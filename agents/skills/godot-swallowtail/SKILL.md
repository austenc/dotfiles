---
name: godot-swallowtail
description: Build, edit, debug, and playtest Godot projects through Swallowtail. Use for Godot implementation, project setup, engine inspection, and verification; concept-only game design does not require an editor.
---

# Godot with Swallowtail

Use Swallowtail for every Godot development task by default. Prefer its live
editor and runtime commands for supported operations. Ordinary source editing
and Godot's native import/export tools remain useful complements. An explicit
user choice overrides this default. If Swallowtail cannot run, diagnose the
blocker, continue useful independent work, and state the verification gap.

## Start in the right project

Resolve the actual directory containing `project.godot`; use an explicit working
directory or `swallowtail --project /absolute/project` for commands. Never rely
on a default port to choose among multiple open projects.

1. Check `swallowtail version`, `godot --version`, and
   `swallowtail doctor --project /absolute/project --json`.
2. For a new project, use `swallowtail create --path /absolute/project`, then
   `swallowtail install --project /absolute/project --enable --skill=false`.
   For an existing project, inspect the addon/plugin state before installing;
   do not overwrite a modified addon with `--force` casually. `--skill=false`
   avoids duplicating this global skill into the project's Claude directory.
3. Check `swallowtail status --project /absolute/project`. Use
   `swallowtail launch --project /absolute/project` when needed; it handles
   discovery instead of blindly stacking editors. Prefer a windowed editor
   for visual work and runtime debugging; use `--headless` for suitable checks.
4. Run commands from that project, or supply its explicit path. Discovery uses
   `.godot/swallowtail.json`; do not commit this generated state. If connection
   fails, use `doctor`, status, and `.godot/swallowtail-launch.log` to diagnose.

The release bundle must retain `addons/` beside the real CLI binary. On Austen's
Mac, the installed bundle is `~/.local/share/swallowtail/1.0.1/`, launched by
`~/.local/bin/swallowtail`; `~/.local/bin/godot` points at Godot.app. Verify actual
paths and versions rather than assuming those host details elsewhere. The
initial setup was verified with Godot 4.7.2. Read current upstream installation
notes before changing engine/addon versions; do not upgrade a game implicitly.

## Discover, build, and read back

- Before using unfamiliar engine APIs, query `engine search`, `engine class-info`,
  or `engine docs` against the running build. Use group/command `--help` and
  `engine commands` for the installed schema instead of guessing parameters.
- Use typed scene/node/resource commands where suitable. Generic `node set`,
  `node call`, and editor scripts cover engine APIs without dedicated wrappers.
  Prefer narrowly scoped writes, and inspect current state before changing it.
- Read back important properties, inspect the scene tree, and save changes.
  Disk validation does not include unsaved editor state. External file changes
  can leave cached resources stale; follow the upstream gotchas guide when
  read-back disagrees with disk. Programmatically packed children need `owner`
  assigned to the scene root to survive saving.

## Verify the actual behavior

Validate changed scripts (`script validate --path`, `--modified`, or `--all`,
exactly one mode) and affected scenes (`scene validate --path res://...`).
Inspect `valid`, `failed`, and diagnostics: transport success is not a passing
validation result. `swallowtail check` provides a cold compile check when no
editor is available.

For gameplay changes, play the affected scene with `scene play`, exercise input
through `input action` or a `test run-scenario`, then inspect `runtime tree`,
`runtime get`, and `runtime errors`. Pair direct action presses with releases.
For scenarios, check `all_passed`, `assertions_failed`, and `errors`, not just
process exit status. Capture and actually inspect runtime screenshots for
visual changes. Stop test runs you started when finished.

A real script error can freeze the player under a headless editor before runtime
error polling works. Check debugger state and logs; recover with `scene stop`
and `scene play`, and use a windowed session when diagnosing script errors.
Hot reload preserves existing state; restart to verify changed exported defaults,
initializers, or `class_name` registration. Do not claim automated input proves
human enjoyment or that desktop tests prove mobile touch/performance quality.

Use game-feel, game-art-director, game-evaluate, and game-invent when their design
or evaluation work applies; this skill supplies the Godot implementation loop.

## Optional MCP

The CLI supplies the complete workflow without MCP configuration. If MCP is
useful, configure it for the real Godot project after reading the upstream
client setup docs. Use an absolute executable and explicit `--project` in the
stdio command: `swallowtail serve --project /absolute/project --typed=false`.
This exposes `godot_run`; discover method schemas through the engine catalog.
Enable the larger typed tool surface only when useful. Preview configuration
before merging it; preserve other servers. Avoid globally binding all tasks to
one game's path or a generic port. Check the actual host's config format.

## Before shipping

Follow the upstream release procedure for every export: disable the plugin so
`MCPGameInspector` and `MCPGameInput` are removed from autoloads; exclude
`addons/swallowtail/*` and any `mcp_commands/*` in every export preset. Inspect
the resulting package/PCK for absence of Swallowtail and MCPGame entries, with
a known game resource as a positive control. Account for platform packaging
(e.g. Android) using the shipping guide. Export success alone does not establish
that development tooling was excluded. Restore development setup after the
release check when needed.

## Authoritative references

Read only the pages needed for the current work:

- [Installation](https://regiellis.github.io/godot-mcp-go/docs/installation/)
- [Quickstart](https://regiellis.github.io/godot-mcp-go/docs/quickstart/)
- [Discover, then drive](https://regiellis.github.io/godot-mcp-go/docs/discover-then-drive/)
- [Validation](https://regiellis.github.io/godot-mcp-go/docs/validation/)
- [Playtesting](https://regiellis.github.io/godot-mcp-go/docs/playtest-loop/)
- [Live-engine gotchas](https://regiellis.github.io/godot-mcp-go/docs/gotchas/)
- [MCP setup](https://regiellis.github.io/godot-mcp-go/docs/mcp-setup/)
- [Before shipping](https://regiellis.github.io/godot-mcp-go/docs/before-you-ship/)
- [Shipping and export](https://regiellis.github.io/godot-mcp-go/docs/guides/shipping-export/)
