#!/usr/bin/env python3
"""Seal and replay the 2026-09-02 refined multi-route abc checkpoint.

The validator inventories every declaration in the eight new Lean modules,
rejects proof escapes and custom opaque declarations, generates one
``#print axioms`` command for every named declaration, compiles each module
with warnings as errors, compiles the generated audit, rebuilds the umbrella
target, replays the deterministic computations, and freezes the exact input
hashes.  It does not assert the abc conjecture or its negation.
"""

from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import shutil
import subprocess
import sys
from typing import Any, Iterable


PACKAGE_ROOT = Path(__file__).resolve().parent
REPO_ROOT = PACKAGE_ROOT.parents[2]
LEAN_ROOT = REPO_ROOT / "Lean"
PACKAGE_NAME = PACKAGE_ROOT.name
LIVE_ROOT = REPO_ROOT / "tmp" / "verification" / PACKAGE_NAME

MODULES = (
    "IUTRefinedTensorHaarThetaSamePilot20260902",
    "MersenneFareyDenominatorEntropy20260902",
    "AffineOwnershipMaximalIntersectionAggregation20260902",
    "PellPolynomialHenselSpecialization20260902",
    "PellPolynomialAllIndexFormalization20260902",
    "SteinbergValuationContactSurface20260902",
    "SteinbergIntegerFiniteChain20260902",
    "QuadraticVeronesePeeling20260902",
)

REPORTS = (
    "research/ABC_IUT_REFINED_TENSOR_HAAR_THETA_SAME_PILOT_2026_09_02.md",
    "research/ABC_MERSENNE_FAREY_DENOMINATOR_ENTROPY_2026_09_02.md",
    "research/ABC_AFFINE_OWNERSHIP_MAXIMAL_INTERSECTION_AGGREGATION_2026_09_02.md",
    "research/ABC_PELL_POLYNOMIAL_HENSEL_SPECIALIZATION_2026_09_02.md",
    "research/ABC_PELL_ALL_INDEX_FORMALIZATION_2026_09_02.md",
    "research/ABC_STEINBERG_VALUATION_CONTACT_SURFACE_2026_09_02.md",
    "research/ABC_STEINBERG_INTEGER_GCD_FINITE_CHAIN_CLOSURE_2026_09_02.md",
    "research/ABC_QUADRATIC_VERONESE_PEELING_ANALYSIS_2026_09_02.md",
    "research/ABC_MULTI_ROUTE_REFINED_HAAR_FAREY_OWNERSHIP_HENSEL_CONTACT_2026_09_02.md",
    "research/ABC_FIVE_ROUTE_ADVERSARIAL_REVIEW_2026_09_02.md",
)

PAPER_FILES = (
    "paper/ChatGPT_ABC_Uniformity_2026.tex",
    "paper/iut_refined_tensor_haar_theta_same_pilot_2026.tex",
    "paper/mersenne_farey_denominator_entropy_2026.tex",
    "paper/affine_ownership_maximal_intersection_aggregation_2026.tex",
    "paper/pell_polynomial_hensel_specialization_2026.tex",
    "paper/pell_polynomial_all_index_formalization_2026.tex",
    "paper/steinberg_valuation_contact_surface_2026.tex",
    "paper/steinberg_integer_finite_chain_2026.tex",
    "paper/quadratic_veronese_peeling_2026.tex",
    "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf",
)

INPUT_DIRECTORIES = (
    "research/computation/2026_09_02_iut_refined_tensor_haar_theta_same_pilot",
    "research/computation/2026_09_02_mersenne_farey_denominator_entropy",
    "research/computation/2026_09_02_affine_ownership_aggregation",
    "research/computation/2026_09_02_pell_hensel_specialization",
    "research/computation/quadratic_veronese_peeling_2026_09_02",
    "research/sources/latest_abc_proposals_2026_09_02",
    "research/sources/mersenne_farey_denominator_entropy_2026_09_02",
    "research/sources/affine_ownership_aggregation_2026_09_02",
    "research/sources/pell_hensel_powerful_polynomial_2026_09_02",
    "research/sources/steinberg_contact_surface_2026_09_02",
    "research/sources/iut_admissible_scaling_order_index_2026_09_02",
    "research/computation/2026_09_02_mersenne_sigma_one",
    "research/sources/mersenne_prime_layer_radical_2026_09_01",
    "output/pdf/ChatGPT_ABC_Refined_Haar_Farey_Ownership_Hensel_Contact_2026_09_02_QA",
)

FIXED_INPUTS = (
    ".gitattributes",
    "README.md",
    "Lean/lean-toolchain",
    "Lean/lakefile.toml",
    "Lean/lake-manifest.json",
    "Lean/IUTThreeClosures.lean",
    "Lean/RESEARCH_STATUS.md",
    "Lean/RESEARCH_ROUTE_REGISTRY.md",
    *(
        f"Lean/IUTThreeClosures/{module}.lean"
        for module in MODULES
    ),
    *(
        f"Lean/IUTThreeClosures/{module}AxiomAudit.lean"
        for module in MODULES
    ),
    *REPORTS,
    *PAPER_FILES,
)

ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}
DECLARATION_KINDS = (
    "theorem", "lemma", "def", "abbrev", "structure", "class",
    "inductive", "instance",
)
AUDITED_KINDS = {
    "theorem", "lemma", "def", "abbrev", "structure", "class",
    "inductive", "instance",
}
GENERATED_AUDIT = "axiom-audit.lean"
INVENTORY_FILE = "declaration-inventory.json"
INPUT_MANIFEST = "input-manifest.json"
VALIDATION_FILE = "validation-run.json"
SEAL_FILE = "SHA256SUMS"
VALIDATION_SCHEMA = "abc-refined-haar-farey-ownership-hensel-contact-validation-v1"
EXPECTED_AGGREGATE_JOBS = 9255

