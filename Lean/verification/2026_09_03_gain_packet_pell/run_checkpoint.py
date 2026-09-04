#!/usr/bin/env python3
"""Replay the gain/packet/Pell checkpoint and freeze command logs."""

from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path


HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
LEAN = REPO / "Lean"


def run(name: str, argv: list[str], cwd: Path) -> dict[str, object]:
    start = time.monotonic()
    proc = subprocess.run(
        argv,
        cwd=cwd,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        encoding="utf-8",
        errors="replace",
        check=False,
    )
    elapsed = round(time.monotonic() - start, 3)
    (HERE / f"{name}.log").write_text(proc.stdout, encoding="utf-8", newline="\n")
    (HERE / f"{name}.exitcode").write_text(
        f"{proc.returncode}\n", encoding="ascii", newline="\n"
    )
    print(f"{name}: exit={proc.returncode} seconds={elapsed}", flush=True)
    return {
        "name": name,
        "argv": argv,
        "cwd": str(cwd),
        "exit_code": proc.returncode,
        "elapsed_seconds": elapsed,
        "output_bytes": len(proc.stdout.encode("utf-8")),
    }


def main() -> int:
    modules = [
        "ABCCanonicalGainSurface20260903",
        "SynchronizedPacketRadicalExcessObstruction20260903",
        "PellSignedTraceProjector20260903",
    ]
    records: list[dict[str, object]] = []

    for module in modules:
        stem = module.replace("20260903", "").lower()
        records.append(
            run(
                f"{stem}-main-strict",
                [
                    "lake",
                    "env",
                    "lean",
                    "-DwarningAsError=true",
                    f"IUTThreeClosures/{module}.lean",
                ],
                LEAN,
            )
        )
        records.append(
            run(
                f"{stem}-axiom-audit-strict",
                [
                    "lake",
                    "env",
                    "lean",
                    "-DwarningAsError=true",
                    f"IUTThreeClosures/{module}AxiomAudit.lean",
                ],
                LEAN,
            )
        )

    legacy_packet = "ABCSynchronizedDivisorPackets20260903"
    records.append(
        run(
            "legacy-synchronized-packet-build",
            ["lake", "build", f"IUTThreeClosures.{legacy_packet}"],
            LEAN,
        )
    )
    records.append(
        run(
            "legacy-synchronized-packet-main-strict",
            [
                "lake", "env", "lean", "-DwarningAsError=true",
                f"IUTThreeClosures/{legacy_packet}.lean",
            ],
            LEAN,
        )
    )
    records.append(
        run(
            "legacy-synchronized-packet-axiom-audit-strict",
            [
                "lake", "env", "lean", "-DwarningAsError=true",
                f"IUTThreeClosures/{legacy_packet}AxiomAudit.lean",
            ],
            LEAN,
        )
    )

    records.append(run("umbrella-build", ["lake", "build", "IUTThreeClosures"], LEAN))

    records.append(
        run(
            "canonical-gain-route-verifier",
            [sys.executable, "verify_checkpoint.py"],
            REPO / "research" / "verification" / "2026_09_03_canonical_gain_surface",
        )
    )
    records.append(
        run(
            "packet-radical-route-verifier",
            [sys.executable, "verify_artifacts.py"],
            REPO
            / "research"
            / "verification"
            / "2026_09_03_packet_radical_excess_obstruction",
        )
    )

    pell = REPO / "research" / "computation" / "2026_09_03_pell_signed_trace_projector"
    records.append(run("pell-search-verifier", [sys.executable, "verify_signed_trace_projector.py"], pell))
    records.append(run("pell-collision-certifier", [sys.executable, "certify_exact_collisions.py"], pell))
    records.append(
        run(
            "pell-formalization-audit",
            [
                sys.executable,
                "audit_formalization.py",
                "--main",
                str(LEAN / "IUTThreeClosures" / "PellSignedTraceProjector20260903.lean"),
                "--audit",
                str(LEAN / "IUTThreeClosures" / "PellSignedTraceProjector20260903AxiomAudit.lean"),
                "--audit-output",
                str(pell / "lean_axiom_audit_stdout.txt"),
                "--evidence-dir",
                str(pell),
                "--output",
                str(pell / "formalization_audit.json"),
            ],
            pell,
        )
    )
    records.append(
        run(
            "pell-text-validator",
            [
                sys.executable,
                "validate_text_artifacts.py",
                "--report",
                str(REPO / "research" / "ABC_PELL_SIGNED_TRACE_PROJECTOR_2026_09_03.md"),
                "--paper",
                str(REPO / "paper" / "pell_signed_trace_projector_2026.tex"),
                "--main-paper",
                str(REPO / "paper" / "ChatGPT_ABC_Uniformity_2026.tex"),
                "--output",
                str(pell / "text_artifact_validation.json"),
            ],
            pell,
        )
    )

    status = "PASS" if all(r["exit_code"] == 0 for r in records) else "FAIL"
    summary = {
        "schema": "abc-gain-packet-pell-replay-v1",
        "python": sys.version,
        "records": records,
        "status": status,
    }
    (HERE / "run_summary.json").write_text(
        json.dumps(summary, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    print(json.dumps({"tasks": len(records), "status": status}, sort_keys=True))
    return 0 if status == "PASS" else 1


if __name__ == "__main__":
    raise SystemExit(main())
