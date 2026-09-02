#!/usr/bin/env python3
"""Verify SHA256SUMS.txt without trusting platform-specific hash tools."""

from __future__ import annotations

import hashlib
from pathlib import Path


here = Path(__file__).resolve().parent
errors = []
rows = []
for line in (here / "SHA256SUMS.txt").read_text(encoding="utf-8").splitlines():
    if not line.strip():
        continue
    expected, name = line.split("  ", 1)
    path = here / name
    actual = hashlib.sha256(path.read_bytes()).hexdigest()
    rows.append(name)
    if actual != expected:
        errors.append(name)
print(f"{'PASS' if not errors else 'FAIL'} files={len(rows)}")
if errors:
    print("mismatches:", ", ".join(errors))
raise SystemExit(1 if errors else 0)
