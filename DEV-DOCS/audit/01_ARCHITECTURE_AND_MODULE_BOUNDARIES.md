# 01 Architecture and Module Boundaries

## Summary
Baseline audit identified duplicated runtime blocks and boundary drift in `dashboard.py`. Duplicate-block findings have since been remediated; remaining risk centers on single-file complexity and global-state coupling.

## Status Update (Post-Baseline)
- `ARC-01`: Resolved (`dashboard.py` duplicate runtime blocks removed)
- `ARC-02`: Resolved (`detect_config` no longer redefined)
- `ARC-03`: Open (global mutable state coupling remains)

## Findings

### ARC-01 Duplicate runtime blocks redefine core behavior
- ID: `ARC-01`
- Severity: `P1`
- Impact: Duplicate helper/runtime definitions increase drift risk and make execution order non-obvious.
- Likelihood: High (baseline), Low (current after remediation)
- Affected files:
  - `dashboard.py`
- Evidence:
  - duplicated function definitions and duplicate `DASHBOARD_HTML` constants captured in `../reports/duplicate-scan-2026-03-04.txt`
  - post-remediation verification in `../reports/duplicate-scan-post-remediation-2026-03-04.txt`
- Recommended fix:
  - completed: collapsed duplicated blocks into one authoritative implementation section

### ARC-02 `detect_config` behavior is redefined, creating dead/overwritten initialization paths
- ID: `ARC-02`
- Severity: `P1`
- Impact: Earlier `detect_config` path initialized provider differently than later definition, creating startup ambiguity.
- Likelihood: High (baseline), Low (current after remediation)
- Affected files:
  - `dashboard.py`
- Evidence:
  - line regions showed two `detect_config` definitions (`../reports/duplicate-scan-2026-03-04.txt`)
  - post-remediation duplicate scan confirms single definition
- Recommended fix:
  - completed: one `detect_config` function retained with explicit internal helper flow

### ARC-03 Global mutable state dominates cross-cutting boundaries
- ID: `ARC-03`
- Severity: `P2`
- Impact: Runtime coupling between auth, config, metrics, and routes increases regression scope for small changes.
- Likelihood: High
- Affected files:
  - `dashboard.py`
- Evidence:
  - many module-level globals for token/config/runtime stores in `dashboard.py`
  - auth and route behavior depend on global state mutation order
- Recommended fix:
  - retain single-file architecture but create explicit state container sections and startup sequence comments
  - narrow global writes to dedicated bootstrap helpers
