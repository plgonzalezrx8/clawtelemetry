# 07 Testing and CI Quality

## Summary
Test and CI coverage breadth is good, but local determinism and token assumptions introduce flaky outcomes.

## Findings

### TST-01 API suite determinism depends on token-source alignment
- ID: `TST-01`
- Severity: `P1`
- Impact: Local runs can fail with false negatives when provided token differs from persisted gateway config token.
- Likelihood: High
- Affected files:
  - `tests/conftest.py`
  - `dashboard.py`
- Evidence:
  - failing run: `../reports/pytest-api-isolated-2026-03-04.txt`
  - passing run: `../reports/pytest-api-isolated-tokenfile-2026-03-04.txt`
- Recommended fix:
  - make fixture token source explicit and enforce a controlled startup mode for tests

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
