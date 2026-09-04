#!/usr/bin/env python3
"""Build labelled contact sheets and preserve representative full-page renders."""

from __future__ import annotations

import hashlib
import json
import shutil
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont


HERE = Path(__file__).resolve().parent
PAGES = HERE / "_render_all"
CONTACTS = HERE / "contact_sheets"
SELECTED = HERE / "selected_pages"
COLS, ROWS = 6, 4
CELL_W, CELL_H = 290, 400
THUMB_W, THUMB_H = 260, 360
SELECTED_PAGES = [
    1, 2, 4, 169, 170, 171, 172, 205, 207, 208, 209, 210, 211, 212, 227, 240, 246
]


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1 << 20), b""):
            digest.update(block)
    return digest.hexdigest()


def main() -> None:
    pages = sorted(PAGES.glob("page-*.png"))
    if len(pages) != 246:
        raise SystemExit(f"expected 246 rendered pages, found {len(pages)}")
    CONTACTS.mkdir(parents=True, exist_ok=True)
    SELECTED.mkdir(parents=True, exist_ok=True)
    font = ImageFont.load_default()
    per_sheet = COLS * ROWS
    contact_paths: list[Path] = []
    for offset in range(0, len(pages), per_sheet):
        batch = pages[offset : offset + per_sheet]
        sheet = Image.new("RGB", (COLS * CELL_W, ROWS * CELL_H), "white")
        draw = ImageDraw.Draw(sheet)
        for position, page in enumerate(batch):
            with Image.open(page) as source:
                thumb = source.convert("RGB")
                thumb.thumbnail((THUMB_W, THUMB_H), Image.Resampling.LANCZOS)
            col, row = position % COLS, position // COLS
            x = col * CELL_W + (CELL_W - thumb.width) // 2
            y = row * CELL_H + 22
            sheet.paste(thumb, (x, y))
            page_number = offset + position + 1
            draw.text((col * CELL_W + 8, row * CELL_H + 5),
                      f"page {page_number}", fill="black", font=font)
            draw.rectangle((x - 1, y - 1, x + thumb.width, y + thumb.height),
                           outline="#777777", width=1)
        first = offset + 1
        last = offset + len(batch)
        target = CONTACTS / f"pages_{first:03d}_{last:03d}.png"
        sheet.save(target, optimize=True)
        contact_paths.append(target)

    for page_number in SELECTED_PAGES:
        source = PAGES / f"page-{page_number:03d}.png"
        shutil.copyfile(source, SELECTED / f"page-{page_number:03d}.png")

    ordered_page_hashes = "\n".join(sha256(page) for page in pages).encode("ascii")
    result = {
        "schema": "abc-final-paper-visual-qa-v1",
        "rendered_pages": len(pages),
        "contact_sheets": len(contact_paths),
        "contact_sheet_files": [path.relative_to(HERE).as_posix() for path in contact_paths],
        "selected_pages": SELECTED_PAGES,
        "selected_files": [f"selected_pages/page-{n:03d}.png" for n in SELECTED_PAGES],
        "ordered_render_sha256": hashlib.sha256(ordered_page_hashes).hexdigest(),
        "status": "READY_FOR_VISUAL_INSPECTION",
    }
    (HERE / "visual_qa_manifest.json").write_text(
        json.dumps(result, indent=2) + "\n", encoding="utf-8", newline="\n"
    )
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
