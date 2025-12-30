#!/bin/bash

# Toggle dry-run mode: true = do not delete, false = actually delete
DRY_RUN=true

# Folders to clean
MEDIA_FOLDERS=(
  "/mnt/user/data/media/movies"
  "/mnt/user/data/media/tv"
)

# Keep ONLY video + subtitle files (expanded)
VIDEO_EXT=("mkv" "mp4" "avi" "mov" "m4v" "wmv" "mpeg" "mpg" "webm" "flv" "ts" "m2ts" "ogv" "3gp" "vob")
SUB_EXT=("srt" "ass" "ssa" "sub" "vtt" "idx")

# Temp/junk extensions to always remove
JUNK_EXTS=("tmp" "temp" "partial" "part" "crdownload" "DS_Store" "Thumbs.db")

# Initialize counters
declare -A ext_count
total_files_deleted=0

for MEDIA_ROOT in "${MEDIA_FOLDERS[@]}"; do
  echo "=== Scanning $MEDIA_ROOT ==="

  while IFS= read -r file; do
    # Extract lowercase extension
    ext="${file##*.}"
    ext="${ext,,}"  # lowercase

    # Check if extension is allowed (video or subtitle)
    keep=false
    for allowed in "${VIDEO_EXT[@]}" "${SUB_EXT[@]}"; do
      if [ "$ext" == "$allowed" ]; then
        keep=true
        break
      fi
    done

    if [ "$keep" = false ]; then
      # Increment counters
      ((ext_count[$ext]++))
      ((total_files_deleted++))

      if [ "$DRY_RUN" = true ]; then
        echo "[DRY-RUN] Would delete: $file"
      else
        rm -f "$file"
        echo "Deleted: $file"
      fi
    fi

  done < <(find "$MEDIA_ROOT" -type f)
done

# Print summary
echo "=== Cleanup Summary ==="
echo "Total files affected: $total_files_deleted"
echo "Files by extension:"
for ext in "${!ext_count[@]}"; do
  echo "  .$ext : ${ext_count[$ext]}"
done

if [ "$DRY_RUN" = true ]; then
  echo "=== DRY-RUN MODE: No files were deleted ==="
else
  echo "=== Cleanup complete ==="
fi
