#!/usr/bin/env python3
"""Reproduce the signed/slow-slack/correlated/admissible checkpoint.

The validator deliberately has a narrow scope.  It freezes every local Lean
source together with the Lake configuration, parses every theorem and lemma in
the four continuation modules, deterministically generates one independent
``#print axioms`` command per proof declaration, compiles the four modules and
the generated audit, and rebuilds the aggregate target.

The generated audit recompiles an exact amalgamation of the four source files
instead of merely importing them.  This is necessary to name ``private`` proof
declarations: Lean hides their generated names outside the source file.  The
audit file is regenerated and byte-compared on every replay.
"""

from __future__ import annotations

import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import shutil
import subprocess
import sys
from typing import Any


PACKAGE_ROOT = Path(__file__).resolve().parent
REPO_ROOT = PACKAGE_ROOT.parents[2]
LEAN_ROOT = REPO_ROOT / "Lean"
PACKAGE_NAME = PACKAGE_ROOT.name
LIVE_OUTPUT_ROOT = REPO_ROOT / "tmp" / "verification" / PACKAGE_NAME

MODULES = (
    "AffineSignedRayCanonicalCaps20260901",
    "IUTAdmissibleScalingOrderIndex20260901",
    "MersenneCriticalSlowSlackGate20260901",
    "PellLucasCorrelatedAllOrderExclusion20260901",
)
MODULE_PATHS = tuple(
    f"Lean/IUTThreeClosures/{module}.lean" for module in MODULES
)
CONFIG_PATHS = (
    ".gitattributes",
    "Lean/lean-toolchain",
    "Lean/lakefile.toml",
    "Lean/lake-manifest.json",
)
EXTRA_INPUT_PATHS = (
    "README.md",
    "Lean/IUTThreeClosures.lean",
    "Lean/RESEARCH_STATUS.md",
    "Lean/RESEARCH_ROUTE_REGISTRY.md",
    "research/ABC_AFFINE_SIGNED_RAY_CANONICAL_CAPS_2026_09_01.md",
    "research/ABC_IUT_ADMISSIBLE_SCALING_ORDER_INDEX_2026_09_02.md",
    "research/ABC_MERSENNE_CRITICAL_SLOW_SLACK_GATE_2026_09_01.md",
    "research/ABC_PELL_LUCAS_CORRELATED_ALL_ORDER_EXCLUSION_2026_09_01.md",
    "research/ABC_MULTI_ROUTE_SIGNED_SLOW_CORRELATED_ADMISSIBLE_2026_09_02.md",
    "research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf",
    "research/sources/iut_lana_2026_09_01/LANA_report_202607.tex",
    "paper/ChatGPT_ABC_Uniformity_2026.tex",
    "paper/affine_signed_ray_canonical_caps_2026.tex",
    "paper/iut_admissible_scaling_order_index_2026.tex",
    "paper/mersenne_critical_slow_slack_2026.tex",
    "paper/pell_lucas_correlated_all_order_exclusion_2026.tex",
    "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf",
)
EXTRA_INPUT_DIRECTORIES = (
    "research/computation/2026_09_01_affine_signed_ray_caps",
    "research/computation/2026_09_01_mersenne_critical_slow_slack",
    "research/computation/2026_09_01_pell_lucas_correlated_all_order",
    "research/sources/iut_admissible_scaling_order_index_2026_09_02",
    "research/sources/mersenne_critical_slow_slack_2026_09_01",
    "output/pdf/ChatGPT_ABC_Signed_SlowSlack_Correlated_Admissible_Index_2026_09_02_QA",
)
EXPECTED_AGGREGATE_JOBS = 9233
EVIDENCE_REPLAY_OUTPUT = "evidence-replay.json"
EXPECTED_EVIDENCE_VERIFIED = {
    "affine": {
        "armCaptures": 43403,
        "catalogueDeletion": {"allDivisorWeight": 972496, "ownerMass": 1072},
        "cubicLedgers": 1776807,
        "directions": 15840,
        "quadraticLedgers": 2390018,
        "selectedM10Large": 110,
        "selectedM10Repeated": 12,
        "stressLarge": 113,
        "stressNonarm": 1,
        "stressRepeated": 9,
        "verificationSha256": "4bf54f7fad2a50fd16bd1be56f844da1e8d2e1f8536ec3bcd2d806fea96cf60b",
    },
    "hashEntries": {
        "affine": 6,
        "iut": 15,
        "mersenneComputationAndSource": 6,
        "pell": 14,
        "total": 41,
    },
    "iut": {
        "buildJobs": 8767,
        "commit": "c65b28c9f9631635e742294c3a5df15759e7c74c",
        "frozenEntries": 13,
        "patchFiles": 3,
        "sealEntries": 15,
    },
    "mersenne": {
        "characterIdentity": True,
        "oddPrimeCount": 9591,
        "primeCount": 9592,
        "retirementWitness": 1093,
        "scanLimit": 100000,
        "wieferichRows": [
            {"depth": 2, "multiplier": 3, "order": 364, "prime": 1093},
            {"depth": 2, "multiplier": 2, "order": 1755, "prime": 3511},
        ],
    },
    "pell": {
        "coefficientPairs": 138675,
        "depthThreeHits": 0,
        "indexElevenMixedSigns": True,
        "largestPrimeIndex": 271,
        "polynomialChecks": 228,
        "primeCandidateTests": 527352,
        "primeIndices": 57,
        "repeatedHits": [
            {"channel": "B", "depth": "exactly_2", "index": 7, "prime": 13}
        ],
        "verificationSha256": "1c2d884f3ca05b04f7724823fd517d86de9a8d791e1bd815fe3ab79f8ad2e82d",
    },
    "schema": "abc-signed-slow-correlated-admissible-evidence-v1",
    "status": "PASS",
}
ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}
DECLARATION_KINDS = (
    "theorem",
    "lemma",
    "def",
    "abbrev",
    "structure",
    "class",
    "inductive",
    "instance",
)
EXPECTED_MODULE_COUNTS = {
    "AffineSignedRayCanonicalCaps20260901": {
        "theorem": 41,
        "lemma": 0,
        "def": 4,
        "abbrev": 0,
        "structure": 0,
        "class": 0,
        "inductive": 0,
        "instance": 0,
    },
    "IUTAdmissibleScalingOrderIndex20260901": {
        "theorem": 11,
        "lemma": 0,
        "def": 2,
        "abbrev": 0,
        "structure": 0,
        "class": 0,
        "inductive": 0,
        "instance": 0,
    },
    "MersenneCriticalSlowSlackGate20260901": {
        "theorem": 16,
        "lemma": 0,
        "def": 4,
        "abbrev": 0,
        "structure": 0,
        "class": 0,
        "inductive": 0,
        "instance": 0,
    },
    "PellLucasCorrelatedAllOrderExclusion20260901": {
        "theorem": 22,
        "lemma": 0,
        "def": 6,
        "abbrev": 0,
        "structure": 0,
        "class": 0,
        "inductive": 0,
        "instance": 0,
    },
}
EXPECTED_TOTAL_COUNTS = {
    "theorem": 90,
    "lemma": 0,
    "def": 16,
    "abbrev": 0,
    "structure": 0,
    "class": 0,
    "inductive": 0,
    "instance": 0,
}
EXPECTED_COUNTED_DECLARATIONS = 106
EXPECTED_PROOF_DECLARATIONS = 90
EXPECTED_PRIVATE_PROOF_DECLARATIONS = 0
EXPECTED_RECORDED_TOTALS = {
    **EXPECTED_TOTAL_COUNTS,
    "countedDeclarations": EXPECTED_COUNTED_DECLARATIONS,
    "proofDeclarations": EXPECTED_PROOF_DECLARATIONS,
    "privateProofDeclarations": EXPECTED_PRIVATE_PROOF_DECLARATIONS,
    "axiomReports": EXPECTED_PROOF_DECLARATIONS,
}
DRIVER_FILES = ("replay_evidence.py", "validate.py", "validate.ps1")
GENERATED_AUDIT = "axiom-audit.lean"
INPUT_MANIFEST = "input-manifest.json"
INVENTORY_FILE = "declaration-inventory.json"
VALIDATION_FILE = "validation-run.json"
SEAL_FILE = "SHA256SUMS"


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def canonical_repo_path(relative: str) -> Path:
    pure = PurePosixPath(relative)
    if (
        pure.is_absolute()
        or not pure.parts
        or any(part in {"", ".", ".."} for part in pure.parts)
        or "\\" in relative
    ):
        raise RuntimeError(f"noncanonical repository path: {relative!r}")
    candidate = (REPO_ROOT / Path(*pure.parts)).resolve()
    try:
        candidate.relative_to(REPO_ROOT)
    except ValueError as exc:
        raise RuntimeError(f"path escapes repository: {relative}") from exc
    return candidate


