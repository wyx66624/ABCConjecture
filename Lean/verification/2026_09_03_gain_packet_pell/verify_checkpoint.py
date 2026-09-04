#!/usr/bin/env python3
"""Static and replay-log validator for the gain/packet/Pell checkpoint."""

from __future__ import annotations

import hashlib
import json
import re
import sys
from collections import Counter
from pathlib import Path


HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
LEAN_DIR = REPO / "Lean" / "IUTThreeClosures"

EXPECTED = {
    "ABCCanonicalGainSurface20260903": 41,
    "SynchronizedPacketRadicalExcessObstruction20260903": 37,
    "PellSignedTraceProjector20260903": 36,
}
ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def text(path: Path) -> str:
    require(path.is_file(), f"missing file: {path}")
    return path.read_text(encoding="utf-8")


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1 << 20), b""):
            h.update(block)
    return h.hexdigest()


def declaration_names(source: str) -> list[str]:
    return re.findall(
        r"^(?:noncomputable\s+)?(?:def|abbrev|structure|theorem|lemma|instance)\s+"
        r"([A-Za-z_][A-Za-z0-9_.]*)",
        source,
        flags=re.MULTILINE,
    )


def check_modules() -> tuple[dict[str, int], set[str]]:
    counts: dict[str, int] = {}
    axiom_union: set[str] = set()
    for module, expected in EXPECTED.items():
        main_path = LEAN_DIR / f"{module}.lean"
        audit_path = LEAN_DIR / f"{module}AxiomAudit.lean"
        source = text(main_path)
        audit = text(audit_path)
        names = declaration_names(source)
        targets = re.findall(r"^#print axioms\s+([^\s]+)", audit, flags=re.MULTILINE)
        require(len(names) == expected, f"{module}: {len(names)} declarations, expected {expected}")
        require(len(targets) == expected, f"{module}: {len(targets)} axiom targets, expected {expected}")
        require(len(targets) == len(set(targets)), f"{module}: duplicate axiom target")
        require(not re.search(r"(?m)^\s*axiom\s+", source), f"{module}: custom axiom declaration")
        require(not re.search(r"\b(?:sorry|admit|sorryAx)\b", source), f"{module}: proof placeholder")

        stem = module.replace("20260903", "").lower()
        main_log = text(HERE / f"{stem}-main-strict.log")
        require(main_log == "", f"{module}: strict main log is not empty")
        require(text(HERE / f"{stem}-main-strict.exitcode").strip() == "0", f"{module}: strict main failed")

        audit_log = text(HERE / f"{stem}-axiom-audit-strict.log")
        require(text(HERE / f"{stem}-axiom-audit-strict.exitcode").strip() == "0", f"{module}: audit failed")
        blocks = re.findall(r"depends on axioms:\s*\[([^\]]*)\]", audit_log, flags=re.DOTALL)
        no_axiom = len(re.findall(r"does not depend on any axioms", audit_log))
        require(len(blocks) + no_axiom == expected, f"{module}: incomplete axiom output")
        for block in blocks:
            axiom_union.update(re.findall(r"[A-Za-z_][A-Za-z0-9_.]*", block))
        require("sorryAx" not in audit_log, f"{module}: sorryAx in audit")
        counts[module] = len(names)

    require(sum(counts.values()) == 114, "combined declaration count is not 114")
    require(axiom_union == ALLOWED_AXIOMS, f"unexpected axiom union: {sorted(axiom_union)}")
    return counts, axiom_union


