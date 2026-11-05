---
name: tmu-review
description: Review a TMU pull request for coding standards, Linear-issue fit, and oversights, then give the user a readable brief plus an exported Markdown draft they paste into GitHub themselves. Never posts to GitHub. Use when the user asks to review a TMU PR, passes a TMU Linear issue ID (e.g. TMU-123), a Linear URL, a GitHub PR URL, or says /tmu-review.
---

# TMU PR review

On-demand review workflow for TMU PRs. Prefer a Linear issue ID; fall back to a GitHub PR URL when there is no Linear issue.

PRs may target **core** (`hdmastr/core`) **or a state/client application** (e.g. missouri, ohio, mass-cna). Linear is the guide: the issue usually links the GitHub PR. Do not assume core.

The output is a draft for Austen to review and post by hand. **Never post, comment, approve, request changes, or react on GitHub or Linear — and don't offer to.** Don't end with "want me to post this?". Austen does all reviews manually.

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
   - Else use Linear's git branch name with `gh pr list` — try the repo implied by the issue (project/label/title/client name) before falling back to core.
   - Last resort search: `gh search prs "TMU-123" --owner hdmastr --state open` (or org-wide search) and pick the matching open PR.
3. If multiple PRs match, prefer the open one targeting `develop`. If still ambiguous, ask the user.
4. If no PR exists, stop and say so — do not invent a review from the issue alone.

**From GitHub PR URL:**

1. Parse owner/repo/number from the URL (may be core or a client app).
2. Load the PR with `gh pr view <n> --repo <owner>/<repo> --json title,body,baseRefName,headRefName,files,commits,author,state,url,labels`.
3. If the title/body/branch mentions `TMU-\d+`, fetch that Linear issue + comments as context. If none, review from the PR description alone.

### 2. Move into the PR's repo

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

Also skim existing PR review comments / conversation when relevant, so you don't repeat a note someone already left:

```bash
gh api repos/<owner>/<repo>/pulls/<n>/comments
gh api repos/<owner>/<repo>/issues/<n>/comments
gh api repos/<owner>/<repo>/pulls/<n>/reviews
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
- A class, view, or route states override: will existing client overrides still behave? Removed config keys that a state may still set.

**Tests**

- Names describe the behavior: `test_observer_cannot_edit_payout_comments`. `cannot` is one word. The method name matches the file's subject.
- Happy and sad paths. When the change is behind config or an option, cover it on and off.
- A bugfix gets a test that would have failed before the fix, when that is practical.
- The actor who must be denied is tested, not only the actor who is allowed.
- Unrelated tests are not rewritten or removed in passing.
- A new test file needs a reason. A portal or account surface can have its own test; a single extra case usually belongs in the existing test.

**Naming**

- New names are guessable and unabbreviated. Prefer active tense (`default_approval_message`).
- Date columns use `_at` unless that table already uses another suffix.
- Don't prefix a column with the table's own noun (`facility_citations.end_at`).
- Config keys match their env names and the keys beside them.
- New "event" names say `testevent`. A bare `event` collides with Laravel's events and with older names in this app.
- Artisan signatures stay in the `core:` family when nearby commands do.
- Root aliases (`use \Student;`), including Livewire routes, so a state can override the class without overriding the route.

**Views, copy, and Livewire**

- UI-kit props and variants that actually exist. An invented prop will render nothing useful.
- Slot tags use the shorthand that matches at both ends: `<x-slot:trigger>` … `</x-slot:trigger>`. Component attributes are kebab-case (`:label-help-text`), except the `:$prop` shorthand.
- Reuse an existing cell, button, icon, badge, or mail table component before adding a one-off.
- Wording a non-technical user will understand, including what will happen next ("this note is sent to the applicant").
- Primary actions sit where the rest of the app puts them (the end of the row).
- Livewire: `notify()` when that is the local pattern, instead of flash plus redirect; computed properties instead of serializing a large option list into the component tag; `:key` in loops; a unique form `id`; typehinted optional models.
- `use Illuminate\Support\Carbon`, not the Carbon package class.
- Unused imports or variables inside Blade. Pint does not catch those.
- `@js` when a value is crossing into Alpine or JavaScript, so numbers and strings are encoded.

**Shape of the change**

- The smallest change that solves the issue. A halfway split (one new route file with two routes, a new namespace used once) belongs in its own PR or should be folded back into the caller.
- Co-locate a one-off export or helper on the component that uses it.
- Share methods between a Livewire class and a Volt component with a trait when they are actually the same.
- Destructive migrations (drop or rename) stay separable from the feature so a revert still has the old data.
- A new column's default belongs on the schema, not only in a seeder.
- Queries should stay equivalent, and an "optimization" should not drop eager loads the screen still needs.
- A rename that missed a call site, a leftover comment that doesn't help, or debug output, secrets, or tooling attribution left in the diff or PR text.

**Changelog**

- User-facing or notable changes get a line under `## [Unreleased]` in that repo's `changelog.md`, with the Linear ID when there is one.
- Lead with a clear verb: added, changed, fixed, updated, removed. Say what the user can do now.
- A missing or vague line is a note, not a merge block, unless the entry would mislead someone cutting a release.

