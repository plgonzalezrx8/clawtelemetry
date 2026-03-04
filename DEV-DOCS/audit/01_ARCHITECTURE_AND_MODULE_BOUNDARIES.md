# 01 Architecture and Module Boundaries

## Summary
The project follows a valid single-file architecture goal, but current implementation contains duplicated runtime blocks and boundary drift that significantly increase maintenance risk.

## Findings

### ARC-01 Duplicate runtime blocks redefine core behavior
- ID: `ARC-01`
- Severity: `P1`
- Impact: Duplicate helper/runtime definitions increase drift risk and make execution order non-obvious.
- Likelihood: High
- Affected files:
  - `dashboard.py`
- Evidence:
  - duplicated function definitions and duplicate `DASHBOARD_HTML` constants captured in `../reports/duplicate-scan-2026-03-04.txt`
  - duplicate function line regions include `detect_config`, `_metrics_file_path`, `_load_metrics_from_disk`, `_save_metrics_to_disk`
- Recommended fix:
  - collapse duplicated blocks into a single authoritative implementation section
  - add section headers and ownership comments for each runtime subsystem

### ARC-02 `detect_config` behavior is redefined, creating dead/overwritten initialization paths
- ID: `ARC-02`
- Severity: `P1`
- Impact: Earlier `detect_config` path initializes provider, later redefinition registers blueprints and can change startup semantics.
- Likelihood: High
- Affected files:
  - `dashboard.py`
- Evidence:
  - line regions show two `detect_config` definitions (`../reports/duplicate-scan-2026-03-04.txt`)
  - first definition includes `_init_data_provider()`, later one replaces that behavior
- Recommended fix:
  - keep one `detect_config` function
  - split internal steps into explicitly called helper functions within same file

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
