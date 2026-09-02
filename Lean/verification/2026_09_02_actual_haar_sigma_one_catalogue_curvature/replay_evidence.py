#!/usr/bin/env python3
"""Replay the four computation bundles into an independent temporary tree."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
from typing import Any


PACKAGE_ROOT = Path(__file__).resolve().parent
REPO_ROOT = PACKAGE_ROOT.parents[2]
IUT = REPO_ROOT / "research/computation/2026_09_02_iut_actual_haar_orbit"
MERSENNE = REPO_ROOT / "research/computation/2026_09_02_mersenne_sigma_one"
AFFINE = REPO_ROOT / "research/computation/2026_09_02_affine_inverse_period_catalogue"
PELL = REPO_ROOT / "research/computation/2026_09_02_pell_factor_quotient_coupling"


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def run(command: list[str], cwd: Path) -> str:
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
    output = process.stdout.replace("\r\n", "\n")
    if process.returncode != 0:
        raise RuntimeError(
            f"command failed ({process.returncode}): "
            f"{subprocess.list2cmdline(command)}\n{output}"
        )
    return output


def load_object(path: Path) -> dict[str, Any]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise RuntimeError(f"expected JSON object: {path}")
    return value


def verify_hash_manifest(directory: Path, name: str) -> int:
    manifest = directory / name
    if not manifest.is_file():
        raise RuntimeError(f"missing hash manifest: {manifest}")
    seen: set[str] = set()
    resolved_seen: set[Path] = set()
    resolved_directory = directory.resolve()
    allowed_external = {
        (REPO_ROOT / "Lean/IUTThreeClosures/"
         "AffineInversePeriodCatalogueNovelty20260902.lean").resolve():
            "../../../Lean/IUTThreeClosures/"
            "AffineInversePeriodCatalogueNovelty20260902.lean",
        (REPO_ROOT / "research/"
         "ABC_AFFINE_INVERSE_PERIOD_CATALOGUE_NOVELTY_2026_09_02.md").resolve():
            "../../ABC_AFFINE_INVERSE_PERIOD_CATALOGUE_NOVELTY_2026_09_02.md",
    } if directory == AFFINE else {}
    observed_external: set[Path] = set()
    for line in manifest.read_text(encoding="utf-8").splitlines():
        if not line:
            continue
        match = re.fullmatch(r"([0-9a-f]{64})  (.+)", line)
        if not match:
            raise RuntimeError(f"malformed hash line in {manifest}: {line!r}")
        expected, relative = match.groups()
        if (
            not relative
            or "\\" in relative
            or ":" in relative
            or Path(relative).is_absolute()
            or Path(*Path(relative).parts).as_posix() != relative
        ):
            raise RuntimeError(f"noncanonical manifest path in {manifest}: {relative}")
        if relative in seen:
            raise RuntimeError(f"duplicate hash entry in {manifest}: {relative}")
        seen.add(relative)
        candidate = (directory / relative).resolve()
        try:
            candidate.relative_to(REPO_ROOT.resolve())
        except ValueError as exc:
            raise RuntimeError(f"manifest path escapes repository: {relative}") from exc
        if candidate in resolved_seen:
            raise RuntimeError(f"duplicate resolved manifest target: {candidate}")
        resolved_seen.add(candidate)
        try:
            candidate.relative_to(resolved_directory)
        except ValueError:
            if allowed_external.get(candidate) != relative:
                raise RuntimeError(f"unapproved external manifest target: {candidate}")
            observed_external.add(candidate)
        else:
            if ".." in Path(relative).parts:
                raise RuntimeError(f"noncanonical local manifest alias: {relative}")
        if not candidate.is_file() or sha256(candidate) != expected:
            raise RuntimeError(f"hash mismatch: {candidate}")
    if not seen:
        raise RuntimeError(f"empty hash manifest: {manifest}")
    if observed_external != set(allowed_external):
        raise RuntimeError(
            f"external manifest coverage changed: {sorted(map(str, observed_external))}"
        )
    stable_local = {
        path.resolve()
        for path in directory.rglob("*")
        if (
            path.is_file()
            and path.resolve() != manifest.resolve()
            and "__pycache__" not in path.parts
            and path.suffix.lower() != ".pyc"
        )
    }
    manifest_local = {
        path for path in resolved_seen if path not in observed_external
    }
    if manifest_local != stable_local:
        missing = sorted(map(str, stable_local - manifest_local))
        extra = sorted(map(str, manifest_local - stable_local))
        raise RuntimeError(
            f"manifest local coverage changed for {directory}: "
            f"missing={missing}, extra={extra}"
        )
    return len(seen)


def exact_stdout(actual: str, frozen: Path, label: str) -> None:
    expected = frozen.read_text(encoding="utf-8").replace("\r\n", "\n")
    if actual != expected:
        raise RuntimeError(f"{label} stdout differs from {frozen.name}")


def replay_iut() -> tuple[dict[str, Any], int]:
    hashes = verify_hash_manifest(IUT, "SHA256SUMS")
    stdout = run([sys.executable, "-B", "verify_normalization.py"], IUT)
    exact_stdout(stdout, IUT / "verification_output.json", "IUT normalization")
    data = json.loads(stdout)
    if data.get("status") != "PASS":
        raise RuntimeError("IUT normalization status is not PASS")
    rows = data.get("raw_and_normalized_rows", [])
    if len(rows) != 20 or not all(
        row.get("raw_identity") and row.get("normalized_identity") for row in rows
    ):
        raise RuntimeError("IUT Haar normalization rows changed")
    counterexample = data.get("raw_weight_sum_counterexample", {})
    packet = data.get("normalized_packet_check", {})
    if not counterexample.get("strict_counterexample") or not packet.get("packet_identity"):
        raise RuntimeError("IUT counterexample or packet identity changed")
    return {
        "normalizationRows": len(rows),
        "normalizedPacketIdentity": True,
        "rawResidueDegreeTwoCounterexample": True,
        "verificationSha256": sha256(IUT / "verification_output.json"),
    }, hashes


def replay_mersenne(work: Path) -> tuple[dict[str, Any], int]:
    hashes = verify_hash_manifest(MERSENNE, "SHA256SUMS")
    local = work / "mersenne"
    local.mkdir()
    for name in ("verify_witnesses.py", "scan_1b.json"):
        shutil.copy2(MERSENNE / name, local / name)
    stdout = run([sys.executable, "-B", "verify_witnesses.py"], local)
    exact_stdout(stdout, MERSENNE / "verify_witnesses_output.json", "Mersenne witness")
    if (local / "verify_witnesses_output.json").read_bytes() != (
        MERSENNE / "verify_witnesses_output.json"
    ).read_bytes():
        raise RuntimeError("Mersenne regenerated certificate differs")
    cert = json.loads(stdout)
    scan = load_object(MERSENNE / "scan_1b.json")
    compiler = shutil.which("g++")
    if compiler is None:
        raise RuntimeError("g++ is required to replay the complete p <= 10^9 scan")
    executable = local / ("scan-replay.exe" if sys.platform == "win32" else "scan-replay")
    compile_output = run(
        [compiler, "-O3", "-std=c++20", str(MERSENNE / "scan.cpp"),
         "-o", str(executable)],
        REPO_ROOT,
    )
    if compile_output:
        raise RuntimeError("Mersenne scan compilation unexpectedly emitted output")
    scan_stdout = run([str(executable), str(10**9)], local)
    exact_stdout(scan_stdout, MERSENNE / "scan_1b.json", "Mersenne complete scan")
    checks = cert.get("exact_rational_log_window_certificates", {})
    if (
        cert.get("schema") != "sigma-one-witness-independent-v1"
        or not cert.get("factor_product_equals_phi")
        or not cert.get("scan_1b_crosscheck_pass")
        or not checks.get("all_checks_pass")
    ):
        raise RuntimeError("Mersenne exact certificate changed")
    expected_hits = [
        {"p": 1093, "d": 364, "r": 3},
        {"p": 3511, "d": 1755, "r": 2},
    ]
    if scan != {"limit": 10**9, "prime_count": 50_847_534, "hits": expected_hits}:
        raise RuntimeError("Mersenne complete scan record changed")
    return {
        "completeScanReplayed": True,
        "exactLogWindowChecks": len(checks["checks"]),
        "factorProductEqualsPhi": True,
        "scanHits": expected_hits,
        "scanLimit": scan["limit"],
        "scanPrimeCount": scan["prime_count"],
        "verificationSha256": sha256(MERSENNE / "verify_witnesses_output.json"),
    }, hashes


def replay_affine(work: Path) -> tuple[dict[str, Any], int]:
    hashes = verify_hash_manifest(AFFINE, "SHA256SUMS.txt")
    local = work / "affine"
    shutil.copytree(
        AFFINE,
        local,
        ignore=shutil.ignore_patterns("__pycache__", "*.pyc"),
    )
    runs = (
        ("verify_inverse_period_catalogue.py", "OUTPUT_PERIOD_ONE.txt",
         "PASS: canonical M=388 T=1 non-arm witness and full selected catalogue"),
        ("verify_cross_singleton.py", "OUTPUT_CROSS_SINGLETON.txt",
         "PASS: canonical M=170 cross-singleton repeated-label witness"),
        ("verify_subcritical_full_catalogues.py", "OUTPUT_SUBCRITICAL.txt",
         "PASS: subcritical canonical B=8 T=1 cross-singleton fibre"),
        ("verify_euler_and_subcritical.py", "OUTPUT_EULER.txt",
         "PASS: exact Euler factors, hybrid tails, and canonical boundary witnesses"),
        ("independent_replay.py", "INDEPENDENT_REPLAY.txt",
         "PASS: independent direct-divisor and congruence replay"),
        ("run_canonical_catalogue_scan.py", "OUTPUT_CANONICAL_SCAN.txt",
         "PASS: canonical catalogue identities and support covers in all six cases"),
    )
    for script, output, marker in runs:
        stdout = run([sys.executable, "-B", script], local)
        exact_stdout(stdout, AFFINE / output, f"Affine {script}")
        if not stdout.rstrip().endswith(marker):
            raise RuntimeError(f"Affine replay lacks marker: {marker}")
    if (local / "verification.json").read_bytes() != (
        AFFINE / "verification.json"
    ).read_bytes():
        raise RuntimeError("Affine regenerated verification.json differs")
    verification = load_object(AFFINE / "verification.json")
    canonical_text = (AFFINE / "OUTPUT_CANONICAL_SCAN.txt").read_text(encoding="utf-8")
    canonical_json = json.loads(canonical_text[canonical_text.index("{"):
                                               canonical_text.rindex("}\n") + 1])
    totals = canonical_json.get("totals")
    expected_totals = {
        "parameter_cases": 6,
        "admissible_selected": 755_322,
        "kernel_classes": 3_885,
        "large_labels": 7_641,
        "repeated_labels": 631,
        "nonarm_labels": 34,
    }
    if totals != expected_totals:
        raise RuntimeError("Affine canonical totals changed")
    identities = verification.get("exhaustive_identities", {})
    subcritical = verification.get("subcritical_cross_singleton_boundary", {})
    if (
        verification.get("schema") != "affine-inverse-period-catalogue-v1"
        or identities.get("prime_power_cases") != 588
        or identities.get("general_euler_cases") != 48_400
        or identities.get("occupancy_bridge_cases") != 10_001
        or subcritical.get("weight_over_D") != "23392/23701"
        or subcritical.get("period") != 1
    ):
        raise RuntimeError("Affine exhaustive verification changed")
    return {
        "canonicalTotals": totals,
        "generalEulerCases": identities["general_euler_cases"],
        "occupancyBridgeCases": identities["occupancy_bridge_cases"],
        "primePowerCases": identities["prime_power_cases"],
        "scriptRuns": len(runs),
        "subcriticalPeriod": subcritical["period"],
        "subcriticalWeightOverD": subcritical["weight_over_D"],
        "verificationSha256": sha256(AFFINE / "verification.json"),
    }, hashes


def replay_pell(work: Path) -> tuple[dict[str, Any], int]:
    hashes = verify_hash_manifest(PELL, "SHA256SUMS.txt")
    manifest_stdout = run([sys.executable, "-B", "verify_manifest.py"], PELL)
    if manifest_stdout != f"PASS files={hashes}\n":
        raise RuntimeError("Pell manifest verifier output changed")
    packet = work / "factor_quotient_projective_packet.json"
    producer_stdout = run(
        [sys.executable, "-B", str(PELL / "produce_factor_quotient_projective_coupling.py"),
         "--output", str(packet)],
        REPO_ROOT,
    )
    producer = json.loads(producer_stdout)
    producer.pop("output", None)
    if producer != {
        "status": "PASS",
        "endpoint_rows": 57,
        "factor_quotient_rows": 13,
        "exact_simple_witnesses": 57,
        "full_actual_packets": 0,
        "local_counterexample": [3, 7, 797],
    }:
        raise RuntimeError("Pell producer summary changed")
    if packet.read_bytes() != (PELL / "factor_quotient_projective_packet.json").read_bytes():
        raise RuntimeError("Pell regenerated packet differs")
    verified_path = work / "factor_quotient_projective_verification.json"
    verifier_stdout = run(
        [sys.executable, "-B", str(PELL / "verify_factor_quotient_projective_coupling.py"),
         "--input", str(packet), "--output", str(verified_path)],
        REPO_ROOT,
    )
    exact_stdout(verifier_stdout, PELL / "verifier_stdout.txt", "Pell verifier")
    if verified_path.read_bytes() != (
        PELL / "factor_quotient_projective_verification.json"
    ).read_bytes():
        raise RuntimeError("Pell regenerated verification differs")
    verification = json.loads(verifier_stdout)
    details = verification.get("verified", {})
    if verification.get("status") != "PASS" or verification.get("errors") != []:
        raise RuntimeError("Pell verification is not exact PASS")
    factor_rows = details.get("factor_quotient_rows", [])
    return {
        "actualSquarefullPackets": details["actual_squarefull_packets_in_factored_rows"],
        "endpointExactAndSharpRows": details["endpoint_exact_and_sharp_rows"],
        "exactSimpleWitnesses": details["exact_simple_witnesses"],
        "factorQuotientRows": len(factor_rows),
        "largestPrimeIndex": details["all_prime_indices_through"],
        "localL3Counterexample": details["local_L3_counterexample"],
        "packetSha256": sha256(PELL / "factor_quotient_projective_packet.json"),
        "verificationSha256": sha256(
            PELL / "factor_quotient_projective_verification.json"
        ),
    }, hashes


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    (REPO_ROOT / "tmp").mkdir(exist_ok=True)
    with tempfile.TemporaryDirectory(
        prefix="abc-actual-haar-sigma-one-", dir=REPO_ROOT / "tmp"
    ) as temporary:
        work = Path(temporary)
        iut, iut_hashes = replay_iut()
        mersenne, mersenne_hashes = replay_mersenne(work)
        affine, affine_hashes = replay_affine(work)
        pell, pell_hashes = replay_pell(work)
    document = {
        "affine": affine,
        "hashEntries": {
            "affine": affine_hashes,
            "iut": iut_hashes,
            "mersenne": mersenne_hashes,
            "pell": pell_hashes,
            "total": affine_hashes + iut_hashes + mersenne_hashes + pell_hashes,
        },
        "iut": iut,
        "mersenne": mersenne,
        "pell": pell,
        "schema": "abc-actual-haar-sigma-one-catalogue-curvature-evidence-v1",
        "status": "PASS",
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(document, indent=2, ensure_ascii=False, sort_keys=True) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    print(
        "PASS evidence replay: "
        f"IUT={iut['normalizationRows']} rows; "
        f"Mersenne={mersenne['scanPrimeCount']} primes; "
        f"Affine={affine['scriptRuns']} scripts; "
        f"Pell={pell['endpointExactAndSharpRows']} endpoints; "
        f"hashes={document['hashEntries']['total']}"
    )


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        raise
