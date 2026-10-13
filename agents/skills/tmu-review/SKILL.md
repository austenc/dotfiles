---
name: tmu-review
description: >-
  Review a TMU pull request for coding standards, Linear-issue fit, and
  oversights, then give the user a paste-ready brief: what to do, which
  lines to comment on, and the comment text. Post on GitHub only after
  the user confirms. Use when the user asks to review a TMU PR, passes a
  TMU Linear issue ID (e.g. TMU-123), a Linear URL, a GitHub PR URL, or
  says /tmu-review.
---

# TMU PR review

On-demand review workflow for TMU PRs. Prefer a Linear issue ID; fall back to a GitHub PR URL when there is no Linear issue.

PRs may target **core** (`hdmastr/core`) **or a state/client application** (e.g. missouri, ohio, mass-cna). Linear is the guide: the issue usually links the GitHub PR. Do not assume core.

Give the user a review they can paste onto the PR themselves. Tell them which GitHub action to take, which lines to comment on, and the exact text for each comment. Do not post, approve, or request changes on GitHub during the review. After the brief, ask if they want those comments posted, and wait.

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

If the PR body asks a question, answer it in the summary comment.

### 4. How to read the diff

Go in this order, and stop adding comments once the next note would not change a merge decision or teach a house convention:

1. Claim versus diff. Does the change do what the Linear issue or PR says, including the parts that are easy to miss (redirects for a renamed URL, both sides of a config flag, empty states)?
2. Behavior. Would this still be right for the real domain rule, not just the happy path on the ticket?
3. Tests. Would they fail for the bug, and do the names say what happened?
4. Names, nearby code, and UI wording.
5. Data changes: migrations, queries, jobs, notifications.
6. Only then, small consistency nits that match an existing convention.

Skip formatting Pint or the existing style already allows. Prefer a few precise comments over a tour of the file.

### 5. What to look for

Read `/Users/austen/Code/bedrock/core/AGENTS.md` for the sections that match the files in the diff. Then comb for the things that show up again and again in core reviews:

**Behavior and domain**

- A refactor that is not equivalent: null versus boolean, a dropped `?`, a condition that used to be narrower.
- Bulk `update()` / `where()->update()` that no longer fires model events the old `find()` + `save()` path did.
- Domain rules flattened into one case (more than one fee per attempt, config on and off, date boundaries, contractual reports).
- Authorization on the Livewire action or route, not only the button that links to it.
- A class, view, or route states override: will existing client overrides still behave?

**Tests**

- Names describe the behavior: `test_observer_cannot_edit_payout_comments`. `cannot` is one word. The method name matches the file’s subject.
- Happy and sad paths. When the change is behind config, cover the flag on and off.
- A bugfix gets a test that would have failed before the fix, when that is practical.
- The actor who must be denied is tested, not only the actor who is allowed.
- Unrelated tests are not rewritten or removed in passing.
- A new test file needs a reason. A portal or account surface can have its own test; a single extra case usually belongs in the existing test.

**Naming**

- New names are guessable and unabbreviated. Prefer active tense (`default_approval_message`).
- Date columns use `_at` unless that table already uses another suffix.
- Don’t prefix a column with the table’s own noun (`facility_citations.end_at`).
- Config keys match their env names and the keys beside them.
- New “event” names say `testevent`. A bare `event` collides with Laravel’s events and with older names in this app.
- Artisan signatures stay in the `core:` family when nearby commands do.
- Root aliases (`use \Student;`), including Livewire routes, so a state can override the class without overriding the route.

**Views, copy, and Livewire**

- UI-kit props and variants that actually exist. An invented prop will render nothing useful.
- Slot tags use the shorthand that matches at both ends: `<x-slot:trigger>` … `</x-slot:trigger>`. Component attributes are kebab-case (`:label-help-text`), except the `:$prop` shorthand.
- Reuse an existing cell, button, icon, badge, or mail table component before adding a one-off.
- Wording a non-technical user will understand, including what will happen next (“this note is sent to the applicant”).
- Primary actions sit where the rest of the app puts them (the end of the row).
- Livewire: `notify()` when that is the local pattern, instead of flash plus redirect; computed properties instead of serializing a large option list into the component tag; `:key` in loops; a unique form `id`; typehinted optional models.
- `use Illuminate\Support\Carbon`, not the Carbon package class.
- Unused imports inside Blade. Pint does not catch those.
- `@js` when a value is crossing into Alpine or JavaScript, so numbers and strings are encoded.

**Shape of the change**

- The smallest change that solves the issue. A halfway split (one new route file with two routes, a new namespace used once) belongs in its own PR or should be folded back into the caller.
- Co-locate a one-off export or helper on the component that uses it.
- Share methods between a Livewire class and a Volt component with a trait when they are actually the same.
- Destructive migrations (drop or rename) stay separable from the feature so a revert still has the old data.
- A new column’s default belongs on the schema, not only in a seeder.
- Queries should stay equivalent, and an “optimization” should not drop eager loads the screen still needs.
- A rename that missed a call site, a leftover comment that doesn’t help, or debug output, secrets, or tooling attribution left in the diff or PR text.

**Changelog**

