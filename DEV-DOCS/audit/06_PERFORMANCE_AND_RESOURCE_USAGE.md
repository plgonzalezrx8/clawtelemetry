# 06 Performance and Resource Usage

## Summary
The project is performance-aware in some areas (bounded stores), but duplicated code and repeated subprocess work can degrade efficiency.

## Findings

### PFM-01 Duplicate large runtime blocks increase parse/load overhead and maintenance churn
- ID: `PFM-01`
- Severity: `P2`
- Impact: Larger source and duplicated logic increase startup parsing cost and maintenance overhead.
- Likelihood: High
- Affected files:
  - `dashboard.py`
- Evidence:
  - duplicate scan in `../reports/duplicate-scan-2026-03-04.txt`
  - file size snapshot in `../reports/code-quality-scan-2026-03-04.txt`
- Recommended fix:
  - deduplicate template/runtime blocks without changing single-file architecture

### PFM-02 Some overview/system endpoints rely on repeated subprocess calls per request
- ID: `PFM-02`
- Severity: `P2`
- Impact: Frequent calls can increase CPU/latency under high refresh rates.
- Likelihood: Medium
- Affected files:
  - `dashboard.py` (`/api/overview`, health/system helpers)
- Evidence:
  - source inspection of endpoint implementations
- Recommended fix:
  - cache short-lived system metrics (for example 2-5 seconds) for bursty polling

### PFM-03 Memory store caps are present but should be validated under long-run workload
- ID: `PFM-03`
- Severity: `P3`
- Impact: Without long-run verification, cap behavior under heavy OTLP ingress is uncertain.
- Likelihood: Medium
- Affected files:
  - `dashboard.py`
- Evidence:
  - bounded store constants and flush loop in runtime code
- Recommended fix:
  - add long-run memory profile artifact under `DEV-DOCS/reports/`
