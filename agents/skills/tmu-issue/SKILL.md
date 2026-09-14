---
name: tmu-issue
description: >-
  Start TMU Linear work from an issue ID: fetch the TMU issue, create its git
  branch, implement the work, and open a draft PR into develop. Use when the
  user provides a TMU Linear issue ID (e.g. TMU-123), pastes a Linear URL, or
  asks to start/work on a TMU issue through to a draft PR.
---

# TMU issue → draft PR

On-demand workflow for TMU software. The user picks the issue and kicks it off with an ID (or URL).

## Kickoff

Accept any of:

- Issue ID: `TMU-123`
- Linear URL containing that ID
- Short prompts like "work on TMU-123" / "start TMU-123"

If no ID is given, ask for one. Do not browse assigned issues unless asked.

## Procedure

### 1. Fetch the issue

Use the Linear MCP `get_issue` with the issue ID.

Pull at least:

- identifier (e.g. `TMU-123`)
- title
- description / acceptance criteria
- **git branch name** from Linear

If the issue cannot be fetched, stop and tell the user.

### 2. Branch from `develop`

1. Ensure the working tree is clean enough to branch (stash or ask if dirty with unrelated changes).
2. Fetch and checkout `develop`, then pull latest.
3. Create and checkout the branch name **exactly as Linear provides** (do not invent a different name).

```bash
git fetch origin
git checkout develop
git pull origin develop
git checkout -b <linear-branch-name>
```

If the branch already exists locally or remotely, check it out / track it instead of recreating.

### 3. Implement the issue

- Use the Linear title + description as the source of truth for scope.
- Prefer the smallest change that satisfies the issue.
- Follow TMU / project conventions already in the repo.
- Run relevant checks/tests when the project has an obvious command.

Keep iterating with the user if requirements are ambiguous; do not invent product behavior.

### 3b. UI screenshots (when applicable)

When the work changes anything the user sees in the app — including Blade views, Livewire components, layouts, copy, flows, or other UI — capture browser screenshots and put them in **both** this Cursor chat **and** the GitHub PR description.

**When to capture**

- After edits to Blade views, Livewire components, or other UI-facing code.
- After the change is visible on local Bedrock.
- Before **and** after when a single after shot would be hard to judge.
- Skip for pure backend / non-UI work with no Blade, Livewire, or visual surface changes.

**Where they go**

- **Cursor chat** (required). The user must see the images in the final reply.
- **GitHub PR description** (required). Add a `## Screenshots` section and upload the files with `gh pr create` / `gh pr edit` `--attach` so they render on GitHub.
- Do **not** write screenshots into the project tree (no `.cursor-tmp/`, no PNGs under the workspace, nothing to commit).
- Do **not** put screenshots in Linear.

**Storage (outside the repo)**

1. Save under `~/.cursor/tmp/screenshots/` (create it if missing).
2. Use descriptive filenames: `<topic>-<state>.png` (e.g. `cut-score-empirical.png`, `facility-login-after.png`).
3. Treat files as ephemeral — never commit them.

**Required embedding pattern (so images render in chat)**

Browser `browser_take_screenshot` / Read-on-image may attach in the tool turn, but **final user-facing replies must still include Markdown with an absolute filesystem path** so the image is visible in the message itself.

Verified Cursor chat Markdown behavior:

| Source | Renders in chat? |
|--------|------------------|
| Absolute path: `![alt](/Users/…/shot.png)` | **Yes** |
| Relative workspace path: `![alt](.cursor-tmp/shot.png)` | No |
| `file://` URI: `![alt](file:///Users/…/shot.png)` | No |
| Public `https://…` URL | Yes (optional fallback only; prefer local absolute paths) |

After capturing, copy/save to the user-level dir, then in the assistant reply use **only** this form:

```markdown
![Short label](/Users/austen/.cursor/tmp/screenshots/<name>.png)
```

Never use relative paths or `file://` URIs for chat embeds.

**How**

