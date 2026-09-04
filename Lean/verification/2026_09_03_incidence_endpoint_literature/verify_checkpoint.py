#!/usr/bin/env python3
"""Verify the full incidence/endpoint/successor checkpoint evidence."""

from __future__ import annotations

import csv
import hashlib
import json
import math
import os
import re
import sys
from collections import Counter
from pathlib import Path

from pypdf import PdfReader

sys.dont_write_bytecode = True

from checkpoint_scope import (
    CONFIG_RELATIVE_PATHS,
    ENDPOINT,
    ENDPOINT_RELATIVE_PATHS,
    FINAL_PAPER_ARTIFACT_RELATIVE_PATHS,
    FINAL_QA_CONTACT_NAMES,
    HERE,
    LEAN,
    LEAN_MODULE_DIR,
    MODULES,
    PACKAGE_STATIC_NAMES,
    PAPER_MAIN_RELATIVE_PATH,
    PBT,
    PBT_RELATIVE_PATHS,
    REPO,
    RESEARCH_RELATIVE_PATHS,
    STATUS_RELATIVE_PATHS,
    SUCCESSOR,
    SUCCESSOR_RELATIVE_PATHS,
    canonical_relative_path,
    config_paths,
    environment_audit_input_paths,
    expected_manifest_names,
    module_input_paths,
    paper_input_closure,
    relative_name,
    repo_path,
    sha256,
    umbrella_input_paths,
    authored_artifact_paths,
)


ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}
EXPECTED_ENDPOINT_SUMMARY = {
    "triples_scanned": 3_795_230,
    "exact_identity_failures": 0,
    "full_integral_dominance_matching_failures": 113_086,
    "core_le_external_but_integral_matching_fails": 113_027,
    "exact_zero_unmatched_fractional_monotone_flows": 3_792_836,
}
EXPECTED_SUCCESSOR_COUNTS = {
    "actual_primitive_unordered": 218_893,
    "actual_zero_defect_failures": 1_669,
}
EXPECTED_PBT_SUMMARY = {
    "multiple_source_points": 43_340,
    "one_source_points": 362_531,
    "packet_optimum_equals_scalar_positive_part": 1_367_522,
    "positive_fragmentation_gap": 572,
    "positive_optimal_residual": 624,
    "positive_scalar_defect": 57,
    "primitive_triples": 1_368_094,
    "scalar_zero_but_packet_positive": 567,
    "source_free_points": 962_223,
    "zero_optimal_residual": 1_367_470,
}
ENDPOINT_REPLAY = HERE / "endpoint-replay-output.json"
SUCCESSOR_REPLAY = HERE / "successor-replay-output.json"
SUCCESSOR_REPLAY_CSV = HERE / "successor-replay-output.csv"
PBT_REPLAY = HERE / "pbt-replay" / "OUTPUT.json"
PBT_REPLAY_CSV = HERE / "pbt-replay" / "STRUCTURED_FAMILIES.csv"
VERIFICATION_SUMMARY = HERE / "verification_summary.json"
FINAL_PDF = REPO / "output" / "pdf" / "ChatGPT_ABC_Uniformity_2026.pdf"
FINAL_QA = (
    REPO
    / "output"
    / "pdf"
    / "ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA"
)
EXPECTED_PDF_TEXT_TARGETS = {
    "labelled valuation-incidence complex",
    "fixed-budget incidence obstruction",
    "coefficient-one scale-budget obstruction",
    "three-arm incidence covers and complement transport",
    "infinite obstruction to",
    "complement transport implies standard abc",
    "signed endpoint prime-token transport",
    "prime-packet boundary transport",
    "linnik obstruction to exclusive prime packets",
    "shared crt incidence after exclusive packets",
    "primary-literature gate audit",
    "496 public declarations",
    "formal verification and remaining obligations",
    "current boundary and continuing programme",
}


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def read_text(path: Path) -> str:
    require(path.is_file() and not path.is_symlink(), f"missing/symlinked file: {path}")
    return path.read_text(encoding="utf-8")


