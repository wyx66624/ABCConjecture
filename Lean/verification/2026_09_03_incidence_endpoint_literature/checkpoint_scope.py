#!/usr/bin/env python3
"""Shared, explicit scope for the September 3 incidence checkpoint."""

from __future__ import annotations

import hashlib
import re
from pathlib import Path, PurePosixPath


HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
LEAN = REPO / "Lean"
LEAN_MODULE_DIR = LEAN / "IUTThreeClosures"
ENDPOINT = (
    REPO
    / "research"
    / "computation"
    / "2026_09_03_signed_endpoint_prime_token_transport"
)
SUCCESSOR = (
    REPO
    / "research"
    / "computation"
    / "2026_09_03_three_arm_incidence_successor"
)
PBT = (
    REPO
    / "research"
    / "computation"
    / "2026_09_03_prime_packet_boundary_transport"
)
PAPER = REPO / "paper"

# The declaration counts are deliberately fixed rather than inferred from an
# audit file.  Any source/audit inventory change must be reviewed here.
MODULES: tuple[tuple[str, str, int, str], ...] = (
    (
        "valuation-incidence-complex",
        "ABCValuationIncidenceComplex20260903",
        85,
        "IUTThreeClosures.ABCValuationIncidenceComplex20260903",
    ),
    (
        "fixed-budget-obstruction",
        "ABCValuationIncidenceFixedBudgetObstruction20260903",
        18,
        "IUTThreeClosures.ABCValuationIncidenceFixedBudgetObstruction20260903",
    ),
    (
        "scale-budget-obstruction",
        "ABCValuationIncidenceScaleBudgetObstruction20260903",
        34,
        "IUTThreeClosures.ABCValuationIncidenceScaleBudgetObstruction20260903",
    ),
    (
        "signed-endpoint-prime-token-transport",
        "ABCSignedEndpointPrimeTokenTransport20260903",
        77,
        "IUTThreeClosures.SignedEndpointPrimeTokenTransport",
    ),
    (
        "three-arm-incidence-successor",
        "ABCThreeArmIncidenceSuccessor20260903",
        65,
        "IUTThreeClosures.ABCThreeArmIncidenceSuccessor20260903",
    ),
    (
        "three-arm-complement-transport-obstruction",
        "ABCThreeArmComplementTransportObstruction20260903",
        37,
        "IUTThreeClosures.ABCThreeArmComplementTransportObstruction20260903",
    ),
    (
        "bidirectional-prime-transport-successor",
        "ABCBidirectionalPrimeTransportSuccessor20260903",
        44,
        "IUTThreeClosures.ABCBidirectionalPrimeTransportSuccessor20260903",
    ),
    (
        "bidirectional-energy-pythagorean-obstruction",
        "ABCBidirectionalEnergyPythagoreanObstruction20260903",
        40,
        "IUTThreeClosures.ABCBidirectionalEnergyPythagoreanObstruction20260903",
    ),
    (
        "prime-packet-boundary-transport-successor",
        "ABCPrimePacketBoundaryTransportSuccessor20260903",
        39,
        "IUTThreeClosures.ABCPrimePacketBoundaryTransportSuccessor20260903",
    ),
    (
        "prime-packet-boundary-linnik-obstruction",
        "ABCPrimePacketBoundaryLinnikObstruction20260903",
        27,
        "IUTThreeClosures.ABCPrimePacketBoundaryLinnikObstruction20260903",
    ),
    (
        "shared-crt-incidence-successor",
        "ABCSharedCRTIncidenceSuccessor20260903",
        30,
        "IUTThreeClosures.ABCSharedCRTIncidenceSuccessor20260903",
    ),
)

CONFIG_RELATIVE_PATHS: tuple[str, ...] = (
    "Lean/lakefile.toml",
    "Lean/lake-manifest.json",
    "Lean/lean-toolchain",
)

