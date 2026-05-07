#!/bin/bash
#   - to generate list of sound files in zip archive:
#     zipinfo -1 $archive | grep -E '\.(mp3|wav)$' | sort > filelist.txt

extract_to_part() {
    local filename=$(basename "$1")
    root="/media/randall/4004-4C2E"
    echo "$root/playlists/$3/$2 $filename"
    unzip -p "/media/randall/4004-4C2E/acapella/drive-download-20260427T214330Z-3-001.zip" "$1" > "$root/playlists/$3/$2 $filename"
}

index="01"
 extract_to_part 'Best Night of My Life/_All - BNoML.mp3' $index _ALL
 extract_to_part 'Best Night of My Life/Alto - BNoML.mp3' $index ALTO
 extract_to_part 'Best Night of My Life/Bass - BNoML.mp3' $index BASS
 extract_to_part 'Best Night of My Life/Soprano - BNoML.mp3' $index SOPR
 extract_to_part 'Best Night of My Life/Tenor - BNoML.mp3' $index TENR

index="02"
 extract_to_part 'Change the World/_All - Change the World All Parts in F#.mp3' $index _ALL
 extract_to_part 'Change the World/Alto - Change the World.mp3' $index ALTO
 extract_to_part 'Change the World/Bass - Change the World.mp3' $index BASS
 extract_to_part 'Change the World/Mezzo - Change the World.mp3' $index MEZZ
 extract_to_part 'Change the World/Soprano - Change the World.mp3' $index SOPR
 extract_to_part 'Change the World/Tenor - Change the World.mp3' $index TENR

index="03"
 extract_to_part 'Danger Zone/_All - Danger Zone.mp3' $index _ALL
 extract_to_part 'Danger Zone/Alto - Danger Zone.mp3' $index ALTO
 extract_to_part 'Danger Zone/Bass - Danger Zone.mp3' $index BASS
 extract_to_part 'Danger Zone/Mezzo-soprano - Danger Zone.mp3' $index MEZZ
 extract_to_part 'Danger Zone/Soprano - Danger Zone.mp3' $index SOPR
 extract_to_part 'Danger Zone/Tenor - Danger Zone.mp3' $index TENR

index="04"
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

