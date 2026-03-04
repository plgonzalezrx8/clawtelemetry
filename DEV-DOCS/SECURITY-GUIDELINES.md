# Security Guidelines

## Security Model
ClawTelemetry is a local observability tool with optional cloud sync. Core principle: least privilege and local data control.

## Auth and Access
- API routes under `/api/*` require gateway token validation when configured.
- `/api/auth/check` remains the auth bootstrap route.
- Fleet endpoints use separate key-based auth model.

## Token Handling
- Never log plaintext tokens.
- Avoid committing machine-local token files.
- Treat `~/.clawtelemetry-gateway.json` as sensitive local configuration.

## Filesystem Safety
- Always enforce workspace-root checks for file reads.
- Block path traversal in any user-controlled path input.
- Prefer explicit allowlists for readable files when possible.

## Network Safety
- Do not add external network calls from core dashboard paths.
- Cloud sync encryption remains client-side responsibility.
- Keep default host binding local unless user explicitly opts into broader exposure.

## Operational Hardening
- When binding `0.0.0.0`, require reverse proxy auth/TLS externally.
- Keep SSE endpoints bounded (duration and client caps).
- Review any subprocess calls for injection and unsafe shell interpolation.

## Secure Change Checklist
- [ ] auth behavior unchanged or intentionally updated with tests
- [ ] no new token exposure in logs/errors
- [ ] file/path validation retained
- [ ] dependency changes reviewed for risk
