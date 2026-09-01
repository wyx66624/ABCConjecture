"""Read-only verification of the August 31 partial-results acceptance.

This never regenerates a manifest, edits a snapshot, compiles a proof, or
certifies ABC. Use the separate one-time freeze script only after final QA.
Future research outside the explicit scope is not part of this acceptance.
"""
from pathlib import Path
from collections import Counter
import hashlib
import json
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
MANIFEST = HERE / "SHA256SUMS"
ALLOWED = {"propext", "Classical.choice", "Quot.sound"}
HISTORY = [
    ("2026_08_30_galois_lifts", 705,
     "a05309cddfaa382f90398e4ec17fdddcf4572c93116e420a4658e625987606ce",
     HERE / "previous-manifest-map.json", 6),
    ("2026_08_30_uniform_gate", 506,
     "c470be98f60af38a31b8a00393d09f276e10d223c197034cfd1a1ee5628afe7a",
     ROOT / "Lean/verification/2026_08_30_galois_lifts/previous-manifest-map.json", 6),
    ("2026_08_30_continuation", 447,
     "dbc5fdc869019dd21fd091e40c32a3d3cf607dcb8feda2819facd529d7e3684a",
     ROOT / "Lean/verification/2026_08_30_uniform_gate/previous-manifest-map.json", 10),
]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def entries(path):
    result = []
    for line in path.read_text(encoding="utf-8-sig").splitlines():
        if line:
            sha, name = line.split("  ", 1)
            if not re.fullmatch(r"[0-9a-f]{64}", sha):
                raise ValueError(f"Invalid digest in {path}")
            result.append((sha, name))
    return result


def verify(values, mapping=None):
    mapping = mapping or {}
    failures, seen = [], set()
    for expected, name in values:
        path = (ROOT / mapping.get(name, name)).resolve()
        if name in seen:
            failures.append(f"Duplicate path: {name}")
        seen.add(name)
        if not path.is_relative_to(ROOT.resolve()):
            failures.append(f"Path outside repository: {name}")
        elif not path.is_file():
            failures.append(f"Missing file: {name}")
        elif digest(path) != expected:
            failures.append(f"Hash mismatch: {name}")
    return failures


def history_checks():
    result = []
    for name, count, sha, map_path, map_count in HISTORY:
        manifest = ROOT / "Lean/verification" / name / "SHA256SUMS"
        values, mapping = entries(manifest), read(map_path)
        failures = verify(values, mapping)
        if digest(manifest) != sha:
            failures.append("Frozen manifest changed")
        if len(values) != count or len(mapping) != map_count:
            failures.append("Frozen manifest or remapping scope changed")
        result.append({"stage": name, "checked_files": len(values),
                       "remapped_paths": len(mapping), "manifest_sha256": digest(manifest),
                       "failures": failures})
    return result


def scoped_files():
    previous = ROOT / "Lean/verification/2026_08_30_galois_lifts"
    files = {ROOT / name for _, name in entries(previous / "SHA256SUMS")}
    # The user is viewing this older intermediate PDF in WPS. The accepted
    # parent PDF is preserved by the historical snapshot mapping; this stage
    # accepts the new dated PDF instead of sealing the open intermediate.
    files.discard(ROOT / "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf")
    files.update(ROOT / item["source"] for item in read(HERE / "declarations.json").values())
    files.add(ROOT / "Lean/IUTThreeClosures/ResearchUniformContinuation20260831Audit.lean")
    files.add(ROOT / "output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf")
    reports = [
        "ABC_UNIFORM_CONTINUATION_2026_08_31.md",
        "ABC_ODD_PART_FIBRE_FORMAL_PROOFS_2026_08_31.md",
        "TRACE_COVARIANT_RATIONAL_RETURN_PROOFS_2026_08_31.md",
        "ANALYTIC_UNIFORM_GATE_2026_08_31.md",
        "ARITHMETIC_GEOMETRY_UNIFORM_GATE_2026_08_31.md",
        "ARITHMETIC_GEOMETRY_UNIFORM_GATE_CROSS_REVIEW_IUT_2026_08_31.md",
        "FREY_ENTIRE_ISOGENY_WEIL_HEIGHT_2026_08_31.md",
        "FREY_ISOGENY_WEIL_HEIGHT_FORMAL_PROOFS_2026_08_31.md",
        "FREY_ISOGENY_WEIL_HEIGHT_CROSS_REVIEW_2026_08_31.md",
        "IUT_GLOBAL_COMPARISON_NEXT_GATE_2026_08_31.md",
        "IUT_GLOBAL_COMPARISON_ARITHMETIC_CROSS_REVIEW_2026_08_31.md",
        "IUT_NATIVE_THETA_TORSION_POINT_HULL_2026_08_31.md",
        "IUT_NATIVE_THETA_TORSION_POINT_CROSS_REVIEW_2026_08_31.md",
        "IUT_LOGFIELD_SHELL_COORDINATE_CROSS_REVIEW_2026_08_31.md",
        "IUT_IDENTITY_LOG_LINK_LOCAL_MEMBERSHIP_2026_08_31.md",
        "IUT_IDENTITY_LOG_LINK_MEMBERSHIP_CROSS_REVIEW_2026_08_31.md",
        "UNIFORM_CONTINUATION_FORMAL_CROSS_REVIEW_2026_08_31.md",
        "UNIFORM_CONTINUATION_ROOT_CROSS_REVIEW_2026_08_31.md",
        "UNIFORM_CONTINUATION_KERNEL_SCOPE_REVIEW_2026_08_31.md",
    ]
    files.update(ROOT / "research" / name for name in reports)
    files.update(ROOT / "paper" / f"uniform_continuation_{name}_2026.tex" for name in [
        "analytic", "entire_isogeny", "weil_height", "theta_points",
        "identity_membership", "arithmetic_bundles"])
    files.update(ROOT / source["path"] for source in read(HERE / "source_metadata.json")["sources"])
    for directory in [
        HERE, previous, ROOT / "tmp/pdfs/abc_uniform_continuation_qa_2026_08_31",
        ROOT / "tmp/lean_audits/abc_two_prime_support_2026_08_31",
        ROOT / "tmp/lean_audits/frey_weil_height_cross_review_2026_08_31",
    ]:
        files.update(p for p in directory.rglob("*") if p.is_file()
                     and "__pycache__" not in p.parts
                     and p not in {MANIFEST, HERE / "manifest-verification.json"})
    files.add(ROOT / "tmp/frey_isogeny_weil_height_target_build_2026_08_31.log")
    for source in read(HERE / "root-membership-source-pages.json")["sources"]:
        for page in source["pages"]:
            for key in ["text_path", "image_path"]:
                if key in page:
                    files.add(ROOT / page[key])
    # These are exact original-page evidence images, not manuscript QA pages.
    for name in ["EtTh-p20.png", "MochII-p72.png", "MochII-p73.png", "MochIII-p105.png",
                 "MochIII-p24-root.png"]:
        path = ROOT / "tmp/iut_native_theta_torsion_2026_08_31" / name
        files.add(path)
    return sorted(files, key=lambda path: path.relative_to(ROOT).as_posix())


