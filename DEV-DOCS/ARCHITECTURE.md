# Internal Architecture

## System Shape
ClawTelemetry is a Python Flask dashboard with embedded frontend templates and runtime data collection.

Primary runtime assets:
- `dashboard.py`: server, API routes, embedded HTML/CSS/JS, CLI entrypoint, update check/update command logic
- `history.py`: optional local history/time-series collector
- `clawtelemetry/`: package helpers (CLI wrapper, sync daemon, providers, extensions)

## Entry Points
- `python3 dashboard.py`
- `clawtelemetry` console script -> `clawtelemetry.cli:main`

## Runtime Responsibilities
- auto-detect workspace, sessions, logs, gateway connection
- expose API surface for dashboard UI and integrations
- optionally receive OTLP metrics/traces (`/v1/metrics`, `/v1/traces`)
- optionally sync encrypted data to cloud via `clawtelemetry/sync.py`
- check latest GitHub release metadata at startup and on 24h cadence (cached, non-blocking)

## API Surface Summary
From runtime route inventory (`DEV-DOCS/reports/route-inventory-post-remediation-2026-03-04.txt`):
- total routes: `90`
- channel routes: `/api/channel/*` for many providers
- system/overview routes: `/api/overview`, `/api/health`, `/api/system-health`
- session/transcript routes: `/api/sessions`, `/api/transcript/*`, `/api/subagents`
- configuration/ops routes: gateway config/invoke/rpc, budget, alerts, history, fleet

`/api/overview` now also carries a cached `update` object used by the Overview update banner.

## Structural Risks
- single-file complexity in `dashboard.py` remains high (large surface and dense responsibilities)
- global mutable state coupling across auth/config/runtime code paths still raises regression risk
- broad exception swallowing remains in selected legacy paths and should be reduced

## External Integrations
- OpenClaw local files and gateway
- optional OTLP protobuf ingestion
- optional cloud ingest endpoint via sync daemon
- optional GitHub Release API metadata check for update notifications (disable with `CLAWTELEMETRY_DISABLE_UPDATE_CHECK=1`)

## Architectural Constraints
- keep single-file `dashboard.py` architecture
- no frontend build system
- no mandatory database dependency for core dashboard behavior
- maintain Raspberry Pi friendly resource usage