EXPECTED_MODULE_COUNTS = {
    "IUTRefinedTensorHaarThetaSamePilot20260902": {
        "theorem": 38, "lemma": 0, "def": 12, "abbrev": 0,
        "structure": 1, "class": 0, "inductive": 0, "instance": 2,
    },
    "MersenneFareyDenominatorEntropy20260902": {
        "theorem": 16, "lemma": 0, "def": 7, "abbrev": 0,
        "structure": 0, "class": 0, "inductive": 0, "instance": 0,
    },
    "AffineOwnershipMaximalIntersectionAggregation20260902": {
        "theorem": 24, "lemma": 0, "def": 1, "abbrev": 0,
        "structure": 0, "class": 0, "inductive": 0, "instance": 0,
    },
    "PellPolynomialHenselSpecialization20260902": {
        "theorem": 21, "lemma": 0, "def": 9, "abbrev": 0,
        "structure": 0, "class": 0, "inductive": 0, "instance": 0,
    },
    "PellPolynomialAllIndexFormalization20260902": {
        "theorem": 43, "lemma": 0, "def": 8, "abbrev": 0,
        "structure": 1, "class": 0, "inductive": 0, "instance": 0,
    },
    "SteinbergValuationContactSurface20260902": {
        "theorem": 45, "lemma": 0, "def": 23, "abbrev": 1,
        "structure": 0, "class": 0, "inductive": 0, "instance": 0,
    },
    "SteinbergIntegerFiniteChain20260902": {
        "theorem": 57, "lemma": 0, "def": 25, "abbrev": 4,
        "structure": 2, "class": 0, "inductive": 0, "instance": 0,
    },
    "QuadraticVeronesePeeling20260902": {
        "theorem": 53, "lemma": 0, "def": 28, "abbrev": 0,
        "structure": 0, "class": 0, "inductive": 0, "instance": 0,
    },
}

EXPECTED_INVENTORY_TOTALS = {
    "theorem": 297, "lemma": 0, "def": 113, "abbrev": 5,
    "structure": 4, "class": 0, "inductive": 0, "instance": 2,
    "countedDeclarations": 421, "proofDeclarations": 297,
    "auditedDeclarations": 421,
}


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def repo_path(relative: str) -> Path:
    pure = PurePosixPath(relative)
    if pure.is_absolute() or ".." in pure.parts:
        raise RuntimeError(f"unsafe repository path: {relative}")
    path = REPO_ROOT.joinpath(*pure.parts).resolve()
    path.relative_to(REPO_ROOT.resolve())
    return path


def strip_lean_comments_and_strings(source: str) -> str:
    """Blank nested comments and literals while preserving line numbers."""
    output: list[str] = []
    index = 0
    block_depth = 0
    line_comment = False
    in_string = False
    escaped = False
    while index < len(source):
        char = source[index]
        nxt = source[index + 1] if index + 1 < len(source) else ""
        if line_comment:
            if char in "\r\n":
                line_comment = False
                output.append(char)
            else:
                output.append(" ")
            index += 1
            continue
        if block_depth:
            if char == "/" and nxt == "-":
                block_depth += 1
                output.extend((" ", " "))
                index += 2
            elif char == "-" and nxt == "/":
                block_depth -= 1
                output.extend((" ", " "))
                index += 2
            else:
                output.append(char if char in "\r\n" else " ")
                index += 1
            continue
        if in_string:
            output.append(char if char in "\r\n" else " ")
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                in_string = False
            index += 1
            continue
        if char == "-" and nxt == "-":
            line_comment = True
            output.extend((" ", " "))
            index += 2
        elif char == "/" and nxt == "-":
            block_depth = 1
            output.extend((" ", " "))
            index += 2
        elif char == "'" and not (
            index > 0 and (source[index - 1].isalnum() or source[index - 1] in "_'")
        ):
            cursor = index + 1
            literal_escaped = False
            found = False
            while cursor < len(source) and source[cursor] not in "\r\n":
                if literal_escaped:
                    literal_escaped = False
                elif source[cursor] == "\\":
                    literal_escaped = True
                elif source[cursor] == "'" and cursor > index + 1:
                    found = True
                    break
                cursor += 1
            if found:
                output.extend(" " for _ in range(cursor - index + 1))
                index = cursor + 1
            else:
                output.append(char)
                index += 1
        elif char == '"':
            in_string = True
            output.append(" ")
            index += 1
        else:
            output.append(char)
            index += 1
    if block_depth or in_string:
        raise RuntimeError("unterminated Lean comment or string")
    return "".join(output)


def strip_attributes(source: str) -> str:
    output = list(source)
    index = 0
    while index + 1 < len(source):
        if source[index:index + 2] != "@[":
            index += 1
            continue
        depth = 1
        cursor = index + 2
        while cursor < len(source) and depth:
            if source[cursor] == "[":
                depth += 1
            elif source[cursor] == "]":
                depth -= 1
            cursor += 1
        if depth:
            raise RuntimeError("unterminated Lean attribute")
        for position in range(index, cursor):
            if output[position] not in "\r\n":
                output[position] = " "
        index = cursor
    return "".join(output)