def visual_checks(summary, pdf, render):
    """Check actual image bytes, pair pixels, and the explicit review coverage."""
    from PIL import Image, ImageChops
    failures = []
    expected_pages = list(range(1, pdf["pages"] + 1))
    pages = render["pages"]
    if [page["page"] for page in pages] != expected_pages:
        return ["Rendered page list is incomplete or not uniquely ordered"]
    for page in pages:
        path = Path(page["path"]).resolve()
        if not path.is_relative_to(ROOT.resolve()) or not path.is_file():
            failures.append(f"Invalid rendered page path: {page['page']}")
        elif digest(path) != page["sha256"]:
            failures.append(f"Changed rendered page: {page['page']}")
    if failures:
        return failures
    pair_pages = []
    for pair in render["pairs"]:
        pair_path = Path(pair["path"]).resolve()
        if not pair_path.is_relative_to(ROOT.resolve()) or not pair_path.is_file():
            failures.append("Invalid paired-image path")
            continue
        if digest(pair_path) != pair["sha256"]:
            failures.append("Changed paired-image bytes")
            continue
        numbers = list(range(pair["first"], pair["last"] + 1))
        if not numbers or any(number not in expected_pages for number in numbers):
            failures.append("Invalid paired-image page range")
            continue
        pair_pages.extend(numbers)
        with Image.open(pair_path) as raw_pair:
            paired = raw_pair.convert("RGB")
            offset = 0
            for number in numbers:
                with Image.open(pages[number - 1]["path"]) as raw_page:
                    single = raw_page.convert("RGB")
                    crop = paired.crop((offset, 0, offset + single.width, single.height))
                    if ImageChops.difference(crop, single).getbbox() is not None:
                        failures.append(f"Pair pixels differ from page {number}")
                    offset += single.width + 18
    if Counter(pair_pages) != Counter(expected_pages):
        failures.append("Paired-image coverage is incomplete or duplicated")
    reviews = summary.get("visual_qa_records", {})
    if not reviews:
        failures.append("No actual visual review records supplied")
    review_pages = []
    for reviewer, relative in reviews.items():
        path = HERE / relative
        review = read(path)
        if review.get("pdf_sha256") != pdf["sha256"] or review.get("status") != "pass":
            failures.append(f"Visual review is not a pass for the exact PDF: {reviewer}")
        inspected = review.get("inspected_pages", [])
        if not inspected or len(set(inspected)) != len(inspected):
            failures.append(f"Empty or repeated visual-review page list: {reviewer}")
        notes = review.get("page_notes", {})
        image_hashes = review.get("page_image_sha256", {})
        for number in inspected:
            if number not in expected_pages or not notes.get(str(number)):
                failures.append(f"Missing page note or invalid page: {reviewer}/{number}")
            elif image_hashes.get(str(number)) != pages[number - 1]["sha256"]:
                failures.append(f"Review identifies different page pixels: {reviewer}/{number}")
        review_pages.extend(inspected)
        if relative not in summary.get("visual_qa_record_sha256", {}):
            failures.append(f"Review is not hash-bound by the summary: {reviewer}")
    if sorted(set(review_pages)) != expected_pages:
        failures.append("Actual visual-review records do not cover every PDF page")
    return failures


