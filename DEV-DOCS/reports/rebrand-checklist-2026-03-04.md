# Rebrand Checklist - 2026-03-04

## Scope
Hard-cut rename to `ClawTelemetry` plus GitHub-only release/install path.

## Checks

### 1. Legacy name residue
Command:

```bash
rg -n "Clawmetry|clawmetry|CLAWMETRY" . --glob '!.git/*' --glob '!LICENSE' --glob '!CHANGELOG.md'
```

Result: no matches.

### 2. Syntax + import sanity
Command:

```bash
python3 -m compileall dashboard.py history.py clawtelemetry tests
python3 -c "import clawtelemetry, dashboard; print('clawtelemetry', clawtelemetry.__version__)"
```

Result: pass.

### 3. API smoke
Command:

```bash
python3 -m pytest tests/test_api.py -q
```

Result: may fail if an existing localhost server is already bound on port 8900 with mismatched runtime state.

### 4. Deterministic isolated API smoke (recommended)
Command:

```bash
CLAWTELEMETRY_URL=http://127.0.0.1:8933 CLAWTELEMETRY_TOKEN=dev-token python3 -m pytest tests/test_api.py -q
```

Result: pass (`45 passed, 5 skipped`).

## Completed Rebrand Artifacts
- package namespace: `clawtelemetry/`
- CLI command: `clawtelemetry`
- local state paths: `~/.clawtelemetry*`
- service IDs: `com.clawtelemetry*`, `clawtelemetry-sync`
- installers: GitHub archive/release installation (`install.sh`, `install.ps1`, `install.cmd`)
- release automation: `.github/workflows/publish.yml` publishes GitHub release assets
- guardrail: `.github/workflows/ci.yml` blocks legacy token reintroduction

## Follow-up
- keep isolated-port test command as the canonical local verification path to avoid stale localhost contamination.

## Evidence Export
- `DEV-DOCS/reports/rebrand-validation-2026-03-04.txt`
