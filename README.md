# AlreadyThere

**The tool you need is probably already on your laptop.**

Someone asked an AI to merge two PDFs. It doesn't need an AI, an app or a subscription: every Mac ships a PDF combiner. A short script that calls it merged the files in a second, and with a small loop it now merges whatever lands in a folder and writes a report. It keeps working with no AI, no internet and no account.

AlreadyThere is a prompt that teaches any AI chat to work this way:

1. **Understand the job.** What goes in, what comes out, how often.
2. **Check what's already there.** One read-only command lists the tools and apps on your computer. You read it before you run it.
3. **Show the options.** Built-in first, then apps you already have, installs only as a last resort.
4. **Write one small script.** Plain comments, never touches your originals. For repeat jobs: drop files in `inbox/`, run one command, results in `done/`, a `report.md` of what happened.
5. **Teach while it goes.** You predict what the key line does before it runs, and you leave knowing one idea you can reuse.
6. **Fix together.** Paste the error, understand it, change one thing.

The point is that you get the script *and* the understanding. You stay in charge; the AI helps you think.

## Use it

**Any AI chat (ChatGPT, Claude, Copilot, Gemini), nothing to install:** copy the contents of [PROMPT.md](PROMPT.md) into a new chat, then describe your task.

**As an agent skill (Claude Code, Codex, Cursor and others that read `SKILL.md`):** copy this folder into your skills folder, for example `~/.claude/skills/alreadythere/`.

## Examples

| Task | Mac | Windows |
|---|---|---|
| [Merge PDFs](examples/merge-pdfs/) | built-in, tested | no built-in tool; the check step looks for one you already have |
| [Resize photos](examples/resize-photos/) | built-in, tested | built-in, not yet tested on Windows |

Mac scripts are tested on macOS 27 with a clean environment (no Homebrew, no Python, no developer tools on the path).

## What tends to already be there

- **Mac:** `osascript` (AppleScript and JavaScript with access to macOS frameworks like PDFKit), `sips` (images), `textutil` (Word, RTF, HTML, text), `cupsfilter` (to PDF), `mdls` (file details), `shortcuts`, Automator's PDF combiner.
- **Windows:** PowerShell and .NET (images, files, zip, web requests, Excel and Word through Office if installed).
- **Apps you already use** that run without a window: LibreOffice, VLC, GIMP, Inkscape, Microsoft Office.

## License

MIT