MODIFIERS = r"(?P<modifiers>(?:(?:private|protected|noncomputable)[ \t]+)*)"
DECLARATION_RE = re.compile(
    rf"(?m)^[ \t]*{MODIFIERS}"
    r"(?P<kind>theorem|lemma|def|abbrev|structure|class|inductive|instance)\b"
)
NAMED_RE = re.compile(
    rf"(?m)^[ \t]*{MODIFIERS}"
    r"(?P<kind>theorem|lemma|def|abbrev|structure|class|inductive|instance)\s+"
    r"(?P<name>[^\s:({\[]+)"
)
FORBIDDEN_RE = re.compile(
    r"(?m)^[ \t]*(?:(?:private|protected|noncomputable)[ \t]+)*"
    r"(?P<kind>axiom|axioms|opaque|unsafe|partial|extern)\b"
)
UNSUPPORTED_DECLARATION_RE = re.compile(
    r"(?m)^[ \t]*(?:(?:private|protected|noncomputable)[ \t]+)*(?P<form>"
    r"nonrec[ \t]+(?:theorem|lemma|def|abbrev|structure|class|inductive|instance)"
    r"|irreducible_def\b|scoped[ \t]+instance\b|deriving[ \t]+instance\b"
    r"|local[ \t]+instance\b|example\b|mutual\b)"
)
SCOPE_RE = re.compile(
    r"(?m)^[ \t]*(namespace[ \t]+([^\s]+)|(?:noncomputable[ \t]+)?section(?:[ \t]+[^\s]+)?|end(?:[ \t]+[^\s]+)?)[ \t]*$"
)


def qualify(name: str, namespace: tuple[str, ...]) -> str:
    if name.startswith("_root_."):
        return name.removeprefix("_root_.")
    return ".".join((*namespace, *(part for part in name.split(".") if part)))


def named_declarations(clean: str) -> list[dict[str, Any]]:
    events: list[tuple[int, int, str, Any]] = []
    for match in SCOPE_RE.finditer(clean):
        command = match.group(1)
        if command.startswith("namespace"):
            events.append((match.start(), 0, "namespace", match.group(2)))
        elif command.startswith("section") or command.startswith("noncomputable section"):
            events.append((match.start(), 0, "section", None))
        else:
            events.append((match.start(), 0, "end", None))
    for match in NAMED_RE.finditer(clean):
        events.append((match.start(), 1, "declaration", match))
    events.sort(key=lambda row: (row[0], row[1]))

    namespace: list[str] = []
    scopes: list[tuple[str, tuple[str, ...] | None]] = []
    declarations: list[dict[str, Any]] = []
    for _, _, event, payload in events:
        if event == "namespace":
            previous = tuple(namespace)
            raw = str(payload)
            if raw.startswith("_root_."):
                namespace.clear()
                raw = raw.removeprefix("_root_.")
            namespace.extend(part for part in raw.split(".") if part)
            scopes.append(("namespace", previous))
        elif event == "section":
            scopes.append(("section", None))
        elif event == "end":
            if not scopes:
                raise RuntimeError("unmatched Lean end")
            kind, previous = scopes.pop()
            if kind == "namespace" and previous is not None:
                namespace[:] = previous
        else:
            match = payload
            modifiers = match.group("modifiers").split()
            short_name = match.group("name")
            declarations.append({
                "kind": match.group("kind"),
                "shortName": short_name,
                "name": qualify(short_name, tuple(namespace)),
                "private": "private" in modifiers,
                "line": clean.count("\n", 0, match.start()) + 1,
            })
    if scopes:
        raise RuntimeError("unterminated Lean namespace or section")
    return declarations


def inventory_module(module: str) -> dict[str, Any]:
    relative = f"Lean/IUTThreeClosures/{module}.lean"
    path = repo_path(relative)
    raw = path.read_text(encoding="utf-8")
    clean = strip_attributes(strip_lean_comments_and_strings(raw))

    forbidden = [
        token for token in ("sorry", "admit", "native_decide", "sorryAx")
        if re.search(rf"\b{re.escape(token)}\b", clean)
    ]
    forbidden.extend(match.group("kind") for match in FORBIDDEN_RE.finditer(clean))
    if forbidden:
        raise RuntimeError(f"forbidden Lean source in {module}: {sorted(set(forbidden))}")

    unsupported = [
        match.group("form") for match in UNSUPPORTED_DECLARATION_RE.finditer(clean)
    ]
    if unsupported:
        raise RuntimeError(
            f"unsupported declaration form in {module}: {sorted(set(unsupported))}"
        )

    counts = {kind: 0 for kind in DECLARATION_KINDS}
    for match in DECLARATION_RE.finditer(clean):
        counts[match.group("kind")] += 1
    declarations = named_declarations(clean)
    names = [str(row["name"]) for row in declarations]
    if len(names) != len(set(names)):
        raise RuntimeError(f"duplicate parsed declaration in {module}")
    if any(row["private"] for row in declarations):
        raise RuntimeError(f"private declarations cannot be independently audited: {module}")
    anonymous_instances = counts["instance"] - sum(
        row["kind"] == "instance" for row in declarations
    )
    if anonymous_instances:
        raise RuntimeError(f"anonymous instances are forbidden in checkpoint module {module}")
    expected_named = sum(counts.values())
    if len(declarations) != expected_named:
        raise RuntimeError(
            f"declaration parser mismatch in {module}: {len(declarations)} != {expected_named}"
        )
    expected_counts = EXPECTED_MODULE_COUNTS[module]
    if counts != expected_counts:
        raise RuntimeError(
            f"fixed declaration counts changed in {module}: "
            f"actual={counts}, expected={expected_counts}"
        )
    return {
        "module": module,
        "path": relative,
        "bytes": path.stat().st_size,
        "sha256": sha256(path),
        "counts": counts,
        "countedDeclarations": expected_named,
        "proofDeclarations": counts["theorem"] + counts["lemma"],
        "auditedDeclarations": declarations,
    }


