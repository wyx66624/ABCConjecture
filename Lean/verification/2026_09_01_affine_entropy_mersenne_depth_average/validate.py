#!/usr/bin/env python3
"""Reproduce the affine-entropy and Mersenne-depth continuation.

The frozen input manifest makes the source snapshot immutable.  The ordinary
run compiles every new Lean module, audits declarations and kernel
dependencies, rebuilds the aggregate target, verifies all source/evidence
hashes, and independently replays the two finite computations.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime, timezone


PACKAGE_ROOT = Path(__file__).resolve().parent
REPO_ROOT = PACKAGE_ROOT.parents[2]
LEAN_ROOT = REPO_ROOT / "Lean"
FROZEN_OUTPUT_ROOT = PACKAGE_ROOT
LIVE_OUTPUT_ROOT = REPO_ROOT / "tmp" / "verification" / PACKAGE_ROOT.name
OUTPUT_ROOT = LIVE_OUTPUT_ROOT
LOG_ROOT = OUTPUT_ROOT / "logs"
VALIDATION_DRIVER_FILES = ("validate.py", "validate.ps1")

MODULES = (
    "AffineTemplateEntropy20260901",
    "MersenneWeightedOrderTail20260901",
    "MersenneSuperWieferichDepth20260901",
)

EXPECTED_DECLARATION_COUNTS = {
    "theorem": 74,
    "lemma": 0,
    "def": 21,
    "abbrev": 0,
    "structure": 0,
    "class": 0,
    "inductive": 0,
    "instance": 0,
}
EXPECTED_COUNTED_DECLARATIONS = 95
EXPECTED_PRINT_AXIOMS_COMMANDS = 74
EXPECTED_AGGREGATE_JOBS = 9209

NON_LEAN_INPUT_PATHS = (
        ".gitattributes",
        "Lean/lean-toolchain",
        "Lean/lakefile.toml",
        "Lean/lake-manifest.json",
        "Lean/RESEARCH_ROUTE_REGISTRY.md",
        "Lean/RESEARCH_STATUS.md",
        "research/ABC_AFFINE_TEMPLATE_ENTROPY_2026_09_01.md",
        "research/ABC_MERSENNE_WEIGHTED_ORDER_TAIL_2026_09_01.md",
        "research/ABC_MERSENNE_SUPER_WIEFERICH_DEPTH_2026_09_01.md",
        "research/ABC_AFFINE_ENTROPY_MERSENNE_DEPTH_AVERAGE_2026_09_01.md",
        "paper/ChatGPT_ABC_Uniformity_2026.tex",
        "paper/affine_template_entropy_2026.tex",
        "paper/mersenne_weighted_order_tail_2026.tex",
        "paper/mersenne_super_wieferich_depth_2026.tex",
        "paper/mersenne_super_wieferich_depth_section_2026.tex",
        "research/computation/2026_09_01_affine_template_entropy/SHA256SUMS",
        "research/computation/2026_09_01_mersenne_super_wieferich_depth/SHA256SUMS",
)


def git_index_entries() -> dict[str, dict[str, str]]:
    """Read the exact stage-zero Git index without consulting ignored files."""
    raw = subprocess.check_output(
        ["git", "-C", str(REPO_ROOT), "ls-files", "--stage", "-z"]
    )
    entries: dict[str, dict[str, str]] = {}
    for record in raw.split(b"\0"):
        if not record:
            continue
        try:
            header, path_bytes = record.split(b"\t", 1)
            mode, oid, stage = header.decode("ascii").split()
            relative = path_bytes.decode("utf-8")
        except (UnicodeDecodeError, ValueError) as exc:
            raise RuntimeError("malformed or non-UTF-8 Git index entry") from exc
        if stage != "0":
            raise RuntimeError(f"unmerged Git index entry at stage {stage}: {relative}")
        if not re.fullmatch(r"[0-7]{6}", mode) or not re.fullmatch(
            r"[0-9a-f]{40,64}", oid
        ):
            raise RuntimeError(f"malformed Git index metadata: {relative}")
        pure = PurePosixPath(relative)
        if (
            pure.is_absolute()
            or not pure.parts
            or any(part in {"", ".", ".."} for part in pure.parts)
            or "\\" in relative
        ):
            raise RuntimeError(f"noncanonical Git index path: {relative}")
        if relative in entries:
            raise RuntimeError(f"duplicate Git index path: {relative}")
        entries[relative] = {"mode": mode, "oid": oid}
    if not entries:
        raise RuntimeError("Git index is empty")
    return entries


def configured_input_paths(
    index_entries: dict[str, dict[str, str]] | None = None,
) -> tuple[str, ...]:
    """Freeze only indexed Lean sources plus indexed paper/evidence inputs."""
    index_entries = index_entries or git_index_entries()
    lean_sources: set[str] = set()
    for relative in index_entries:
        pure = PurePosixPath(relative)
        if (
            len(pure.parts) >= 2
            and pure.parts[0] == "Lean"
            and pure.suffix == ".lean"
            and pure.parts[1] not in {".lake", "verification"}
        ):
            lean_sources.add(relative)
    required = set(NON_LEAN_INPUT_PATHS) | {
        "Lean/IUTThreeClosures.lean",
        *(f"Lean/IUTThreeClosures/{module}.lean" for module in MODULES),
    }
    missing = sorted(required - set(index_entries))
    if missing:
        raise RuntimeError(
            "required validation input is absent from the Git index: "
            + ", ".join(missing)
        )
    return tuple(sorted(lean_sources | set(NON_LEAN_INPUT_PATHS)))

EVIDENCE_DIRS = (
    "research/computation/2026_09_01_affine_template_entropy",
    "research/computation/2026_09_01_mersenne_super_wieferich_depth",
)

ALLOWED_UNHASHED_BY_SHA_DIR: dict[str, set[str]] = {}

ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def is_reparse_point(path: Path) -> bool:
    """Recognize POSIX symlinks and Windows reparse points without following them."""
    attributes = int(getattr(path.lstat(), "st_file_attributes", 0))
    return path.is_symlink() or bool(attributes & 0x400)


def repo_path(relative: str) -> Path:
    path = (REPO_ROOT / relative).resolve()
    try:
        path.relative_to(REPO_ROOT)
    except ValueError as exc:
        raise RuntimeError(f"path escapes repository: {relative}") from exc
    return path


def git_blob_bytes(oids: list[str]) -> dict[str, bytes]:
    """Read a set of indexed blobs in one deterministic `git cat-file` batch."""
    unique_oids = list(dict.fromkeys(oids))
    request = b"".join(oid.encode("ascii") + b"\n" for oid in unique_oids)
    process = subprocess.run(
        ["git", "-C", str(REPO_ROOT), "cat-file", "--batch"],
        input=request,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    if process.returncode != 0:
        detail = process.stderr.decode("utf-8", errors="replace").strip()
        raise RuntimeError(f"git cat-file --batch failed: {detail}")
    payload = process.stdout
    cursor = 0
    blobs: dict[str, bytes] = {}
    for expected_oid in unique_oids:
        newline = payload.find(b"\n", cursor)
        if newline < 0:
            raise RuntimeError("truncated git cat-file header")
        header = payload[cursor:newline].decode("ascii", errors="strict").split()
        cursor = newline + 1
        if len(header) != 3 or header[0] != expected_oid or header[1] != "blob":
            raise RuntimeError(
                f"unexpected git cat-file header for {expected_oid}: {header}"
            )
        try:
            size = int(header[2])
        except ValueError as exc:
            raise RuntimeError(f"invalid Git blob size for {expected_oid}") from exc
        end = cursor + size
        if end >= len(payload) or payload[end : end + 1] != b"\n":
            raise RuntimeError(f"truncated Git blob payload for {expected_oid}")
        blobs[expected_oid] = payload[cursor:end]
        cursor = end + 1
    if cursor != len(payload):
        raise RuntimeError("unexpected trailing bytes from git cat-file --batch")
    return blobs


def input_records() -> list[dict[str, object]]:
    index_entries = git_index_entries()
    relatives = configured_input_paths(index_entries)
    blobs = git_blob_bytes([index_entries[path]["oid"] for path in relatives])
    records: list[dict[str, object]] = []
    missing: list[str] = []
    mismatches: list[str] = []
    for relative in relatives:
        lexical_path = REPO_ROOT.joinpath(*PurePosixPath(relative).parts)
        if not lexical_path.is_file():
            missing.append(relative)
            continue
        if is_reparse_point(lexical_path):
            raise RuntimeError(f"reparse point cannot be a frozen input: {relative}")
        path = repo_path(relative)
        raw = path.read_bytes()
        oid = index_entries[relative]["oid"]
        indexed = blobs[oid]
        if raw != indexed:
            mismatches.append(
                f"{relative} (work={hashlib.sha256(raw).hexdigest()}, "
                f"index={hashlib.sha256(indexed).hexdigest()})"
            )
            continue
        records.append(
            {
                "path": relative,
                "bytes": len(raw),
                "sha256": hashlib.sha256(raw).hexdigest(),
                "gitBlob": oid,
            }
        )
    if missing or mismatches:
        details = []
        if missing:
            details.append("missing=" + ", ".join(missing))
        if mismatches:
            details.append("index-byte-mismatch=" + ", ".join(mismatches))
        raise RuntimeError("Git-index input audit failed: " + "; ".join(details))
    return records


def validation_driver_records() -> list[dict[str, object]]:
    records: list[dict[str, object]] = []
    for name in VALIDATION_DRIVER_FILES:
        path = PACKAGE_ROOT / name
        if not path.is_file():
            raise RuntimeError(f"validation driver is missing: {name}")
        records.append({"path": name, "bytes": path.stat().st_size, "sha256": sha256(path)})
    return records


def lake_dependency_records() -> dict[str, object]:
    """Require every Lake Git dependency to be clean at its pinned revision."""
    manifest_path = LEAN_ROOT / "lake-manifest.json"
    data = json.loads(manifest_path.read_text(encoding="utf-8"))
    packages = data.get("packages")
    if not isinstance(packages, list) or not packages:
        raise RuntimeError("lake-manifest.json has no package inventory")
    records: list[dict[str, str]] = []
    for package in packages:
        if not isinstance(package, dict) or package.get("type") != "git":
            raise RuntimeError("validation requires every Lake dependency to be Git-pinned")
        manifest_name = package.get("name")
        revision = package.get("rev")
        url = package.get("url")
        if not all(isinstance(value, str) and value for value in (manifest_name, revision, url)):
            raise RuntimeError("malformed Git dependency in lake-manifest.json")
        directory_name = manifest_name.removeprefix("«").removesuffix("»")
        package_root = LEAN_ROOT / ".lake" / "packages" / directory_name
        if not package_root.is_dir():
            raise RuntimeError(f"Lake dependency checkout is missing: {directory_name}")
        head = subprocess.check_output(
            ["git", "-C", str(package_root), "rev-parse", "HEAD"], text=True
        ).strip()
        if head != revision:
            raise RuntimeError(
                f"Lake dependency revision mismatch for {directory_name}: "
                f"actual={head}, expected={revision}"
            )
        status = subprocess.check_output(
            [
                "git",
                "-C",
                str(package_root),
                "status",
                "--porcelain=v1",
                "--untracked-files=all",
            ],
            text=True,
        ).strip()
        if status:
            raise RuntimeError(f"Lake dependency checkout is dirty: {directory_name}")
        records.append(
            {
                "name": manifest_name,
                "directory": directory_name,
                "revision": revision,
                "url": url,
            }
        )
    return {
        "manifestPath": "Lean/lake-manifest.json",
        "manifestSha256": sha256(manifest_path),
        "packages": records,
    }


def freeze_inputs() -> None:
    if (PACKAGE_ROOT / "SHA256SUMS").exists():
        raise RuntimeError("refusing to replace inputs in a sealed package")
    manifest = PACKAGE_ROOT / "input-manifest.json"
    stale_result = PACKAGE_ROOT / "validation-run.json"
    stale_logs = PACKAGE_ROOT / "logs"
    stale_result.unlink(missing_ok=True)
    if stale_logs.exists():
        shutil.rmtree(stale_logs)
    manifest.parent.mkdir(parents=True, exist_ok=True)
    manifest.write_text(
        json.dumps(input_records(), indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    print(f"WROTE {manifest}")


def verify_frozen_inputs() -> dict[str, object]:
    manifest = PACKAGE_ROOT / "input-manifest.json"
    if not manifest.is_file():
        raise RuntimeError("missing input-manifest.json; run with --freeze-inputs")
    frozen = json.loads(manifest.read_text(encoding="utf-8"))
    actual = input_records()
    if frozen != actual:
        frozen_map = {row["path"]: row for row in frozen}
        actual_map = {row["path"]: row for row in actual}
        changed = sorted(
            path
            for path in set(frozen_map) | set(actual_map)
            if frozen_map.get(path) != actual_map.get(path)
        )
        raise RuntimeError("frozen input mismatch: " + ", ".join(changed))
    return {
        "path": str(manifest.relative_to(REPO_ROOT)).replace("\\", "/"),
        "entries": len(frozen),
        "sha256": sha256(manifest),
    }


def verify_text_controls() -> None:
    """Reject lone carriage returns, C0 controls, and bare TeX `qquad`."""
    textual_suffixes = {".lean", ".md", ".tex", ".toml", ".json"}
    for relative in configured_input_paths():
        path = repo_path(relative)
        if path.suffix.lower() not in textual_suffixes:
            continue
        raw = path.read_bytes()
        for index, value in enumerate(raw):
            if value == 13:
                if index + 1 >= len(raw) or raw[index + 1] != 10:
                    raise RuntimeError(f"lone carriage return in {relative} at byte {index}")
            elif value < 32 and value not in (9, 10):
                raise RuntimeError(
                    f"unexpected C0 byte {value} in {relative} at byte {index}"
                )
        if path.suffix.lower() in {".md", ".tex"}:
            text = raw.decode("utf-8")
            # An even number of preceding backslashes leaves `qquad` bare in
            # TeX; an odd number makes the final backslash its command marker.
            match = re.search(r"(?<!\\)(?:\\\\)*\bqquad\b", text)
            if match:
                line = text.count("\n", 0, match.start()) + 1
                raise RuntimeError(f"bare qquad in {relative}:{line}")


def find_lake() -> str:
    command = shutil.which("lake")
    if not command:
        raise RuntimeError("lake was not found on PATH")
    return command


def run_logged(
    name: str, command: list[str], cwd: Path, *, require: str | None = None
) -> dict[str, object]:
    LOG_ROOT.mkdir(parents=True, exist_ok=True)
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
    transcript = (
        f"WORKDIR: {cwd}\n"
        f"COMMAND: {subprocess.list2cmdline(command)}\n"
        f"{process.stdout}"
        f"EXIT_CODE: {process.returncode}\n"
    )
    log_path = LOG_ROOT / f"{name}.log"
    log_path.write_text(transcript, encoding="utf-8", newline="\n")
    (LOG_ROOT / f"{name}.log.exitcode").write_text(
        f"{process.returncode}\n", encoding="ascii", newline="\n"
    )
    if process.returncode != 0:
        raise RuntimeError(f"{name} failed; inspect {log_path}")
    if require is not None and require not in process.stdout:
        raise RuntimeError(f"{name} omitted required marker: {require}")
    return {
        "name": name,
        "exitCode": process.returncode,
        "log": str(log_path.relative_to(REPO_ROOT)).replace("\\", "/"),
        "logSha256": sha256(log_path),
        "output": process.stdout,
    }


def strip_lean_comments_and_strings(text: str) -> str:
    """Replace nested comments and string contents while retaining newlines."""
    out: list[str] = []
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
                out.append(char)
            else:
                out.append(" ")
            index += 1
            continue
        if block_depth:
            if char == "/" and nxt == "-":
                block_depth += 1
                out.extend((" ", " "))
                index += 2
            elif char == "-" and nxt == "/":
                block_depth -= 1
                out.extend((" ", " "))
                index += 2
            else:
                out.append(char if char in "\r\n" else " ")
                index += 1
            continue
        if in_string:
            if char in "\r\n":
                out.append(char)
            else:
                out.append(" ")
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
        elif char == "/" and nxt == "-":
            block_depth = 1
            out.extend((" ", " "))
            index += 2
        elif char == "'" and not (
            index > 0 and (text[index - 1].isalnum() or text[index - 1] in "_'")
        ):
            # Lean character literals may contain a double quote (`'"'`) or
            # escaped quote.  Do not let either open the string-literal state.
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
                out.extend(" " for _ in range(end - index + 1))
                index = end + 1
            else:
                out.append(char)
                index += 1
        elif char == '"':
            in_string = True
            out.append(" ")
            index += 1
        else:
            out.append(char)
            index += 1
    if block_depth:
        raise RuntimeError("unterminated Lean block comment")
    if in_string:
        raise RuntimeError("unterminated Lean string")
    return "".join(out)


def strip_lean_attributes(text: str) -> str:
    """Blank balanced `@[...]` attributes while preserving positions/newlines."""
    out = list(text)
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
            if out[position] not in "\r\n":
                out[position] = " "
        index = cursor
    return "".join(out)


ATTRIBUTE_PREFIX = r"(?:@\[[^\]\n]*\]\s*)*"
MODIFIER_PREFIX = r"(?:(?:private|protected|noncomputable)\s+)*"
DECLARATION_RE = re.compile(
    rf"(?m)^\s*{ATTRIBUTE_PREFIX}{MODIFIER_PREFIX}"
    r"(theorem|lemma|def|abbrev|structure|class|inductive|instance)\b"
)
PROOF_DECLARATION_RE = re.compile(
    rf"(?m)^\s*{ATTRIBUTE_PREFIX}{MODIFIER_PREFIX}"
    r"(theorem|lemma)\s+([^\s:({\[]+)"
)
NAMED_DECLARATION_RE = re.compile(
    rf"(?m)^\s*{ATTRIBUTE_PREFIX}{MODIFIER_PREFIX}"
    r"(theorem|lemma|def|abbrev|structure|class|inductive)\s+([^\s:({\[]+)"
)
FORBIDDEN_DECL_RE = re.compile(
    rf"(?m)^\s*{ATTRIBUTE_PREFIX}{MODIFIER_PREFIX}"
    r"(axiom|axioms|opaque|unsafe|partial|extern)\b"
)
PRINT_RE = re.compile(r"(?m)^\s*#print\s+axioms\s+([^\s]+)")
SCOPE_RE = re.compile(
    r"(?m)^\s*(namespace\s+([^\s]+)|section(?:\s+[^\s]+)?|end(?:\s+[^\s]+)?)\s*$"
)


def qualify_lean_name(name: str, namespace: tuple[str, ...]) -> str:
    """Resolve a declaration/command name using the active Lean namespace."""
    if name.startswith("_root_."):
        return name[len("_root_.") :]
    components = tuple(part for part in name.split(".") if part)
    return ".".join((*namespace, *components))


def names_with_namespaces(
    clean: str, pattern: re.Pattern[str], name_group: int
) -> list[tuple[re.Match[str], str]]:
    """Return regex matches paired with their fully resolved source names.

    Namespace and section commands are merged with declaration/print matches in
    source order.  A section consumes an `end` but contributes no name, while a
    dotted namespace contributes each component until its matching `end`.
    """
    events: list[tuple[int, int, str, object]] = []
    for match in SCOPE_RE.finditer(clean):
        command = match.group(1)
        if command.startswith("namespace"):
            events.append((match.start(), 0, "namespace", match.group(2)))
        elif command.startswith("section"):
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
            previous_namespace = tuple(namespace)
            if raw.startswith("_root_."):
                components = [part for part in raw[len("_root_.") :].split(".") if part]
                namespace.clear()
            else:
                components = [part for part in raw.split(".") if part]
            namespace.extend(components)
            scopes.append(("namespace", previous_namespace))
        elif kind == "section":
            scopes.append(("section", None))
        elif kind == "end":
            if not scopes:
                raise RuntimeError("unmatched Lean `end` while resolving names")
            scope_kind, previous_namespace = scopes.pop()
            if scope_kind == "namespace" and previous_namespace is not None:
                namespace[:] = previous_namespace
        else:
            match = payload
            if not isinstance(match, re.Match):
                raise AssertionError("internal source event type mismatch")
            resolved.append(
                (match, qualify_lean_name(match.group(name_group), tuple(namespace)))
            )
    if scopes:
        raise RuntimeError("unterminated Lean namespace/section while resolving names")
    return resolved


def source_inventory(module: str) -> dict[str, object]:
    path = LEAN_ROOT / "IUTThreeClosures" / f"{module}.lean"
    clean = strip_lean_comments_and_strings(path.read_text(encoding="utf-8"))
    declaration_clean = strip_lean_attributes(clean)
    forbidden: list[str] = []
    for token in ("sorry", "admit", "native_decide", "sorryAx"):
        if re.search(rf"\b{re.escape(token)}\b", clean):
            forbidden.append(token)
    forbidden.extend(
        match.group(1) for match in FORBIDDEN_DECL_RE.finditer(declaration_clean)
    )
    if forbidden:
        raise RuntimeError(f"forbidden Lean source in {module}: {sorted(set(forbidden))}")
    counts = {
        key: 0
        for key in (
            "theorem",
            "lemma",
            "def",
            "abbrev",
            "structure",
            "class",
            "inductive",
            "instance",
        )
    }
    for match in DECLARATION_RE.finditer(declaration_clean):
        counts[match.group(1)] += 1
    named_declarations = names_with_namespaces(
        declaration_clean, NAMED_DECLARATION_RE, 2
    )
    declaration_names = {name for _, name in named_declarations}
    proof_names = [
        name
        for match, name in named_declarations
        if match.group(1) in {"theorem", "lemma"}
    ]
    print_targets = [name for _, name in names_with_namespaces(clean, PRINT_RE, 1)]
    if len(set(proof_names)) != len(proof_names):
        raise RuntimeError(f"duplicate fully qualified proof declaration in {module}")
    if len(set(print_targets)) != len(print_targets):
        raise RuntimeError(f"duplicate #print axioms target in {module}")
    missing_reports = sorted(set(proof_names) - set(print_targets))
    extra_reports = sorted(set(print_targets) - set(proof_names))
    if missing_reports:
        raise RuntimeError(
            f"{module}: theorem-level axiom coverage mismatch; "
            f"missing={missing_reports}, extra={extra_reports}"
        )
    nonlocal_reports = sorted(set(print_targets) - declaration_names)
    if nonlocal_reports:
        raise RuntimeError(
            f"{module}: #print axioms targets nonlocal declarations: {nonlocal_reports}"
        )
    print_count = len(print_targets)
    return {
        "module": module,
        "sha256": sha256(path),
        "counts": counts,
        "countedTopLevelDeclarations": sum(counts.values()),
        "printAxiomsCommands": print_count,
        "namedDeclarations": [name for _, name in named_declarations],
        "proofDeclarations": proof_names,
        "printAxiomsTargets": print_targets,
        "extraPrintedDefinitions": extra_reports,
    }


def parse_axiom_reports(
    output: str, expected_targets: list[str], module: str
) -> set[str]:
    report_re = re.compile(
        r"'([^\r\n]+?)'\s+(?:"
        r"does not depend on any axioms|"
        r"depends on axioms:\s*\[(.*?)\])",
        flags=re.DOTALL,
    )
    reports: dict[str, str | None] = {}
    for match in report_re.finditer(output):
        name = match.group(1)
        if name in reports:
            raise RuntimeError(f"{module}: duplicate compiler axiom report for {name}")
        reports[name] = match.group(2)
    expected_set = set(expected_targets)
    if len(expected_set) != len(expected_targets):
        raise RuntimeError(f"{module}: duplicate expected axiom-report target")
    if set(reports) != expected_set:
        missing = sorted(expected_set - set(reports))
        extra = sorted(set(reports) - expected_set)
        raise RuntimeError(
            f"{module}: compiler axiom-report target mismatch; "
            f"missing={missing}, extra={extra}"
        )
    axioms: set[str] = set()
    for body in reports.values():
        if body is not None:
            axioms.update(item.strip() for item in body.split(",") if item.strip())
    unexpected = axioms - ALLOWED_AXIOMS
    if unexpected:
        raise RuntimeError(f"{module}: unexpected axioms: {sorted(unexpected)}")
    if "sorryAx" in output:
        raise RuntimeError(f"{module}: compiler output contains sorryAx")
    return axioms


def verify_sha_manifest(
    relative: str, *, allowed_unhashed: set[str] | None = None
) -> dict[str, object]:
    root = repo_path(relative)
    manifest = root / "SHA256SUMS"
    entries: dict[str, str] = {}
    for line in manifest.read_text(encoding="utf-8").splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        match = re.fullmatch(r"([0-9a-fA-F]{64})\s+\*?(.+?)\s*", line)
        if not match:
            raise RuntimeError(f"malformed checksum line in {manifest}: {line!r}")
        expected, name = match.group(1).lower(), match.group(2).replace("\\", "/")
        if name in entries:
            raise RuntimeError(f"duplicate checksum entry in {manifest}: {name}")
        path = (root / name).resolve()
        try:
            path.relative_to(root)
        except ValueError as exc:
            raise RuntimeError(f"checksum path escapes bundle: {name}") from exc
        if not path.is_file() or sha256(path) != expected:
            raise RuntimeError(f"checksum mismatch or missing file: {path}")
        entries[name] = expected
    if not entries:
        raise RuntimeError(f"empty checksum manifest: {manifest}")
    allowed_unhashed = allowed_unhashed or set()
    reparse_points = [path for path in root.rglob("*") if is_reparse_point(path)]
    if reparse_points:
        names = ", ".join(
            str(path.relative_to(root)).replace("\\", "/")
            for path in reparse_points
        )
        raise RuntimeError(f"reparse point in checksum bundle {relative}: {names}")
    actual = sorted(
        str(path.relative_to(root)).replace("\\", "/")
        for path in root.rglob("*")
        if path.is_file() and path.resolve() != manifest.resolve()
    )
    expected_files = sorted(set(entries) | allowed_unhashed)
    if expected_files != actual:
        raise RuntimeError(f"strict checksum file-set mismatch: {relative}")
    return {
        "directory": relative,
        "entries": len(entries),
        "strict": True,
        "allowedUnhashed": sorted(allowed_unhashed),
        "manifestSha256": sha256(manifest),
    }


def assert_no_replay_artifacts() -> None:
    violations: list[str] = []
    for relative in EVIDENCE_DIRS:
        root = repo_path(relative)
        for path in root.rglob("*"):
            if is_reparse_point(path) or (
                path.is_dir() and path.name == "__pycache__"
            ) or (
                path.is_file() and path.suffix.lower() in {".exe", ".pyc", ".pyo"}
            ):
                violations.append(str(path.relative_to(REPO_ROOT)).replace("\\", "/"))
    if violations:
        raise RuntimeError("forbidden replay artifacts: " + ", ".join(violations))


def compare_bytes(left: Path, right: Path, label: str) -> None:
    if left.read_bytes() != right.read_bytes():
        raise RuntimeError(f"deterministic replay differs from frozen {label}")


def prepare_output_root(record: bool) -> None:
    """Remove stale success records before any fallible validation step."""
    if record:
        if (PACKAGE_ROOT / "SHA256SUMS").exists():
            raise RuntimeError("refusing to record into a sealed package")
        (PACKAGE_ROOT / "validation-run.json").unlink(missing_ok=True)
        if LOG_ROOT.exists():
            shutil.rmtree(LOG_ROOT)
        return
    allowed_root = (REPO_ROOT / "tmp" / "verification").resolve()
    resolved_output = OUTPUT_ROOT.resolve()
    try:
        resolved_output.relative_to(allowed_root)
    except ValueError as exc:
        raise RuntimeError("live output path escapes tmp/verification") from exc
    if resolved_output.exists():
        shutil.rmtree(resolved_output)


def main() -> None:
    global OUTPUT_ROOT, LOG_ROOT
    parser = argparse.ArgumentParser()
    parser.add_argument("--freeze-inputs", action="store_true")
    parser.add_argument(
        "--record",
        action="store_true",
        help="write the audited run into the immutable package before it is sealed",
    )
    args = parser.parse_args()
    if sys.flags.optimize != 0:
        raise RuntimeError("Python optimization is forbidden because replays use assertions")
    if args.freeze_inputs and args.record:
        raise RuntimeError("--freeze-inputs and --record are separate maintainer steps")
    if args.freeze_inputs:
        freeze_inputs()
        return

    OUTPUT_ROOT = FROZEN_OUTPUT_ROOT if args.record else LIVE_OUTPUT_ROOT
    LOG_ROOT = OUTPUT_ROOT / "logs"

    prepare_output_root(args.record)
    LOG_ROOT.mkdir(parents=True, exist_ok=True)
    driver_start = validation_driver_records()
    dependencies_start = lake_dependency_records()
    frozen_start = verify_frozen_inputs()
    verify_text_controls()
    assert_no_replay_artifacts()
    lake = find_lake()

    aggregate = strip_lean_comments_and_strings(
        (LEAN_ROOT / "IUTThreeClosures.lean").read_text(encoding="utf-8")
    )
    for module in MODULES:
        pattern = rf"(?m)^\s*import\s+IUTThreeClosures\.{re.escape(module)}\s*$"
        if not re.search(pattern, aggregate):
            raise RuntimeError(f"aggregate import missing: {module}")

    inventories: list[dict[str, object]] = []
    direct_runs: list[dict[str, object]] = []
    axiom_union: set[str] = set()
    for module in MODULES:
        inventory = source_inventory(module)
        run = run_logged(
            f"{module}-direct",
            [lake, "env", "lean", f"IUTThreeClosures/{module}.lean"],
            LEAN_ROOT,
        )
        warnings = len(re.findall(r"(?im)\bwarning:", str(run["output"])))
        if warnings:
            raise RuntimeError(f"{module}: direct compilation emitted {warnings} warnings")
        axioms = parse_axiom_reports(
            str(run["output"]), list(inventory["printAxiomsTargets"]), module
        )
        inventory["axioms"] = sorted(axioms)
        run.pop("output")
        run["warnings"] = warnings
        inventories.append(inventory)
        direct_runs.append(run)
        axiom_union.update(axioms)
    if axiom_union != ALLOWED_AXIOMS:
        raise RuntimeError(
            f"axiom union changed: {sorted(axiom_union)} != {sorted(ALLOWED_AXIOMS)}"
        )

    aggregate_run = run_logged(
        "aggregate-lake-build", [lake, "build", "IUTThreeClosures"], LEAN_ROOT
    )
    aggregate_output = str(aggregate_run.pop("output"))
    match = re.search(r"Build completed successfully \((\d+) jobs\)\.", aggregate_output)
    if not match:
        raise RuntimeError("aggregate build success marker was not found")
    aggregate_run["jobs"] = int(match.group(1))
    aggregate_run["warnings"] = len(re.findall(r"(?im)\bwarning:", aggregate_output))
    if aggregate_run["jobs"] != EXPECTED_AGGREGATE_JOBS:
        raise RuntimeError(
            "aggregate build job count changed: "
            f"{aggregate_run['jobs']} != {EXPECTED_AGGREGATE_JOBS}"
        )

    aggregate_direct = run_logged(
        "aggregate-direct", [lake, "env", "lean", "IUTThreeClosures.lean"], LEAN_ROOT
    )
    aggregate_direct.pop("output")

    manifest_results = [
        verify_sha_manifest(
            relative, allowed_unhashed=ALLOWED_UNHASHED_BY_SHA_DIR.get(relative)
        )
        for relative in EVIDENCE_DIRS
    ]
    python = sys.executable
    affine_dir = repo_path("research/computation/2026_09_01_affine_template_entropy")
    affine_run = run_logged(
        "affine-template-entropy-replay",
        [python, "-B", "verify_template_entropy.py"],
        affine_dir,
    )
    affine_output = str(affine_run["output"])
    frozen_affine_output = (affine_dir / "OUTPUT.txt").read_text(encoding="utf-8")
    if affine_output.splitlines() != frozen_affine_output.splitlines():
        raise RuntimeError("affine template-entropy replay differs from OUTPUT.txt")
    affine_run.pop("output")

    mersenne_dir = repo_path(
        "research/computation/2026_09_01_mersenne_super_wieferich_depth"
    )
    with tempfile.TemporaryDirectory(prefix="abc-mersenne-depth-replay-") as temporary:
        temp = Path(temporary)
        scan_output = temp / "scan_10m.json"
        verification_output = temp / "verification.json"
        scan_run = run_logged(
            "mersenne-super-wieferich-scan",
            [
                python,
                "-B",
                str(mersenne_dir / "scan_super_wieferich.py"),
                "--limit",
                "10000000",
                "--output",
                str(scan_output),
            ],
            REPO_ROOT,
        )
        scan_run.pop("output")
        compare_bytes(
            scan_output, mersenne_dir / "scan_10m.json", "Mersenne depth scan"
        )
        verify_run = run_logged(
            "mersenne-super-wieferich-verify",
            [
                python,
                "-B",
                str(mersenne_dir / "verify_super_wieferich.py"),
                "--input",
                str(scan_output),
                "--output",
                str(verification_output),
            ],
            REPO_ROOT,
        )
        verify_run.pop("output")
        compare_bytes(
            verification_output,
            mersenne_dir / "verification.json",
            "Mersenne depth verifier",
        )

    assert_no_replay_artifacts()
    manifest_results_end = [
        verify_sha_manifest(
            relative, allowed_unhashed=ALLOWED_UNHASHED_BY_SHA_DIR.get(relative)
        )
        for relative in EVIDENCE_DIRS
    ]
    if manifest_results_end != manifest_results:
        raise RuntimeError("evidence manifests changed during replay")
    frozen_end = verify_frozen_inputs()
    if frozen_start != frozen_end:
        raise RuntimeError("frozen inputs changed during validation")
    driver_end = validation_driver_records()
    if driver_start != driver_end:
        raise RuntimeError("validation driver changed during validation")
    dependencies_end = lake_dependency_records()
    if dependencies_start != dependencies_end:
        raise RuntimeError("Lake dependency state changed during validation")

    totals = {
        key: sum(int(row["counts"][key]) for row in inventories)
        for key in inventories[0]["counts"]
    }
    if totals != EXPECTED_DECLARATION_COUNTS:
        raise RuntimeError(
            f"declaration counts changed: {totals} != {EXPECTED_DECLARATION_COUNTS}"
        )
    counted_declarations = sum(
        int(row["countedTopLevelDeclarations"]) for row in inventories
    )
    print_axioms_commands = sum(
        int(row["printAxiomsCommands"]) for row in inventories
    )
    if counted_declarations != EXPECTED_COUNTED_DECLARATIONS:
        raise RuntimeError(
            "counted declaration total changed: "
            f"{counted_declarations} != {EXPECTED_COUNTED_DECLARATIONS}"
        )
    if print_axioms_commands != EXPECTED_PRINT_AXIOMS_COMMANDS:
        raise RuntimeError(
            "#print axioms total changed: "
            f"{print_axioms_commands} != {EXPECTED_PRINT_AXIOMS_COMMANDS}"
        )
    result = {
        "schema": "abc-affine-entropy-mersenne-depth-average-validation-v1",
        "status": "PASS",
        "completedUtc": datetime.now(timezone.utc).isoformat(),
        "repository": str(REPO_ROOT),
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
        "validationDrivers": driver_end,
        "lakeDependencies": dependencies_end,
        "frozenInputs": frozen_end,
        "modules": inventories,
        "totals": {
            **totals,
            "countedTopLevelDeclarations": counted_declarations,
            "printAxiomsCommands": print_axioms_commands,
        },
        "axiomUnion": sorted(axiom_union),
        "directRuns": direct_runs,
        "aggregateBuild": aggregate_run,
        "aggregateDirect": aggregate_direct,
        "manifests": manifest_results,
        "crossReferences": [],
        "replays": [affine_run, scan_run, verify_run],
        "scope": {
            "finiteNoHitIsAsymptoticEvidence": False,
            "provesOrDisprovesStandardABC": False,
        },
    }
    result_path = OUTPUT_ROOT / "validation-run.json"
    result_path.parent.mkdir(parents=True, exist_ok=True)
    result_path.write_text(
        json.dumps(result, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    summary = (
        "PASS\n"
        f"modules={len(MODULES)}\n"
        f"declarations={result['totals']['countedTopLevelDeclarations']}\n"
        f"print_axioms={result['totals']['printAxiomsCommands']}\n"
        f"axiom_union={','.join(sorted(axiom_union))}\n"
        f"aggregate_jobs={aggregate_run['jobs']}\n"
        "standard_abc_closed=false\n"
    )
    (LOG_ROOT / "SUMMARY.txt").write_text(
        summary, encoding="utf-8", newline="\n"
    )
    print(summary, end="")


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        raise
