"""Consolidate already completed proof checks and actual per-page reviews.

This writes only the new acceptance summary. It never creates a visual
review on behalf of an agent, changes a proof, or edits a historical stage.
"""
from pathlib import Path
import hashlib
import importlib.util
import json
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[4]
HERE = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
EXPECTED_PDF = "0dfc4b7be5f7b32c65d357bf43d1e0df91a4ec8c35eb68cec7f46c56898e4e9f"

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def read(name):
    return json.loads((HERE / name).read_text(encoding="utf-8"))

def require(condition, message):
    if not condition:
        raise SystemExit(message)

pdf = read("pdf-metadata.json")
path = ROOT / pdf["path"]
require(pdf["sha256"] == digest(path) == EXPECTED_PDF, "Final PDF identity changed")
require(pdf["pages"] == 93 and pdf["bytes"] == 741229, "Unexpected final PDF metadata")
reader = PdfReader(path)
require(len(reader.pages) == 93 and reader.metadata.author == "ChatGPT", "Actual PDF metadata mismatch")
page_text = [page.extract_text() or "" for page in reader.pages]
reader.close()
require(all(len(text) > 100 and "??" not in text for text in page_text), "Blank page or unresolved reference")
render = read("render-manifest.json")
build = read("build-run.json")
audit = read("audit-run.json")
axioms = read("axiom-summary.json")
history = read("proof-and-history-verification.json")
latex = read("latex-run.json")
environment = read("environment.json")
declarations = read("declarations.json")
sources = read("source_metadata.json")
require(axioms["all_passed"] and history["all_passed"] and environment["all_passed"], "Incomplete proof or environment verification")
require(build["completion"] == ["Build completed successfully (9135 jobs)."] and build["exit_code"] == 0,
        "Full build did not pass")
require(build["warnings"] == 265 and history["build"]["warning_multiset_matches_previous"], "Changed build warnings")
require(audit["exit_code"] == 0 and audit["warnings"] == 0 and audit["dependency_reports"] == 106, "Central audit mismatch")
require(axioms["public_theorem_count"] == 97 and axioms["additional_proof_bearing_declaration_count"] == 9,
        "Declaration scope mismatch")
require(latex["exit_code"] == 0 and latex["final_warning_count"] == 0, "Final TeX pass has warnings or errors")
require(sources["verified_pdf_count"] == 13 and sources["new_primary_pdf_count"] == 3, "Source archive scope mismatch")
reviews = {name: f"qa/{name}-review.json" for name in ["analytic", "geometry", "root", "iut"]}
review_paths = list(reviews.values()) + [f"qa/{name}-review.md" for name in reviews]
for name in review_paths:
    require(EXPECTED_PDF in (HERE / name).read_text(encoding="utf-8"), f"Wrong artifact in visual record {name}")
inspected = sorted({page for relative in reviews.values() for page in read(relative)["inspected_pages"]})
summary = {
    "research_date": "2026-08-31", "status": "proof and PDF verification passed; partial research results",
    "compiler": "Tectonic 0.17.0", "compile_exit_code": latex["exit_code"],
    "final_tex_warning_lines": latex["final_warnings"],
    "pdf_path": pdf["path"], "pdf_pages": pdf["pages"], "pdf_bytes": pdf["bytes"],
    "pdf_author": "ChatGPT", "pdf_sha256": EXPECTED_PDF,
    "page_text_lengths": [len(text) for text in page_text],
    "qa_directory": render["directory"], "visual_qa_status": "passed; every page actually viewed as an image",
    "inspected_pages": inspected, "visual_qa_records": reviews,
    "visual_qa_record_sha256": {name: digest(HERE / name) for name in review_paths},
    "all_render_hashes_checked": True, "all_pair_pixels_match_single_pages": True,
    "build_completion_jobs": 9135, "build_warning_count": 265,
    "new_module_warning_count": 0, "audit_warning_count": 0,
    "new_module_count": len(declarations),
    "public_theorems_by_module": {name: len(item["public_theorems"]) for name, item in declarations.items()},
    "additional_constructions_by_module": {name: len(item["additional_proof_bearing_declarations"])
                                            for name, item in declarations.items()},
    "public_theorem_count": 97, "additional_construction_count": 9,
    "audited_declaration_count": 106, "zero_axiom_declaration_count": 3,
    "previous_audited_declaration_counts": {"galois_lifts": 145, "uniform_gate": 89, "continuation": 43},
    "axioms": axioms["allowed_axioms"], "unexpected_axioms": [], "audit_has_sorryAx": False,
    "protected_core_and_pins_unchanged": True,
    "new_primary_source_count": 3, "reused_primary_source_count": 10,
    "standard_abc_proof_or_disproof": False, "external_human_peer_review": False,
    "formalized_entire_rational_isogeny_classification": False,
    "formalized_full_local_galois_reconstruction": False,
    "formalized_canonical_iut_source_membership": False,
    "formalized_full_global_abc_comparison": False,
    "superseded_open_pdf_excluded_from_current_scope": "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf",
    "superseded_open_pdf_note": "WPS holds this older intermediate PDF open. It is left unchanged; the dated PDF is the accepted deliverable. The accepted 66-page parent PDF is independently preserved in previous_snapshot.",
}
spec = importlib.util.spec_from_file_location("acceptance_verifier", HERE / "verify_manifest.py")
verifier = importlib.util.module_from_spec(spec)
spec.loader.exec_module(verifier)
visual_failures = verifier.visual_checks(summary, pdf, render)
require(not visual_failures, f"Actual page, pair, or review coverage check failed: {visual_failures}")
require(all(not item["failures"] for item in verifier.history_checks()), "Historical replay failed")
(HERE / "validation_summary.json").write_text(json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
metadata_failures = verifier.metadata_checks()
require(not metadata_failures, f"Consolidated metadata verification failed: {metadata_failures}")
print(json.dumps({"pdf_pages": 93, "pdf_sha256": EXPECTED_PDF, "visually_inspected_pages": len(inspected),
                  "visual_reviews": len(reviews), "audited_declarations": 106,
                  "historical_manifest_counts": [705, 506, 447], "all_passed": True}))