RESEARCH_RELATIVE_PATHS: tuple[str, ...] = (
    "research/ABC_LABELED_VALUATION_INCIDENCE_COMPLEX_2026_09_03.md",
    "research/ABC_VALUATION_INCIDENCE_FIXED_BUDGET_OBSTRUCTION_2026_09_03.md",
    "research/ABC_VALUATION_INCIDENCE_SCALE_BUDGET_OBSTRUCTION_2026_09_03.md",
    "research/ABC_SIGNED_ENDPOINT_PRIME_TOKEN_TRANSPORT_2026_09_03.md",
    "research/ABC_THREE_ARM_INCIDENCE_SUCCESSOR_2026_09_03.md",
    "research/ABC_ORDERED_PRIME_TRANSPORT_OBSTRUCTION_2026_09_03.md",
    "research/ABC_BIDIRECTIONAL_PRIME_TRANSPORT_SUCCESSOR_2026_09_03.md",
    "research/ABC_BIDIRECTIONAL_ENERGY_ADVERSARIAL_AUDIT_2026_09_03.md",
    "research/ABC_PRIME_PACKET_BOUNDARY_TRANSPORT_SUCCESSOR_2026_09_03.md",
    "research/ABC_PRIME_PACKET_BOUNDARY_COMPUTATION_2026_09_03.md",
    "research/ABC_PRIME_PACKET_BOUNDARY_THEORETICAL_AUDIT_2026_09_03.md",
    "research/ABC_SHARED_CRT_INCIDENCE_SUCCESSOR_2026_09_03.md",
    "research/ABC_PRIMARY_LITERATURE_GATE_AUDIT_2026_09_03.md",
    "research/ABC_ROUTE_BOTTLENECKS.md",
)

STATUS_RELATIVE_PATHS: tuple[str, ...] = (
    ".gitattributes",
    "README.md",
    "Lean/RESEARCH_STATUS.md",
    "Lean/RESEARCH_ROUTE_REGISTRY.md",
)

PAPER_MAIN_RELATIVE_PATH = "paper/ChatGPT_ABC_Uniformity_2026.tex"
REQUIRED_PAPER_INPUT_RELATIVE_PATHS: tuple[str, ...] = (
    PAPER_MAIN_RELATIVE_PATH,
    "paper/abc_synchronized_divisor_packets_2026.tex",
    "paper/abc_labeled_valuation_incidence_complex_2026.tex",
    "paper/abc_valuation_incidence_fixed_budget_obstruction_2026.tex",
    "paper/abc_valuation_incidence_scale_budget_obstruction_2026.tex",
    "paper/abc_three_arm_incidence_successor_2026.tex",
    "paper/abc_signed_endpoint_prime_token_transport_2026.tex",
    "paper/abc_ordered_prime_transport_obstruction_2026.tex",
    "paper/abc_bidirectional_energy_obstruction_2026.tex",
    "paper/abc_prime_packet_boundary_transport_2026.tex",
    "paper/abc_prime_packet_boundary_linnik_obstruction_2026.tex",
    "paper/abc_shared_crt_incidence_successor_2026.tex",
    "paper/abc_primary_literature_gate_audit_2026.tex",
)

FINAL_QA_CONTACT_NAMES: tuple[str, ...] = (
    "contact-001-016.png",
    "contact-017-032.png",
    "contact-033-048.png",
    "contact-049-064.png",
    "contact-065-080.png",
    "contact-081-096.png",
    "contact-097-112.png",
    "contact-113-128.png",
    "contact-129-144.png",
    "contact-145-160.png",
    "contact-161-176.png",
    "contact-177-192.png",
    "contact-193-208.png",
    "contact-209-224.png",
    "contact-225-240.png",
    "contact-241-256.png",
    "contact-257-270.png",
)

# These are created only after the formal/computational replay succeeds.  They
# are nevertheless part of the final exact-set manifest, so the delivered PDF
# and its QA evidence cannot be replaced without invalidating the seal.
FINAL_PAPER_ARTIFACT_RELATIVE_PATHS: tuple[str, ...] = (
    "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "compile_latex.log",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "compile_latex.exitcode",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "compile_multirun.log",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "compile_driver.json",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "compile_driver.exitcode",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "tectonic_engine.log",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "PDF_VALIDATION.md",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "qa_metrics.json",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "render_audit.py",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "render_audit.log",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "render_audit.exitcode",
    "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/"
    "paper_build_provenance.json",
    *(
        "output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/" + name
        for name in FINAL_QA_CONTACT_NAMES
    ),
)

ENDPOINT_RELATIVE_PATHS: tuple[str, ...] = (
    "research/computation/2026_09_03_signed_endpoint_prime_token_transport/"
    "search_endpoint_token_transport.py",
    "research/computation/2026_09_03_signed_endpoint_prime_token_transport/README.md",
    "research/computation/2026_09_03_signed_endpoint_prime_token_transport/OUTPUT.json",
    "research/computation/2026_09_03_signed_endpoint_prime_token_transport/RUN.log",
    "research/computation/2026_09_03_signed_endpoint_prime_token_transport/"
    "LEAN_VERIFICATION.txt",
    "research/computation/2026_09_03_signed_endpoint_prime_token_transport/"
    "SHA256SUMS.txt",
)

