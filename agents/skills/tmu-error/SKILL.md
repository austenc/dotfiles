---
name: tmu-error
description: >-
  Triage TMU Flare errors, confirm a real browser repro on a local .test site,
  and file a quality Linear bug. Use when the user says TMU Error, /tmu-error,
  pastes a flareapp.io URL or Flare error/occurrence ID, or asks to pull recent
  Flare errors into Linear. Distinct from tmu-issue (implement an existing
  TMU-### through a draft PR).
---

# TMU Error

Turn production Flare noise into a small number of good Linear bugs. Prefer one well-understood issue over a pile of guesses.

This is **not** `tmu-issue` (implement a draft PR) and **not** `tmu-repro` (seed a local `.test` click path for an existing Linear bug). Do not branch, implement, or open a PR unless the user asks after filing.

## Kickoff

**With input** (one or more):

- Flare error URL (`https://flareapp.io/errors/{id}` or `…/latest`)
- Flare error ID or occurrence ID
- Exception class + message + enough stack/context to find the error

Triage those. File Linear only when the story is solid.

**With no input:** pull a few recent unresolved errors from **Flare Production**, summarize them in chat, and file Linear only for the ones that survive investigation. Default to **at most three** issues per run. Skip the rest with a one-line reason (noise, already filed, no user-facing repro).

Search Linear for the Flare error URL / ID before creating anything. Do not duplicate.

## Procedure

### 1. Load Flare

Prefer Flare MCP if it is authenticated. Otherwise use the Flare CLI if it is installed and logged in (`flare` on PATH, or a local checkout such as `/tmp/flare-cli/vendor/bin/flare`).

Production project id is **1790**. Do not use staging/HQ unless the user says so.

For each error, pull the **latest occurrence** (not just the grouping title). Read:

- Exception class and message
- Entry URL, handler, referer
- Livewire body: `calls`, `updates`, snapshot property names (not PII)
- Stack / view file
- App version / git hash when present

Grouped Flare errors can mix different messages. Use the occurrence that matches the title you are filing.

### 2. Read the code

Find the call site in `hdmaster/core` (and the client app only if the stack is client-specific). Explain **what is null / missing / invalid** and **which user action** reaches that render or request.

Pay attention to:

- Full page `mount()` vs a later Livewire update (`handleUpdate`, empty `calls` = `$refresh` / history)
- Guards that flash-and-redirect (those are **not** the 500)
- URL/history attributes that bypass clamping

If the first guessed click path hits a guard, keep looking. Do not publish that path as the bug.

### 3. Confirm on local `.test` only

Reproduce on a **local Herd `*.test` site** (e.g. `http://bedrock.test` — HTTP, not HTTPS, unless the bug requires SSL). Never hit production/staging TMU hosts. Never replay live student, event, or attachment rows from Flare.

- Create **new factory records** when you need data. Do not mutate imported production rows.
- Repro steps must be **clicks, forms, and browser chrome** (Back/Forward, address bar, file dialogs).
- **Never** put JavaScript console, DevTools, `$wire`, or tinker in Linear “How to reproduce”.
- Tinker is OK privately to seed or inspect local factory data — not as the reported repro.

If you cannot get a real browser 500 (or equivalent) on `.test`, **do not file**. Tell the user what you know and what is still missing.

### 4. File Linear

Team **TMU**, label **Bug**. Human title (what the user hits), not the exception class.

Description shape is **TMU-1579**. Copy the structure, not Bedrock IDs. Full template: [linear-issue.md](linear-issue.md).

Required:

- Open with the Flare error URL
- Quote the user-facing / Flare message
- What is wrong (where, why), in prose
- `### How to reproduce` — setup in ordinary TMU terms, then numbered **browser** steps anyone can follow on their own local `*.test` app
- Expected failure

Do **not** include: suggested fix, tests, acceptance criteria, console snippets, production URLs, live IDs, or PII (emails, SSNs, names from Flare).

Do **not** change Linear workflow state.

After filing, give the user the Linear URL(s) and a short chat summary. Local click setup for a filed issue is `tmu-repro` — do that in the same run only if they ask.

## What to skip

Unless the user insists: payment-provider 404s, QuickBooks/accounting noise, obvious bot/scanner traffic, and Flare groupings that are several unrelated `UrlGenerationException`s mashed together. Say you skipped them.

## Non-goals

- Implementing the fix (`tmu-issue` is that workflow)
- Seeding a local click path (`tmu-repro` is that workflow)
- Using production as a repro environment
- Quantity of Linear tickets
- Console-driven “repros”