def atomic_json(path: Path, payload: object) -> None:
    temporary = path.with_name(path.name + ".tmp")
    temporary.write_text(
        json.dumps(payload, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    os.replace(temporary, path)


def strip_lean_comments_and_strings(source: str) -> str:
    """Blank nested comments and literals while preserving line positions."""
    out: list[str] = []
    index = 0
    depth = 0
    line_comment = False
    in_string = False
    escaped = False
    while index < len(source):
        char = source[index]
        nxt = source[index + 1] if index + 1 < len(source) else ""
        if line_comment:
            if char in "\r\n":
                line_comment = False
                out.append(char)
            else:
                out.append(" ")
            index += 1
            continue
        if depth:
            if char == "/" and nxt == "-":
                depth += 1
                out.extend((" ", " "))
                index += 2
            elif char == "-" and nxt == "/":
                depth -= 1
                out.extend((" ", " "))
                index += 2
            else:
                out.append(char if char in "\r\n" else " ")
                index += 1
            continue
        if in_string:
            out.append(char if char in "\r\n" else " ")
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
            out.extend((" ", " "))
            index += 2
            continue
        if char == "/" and nxt == "-":
            depth += 1
            out.extend((" ", " "))
            index += 2
            continue
        if char == "'" and not (
            index > 0 and (source[index - 1].isalnum() or source[index - 1] in "_'")
        ):
            end = index + 1
            char_escaped = False
            found = False
            while end < len(source) and source[end] not in "\r\n":
                if char_escaped:
                    char_escaped = False
                elif source[end] == "\\":
                    char_escaped = True
                elif source[end] == "'" and end > index + 1:
                    found = True
                    break
                end += 1
            if found:
                out.extend(" " for _ in range(end - index + 1))
                index = end + 1
            else:
                out.append(char)
                index += 1
            continue
        if char == '"':
            in_string = True
            out.append(" ")
            index += 1
            continue
        out.append(char)
        index += 1
    require(depth == 0, "unterminated Lean block comment")
    require(not in_string, "unterminated Lean string")
    return "".join(out)


def strip_lean_attributes(source: str) -> str:
    out = list(source)
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
        require(depth == 0, "unterminated Lean attribute")
        for position in range(index, cursor):
            if out[position] not in "\r\n":
                out[position] = " "
        index = cursor
    return "".join(out)


MODIFIERS = r"(?:(?:private|protected|noncomputable|local|scoped|public)\s+)*"
DECLARATION_COMMAND = re.compile(
    rf"(?m)^\s*{MODIFIERS}"
    r"(theorem|lemma|def|abbrev|structure|class|inductive|instance)\b"
)
NAMED_DECLARATION = re.compile(
    rf"(?m)^\s*({MODIFIERS})"
    r"(theorem|lemma|def|abbrev|structure|class|inductive|instance)\s+"
    r"([^\s:({\[]+)"
)
FORBIDDEN_DECLARATION = re.compile(
    rf"(?m)^\s*{MODIFIERS}"
    r"(axiom|axioms|constant|constants|opaque|unsafe|partial|extern|mutual)\b"
)
PRINT_AXIOMS = re.compile(r"(?m)^\s*#print\s+axioms\s+([^\s]+)\s*$")
SCOPE = re.compile(
    r"(?m)^\s*(namespace\s+([^\s]+)|(?:noncomputable\s+)?section(?:\s+[^\s]+)?|"
    r"end(?:\s+[^\s]+)?)\s*$"
)
AUDIT_ALLOWED_LINE = re.compile(
    r"^(?:import\s+\S+(?:\s+\S+)*|namespace\s+\S+|open(?:\s+scoped)?\s+\S+"
    r"(?:\s+\S+)*|end(?:\s+\S+)?|#print\s+axioms\s+\S+)$"
)


def qualify_lean_name(name: str, namespace: tuple[str, ...]) -> str:
    if name.startswith("_root_."):
        return name[len("_root_."):]
    return ".".join((*namespace, *(part for part in name.split(".") if part)))


def names_with_namespaces(
    clean: str, pattern: re.Pattern[str], name_group: int
) -> list[tuple[re.Match[str], str]]:
    events: list[tuple[int, int, str, object]] = []
    for match in SCOPE.finditer(clean):
        command = match.group(1)
        if command.startswith("namespace"):
            events.append((match.start(), 0, "namespace", match.group(2)))
        elif "section" in command:
            events.append((match.start(), 0, "section", None))
        else:
            events.append((match.start(), 0, "end", None))
    for match in pattern.finditer(clean):
        events.append((match.start(), 1, "name", match))
    events.sort(key=lambda event: (event[0], event[1]))

    namespace: list[str] = []
    scopes: list[tuple[str, tuple[str, ...] | None]] = []
    resolved: list[tuple[re.Match[str], str]] = []
    for _, _, kind, payload in events:
        if kind == "namespace":
            raw = str(payload)
            previous = tuple(namespace)
            if raw.startswith("_root_."):
                namespace.clear()
                raw = raw[len("_root_."):]
            namespace.extend(part for part in raw.split(".") if part)
            scopes.append(("namespace", previous))
        elif kind == "section":
            scopes.append(("section", None))
        elif kind == "end":
            require(bool(scopes), "unmatched Lean `end` while resolving names")
            scope_kind, previous = scopes.pop()
            if scope_kind == "namespace" and previous is not None:
                namespace[:] = previous
        else:
            match = payload
            require(isinstance(match, re.Match), "internal source event mismatch")
            resolved.append(
                (match, qualify_lean_name(match.group(name_group), tuple(namespace)))
            )
    require(not scopes, "unterminated Lean namespace/section while resolving names")
    return resolved


def source_declaration_names(source: str) -> list[str]:
    clean = strip_lean_comments_and_strings(source)
    attribute_free = strip_lean_attributes(clean)
    forbidden_words = [
        token
        for token in ("sorry", "admit", "native_decide", "sorryAx")
        if re.search(rf"(?<![\w']){re.escape(token)}(?![\w'])", clean)
    ]
    forbidden_words.extend(
        match.group(1) for match in FORBIDDEN_DECLARATION.finditer(attribute_free)
    )
    require(not forbidden_words, f"forbidden Lean constructs: {sorted(set(forbidden_words))}")
    commands = list(DECLARATION_COMMAND.finditer(attribute_free))
    named = names_with_namespaces(attribute_free, NAMED_DECLARATION, 3)
    require(
        len(commands) == len(named),
        "a top-level declaration command was not completely parsed",
    )
    public_names = [
        name
        for match, name in named
        if "private" not in match.group(1).split()
        and "local" not in match.group(1).split()
    ]
    require(
        len(public_names) == len(set(public_names)),
        "duplicate fully qualified public declaration",
    )
    return public_names


def source_declaration_kind_counts(source: str) -> dict[str, int]:
    clean = strip_lean_attributes(strip_lean_comments_and_strings(source))
    named = names_with_namespaces(clean, NAMED_DECLARATION, 3)
    counts = Counter(
        match.group(2)
        for match, _ in named
        if "private" not in match.group(1).split()
        and "local" not in match.group(1).split()
    )
    return dict(sorted(counts.items()))


def check_parser_regressions() -> dict[str, object]:
    benign = """
namespace Δ
@[simp] public theorem α : True := by trivial
private def hidden : Nat := 0
class Κ where
  value : Nat
def quoted : String := \"sorry axiom native_decide\"
-- public opaque ignoredComment : Nat
/- @[simp] axiom ignoredBlock : Prop -/
end Δ
"""
    require(
        source_declaration_names(benign) == ["Δ.α", "Δ.Κ", "Δ.quoted"],
        "source parser Unicode/modifier/comment regression",
    )
    rejected = (
        "@[simp] axiom α : Prop\n",
        "public opaque shadow : Nat\n",
        "partial def loop : Nat := loop\n",
        "unsafe def escape : Nat := 0\n",
        "constant custom : Prop\n",
        "def fake : True := by native_decide\n",
    )
    for source in rejected:
        try:
            source_declaration_names(source)
        except AssertionError:
            continue
        raise AssertionError(f"source parser accepted forbidden regression: {source!r}")
    shadow_audit = """
import IUTThreeClosures.Dummy
namespace Audit
opaque sourceName : Nat
#print axioms sourceName
end Audit
"""
    try:
        audit_targets(shadow_audit, "IUTThreeClosures.Dummy", "Dummy")
    except AssertionError:
        pass
    else:
        raise AssertionError("audit parser accepted a shadow declaration")
    return {
        "unicode_and_decorated_public_declarations": "PASS",
        "comment_and_string_false_positives": "PASS",
        "forbidden_declaration_cases_rejected": len(rejected),
        "audit_shadow_case_rejected": True,
    }


def audit_targets(audit: str, root: str, module: str) -> list[str]:
    clean = strip_lean_comments_and_strings(audit)
    attribute_free = strip_lean_attributes(clean)
    require(
        not DECLARATION_COMMAND.search(attribute_free)
        and not FORBIDDEN_DECLARATION.search(attribute_free),
        f"{module}: audit file declares or can shadow constants",
    )
    require(
        not re.search(r"(?<![\w'])(?:sorry|admit|native_decide|sorryAx)(?![\w'])", clean),
        f"{module}: forbidden proof token in audit",
    )
    for line in attribute_free.splitlines():
        stripped = line.strip()
        if stripped:
            require(
                AUDIT_ALLOWED_LINE.fullmatch(stripped) is not None,
                f"{module}: unapproved audit command/continuation: {stripped!r}",
            )
    imports = re.findall(r"(?m)^\s*import\s+([^\s]+)\s*$", clean)
    require(
        imports == [f"IUTThreeClosures.{module}"],
        f"{module}: audit must import exactly its companion module",
    )
    targets = PRINT_AXIOMS.findall(clean)
    require(all(re.fullmatch(r"[\w'.]+", target) for target in targets),
            f"{module}: malformed axiom target")
    require(all(not target.startswith("_root_.") for target in targets),
            f"{module}: root-qualified audit target forbidden")
    return [f"{root}.{target}" for target in targets]


def check_source_inventory() -> tuple[dict[str, object], dict[str, list[str]]]:
    counts: dict[str, int] = {}
    kinds: dict[str, dict[str, int]] = {}
    names_by_module: dict[str, list[str]] = {}
    for _, module, expected_count, root in MODULES:
        source = read_text(LEAN_MODULE_DIR / f"{module}.lean")
        audit = read_text(LEAN_MODULE_DIR / f"{module}AxiomAudit.lean")
        names = source_declaration_names(source)
        targets = audit_targets(audit, root, module)
        require(
            len(names) == expected_count,
            f"{module}: {len(names)} declarations, expected {expected_count}",
        )
        require(
            len(targets) == expected_count,
            f"{module}: {len(targets)} axiom queries, expected {expected_count}",
        )
        require(
            names == targets,
            f"{module}: ordered source/audit mismatch; "
            f"missing={sorted(set(names) - set(targets))}, "
            f"extra={sorted(set(targets) - set(names))}",
        )
        counts[module] = len(names)
        kinds[module] = source_declaration_kind_counts(source)
        require(sum(kinds[module].values()) == len(names),
                f"{module}: declaration-kind count mismatch")
        names_by_module[module] = names

    original_total = sum(counts[module] for _, module, _, _ in MODULES[:4])
    require(original_total == 214, "original four-module declaration count is not 214")
    total = sum(counts.values())
    aggregate_kinds: Counter[str] = Counter()
    for module_kinds in kinds.values():
        aggregate_kinds.update(module_kinds)
    return (
        {
            "counts": counts,
            "kinds_by_module": kinds,
            "aggregate_kinds": dict(sorted(aggregate_kinds.items())),
            "original_four_total": original_total,
            "successor_count": counts["ABCThreeArmIncidenceSuccessor20260903"],
            "total": total,
            "ordered_one_for_one": True,
            "forbidden_constructs_absent": True,
        },
        names_by_module,
    )


AXIOM_RECORD = re.compile(
    r"'([^'\r\n]+)' (?:(does not depend on any axioms)|"
    r"depends on axioms:\s*\[([^\]]*)\])"
)


def parse_axiom_log(log: str, expected_names: list[str], module: str) -> list[set[str]]:
    records: list[tuple[str, set[str]]] = []
    cursor = 0
    for match in AXIOM_RECORD.finditer(log):
        require(not log[cursor:match.start()].strip(),
                f"{module}: unparsed axiom-log text")
        name, no_axioms, body = match.groups()
        if no_axioms is not None:
            dependencies: set[str] = set()
        else:
            raw = [item.strip() for item in (body or "").split(",")]
            require(all(raw), f"{module}: malformed axiom dependency list")
            require(len(raw) == len(set(raw)), f"{module}: duplicate axiom dependency")
            dependencies = set(raw)
        require(dependencies <= ALLOWED_AXIOMS,
                f"{module}: disallowed axioms {sorted(dependencies - ALLOWED_AXIOMS)}")
        records.append((name, dependencies))
        cursor = match.end()
    require(not log[cursor:].strip(), f"{module}: trailing unparsed axiom-log text")
    observed_names = [name for name, _ in records]
    require(observed_names == expected_names,
            f"{module}: axiom log names/order differ from exact canonical inventory")
    return [dependencies for _, dependencies in records]


def digest_map(paths: tuple[Path, ...]) -> dict[str, str]:
    return {relative_name(path): sha256(path) for path in paths}


def expected_run_records() -> list[dict[str, object]]:
    records: list[dict[str, object]] = [
        {
            "name": "lean-version",
            "argv": ["lake", "env", "lean", "--version"],
            "cwd": "Lean",
            "inputs": config_paths(),
        },
        {
            "name": "umbrella-build",
            "argv": ["lake", "build", "IUTThreeClosures"],
            "cwd": "Lean",
            "inputs": umbrella_input_paths(),
        },
    ]
    for stem, module, _, _ in MODULES:
        records.extend(
            (
                {
                    "name": f"{stem}-main-strict",
                    "argv": [
                        "lake", "env", "lean", "-DwarningAsError=true",
                        f"IUTThreeClosures/{module}.lean",
                    ],
                    "cwd": "Lean",
                    "inputs": module_input_paths(module, audit=False),
                },
                {
                    "name": f"{stem}-axiom-audit-strict",
                    "argv": [
                        "lake", "env", "lean", "-DwarningAsError=true",
                        f"IUTThreeClosures/{module}AxiomAudit.lean",
                    ],
                    "cwd": "Lean",
                    "inputs": module_input_paths(module, audit=True),
                },
            )
        )
    package_prefix = relative_name(HERE)
    endpoint_prefix = relative_name(ENDPOINT)
    successor_prefix = relative_name(SUCCESSOR)
    pbt_prefix = relative_name(PBT)
    records.extend(
        (
            {
                "name": "environment-axiom-audit-strict",
                "argv": [
                    "lake", "env", "lean", "-DwarningAsError=true",
                    "verification/2026_09_03_incidence_endpoint_literature/"
                    "EnvironmentAxiomAudit.lean",
                ],
                "cwd": "Lean",
                "inputs": environment_audit_input_paths(),
            },
            {
                "name": "endpoint-computation-replay",
                "argv": [
                    "python", "search_endpoint_token_transport.py", "--limit", "5000",
                    "--lte-k-limit", "12", "--output",
                    f"{package_prefix}/endpoint-replay-output.json",
                ],
                "cwd": endpoint_prefix,
                "inputs": (ENDPOINT / "search_endpoint_token_transport.py",),
            },
            {
                "name": "endpoint-independent-hall-audit",
                "argv": [
                    "python", "independent_endpoint_hall_audit.py", "--limit", "5000",
                ],
                "cwd": package_prefix,
                "inputs": (HERE / "independent_endpoint_hall_audit.py",),
            },
            {
                "name": "successor-computation-replay",
                "argv": [
                    "python", "search_three_arm_successor.py", "--cmax", "1200",
                    "--rmax", "12", "--tmax", "80", "--output",
                    f"{package_prefix}/successor-replay-output.json",
                ],
                "cwd": successor_prefix,
                "inputs": (SUCCESSOR / "search_three_arm_successor.py",),
            },
            {
                "name": "pbt-computation-replay",
                "argv": [
                    "python", "search_prime_packet_boundary.py", "--cmax", "3000",
                    "--coarse-ratio-denominator", "120",
                    "--fine-ratio-denominator", "12000",
                    "--structured-prime-limit", "5000",
                    "--smooth-power-limit", "8", "--output",
                    f"{package_prefix}/pbt-replay/OUTPUT.json",
                    "--structured-csv",
                    f"{package_prefix}/pbt-replay/STRUCTURED_FAMILIES.csv",
                ],
                "cwd": pbt_prefix,
                "inputs": (PBT / "search_prime_packet_boundary.py",),
            },
            {
                "name": "pbt-independent-full-audit",
                "argv": [
                    "python", "validate_prime_packet_boundary.py",
                    "--directory", ".", "--skip-replay",
                ],
                "cwd": pbt_prefix,
                "inputs": (
                    PBT / "validate_prime_packet_boundary.py",
                    PBT / "search_prime_packet_boundary.py",
                    PBT / "OUTPUT.json",
                    PBT / "STRUCTURED_FAMILIES.csv",
                ),
            },
        )
    )
    return records


def check_run_summary() -> dict[str, object]:
    payload = json.loads(read_text(HERE / "run_summary.json"))
    require(payload.get("schema") == "abc-incidence-endpoint-successor-pbt-replay-v3",
            "unexpected run-summary schema")
    require(payload.get("status") == "PASS", "runner did not report PASS")
    require(payload.get("computation_status") ==
            "REPLAYED_AND_INDEPENDENTLY_AUDITED",
            "the exhaustive computations and independent audits were not replayed")
    python_info = payload.get("python")
    require(isinstance(python_info, dict) and python_info.get("optimize") == 0,
            "run used optimized Python")
    require(payload.get("controlled_environment") == {
        "PYTHONDONTWRITEBYTECODE": "1",
        "PYTHONHASHSEED": "0",
        "PYTHONOPTIMIZE": "0",
    }, "runner environment controls changed")
    observed = payload.get("records")
    expected = expected_run_records()
    require(isinstance(observed, list), "run records are not a list")
    require([row.get("name") for row in observed] == [row["name"] for row in expected],
            "run record names/order changed")
    require(len(observed) == len(expected),
            f"run summary has {len(observed)} records, expected {len(expected)}")
    allowed_record_keys = {
        "name", "argv", "cwd", "exit_code", "elapsed_seconds", "output_bytes",
        "input_sha256", "inputs_stable_during_command",
    }
    umbrella_hashes: dict[str, str] | None = None
    for row, specification in zip(observed, expected, strict=True):
        name = str(specification["name"])
        require(set(row) == allowed_record_keys, f"{name}: run-record fields changed")
        require(row["argv"] == specification["argv"], f"{name}: argv changed")
        require(row["cwd"] == specification["cwd"], f"{name}: cwd changed")
        require(row["exit_code"] == 0, f"{name}: nonzero exit")
        require(row["inputs_stable_during_command"] is True,
                f"{name}: input changed during command")
        require(isinstance(row["elapsed_seconds"], (int, float))
                and math.isfinite(row["elapsed_seconds"])
                and row["elapsed_seconds"] >= 0,
                f"{name}: invalid elapsed time")
        log_path = HERE / f"{name}.log"
        exit_path = HERE / f"{name}.exitcode"
        require(read_text(exit_path) == "0\n", f"{name}: exitcode evidence mismatch")
        require(row["output_bytes"] == len(log_path.read_bytes()),
                f"{name}: log byte count mismatch")
        expected_inputs = digest_map(specification["inputs"])
        require(row["input_sha256"] == expected_inputs,
                f"{name}: input set/hash differs from current exact closure")
        if name == "umbrella-build":
            umbrella_hashes = expected_inputs
        elif name.endswith("-main-strict"):
            require(umbrella_hashes is not None, "umbrella hashes unavailable")
            require(all(umbrella_hashes.get(path) == digest
                        for path, digest in expected_inputs.items()),
                    f"{name}: direct check not bound to umbrella build inputs")
        elif name != "environment-axiom-audit-strict" and name.endswith(
            "-axiom-audit-strict"
        ):
            require(umbrella_hashes is not None, "umbrella hashes unavailable")
            extra = set(expected_inputs) - set(umbrella_hashes)
            require(len(extra) == 1 and next(iter(extra)).endswith("AxiomAudit.lean"),
                    f"{name}: unexpected input outside umbrella closure: {sorted(extra)}")
            require(all(umbrella_hashes.get(path) == digest
                        for path, digest in expected_inputs.items() if path not in extra),
                    f"{name}: imported source changed after umbrella build")
    return {
        "record_count": len(observed),
        "python": python_info,
        "local_umbrella_input_count": len(umbrella_hashes or {}),
        "all_inputs_current_and_stable": True,
    }


def check_environment_audit(names_by_module: dict[str, list[str]]) -> dict[str, object]:
    name = "environment-axiom-audit-strict"
    require(read_text(HERE / f"{name}.exitcode") == "0\n",
            "compiled-environment audit failed")
    lines = read_text(HERE / f"{name}.log").splitlines()
    declaration_rows: list[tuple[str, str, set[str]]] = []
    module_rows: dict[str, int] = {}
    summary: tuple[int, str, str] | None = None
    for line in lines:
        if line.startswith("AXIOM_AUDIT|DECL|"):
            parts = line.split("|", 4)
            require(len(parts) == 5, "malformed environment declaration row")
            _, _, module_name, declaration_name, raw_dependencies = parts
            dependencies = set(filter(None, raw_dependencies.split(",")))
            require(dependencies <= ALLOWED_AXIOMS,
                    f"environment audit disallowed axioms: {sorted(dependencies - ALLOWED_AXIOMS)}")
            declaration_rows.append((module_name, declaration_name, dependencies))
        elif line.startswith("AXIOM_AUDIT|MODULE|"):
            parts = line.split("|")
            require(len(parts) == 4 and parts[2] not in module_rows,
                    "malformed/duplicate environment module row")
            module_rows[parts[2]] = int(parts[3])
        elif line.startswith("AXIOM_AUDIT|SUMMARY|"):
            parts = line.split("|")
            require(len(parts) == 5 and summary is None,
                    "malformed/duplicate environment summary")
            summary = (int(parts[2]), parts[3], parts[4])
        else:
            require(not line.strip(), f"unparsed environment-audit output: {line!r}")

    expected_modules = {f"IUTThreeClosures.{module}" for _, module, _, _ in MODULES}
    require(set(module_rows) == expected_modules, "environment module set changed")
    require(summary is not None and summary[1:] == ("unsafe=0", "partial=0"),
            "environment audit lacks clean unsafe/partial summary")
    require(summary[0] == len(declaration_rows), "environment summary count mismatch")
    observed_counts = Counter(module_name for module_name, _, _ in declaration_rows)
    require(dict(observed_counts) == module_rows, "environment per-module counts mismatch")
    require(all(count > 0 for count in module_rows.values()),
            "environment audit selected an empty module")
    declaration_names = [declaration for _, declaration, _ in declaration_rows]
    require(len(declaration_names) == len(set(declaration_names)),
            "duplicate compiled-environment declaration")
    source_names = {name for names in names_by_module.values() for name in names}
    require(source_names <= set(declaration_names),
            f"compiled-environment audit omitted source declarations: "
            f"{sorted(source_names - set(declaration_names))}")
    axiom_union = set().union(*(dependencies for _, _, dependencies in declaration_rows))
    require(axiom_union == ALLOWED_AXIOMS,
            f"compiled-environment axiom union changed: {sorted(axiom_union)}")
    return {
        "compiled_declaration_count": len(declaration_rows),
        "per_file_module": dict(sorted(module_rows.items())),
        "axiom_union": sorted(axiom_union),
        "unsafe": 0,
        "partial": 0,
    }


def check_formal_logs(names_by_module: dict[str, list[str]]) -> dict[str, object]:
    union: set[str] = set()
    counts: dict[str, int] = {}
    for stem, module, expected_count, _ in MODULES:
        require(read_text(HERE / f"{stem}-main-strict.exitcode") == "0\n",
                f"{module}: strict main elaboration failed")
        require(read_text(HERE / f"{stem}-main-strict.log") == "",
                f"{module}: strict main emitted warnings/output")
        require(read_text(HERE / f"{stem}-axiom-audit-strict.exitcode") == "0\n",
                f"{module}: strict axiom audit failed")
        dependencies = parse_axiom_log(
            read_text(HERE / f"{stem}-axiom-audit-strict.log"),
            names_by_module[module],
            module,
        )
        require(len(dependencies) == expected_count,
                f"{module}: wrong axiom-result count")
        union.update(*dependencies)
        counts[module] = len(dependencies)
    require(union == ALLOWED_AXIOMS, f"handwritten axiom union changed: {sorted(union)}")
    require(read_text(HERE / "lean-version.exitcode") == "0\n", "Lean version failed")
    version = read_text(HERE / "lean-version.log").strip()
    require(version.startswith("Lean (version 4.32.0,"), f"unexpected Lean version: {version}")
    require(read_text(HERE / "umbrella-build.exitcode") == "0\n", "umbrella build failed")
    require("Build completed successfully" in read_text(HERE / "umbrella-build.log"),
            "umbrella build lacks success marker")
    environment = check_environment_audit(names_by_module)
    return {
        "axiom_result_counts": counts,
        "axiom_union": sorted(union),
        "lean_version": version,
        "umbrella_build": "PASS",
        "compiled_environment": environment,
    }


SHA_ROW = re.compile(r"^([0-9a-f]{64})  (.+)$")


def parse_repo_sha_manifest(path: Path, expected_names: set[str]) -> dict[str, str]:
    rows: dict[str, str] = {}
    lines = read_text(path).splitlines()
    require(lines, f"empty checksum file: {path}")
    for line in lines:
        match = SHA_ROW.fullmatch(line)
        require(match is not None, f"malformed SHA-256 row: {line!r}")
        digest, raw_name = match.groups()
        name = canonical_relative_path(raw_name)
        require(name not in rows, f"duplicate SHA-256 path: {name}")
        rows[name] = digest
    require(set(rows) == expected_names,
            f"checksum file set changed: {sorted(set(rows) ^ expected_names)}")
    for name, digest in rows.items():
        require(sha256(repo_path(name)) == digest, f"checksum mismatch: {name}")
    return rows


def parse_local_sha_manifest(
    path: Path, directory: Path, expected_names: set[str]
) -> dict[str, str]:
    rows: dict[str, str] = {}
    lines = read_text(path).splitlines()
    require(lines, f"empty checksum file: {path}")
    for line in lines:
        match = SHA_ROW.fullmatch(line)
        require(match is not None, f"malformed SHA-256 row: {line!r}")
        digest, raw_name = match.groups()
        require("/" not in raw_name and "\\" not in raw_name
                and raw_name not in ("", ".", ".."),
                f"nonlocal checksum path: {raw_name!r}")
        require(raw_name not in rows, f"duplicate local checksum path: {raw_name}")
        rows[raw_name] = digest
    require(set(rows) == expected_names,
            f"local checksum file set changed: {sorted(set(rows) ^ expected_names)}")
    for name, digest in rows.items():
        target = directory / name
        require(target.is_file() and not target.is_symlink(), f"missing local checksum file: {name}")
        require(sha256(target) == digest, f"local checksum mismatch: {name}")
    return rows


def normalized_primitive_nonunit_count(limit: int) -> int:
    phi = list(range(limit + 1))
    for prime in range(2, limit + 1):
        if phi[prime] == prime:
            for multiple in range(prime, limit + 1, prime):
                phi[multiple] -= phi[multiple] // prime
    return sum(phi[c] // 2 - 1 for c in range(4, limit + 1))


def parse_endpoint_stdout(text: str) -> dict[str, int]:
    lines = text.splitlines()
    require(len(lines) == 4, "endpoint stdout must contain exactly four lines")
    summary = json.loads(lines[0])
    require(summary == EXPECTED_ENDPOINT_SUMMARY, "endpoint stdout summary changed")
    require(lines[1] == "first_integral_failure [3, 13, 16]",
            "endpoint stdout first failure changed")
    require(lines[2] == "first_core_favorable_integral_failure [3, 13, 16]",
            "endpoint stdout first favorable failure changed")
    require(lines[3] == f"script_sha256 {sha256(ENDPOINT / 'search_endpoint_token_transport.py')}",
            "endpoint stdout script hash changed")
    return summary


def check_endpoint_computation() -> dict[str, object]:
    require(read_text(HERE / "endpoint-computation-replay.exitcode") == "0\n",
            "endpoint computation replay failed")
    frozen = ENDPOINT / "OUTPUT.json"
    require(b"\r" not in frozen.read_bytes()
            and b"\r" not in (ENDPOINT / "RUN.log").read_bytes()
            and b"\r" not in ENDPOINT_REPLAY.read_bytes(),
            "endpoint JSON/run artifacts are not LF-only")
    require(ENDPOINT_REPLAY.read_bytes() == frozen.read_bytes(),
            "endpoint replay is not byte-identical in the recorded environment")
    payload = json.loads(read_text(frozen))
    require(payload.get("command_parameters") == {"limit": 5000, "lte_k_limit": 12},
            "endpoint parameters changed")
    require(payload.get("summary") == EXPECTED_ENDPOINT_SUMMARY,
            "endpoint headline counts changed")
    script = ENDPOINT / "search_endpoint_token_transport.py"
    require(payload.get("script_sha256") == sha256(script),
            "endpoint embedded script hash mismatch")
    require(payload.get("scope") ==
            "normalized primitive nonunit triples 2 <= a <= b, a+b=c",
            "endpoint scope changed")
    require(normalized_primitive_nonunit_count(5000) == 3_795_230,
            "independent totient count changed")
    require(payload["first_integral_failure"]["triple"] == [3, 13, 16],
            "endpoint first integral failure changed")
    require(payload["first_core_favorable_integral_failure"]["triple"] == [3, 13, 16],
            "endpoint first favorable failure changed")
    named = payload.get("named_complete_premise_certificates", {})
    require(named["cardinality_obstruction"]["triple"] == [3, 13, 16],
            "cardinality certificate changed")
    require(named["threshold_obstruction"]["triple"] == [9, 16, 25],
            "threshold certificate changed")
    require(named["positive_core_defect"]["triple"] == [5, 27, 32],
            "positive-defect certificate changed")
    for record in named.values():
        a, b, c = record["triple"]
        require(a + b == c and math.gcd(a, b) == 1,
                f"nonprimitive named endpoint row: {record['triple']}")
        require(abs(record["fractional_accounting_error"]) < 1e-9,
                f"fractional accounting error: {record['triple']}")
    lte = payload.get("lte_dyadic_unit_arm_audit", [])
    require(len(lte) == 12 and all(
        row["k"] == k
        and row["m"] == 2 * 3**k
        and row["v3_2powm_minus_one"] == k + 1
        for k, row in enumerate(lte, start=1)
    ), "endpoint LTE certificate changed")
    parse_endpoint_stdout(read_text(HERE / "endpoint-computation-replay.log"))
    parse_endpoint_stdout(read_text(ENDPOINT / "RUN.log"))

    expected_checksum_names = set(ENDPOINT_RELATIVE_PATHS) - {
        "research/computation/2026_09_03_signed_endpoint_prime_token_transport/"
        "SHA256SUMS.txt"
    }
    expected_checksum_names.update(
        {
            "research/ABC_SIGNED_ENDPOINT_PRIME_TOKEN_TRANSPORT_2026_09_03.md",
            "Lean/IUTThreeClosures/ABCSignedEndpointPrimeTokenTransport20260903.lean",
            "Lean/IUTThreeClosures/ABCSignedEndpointPrimeTokenTransport20260903AxiomAudit.lean",
        }
    )
    hashes = parse_repo_sha_manifest(ENDPOINT / "SHA256SUMS.txt", expected_checksum_names)
    return {
        **EXPECTED_ENDPOINT_SUMMARY,
        "recorded_environment_byte_identical": True,
        "portable_exact_integer_audit": "PASS",
        "independent_totient_count": normalized_primitive_nonunit_count(5000),
        "checksum_entries": len(hashes),
        "script_sha256": sha256(script),
        "output_sha256": sha256(frozen),
    }


def check_independent_endpoint_audit() -> dict[str, object]:
    require(read_text(HERE / "endpoint-independent-hall-audit.exitcode") == "0\n",
            "independent endpoint audit failed")
    lines = read_text(HERE / "endpoint-independent-hall-audit.log").splitlines()
    require(len(lines) == 1, "independent endpoint audit emitted unexpected text")
    payload = json.loads(lines[0])
    require(payload.get("algorithm") == "independent exact upper-tail Hall audit",
            "independent endpoint algorithm marker changed")
    require(payload.get("limit") == 5000, "independent endpoint limit changed")
    require(payload.get("summary") == EXPECTED_ENDPOINT_SUMMARY,
            "independent endpoint counts disagree")
    require(payload.get("totient_count") == 3_795_230,
            "independent endpoint totient count disagrees")
    require(payload.get("first_integral_failure") == [3, 13, 16]
            and payload.get("first_core_favorable_integral_failure") == [3, 13, 16],
            "independent endpoint first failure changed")
    return payload


def successor_exact_counts(limit: int) -> tuple[int, int]:
    spf = list(range(limit + 1))
    for prime in range(2, math.isqrt(limit) + 1):
        if spf[prime] == prime:
            for multiple in range(prime * prime, limit + 1, prime):
                if spf[multiple] == multiple:
                    spf[multiple] = prime
    exponent_one_product = [1] * (limit + 1)
    for original in range(2, limit + 1):
        n = original
        product = 1
        while n > 1:
            prime = spf[n]
            exponent = 0
            while n % prime == 0:
                n //= prime
                exponent += 1
            if exponent == 1:
                product *= prime
        exponent_one_product[original] = product
    total = 0
    failures = 0
    for c in range(2, limit + 1):
        for a in range(1, c // 2 + 1):
            b = c - a
            if math.gcd(a, b) != 1:
                continue
            total += 1
            if exponent_one_product[a] * exponent_one_product[b] * exponent_one_product[c] < c:
                failures += 1
    return total, failures


def integer_radical(n: int) -> int:
    answer = 1
    divisor = 2
    while divisor * divisor <= n:
        if n % divisor == 0:
            answer *= divisor
            while n % divisor == 0:
                n //= divisor
        divisor = 3 if divisor == 2 else divisor + 2
    if n > 1:
        answer *= n
    return answer


def validate_successor_row(row: dict[str, object]) -> None:
    a, b, c = int(row["a"]), int(row["b"]), int(row["c"])
    require(a + b == c and math.gcd(a, b) == 1,
            f"invalid successor triple: {(a, b, c)}")
    require(row["radical"] == integer_radical(a * b * c),
            f"successor radical mismatch: {(a, b, c)}")
    require(int(row["covering_faces"]) > 0 and int(row["min_raw_defect"]) >= 1,
            f"invalid successor covering data: {(a, b, c)}")
    require(bool(row["zero_defect_cover"]) == (int(row["min_raw_defect"]) == 1),
            f"zero-defect flag mismatch: {(a, b, c)}")
    scalar = float(row["min_scalar_unmatched"])
    flow = float(row["min_monotone_unmatched"])
    require(flow + 1e-10 >= scalar >= -1e-12,
            f"successor flow/scalar inequality failed: {(a, b, c)}")


def check_successor_computation() -> dict[str, object]:
    require(read_text(HERE / "successor-computation-replay.exitcode") == "0\n",
            "successor computation replay failed")
    frozen_json = SUCCESSOR / "OUTPUT.json"
    frozen_csv = SUCCESSOR / "OUTPUT.csv"
    require(b"\r" not in frozen_json.read_bytes()
            and b"\r" not in SUCCESSOR_REPLAY.read_bytes(),
            "successor JSON artifacts are not LF-only")
    require(SUCCESSOR_REPLAY.read_bytes() == frozen_json.read_bytes(),
            "successor JSON replay is not byte-identical in the recorded environment")
    require(SUCCESSOR_REPLAY_CSV.read_bytes() == frozen_csv.read_bytes(),
            "successor CSV replay is not byte-identical in the recorded environment")
    payload = json.loads(read_text(frozen_json))
    require(payload.get("parameters") == {"cmax": 1200, "rmax": 12, "tmax": 80},
            "successor parameters changed")
    require(payload.get("counts") == EXPECTED_SUCCESSOR_COUNTS,
            "successor headline counts changed")
    exact_total, exact_failures = successor_exact_counts(1200)
    require((exact_total, exact_failures) == (218_893, 1_669),
            "independent successor exact counts disagree")
    require("exact integers" in payload.get("semantics", {}).get("exactness", ""),
            "successor exactness marker missing")

    raw_top = payload.get("actual_top_raw_ratio", [])
    flow_top = payload.get("actual_top_flow_ratio", [])
    balanced = payload.get("balanced", [])
    pythagorean = payload.get("pythagorean", [])
    require(len(raw_top) == 20 and len(flow_top) == 20,
            "successor top-list length changed")
    require(len(balanced) == 12 and len(pythagorean) == 80,
            "successor family lengths changed")
    require(all(float(raw_top[i]["raw_ratio"]) >= float(raw_top[i + 1]["raw_ratio"])
                for i in range(19)), "successor raw top list not sorted")
    require(all(float(flow_top[i]["flow_ratio"]) >= float(flow_top[i + 1]["flow_ratio"])
                for i in range(19)), "successor flow top list not sorted")
    for row in [*raw_top, *flow_top, *balanced, *pythagorean]:
        validate_successor_row(row)
    for index, row in enumerate(balanced, start=1):
        require((row["a"], row["b"], row["c"]) ==
                (2 ** (2 * index), 3**index, 2 ** (2 * index) + 3**index),
                f"balanced successor row {index} changed")
    for index, row in enumerate(pythagorean, start=1):
        x = 2 * index + 1
        y = 2 * index * (index + 1)
        z = 2 * index * index + 2 * index + 1
        require((row["a"], row["b"], row["c"]) == (x * x, y * y, z * z),
                f"Pythagorean successor row {index} changed")

    with frozen_csv.open("r", encoding="utf-8", newline="") as stream:
        csv_rows = list(csv.DictReader(stream))
    require(len(csv_rows) == 92, "successor CSV row count changed")
    require(all(row["family"] == "balanced" and int(row["index"]) == index
                for index, row in enumerate(csv_rows[:12], start=1)),
            "successor balanced CSV labels changed")
    require(all(row["family"] == "pythagorean" and int(row["index"]) == index
                for index, row in enumerate(csv_rows[12:], start=1)),
            "successor Pythagorean CSV labels changed")

    stdout_payload = json.loads(read_text(HERE / "successor-computation-replay.log"))
    expected_output_argument = os.path.relpath(SUCCESSOR_REPLAY, SUCCESSOR).replace("\\", "/")
    observed_output = str(stdout_payload.get("output", "")).replace("\\", "/")
    observed_csv = str(stdout_payload.get("csv", "")).replace("\\", "/")
    require(observed_output == expected_output_argument
            and observed_csv == str(Path(expected_output_argument).with_suffix(".csv")).replace("\\", "/"),
            "successor stdout destinations changed")
    require(stdout_payload.get("counts") == EXPECTED_SUCCESSOR_COUNTS,
            "successor stdout counts changed")
    require(math.isclose(stdout_payload["max_actual_raw_ratio"],
                         raw_top[0]["raw_ratio"], rel_tol=0, abs_tol=1e-15),
            "successor stdout raw maximum changed")
    require(math.isclose(stdout_payload["max_actual_flow_ratio"],
                         flow_top[0]["flow_ratio"], rel_tol=0, abs_tol=1e-15),
            "successor stdout flow maximum changed")
    require(math.isclose(stdout_payload["max_balanced_flow_ratio"],
                         max(row["flow_ratio"] for row in balanced),
                         rel_tol=0, abs_tol=1e-15),
            "successor stdout balanced maximum changed")
    require(math.isclose(stdout_payload["max_pythagorean_flow_ratio"],
                         max(row["flow_ratio"] for row in pythagorean),
                         rel_tol=0, abs_tol=1e-15),
            "successor stdout Pythagorean maximum changed")

    expected_local_names = {
        "OUTPUT.csv", "OUTPUT.json", "README.md", "RUN.txt",
        "search_three_arm_successor.py",
    }
    hashes = parse_local_sha_manifest(
        SUCCESSOR / "SHA256SUMS", SUCCESSOR, expected_local_names
    )
    run_text = read_text(SUCCESSOR / "RUN.txt")
    require("unordered positive primitive triples: 218893" in run_text
            and "triples with no zero-defect covering face: 1669" in run_text
            and "regression sources [(5,1),(2,1)], sink [(3,1)]: unmatched mass 1" in run_text
            and "Hall upper-tail formula" in run_text,
            "successor RUN ledger lacks exact required markers")
    return {
        **EXPECTED_SUCCESSOR_COUNTS,
        "recorded_environment_json_byte_identical": True,
        "recorded_environment_csv_byte_identical": True,
        "independent_exact_primitive_count": exact_total,
        "independent_exact_zero_defect_failures": exact_failures,
        "balanced_rows": len(balanced),
        "pythagorean_rows": len(pythagorean),
        "checksum_entries": len(hashes),
        "script_sha256": sha256(SUCCESSOR / "search_three_arm_successor.py"),
        "output_json_sha256": sha256(frozen_json),
        "output_csv_sha256": sha256(frozen_csv),
    }


def pbt_primitive_count(limit: int) -> int:
    return sum(
        1
        for c in range(2, limit + 1)
        for a in range(1, c // 2 + 1)
        if math.gcd(a, c) == 1
    )


def check_pbt_computation() -> dict[str, object]:
    require(read_text(HERE / "pbt-computation-replay.exitcode") == "0\n",
            "PBT computation replay failed")
    require(read_text(HERE / "pbt-independent-full-audit.exitcode") == "0\n",
            "PBT independent full-scope audit failed")
    frozen_json = PBT / "OUTPUT.json"
    frozen_csv = PBT / "STRUCTURED_FAMILIES.csv"
    require(PBT_REPLAY.read_bytes() == frozen_json.read_bytes(),
            "PBT JSON replay is not byte-identical in the recorded environment")
    require(PBT_REPLAY_CSV.read_bytes() == frozen_csv.read_bytes(),
            "PBT CSV replay is not byte-identical in the recorded environment")
    for path in (
        frozen_json,
        frozen_csv,
        PBT_REPLAY,
        PBT_REPLAY_CSV,
        PBT / "RUN.log",
        PBT / "VALIDATION.log",
    ):
        require(b"\r" not in path.read_bytes(), f"PBT artifact is not LF-only: {path}")

    payload = json.loads(read_text(frozen_json))
    require(payload.get("parameters") == {
        "cmax": 3000,
        "coarse_ratio_grid_denominator": 120,
        "fine_ratio_grid_denominator": 12000,
        "normalized_scope": "1 <= a <= b, a+b=c, gcd(a,b)=1",
        "smooth_power_exponent_range": [2, 8],
        "structured_prime_limit": 5000,
    }, "PBT parameters changed")
    require(payload.get("summary") == EXPECTED_PBT_SUMMARY,
            "PBT exact headline summary changed")
    require(pbt_primitive_count(3000) == 1_368_094,
            "independent PBT primitive-triple count changed")
    producer = PBT / "search_prime_packet_boundary.py"
    validator = PBT / "validate_prime_packet_boundary.py"
    require(payload.get("script_sha256") == sha256(producer),
            "PBT embedded producer hash mismatch")
    validator_source = read_text(validator)
    require(re.search(
        r"(?m)^\s*(?:from\s+search_prime_packet_boundary\s+import|"
        r"import\s+search_prime_packet_boundary(?:\s|$))",
        validator_source,
    ) is None, "PBT independent validator imports the producer")

    claim = payload.get("claim_discipline", {})
    require(isinstance(claim, dict)
            and "refuted independently by the complete-premise Linnik family"
            in str(claim.get("PBT_global_status", ""))
            and "not proved or disproved" in str(claim.get("standard_abc", "")),
            "PBT claim discipline is stale or overclaims standard abc")

    first = payload.get("first_certificates", {})
    require(first["positive_packet_residual"]["abc"] == [1, 8, 9],
            "PBT first positive-residual certificate changed")
    require(first["positive_fragmentation_gap"]["abc"] == [1, 71, 72]
            and first["scalar_defect_zero_but_packet_residual_positive"]["abc"]
            == [1, 71, 72],
            "PBT first fragmentation certificate changed")
    ratio = payload.get("exact_residual_ratio_audit", {})
    require(ratio.get("global_maximum_coarse_grid_cell") == 54
            and ratio.get("coarse_grid_denominator") == 120
            and ratio.get("global_maximum_fine_grid_cell") == 5_468
            and ratio.get("fine_grid_denominator") == 12_000
            and ratio.get("certified_global_ratio_enclosure") == {
                "lower": "5468/12000", "upper_strict": "5469/12000"
            }, "PBT exact ratio enclosure changed")
    maximum_cases = ratio.get("cases_in_maximum_fine_cell_first_twenty", [])
    require(len(maximum_cases) == 1
            and maximum_cases[0]["abc"] == [1, 2400, 2401]
            and maximum_cases[0]["optimal_residual_factor"] == {
                "numerator": 343, "denominator": 30
            }, "PBT maximum ratio certificate changed")
    largest = payload.get("exact_largest_residual_factor", {})
    require(largest.get("factor") == {"numerator": 16, "denominator": 1}
            and largest.get("number_of_cases") == 1
            and largest.get("cases_first_twenty", [{}])[0].get("abc")
            == [1, 2591, 2592],
            "PBT largest residual-factor certificate changed")

    with frozen_csv.open("r", encoding="utf-8", newline="") as stream:
        csv_rows = list(csv.DictReader(stream))
    require(len(csv_rows) == 1_038, "PBT structured CSV row count changed")
    observed_families = Counter(row["family"] for row in csv_rows)
    require(observed_families == {
        "prime_hypotenuse_pythagorean_square": 329,
        "prime_predecessor_square_primorial_sanity": 5,
        "smooth_power_unit_endpoint": 35,
        "unit_prime_square": 669,
    }, "PBT structured family inventory changed")

    replay_lines = read_text(HERE / "pbt-computation-replay.log").splitlines()
    require(len(replay_lines) == 1, "PBT producer emitted unexpected output")
    producer_stdout = json.loads(replay_lines[0])
    expected_headline = {
        "max_coarse_ratio_cell": 54,
        "max_fine_ratio_cell": 5_468,
        "positive_fragmentation_gap": 572,
        "positive_optimal_residual": 624,
        "primitive_triples": 1_368_094,
        "scalar_zero_but_packet_positive": 567,
        "script_sha256": sha256(producer),
        "structured_rows": 1_038,
    }
    require(producer_stdout == expected_headline, "PBT producer stdout changed")
    require(json.loads(read_text(PBT / "RUN.log")) == expected_headline,
            "PBT frozen run ledger changed")

    audit_lines = read_text(HERE / "pbt-independent-full-audit.log").splitlines()
    require(len(audit_lines) == 1, "PBT independent audit emitted unexpected output")
    audit = json.loads(audit_lines[0])
    require(audit == {
        "deterministic_replay": False,
        "independent_full_scope": True,
        "output_sha256": sha256(frozen_json),
        "primitive_triples": 1_368_094,
        "producer_sha256": sha256(producer),
        "replay_stdout": "skipped",
        "status": "PASS",
        "structured_csv_sha256": sha256(frozen_csv),
        "structured_rows": 1_038,
    }, "PBT independent full-scope audit summary changed")
    archived_audit = json.loads(read_text(PBT / "VALIDATION.log"))
    require(archived_audit == {
        "deterministic_replay": True,
        "independent_full_scope": True,
        "output_sha256": sha256(frozen_json),
        "primitive_triples": 1_368_094,
        "producer_sha256": sha256(producer),
        "replay_stdout": json.dumps(
            expected_headline, sort_keys=True, separators=(",", ":")
        ),
        "status": "PASS",
        "structured_csv_sha256": sha256(frozen_csv),
        "structured_rows": 1_038,
    }, "PBT archived validation ledger changed")

    expected_checksum_names = set(PBT_RELATIVE_PATHS) - {
        "research/computation/2026_09_03_prime_packet_boundary_transport/"
        "SHA256SUMS.txt"
    }
    expected_checksum_names.update({
        "research/ABC_PRIME_PACKET_BOUNDARY_COMPUTATION_2026_09_03.md",
        "research/ABC_PRIME_PACKET_BOUNDARY_THEORETICAL_AUDIT_2026_09_03.md",
    })
    hashes = parse_repo_sha_manifest(
        PBT / "SHA256SUMS.txt", expected_checksum_names
    )
    return {
        **EXPECTED_PBT_SUMMARY,
        "structured_rows": len(csv_rows),
        "recorded_environment_json_byte_identical": True,
        "recorded_environment_csv_byte_identical": True,
        "independent_full_scope": True,
        "checksum_entries": len(hashes),
        "producer_sha256": sha256(producer),
        "validator_sha256": sha256(validator),
        "output_sha256": sha256(frozen_json),
        "structured_csv_sha256": sha256(frozen_csv),
    }


def check_hygiene_and_imports() -> dict[str, dict[str, object]]:
    paths = authored_artifact_paths()
    lengths: dict[str, int] = {}
    hashes: dict[str, str] = {}
    for path in paths:
        require(path.is_file() and not path.is_symlink(), f"invalid authored artifact: {path}")
        raw = path.read_bytes()
        raw.decode("utf-8")
        require(b"\t" not in raw, f"TAB byte in authored artifact: {path}")
        require(b"\xef\xbf\xbd" not in raw, f"U+FFFD in authored artifact: {path}")
        require(not [value for value in raw if value < 32 and value not in (10, 13)],
                f"C0 control in authored artifact: {path}")
        require(b"\x7f" not in raw, f"DEL byte in authored artifact: {path}")
        require(raw.endswith(b"\n"), f"missing final newline: {path}")
        require(not any(line.rstrip(b"\r\n").endswith(b" ")
                        for line in raw.splitlines(keepends=True)),
                f"trailing horizontal whitespace: {path}")
        lengths[relative_name(path)] = len(raw)
        hashes[relative_name(path)] = sha256(path)

    umbrella_clean = strip_lean_comments_and_strings(read_text(LEAN / "IUTThreeClosures.lean"))
    imports = set(re.findall(r"(?m)^\s*import\s+([^\s]+)\s*$", umbrella_clean))
    for _, module, _, _ in MODULES:
        require(f"IUTThreeClosures.{module}" in imports, f"umbrella omits {module}")
    for config_name in CONFIG_RELATIVE_PATHS:
        require(repo_path(config_name).is_file(), f"missing build config: {config_name}")
    require(
        repo_path(PAPER_MAIN_RELATIVE_PATH) in paper_input_closure(),
        "paper input closure omits the main source",
    )
    return {"bytes": lengths, "sha256": hashes}


def check_paper_seal() -> dict[str, object]:
    """Independently bind the final PDF to the recorded render/metadata audit."""
    for name in FINAL_PAPER_ARTIFACT_RELATIVE_PATHS:
        path = repo_path(name)
        require(not path.is_symlink(), f"symlinked paper artifact: {name}")

    qa = json.loads(read_text(FINAL_QA / "qa_metrics.json"))
    require(qa.get("schema") == "abc-journal-pdf-qa-v1", "unexpected PDF QA schema")
    require(qa.get("status") == "PASS", "final PDF QA did not report PASS")
    pdf = qa.get("pdf")
    require(isinstance(pdf, dict), "missing PDF QA metadata")
    require(pdf.get("name") == FINAL_PDF.name, "PDF QA name mismatch")
    require(pdf.get("bytes") == FINAL_PDF.stat().st_size, "PDF QA byte count mismatch")
    require(pdf.get("sha256") == sha256(FINAL_PDF), "PDF QA digest mismatch")
    require(isinstance(pdf.get("pages"), int) and pdf["pages"] > 0,
            "invalid final PDF page count")
    require(pdf.get("author") == "ChatGPT", "final PDF author is not ChatGPT")
    require(
        pdf.get("title") ==
        "Uniformity, Prime Support, and Reachable Lattices in Approaches to the abc Conjecture",
        "final PDF title metadata changed",
    )
    require(pdf.get("encrypted") is False, "final PDF is encrypted")
    reader = PdfReader(FINAL_PDF)
    metadata = reader.metadata or {}
    require(reader.is_encrypted is False, "independent PDF reader found encryption")
    require(len(reader.pages) == pdf["pages"], "independent PDF page count mismatch")
    require(str(metadata.get("/Author", "")) == pdf["author"],
            "independent PDF author mismatch")
    require(str(metadata.get("/Title", "")) == pdf["title"],
            "independent PDF title mismatch")

    render = qa.get("render")
    require(isinstance(render, dict), "missing render audit")
    require(render.get("rasterPages") == pdf["pages"], "not every PDF page was rendered")
    require(render.get("pixelWidths") == [910] and render.get("pixelHeights") == [1287],
            "rendered page dimensions changed")
    require(render.get("blankRasterPages") == [], "blank rendered PDF page")
    require(render.get("borderContactPagesAtFourPixels") == [],
            "rendered ink touches the four-pixel border")
    pages = qa.get("pages")
    require(isinstance(pages, list) and len(pages) == pdf["pages"],
            "per-page raster audit is incomplete")
    require([row.get("page") for row in pages if isinstance(row, dict)] ==
            list(range(1, pdf["pages"] + 1)),
            "per-page raster rows are not exact and contiguous")
    contacts = render.get("contactSheets")
    require(contacts == list(FINAL_QA_CONTACT_NAMES),
            "contact-sheet inventory is not the exact ordered sealed inventory")
    require(len(set(contacts)) == len(contacts), "duplicate contact-sheet name")
    require(
        all(
            isinstance(name, str)
            and (FINAL_QA / name).is_file()
            and not (FINAL_QA / name).is_symlink()
            for name in contacts
        ),
        "missing or symlinked contact sheet",
    )

    text_audit = qa.get("text")
    require(isinstance(text_audit, dict), "missing PDF text audit")
    targets = text_audit.get("targetPages")
    require(isinstance(targets, dict) and set(targets) == EXPECTED_PDF_TEXT_TARGETS,
            "PDF text-target inventory changed")
    require(all(isinstance(pages, list) and pages for pages in targets.values()),
            "required paper text is absent from the PDF")
    require(text_audit.get("missingTargets") == [], "PDF QA reports missing text targets")
    require(text_audit.get("lowTextPagesBelow100Characters") == [],
            "PDF QA reports a low-text page")
    fonts = qa.get("fonts")
    require(isinstance(fonts, list) and len(fonts) == 36,
            "PDF font inventory changed")
    require(read_text(FINAL_QA / "render_audit.exitcode") == "0\n",
            "PDF render audit did not exit zero")
    render_log = json.loads(read_text(FINAL_QA / "render_audit.log"))
    require(render_log.get("status") == "PASS" and
            render_log.get("pages") == pdf["pages"],
            "PDF render log does not report a complete PASS")

    compile_log = read_text(FINAL_QA / "compile_latex.log")
    require(read_text(FINAL_QA / "compile_latex.exitcode") == "0\n",
            "direct Tectonic compilation did not exit zero")
    require(read_text(FINAL_QA / "compile_driver.exitcode") == "0\n",
            "bundled LaTeX driver did not exit zero")
    driver = json.loads(read_text(FINAL_QA / "compile_driver.json"))
    require(driver.get("exitCode") == 0 and driver.get("pdfExists") is True,
            "bundled LaTeX driver JSON does not report success")
    require(driver.get("compiler") == "tectonic", "unexpected LaTeX compiler")
    require(Path(str(driver.get("rootFile", ""))).resolve() ==
            repo_path(PAPER_MAIN_RELATIVE_PATH).resolve(),
            "bundled LaTeX driver used a different root source")
    require(Path(str(driver.get("pdfPath", ""))).resolve() == FINAL_PDF.resolve(),
            "bundled LaTeX driver wrote a different PDF path")
    forbidden = re.compile(
        r"LaTeX Warning|Package [^\r\n]* Warning|Overfull \\hbox|"
        r"Underfull \\hbox|undefined references?|undefined citations?|"
        r"Missing character|(?:^|\n)warning:|(?:^|\n)! .*Error",
        re.IGNORECASE,
    )
    require(forbidden.search(compile_log) is None,
            "LaTeX transcript contains a warning, bad box, or unresolved reference")
    engine_log = read_text(FINAL_QA / "tectonic_engine.log")
    require(forbidden.search(engine_log) is None,
            "final Tectonic engine log contains a warning or unresolved reference")
    driver_log = driver.get("log")
    require(isinstance(driver_log, str) and forbidden.search(driver_log) is None,
            "bundled LaTeX driver log contains a warning or unresolved reference")
    require(f"Output written on {FINAL_PDF.stem}.xdv" in compile_log,
            "final TeX engine log lacks its successful output marker")
    require("note: Writing `" in driver_log and FINAL_PDF.name in driver_log,
            "bundled LaTeX driver log lacks its successful PDF write marker")

    provenance = json.loads(read_text(FINAL_QA / "paper_build_provenance.json"))
    require(provenance.get("schema") == "abc-paper-build-provenance-v1",
            "unexpected paper-build provenance schema")
    require(provenance.get("status") == "PASS", "paper build provenance is not PASS")
    source_hashes = provenance.get("paper_input_sha256")
    current_source_hashes = {
        relative_name(path): sha256(path) for path in paper_input_closure()
    }
    require(len(current_source_hashes) == 87,
            "recursive TeX source closure no longer has 87 files")
    require(source_hashes == current_source_hashes,
            "current recursive TeX source closure differs from the compiled closure")
    require(provenance.get("source_count") == len(current_source_hashes),
            "paper-build provenance source count mismatch")
    require(provenance.get("pdf_sha256") == pdf["sha256"],
            "paper-build provenance PDF digest mismatch")
    require(provenance.get("pdf_bytes") == pdf["bytes"],
            "paper-build provenance PDF byte count mismatch")
    require(provenance.get("driver_exit_code") == 0,
            "paper-build provenance driver exit was nonzero")
    require(
        provenance.get("driver_json_sha256") ==
        sha256(FINAL_QA / "compile_driver.json"),
        "paper-build provenance does not bind the current driver JSON",
    )
    require(
        provenance.get("driver_script_sha256") ==
        "59b215e91409dfcac531da2ad0ade5942ec2a94ae37ac61da66cfaa7dd773aac",
        "paper-build provenance compile-driver digest changed",
    )
    require(
        provenance.get("compiler") == driver.get("compiler") == "tectonic",
        "paper-build provenance compiler mismatch",
    )
    require(provenance.get("compiler_version") == "Tectonic 0.17.0",
            "paper-build provenance compiler version changed")
    require(provenance.get("inputs_stable_during_build") is True,
            "paper sources changed during the final build")

    seal = read_text(HERE / "PAPER_SEAL.md")
    require(re.search(r"(?m)^Status: \*\*PASS\*\*\s*$", seal) is not None,
            "PAPER_SEAL.md is not final PASS evidence")
    require(pdf["sha256"] in seal, "PAPER_SEAL.md omits the current PDF digest")
    require(f"{pdf['pages']} pages" in seal, "PAPER_SEAL.md omits the page count")
    require(f"{pdf['bytes']} bytes" in seal, "PAPER_SEAL.md omits the byte count")
    validation = read_text(HERE / "VALIDATION.md")
    require(re.search(r"(?m)^Status: \*\*PASS\*\*\s*$", validation) is not None,
            "VALIDATION.md is not final PASS evidence")
    require(pdf["sha256"] in validation and f"{pdf['pages']} pages" in validation,
            "VALIDATION.md is stale relative to the final PDF")
    pdf_validation = read_text(FINAL_QA / "PDF_VALIDATION.md")
    require(re.search(r"(?m)^Status: \*\*PASS\*\*\s*$", pdf_validation) is not None,
            "PDF_VALIDATION.md is not final PASS evidence")
    require(pdf["sha256"] in pdf_validation and f"{pdf['pages']} pages" in pdf_validation,
            "PDF_VALIDATION.md is stale relative to the final PDF")
    return {
        "status": "PASS",
        "artifact_sha256": {
            name: sha256(repo_path(name))
            for name in FINAL_PAPER_ARTIFACT_RELATIVE_PATHS
        },
        "pdf_sha256": pdf["sha256"],
        "pdf_bytes": pdf["bytes"],
        "page_count": pdf["pages"],
        "rendered_page_count": render["rasterPages"],
        "contact_sheet_count": len(contacts),
        "author": pdf["author"],
        "title": pdf["title"],
        "encrypted": pdf["encrypted"],
        "required_text_targets": len(targets),
        "latex_warning_gate": "PASS",
    }


def main() -> int:
    VERIFICATION_SUMMARY.unlink(missing_ok=True)
    if sys.flags.optimize != 0:
        raise RuntimeError("checkpoint verification forbids Python -O/PYTHONOPTIMIZE")
    initial_sealed_inputs_sha256 = {
        name: sha256(repo_path(name))
        for name in expected_manifest_names(include_verification_summary=False)
    }
    parser_regressions = check_parser_regressions()
    inventory, names_by_module = check_source_inventory()
    runner = check_run_summary()
    formal_logs = check_formal_logs(names_by_module)
    endpoint = check_endpoint_computation()
    independent_endpoint = check_independent_endpoint_audit()
    successor = check_successor_computation()
    pbt = check_pbt_computation()
    authored_artifacts = check_hygiene_and_imports()
    paper_seal = check_paper_seal()
    sealed_inputs_sha256 = {
        name: sha256(repo_path(name))
        for name in expected_manifest_names(include_verification_summary=False)
    }
    require(
        sealed_inputs_sha256 == initial_sealed_inputs_sha256,
        "a sealed input changed while verify_checkpoint.py was running",
    )
    summary = {
        "schema": "abc-incidence-endpoint-successor-pbt-verification-v3",
        "parser_regressions": parser_regressions,
        "formal_inventory": inventory,
        "runner": runner,
        "formal_logs": formal_logs,
        "endpoint_computation": endpoint,
        "independent_endpoint_hall_audit": independent_endpoint,
        "successor_computation": successor,
        "pbt_computation": pbt,
        "authored_artifacts": authored_artifacts,
        "paper_seal": paper_seal,
        "sealed_inputs_sha256": sealed_inputs_sha256,
        "status": "PASS",
    }
    atomic_json(VERIFICATION_SUMMARY, summary)
    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        VERIFICATION_SUMMARY.unlink(missing_ok=True)
        print(f"FAIL: {type(exc).__name__}: {exc}", file=sys.stderr)
        raise
