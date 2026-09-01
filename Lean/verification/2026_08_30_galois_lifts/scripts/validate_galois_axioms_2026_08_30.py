"""Audit every requested declaration, including the zero-axiom output form."""
from pathlib import Path
import json
import re

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_30_galois_lifts"
allowed = {"propext", "Classical.choice", "Quot.sound"}
theorems = json.loads((RECORD / "declarations.json").read_text(encoding="utf-8"))
constructions = json.loads((RECORD / "constructions.json").read_text(encoding="utf-8"))
expected = [n for mapping in [theorems, constructions] for names in mapping.values() for n in names]
log = (RECORD / "axioms.txt").read_text(encoding="utf-8")
reports = {}
for match in re.finditer(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", log, re.S):
    name, contents = match.groups()
    assert name not in reports, f"Duplicate audit: {name}"
    reports[name] = [x.strip() for x in contents.split(",") if x.strip()]
for match in re.finditer(r"'([^']+)' does not depend on any axioms", log):
    name = match.group(1)
    assert name not in reports, f"Duplicate zero-axiom audit: {name}"
    reports[name] = []
missing = sorted(set(expected) - reports.keys())
unexpected = sorted(reports.keys() - set(expected))
nonstandard = {n: a for n, a in reports.items() if not set(a).issubset(allowed)}
errors = [line for line in log.splitlines() if "error:" in line]
summary = {
    "expected_public_theorems": sum(map(len, theorems.values())),
    "expected_additional_constructions": sum(map(len, constructions.values())),
    "checked_total": len(reports),
    "zero_axiom_count": sum(not a for a in reports.values()),
    "zero_axiom_declarations": [n for n, a in reports.items() if not a],
    "allowed_axioms": sorted(allowed), "missing": missing,
    "unexpected": unexpected, "nonstandard": nonstandard, "errors": errors,
    "all_passed": not (missing or unexpected or nonstandard or errors),
}
(RECORD / "axiom-dependencies.json").write_text(
    json.dumps(reports, indent=2) + "\n", encoding="utf-8")
(RECORD / "axiom-summary.json").write_text(
    json.dumps(summary, indent=2) + "\n", encoding="utf-8")
print(json.dumps(summary))
assert summary["all_passed"], "Incomplete or nonstandard axiom audit"
