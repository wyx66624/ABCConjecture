#!/usr/bin/env python3
"""Reproduce the actual-Haar/sigma-one/catalogue/curvature checkpoint.

The validator deliberately has a narrow scope.  It freezes every local Lean
source together with the Lake configuration, parses every theorem and lemma in
the four continuation modules, deterministically generates one independent
``#print axioms`` command per proof declaration, compiles the four modules and
the generated audit, and rebuilds the aggregate target.

The generated audit imports the four compiled modules and prints the axiom
dependencies of every public proof declaration. Private proofs are forbidden,
so every report names the exact exported constant compiled from its source.
The audit file is regenerated and byte-compared on every replay.
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
    "IUTActualHaarAdmissibleOrbit20260902",
    "MersenneSigmaOneExactOrderCoupling20260902",
    "AffineInversePeriodCatalogueNovelty20260902",
    "PellLucasFactorQuotientProjectiveCoupling20260902",
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
    "Lean/IUTThreeClosures/IUTActualHaarAdmissibleOrbit20260902AxiomAudit.lean",
    "Lean/IUTThreeClosures/PellLucasFactorQuotientProjectiveCoupling20260902AxiomAudit.lean",
    "research/ABC_IUT_ACTUAL_HAAR_ADMISSIBLE_ORBIT_2026_09_02.md",
    "research/ABC_MERSENNE_SIGMA_ONE_EXACT_ORDER_COUPLING_2026_09_02.md",
    "research/ABC_AFFINE_INVERSE_PERIOD_CATALOGUE_NOVELTY_2026_09_02.md",
    "research/ABC_PELL_LUCAS_FACTOR_QUOTIENT_PROJECTIVE_COUPLING_2026_09_02.md",
    "research/ABC_MULTI_ROUTE_ACTUAL_HAAR_SIGMA_ONE_CATALOGUE_CURVATURE_2026_09_02.md",
    "research/ABC_CHECKPOINT_ADVERSARIAL_AUDIT_2026_09_02.md",
    "research/ABC_AFFINE_PELL_ADVERSARIAL_AUDIT_2026_09_02.md",
    "research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf",
    "research/sources/mersenne_prime_layer_radical_2026_09_01/Murty_Seguin_2019_Cyclotomic_Wieferich.pdf",
    "research/sources/mersenne_prime_layer_radical_2026_09_01/Murty_Seguin_2019_Cyclotomic_Wieferich.txt",
    "research/sources/mersenne_balanced_multiplier_depth_2026_09_01/Yamada_2006_p_adic_Fermat_quotient_bound.pdf",
    "research/sources/mersenne_balanced_multiplier_depth_2026_09_01/Yamada_2006_p_adic_Fermat_quotient_bound.txt",
    "research/sources/campana_counterexample_2026_08_31/Bilu_Hanrot_Voutier_RR3792_Primitive_Divisors.pdf",
    "research/computation/2026_09_01_pell_lucas_correlated_all_order/correlated_all_order_packet.json",
    "paper/ChatGPT_ABC_Uniformity_2026.tex",
    "paper/iut_actual_haar_admissible_orbit_2026.tex",
    "paper/mersenne_sigma_one_exact_order_coupling_2026.tex",
    "paper/affine_inverse_period_catalogue_novelty_2026.tex",
    "paper/pell_factor_quotient_projective_coupling_2026.tex",
    "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf",
)
EXTRA_INPUT_DIRECTORIES = (
    "paper",
    "research/computation/2026_09_02_iut_actual_haar_orbit",
    "research/computation/2026_09_02_mersenne_sigma_one",
    "research/computation/2026_09_02_affine_inverse_period_catalogue",
    "research/computation/2026_09_02_pell_factor_quotient_coupling",
    "output/pdf/ChatGPT_ABC_ActualHaar_SigmaOne_Catalogue_Curvature_2026_09_02_QA",
)
EXPECTED_AGGREGATE_JOBS = 9239
EVIDENCE_REPLAY_OUTPUT = "evidence-replay.json"
EXPECTED_EVIDENCE_VERIFIED = {'affine': {'canonicalTotals': {'admissible_selected': 755322,
                                'kernel_classes': 3885,
                                'large_labels': 7641,
                                'nonarm_labels': 34,
                                'parameter_cases': 6,
                                'repeated_labels': 631},
            'generalEulerCases': 48400,
            'occupancyBridgeCases': 10001,
            'primePowerCases': 588,
            'scriptRuns': 6,
            'subcriticalPeriod': 1,
            'subcriticalWeightOverD': '23392/23701',
            'verificationSha256': '29ace952fd6b2feea116f1f65e0e78439feba54d2c20b047dff8c7fdc1dce10e'},
 'hashEntries': {'affine': 19, 'iut': 3, 'mersenne': 6, 'pell': 15, 'total': 43},
 'iut': {'normalizationRows': 20,
         'normalizedPacketIdentity': True,
         'rawResidueDegreeTwoCounterexample': True,
         'verificationSha256': 'e7404985aa91505a61d284e63dd3bd542897a3b449f853385032c2495605bda2'},
 'mersenne': {'completeScanReplayed': True,
              'exactLogWindowChecks': 16,
              'factorProductEqualsPhi': True,
              'scanHits': [{'d': 364, 'p': 1093, 'r': 3}, {'d': 1755, 'p': 3511, 'r': 2}],
              'scanLimit': 1000000000,
              'scanPrimeCount': 50847534,
              'verificationSha256': 'ab4d3ae848cb5ab96d16a84e0b5fab1f86bc04db5853bb7cbae37ccab6992a69'},
 'pell': {'actualSquarefullPackets': 0,
          'endpointExactAndSharpRows': 57,
          'exactSimpleWitnesses': 57,
          'factorQuotientRows': 13,
          'largestPrimeIndex': 271,
          'localL3Counterexample': True,
          'packetSha256': 'c19ad636ad8f2cbd01e57b9a0141e3d56d46df194e85d3b29c48b462eedb59a9',
          'verificationSha256': '796e85a61e049e5d9ec55cfc9ce146bcab928b516e007679350fa7c9e4731df5'},
 'schema': 'abc-actual-haar-sigma-one-catalogue-curvature-evidence-v1',
 'status': 'PASS'}
ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}
EXPECTED_AXIOM_UNION = {"propext", "Classical.choice", "Quot.sound"}
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
    "IUTActualHaarAdmissibleOrbit20260902": {
        "theorem": 33,
        "lemma": 0,
        "def": 8,
        "abbrev": 0,
        "structure": 1,
        "class": 0,
        "inductive": 0,
        "instance": 0,
    },
    "MersenneSigmaOneExactOrderCoupling20260902": {
        "theorem": 19,
        "lemma": 0,
        "def": 6,
        "abbrev": 1,
        "structure": 1,
        "class": 0,
        "inductive": 0,
        "instance": 0,
    },
    "AffineInversePeriodCatalogueNovelty20260902": {
        "theorem": 26,
        "lemma": 0,
        "def": 0,
        "abbrev": 0,
        "structure": 0,
        "class": 0,
        "inductive": 0,
        "instance": 0,
    },
    "PellLucasFactorQuotientProjectiveCoupling20260902": {
        "theorem": 24,
        "lemma": 0,
        "def": 4,
        "abbrev": 0,
        "structure": 0,
        "class": 0,
        "inductive": 0,
        "instance": 0,
    },
}
EXPECTED_TOTAL_COUNTS = {
    "theorem": 102,
    "lemma": 0,
    "def": 18,
    "abbrev": 1,
    "structure": 2,
    "class": 0,
    "inductive": 0,
    "instance": 0,
}
EXPECTED_COUNTED_DECLARATIONS = 123
EXPECTED_PROOF_DECLARATIONS = 102
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
TEXT_INPUT_SUFFIXES = {
    ".bib",
    ".cpp",
    ".csv",
    ".exitcode",
    ".json",
    ".lean",
    ".log",
    ".md",
    ".ps1",
    ".py",
    ".sty",
    ".tex",
    ".toml",
    ".tsv",
    ".txt",
    ".yaml",
    ".yml",
}
EXPECTED_SCOPE = {
    "provesOrDisprovesStandardABC": False,
    "finiteOrConditionalClaimsUpgraded": False,
}


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
            if (
                path.is_file()
                and "__pycache__" not in path.parts
                and path.suffix.lower() != ".pyc"
            )
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


def read_exact(stream: Any, size: int) -> bytes:
    chunks: list[bytes] = []
    remaining = size
    while remaining:
        chunk = stream.read(remaining)
        if not chunk:
            raise RuntimeError("unexpected EOF from git cat-file --batch")
        chunks.append(chunk)
        remaining -= len(chunk)
    return b"".join(chunks)


def git_index_byte_check() -> dict[str, Any]:
    """Compare every frozen worktree byte string with its staged Git blob."""
    manifest_path = PACKAGE_ROOT / INPUT_MANIFEST
    if not manifest_path.is_file():
        raise RuntimeError("missing input-manifest.json for Git index check")
    rows = json.loads(manifest_path.read_text(encoding="utf-8"))
    if not isinstance(rows, list) or not rows:
        raise RuntimeError("input manifest is not a nonempty list")

    process = subprocess.Popen(
        ["git", "-C", str(REPO_ROOT), "cat-file", "--batch"],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    if process.stdin is None or process.stdout is None or process.stderr is None:
        process.kill()
        raise RuntimeError("failed to open git cat-file pipes")
    object_ledger = hashlib.sha256()
    total_bytes = 0
    try:
        for position, row in enumerate(rows):
            if not isinstance(row, dict):
                raise RuntimeError(f"malformed input manifest row {position}")
            relative = row.get("path")
            expected_bytes = row.get("bytes")
            expected_sha = row.get("sha256")
            if (
                not isinstance(relative, str)
                or not isinstance(expected_bytes, int)
                or expected_bytes < 0
                or not isinstance(expected_sha, str)
                or not re.fullmatch(r"[0-9a-f]{64}", expected_sha)
            ):
                raise RuntimeError(f"malformed input manifest row {position}")
            canonical_repo_path(relative)
            process.stdin.write(f":{relative}\n".encode("utf-8"))
            process.stdin.flush()
            header = process.stdout.readline()
            if not header:
                raise RuntimeError(f"missing Git index response for {relative}")
            if header.endswith(b" missing\n"):
                raise RuntimeError(f"frozen input is absent from Git index: {relative}")
            pieces = header.rstrip(b"\n").split(b" ")
            if len(pieces) != 3:
                raise RuntimeError(f"malformed Git index response for {relative}: {header!r}")
            object_id, object_type, size_bytes = pieces
            if object_type != b"blob" or not size_bytes.isdigit():
                raise RuntimeError(f"Git index entry is not a blob: {relative}")
            size = int(size_bytes)
            payload = read_exact(process.stdout, size)
            if read_exact(process.stdout, 1) != b"\n":
                raise RuntimeError(f"malformed Git batch delimiter for {relative}")
            digest = hashlib.sha256(payload).hexdigest()
            if size != expected_bytes or digest != expected_sha:
                raise RuntimeError(
                    f"Git index byte mismatch for {relative}: "
                    f"bytes={size}/{expected_bytes}, sha256={digest}/{expected_sha}"
                )
            object_ledger.update(relative.encode("utf-8"))
            object_ledger.update(b"\0")
            object_ledger.update(object_id)
            object_ledger.update(b"\n")
            total_bytes += size
        process.stdin.close()
        return_code = process.wait()
        stderr = process.stderr.read().decode("utf-8", errors="replace")
        if return_code != 0 or stderr:
            raise RuntimeError(
                f"git cat-file --batch failed ({return_code}): {stderr}"
            )
    finally:
        if process.poll() is None:
            process.kill()
            process.wait()
    return {
        "status": "PASS",
        "entries": len(rows),
        "byteMatches": len(rows),
        "bytes": total_bytes,
        "objectIdLedgerSha256": object_ledger.hexdigest(),
    }


def frozen_text_hygiene() -> dict[str, Any]:
    checked: list[str] = []
    for relative in configured_input_paths():
        path = canonical_repo_path(relative)
        if (
            path.suffix.lower() not in TEXT_INPUT_SUFFIXES
            and not path.name.startswith("SHA256SUMS")
        ):
            continue
        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeDecodeError as exc:
            raise RuntimeError(f"configured text input is not UTF-8: {relative}") from exc
        if "\x00" in text:
            raise RuntimeError(f"NUL byte in configured text input: {relative}")
        if not relative.startswith("research/sources/"):
            for line_number, line in enumerate(text.splitlines(), start=1):
                trailing = re.search(r"[ \t]+$", line)
                if trailing is None:
                    continue
                suffix = trailing.group(0)
                if path.suffix.lower() == ".md" and suffix == "  ":
                    # Two spaces are Markdown's explicit hard-line-break syntax.
                    continue
                raise RuntimeError(
                    f"trailing whitespace in configured text input: "
                    f"{relative}:{line_number}"
                )
        if re.search(
            r"(?m)^(?:(?:<<<<<<<|\|\|\|\|\|\|\||>>>>>>>) |=======$)",
            text,
        ):
            raise RuntimeError(f"merge-conflict marker in configured text input: {relative}")
        checked.append(relative)
    return {"status": "PASS", "filesChecked": len(checked)}


def validation_summary(
    totals: dict[str, int],
    axiom_union: set[str],
    aggregate_jobs: int,
    index_entries: int,
) -> str:
    return (
        "PASS\n"
        f"modules={len(MODULES)}\n"
        f"theorems={totals['theorem']}\n"
        f"lemmas={totals['lemma']}\n"
        f"proof_declarations={totals['proofDeclarations']}\n"
        f"private_proof_declarations={totals['privateProofDeclarations']}\n"
        f"axiom_reports={totals['axiomReports']}\n"
        f"counted_declarations={totals['countedDeclarations']}\n"
        f"axiom_union={','.join(sorted(axiom_union))}\n"
        f"evidence_hash_entries={EXPECTED_EVIDENCE_VERIFIED['hashEntries']['total']}\n"
        f"iut_normalization_rows={EXPECTED_EVIDENCE_VERIFIED['iut']['normalizationRows']}\n"
        f"mersenne_scan_primes={EXPECTED_EVIDENCE_VERIFIED['mersenne']['scanPrimeCount']}\n"
        f"affine_script_runs={EXPECTED_EVIDENCE_VERIFIED['affine']['scriptRuns']}\n"
        f"pell_endpoint_rows={EXPECTED_EVIDENCE_VERIFIED['pell']['endpointExactAndSharpRows']}\n"
        "git_diff_check=pass\n"
        "git_cached_diff_check=pass\n"
        f"git_index_byte_matches={index_entries}\n"
        "frozen_text_hygiene=pass\n"
        f"aggregate_jobs={aggregate_jobs}\n"
        "standard_abc_closed=false\n"
    )


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
    lines = [
        "/-",
        "Generated by validate.py.  Do not edit by hand.",
        "",
        "This file imports the exact four compiled checkpoint modules and issues",
        "one #print axioms command for every exported source theorem or lemma.",
        "The validator separately hard-rejects private proof declarations.",
        "-/",
        *(f"import IUTThreeClosures.{module}" for module in MODULES),
        "",
    ]
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
    for stale in (
        PACKAGE_ROOT / VALIDATION_FILE,
        PACKAGE_ROOT / INVENTORY_FILE,
        PACKAGE_ROOT / EVIDENCE_REPLAY_OUTPUT,
    ):
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
    index_bytes_start = git_index_byte_check()
    if index_bytes_start["entries"] != inputs_start["entries"]:
        raise RuntimeError("Git index check does not cover every frozen input")
    text_hygiene_start = frozen_text_hygiene()
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
    cxx = shutil.which("g++")
    if cxx is None:
        raise RuntimeError("g++ is required for the complete Mersenne scan replay")
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
    if axiom_union != EXPECTED_AXIOM_UNION:
        raise RuntimeError(
            f"axiom union changed: {sorted(axiom_union)} != "
            f"{sorted(EXPECTED_AXIOM_UNION)}"
        )

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

    git_diff_run, git_diff_output = run_logged(
        output_root,
        "git-diff-check",
        ["git", "diff", "--check"],
        REPO_ROOT,
    )
    if git_diff_output:
        raise RuntimeError("git diff --check unexpectedly emitted output")

    git_cached_diff_run, git_cached_diff_output = run_logged(
        output_root,
        "git-cached-diff-check",
        ["git", "diff", "--cached", "--check"],
        REPO_ROOT,
    )
    if git_cached_diff_output:
        raise RuntimeError("git diff --cached --check unexpectedly emitted output")

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
    if git_index_byte_check() != index_bytes_start:
        raise RuntimeError("Git index bytes changed during validation")
    if frozen_text_hygiene() != text_hygiene_start:
        raise RuntimeError("frozen text hygiene changed during validation")
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
        "schema": "abc-actual-haar-sigma-one-catalogue-curvature-inventory-v1",
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
        "schema": "abc-actual-haar-sigma-one-catalogue-curvature-validation-v1",
        "status": "PASS",
        "completedUtc": datetime.now(timezone.utc).isoformat(),
        "gitHeadBeforeCheckpointCommit": subprocess.check_output(
            ["git", "-C", str(REPO_ROOT), "rev-parse", "HEAD"], text=True
        ).strip(),
        "toolVersions": {
            "python": sys.version.splitlines()[0],
            "cxx": subprocess.check_output(
                [cxx, "--version"], text=True, encoding="utf-8", errors="replace"
            ).splitlines()[0],
            "lake": subprocess.check_output(
                [lake, "--version"], cwd=LEAN_ROOT, text=True
            ).strip(),
            "lean": subprocess.check_output(
                [lake, "env", "lean", "--version"], cwd=LEAN_ROOT, text=True
            ).strip(),
        },
        "validationDrivers": drivers_start,
        "frozenInputs": inputs_start,
        "gitIndexByteCheck": index_bytes_start,
        "frozenTextHygiene": text_hygiene_start,
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
        "gitDiffCheck": git_diff_run,
        "gitCachedDiffCheck": git_cached_diff_run,
        "aggregateBuild": aggregate_run,
        "scope": EXPECTED_SCOPE,
    }
    write_text_exact(
        output_root / VALIDATION_FILE,
        json.dumps(result, indent=2, ensure_ascii=False) + "\n",
    )
    summary = validation_summary(
        inventory_document["totals"],
        axiom_union,
        aggregate_jobs,
        index_bytes_start["entries"],
    )
    write_text_exact(output_root / "logs" / "SUMMARY.txt", summary)
    print(summary, end="")


def package_files_without_seal() -> list[Path]:
    files = [
        path
        for path in PACKAGE_ROOT.rglob("*")
        if (
            path.is_file()
            and path.resolve() != (PACKAGE_ROOT / SEAL_FILE).resolve()
            and "__pycache__" not in path.parts
        )
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
    if result.get("schema") != "abc-actual-haar-sigma-one-catalogue-curvature-validation-v1":
        raise RuntimeError("recorded validation schema mismatch")
    if result.get("validationDrivers") != driver_records():
        raise RuntimeError("recorded validation drivers differ from current drivers")
    current_frozen_inputs = verify_frozen_inputs()
    if result.get("frozenInputs") != current_frozen_inputs:
        raise RuntimeError("recorded frozen-input summary differs from current manifest")
    current_index_bytes = git_index_byte_check()
    if result.get("gitIndexByteCheck") != current_index_bytes:
        raise RuntimeError("recorded Git index byte check changed")
    if current_index_bytes["entries"] != current_frozen_inputs["entries"]:
        raise RuntimeError("recorded Git index coverage is incomplete")
    if result.get("frozenTextHygiene") != frozen_text_hygiene():
        raise RuntimeError("recorded frozen-text hygiene changed")
    if result.get("lakeDependencies") != lake_dependency_records():
        raise RuntimeError("recorded Lake dependency state changed")

    current_inventories = all_inventories()
    audit_path = PACKAGE_ROOT / GENERATED_AUDIT
    expected_audit = generated_audit_text(current_inventories)
    if (
        not audit_path.is_file()
        or audit_path.read_text(encoding="utf-8") != expected_audit
    ):
        raise RuntimeError("generated audit is not the deterministic current expansion")
    current_audit = {
        "path": f"Lean/verification/{PACKAGE_NAME}/{GENERATED_AUDIT}",
        "bytes": audit_path.stat().st_size,
        "sha256": sha256(audit_path),
    }
    if result.get("generatedAudit") != current_audit:
        raise RuntimeError("recorded generated-audit summary changed")

    recorded_modules = result.get("modules", [])
    if [row.get("module") for row in recorded_modules] != list(MODULES):
        raise RuntimeError("recorded module inventory mismatch")
    for row, current in zip(recorded_modules, current_inventories, strict=True):
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
        if (
            row.get("path") != current["path"]
            or row.get("bytes") != current["bytes"]
            or row.get("sha256") != current["sha256"]
        ):
            raise RuntimeError(f"recorded source identity changed for {module}")
    if result.get("aggregateBuild", {}).get("jobs") != EXPECTED_AGGREGATE_JOBS:
        raise RuntimeError("recorded aggregate job count mismatch")
    totals = result.get("totals", {})
    if totals != EXPECTED_RECORDED_TOTALS:
        raise RuntimeError("recorded declaration totals changed")
    if totals.get("axiomReports") != totals.get("proofDeclarations"):
        raise RuntimeError("recorded axiom coverage is not one-for-one")
    if set(result.get("axiomUnion", [])) != EXPECTED_AXIOM_UNION:
        raise RuntimeError("recorded validation axiom union changed")
    if result.get("scope") != EXPECTED_SCOPE:
        raise RuntimeError("recorded standard-abc scope boundary changed")
    inventory_path = PACKAGE_ROOT / INVENTORY_FILE
    if result.get("inventory", {}).get("sha256") != sha256(inventory_path):
        raise RuntimeError("recorded declaration inventory hash mismatch")
    inventory_document = json.loads(inventory_path.read_text(encoding="utf-8"))
    if inventory_document.get("schema") != (
        "abc-actual-haar-sigma-one-catalogue-curvature-inventory-v1"
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
        "git-diff-check",
        "git-cached-diff-check",
        "aggregate-lake-build",
    ]
    runs = [
        *result.get("directRuns", []),
        result.get("axiomAuditRun", {}),
        result.get("computationReplay", {}),
        result.get("gitDiffCheck", {}),
        result.get("gitCachedDiffCheck", {}),
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

    audit_log = (
        PACKAGE_ROOT / "logs" / "axiom-audit.log"
    ).read_text(encoding="utf-8")
    audited_declarations, logged_axiom_union = parse_axiom_audit(
        audit_log, current_inventories
    )
    if logged_axiom_union != EXPECTED_AXIOM_UNION:
        raise RuntimeError("recorded axiom log union changed")
    by_name = {row["name"]: row for row in audited_declarations}
    for current in current_inventories:
        current["proofDeclarations"] = [
            by_name[declaration["name"]]
            for declaration in current["proofDeclarations"]
        ]
        current["axiomUnion"] = sorted(
            {
                axiom
                for declaration in current["proofDeclarations"]
                for axiom in declaration["axioms"]
            }
        )
    expected_inventory_document = {
        "schema": "abc-actual-haar-sigma-one-catalogue-curvature-inventory-v1",
        "modules": current_inventories,
        "totals": EXPECTED_RECORDED_TOTALS,
        "axiomUnion": sorted(EXPECTED_AXIOM_UNION),
    }
    if inventory_document != expected_inventory_document:
        raise RuntimeError("recorded declaration inventory differs from compiler log")
    for row, current in zip(recorded_modules, current_inventories, strict=True):
        if row.get("axiomUnion") != current["axiomUnion"]:
            raise RuntimeError(
                f"recorded per-module axiom union changed for {row['module']}"
            )

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
    if json.loads(evidence_output.read_text(encoding="utf-8")) != EXPECTED_EVIDENCE_VERIFIED:
        raise RuntimeError("recorded four-route replay document changed")

    git_log = (PACKAGE_ROOT / "logs" / "git-diff-check.log").read_text(
        encoding="utf-8"
    )
    if git_log != (
        "WORKDIR: .\n"
        "COMMAND: git diff --check\n"
        "EXIT_CODE: 0\n"
    ):
        raise RuntimeError("recorded git diff --check transcript changed")

    git_cached_log = (
        PACKAGE_ROOT / "logs" / "git-cached-diff-check.log"
    ).read_text(encoding="utf-8")
    if git_cached_log != (
        "WORKDIR: .\n"
        "COMMAND: git diff --cached --check\n"
        "EXIT_CODE: 0\n"
    ):
        raise RuntimeError("recorded git diff --cached --check transcript changed")

    aggregate_log = (
        PACKAGE_ROOT / "logs" / "aggregate-lake-build.log"
    ).read_text(encoding="utf-8")
    aggregate_match = re.search(
        r"Build completed successfully \((\d+) jobs\)\.", aggregate_log
    )
    if (
        not aggregate_match
        or int(aggregate_match.group(1)) != EXPECTED_AGGREGATE_JOBS
    ):
        raise RuntimeError("recorded aggregate transcript job count changed")
    expected_summary = validation_summary(
        EXPECTED_RECORDED_TOTALS,
        EXPECTED_AXIOM_UNION,
        EXPECTED_AGGREGATE_JOBS,
        current_index_bytes["entries"],
    )
    if (PACKAGE_ROOT / "logs" / "SUMMARY.txt").read_text(
        encoding="utf-8"
    ) != expected_summary:
        raise RuntimeError("recorded validation summary changed")
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
        if (
            pure.is_absolute()
            or "\\" in relative
            or any(part in {"", ".", ".."} for part in pure.parts)
        ):
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
