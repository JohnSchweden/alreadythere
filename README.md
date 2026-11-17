# AlreadyThere

**Your computer can probably already do that chore. You just need someone to show you how.**

Someone wanted an AI to merge two PDF files. Their laptop could already do it. A small file that used what was there merged them in seconds, and now it merges whatever lands in a folder. No app, no subscription, no AI needed to run it.

AlreadyThere is an agent skill for Claude Code and Codex, plus a prompt for any AI chat. Either way it turns the AI into a patient helper that:

- **asks about your chore** in plain words, until both of you understand it,
- **looks for the simplest way with what you already have**: sometimes that's a few clicks in an app you know, sometimes one small file,
- **builds that file with you**, and tells you exactly how to save it,
- so from then on you **drop your files in a folder and double-click**. Every time, same result, no AI.

You never type commands. You don't need to know what a script is.

## Install the skill (Claude Code or Codex)

One line, either tool:

```sh
npx skills add JohnSchweden/alreadythere -g -a claude-code -a codex
```

Leave out `-g` to install it into the project you're in (`.claude/skills/` and `.agents/skills/`) instead of for your user. Use only `-a claude-code` or only `-a codex` if you have one of them.

Claude Code only, as a plugin (type it inside Claude Code):

```
/plugin install alreadythere --marketplace JohnSchweden/alreadythere
```

Then describe your chore. The agent picks the skill up from the task, or you call it: `/alreadythere` in Claude Code (`/alreadythere:alreadythere` with the plugin install), `$alreadythere` in Codex.

### Skill or prompt?

Same method, different reach. The skill is for an agent that can run commands on your computer; the prompt is for a chat that can't.

| | Skill (Claude Code, Codex) | Prompt (any AI chat) |
|---|---|---|
| What's on your computer | the agent checks it itself, read-only | the AI asks you which apps you use |
| The script | the agent writes it into your folder and tests it on copies before you run it | you copy it from the chat and save it yourself |
| When it fails | the agent reads the error itself | you copy the error back into the chat |
| Next time | loads by itself when a chore comes up | you paste the prompt again |
| You need | Claude Code or Codex | nothing to install |

## Use the prompt (any AI chat, nothing to install)

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

- **Layout:** the skill is [`skills/alreadythere/`](skills/alreadythere/) ([`SKILL.md`](skills/alreadythere/SKILL.md) plus its tested examples); [`.claude-plugin/`](.claude-plugin/) makes the repo a Claude Code plugin marketplace; [`PROMPT.md`](PROMPT.md) is the chat version.
- **Manual install:** copy `skills/alreadythere/` into `~/.claude/skills/` (Claude Code) or `~/.agents/skills/` (Codex).
- **No install:** tell the agent "Read https://github.com/JohnSchweden/alreadythere/blob/main/skills/alreadythere/SKILL.md and follow it for this task:" and add your chore.

- **Tested examples** in [examples/](skills/alreadythere/examples/):

| Task | Mac | Windows |
|---|---|---|
| [Merge PDFs](skills/alreadythere/examples/merge-pdfs/) | double-click app (AppleScript), tested; shell version, tested | Windows has no built-in PDF merger; Word can |
| [Resize photos](skills/alreadythere/examples/resize-photos/) | shell version, tested | PowerShell version, not yet tested on Windows |

Mac scripts were tested on macOS 27 with no Homebrew and no Python on the path, using only tools that ship with macOS.

## License

MIT
