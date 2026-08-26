# Cursor

Global Cursor **skills** and **user-level agent rules**, versioned here and symlinked to the paths Cursor reads.

Editor settings, keybindings, and snippets stay out of this repo — Cursor already syncs `~/Library/Application Support/Cursor/User/` with the signed-in account.

This repo is public. Nothing in this folder has been pushed yet — review it before it goes to `origin`.

## Layout

```
cursor/
├── skills/          → ~/.cursor/skills
├── rules/           → ~/.cursor/rules
├── mcp.json.example
└── link.zsh
```

Cursor has no “put my skills in another folder” setting. It always reads user skills from `~/.cursor/skills` and user rule files from `~/.cursor/rules`. The symlink is what makes those directories this repo. Creating a personal skill in the UI or via the agent writes into the repo automatically.

`./setup.zsh` sources `cursor/link.zsh`. You can also run that script on its own:

```zsh
~/Code/dotfiles/cursor/link.zsh
```

Re-running is safe. If a destination already exists and is not the expected symlink, it is moved to `~/.cursor/dotfiles-backup/<timestamp>/...` first. New skill/rule files do not need a reload; they are live as soon as they hit the linked folders.

## What is linked

| Repo path | Cursor reads |
| --- | --- |
| `skills/` | User skills (`~/.cursor/skills`) |
| `rules/` | User rule files (`~/.cursor/rules`) |

## What is intentionally not in git

| Path | Why |
| --- | --- |
| Cursor User `settings.json` / `keybindings.json` / snippets | Account-synced by Cursor. |
| `~/.cursor/mcp.json` | Contains API keys. Template is `mcp.json.example`. |
| `~/.cursor/cli-config.json` | Account email / auth ids. |
| `~/.cursor/skills-cursor/` | Cursor-managed built-in skills. |
| `~/.cursor/projects/`, History, globalStorage | Machine/session state. |

Copy `mcp.json.example` to `~/.cursor/mcp.json` on a new machine and fill in secrets there. Do not symlink MCP config from this repo.

## Review before publishing

These are not secrets, but they are identifying / work-specific:

- TMU skills mention local paths (`/Users/austen/Code/...`), Flare project id `1790`, GitHub org `hdmastr`, and Headmaster/TMU workflow details.

The python, product-name copyright, and PR-heading rules exist both as files here and as Cursor Settings user rules (account-synced). They may apply twice until you drop one copy. Git commit / PR creation protocols that show up in agent context were not stored as Settings files on this machine, so they are not in this folder yet.
