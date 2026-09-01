#!/usr/bin/env python3
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()


manifest = json.loads((HERE / "FILE_MANIFEST.json").read_text(encoding="utf-8"))
assert manifest["file_count_excluding_manifest_and_sums"] == len(manifest["files"])
for row in manifest["files"]:
    path = HERE / row["path"]
    assert path.is_file()
    assert path.stat().st_size == row["bytes"]
    assert digest(path) == row["sha256"]

for line in (HERE / "SHA256SUMS").read_text(encoding="utf-8").splitlines():
    expected, rel = line.split(" *", 1)
    assert digest(HERE / rel) == expected

print(json.dumps({"status": "PASS", "manifest_files": len(manifest["files"])}))
