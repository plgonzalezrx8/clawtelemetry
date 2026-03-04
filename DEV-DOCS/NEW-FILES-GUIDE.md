# New Files Guide

## If You Are...

### Adding a new API endpoint
Read first:
- `DEV-DOCS/CODING-STANDARDS.md`
- `DEV-DOCS/implementation/VALIDATION-PATTERNS.md`
- `DEV-DOCS/implementation/CRUD-PATTERNS.md`

Then update:
- tests under `tests/`
- route inventory notes in audit docs if API surface changes

### Changing embedded UI behavior
Read first:
- `DEV-DOCS/implementation/UI-PATTERNS.md`
- `DEV-DOCS/CODING-STANDARDS.md`

Then update:
- e2e tests if selectors/flows changed
- docs if tab/route behavior changed

### Touching auth/security logic
Read first:
- `DEV-DOCS/SECURITY-GUIDELINES.md`
- `DEV-DOCS/COMMENTING-STANDARD.md`

Then update:
- security audit section in `DEV-DOCS/audit/04_SECURITY_AND_PRIVACY.md`
- evidence index with new validation commands

### Updating packaging/release behavior
Read first:
- `DEV-DOCS/audit/08_PACKAGING_RELEASE_COMPATIBILITY.md`

Then update:
- `CHANGELOG.md`
- relevant workflow docs/evidence