def check_replays() -> None:
    expected_logs = [
        "legacy-synchronized-packet-build",
        "legacy-synchronized-packet-main-strict",
        "legacy-synchronized-packet-axiom-audit-strict",
        "canonical-gain-route-verifier",
        "packet-radical-route-verifier",
        "pell-search-verifier",
        "pell-collision-certifier",
        "pell-formalization-audit",
        "pell-text-validator",
        "umbrella-build",
    ]
    for name in expected_logs:
        require(text(HERE / f"{name}.exitcode").strip() == "0", f"{name} failed")
    pass_logs = [
        "canonical-gain-route-verifier",
        "packet-radical-route-verifier",
        "pell-search-verifier",
        "pell-collision-certifier",
        "pell-formalization-audit",
        "pell-text-validator",
    ]
    for name in pass_logs:
        require("PASS" in text(HERE / f"{name}.log"), f"{name} has no PASS marker")
    umbrella = text(HERE / "umbrella-build.log")
    require("Build completed successfully" in umbrella, "umbrella build did not complete")

    gain = json.loads(text(REPO / "research" / "computation" / "2026_09_03_canonical_gain_surface" / "OUTPUT.json"))
    packet = json.loads(text(REPO / "research" / "computation" / "2026_09_03_packet_radical_excess_obstruction" / "OUTPUT.json"))
    pell = json.loads(text(REPO / "research" / "computation" / "2026_09_03_pell_signed_trace_projector" / "signed_trace_projector_search.json"))
    pell_cert = json.loads(text(REPO / "research" / "computation" / "2026_09_03_pell_signed_trace_projector" / "exact_collision_certificates.json"))
    require(gain.get("status") == "PASS", "canonical gain computation status")
    require(packet.get("primitive_triples_exhausted") == 1_365_095,
            "packet primitive-triple count")
    require(packet.get("packets_exhausted") == 1_366_531,
            "packet count")
    packet_invariants = packet.get("proved_invariants_checked_on_every_packet", {})
    require(packet_invariants and all(packet_invariants.values()),
            "packet invariant audit")
    dyadic = packet.get("dyadic_family_exact_audit", [])
    require(len(dyadic) == 21 and
            all(row.get("all_packets_fail_B_cubed_le_R_fourth") is True
                for row in dyadic),
            "packet dyadic-family audit")
    require(pell.get("schema") == "pell-signed-trace-projector-search-v1",
            "Pell search schema")
    pell_counts = pell.get("counts", {})
    require(pell_counts.get("prime_indices") == 63_950 and
            pell_counts.get("candidate_prime_tests") == 764_366 and
            pell_counts.get("repeated_hits") == 2,
            "Pell search headline counts")
    require(len(pell.get("repeated_hits", [])) == 2,
            "Pell collision row count")
    require(pell_cert.get("status") == "PASS", "Pell certificate status")


def check_legacy_packet_audit() -> dict[str, object]:
    module = "ABCSynchronizedDivisorPackets20260903"
    audit = text(LEAN_DIR / f"{module}AxiomAudit.lean")
    targets = re.findall(r"^#print axioms\s+([^\s]+)", audit, flags=re.MULTILINE)
    require(len(targets) == 70, f"legacy packet audit has {len(targets)} targets")
    require(len(targets) == len(set(targets)), "legacy packet audit has duplicate target")
    require(text(HERE / "legacy-synchronized-packet-main-strict.log") == "",
            "legacy packet strict main log is not empty")
    log = text(HERE / "legacy-synchronized-packet-axiom-audit-strict.log")
    blocks = re.findall(r"depends on axioms:\s*\[([^\]]*)\]", log, flags=re.DOTALL)
    no_axiom = len(re.findall(r"does not depend on any axioms", log))
    require(len(blocks) + no_axiom == 70, "legacy packet axiom output is incomplete")
    axioms: set[str] = set()
    for block in blocks:
        axioms.update(re.findall(r"[A-Za-z_][A-Za-z0-9_.]*", block))
    require(axioms == ALLOWED_AXIOMS, f"legacy packet axiom union: {sorted(axioms)}")
    require("sorryAx" not in log, "legacy packet audit contains sorryAx")
    computation = (
        REPO / "research" / "computation" /
        "2026_09_03_synchronized_divisor_packets"
    )
    manifest_rows: dict[str, str] = {}
    for line in text(computation / "SHA256SUMS").splitlines():
        digest, name = line.split("  ", 1)
        require(re.fullmatch(r"[0-9a-f]{64}", digest) is not None,
                f"legacy packet malformed hash: {line}")
        manifest_rows[name] = digest
    require(set(manifest_rows) == {"search_synchronized_packets.py", "OUTPUT.json", "RUN.log"},
            "legacy packet manifest file set")
    for name, digest in manifest_rows.items():
        require(sha256(computation / name) == digest,
                f"legacy packet hash mismatch: {name}")
    require((computation / "OUTPUT.json").read_bytes() ==
            (computation / "RUN.log").read_bytes(),
            "legacy packet RUN.log differs from OUTPUT.json")
    payload = json.loads(text(computation / "OUTPUT.json"))
    expected_counts = {
        "primitive_triples_scanned": 3_795_230,
        "triples_packet_enumerated": 151_244,
        "packets_found": 151_711,
        "proper_packets_found": 467,
        "exact_gap_packet_count": 105,
    }
    for key, value in expected_counts.items():
        require(payload.get(key) == value, f"legacy packet count {key}")
    audit_payload = payload.get("candidate_audit", {})
    for key in [
        "corner_uniqueness_first_counterexample",
        "cubic_bound_first_counterexample",
        "quartic_bound_first_counterexample",
        "product_square_bound_first_counterexample",
    ]:
        require(audit_payload.get(key) is not None,
                f"legacy packet missing counterexample: {key}")
    require(audit_payload.get("proved_pair_max_and_sixth_power_bounds_checked") is True,
            "legacy packet proved-bound audit")
    worst = payload.get("worst_observed_max_power_needed", {})
    require(worst.get("abc") == [385, 527, 912],
            "legacy packet quintic witness triple")
    require(worst.get("packet") == [7, 31, 24],
            "legacy packet quintic witness packet")
    witness_abc = worst["abc"]
    witness_packet = worst["packet"]
    require(witness_abc[0] * witness_abc[1] * witness_abc[2]
            > max(witness_packet) ** 5,
            "legacy packet quintic witness inequality")
    return {
        "axiom_queries": len(targets),
        "axiom_union": sorted(axioms),
        "frozen_computation_manifest_entries": len(manifest_rows),
        "quintic_witness_checked": True,
        **expected_counts,
    }


