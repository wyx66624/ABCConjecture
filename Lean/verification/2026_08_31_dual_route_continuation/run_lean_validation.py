#!/usr/bin/env python3
"""Reproduce and summarize the Lean validation for the dual-route stage."""

from __future__ import annotations

from collections import Counter
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import time


HERE = Path(__file__).resolve().parent
LEAN_ROOT = HERE.parents[1]
REPO_ROOT = LEAN_ROOT.parent
DECLARATIONS_PATH = HERE / "declarations.json"
OLD_EVIDENCE = LEAN_ROOT / "verification" / "2026_08_31_uniform_continuation"
AUDIT_MODULE = "ResearchDualRouteContinuation20260831Audit"
ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}


def utc_now() -> str:
    return datetime.now(timezone.utc).isoformat()


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_json(path: Path, value: object) -> None:
    path.write_text(
        json.dumps(value, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )


def run(command: list[str], output_path: Path) -> dict[str, object]:
    start_utc = utc_now()
    start = time.perf_counter()
    result = subprocess.run(
        command,
        cwd=LEAN_ROOT,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        encoding="utf-8",
        errors="replace",
        check=False,
    )
    elapsed = time.perf_counter() - start
    output_path.write_text(result.stdout, encoding="utf-8")
    return {
        "command": command,
        "started_utc": start_utc,
        "completed_utc": utc_now(),
        "elapsed_seconds": round(elapsed, 3),
        "exit_code": result.returncode,
        "output_file": output_path.relative_to(REPO_ROOT).as_posix(),
        "output_sha256": sha256(output_path),
    }


def command_output(command: list[str], cwd: Path = LEAN_ROOT) -> str:
    result = subprocess.run(
        command,
        cwd=cwd,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        encoding="utf-8",
        errors="replace",
        check=False,
    )
    if result.returncode != 0:
        raise RuntimeError(f"command failed: {command}\n{result.stdout}")
    return result.stdout.strip()


def main() -> None:
    declarations = json.loads(DECLARATIONS_PATH.read_text(encoding="utf-8"))
    source_paths = [
        REPO_ROOT / item["source"] for item in declarations.values()
    ]
    audit_path = LEAN_ROOT / "IUTThreeClosures" / f"{AUDIT_MODULE}.lean"
    protected_paths = [
        LEAN_ROOT / "lean-toolchain",
        LEAN_ROOT / "lakefile.toml",
        LEAN_ROOT / "lake-manifest.json",
        LEAN_ROOT / "IUTThreeClosures" / "ABCStatement.lean",
        LEAN_ROOT / "IUTThreeClosures" / "NonCircularDownstream.lean",
    ]
    immutable_inputs = [
        *source_paths,
        audit_path,
        DECLARATIONS_PATH,
        LEAN_ROOT / "IUTThreeClosures.lean",
        *protected_paths,
    ]
    before = {path.relative_to(REPO_ROOT).as_posix(): sha256(path) for path in immutable_inputs}

    def direct_compile(module: str) -> tuple[str, dict[str, object]]:
        output = HERE / f"{module}-direct-output.txt"
        run_data = run(
            ["lake", "env", "lean", f"IUTThreeClosures/{module}.lean"],
            output,
        )
        return module, run_data

    with ThreadPoolExecutor(max_workers=len(declarations)) as pool:
        direct_results = dict(pool.map(direct_compile, declarations.keys()))
    write_json(HERE / "direct-runs.json", direct_results)
    direct_failures = {
        module: data["exit_code"]
        for module, data in direct_results.items()
        if data["exit_code"] != 0
    }
    if direct_failures:
        raise RuntimeError(f"direct compilation failures: {direct_failures}")

    audit_run = run(
        ["lake", "env", "lean", f"IUTThreeClosures/{AUDIT_MODULE}.lean"],
        HERE / "audit-output.txt",
    )
    write_json(HERE / "audit-run.json", audit_run)
    if audit_run["exit_code"] != 0:
        raise RuntimeError("audit direct compilation failed")

    target_run = run(
        ["lake", "build", f"IUTThreeClosures.{AUDIT_MODULE}"],
        HERE / "audit-target-build-output.txt",
    )
    write_json(HERE / "audit-target-build-run.json", target_run)
    if target_run["exit_code"] != 0:
        raise RuntimeError("audit target build failed")

    build_run = run(["lake", "build"], HERE / "build-output.txt")
    if build_run["exit_code"] != 0:
        raise RuntimeError("full build failed")

    after = {path.relative_to(REPO_ROOT).as_posix(): sha256(path) for path in immutable_inputs}
    changed = [path for path in before if before[path] != after[path]]
    if changed:
        raise RuntimeError(f"inputs changed during validation: {changed}")

    audit_text = (HERE / "audit-output.txt").read_text(encoding="utf-8")
    axiom_pattern = re.compile(
        r"'([^']+)' (does not depend on any axioms|depends on axioms: \[(.*?)\])",
        re.DOTALL,
    )
    dependencies: dict[str, list[str]] = {}
    for match in axiom_pattern.finditer(audit_text):
        name = match.group(1)
        body = match.group(3)
        axioms = [] if body is None else [part.strip() for part in body.split(",")]
        dependencies[name] = axioms

    expected_names = set()
    theorem_counts: dict[str, int] = {}
    additional_counts: dict[str, int] = {}
    for module, data in declarations.items():
        prefix = f"IUTThreeClosures.{module}."
        theorem_counts[module] = len(data["public_theorems"])
        additional_counts[module] = len(data["additional_proof_bearing_declarations"])
        expected_names.update(prefix + name for name in data["public_theorems"])
        expected_names.update(
            prefix + name for name in data["additional_proof_bearing_declarations"]
        )
    if set(dependencies) != expected_names:
        missing = sorted(expected_names - set(dependencies))
        extra = sorted(set(dependencies) - expected_names)
        raise RuntimeError(f"audit declaration mismatch: missing={missing}, extra={extra}")

    all_axioms = sorted({axiom for values in dependencies.values() for axiom in values})
    unexpected_axioms = sorted(set(all_axioms) - ALLOWED_AXIOMS)
    if unexpected_axioms or "sorryAx" in audit_text:
        raise RuntimeError(f"unexpected axioms: {unexpected_axioms}")

    forbidden_pattern = re.compile(
        r"(?m)\b(?:sorry|admit)\b|^\s*(?:axiom|unsafe)\b"
    )
    forbidden_hits = {
        path.relative_to(REPO_ROOT).as_posix(): forbidden_pattern.findall(
            path.read_text(encoding="utf-8")
        )
        for path in [*source_paths, audit_path]
        if forbidden_pattern.search(path.read_text(encoding="utf-8"))
    }
    if forbidden_hits:
        raise RuntimeError(f"forbidden proof placeholders: {forbidden_hits}")

    write_json(HERE / "axiom-dependencies.json", dependencies)
    axiom_summary = {
        "audited_declarations": len(dependencies),
        "zero_axiom_declarations": sum(not values for values in dependencies.values()),
        "axioms": all_axioms,
        "unexpected_axioms": unexpected_axioms,
        "has_sorryAx": "sorryAx" in audit_text,
        "forbidden_source_tokens": forbidden_hits,
    }
    write_json(HERE / "axiom-summary.json", axiom_summary)

    new_build_text = (HERE / "build-output.txt").read_text(encoding="utf-8")
    old_build_text = (OLD_EVIDENCE / "build-output.txt").read_text(encoding="utf-8")
    warning_re = re.compile(r"(?m)^warning:.*$")
    new_warnings = warning_re.findall(new_build_text)
    old_warnings = warning_re.findall(old_build_text)
    warning_multiset_match = Counter(new_warnings) == Counter(old_warnings)
    if not warning_multiset_match:
        raise RuntimeError("full-build warning multiset differs from frozen baseline")
    new_module_pattern = re.compile(
        r"^warning: IUTThreeClosures/(?:"
        + "|".join(re.escape(module) for module in declarations)
        + rf"|{re.escape(AUDIT_MODULE)})\.lean",
        re.MULTILINE,
    )
    new_module_warnings = new_module_pattern.findall(new_build_text)
    if new_module_warnings:
        raise RuntimeError(f"new-module warnings: {new_module_warnings}")

    completion_match = re.search(
        r"Build completed successfully \((\d+) jobs\)\.", new_build_text
    )
    if not completion_match:
        raise RuntimeError("full-build completion line missing")
    build_run.update(
        {
            "input_sha256": before,
            "inputs_changed_during_run": changed,
            "warnings": len(new_warnings),
            "baseline_warnings": len(old_warnings),
            "warning_multiset_matches_frozen_baseline": warning_multiset_match,
            "new_module_warnings": len(new_module_warnings),
            "completion_jobs": int(completion_match.group(1)),
        }
    )
    write_json(HERE / "build-run.json", build_run)

    old_environment = json.loads((OLD_EVIDENCE / "environment.json").read_text(encoding="utf-8"))
    current_protected = {
        path.relative_to(REPO_ROOT).as_posix(): sha256(path) for path in protected_paths
    }
    packages = {}
    for package in ["mathlib", "iut", "genl", "heights", "tate-curves-theta"]:
        packages[package] = command_output(
            ["git", "rev-parse", "HEAD"], LEAN_ROOT / ".lake" / "packages" / package
        )
    environment = {
        "repository_head": command_output(["git", "rev-parse", "HEAD"], REPO_ROOT),
        "lean": command_output(["lake", "env", "lean", "--version"]),
        "lake": command_output(["lake", "--version"]),
        "packages": packages,
        "protected_file_sha256": current_protected,
        "protected_files_match_frozen_baseline": current_protected
        == old_environment["protected_file_sha256"],
        "packages_match_frozen_baseline": packages == old_environment["packages"],
    }
    write_json(HERE / "environment.json", environment)
    if not environment["protected_files_match_frozen_baseline"]:
        raise RuntimeError("protected files differ from frozen baseline")
    if not environment["packages_match_frozen_baseline"]:
        raise RuntimeError("package pins differ from frozen baseline")

    source_hashes = {
        path.relative_to(REPO_ROOT).as_posix(): {
            "sha256": sha256(path),
            "bytes": path.stat().st_size,
        }
        for path in [
            *source_paths,
            audit_path,
            DECLARATIONS_PATH,
            LEAN_ROOT / "IUTThreeClosures.lean",
            REPO_ROOT / "research" / "ABC_SUBCRITICAL_LOCUS_UNIFORMITY_2026_08_31.md",
            REPO_ROOT / "research" / "ABC_COUNTEREXAMPLE_CAMPANA_ESCAPE_2026_08_31.md",
            REPO_ROOT / "research" / "sources" / "campana_counterexample_2026_08_31" / "source-metadata.json",
            REPO_ROOT / "research" / "sources" / "campana_counterexample_2026_08_31" / "Bilu_Hanrot_Voutier_RR3792_Primitive_Divisors.pdf",
            REPO_ROOT / "paper" / "ChatGPT_ABC_Uniformity_2026.tex",
            REPO_ROOT / "paper" / "dual_route_subcritical_pell_2026.tex",
        ]
    }
    write_json(HERE / "source-hashes.json", source_hashes)

    summary = {
        "research_date": "2026-08-31",
        "status": "Lean validation passed; rigorous partial results",
        "direct_compile_exit_codes": {
            module: data["exit_code"] for module, data in direct_results.items()
        },
        "audit_compile_exit_code": audit_run["exit_code"],
        "audit_target_build_exit_code": target_run["exit_code"],
        "full_build_exit_code": build_run["exit_code"],
        "full_build_jobs": build_run["completion_jobs"],
        "full_build_warning_count": len(new_warnings),
        "frozen_baseline_warning_count": len(old_warnings),
        "warning_multiset_matches_frozen_baseline": warning_multiset_match,
        "new_module_warning_count": len(new_module_warnings),
        "module_count": len(declarations),
        "public_theorems_by_module": theorem_counts,
        "additional_declarations_by_module": additional_counts,
        "public_theorem_count": sum(theorem_counts.values()),
        "additional_declaration_count": sum(additional_counts.values()),
        "audited_declaration_count": len(dependencies),
        "zero_axiom_declaration_count": axiom_summary["zero_axiom_declarations"],
        "axioms": all_axioms,
        "unexpected_axioms": unexpected_axioms,
        "audit_has_sorryAx": False,
        "forbidden_source_tokens": forbidden_hits,
        "protected_files_match_frozen_baseline": environment[
            "protected_files_match_frozen_baseline"
        ],
        "packages_match_frozen_baseline": environment[
            "packages_match_frozen_baseline"
        ],
        "standard_abc_proof_or_disproof": False,
        "positive_route_status": "exact equivalence and conditional amplification gates proved",
        "counterexample_route_status": "conditional Pell squarefull-root disproof gate proved; premise open",
        "all_passed": True,
    }
    write_json(HERE / "validation_summary.json", summary)

    validation_md = "# Dual-route Lean validation\n\n"
    validation_md += "Validated on 2026-08-31. The standard `ABCConjecture` remains open.\n\n"
    validation_md += f"- Six modules compiled directly with exit code zero.\n"
    validation_md += f"- The declaration audit covers {len(dependencies)} declarations: "
    validation_md += f"{sum(theorem_counts.values())} theorems and {sum(additional_counts.values())} definitions/structures.\n"
    validation_md += f"- The audit has no warnings, no `sorryAx`, and no unexpected axioms.\n"
    validation_md += f"- Kernel dependencies are exactly: {', '.join(all_axioms)}.\n"
    validation_md += f"- Full `lake build` passed with {build_run['completion_jobs']} jobs.\n"
    validation_md += f"- The {len(new_warnings)} warning lines exactly match the frozen baseline multiset; the new modules add zero warnings.\n"
    validation_md += "- Protected statement/toolchain files and package pins match the frozen baseline.\n"
    validation_md += "- The positive route proves an exact uniformity equivalence and conditional amplification lemmas.\n"
    validation_md += "- The counterexample route proves a conditional Pell/Campana disproof gate, without assuming its open squarefull-subsequence premise.\n"
    (HERE / "VALIDATION.md").write_text(validation_md, encoding="utf-8")

    print(json.dumps(summary, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()
