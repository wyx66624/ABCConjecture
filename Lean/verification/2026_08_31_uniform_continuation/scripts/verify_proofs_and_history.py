"""Independently parse the completed proof checks and replay frozen history.

This writes only this continuation's verification JSON. It does not run or
modify an older stage's finalizer, audit, manifest, or source snapshot.
"""
from collections import Counter
from pathlib import Path
import hashlib
import json
import re

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
ALLOWED = {"propext", "Classical.choice", "Quot.sound"}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def dependencies(text):
    result = {}
    for name, body in re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", text, re.S):
        assert name not in result, f"Repeated dependency report: {name}"
        result[name] = sorted({a.strip() for a in body.split(",") if a.strip()})
    for name in re.findall(r"'([^']+)' does not depend on any axioms", text):
        assert name not in result, f"Repeated zero-axiom report: {name}"
        result[name] = []
    return result


def check_audit(mode, audit_name, count):
    log_path = RECORD / f"{mode}-output.txt"
    log = log_path.read_text(encoding="utf-8")
    run = read(RECORD / f"{mode}-run.json")
    source = ROOT / "Lean/IUTThreeClosures" / audit_name
    source_text = source.read_text(encoding="utf-8")
    spellings = re.findall(r"^#print axioms\s+(\S+)", source_text, re.M)
    prefixes = re.findall(r"^open\s+(\S+)", source_text, re.M)
    reports = dependencies(log)
    failures = []
    expected = []
    for spelling in spellings:
        candidates = {spelling} | {prefix + "." + spelling for prefix in prefixes}
        resolved = candidates & reports.keys()
        if len(resolved) != 1:
            failures.append(f"Cannot uniquely resolve printed name from opened namespaces: {spelling}")
        else:
            expected.append(next(iter(resolved)))
    if run["exit_code"] or run["warnings"]:
        failures.append("Command failed or reported warnings")
    if mode == "audit":
        if not run.get("input_sha256"):
            failures.append("Current audit lacks captured input hashes")
        for name, expected_sha in run.get("input_sha256", {}).items():
            if digest(ROOT / name) != expected_sha:
                failures.append(f"Current audit input changed: {name}")
        failures.extend(run.get("inputs_changed_during_run", []))
    if len(expected) != count or len(set(expected)) != count:
        failures.append("Unexpected audit declaration scope")
    if set(expected) != set(reports) or len(reports) != count:
        failures.append("Actual dependency names differ from audit source")
    if any(not set(items) <= ALLOWED for items in reports.values()):
        failures.append("Nonstandard axiom dependency")
    if re.search(r"sorryAx|(?:^|\n).*\b(?:error|warning):", log):
        failures.append("Audit contains a diagnostic or sorryAx")
    return {"mode": mode, "source": source.relative_to(ROOT).as_posix(),
            "source_sha256": digest(source), "output_sha256": digest(log_path),
            "expected_count": count, "actual_count": len(reports),
            "zero_axiom_count": sum(not items for items in reports.values()),
            "axioms": sorted({a for items in reports.values() for a in items}),
            "failures": failures, "dependencies": reports}


def check_history(name, count, sha, mapping_path, mapping_count):
    manifest = ROOT / "Lean/verification" / name / "SHA256SUMS"
    mapping = read(mapping_path)
    values = [line.split("  ", 1) for line in manifest.read_text(encoding="utf-8-sig").splitlines() if line]
    failures = []
    if digest(manifest) != sha:
        failures.append("Frozen manifest changed")
    if len(values) != count or len(mapping) != mapping_count:
        failures.append("Frozen entry or remapping count changed")
    seen = set()
    for expected, name in values:
        target = (ROOT / mapping.get(name, name)).resolve()
        if name in seen:
            failures.append(f"Repeated path: {name}")
        seen.add(name)
        if not target.is_relative_to(ROOT.resolve()):
            failures.append(f"Path outside repository: {name}")
        elif not target.is_file():
            failures.append(f"Missing historical file: {name}")
        elif digest(target) != expected:
            failures.append(f"Historical mismatch: {name}")
    return {"manifest": manifest.relative_to(ROOT).as_posix(), "manifest_sha256": digest(manifest),
            "checked_files": len(values), "remapped_paths": len(mapping),
            "mapping": mapping_path.relative_to(ROOT).as_posix(), "failures": failures}


