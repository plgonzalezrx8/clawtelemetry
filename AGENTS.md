# AGENTS.md — For AI Coding Agents

## Quick Context
ClawTelemetry = open-source observability dashboard for OpenClaw AI agents. Single Python file, zero config, auto-detects everything.

## Rules
- **Don't split dashboard.py** — the single-file architecture is a feature, not a bug
- **Don't add heavy dependencies** — Flask is the only required dependency
- **Don't add a build step** — frontend is embedded in Python, no npm/webpack/vite
- **Keep auto-detection working** — if you add a feature, it should work without config
- **Performance matters** — this runs on Raspberry Pis. Keep it light (<100MB RAM)
- **Read-only principle** — ClawTelemetry observes agents, it doesn't control them

## Common Tasks
- **Add a new API endpoint**: Add `@app.route` in dashboard.py, follow existing patterns
- **Update the UI**: Edit HTML template strings in dashboard.py (search for the route's `render_template_string`)
- **Add a new dashboard view**: Add route + template + navigation link
- **Bump version**: Update `__version__` in dashboard.py and `setup.py`

## Publishing
Use GitHub Releases only (no PyPI distribution in this repo).
Tag format: `vX.Y.Z`, then publish release assets via `.github/workflows/publish.yml`.

## Don't
- Don't introduce React/Vue/Angular — vanilla JS only
- Don't require a database for core functionality (history.py is optional)
- Don't make external network calls from the dashboard
- Don't store user data outside the local machine
- Don't break backward compatibility with older OpenClaw versions
