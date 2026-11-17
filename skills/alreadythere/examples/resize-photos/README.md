# Resize photos

Drop photos into `inbox/`, run one command, get JPEGs no larger than 1600 pixels on the longest side in `done/`, and a line in `report.md` for every photo. Smaller photos are converted, never enlarged. Change `MAX=1600` (Mac) or `$Max = 1600` (Windows) at the top of the script for another size.

## Mac (tested)

Uses `sips`, the image tool built into macOS.

1. Put `mac/resize-photos.sh` in a folder of its own.
2. In Terminal: `bash /path/to/that/folder/resize-photos.sh` once. It creates `inbox/` and `done/`.
3. Drop photos into `inbox/` and run the same command again.

## Windows (not yet tested on a Windows machine)

Uses Windows PowerShell and .NET, both built into Windows 10 and 11. It also turns phone photos the right way up.

1. Put `windows/resize-photos.ps1` in a folder of its own.
2. Open PowerShell in that folder and run `powershell -ExecutionPolicy Bypass -File .\resize-photos.ps1` once. It creates `inbox\` and `done\`.
3. Drop photos into `inbox\` and run the same command again.

Windows blocks scripts by default; the `-ExecutionPolicy Bypass` part allows this one run without changing any settings.

Originals are never changed on either system. They move to `done/originals-<date>/`.
