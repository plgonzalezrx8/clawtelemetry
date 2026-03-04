# 01 Task List

## In Progress
- [ ] TSK-003 Tighten error handling in high-risk API/IO paths (replace broad `except Exception: pass` where practical)

## Completed
- [x] TSK-100 Create `DEV-DOCS` structure
- [x] TSK-101 Create engineering audit dossier under `DEV-DOCS/audit`
- [x] TSK-102 Generate evidence exports in `DEV-DOCS/reports`
- [x] TSK-103 Define standards for coding, commenting, testing, and security docs
- [x] TSK-001 Resolve duplicated runtime/function blocks in `dashboard.py` without splitting file
- [x] TSK-002 Make test startup deterministic independent of existing `~/.clawmetry-gateway.json`
- [x] TSK-104 Add duplicate definition guard to CI and local lint workflow

## Backlog
- [ ] TSK-200 Add automated comment-density check integrated with CI (non-blocking first)
- [ ] TSK-201 Add endpoint contract test for all registered Flask routes
- [ ] TSK-202 Add benchmark script for memory/CPU profile on long-running dashboard sessions

## Blockers
- None for docs/audit phase.
