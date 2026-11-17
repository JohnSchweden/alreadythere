# Merge PDFs

Drop PDFs into `inbox/`, run one command, get one merged PDF in `done/` and a line in `report.md` for every file.

## Mac, double-click app (tested)

No Terminal. Uses the PDF combiner macOS ships inside Automator.

1. Make a folder, for example "Merge PDFs" on the Desktop.
2. Open Script Editor (Applications › Utilities), New Document, paste [`mac/merge-pdfs.applescript`](mac/merge-pdfs.applescript).
3. File › Export…, File Format: Application, save it into that folder as "Merge PDFs".
4. Double-click it once: it creates `inbox/` and `done/`. Allow access to the folder if macOS asks.
5. Drop PDFs into `inbox/` (name order sets the page order) and double-click again.

## Mac, Terminal version (tested)

Uses the PDF combiner macOS ships inside Automator, plus PDFKit through `osascript` to count pages. Nothing to install, no developer tools needed.

1. Put `mac/merge-pdfs.sh` in a folder of its own.
2. In Terminal: `bash /path/to/that/folder/merge-pdfs.sh` once. It creates `inbox/` and `done/`.
3. Drop your PDFs into `inbox/`. They are merged in name order, so `01-...`, `02-...` controls the order.
4. Run the same command again.

Your originals are never changed. They move to `done/originals-<date>/`.

## Windows

Windows has no built-in PDF merger. The prompt asks which apps you already use: Microsoft Word can open PDFs and save PDFs, and a double-click file can drive Word in the background, but Word converts a PDF into an editable document first, so the layout can shift. Fine for plain text letters, not for forms or statements with tables. If nothing you have can do it, the prompt says so plainly before suggesting a free tool to install. Not tested on Windows yet.
