# 10 Remediation Roadmap

## Objective
Address high-risk reliability/test determinism issues first, then tackle performance and packaging consistency.

## Progress Update (2026-03-04, refreshed)
### Completed Baseline Remediations
- deduplicated `dashboard.py` duplicate top-level helper/runtime blocks (ARC-01, ARC-02, REL-03, PFM-01)
- made gateway token resolution deterministic with env-first precedence (API-01, REL-02, TST-01)
- wired duplicate definition guard into CI lint and local `make lint`
- fixed duplicate startup summary behavior and bind-host launch hint consistency
- added built-in version checks and `clawtelemetry update` command (post-baseline hardening)

### Remaining Priority Work
- targeted reduction of broad exception swallowing in critical auth/file/network paths
- deterministic release-install-update lifecycle validation in CI
- long-run performance artifacts for sustained sessions

## Now (0-2 weeks)

| Action | Related Findings | Priority | Exit Criteria |
| --- | --- | --- | --- |
| Harden readiness probing strategy in tests to avoid stale localhost contamination and token ambiguity | REL-02, TST-01 | P1 | fixture reliably verifies health on isolated server/port/token mode |
| Reduce broad exception swallowing in critical auth/file/network paths | SEC-03, DOC-02 | P2 | targeted exceptions + warning logs in prioritized paths |
| Add release-install-update end-to-end smoke check against GitHub release assets | PKG-03, TST-03 | P2 | CI validates install + `clawtelemetry --version` + update-path no-op on latest |
| Document and enforce dependency policy between `requirements.txt` and `setup.py` | PKG-02 | P2 | explicit dev/runtime dependency policy in CONTRIBUTING and CI checks |

## Next (2-6 weeks)

| Action | Related Findings | Priority | Exit Criteria |
| --- | --- | --- | --- |
| Normalize BrowserStack auth token injection key usage | TST-02 | P2 | BrowserStack tests use same key naming as runtime JS |
| Add short-lived caching for expensive system subprocess metrics | PFM-02 | P2 | overview/system endpoints avoid repeated heavy subprocess calls per poll burst |
| Add route-contract snapshot check to catch accidental API drift | API-03, TST-03 | P2 | route inventory assertion in CI with intentional-update workflow |

## Later (6+ weeks)

| Action | Related Findings | Priority | Exit Criteria |
| --- | --- | --- | --- |
| Add long-run memory/resource benchmark artifacts | PFM-03 | P3 | baseline 1h profile artifacts under `DEV-DOCS/reports/` |
| Continuous docs quality checks (comment density and TODO hygiene) | DOC-02, DOC-03 | P3 | recurring report generation integrated with CI or release checklist |

## Ownership Template
- Owner:
- Target date:
- Status:
- Validation command(s):
- Linked PR(s):
