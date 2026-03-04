# 00 Start Here

## Current Objective
Keep `DEV-DOCS` aligned with current runtime, CI, and release behavior while executing remaining engineering-core remediation items.

## Current Snapshot (2026-03-04, refreshed)
- Canonical version is `0.12.3`.
- Branch model is active as `main` (production) + `development` (integration).
- Distribution is GitHub-only (install scripts + GitHub Releases).
- Dashboard now performs built-in version checks at startup and every 24h.
- Overview API/UI exposes a read-only update notice when a newer release exists.
- CLI now supports `clawtelemetry update` (GitHub release install + service auto-restart when active).
- Duplicate runtime blocks in `dashboard.py` were removed; route surface remains stable at `90` routes.

## First Reads For New Session
1. `DEV-DOCS/DEVELOPMENT-STATUS.md`
2. `DEV-DOCS/01-task-list.md`
3. `DEV-DOCS/audit/10_REMEDIATION_ROADMAP.md`
4. `DEV-DOCS/audit/99_EVIDENCE_INDEX.md`

## Immediate Priorities
- reduce broad exception swallowing in critical auth/file/network paths
- tighten release/install/update lifecycle validation across all platforms
- add lightweight performance benchmark artifacts for long-running sessions

## Quick Commands
```bash
# syntax/import sanity
python3 -m py_compile dashboard.py history.py clawtelemetry/*.py clawtelemetry/providers/*.py

# API suite (isolated)
CLAWTELEMETRY_URL=http://127.0.0.1:8924 CLAWTELEMETRY_TOKEN=<token> pytest -q tests/test_api.py -q

# run server
clawtelemetry --host 0.0.0.0 --port 8900

# check installed version and update
clawtelemetry --version
clawtelemetry update
```

## Operating Constraints
- Keep `dashboard.py` single-file architecture.
- Avoid heavy dependencies.
- Preserve zero-config behavior.
- Prefer read-only observability semantics.
