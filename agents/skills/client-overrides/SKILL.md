---
name: client-overrides
description: Understand, document, and outline client/state-specific overrides and business logic. Activates when documenting a client instance, summarizing state differences, implementing client customizations, auditing what a fork overrides, reviewing view overrides, or when the user mentions client, state, override, state-specific, business logic, vendor views, or Blade overrides.
---

# Client / State Overrides

## When to Apply

Activate when:

- Documenting what a client (typically a US state) instance overrides or customizes
- Summarizing differences between client forks
- Implementing new client-specific logic
- Auditing a fork to understand its customizations
- Explaining business logic that varies by state
- Reviewing view overrides in `resources/views/vendor/` or non-standard app views

## Override Mechanisms

Client instances (forks of Bedrock) customize behavior through:

### 1. Config Overrides

Core merges config via `mergeConfigFrom()`. Client app config **overrides** core defaults.

- **Primary**: `config/core.php` — Most business logic toggles live here. Client copies from core and overrides values.
- **Client identity**: `config/client.php` — `CLIENT_NAME` for nav/branding; `config/core.php` → `client` (abbrev, e.g. `ZZ` for workbench, `or` for Oregon).

Key `config/core.php` areas: certifications, employments, facilities, payments, students, testing, trainings, observers, etc. Most use `env()` so values come from `.env`.

### 2. Environment Variables

`.env` drives most client differences. Common vars:

- `CLIENT`, `CLIENT_NAME` — Identity
- `ENABLE_*`, `*_ENABLED` — Feature flags (e.g. `EMPLOYER_SPONSORED_RENEWALS`, `FACILITY_APPROVALS`)
- `*_BEFORE`, `*_AFTER` — Thresholds (e.g. `RENEWAL_ELIGIBLE_BEFORE`)
- `REQUIRE_*`, `*_REQUIRED` — Validation rules

### 3. Class Overrides (excludeAliases)

To replace core behavior with client logic:

1. Add class name to `config/core.php` → `excludeAliases`
2. Create `App\Models\*` (or `App\Policies\*`, etc.) extending the core class
3. Optionally register in `config/app.php` aliases for root-level resolution

Same pattern for Policies, Controllers, Livewire components.

### 4. App Namespace Extensions

- **Policies**: `AuthServiceProvider` checks `App\Policies\{Model}Policy` first, falls back to core
- **Factories**: `AppServiceProvider` checks `Database\Factories\{Model}Factory` first, falls back to core
- **Controllers**: Client can extend core controllers (e.g. `RegisterController extends Hdmaster\Core\Controllers\Auth\RegisterController`)

### 5. View Overrides

Laravel resolves package views from `resources/views/vendor/{namespace}/` before the package's own views.

- **Core overrides**: `resources/views/vendor/core/` — Mirrors core's view structure. A file at `vendor/core/students/show.blade.php` overrides `core::students.show`.
- **Other packages**: `resources/views/vendor/mail/`, `resources/views/vendor/ui/`, etc.
- **App-level views**: `resources/views/auth/`, `resources/views/errors/` — Often extend core (`@extends('core::auth.login')`) but can add client-specific markup.

**Important**: Overridden and non-standard views often contain **comments explaining the "why"** — state-specific requirements, regulatory wording, or business logic. Read these when documenting; they explain why the override exists.

## Documenting a Client

When outlining or summarizing a client's overrides:

1. **Identity**: `CLIENT`, `CLIENT_NAME` from env/config
2. **Config overrides**: List non-default values from `config/core.php` (and any other merged configs)
3. **Env-driven flags**: Enumerate `.env` vars that differ from defaults
4. **Class overrides**: List `excludeAliases` and any `App\*` classes that extend core
5. **View overrides**: List files in `resources/views/vendor/{namespace}/` and any non-standard app views. **Extract comments** — they often explain why the override exists.
6. **Custom logic**: Note any app-level controllers, policies, jobs, or routes that add/change behavior

## Summary Template

```markdown
# [Client Name] Overrides

## Identity

- CLIENT: [abbrev]
- CLIENT_NAME: [display name]

## Config (config/core.php)

| Key | Value | Notes |
| --- | ----- | ----- |
| ... | ...   | ...   |

## Environment

- [VAR_NAME]=[value]
- ...

## Class Overrides

- excludeAliases: [Model1, Model2, ...]
- App\* extensions: [list]

## View Overrides

- vendor/core/: [list files; note any comments explaining "why"]
- vendor/other/: [as applicable]
- Non-standard app views: [list]

## Custom Logic

- [Brief description of app-specific behavior]
```

## Discovery Checklist

When auditing a client fork:

- [ ] Read `config/core.php` — compare to `vendor/hdmaster/core/config/core.php` (or core package path)
- [ ] Read `config/client.php`
- [ ] Scan `.env.example` for client-specific vars
- [ ] Check `excludeAliases` in config
- [ ] List `app/` classes (Models, Policies, Controllers, etc.)
- [ ] Compare `routes/` to core routes
- [ ] Check `app/Providers/*` for custom bindings or overrides
- [ ] **Scan `resources/views/vendor/`** — Core overrides live in `vendor/core/`; other packages in `vendor/{namespace}/`
- [ ] **Scan `resources/views/`** for non-standard app views (auth, errors, etc.)
- [ ] **Read comments in overridden views** — They often document the "why" (state rules, regulatory wording, business logic)
