"""Read archived source pages used to check the proposed log-link membership.

This script never modifies the original PDFs. The excerpts preserve physical
page indices; page images, rather than flattened text, govern diagram reading.
"""
from pathlib import Path
import hashlib
import json
import pypdfium2 as pdfium
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
OUT = ROOT / "tmp/iut_membership_root_2026_08_31"
OUT.mkdir(parents=True, exist_ok=True)
SOURCES = {
    "III": (ROOT / "research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf",
            [23, 24, 25, 29, 30, 41, 42, 43, 93, 101, 102, 103, 104, 105, 106,
             110, 111, 112, 114, 151, 152, 153, 154, 155, 156, 157, 173, 174, 175]),
    "AbsTopIII": (ROOT / "research/sources/iut_membership_2026_08_31/Mochizuki_AbsTopIII_November2015_author.pdf",
                  [1, 125, 126, 129, 137, 138, 139, 140, 141, 148, 149]),
    "I": (ROOT / "research/sources/continuation_2026_08_30/Mochizuki_IUT_I_May2020.pdf", [144]),
}
records = []
for label, (source, selected) in SOURCES.items():
    reader = PdfReader(source)
    doc = pdfium.PdfDocument(source)
    pages = []
    for number in selected:
        text_path = OUT / f"{label}-p{number}.txt"
        text_path.write_text(reader.pages[number-1].extract_text() or "", encoding="utf-8")
        item = {"physical_page": number, "text_path": text_path.relative_to(ROOT).as_posix(),
                "text_sha256": hashlib.sha256(text_path.read_bytes()).hexdigest()}
        if (label == "III" and number in {42, 102, 103, 104, 110, 112, 152, 153, 154, 155, 156, 174}) or (label == "AbsTopIII" and number in {139, 148, 149}) or label == "I":
            page = doc[number-1]
            bitmap = page.render(scale=1.5)
            path = OUT / f"{label}-p{number}.png"
            bitmap.to_pil().convert("RGB").save(path)
            item.update(image_path=path.relative_to(ROOT).as_posix(),
                        image_sha256=hashlib.sha256(path.read_bytes()).hexdigest())
            bitmap.close()
            page.close()
        pages.append(item)
    doc.close()
    records.append({"source": source.relative_to(ROOT).as_posix(),
                    "source_sha256": hashlib.sha256(source.read_bytes()).hexdigest(),
                    "pages": pages})
(RECORD / "root-membership-source-pages.json").write_text(
    json.dumps({"sources": records, "purpose": "Source reading only; no membership conclusion"},
               ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(json.dumps({"extracted_pages": sum(len(s["pages"]) for s in records),
                  "output": OUT.as_posix()}, ensure_ascii=False))
