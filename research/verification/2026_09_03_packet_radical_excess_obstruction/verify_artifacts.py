#!/usr/bin/env python3
"""Static verifier for the packet radical-excess checkpoint."""

from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]

MAIN = ROOT / "Lean/IUTThreeClosures/SynchronizedPacketRadicalExcessObstruction20260903.lean"
AUDIT = ROOT / "Lean/IUTThreeClosures/SynchronizedPacketRadicalExcessObstruction20260903AxiomAudit.lean"
REPORT = ROOT / "research/ABC_SYNCHRONIZED_PACKET_RADICAL_EXCESS_OBSTRUCTION_2026_09_03.md"
PAPER = ROOT / "paper/synchronized_packet_radical_excess_obstruction_2026.tex"
COMP = ROOT / "research/computation/2026_09_03_packet_radical_excess_obstruction"
SEARCH = COMP / "search_packet_radical_excess.py"
OUTPUT = COMP / "OUTPUT.json"
RUN_LOG = COMP / "RUN.log"
COMP_SUMS = COMP / "SHA256SUMS"
AXIOM_LOG = HERE / "axiom-audit.log"
PDF = HERE / "latex-build/paper-fragment-wrapper.pdf"


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def assert_utf8_no_controls(path: Path) -> None:
    data = path.read_bytes()
    data.decode("utf-8")
    bad = [(i, b) for i, b in enumerate(data) if b < 32 and b not in (9, 10, 13)]
    assert not bad, (path, bad[:20])


def parse_decl_names(text: str) -> list[str]:
    return re.findall(
        r"(?m)^(?:noncomputable\s+)?(?:def|theorem|abbrev)\s+([A-Za-z0-9_]+)",
        text,
    )


def main() -> None:
    required = [
        MAIN,
        AUDIT,
        REPORT,
        PAPER,
        SEARCH,
        OUTPUT,
        RUN_LOG,
        COMP_SUMS,
        AXIOM_LOG,
        PDF,
        HERE / "main-direct.log",
        HERE / "lake-build.log",
        HERE / "latex-compile.json",
        HERE / "README.md",
        HERE / "paper-fragment-wrapper.tex",
    ]
    assert all(path.is_file() for path in required)
    for path in required:
        if path == PDF:
            continue
        assert_utf8_no_controls(path)

    main_text = MAIN.read_text(encoding="utf-8")
    audit_text = AUDIT.read_text(encoding="utf-8")
    report_text = REPORT.read_text(encoding="utf-8")
    assert r"\arepsilon" not in report_text
    assert report_text.count(r"\varepsilon") == 8
    assert not re.search(r"\b(sorry|admit|axiom|native_decide)\b", main_text)

    declarations = parse_decl_names(main_text)
    audit_targets = re.findall(r"(?m)^#print axioms (\S+)", audit_text)
    missing = [
        name
        for name in declarations
        if not any(target == name or target.endswith("." + name) for target in audit_targets)
    ]
    assert not missing, missing
    assert len(declarations) == len(audit_targets) == 37

    axiom_text = AXIOM_LOG.read_text(encoding="utf-8")
    axiom_union: set[str] = set()
    for block in re.findall(r"depends on axioms: \[(.*?)\]", axiom_text, re.S):
        axiom_union.update(
            value.strip()
            for value in block.replace("\n", " ").split(",")
            if value.strip()
        )
    assert axiom_union == {"propext", "Classical.choice", "Quot.sound"}, axiom_union
    assert "native_decide" not in axiom_text

    exit_codes = {}
    for name in (
        "main-direct.log.exitcode",
        "lake-build.log.exitcode",
        "axiom-audit.log.exitcode",
        "latex-compile.json.exitcode",
    ):
        value = int((HERE / name).read_text(encoding="utf-8-sig").strip())
        assert value == 0, (name, value)
        exit_codes[name] = value

    output = json.loads(OUTPUT.read_text(encoding="utf-8"))
    assert sha256(SEARCH) == output["script_sha256"]
    assert OUTPUT.read_bytes() == RUN_LOG.read_bytes()
    assert output["parameters"] == {"limit": 3000, "dyadic_k_range": [0, 20]}
    assert output["primitive_triples_exhausted"] == 1_365_095
    assert output["packets_exhausted"] == 1_366_531
    assert output["proper_packets_exhausted"] == 1_436
    assert len(output["dyadic_family_exact_audit"]) == 21
    assert all(
        row["all_packets_fail_B_cubed_le_R_fourth"]
        for row in output["dyadic_family_exact_audit"]
    )

    expected_comp_sums = {}
    for line in COMP_SUMS.read_text(encoding="utf-8").splitlines():
        digest, name = line.split(maxsplit=1)
        expected_comp_sums[name] = digest
    assert expected_comp_sums == {
        "search_packet_radical_excess.py": sha256(SEARCH),
        "OUTPUT.json": sha256(OUTPUT),
        "RUN.log": sha256(RUN_LOG),
    }

    latex = json.loads((HERE / "latex-compile.json").read_text(encoding="utf-8-sig"))
    assert latex["exitCode"] == 0 and latex["pdfExists"]
    assert PDF.stat().st_size > 10_000
    assert PDF.read_bytes().startswith(b"%PDF")

    summary = {
        "status": "PASS",
        "declarations": len(declarations),
        "axiom_audit_targets": len(audit_targets),
        "axiom_union": sorted(axiom_union),
        "lean_exit_codes": exit_codes,
        "primitive_triples_exhausted": output["primitive_triples_exhausted"],
        "packets_exhausted": output["packets_exhausted"],
        "proper_packets_exhausted": output["proper_packets_exhausted"],
        "dyadic_rows_checked": len(output["dyadic_family_exact_audit"]),
        "paper_fragment_pdf_bytes": PDF.stat().st_size,
        "script_sha256": sha256(SEARCH),
        "output_sha256": sha256(OUTPUT),
    }
    (HERE / "verification-summary.json").write_text(
        json.dumps(summary, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    print(json.dumps(summary, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
