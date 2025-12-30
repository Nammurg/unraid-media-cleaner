# Unraid Media Cleaner

**Unraid Media Cleaner** is a bash script designed to maintain clean media folders on your Unraid server. It removes non-video and non-subtitle files while preserving valid media files and empty directories for Sonarr/Radarr.

## Features
- Deletes temp/junk files and non-media files
- Keeps all common video formats: mkv, mp4, avi, flv, ts, webm, mov, m4v, wmv, mpeg, mpg, m2ts, ogv, 3gp, vob
- Keeps all common subtitle formats: srt, ass, sub, idx, vtt, ssa
- Preserves empty directories for Sonarr/Radarr
- Dry-run mode to preview deletions safely
- Provides a per-extension summary of files removed

## Usage
1. Edit `media-cleaner.sh` to set your media folder paths.
2. Run in dry-run mode to preview deletions:

```bash
DRY_RUN=true ./media-cleaner.sh
