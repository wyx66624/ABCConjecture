#!/usr/bin/env python3
"""Freeze Lean evidence for the 2026-08-31 balanced-persistence stage."""

from __future__ import annotations

from collections import Counter
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import re
import subprocess
import time


HERE = Path(__file__).resolve().parent
LEAN_ROOT = HERE.parents[1]
REPO_ROOT = LEAN_ROOT.parent
BASELINE = LEAN_ROOT / "verification" / "2026_08_31_dual_route_continuation"
AUDIT_MODULE = "ResearchBalancedPersistence20260831Audit"
MODULES = {
    "PellAdjacentFactorCounterexample20260831": (13, 2),
    "PellSquareRootDescent20260831": (14, 1),
    "HallSquarefullCounterexample20260831": (7, 2),
    "AffineShearAmplification20260831": (28, 10),
}
ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}

DECL_RE = re.compile(
    r"^\s*(?:@\[[^\]]+\]\s*)?(?:noncomputable\s+)?"
    r"(def|theorem|structure)\s+([A-Za-z0-9_']+)"
)
NAMESPACE_RE = re.compile(r"^\s*namespace\s+([A-Za-z0-9_.]+)\s*$")
END_RE = re.compile(r"^\s*end\s+([A-Za-z0-9_.]+)\s*$")
WARNING_RE = re.compile(r"(?m)^warning:.*$")


