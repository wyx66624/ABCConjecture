#!/usr/bin/env python3
"""Verify SHA256SUMS.txt and reject missing or unlisted regular files."""

from __future__ import annotations

import hashlib
from pathlib import Path


def main() -> None:
    root = Path(__file__).resolve().parent
    manifest = root / "SHA256SUMS.txt"
    expected = {}
    for line in manifest.read_text(encoding="utf-8").splitlines():
        digest, name = line.split("  ", 1)
        expected[name] = digest
    actual_names = sorted(
        p.name for p in root.iterdir() if p.is_file() and p.name != manifest.name
    )
    if sorted(expected) != actual_names:
        raise SystemExit("FAIL: manifest file list mismatch")
    for name, digest in expected.items():
        actual = hashlib.sha256((root / name).read_bytes()).hexdigest()
        if actual != digest:
            raise SystemExit(f"FAIL: hash mismatch for {name}")
    print(f"PASS: {len(expected)} files match SHA256SUMS.txt")


if __name__ == "__main__":
    main()
