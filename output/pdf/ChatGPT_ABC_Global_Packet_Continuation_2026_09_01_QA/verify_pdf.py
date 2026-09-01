from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path

from pypdf import PdfReader


qa_dir = Path(__file__).resolve().parent
pdf_path = qa_dir.parent / "ChatGPT_ABC_Global_Packet_Continuation_2026_09_01.pdf"
reader = PdfReader(pdf_path)
page_text = [(page.extract_text() or "") for page in reader.pages]
joined = "\n".join(page_text)


def normalize(value: str) -> str:
    return re.sub(r"[^a-z0-9]+", "", value.casefold())


normalized = normalize(joined)
markers = {
    "author_scope": "Uniformity, Prime Support, and Reachable Lattices",
    "affine_square_warning": "5041,8281,7921",
    "pell_global_alternative": "unconditional alternative",
    "danilov_final_factor_count": "exactly 638 distinct prime factors",
    "hong_tail": "41n+1",
    "iut_scope": "rules out the pinned low-resolution signature as a satisfiable specification",
    "lean_theorem_count": "122 theorem or lemma declarations",
    "lean_nonproof_count": "42 definitions, structures, or abbreviations",
    "lean_total_count": "164 declarations in their source",
    "terminal_status": "No unconditional closed term of type ABCConjecture",
}
marker_results = {
    name: normalize(value) in normalized for name, value in markers.items()
}

page_hits: dict[str, list[int]] = {}
for name, value in markers.items():
    needle = normalize(value)
    page_hits[name] = [
        index for index, text in enumerate(page_text, start=1)
        if needle in normalize(text)
    ]

media_boxes = [
    [float(page.mediabox.width), float(page.mediabox.height)]
    for page in reader.pages
]
a4 = all(
    abs(width - 595.28) < 0.2 and abs(height - 841.89) < 0.2
    for width, height in media_boxes
)
root = reader.trailer["/Root"]
has_javascript = "/Names" in root and "/JavaScript" in root["/Names"]

log_text = (qa_dir / "tectonic.log").read_text(encoding="utf-8", errors="replace")
stdout_text = (qa_dir / "tectonic-stdout.txt").read_text(
    encoding="utf-8", errors="replace"
)
forbidden_log_patterns = {
    "overfull": r"Overfull",
    "undefined_control_sequence": r"Undefined control sequence",
    "undefined_reference": r"undefined references?",
    "undefined_citation": r"undefined citations?",
    "latex_error": r"! LaTeX Error",
}
log_checks = {
    name: re.search(pattern, log_text, flags=re.IGNORECASE) is None
    for name, pattern in forbidden_log_patterns.items()
}

data = pdf_path.read_bytes()
expected_contact_sheets = [
    "contact-sheet-001-020.png",
    "contact-sheet-021-040.png",
    "contact-sheet-041-060.png",
    "contact-sheet-061-080.png",
    "contact-sheet-081-100.png",
    "contact-sheet-101-119.png",
]
contact_sheets = sorted(path.name for path in qa_dir.glob("contact-sheet-*.png"))
expected_high_resolution_pages = [1, *range(101, len(reader.pages) + 1)]
high_resolution_pages = sorted(
    int(path.stem.rsplit("-", 1)[1]) for path in qa_dir.glob("page-*.png")
)
result = {
    "status": "PASS",
    "pdf": pdf_path.name,
    "bytes": len(data),
    "sha256": hashlib.sha256(data).hexdigest(),
    "pages": len(reader.pages),
    "metadata": {str(k): str(v) for k, v in (reader.metadata or {}).items()},
    "encrypted": reader.is_encrypted,
    "formFields": bool(reader.get_fields()),
    "javascript": has_javascript,
    "a4Pages": a4,
    "pageTextLengths": [len(text) for text in page_text],
    "markers": marker_results,
    "markerPages": page_hits,
    "logChecks": log_checks,
    "underfullVboxOccurrencesInFinalLog": len(
        re.findall(r"Underfull \\vbox", log_text)
    ),
    "fontconfigRuntimeWarning": "Fontconfig error" in stdout_text,
    "recordedLowDpiRenderCoverage": list(range(1, len(reader.pages) + 1)),
    "contactSheets": contact_sheets,
    "highResolutionRenderedPages": high_resolution_pages,
}

assert result["pages"] == 119
assert result["metadata"].get("/Author") == "ChatGPT"
assert not result["encrypted"]
assert not result["formFields"]
assert not result["javascript"]
assert result["a4Pages"]
assert min(result["pageTextLengths"]) > 0
assert all(result["markers"].values()), [
    name for name, present in result["markers"].items() if not present
]
assert all(result["logChecks"].values()), [
    name for name, passed in result["logChecks"].items() if not passed
]
assert contact_sheets == expected_contact_sheets
assert high_resolution_pages == expected_high_resolution_pages

(qa_dir / "pdf-verification.json").write_text(
    json.dumps(result, indent=2, ensure_ascii=False) + "\n",
    encoding="utf-8",
)
print(json.dumps(result, indent=2, ensure_ascii=False))