index="07"
 extract_to_part 'Good Song Never Dies/_All - A Good Song Never Dies - All Parts Voice.mp3' $index _ALL
 extract_to_part 'Good Song Never Dies/Alto - A Good Song Never Dies - Alto Voice.mp3' $index ALTO
 extract_to_part 'Good Song Never Dies/Bass - A Good Song Never Dies - Bass Voices.mp3' $index BASS
 extract_to_part 'Good Song Never Dies/Mezzo - A Good Song Never Dies - Mezzo Voice.mp3' $index MEZZ
 extract_to_part 'Good Song Never Dies/Solo - A Good Song Never Dies - Solo Voice.mp3' $index SOLO
 extract_to_part 'Good Song Never Dies/Soprano - A Good Song Never Dies - Soprano Voice.mp3' $index SOPR
 extract_to_part 'Good Song Never Dies/Tenor - A Good Song Never Dies - Tenor Voice.mp3' $index TENR

 index="08"
 extract_to_part 'Nella Fantasia/_All - Nella Fantasia.mp3' $index _ALL
 extract_to_part 'Nella Fantasia/ALTO - Nella Fantasia.mp3' $index ALTO
 extract_to_part 'Nella Fantasia/BASS - Nella Fantasia.mp3' $index BASS
 extract_to_part 'Nella Fantasia/MEZZO - Nella Fantasia.mp3' $index MEZZ
 extract_to_part 'Nella Fantasia/SOPRANO - Nella Fantasia.mp3' $index SOPR
 extract_to_part 'Nella Fantasia/TENOR - Nella Fantasia.mp3' $index TENR

 index="09"
 extract_to_part 'Perhaps/_All - Perhaps.mp3' $index _ALL
 extract_to_part 'Perhaps/Alto - Perhaps.mp3' $index ALTO
 extract_to_part 'Perhaps/Bass - Perhaps.mp3' $index BASS
 extract_to_part 'Perhaps/Mezzo - Perhaps.mp3' $index MEZZ
 extract_to_part 'Perhaps/Solo - Perhaps.mp3' $index SOLO
 extract_to_part 'Perhaps/Soprano - Perhaps.mp3' $index SOPR
 extract_to_part 'Perhaps/Tenor - Perhaps.mp3' $index TENR

 index="10"
 extract_to_part 'Pink Pony Club/_All - Pink Pony Club.mp3' $index _ALL
 extract_to_part 'Pink Pony Club/Alto - Pink Pony Club.mp3' $index ALTO
 extract_to_part 'Pink Pony Club/Bass - Pink Pony Club.mp3' $index BASS
 extract_to_part 'Pink Pony Club/Solo - Pink Pony Club.mp3' $index SOLO
 extract_to_part 'Pink Pony Club/Soprano - Pink Pony Club.mp3' $index SOPR
 extract_to_part 'Pink Pony Club/Tenor - Pink Pony Club.mp3' $index TENR

 index="11"
 extract_to_part 'Poor Unfortunate Souls/_All - Poor Unfortunate Souls.mp3' $index _ALL
 extract_to_part 'Poor Unfortunate Souls/Alto - Poor Unfortunate Souls.mp3' $index ALTO
 extract_to_part 'Poor Unfortunate Souls/Bass - Poor Unfortunate Souls.mp3' $index BASS
 extract_to_part 'Poor Unfortunate Souls/Mezzo - Poor Unfortunate Souls.mp3' $index MEZZ
 extract_to_part 'Poor Unfortunate Souls/Solo - Poor Unfortunate Souls.mp3' $index SOLO
 extract_to_part 'Poor Unfortunate Souls/Soprano - Poor Unfortunate Souls.mp3' $index SOPR
 extract_to_part 'Poor Unfortunate Souls/Tenor - Poor Unfortunate Souls.mp3' $index TENR

 index="12"
 extract_to_part 'Shine/_All - Shine.mp3' $index _ALL
 extract_to_part 'Shine/Alto - Shine.mp3' $index ALTO
 extract_to_part 'Shine/Bass - Shine.mp3' $index BASS
 extract_to_part 'Shine/Mezzo - Shine.mp3' $index MEZZ
 extract_to_part 'Shine/Soprano - Shine.mp3' $index SOPR
 extract_to_part 'Shine/Tenor - Shine.mp3' $index TENR

 index="13"
 extract_to_part 'Simply the Best/Simply the Best ALL PARTS.wav' $index _ALL
 extract_to_part 'Simply the Best/Simply the Best ALTO W ENS.wav' $index ALTO
 extract_to_part 'Simply the Best/Simply the Best BASS W ENS.wav' $index BASS
 extract_to_part 'Simply the Best/Simply the Best MEZ W ENS.wav' $index MEZZ
 extract_to_part 'Simply the Best/Simply the Best SOP W ENS.wav' $index SOPR
 extract_to_part 'Simply the Best/Simply the Best TENOR W ENS.wav' $index TENR

 index="14"
 extract_to_part 'Song That Goes Like This/_All - The Song That Goes Like This.mp3' $index _ALL
 extract_to_part 'Song That Goes Like This/Alto - The Song That Goes Like This.mp3' $index ALTO
 extract_to_part 'Song That Goes Like This/Bass - The Song That Goes Like This.mp3' $index BASS
 extract_to_part 'Song That Goes Like This/Mezzo-soprano - The Song That Goes Like This.mp3' $index MEZZ
 extract_to_part 'Song That Goes Like This/Solo 1 - The Song That Goes Like This.mp3' $index SOLO
 extract_to_part 'Song That Goes Like This/Solo 2 - The Song That Goes Like This.mp3' $index SOLO
 extract_to_part 'Song That Goes Like This/Soprano - The Song That Goes Like This.mp3' $index SOPR
 extract_to_part 'Song That Goes Like This/Tenor - The Song That Goes Like This.mp3' $index TENR

 index="15"
 extract_to_part 'This is the Life/_All - This is the Life.mp3' $index _ALL
 extract_to_part 'This is the Life/Alto - This is the Life.mp3' $index ALTO
 extract_to_part 'This is the Life/Bass - This is the Life.mp3' $index BASS
 extract_to_part 'This is the Life/Solo - This is the Life.mp3' $index SOLO
 extract_to_part 'This is the Life/Soprano - This is the Life.mp3' $index SOPR
 extract_to_part 'This is the Life/Tenor - This is the Life.mp3' $index TENR

 index="16"
 extract_to_part 'Your Wildest Dreams/_All - Your Wildest Dreams.mp3' $index _ALL
 extract_to_part 'Your Wildest Dreams/Alto - Your Wildest Dreams.mp3' $index ALTO
 extract_to_part 'Your Wildest Dreams/Baritone - Your Wildest Dreams.mp3' $index BARI
 extract_to_part 'Your Wildest Dreams/Bass - Your Wildest Dreams.mp3' $index BASS
 extract_to_part 'Your Wildest Dreams/Mezzo - Your Wildest Dreams.mp3' $index MEZZ
 extract_to_part 'Your Wildest Dreams/Soprano - Your Wildest Dreams.mp3' $index SOPR
 extract_to_part 'Your Wildest Dreams/Tenor - Your Wildest Dreams.mp3' $index TENR
 
 index="17"
 extract_to_part 'You Were On My Mind/_All - You Were On My Mind.mp3' $index _ALL
 extract_to_part 'You Were On My Mind/Alto - You Were On My Mind.mp3' $index ALTO
 extract_to_part 'You Were On My Mind/Bass - You Were On My Mind.mp3' $index BASS
 extract_to_part 'You Were On My Mind/Mezzo - You Were On My Mind.mp3' $index MEZZ
 extract_to_part 'You Were On My Mind/Soprano - You Were On My Mind.mp3' $index SOPR
 extract_to_part 'You Were On My Mind/Tenor - You Were On My Mind.mp3' $index TENR
