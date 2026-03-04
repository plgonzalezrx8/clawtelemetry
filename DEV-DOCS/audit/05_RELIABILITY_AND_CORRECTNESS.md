# 05 Reliability and Correctness

## Summary
Core runtime behavior is stable when explicit token/port context is controlled. Major duplicate-definition correctness hazards were remediated; remaining risk is mainly around startup diagnostics clarity and broad exception handling.

## Status Update (Post-Baseline)
- `REL-01`: Resolved (`detect_config` now tolerates non-standard bootstrap inputs)
- `REL-02`: Mitigated (deterministic token precedence improved reliability)
- `REL-03`: Resolved (duplicate helper/runtime definitions removed)

## Findings

### REL-01 `detect_config(None)` throws attribute error in introspection usage
- ID: `REL-01`
- Severity: `P2`
- Impact: Tooling scripts and non-standard bootstrap paths can fail unexpectedly.
- Likelihood: Medium (baseline), Low (current)
- Affected files:
  - `dashboard.py`
- Evidence:
  - baseline audit command failure encountered when calling `detect_config(None)` before namespace normalization
- Recommended fix:
  - completed: `detect_config` now safely handles missing/partial namespace args

### REL-02 Startup readiness probes can fail under token mismatch despite server availability
- ID: `REL-02`
- Severity: `P1`
- Impact: Test harnesses and health automation can misclassify running server as down.
- Likelihood: High (baseline), Medium (current)
- Affected files:
  - `dashboard.py`
  - `tests/conftest.py`
- Evidence:
  - failed isolated probe and fixture startup conflict output in `../reports/pytest-api-isolated-2026-03-04.txt`
  - successful run with aligned token in `../reports/pytest-api-isolated-tokenfile-2026-03-04.txt`
  - post-remediation passing isolated run in `../reports/pytest-api-isolated-devtoken-post-remediation-2026-03-04.txt`
- Recommended fix:
  - keep readiness checks isolated by explicit URL/port/token
  - continue hardening fixture startup strategy against stale localhost contamination

### REL-03 Duplicate function definitions risk unintentional behavior override
- ID: `REL-03`
- Severity: `P1`
- Impact: Later definitions silently shadow earlier code, creating hidden behavioral drift.
- Likelihood: High (baseline), Low (current)
- Affected files:
  - `dashboard.py`
- Evidence:
  - baseline duplicate scan report `../reports/duplicate-scan-2026-03-04.txt`
  - post-remediation verification `../reports/duplicate-scan-post-remediation-2026-03-04.txt`
- Recommended fix:
  - completed: duplicates removed and one-definition-per-helper enforced via static check in CI
