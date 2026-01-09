#!/bin/bash

extract_to_part() {
    local filename=$(basename "$1")
    echo "/media/randall/FW/playlists/$3/$2 $filename"
    unzip -p "drive-download-20260109T145144Z-1-001.zip" "$1" > "/media/randall/FW/playlists/$3/$2 $filename"
}

index="07"
extract_to_part 'Simply the Best/Simply the Best ALL PARTS.wav' $index _ALL
extract_to_part 'Simply the Best/Simply the Best ALTO W ENS.wav' $index ALTO
extract_to_part 'Simply the Best/Simply the Best BASS W ENS.wav' $index BASS
extract_to_part 'Simply the Best/Simply the Best MEZ W ENS.wav' $index MEZZ
extract_to_part 'Simply the Best/Simply the Best SOP W ENS.wav' $index SOPR
extract_to_part 'Simply the Best/Simply the Best TENOR W ENS.wav' $index TENR

index="14"
extract_to_part 'A Good Song Never Dies/_All - A Good Song Never Dies - All Parts Voice.mp3' $index _ALL
extract_to_part 'A Good Song Never Dies/Alto - A Good Song Never Dies - Alto Voice.mp3' $index ALTO
extract_to_part 'A Good Song Never Dies/Bass - A Good Song Never Dies - Bass Voices.mp3' $index BASS
extract_to_part 'A Good Song Never Dies/Mezzo - A Good Song Never Dies - Mezzo Voice.mp3' $index MEZZ
extract_to_part 'A Good Song Never Dies/Solo - A Good Song Never Dies - Solo Voice.mp3' $index SOLO
extract_to_part 'A Good Song Never Dies/Soprano - A Good Song Never Dies - Soprano Voice.mp3' $index SOPR
extract_to_part 'A Good Song Never Dies/Tenor - A Good Song Never Dies - Tenor Voice.mp3' $index TENR

index="10"
extract_to_part 'Best Night of My Life/_All - BNoML.mp3' $index _ALL
extract_to_part 'Best Night of My Life/Alto - BNoML.mp3' $index ALTO
extract_to_part 'Best Night of My Life/Bass - BNoML.mp3' $index BASS
extract_to_part 'Best Night of My Life/Soprano - BNoML.mp3' $index SOPR
extract_to_part 'Best Night of My Life/Tenor - BNoML.mp3' $index TENR

index="08"
extract_to_part 'Change the World/_All - Change the World All Parts in F#.mp3' $index _ALL
extract_to_part 'Change the World/Alto - Change the World.mp3' $index ALTO
extract_to_part 'Change the World/Bass - Change the World.mp3' $index BASS
extract_to_part 'Change the World/Mezzo - Change the World.mp3' $index MEZZ
extract_to_part 'Change the World/Soprano - Change the World.mp3' $index SOPR
extract_to_part 'Change the World/Tenor - Change the World.mp3' $index TENR

index="12"
extract_to_part 'Danger Zone/_All - Danger Zone.mp3' $index _ALL
extract_to_part 'Danger Zone/Alto - Danger Zone.mp3' $index ALTO
extract_to_part 'Danger Zone/Bass - Danger Zone.mp3' $index BASS
extract_to_part 'Danger Zone/Mezzo-soprano - Danger Zone.mp3' $index MEZZ
extract_to_part 'Danger Zone/Soprano - Danger Zone.mp3' $index SOPR
extract_to_part 'Danger Zone/Tenor - Danger Zone.mp3' $index TENR

index="01"
extract_to_part 'Don_t Stop Thinking About Tomorrow/Don_t_Stop-All_Parts_Short_16780550105663.mp3' $index _ALL
extract_to_part 'Don_t Stop Thinking About Tomorrow/Don_t Stop Baritone.mp3' $index TENR
extract_to_part 'Don_t Stop Thinking About Tomorrow/Don_t_Stop-Bass_Short_16780551674939.mp3' $index BASS
extract_to_part 'Don_t Stop Thinking About Tomorrow/Don_t Stop Lead Shortened.mp3' $index ALTO
extract_to_part 'Don_t Stop Thinking About Tomorrow/Don_t Stop-tenor_cut_pitched.mp3' $index SOPR

index="02"
extract_to_part 'Nella Fantasia/_All - Nella Fantasia.mp3' $index _ALL
extract_to_part 'Nella Fantasia/ALTO - Nella Fantasia.mp3' $index ALTO
extract_to_part 'Nella Fantasia/BASS - Nella Fantasia.mp3' $index BASS
extract_to_part 'Nella Fantasia/MEZZO - Nella Fantasia.mp3' $index MEZZ
extract_to_part 'Nella Fantasia/SOPRANO - Nella Fantasia.mp3' $index SOPR
extract_to_part 'Nella Fantasia/TENOR - Nella Fantasia.mp3' $index TENR

