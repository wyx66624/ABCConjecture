#!/usr/bin/env python3
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent
MANIFEST = "FILE_MANIFEST.json"
SUMS = "SHA256SUMS"


def digest(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            h.update(block)
    return h.hexdigest().upper()


data = json.loads((ROOT / MANIFEST).read_text(encoding="utf-8"))
records = data["files"]
expected_payload = {
    p.relative_to(ROOT).as_posix()
    for p in ROOT.rglob("*")
    if p.is_file() and p.relative_to(ROOT).as_posix() not in {MANIFEST, SUMS}
}
assert {record["path"] for record in records} == expected_payload
assert data["file_count_excluding_manifest_and_sums"] == len(records)
for record in records:
    path = ROOT / record["path"]
    assert path.stat().st_size == record["bytes"], record["path"]
    assert digest(path) == record["sha256"], record["path"]

sum_records = {}
for line in (ROOT / SUMS).read_text(encoding="utf-8").splitlines():
    hash_value, rel = line.split(" *", 1)
    assert rel not in sum_records
    sum_records[rel] = hash_value
expected_sums = {
    p.relative_to(ROOT).as_posix()
    for p in ROOT.rglob("*")
    if p.is_file() and p.relative_to(ROOT).as_posix() != SUMS
}
assert set(sum_records) == expected_sums
for rel, hash_value in sum_records.items():
    assert digest(ROOT / rel) == hash_value, rel

print(json.dumps({
    "status": "PASS",
    "manifest_payload_files": len(records),
    "sha256sum_entries": len(sum_records),
    "manifest_sha256": digest(ROOT / MANIFEST),
    "sha256sums_sha256": digest(ROOT / SUMS),
}, indent=2))
