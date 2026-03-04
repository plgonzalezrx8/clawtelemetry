# ClawTelemetry Developer Docs (`DEV-DOCS`)

## Purpose
This directory is the internal engineering source of truth for:
- technical execution
- audit findings
- handoff context
- remediation tracking

Root docs remain canonical for public/open-source consumption. `DEV-DOCS` cross-links to root docs and adds engineering-operational depth.

## Reading Order
1. [00-START-HERE.md](./00-START-HERE.md)
2. [01-task-list.md](./01-task-list.md)
3. [DEVELOPMENT-STATUS.md](./DEVELOPMENT-STATUS.md)
4. [ARCHITECTURE.md](./ARCHITECTURE.md)
5. [CODING-STANDARDS.md](./CODING-STANDARDS.md)
6. [COMMENTING-STANDARD.md](./COMMENTING-STANDARD.md)
7. [SECURITY-GUIDELINES.md](./SECURITY-GUIDELINES.md)
8. [TESTING-PERFORMANCE.md](./TESTING-PERFORMANCE.md)
9. [project-structure.md](./project-structure.md)
10. [audit/README.md](./audit/README.md)

## Directory Layout
```text
DEV-DOCS/
├── README.md
├── 00-START-HERE.md
├── 01-task-list.md
├── ARCHITECTURE.md
├── CODING-STANDARDS.md
├── COMMENTING-STANDARD.md
├── SECURITY-GUIDELINES.md
├── TESTING-PERFORMANCE.md
├── DEVELOPMENT-STATUS.md
├── NEW-FILES-GUIDE.md
├── project-structure.md
├── work-log.md
├── features/
│   └── FEATURE-TEMPLATE.md
├── implementation/
│   ├── CRUD-PATTERNS.md
│   ├── UI-PATTERNS.md
│   ├── VALIDATION-PATTERNS.md
│   └── LESSONS-LEARNED.md
├── reports/
│   └── (command outputs, audit artifacts)
└── audit/
    ├── README.md
    ├── 00_AUDIT_SCOPE_AND_METHOD.md
    ├── 01_ARCHITECTURE_AND_MODULE_BOUNDARIES.md
    ├── 02_API_AND_INTERFACE_AUDIT.md
    ├── 03_DATA_FLOW_AND_STATE_AUDIT.md
    ├── 04_SECURITY_AND_PRIVACY.md
    ├── 05_RELIABILITY_AND_CORRECTNESS.md
    ├── 06_PERFORMANCE_AND_RESOURCE_USAGE.md
    ├── 07_TESTING_AND_CI_QUALITY.md
    ├── 08_PACKAGING_RELEASE_COMPATIBILITY.md
    ├── 09_DOCUMENTATION_AND_COMMENT_QUALITY.md
    ├── 10_REMEDIATION_ROADMAP.md
    └── 99_EVIDENCE_INDEX.md
```

## Root Docs Cross-Links
- Public product overview: [../README.md](../README.md)
- Public architecture: [../ARCHITECTURE.md](../ARCHITECTURE.md)
- Public changelog: [../CHANGELOG.md](../CHANGELOG.md)
- Contributing guide: [../CONTRIBUTING.md](../CONTRIBUTING.md)
- Security policy: [../SECURITY.md](../SECURITY.md)
- Build notes: [../BUILD_STATUS.md](../BUILD_STATUS.md)
- Upcoming ideas: [../UPCOMING.md](../UPCOMING.md)

## Maintenance Rules
- Update docs in the same change as code changes that affect behavior.
- Keep findings evidence-backed. Link report artifacts under `reports/`.
- Do not move or remove root docs unless explicitly planned.
- Follow the finding schema from `audit/00_AUDIT_SCOPE_AND_METHOD.md`.

## Documentation Contract
Every audit finding must include:
- `ID`
- `Severity` (`P0` to `P3`)
- `Impact`
- `Likelihood`
- `Affected files`
- `Evidence`
- `Recommended fix`
