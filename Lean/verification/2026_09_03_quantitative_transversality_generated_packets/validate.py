#!/usr/bin/env python3
"""Seal and replay the 2026-09-03 five-route abc checkpoint.

The validator inventories every named declaration in the five checkpoint
modules, rejects proof escapes and custom opaque declarations, generates one
``#print axioms`` command per declaration, directly compiles both each module
and its hand-written audit with warnings as errors, rebuilds the umbrella
target, replays every designated source/computation capsule, and freezes exact
input hashes.  It does not assert the abc conjecture or its negation.
"""

from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import json
import os
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
    "MersenneFareyQuantitativeSwarm20260903",
    "AlternativeQualityPackingBridge20260903",
    "PellFixedTwoTransversality20260903",
    "SteinbergFiveTermBoundaryBridge20260903",
    "ABCSynchronizedDivisorPackets20260903",
)

REPORTS = (
    "research/ABC_MERSENNE_FAREY_QUANTITATIVE_SWARM_2026_09_03.md",
    "research/ABC_ALTERNATIVE_QUALITY_PACKING_AUDIT_2026_09_03.md",
    "research/ABC_PELL_FIXED_TWO_TRANSVERSALITY_2026_09_03.md",
    "research/ABC_STEINBERG_FIVE_TERM_BOUNDARY_BRIDGE_2026_09_03.md",
    "research/ABC_SYNCHRONIZED_DIVISOR_PACKET_SPECTRUM_2026_09_03.md",
    "research/ABC_MULTI_ROUTE_QUANTITATIVE_TRANSVERSALITY_GENERATED_PACKETS_2026_09_03.md",
    "research/ABC_FIVE_ROUTE_ADVERSARIAL_REVIEW_2026_09_02.md",
    "research/ABC_STEINBERG_VALUATION_CONTACT_SURFACE_2026_09_02.md",
)

PAPER_FILES = (
    "paper/ChatGPT_ABC_Uniformity_2026.tex",
    "paper/mersenne_farey_quantitative_swarm_2026.tex",
    "paper/alternative_quality_packing_audit_2026.tex",
    "paper/pell_fixed_two_transversality_2026.tex",
    "paper/steinberg_five_term_boundary_bridge_2026.tex",
    "paper/steinberg_five_term_boundary_bridge_2026_bibitems.tex",
    "paper/abc_synchronized_divisor_packets_2026.tex",
    "paper/steinberg_valuation_contact_surface_2026.tex",
    "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf",
)

