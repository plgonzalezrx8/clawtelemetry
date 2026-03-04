# 00 Start Here

## Current Objective
Complete a full engineering-core audit and establish durable internal docs for ClawMetry.

## Current Snapshot (2026-03-04)
- `DEV-DOCS` scaffold and audit dossier created.
- Evidence artifacts generated under `DEV-DOCS/reports/`.
- Full API suite confirmed passing in isolated run when using configured gateway token file.
- Major architectural risk identified: duplicate implementation blocks in `dashboard.py`.

## First Reads For New Session
1. `DEV-DOCS/DEVELOPMENT-STATUS.md`
2. `DEV-DOCS/01-task-list.md`
3. `DEV-DOCS/audit/10_REMEDIATION_ROADMAP.md`
4. `DEV-DOCS/audit/99_EVIDENCE_INDEX.md`

## Immediate Priorities
- align auth/bootstrap behavior for deterministic local test startup
- decide and execute strategy to remove duplicate runtime blocks in `dashboard.py`
- reduce exception swallowing in critical paths

## Quick Commands
```bash
# syntax/import sanity
python3 -m py_compile dashboard.py history.py clawmetry/*.py clawmetry/providers/*.py

# API suite (isolated)
CLAWMETRY_URL=http://127.0.0.1:8924 CLAWMETRY_TOKEN=<token> pytest -q tests/test_api.py -q

# run server
python3 dashboard.py --port 8900 --no-debug
```

## Operating Constraints
- Keep `dashboard.py` single-file architecture.
- Avoid heavy dependencies.
- Preserve zero-config behavior.
- Prefer read-only observability semantics.
