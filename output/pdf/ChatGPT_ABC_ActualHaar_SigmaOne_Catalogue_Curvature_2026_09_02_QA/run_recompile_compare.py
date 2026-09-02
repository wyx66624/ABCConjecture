from __future__ import annotations

import hashlib
import json
from pathlib import Path

from pypdf import PdfReader


QA_DIR = Path(__file__).resolve().parent
PUBLISHED = QA_DIR.parent / "ChatGPT_ABC_Uniformity_2026.pdf"
RECOMPILED = QA_DIR / "recompile" / "ChatGPT_ABC_Uniformity_2026.pdf"
OUT = QA_DIR / "RECOMPILE_COMPARISON.json"


def text_pages(path: Path) -> tuple[PdfReader, list[str]]:
    reader = PdfReader(path, strict=True)
    return reader, [(page.extract_text() or "") for page in reader.pages]


def main() -> None:
    published_reader, published_text = text_pages(PUBLISHED)
    recompiled_reader, recompiled_text = text_pages(RECOMPILED)
    published_boxes = [
        (round(float(page.mediabox.width), 3), round(float(page.mediabox.height), 3))
        for page in published_reader.pages
    ]
    recompiled_boxes = [
        (round(float(page.mediabox.width), 3), round(float(page.mediabox.height), 3))
        for page in recompiled_reader.pages
    ]
    differing_text_pages = [
        index + 1
        for index, (left, right) in enumerate(zip(published_text, recompiled_text))
        if left != right
    ]
    result = {
        "verdict": "PASS"
        if len(published_reader.pages) == len(recompiled_reader.pages) == 202
        and not differing_text_pages
        and published_boxes == recompiled_boxes
        else "FAIL",
        "published_sha256": hashlib.sha256(PUBLISHED.read_bytes()).hexdigest(),
        "recompiled_sha256": hashlib.sha256(RECOMPILED.read_bytes()).hexdigest(),
        "published_bytes": PUBLISHED.stat().st_size,
        "recompiled_bytes": RECOMPILED.stat().st_size,
        "published_pages": len(published_reader.pages),
        "recompiled_pages": len(recompiled_reader.pages),
        "identical_extracted_text": not differing_text_pages,
        "differing_text_pages": differing_text_pages,
        "identical_media_boxes": published_boxes == recompiled_boxes,
        "note": "PDF byte hashes may differ because compilation metadata is time dependent; the audit compares every extracted page and every media box.",
    }
    OUT.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
