from pathlib import Path

from PIL import Image, ImageDraw


root = Path(__file__).resolve().parent
pages = sorted(root.glob("page-*.png"))
thumb_width = 300
label_height = 28
gap = 14
columns = 4

thumbs = []
for page in pages:
    with Image.open(page) as source:
        height = round(source.height * thumb_width / source.width)
        image = source.convert("RGB").resize((thumb_width, height), Image.Resampling.LANCZOS)
    thumbs.append((page.stem.removeprefix("page-"), image))

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
for index, (label, image) in enumerate(thumbs):
    row, column = divmod(index, columns)
    x = gap + column * (thumb_width + gap)
    y = gap + row * (thumb_height + label_height + gap)
    draw.text((x, y), f"Page {int(label)}", fill="black")
    sheet.paste(image, (x, y + label_height))

sheet.save(root / "contact-sheet.png")
