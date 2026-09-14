---
name: tmu-state-laravel-13
description: >-
  Roll the TMU-1573 Laravel 13 / hdmaster/core ^21.0 upgrade into a TMU state
  repo by merging Bedrock main, bumping core, regenerating lockfiles, and
  opening a GitHub PR. Use when the user asks to upgrade a state app, run
  TMU-1573 for remaining states, or mentions arizona-cgfm / state repos
  pulling upstream bedrock.
---

# TMU state Laravel 13 upgrade (TMU-1573)

Roll Bedrock's Laravel 13 merge into one state app at a time. Template: [hdmastr/arizona#22](https://github.com/hdmastr/arizona/pull/22). First follow-up: [hdmastr/arizona-cgfm#18](https://github.com/hdmastr/arizona-cgfm/pull/18).

State checkouts live in `~/Code/<state>`. Each has `origin` (the state GitHub repo) and `upstream` (`git@github.com:hdmastr/bedrock.git`).

Do **not** use the tmu-issue `develop` / draft-PR flow. State apps branch from `main` and open a regular PR into `main`.

## Kickoff

Accept a state directory name (`arizona-cgfm`), a path, or "do the rest". Skip states that already have an open/merged TMU-1573 PR.

1. `move_agent_to_root` to `/Users/austen/Code/<state>`.
2. Confirm remotes: `origin` → `hdmastr/<state>`, `upstream` → `hdmastr/bedrock`.
3. Working tree must be clean (stash or ask if dirty).

## Procedure

### 1. Branch from latest `main`

```bash
git fetch origin
git fetch upstream
git checkout main
git pull origin main
git checkout -B tmu-1573-laravel-13-upgrade
```

`-B` is required: a leftover local branch with that name is common and may be stale.

### 2. Bump core, then merge Bedrock

In `composer.json`, set `"hdmaster/core": "^21.0"`. Commit that change **before** the merge so `composer.json` can merge cleanly:

```bash
git add composer.json
git commit -m "Require hdmaster/core ^21.0 for the Laravel 13 upgrade."
git pull upstream main --no-edit
```

### 3. Resolve conflicts

Expect three files. Keep **state identity**, take **Laravel 13 / PHP 8.3** from Bedrock.

**`composer.json`**

- `"name"`: keep `hdmaster/<state>` (never `hdmaster/bedrock`)
- `"php"`: `>=8.3`
- `"hdmaster/core"`: `^21.0` (never Bedrock's `*@dev`)
- `"laravel/framework"`: `^13.0`
- `repositories`: keep the git URL `git@github.com:hdmastr/core.git` (never Bedrock's path `./core`)
- Take Bedrock `require-dev` bumps (`debugbar ^4`, `tinker ^3`, `phpunit ^12`, `paratest ^7.8`)
- Keep any extra state-only packages (Arizona had `league/flysystem-sftp-v3`; most states do not)

**`.env.example`**

- Keep `APP_URL=http://<state>.test` and `DB_DATABASE=<state_db>`
- Add Bedrock locale keys:

```
APP_LOCALE=en
APP_FALLBACK_LOCALE=en
APP_FAKER_LOCALE=en_US
```

**`composer.lock`**

```bash
git checkout --ours composer.lock
git add composer.lock
```

It will be deleted and regenerated in the next step.

Also preserve auto-merged state-specific bits:

- `phpunit.xml` test `<exclude>`s
- extra `bootstrap/app.php` schedule commands
- CSRF `except` paths

After resolving:

```bash
git add .env.example composer.json composer.lock
git commit -m "Merge branch 'main' of github.com:hdmastr/bedrock into tmu-1573-laravel-13-upgrade"
```

### 4. Fresh lockfiles

`rm -f vendor node_modules` will **not** remove directories. Use:

```bash
rm -rf vendor node_modules
rm -f composer.lock package-lock.json
composer update && npm i
```

Confirm `composer show hdmaster/core` is `21.0.0` and `php artisan --version` reports Laravel 13. Run Pint on changed PHP files via the Bedrock/host `vendor/bin/pint` in this state repo.

Commit lockfiles with the same message Arizona used:

```bash
git add composer.lock package-lock.json
git commit -m "composer & npm update"
```

Expected file set vs `main` (same as Arizona #22):

- `.env.example`, `.gitignore`, `bootstrap/app.php`, `composer.json`, `composer.lock`
- `config/app.php`, `config/cache.php`, `config/database.php`, `config/logging.php`, `config/sanctum.php`, `config/session.php`
- `package-lock.json`, `phpunit.xml`, `storage/framework/.gitignore`

### 5. Open the PR

These repos are **forks of Bedrock**. Bare `gh pr create` targets Bedrock and fails with "No commits between main and …". Always pass `--repo`:

```bash
git push -u origin HEAD
gh pr create --repo hdmastr/<state> --base main --title "TMU-1573 | Laravel 13 Upgrade" --body "$(cat <<'EOF'
## Summary
- Merge Bedrock `main` (Laravel 13) into this state app, matching [hdmastr/arizona#22](https://github.com/hdmastr/arizona/pull/22).
- Bump `hdmaster/core` to `^21.0` and regenerate `composer.lock` / `package-lock.json`.
- Bring over Laravel 13 config updates (`preventRequestForgery`, cache unserialization, session cache store, PHPUnit 12).

## Testing This PR
- [ ] Confirm the app boots (`php artisan --version` should report Laravel 13)
- [ ] Run the test suite
- [ ] Spot-check login and a couple of common pages
EOF
)"
```

Do **not** update Linear. Give the user the PR URL.

## Core overrides (Laravel 13)

Core moved `CoordinateObserver` / `StudentAdaObserver` from `boot()` onto `#[ObservedBy]` (and `#[ScopedBy]` on `StudentAda`). Laravel 13's `resolveObserveAttributes()` walks parent classes, so **state subclasses inherit those attributes** — do not copy `ObservedBy` onto `App\Models\Student` / `Facility` unless a subclass stops calling `parent::boot()` and also bypasses trait boot.

States with Student/Facility overrides that needed no extra code:

- Student: arkansas, mass, new-mexico, ohio, oklahoma, oregon, south-dakota, tennessee, wisconsin
- Facility: mass, mass-cna, missouri

Oregon `Student` and Missouri `Facility` define `boot()` but call `parent::boot()`. No state overrides `Payment`, `StudentAda`, `PassFail`, or `PassFailController`. Core did not change Blade views.

## Extra conflict / identity notes

- `iowa-dcp` and `nevada` already use composer `"name": "hdmaster/bedrock"`. Keep that; do not fail the upgrade.
- Nevada also conflicts in `config/database.php` Redis prefix: keep `CLIENT_NAME` `nevada`, take Bedrock's `'persistent'` key.
- Keep extra require packages such as `league/flysystem-sftp-v3` (arizona, arkansas, missouri, oregon, wyoming).

## Non-goals

- Changing Bedrock or core
- Force-pushing
- Draft PRs into `develop`
- Adding Cursor / AI attribution on GitHub
