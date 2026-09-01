"""Verify this partial-results increment and replay both prior frozen manifests.

Default operation is read-only. --write freezes the explicitly scoped current
files after checking the historical snapshots and completed audit/QA metadata.
New research started after this 66-page increment is deliberately excluded.
This integrity check neither compiles Lean nor certifies an ABC proof.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
PREVIOUS = ROOT / "Lean/verification/2026_08_30_uniform_gate"
ANCESTOR = ROOT / "Lean/verification/2026_08_30_continuation"
MANIFEST = HERE / "SHA256SUMS"
PREVIOUS_SHA = "c470be98f60af38a31b8a00393d09f276e10d223c197034cfd1a1ee5628afe7a"
PDF_SHA = "752027de98d87d2457e2c038fda635b212a6534d63b9f82e903c66eb7484a4c1"
ALLOWED = {"propext", "Classical.choice", "Quot.sound"}


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path: Path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def entries(path: Path) -> list[tuple[str, str]]:
    values = []
    for line in path.read_text(encoding="utf-8-sig").splitlines():
        if not line:
            continue
        expected, name = line.split("  ", 1)
        if not re.fullmatch(r"[0-9a-f]{64}", expected):
            raise ValueError(f"Invalid digest in {path}: {expected}")
        values.append((expected, name))
    return values


def verify(values, mapping=None):
    remapping = mapping or {}
    failures = []
    seen = set()
    for expected, name in values:
        actual_name = remapping.get(name, name)
        actual = (ROOT / actual_name).resolve()
        if not actual.is_relative_to(ROOT.resolve()):
            failures.append(f"Path leaves repository: {actual_name}")
            continue
        if name in seen:
            failures.append(f"Duplicate path: {name}")
        seen.add(name)
        if not actual.is_file():
            failures.append(f"Missing file: {actual_name}")
        elif digest(actual) != expected:
            failures.append(f"Hash mismatch: {name} -> {actual_name}")
    return failures


def scoped_files() -> list[Path]:
    files = {ROOT / name for _, name in entries(PREVIOUS / "SHA256SUMS")}
    modules = read(HERE / "declarations.json")
    files.update(ROOT / "Lean/IUTThreeClosures" / f"{module}.lean" for module in modules)
    files.add(ROOT / "Lean/IUTThreeClosures/ResearchGaloisLifts20260830Audit.lean")
    reports = [
        "ABC_GALOIS_LIFTS_2026_08_31.md",
        "FREY_139_REALIZATION_ARITHMETIC_CROSS_REVIEW_2026_08_30.md",
        "FREY_139_TATE_210_REALIZATION_2026_08_30.md",
        "FREY_43_1289_BALANCED_LEGENDRE_REALIZATION_2026_08_30.md",
        "FREY_43_FORMAL_ARITHMETIC_PROOFS_2026_08_30.md",
        "FREY_GALOIS_REALIZATIONS_TEX_CROSS_REVIEW_2026_08_30.md",
        "FREY_POWERFREE_CRT_EXISTENCE_FAMILY_2026_08_30.md",
        "GALOIS_LIFTS_ROOT_CROSS_REVIEW_2026_08_30.md",
        "GEOMETRY_43_1289_ARITHMETIC_CERTIFICATE_2026_08_30.json",
        "IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md",
        "IUT_GENERAL_TAME_SQUARE_LABELS_2026_08_30.md",
        "IUT_INITIAL_DATA_BALANCED43_AUDIT_2026_08_30.md",
        "IUT_INITIAL_DATA_BALANCED43_CROSS_REVIEW_2026_08_30.md",
        "IUT_INITIAL_DATA_BALANCED43_GEOMETRY_REVIEW_2026_08_31.md",
        "IUT_INITIAL_DATA_POWERFREE_FAMILY_2026_08_31.md",
        "IUT_INITIAL_DATA_POWERFREE_GEOMETRY_REVIEW_2026_08_31.md",
        "IUT_MINIMUM_LAYER_ARITHMETIC_CROSS_REVIEW_2026_08_30.md",
        "IUT_NATIVE_PILOT_DICTIONARY_2026_08_30.md",
        "IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md",
        "IUT_THREE_LABEL_MINIMUM_LAYER_CROSS_REVIEW_2026_08_30.md",
        "JW_CROSS_HANDLE_AUTOMORPHISM_CROSS_REVIEW_2026_08_30.md",
        "SL2_TRANSVECTION_GENERATION_2026_08_30.md",
        "TRACE_DUAL_PREIDEAL_EXACT_HULL_2026_08_31.md",
        "TRACE_DUAL_PREIDEAL_EXACT_HULL_CROSS_REVIEW_2026_08_31.md",
        "TRACE_DUAL_PREIDEAL_LEAN_BOUNDARY_2026_08_31.md",
    ]
    files.update(ROOT / "research" / name for name in reports)
    for name in ["galois_lifts_continuation_2026.tex", "native_pilot_dictionary_2026.tex",
                 "frey_galois_realizations_2026.tex", "general_tame_square_labels_2026.tex",
                 "initial_theta_data_2026.tex", "powerfree_global_family_2026.tex"]:
        files.add(ROOT / "paper" / name)
    for directory in [
        PREVIOUS, HERE,
        ROOT / "research/sources/galois_lift_2026_08_30",
        ROOT / "research/sources/initial_data_2026_08_30",
        ROOT / "research/sources/frey_powerfree_family_2026_08_30",
        ROOT / "tmp/pdfs/abc_galois_lifts_qa_2026_08_31",
    ]:
        files.update(p for p in directory.rglob("*") if p.is_file()
                     and "__pycache__" not in p.parts
                     and p not in {MANIFEST, HERE / "manifest-verification.json"})
    return sorted(files, key=lambda p: p.relative_to(ROOT).as_posix())


def validate_record() -> list[str]:
    failures = []
    summary = read(HERE / "validation_summary.json")
    checks = {
        "PDF metadata": summary["pdf_sha256"] == PDF_SHA and summary["pdf_pages"] == 66
            and summary["pdf_bytes"] == 555812 and summary["pdf_author"] == "ChatGPT",
        "PDF actual bytes": digest(ROOT / "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf") == PDF_SHA,
        "All pages visually reviewed": summary["inspected_pages"] == list(range(1, 67)),
        "Build completion": summary["build_completion_jobs"] == 9129,
        "New module and audit warnings": summary["new_module_warning_count"] == 0
            and summary["audit_warning_count"] == 0,
        "Declaration counts": summary["public_theorem_count"] == 130
            and summary["additional_construction_count"] == 15
            and summary["audited_declaration_count"] == 145,
        "No extra axioms": not summary["unexpected_axioms"] and not summary["audit_has_sorryAx"],
        "No claimed ABC result": summary["standard_abc_proof_or_disproof"] is False,
        "No claimed external peer review": summary["external_human_peer_review"] is False,
        "TeX warnings": not summary["final_tex_warning_lines"],
    }
    failures.extend(name for name, passed in checks.items() if not passed)
    expected_names = set()
    for filename in ["declarations.json", "constructions.json"]:
        for names in read(HERE / filename).values():
            expected_names.update(names)
    log = (HERE / "axioms.txt").read_text(encoding="utf-8")
    reports = {name: {a.strip() for a in body.split(",") if a.strip()}
               for name, body in re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", log, re.S)}
    for name in re.findall(r"'([^']+)' does not depend on any axioms", log):
        reports[name] = set()
    if set(reports) != expected_names or len(reports) != 145:
        failures.append("Actual dependency reports differ from declared audit scope")
    if any(not dependencies <= ALLOWED for dependencies in reports.values()):
        failures.append("Nonstandard actual dependency")
    if any(word in log for word in ["sorryAx", "error:", "warning:"]):
        failures.append("Actual audit contains a forbidden dependency, error or warning")
    for name, expected in summary["visual_qa_record_sha256"].items():
        if digest(HERE / name) != expected:
            failures.append(f"Visual report changed: {name}")
        if PDF_SHA not in (HERE / name).read_text(encoding="utf-8"):
            failures.append(f"Visual report identifies a different artifact: {name}")
    for name, expected in read(HERE / "environment.json")["protected_file_sha256"].items():
        if digest(ROOT / name) != expected:
            failures.append(f"Protected core/pin changed: {name}")
    for source in read(HERE / "source_metadata.json")["sources"]:
        if digest(ROOT / source["path"]) != source["sha256"]:
            failures.append(f"Original source changed: {source['path']}")
    return failures


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true")
    args = parser.parse_args()
    previous_values = entries(PREVIOUS / "SHA256SUMS")
    previous_map = read(HERE / "previous-manifest-map.json")
    previous_failures = verify(previous_values, previous_map)
    if digest(PREVIOUS / "SHA256SUMS") != PREVIOUS_SHA:
        previous_failures.append("Previous immutable manifest changed")
    if len(previous_values) != 506 or len(previous_map) != 6:
        previous_failures.append("Previous snapshot scope changed")
    ancestor_values = entries(ANCESTOR / "SHA256SUMS")
    ancestor_map = read(PREVIOUS / "previous-manifest-map.json")
    ancestor_failures = verify(ancestor_values, ancestor_map)
    if len(ancestor_values) != 447 or len(ancestor_map) != 10:
        ancestor_failures.append("Ancestor snapshot scope changed")
    metadata_failures = validate_record()
    if args.write and not (previous_failures or ancestor_failures or metadata_failures):
        files = scoped_files()
        MANIFEST.write_text("".join(f"{digest(p)}  {p.relative_to(ROOT).as_posix()}\n"
                                    for p in files), encoding="utf-8")
    values = entries(MANIFEST) if MANIFEST.exists() else []
    failures = verify(values) + metadata_failures
    if not values:
        failures.append("Current manifest has not been created")
    expected_scope = {p.relative_to(ROOT).as_posix() for p in scoped_files()}
    if {name for _, name in values} != expected_scope:
        failures.append("Current manifest differs from the explicitly scoped file set")
    result = {"checked_files": len(values), "failures": failures,
              "previous_checked_files": len(previous_values), "previous_remapped_paths": len(previous_map),
              "previous_failures": previous_failures,
              "ancestor_checked_files": len(ancestor_values), "ancestor_remapped_paths": len(ancestor_map),
              "ancestor_failures": ancestor_failures, "pdf_sha256": PDF_SHA,
              "manifest_sha256": digest(MANIFEST) if MANIFEST.exists() else None,
              "standard_abc_proof_or_disproof": False}
    print(json.dumps(result, ensure_ascii=False))
    if failures or previous_failures or ancestor_failures:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
