#!/bin/bash

# Define the base path to avoid typos
BASE="/media/randall/FW/playlists"

# 1. Clear out old archives (as you were doing)
rm "$BASE/2026-01 - All Parts.zip" \
   "$BASE/2026-01 - Alto.zip" \
   "$BASE/2026-01 - Bass.zip" \
   "$BASE/2026-01 - Mezzo.zip" \
   "$BASE/2026-01 - Soprano.zip" \
   "$BASE/2026-01 - Tenor.zip" \
   "$BASE/2026-01 - Solo.zip"

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
zip_flat "2026-01 - All Parts.zip" "$BASE/_ALL/normalized"
zip_flat "2026-01 - Alto.zip"      "$BASE/ALTO/normalized"
zip_flat "2026-01 - Bass.zip"      "$BASE/BASS/normalized"
zip_flat "2026-01 - Mezzo.zip"     "$BASE/MEZZ/normalized"
zip_flat "2026-01 - Soprano.zip"   "$BASE/SOPR/normalized"
zip_flat "2026-01 - Tenor.zip"     "$BASE/TENR/normalized"
zip_flat "2026-01 - Solo.zip"      "$BASE/SOLO/normalized"

echo "All zips created successfully."
