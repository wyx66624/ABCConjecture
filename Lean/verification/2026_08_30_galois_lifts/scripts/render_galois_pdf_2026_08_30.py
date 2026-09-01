"""Render every page of the exact expanded PDF and make review pairs."""
from pathlib import Path
import hashlib
import json
from PIL import Image
import pypdfium2 as pdfium
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_30_galois_lifts"
PDF = ROOT / "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf"
OUT = ROOT / "tmp/pdfs/abc_galois_lifts_qa_2026_08_31"
OUT.mkdir(parents=True, exist_ok=True)
expected = json.loads((RECORD / "pdf-metadata.json").read_text(encoding="utf-8"))
pdf_sha = hashlib.sha256(PDF.read_bytes()).hexdigest()
assert pdf_sha == expected["sha256"]
document = pdfium.PdfDocument(PDF)
reader = PdfReader(PDF)
pages = []
for number in range(len(document)):
    page = document[number]
    bitmap = page.render(scale=1.5)
    picture = bitmap.to_pil().convert("RGB")
    path = OUT / f"page-{number+1:02d}.png"
    picture.save(path)
    pages.append({"page": number+1, "path": path.as_posix(),
                  "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
                  "width": picture.width, "height": picture.height,
                  "text_length": len(reader.pages[number].extract_text() or "")})
    bitmap.close()
    page.close()
document.close()
pairs = []
for start in range(1, len(pages)+1, 2):
    finish = min(start+1, len(pages))
    images = [Image.open(OUT / f"page-{n:02d}.png").convert("RGB")
              for n in range(start, finish+1)]
    paired = Image.new("RGB", (sum(im.width for im in images)+18*(len(images)-1),
                               max(im.height for im in images)), "#dddddd")
    x = 0
    for im in images:
        paired.paste(im, (x, 0))
        x += im.width+18
    path = OUT / f"pair-{start:02d}-{finish:02d}.png"
    paired.save(path)
    pairs.append({"first": start, "last": finish, "path": path.as_posix()})
report = {"pdf_sha256": pdf_sha, "pdf_pages": len(pages), "directory": OUT.as_posix(),
          "render_scale": 1.5, "pages": pages, "pairs": pairs}
(RECORD / "render-manifest.json").write_text(
    json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(json.dumps({"pdf_sha256": pdf_sha, "pages": len(pages), "pairs": len(pairs),
                  "directory": OUT.as_posix(),
                  "short_pages": [p["page"] for p in pages if p["text_length"] < 100]},
                 ensure_ascii=False))