### 6. Intent

Using the Linear description + comments (or PR body if no issue):

- Does the diff address the stated problem / acceptance criteria?
- Anything in the issue comments that the PR ignores or contradicts?
- Scope that should be its own PR, versus a drive-by that is already done and harmless?
- For **client** PRs: is this a client override, config, or state-specific behavior, or does it belong in core?

### 7. Voice — write like Austen

Comments should read like Austen typed them between meetings: short, casual, curious, and generous. Not like a linter, and not like a formal code-review template. The goal is that the author fixes the thing *and* feels good about it, so lean on the "How to Win Friends and Influence People" moves:

- **Start with honest, specific praise** when there's something real to praise ("Nice tests, great feature addition!", "This will be really nice to have when investigating!"). Never invent it.
- **Ask instead of tell.** Most notes should be questions that let the author reach the fix themselves and save face if they already had a reason. Questions are the default; statements are for clear-cut house conventions or actual bugs.
- **Point at the code, not the person.** "This looks like it's missing a `?`" — not "you missed a `?`".
- **Assume there was a reason.** "Curious why…" and "Any reason…" leave room for "oh, because X" without anyone being wrong.
- **Offer help** when something is fiddly ("I didn't fully investigate but I can if you'd like.", "Maybe we can link up and talk about it?").
- **Make the bar clear.** Say plainly when something is optional ("Not that it really matters, but…", "Not worried about it…") versus when it should change before merge.

Openers Austen actually uses — rotate them, don't use the same one twice in a row:

- "Curious why …?"
- "Any reason you chose … instead of …?"
- "Do we need … anymore?"
- "Does this `$roles` variable get used in the view?"
- "Could we … instead?" / "Couldn't we just …?"
- "Maybe … would be nice?"
- "I think we should …" / "I think we could …"
- "Should we be using … here?"
- "I'm not finding … in [the docs](…)? … Are you sure this is working as intended?"
- "Not that it really matters, but …"
- "Probably can remove this comment, it's not overly useful?"

Style:

- Short. One to three sentences per inline comment is typical. One issue per comment.
- Casual punctuation is fine: an ellipsis for a trailing thought, a "hmm", a single 🤔 on a genuine head-scratcher. Keep it to one per review.
- When a convention needs a reason, give it once, briefly ("…because it's easier to see which end tag matches which start tag").
- Link docs when you cite them. Include a GitHub `suggestion` block only when the replacement is complete and you're confident it's equivalent.
- Summary: one or two short paragraphs, or praise + a short bulleted list when there are several before-merge items. End light: "Otherwise, looks good!", "Thanks for doing this!", "Couple comments you'll want to look at."
- If the change is contractual or high-stakes (Pass/Fail, payouts, certifications), say why confidence matters ("Pass/Fail is such an important (contractually!) report that we should be super confident before we ship this.").

Never: sarcasm, teasing, "slop", "vibe-coded", "bad", "shame", "send it", "you should have", "you didn't", stacked rhetorical questions, verdicts about the author, apologies for reviewing, or hype.

Real examples to calibrate against:

```markdown
Curious why you didn't use `->notify()` here? I was surprised to see the flash + redirect combo.
```

```markdown
I don't think there's an `outline` property on the buttons in the UI kit. There's an outline _variant_ though — could we use that so the style actually applies?
```