index="11"
extract_to_part 'Perhaps/_All - Perhaps.mp3' $index _ALL
extract_to_part 'Perhaps/Alto - Perhaps.mp3' $index ALTO
extract_to_part 'Perhaps/Bass - Perhaps.mp3' $index BASS
extract_to_part 'Perhaps/Mezzo - Perhaps.mp3' $index MEZZ
extract_to_part 'Perhaps/Solo - Perhaps.mp3' $index SOLO
extract_to_part 'Perhaps/Soprano - Perhaps.mp3' $index SOPR
extract_to_part 'Perhaps/Tenor - Perhaps.mp3' $index TENR

index="04"
extract_to_part 'Poor Unfortunate Souls/_All - Poor Unfortunate Souls.mp3' $index _ALL
extract_to_part 'Poor Unfortunate Souls/Alto - Poor Unfortunate Souls.mp3' $index ALTO
extract_to_part 'Poor Unfortunate Souls/Bass - Poor Unfortunate Souls.mp3' $index BASS
extract_to_part 'Poor Unfortunate Souls/Mezzo - Poor Unfortunate Souls.mp3' $index MEZZ
extract_to_part 'Poor Unfortunate Souls/Solo - Poor Unfortunate Souls.mp3' $index SOLO
extract_to_part 'Poor Unfortunate Souls/Soprano - Poor Unfortunate Souls.mp3' $index SOPR
extract_to_part 'Poor Unfortunate Souls/Tenor - Poor Unfortunate Souls.mp3' $index TENR

index="06"
extract_to_part 'Rockin_ the Paradise/_All - A D 1928 Rockin_ the Paradise.mp3' $index _ALL
extract_to_part 'Rockin_ the Paradise/Alto - A D 1928 Rockin_ the Paradise.mp3' $index ALTO
extract_to_part 'Rockin_ the Paradise/Bass - A D 1928 Rockin_ the Paradise.mp3' $index BASS
extract_to_part 'Rockin_ the Paradise/Mezzo - A D 1928 Rockin_ the Paradise.mp3' $index MEZZ
extract_to_part 'Rockin_ the Paradise/Soprano - A D 1928 Rockin_ the Paradise.mp3' $index SOPR
extract_to_part 'Rockin_ the Paradise/Tenor - A D 1928 Rockin_ the Paradise.mp3' $index TENR

index="13"
extract_to_part 'See You Later/_All - See You Later.mp3' $index _ALL
extract_to_part 'See You Later/Alto - See You Later.mp3' $index ALTO
extract_to_part 'See You Later/Bass - See You Later.mp3' $index BASS
extract_to_part 'See You Later/Mezzo - See You Later.mp3' $index MEZZ
extract_to_part 'See You Later/Solo - See You Later.mp3' $index SOLO
extract_to_part 'See You Later/Soprano - See You Later.mp3' $index SOPR
extract_to_part 'See You Later/Tenor - See You Later.mp3' $index TENR

index="03"
extract_to_part 'Shine/_All - Shine.mp3' $index _ALL
extract_to_part 'Shine/Alto - Shine.mp3' $index ALTO
extract_to_part 'Shine/Bass - Shine.mp3' $index BASS
extract_to_part 'Shine/Mezzo - Shine.mp3' $index MEZZ
extract_to_part 'Shine/Soprano - Shine.mp3' $index SOPR
extract_to_part 'Shine/Tenor - Shine.mp3' $index TENR

index="09"
extract_to_part 'This is the Life/_All - This is the Life.mp3' $index _ALL
extract_to_part 'This is the Life/Alto - This is the Life.mp3' $index ALTO
extract_to_part 'This is the Life/Bass - This is the Life.mp3' $index BASS
extract_to_part 'This is the Life/Solo - This is the Life.mp3' $index SOLO
extract_to_part 'This is the Life/Soprano - This is the life.mp3' $index SOPR
extract_to_part 'This is the Life/Tenor - This is the Life.mp3' $index TENR

index="05"
extract_to_part 'You Were On My Mind/_All - You Were On My Mind.mp3' $index _ALL
extract_to_part 'You Were On My Mind/Alto - You Were On My Mind.mp3' $index ALTO
extract_to_part 'You Were On My Mind/Bass - You Were On My Mind.mp3' $index BASS
extract_to_part 'You Were On My Mind/Mezzo - You Were On My Mind.mp3' $index MEZZ
extract_to_part 'You Were On My Mind/Soprano - You Were On My Mind.mp3' $index SOPR
extract_to_part 'You Were On My Mind/Tenor - You Were On My Mind.mp3' $index TENR