def tracked_local_lean_paths() -> set[str]:
    raw = subprocess.check_output(
        ["git", "-C", str(REPO_ROOT), "ls-files", "-z", "--", "Lean"],
    )
    paths: set[str] = set()
    for item in raw.split(b"\0"):
        if not item:
            continue
        relative = item.decode("utf-8")
        pure = PurePosixPath(relative)
        if (
            pure.suffix == ".lean"
            and len(pure.parts) >= 2
            and pure.parts[0] == "Lean"
            and pure.parts[1] not in {".lake", "verification"}
        ):
            paths.add(relative)
    return paths


def configured_input_paths() -> tuple[str, ...]:
    paths = tracked_local_lean_paths()
    paths.update(MODULE_PATHS)
    paths.update(CONFIG_PATHS)
    paths.update(EXTRA_INPUT_PATHS)
    for directory in EXTRA_INPUT_DIRECTORIES:
        root = canonical_repo_path(directory)
        if not root.is_dir():
            raise RuntimeError(f"missing validation input directory: {directory}")
        paths.update(
            path.relative_to(REPO_ROOT).as_posix()
            for path in root.rglob("*")
            if path.is_file()
        )
    missing = [path for path in sorted(paths) if not canonical_repo_path(path).is_file()]
    if missing:
        raise RuntimeError("missing validation input: " + ", ".join(missing))
    return tuple(sorted(paths))


def input_records() -> list[dict[str, Any]]:
    records: list[dict[str, Any]] = []
    for relative in configured_input_paths():
        path = canonical_repo_path(relative)
        records.append(
            {
                "path": relative,
                "bytes": path.stat().st_size,
                "sha256": sha256(path),
            }
        )
    return records


def driver_records() -> list[dict[str, Any]]:
    records: list[dict[str, Any]] = []
    for name in DRIVER_FILES:
        path = PACKAGE_ROOT / name
        if not path.is_file():
            raise RuntimeError(f"missing validation driver: {name}")
        records.append(
            {"path": name, "bytes": path.stat().st_size, "sha256": sha256(path)}
        )
    return records


def lake_dependency_records() -> dict[str, Any]:
    manifest_path = LEAN_ROOT / "lake-manifest.json"
    data = json.loads(manifest_path.read_text(encoding="utf-8"))
    packages = data.get("packages")
    if not isinstance(packages, list) or not packages:
        raise RuntimeError("lake-manifest.json has no packages")
    records: list[dict[str, str]] = []
    for package in packages:
        if not isinstance(package, dict) or package.get("type") != "git":
            raise RuntimeError("every Lake dependency must be Git-pinned")
        name = package.get("name")
        revision = package.get("rev")
        url = package.get("url")
        if not all(isinstance(x, str) and x for x in (name, revision, url)):
            raise RuntimeError("malformed Lake Git dependency")
        directory = name.removeprefix("«").removesuffix("»")
        root = LEAN_ROOT / ".lake" / "packages" / directory
        if not root.is_dir():
            raise RuntimeError(f"missing Lake dependency checkout: {directory}")
        head = subprocess.check_output(
            ["git", "-C", str(root), "rev-parse", "HEAD"], text=True
        ).strip()
        if head != revision:
            raise RuntimeError(
                f"Lake dependency revision mismatch for {directory}: {head} != {revision}"
            )
        status = subprocess.check_output(
            [
                "git",
                "-C",
                str(root),
                "status",
                "--porcelain=v1",
                "--untracked-files=all",
            ],
            text=True,
        ).strip()
        if status:
            raise RuntimeError(f"dirty Lake dependency checkout: {directory}")
        records.append(
            {"name": name, "directory": directory, "revision": revision, "url": url}
        )
    return {
        "manifestPath": "Lean/lake-manifest.json",
        "manifestSha256": sha256(manifest_path),
        "packages": records,
    }