def metadata_checks():
    failures = []
    summary = read(HERE / "validation_summary.json")
    pdf = read(HERE / "pdf-metadata.json")
    render = read(HERE / "render-manifest.json")
    axioms = read(HERE / "axiom-summary.json")
    build = read(HERE / "build-run.json")
    latex = read(HERE / "latex-run.json")
    proof_history = read(HERE / "proof-and-history-verification.json")
    environment = read(HERE / "environment.json")
    checks = {
        "Final PDF identity": summary["pdf_sha256"] == pdf["sha256"] == render["pdf_sha256"]
            == digest(ROOT / pdf["path"]),
        "Final PDF size, pages and author": summary["pdf_bytes"] == pdf["bytes"]
            == (ROOT / pdf["path"]).stat().st_size
            and summary["pdf_pages"] == pdf["pages"] == render["pdf_pages"]
            and summary["pdf_author"] == pdf["metadata"]["/Author"] == "ChatGPT",
        "Every page visually inspected": summary["inspected_pages"] == list(range(1, pdf["pages"] + 1))
            and summary["all_render_hashes_checked"] and summary["all_pair_pixels_match_single_pages"],
        "Completed full build": build["exit_code"] == 0
            and build["completion"] == ["Build completed successfully (9135 jobs)."],
        "No new build warnings": build["warnings"] == 265
            and proof_history["build"]["warning_multiset_matches_previous"],
        "Completed central audit": axioms["all_passed"] and axioms["module_count"] == 5
            and axioms["public_theorem_count"] == 97
            and axioms["additional_proof_bearing_declaration_count"] == 9
            and axioms["audited_declaration_count"] == 106
            and axioms["zero_axiom_count"] == 3,
        "Independent history/proof verification": proof_history["all_passed"],
        "Final TeX pass": latex["exit_code"] == 0 and latex["final_warning_count"] == 0
            and not latex["inputs_changed_during_run"],
        "Protected core and toolchain": environment["all_passed"],
        "No general ABC result claimed": summary["standard_abc_proof_or_disproof"] is False,
        "No external peer review claimed": summary["external_human_peer_review"] is False,
    }
    failures.extend(name for name, passed in checks.items() if not passed)
    failures.extend(visual_checks(summary, pdf, render))
    for run_name in ["build-run.json", "audit-run.json", "latex-run.json"]:
        run = read(HERE / run_name)
        hashes = run.get("input_sha256", {})
        if not hashes or run.get("inputs_changed_during_run"):
            failures.append(f"Missing or changed run inputs: {run_name}")
        failures.extend(verify([(sha, name) for name, sha in hashes.items()]))
    modules = read(HERE / "declarations.json")
    expected = [f"IUTThreeClosures.{module}.{name}" for module, item in modules.items()
                for name in item["public_theorems"] + item["additional_proof_bearing_declarations"]]
    log = (HERE / "audit-output.txt").read_text(encoding="utf-8")
    reports = [(name, {a.strip() for a in body.split(",") if a.strip()})
               for name, body in re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", log, re.S)]
    reports.extend((name, set()) for name in re.findall(r"'([^']+)' does not depend on any axioms", log))
    if Counter(name for name, _ in reports) != Counter(expected) or len(reports) != 106:
        failures.append("Actual kernel report names do not exactly match the scope")
    if any(not deps <= ALLOWED for _, deps in reports) or "sorryAx" in log:
        failures.append("Forbidden actual axiom dependency")
    if re.search(r"(?:^|\n).*\b(?:error|warning):", log):
        failures.append("Diagnostic in the actual audit output")
    for name, expected_sha in summary["visual_qa_record_sha256"].items():
        path = HERE / name
        if digest(path) != expected_sha or pdf["sha256"] not in path.read_text(encoding="utf-8"):
            failures.append(f"Changed visual review or different reviewed PDF: {name}")
    failures.extend(verify([(sha, name) for name, sha in environment["protected_file_sha256"].items()]))
    failures.extend(verify([(source["sha256"], source["path"])
                            for source in read(HERE / "source_metadata.json")["sources"]]))
    return failures


def main():
    history = history_checks()
    failures = metadata_checks()
    values = entries(MANIFEST) if MANIFEST.exists() else []
    if not values:
        failures.append("Current manifest has not been frozen")
    failures.extend(verify(values))
    if {name for _, name in values} != {p.relative_to(ROOT).as_posix() for p in scoped_files()}:
        failures.append("Manifest scope differs from the explicitly accepted file set")
    result = {"checked_files": len(values), "failures": failures, "history": history,
              "manifest_sha256": digest(MANIFEST) if MANIFEST.exists() else None,
              "pdf_sha256": read(HERE / "pdf-metadata.json")["sha256"],
              "standard_abc_proof_or_disproof": False}
    result["all_passed"] = not failures and all(not item["failures"] for item in history)
    print(json.dumps(result, ensure_ascii=False))
    raise SystemExit(0 if result["all_passed"] else 1)


if __name__ == "__main__":
    main()
