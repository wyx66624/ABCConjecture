#!/usr/bin/env python3
"""Build page contact sheets and a hash manifest for final PDF visual QA."""

from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path

from PIL import Image, ImageDraw


HERE = Path(__file__).resolve().parent
REPO_ROOT = HERE.parents[2]
QA_DIR = REPO_ROOT / "tmp" / "pdfs" / "abc_dual_route_qa_2026_08_31"
PAGE_RE = re.compile(r"page-(\d+)\.png$")


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main() -> None:
    pages = sorted(
        (path for path in QA_DIR.glob("page-*.png") if PAGE_RE.match(path.name)),
        key=lambda path: int(PAGE_RE.match(path.name).group(1)),
    )
    if len(pages) != 102:
        raise RuntimeError(f"expected 102 page renders, found {len(pages)}")

    manifest: dict[str, object] = {"page_count": len(pages), "pages": [], "contacts": []}
    for path in pages:
        with Image.open(path) as image:
            manifest["pages"].append(
                {
                    "page": int(PAGE_RE.match(path.name).group(1)),
                    "file": path.relative_to(REPO_ROOT).as_posix(),
                    "width": image.width,
                    "height": image.height,
                    "sha256": sha256(path),
                }
            )

    for start in range(0, len(pages), 6):
        batch = pages[start : start + 6]
        canvas = Image.new("RGB", (1820, 1760), (225, 225, 225))
        draw = ImageDraw.Draw(canvas)
        covered: list[int] = []
        for slot, path in enumerate(batch):
            page_number = int(PAGE_RE.match(path.name).group(1))
            covered.append(page_number)
            with Image.open(path) as image:
                thumb = image.convert("RGB")
                thumb.thumbnail((580, 820), Image.Resampling.LANCZOS)
            column = slot % 3
            row = slot // 3
            x = 20 + column * 600
            y = 38 + row * 870
            draw.text((x, y - 24), f"Page {page_number}", fill=(0, 0, 0))
            draw.rectangle(
                (x - 1, y - 1, x + thumb.width, y + thumb.height),
                outline=(80, 80, 80),
            )
            canvas.paste(thumb, (x, y))
        contact = QA_DIR / f"contact-{covered[0]:03d}-{covered[-1]:03d}.png"
        canvas.save(contact, optimize=True)
        manifest["contacts"].append(
            {
                "pages": covered,
                "file": contact.relative_to(REPO_ROOT).as_posix(),
                "sha256": sha256(contact),
            }
        )

    (HERE / "render-manifest.json").write_text(
        json.dumps(manifest, indent=2) + "\n", encoding="utf-8"
    )
    print(json.dumps({"pages": len(pages), "contacts": len(manifest["contacts"])}, indent=2))


if __name__ == "__main__":
    main()