def strip_lean_comments_and_strings(text: str) -> str:
    """Blank nested comments and literals while retaining line positions."""
    output: list[str] = []
    index = 0
    block_depth = 0
    line_comment = False
    in_string = False
    escaped = False
    while index < len(text):
        char = text[index]
        nxt = text[index + 1] if index + 1 < len(text) else ""
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
            index > 0 and (text[index - 1].isalnum() or text[index - 1] in "_'")
        ):
            # Blank character literals without misreading `\"` inside them.
            end = index + 1
            char_escaped = False
            found = False
            while end < len(text) and text[end] not in "\r\n":
                if char_escaped:
                    char_escaped = False
                elif text[end] == "\\":
                    char_escaped = True
                elif text[end] == "'" and end > index + 1:
                    found = True
                    break
                end += 1
            if found:
                output.extend(" " for _ in range(end - index + 1))
                index = end + 1
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
    if block_depth:
        raise RuntimeError("unterminated Lean block comment")
    if in_string:
        raise RuntimeError("unterminated Lean string")
    return "".join(output)


def strip_lean_attributes(text: str) -> str:
    output = list(text)
    index = 0
    while index + 1 < len(text):
        if text[index] != "@" or text[index + 1] != "[":
            index += 1
            continue
        depth = 1
        cursor = index + 2
        while cursor < len(text) and depth:
            if text[cursor] == "[":
                depth += 1
            elif text[cursor] == "]":
                depth -= 1
            cursor += 1
        if depth:
            raise RuntimeError("unterminated Lean attribute")
        for position in range(index, cursor):
            if output[position] not in "\r\n":
                output[position] = " "
        index = cursor
    return "".join(output)


MODIFIERS = r"(?P<modifiers>(?:(?:private|protected|noncomputable)\s+)*)"
DECLARATION_RE = re.compile(
    rf"(?m)^\s*{MODIFIERS}"
    r"(?P<kind>theorem|lemma|def|abbrev|structure|class|inductive|instance)\b"
)
NAMED_DECLARATION_RE = re.compile(
    rf"(?m)^\s*{MODIFIERS}"
    r"(?P<kind>theorem|lemma|def|abbrev|structure|class|inductive)\s+"
    r"(?P<name>[^\s:({\[]+)"
)
FORBIDDEN_DECLARATION_RE = re.compile(
    r"(?m)^\s*(?:(?:private|protected|noncomputable)\s+)*"
    r"(?P<kind>axiom|axioms|opaque|unsafe|partial|extern)\b"
)
SCOPE_RE = re.compile(
    r"(?m)^\s*(namespace\s+([^\s]+)|section(?:\s+[^\s]+)?|end(?:\s+[^\s]+)?)\s*$"
)
IMPORT_RE = re.compile(r"(?m)^\s*import\s+([^\s]+)\s*$")
PRINT_AXIOMS_LINE_RE = re.compile(r"(?m)^\s*#print\s+axioms\s+[^\s]+\s*$")


def qualify_name(name: str, namespace: tuple[str, ...]) -> str:
    if name.startswith("_root_."):
        return name[len("_root_.") :]
    components = tuple(part for part in name.split(".") if part)
    return ".".join((*namespace, *components))


def declarations_with_namespaces(clean: str) -> list[dict[str, Any]]:
    events: list[tuple[int, int, str, Any]] = []
    for match in SCOPE_RE.finditer(clean):
        command = match.group(1)
        if command.startswith("namespace"):
            events.append((match.start(), 0, "namespace", match.group(2)))
        elif command.startswith("section"):
            events.append((match.start(), 0, "section", None))
        else:
            events.append((match.start(), 0, "end", None))
    for match in NAMED_DECLARATION_RE.finditer(clean):
        events.append((match.start(), 1, "declaration", match))
    events.sort(key=lambda event: (event[0], event[1]))

    namespace: list[str] = []
    scopes: list[tuple[str, tuple[str, ...] | None]] = []
    declarations: list[dict[str, Any]] = []
    for _, _, event_kind, payload in events:
        if event_kind == "namespace":
            raw = str(payload)
            previous = tuple(namespace)
            if raw.startswith("_root_."):
                namespace.clear()
                raw = raw[len("_root_.") :]
            namespace.extend(part for part in raw.split(".") if part)
            scopes.append(("namespace", previous))
        elif event_kind == "section":
            scopes.append(("section", None))
        elif event_kind == "end":
            if not scopes:
                raise RuntimeError("unmatched Lean `end` while resolving declarations")
            scope_kind, previous = scopes.pop()
            if scope_kind == "namespace" and previous is not None:
                namespace[:] = previous
        else:
            match = payload
            if not isinstance(match, re.Match):
                raise AssertionError("invalid parser event")
            short_name = match.group("name")
            modifiers = match.group("modifiers").split()
            declarations.append(
                {
                    "kind": match.group("kind"),
                    "shortName": short_name,
                    "name": qualify_name(short_name, tuple(namespace)),
                    "private": "private" in modifiers,
                    "protected": "protected" in modifiers,
                    "line": clean.count("\n", 0, match.start()) + 1,
                }
            )
    if scopes:
        raise RuntimeError("unterminated Lean namespace or section")
    return declarations


