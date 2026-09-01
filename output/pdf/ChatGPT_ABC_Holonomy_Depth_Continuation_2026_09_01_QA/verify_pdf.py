from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path

from pypdf import PdfReader


qa_dir = Path(__file__).resolve().parent
pdf_path = qa_dir.parent / "ChatGPT_ABC_Holonomy_Depth_Continuation_2026_09_01.pdf"
reader = PdfReader(pdf_path)
page_text = [(page.extract_text() or "") for page in reader.pages]
joined = "\n".join(page_text)


def normalize(value: str) -> str:
    return re.sub(r"[^a-z0-9]+", "", value.casefold())


markers = {
    "title": "Uniformity, Prime Support, and Reachable Lattices",
    "valuation_ball": "Valuation-ball transport",
    "positive_scalar_collision": "Positive normalized scalar collision",
    "affine_boundary_counterexample":
        "the complete U = 1 counterexample to its weaker form",
    "pell_coordinate_identity": "uℓ = AℓBℓ",
    "pell_finite_boundary": "finite lower bound, not a nonexistence result",
    "pell_no_intersection_claim": "not asserted to intersect",
    "danilov_exact_endpoint":
        "exact truncated subset-product enumeration gives E_B(Q_*)=622",
    "lean_theorem_count": "65 theorem or lemma declarations",
    "lean_definition_count": "18 definitions, four abbreviations, and five structures",
    "lean_total_count": "for 92 declarations",
    "lean_print_count": "58 embedded #print axioms queries",
    "terminal_status": "No unconditional closed term of type ABCConjecture",
}
marker_results = {
    name: normalize(value) in normalize(joined) for name, value in markers.items()
}
marker_pages = {
    name: [
        index
        for index, text in enumerate(page_text, start=1)
        if normalize(value) in normalize(text)
    ]
    for name, value in markers.items()
}

media_boxes = [
    [float(page.mediabox.width), float(page.mediabox.height)]
    for page in reader.pages
]
pell_page_text = normalize(page_text[113])
pell_coordinate_identity_correct = (
    normalize("uℓ = AℓBℓ") in pell_page_text
    and normalize("uℓ = 2AℓBℓ") not in pell_page_text
)
a4_pages = all(
    abs(width - 595.28) < 0.2 and abs(height - 841.89) < 0.2
    for width, height in media_boxes
)
root = reader.trailer["/Root"]
has_javascript = "/Names" in root and "/JavaScript" in root["/Names"]

log_text = (qa_dir / "tectonic.log").read_text(
    encoding="utf-8", errors="replace"
)
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

page_count = len(reader.pages)
chunk_size = 20
expected_contact_sheets = [
    f"contact-sheet-{first:03d}-{min(first + chunk_size - 1, page_count):03d}.png"
    for first in range(1, page_count + 1, chunk_size)
]
contact_sheets = sorted(path.name for path in qa_dir.glob("contact-sheet-*.png"))
expected_high_resolution_pages = [1, *range(111, page_count + 1)]
high_resolution_pages = sorted(
    int(path.stem.rsplit("-", 1)[1]) for path in qa_dir.glob("page-*.png")
)

data = pdf_path.read_bytes()
result = {
    "status": "PASS",
    "pdf": pdf_path.name,
    "bytes": len(data),
    "sha256": hashlib.sha256(data).hexdigest(),
    "pages": page_count,
    "metadata": {str(k): str(v) for k, v in (reader.metadata or {}).items()},
    "encrypted": reader.is_encrypted,
    "formFields": bool(reader.get_fields()),
    "javascript": has_javascript,
    "a4Pages": a4_pages,
    "pageTextLengths": [len(text) for text in page_text],
    "markers": marker_results,
    "markerPages": marker_pages,
    "pellCoordinateIdentityCorrectOnPage114": pell_coordinate_identity_correct,
    "logChecks": log_checks,
    "underfullVboxLocationsInFinalLog": len(
        re.findall(r"Underfull \\vbox", log_text)
    ),
    "fontconfigRuntimeWarning": "Fontconfig error" in stdout_text,
    "recordedLowDpiRenderCoverage": list(range(1, page_count + 1)),
    "contactSheets": contact_sheets,
    "highResolutionRenderedPages": high_resolution_pages,
}

assert result["pages"] == 124
assert result["metadata"].get("/Author") == "ChatGPT"
assert not result["encrypted"]
assert not result["formFields"]
assert not result["javascript"]
assert result["a4Pages"]
assert min(result["pageTextLengths"]) > 0
assert all(result["markers"].values()), [
    name for name, present in result["markers"].items() if not present
]
assert result["pellCoordinateIdentityCorrectOnPage114"]
assert all(result["logChecks"].values()), [
    name for name, passed in result["logChecks"].items() if not passed
]
assert result["underfullVboxLocationsInFinalLog"] == 4
assert contact_sheets == expected_contact_sheets
assert high_resolution_pages == expected_high_resolution_pages

(qa_dir / "pdf-verification.json").write_text(
    json.dumps(result, indent=2, ensure_ascii=False) + "\n",
    encoding="utf-8",
)
print(json.dumps(result, indent=2, ensure_ascii=False))
