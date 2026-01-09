#!/bin/bash

rm "/media/randall/FW/playlists/2026-01-10 Sunrise - All Parts.zip" \
    "/media/randall/FW/playlists/2026-01-10 Sunrise - Alto.zip" \
    "/media/randall/FW/playlists/2026-01-10 Sunrise - Bass.zip" \
    "/media/randall/FW/playlists/2026-01-10 Sunrise - Mezzo.zip" \
    "/media/randall/FW/playlists/2026-01-10 Sunrise - Soprano.zip" \
    "/media/randall/FW/playlists/2026-01-10 Sunrise - Tenor.zip" \
    "/media/randall/FW/playlists/2026-01-10 Sunrise - Solo.zip"

zip -j "/media/randall/FW/playlists/2026-01-10 Sunrise - All Parts.zip" "/media/randall/FW/playlists/_ALL/normalized/"*

zip -j "/media/randall/FW/playlists/2026-01-10 Sunrise - Alto.zip" "/media/randall/FW/playlists/ALTO/normalized/"*

zip -j "/media/randall/FW/playlists/2026-01-10 Sunrise - Bass.zip" "/media/randall/FW/playlists/BASS/normalized/"*

zip -j "/media/randall/FW/playlists/2026-01-10 Sunrise - Mezzo.zip" "/media/randall/FW/playlists/MEZZ/normalized/"*

zip -j "/media/randall/FW/playlists/2026-01-10 Sunrise - Soprano.zip" "/media/randall/FW/playlists/SOPR/normalized/"*

zip -j "/media/randall/FW/playlists/2026-01-10 Sunrise - Tenor.zip" "/media/randall/FW/playlists/TENR/normalized/"*

zip -j "/media/randall/FW/playlists/2026-01-10 Sunrise - Solo.zip" "/media/randall/FW/playlists/SOLO/normalized/"*
