"""Record completed visual checks and source provenance; do not compile or alter proofs."""
from pathlib import Path
import hashlib
import json
from PIL import Image, ImageChops
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_30_galois_lifts"
EXPECTED_PDF = "752027de98d87d2457e2c038fda635b212a6534d63b9f82e903c66eb7484a4c1"

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def read(name):
    return json.loads((RECORD / name).read_text(encoding="utf-8"))

pdf = ROOT / "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf"
assert digest(pdf) == EXPECTED_PDF
reader = PdfReader(pdf)
assert len(reader.pages) == 66 and pdf.stat().st_size == 555812
assert reader.metadata.author == "ChatGPT"
render = read("render-manifest.json")
assert render["pdf_sha256"] == EXPECTED_PDF
for item in render["pages"]:
    assert digest(Path(item["path"])) == item["sha256"], item["page"]
for item in render["pairs"]:
    with Image.open(item["path"]).convert("RGB") as pair:
        x = 0
        for number in range(item["first"], item["last"] + 1):
            with Image.open(render["pages"][number-1]["path"]).convert("RGB") as single:
                crop = pair.crop((x, 0, x+single.width, single.height))
                assert ImageChops.difference(single, crop).getbbox() is None, number
                x += single.width + 18

page_notes = {
    37: "Three-label valuation and trace proof, common inertia choice, minimum-layer attainment",
    38: "Exact endpoint ideals and Haar volumes, native-pilot section opening",
    39: "Normalized and standard logarithms, root-to-log principal-ideal comparison",
    40: "Full principal-unit multiplication image, singleton and whole-input distinction",
    41: "Strict source inclusion, six-vector valuation table, actual common-arrow proof",
    42: "Endpoint hulls, exponent table, pre-ideal definition and weaker sandwich",
    43: "Sharp trace-dual upper bound, exact pre-ideal corollary, source and scale comparison",
    44: "Remaining source distinctions, global-comparison boundary, Frey section opening",
    45: "Actual curve invariants, two-transvection argument, degree-210 realization proof",
    46: "Normalized small-example heights and exception boundary, balanced level-43 theorem",
    47: "Good reduction at two, primorial proof, exact logarithmic bounds, true uniformizer",
    48: "General tame square labels, genuine uniformizer, logarithmic lattice and trace depths",
    49: "Norm/trace proof, inertia-character count, simultaneous common-arrow theorem",
    50: "Exact endpoint hulls, sharp pre-transport trace-dual bound, exact-pilot corollary",
}
assert list(page_notes) == list(range(37, 51))
rows = "\n".join(f"| {n} | {note} | Pass |" for n, note in page_notes.items())
root_qa = f"""# Final PDF visual QA: pages 37–50

Reviewer: root coordinating agent. Review date: 2026-08-31.

Result: **PASS for every page 37–50. No required visual correction found.**

The root agent actually viewed all seven full-resolution pair images, from
`pair-37-38.png` through `pair-49-50.png`. This is an image inspection, not
an inference from successful compilation or text extraction. Mathematical
proof review is recorded separately in `../DOC_REVIEW.md`.

Exact PDF: `E:/AImath/abc猜想/output/pdf/ChatGPT_ABC_Uniformity_2026.pdf`.
SHA-256: `{EXPECTED_PDF}`. Size: 555812 bytes. Length: 66 pages.
The PDF hash, all page-image hashes in `../render-manifest.json`, and pixel
identity of every paired half with its corresponding single page were
independently recomputed before this record was written.

| Page | Material actually viewed | Result |
| --- | --- | --- |
{rows}

Fractions, tensor products, ideals, trace-dual superscripts, floor/ceiling
symbols, matrices, displayed equations and both valuation tables are
readable and stay inside the text area. No clipped line, overlapping
symbol, missing glyph or unresolved `??` reference was seen. Page headers
and page numbers are distinct from the body. Continuing proofs and
Corollary 14.7 at the page-50 boundary are not truncated. The reference on
page 44 to later initial-data work has the correct scope: this earlier
local section alone is not presented as a construction of all global data.

No PDF or TeX source was changed during this final inspection. This
record asserts visual quality of the exact artifact, not an abc proof
or external human peer review.
"""
(RECORD / "qa/root-review.md").write_text(root_qa, encoding="utf-8")

