# Testing and Performance

## Test Layers
- syntax/import checks: fast sanity
- API tests: endpoint behavior and response structure
- e2e Playwright: UI load and tab navigation sanity
- BrowserStack: cross-browser smoke coverage

## Deterministic Local Runbook
```bash
# syntax/import
python3 -m py_compile dashboard.py history.py clawtelemetry/*.py clawtelemetry/providers/*.py

# API tests (isolated URL + known token)
CLAWTELEMETRY_URL=http://127.0.0.1:8924 CLAWTELEMETRY_TOKEN=<token> pytest -q tests/test_api.py -q
```

## Known Testing Gotcha
Server startup/auth readiness depends on active gateway token source resolution. If token mismatch occurs, `/api/health` returns `401` and fixture startup may fail.

## CI Summary
From `.github/workflows/`:
- lint/syntax
- API matrix (linux/macos/windows)
- e2e Playwright (allowed failure)
- BrowserStack workflow
- install script tests
- publish workflow for tagged versions

## Performance Expectations
- memory budget target: under 100MB on constrained hardware
- avoid high-frequency expensive scans
- keep SSE streams bounded
- avoid unbounded in-memory growth (cap metrics store)

## Performance Validation Suggestions
- run long-session memory profile (1h)
- profile expensive endpoints (`/api/overview`, `/api/system-health`)
- validate response time under realistic session/log volumes
