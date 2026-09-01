#!/usr/bin/env python3
from __future__ import annotations

import hashlib
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
MANIFEST = HERE / "FILE_MANIFEST.json"
GENERATED_NAMES = {"depth3_scan_extended.exe"}


def is_evidence_file(path: Path) -> bool:
    relative = path.relative_to(HERE)
    return (
        path.is_file()
        and path != MANIFEST
        and path.name not in GENERATED_NAMES
        and "__pycache__" not in relative.parts
        and path.suffix not in {".pyc", ".pyo"}
    )


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1 << 20), b""):
            digest.update(block)
    return digest.hexdigest()


def main() -> None:
    data = json.loads(MANIFEST.read_text(encoding="utf-8"))
    expected = {entry["path"]: entry for entry in data["files"]}
    actual_paths = {
        path.relative_to(HERE).as_posix()
        for path in HERE.rglob("*")
        if is_evidence_file(path)
    }
    assert actual_paths == set(expected), (sorted(actual_paths - set(expected)), sorted(set(expected) - actual_paths))
    for rel, entry in expected.items():
        path = HERE / rel
        assert path.stat().st_size == entry["bytes"], rel
        assert sha256(path) == entry["sha256"], rel
    assert data["file_count"] == len(expected)
    print(json.dumps({"file_count": len(expected), "verification": "PASS"}, indent=2))


if __name__ == "__main__":
    main()
