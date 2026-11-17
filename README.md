# AlreadyThere

**Your computer can probably already do that chore. You just need someone to show you how.**

Someone wanted an AI to merge two PDF files. Their laptop could already do it. A small file that used what was there merged them in seconds, and now it merges whatever lands in a folder. No app, no subscription, no AI needed to run it.

AlreadyThere is a set of instructions you paste into an AI chat. It turns the AI into a patient helper that:

- **asks about your chore** in plain words, until both of you understand it,
- **looks for the simplest way with what you already have**: sometimes that's a few clicks in an app you know, sometimes one small file,
- **builds that file with you**, and tells you exactly how to save it,
- so from then on you **drop your files in a folder and double-click**. Every time, same result, no AI.

You never type commands. You don't need to know what a script is.

## How to use it

1. Open [PROMPT.md](PROMPT.md), copy everything in it.
2. Open the AI chat you already use (ChatGPT, Claude, Copilot, Gemini) and start a new chat.
3. Paste it, and below it describe your chore in your own words. For example:
   - "Every month I get 30 invoices as PDFs and rename each one by hand."
   - "I need to shrink 200 holiday photos so I can email them."
   - "I have to turn a folder of Word files into PDFs."
4. Answer its questions. It will tell you what to click, or give you a file and the steps to save it.
Your files stay on your computer. You don't upload them to the chat.

## What you'll end up with

For a chore you do again and again, a folder like this:

```
Merge PDFs/
  Merge PDFs     ← double-click this
  inbox/         ← drop your files here
  done/          ← your results appear here
```

On a Mac it's a small app you save from Script Editor (it comes with every Mac). On Windows it's a file you save from Notepad. The AI walks you through it, step by step.

## Good to know

- **Work laptops:** you usually can't install anything, and that's fine: this uses what's already there. Some companies block double-click files on Windows; if that happens, it's a company setting, not your mistake.
- **Tested so far:** the PDF merge on a Mac (macOS 27). Windows files are not tested yet.
- **It won't guess.** If part of your chore needs a person to decide (is this photo good, which client is this), it says so and leaves that part to you.

---

## For developers

- **As an agent skill** (Claude Code, Codex, Cursor and others that read `SKILL.md`): copy this folder into your skills folder, for example `~/.claude/skills/alreadythere/`. An agent with a terminal can do the steps itself; the prompt is written for a person in a plain chat.
- **Tested examples** in [examples/](examples/):

| Task | Mac | Windows |
|---|---|---|
| [Merge PDFs](examples/merge-pdfs/) | double-click app (AppleScript), tested; shell version, tested | Windows has no built-in PDF merger; Word can |
| [Resize photos](examples/resize-photos/) | shell version, tested | PowerShell version, not yet tested on Windows |

Mac scripts were tested on macOS 27 with no Homebrew and no Python on the path, using only tools that ship with macOS.

## License

MIT
