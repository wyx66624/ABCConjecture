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


payload = sorted(
    p for p in ROOT.rglob("*")
    if p.is_file() and p.relative_to(ROOT).as_posix() not in {MANIFEST, SUMS}
)
records = [
    {
        "path": p.relative_to(ROOT).as_posix(),
        "bytes": p.stat().st_size,
        "sha256": digest(p),
    }
    for p in payload
]
manifest = {
    "generated_date": "2026-09-01",
    "scope": "Danilov Fibonacci simple-primitive-divisor report, primary sources, and bounded exact evidence",
    "file_count_excluding_manifest_and_sums": len(records),
    "files": records,
}
(ROOT / MANIFEST).write_text(
    json.dumps(manifest, indent=2, ensure_ascii=False) + "\n",
    encoding="utf-8",
)

sum_files = sorted(
    p for p in ROOT.rglob("*")
    if p.is_file() and p.relative_to(ROOT).as_posix() != SUMS
)
lines = [
    f"{digest(p)} *{p.relative_to(ROOT).as_posix()}"
    for p in sum_files
]
(ROOT / SUMS).write_text("\n".join(lines) + "\n", encoding="utf-8")
print(json.dumps({
    "status": "PASS",
    "manifest_payload_files": len(records),
    "sha256sum_entries": len(lines),
}, indent=2))
