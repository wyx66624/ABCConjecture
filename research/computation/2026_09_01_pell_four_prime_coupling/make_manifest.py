#!/usr/bin/env python3
"""Freeze SHA-256 hashes of every portable evidence file in this directory."""

import hashlib
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE / "SHA256SUMS"
EXCLUDED = {"SHA256SUMS"}


def included(path: Path) -> bool:
    return (
        path.is_file()
        and path.name not in EXCLUDED
        and path.suffix.lower() != ".exe"
        and "__pycache__" not in path.parts
    )


lines = []
for path in sorted((p for p in HERE.rglob("*") if included(p)), key=lambda p: p.as_posix()):
    digest = hashlib.sha256(path.read_bytes()).hexdigest()
    lines.append(f"{digest}  {path.relative_to(HERE).as_posix()}")
OUT.write_text("\n".join(lines) + "\n", encoding="ascii", newline="\n")
print(f"manifest_files={len(lines)}")
print(f"manifest={OUT}")
