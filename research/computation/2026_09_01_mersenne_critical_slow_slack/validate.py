#!/usr/bin/env python3
"""Run the independent computation, integrity, and Lean checks."""

from __future__ import annotations

import hashlib
import re
import shutil
import subprocess
import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
LEAN_ROOT = ROOT / "Lean"
MODULE = LEAN_ROOT / "IUTThreeClosures" / "MersenneCriticalSlowSlackGate20260901.lean"
REPORT = ROOT / "research" / "ABC_MERSENNE_CRITICAL_SLOW_SLACK_GATE_2026_09_01.md"
SOURCE_AUDIT = ROOT / "research" / "sources" / "mersenne_critical_slow_slack_2026_09_01"


def run(command: list[str], cwd: Path) -> str:
    completed = subprocess.run(
        command,
        cwd=cwd,
        check=True,
        text=True,
        encoding="utf-8",
        errors="replace",
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    return completed.stdout


def verify_sha_file(directory: Path) -> int:
    manifest = directory / "SHA256SUMS"
    count = 0
    for line in manifest.read_text(encoding="utf-8").splitlines():
        expected, relative = line.split("  ", 1)
        actual = hashlib.sha256((directory / relative).read_bytes()).hexdigest()
        if actual != expected:
            raise AssertionError(f"hash mismatch: {directory / relative}")
        count += 1
    return count


def main() -> None:
    replay = run([sys.executable, str(HERE / "verify.py"), "--verify"], ROOT)
    if not replay.startswith("PASS:"):
        raise AssertionError(replay)

    computation_hashes = verify_sha_file(HERE)
    source_hashes = verify_sha_file(SOURCE_AUDIT)

    module_text = MODULE.read_text(encoding="utf-8")
    forbidden = re.compile(r"\b(?:sorry|admit|native_decide)\b|^\s*axiom\b", re.MULTILINE)
    hit = forbidden.search(module_text)
    if hit:
        raise AssertionError(f"forbidden Lean token: {hit.group(0)!r}")
    theorem_count = len(re.findall(r"^theorem\s+", module_text, re.MULTILINE))
    definition_count = len(
        re.findall(r"^(?:noncomputable\s+)?def\s+", module_text, re.MULTILINE)
    )
    if (theorem_count, definition_count) != (16, 4):
        raise AssertionError((theorem_count, definition_count))

    lake = shutil.which("lake")
    if lake is None:
        raise RuntimeError("lake executable not found")
    lean_output = run(
        [
            lake,
            "env",
            "lean",
            "-DwarningAsError=true",
            "IUTThreeClosures/MersenneCriticalSlowSlackGate20260901.lean",
        ],
        LEAN_ROOT,
    )
    if "sorryAx" in lean_output or "error:" in lean_output:
        raise AssertionError(lean_output)
    allowed_axioms = {"propext", "Classical.choice", "Quot.sound"}
    mentioned = set(re.findall(r"\b(?:propext|Classical\.choice|Quot\.sound|sorryAx)\b", lean_output))
    if not mentioned <= allowed_axioms:
        raise AssertionError(mentioned)

    report_text = REPORT.read_text(encoding="utf-8")
    required = [
        "critical slow-slack removal",
        "sigma_*(m)",
        "full-premise counterexample",
        "standard abc conjecture is neither proved nor disproved",
        "The target with\n\\(\\sigma=1\\) remains active",
    ]
    for marker in required:
        if marker not in report_text:
            raise AssertionError(f"missing report marker: {marker}")

    print(
        "PASS: computation replay; "
        f"{computation_hashes + source_hashes} hashes; "
        f"Lean {theorem_count} theorems/{definition_count} definitions; "
        "standard axioms only"
    )


if __name__ == "__main__":
    main()
