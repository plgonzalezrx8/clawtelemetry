#!/usr/bin/env python3
"""
Fail-fast guard for duplicate top-level definitions in dashboard.py.

Why this exists:
- duplicate function and constant definitions can silently shadow behavior
- shadowing is especially risky in this repo's single-file architecture

Checks:
1) duplicate top-level function names
2) duplicate top-level constant names (UPPER_SNAKE_CASE)
"""

from __future__ import annotations

import ast
import collections
import re
import sys
from pathlib import Path

_CONSTANT_RE = re.compile(r"^[A-Z][A-Z0-9_]*$")


def _iter_top_level_constants(module: ast.Module):
    """Yield top-level constant names from Assign/AnnAssign nodes."""
    for node in module.body:
        if isinstance(node, ast.Assign):
            for target in node.targets:
                if isinstance(target, ast.Name) and _CONSTANT_RE.match(target.id):
                    yield target.id
        elif isinstance(node, ast.AnnAssign):
            target = node.target
            if isinstance(target, ast.Name) and _CONSTANT_RE.match(target.id):
                yield target.id


def main() -> int:
    """Run duplicate checks and exit non-zero when duplicates are found."""
    path = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("dashboard.py")
    if not path.exists():
        print(f"[dup-check] file not found: {path}")
        return 2

    source = path.read_text(encoding="utf-8")
    module = ast.parse(source, filename=str(path))

    fn_counts = collections.Counter(
        node.name
        for node in module.body
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef))
    )
    const_counts = collections.Counter(_iter_top_level_constants(module))

    dup_fns = {name: count for name, count in fn_counts.items() if count > 1}
    dup_consts = {name: count for name, count in const_counts.items() if count > 1}

    if not dup_fns and not dup_consts:
        print("[dup-check] PASS: no duplicate top-level functions/constants")
        return 0

    print("[dup-check] FAIL: duplicate top-level definitions detected")
    if dup_fns:
        print("  functions:")
        for name, count in sorted(dup_fns.items()):
            print(f"    - {name}: {count}")
    if dup_consts:
        print("  constants:")
        for name, count in sorted(dup_consts.items()):
            print(f"    - {name}: {count}")

    return 1


if __name__ == "__main__":
    raise SystemExit(main())