- User-facing or notable changes get a line under `## [Unreleased]` in that repo’s `changelog.md`, with the Linear ID when there is one.
- Lead with a clear verb: added, changed, fixed, updated, removed. Say what the user can do now.
- A missing or vague line is a note, not a merge block, unless the entry would mislead someone cutting a release.

### 6. Intent

Using the Linear description + comments (or PR body if no issue):

- Does the diff address the stated problem / acceptance criteria?
- Anything in the issue comments that the PR ignores or contradicts?
- Scope that should be its own PR, versus a drive-by that is already done and harmless?
- For **client** PRs: is this a client override, config, or state-specific behavior, or does it belong in core?

### 7. Voice

The suggested summary and inline comments should sound like a teammate who read the diff carefully and wants the author to succeed. Direct and kind at the same time.

Write each inline comment in this order: the observation, why it matters, then a concrete suggestion when you have one. One issue per comment. Ask when the diff does not show the reason; don’t turn a question into a verdict.

Use the author’s name only if you are replying to something they asked. “We” is for the codebase. “Could we…” and “I think…” are for preferences. Say plainly when something is optional and the PR can merge without it.

Do not write sarcasm, teasing, hype, or a verdict about the author. Skip emoji, “send it”, “shame”, “slop”, “bad”, and openers like “you should have” or “you didn’t”. Don’t stack rhetorical questions. Don’t apologize for reviewing.

A house convention can be stated once, with the reason (matching slot tags, Carbon’s support class, `testevent`). Call something a personal preference when it is one, and mark it optional.

Good shapes:

```markdown
This looks good. The filter matches the issue, and the tests cover the on and off cases.

I left two optional notes on naming. Neither needs to change before merge.
```

```markdown
This is close. The dialog copy is clear, and the happy path works.

Before we merge, could we add a test for the config-off case and switch that slot to `<x-slot:trigger>` so the end tag matches? I left those on the diff. The other notes are optional.
```

```markdown
Could we use a regular ternary here instead of the spread operators? I think that would be easier to follow.
```

```markdown
I don't think these buttons have an `outline` property. The UI kit has an outline variant — could we use that so the style actually applies?
```

Use a GitHub suggestion block only when the replacement is complete and you are confident it is equivalent. If you are not sure it works, say so and skip the block.

### 8. Brief for the user

Respond in chat only. Do **not** post GitHub or Linear comments, submit a review, approve, request changes, merge, or change Linear status in this step.

Lead with what the user should do on GitHub, then the text they can paste. Put each paste target in its own fenced block so a click copies one comment and nothing else. Quote the line (or the nearest method or heading, when the note is about something missing) so they can find it on the diff. Use the new-file line number from the diff when that line is part of the change.

Use this structure. Each comment sits in its own fence so it can be copied on its own:

````markdown
## What to do
**Approve** | **Approve with nits** | **Request changes**

One sentence on why, for the user. Say that nothing has been posted.

## Paste as the review summary

```
The summary comment, ready to paste.
```

## Lines to comment on

### 1. Before merge — `path/to/file.php:42`

```
the line or snippet to anchor on
```

```
The comment to paste on that line.
```

### 2. Optional — `path/to/other.php` near `methodName`

```
The comment to paste. This note is optional; the PR can merge without it.
```

## For you

### Standards
Brief note on AGENTS.md / local convention fit.

### Intent
How well the PR matches the Linear issue (or PR description). Cite acceptance criteria that are met or missed.
````

Skip "Lines to comment on" when there is nothing worth pasting. Skip a "For you" subsection when it would only repeat the summary.

End the response by asking whether to post this review. Wait for a yes. Do not treat the original review request as that yes.

**What to do:**

- **Approve** — solves the intended problem, and there is nothing worth commenting. The summary can be a short approval note, and there is no line list.
- **Approve with nits** — only optional notes or questions. The summary says the PR can merge without those changes. Tell the user to approve, and to paste the line notes as comments.
- **Request changes** — a likely bug, a missed acceptance criterion, a broken convention the repo actually keeps (aliases, slot tags, Carbon import, `testevent` naming, UI-kit API), a missing test on important or contractual behavior, a destructive migration mixed into the feature, a failed relevant check, or a state-override hazard.

Style nits, changelog wording, and stated preferences are optional unless they change behavior or user-facing meaning. Do not recommend requesting changes for a pile of optional notes.

### 9. Posting after confirmation

Post only after the user confirms in a later message. Post the summary and the line comments they kept. If they name a verdict, use it; if they only say to comment, submit a comment review and do not approve or request changes.

Anchor each inline comment to the diff's latest commit, path, and line. When a note cannot be attached to a diff line, include it in the review body instead of dropping it. Do not change Linear state, merge, or dismiss other reviews.

## Non-goals

- Implementing fixes (unless the user asks after the review)
- Posting the review to GitHub or Linear before the user confirms
- Changing Linear workflow state
- Merging or dismissing other reviews
- Browsing the PR queue for something to review
- Adding Cursor / AI attribution anywhere

## Iteration notes

Voice and the review lens came from Austen’s reviews on `hdmastr/core`: short summaries, line-level comments, suggestion blocks when the fix is obvious, and a hard look at naming, tests, equivalence, and UI consistency. Keep the paste-ready comments kind even when an older review was sharper. The brief is for the user to paste; posting waits for a later confirmation. Prefer updating this file when a new house convention shows up repeatedly.
