from __future__ import annotations

import json
import re
import subprocess
import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
LEAN = REPO / "Lean"
MODULE = "IUTThreeClosures/ABCCanonicalGainSurface20260903.lean"
AUDIT = "IUTThreeClosures/ABCCanonicalGainSurface20260903AxiomAudit.lean"


def run(name: str, command: list[str], cwd: Path) -> str:
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
    output = completed.stdout.replace("\r\n", "\n")
    (HERE / f"{name}.log").write_text(output, encoding="utf-8", newline="\n")
    if completed.returncode != 0:
        raise SystemExit(f"{name} failed with exit code {completed.returncode}")
    return output


def main() -> None:
    source = (LEAN / MODULE).read_text(encoding="utf-8")
    forbidden = {
        "sorry": len(re.findall(r"\bsorry\b", source)),
        "admit": len(re.findall(r"\badmit\b", source)),
        "custom_axiom_declaration": len(
            re.findall(r"(?m)^\s*axiom\s+[A-Za-z_]", source)
        ),
    }
    if any(forbidden.values()):
        raise SystemExit(f"forbidden source token found: {forbidden}")

    declaration_count = len(
        re.findall(r"(?m)^(?:def|theorem|lemma|structure|abbrev)\s+", source)
    )
    audit_source = (LEAN / AUDIT).read_text(encoding="utf-8")
    audit_count = len(re.findall(r"(?m)^#print axioms\s+", audit_source))
    if declaration_count != 41 or audit_count != declaration_count:
        raise SystemExit(
            f"declaration/audit count mismatch: {declaration_count}/{audit_count}"
        )

    run(
        "source_verifier",
        [sys.executable, "research/sources/abc_gain_surface_2026_09_03/verify_sources.py"],
        REPO,
    )
    run(
        "computation_verifier",
        [
            sys.executable,
            "research/computation/2026_09_03_canonical_gain_surface/verify_output.py",
        ],
        REPO,
    )
    direct = run(
        "main_warning_as_error",
        ["lake", "env", "lean", "-DwarningAsError=true", MODULE],
        LEAN,
    )
    build = run(
        "lake_build",
        ["lake", "build", "IUTThreeClosures.ABCCanonicalGainSurface20260903"],
        LEAN,
    )
    audit = run(
        "axiom_audit_warning_as_error",
        ["lake", "env", "lean", "-DwarningAsError=true", AUDIT],
        LEAN,
    )

    allowed = {"propext", "Classical.choice", "Quot.sound"}
    observed: set[str] = set()
    for block in re.findall(r"depends on axioms: \[([^\]]*)\]", audit, flags=re.S):
        observed.update(x.strip() for x in block.replace("\n", " ").split(",") if x.strip())
    if not observed <= allowed:
        raise SystemExit(f"unexpected axiom dependency: {sorted(observed - allowed)}")

    summary = {
        "status": "PASS",
        "declarations": declaration_count,
        "axiom_audits": audit_count,
        "axiom_union": sorted(observed),
        "forbidden_source_tokens": forbidden,
        "direct_output_bytes": len(direct.encode("utf-8")),
        "build_completed": "Build completed successfully" in build,
        "source_capsule_verified": True,
        "finite_search_verified": True,
        "claim_boundary": "No unconditional ABCConjecture inhabitant and no abc counterexample.",
    }
    (HERE / "verification_summary.json").write_text(
        json.dumps(summary, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    print(json.dumps(summary, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()

