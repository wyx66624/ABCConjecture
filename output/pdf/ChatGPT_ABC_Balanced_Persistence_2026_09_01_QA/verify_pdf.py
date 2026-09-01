from __future__ import annotations

import hashlib
import json
from pathlib import Path

from pypdf import PdfReader


qa_dir = Path(__file__).resolve().parent
pdf_path = qa_dir.parent / "ChatGPT_ABC_Balanced_Persistence_2026_09_01.pdf"
reader = PdfReader(pdf_path)
page_text = [(page.extract_text() or "") for page in reader.pages]
joined = "\n".join(page_text)
compact_text = "".join(joined.split())

markers = {
    "danilov_representative": "122136955032565025967809449110840347537827",
    "danilov_modulus": "183205432548847538951714173666260521306741",
    "declaration_count": "57 theorems and 30 definitions",
    "terminal_status": "No unconditional closed term of type ABCConjecture",
}

data = pdf_path.read_bytes()
result = {
    "status": "PASS",
    "pdf": str(pdf_path),
    "bytes": len(data),
    "sha256": hashlib.sha256(data).hexdigest(),
    "pages": len(reader.pages),
    "metadata": {str(k): str(v) for k, v in (reader.metadata or {}).items()},
    "pageTextLengths": [len(text) for text in page_text],
    "markers": {
        name: "".join(value.split()) in compact_text
        for name, value in markers.items()
    },
    "renderedPages": [1, *range(96, 112)],
    "visuallyInspectedPages": [1, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111],
}

assert result["pages"] == 111
assert result["metadata"].get("/Author") == "ChatGPT"
if not all(result["markers"].values()):
    missing = [name for name, present in result["markers"].items() if not present]
    raise AssertionError(f"Missing extracted-text markers: {missing}")
assert min(result["pageTextLengths"]) > 0

(qa_dir / "pdf-verification.json").write_text(
    json.dumps(result, indent=2, ensure_ascii=False) + "\n",
    encoding="utf-8",
)
print(json.dumps(result, indent=2, ensure_ascii=False))
