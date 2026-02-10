import argparse
import os
import sys
from ffmpeg_normalize import FFmpegNormalize

def normalize_audio(input_dir, output_dir=None, sample_rate=44100, normalization_type='ebu', target_level=-16.0, true_peak=-1.5):
    """
    Normalizes MP3 and WAV files in the input_dir.
    Output files will always be MP3.
    """
    # Check input directory
    if not os.path.isdir(input_dir):
        print(f"Error: Input directory '{input_dir}' does not exist or is not a directory.")
        sys.exit(1)

    # Determine output directory
    if output_dir:
        if not os.path.exists(output_dir):
            try:
                os.makedirs(output_dir)
            except OSError as e:
                print(f"Error creating output directory: {e}")
                sys.exit(1)
    else:
        output_dir = os.path.join(input_dir, "normalized")
        if not os.path.exists(output_dir):
            try:
                os.makedirs(output_dir)
            except OSError as e:
                print(f"Error creating default output directory: {e}")
                sys.exit(1)

    # Find MP3 and WAV files
    audio_files = [f for f in os.listdir(input_dir) if f.lower().endswith(('.mp3', '.wav'))]
    
    if not audio_files:
        print(f"No MP3 or WAV files found in '{input_dir}'.")
        return

    print(f"Found {len(audio_files)} audio files to normalize.")
    print(f"Output directory: {output_dir}")
    print(f"Normalization Type: {normalization_type}")
    print(f"Target Level: {target_level}")

    # Initialize normalizer based on arguments
    if normalization_type == 'peak':
        # Peak normalization simply adjusts gain so the highest peak hits target_level
        normalizer = FFmpegNormalize(
            normalization_type='peak',
            target_level=target_level,
            sample_rate=sample_rate,
            audio_codec='libmp3lame',
            extra_output_options=['-b:a', '192k'],
            progress=True
        )
    else:
        # EBU R128 Loudness Normalization
        normalizer = FFmpegNormalize(
            normalization_type='ebu',
            target_level=target_level,
            true_peak=true_peak,
            loudness_range_target=11.0,
            sample_rate=sample_rate,
            audio_codec='libmp3lame',
            extra_output_options=['-b:a', '192k'],
            progress=True
        )

    count = 0
    for filename in audio_files:
        input_path = os.path.join(input_dir, filename)
        
        # Ensure output filename ends with .mp3
        base_name = os.path.splitext(filename)[0]
        output_filename = f"{base_name}.mp3"
        output_path = os.path.join(output_dir, output_filename)
        
        try:
            print(f"Queueing: {filename} -> {output_filename}")
            normalizer.add_media_file(input_path, output_path)
            count += 1
        except Exception as e:
            print(f"Error adding file {filename}: {e}")

    if count > 0:
        print("Running normalization...")
        try:
            normalizer.run_normalization()
            print("Normalization finished!")
        except Exception as e:
            print(f"An error occurred during normalization: {e}")
    else:
        print("No files to process.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Normalize MP3 and WAV audio files using EBU R128 or Peak Normalization. Output is MP3.")
    parser.add_argument("input_path", help="Path to the directory containing input audio files.")
    parser.add_argument("output_path", nargs="?", help="Optional path to the output directory. Defaults to 'normalized' subdirectory.")
    parser.add_argument("--sample_rate", type=int, choices=[44100, 48000], default=44100, help="Output sample rate (44100 or 48000). Default: 44100")
    parser.add_argument("--normalization-type", choices=['ebu', 'peak'], default='ebu', help="Normalization type: 'ebu' (Loudness, default) or 'peak' (Peak).")
    parser.add_argument("--target-level", type=float, default=-16.0, help="Target level in LUFS (for ebu) or dBFS (for peak). Default: -16.0")
    parser.add_argument("--true-peak", type=float, default=-1.5, help="True peak level limit (only for ebu). Default: -1.5")

    args = parser.parse_args()
    normalize_audio(args.input_path, args.output_path, args.sample_rate, args.normalization_type, args.target_level, args.true_peak)