def check_text_artifacts() -> dict[str, int]:
    paths = [
        REPO / "README.md",
        REPO / "Lean" / "RESEARCH_STATUS.md",
        REPO / "Lean" / "RESEARCH_ROUTE_REGISTRY.md",
        REPO / "research" / "ABC_CANONICAL_GAIN_SURFACE_AND_DEFECT_FLAG_2026_09_03.md",
        REPO / "research" / "ABC_SYNCHRONIZED_PACKET_RADICAL_EXCESS_OBSTRUCTION_2026_09_03.md",
        REPO / "research" / "ABC_PELL_SIGNED_TRACE_PROJECTOR_2026_09_03.md",
        REPO / "research" / "ABC_MULTI_ROUTE_GAIN_PACKET_TRACE_SYNTHESIS_2026_09_03.md",
        REPO / "research" / "ABC_SYNCHRONIZED_DIVISOR_PACKET_SPECTRUM_2026_09_03.md",
        REPO / "research" / "ABC_FIVE_ROUTE_ADVERSARIAL_REVIEW_2026_09_02.md",
        REPO / "research" / "ABC_MULTI_ROUTE_QUANTITATIVE_TRANSVERSALITY_GENERATED_PACKETS_2026_09_03.md",
        REPO / "paper" / "abc_synchronized_divisor_packets_2026.tex",
        REPO / "paper" / "abc_canonical_gain_surface_2026.tex",
        REPO / "paper" / "synchronized_packet_radical_excess_obstruction_2026.tex",
        REPO / "paper" / "pell_signed_trace_projector_2026.tex",
        REPO / "paper" / "ChatGPT_ABC_Uniformity_2026.tex",
        REPO / "Lean" / "IUTThreeClosures.lean",
    ]
    lengths: dict[str, int] = {}
    forbidden = [b"\x0b", b"\x0c", b"\\arepsilon", b",qquad", b"(square)"]
    for path in paths:
        raw = path.read_bytes()
        raw.decode("utf-8")
        require(b"\t" not in raw, f"{path}: TAB byte in authored text")
        for needle in forbidden:
            require(needle not in raw, f"{path}: forbidden byte sequence {needle!r}")
        unexpected = [b for b in raw if b < 32 and b not in (9, 10, 13)]
        require(not unexpected, f"{path}: unexpected C0 bytes {unexpected[:8]}")
        lengths[str(path.relative_to(REPO))] = len(raw)

    main = text(REPO / "paper" / "ChatGPT_ABC_Uniformity_2026.tex")
    umbrella = text(REPO / "Lean" / "IUTThreeClosures.lean")
    for fragment in [
        "abc_synchronized_divisor_packets_2026",
        "abc_canonical_gain_surface_2026",
        "synchronized_packet_radical_excess_obstruction_2026",
        "pell_signed_trace_projector_2026",
    ]:
        require(f"\\input{{{fragment}}}" in main, f"main paper omits {fragment}")
    for module in EXPECTED:
        require(f"import IUTThreeClosures.{module}" in umbrella, f"umbrella omits {module}")

    fragments = [
        text(REPO / "paper" / "abc_synchronized_divisor_packets_2026.tex"),
        text(REPO / "paper" / "abc_canonical_gain_surface_2026.tex"),
        text(REPO / "paper" / "synchronized_packet_radical_excess_obstruction_2026.tex"),
        text(REPO / "paper" / "pell_signed_trace_projector_2026.tex"),
    ]
    labels = [label for source in fragments for label in re.findall(r"\\label\{([^}]+)\}", source)]
    require(all(v == 1 for v in Counter(labels).values()), "duplicate labels among new fragments")
    bibkeys = set(re.findall(r"\\bibitem\{([^}]+)\}", main))
    citations = {
        key.strip()
        for source in fragments
        for group in re.findall(r"\\cite\{([^}]+)\}", source)
        for key in group.split(",")
    }
    require(citations <= bibkeys, f"missing bibliography keys: {sorted(citations - bibkeys)}")
    for source in fragments:
        require("\\documentclass" not in source and "\\begin{document}" not in source, "fragment has wrapper")
    return lengths


