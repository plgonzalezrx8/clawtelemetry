# Work Log

## 2026-03-04 - DEV-DOCS bootstrap and full engineering-core audit

### Completed
- created complete `DEV-DOCS` structure
- authored core docs (architecture, standards, security, testing, status)
- produced full audit dossier (`DEV-DOCS/audit/`)
- generated evidence artifacts (`DEV-DOCS/reports/`)

### Key Evidence Artifacts
- `reports/route-inventory-2026-03-04.txt`
- `reports/duplicate-scan-2026-03-04.txt`
- `reports/code-quality-scan-2026-03-04.txt`
- `reports/ci-packaging-snapshot-2026-03-04.txt`
- `reports/syntax-check-2026-03-04.txt`
- `reports/runtime-probe-2026-03-04.txt`
- `reports/runtime-smoke-passing-2026-03-04.txt`
- `reports/pytest-api-isolated-tokenfile-2026-03-04.txt`

### Notes
- isolated API run passes when token source aligns with configured gateway token file
- startup auth behavior can fail deterministic probes when environment token differs from persisted gateway config
- duplicate runtime blocks in `dashboard.py` are the top structural remediation target

---

## 2026-03-04 - Remediation pass (roadmap next steps)

### Completed
- deduplicated `dashboard.py` by removing repeated helper/runtime copy and keeping a single top-level definition set
- updated `detect_config` to:
  - safely handle `None`/partial args namespaces
  - register blueprints via idempotent `_register_blueprints_once()`
- updated `_load_gw_config` precedence so `OPENCLAW_GATEWAY_TOKEN` overrides persisted local config for deterministic test/CI behavior
- added `scripts/check_dashboard_duplicates.py`
- integrated duplicate guard into:
  - `.github/workflows/ci.yml` lint job
  - `Makefile` `lint` target

### Validation
- `python3 -m py_compile dashboard.py history.py clawtelemetry/*.py clawtelemetry/providers/*.py` -> pass
- `python3 scripts/check_dashboard_duplicates.py dashboard.py` -> pass
- isolated route registration probe (double `detect_config()` call) -> pass, 90 routes available
- API suite on isolated port with explicit env token:
  - `CLAWTELEMETRY_URL=http://127.0.0.1:8933 CLAWTELEMETRY_TOKEN=dev-token pytest -q tests/test_api.py -q` -> pass

---

## 2026-03-04 - ClawTelemetry hard-cut rebrand + GitHub-only distribution

### Completed
- renamed package namespace directory from `clawmetry/` to `clawtelemetry/`
- updated imports, env vars, local token keys, service IDs, and runtime paths to `clawtelemetry` naming
- removed legacy alias package subtree under `packages/`
- replaced PyPI publish workflow with GitHub Release asset workflow
- rewrote install scripts (`install.sh`, `install.ps1`, `install.cmd`) to install from GitHub release/ref archives
- updated root/docs/install guidance to GitHub-only installation commands
- added CI guard step to fail if legacy brand token appears outside allowlist
- removed `dashboard.py.bak` snapshot to avoid stale duplicate runtime and stale brand references

### Validation
- residue scan:
  - `rg -n \"Clawmetry|clawmetry|CLAWMETRY\" . --glob '!.git/*' --glob '!LICENSE' --glob '!CHANGELOG.md'` -> no matches
- syntax/import:
  - `python3 -m compileall dashboard.py history.py clawtelemetry tests` -> pass
  - `python3 -c \"import clawtelemetry, dashboard; print(clawtelemetry.__version__)\"` -> pass
- runtime smoke:
  - `OPENCLAW_GATEWAY_TOKEN=dev-token python3 dashboard.py --port 8911 --no-debug` + `/api/health` probe -> pass (HTTP 200)
- API suite:
  - default `python3 -m pytest tests/test_api.py -q` can fail if stale localhost server is already bound on port 8900
  - isolated run `CLAWTELEMETRY_URL=http://127.0.0.1:8933 CLAWTELEMETRY_TOKEN=dev-token python3 -m pytest tests/test_api.py -q` -> pass (`45 passed, 5 skipped`)

### Notes
- channel endpoint failures in default runs are environment-contamination related (stale localhost server), not route-removal regressions.
