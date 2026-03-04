# Project Structure (Engineering View)

```text
clawmetry/
├── dashboard.py                  # Main runtime (Flask app + embedded frontend + CLI logic)
├── history.py                    # Optional local history collector (SQLite)
├── clawmetry/
│   ├── __init__.py               # package version + main delegation
│   ├── cli.py                    # console command handlers (start/stop/status/connect)
│   ├── sync.py                   # cloud sync daemon and encryption pipeline
│   ├── config.py                 # config dataclass (partial migration scaffold)
│   ├── extensions.py             # plugin event registry
│   └── providers/
│       ├── base.py               # provider abstract interfaces
│       ├── local.py              # filesystem-backed provider
│       ├── turso.py              # cloud provider implementation
│       └── __init__.py           # provider registry/bootstrap
├── tests/
│   ├── conftest.py               # server bootstrap fixtures
│   ├── test_api.py               # API contract checks
│   ├── test_e2e.py               # local Playwright tests
│   └── test_e2e_browserstack.py  # BrowserStack tests
├── .github/workflows/            # CI, BrowserStack, publish, install-test workflows
├── docs/
│   └── CLOUD_TESTING.md          # deployment/testing guide
├── setup.py                      # main package build config
├── packages/clawmetry/setup.py   # alias package wrapper
└── DEV-DOCS/                     # internal engineering docs and audit dossier
```

## Ownership Boundaries
- runtime behavior: `dashboard.py`
- optional history persistence: `history.py`
- cloud and provider extensions: `clawmetry/`
- verification and regressions: `tests/` + `.github/workflows/`
- internal engineering knowledge: `DEV-DOCS/`
