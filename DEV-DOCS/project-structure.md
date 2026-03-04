# Project Structure (Engineering View)

```text
clawtelemetry/
├── dashboard.py                  # Main runtime (Flask app + embedded frontend + CLI logic)
├── history.py                    # Optional local history collector (SQLite)
├── clawtelemetry/
│   ├── __init__.py               # package version + main delegation
│   ├── cli.py                    # wrapper CLI (connect/disconnect/status) + delegation to dashboard main
│   ├── sync.py                   # cloud sync daemon and encryption pipeline
│   ├── config.py                 # config dataclass (partial migration scaffold)
│   ├── extensions.py             # plugin event registry
│   └── providers/
│       ├── base.py               # provider abstract interfaces
│       ├── local.py              # filesystem-backed provider
│       ├── turso.py              # cloud provider implementation
│       └── __init__.py           # provider registry/bootstrap
├── scripts/
│   └── check_dashboard_duplicates.py  # static guard for duplicate top-level definitions
├── tests/
│   ├── conftest.py               # server bootstrap fixtures
│   ├── test_api.py               # API contract checks
│   ├── test_e2e.py               # local Playwright tests
│   └── test_e2e_browserstack.py  # BrowserStack tests
├── .github/workflows/            # CI, BrowserStack, publish, install-test workflows
├── docs/
│   └── CLOUD_TESTING.md          # deployment/testing guide
├── setup.py                      # main package build config
└── DEV-DOCS/                     # internal engineering docs and audit dossier
```

## Ownership Boundaries
- runtime behavior and embedded frontend: `dashboard.py`
- optional history persistence: `history.py`
- cloud sync and provider extensions: `clawtelemetry/`
- static guards and local automation scripts: `scripts/`
- verification and regressions: `tests/` + `.github/workflows/`
- internal engineering knowledge and status tracking: `DEV-DOCS/`
