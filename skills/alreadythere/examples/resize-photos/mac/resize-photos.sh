#!/bin/bash
# Shrink every photo in inbox/ so its longest side is at most 1600 pixels,
# save it as a JPEG in done/, then write a report.
# Uses only sips, the image tool built into macOS. Run it with:  bash resize-photos.sh

MAX=1600   # change this number for bigger or smaller photos

# Work in the folder this script lives in, wherever you run it from.
cd "$(dirname "$0")" || exit 1
mkdir -p inbox done

stamp=$(date +%Y-%m-%d_%H-%M-%S)
count=0
lines=""   # report lines for this run, written at the end

for f in inbox/*; do
  [ -f "$f" ] || continue
  name=$(basename "$f")
  out="done/${name%.*}.jpg"
  # Never overwrite an earlier result with the same name.
  [ -e "$out" ] && out="done/${name%.*}-$stamp.jpg"

  # Read the photo's size. sips -Z keeps the proportions, but it would also
  # enlarge small photos, so we only use it when the photo is too big.
  w=$(sips -g pixelWidth "$f" 2>/dev/null | awk '/pixelWidth/ && $2 ~ /^[0-9]+$/ {print $2}')
  h=$(sips -g pixelHeight "$f" 2>/dev/null | awk '/pixelHeight/ && $2 ~ /^[0-9]+$/ {print $2}')
  resize=()
  if [ -n "$w" ] && { [ "$w" -gt "$MAX" ] || [ "$h" -gt "$MAX" ]; }; then
    resize=(-Z "$MAX")
  fi

  if [ -n "$w" ] && sips "${resize[@]}" -s format jpeg "$f" --out "$out" >/dev/null 2>&1; then
    w=$(sips -g pixelWidth "$out" | awk '/pixelWidth/ && $2 ~ /^[0-9]+$/ {print $2}')
    h=$(sips -g pixelHeight "$out" | awk '/pixelHeight/ && $2 ~ /^[0-9]+$/ {print $2}')
    lines+="- $name → $(basename "$out"), ${w}×${h}"$'\n'
    mkdir -p "done/originals-$stamp"
    mv "$f" "done/originals-$stamp/"
    count=$((count + 1))
  else
    lines+="- $name: skipped, not an image sips can read (left in inbox/)"$'\n'
  fi
done

# Add this run to the report, if anything happened.
[ -n "$lines" ] && printf '## %s\n\n%s\n' "$stamp" "$lines" >> report.md

if [ "$count" -eq 0 ]; then
  echo "No photos resized. Put photos in the inbox folder, then run this again."
  exit 1
fi
echo "Done: $count photos in done/ (details in report.md)"
