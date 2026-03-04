# 02 API and Interface Audit

## Summary
API surface remains broad and functional (`90` routes). Baseline auth/bootstrap friction was significantly reduced by deterministic token precedence changes; remaining work is mostly around diagnostics clarity and contract hardening.

## API Surface Snapshot
- Total registered routes: `90`
- Source: `../reports/route-inventory-post-remediation-2026-03-04.txt`
- Includes channel endpoints, system endpoints, gateway control, history, budget, alerts, and fleet interfaces.

## Status Update (Post-Baseline)
- `API-01`: Mitigated (env-first token precedence implemented)
- `API-02`: Open (diagnostic clarity can still improve)
- `API-03`: Mitigated (blueprint registration flow stabilized)

## Findings

### API-01 Auth bootstrap behavior is sensitive to token source precedence
- ID: `API-01`
- Severity: `P1`
- Impact: Identical startup commands can produce different auth outcomes depending on persisted gateway config and environment token mismatch.
- Likelihood: High (baseline), Medium-Low (current after env-first precedence)
- Affected files:
  - `dashboard.py`
  - `tests/conftest.py`
- Evidence:
  - probe with env token mismatch produced `401` on protected endpoints (`../reports/runtime-probe-2026-03-04.txt`)
  - successful isolated API run required configured token alignment (`../reports/pytest-api-isolated-tokenfile-2026-03-04.txt`)
  - post-remediation run passed with explicit env token (`../reports/pytest-api-isolated-devtoken-post-remediation-2026-03-04.txt`)
- Recommended fix:
  - completed core precedence remediation
  - continue documenting deterministic startup/test token contracts

### API-02 `/api/auth/check` and protected endpoint behavior can appear contradictory during setup
- ID: `API-02`
- Severity: `P2`
- Impact: `auth/check` can report `valid:false` while other probes pass under a different token source context, confusing operators/tests.
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
- Impact: App URL map availability depended on specific startup path; introspection/tooling could fail when config helper was not called as expected.
- Likelihood: Medium (baseline), Low (current after registration stabilization)
- Affected files:
  - `dashboard.py`
- Evidence:
  - route map required initialization sequence (`../reports/route-inventory-2026-03-04.txt` generation flow)
  - post-remediation registration probe confirmed stable route map (`../reports/route-inventory-post-remediation-2026-03-04.txt`)
- Recommended fix:
  - keep blueprint registration centralized in one explicit app-init path invoked once
