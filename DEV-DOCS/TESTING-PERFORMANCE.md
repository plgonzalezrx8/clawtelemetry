# Testing and Performance

## Test Layers
- syntax/import checks: fast sanity
- API tests: endpoint behavior and response structure
- e2e Playwright: UI load and tab navigation sanity
- BrowserStack: cross-browser smoke coverage
- install script tests: GitHub-only install path validation on Linux/macOS/Windows

## Deterministic Local Runbook
```bash
# syntax/import
python3 -m py_compile dashboard.py history.py clawtelemetry/*.py clawtelemetry/providers/*.py

# API tests (isolated URL + known token)
CLAWTELEMETRY_URL=http://127.0.0.1:8924 CLAWTELEMETRY_TOKEN=<token> pytest -q tests/test_api.py -q

# optional: disable update-check network call in offline/CI-like local runs
CLAWTELEMETRY_DISABLE_UPDATE_CHECK=1 python3 dashboard.py --port 8900 --no-debug
```

## Known Testing Gotchas
- default API tests may hit a stale process already bound to `localhost:8900`; prefer isolated port/token runs
- auth readiness still depends on matching explicit token mode in startup/test harness

## CI Summary
From `.github/workflows/`:
- `ci.yml`: runs on pushes to `main` and `development`, plus pull requests
- lint guard includes legacy-brand residue check and duplicate-definition static check
- API matrix covers Linux/macOS/Windows
- Playwright e2e is currently non-blocking (`continue-on-error: true`)
- `install-test.yml`: validates install scripts on all target platforms
- `publish.yml`: on merge/push to `main`, publishes GitHub Release once per dashboard version (or manually via `workflow_dispatch`)

## Performance Expectations
- memory budget target: under 100MB on constrained hardware
- avoid high-frequency expensive scans
- keep SSE streams bounded
- avoid unbounded in-memory growth (cap metrics store)

## Performance Validation Suggestions
- run long-session memory profile (1h)
- profile expensive endpoints (`/api/overview`, `/api/system-health`)
- validate response time under realistic session/log volumes
