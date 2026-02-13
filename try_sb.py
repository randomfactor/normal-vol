import os
import sys
import argparse
import subprocess
from pathlib import Path

def main():
    parser = argparse.ArgumentParser(description="Process audio files with sb_compressor and sb_mixer.")
    parser.add_argument("input_directory", type=str, help="Directory containing input wav/mp3 files.")
    
    args = parser.parse_args()

    input_dir = Path(args.input_directory).resolve()
    
    if not input_dir.exists() or not input_dir.is_dir():
        print(f"Error: Directory '{input_dir}' does not exist.")
        sys.exit(1)

    stage1_dir = input_dir / "stage1"
    songtrack_dir = input_dir / "songtrack"

    # Ensure output directory exists
    stage1_dir.mkdir(parents=True, exist_ok=True)

    print(f"Processing files from {input_dir}/ to {stage1_dir}/ ...")

    # Collect all output files for mixing
    mixer_inputs = []
    song_title = None

    # Get all wav and mp3 files
    files = list(input_dir.glob("*.wav")) + list(input_dir.glob("*.mp3"))

    for input_file in files:
        filename = input_file.name
        filename_no_ext = input_file.stem
        # Always output as wav
        output_file = stage1_dir / f"{filename_no_ext}.wav"

        print("---------------------------------------------------")
        print(f"Processing: {filename}")
        
        # call sb_compressor.py
        # uv run sb_compressor.py <input> <output> <rate>
        cmd = [
            "uv", "run", "sb_compressor.py",
            str(input_file),
            str(output_file),
            "44100"
        ]
        
        subprocess.run(cmd, check=True)
        
        # Add to mix list
        if output_file.exists():
            mixer_inputs.extend(["-i", str(output_file), "-v", "1.0"])
        
        # Check for Bass track to determine song title
        if "_Bass" in filename_no_ext:
            song_title = filename_no_ext.replace("_Bass", "")

    print("---------------------------------------------------")
    print("Batch processing complete.")

    # Prepare output directory
    songtrack_dir.mkdir(parents=True, exist_ok=True)

    if song_title:
        output_mix = songtrack_dir / f"{song_title}.mp3"
    else:
        output_mix = songtrack_dir / "output.mp3"

    print(f"Mixing tracks to {output_mix} ...")

    # Run sb_mixer.py
    if mixer_inputs:
        mixer_cmd = ["uv", "run", "sb_mixer.py"] + mixer_inputs + ["-o", str(output_mix)]
        subprocess.run(mixer_cmd, check=True)
        print("Mixing complete.")
    else:
        print("No files processed successfully to mix.")

if __name__ == "__main__":
    main()
