from __future__ import annotations

import sys
from pathlib import Path

from PIL import Image, ImageDraw


if len(sys.argv) != 3:
    raise SystemExit("usage: make_contact_sheets.py RENDER_DIR OUTPUT_DIR")

render_dir = Path(sys.argv[1]).resolve()
output_dir = Path(sys.argv[2]).resolve()
output_dir.mkdir(parents=True, exist_ok=True)
pages = sorted(render_dir.glob("page-*.png"))
if not pages:
    raise SystemExit(f"no rendered pages found in {render_dir}")

thumb_width = 220
label_height = 24
gap = 10
columns = 4
chunk_size = 20

for chunk_start in range(0, len(pages), chunk_size):
    chunk = pages[chunk_start : chunk_start + chunk_size]
    thumbs: list[tuple[int, Image.Image]] = []
    for page in chunk:
        page_number = int(page.stem.rsplit("-", 1)[1])
        with Image.open(page) as source:
            height = round(source.height * thumb_width / source.width)
            thumbnail = source.convert("RGB").resize(
                (thumb_width, height), Image.Resampling.LANCZOS
            )
        thumbs.append((page_number, thumbnail))

    thumb_height = max(image.height for _, image in thumbs)
    rows = (len(thumbs) + columns - 1) // columns
    sheet = Image.new(
        "RGB",
        (
            gap + columns * (thumb_width + gap),
            gap + rows * (thumb_height + label_height + gap),
        ),
        "white",
    )
    draw = ImageDraw.Draw(sheet)
    for index, (page_number, thumbnail) in enumerate(thumbs):
        row, column = divmod(index, columns)
        x = gap + column * (thumb_width + gap)
        y = gap + row * (thumb_height + label_height + gap)
        draw.text((x, y), f"Page {page_number}", fill="black")
        sheet.paste(thumbnail, (x, y + label_height))

    first, last = thumbs[0][0], thumbs[-1][0]
    sheet.save(output_dir / f"contact-sheet-{first:03d}-{last:03d}.png")

print(f"PASS: {len(pages)} pages -> {(len(pages) + chunk_size - 1) // chunk_size} sheets")