SUCCESSOR_RELATIVE_PATHS: tuple[str, ...] = (
    "research/computation/2026_09_03_three_arm_incidence_successor/"
    "search_three_arm_successor.py",
    "research/computation/2026_09_03_three_arm_incidence_successor/README.md",
    "research/computation/2026_09_03_three_arm_incidence_successor/OUTPUT.json",
    "research/computation/2026_09_03_three_arm_incidence_successor/OUTPUT.csv",
    "research/computation/2026_09_03_three_arm_incidence_successor/RUN.txt",
    "research/computation/2026_09_03_three_arm_incidence_successor/SHA256SUMS",
)

PBT_RELATIVE_PATHS: tuple[str, ...] = (
    "research/computation/2026_09_03_prime_packet_boundary_transport/"
    "search_prime_packet_boundary.py",
    "research/computation/2026_09_03_prime_packet_boundary_transport/"
    "validate_prime_packet_boundary.py",
    "research/computation/2026_09_03_prime_packet_boundary_transport/README.md",
    "research/computation/2026_09_03_prime_packet_boundary_transport/OUTPUT.json",
    "research/computation/2026_09_03_prime_packet_boundary_transport/"
    "STRUCTURED_FAMILIES.csv",
    "research/computation/2026_09_03_prime_packet_boundary_transport/RUN.log",
    "research/computation/2026_09_03_prime_packet_boundary_transport/VALIDATION.log",
    "research/computation/2026_09_03_prime_packet_boundary_transport/SHA256SUMS.txt",
)

PACKAGE_STATIC_NAMES: tuple[str, ...] = (
    "build_paper_and_seal.py",
    "checkpoint_scope.py",
    "EnvironmentAxiomAudit.lean",
    "independent_endpoint_hall_audit.py",
    "make_manifest.py",
    "PAPER_SEAL.md",
    "README.md",
    "refresh_endpoint_checksums.py",
    "refresh_pbt_checksums.py",
    "refresh_successor_checksums.py",
    "run_checkpoint.py",
    "VALIDATION.md",
    "verify_checkpoint.py",
    "verify_manifest.py",
)


def evidence_names() -> tuple[str, ...]:
    names = [
        "lean-version.log",
        "lean-version.exitcode",
        "umbrella-build.log",
        "umbrella-build.exitcode",
        "environment-axiom-audit-strict.log",
        "environment-axiom-audit-strict.exitcode",
        "endpoint-computation-replay.log",
        "endpoint-computation-replay.exitcode",
        "endpoint-replay-output.json",
        "endpoint-independent-hall-audit.log",
        "endpoint-independent-hall-audit.exitcode",
        "successor-computation-replay.log",
        "successor-computation-replay.exitcode",
        "successor-replay-output.json",
        "successor-replay-output.csv",
        "pbt-computation-replay.log",
        "pbt-computation-replay.exitcode",
        "pbt-replay/OUTPUT.json",
        "pbt-replay/STRUCTURED_FAMILIES.csv",
        "pbt-independent-full-audit.log",
        "pbt-independent-full-audit.exitcode",
        "run_summary.json",
        "verification_summary.json",
    ]
    for stem, _, _, _ in MODULES:
        names.extend(
            (
                f"{stem}-main-strict.log",
                f"{stem}-main-strict.exitcode",
                f"{stem}-axiom-audit-strict.log",
                f"{stem}-axiom-audit-strict.exitcode",
            )
        )
    return tuple(names)


def sha256(path: Path) -> str:
    value = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1 << 20), b""):
            value.update(block)
    return value.hexdigest()


def canonical_relative_path(name: str) -> str:
    """Validate and return a canonical repository-relative POSIX path."""
    if not name or "\\" in name or "\0" in name:
        raise ValueError(f"noncanonical relative path: {name!r}")
    pure = PurePosixPath(name)
    if pure.is_absolute() or pure.parts[0].endswith(":"):
        raise ValueError(f"absolute/drive path forbidden: {name!r}")
    if any(part in ("", ".", "..") for part in pure.parts):
        raise ValueError(f"dot or empty path component forbidden: {name!r}")
    canonical = pure.as_posix()
    if canonical != name:
        raise ValueError(f"noncanonical relative path: {name!r}")
    resolved = (REPO / Path(*pure.parts)).resolve()
    try:
        resolved.relative_to(REPO.resolve())
    except ValueError as exc:
        raise ValueError(f"path escapes repository: {name!r}") from exc
    return canonical


def repo_path(name: str, *, require_file: bool = True) -> Path:
    canonical = canonical_relative_path(name)
    path = REPO
    for part in PurePosixPath(canonical).parts:
        path = path / part
        if path.is_symlink():
            raise ValueError(f"symlink component forbidden in sealed scope: {canonical}")
    if require_file and not path.is_file():
        raise FileNotFoundError(f"missing file: {canonical}")
    return path


