#!/usr/bin/env python3
from __future__ import annotations

import hashlib
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
OUTPUT = HERE / "FILE_MANIFEST.json"
GENERATED_NAMES = {"depth3_scan_extended.exe"}


def is_evidence_file(path: Path) -> bool:
    relative = path.relative_to(HERE)
    return (
        path.is_file()
        and path != OUTPUT
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
    files = sorted(
        path for path in HERE.rglob("*") if is_evidence_file(path)
    )
    data = {
        "algorithm": "sha256",
        "file_count": len(files),
        "files": [
            {
                "bytes": path.stat().st_size,
                "path": path.relative_to(HERE).as_posix(),
                "sha256": sha256(path),
            }
            for path in files
        ],
    }
    OUTPUT.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps({"file_count": len(files), "output": str(OUTPUT)}, indent=2))


if __name__ == "__main__":
    main()
