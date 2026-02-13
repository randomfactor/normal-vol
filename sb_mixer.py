import argparse
import subprocess
import sys
import re
import os

def run_ffmpeg_command(cmd):
    """Run an ffmpeg command and return stdout/stderr."""
    print("Running:", " ".join(cmd))
    try:
        # print("Running:", " ".join(cmd)) # Debug
        result = subprocess.run(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            check=True
        )
        return result.stdout, result.stderr
    except subprocess.CalledProcessError as e:
        print(f"Error running ffmpeg command: {' '.join(cmd)}", file=sys.stderr)
        print(e.stderr, file=sys.stderr)
        sys.exit(1)

def get_max_volume(input_file):
    """Run volumedetect filter and return max_volume in dB."""
    cmd = [
        "ffmpeg",
        "-i", input_file,
        "-af", "volumedetect",
        "-f", "null",
        "-"
    ]
    
    _, stderr_output = run_ffmpeg_command(cmd)
    
    # Parse output for: "max_volume: -5.2 dB"
    match = re.search(r"max_volume:\s+([-\d\.]+)\s+dB", stderr_output)
    if match:
        return float(match.group(1))
    else:
        print("Could not parse max_volume from volumedetect output.", file=sys.stderr)
        sys.exit(1)

def mix_tracks(inputs, volumes, output_raw):
    """
    Mix tracks using ffmpeg complex filter.
    inputs: list of file paths
    volumes: list of volume strings (e.g. "1.5" or "-3dB")
    output_raw: temporary output file
    """
    cmd = ["ffmpeg", "-y"]
    
    # Add all inputs
    for inp in inputs:
        cmd.extend(["-i", inp])
    
    # Build filter complex
    # Example: [0:a]volume=1.0[a0];[1:a]volume=0.5[a1];[a0][a1]amix=inputs=2:normalize=0[out]
    filter_parts = []
    mix_inputs = []
    
    for i, vol in enumerate(volumes):
        # Determine if vol is pure number or dB
        # ffmpeg `volume` filter accepts both "1.5" and "-3dB" directly.
        
        # [i:a]volume=VOL[a_i]
        filter_parts.append(f"[{i}:a]volume={vol}[a{i}]")
        mix_inputs.append(f"[a{i}]")
        
    # Combine mix inputs
    mix_str = "".join(mix_inputs)
    num_inputs = len(inputs)
    # duration=longest: keep playing until longest track ends (default)
    # dropout_transition=0: smooth transition? usually 2s default. 0 is fine.
    # normalize=0: DO NOT scale output by 1/N. We want sum of signals.
    filter_parts.append(f"{mix_str}amix=inputs={num_inputs}:normalize=0:dropout_transition=0[out]")
    
    filter_complex = ";".join(filter_parts)
    
    cmd.extend([
        "-filter_complex", filter_complex,
        "-map", "[out]",
        output_raw
    ])
    
    run_ffmpeg_command(cmd)

def normalize_final(input_file, output_file, max_vol):
    """
    Normalize peak to -0.1 dB.
    gain = target - current
    target = -0.1
    """
    target = -0.1
    gain = target - max_vol
    
    # print(f"Max Volume: {max_vol} dB. Applying gain: {gain:.2f} dB")
    
    cmd = [
        "ffmpeg",
        "-y",
        "-i", input_file,
        "-af", f"volume={gain}dB",
        output_file
    ]
    
    run_ffmpeg_command(cmd)

def parse_arguments():
    """Manual argument parsing to handle -i [file] [optional -v vol] pattern."""
    args = sys.argv[1:]
    inputs = []
    volumes = []
    output_file = None
    
    i = 0
    while i < len(args):
        arg = args[i]
        
        if arg == "-o" or arg == "--output":
            if i + 1 < len(args):
                output_file = args[i+1]
                i += 2
                continue
            else:
                print("Error: -o requires a file path.", file=sys.stderr)
                sys.exit(1)
        
        if arg == "-i" or arg == "--input":
            if i + 1 < len(args):
                input_path = args[i+1]
                inputs.append(input_path)
                
                # Check if next arg is -v
                if i + 2 < len(args) and (args[i+2] == "-v" or args[i+2] == "--volume"):
                    if i + 3 < len(args):
                        volumes.append(args[i+3])
                        i += 4 # Consumed -i val -v val
                        continue
                    else:
                        print("Error: -v requires a volume value.", file=sys.stderr)
                        sys.exit(1)
                else:
                    # No -v provided for this input, default to 1.0 (no change)
                    volumes.append("1.0")
                    i += 2 # Consumed -i val
                    continue
            else:
                print("Error: -i requires a file path.", file=sys.stderr)
                sys.exit(1)
        
        # If we hit an unparsed -v without a preceding -i (or out of order), it's specific logic dependent.
        # But our loop handles -v strictly after -i. If we see -v here, it's orphan.
        if arg == "-v" or arg == "--volume":
             print("Error: -v must immediately follow an input file (-i).", file=sys.stderr)
             sys.exit(1)
             
        # Help
        if arg == "-h" or arg == "--help":
             print("Usage: sb_mixer.py -i <input> [-v <volume>] ... -o <output>")
             sys.exit(0)

        i += 1

    if not inputs:
        print("Error: At least one input (-i) is required.", file=sys.stderr)
        sys.exit(1)
        
    if not output_file:
        print("Error: Output file (-o) is required.", file=sys.stderr)
        sys.exit(1)

    return inputs, volumes, output_file

