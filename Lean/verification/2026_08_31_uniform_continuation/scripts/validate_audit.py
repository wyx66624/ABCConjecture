"""Check every scoped kernel dependency report and source hash (writes JSON)."""
from pathlib import Path
import hashlib
import json
import re

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
ALLOWED = {"propext", "Classical.choice", "Quot.sound"}
modules = json.loads((RECORD / "declarations.json").read_text(encoding="utf-8"))
run = json.loads((RECORD / "audit-run.json").read_text(encoding="utf-8"))
log = (RECORD / "audit-output.txt").read_text(encoding="utf-8")
expected = []
changed_sources = []
for module, data in modules.items():
    expected.extend(f"IUTThreeClosures.{module}.{name}" for name in
                    data["public_theorems"] + data["additional_proof_bearing_declarations"])
    if hashlib.sha256((ROOT / data["source"]).read_bytes()).hexdigest() != data["source_sha256"]:
        changed_sources.append(data["source"])

reports = {}
for match in re.finditer(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", log, re.S):
    name, contents = match.groups()
    assert name not in reports, f"Duplicate report: {name}"
    reports[name] = [x.strip() for x in contents.split(",") if x.strip()]
for match in re.finditer(r"'([^']+)' does not depend on any axioms", log):
    name = match.group(1)
    assert name not in reports, f"Duplicate zero-axiom report: {name}"
    reports[name] = []

missing = sorted(set(expected) - reports.keys())
unexpected = sorted(reports.keys() - set(expected))
nonstandard = {name: deps for name, deps in reports.items() if not set(deps) <= ALLOWED}
diagnostics = [line for line in log.splitlines() if re.match(r"^(?:error|warning):", line)]
required_inputs = {"Lean/IUTThreeClosures.lean",
                   "Lean/IUTThreeClosures/ResearchUniformContinuation20260831Audit.lean",
                   "Lean/verification/2026_08_31_uniform_continuation/declarations.json"}
required_inputs.update(data["source"] for data in modules.values())
captured_inputs = run.get("input_sha256", {})
run_input_failures = sorted(required_inputs - captured_inputs.keys())
run_input_failures.extend(name for name, sha in captured_inputs.items()
                          if hashlib.sha256((ROOT / name).read_bytes()).hexdigest() != sha)
run_input_failures.extend(run.get("inputs_changed_during_run", []))
summary = {
    "module_count": len(modules),
    "public_theorem_count": sum(len(x["public_theorems"]) for x in modules.values()),
    "additional_proof_bearing_declaration_count": sum(
        len(x["additional_proof_bearing_declarations"]) for x in modules.values()),
    "audited_declaration_count": len(reports),
    "zero_axiom_count": sum(not deps for deps in reports.values()),
    "zero_axiom_declarations": [name for name, deps in reports.items() if not deps],
    "allowed_axioms": sorted(ALLOWED),
    "missing": missing, "unexpected": unexpected, "nonstandard": nonstandard,
    "changed_sources": changed_sources, "diagnostics": diagnostics,
    "run_input_failures": run_input_failures,
    "audit_output_sha256": hashlib.sha256((RECORD / "audit-output.txt").read_bytes()).hexdigest(),
    "audit_exit_code": run["exit_code"], "audit_has_sorryAx": "sorryAx" in log,
}
summary["all_passed"] = not (
    missing or unexpected or nonstandard or changed_sources or diagnostics or run_input_failures
    or run["exit_code"] or summary["audit_has_sorryAx"]
)
(RECORD / "axiom-dependencies.json").write_text(
    json.dumps(reports, indent=2) + "\n", encoding="utf-8")
(RECORD / "axiom-summary.json").write_text(
    json.dumps(summary, indent=2) + "\n", encoding="utf-8")
print(json.dumps(summary))
assert summary["all_passed"], "Scoped source/dependency audit did not pass"