reviews = {"pages_1_18": "qa/analytic-review.md",
           "pages_19_36": "qa/geometry-review.md",
           "pages_37_50": "qa/root-review.md",
           "pages_51_66": "qa/iut-review.md"}
for path in reviews.values():
    assert EXPECTED_PDF in (RECORD/path).read_text(encoding="utf-8"), path

axioms = read("axiom-summary.json")
assert axioms["all_passed"] and axioms["checked_total"] == 145
assert axioms["expected_public_theorems"] == 130
assert axioms["expected_additional_constructions"] == 15
assert not axioms["missing"] and not axioms["unexpected"] and not axioms["nonstandard"]
build = read("build-run.json")
assert build["exit_code"] == 0 and build["warnings"] == 265
assert build["completion"] == ["Build completed successfully (9129 jobs)."]
latex = read("latex-run.json")
assert latex["exit_code"] == 0 and latex["final_warning_count"] == 0
environment = read("environment.json")
assert environment["protected_files_match_previous"] and environment["packages_match_previous"]
declarations = read("declarations.json")
constructions = read("constructions.json")
audit_log = (RECORD/"axioms.txt").read_text(encoding="utf-8")
assert "sorryAx" not in audit_log and "error:" not in audit_log and "warning:" not in audit_log
all_text = [page.extract_text() or "" for page in reader.pages]
assert not any("??" in page for page in all_text)
summary = {
    "research_dates": ["2026-08-30", "2026-08-31"],
    "compiler": "Tectonic 0.17.0", "compile_exit_code": 0,
    "final_tex_warning_lines": [], "pdf_pages": 66, "pdf_bytes": 555812,
    "pdf_author": "ChatGPT", "pdf_sha256": EXPECTED_PDF,
    "page_text_lengths": [len(page) for page in all_text],
    "qa_directory": render["directory"],
    "visual_qa_status": "passed; every page actually viewed as an image",
    "inspected_pages": list(range(1, 67)), "visual_qa_records": reviews,
    "visual_qa_record_sha256": {p: digest(RECORD/p) for p in reviews.values()},
    "all_render_hashes_checked": True, "all_pair_pixels_match_single_pages": True,
    "build_completion_jobs": 9129, "build_warning_count": 265,
    "new_module_warning_count": 0, "audit_warning_count": 0,
    "new_module_count": len(declarations),
    "public_theorems_by_module": {m: len(ds) for m, ds in declarations.items()},
    "additional_constructions_by_module": {m: len(ds) for m, ds in constructions.items()},
    "public_theorem_count": 130, "additional_construction_count": 15,
    "audited_declaration_count": 145, "zero_axiom_declaration_count": 6,
    "previous_audited_declaration_counts": {"uniform_gate": 89, "continuation": 43},
    "axioms": axioms["allowed_axioms"], "unexpected_axioms": [],
    "audit_has_sorryAx": False, "standard_abc_proof_or_disproof": False,
    "protected_core_and_pins_unchanged": True,
    "formalized_full_initial_theta_data": False,
    "formalized_full_local_galois_reconstruction": False,
    "formalized_full_global_abc_comparison": False,
    "external_human_peer_review": False,
}
(RECORD/"validation_summary.json").write_text(
    json.dumps(summary, ensure_ascii=False, indent=2)+"\n", encoding="utf-8")

previous = ROOT / "Lean/verification/2026_08_30_uniform_gate"
previous_manifest = previous / "SHA256SUMS"
assert digest(previous_manifest) == "c470be98f60af38a31b8a00393d09f276e10d223c197034cfd1a1ee5628afe7a"
mapping = read("previous-manifest-map.json")
old_entries = [line.split("  ", 1) for line in previous_manifest.read_text(encoding="utf-8-sig").splitlines() if line]
assert len(old_entries) == 506 and len(mapping) == 6
for expected, path in old_entries:
    actual = ROOT / mapping.get(path, path)
    assert actual.resolve().is_relative_to(ROOT.resolve())
    assert digest(actual) == expected, path

print(json.dumps({"pdf_pages": 66, "visual_reviews": 4, "audited_declarations": 145,
                  "previous_manifest_replayed": 506, "previous_failures": [],
                  "pdf_sha256": EXPECTED_PDF}, ensure_ascii=False))
