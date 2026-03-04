# 08 Packaging, Release, and Compatibility

## Summary
Primary packaging path is coherent, but legacy/alias packaging metadata appears stale and can cause confusion.

## Findings

### PKG-01 Dual setup.py paths have divergent metadata and versioning
- ID: `PKG-01`
- Severity: `P2`
- Impact: Maintainers and automation can target outdated package definitions accidentally.
- Likelihood: Medium
- Affected files:
  - `setup.py`
  - `packages/clawmetry/setup.py`
- Evidence:
  - snapshot: `../reports/ci-packaging-snapshot-2026-03-04.txt`
  - alias package references older naming/version strategy
- Recommended fix:
  - document authoritative build path and deprecate/align legacy alias package metadata

### PKG-02 Requirements and package install dependencies are not fully aligned
- ID: `PKG-02`
- Severity: `P2`
- Impact: dev installs via `requirements.txt` can differ from package runtime dependencies.
- Likelihood: Medium
- Affected files:
  - `requirements.txt`
  - `setup.py`
- Evidence:
  - `requirements.txt` vs `setup.py install_requires` snapshot in `../reports/ci-packaging-snapshot-2026-03-04.txt`
- Recommended fix:
  - define explicit policy for dev vs package deps and document rationale in CONTRIBUTING

### PKG-03 Release automation exists and should be preserved during cleanup
- ID: `PKG-03`
- Severity: `P3`
- Impact: Positive control; cleanup work could accidentally break publish path.
- Likelihood: Medium
- Affected files:
  - `.github/workflows/publish.yml`
- Evidence:
  - workflow snapshot in `../reports/ci-packaging-snapshot-2026-03-04.txt`
- Recommended fix:
  - include publish workflow smoke check in any packaging refactor PR