def module_inventory(module: str) -> dict[str, Any]:
    path = LEAN_ROOT / "IUTThreeClosures" / f"{module}.lean"
    raw = path.read_text(encoding="utf-8")
    clean = strip_lean_comments_and_strings(raw)
    declaration_clean = strip_lean_attributes(clean)

    forbidden: list[str] = []
    for token in ("sorry", "admit", "native_decide", "sorryAx", "unsafe"):
        if re.search(rf"\b{re.escape(token)}\b", declaration_clean):
            forbidden.append(token)
    forbidden.extend(
        match.group("kind")
        for match in FORBIDDEN_DECLARATION_RE.finditer(declaration_clean)
    )
    if forbidden:
        raise RuntimeError(
            f"forbidden Lean source in {module}: {sorted(set(forbidden))}"
        )

    counts = {kind: 0 for kind in DECLARATION_KINDS}
    for match in DECLARATION_RE.finditer(declaration_clean):
        counts[match.group("kind")] += 1
    declarations = declarations_with_namespaces(declaration_clean)
    proof_declarations = [
        declaration
        for declaration in declarations
        if declaration["kind"] in {"theorem", "lemma"}
    ]
    proof_names = [str(declaration["name"]) for declaration in proof_declarations]
    if len(proof_names) != len(set(proof_names)):
        raise RuntimeError(f"duplicate theorem/lemma name in {module}")
    if len(proof_names) != counts["theorem"] + counts["lemma"]:
        raise RuntimeError(f"theorem/lemma parser count mismatch in {module}")
    return {
        "module": module,
        "path": f"Lean/IUTThreeClosures/{module}.lean",
        "bytes": path.stat().st_size,
        "sha256": sha256(path),
        "counts": counts,
        "countedDeclarations": sum(counts.values()),
        "proofDeclarations": proof_declarations,
    }


def verify_expected_inventories(inventories: list[dict[str, Any]]) -> None:
    module_names = [str(inventory.get("module")) for inventory in inventories]
    if module_names != list(MODULES):
        raise RuntimeError(
            f"declaration module order changed: {module_names} != {list(MODULES)}"
        )
    for inventory in inventories:
        module = str(inventory["module"])
        expected = EXPECTED_MODULE_COUNTS[module]
        actual = inventory.get("counts")
        if actual != expected:
            raise RuntimeError(
                f"declaration counts changed for {module}: {actual} != {expected}"
            )
        expected_counted = sum(expected.values())
        if inventory.get("countedDeclarations") != expected_counted:
            raise RuntimeError(
                f"counted declaration total changed for {module}: "
                f"{inventory.get('countedDeclarations')} != {expected_counted}"
            )
        proof_declarations = inventory.get("proofDeclarations")
        if not isinstance(proof_declarations, list):
            raise RuntimeError(f"malformed proof declaration list for {module}")
        expected_proofs = expected["theorem"] + expected["lemma"]
        if len(proof_declarations) != expected_proofs:
            raise RuntimeError(
                f"proof declaration count changed for {module}: "
                f"{len(proof_declarations)} != {expected_proofs}"
            )

    totals = {
        kind: sum(int(inventory["counts"][kind]) for inventory in inventories)
        for kind in DECLARATION_KINDS
    }
    if totals != EXPECTED_TOTAL_COUNTS:
        raise RuntimeError(
            f"total declaration counts changed: {totals} != {EXPECTED_TOTAL_COUNTS}"
        )
    counted = sum(totals.values())
    if counted != EXPECTED_COUNTED_DECLARATIONS:
        raise RuntimeError(
            f"counted declarations changed: "
            f"{counted} != {EXPECTED_COUNTED_DECLARATIONS}"
        )
    proofs = totals["theorem"] + totals["lemma"]
    if proofs != EXPECTED_PROOF_DECLARATIONS:
        raise RuntimeError(
            f"proof declarations changed: {proofs} != {EXPECTED_PROOF_DECLARATIONS}"
        )
    private_flags = [
        declaration.get("private")
        for inventory in inventories
        for declaration in inventory["proofDeclarations"]
    ]
    if any(type(flag) is not bool for flag in private_flags):
        raise RuntimeError("malformed private-proof flag in declaration inventory")
    private_proofs = sum(1 for flag in private_flags if flag)
    if private_proofs != EXPECTED_PRIVATE_PROOF_DECLARATIONS:
        raise RuntimeError(
            f"private proof declarations changed: "
            f"{private_proofs} != {EXPECTED_PRIVATE_PROOF_DECLARATIONS}"
        )


def all_inventories() -> list[dict[str, Any]]:
    inventories = [module_inventory(module) for module in MODULES]
    verify_expected_inventories(inventories)
    return inventories


def generated_audit_text(inventories: list[dict[str, Any]]) -> str:
    imports: list[str] = []
    bodies: list[str] = []
    for module in MODULES:
        path = LEAN_ROOT / "IUTThreeClosures" / f"{module}.lean"
        text = path.read_text(encoding="utf-8").replace("\r\n", "\n")
        for imported in IMPORT_RE.findall(strip_lean_comments_and_strings(text)):
            if imported not in imports:
                imports.append(imported)
        body = IMPORT_RE.sub("", text)
        body = PRINT_AXIOMS_LINE_RE.sub("", body)
        bodies.append(body.strip("\n"))

    lines = [
        "/-",
        "Generated by validate.py.  Do not edit by hand.",
        "",
        "This file recompiles the exact declaration bodies of the four checkpoint",
        "modules and issues one #print axioms command for every source theorem or",
        "lemma.  Recompilation in one file keeps private source names addressable.",
        "-/",
        *(f"import {name}" for name in imports),
        "",
    ]
    for module, body in zip(MODULES, bodies, strict=True):
        lines.extend(
            [
                f"/- BEGIN EXACT BODY: IUTThreeClosures/{module}.lean -/",
                body,
                f"/- END EXACT BODY: IUTThreeClosures/{module}.lean -/",
                "",
            ]
        )
    lines.extend(
        [
            "/- BEGIN GENERATED COMPLETE THEOREM/LEMMA AXIOM AUDIT -/",
        ]
    )
    for inventory in inventories:
        for declaration in inventory["proofDeclarations"]:
            lines.append(f"#print axioms {declaration['name']}")
    lines.extend(
        [
            "/- END GENERATED COMPLETE THEOREM/LEMMA AXIOM AUDIT -/",
            "",
        ]
    )
    return "\n".join(lines)


