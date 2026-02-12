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
      mixed_inputs="$mixed_inputs -i \"$output_file\" -v 1.0"
  fi
  
  # Check for Bass track to determine song title
  if [[ "$filename_no_ext" == *"_Bass"* ]]; then
      song_title="${filename_no_ext//_Bass/}"
  fi
  
done

echo "---------------------------------------------------"
echo "Batch processing complete."

# Prepare output directory
mkdir -p "test/songtrack"

if [ -n "$song_title" ]; then
    output_mix="test/songtrack/${song_title}.mp3"
else
    output_mix="test/songtrack/output.mp3"
fi

echo "Mixing tracks to $output_mix ..."

# Use eval to handle the quoted strings in mixed_inputs correctly
eval python3 sb_mixer.py $mixed_inputs -o \"$output_mix\"

echo "Mixing complete."
