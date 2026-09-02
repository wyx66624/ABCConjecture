from __future__ import annotations

import json
from pathlib import Path

from PIL import Image


QA_DIR = Path(__file__).resolve().parent
OUT = QA_DIR / "RASTER_AUDIT.json"
SELECTED = [1, 2, 127, 128, 144, 145, 146, 155, 156, 182, 183, 184, 185, 186, 199, 202]


def number(path: Path) -> int:
    return int(path.stem.split("-")[1])


def verified_dimensions(paths: list[Path]) -> list[list[int]]:
    dimensions: set[tuple[int, int]] = set()
    for path in paths:
        with Image.open(path) as image:
            image.verify()
        with Image.open(path) as image:
            dimensions.add(image.size)
    return [list(pair) for pair in sorted(dimensions)]


def main() -> None:
    pages = sorted(QA_DIR.glob("page-*.png"))
    contacts = sorted(QA_DIR.glob("contact-*.jpg"))
    selected = sorted((QA_DIR / "selected").glob("page-*.png"))
    continuous = [number(path) for path in pages] == list(range(1, 203))
    selected_exact = [number(path) for path in selected] == SELECTED
    counts_exact = len(pages) == 202 and len(contacts) == 17 and len(selected) == 16
    result = {
        "verdict": "PASS" if continuous and selected_exact and counts_exact else "FAIL",
        "page_count": len(pages),
        "contact_count": len(contacts),
        "selected_count": len(selected),
        "continuous_page_sequence": continuous,
        "selected_pages_exact": selected_exact,
        "dimensions": {
            "pages": verified_dimensions(pages),
            "contacts": verified_dimensions(contacts),
            "selected": verified_dimensions(selected),
        },
    }
    OUT.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
