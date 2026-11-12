# Merge PDFs

Drop PDFs into `inbox/`, run one command, get one merged PDF in `done/` and a line in `report.md` for every file.

## Mac (tested)

Uses the PDF combiner macOS ships inside Automator, plus PDFKit through `osascript` to count pages. Nothing to install, no developer tools needed.

1. Put `mac/merge-pdfs.sh` in a folder of its own.
2. In Terminal: `bash /path/to/that/folder/merge-pdfs.sh` once. It creates `inbox/` and `done/`.
3. Drop your PDFs into `inbox/`. They are merged in name order, so `01-...`, `02-...` controls the order.
4. Run the same command again.

Your originals are never changed. They move to `done/originals-<date>/`.

## Windows

Windows has no built-in PDF merger. This is exactly where step 2 of the prompt matters: the check often finds something already installed that can do it (Microsoft Word, LibreOffice, a PDF app with a command line). If nothing is there, the prompt says so plainly before suggesting a free tool to install.
