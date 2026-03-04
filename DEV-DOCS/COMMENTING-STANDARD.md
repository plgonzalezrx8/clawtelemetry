# Commenting Standard

## Goal
Comments should explain intent, constraints, and risk boundaries, not restate obvious code.

## Required Comment Zones
- auth and security boundaries
- filesystem path traversal protections
- subprocess/network fallbacks
- compatibility hacks
- non-obvious data parsing rules

## Required Patterns
1. Module header for major sections in `dashboard.py`.
2. Function docstring for route handlers and helpers with side effects.
3. Intent comments before complex branches.
4. Risk comments for degraded/fallback behavior.

## Example: Good
```python
def read_workspace_file(relative_path: str) -> str:
    """Read a workspace-relative file while blocking traversal outside root."""
    full = os.path.realpath(os.path.join(workspace, relative_path))
    # Prevent user-supplied path from escaping workspace root.
    if not full.startswith(os.path.realpath(workspace)):
        raise ValueError("Path traversal blocked")
```

## Example: Avoid
```python
# join path
full = os.path.join(workspace, relative_path)
```

## Review Checklist
- Does the comment explain why this logic exists?
- Would a new maintainer understand the risk if this code is changed?
- Is the comment still true after the change?
