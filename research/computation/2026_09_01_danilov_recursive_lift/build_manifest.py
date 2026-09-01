#!/usr/bin/env python3
"""Build the deterministic evidence manifest and SHA256SUMS file."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
EXCLUDE = {"FILE_MANIFEST.json", "SHA256SUMS", "manifest_build_stdout.json"}
CANONICAL_STAGES = [
    "search_stage0_1m.json", "search_stage1_1m.json",
    "search_stage2_1m.json", "search_stage3_1m.json",
    "search_stage4_1m.json", "search_stage5_1m.json",
    "search_stage6_1m.json", "search_stage7_10m.json",
    "search_stage8_10m.json", "search_stage9_10m.json",
    "search_stage10_50m.json", "search_stage11_50m.json",
    "search_stage12_100m.json", "search_stage13_100m.json",
]


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def evidence_files() -> list[Path]:
    return sorted(
        p for p in HERE.iterdir()
        if p.is_file() and p.name not in EXCLUDE
    )


def main() -> None:
    files = evidence_files()
    manifest = {
        "scope": "Danilov recursive-lift theorem, countermodels, and bounded exact evidence",
        "date": "2026-09-01",
        "canonical_stage_files": CANONICAL_STAGES,
        "external_primary_source": {
            "path": "research/sources/alternative_counterexample_2026_08_31/Yabuta_Carmichael_Primitive_Divisors_2001.pdf",
            "bytes": 1695369,
            "sha256": "69543ae7c2fd2193ce633a5cfbae1f448204f114fd07da11b3add2ef694eff70",
        },
        "files": [
            {"path": p.name, "bytes": p.stat().st_size, "sha256": digest(p)}
            for p in files
        ],
    }
    manifest_path = HERE / "FILE_MANIFEST.json"
    manifest_path.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8")

    sum_files = sorted(files + [manifest_path], key=lambda p: p.name)
    sums = "".join(f"{digest(p)}  {p.name}\n" for p in sum_files)
    (HERE / "SHA256SUMS").write_text(sums, encoding="utf-8")
    print(json.dumps({
        "manifest_files": len(files),
        "manifest_sha256": digest(manifest_path),
        "sha256sums_sha256": digest(HERE / "SHA256SUMS"),
    }, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
