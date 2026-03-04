# 01 Task List

## In Progress
- [ ] TSK-003 Tighten error handling in high-risk API/IO paths (replace broad `except Exception: pass` where practical)

## Completed
- [x] TSK-100 Create `DEV-DOCS` structure
- [x] TSK-101 Create engineering audit dossier under `DEV-DOCS/audit`
- [x] TSK-102 Generate evidence exports in `DEV-DOCS/reports`
- [x] TSK-103 Define standards for coding, commenting, testing, and security docs
- [x] TSK-001 Resolve duplicated runtime/function blocks in `dashboard.py` without splitting file
- [x] TSK-002 Make test startup deterministic independent of existing `~/.clawtelemetry-gateway.json`
- [x] TSK-104 Add duplicate definition guard to CI and local lint workflow
- [x] TSK-300 Rebrand runtime/package/install/docs from `clawmetry` to `clawtelemetry`
- [x] TSK-301 Replace PyPI publish flow with GitHub Release assets workflow
- [x] TSK-302 Rewrite install scripts for GitHub archive/tag installation
- [x] TSK-303 Add CI guard to block legacy brand token reintroduction
- [x] TSK-304 Fix duplicate startup summary in debug reloader and align network binding launch hints
- [x] TSK-305 Add built-in version check loop (startup + 24h cadence) and cached update state
- [x] TSK-306 Add Overview update notice and `clawtelemetry update` CLI command
- [x] TSK-307 Align branch model (`main` + `development`) and CI trigger coverage

## Backlog
- [ ] TSK-200 Add automated comment-density check integrated with CI (non-blocking first)
- [ ] TSK-201 Add endpoint contract test for all registered Flask routes
- [ ] TSK-202 Add benchmark script for memory/CPU profile on long-running dashboard sessions
- [ ] TSK-203 Add release-install-update end-to-end smoke test from latest GitHub release artifact

## Blockers
- None currently.
