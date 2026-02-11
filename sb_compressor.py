import argparse
import subprocess
import json
import sys
import re
import os

def run_ffmpeg_command(cmd):
    """Run an ffmpeg command and return stdout/stderr."""
    try:
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

def compress_audio(input_file, output_wav, rate):
    """Apply compression and limiter using ffmpeg."""
    # Filter string as specified
    filter_chain = "acompressor=threshold=-24dB:ratio=3:attack=10:release=500:knee=2,alimiter=limit=0.988"
    
    cmd = [
        "ffmpeg",
        "-y", # Overwrite output
        "-i", input_file,
        "-af", filter_chain,
        "-ar", str(rate),
        "-ac", "1", # Force mono as per requirement description (input expected mono, standardizing output)
        output_wav
    ]
    
    # We don't need to capture output for the compression step, just ensure it runs
    run_ffmpeg_command(cmd)

def measure_loudness(audio_file):
    """Measure Integrated Loudness (I) and Threshold using ebur128 filter."""
    # We use -f null - to avoid writing a file, and capture stderr where measurement logs are printed
    # The ebur128 filter with metadata=1 injects metadata, but to get a summary we can parse the log
    # OR better: use the 'video' output format of ebur128 if we want visual, but here we want text.
    # Actually, standard procedure to get the summary is to look for the "Integrated loudness" lines in stderr
    # produced by the ebur128 filter.
    
    cmd = [
        "ffmpeg",
        "-i", audio_file,
        "-filter_complex", "ebur128=peak=none", # peak=none saves some processing
        "-f", "null",
        "-"
    ]
    
    # ffmpeg prints stats to stderr
    _, stderr_output = run_ffmpeg_command(cmd)
    
    return parse_loudness_output(stderr_output)

def parse_loudness_output(output):
    """Parse ffmpeg ebur128 output for Integrated loudness and Threshold."""
    # The output contains multiple "I:" lines (momentary, etc.). 
    # We want the FINAL summary block which looks like:
    # Integrated loudness:
    #   I:         -24.1 LUFS
    #   Threshold: -34.3 LUFS
    
    i_value = None
    threshold_value = None
    
    # We strip the output to ensure we are looking at the end
    # and search reversely or use a very specific block regex.
    
    try:
        # Regex to find the block starting with "Integrated loudness:" 
        # followed by I and Threshold values.
        # We use findall and take the LAST match to ensure we get the summary
        # and not some intermediate log (though ebur128 usually only prints one summary at the end).
        
        # Pattern explanation:
        # Integrated loudness:\s+  -> Header
        # I:\s+                    -> I label
        # ([-\d\.]+)               -> Capture float value (I)
        # \s+LUFS                  -> Unit
        # .*?                      -> non-greedy match (newlines etc)
        # Threshold:\s+            -> Threshold label
        # ([-\d\.]+)               -> Capture float value (Threshold)
        
        pattern = r"Integrated loudness:\s+I:\s+([-\d\.]+)\s+LUFS.*?Threshold:\s+([-\d\.]+)\s+LUFS"
        matches = re.findall(pattern, output, re.DOTALL | re.MULTILINE)
        
        if matches:
            # Take the last match (should be the global summary)
            last_match = matches[-1]
            i_value = float(last_match[0])
            threshold_value = float(last_match[1])
        else:
             # Debugging fallback: failed to match standard block.
             # Print warning to stderr?
             pass

    except Exception as e:
        print(f"Error parsing loudness data: {e}", file=sys.stderr)
        sys.exit(1)

    if i_value is None or threshold_value is None:
        print("Could not find loudness data in ffmpeg output.", file=sys.stderr)
        # Helpful debug output for the user if parsing fails
        # print("--- ffmpeg stderr ---", file=sys.stderr)
        # print(output, file=sys.stderr)
        # print("---------------------", file=sys.stderr)
        sys.exit(1)
        
    return {
        "I": i_value,
        "Threshold": threshold_value
    }

def main():
    parser = argparse.ArgumentParser(description="Clean, compress, and limit audio, then report loudness.")
    parser.add_argument("input_file", help="Path to original audio file")
    parser.add_argument("output_wav", help="Path to output WAV file")
    parser.add_argument("rate", type=int, help="PCM sample rate for output (e.g., 44100)")
    
    args = parser.parse_args()
    
    # 1. Compress
    compress_audio(args.input_file, args.output_wav, args.rate)
    
    # 2. Measure
    loudness_stats = measure_loudness(args.output_wav)
    
    # 3. Emit JSON
    print(json.dumps(loudness_stats))

if __name__ == "__main__":
    main()
