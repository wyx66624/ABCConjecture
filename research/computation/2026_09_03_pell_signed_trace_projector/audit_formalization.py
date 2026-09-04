#!/usr/bin/env python3
"""Machine-check the strict Lean and axiom-audit evidence."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path


EXPECTED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}


def read_exit_code(path: Path) -> int:
    return int(path.read_text(encoding="utf-8-sig").strip())


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--main", type=Path, required=True)
    parser.add_argument("--audit", type=Path, required=True)
    parser.add_argument("--audit-output", type=Path, required=True)
    parser.add_argument("--evidence-dir", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    main_text = args.main.read_text(encoding="utf-8")
    audit_source = args.audit.read_text(encoding="utf-8")
    audit_output = args.audit_output.read_text(encoding="utf-8")
    declarations = re.findall(r"^(?:theorem|def)\s+([A-Za-z0-9_]+)", main_text, re.MULTILINE)
    checked = re.findall(r"^#check\s+([A-Za-z0-9_]+)", audit_source, re.MULTILINE)
    printed = re.findall(r"^#print axioms\s+([A-Za-z0-9_]+)", audit_source, re.MULTILINE)

    axiom_blocks = re.findall(
        r"depends on axioms: \[(.*?)\]",
        audit_output,
        flags=re.DOTALL,
    )
    axiom_union = {
        name.strip()
        for block in axiom_blocks
        for name in block.replace("\n", " ").split(",")
        if name.strip()
    }
    audit_records = len(
        re.findall(
            r"(?:depends on axioms:|does not depend on any axioms)",
            audit_output,
        )
    )
    forbidden = {
        token: bool(re.search(pattern, main_text, flags=re.MULTILINE))
        for token, pattern in {
            "sorry": r"\bsorry\b",
            "admit": r"\badmit\b",
            "custom_axiom_declaration": r"^\s*axiom\s+",
            "native_decide": r"\bnative_decide\b",
        }.items()
    }
    checks = {
        "strict_main_exit_zero":
            read_exit_code(args.evidence_dir / "lean_main_strict_exitcode.txt") == 0,
        "lake_build_exit_zero":
            read_exit_code(args.evidence_dir / "lake_build_exitcode.txt") == 0,
        "strict_audit_exit_zero":
            read_exit_code(args.evidence_dir / "lean_axiom_audit_exitcode.txt") == 0,
        "every_declaration_checked_once":
            len(checked) == len(declarations) and set(checked) == set(declarations),
        "every_declaration_printed_once":
            len(printed) == len(declarations) and set(printed) == set(declarations),
        "audit_output_has_every_record": audit_records == len(declarations),
        "axiom_union_is_standard": axiom_union == EXPECTED_AXIOMS,
        "no_forbidden_proof_placeholders": not any(forbidden.values()),
    }
    result = {
        "schema": "pell-signed-trace-formalization-audit-v1",
        "declaration_count": len(declarations),
        "checked_count": len(checked),
        "printed_axiom_count": len(printed),
        "audit_record_count": audit_records,
        "axiom_union": sorted(axiom_union),
        "forbidden_tokens_present": forbidden,
        "checks": checks,
        "status": "PASS" if all(checks.values()) else "FAIL",
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    if result["status"] != "PASS":
        raise SystemExit(1)


if __name__ == "__main__":
    main()
