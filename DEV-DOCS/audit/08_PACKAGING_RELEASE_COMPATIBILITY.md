# 08 Packaging, Release, and Compatibility

## Summary
Packaging is converged to a single GitHub-only distribution path. Release automation now triggers from `main` merges/pushes (or manual dispatch) and publishes once per dashboard version tag.

## Findings

### PKG-01 Legacy dual-package path was removed
- ID: `PKG-01`
- Severity: `P3`
- Impact: Risk addressed; no active dual-path package metadata remains.
- Likelihood: Low
- Affected files:
  - `setup.py`
- Evidence:
  - snapshot: `../reports/ci-packaging-snapshot-2026-03-04.txt`
  - legacy package path removed in rebrand pass
- Recommended fix:
  - maintain single authoritative build path (`setup.py`) and avoid reintroducing alias package wrappers

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

### PKG-03 Release automation remains mandatory
- ID: `PKG-03`
- Severity: `P3`
- Impact: Positive control; future changes could accidentally break release path.
- Likelihood: Medium
- Affected files:
  - `.github/workflows/publish.yml`
- Evidence:
  - workflow snapshot in `../reports/ci-packaging-snapshot-2026-03-04.txt`
  - current workflow behavior: push/merge to `main` publishes release for current `dashboard.py` version if tag does not yet exist
- Recommended fix:
  - include release workflow smoke checks in packaging/install/update refactor PRs
