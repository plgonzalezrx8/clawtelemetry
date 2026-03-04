# 00 Audit Scope and Method

## Date
2026-03-04

## Audit Goal
Provide decision-ready, evidence-backed engineering findings without modifying runtime code paths.

## In Scope
- runtime architecture and route surface
- auth, token, and state-management behavior
- reliability and startup behavior
- test and CI quality
- packaging/release compatibility
- documentation and code-comment quality

## Out of Scope
- full remediation implementation
- feature redesign
- product/marketing copy strategy

## Method
1. Static inspection of runtime and package modules.
2. Route inventory extraction from app url map.
3. Duplicate/function hotspot scans.
4. Isolated runtime smoke probes.
5. API test execution on isolated ports.
6. CI/workflow and packaging metadata review.

## Severity Rubric
- `P0`: critical exploitable or production-blocking issue
- `P1`: high-priority issue with significant risk
- `P2`: medium-priority correctness/maintainability issue
- `P3`: low-priority improvement or debt

## Finding Schema
Every finding records:
- ID
- Severity
- Impact
- Likelihood
- Affected files
- Evidence
- Recommended fix

## Key Inputs
- `dashboard.py`
- `history.py`
- `clawmetry/` package modules
- `tests/`
- `.github/workflows/`
- artifacts in `DEV-DOCS/reports/`
