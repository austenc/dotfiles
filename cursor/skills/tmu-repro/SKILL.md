---
name: tmu-repro
description: >-
  Set up a local TMU reproduction for a Linear bug: seed factory data on a
  Herd *.test site and give the user clickable links plus numbered browser
  steps. Use when the user says TMU repro, /tmu-repro, TMU-repro, or passes a
  TMU Linear issue ID (e.g. TMU-1584 or 1584) to reproduce locally. Distinct
  from tmu-error (file the bug) and tmu-issue (implement a draft PR).
---

# TMU Repro

Turn a filed TMU Linear bug into something the user can click on a **local** Herd site. Seed factory data if needed, then reply with links and **Do this** steps.

This is **not** `tmu-error` (triage Flare / file Linear) and **not** `tmu-issue` (branch, fix, PR). Do not implement the fix. Do not edit the Linear issue unless the user asks.

Issues usually come from `tmu-error`. The Linear “How to reproduce” is written without hosts or live IDs; this skill instantiates that on `.test`.

## Kickoff

Accept any of:

- Issue ID: `TMU-1584`
- Bare number: `1584` → treat as `TMU-1584`
- Linear URL containing that ID
- Short prompts like `tmu repro 1584` / `/tmu-repro` / `TMU-repro TMU-1584`

If no ID is given, ask for one. Do not browse assigned issues unless asked.

## Hard rules

- **Local only.** Default site is `http://bedrock.test`. Never hit production or staging TMU hosts (`*.tmutest.com`, `*.tmuniverse.com`, etc.).
- **HTTP, not HTTPS.** Local Herd usually has no SSL. Chat links must be `http://bedrock.test` (or `http://oregon.test`, etc.). Use `https://` on `.test` only when the bug itself requires SSL. If Boost `get-absolute-url` (or `APP_URL`) returns `https://`, rewrite it to `http://` unless that exception applies.
- **Factory records only.** Create new models with factories (tinker / artisan from the host app is OK). **Do not** update, delete, archive, merge, or otherwise mutate imported production rows.
- Destructive repro steps (delete a student, accept a score, etc.) are **for the user to click** on the factory records you created — do not perform those clicks/updates yourself unless the user asks.
- Do not put passwords, production PII, or Flare live IDs in chat.
- Local IDs and `*.test` URLs **belong in chat** (that is the point). They must **not** be written back into Linear.
- Do not change Linear workflow state, assignee, or the issue description.
- Do not branch, commit, or open a PR.

## Procedure

### 1. Fetch the issue

Linear MCP `get_issue` for the ID. Pull title, description (especially `### How to reproduce`), and any Flare link.

If the issue cannot be fetched, stop.

If “How to reproduce” is missing or looks like a guarded flash-and-redirect (not the 500), read the call site in `hdmaster/core` (same judgment as `tmu-error`) and do not send the user down the guarded path.

### 2. Pick the local site

| Situation | Site |
| --- | --- |
| Core / Bedrock feature | `http://bedrock.test` |
| Client-only screen (e.g. Oregon Activate Med Aide `/activate-student`) | That client’s local Herd `*.test` if it exists (e.g. `http://oregon.test`) |

The app is served by Laravel Herd. Do not run `php artisan serve`. You may use Boost `get-absolute-url` for path/host, then force `http://` as above.

If the feature does not exist on Bedrock and there is no local client app, say what is missing. Do not pretend Bedrock has Oregon-only routes.

Seed from the **host app** artisan (`/Users/austen/Code/bedrock` for Bedrock; `/Users/austen/Code/<client>` for a client), not by editing production-shaped rows in core’s git repo.

### 3. Seed (non-destructive)

Create the ordinary TMU records the Linear repro asks for: students, facility, attempts, attachments, etc.

- Use model factories. Tag or name factory people so they are obvious in the UI (e.g. last name `Repro1584`).
- Make them actually eligible for the click path (payments, training, started attempt, etc.) — same setup the Linear issue describes in domain language.
- Prefer screens the logged-in **admin** can reach. If the bug is student/facility-only, create that factory person and give an **impersonate** link (`/students/{id}/impersonate`, `/facilities/{id}/impersonate`, etc.).
- You may inspect with tinker. Do not tell the user to run tinker, DevTools, or `$wire`.

Do **not** add items to the user’s existing browser session (you cannot). Leave them a cart/list/impersonate path they can click.

### 4. Reply: links + Do this

Lead with the issue. Then the links. Then numbered clicks. Keep it short.

Use this shape:

```markdown
## TMU-1584 — {Linear title}

{one line: what should blow up}

Seeded **factory** records on {site} (not imported production rows).

**Open these**
- {label}: http://bedrock.test/...
- Impersonate facility: http://bedrock.test/facilities/{id}/impersonate

**Do this**
1. {click}
2. {click}
3. {click}

Expected: {the 500 or equivalent, in user-visible terms}.
```

Rules for **Do this**:

- Browser only: links, buttons, forms, address bar, Back/Forward, file dialogs, second tab.
- Use the factory records you just created (local IDs in the links are fine).
- Follow the Linear repro, with hosts and IDs filled in.
- No console, `$wire`, tinker, or curl.

## Example (shape only)

For a prepay-after-delete bug you might seed two factory students eligible to prepay under a factory facility, then:

**Open these**

- Facility: `http://bedrock.test/facilities/{id}`
- Impersonate facility: `http://bedrock.test/facilities/{id}/impersonate`
- Student A: `http://bedrock.test/students/{id}`
- Student B: `http://bedrock.test/students/{id}`

**Do this**

1. Impersonate the facility. On the students list, select those two students and mass-prepay into the cart.
2. Un-impersonate (or use a second admin tab). Open student B and **delete** that student (archive is not enough).
3. Back in the facility tab, continue to checkout (`/prepay`).

Expected: 500 calling `adas()` on null.

## Related

- `tmu-error` — file the Linear bug from Flare (generic repro, no local IDs).
- `tmu-issue` — implement that issue through a draft PR after the repro is confirmed.

## Non-goals

- Filing or rewriting Linear issues
- Implementing the fix
- Replaying production rows
- Quantity of extra tickets
- Confirming the 500 in the agent’s browser unless the user asks — this skill **sets up**; they click
