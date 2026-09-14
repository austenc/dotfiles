---
name: tmu-review
description: >-
  Review a TMU pull request for coding standards, Linear-issue fit, and
  oversights; return approve or request-changes with a draft PR comment. Use
  when the user asks to review a TMU PR, passes a TMU Linear issue ID
  (e.g. TMU-123), a Linear URL, a GitHub PR URL, or says /tmu-review.
---

# TMU PR review

On-demand review workflow for TMU PRs. Prefer a Linear issue ID; fall back to a GitHub PR URL when there is no Linear issue.

PRs may target **core** (`hdmastr/core`) **or a state/client application** (e.g. missouri, ohio, mass-cna). Linear is the guide: the issue usually links the GitHub PR. Do not assume core.

## Kickoff

Accept any of:

- Issue ID: `TMU-123` (or bare number `123` → treat as `TMU-123`) — **preferred**
- Linear URL containing that ID
- GitHub PR URL (core or client repo)
- Short prompts like `review TMU-123` / `/tmu-review` + ID or URL

If neither an issue ID nor a PR URL is given, ask for one. Do not browse open PRs or assigned issues unless asked.

## Procedure

### 1. Resolve the PR (Linear first when available)

**From Linear issue (preferred):**

1. Linear MCP `get_issue` for the ID — pull identifier, title, description / acceptance criteria, branch name, attachments/links, and comments (`list_comments` if needed).
2. Find the GitHub PR URL from the issue — **do not assume `hdmastr/core`**:
   - Prefer an explicit GitHub PR link in the description, attachments, or comments (most reliable for client apps).
   - Else use Linear’s git branch name with `gh pr list` — try the repo implied by the issue (project/label/title/client name) before falling back to core.
   - Last resort search: `gh search prs "TMU-123" --owner hdmastr --state open` (or org-wide search) and pick the matching open PR.
3. If multiple PRs match, prefer the open one targeting `develop`. If still ambiguous, ask the user.
4. If no PR exists, stop and say so — do not invent a review from the issue alone.

**From GitHub PR URL:**

1. Parse owner/repo/number from the URL (may be core or a client app).
2. Load the PR with `gh pr view <n> --repo <owner>/<repo> --json title,body,baseRefName,headRefName,files,commits,author,state,url,labels`.
3. If the title/body/branch mentions `TMU-\d+`, fetch that Linear issue + comments as context. If none, review from the PR description alone.

### 2. Move into the PR’s repo

After the PR repo is known, call `move_agent_to_root` on the matching local checkout **before** substantive review:

| GitHub repo (typical) | Local path |
| --- | --- |
| `hdmastr/core` | `/Users/austen/Code/bedrock/core` |
| `hdmastr/<client>` (state/client app) | `/Users/austen/Code/<client>` |

Examples: missouri → `~/Code/missouri`, ohio → `~/Code/ohio`. If the local folder is missing or the name does not match, ask rather than guessing.

Shared standards still live in core — always read `/Users/austen/Code/bedrock/core/AGENTS.md` (and Boost under `resources/boost/`) even when reviewing a client PR. For client overrides, also follow patterns in that app (sibling files, existing override style).

### 3. Load the diff and context

Use the **resolved** owner/repo (not hard-coded core):

```bash
gh pr view <n> --repo <owner>/<repo>
gh pr diff <n> --repo <owner>/<repo>
gh pr checks <n> --repo <owner>/<repo>
```

Also skim existing PR review comments / conversation when relevant:

```bash
gh api repos/<owner>/<repo>/pulls/<n>/comments
gh api repos/<owner>/<repo>/issues/<n>/comments
```

Do **not** check out the PR branch unless you need to run tests or inspect files that `gh pr diff` cannot show clearly. Prefer read-only review via `gh` when possible. If the working tree is dirty with unrelated work, do not stash or switch branches without asking.

### 4. Standards checklist

Read and apply:

1. `/Users/austen/Code/bedrock/core/AGENTS.md` (Laravel Boost + project guidelines) — skim sections relevant to the changed files; applies to core and client PRs.
2. Sibling / nearby code in the **PR repo** (naming, structure, Livewire/Volt style, root aliases, client override patterns).
3. Changelog expectation: user-facing or notable fixes/features usually get a line under `## [Unreleased]` in that repo’s `changelog.md` (core: often `changelog.md` at repo root of the package / app) referencing the Linear ID when one exists.

Pay special attention to TMU / core conventions called out in `AGENTS.md`, including:

- Root aliases for core classes (`use \Student;`, not `Hdmaster\Core\...` unless intentionally overriding in a client)
- Client overrides that correctly extend/replace core without breaking alias swaps
- Existing directory structure and reuse of components
- PHP / Laravel / Livewire / Volt / Pint norms for this stack
- Tests when behavior changes in a testable way

Do not nitpick formatting that Pint or existing style already allows. Focus on correctness, convention mismatches, missing edge cases, and whether the change is the smallest reasonable fix.

### 5. Intent checklist (Linear or PR body)

Using the Linear description + comments (or PR body if no issue):

- Does the diff address the stated problem / acceptance criteria?
- Anything in the issue comments that the PR ignores or contradicts?
- Scope creep or unrelated changes that should be split out?
- Missing pieces: changelog, tests, migrations, permissions/policies, client-override implications, copy/UI gaps?
- For **client** PRs: is this correctly a client-only change (override / config / state-specific behavior) rather than something that belongs in core — or vice versa?

### 6. Oversights pass

Look for:

- Broken or incomplete paths (dead code left behind, half-renames)
- Authz / tenancy / facility-scoping mistakes common in TMU apps
- Client overrides that miss a required parent method, view, or route still served from core
- Migrations without a safe rollback story or destructive changes
- UI changes without obvious manual test notes
- CI failures on the PR (`gh pr checks`)
- Secrets, debug leftover, or tooling attribution in PR text

### 7. Verdict and output

Respond in chat only. Do **not** post GitHub or Linear comments, approve/request-changes on GitHub, merge, or change Linear status unless the user explicitly asks.

Use this structure:

```markdown
## Verdict
**Approve** | **Request changes**

## Summary
1–3 sentences: what the PR does and whether it solves the intended problem.

## Findings
### Blocking
- …

### Non-blocking
- …

(If none in a section, write "None.")

## Standards
Brief note on AGENTS.md / Boost / local convention fit (or specific misses).

## Intent
How well the PR matches the Linear issue (or PR description if no issue). Cite acceptance criteria that are met or missed.

## Suggested comment
A short paragraph the user could paste as a PR review comment. Tone: collegial, specific, no AI/tool attribution. Match the verdict — approval note or clear change requests.
```

**Verdict rules:**

- **Approve** — solves the intended problem; no blocking convention or correctness issues. Non-blocking nits are OK.
- **Request changes** — missing acceptance criteria, likely bug, clear AGENTS.md/convention violation, failed relevant checks, or other merge-blocking gaps.

Keep findings actionable (file/area + why). Prefer fewer high-signal notes over exhaustive style commentary.

## Non-goals

- Implementing fixes (unless the user asks after the review)
- Posting the review to GitHub or Linear without an explicit ask
- Changing Linear workflow state
- Merging or dismissing other reviews
- Browsing the PR queue for something to review
- Adding Cursor / AI attribution anywhere

## Iteration notes

This skill is intentionally thin so it can be refined. Prefer updating this file when review norms stabilize (required CI, changelog strictness, Linear→PR link conventions, client repo naming under `~/Code/`, etc.).
