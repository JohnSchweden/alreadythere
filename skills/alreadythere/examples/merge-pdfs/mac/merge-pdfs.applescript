-- Merge PDFs: double-click me. I merge every PDF in the "inbox" folder next to me,
-- in name order, into one new PDF in the "done" folder. Your original files are not changed.

-- If I'm run straight from Script Editor, I don't know which folder is mine yet.
if (POSIX path of (path to me)) starts with "/System/" or (POSIX path of (path to me)) starts with "/usr/" then
	display dialog "Save me as an app first: File > Export, File Format: Application. Then double-click the saved app." buttons {"OK"} default button 1
	return
end if

-- macOS ships a PDF combiner inside Automator. Stop politely if this Mac doesn't have it.
set joinTool to "/System/Library/Automator/Combine PDF Pages.action/Contents/MacOS/join"
try
	do shell script "test -x " & quoted form of joinTool
on error
	display dialog "This Mac doesn't have the built-in PDF combiner. Tell the AI, and it will suggest another way." buttons {"OK"} default button 1
	return
end try

-- The folders next to me. The first time, I create them.
set here to POSIX path of ((path to me as text) & "::")
set inbox to here & "inbox/"
set done to here & "done/"
do shell script "mkdir -p " & quoted form of inbox & " " & quoted form of done
-- The PDFs in the inbox, in name order (01-..., 02-... sets the order).
set pdfs to paragraphs of (do shell script "cd " & quoted form of inbox & " && ls | grep -i '\\.pdf$' || true")
if (count of pdfs) < 2 then
	display dialog "Put at least two PDFs in the inbox folder, then open me again." buttons {"OK"} default button 1
	return
end if
set args to ""
repeat with f in pdfs
	set args to args & " " & quoted form of (inbox & f)
end repeat
set stamp to do shell script "date +%Y-%m-%d_%H-%M-%S"
set outFile to done & "merged-" & stamp & ".pdf"
-- Merge them into one new file, named with today's date and time so nothing is overwritten.
do shell script quoted form of joinTool & " -o " & quoted form of outFile & args
display dialog "Done: " & (count of pdfs) & " PDFs merged into done/merged-" & stamp & ".pdf" buttons {"Show me", "OK"} default button 1
if button returned of result is "Show me" then do shell script "open -R " & quoted form of outFile
