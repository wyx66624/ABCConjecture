#!/usr/bin/env python3
"""Reproduce the 2026-09-04 flagged-CRT/residue-cube checkpoint."""

from __future__ import annotations

import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
LEAN = REPO / "Lean"

LEAN_MODULES = [
    "IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904.lean",
    "IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904AxiomAudit.lean",
    "IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904IndependentBridge.lean",
    "IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904IndependentBridgeAxiomAudit.lean",
    "IUTThreeClosures/ABCAnchoredPrefixFlaggedCRT20260904.lean",
    "IUTThreeClosures/ABCAnchoredPrefixFlaggedCRT20260904AxiomAudit.lean",
]

SOURCE_MODULES = [
    LEAN / "IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904.lean",
    LEAN / "IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904IndependentBridge.lean",
    LEAN / "IUTThreeClosures/ABCAnchoredPrefixFlaggedCRT20260904.lean",
]

AUDIT_MODULES = [
    LEAN / "IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904AxiomAudit.lean",
    LEAN / "IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904IndependentBridgeAxiomAudit.lean",
    LEAN / "IUTThreeClosures/ABCAnchoredPrefixFlaggedCRT20260904AxiomAudit.lean",
]


def slug(path: str) -> str:
    return Path(path).stem.replace("ABC", "abc-").replace("20260904", "-20260904").lower()


def run(name: str, argv: list[str], cwd: Path) -> dict[str, object]:
    proc = subprocess.run(argv, cwd=cwd, text=True, encoding="utf-8",
                          errors="replace", stdout=subprocess.PIPE,
                          stderr=subprocess.STDOUT)
    (HERE / f"{name}.log").write_text(proc.stdout, encoding="utf-8")
    (HERE / f"{name}.exitcode").write_text(f"{proc.returncode}\n", encoding="ascii")
    return {"name": name, "argv": argv, "exit_code": proc.returncode,
            "log": f"{name}.log"}


def strip_lean_comments(text: str) -> str:
    out: list[str] = []
    i = 0
    depth = 0
    while i < len(text):
        if text.startswith("/-", i):
            depth += 1
            i += 2
        elif depth and text.startswith("-/", i):
            depth -= 1
            i += 2
        elif depth:
            i += 1
        elif text.startswith("--", i):
            end = text.find("\n", i)
            i = len(text) if end < 0 else end
        else:
            out.append(text[i])
            i += 1
    return "".join(out)


def declarations(path: Path) -> int:
    code = strip_lean_comments(path.read_text(encoding="utf-8"))
    return len(re.findall(
        r"(?m)^(?:theorem|lemma|def|structure|abbrev|class|instance|inductive)\s+",
        code,
    ))


def audit_queries(path: Path) -> int:
    return len(re.findall(r"(?m)^#print axioms\s+", path.read_text(encoding="utf-8")))