INPUT_DIRECTORIES = (
    "research/computation/2026_09_03_root_route_cross_audit",
    "research/computation/2026_09_03_fixed_pell_transversality",
    "research/computation/2026_09_03_steinberg_five_term_boundary_bridge",
    "research/computation/2026_09_03_synchronized_divisor_packets",
    "research/sources/alternative_quality_metrics_2026_09_03",
    "research/verification/2026_09_03_synchronized_divisor_packets",
    "output/pdf/ChatGPT_ABC_Quantitative_Transversality_Generated_Packets_2026_09_03_QA",
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
VALIDATION_SCHEMA = "abc-quantitative-transversality-generated-packets-validation-v1"
EXPECTED_AGGREGATE_JOBS = 9265

EXPECTED_MODULE_COUNTS = {
    "MersenneFareyQuantitativeSwarm20260903": {
        "theorem": 17, "lemma": 0, "def": 3, "abbrev": 0,
        "structure": 0, "class": 0, "inductive": 0, "instance": 0,
    },
    "AlternativeQualityPackingBridge20260903": {
        "theorem": 9, "lemma": 0, "def": 4, "abbrev": 0,
        "structure": 0, "class": 0, "inductive": 0, "instance": 0,
    },
    "PellFixedTwoTransversality20260903": {
        "theorem": 25, "lemma": 0, "def": 6, "abbrev": 0,
        "structure": 0, "class": 0, "inductive": 0, "instance": 0,
    },
    "SteinbergFiveTermBoundaryBridge20260903": {
        "theorem": 66, "lemma": 0, "def": 41, "abbrev": 1,
        "structure": 5, "class": 0, "inductive": 0, "instance": 0,
    },
    "ABCSynchronizedDivisorPackets20260903": {
        "theorem": 52, "lemma": 0, "def": 25, "abbrev": 0,
        "structure": 2, "class": 0, "inductive": 0, "instance": 2,
    },
}

EXPECTED_INVENTORY_TOTALS = {
    "theorem": 169, "lemma": 0, "def": 79, "abbrev": 1,
    "structure": 7, "class": 0, "inductive": 0, "instance": 2,
    "countedDeclarations": 258, "proofDeclarations": 169,
    "auditedDeclarations": 258,
}

REQUIRED_DECLARATIONS = {
    "IUTThreeClosures.MersenneFareyQuantitativeSwarm20260903.quantitativeSwarm_count_lower",
    "IUTThreeClosures.MersenneFareyQuantitativeSwarm20260903.not_isLittleO_iff_exists_frequently_gt",
    "IUTThreeClosures.AlternativeQualityPackingBridge20260903.packing_bound_iff",
    "IUTThreeClosures.AlternativeQualityPackingBridge20260903.exists_unboundedDGM_constantStandard",
    "IUTThreeClosures.PellFixedTwoTransversality20260903.fixed_two_squarefull_iff_all_zero_displacements",
    "IUTThreeClosures.PellFixedTwoTransversality20260903.fixed_zero_displacement_exclusion_iff_squarefull_exclusion",
    "IUTThreeClosures.PellFixedTwoTransversality20260903.index_seven_fibonacci_zero_displacement",
    "IUTThreeClosures.SteinbergFiveTermBoundaryBridge20260903.fiveTermRelation_le_ker",
    "IUTThreeClosures.SteinbergFiveTermBoundaryBridge20260903.positiveFiveTermRelation_le_ker",
    "IUTThreeClosures.ABCSynchronizedDivisorPackets20260903.standardQuality",
    "IUTThreeClosures.ABCSynchronizedDivisorPackets20260903.packetEnergy",
    "IUTThreeClosures.ABCSynchronizedDivisorPackets20260903.minimumPacketEnergy",
    "IUTThreeClosures.ABCSynchronizedDivisorPackets20260903.standardQuality_le_packetEnergy",
    "IUTThreeClosures.ABCSynchronizedDivisorPackets20260903.standardQuality_le_minimumPacketEnergy",
    "IUTThreeClosures.ABCSynchronizedDivisorPackets20260903.cornerCounterexamplePacket_ne_full",
    "IUTThreeClosures.ABCSynchronizedDivisorPackets20260903.cubicCounterexamplePacket_fails_height_pow_three",
    "IUTThreeClosures.ABCSynchronizedDivisorPackets20260903.quarticCounterexamplePacket_fails_height_pow_four",
    "IUTThreeClosures.ABCSynchronizedDivisorPackets20260903.quarticCounterexamplePacket_fails_coordinateProduct_sq",
    "IUTThreeClosures.ABCSynchronizedDivisorPackets20260903.quinticCounterexamplePacket_fails_height_pow_five",
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
    r"\b(?P<kind>axiom|axioms|opaque|unsafe|partial|extern)\b"
)
ALL_DECLARATION_TOKEN_RE = re.compile(
    r"\b(?P<kind>theorem|lemma|def|abbrev|structure|class|inductive|instance)\b"
)
UNSUPPORTED_DECLARATION_RE = re.compile(
    r"(?m)^[ \t]*(?:(?:private|protected|noncomputable)[ \t]+)*(?P<form>"
    r"nonrec[ \t]+(?:theorem|lemma|def|abbrev|structure|class|inductive|instance)"
    r"|irreducible_def\b|scoped[ \t]+instance\b|deriving[ \t]+instance\b"
    r"|local[ \t]+instance\b|example\b|mutual\b|elab\b|elab_rules\b"
    r"|macro\b|macro_rules\b|syntax\b|syntax_cat\b|run_tac\b|initialize\b"
    r"|set_option\b|(?:open|omit|include|attribute)\b[^\r\n]*\bin\b)"
)
SCOPE_RE = re.compile(
    r"(?m)^[ \t]*(namespace[ \t]+([^\s]+)|(?:noncomputable[ \t]+)?section(?:[ \t]+[^\s]+)?|end(?:[ \t]+[^\s]+)?)[ \t]*$"
)

SCANNER_REGRESSION_FIXTURES = (
    "axiom directAx : False\n",
    "set_option autoImplicit false in axiom wrappedAx : False\n",
    "set_option autoImplicit false in theorem wrappedTheorem : True := True.intro\n",
    "open Nat in axiom openWrappedAx : False\n",
    "omit x in axiom omittedAx : False\n",
    "include x in axiom includedAx : False\n",
    "variable (x : Nat) in axiom variableWrappedAx : False\n",
)


def verify_scanner_regressions() -> None:
    for fixture in SCANNER_REGRESSION_FIXTURES:
        clean = strip_attributes(strip_lean_comments_and_strings(fixture))
        direct = Counter(match.group("kind") for match in DECLARATION_RE.finditer(clean))
        tokens = Counter(
            match.group("kind") for match in ALL_DECLARATION_TOKEN_RE.finditer(clean)
        )
        if (
            FORBIDDEN_RE.search(clean) is None
            and UNSUPPORTED_DECLARATION_RE.search(clean) is None
            and direct == tokens
        ):
            raise RuntimeError(f"Lean declaration scanner regression: {fixture.strip()}")


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
    forbidden_clean = re.sub(
        r"(?m)^[ \t]*#print[ \t]+axioms\b[^\r\n]*",
        lambda match: " " * len(match.group(0)),
        clean,
    )

    forbidden = [
        token for token in ("sorry", "admit", "native_decide", "sorryAx")
        if re.search(rf"\b{re.escape(token)}\b", forbidden_clean)
    ]
    forbidden.extend(match.group("kind") for match in FORBIDDEN_RE.finditer(forbidden_clean))
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
    token_counts = {kind: 0 for kind in DECLARATION_KINDS}
    for match in ALL_DECLARATION_TOKEN_RE.finditer(clean):
        token_counts[match.group("kind")] += 1
    if token_counts != counts:
        raise RuntimeError(
            f"wrapped or unscanned declaration keyword in {module}: "
            f"lineStart={counts}, allTokens={token_counts}"
        )
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
    verify_scanner_regressions()
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
    actual_names = {
        declaration["name"]
        for row in rows for declaration in row["auditedDeclarations"]
    }
    missing_required = sorted(REQUIRED_DECLARATIONS - actual_names)
    if missing_required:
        raise RuntimeError(
            "required route-boundary declarations are missing: "
            + ", ".join(missing_required)
        )
    return summary


def audit_text(rows: list[dict[str, Any]]) -> str:
    lines = [
        "/- Generated by validate.py; do not edit. -/",
        *(f"import IUTThreeClosures.{module}" for module in MODULES),
        "",
        "/- One command for every named declaration in the five source modules. -/",
    ]
    for row in rows:
        for declaration in row["auditedDeclarations"]:
            if declaration["kind"] in AUDITED_KINDS:
                lines.append(f"#print axioms {declaration['name']}")
    lines.extend([
        "",
        "/- Type-level contracts for the two most scope-sensitive bridges. -/",
        "example :",
        "    IUTThreeClosures.SteinbergFiveTermBoundaryBridge20260903.fiveTermRelation ≤",
        "      LinearMap.ker",
        "        IUTThreeClosures.SteinbergFiveTermBoundaryBridge20260903.chainBoundary :=",
        "  IUTThreeClosures.SteinbergFiveTermBoundaryBridge20260903.fiveTermRelation_le_ker",
        "",
        "example :",
        "    IUTThreeClosures.SteinbergFiveTermBoundaryBridge20260903.positiveFiveTermRelation ≤",
        "      LinearMap.ker",
        "        IUTThreeClosures.SteinbergFiveTermBoundaryBridge20260903.chainBoundary :=",
        "  IUTThreeClosures.SteinbergFiveTermBoundaryBridge20260903.positiveFiveTermRelation_le_ker",
        "",
        "namespace IUTThreeClosures.ABCSynchronizedDivisorPackets20260903",
        "",
        "example (P : PrimitiveABC) :",
        "    standardQuality P = Real.log P.c / Real.log (abcRadical P) := rfl",
        "",
        "example {P : PrimitiveABC} (Q : SynchronizedPacket P) :",
        "    packetEnergy Q =",
        "      Real.log Q.pairMaxBound / Real.log (abcRadical P) := rfl",
        "",
        "example (P : PrimitiveABC) :",
        "    minimumPacketEnergy P =",
        "      Finset.univ.inf' Finset.univ_nonempty (packetEnergy (P := P)) := rfl",
        "",
        "example (P : PrimitiveABC) :",
        "    standardQuality P ≤ minimumPacketEnergy P :=",
        "  standardQuality_le_minimumPacketEnergy P",
        "",
        "end IUTThreeClosures.ABCSynchronizedDivisorPackets20260903",
    ])
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
    # Reject any nonignored, untracked Lean source outside the explicit
    # checkpoint inputs. Such a file could be imported by the umbrella while
    # escaping the tracked-source closure above. The generated audit in this
    # package is a sealed output and is handled separately.
    untracked = subprocess.run(
        ["git", "ls-files", "--others", "--exclude-standard", "-z", "--", "Lean"],
        cwd=REPO_ROOT, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True,
    ).stdout.decode("utf-8")
    explicit_lean = {
        PurePosixPath(relative).as_posix()
        for relative in FIXED_INPUTS if relative.endswith(".lean")
    }
    package_relative = PACKAGE_ROOT.relative_to(REPO_ROOT).as_posix() + "/"
    unexpected_untracked: list[str] = []
    for relative in untracked.split("\0"):
        if not relative or not relative.endswith(".lean"):
            continue
        normalized = PurePosixPath(relative).as_posix()
        if normalized.startswith(package_relative):
            continue
        if normalized in explicit_lean:
            path = repo_path(normalized)
            if not path.is_file():
                raise RuntimeError(f"explicit untracked Lean source is missing: {normalized}")
            paths.add(path.resolve())
        else:
            unexpected_untracked.append(normalized)
    if unexpected_untracked:
        raise RuntimeError(
            "unexpected nonignored untracked Lean sources: "
            + ", ".join(sorted(unexpected_untracked))
        )
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
    environment = os.environ.copy()
    environment["PYTHONUTF8"] = "1"
    environment["PYTHONIOENCODING"] = "utf-8"
    result = subprocess.run(
        command, cwd=cwd, text=True, encoding="utf-8", errors="strict",
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=timeout,
        env=environment,
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
    return path.read_bytes().decode("utf-8-sig").replace("\r\n", "\n").replace("\r", "\n")


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


def require_json_stdout_match(
    log_root: Path, log_name: str, frozen_relative: str,
) -> tuple[dict[str, Any], dict[str, Any]]:
    """Compare JSON stdout semantically, tolerating a BOM and host newlines."""
    live_path = log_root / f"{log_name}.log"
    frozen_path = repo_path(frozen_relative)
    live = json.loads(normalized_utf8(live_path))
    frozen = json.loads(normalized_utf8(frozen_path))
    if not isinstance(live, dict) or not isinstance(frozen, dict):
        raise RuntimeError(f"JSON stdout is not an object: {log_name}")
    if live != frozen:
        raise RuntimeError(
            f"semantic JSON stdout mismatch: {log_name} != {frozen_relative}"
        )
    return live, {
        "command": log_name,
        "frozen": frozen_relative,
        "comparison": "semantic JSON equality after strict UTF-8-sig decoding",
        "canonicalSha256": hashlib.sha256(
            json.dumps(live, sort_keys=True, separators=(",", ":"), ensure_ascii=False)
            .encode("utf-8")
        ).hexdigest(),
    }


def snapshot_files(paths: Iterable[Path]) -> dict[str, str]:
    """Hash a fixed set before a producer overwrites its declared outputs."""
    return {
        path.resolve().relative_to(REPO_ROOT.resolve()).as_posix(): sha256(path)
        for path in paths
    }


def require_snapshot_unchanged(snapshot: dict[str, str]) -> None:
    changed = []
    for relative, expected in snapshot.items():
        path = repo_path(relative)
        if not path.is_file() or sha256(path) != expected:
            changed.append(relative)
    if changed:
        raise RuntimeError("producer changed frozen output bytes: " + ", ".join(changed))


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
        path for root in roots for pattern in (
            "SHA256SUMS", "SHA256SUMS.txt", "INPUT_SHA256SUMS.txt", "manifest.sha256",
        )
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
            raw_target = PurePosixPath(match.group(2))
            if raw_target.is_absolute() or ".." in raw_target.parts:
                raise RuntimeError(f"unsafe hash target {manifest}:{line_number}")
            # Evidence archives use both local names and repository-rooted
            # names.  The latter always start at an explicit top-level tree.
            local_target = manifest.parent.joinpath(*raw_target.parts).resolve()
            if local_target.is_file():
                target = local_target
            elif raw_target.parts and raw_target.parts[0] in {
                "Lean", "paper", "research", "output",
            }:
                target = REPO_ROOT.joinpath(*raw_target.parts).resolve()
            else:
                target = local_target
            target.relative_to(REPO_ROOT.resolve())
            if not target.is_file():
                raise RuntimeError(f"missing hashed file: {target}")
            actual = sha256(target)
            if actual.lower() != match.group(1).lower():
                raise RuntimeError(f"hash mismatch: {target}")
            checked += 1
    return {
        "manifests": len(manifests),
        "entries": checked,
        "paths": [path.relative_to(REPO_ROOT).as_posix() for path in manifests],
    }


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
        "ChatGPT_ABC_Quantitative_Transversality_Generated_Packets_2026_09_03_QA"
    )
    # Generated inventory, audit, validation, metrics, and seal files appear at
    # different phases of record/check.  Keep this set explicit so the text
    # audit is phase-independent and its "authored" label remains truthful.
    authored_paths.update({
        (PACKAGE_ROOT / "README.md").resolve(),
        (PACKAGE_ROOT / "validate.py").resolve(),
        (PACKAGE_ROOT / "validate.ps1").resolve(),
    })
    authored_paths.update({
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


def verify_pdf_qa() -> dict[str, Any]:
    pdf = repo_path("output/pdf/ChatGPT_ABC_Uniformity_2026.pdf")
    qa_root = repo_path(
        "output/pdf/"
        "ChatGPT_ABC_Quantitative_Transversality_Generated_Packets_2026_09_03_QA"
    )
    metrics_path = qa_root / "qa_metrics.json"
    if not pdf.read_bytes().startswith(b"%PDF-"):
        raise RuntimeError("final paper does not have a PDF header")
    metrics = json.loads(metrics_path.read_bytes().decode("utf-8-sig"))
    if not isinstance(metrics, dict) or metrics.get("status") != "PASS":
        raise RuntimeError("PDF QA metrics do not report PASS")
    paper = metrics.get("pdf")
    render = metrics.get("render")
    text_metrics = metrics.get("text")
    if not all(isinstance(row, dict) for row in (paper, render, text_metrics)):
        raise RuntimeError("PDF QA metrics are missing pdf/render/text objects")
    assert isinstance(paper, dict) and isinstance(render, dict) and isinstance(text_metrics, dict)
    pages = paper.get("pages")
    if (
        paper.get("name") != pdf.name
        or paper.get("bytes") != pdf.stat().st_size
        or paper.get("sha256") != sha256(pdf)
        or paper.get("author") != "ChatGPT"
        or paper.get("encrypted") is not False
        or not isinstance(pages, int)
        or pages <= 0
    ):
        raise RuntimeError("PDF QA identity fields do not match the final artifact")
    if (
        render.get("rasterPages") != pages
        or render.get("blankRasterPages") != []
        or render.get("borderContactPagesAtFourPixels") != []
        or text_metrics.get("lowTextPagesBelow100Characters") != []
    ):
        raise RuntimeError("PDF render/text QA contains an unresolved page defect")
    metric_pages = metrics.get("pages")
    if not isinstance(metric_pages, list) or len(metric_pages) != pages:
        raise RuntimeError("PDF QA page-metric rows do not cover every page")
    widths: set[int] = set()
    heights: set[int] = set()
    for page_number, row in enumerate(metric_pages, 1):
        if not isinstance(row, dict) or row.get("page") != page_number:
            raise RuntimeError("PDF QA page rows are not consecutively numbered")
        pixels = row.get("pixels")
        box = row.get("inkBoundingBox")
        margins = row.get("inkMargins")
        if (
            not isinstance(pixels, list) or len(pixels) != 2
            or not all(isinstance(value, int) and value > 0 for value in pixels)
            or not isinstance(box, list) or len(box) != 4
            or not all(isinstance(value, int) for value in box)
            or not isinstance(margins, dict)
        ):
            raise RuntimeError(f"malformed PDF QA geometry at page {page_number}")
        width, height = pixels
        left, top, right, bottom = box
        expected_margins = {
            "left": left, "top": top,
            "right": width - right, "bottom": height - bottom,
        }
        if (
            not (0 <= left < right <= width and 0 <= top < bottom <= height)
            or margins != expected_margins
            or min(expected_margins.values()) <= 4
        ):
            raise RuntimeError(f"invalid PDF QA ink geometry at page {page_number}")
        widths.add(width)
        heights.add(height)
    if (
        render.get("pixelWidths") != sorted(widths)
        or render.get("pixelHeights") != sorted(heights)
    ):
        raise RuntimeError("PDF QA aggregate raster dimensions disagree with page rows")
    sheets = render.get("contactSheets")
    if not isinstance(sheets, list) or not sheets:
        raise RuntimeError("PDF QA has no contact sheets")
    expected_sheets = [
        f"contact-{first:03d}-{min(first + 15, pages):03d}.png"
        for first in range(1, pages + 1, 16)
    ]
    if sheets != expected_sheets:
        raise RuntimeError("PDF QA contact-sheet ranges do not exactly cover all pages")
    missing_sheets = [name for name in sheets if not isinstance(name, str) or not (qa_root / name).is_file()]
    if missing_sheets:
        raise RuntimeError(f"PDF QA contact sheets are missing: {missing_sheets}")
    target_pages = text_metrics.get("targetPages")
    required_metric_targets = (
        "quantitative swarm",
        "alternative quality metrics",
        "synchronized divisor packets",
        "formal verification and remaining obligations",
        "258 counted declarations",
    )
    if (
        not isinstance(target_pages, dict)
        or any(not target_pages.get(target) for target in required_metric_targets)
    ):
        raise RuntimeError("PDF QA content-target index is missing a checkpoint anchor")

    try:
        from pypdf import PdfReader
    except ImportError as exc:
        raise RuntimeError("pypdf is required to independently inspect the final PDF") from exc
    reader = PdfReader(pdf)
    if len(reader.pages) != pages or reader.is_encrypted:
        raise RuntimeError("independent PDF reader disagrees with QA identity fields")
    extracted = [page.extract_text() or "" for page in reader.pages]
    independent_low_text = [
        index for index, value in enumerate(extracted, 1) if len(value.strip()) < 100
    ]
    joined_text = "\n".join(extracted)
    if (
        independent_low_text
        or text_metrics.get("totalCharacters") != sum(len(value) for value in extracted)
        or "qquad" in joined_text
        or "??" in joined_text
        or "\ufffd" in joined_text
    ):
        raise RuntimeError(
            "independent PDF text audit found a low-text page or malformed token"
        )
    metadata = reader.metadata or {}
    if str(metadata.get("/Author", "")) != "ChatGPT":
        raise RuntimeError("independent PDF metadata does not identify ChatGPT as author")
    compact_pages = [re.sub(r"\s+", "", value.casefold()) for value in extracted]
    anchors = (
        "quantitativeswarm",
        "alternativequalitymetrics",
        "pellfixedtwotransversality20260903",
        "steinbergfivetermboundarybridge20260903",
        "synchronizeddivisorpackets",
        "minimumpacketenergy",
        "258counteddeclarations",
    )
    anchor_pages = {
        anchor: [
            index for index, value in enumerate(compact_pages, 1) if anchor in value
        ]
        for anchor in anchors
    }
    if any(not found for found in anchor_pages.values()):
        raise RuntimeError(f"final PDF is missing a checkpoint text anchor: {anchor_pages}")

    final_log = (qa_root / "final-tectonic.log").read_bytes().decode("utf-8-sig")
    diagnostic_pattern = re.compile(
        r"(?im)LaTeX Warning:|Package .+ Warning:|Overfull \\hbox|"
        r"Underfull \\hbox|undefined (?:references|citations)|Rerun to get|^! "
    )
    if diagnostic_pattern.search(final_log):
        raise RuntimeError("final converged TeX log still contains a diagnostic")

    qa_manifest = qa_root / "SHA256SUMS"
    manifest_names: set[str] = set()
    for line_number, line in enumerate(qa_manifest.read_text(encoding="utf-8").splitlines(), 1):
        match = re.fullmatch(r"[0-9a-f]{64}  ([^/\\]+)", line)
        if match is None:
            raise RuntimeError(f"malformed PDF QA manifest line {line_number}")
        manifest_names.add(match.group(1))
    actual_names = {
        path.name for path in qa_root.iterdir()
        if path.is_file() and path.name != qa_manifest.name
    }
    if manifest_names != actual_names:
        raise RuntimeError(
            "PDF QA manifest file-set mismatch; missing="
            f"{sorted(actual_names - manifest_names)}, extra={sorted(manifest_names - actual_names)}"
        )
    return {
        "status": "PASS",
        "pdfSha256": sha256(pdf),
        "pdfBytes": pdf.stat().st_size,
        "pages": pages,
        "rasterPages": render["rasterPages"],
        "contactSheets": len(sheets),
        "blankRasterPages": 0,
        "borderContactPages": 0,
        "lowTextPages": 0,
        "contentAnchorPages": anchor_pages,
        "finalTeXDiagnostics": 0,
        "qaManifestFiles": len(manifest_names),
    }


def require_pass(payload: dict[str, Any], label: str) -> None:
    if payload.get("status") != "PASS":
        raise RuntimeError(f"{label} did not report semantic PASS")


def verify_pell_payload(search: dict[str, Any], verification: dict[str, Any]) -> dict[str, Any]:
    counts = search.get("counts")
    repeated = search.get("repeated_hits")
    decisions = search.get("logical_decisions")
    if not isinstance(counts, dict) or not isinstance(repeated, list) or not isinstance(decisions, dict):
        raise RuntimeError("Pell search payload is malformed")
    witness = {"index": 7, "prime": 13, "channel": "B", "valuation": "exactly_2"}
    if (
        search.get("schema") != "fixed-two-pell-transversality-search-v1"
        or search.get("parameters") != {
            "max_prime_index": 20_000,
            "support_prime_bound": 10_000_000,
        }
        or counts.get("candidate_prime_tests") != 3_091_963
        or counts.get("repeated_hits") != 1
        or counts.get("depth_at_least_3_hits") != 0
        or counts.get("opposite_channel_repeated_indices") != 0
        or repeated != [witness]
        or decisions.get("fixed_all_support_zero_exclusion", {}).get("status") != "OPEN"
    ):
        raise RuntimeError("Pell finite evidence lost a fixed premise/count boundary")
    require_pass(verification, "Pell independent verification")
    if verification.get("verified_counts") != counts or verification.get("errors") != []:
        raise RuntimeError("Pell independent verification counts do not match the producer")
    return {
        "candidatePrimeTests": counts["candidate_prime_tests"],
        "repeatedHits": counts["repeated_hits"],
        "depthAtLeast3Hits": counts["depth_at_least_3_hits"],
        "oppositeChannelRepeatedIndices": counts["opposite_channel_repeated_indices"],
        "individualZeroDisplacementWitness": witness,
        "globalSquarefullExclusion": "OPEN",
    }


def verify_synchronized_payload(payload: dict[str, Any]) -> dict[str, Any]:
    audit = payload.get("candidate_audit")
    family = payload.get("explicit_family")
    if not isinstance(audit, dict) or not isinstance(family, dict):
        raise RuntimeError("synchronized-packet payload is malformed")
    expected_parameters = {
        "limit": 5000,
        "exhaustive": 1000,
        "top_quality": 200,
        "quality_threshold": 1.0,
        "family_limit": 100000,
    }
    witnesses = {
        "corner": ([3, 5, 8], [3, 5, 2]),
        "cubic": ([5, 7, 12], [5, 7, 2]),
        "quartic": ([5, 16, 21], [5, 2, 3]),
        "productSquare": ([5, 16, 21], [5, 2, 3]),
        "quintic": ([385, 527, 912], [7, 31, 24]),
    }
    rows = {
        "corner": audit.get("corner_uniqueness_first_counterexample"),
        "cubic": audit.get("cubic_bound_first_counterexample"),
        "quartic": audit.get("quartic_bound_first_counterexample"),
        "productSquare": audit.get("product_square_bound_first_counterexample"),
        "quintic": payload.get("worst_observed_max_power_needed"),
    }
    if (
        payload.get("parameters") != expected_parameters
        or payload.get("primitive_triples_scanned") != 3_795_230
        or payload.get("triples_packet_enumerated") != 151_244
        or payload.get("packets_found") != 151_711
        or payload.get("proper_packets_found") != 467
        or payload.get("exact_gap_packet_count") != 105
        or audit.get("canonical_orientation_rigidity_first_counterexample") is not None
        or audit.get("proved_pair_max_and_sixth_power_bounds_checked") is not True
        or family.get("checked_t_range") != [2, 100000]
        or family.get("first_failure") is not None
    ):
        raise RuntimeError("synchronized-packet finite evidence changed its frozen scope")
    for label, (abc, packet) in witnesses.items():
        row = rows[label]
        if not isinstance(row, dict) or row.get("abc") != abc or row.get("packet") != packet:
            raise RuntimeError(f"missing full-premise synchronized-packet witness: {label}")
    quintic = rows["quintic"]
    assert isinstance(quintic, dict)
    if (
        quintic.get("proper") is not True
        or quintic.get("gap_product_quotient") != 1
        or 385 * 527 * 912 <= max(7, 31, 24) ** 5
    ):
        raise RuntimeError("constant-one quintic counterexample lost a full premise")
    spectrum = payload.get("same_prime_support_different_packet_spectrum")
    expected_spectrum = [
        {"abc": [2, 3, 5], "radical": 30, "packet_count": 1, "proper_packet_count": 0},
        {"abc": [3, 5, 8], "radical": 30, "packet_count": 2, "proper_packet_count": 1},
    ]
    if spectrum != expected_spectrum:
        raise RuntimeError("same-support packet-spectrum witness is missing")
    return {
        "primitiveTriples": payload["primitive_triples_scanned"],
        "enumeratedFibres": payload["triples_packet_enumerated"],
        "packets": payload["packets_found"],
        "properPackets": payload["proper_packets_found"],
        "exactGapPackets": payload["exact_gap_packet_count"],
        "counterexampleWitnesses": witnesses,
        "canonicalOrientationFiniteFailure": None,
        "familyFirstFailure": None,
        "finiteEvidenceUpgradedToAsymptotic": False,
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
    if EXPECTED_AGGREGATE_JOBS <= 0:
        raise RuntimeError(
            "EXPECTED_AGGREGATE_JOBS is uncalibrated; freeze the stable job count before Record"
        )
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
        command_records.append(run_logged(
            f"lean-{module}-handwritten-audit",
            [lake, "env", "lean", "-DwarningAsError=true",
             f"IUTThreeClosures/{module}AxiomAudit.lean"],
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
    evidence_summary: dict[str, Any] = {}

    source_root = repo_path("research/sources/alternative_quality_metrics_2026_09_03")
    command_records.append(run_logged(
        "evidence-alternative-source", [python, "verify_source.py"],
        source_root, log_root, 300,
    ))
    source_payload, source_comparison = require_json_stdout_match(
        log_root, "evidence-alternative-source",
        "research/sources/alternative_quality_metrics_2026_09_03/verification_output.json",
    )
    require_pass(source_payload, "alternative-quality source capsule")
    stdout_audit.append(source_comparison)
    evidence_summary["alternativeQualitySource"] = {
        "status": source_payload["status"],
        "arxiv": source_payload.get("arxiv"),
        "declaredPages": source_payload.get("declaredPages"),
    }

    cross_root = repo_path("research/computation/2026_09_03_root_route_cross_audit")
    command_records.append(run_logged(
        "evidence-root-cross-audit", [python, "verify_cross_audit.py"],
        cross_root, log_root, 600,
    ))
    cross_payload, cross_comparison = require_json_stdout_match(
        log_root, "evidence-root-cross-audit",
        "research/computation/2026_09_03_root_route_cross_audit/cross_audit.json",
    )
    require_pass(cross_payload, "root-route cross-audit")
    if cross_payload.get("critical_errors") != []:
        raise RuntimeError("root-route cross-audit retained critical errors")
    stdout_audit.append(cross_comparison)
    evidence_summary["rootRouteCrossAudit"] = {
        "status": cross_payload["status"],
        "criticalErrors": [],
        "finiteBoundary": cross_payload.get("finite_boundary"),
    }

    pell_root = repo_path("research/computation/2026_09_03_fixed_pell_transversality")
    pell_outputs = snapshot_files([
        pell_root / "fixed_two_search.json",
        pell_root / "fixed_two_verification.json",
    ])
    command_records.append(run_logged(
        "evidence-pell-producer", [python, "produce_fixed_two_search.py"],
        pell_root, log_root, 3600,
    ))
    stdout_audit.append(require_normalized_stdout_match(
        log_root, "evidence-pell-producer",
        "research/computation/2026_09_03_fixed_pell_transversality/producer_stdout.txt",
    ))
    command_records.append(run_logged(
        "evidence-pell-independent-verifier", [python, "verify_fixed_two_search.py"],
        pell_root, log_root, 3600,
    ))
    stdout_audit.append(require_normalized_stdout_match(
        log_root, "evidence-pell-independent-verifier",
        "research/computation/2026_09_03_fixed_pell_transversality/verifier_stdout.txt",
    ))
    require_snapshot_unchanged(pell_outputs)
    pell_search = json.loads((pell_root / "fixed_two_search.json").read_text(encoding="utf-8"))
    pell_verification = json.loads(
        (pell_root / "fixed_two_verification.json").read_text(encoding="utf-8")
    )
    evidence_summary["pellFixedTwo"] = verify_pell_payload(
        pell_search, pell_verification,
    )

    steinberg_root = repo_path(
        "research/computation/2026_09_03_steinberg_five_term_boundary_bridge"
    )
    command_records.append(run_logged(
        "evidence-steinberg-five-term", [python, "validate.py"],
        steinberg_root, log_root, 1800,
    ))
    steinberg_payload, steinberg_comparison = require_json_stdout_match(
        log_root, "evidence-steinberg-five-term",
        "research/computation/2026_09_03_steinberg_five_term_boundary_bridge/validation.json",
    )
    require_pass(steinberg_payload, "Steinberg five-term evidence")
    if steinberg_payload.get("unexpected_axioms") != []:
        raise RuntimeError("Steinberg evidence reports unexpected axioms")
    stdout_audit.append(steinberg_comparison)
    evidence_summary["steinbergFiveTerm"] = {
        "status": steinberg_payload["status"],
        "finiteScanMatchesFrozenJson": steinberg_payload.get(
            "finite_scan_matches_frozen_json"
        ),
        "formalScope": "generated submodule is contained in the boundary kernel",
    }

    synchronized_root = repo_path(
        "research/computation/2026_09_03_synchronized_divisor_packets"
    )
    synchronized_output = synchronized_root / "OUTPUT.json"
    synchronized_snapshot = snapshot_files([synchronized_output])
    command_records.append(run_logged(
        "evidence-synchronized-packets",
        [
            python, "search_synchronized_packets.py",
            "--limit", "5000", "--exhaustive", "1000",
            "--top-quality", "200", "--quality-threshold", "1.0",
            "--family-limit", "100000", "--output", "OUTPUT.json",
        ],
        synchronized_root, log_root, 3600,
    ))
    stdout_audit.append(require_normalized_stdout_match(
        log_root, "evidence-synchronized-packets",
        "research/computation/2026_09_03_synchronized_divisor_packets/RUN.log",
    ))
    require_snapshot_unchanged(synchronized_snapshot)
    synchronized_payload = json.loads(synchronized_output.read_text(encoding="utf-8"))
    evidence_summary["synchronizedDivisorPackets"] = verify_synchronized_payload(
        synchronized_payload
    )

    # Every replayed producer must reproduce the frozen bytes exactly.
    verify_prepared()
    hash_summary = verify_hash_manifests()
    text_summary = verify_text_inputs()
    pdf_qa = verify_pdf_qa()
    git_check = run_logged("git-diff-check", ["git", "diff", "--check"],
                           REPO_ROOT, log_root, 120)
    command_records.append(git_check)
    staged_git_check = run_logged(
        "git-diff-cached-check", ["git", "diff", "--cached", "--check"],
        REPO_ROOT, log_root, 120,
    )
    command_records.append(staged_git_check)

    return {
        "schema": VALIDATION_SCHEMA,
        "status": "PASS",
        "scope": {
            "provesStandardABC": False,
            "disprovesStandardABC": False,
            "finiteSearchUpgradedToAsymptotic": False,
            "paperOnlyBridgeCountedAsLean": False,
            "steinbergGeneratedSubmoduleEqualsBoundaryKernel": False,
            "steinbergGeneratedSubmoduleContainedInBoundaryKernel": True,
            "synchronizedRealLogMinimumQualityBridgeFormalized": True,
        },
        "inventoryTotals": inventory["totals"],
        "moduleCount": len(MODULES),
        "sourceScanner": {
            "regressionFixtures": len(SCANNER_REGRESSION_FIXTURES),
            "wrappedDeclarationTokenBalance": "exact",
            "unexpectedUntrackedLeanSources": 0,
        },
        "axiomAudit": axiom_summary,
        "aggregateBuildJobs": aggregate_jobs,
        "hashManifests": hash_summary,
        "textAudit": text_summary,
        "pdfQA": pdf_qa,
        "evidence": evidence_summary,
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
        "sourceScanner", "axiomAudit", "aggregateBuildJobs", "hashManifests", "textAudit",
        "pdfQA", "evidence", "stdoutAudit",
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
    # Compare the live result in the same data model used by the immutable
    # JSON record.  In particular, Python tuples become JSON arrays on Record
    # and therefore read back as lists on Check.  A strict JSON round-trip
    # preserves every reproducibility field while eliminating that in-memory
    # representation difference; allow_nan=False also rejects non-JSON
    # numeric sentinels before they can enter the stable comparison.
    return json.loads(json.dumps(view, ensure_ascii=False, allow_nan=False))


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
