# 07 Testing and CI Quality

## Summary
Coverage breadth is strong across lint, API matrix, e2e, and install scripts. Determinism has improved post-baseline, but local stale-process collisions and non-blocking e2e policy still leave residual risk.

## Status Update (Post-Baseline)
- `TST-01`: Mitigated (token-source determinism improved; fixture/process isolation still important)
- `TST-02`: Open (BrowserStack token key naming mismatch still tracked)
- `TST-03`: Open (e2e remains non-blocking by design)

## Findings

### TST-01 API suite determinism depends on token-source alignment
- ID: `TST-01`
- Severity: `P1`
- Impact: Local runs can fail with false negatives when provided token differs from persisted gateway config token.
- Likelihood: High (baseline), Medium (current)
- Affected files:
  - `tests/conftest.py`
  - `dashboard.py`
- Evidence:
  - failing run: `../reports/pytest-api-isolated-2026-03-04.txt`
  - passing run: `../reports/pytest-api-isolated-tokenfile-2026-03-04.txt`
  - passing post-remediation run: `../reports/pytest-api-isolated-devtoken-post-remediation-2026-03-04.txt`
- Recommended fix:
  - continue enforcing explicit isolated URL/port/token startup mode in tests
  - add stale-process guard in test harness startup

### TST-02 BrowserStack test token key naming differs from app key naming
- ID: `TST-02`
- Severity: `P2`
- Impact: Auth injection may be brittle across environments.
- Likelihood: Medium
- Affected files:
  - `tests/test_e2e_browserstack.py`
  - `dashboard.py` (localStorage key usage)
- Evidence:
  - app uses `clawtelemetry-token`; BrowserStack test sets `clawtelemetry_token`
- Recommended fix:
  - normalize key names in tests to match runtime frontend

### TST-03 CI workflows are comprehensive but some jobs are intentionally non-blocking
- ID: `TST-03`
- Severity: `P3`
- Impact: Regressions may merge when e2e failures are tolerated.
- Likelihood: Medium
- Affected files:
  - `.github/workflows/ci.yml`
- Evidence:
  - e2e job configured with `continue-on-error: true`
- Recommended fix:
  - define graduation criteria to make e2e blocking once flakiness is reduced