def measure_loudness_i(audio_file):
    """Measure Integrated Loudness (I) using ebur128 filter."""
    cmd = [
        "ffmpeg",
        "-i", audio_file,
        "-filter_complex", "ebur128=peak=none", 
        "-f", "null",
        "-"
    ]
    
    _, stderr_output = run_ffmpeg_command(cmd)
    
    # Parse integrated loudness
    # Look for "Integrated loudness:" block
    try:
        # Use the same robust pattern as sb_compressor.py
        pattern = r"Integrated loudness:\s+I:\s+([-\d\.]+)\s+LUFS"
        matches = re.findall(pattern, stderr_output, re.DOTALL | re.MULTILINE)
        
        if matches:
            # Take the last match (summary)
            return float(matches[-1])
            
        # Fallback search if the block isn't found perfectly
        matches = re.findall(r"I:\s+([-\d\.]+)\s+LUFS", stderr_output)
        if matches:
            return float(matches[-1])
            
    except Exception:
        pass
        
    print(f"Warning: Could not measure loudness for {audio_file}", file=sys.stderr)
    return None

import tempfile

def main():
    inputs, volumes, output_file = parse_arguments()
    
    # Auto-adjust volume for click.wav
    for idx, inp in enumerate(inputs):
        if os.path.basename(inp) == "click.wav":
            print(f"Detected click track: {inp}")
            current_i = measure_loudness_i(inp)
            
            if current_i is not None:
                target_lufs = -39.0
                gain_db = target_lufs - current_i
                print(f"  Current Loudness: {current_i} LUFS")
                print(f"  Target: {target_lufs} LUFS")
                
                if gain_db < 0:
                    print(f"  Applying Gain: {gain_db:.2f} dB")
                    # Update volume for this track
                    volumes[idx] = f"{gain_db:.2f}dB"
                else:
                    print(f"  Calculated Gain is positive ({gain_db:.2f} dB). Keeping original volume.")
            else:
                print("  Failed to measure loudness, keeping original volume.")

    # Create a unique temporary file in the OS standard temp directory
    fd, temp_mix_file = tempfile.mkstemp(suffix=".wav")
    os.close(fd) # Close file descriptor immediately so ffmpeg can use the path
    
    try:
        # 1. Main Mix
        print("Processing Main Mix...")
        mix_tracks(inputs, volumes, temp_mix_file)
        max_vol = get_max_volume(temp_mix_file)
        normalize_final(temp_mix_file, output_file, max_vol)
        
        # 2. Featured Track Mixes
        # For each input track (except click.wav), create a separate mix 
        # where that track is boosted to 2.0 volume, and save it as [TrackName].mp3
        # The output directory should probably be the same as the main output file.
        
        output_dir = os.path.dirname(output_file)
        
        for i, target_track in enumerate(inputs):
            # Skip click track
            if os.path.basename(target_track) == "click.wav":
                continue
                
            print(f"Processing featured mix for: {os.path.basename(target_track)}")
            
            # Create a copy of volumes for this specific mix
            featured_volumes = list(volumes)
            
            # Apply boost.
            # Convert 2.0 linear gain to dB? Or just use "2.0"?
            # Since volumes list might contain "dB" strings or float strings, we need to handle carefully.
            # The prompt asks for "initial volume of 2.0".
            # If the original volume was "1.0", we change it to "2.0". 
            # If it was -3dB, we might need complex math.
            # But the requirement says "volume... is mixed in louder... try an initial volume of 2.0".
            # Assuming this replaces the standard volume for that track.
            
            # If the user supplied a volume for this track, we replace it with 2.0? Or multiply?
            # "volume for the target track is mixed in louder ... try an initial volume of 2.0"
            # I will set it explicitly to 4.0.
            
            featured_volumes[i] = "4.0" 
            
            # Determine output filename
            # "resulting output track will have the same base name as the target track"
            target_base = os.path.splitext(os.path.basename(target_track))[0]
            # Assuming output format matches main output (likely mp3 based on try_sb.sh)
            main_ext = os.path.splitext(output_file)[1]
            featured_output = os.path.join(output_dir, f"{target_base}{main_ext}")
            
            # Check if we are overwriting the main output? (If inputs are named same as output?)
            # Unlikely given try_sb.sh structure.
            
            # Mix
            mix_tracks(inputs, featured_volumes, temp_mix_file)
            max_vol = get_max_volume(temp_mix_file)
            normalize_final(temp_mix_file, featured_output, max_vol)
            
    finally:
        if os.path.exists(temp_mix_file):
            # os.remove(temp_mix_file) 
            # pass # Keep for debug? No, standard is remove.
            os.remove(temp_mix_file)

if __name__ == "__main__":
    main()