def inventories() -> list[dict[str, Any]]:
    return [inventory_module(module) for module in MODULES]


def inventory_summary(rows: list[dict[str, Any]]) -> dict[str, Any]:
    totals = {
        kind: sum(int(row["counts"][kind]) for row in rows)
        for kind in DECLARATION_KINDS
    }
    summary = {
        "modules": rows,
        "totals": {
            **totals,
            "countedDeclarations": sum(totals.values()),
            "proofDeclarations": totals["theorem"] + totals["lemma"],
            "auditedDeclarations": sum(
                len(row["auditedDeclarations"]) for row in rows
            ),
        },
    }
    if summary["totals"] != EXPECTED_INVENTORY_TOTALS:
        raise RuntimeError(
            "fixed aggregate declaration counts changed: "
            f"actual={summary['totals']}, expected={EXPECTED_INVENTORY_TOTALS}"
        )
    return summary


def audit_text(rows: list[dict[str, Any]]) -> str:
    lines = [
        "/- Generated by validate.py; do not edit. -/",
        *(f"import IUTThreeClosures.{module}" for module in MODULES),
        "",
        "/- One command for every named declaration in the eight source modules. -/",
    ]
    for row in rows:
        for declaration in row["auditedDeclarations"]:
            if declaration["kind"] in AUDITED_KINDS:
                lines.append(f"#print axioms {declaration['name']}")
    lines.append("")
    return "\n".join(lines)


