# 99 Evidence Index

## Generated Artifacts (`DEV-DOCS/reports`)

### Core inventories
- `route-inventory-2026-03-04.txt`
  - route count and full route list from runtime url map
- `duplicate-scan-2026-03-04.txt`
  - duplicate helper/function definitions and key duplicate constant line references
- `code-quality-scan-2026-03-04.txt`
  - TODO/FIXME markers and broad exception/pass hotspot sample

### Build/test/runtime checks
- `syntax-check-2026-03-04.txt`
  - `py_compile` pass snapshot
- `runtime-probe-2026-03-04.txt`
  - isolated startup probe showing auth mismatch behavior
- `runtime-smoke-passing-2026-03-04.txt`
  - isolated startup probe showing successful protected endpoint behavior with configured token
- `pytest-api-isolated-2026-03-04.txt`
  - failing isolated run (port conflict from fixture startup assumptions)
- `pytest-api-isolated-tokenfile-2026-03-04.txt`
  - passing isolated API suite with aligned token source
- `pytest-api-isolated-devtoken-post-remediation-2026-03-04.txt`
  - passing isolated API suite after env-first token precedence remediation

### Packaging/CI snapshots
- `ci-packaging-snapshot-2026-03-04.txt`
  - workflows list and dependency metadata extracts

### Server logs
- `server-2026-03-04.log`
- `server-probe-2026-03-04.log`
- `server-smoke-passing-2026-03-04.log`

### Post-remediation verification
- `duplicate-scan-post-remediation-2026-03-04.txt`
  - confirms no duplicate top-level helper definitions remain
- `route-inventory-post-remediation-2026-03-04.txt`
  - confirms route surface remains stable (`90` routes)

## Command Summary
- route extraction via Python app url map iteration
- duplicate detection via ripgrep function signature counts
- syntax/import validation via `python3 -m py_compile`
- isolated runtime probes via `python3 dashboard.py --port <port> --no-debug` + `curl`
- API suite via `pytest -q tests/test_api.py -q`

## Evidence-to-Finding Mapping
- ARC-01/REL-03/PFM-01 -> `duplicate-scan-2026-03-04.txt`
- API-01/REL-02/TST-01 -> `runtime-probe-2026-03-04.txt`, `pytest-api-isolated-2026-03-04.txt`, `pytest-api-isolated-tokenfile-2026-03-04.txt`
- API surface findings -> `route-inventory-2026-03-04.txt`
- SEC-03/DOC-02 -> `code-quality-scan-2026-03-04.txt`
- PKG findings -> `ci-packaging-snapshot-2026-03-04.txt`

## Confidence Notes
- Findings are grounded in reproducible command outputs and direct source inspection.
- Runtime behavior findings include both failure and success probes to avoid one-sided interpretation.
