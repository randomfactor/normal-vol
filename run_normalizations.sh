#!/bin/bash

# /home/randall/.local/bin/uv run python normalize_audio.py /media/randall/FW/playlists/_ALL/ /media/randall/FW/playlists/_ALL/normalized

# /home/randall/.local/bin/uv run python normalize_audio.py /media/randall/FW/playlists/ALTO/ /media/randall/FW/playlists/ALTO/normalized

# /home/randall/.local/bin/uv run python normalize_audio.py /media/randall/FW/playlists/BASS/ /media/randall/FW/playlists/BASS/normalized

# /home/randall/.local/bin/uv run python normalize_audio.py /media/randall/FW/playlists/MEZZ/ /media/randall/FW/playlists/MEZZ/normalized

# /home/randall/.local/bin/uv run python normalize_audio.py /media/randall/FW/playlists/SOPR/ /media/randall/FW/playlists/SOPR/normalized

# /home/randall/.local/bin/uv run python normalize_audio.py /media/randall/FW/playlists/TENR/ /media/randall/FW/playlists/TENR/normalized

# /home/randall/.local/bin/uv run python normalize_audio.py /media/randall/FW/playlists/SOLO/ /media/randall/FW/playlists/SOLO/normalized

# ~/.local/bin/uv run python normalize_audio.py --sample_rate 48000 ~/Music/soundbites/YWD/tracks/ ~/Music/soundbites/YWD/tracks/normalized

# create list of 4-letter voice part names
voice_parts=("ALTO" "BARI" "BASS" "MEZZ" "SOPR" "TENR" "SOLO")

for part in "${voice_parts[@]}"; do
    /home/randall/.local/bin/uv run python normalize_audio.py "/media/randall/FW/playlists/$part/" "/media/randall/FW/playlists/$part/normalized"
done