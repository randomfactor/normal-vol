#!/bin/bash

# Ensure output directory exists
mkdir -p test/stage1

echo "Processing files from test/wav_in/ to test/stage1/ ..."

# Collect all output files for mixing
mixed_inputs=""

# Loop through all wav and mp3 files
for input_file in test/wav_in/*.{wav,mp3}; do
  # Check if file exists (in case glob fails)
  [ -e "$input_file" ] || continue

  filename=$(basename "$input_file")
  # Always output as wav
  filename_no_ext="${filename%.*}"
  output_file="test/stage1/${filename_no_ext}.wav"

  echo "---------------------------------------------------"
  echo "Processing: $filename"
  
  # call sb_compressor.py
  # python3 sb_compressor.py <input> <output> <rate>
  python3 sb_compressor.py "$input_file" "$output_file" 44100
  
  # Add to mix list
  if [ -f "$output_file" ]; then
      mixed_inputs="$mixed_inputs -i \"$output_file\""
  fi
  
done

echo "---------------------------------------------------"
echo "Batch processing complete."

# Prepare output directory
mkdir -p "test/songtrack"
output_mix="test/songtrack/You Were On My Mind.mp3"

echo "Mixing tracks to $output_mix ..."

# Use eval to handle the quoted strings in mixed_inputs correctly
eval python3 sb_mixer.py $mixed_inputs -o \"$output_mix\"

echo "Mixing complete."