```markdown
Think we should prefer the shorthand for the slot tag syntax:

`<x-slot:trigger>` … `</x-slot:trigger>`

It's easier to see which end tag matches which start tag that way.
```

```markdown
This looks great, but I think we should make it more clear in the denial dialog that this message will be sent to the applicant. Some wording to explain that is enough!
```

```markdown
Approving this, but I'm curious why you chose to make a new test file for InstructorStudentsTest? Typically I'd have put that right into InstructorTest... but I've also thought we should maybe have "InstructorPortalTest" or similar. Curious what you think.
```

### 8. Brief for the user

Respond in chat **and** write an export file. Do not post anything anywhere.

#### Writing comments so they're readable and pasteable

- Write each comment as normal Markdown paragraphs. Put a blank line between thoughts; never hard-wrap mid-sentence (GitHub renders single newlines as line breaks).
- Use inline backticks for code names and fenced blocks only for actual code or `suggestion` blocks.

#### Export file (the paste source)

Write the full review to `~/.cursor/tmu-reviews/<repo>-<number>.md` (e.g. `~/.cursor/tmu-reviews/core-2962.md`), overwriting any previous draft for that PR, then open it with `cursor-app-control` → `open_resource` (`file:///Users/austen/.cursor/tmu-reviews/<repo>-<number>.md`). Austen copies from this file (raw or preview) into GitHub as a starting point.

Structure of the export file:

````markdown
# Review draft: <owner>/<repo>#<n> — <PR title>

<PR URL> · Linear: <TMU-123 link or "none">

**Suggested action:** Approve | Approve with nits | Request changes

---

## Summary comment

<summary text as plain Markdown — this is what gets pasted>

---

## 1. Before merge — `path/to/file.php:42`

```php
the line or snippet to anchor on
```

<comment text as plain Markdown>

---

## 2. Optional — `path/to/other.blade.php` near `methodName`

<comment text>
````

Each comment's text sits directly under its anchor as plain Markdown (not inside a fence), so it reads naturally in preview and pastes into GitHub with formatting intact.

#### Chat response

Keep the chat readable at a glance. Use this structure:

```markdown
## Suggested action: **Request changes**

One or two sentences on why, for Austen. Mention the export file path.

## Summary comment

> Summary text as a blockquote (wraps nicely in chat).

## Line comments

### 1. Before merge · `src/Reports/PassFail.php:120`
`anchor line` (inline code; a short fenced block if it's multi-line code)

> Comment text as a blockquote, short paragraphs.

### 2. Optional · `resources/views/.../generate.blade.php:88`
…

## For you

**Standards:** brief note on AGENTS.md / local convention fit.

**Intent:** how well the PR matches the Linear issue (or PR description) — acceptance criteria met or missed.
```

Skip "Line comments" when there's nothing worth commenting. Skip a "For you" subsection when it would only repeat the summary. End after "For you" — no offer to post.

**Suggested action:**

- **Approve** — solves the intended problem, and there is nothing worth commenting. The summary can be a short approval note ("Looks good!", "This looks good and works as advertised! Thanks for fixing it!").
- **Approve with nits** — only optional notes or questions. The summary says the PR can merge without those changes.
- **Request changes** — a likely bug, a missed acceptance criterion, a broken convention the repo actually keeps (aliases, slot tags, Carbon import, `testevent` naming, UI-kit API), a missing test on important or contractual behavior, a destructive migration mixed into the feature, a failed relevant check, or a state-override hazard.

Style nits, changelog wording, and stated preferences are optional unless they change behavior or user-facing meaning. Do not recommend requesting changes for a pile of optional notes.

## Non-goals

- Posting, commenting, approving, requesting changes, or reacting on GitHub or Linear — ever, and offering to do so
- Implementing fixes (unless the user asks after the review)
- Changing Linear workflow state
- Merging or dismissing other reviews
- Browsing the PR queue for something to review
- Adding Cursor / AI attribution anywhere

## Iteration notes

Voice and the review lens came from Austen's own comments on `hdmastr/core`: short summaries, question-first line comments, suggestion blocks when the fix is obvious, and a hard look at naming, tests, equivalence, and UI consistency. When an older comment of his was sharper than it needed to be, keep the curiosity and drop the edge. Prefer updating this file when a new house convention shows up repeatedly.