def write_text(path: Path, value: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(value, encoding="utf-8", newline="\n")


def iter_input_paths() -> list[Path]:
    paths: set[Path] = set()
    for relative in FIXED_INPUTS:
        path = repo_path(relative)
        if not path.is_file():
            raise RuntimeError(f"missing fixed input: {relative}")
        paths.add(path)
    # Freeze every version-controlled Lean source that may lie in an import
    # chain, in addition to the fixed new modules above.  Ignored Scratch/Tmp
    # experiments are intentionally not build inputs or checkpoint artifacts.
    # Build products and historical verification packages are reproducibility
    # outputs rather than source inputs.
    tracked = subprocess.run(
        ["git", "ls-files", "-z", "--", "Lean"], cwd=REPO_ROOT,
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True,
    ).stdout.decode("utf-8")
    lean_source_root = repo_path("Lean")
    for relative in tracked.split("\0"):
        if not relative or not relative.endswith(".lean"):
            continue
        path = repo_path(relative)
        relative_parts = path.relative_to(lean_source_root).parts
        if ".lake" in relative_parts or "verification" in relative_parts:
            continue
        if not path.is_file():
            raise RuntimeError(f"tracked Lean source is missing: {relative}")
        paths.add(path.resolve())
    for relative in INPUT_DIRECTORIES:
        directory = repo_path(relative)
        if not directory.is_dir():
            raise RuntimeError(f"missing input directory: {relative}")
        for path in directory.rglob("*"):
            if path.is_file() and path.suffix.lower() not in {".exe", ".obj", ".o", ".pyc"}:
                paths.add(path.resolve())
    for path in repo_path("paper").glob("*"):
        if path.is_file() and path.suffix.lower() in {".tex", ".sty", ".bib"}:
            paths.add(path.resolve())
    return sorted(paths, key=lambda path: path.relative_to(REPO_ROOT).as_posix())


def input_records() -> list[dict[str, Any]]:
    records = []
    for path in iter_input_paths():
        records.append({
            "path": path.relative_to(REPO_ROOT).as_posix(),
            "bytes": path.stat().st_size,
            "sha256": sha256(path),
        })
    return records


def prepare() -> dict[str, Any]:
    rows = inventories()
    summary = inventory_summary(rows)
    write_text(PACKAGE_ROOT / INVENTORY_FILE,
               json.dumps(summary, indent=2, ensure_ascii=False) + "\n")
    write_text(PACKAGE_ROOT / GENERATED_AUDIT, audit_text(rows))
    write_text(PACKAGE_ROOT / INPUT_MANIFEST,
               json.dumps(input_records(), indent=2, ensure_ascii=False) + "\n")
    return summary


def verify_prepared() -> dict[str, Any]:
    expected_inventory = json.loads((PACKAGE_ROOT / INVENTORY_FILE).read_text(encoding="utf-8"))
    actual_inventory = inventory_summary(inventories())
    if expected_inventory != actual_inventory:
        raise RuntimeError("declaration inventory differs from the frozen inventory")
    generated = audit_text(actual_inventory["modules"])
    if (PACKAGE_ROOT / GENERATED_AUDIT).read_text(encoding="utf-8") != generated:
        raise RuntimeError("generated axiom audit differs from frozen audit")
    expected_inputs = json.loads((PACKAGE_ROOT / INPUT_MANIFEST).read_text(encoding="utf-8"))
    actual_inputs = input_records()
    if expected_inputs != actual_inputs:
        expected = {row["path"]: row for row in expected_inputs}
        actual = {row["path"]: row for row in actual_inputs}
        changed = sorted(
            name for name in set(expected) | set(actual)
            if expected.get(name) != actual.get(name)
        )
        raise RuntimeError("frozen input mismatch: " + ", ".join(changed))
    return actual_inventory


def run_logged(name: str, command: list[str], cwd: Path, log_root: Path,
               timeout: int = 1800) -> dict[str, Any]:
    result = subprocess.run(
        command, cwd=cwd, text=True, encoding="utf-8", errors="strict",
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=timeout,
    )
    log_path = log_root / f"{name}.log"
    write_text(log_path, result.stdout)
    if result.returncode:
        tail = "\n".join(result.stdout.splitlines()[-80:])
        raise RuntimeError(f"command failed ({name}, {result.returncode}):\n{tail}")
    return {
        "name": name,
        "command": command,
        "cwd": cwd.relative_to(REPO_ROOT).as_posix(),
        "exitCode": result.returncode,
        "log": log_path.relative_to(
            PACKAGE_ROOT if PACKAGE_ROOT in log_path.parents else REPO_ROOT
        ).as_posix(),
        "logSha256": sha256(log_path),
    }


def normalized_utf8(path: Path) -> str:
    """Decode strictly and normalize only the host newline convention."""
    return path.read_bytes().decode("utf-8").replace("\r\n", "\n").replace("\r", "\n")


def require_normalized_stdout_match(
    log_root: Path, log_name: str, frozen_relative: str,
) -> dict[str, Any]:
    live_path = log_root / f"{log_name}.log"
    frozen_path = repo_path(frozen_relative)
    live = normalized_utf8(live_path)
    frozen = normalized_utf8(frozen_path)
    if live != frozen:
        raise RuntimeError(
            f"newline-normalized stdout mismatch: {log_name} != {frozen_relative}"
        )
    return {
        "command": log_name,
        "frozen": frozen_relative,
        "normalizedSha256": hashlib.sha256(live.encode("utf-8")).hexdigest(),
    }


def parse_json_after_marker(value: str, marker: str) -> dict[str, Any]:
    prefix, separator, payload = value.partition(marker)
    if not separator or not prefix.strip():
        raise RuntimeError(f"missing or malformed JSON marker: {marker!r}")
    parsed = json.loads(payload)
    if not isinstance(parsed, dict):
        raise RuntimeError("marked JSON payload is not an object")
    return parsed


def parse_axioms(output: str, expected_names: list[str]) -> dict[str, Any]:
    pattern = re.compile(
        r"(?m)^'([^\r\n]+)' "
        r"(?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)"
        r"[ \t]*$",
    )
    parsed: list[tuple[str, list[str]]] = []
    for match in pattern.finditer(output):
        block = match.group(2)
        axioms = [] if block is None else [
            item.strip() for item in block.replace("\n", " ").split(",") if item.strip()
        ]
        parsed.append((match.group(1), axioms))
    name_counts = Counter(name for name, _ in parsed)
    expected_counts = Counter(expected_names)
    missing = sorted(name for name in expected_counts if name_counts[name] == 0)
    extra = sorted(name for name in name_counts if name not in expected_counts)
    duplicates = sorted(name for name, count in name_counts.items() if count != 1)
    expected_duplicates = sorted(
        name for name, count in expected_counts.items() if count != 1
    )
    if missing or extra or duplicates or expected_duplicates or len(parsed) != len(expected_names):
        raise RuntimeError(
            "axiom report mismatch; "
            f"missing={missing}, extra={extra}, duplicates={duplicates}, "
            f"expectedDuplicates={expected_duplicates}, "
            f"parsed={len(parsed)}, expected={len(expected_names)}"
        )
    reports = dict(parsed)
    union = sorted({axiom for values in reports.values() for axiom in values})
    unexpected = sorted(set(union) - ALLOWED_AXIOMS)
    if unexpected:
        raise RuntimeError(f"unexpected axiom dependencies: {unexpected}")
    return {
        "reports": len(reports),
        "allowed": sorted(ALLOWED_AXIOMS),
        "union": union,
        "unexpected": unexpected,
    }


def verify_hash_manifests() -> dict[str, Any]:
    roots = [repo_path(relative) for relative in INPUT_DIRECTORIES]
    manifests = sorted({
        path for root in roots for pattern in ("SHA256SUMS", "SHA256SUMS.txt")
        for path in root.rglob(pattern)
    })
    checked = 0
    for manifest in manifests:
        for line_number, raw in enumerate(manifest.read_text(encoding="utf-8").splitlines(), 1):
            line = raw.strip()
            if not line or line.startswith("#"):
                continue
            match = re.fullmatch(r"([0-9a-fA-F]{64})\s+\*?(.+)", line)
            if not match:
                raise RuntimeError(f"malformed hash line {manifest}:{line_number}")
            target = (manifest.parent / match.group(2)).resolve()
            target.relative_to(REPO_ROOT.resolve())
            if not target.is_file():
                raise RuntimeError(f"missing hashed file: {target}")
            actual = sha256(target)
            if actual.lower() != match.group(1).lower():
                raise RuntimeError(f"hash mismatch: {target}")
            checked += 1
    return {"manifests": len(manifests), "entries": checked}


def verify_text_inputs() -> dict[str, Any]:
    checked = 0
    archived_extraction_controls = 0
    for path in iter_input_paths():
        if path.suffix.lower() not in {
            ".lean", ".md", ".tex", ".py", ".ps1", ".json", ".txt",
            ".toml", ".bib", ".cpp", ".csv", ".tsv", ".yaml", ".yml",
        }:
            continue
        raw = path.read_bytes()
        # Universal-newline text decoding would silently turn an isolated CR
        # into LF.  Reject that byte explicitly; ordinary CRLF is permitted.
        if re.search(br"\r(?!\n)", raw):
            raise RuntimeError(f"isolated carriage return in {path}")
        value = raw.decode("utf-8")
        bad = [char for char in value if ord(char) < 32 and char not in "\n\r\t"]
        if bad:
            relative = path.relative_to(REPO_ROOT).as_posix()
            # Frozen PDF-to-text extractions may retain page separators and
            # font-control bytes emitted by the extractor.  They are source
            # evidence, not authored code or prose; hash them and report their
            # count, while continuing to reject controls everywhere else.
            if path.suffix.lower() == ".txt" and relative.startswith("research/sources/"):
                archived_extraction_controls += len(bad)
            else:
                raise RuntimeError(f"control character in {path}")
        if path.suffix.lower() == ".tex" and re.search(r"(?<!\\)\bqquad\b", value):
            raise RuntimeError(f"bare TeX spacing command in {path}")
        checked += 1

    authored_paths = {
        repo_path(relative) for relative in FIXED_INPUTS
        if repo_path(relative).suffix.lower() in {
            ".lean", ".md", ".tex", ".py", ".ps1", ".json", ".toml",
            ".bib", ".yaml", ".yml",
        }
    }
    qa_root = repo_path(
        "output/pdf/"
        "ChatGPT_ABC_Refined_Haar_Farey_Ownership_Hensel_Contact_2026_09_02_QA"
    )
    # Generated inventory, audit, validation, metrics, and seal files appear at
    # different phases of record/check.  Keep this set explicit so the text
    # audit is phase-independent and its "authored" label remains truthful.
    authored_paths.update({
        (PACKAGE_ROOT / "README.md").resolve(),
        (PACKAGE_ROOT / "validate.py").resolve(),
        (PACKAGE_ROOT / "validate.ps1").resolve(),
        (qa_root / "README.md").resolve(),
        (qa_root / "render_audit.py").resolve(),
    })
    missing_authored = sorted(str(path) for path in authored_paths if not path.is_file())
    if missing_authored:
        raise RuntimeError(f"missing authored text input: {missing_authored}")
    trailing: list[str] = []
    for path in sorted(authored_paths):
        value = path.read_bytes().decode("utf-8")
        for line_number, line in enumerate(value.splitlines(), 1):
            if line.endswith((" ", "\t")):
                trailing.append(
                    f"{path.relative_to(REPO_ROOT).as_posix()}:{line_number}"
                )
    if trailing:
        raise RuntimeError("trailing whitespace in authored input: " + ", ".join(trailing))
    return {
        "utf8TextFiles": checked,
        "authoredTextFiles": len(authored_paths),
        "authoredControlCharacters": 0,
        "archivedExtractionControlCharacters": archived_extraction_controls,
        "isolatedCarriageReturns": 0,
        "bareQquadCommands": 0,
        "trailingWhitespaceLines": 0,
    }


def validate(log_root: Path) -> dict[str, Any]:
    inventory = verify_prepared()
    if log_root.exists():
        shutil.rmtree(log_root)
    log_root.mkdir(parents=True)
    lake = shutil.which("lake")
    python = sys.executable
    if not lake:
        raise RuntimeError("lake was not found on PATH")

    command_records: list[dict[str, Any]] = []
    # Build the full dependency graph first.  Direct compilation and the
    # generated audit then inspect dependencies rebuilt from the frozen source
    # tree rather than pre-existing oleans.
    aggregate = run_logged(
        "lake-build-IUTThreeClosures", [lake, "build", "IUTThreeClosures"],
        LEAN_ROOT, log_root, timeout=3600,
    )
    command_records.append(aggregate)
    aggregate_text = (log_root / "lake-build-IUTThreeClosures.log").read_text(encoding="utf-8")
    jobs_match = re.search(r"Build completed successfully \((\d+) jobs\)\.", aggregate_text)
    if not jobs_match:
        raise RuntimeError("Lake aggregate build did not report a job count")
    aggregate_jobs = int(jobs_match.group(1))
    if aggregate_jobs != EXPECTED_AGGREGATE_JOBS:
        raise RuntimeError(
            f"aggregate build job count changed: {aggregate_jobs} != "
            f"{EXPECTED_AGGREGATE_JOBS}"
        )

    for module in MODULES:
        command_records.append(run_logged(
            f"lean-{module}",
            [lake, "env", "lean", "-DwarningAsError=true", f"IUTThreeClosures/{module}.lean"],
            LEAN_ROOT, log_root,
        ))

    audit_result = subprocess.run(
        [lake, "env", "lean", "-DwarningAsError=true", str(PACKAGE_ROOT / GENERATED_AUDIT)],
        cwd=LEAN_ROOT, text=True, encoding="utf-8", errors="strict",
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=1800,
    )
    audit_log = log_root / "axiom-audit.log"
    write_text(audit_log, audit_result.stdout)
    if audit_result.returncode:
        raise RuntimeError("generated axiom audit did not compile")
    expected_names = [
        declaration["name"]
        for module in inventory["modules"]
        for declaration in module["auditedDeclarations"]
    ]
    axiom_summary = parse_axioms(audit_result.stdout, expected_names)
    command_records.append({
        "name": "generated-axiom-audit",
        "exitCode": 0,
        "log": audit_log.relative_to(
            PACKAGE_ROOT if PACKAGE_ROOT in audit_log.parents else REPO_ROOT
        ).as_posix(),
        "logSha256": sha256(audit_log),
    })

    stdout_audit: list[dict[str, Any]] = []
    evidence = (
        ("evidence-iut", [python, "verify_refined_tensor_normalization.py"],
         "research/computation/2026_09_02_iut_refined_tensor_haar_theta_same_pilot", 300,
         "research/computation/2026_09_02_iut_refined_tensor_haar_theta_same_pilot/verification_output.json"),
        ("evidence-mersenne", [python, "verify.py"],
         "research/computation/2026_09_02_mersenne_farey_denominator_entropy", 300,
         "research/computation/2026_09_02_mersenne_farey_denominator_entropy/verification_output.json"),
        ("evidence-iut-source-metadata", [python, "verify_source_metadata.py"],
         "research/sources/iut_admissible_scaling_order_index_2026_09_02", 300, None),
        ("evidence-mersenne-sigma-one", [python, "verify_witnesses.py"],
         "research/computation/2026_09_02_mersenne_sigma_one", 300,
         "research/computation/2026_09_02_mersenne_sigma_one/verify_witnesses_output.json"),
    )
    for name, command, cwd_relative, timeout, frozen_stdout in evidence:
        command_records.append(run_logged(
            name, command, repo_path(cwd_relative), log_root, timeout,
        ))
        if frozen_stdout is not None:
            stdout_audit.append(require_normalized_stdout_match(
                log_root, name, frozen_stdout,
            ))

    # The canonical affine scan is the producer.  Its process returns zero even
    # when its JSON status is FAIL, so require both the frozen output and the
    # semantic PASS fields before the independent consumer is allowed to run.
    affine_root = repo_path(
        "research/computation/2026_09_02_affine_ownership_aggregation"
    )
    affine_grid_name = "evidence-affine-grid"
    command_records.append(run_logged(
        affine_grid_name, [python, "canonical_grid_scan.py"],
        affine_root, log_root, 1200,
    ))
    stdout_audit.append(require_normalized_stdout_match(
        log_root, affine_grid_name,
        "research/computation/2026_09_02_affine_ownership_aggregation/OUTPUT_GRID_SCAN.txt",
    ))
    affine_grid = parse_json_after_marker(
        normalized_utf8(log_root / f"{affine_grid_name}.log"), "RESULT_JSON\n"
    )
    scan = affine_grid.get("scan")
    if not isinstance(scan, dict):
        raise RuntimeError("affine grid scan is missing its scan object")
    if (
        affine_grid.get("status") != "PASS"
        or scan.get("cases") != 2208
        or scan.get("errors") != []
        or scan.get("exact_skeleton_all_pair_maximal_system_equalities") != 2208
    ):
        raise RuntimeError(f"affine grid semantic failure: {affine_grid.get('status')}")

    affine_independent_name = "evidence-affine-independent"
    command_records.append(run_logged(
        affine_independent_name, [python, "independent_replay.py"],
        affine_root, log_root, 600,
    ))
    stdout_audit.append(require_normalized_stdout_match(
        log_root, affine_independent_name,
        "research/computation/2026_09_02_affine_ownership_aggregation/INDEPENDENT_REPLAY.txt",
    ))

    remaining_evidence = (
        ("evidence-pell-producer", [python, "produce_pell_hensel_specialization.py"],
         "research/computation/2026_09_02_pell_hensel_specialization", 300,
         "research/computation/2026_09_02_pell_hensel_specialization/producer_stdout.txt"),
        ("evidence-pell-verifier", [python, "verify_pell_hensel_specialization.py"],
         "research/computation/2026_09_02_pell_hensel_specialization", 300,
         "research/computation/2026_09_02_pell_hensel_specialization/verifier_stdout.txt"),
        ("evidence-pell-search", [python, "search_index3_moving_squarefull.py"],
         "research/computation/2026_09_02_pell_hensel_specialization", 600,
         "research/computation/2026_09_02_pell_hensel_specialization/index3_search_stdout.txt"),
        ("evidence-quadratic-producer",
         [python, "quadratic_veronese_peeling_scan.py", "--output", "scan_results.json"],
         "research/computation/quadratic_veronese_peeling_2026_09_02", 600, None),
        ("evidence-quadratic-verifier", [python, "verify_quadratic_veronese_peeling.py"],
         "research/computation/quadratic_veronese_peeling_2026_09_02", 300, None),
    )
    for name, command, cwd_relative, timeout, frozen_stdout in remaining_evidence:
        command_records.append(run_logged(
            name, command, repo_path(cwd_relative), log_root, timeout,
        ))
        if frozen_stdout is not None:
            stdout_audit.append(require_normalized_stdout_match(
                log_root, name, frozen_stdout,
            ))

    # Every replayed producer must reproduce the frozen bytes exactly.
    verify_prepared()
    hash_summary = verify_hash_manifests()
    text_summary = verify_text_inputs()
    git_check = run_logged("git-diff-check", ["git", "diff", "--check"],
                           REPO_ROOT, log_root, 120)
    command_records.append(git_check)

    return {
        "schema": VALIDATION_SCHEMA,
        "status": "PASS",
        "scope": {
            "provesStandardABC": False,
            "disprovesStandardABC": False,
            "finiteSearchUpgradedToAsymptotic": False,
            "paperOnlyBridgeCountedAsLean": False,
        },
        "inventoryTotals": inventory["totals"],
        "moduleCount": len(MODULES),
        "axiomAudit": axiom_summary,
        "aggregateBuildJobs": aggregate_jobs,
        "hashManifests": hash_summary,
        "textAudit": text_summary,
        "stdoutAudit": {
            "normalization": "strict UTF-8 with CRLF/CR mapped to LF",
            "comparisons": stdout_audit,
        },
        "commands": command_records,
    }


def seal_package() -> None:
    rows = []
    seal_path = (PACKAGE_ROOT / SEAL_FILE).resolve()
    for path in sorted(PACKAGE_ROOT.rglob("*")):
        if (not path.is_file() or path.resolve() == seal_path or
                path.suffix.lower() == ".pyc" or "__pycache__" in path.parts):
            continue
        rows.append(f"{sha256(path)}  {path.relative_to(PACKAGE_ROOT).as_posix()}")
    write_text(PACKAGE_ROOT / SEAL_FILE, "\n".join(rows) + "\n")


def verify_seal() -> dict[str, Any]:
    manifest = PACKAGE_ROOT / SEAL_FILE
    if not manifest.is_file():
        raise RuntimeError("validation-package seal is missing")
    lines = manifest.read_bytes().decode("utf-8").splitlines()
    if not lines or any(not line for line in lines):
        raise RuntimeError("validation-package seal contains a blank line")
    recorded_rows: list[tuple[str, str]] = []
    for line_number, line in enumerate(lines, 1):
        match = re.fullmatch(r"([0-9a-f]{64})  ([^\r\n]+)", line)
        if not match:
            raise RuntimeError(f"malformed validation-package seal line {line_number}")
        digest, relative = match.groups()
        pure = PurePosixPath(relative)
        if (
            pure.is_absolute() or relative != pure.as_posix()
            or any(part in {"", ".", ".."} for part in pure.parts)
            or relative == SEAL_FILE
        ):
            raise RuntimeError(f"noncanonical validation-package seal path: {relative}")
        recorded_rows.append((digest, relative))
    recorded_paths = [relative for _, relative in recorded_rows]
    duplicates = sorted(
        relative for relative, count in Counter(recorded_paths).items() if count != 1
    )
    if duplicates:
        raise RuntimeError(f"duplicate validation-package seal paths: {duplicates}")
    for digest, relative in recorded_rows:
        path = PACKAGE_ROOT.joinpath(*PurePosixPath(relative).parts).resolve()
        path.relative_to(PACKAGE_ROOT.resolve())
        if not path.is_file():
            raise RuntimeError(f"missing validation-package file: {relative}")
        if sha256(path) != digest:
            raise RuntimeError(f"validation-package seal mismatch: {relative}")
    seal_path = manifest.resolve()
    actual = {
        path.relative_to(PACKAGE_ROOT).as_posix()
        for path in PACKAGE_ROOT.rglob("*")
        if (path.is_file() and path.resolve() != seal_path and
            path.suffix.lower() != ".pyc" and "__pycache__" not in path.parts)
    }
    recorded = set(recorded_paths)
    if actual != recorded:
        missing = sorted(actual - recorded)
        extra = sorted(recorded - actual)
        raise RuntimeError(
            f"validation-package seal file set mismatch; missing={missing}, extra={extra}"
        )
    return {"entries": len(recorded_rows), "sha256": sha256(manifest)}


def stable_validation_view(result: dict[str, Any]) -> dict[str, Any]:
    fields = (
        "schema", "status", "scope", "inventoryTotals", "moduleCount",
        "axiomAudit", "aggregateBuildJobs", "hashManifests", "textAudit",
        "stdoutAudit",
    )
    view = {field: result.get(field) for field in fields}
    commands = result.get("commands")
    if not isinstance(commands, list):
        raise RuntimeError("validation result has no command list")
    view["commands"] = [
        {"name": row.get("name"), "exitCode": row.get("exitCode")}
        for row in commands if isinstance(row, dict)
    ]
    if len(view["commands"]) != len(commands):
        raise RuntimeError("validation command list contains a non-object")
    return view


def load_recorded_validation() -> dict[str, Any]:
    path = PACKAGE_ROOT / VALIDATION_FILE
    try:
        result = json.loads(path.read_bytes().decode("utf-8"))
    except (OSError, UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise RuntimeError("sealed validation-run.json is unreadable") from exc
    if not isinstance(result, dict):
        raise RuntimeError("sealed validation-run.json is not an object")
    if result.get("schema") != VALIDATION_SCHEMA or result.get("status") != "PASS":
        raise RuntimeError("sealed validation-run.json has invalid schema or status")
    stable_validation_view(result)
    return result


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--prepare", action="store_true")
    parser.add_argument("--record", action="store_true")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    if sum((args.prepare, args.record, args.check)) != 1:
        parser.error("choose exactly one of --prepare, --record, --check")

    PACKAGE_ROOT.mkdir(parents=True, exist_ok=True)
    if args.prepare:
        summary = prepare()
        print(json.dumps(summary["totals"], indent=2))
        return
    if args.record:
        (PACKAGE_ROOT / SEAL_FILE).unlink(missing_ok=True)
        (PACKAGE_ROOT / VALIDATION_FILE).unlink(missing_ok=True)
        prepare()
        result = validate(PACKAGE_ROOT / "logs")
        write_text(PACKAGE_ROOT / VALIDATION_FILE,
                   json.dumps(result, indent=2, ensure_ascii=False) + "\n")
        seal_package()
        print(json.dumps(result, indent=2, ensure_ascii=False))
        return

    seal = verify_seal()
    recorded = load_recorded_validation()
    result = validate(LIVE_ROOT / "logs")
    recorded_view = stable_validation_view(recorded)
    live_view = stable_validation_view(result)
    if recorded_view != live_view:
        raise RuntimeError("live validation differs from sealed stable validation fields")
    result["recordComparison"] = {
        "status": "PASS",
        "stableFields": sorted(recorded_view),
    }
    result["packageSeal"] = seal
    print(json.dumps(result, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()
