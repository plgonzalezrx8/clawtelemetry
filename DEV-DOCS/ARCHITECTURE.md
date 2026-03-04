# Internal Architecture

## System Shape
ClawTelemetry is a Python Flask dashboard with embedded frontend templates and runtime data collection.

Primary runtime assets:
- `dashboard.py`: server, API routes, embedded HTML/CSS/JS, CLI entrypoint
- `history.py`: optional local history/time-series collector
- `clawtelemetry/`: package helpers (CLI, sync daemon, providers, extensions)

## Entry Points
- `python3 dashboard.py`
- `clawtelemetry` console script -> `clawtelemetry.cli:main`

## Runtime Responsibilities
- auto-detect workspace, sessions, logs, gateway connection
- expose API surface for dashboard UI and integrations
- optionally receive OTLP metrics/traces (`/v1/metrics`, `/v1/traces`)
- optionally sync encrypted data to cloud via `clawtelemetry/sync.py`

## API Surface Summary
From runtime route inventory (`DEV-DOCS/reports/route-inventory-2026-03-04.txt`):
- total routes: `90`
- channel routes: `/api/channel/*` for many providers
- system/overview routes: `/api/overview`, `/api/health`, `/api/system-health`
- session/transcript routes: `/api/sessions`, `/api/transcript/*`, `/api/subagents`
- configuration/ops routes: gateway config/invoke/rpc, budget, alerts, history, fleet

## Structural Risks
- duplicate implementations exist in `dashboard.py` (duplicate helper functions and duplicate `DASHBOARD_HTML` definitions)
- multiple app initialization blocks can cause maintenance drift
- heavy global state coupling across auth/config/runtime code paths

## External Integrations
- OpenClaw local files and gateway
- optional OTLP protobuf ingestion
- optional cloud ingest endpoint via sync daemon

## Architectural Constraints
- keep single-file `dashboard.py` architecture
- no frontend build system
- no mandatory database dependency for core dashboard behavior
- maintain Raspberry Pi friendly resource usage
