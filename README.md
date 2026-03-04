# ClawTelemetry

Real-time observability dashboard for OpenClaw agents.

ClawTelemetry stays zero-config by default: run it, point your browser to `http://localhost:8900`, and inspect live activity across sessions, channels, logs, usage, and memory.

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

Common options:

```bash
clawtelemetry --port 9000
clawtelemetry --host 127.0.0.1
clawtelemetry --workspace ~/mybot
clawtelemetry --name "Alice"
```

## From Source

```bash
git clone https://github.com/plgonzalezrx8/clawtelemetry.git
cd clawtelemetry
python3 dashboard.py --host 0.0.0.0 --port 8900
```

## What You Get

- Flow visualization for agent/channel interactions
- Overview health and activity status
- Usage and cost telemetry
- Sessions and transcript inspection
- Cron status and execution history
- Real-time logs
- Memory browser (SOUL.md, MEMORY.md, AGENTS.md, notes)

## Screenshots

| Overview | Usage | Memory |
|---|---|---|
| ![Overview](.github/screenshots/phase2-overview.png) | ![Usage](.github/screenshots/phase2-tokens.png) | ![Memory](.github/screenshots/phase2-memory.png) |

| Brain | Overview (v3) | Usage (v3) |
|---|---|---|
| ![Brain](.github/screenshots/phase3-brain.png) | ![Overview v3](.github/screenshots/phase3-overview.png) | ![Usage v3](.github/screenshots/phase3-tokens.png) |

## Docs

- Architecture: [ARCHITECTURE.md](ARCHITECTURE.md)
- Cloud and remote access notes: [docs/CLOUD_TESTING.md](docs/CLOUD_TESTING.md)
- Contributing: [CONTRIBUTING.md](CONTRIBUTING.md)
- Security policy: [SECURITY.md](SECURITY.md)

## License

MIT
