#!/usr/bin/env python3
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
MANIFEST = "FILE_MANIFEST.json"
SUMS = "SHA256SUMS"


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()


payload = sorted(
    p for p in HERE.rglob("*")
    if p.is_file() and p.relative_to(HERE).as_posix() not in {MANIFEST, SUMS}
)
records = [{
    "path": p.relative_to(HERE).as_posix(),
    "bytes": p.stat().st_size,
    "sha256": digest(p),
} for p in payload]

(HERE / MANIFEST).write_text(json.dumps({
    "generated_date": "2026-09-01",
    "scope": "Danilov divisor-pair WSS amplification finite computation",
    "file_count_excluding_manifest_and_sums": len(records),
    "files": records,
}, indent=2) + "\n", encoding="utf-8")

sum_files = sorted(
    p for p in HERE.rglob("*")
    if p.is_file() and p.relative_to(HERE).as_posix() != SUMS
)
(HERE / SUMS).write_text("\n".join(
    f"{digest(p)} *{p.relative_to(HERE).as_posix()}" for p in sum_files
) + "\n", encoding="utf-8")
print(json.dumps({"status": "PASS", "manifest_payload_files": len(records),
                  "sha256sum_entries": len(sum_files)}, indent=2))