def relative_name(path: Path) -> str:
    resolved = path.resolve()
    try:
        relative = resolved.relative_to(REPO.resolve()).as_posix()
    except ValueError as exc:
        raise ValueError(f"path outside repository: {path}") from exc
    return canonical_relative_path(relative)


def _blank_lean_comments_and_strings(source: str) -> str:
    """Blank nested comments and literals while preserving newlines."""
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
        elif depth:
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
        elif in_string:
            out.append(char if char in "\r\n" else " ")
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                in_string = False
            index += 1
        elif char == "-" and nxt == "-":
            line_comment = True
            out.extend((" ", " "))
            index += 2
        elif char == "/" and nxt == "-":
            depth = 1
            out.extend((" ", " "))
            index += 2
        elif char == '"':
            in_string = True
            out.append(" ")
            index += 1
        else:
            out.append(char)
            index += 1
    if depth or in_string:
        raise ValueError("unterminated Lean comment or string")
    return "".join(out)


IMPORT_LINE = re.compile(r"(?m)^\s*import\s+([^\r\n]+)$")
MODULE_TOKEN = re.compile(r"(?:_root_\.)?[A-Za-z0-9_'.]+")


def local_imports(path: Path) -> tuple[Path, ...]:
    clean = _blank_lean_comments_and_strings(path.read_text(encoding="utf-8"))
    imports: list[Path] = []
    for match in IMPORT_LINE.finditer(clean):
        tokens = match.group(1).split()
        if not tokens:
            raise ValueError(f"empty import command: {relative_name(path)}")
        for token in tokens:
            if MODULE_TOKEN.fullmatch(token) is None:
                raise ValueError(
                    f"unparsed import token {token!r} in {relative_name(path)}"
                )
            module = token.removeprefix("_root_.")
            candidate = LEAN / Path(*module.split("."))
            candidate = candidate.with_suffix(".lean")
            if candidate.is_file():
                imports.append(candidate)
    return tuple(imports)


def local_import_closure(seeds: tuple[Path, ...]) -> tuple[Path, ...]:
    pending = list(seeds)
    visited: dict[str, Path] = {}
    while pending:
        path = pending.pop()
        name = relative_name(path)
        if name in visited:
            continue
        if path.is_symlink() or not path.is_file():
            raise ValueError(f"invalid local Lean input: {name}")
        visited[name] = path
        pending.extend(local_imports(path))
    return tuple(visited[name] for name in sorted(visited))


TEX_INPUT = re.compile(r"\\input\s*\{([^{}]+)\}")
TEX_INPUT_COMMAND = re.compile(r"\\input\b")
UNSUPPORTED_LOCAL_TEX_DEPENDENCY = re.compile(
    r"\\(?:include|includegraphics|bibliography|addbibresource|"
    r"InputIfFileExists|subfile)\b"
)


def _strip_tex_comments(source: str) -> str:
    """Remove unescaped percent comments while preserving line structure."""
    clean: list[str] = []
    for line in source.splitlines(keepends=True):
        cut = len(line)
        for index, char in enumerate(line):
            if char != "%":
                continue
            backslashes = 0
            cursor = index - 1
            while cursor >= 0 and line[cursor] == "\\":
                backslashes += 1
                cursor -= 1
            if backslashes % 2 == 0:
                cut = index
                break
        suffix = "\n" if line.endswith("\n") else ""
        clean.append(line[:cut].rstrip("\r\n") + suffix)
    return "".join(clean)


