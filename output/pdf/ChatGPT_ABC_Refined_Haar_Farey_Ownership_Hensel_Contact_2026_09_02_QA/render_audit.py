#!/usr/bin/env python3
"""Build deterministic contact sheets and structural checks for the final PDF."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

from PIL import Image, ImageDraw
from pypdf import PdfReader


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--pdf", type=Path, required=True)
    parser.add_argument("--pages", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    pdf = args.pdf.resolve()
    page_root = args.pages.resolve()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)

    raster_pages = sorted(page_root.glob("page-*.png"))
    reader = PdfReader(pdf)
    if len(raster_pages) != len(reader.pages):
        raise RuntimeError(
            f"raster/PDF page mismatch: {len(raster_pages)} != {len(reader.pages)}"
        )

    widths: set[int] = set()
    heights: set[int] = set()
    page_rows: list[dict[str, object]] = []
    blank_raster: list[int] = []
    border_contact: list[int] = []
    contacts: list[str] = []

    columns, rows = 4, 4
    thumb_width, thumb_height = 270, 382
    label_height, gutter = 24, 10
    sheet_width = columns * (thumb_width + gutter) + gutter
    sheet_height = rows * (thumb_height + label_height + gutter) + gutter

    for block_start in range(0, len(raster_pages), columns * rows):
        sheet = Image.new("RGB", (sheet_width, sheet_height), "white")
        draw = ImageDraw.Draw(sheet)
        for offset, path in enumerate(
            raster_pages[block_start:block_start + columns * rows]
        ):
            page_number = block_start + offset + 1
            with Image.open(path) as image:
                rgb = image.convert("RGB")
                width, height = rgb.size
                widths.add(width)
                heights.add(height)
                gray = rgb.convert("L")
                mask = gray.point(lambda value: 255 if value < 248 else 0)
                bbox = mask.getbbox()
                if bbox is None:
                    blank_raster.append(page_number)
                    margins = None
                else:
                    left, top, right, bottom = bbox
                    margins = {
                        "left": left,
                        "top": top,
                        "right": width - right,
                        "bottom": height - bottom,
                    }
                    if min(margins.values()) <= 4:
                        border_contact.append(page_number)
                page_rows.append({
                    "page": page_number,
                    "pixels": [width, height],
                    "inkBoundingBox": list(bbox) if bbox else None,
                    "inkMargins": margins,
                })

                thumbnail = rgb.copy()
                thumbnail.thumbnail((thumb_width, thumb_height), Image.Resampling.LANCZOS)
                col = offset % columns
                row = offset // columns
                x = gutter + col * (thumb_width + gutter)
                y = gutter + row * (thumb_height + label_height + gutter)
                draw.text((x, y), f"Page {page_number}", fill="black")
                paste_x = x + (thumb_width - thumbnail.width) // 2
                sheet.paste(thumbnail, (paste_x, y + label_height))

        first = block_start + 1
        last = min(block_start + columns * rows, len(raster_pages))
        name = f"contact-{first:03d}-{last:03d}.png"
        sheet.save(output / name, optimize=True)
        contacts.append(name)

    texts: list[str] = []
    low_text: list[dict[str, int]] = []
    for page_number, page in enumerate(reader.pages, 1):
        value = page.extract_text() or ""
        texts.append(value)
        count = len(value.strip())
        if count < 100:
            low_text.append({"page": page_number, "characters": count})

    joined_pages = [value.casefold() for value in texts]
    targets = [
        "refined tensor-haar",
        "farey denominator",
        "maximal-intersection ownership",
        "polynomial hensel",
        "all-index formalization",
        "steinberg valuation contact",
        "integer finite-chain",
        "quadratic veronese peeling",
        "formal verification and remaining obligations",
        "421 counted declarations",
    ]
    target_pages = {
        target: [
            page_number
            for page_number, text in enumerate(joined_pages, 1)
            if target.casefold() in text
        ]
        for target in targets
    }

    metadata = reader.metadata or {}
    fonts: set[str] = set()
    for page in reader.pages:
        resources = page.get("/Resources") or {}
        font_map = resources.get("/Font") or {}
        for font_ref in font_map.values():
            font = font_ref.get_object()
            base_font = font.get("/BaseFont")
            if base_font:
                fonts.add(str(base_font))

    metrics = {
        "status": "PASS" if not blank_raster and not border_contact else "REVIEW",
        "pdf": {
            "name": pdf.name,
            "bytes": pdf.stat().st_size,
            "sha256": sha256(pdf),
            "pages": len(reader.pages),
            "title": str(metadata.get("/Title", "")),
            "author": str(metadata.get("/Author", "")),
            "encrypted": reader.is_encrypted,
        },
        "render": {
            "rasterPages": len(raster_pages),
            "pixelWidths": sorted(widths),
            "pixelHeights": sorted(heights),
            "blankRasterPages": blank_raster,
            "borderContactPagesAtFourPixels": border_contact,
            "contactSheets": contacts,
        },
        "text": {
            "totalCharacters": sum(len(value) for value in texts),
            "lowTextPagesBelow100Characters": low_text,
            "targetPages": target_pages,
        },
        "fonts": sorted(fonts),
        "pages": page_rows,
    }
    (output / "qa_metrics.json").write_text(
        json.dumps(metrics, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    print(json.dumps({
        "status": metrics["status"],
        "pages": len(reader.pages),
        "contacts": len(contacts),
        "blankRasterPages": blank_raster,
        "borderContactPagesAtFourPixels": border_contact,
        "lowTextPagesBelow100Characters": low_text,
        "targetPages": target_pages,
    }, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()

