#!/bin/bash

# Check for input directory argument
if [ -z "$1" ]; then
  echo "Usage: $0 <input_directory>"
  exit 1
fi

INPUT_DIR="${1%/}" # Remove trailing slash if present
STAGE1_DIR="$INPUT_DIR/stage1"
SONGTRACK_DIR="$INPUT_DIR/songtrack"

# Ensure output directory exists
mkdir -p "$STAGE1_DIR"

echo "Processing files from $INPUT_DIR/ to $STAGE1_DIR/ ..."

# Collect all output files for mixing
mixed_inputs=""

# Loop through all wav and mp3 files
for input_file in "$INPUT_DIR"/*.{wav,mp3}; do
  # Check if file exists (in case glob fails)
  [ -e "$input_file" ] || continue

  filename=$(basename "$input_file")
  # Always output as wav
  filename_no_ext="${filename%.*}"
  output_file="$STAGE1_DIR/${filename_no_ext}.wav"

  echo "---------------------------------------------------"
  echo "Processing: $filename"
  
  # call sb_compressor.py
  # uv run sb_compressor.py <input> <output> <rate>
  uv run sb_compressor.py "$input_file" "$output_file" 44100
  
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
mkdir -p "$SONGTRACK_DIR"

if [ -n "$song_title" ]; then
    output_mix="$SONGTRACK_DIR/${song_title}.mp3"
else
    output_mix="$SONGTRACK_DIR/output.mp3"
fi

echo "Mixing tracks to $output_mix ..."

# Use eval to handle the quoted strings in mixed_inputs correctly
eval uv run sb_mixer.py $mixed_inputs -o \"$output_mix\"

echo "Mixing complete."
