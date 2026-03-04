# 02 API and Interface Audit

## Summary
API surface is broad and generally functional, but token/bootstrap precedence and interface consistency gaps create avoidable test/runtime friction.

## API Surface Snapshot
- Total registered routes: `90`
- Source: `../reports/route-inventory-2026-03-04.txt`
- Includes channel endpoints, system endpoints, gateway control, history, budget, alerts, and fleet interfaces.

## Findings

### API-01 Auth bootstrap behavior is sensitive to token source precedence
- ID: `API-01`
- Severity: `P1`
- Impact: Identical startup commands can produce different auth outcomes depending on persisted gateway config and environment token mismatch.
- Likelihood: High
- Affected files:
  - `dashboard.py`
  - `tests/conftest.py`
- Evidence:
  - probe with env token mismatch produced `401` on protected endpoints (`../reports/runtime-probe-2026-03-04.txt`)
  - successful isolated API run required configured token alignment (`../reports/pytest-api-isolated-tokenfile-2026-03-04.txt`)
- Recommended fix:
  - document and enforce explicit precedence contract for gateway token resolution
  - expose a deterministic startup flag for test mode token source

### API-02 `/api/auth/check` and protected endpoint behavior can appear contradictory during setup
- ID: `API-02`
- Severity: `P2`
- Impact: `auth/check` can report `valid:false` while health still works with another token source, confusing operators/tests.
- Likelihood: Medium
- Affected files:
  - `dashboard.py`
- Evidence:
  - `../reports/runtime-probe-2026-03-04.txt`
  - `../reports/runtime-smoke-passing-2026-03-04.txt`
- Recommended fix:
  - return additional token-source metadata in auth check (masked/source-only)
  - add explicit setup diagnostics endpoint for readiness probing

### API-03 Route registration is runtime-coupled to config detection call path
- ID: `API-03`
- Severity: `P2`
- Impact: App URL map availability depends on specific startup path; introspection/tooling can fail when config helper is not called as expected.
- Likelihood: Medium
- Affected files:
  - `dashboard.py`
- Evidence:
  - route map requires initialization sequence (`../reports/route-inventory-2026-03-04.txt` generation flow)
- Recommended fix:
  - centralize blueprint registration in one explicit app-init function invoked exactly once
