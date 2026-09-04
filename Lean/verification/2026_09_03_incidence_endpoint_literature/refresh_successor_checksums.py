#!/usr/bin/env python3
"""Atomically refresh the five-file three-arm computation checksum list."""

from __future__ import annotations

import hashlib
import os
import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
DIRECTORY = (
    REPO
    / "research"
    / "computation"
    / "2026_09_03_three_arm_incidence_successor"
)
OUTPUT = DIRECTORY / "SHA256SUMS"
FILES = (
    "OUTPUT.csv",
    "OUTPUT.json",
    "README.md",
    "RUN.txt",
    "search_three_arm_successor.py",
)


def digest(path: Path) -> str:
    value = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1 << 20), b""):
            value.update(block)
    return value.hexdigest()


def main() -> int:
    if sys.flags.optimize != 0:
        raise SystemExit("checksum refresh forbids Python -O/PYTHONOPTIMIZE")
    missing = [name for name in FILES if not (DIRECTORY / name).is_file()]
    if missing:
        raise SystemExit(f"missing successor evidence: {missing}")
    temporary = OUTPUT.with_name(OUTPUT.name + ".tmp")
    temporary.write_text(
        "".join(f"{digest(DIRECTORY / name)}  {name}\n" for name in FILES),
        encoding="utf-8",
        newline="\n",
    )
    os.replace(temporary, OUTPUT)
    print(f"wrote {len(FILES)} entries to {OUTPUT.relative_to(REPO).as_posix()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