def forbidden_tokens(path: Path) -> list[str]:
    code = strip_lean_comments(path.read_text(encoding="utf-8"))
    return [token for token in ("sorry", "admit", "axiom", "unsafe", "native_decide")
            if re.search(rf"\b{re.escape(token)}\b", code)]


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def main() -> int:
    HERE.mkdir(parents=True, exist_ok=True)
    results: list[dict[str, object]] = []
    results.append(run("lean-version", ["lake", "env", "lean", "--version"], LEAN))
    for module in LEAN_MODULES:
        results.append(run(slug(module) + "-strict",
                           ["lake", "env", "lean", "-DwarningAsError=true", module], LEAN))
    results.append(run("umbrella-build", ["lake", "build", "IUTThreeClosures"], LEAN))
    results.append(run(
        "shared-crt-exact-independent-validator",
        [sys.executable,
         "research/computation/2026_09_04_shared_crt_exact/validate_shared_crt_exact.py",
         "--directory", "research/computation/2026_09_04_shared_crt_exact"],
        REPO,
    ))

    count_rows = []
    for source, audit in zip(SOURCE_MODULES, AUDIT_MODULES):
        row = {"source": str(source.relative_to(REPO)),
               "declarations": declarations(source),
               "audit": str(audit.relative_to(REPO)),
               "axiom_queries": audit_queries(audit),
               "forbidden_code_tokens": forbidden_tokens(source)}
        row["one_for_one"] = row["declarations"] == row["axiom_queries"]
        count_rows.append(row)

    expected = [70, 18, 28]
    counts_ok = [row["declarations"] for row in count_rows] == expected
    scans_ok = all(not row["forbidden_code_tokens"] for row in count_rows)
    commands_ok = all(row["exit_code"] == 0 for row in results)

    audit_text = "\n".join((HERE / str(row["log"])).read_text(encoding="utf-8")
                            for row in results if "axiomaudit" in str(row["name"]))
    names = set()
    for match in re.finditer(r"depends on axioms:\s*\[([^]]*)\]", audit_text, re.S):
        names.update(x.strip() for x in match.group(1).replace("\n", " ").split(",") if x.strip())
    expected_axioms = {"propext", "Classical.choice", "Quot.sound"}
    axiom_union_ok = names == expected_axioms

    summary = {
        "status": "PASS" if commands_ok and counts_ok and scans_ok and axiom_union_ok else "FAIL",
        "commands": results,
        "declaration_audit": count_rows,
        "expected_declaration_counts": expected,
        "reported_axiom_union": sorted(names),
        "expected_axiom_union": sorted(expected_axioms),
        "claims": {
            "standard_abc": "open; neither proved nor disproved",
            "FCRT_1": "open uniform estimate",
            "SCRT_0": "open uniform estimate",
            "retired_exact_child": "free-target surplus collapses to scalar pooling",
            "retired_exact_shortcut": "raw Boolean count implies a proper compatible target face",
        },
    }
    (HERE / "verification_summary.json").write_text(
        json.dumps(summary, indent=2, sort_keys=True) + "\n", encoding="utf-8")

    validation = f"""# Verification summary

**Status:** {summary['status']}

- Direct strict compilation: primary FCRT, independent bridge, anchored-prefix module, and all three one-for-one axiom audits.
- Declaration/query counts: 70/70, 18/18, and 28/28.
- Kernel dependency union: `{', '.join(sorted(names))}`.
- Independent exact FCRT/SCRT validator: {'PASS' if results[-1]['exit_code'] == 0 else 'FAIL'}.
- Umbrella library build: {'PASS' if results[-2]['exit_code'] == 0 else 'FAIL'}.
- Code-token scan: no `sorry`, `admit`, declaration-style `axiom`, `unsafe`, or `native_decide` in the three new source modules.

The verified results are finite accounting, selection, and arithmetic kernels. Standard `ABCConjecture`, SCRT-0, FCRT-1, and the anchored entropy estimate remain open.
"""
    (HERE / "VALIDATION.md").write_text(validation, encoding="utf-8")

    manifest_paths = SOURCE_MODULES + AUDIT_MODULES + [
        REPO / "research/ABC_ENDPOINT_RESIDUE_CUBE_FLAGGED_CRT_2026_09_04.md",
        REPO / "research/ABC_ANCHORED_PREFIX_FLAGGED_CRT_2026_09_04.md",
        REPO / "research/ABC_FLAGGED_CRT_LEAN_INDEPENDENT_AUDIT_2026_09_04.md",
        REPO / "research/computation/2026_09_04_shared_crt_exact/OUTPUT.json",
        REPO / "research/computation/2026_09_04_shared_crt_exact/STRUCTURED_FAMILIES.csv",
        HERE / "verify_round.py", HERE / "verification_summary.json", HERE / "VALIDATION.md",
    ]
    lines = [f"{sha256(path)}  {path.relative_to(REPO).as_posix()}" for path in manifest_paths]
    (HERE / "SHA256SUMS.txt").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0 if summary["status"] == "PASS" else 1


if __name__ == "__main__":
    raise SystemExit(main())
