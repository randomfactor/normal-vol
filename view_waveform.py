import argparse
import numpy as np
import matplotlib.pyplot as plt
from pydub import AudioSegment
import sys

def view_waveform(file_path):
    try:
        audio = AudioSegment.from_file(file_path)
    except Exception as e:
        print(f"Error reading file {file_path}: {e}")
        sys.exit(1)

    # Convert to numpy array
    data = np.array(audio.get_array_of_samples())
    sample_rate = audio.frame_rate
    
    # Handle Stereo (interleaved samples)
    if audio.channels > 1:
        print(f"Stereo file detected ({audio.channels} channels), showing channel 0")
        data = data.reshape((-1, audio.channels))
        data = data[:, 0]
    
    # Create time axis
    duration = len(data) / sample_rate
    time = np.linspace(0., duration, len(data))

    # Determine min/max based on data type for fixed Y-axis
    dtype = data.dtype
    if np.issubdtype(dtype, np.integer):
        max_val = float(np.iinfo(dtype).max)
        min_val = float(np.iinfo(dtype).min)
    else:
        # Fallback for float or other types
        max_val = 1.0
        min_val = -1.0
        
    # Set y-scale to symlog as requested
    plt.yscale('symlog', linthresh=100)
    
    # Set fixed Y limits
    plt.ylim(min_val, max_val)

    # Plot the data
    plt.figure(figsize=(12, 6))
    ax = plt.gca()
    ax.plot(time, data, color='blue', alpha=0.7)
    
    # Re-apply limits and scale to current axes (order matters in matplotlib)
    ax.set_yscale('symlog', linthresh=100)
    ax.set_ylim(min_val * 1.05, max_val * 1.05) # Add 5% padding
    
    plt.title(f"Waveform of {file_path}")
    plt.xlabel("Time (s)")
    plt.ylabel("Amplitude")
    plt.grid(True, alpha=0.3)
    
    # Draw reference lines
    if np.issubdtype(dtype, np.integer):
        ax.axhline(y=np.iinfo(dtype).max, color='r', linestyle='--', label='Max Scale')
        ax.axhline(y=np.iinfo(dtype).min, color='r', linestyle='--', label='Min Scale')
    
    plt.legend()
    plt.tight_layout()
    
    # Lock Y-axis zoom by resetting limits on draw
    def lock_zoom(event):
        # Only reset if we are on the main axes
        if event.inaxes != ax: return
        current_ylim = ax.get_ylim()
        if current_ylim != (min_val * 1.05, max_val * 1.05):
             ax.set_ylim(min_val * 1.05, max_val * 1.05)

    # Connect the callback to draw_event so it resets Y-limits after every zoom/pan
    plt.gcf().canvas.mpl_connect('draw_event', lambda event: ax.set_ylim(min_val * 1.05, max_val * 1.05))

    print("-" * 50)
    print("Waveform Viewer Controls:")
    print("1. Zoom In:  Click the 'Zoom' magnifying glass icon, then drag a rectangle.")
    print("             (The vertical height of the box is ignored; only time is zoomed.)")
    print("2. Zoom Out: Click the 'Back' (Left Arrow) icon to undo the last zoom.")
    print("3. Reset:    Click the 'Home' icon to view the full file.")
    print("4. Pan:      Click the 'Pan' (Cross arrows) icon, then drag left/right.")
    print("-" * 50)
    print("Close the plot window to exit.")
    
    plt.show()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="View audio waveform.")
    parser.add_argument("file_path", help="Path to the audio file (.wav)")
    args = parser.parse_args()
    
    view_waveform(args.file_path)
