#!/bin/bash

# Create test directory if it doesn't exist
mkdir -p test

# Generate Low Volume Sine Wave (-20dB)
echo "Generating low_vol.wav..."
ffmpeg -y -f lavfi -i "sine=frequency=440:duration=5" -filter:a "volume=-20dB" test/low_vol.wav

# Generate High Volume Sine Wave (-3dB)
echo "Generating high_vol.wav..."
ffmpeg -y -f lavfi -i "sine=frequency=440:duration=5" -filter:a "volume=-3dB" test/high_vol.wav

echo "Test files created in test/"