def check_pdf() -> dict[str, object]:
    pdf = REPO / "output" / "pdf" / "ChatGPT_ABC_Uniformity_2026.pdf"
    require(pdf.is_file(), "final paper PDF missing")
    try:
        from pypdf import PdfReader
    except ImportError as exc:
        raise AssertionError("pypdf is required for PDF verification") from exc
    reader = PdfReader(str(pdf))
    require(len(reader.pages) == 246, f"paper has {len(reader.pages)} pages, expected 246")
    metadata = reader.metadata or {}
    author = str(metadata.get("/Author", ""))
    require("ChatGPT" in author, f"unexpected PDF author: {author!r}")
    page_text = [page.extract_text() or "" for page in reader.pages]
    section_titles = [
        "Signed trace projectors",
        "Radical-excess obstructions",
        "Canonical gain surface",
    ]
    section_pages: dict[str, list[int]] = {}
    for title in section_titles:
        hits = [i + 1 for i, value in enumerate(page_text) if title in value]
        require(hits, f"section absent from extracted PDF text: {title}")
        section_pages[title] = hits

    compile_log = text(HERE / "paper-compile.json")
    require('"exitCode": 0' in compile_log, "paper compiler exit code missing")
    bad = ["Overfull \\hbox", "Underfull \\hbox", "undefined references", "multiply defined"]
    require(not any(item in compile_log for item in bad), "paper compiler reported a layout/reference warning")
    return {
        "path": str(pdf.relative_to(REPO)),
        "bytes": pdf.stat().st_size,
        "pages": len(reader.pages),
        "sha256": sha256(pdf),
        "author": author,
        "section_pages": section_pages,
    }


def main() -> int:
    counts, axioms = check_modules()
    check_replays()
    legacy_packet = check_legacy_packet_audit()
    lengths = check_text_artifacts()
    pdf = check_pdf()
    summary = {
        "schema": "abc-gain-packet-pell-verification-v1",
        "declaration_counts": counts,
        "declarations_total": sum(counts.values()),
        "axiom_union": sorted(axioms),
        "legacy_packet_audit": legacy_packet,
        "text_artifact_bytes": lengths,
        "paper": pdf,
        "status": "PASS",
    }
    (HERE / "verification_summary.json").write_text(
        json.dumps(summary, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        raise
