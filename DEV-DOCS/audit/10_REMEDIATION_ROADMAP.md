# 10 Remediation Roadmap

## Objective
Address high-risk architecture/auth/test determinism issues first, then tackle performance and packaging consistency.

## Progress Update (2026-03-04)
- Completed:
  - deduplicate `dashboard.py` duplicate top-level helper/runtime blocks
  - deterministic env-first gateway token precedence in `_load_gw_config`
  - duplicate definition guard script wired into CI lint and local `make lint`
- Remaining from `Now`:
  - targeted reduction of broad exception swallowing in critical auth/file/network paths

## Now (0-2 weeks)

| Action | Related Findings | Priority | Exit Criteria |
| --- | --- | --- | --- |
| Deduplicate `dashboard.py` duplicated runtime blocks and helper redefinitions | ARC-01, ARC-02, REL-03, PFM-01 | P1 | duplicate scan shows one definition per helper and one `DASHBOARD_HTML` block |
| Make token source precedence deterministic and testable | API-01, REL-02, TST-01 | P1 | startup/auth behavior documented and API tests pass with explicit test token mode |
| Harden readiness probing strategy in tests | REL-02, TST-01 | P1 | fixture no longer false-fails due token/source mismatch |
| Reduce broad exception swallowing in critical auth/file/network paths | SEC-03, DOC-02 | P2 | targeted exceptions + warning logs in prioritized paths |

## Next (2-6 weeks)

| Action | Related Findings | Priority | Exit Criteria |
| --- | --- | --- | --- |
| Normalize BrowserStack auth token injection key usage | TST-02 | P2 | browser tests use same key naming as runtime JS |
| Add short-lived caching for expensive system subprocess metrics | PFM-02 | P2 | overview/system endpoints avoid repeated heavy subprocess calls per poll burst |
| Align legacy packaging metadata or deprecate alias path | PKG-01, PKG-02 | P2 | one authoritative packaging contract documented and enforced |

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
