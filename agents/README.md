# Skills

Personal skills and user-level agent rules live here.

## Layout

```
agents/
├── skills/
├── rules/
├── AGENTS.md
├── mcp.json.example
└── link.zsh
```

Edit skills in `skills/<name>/SKILL.md` and rules in `rules/<name>.mdc`.
`AGENTS.md` loads the rule files.

## Setup

`./setup.zsh` sources `agents/link.zsh`. You can also run it on its own:

```zsh
~/Code/dotfiles/agents/link.zsh
```

| Source | Symlink destinations |
| --- | --- |
| `skills/` | `~/.cursor/skills`, `~/.agents/skills` |
| `rules/` | `~/.cursor/rules` |
| `AGENTS.md` | `${CODEX_HOME:-~/.codex}/AGENTS.md` |

Re-running is safe. Existing files, directories, or unexpected symlinks are
moved to a unique directory under `~/.agents/dotfiles-backup/` before linking.
Set `AGENTS_DOTFILES_BACKUP` to override that location. Backup contents are
not merged automatically; move anything you want to keep into this repo.

Start a new task to load global instructions. Restart the app if a new skill
does not appear. An `AGENTS.override.md` beside the linked `AGENTS.md` takes
precedence over it.

Editor settings, credentials, built-in skills, and session state stay outside
this repo. Copy `mcp.json.example` to `~/.cursor/mcp.json` when needed and fill
in secrets there; do not symlink live MCP configuration.

## Small mobile game skills

| Skill | Use for |
| --- | --- |
| `invent-game` | Explore 3–5 distinct mechanics and choose a small prototype |
| `evaluate-game` | Score concepts or prototypes and choose the next evidence-gathering test |
| `game-feel` | Tune control, timing, and feedback for the core action |
| `art-director` | Define a reusable visual bible and asset brief |

These skills are plain `SKILL.md` files with no agent-specific tools or runtime
requirements. Keep `agents/skills/` as the canonical source in this dotfiles
repo: the existing links already expose it to Codex and Cursor. To use the
skills in a separate game repo, copy the desired skill folders into that
project's `.agents/skills/`. Copy the game philosophy from the root
[`AGENTS.md`](../AGENTS.md) into the game's own instructions as appropriate.

Discovery locations: [Codex skills](https://developers.openai.com/codex/skills/)
and [Cursor skills](https://cursor.com/docs/skills).