def write_text_exact(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8", newline="\n")


def freeze_inputs() -> None:
    if (PACKAGE_ROOT / SEAL_FILE).exists():
        raise RuntimeError("refusing to modify a sealed validation package")
    for stale in (PACKAGE_ROOT / VALIDATION_FILE, PACKAGE_ROOT / INVENTORY_FILE):
        stale.unlink(missing_ok=True)
    logs = PACKAGE_ROOT / "logs"
    if logs.exists():
        shutil.rmtree(logs)
    inventories = all_inventories()
    write_text_exact(PACKAGE_ROOT / GENERATED_AUDIT, generated_audit_text(inventories))
    write_text_exact(
        PACKAGE_ROOT / INPUT_MANIFEST,
        json.dumps(input_records(), indent=2, ensure_ascii=False) + "\n",
    )
    print(f"WROTE {PACKAGE_ROOT / INPUT_MANIFEST}")
    print(f"WROTE {PACKAGE_ROOT / GENERATED_AUDIT}")


def verify_frozen_inputs() -> dict[str, Any]:
    path = PACKAGE_ROOT / INPUT_MANIFEST
    if not path.is_file():
        raise RuntimeError("missing input-manifest.json; run -FreezeInputs first")
    frozen = json.loads(path.read_text(encoding="utf-8"))
    actual = input_records()
    if frozen != actual:
        frozen_by_path = {row["path"]: row for row in frozen}
        actual_by_path = {row["path"]: row for row in actual}
        changed = sorted(
            name
            for name in set(frozen_by_path) | set(actual_by_path)
            if frozen_by_path.get(name) != actual_by_path.get(name)
        )
        raise RuntimeError("frozen input mismatch: " + ", ".join(changed))
    return {
        "path": f"Lean/verification/{PACKAGE_NAME}/{INPUT_MANIFEST}",
        "entries": len(frozen),
        "sha256": sha256(path),
    }


def find_lake() -> str:
    lake = shutil.which("lake")
    if not lake:
        raise RuntimeError("lake was not found on PATH")
    return lake


def relative_to_repo(path: Path) -> str:
    return path.resolve().relative_to(REPO_ROOT).as_posix()


def run_logged(
    output_root: Path, name: str, command: list[str], cwd: Path
) -> tuple[dict[str, Any], str]:
    logs = output_root / "logs"
    logs.mkdir(parents=True, exist_ok=True)
    process = subprocess.run(
        command,
        cwd=cwd,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        encoding="utf-8",
        errors="replace",
        check=False,
    )
    cwd_label = relative_to_repo(cwd) or "."
    transcript = (
        f"WORKDIR: {cwd_label}\n"
        f"COMMAND: {subprocess.list2cmdline(command)}\n"
        f"{process.stdout}"
        f"EXIT_CODE: {process.returncode}\n"
    )
    log_path = logs / f"{name}.log"
    write_text_exact(log_path, transcript)
    write_text_exact(logs / f"{name}.log.exitcode", f"{process.returncode}\n")
    if process.returncode != 0:
        raise RuntimeError(f"{name} failed; inspect {log_path}")
    return (
        {
            "name": name,
            "exitCode": process.returncode,
            "log": relative_to_repo(log_path),
            "logSha256": sha256(log_path),
        },
        process.stdout,
    )


AXIOM_REPORT_RE = re.compile(
    r"'([^\r\n]+?)'\s+(?:does not depend on any axioms|depends on axioms:\s*\[(.*?)\])",
    flags=re.DOTALL,
)


def parse_axiom_audit(
    output: str, inventories: list[dict[str, Any]]
) -> tuple[list[dict[str, Any]], set[str]]:
    expected = [
        declaration
        for inventory in inventories
        for declaration in inventory["proofDeclarations"]
    ]
    reports = list(AXIOM_REPORT_RE.finditer(output))
    if len(reports) != len(expected):
        raise RuntimeError(
            f"axiom report count mismatch: reports={len(reports)}, expected={len(expected)}"
        )
    results: list[dict[str, Any]] = []
    union: set[str] = set()
    for declaration, report in zip(expected, reports, strict=True):
        source_name = str(declaration["name"])
        reported_name = report.group(1)
        if declaration["private"]:
            if not (
                reported_name.startswith("_private.")
                and reported_name.endswith("." + source_name)
            ):
                raise RuntimeError(
                    f"private axiom report mismatch: {source_name} -> {reported_name}"
                )
        elif reported_name != source_name:
            raise RuntimeError(
                f"axiom report mismatch: expected {source_name}, got {reported_name}"
            )
        body = report.group(2)
        axioms = [] if body is None else [
            item.strip() for item in body.split(",") if item.strip()
        ]
        unexpected = set(axioms) - ALLOWED_AXIOMS
        if unexpected:
            raise RuntimeError(
                f"unexpected axiom(s) for {source_name}: {sorted(unexpected)}"
            )
        union.update(axioms)
        results.append(
            {
                **declaration,
                "reportedConstant": reported_name,
                "axioms": sorted(set(axioms)),
            }
        )
    if "sorryAx" in output:
        raise RuntimeError("axiom audit output contains sorryAx")
    return results, union


def prepare_output_root(record: bool) -> Path:
    if record:
        if (PACKAGE_ROOT / SEAL_FILE).exists():
            raise RuntimeError("refusing to overwrite a sealed validation package")
        for stale in (PACKAGE_ROOT / VALIDATION_FILE, PACKAGE_ROOT / INVENTORY_FILE):
            stale.unlink(missing_ok=True)
        logs = PACKAGE_ROOT / "logs"
        if logs.exists():
            shutil.rmtree(logs)
        return PACKAGE_ROOT
    resolved = LIVE_OUTPUT_ROOT.resolve()
    allowed = (REPO_ROOT / "tmp" / "verification").resolve()
    try:
        resolved.relative_to(allowed)
    except ValueError as exc:
        raise RuntimeError("live output escapes tmp/verification") from exc
    if resolved.exists():
        shutil.rmtree(resolved)
    return resolved


def validate(record: bool) -> None:
    output_root = prepare_output_root(record)
    output_root.mkdir(parents=True, exist_ok=True)

    drivers_start = driver_records()
    inputs_start = verify_frozen_inputs()
    dependencies_start = lake_dependency_records()
    inventories = all_inventories()

    expected_audit = generated_audit_text(inventories)
    audit_path = PACKAGE_ROOT / GENERATED_AUDIT
    if not audit_path.is_file() or audit_path.read_text(encoding="utf-8") != expected_audit:
        raise RuntimeError("axiom-audit.lean is absent or not the deterministic source expansion")
    audit_start = {
        "path": f"Lean/verification/{PACKAGE_NAME}/{GENERATED_AUDIT}",
        "bytes": audit_path.stat().st_size,
        "sha256": sha256(audit_path),
    }

    aggregate_text = strip_lean_comments_and_strings(
        (LEAN_ROOT / "IUTThreeClosures.lean").read_text(encoding="utf-8")
    )
    for module in MODULES:
        if not re.search(
            rf"(?m)^\s*import\s+IUTThreeClosures\.{re.escape(module)}\s*$",
            aggregate_text,
        ):
            raise RuntimeError(f"aggregate import missing: {module}")

    lake = find_lake()
    direct_runs: list[dict[str, Any]] = []
    for module in MODULES:
        run, output = run_logged(
            output_root,
            f"{module}-direct",
            [lake, "env", "lean", "-DwarningAsError=true",
             f"IUTThreeClosures/{module}.lean"],
            LEAN_ROOT,
        )
        run["warnings"] = len(re.findall(r"(?im)\bwarning:", output))
        if "sorryAx" in output:
            raise RuntimeError(f"{module} direct compiler output contains sorryAx")
        direct_runs.append(run)

    audit_run, audit_output = run_logged(
        output_root,
        "axiom-audit",
        [lake, "env", "lean", "-DwarningAsError=true",
         relative_to_repo(audit_path)[len("Lean/") :]],
        LEAN_ROOT,
    )
    audit_run["warnings"] = len(re.findall(r"(?im)\bwarning:", audit_output))
    audited_declarations, axiom_union = parse_axiom_audit(audit_output, inventories)

    by_name = {row["name"]: row for row in audited_declarations}
    for inventory in inventories:
        inventory["proofDeclarations"] = [
            by_name[declaration["name"]]
            for declaration in inventory["proofDeclarations"]
        ]
        inventory["axiomUnion"] = sorted(
            {
                axiom
                for declaration in inventory["proofDeclarations"]
                for axiom in declaration["axioms"]
            }
        )

    evidence_output_path = output_root / EVIDENCE_REPLAY_OUTPUT
    evidence_run, evidence_output = run_logged(
        output_root,
        "four-route-evidence-replay",
        [
            sys.executable,
            "-B",
            str(PACKAGE_ROOT / "replay_evidence.py"),
            "--output",
            str(evidence_output_path),
        ],
        REPO_ROOT,
    )
    evidence_document = json.loads(evidence_output_path.read_text(encoding="utf-8"))
    if evidence_document != EXPECTED_EVIDENCE_VERIFIED:
        raise RuntimeError("four-route evidence replay document changed")
    if not evidence_output.startswith("PASS evidence replay:"):
        raise RuntimeError("four-route evidence replay lacks its exact PASS marker")
    evidence_run["output"] = relative_to_repo(evidence_output_path)
    evidence_run["outputSha256"] = sha256(evidence_output_path)
    evidence_run["verified"] = evidence_document

    aggregate_run, aggregate_output = run_logged(
        output_root,
        "aggregate-lake-build",
        [lake, "build", "IUTThreeClosures"],
        LEAN_ROOT,
    )
    match = re.search(
        r"Build completed successfully \((\d+) jobs\)\.", aggregate_output
    )
    if not match:
        raise RuntimeError("aggregate build success marker is absent")
    aggregate_jobs = int(match.group(1))
    if aggregate_jobs != EXPECTED_AGGREGATE_JOBS:
        raise RuntimeError(
            f"aggregate job count changed: {aggregate_jobs} != {EXPECTED_AGGREGATE_JOBS}"
        )
    aggregate_run["jobs"] = aggregate_jobs
    aggregate_run["warnings"] = len(re.findall(r"(?im)\bwarning:", aggregate_output))

    if driver_records() != drivers_start:
        raise RuntimeError("validation driver changed during validation")
    if verify_frozen_inputs() != inputs_start:
        raise RuntimeError("frozen inputs changed during validation")
    if lake_dependency_records() != dependencies_start:
        raise RuntimeError("Lake dependency state changed during validation")
    if sha256(audit_path) != audit_start["sha256"]:
        raise RuntimeError("generated axiom audit changed during validation")

    totals = {kind: sum(row["counts"][kind] for row in inventories) for kind in DECLARATION_KINDS}
    proof_count = totals["theorem"] + totals["lemma"]
    if proof_count != len(audited_declarations):
        raise RuntimeError("not every theorem/lemma has exactly one axiom report")
    private_proofs = sum(1 for row in audited_declarations if row["private"])

    inventory_path = output_root / INVENTORY_FILE
    inventory_document = {
        "schema": "abc-signed-slow-correlated-admissible-inventory-v1",
        "modules": inventories,
        "totals": {
            **totals,
            "countedDeclarations": sum(totals.values()),
            "proofDeclarations": proof_count,
            "privateProofDeclarations": private_proofs,
            "axiomReports": len(audited_declarations),
        },
        "axiomUnion": sorted(axiom_union),
    }
    write_text_exact(
        inventory_path,
        json.dumps(inventory_document, indent=2, ensure_ascii=False) + "\n",
    )

    result = {
        "schema": "abc-signed-slow-correlated-admissible-validation-v1",
        "status": "PASS",
        "completedUtc": datetime.now(timezone.utc).isoformat(),
        "gitHeadBeforeCheckpointCommit": subprocess.check_output(
            ["git", "-C", str(REPO_ROOT), "rev-parse", "HEAD"], text=True
        ).strip(),
        "toolVersions": {
            "python": sys.version.splitlines()[0],
            "lake": subprocess.check_output(
                [lake, "--version"], cwd=LEAN_ROOT, text=True
            ).strip(),
            "lean": subprocess.check_output(
                [lake, "env", "lean", "--version"], cwd=LEAN_ROOT, text=True
            ).strip(),
        },
        "validationDrivers": drivers_start,
        "frozenInputs": inputs_start,
        "lakeDependencies": dependencies_start,
        "generatedAudit": audit_start,
        "inventory": {
            "path": relative_to_repo(inventory_path),
            "sha256": sha256(inventory_path),
        },
        "modules": [
            {
                "module": row["module"],
                "path": row["path"],
                "bytes": row["bytes"],
                "sha256": row["sha256"],
                "counts": row["counts"],
                "proofDeclarations": len(row["proofDeclarations"]),
                "privateProofDeclarations": sum(
                    1 for declaration in row["proofDeclarations"] if declaration["private"]
                ),
                "axiomUnion": row["axiomUnion"],
            }
            for row in inventories
        ],
        "totals": inventory_document["totals"],
        "axiomUnion": sorted(axiom_union),
        "directRuns": direct_runs,
        "axiomAuditRun": audit_run,
        "computationReplay": evidence_run,
        "aggregateBuild": aggregate_run,
        "scope": {
            "provesOrDisprovesStandardABC": False,
            "finiteOrConditionalClaimsUpgraded": False,
        },
    }
    write_text_exact(
        output_root / VALIDATION_FILE,
        json.dumps(result, indent=2, ensure_ascii=False) + "\n",
    )
    summary = (
        "PASS\n"
        f"modules={len(MODULES)}\n"
        f"theorems={totals['theorem']}\n"
        f"lemmas={totals['lemma']}\n"
        f"proof_declarations={proof_count}\n"
        f"private_proof_declarations={private_proofs}\n"
        f"axiom_reports={len(audited_declarations)}\n"
        f"counted_declarations={sum(totals.values())}\n"
        f"axiom_union={','.join(sorted(axiom_union))}\n"
        f"evidence_hash_entries={EXPECTED_EVIDENCE_VERIFIED['hashEntries']['total']}\n"
        f"affine_cubic_ledgers={EXPECTED_EVIDENCE_VERIFIED['affine']['cubicLedgers']}\n"
        f"mersenne_odd_primes={EXPECTED_EVIDENCE_VERIFIED['mersenne']['oddPrimeCount']}\n"
        f"pell_prime_indices={EXPECTED_EVIDENCE_VERIFIED['pell']['primeIndices']}\n"
        f"iut_recorded_build_jobs={EXPECTED_EVIDENCE_VERIFIED['iut']['buildJobs']}\n"
        f"aggregate_jobs={aggregate_jobs}\n"
        "standard_abc_closed=false\n"
    )
    write_text_exact(output_root / "logs" / "SUMMARY.txt", summary)
    print(summary, end="")


def package_files_without_seal() -> list[Path]:
    files = [
        path
        for path in PACKAGE_ROOT.rglob("*")
        if path.is_file() and path.name != SEAL_FILE and "__pycache__" not in path.parts
    ]
    return sorted(files, key=lambda path: path.relative_to(PACKAGE_ROOT).as_posix())


def verify_recorded_structure() -> dict[str, Any]:
    required = [
        PACKAGE_ROOT / INPUT_MANIFEST,
        PACKAGE_ROOT / GENERATED_AUDIT,
        PACKAGE_ROOT / INVENTORY_FILE,
        PACKAGE_ROOT / VALIDATION_FILE,
        PACKAGE_ROOT / "logs" / "SUMMARY.txt",
    ]
    for path in required:
        if not path.is_file():
            raise RuntimeError(f"recorded package is incomplete: {path.name}")
    result = json.loads((PACKAGE_ROOT / VALIDATION_FILE).read_text(encoding="utf-8"))
    if result.get("status") != "PASS":
        raise RuntimeError("recorded validation status is not PASS")
    if result.get("schema") != "abc-signed-slow-correlated-admissible-validation-v1":
        raise RuntimeError("recorded validation schema mismatch")
    recorded_modules = result.get("modules", [])
    if [row.get("module") for row in recorded_modules] != list(MODULES):
        raise RuntimeError("recorded module inventory mismatch")
    for row in recorded_modules:
        module = row["module"]
        expected_counts = EXPECTED_MODULE_COUNTS[module]
        if row.get("counts") != expected_counts:
            raise RuntimeError(f"recorded declaration counts changed for {module}")
        if row.get("proofDeclarations") != (
            expected_counts["theorem"] + expected_counts["lemma"]
        ):
            raise RuntimeError(f"recorded proof declaration count changed for {module}")
        if row.get("privateProofDeclarations") != 0:
            raise RuntimeError(f"recorded private proof count changed for {module}")
    if result.get("aggregateBuild", {}).get("jobs") != EXPECTED_AGGREGATE_JOBS:
        raise RuntimeError("recorded aggregate job count mismatch")
    totals = result.get("totals", {})
    if totals != EXPECTED_RECORDED_TOTALS:
        raise RuntimeError("recorded declaration totals changed")
    if totals.get("axiomReports") != totals.get("proofDeclarations"):
        raise RuntimeError("recorded axiom coverage is not one-for-one")
    if set(result.get("axiomUnion", [])) - ALLOWED_AXIOMS:
        raise RuntimeError("recorded validation contains an unexpected axiom")
    inventory_path = PACKAGE_ROOT / INVENTORY_FILE
    if result.get("inventory", {}).get("sha256") != sha256(inventory_path):
        raise RuntimeError("recorded declaration inventory hash mismatch")
    inventory_document = json.loads(inventory_path.read_text(encoding="utf-8"))
    if inventory_document.get("schema") != (
        "abc-signed-slow-correlated-admissible-inventory-v1"
    ):
        raise RuntimeError("recorded declaration inventory schema mismatch")
    inventory_modules = inventory_document.get("modules")
    if not isinstance(inventory_modules, list):
        raise RuntimeError("recorded declaration inventory modules are malformed")
    verify_expected_inventories(inventory_modules)
    if inventory_document.get("totals") != EXPECTED_RECORDED_TOTALS:
        raise RuntimeError("recorded declaration inventory totals changed")
    expected_runs = [
        *(f"{module}-direct" for module in MODULES),
        "axiom-audit",
        "four-route-evidence-replay",
        "aggregate-lake-build",
    ]
    runs = [
        *result.get("directRuns", []),
        result.get("axiomAuditRun", {}),
        result.get("computationReplay", {}),
        result.get("aggregateBuild", {}),
    ]
    if [run.get("name") for run in runs] != expected_runs:
        raise RuntimeError("recorded run inventory mismatch")
    for run in runs:
        name = run["name"]
        log = PACKAGE_ROOT / "logs" / f"{name}.log"
        exit_file = PACKAGE_ROOT / "logs" / f"{name}.log.exitcode"
        if not log.is_file() or not exit_file.is_file():
            raise RuntimeError(f"recorded run artifacts missing: {name}")
        if sha256(log) != run.get("logSha256"):
            raise RuntimeError(f"recorded log hash mismatch: {name}")
        if exit_file.read_bytes() != b"0\n":
            raise RuntimeError(f"recorded exit code is not exact: {name}")
        if not log.read_text(encoding="utf-8").endswith("EXIT_CODE: 0\n"):
            raise RuntimeError(f"recorded log lacks successful trailer: {name}")
    evidence_run = result.get("computationReplay", {})
    evidence_output = PACKAGE_ROOT / EVIDENCE_REPLAY_OUTPUT
    if not evidence_output.is_file():
        raise RuntimeError("recorded four-route replay output is absent")
    if evidence_run.get("output") != relative_to_repo(evidence_output):
        raise RuntimeError("recorded four-route replay output path mismatch")
    if evidence_run.get("outputSha256") != sha256(evidence_output):
        raise RuntimeError("recorded four-route replay output hash mismatch")
    if evidence_run.get("verified") != EXPECTED_EVIDENCE_VERIFIED:
        raise RuntimeError("recorded four-route replay counts changed")
    return result


def seal_package() -> None:
    seal = PACKAGE_ROOT / SEAL_FILE
    if seal.exists():
        raise RuntimeError("refusing to overwrite existing SHA256SUMS")
    result = verify_recorded_structure()
    lines = [
        f"{sha256(path)}  {path.relative_to(PACKAGE_ROOT).as_posix()}"
        for path in package_files_without_seal()
    ]
    write_text_exact(seal, "\n".join(lines) + "\n")
    print(
        f"SEALED files={len(lines)} proofs={result['totals']['proofDeclarations']} "
        f"jobs={result['aggregateBuild']['jobs']}"
    )


def verify_sealed_package() -> None:
    seal = PACKAGE_ROOT / SEAL_FILE
    if not seal.is_file():
        raise RuntimeError("missing SHA256SUMS")
    expected: list[str] = []
    previous = ""
    for line in seal.read_text(encoding="utf-8").splitlines():
        match = re.fullmatch(r"([0-9a-f]{64})  (.+)", line)
        if not match:
            raise RuntimeError(f"malformed SHA256SUMS line: {line!r}")
        digest, relative = match.groups()
        if previous and relative <= previous:
            raise RuntimeError("SHA256SUMS paths are not unique ordinal order")
        previous = relative
        pure = PurePosixPath(relative)
        if pure.is_absolute() or any(part in {"", ".", ".."} for part in pure.parts):
            raise RuntimeError(f"noncanonical sealed path: {relative}")
        path = PACKAGE_ROOT.joinpath(*pure.parts)
        if not path.is_file() or sha256(path) != digest:
            raise RuntimeError(f"sealed file mismatch: {relative}")
        expected.append(relative)
    actual = [
        path.relative_to(PACKAGE_ROOT).as_posix()
        for path in package_files_without_seal()
    ]
    if actual != expected:
        raise RuntimeError("sealed package file set mismatch")
    result = verify_recorded_structure()
    print(
        f"PASS sealed_files={len(expected)} modules={len(MODULES)} "
        f"proofs={result['totals']['proofDeclarations']} "
        f"jobs={result['aggregateBuild']['jobs']}"
    )


def main() -> None:
    parser = argparse.ArgumentParser()
    modes = parser.add_mutually_exclusive_group()
    modes.add_argument("--freeze-inputs", action="store_true")
    modes.add_argument("--record", action="store_true")
    modes.add_argument("--seal-package", action="store_true")
    modes.add_argument("--verify-package", action="store_true")
    args = parser.parse_args()
    if sys.flags.optimize != 0:
        raise RuntimeError("Python optimization is forbidden")
    if args.freeze_inputs:
        freeze_inputs()
    elif args.seal_package:
        seal_package()
    elif args.verify_package:
        verify_sealed_package()
    else:
        validate(record=args.record)


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        raise