def main():
    declarations = read(RECORD / "declarations.json")
    current_count = sum(len(d["public_theorems"]) + len(d["additional_proof_bearing_declarations"])
                        for d in declarations.values())
    audits = [
        check_audit("audit", "ResearchUniformContinuation20260831Audit.lean", current_count),
        check_audit("previous-galois", "ResearchGaloisLifts20260830Audit.lean", 145),
        check_audit("previous-uniform", "ResearchUniformGate20260830Audit.lean", 89),
        check_audit("previous-continuation", "ResearchContinuation20260830Audit.lean", 43),
    ]
    history = [
        check_history("2026_08_30_galois_lifts", 705,
                      "a05309cddfaa382f90398e4ec17fdddcf4572c93116e420a4658e625987606ce",
                      RECORD / "previous-manifest-map.json", 6),
        check_history("2026_08_30_uniform_gate", 506,
                      "c470be98f60af38a31b8a00393d09f276e10d223c197034cfd1a1ee5628afe7a",
                      ROOT / "Lean/verification/2026_08_30_galois_lifts/previous-manifest-map.json", 6),
        check_history("2026_08_30_continuation", 447,
                      "dbc5fdc869019dd21fd091e40c32a3d3cf607dcb8feda2819facd529d7e3684a",
                      ROOT / "Lean/verification/2026_08_30_uniform_gate/previous-manifest-map.json", 10),
    ]
    build = read(RECORD / "build-run.json")
    build_log = (RECORD / "build-output.txt").read_text(encoding="utf-8")
    old_build_log = (ROOT / "Lean/verification/2026_08_30_galois_lifts/build-output.txt").read_text(encoding="utf-8")
    warning_pattern = r"^warning:.*$"
    warnings = Counter(re.findall(warning_pattern, build_log, re.M))
    old_warnings = Counter(re.findall(warning_pattern, old_build_log, re.M))
    changed_build_inputs = [name for name, expected in build.get("input_sha256", {}).items()
                            if digest(ROOT / name) != expected]
    changed_build_inputs.extend(build.get("inputs_changed_during_run", []))
    build_checks = {"exit_code": build["exit_code"], "warnings": sum(warnings.values()),
                    "completion": build["completion"],
                    "warning_multiset_matches_previous": warnings == old_warnings,
                    "new_warning_headers": list((warnings - old_warnings).elements()),
                    "missing_previous_warning_headers": list((old_warnings - warnings).elements()),
                    "input_hashes_captured": bool(build.get("input_sha256")),
                    "changed_inputs": changed_build_inputs,
                    "output_sha256": digest(RECORD / "build-output.txt")}
    build_checks["all_passed"] = (
        build["exit_code"] == 0 and sum(warnings.values()) == 265
        and warnings == old_warnings
        and build["completion"] == ["Build completed successfully (9135 jobs)."]
        and build.get("input_sha256") and not changed_build_inputs
    )
    report = {"audits": audits, "history": history, "build": build_checks}
    report["all_passed"] = (
        all(not a["failures"] for a in audits + history) and build_checks["all_passed"])
    (RECORD / "proof-and-history-verification.json").write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"audits": [{k: v for k, v in a.items() if k != "dependencies"} for a in audits],
                      "history": history, "build": build_checks,
                      "all_passed": report["all_passed"]}, ensure_ascii=False))
    assert report["all_passed"], "Proof or historical integrity check failed"


if __name__ == "__main__":
    main()
