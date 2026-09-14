# Personal instructions

Read the user-level rule files in `~/Code/dotfiles/agents/rules/*.mdc` before
starting work.
Treat their Markdown bodies as instructions; their YAML frontmatter describes
when to apply them. Apply `alwaysApply: true` rules to every task; apply other
rules only when their description or file globs match the task.

Personal skills live in `~/Code/dotfiles/agents/skills/`.
Edit the source files in dotfiles.

Some skills name host-specific tools (for example, `move_agent_to_root`).
Use the current host's equivalent when available. For repository operations,
use an explicit working directory or `git -C` with the skill's specified path.
If a required capability has no equivalent, explain the missing capability.
