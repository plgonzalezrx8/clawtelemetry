# Coding Standards

## Core Principles
- Keep behavior explicit and simple.
- Preserve backwards compatibility.
- Optimize for readability and maintainability under single-file constraints.

## Python Standards
- Python 3.8+ compatibility for public package runtime.
- Prefer explicit helper functions over deeply nested blocks.
- Avoid hidden side effects in utility functions.
- Use targeted exceptions where possible; avoid silent broad exception swallowing in core flows.

## Flask/API Standards
- Routes should return stable JSON structures.
- Auth requirements must be explicit and consistently applied.
- Any route touching filesystem or subprocess behavior must include clear safety checks.

## Frontend-in-Python Standards
- Keep JS blocks grouped by page/tab responsibility.
- Avoid duplicate function names in template scripts.
- Keep route names and frontend fetch endpoints in sync.

## Dependency Standards
- Required deps stay minimal (`flask`, runtime server dependency, cryptography for sync).
- No heavy frameworks.
- No build step dependencies.

## Commenting Expectations
- Follow `DEV-DOCS/COMMENTING-STANDARD.md`.
- Complex logic requires intent comments.
- Public-facing functions should have concise docstrings.

## Change Hygiene
- Update relevant docs in same change.
- Add/adjust tests when route behavior changes.
- Add evidence artifact when making high-risk runtime changes.
