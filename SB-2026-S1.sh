#!/bin/bash

extract_to_part() {
    local filename=$(basename "$1")
    echo "/media/randall/FW/playlists/$3/$2 $filename"
    unzip -p "/home/randall/Downloads/drive-download-20260316T160848Z-1-001.zip" "$1" > "/media/randall/FW/playlists/$3/$2 $filename"
}

index="01"
extract_to_part 'Down to the Honkytonk/_All - Down to the Honkytonk.mp3' $index _ALL
extract_to_part 'Down to the Honkytonk/Alto - Down to the Honkytonk.mp3' $index ALTO
extract_to_part 'Down to the Honkytonk/Bass - Down to the Honkytonk.mp3' $index BASS
extract_to_part 'Down to the Honkytonk/Mezzo-soprano - Down to the Honkytonk.mp3' $index MEZZ
extract_to_part 'Down to the Honkytonk/Solo 1 - Down to the Honkytonk.mp3' $index SOLO
extract_to_part 'Down to the Honkytonk/Solo 2 - Down to the Honkytonk.mp3' $index SOLO
extract_to_part 'Down to the Honkytonk/Soprano - Down to the Honkytonk.mp3' $index SOPR
extract_to_part 'Down to the Honkytonk/Tenor - Down to the Honkytonk.mp3' $index TENR

index="05"
extract_to_part 'Everything/_All - Everything.mp3' $index _ALL
extract_to_part 'Everything/Alto - Everything.mp3' $index ALTO
extract_to_part 'Everything/Bass - Everything.mp3' $index BASS
extract_to_part 'Everything/Mezzo-soprano - Everything.mp3' $index MEZZ
extract_to_part 'Everything/Soprano - Everything.mp3' $index SOPR
extract_to_part 'Everything/Tenor - Everything.mp3' $index TENR

index="06"
extract_to_part 'Golden/_All - Golden.mp3' $index _ALL
extract_to_part 'Golden/Alto - Golden.mp3' $index ALTO
extract_to_part 'Golden/Bass - Golden.mp3' $index BASS
extract_to_part 'Golden/Mezzo-soprano - Golden.mp3' $index MEZZ
extract_to_part 'Golden/Solo - Golden.mp3' $index SOLO
extract_to_part 'Golden/Soprano - Golden.mp3' $index SOPR
extract_to_part 'Golden/Tenor - Golden.mp3' $index TENR

index="02"
extract_to_part 'Pink Pony Club/_All - Pink Pony Club.mp3' $index _ALL
extract_to_part 'Pink Pony Club/Alto - Pink Pony Club.mp3' $index ALTO
extract_to_part 'Pink Pony Club/Bass - Pink Pony Club.mp3' $index BASS
extract_to_part 'Pink Pony Club/Solo - Pink Pony Club.mp3' $index SOLO
extract_to_part 'Pink Pony Club/Soprano - Pink Pony Club.mp3' $index SOPR
extract_to_part 'Pink Pony Club/Tenor - Pink Pony Club.mp3' $index TENR

index="03"
extract_to_part 'Song That Goes Like This/_All - The Song That Goes Like This.mp3' $index _ALL
extract_to_part 'Song That Goes Like This/Alto - The Song That Goes Like This.mp3' $index ALTO
extract_to_part 'Song That Goes Like This/Bass - The Song That Goes Like This.mp3' $index BASS
extract_to_part 'Song That Goes Like This/Mezzo-soprano - The Song That Goes Like This.mp3' $index MEZZ
extract_to_part 'Song That Goes Like This/Solo 1 - The Song That Goes Like This.mp3' $index SOLO
extract_to_part 'Song That Goes Like This/Solo 2 - The Song That Goes Like This.mp3' $index SOLO
extract_to_part 'Song That Goes Like This/Soprano - The Song That Goes Like This.mp3' $index SOPR
extract_to_part 'Song That Goes Like This/Tenor - The Song That Goes Like This.mp3' $index TENR

index="04"
extract_to_part 'Your Wildest Dreams/_All - Your Wildest Dreams.mp3' $index _ALL
extract_to_part 'Your Wildest Dreams/Alto - Your Wildest Dreams.mp3' $index ALTO
extract_to_part 'Your Wildest Dreams/Baritone - Your Wildest Dreams.mp3' $index BARI
extract_to_part 'Your Wildest Dreams/Bass - Your Wildest Dreams.mp3' $index BASS
extract_to_part 'Your Wildest Dreams/Mezzo - Your Wildest Dreams.mp3' $index MEZZ
extract_to_part 'Your Wildest Dreams/Soprano - Your Wildest Dreams.mp3' $index SOPR
extract_to_part 'Your Wildest Dreams/Tenor - Your Wildest Dreams.mp3' $index TENR
