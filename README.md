# Audio Normalizer

A Python utility to normalize audio files (MP3 and WAV) to EBU R128 standards.

> [!WARNING]
> The scripts in this project (specifically the helper shell scripts like `run_normalizations.sh`, `create_zips.sh`, etc.) contain **absolute file paths** specific to the original environment. You **must** edit these paths to match your system's directory structure before running them.

## Features

- **EBU R128 Normalization**: 
  - Integrated Loudness Target: -16 LUFS
  - True Peak Target: -1.5 dBTP
  - Loudness Range Target: 11.0 LU
- **Format Support**: Accepts `.mp3` and `.wav` inputs.
- **Output**: Always produces normalized `.mp3` files (192kbps).

> [!WARNING]
> One of the scripts (`create_zips.sh`) dependencies on `7z` (p7zip).
> 
> **Install on Ubuntu:**
> ```bash
> sudo apt update && sudo apt install p7zip-full
> ```

## Requirements

- [FFmpeg](https://ffmpeg.org/) (must be on your system PATH)
- Python 3.10+
- [uv](https://github.com/astral-sh/uv) (recommended for dependency management)
- `p7zip-full` (for `create_zips.sh`)

## Installation

Clone the repository and install dependencies:

```bash
git clone https://github.com/randomfactor/normal-vol.git
cd normal-vol
uv sync
```

## Usage

### Single Directory
Run the script on a directory containing audio files:

```bash
uv run python normalize_audio.py /path/to/audio/files
```

Files will be saved in a `normalized/` subdirectory by default.

### Batch Processing
Use the included helper scripts for batch operations:

- `run_normalizations.sh`: Edit this script to define multiple directories to process.
- `create_zips.sh`: Zips the normalized outputs into archives.
