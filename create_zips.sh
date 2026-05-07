#!/bin/bash

# Define the base path to avoid typos
BASE="/media/randall/4004-4C2E/playlists"
SEASON='SB-2026-S1'

# 1. Clear out old archives (as you were doing)
rm "$BASE/$SEASON - All Parts.zip" \
   "$BASE/$SEASON - Alto.zip" \
   "$BASE/$SEASON - Baritone.zip" \
   "$BASE/$SEASON - Bass.zip" \
   "$BASE/$SEASON - Mezzo.zip" \
   "$BASE/$SEASON - Soprano.zip" \
   "$BASE/$SEASON - Tenor.zip" \
   "$BASE/$SEASON - Solo.zip"

# 2. Define a function to Zip safely
# This solves the "-j" problem by entering the directory before zipping
zip_flat() {
    local zip_name="$1"
    local source_dir="$2"

    echo "Creating $zip_name..."
    
    # Run in a subshell (parentheses) so the 'cd' doesn't affect the main script
    # -tzip: Force standard zip format
    # -mx=9: Max compression (optional, but good)
    (cd "$source_dir" && 7z a -tzip -mx=9 "$BASE/$zip_name" *)
}

# 3. Create the archives
zip_flat "$SEASON - All Parts.zip" "$BASE/_ALL/normalized"
zip_flat "$SEASON - Alto.zip"      "$BASE/ALTO/normalized"
zip_flat "$SEASON - Baritone.zip"  "$BASE/BARI/normalized"
zip_flat "$SEASON - Bass.zip"      "$BASE/BASS/normalized"
zip_flat "$SEASON - Mezzo.zip"     "$BASE/MEZZ/normalized"
zip_flat "$SEASON - Soprano.zip"   "$BASE/SOPR/normalized"
zip_flat "$SEASON - Tenor.zip"     "$BASE/TENR/normalized"
zip_flat "$SEASON - Solo.zip"      "$BASE/SOLO/normalized"

echo "All zips created successfully."
