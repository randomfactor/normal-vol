import mido
import argparse
import sys

def extract_midi_lyrics(file_path):
    mid = mido.MidiFile(file_path)
    all_tracks_lyrics = []

    for track in mid.tracks:
        track_lyrics = []
        track_name = None
        for msg in track:
            if msg.type == 'track_name':
                track_name = msg.name
            # Look for 'lyrics' or 'text' meta-messages
            if msg.type == 'lyrics' or msg.type == 'text':
                track_lyrics.append(msg.text)
        
        if track_lyrics:
            joined_lyrics = "".join(track_lyrics)
            if track_name:
                all_tracks_lyrics.append(f"{track_name.upper()}\n{joined_lyrics}")
            else:
                all_tracks_lyrics.append(joined_lyrics)
    
    # Join tracks with newline
    return "\n".join(all_tracks_lyrics)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extract lyrics from a MIDI file.")
    parser.add_argument("midi_file", help="Path to the MIDI file")
    
    args = parser.parse_args()
    
    try:
        result = extract_midi_lyrics(args.midi_file)
        print(result)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)