def paper_input_closure() -> tuple[Path, ...]:
    """Return the exact recursive local ``\\input`` closure of the main paper."""
    pending = [repo_path(PAPER_MAIN_RELATIVE_PATH)]
    visited: dict[str, Path] = {}
    paper_root = PAPER.resolve()
    while pending:
        path = pending.pop()
        name = relative_name(path)
        if name in visited:
            continue
        if path.is_symlink() or not path.is_file():
            raise ValueError(f"invalid paper input: {name}")
        visited[name] = path
        source = _strip_tex_comments(path.read_text(encoding="utf-8"))
        input_matches = TEX_INPUT.findall(source)
        input_command_count = len(TEX_INPUT_COMMAND.findall(source))
        if input_command_count != len(input_matches):
            raise ValueError(
                f"unparsed or non-braced paper input command in {name}"
            )
        unsupported = UNSUPPORTED_LOCAL_TEX_DEPENDENCY.search(source)
        if unsupported is not None:
            raise ValueError(
                f"unsupported local TeX dependency command "
                f"{unsupported.group(0)!r} in {name}"
            )
        for raw in input_matches:
            value = raw.strip()
            if not value or "\\" in value or "\0" in value:
                raise ValueError(f"nonliteral paper input {raw!r} in {name}")
            pure = PurePosixPath(value)
            if pure.is_absolute() or any(part in ("", ".", "..") for part in pure.parts):
                raise ValueError(f"noncanonical paper input {raw!r} in {name}")
            combined = PurePosixPath(name).parent / pure
            if combined.suffix == "":
                combined = PurePosixPath(f"{combined.as_posix()}.tex")
            candidate = repo_path(canonical_relative_path(combined.as_posix()))
            resolved = candidate.resolve()
            try:
                resolved.relative_to(paper_root)
            except ValueError as exc:
                raise ValueError(f"paper input escapes paper directory: {raw!r}") from exc
            pending.append(candidate)
    required = set(REQUIRED_PAPER_INPUT_RELATIVE_PATHS)
    observed = set(visited)
    if not required <= observed:
        raise ValueError(
            f"paper input closure omits required files: {sorted(required - observed)}"
        )
    return tuple(visited[name] for name in sorted(visited))


def authored_artifact_paths() -> tuple[Path, ...]:
    """Exact UTF-8 source/ledger set whose digests the verifier binds."""
    paths = {
        LEAN / "IUTThreeClosures.lean",
        HERE / "EnvironmentAxiomAudit.lean",
        *(LEAN_MODULE_DIR / f"{module}{suffix}.lean"
          for _, module, _, _ in MODULES for suffix in ("", "AxiomAudit")),
        *(repo_path(name) for name in STATUS_RELATIVE_PATHS),
        *(repo_path(name) for name in RESEARCH_RELATIVE_PATHS),
        *(repo_path(name) for name in ENDPOINT_RELATIVE_PATHS),
        *(repo_path(name) for name in SUCCESSOR_RELATIVE_PATHS),
        *(repo_path(name) for name in PBT_RELATIVE_PATHS),
        *paper_input_closure(),
        *(HERE / name for name in PACKAGE_STATIC_NAMES),
    }
    return tuple(sorted(paths, key=relative_name))


def config_paths() -> tuple[Path, ...]:
    return tuple(repo_path(name) for name in CONFIG_RELATIVE_PATHS)


def umbrella_input_paths() -> tuple[Path, ...]:
    closure = local_import_closure((LEAN / "IUTThreeClosures.lean",))
    return tuple(sorted((*closure, *config_paths()), key=relative_name))


def module_input_paths(module: str, *, audit: bool) -> tuple[Path, ...]:
    seeds = [LEAN_MODULE_DIR / f"{module}.lean"]
    if audit:
        seeds.append(LEAN_MODULE_DIR / f"{module}AxiomAudit.lean")
    closure = local_import_closure(tuple(seeds))
    return tuple(sorted((*closure, *config_paths()), key=relative_name))


def environment_audit_input_paths() -> tuple[Path, ...]:
    closure = local_import_closure((HERE / "EnvironmentAxiomAudit.lean",))
    return tuple(sorted((*closure, *config_paths()), key=relative_name))


def expected_manifest_names(
    *, include_verification_summary: bool = True
) -> tuple[str, ...]:
    package_prefix = HERE.relative_to(REPO).as_posix()
    names = {
        *(relative_name(path) for path in umbrella_input_paths()),
        *(f"Lean/IUTThreeClosures/{module}{suffix}.lean"
          for _, module, _, _ in MODULES for suffix in ("", "AxiomAudit")),
        *STATUS_RELATIVE_PATHS,
        *RESEARCH_RELATIVE_PATHS,
        *ENDPOINT_RELATIVE_PATHS,
        *SUCCESSOR_RELATIVE_PATHS,
        *PBT_RELATIVE_PATHS,
        *(relative_name(path) for path in paper_input_closure()),
        *FINAL_PAPER_ARTIFACT_RELATIVE_PATHS,
        *(f"{package_prefix}/{name}" for name in PACKAGE_STATIC_NAMES),
        *(f"{package_prefix}/{name}" for name in evidence_names()),
    }
    manifest_name = f"{package_prefix}/SHA256SUMS"
    names.discard(manifest_name)
    if not include_verification_summary:
        names.discard(f"{package_prefix}/verification_summary.json")
    canonical = tuple(sorted(canonical_relative_path(name) for name in names))
    if len(canonical) != len(names):
        raise ValueError("duplicate manifest path")
    for name in canonical:
        repo_path(name)
    return canonical
