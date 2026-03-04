<p align="center">
  <img src=".github/branding/clawtelemetry-logo.webp" alt="ClawTelemetry Logo" width="320" />
</p>

<h1 align="center">ClawTelemetry</h1>

<p align="center"><strong>See your OpenClaw agents think, in real time.</strong></p>

<p align="center">
  Real-time observability for sessions, channels, usage, memory, logs, and flow behavior.
</p>

<p align="center">
  <a href="https://github.com/plgonzalezrx8/clawtelemetry/actions/workflows/ci.yml"><img src="https://github.com/plgonzalezrx8/clawtelemetry/actions/workflows/ci.yml/badge.svg" alt="CI" /></a>
  <a href="https://github.com/plgonzalezrx8/clawtelemetry/releases"><img src="https://img.shields.io/github/v/release/plgonzalezrx8/clawtelemetry" alt="Latest Release" /></a>
  <a href="https://github.com/plgonzalezrx8/clawtelemetry/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License" /></a>
</p>

![ClawTelemetry Hero](.github/branding/clawtelemetry-hero.webp)

## Why ClawTelemetry

- Zero-config startup on local machines
- Unified operational visibility across your OpenClaw runtime
- Lightweight architecture (single-file dashboard, no frontend build chain)
- Works well for local development and LAN dashboards

## Install (GitHub-only)

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/plgonzalezrx8/clawtelemetry/main/install.sh | bash
```

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/plgonzalezrx8/clawtelemetry/main/install.ps1 | iex
```

### Windows CMD

```cmd
curl -fsSL https://raw.githubusercontent.com/plgonzalezrx8/clawtelemetry/main/install.cmd -o install.cmd && install.cmd && del install.cmd
```

## Run

```bash
clawtelemetry --host 0.0.0.0 --port 8900
```

Open:
- `http://localhost:8900`
- `http://<your-lan-ip>:8900` (if LAN access is enabled and your firewall allows it)

Common options:

```bash
clawtelemetry --port 9000
clawtelemetry --host 127.0.0.1
clawtelemetry --workspace ~/mybot
clawtelemetry --name "Alice"
```

## Update

```bash
clawtelemetry update
```

- Pulls the latest GitHub Release.
- Automatically restarts a running background ClawTelemetry service after successful update.
- For CI/offline environments, disable periodic checks with `CLAWTELEMETRY_DISABLE_UPDATE_CHECK=1`.

## From Source

```bash
git clone https://github.com/plgonzalezrx8/clawtelemetry.git
cd clawtelemetry
python3 dashboard.py --host 0.0.0.0 --port 8900
```

## Dashboard Views

- Overview
- Usage
- Sessions
- Crons
- Logs
- Memory
- Transcripts
- Flow

## Screenshots

| Overview | Usage | Memory |
|---|---|---|
| ![Overview](.github/screenshots/phase2-overview.png) | ![Usage](.github/screenshots/phase2-tokens.png) | ![Memory](.github/screenshots/phase2-memory.png) |

| Brain | Overview (v3) | Usage (v3) |
|---|---|---|
| ![Brain](.github/screenshots/phase3-brain.png) | ![Overview v3](.github/screenshots/phase3-overview.png) | ![Usage v3](.github/screenshots/phase3-tokens.png) |

## Docs

- Architecture: [ARCHITECTURE.md](ARCHITECTURE.md)
- Cloud and remote-access notes: [docs/CLOUD_TESTING.md](docs/CLOUD_TESTING.md)
- Contributing: [CONTRIBUTING.md](CONTRIBUTING.md)
- Security policy: [SECURITY.md](SECURITY.md)
- Internal engineering docs: [DEV-DOCS/README.md](DEV-DOCS/README.md)

## License

MIT
