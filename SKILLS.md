This is a python command line project utilizing the python virtual environment to normalize the volume of MP3 files using the EBU R128 loudness normalization method.

You can normalize volume across many MP3 files with FFmpeg by using its audio filters or a helper script like ffmpeg-normalize. The most reliable method is EBU R128 loudness normalization, which ensures consistent perceived loudness across tracks.

EBU R128 Loudness Normalization (Recommended)
Uses the loudnorm filter, designed for broadcast standards.

Two-pass normalization is most accurate:

First pass (measure loudness):

bash
ffmpeg -i input.mp3 -af loudnorm=I=-16:TP=-1.5:LRA=11:print_format=json -f null -
Copy the measured values (input_i, input_tp, input_lra, input_thresh).

Second pass (apply normalization):

bash
ffmpeg -i input.mp3 -af loudnorm=I=-16:TP=-1.5:LRA=11:measured_I=...:measured_TP=...:measured_LRA=...:measured_thresh=...:offset=...:linear=true:print_format=summary output.mp3
This ensures all files are normalized to the same loudness target.

