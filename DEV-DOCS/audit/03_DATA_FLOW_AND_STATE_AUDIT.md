# 03 Data Flow and State Audit

## Summary
Data flow works end-to-end, but state orchestration relies heavily on mutable globals and startup side effects.

## Findings

### DFL-01 Global mutable state is shared across unrelated subsystems
- ID: `DFL-01`
- Severity: `P1`
- Impact: Changes in auth/config/global stores can break endpoints far from modified code.
- Likelihood: High
- Affected files:
  - `dashboard.py`
- Evidence:
  - module-level globals for workspace, logs, sessions, metrics, budget, fleet, gateway
- Recommended fix:
  - introduce internal state grouping pattern (still single-file) and limit write points

### DFL-02 Startup sequence has non-obvious side effects
- ID: `DFL-02`
- Severity: `P2`
- Impact: Calling config detection can register routes and mutate runtime state, which complicates reuse/test introspection.
- Likelihood: Medium
- Affected files:
  - `dashboard.py`
- Evidence:
  - `detect_config` contains side-effect work beyond pure config detection
- Recommended fix:
  - make startup sequence explicit: detect paths -> load auth -> init providers -> register blueprints -> serve app

### DFL-03 Provider abstraction is present but boundary is not fully enforced
- ID: `DFL-03`
- Severity: `P2`
- Impact: Mixed direct filesystem access and provider abstraction increase inconsistency risk.
- Likelihood: Medium
- Affected files:
  - `dashboard.py`
  - `clawmetry/providers/*.py`
- Evidence:
  - provider registry and implementations exist, while many routes still read directly via helper logic
- Recommended fix:
  - route-by-route migration plan to provider interface for read paths where practical
