#!/usr/bin/env python3
"""Verify every frozen primary source referenced by source-metadata.json."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def verify_file(entry: dict[str, object]) -> None:
    path = (HERE / str(entry["path"])).resolve()
    if not path.is_file():
        raise SystemExit(f"missing source: {path}")
    expected_bytes = int(entry["bytes"])
    actual_bytes = path.stat().st_size
    if actual_bytes != expected_bytes:
        raise SystemExit(
            f"byte mismatch for {path}: {actual_bytes} != {expected_bytes}"
        )
    expected_hash = str(entry["sha256"])
    actual_hash = sha256(path)
    if actual_hash != expected_hash:
        raise SystemExit(
            f"SHA-256 mismatch for {path}: {actual_hash} != {expected_hash}"
        )
    print(f"PASS {entry['path']} {actual_bytes} {actual_hash}")


def main() -> None:
    metadata = json.loads((HERE / "source-metadata.json").read_text(encoding="utf-8"))
    expected_commit = metadata["projectLana"]["mainCommit"]
    remote_record = (HERE / "REMOTE_HEAD.txt").read_text(encoding="utf-8")
    if remote_record.count(expected_commit) < 2:
        raise SystemExit(
            "REMOTE_HEAD.txt does not record the expected HEAD and main commit"
        )

    entries = list(metadata["projectLana"]["files"]) + list(metadata["papers"])
    for entry in entries:
        verify_file(entry)
    print(f"PASS Project LANA recorded main commit {expected_commit}")
    print(f"PASS {len(entries)} referenced primary-source files")


if __name__ == "__main__":
    main()

