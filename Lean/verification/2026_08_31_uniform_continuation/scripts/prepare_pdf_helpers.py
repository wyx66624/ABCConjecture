"""Copy the accepted PDF helpers to this new stage without changing their originals."""
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
OLD = ROOT / "Lean/verification/2026_08_30_galois_lifts/scripts"
NEW = Path(__file__).resolve().parent
pairs = {
    "run_galois_pdf_checks_2026_08_30.py": "compile_pdf.py",
    "render_galois_pdf_2026_08_30.py": "render_pdf.py",
}
record = []
for source_name, target_name in pairs.items():
    source = OLD / source_name
    target = NEW / target_name
    assert not target.exists(), f"Refusing to replace an existing helper: {target}"
    data = source.read_bytes()
    text = data.decode("utf-8").replace(
        "Lean/verification/2026_08_30_galois_lifts",
        "Lean/verification/2026_08_31_uniform_continuation").replace(
        "tmp/pdfs/abc_galois_lifts_qa_2026_08_31",
        "tmp/pdfs/abc_uniform_continuation_qa_2026_08_31")
    target.write_text(text, encoding="utf-8")
    record.append({
        "source": source.relative_to(ROOT).as_posix(),
        "source_sha256": hashlib.sha256(data).hexdigest(),
        "derived_helper": target.relative_to(ROOT).as_posix(),
        "changes": "Only the verification directory and the new page-render directory.",
    })
(NEW.parent / "pdf-helper-provenance.json").write_text(
    json.dumps(record, indent=2) + "\n", encoding="utf-8")
print(json.dumps(record))
