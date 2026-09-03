#!/usr/bin/env python3
"""Reproduce the Steinberg five-term boundary checkpoint validations."""

from __future__ import annotations

import json
from pathlib import Path
import re
import subprocess
import sys


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
LEAN = ROOT / "Lean"
MODULE = "IUTThreeClosures/SteinbergFiveTermBoundaryBridge20260903.lean"
AUDIT = "IUTThreeClosures/SteinbergFiveTermBoundaryBridge20260903AxiomAudit.lean"
ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}


def run(command: list[str], cwd: Path) -> subprocess.CompletedProcess[str]:
    completed = subprocess.run(
        command,
        cwd=cwd,
        text=True,
        encoding="utf-8",
        errors="replace",
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
    )
    if completed.returncode:
        sys.stdout.write(completed.stdout)
        raise SystemExit(completed.returncode)
    return completed


def main() -> None:
    scan = run([sys.executable, "exhaustive_five_term_scan.py"], HERE)
    observed = json.loads(scan.stdout)
    frozen = json.loads((HERE / "scan.json").read_text(encoding="utf-8"))
    if observed != frozen:
        raise AssertionError("finite scan differs from frozen scan.json")

    build = run(
        ["lake", "build", "IUTThreeClosures.SteinbergFiveTermBoundaryBridge20260903"],
        LEAN,
    )
    direct = run(["lake", "env", "lean", "-DwarningAsError=true", MODULE], LEAN)
    audit = run(["lake", "env", "lean", "-DwarningAsError=true", AUDIT], LEAN)

    axiom_blocks = re.findall(
        r"depends on axioms:\s*\[(.*?)\]", audit.stdout, flags=re.DOTALL
    )
    observed_axioms = {
        name.strip()
        for block in axiom_blocks
        for name in block.replace("\r", "").replace("\n", " ").split(",")
        if name.strip()
    }
    unexpected = observed_axioms - ALLOWED_AXIOMS
    if unexpected:
        raise AssertionError(f"unexpected axioms: {sorted(unexpected)}")

    forbidden = re.compile(r"(?m)^\s*(?:axiom|axioms)\b|\b(?:sorry|admit)\b")
    lexical_hits: dict[str, list[str]] = {}
    for relative in (MODULE, AUDIT):
        text = (LEAN / relative).read_text(encoding="utf-8")
        hits = [match.group(0) for match in forbidden.finditer(text)]
        if hits:
            lexical_hits[relative] = hits
    if lexical_hits:
        raise AssertionError(f"forbidden declarations/tactics: {lexical_hits}")

    result = {
        "status": "PASS",
        "finite_scan_matches_frozen_json": True,
        "lake_build_exit_code": build.returncode,
        "strict_module_exit_code": direct.returncode,
        "strict_axiom_audit_exit_code": audit.returncode,
        "observed_axioms": sorted(observed_axioms),
        "unexpected_axioms": [],
        "sorry_admit_axiom_declarations": [],
        "note": "lake build may replay pre-existing warnings; both new files pass direct warning-as-error compilation.",
    }
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
