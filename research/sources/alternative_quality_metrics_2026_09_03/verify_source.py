#!/usr/bin/env python3
"""Verify the archived Sankaran arXiv source capsule with the standard library."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parent
METADATA = ROOT / "source-metadata.json"


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def main() -> None:
    metadata = json.loads(METADATA.read_text(encoding="utf-8"))
    checks: list[dict[str, object]] = []
    for name, record in metadata["files"].items():
        path = ROOT / name
        actual = sha256(path)
        expected = record["sha256"]
        checks.append(
            {
                "file": name,
                "bytes": path.stat().st_size,
                "expectedSha256": expected,
                "actualSha256": actual,
                "pass": actual == expected,
            }
        )

    pdf_path = ROOT / "Sankaran_Alternative_Quality_Metrics_arXiv2606.08416v1.pdf"
    text_path = ROOT / "Sankaran_Alternative_Quality_Metrics_arXiv2606.08416v1.txt"
    pdf_header_ok = pdf_path.read_bytes().startswith(b"%PDF-")
    text = text_path.read_text(encoding="utf-8")
    forbidden_controls = [
        {"offset": index, "codepoint": ord(char)}
        for index, char in enumerate(text)
        if ord(char) < 32 and char not in "\n\t"
    ]

    status = (
        all(bool(check["pass"]) for check in checks)
        and pdf_header_ok
        and not forbidden_controls
        and metadata["source"]["arxiv"] == "2606.08416v1"
        and metadata["source"]["pages"] == 24
    )
    result = {
        "schema": "abc-alternative-quality-source-capsule-v1",
        "status": "PASS" if status else "FAIL",
        "arxiv": metadata["source"]["arxiv"],
        "declaredPages": metadata["source"]["pages"],
        "pdfHeader": pdf_header_ok,
        "textForbiddenControls": forbidden_controls,
        "files": checks,
    }
    print(json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True))
    if not status:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
