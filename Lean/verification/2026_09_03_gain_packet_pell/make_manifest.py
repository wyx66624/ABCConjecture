#!/usr/bin/env python3
"""Seal the integrated gain/packet/Pell checkpoint, excluding transient caches."""

from __future__ import annotations

import hashlib
from pathlib import Path


HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
OUTPUT = HERE / "SHA256SUMS"

SINGLE_FILES = [
    ".gitattributes",
    "README.md",
    "Lean/IUTThreeClosures.lean",
    "Lean/IUTThreeClosures/ABCSynchronizedDivisorPackets20260903.lean",
    "Lean/IUTThreeClosures/ABCSynchronizedDivisorPackets20260903AxiomAudit.lean",
    "Lean/IUTThreeClosures/ABCCanonicalGainSurface20260903.lean",
    "Lean/IUTThreeClosures/ABCCanonicalGainSurface20260903AxiomAudit.lean",
    "Lean/IUTThreeClosures/SynchronizedPacketRadicalExcessObstruction20260903.lean",
    "Lean/IUTThreeClosures/SynchronizedPacketRadicalExcessObstruction20260903AxiomAudit.lean",
    "Lean/IUTThreeClosures/PellSignedTraceProjector20260903.lean",
    "Lean/IUTThreeClosures/PellSignedTraceProjector20260903AxiomAudit.lean",
    "Lean/RESEARCH_ROUTE_REGISTRY.md",
    "Lean/RESEARCH_STATUS.md",
    "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf",
    "paper/ChatGPT_ABC_Uniformity_2026.tex",
    "paper/abc_synchronized_divisor_packets_2026.tex",
    "paper/abc_canonical_gain_surface_2026.tex",
    "paper/synchronized_packet_radical_excess_obstruction_2026.tex",
    "paper/pell_signed_trace_projector_2026.tex",
    "research/ABC_FIVE_ROUTE_ADVERSARIAL_REVIEW_2026_09_02.md",
    "research/ABC_MULTI_ROUTE_QUANTITATIVE_TRANSVERSALITY_GENERATED_PACKETS_2026_09_03.md",
    "research/ABC_SYNCHRONIZED_DIVISOR_PACKET_SPECTRUM_2026_09_03.md",
    "research/ABC_CANONICAL_GAIN_SURFACE_AND_DEFECT_FLAG_2026_09_03.md",
    "research/ABC_MULTI_ROUTE_GAIN_PACKET_TRACE_SYNTHESIS_2026_09_03.md",
    "research/ABC_PELL_SIGNED_TRACE_PROJECTOR_2026_09_03.md",
    "research/ABC_SYNCHRONIZED_PACKET_RADICAL_EXCESS_OBSTRUCTION_2026_09_03.md",
]

TREE_ROOTS = [
    "Lean/verification/2026_09_03_gain_packet_pell",
    "research/computation/2026_09_03_synchronized_divisor_packets",
    "research/verification/2026_09_03_synchronized_divisor_packets",
    "research/computation/2026_09_03_canonical_gain_surface",
    "research/computation/2026_09_03_packet_radical_excess_obstruction",
    "research/computation/2026_09_03_pell_signed_trace_projector",
    "research/sources/abc_gain_surface_2026_09_03",
    "research/verification/2026_09_03_canonical_gain_surface",
    "research/verification/2026_09_03_packet_radical_excess_obstruction",
    "output/latex_2026_09_03_pell_signed_trace_projector",
    "output/pdf/ChatGPT_ABC_Gain_Packet_Trace_2026_09_03_QA",
]


def digest(path: Path) -> str:
    value = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1 << 20), b""):
            value.update(block)
    return value.hexdigest()


def main() -> None:
    files = {REPO / relative for relative in SINGLE_FILES}
    for relative in TREE_ROOTS:
        files.update(path for path in (REPO / relative).rglob("*") if path.is_file())
    files.discard(OUTPUT)
    files = {path for path in files if "__pycache__" not in path.parts}
    missing = [path for path in files if not path.is_file()]
    if missing:
        raise SystemExit(f"missing manifest inputs: {missing}")
    rows = [
        f"{digest(path)}  {path.relative_to(REPO).as_posix()}\n"
        for path in sorted(files, key=lambda item: item.relative_to(REPO).as_posix())
    ]
    OUTPUT.write_text("".join(rows), encoding="utf-8", newline="\n")
    print(f"sealed {len(rows)} files in {OUTPUT.relative_to(REPO).as_posix()}")


if __name__ == "__main__":
    main()