def utc_now() -> str:
    return datetime.now(timezone.utc).isoformat()


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_json(path: Path, value: object) -> None:
    path.write_text(
        json.dumps(value, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
    )


def run(command: list[str], output_path: Path) -> dict[str, object]:
    started_utc = utc_now()
    started = time.perf_counter()
    result = subprocess.run(
        command,
        cwd=LEAN_ROOT,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        encoding="utf-8",
        errors="replace",
        check=False,
    )
    elapsed = time.perf_counter() - started
    output_path.write_text(result.stdout, encoding="utf-8")
    return {
        "command": command,
        "started_utc": started_utc,
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


def declarations(path: Path) -> list[dict[str, str]]:
    stack: list[str] = []
    found: list[dict[str, str]] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        namespace_match = NAMESPACE_RE.match(line)
        if namespace_match:
            stack.append(namespace_match.group(1))
            continue
        end_match = END_RE.match(line)
        if end_match and stack:
            label = end_match.group(1)
            if label == stack[-1] or label == ".".join(stack):
                stack.pop()
            continue
        declaration_match = DECL_RE.match(line)
        if not declaration_match:
            continue
        kind, name = declaration_match.groups()
        namespace = ".".join(stack)
        full_name = f"{namespace}.{name}" if namespace else name
        prefix = f"IUTThreeClosures.{path.stem}."
        if not full_name.startswith(prefix):
            raise RuntimeError(f"unexpected namespace in {path.name}: {full_name}")
        found.append(
            {
                "kind": kind,
                "name": full_name[len(prefix) :],
                "full_name": full_name,
            }
        )
    return found


def strip_lean_comments(text: str) -> str:
    """Remove nested block comments and line comments, preserving line breaks."""
    out: list[str] = []
    index = 0
    depth = 0
    while index < len(text):
        if depth == 0 and text.startswith("/-", index):
            depth = 1
            out.extend("  ")
            index += 2
        elif depth > 0 and text.startswith("/-", index):
            depth += 1
            out.extend("  ")
            index += 2
        elif depth > 0 and text.startswith("-/", index):
            depth -= 1
            out.extend("  ")
            index += 2
        elif depth == 0 and text.startswith("--", index):
            while index < len(text) and text[index] != "\n":
                out.append(" ")
                index += 1
        elif depth > 0:
            out.append("\n" if text[index] == "\n" else " ")
            index += 1
        else:
            out.append(text[index])
            index += 1
    if depth != 0:
        raise RuntimeError("unterminated Lean block comment")
    return "".join(out)


def scan_source(path: Path) -> dict[str, object]:
    raw = path.read_text(encoding="utf-8")
    code = strip_lean_comments(raw)
    primary_patterns = {
        "sorry": re.compile(r"\bsorry\b"),
        "admit": re.compile(r"\badmit\b"),
        "axiom_declaration": re.compile(r"(?m)^\s*axiom\b"),
        "unsafe_declaration": re.compile(r"(?m)^\s*unsafe\b"),
    }
    extended_patterns = {
        "sorryAx": re.compile(r"\bsorryAx\b"),
        "opaque_declaration": re.compile(r"(?m)^\s*opaque\b"),
        "partial_declaration": re.compile(r"(?m)^\s*partial\b"),
        "extern_declaration": re.compile(r"(?m)^\s*extern\b"),
        "implemented_by": re.compile(r"\bimplemented_by\b"),
    }
    return {
        "path": path.relative_to(REPO_ROOT).as_posix(),
        "sha256": sha256(path),
        "bytes": path.stat().st_size,
        "primary_code_hits": {
            name: len(pattern.findall(code)) for name, pattern in primary_patterns.items()
        },
        "extended_code_hits": {
            name: len(pattern.findall(code)) for name, pattern in extended_patterns.items()
        },
        "raw_comment_or_code_word_counts": {
            word: len(re.findall(rf"\b{word}\b", raw))
            for word in ["sorry", "admit", "axiom", "unsafe", "sorryAx"]
        },
    }


def multiset_fingerprint(items: list[str]) -> str:
    material = "\n".join(sorted(items)) + ("\n" if items else "")
    return hashlib.sha256(material.encode("utf-8")).hexdigest()


def warning_comparison(output_path: Path) -> dict[str, object]:
    baseline_path = BASELINE / "build-output.txt"
    current = WARNING_RE.findall(output_path.read_text(encoding="utf-8"))
    baseline = WARNING_RE.findall(baseline_path.read_text(encoding="utf-8"))
    current_counter = Counter(current)
    baseline_counter = Counter(baseline)
    added = list((current_counter - baseline_counter).elements())
    removed = list((baseline_counter - current_counter).elements())
    new_names = [*MODULES, AUDIT_MODULE]
    new_module_warnings = [
        warning
        for warning in current
        if any(f"IUTThreeClosures/{name}.lean" in warning for name in new_names)
    ]
    return {
        "output_file": output_path.relative_to(REPO_ROOT).as_posix(),
        "baseline_file": baseline_path.relative_to(REPO_ROOT).as_posix(),
        "baseline_file_sha256": sha256(baseline_path),
        "current_warning_count": len(current),
        "baseline_warning_count": len(baseline),
        "current_distinct_warning_count": len(current_counter),
        "baseline_distinct_warning_count": len(baseline_counter),
        "current_multiset_sha256": multiset_fingerprint(current),
        "baseline_multiset_sha256": multiset_fingerprint(baseline),
        "multiset_matches_baseline": current_counter == baseline_counter,
        "added_warning_headers": added,
        "removed_warning_headers": removed,
        "new_module_warning_headers": new_module_warnings,
    }


def parse_jobs(output_path: Path) -> int:
    text = output_path.read_text(encoding="utf-8")
    match = re.search(r"Build completed successfully \((\d+) jobs\)\.", text)
    if not match:
        raise RuntimeError(f"completion job count missing from {output_path.name}")
    return int(match.group(1))


def main() -> None:
    HERE.mkdir(parents=True, exist_ok=True)
    source_paths = {
        module: LEAN_ROOT / "IUTThreeClosures" / f"{module}.lean"
        for module in MODULES
    }
    audit_path = LEAN_ROOT / "IUTThreeClosures" / f"{AUDIT_MODULE}.lean"
    aggregate_path = LEAN_ROOT / "IUTThreeClosures.lean"
    protected_paths = [
        LEAN_ROOT / "lean-toolchain",
        LEAN_ROOT / "lakefile.toml",
        LEAN_ROOT / "lake-manifest.json",
        LEAN_ROOT / "IUTThreeClosures" / "ABCStatement.lean",
        LEAN_ROOT / "IUTThreeClosures" / "NonCircularDownstream.lean",
    ]
    immutable_paths = [*source_paths.values(), audit_path, aggregate_path, *protected_paths]
    before = {
        path.relative_to(REPO_ROOT).as_posix(): sha256(path) for path in immutable_paths
    }

    declaration_manifest: dict[str, object] = {}
    expected_names: set[str] = set()
    theorem_total = 0
    additional_total = 0
    for module, (expected_theorems, expected_additional) in MODULES.items():
        source = source_paths[module]
        found = declarations(source)
        theorems = [item for item in found if item["kind"] == "theorem"]
        additional = [item for item in found if item["kind"] != "theorem"]
        if (len(theorems), len(additional)) != (
            expected_theorems,
            expected_additional,
        ):
            raise RuntimeError(
                f"{module}: expected {expected_theorems}/{expected_additional}, "
                f"found {len(theorems)}/{len(additional)}"
            )
        theorem_total += len(theorems)
        additional_total += len(additional)
        expected_names.update(item["full_name"] for item in found)
        declaration_manifest[module] = {
            "source": source.relative_to(REPO_ROOT).as_posix(),
            "source_sha256": sha256(source),
            "source_bytes": source.stat().st_size,
            "public_theorems": [item["name"] for item in theorems],
            "additional_declarations": [
                {"kind": item["kind"], "name": item["name"]} for item in additional
            ],
            "audited_declaration_count": len(found),
        }
    if (theorem_total, additional_total, len(expected_names)) != (62, 15, 77):
        raise RuntimeError("unexpected declaration totals")
    write_json(HERE / "declarations.json", declaration_manifest)

    audit_text_source = audit_path.read_text(encoding="utf-8")
    audit_checked = set(
        re.findall(r"(?m)^#check\s+([A-Za-z0-9_'.]+)\s*$", audit_text_source)
    )
    audit_axiom_printed = set(
        re.findall(r"(?m)^#print axioms\s+([A-Za-z0-9_'.]+)\s*$", audit_text_source)
    )
    if audit_checked != expected_names or audit_axiom_printed != expected_names:
        raise RuntimeError(
            "audit source does not exactly cover declarations: "
            f"check_missing={sorted(expected_names-audit_checked)}, "
            f"check_extra={sorted(audit_checked-expected_names)}, "
            f"axiom_missing={sorted(expected_names-audit_axiom_printed)}, "
            f"axiom_extra={sorted(audit_axiom_printed-expected_names)}"
        )

    scans = {
        path.stem: scan_source(path) for path in [*source_paths.values(), audit_path]
    }
    write_json(HERE / "source-scan.json", scans)
    primary_hits = {
        module: hits
        for module, scan in scans.items()
        if any((hits := scan["primary_code_hits"]).values())
    }
    extended_hits = {
        module: hits
        for module, scan in scans.items()
        if any((hits := scan["extended_code_hits"]).values())
    }
    if primary_hits or extended_hits:
        raise RuntimeError(
            f"forbidden or escape source tokens: primary={primary_hits}, "
            f"extended={extended_hits}"
        )

    direct_runs: dict[str, object] = {}
    for module in [*MODULES, AUDIT_MODULE]:
        output = HERE / f"{module}-direct-output.txt"
        direct_runs[module] = run(
            ["lake", "env", "lean", f"IUTThreeClosures/{module}.lean"], output
        )
        if direct_runs[module]["exit_code"] != 0:
            write_json(HERE / "direct-runs.json", direct_runs)
            raise RuntimeError(f"direct compile failed: {module}")
    write_json(HERE / "direct-runs.json", direct_runs)

    audit_output_path = HERE / f"{AUDIT_MODULE}-direct-output.txt"
    audit_output = audit_output_path.read_text(encoding="utf-8")
    axiom_pattern = re.compile(
        r"'([^']+)' (does not depend on any axioms|depends on axioms: \[(.*?)\])",
        re.DOTALL,
    )
    dependencies: dict[str, list[str]] = {}
    for match in axiom_pattern.finditer(audit_output):
        name = match.group(1)
        body = match.group(3)
        dependencies[name] = (
            [] if body is None else [item.strip() for item in body.split(",")]
        )
    if set(dependencies) != expected_names:
        raise RuntimeError(
            f"kernel audit mismatch: missing={sorted(expected_names-set(dependencies))}, "
            f"extra={sorted(set(dependencies)-expected_names)}"
        )
    all_axioms = sorted({item for values in dependencies.values() for item in values})
    unexpected_axioms = sorted(set(all_axioms) - ALLOWED_AXIOMS)
    has_sorry_ax = "sorryAx" in audit_output
    if unexpected_axioms or has_sorry_ax:
        raise RuntimeError(
            f"unexpected kernel dependencies: {unexpected_axioms}; sorryAx={has_sorry_ax}"
        )
    write_json(HERE / "axiom-dependencies.json", dependencies)
    axiom_summary = {
        "audited_declarations": len(dependencies),
        "zero_axiom_declarations": sum(not values for values in dependencies.values()),
        "axioms": all_axioms,
        "allowed_axioms": sorted(ALLOWED_AXIOMS),
        "unexpected_axioms": unexpected_axioms,
        "has_sorryAx": has_sorry_ax,
        "audit_source_exactly_covers_declarations": True,
        "forbidden_primary_source_tokens": primary_hits,
        "extended_escape_source_tokens": extended_hits,
    }
    write_json(HERE / "axiom-summary.json", axiom_summary)

    audit_target_output = HERE / "audit-target-build-output.txt"
    audit_target_run = run(
        ["lake", "build", f"IUTThreeClosures.{AUDIT_MODULE}"], audit_target_output
    )
    if audit_target_run["exit_code"] != 0:
        write_json(HERE / "audit-target-build-run.json", audit_target_run)
        raise RuntimeError("audit target build failed")
    audit_target_run["completion_jobs"] = parse_jobs(audit_target_output)
    audit_target_warning_headers = WARNING_RE.findall(
        audit_target_output.read_text(encoding="utf-8")
    )
    audited_source_names = [*MODULES, AUDIT_MODULE]
    audit_target_new_warning_headers = [
        warning
        for warning in audit_target_warning_headers
        if any(
            f"IUTThreeClosures/{name}.lean" in warning
            for name in audited_source_names
        )
    ]
    audit_target_run["warning_count"] = len(audit_target_warning_headers)
    audit_target_run["warning_headers"] = audit_target_warning_headers
    audit_target_run["new_module_warning_count"] = len(
        audit_target_new_warning_headers
    )
    audit_target_run["new_module_warning_headers"] = (
        audit_target_new_warning_headers
    )
    write_json(HERE / "audit-target-build-run.json", audit_target_run)

    library_output = HERE / "library-build-output.txt"
    library_run = run(["lake", "build", "IUTThreeClosures"], library_output)
    if library_run["exit_code"] != 0:
        write_json(HERE / "library-build-run.json", library_run)
        raise RuntimeError("lake build IUTThreeClosures failed")
    library_run["completion_jobs"] = parse_jobs(library_output)
    library_warning = warning_comparison(library_output)
    library_run["warnings"] = library_warning
    write_json(HERE / "library-build-run.json", library_run)

    default_output = HERE / "default-build-output.txt"
    default_run = run(["lake", "build"], default_output)
    if default_run["exit_code"] != 0:
        write_json(HERE / "default-build-run.json", default_run)
        raise RuntimeError("default lake build failed")
    default_run["completion_jobs"] = parse_jobs(default_output)
    default_warning = warning_comparison(default_output)
    default_run["warnings"] = default_warning
    write_json(HERE / "default-build-run.json", default_run)

    warning_summary = {
        "frozen_baseline": (
            BASELINE / "build-output.txt"
        ).relative_to(REPO_ROOT).as_posix(),
        "library_target_build": library_warning,
        "default_build": default_warning,
        "new_module_warning_count_library_target": len(
            library_warning["new_module_warning_headers"]
        ),
        "new_module_warning_count_default": len(
            default_warning["new_module_warning_headers"]
        ),
    }
    write_json(HERE / "warning-comparison.json", warning_summary)

    after = {
        path.relative_to(REPO_ROOT).as_posix(): sha256(path) for path in immutable_paths
    }
    changed = sorted(path for path in before if before[path] != after[path])
    if changed:
        raise RuntimeError(f"source inputs changed during validation: {changed}")

    old_environment = json.loads((BASELINE / "environment.json").read_text("utf-8"))
    protected_hashes = {
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
        "packages_match_dual_route_baseline": packages == old_environment["packages"],
        "protected_file_sha256": protected_hashes,
        "protected_files_match_dual_route_baseline": protected_hashes
        == old_environment["protected_file_sha256"],
        "source_inputs_changed_during_validation": changed,
    }
    write_json(HERE / "environment.json", environment)

    source_hashes = {
        path.relative_to(REPO_ROOT).as_posix(): {
            "sha256": sha256(path),
            "bytes": path.stat().st_size,
        }
        for path in immutable_paths
    }
    source_hashes[
        (BASELINE / "build-output.txt").relative_to(REPO_ROOT).as_posix()
    ] = {
        "sha256": sha256(BASELINE / "build-output.txt"),
        "bytes": (BASELINE / "build-output.txt").stat().st_size,
    }
    write_json(HERE / "source-hashes.json", source_hashes)

    new_module_warning_count = max(
        len(library_warning["new_module_warning_headers"]),
        len(default_warning["new_module_warning_headers"]),
    )
    all_commands_passed = all(
        data["exit_code"] == 0
        for data in [*direct_runs.values(), audit_target_run, library_run, default_run]
    )
    all_passed = (
        all_commands_passed
        and not unexpected_axioms
        and not has_sorry_ax
        and not primary_hits
        and not extended_hits
        and not changed
        and not audit_target_new_warning_headers
        and new_module_warning_count == 0
        and environment["packages_match_dual_route_baseline"]
        and environment["protected_files_match_dual_route_baseline"]
    )
    summary = {
        "research_date": "2026-08-31",
        "status": "Lean validation passed; rigorous conditional and structural results"
        if all_passed
        else "Lean validation requires review",
        "standard_abc_proof_or_disproof": False,
        "abc_status": "The standard ABCConjecture remains open",
        "module_count": len(MODULES),
        "audit_module": AUDIT_MODULE,
        "direct_compile_exit_codes": {
            module: data["exit_code"] for module, data in direct_runs.items()
        },
        "audit_target_build_exit_code": audit_target_run["exit_code"],
        "audit_target_build_jobs": audit_target_run["completion_jobs"],
        "audit_target_warning_count": audit_target_run["warning_count"],
        "audit_target_new_module_warning_count": audit_target_run[
            "new_module_warning_count"
        ],
        "library_target_build_exit_code": library_run["exit_code"],
        "library_target_build_jobs": library_run["completion_jobs"],
        "default_build_exit_code": default_run["exit_code"],
        "default_build_jobs": default_run["completion_jobs"],
        "public_theorems_by_module": {
            module: expected[0] for module, expected in MODULES.items()
        },
        "additional_declarations_by_module": {
            module: expected[1] for module, expected in MODULES.items()
        },
        "public_theorem_count": theorem_total,
        "additional_declaration_count": additional_total,
        "audited_declaration_count": len(dependencies),
        "zero_axiom_declaration_count": axiom_summary["zero_axiom_declarations"],
        "kernel_axioms": all_axioms,
        "unexpected_axioms": unexpected_axioms,
        "audit_has_sorryAx": has_sorry_ax,
        "forbidden_primary_source_tokens": primary_hits,
        "extended_escape_source_tokens": extended_hits,
        "library_warning_count": library_warning["current_warning_count"],
        "default_warning_count": default_warning["current_warning_count"],
        "frozen_baseline_warning_count": default_warning["baseline_warning_count"],
        "library_warning_multiset_matches_baseline": library_warning[
            "multiset_matches_baseline"
        ],
        "default_warning_multiset_matches_baseline": default_warning[
            "multiset_matches_baseline"
        ],
        "new_module_warning_count": new_module_warning_count,
        "packages_match_dual_route_baseline": environment[
            "packages_match_dual_route_baseline"
        ],
        "protected_files_match_dual_route_baseline": environment[
            "protected_files_match_dual_route_baseline"
        ],
        "source_inputs_changed_during_validation": changed,
        "all_passed": all_passed,
    }
    write_json(HERE / "validation_summary.json", summary)

    validation_lines = [
        "# Balanced-persistence Lean validation",
        "",
        "Validated on 2026-08-31. The standard `ABCConjecture` remains open; ",
        "this evidence freezes conditional and structural results only.",
        "",
        f"- Four new mathematical modules and `{AUDIT_MODULE}.lean` compiled directly with exit code zero.",
        f"- The audit covers {len(dependencies)} explicit public declarations: {theorem_total} theorems and {additional_total} definitions/structures.",
        f"- Kernel dependencies are exactly: {', '.join(all_axioms)}.",
        "- No audited declaration depends on `sorryAx`; source scanning found no code-level `sorry`, `admit`, `axiom`, or `unsafe`, and no extended escape declarations.",
        f"- The audit target build passed with {audit_target_run['completion_jobs']} jobs and {audit_target_run['warning_count']} historical dependency warning headers; {audit_target_run['new_module_warning_count']} are attributed to the four modules or audit file.",
        f"- `lake build IUTThreeClosures` passed with {library_run['completion_jobs']} jobs and {library_warning['current_warning_count']} warning headers.",
        f"- The repository-default `lake build` also passed with {default_run['completion_jobs']} jobs and {default_warning['current_warning_count']} warning headers.",
        f"- The frozen dual-route baseline has {default_warning['baseline_warning_count']} warning headers.",
        f"- Library-target warning multiset matches the baseline: {str(library_warning['multiset_matches_baseline']).lower()}.",
        f"- Default-build warning multiset matches the baseline: {str(default_warning['multiset_matches_baseline']).lower()}.",
        f"- Warnings attributed to the four modules or audit file: {new_module_warning_count}.",
        "- Added and removed warning headers, if any, are listed verbatim in `warning-comparison.json`, separating historical warnings from stage-local warnings.",
        f"- Package pins match the frozen baseline: {str(environment['packages_match_dual_route_baseline']).lower()}.",
        f"- Protected statement/toolchain files match the frozen baseline: {str(environment['protected_files_match_dual_route_baseline']).lower()}.",
        "- Hashes taken before and after validation confirm that no mathematical or Lean source input changed during this run.",
        "",
        "The conditional theorems named `not_abcConjecture_of_unbounded_*` require explicit unbounded-family hypotheses. Neither those hypotheses nor an unconditional proof or disproof of `ABCConjecture` is supplied.",
    ]
    (HERE / "VALIDATION.md").write_text("\n".join(validation_lines) + "\n", encoding="utf-8")

    artifact_paths = sorted(
        path
        for path in HERE.iterdir()
        if path.is_file()
        and path.name not in {"SHA256SUMS", "artifact-manifest.json"}
    )
    artifact_manifest = {
        "research_date": "2026-08-31",
        "status": summary["status"],
        "standard_abc_proof_or_disproof": False,
        "artifact_count": len(artifact_paths),
        "artifacts": {
            path.name: {"sha256": sha256(path), "bytes": path.stat().st_size}
            for path in artifact_paths
        },
    }
    write_json(HERE / "artifact-manifest.json", artifact_manifest)

    sum_paths = sorted(
        path for path in HERE.iterdir() if path.is_file() and path.name != "SHA256SUMS"
    )
    sums = "\n".join(f"{sha256(path)} *{path.name}" for path in sum_paths) + "\n"
    (HERE / "SHA256SUMS").write_text(sums, encoding="utf-8")

    print(json.dumps(summary, indent=2, ensure_ascii=False))
    if not all_passed:
        raise SystemExit(2)


if __name__ == "__main__":
    main()
