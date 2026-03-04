# 04 Security and Privacy

## Summary
Core local-first model is strong, but token handling and auth bootstrap flows have avoidable exposure and ambiguity.

## Findings

### SEC-01 Gateway token persisted in plaintext local file
- ID: `SEC-01`
- Severity: `P2`
- Impact: Local compromise of user account/home directory leaks dashboard gateway token.
- Likelihood: Medium
- Affected files:
  - `dashboard.py` (gateway config handling)
  - local runtime file `~/.clawmetry-gateway.json`
- Evidence:
  - gateway config file usage captured during audit (`../reports/runtime-probe-2026-03-04.txt` context)
- Recommended fix:
  - document file sensitivity clearly
  - add optional secure-storage mode for token persistence where platform supports it

### SEC-02 Token-in-query auth helper (`/auth?token=`) increases accidental exposure risk
- ID: `SEC-02`
- Severity: `P2`
- Impact: Query tokens may leak via browser history, logs, or copied URLs.
- Likelihood: Medium
- Affected files:
  - `dashboard.py` (`/auth` handler and JS storage logic)
- Evidence:
  - route behavior in source inspection
- Recommended fix:
  - prefer POST-based token setup flow
  - keep query flow only as compatibility fallback with warning banner

### SEC-03 Broad exception swallowing hides security-significant failures
- ID: `SEC-03`
- Severity: `P2`
- Impact: Silent failures can mask auth/path/network issues and reduce auditability.
- Likelihood: High
- Affected files:
  - `dashboard.py`
  - `history.py`
- Evidence:
  - hotspot scan output in `../reports/code-quality-scan-2026-03-04.txt`
- Recommended fix:
  - replace broad catches with targeted exceptions in auth/file/network critical paths
  - emit structured warning logs with bounded noise

### SEC-04 Path traversal guard exists and should remain mandatory
- ID: `SEC-04`
- Severity: `P3`
- Impact: This is a positive control; regression would be high risk.
- Likelihood: Medium
- Affected files:
  - `dashboard.py` (`/api/file`)
- Evidence:
  - normalized path prefix check in route implementation
- Recommended fix:
  - add regression tests for traversal attempts
