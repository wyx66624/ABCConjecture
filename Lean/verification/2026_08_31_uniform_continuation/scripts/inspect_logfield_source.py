"""Read and render the original log-field definition without editing its PDF."""
from pathlib import Path
import hashlib
import json
import pypdfium2 as pdfium
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
source = ROOT / "research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf"
sha = hashlib.sha256(source.read_bytes()).hexdigest()
assert sha == "9a7ee3c77b1c7717210c0613eb39b6844649d0040dc3d9e1be7d544f8f91a0b9"
number = 24
reader = PdfReader(source)
excerpt = reader.pages[number - 1].extract_text()
(RECORD / "MochIII-p24-excerpt.txt").write_text(excerpt, encoding="utf-8")
document = pdfium.PdfDocument(source)
page = document[number - 1]
bitmap = page.render(scale=1.5)
picture = bitmap.to_pil().convert("RGB")
output = ROOT / "tmp/iut_native_theta_torsion_2026_08_31/MochIII-p24-root.png"
output.parent.mkdir(parents=True, exist_ok=True)
picture.save(output)
bitmap.close()
page.close()
document.close()
record = {"source": source.relative_to(ROOT).as_posix(), "source_sha256": sha,
          "physical_pdf_page": number, "image": output.relative_to(ROOT).as_posix(),
          "image_sha256": hashlib.sha256(output.read_bytes()).hexdigest()}
(RECORD / "root-logfield-source-page.json").write_text(
    json.dumps(record, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(excerpt)
print(json.dumps(record, ensure_ascii=False))
