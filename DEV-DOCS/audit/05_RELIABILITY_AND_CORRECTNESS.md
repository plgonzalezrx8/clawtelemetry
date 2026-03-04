# 05 Reliability and Correctness

## Summary
Most runtime endpoints are stable when token context is correct, but startup and duplicated definitions introduce correctness hazards.

## Findings

### REL-01 `detect_config(None)` throws attribute error in introspection usage
- ID: `REL-01`
- Severity: `P2`
- Impact: Tooling scripts and non-standard bootstrap paths can fail unexpectedly.
- Likelihood: Medium
- Affected files:
  - `dashboard.py`
- Evidence:
  - audit command failure encountered when calling `detect_config(None)` before using namespace args
- Recommended fix:
  - make `detect_config` robust to `None` input by initializing a local namespace safely

### REL-02 Startup readiness probes can fail under token mismatch despite server availability
- ID: `REL-02`
- Severity: `P1`
- Impact: Test harnesses and health automation can misclassify running server as down.
- Likelihood: High
- Affected files:
  - `dashboard.py`
  - `tests/conftest.py`
- Evidence:
  - failed isolated probe and fixture startup conflict output in `../reports/pytest-api-isolated-2026-03-04.txt`
  - successful run with aligned token in `../reports/pytest-api-isolated-tokenfile-2026-03-04.txt`
- Recommended fix:
  - define deterministic readiness endpoint semantics independent of persisted token mismatches
  - adjust fixture readiness check strategy

### REL-03 Duplicate function definitions risk unintentional behavior override
- ID: `REL-03`
- Severity: `P1`
- Impact: Later definitions silently shadow earlier code, creating hidden behavioral drift.
- Likelihood: High
- Affected files:
  - `dashboard.py`
- Evidence:
  - duplicate scan report `../reports/duplicate-scan-2026-03-04.txt`
- Recommended fix:
  - eliminate duplicates and enforce one-definition-per-helper via static check
