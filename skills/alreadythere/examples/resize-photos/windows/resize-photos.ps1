# Shrink every photo in inbox\ so its longest side is at most 1600 pixels,
# save it as a JPEG in done\, then write a report.
# Uses only Windows PowerShell and .NET, both built into Windows. Run it with:
#   powershell -ExecutionPolicy Bypass -File .\resize-photos.ps1

$Max = 1600   # change this number for bigger or smaller photos

# Work in the folder this script lives in, wherever you run it from.
Set-Location $PSScriptRoot
New-Item -ItemType Directory -Force inbox, done | Out-Null
Add-Type -AssemblyName System.Drawing

$stamp = Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
$originals = "done\originals-$stamp"
$count = 0
$lines = @()   # report lines for this run, written at the end

foreach ($f in Get-ChildItem inbox -File) {
    $out = Join-Path 'done' ($f.BaseName + '.jpg')
    # Never overwrite an earlier result with the same name.
    if (Test-Path $out) { $out = Join-Path 'done' ($f.BaseName + "-$stamp.jpg") }

    try {
        $img = [System.Drawing.Image]::FromFile($f.FullName)
    } catch {
        $lines += "- $($f.Name): skipped, not an image Windows can read (left in inbox\)"
        continue
    }

    # Phones store "this photo is turned" as a tag. Apply it, or portraits come out sideways.
    if ($img.PropertyIdList -contains 0x0112) {
        switch ($img.GetPropertyItem(0x0112).Value[0]) {
            3 { $img.RotateFlip('Rotate180FlipNone') }
            6 { $img.RotateFlip('Rotate90FlipNone') }
            8 { $img.RotateFlip('Rotate270FlipNone') }
        }
    }

    # Work out the new size, keeping the proportions. Never enlarge.
    $scale = [Math]::Min(1, $Max / [Math]::Max($img.Width, $img.Height))
    $w = [int]($img.Width * $scale)
    $h = [int]($img.Height * $scale)

    # Draw the photo onto a new canvas of that size and save it as a JPEG.
    $canvas = New-Object System.Drawing.Bitmap $w, $h
    $g = [System.Drawing.Graphics]::FromImage($canvas)
    $g.InterpolationMode = 'HighQualityBicubic'
    $g.DrawImage($img, 0, 0, $w, $h)
    $canvas.Save((Join-Path $PSScriptRoot $out), [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $g.Dispose(); $canvas.Dispose(); $img.Dispose()

    $lines += "- $($f.Name) -> $(Split-Path $out -Leaf), ${w}x${h}"
    New-Item -ItemType Directory -Force $originals | Out-Null
    Move-Item $f.FullName $originals
    $count++
}

# Add this run to the report, if anything happened.
if ($lines.Count -gt 0) { Add-Content report.md (@("## $stamp", '') + $lines + '') }
if ($count -eq 0) {
    Write-Host 'No photos resized. Put photos in the inbox folder, then run this again.'
    exit 1
}
Write-Host "Done: $count photos in done\ (details in report.md)"
