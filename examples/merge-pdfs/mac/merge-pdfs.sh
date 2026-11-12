#!/bin/bash
# Merge every PDF in inbox/ into one PDF in done/, then write a report.
# Uses only tools built into macOS. Run it with:  bash merge-pdfs.sh

# Work in the folder this script lives in, wherever you run it from.
cd "$(dirname "$0")" || exit 1
mkdir -p inbox done

# macOS ships a PDF combiner inside Automator. We call it directly.
JOIN="/System/Library/Automator/Combine PDF Pages.action/Contents/MacOS/join"

# Collect the PDFs in inbox/, sorted by name (01-..., 02-... controls the order).
pdfs=()
for f in inbox/*.pdf; do
  [ -e "$f" ] && pdfs+=("$f")
done
if [ "${#pdfs[@]}" -lt 2 ]; then
  echo "Put at least two PDFs in the inbox folder, then run this again."
  exit 1
fi

# Name the result with the date and time, so nothing is ever overwritten.
stamp=$(date +%Y-%m-%d_%H-%M-%S)
out="done/merged-$stamp.pdf"
"$JOIN" -o "$out" "${pdfs[@]}"
if [ ! -s "$out" ]; then
  echo "Merging failed. Your files are untouched in inbox/."
  exit 1
fi

# Count pages with macOS's PDF framework (through osascript, also built in).
pages() {
  osascript -l JavaScript -e 'function run(argv) {
    ObjC.import("PDFKit")
    return $.PDFDocument.alloc.initWithURL($.NSURL.fileURLWithPath(argv[0])).pageCount
  }' "$PWD/$1"
}

# Add this run to the report, then move the originals out of the inbox.
mkdir -p "done/originals-$stamp"
{
  echo "## $stamp"
  echo
  for f in "${pdfs[@]}"; do
    echo "- $(basename "$f"): $(pages "$f") pages"
  done
  echo "- **Result:** $(basename "$out"), $(pages "$out") pages"
  echo
} >> report.md
mv "${pdfs[@]}" "done/originals-$stamp/"

echo "Done: $out (details in report.md)"
