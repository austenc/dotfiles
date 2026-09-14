# Linear issue format (TMU Error)

Gold standard: [TMU-1579](https://linear.app/headmaster/issue/TMU-1579/knowledge-test-back-button-error).

Quality over quantity. One issue should be understandable without this chat, Bedrock, or Flare access beyond the link.

## Title

Specific and human. Name the product surface and what the user does.

- Good: `Knowledge Test Back Button Error`
- Good: `Skill Scoring Find Pair Error`
- Bad: `ErrorException`, `Attempt to read property stem on null`

## Description

Use this skeleton. Keep “How to reproduce” to browser actions. Paths like `/testing` are fine; do not hard-code a host, and never use production hosts (`*.tmutest.com`, etc.).

```markdown
We're seeing an error on Flare: [https://flareapp.io/errors/{id}/latest](https://flareapp.io/errors/{id}/latest)

> {exception message}

{What is wrong, in a few short paragraphs. Name the screen or component. Say what is null/missing and which request actually blows up (full page load vs later Livewire refresh / history). If a similar click is already guarded and only flashes, say so — that is not this bug.}

### How to reproduce

You need {ordinary TMU setup: role + records. No live IDs.}.

1. {Click / navigate on the local TMU `.test` site.}
2. {…}
3. {…}

Expected: {the 500 or equivalent, in user-visible terms}.
```

## How to reproduce rules

- Steps a person can do in a browser: links, buttons, dialogs, address bar, Back/Forward.
- Setup in domain language (“a student with a started knowledge exam”, “a skill attempt in the scoring queue whose event has an image attachment”).
- If the bug needs two tabs (delete/accept in tab B, then act in tab A), write that.
- **Never** JavaScript console, `$wire`, DevTools, curl, or tinker in this section.
- **Never** production URLs, Flare user PII, or copied live primary keys.

## Example (TMU-1579, shortened)

We're seeing an error on Flare: https://flareapp.io/errors/9171239/latest

> Attempt to read property "stem" on null

The knowledge test looks up the current item by question number. On a full page load it clamps an out-of-range `?number=` to the last question, but Livewire still stores that number in browser history. **Previous** pushes a real in-range entry; **Back** restores the out-of-range number without clamping, so the stem is read on a missing question.

### How to reproduce

You need a student with a started knowledge exam.

1. Log in as that student and open the knowledge test (`/testing`).
2. In the address bar, set `?number=` higher than the last question (for example `99`) and press Enter. You will still see the last question. That is expected.
3. Click **Previous**.
4. Click the browser **Back** button.

Expected: 500 reading `stem` on null.

## Do not add

Suggested fix, test plan, acceptance criteria, or “run this in tinker.” Those belong in a later `tmu-issue` implementation, not this ticket.