1. Use the Cursor browser against local Bedrock at `http://bedrock.test` (start the app if it is not already running).
2. Navigate to the affected screen(s).
3. Take screenshot(s) with the browser screenshot tool.
4. Save/copy each shot into `~/.cursor/tmp/screenshots/` with a descriptive name.
5. In the **final reply**, embed each image with the absolute-path Markdown pattern above (do not only describe them in text).
6. When opening or updating the PR, attach the same files with `gh --attach` and reference those local paths under `## Screenshots` so GitHub rewrites them to uploaded asset URLs (see step 4). Requires `gh` 2.99+.
7. Prefer the account that matches the feature (admin or `ACameron` when that is the right user). Do **not** put passwords in this skill, commits, PRs, or chat logs.

**Auth (no secrets in the skill)**

1. Prefer asking the user to log in once in the Cursor browser (Take Control / unlock, sign in, then hand control back). Reuse that session for the rest of the run.
2. If local env vars for UI login already exist outside the skill (e.g. shell or gitignored env), the agent may use those — never invent or hardcode credentials here.
3. Do not assume the user’s default-browser session is available to Cursor’s browser; cookies usually do not transfer.
4. If login is blocked and the user is unavailable, say screenshots were skipped and continue — omit `## Screenshots` from the PR rather than leaving placeholders.

### 4. Open a draft PR into `develop`

When the work is ready (or the user asks for the PR):

1. **Update the changelog** before opening the PR.
2. Commit with a clear message tied to the issue (include the changelog update in the same commit or a small follow-up commit — match repo habit if obvious).
3. Push the branch with `-u`.
4. Create a **draft** PR targeting `develop`.

**Changelog**

- Edit the project changelog (for Bedrock / TMU this is typically `core/changelog.md`).
- Add **one succinct line** under `## [Unreleased]` (create that section if missing).
- Reference the Linear issue ID at the end of the line.
- Match the tone and style of nearby entries — read a few recent ones first rather than inventing a format.

Examples of the existing style:

```markdown
- Add `observers.manage-duplicates` route - TMU-1566
- Fix instructor training program selection on training form to exclude facilities without an active license - TMU-1554
```

**No tool attribution.** Never add "Made with Cursor", Cursor links, AI watermarks, co-authored-by Cursor trailers, or similar branding in commit messages, PR titles, PR bodies, or PR/issue comments. Keep GitHub text clean and human.

**PR title format** (exact):

```text
<ISSUE-ID> | <issue title>
```

Example: `TMU-123 | Add export button to reports`

**PR body** should include:

- Short summary of what changed
- Screenshots of UI changes (when applicable — see 3b)
- Testing This PR checklist

Do **not** add a Linear heading, issue link section, “see chat” notes, or other Linear boilerplate in the PR body — GitHub ↔ Linear linking is handled automatically via the branch name / integration.

For UI work, include `## Screenshots` with local image paths and pass those files to `--attach` so `gh` uploads them. Requires `gh` 2.99+.

Example:

```bash
gh pr create --draft --base develop --title "TMU-123 | Add export button to reports" --body "$(cat <<'EOF'
## Summary
- <bullet points>

## Screenshots
![After](/Users/austen/.cursor/tmp/screenshots/export-button-after.png)

## Testing This PR
- [ ] <checks>
EOF
)" \
  --attach '/Users/austen/.cursor/tmp/screenshots/export-button-after.png#After'
```

Skip `## Screenshots` and `--attach` when there are no UI screenshots.

### 5. Linear status

Do **not** update Linear issue status. GitHub ↔ Linear handles that.

After the PR exists, give the user the PR URL.

## Non-goals

- Picking which issue to work on
- Changing Linear workflow state
- Merging the PR
- Force-pushing or rewriting shared history
- Adding Cursor / AI attribution or watermarks anywhere on GitHub
- Writing screenshot files into the project workspace

## Iteration notes

This skill is intentionally thin on implementation style so it can be refined over time. Prefer updating this file when conventions stabilize (commit message pattern, PR template, test commands, etc.).
