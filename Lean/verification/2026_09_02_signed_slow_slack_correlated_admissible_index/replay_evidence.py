#!/usr/bin/env python3
"""Replay the four evidence bundles and emit one deterministic summary."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
from typing import Any


PACKAGE_ROOT = Path(__file__).resolve().parent
REPO_ROOT = PACKAGE_ROOT.parents[2]
AFFINE = REPO_ROOT / "research/computation/2026_09_01_affine_signed_ray_caps"
MERSENNE = REPO_ROOT / "research/computation/2026_09_01_mersenne_critical_slow_slack"
MERSENNE_SOURCE = REPO_ROOT / "research/sources/mersenne_critical_slow_slack_2026_09_01"
PELL = REPO_ROOT / "research/computation/2026_09_01_pell_lucas_correlated_all_order"
IUT = REPO_ROOT / "research/sources/iut_admissible_scaling_order_index_2026_09_02"


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
    if process.returncode != 0:
        raise RuntimeError(
            f"command failed ({process.returncode}): "
            f"{subprocess.list2cmdline(command)}\n{process.stdout}"
        )
    return process.stdout.replace("\r\n", "\n")


def verify_hash_manifest(directory: Path, name: str) -> int:
    manifest = directory / name
    if not manifest.is_file():
        raise RuntimeError(f"missing hash manifest: {manifest}")
    count = 0
    seen: set[str] = set()
    for line in manifest.read_text(encoding="utf-8").splitlines():
        if not line:
            continue
        pieces = line.split("  ", 1)
        if len(pieces) != 2:
            raise RuntimeError(f"malformed hash line in {manifest}: {line!r}")
        expected, relative = pieces
        if relative in seen:
            raise RuntimeError(f"duplicate hash entry in {manifest}: {relative}")
        seen.add(relative)
        path = directory / relative
        if not path.is_file() or sha256(path) != expected:
            raise RuntimeError(f"hash mismatch: {path}")
        count += 1
    return count


def load_json(path: Path) -> dict[str, Any]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise RuntimeError(f"expected JSON object: {path}")
    return value


def replay_affine() -> tuple[dict[str, Any], int]:
    stdout = run([sys.executable, "-B", "verify_signed_ray_caps.py"], AFFINE)
    frozen_stdout = (AFFINE / "OUTPUT.txt").read_text(encoding="utf-8").replace(
        "\r\n", "\n"
    )
    if stdout != frozen_stdout:
        raise RuntimeError("affine replay stdout differs from OUTPUT.txt")
    if not stdout.rstrip().endswith(
        "PASS: all signed-ray, arm-cap, owner-global, and actual-box checks"
    ):
        raise RuntimeError("affine replay lacks its exact PASS marker")
    hashes = verify_hash_manifest(AFFINE, "SHA256SUMS")
    data = load_json(AFFINE / "verification.json")
    if data.get("schema") != "affine-signed-ray-caps-v2":
        raise RuntimeError("affine evidence schema changed")
    boxes = data["actual_affine_boxes"]
    selected = [box["canonical_owner_global_audit"] for box in boxes]
    stress = data["canonical_owner_nonarm_stress_case"]
    boundary = data["owner_membership_boundary_counterexample"]
    result = {
        "armCaptures": data["capture_boundary_tests"]["primitive_exact_capture_cases"],
        "catalogueDeletion": {
            "allDivisorWeight": boundary["all_arm_divisor_large_weight"],
            "ownerMass": boundary["selected_kernel_owner_mass"],
        },
        "cubicLedgers": data["ledger_tests"]["cubic_ledger_cases"],
        "directions": data["direction_tests"]["tested"],
        "quadraticLedgers": data["ledger_tests"]["quadratic_ledger_cases"],
        "selectedM10Large": sum(row["large_labels"] for row in selected),
        "selectedM10Repeated": sum(row["repeated_large_labels"] for row in selected),
        "stressLarge": stress["large_labels"],
        "stressNonarm": stress["nonarm_repeated"],
        "stressRepeated": stress["repeated_large_labels"],
        "verificationSha256": sha256(AFFINE / "verification.json"),
    }
    return result, hashes


def replay_mersenne() -> tuple[dict[str, Any], int]:
    stdout = run([sys.executable, "-B", "verify.py", "--verify"], MERSENNE)
    expected = (
        "PASS: residue table, 9591 odd-prime character checks, and exact "
        "Wieferich rows through 100000\n"
    )
    if stdout != expected:
        raise RuntimeError("Mersenne replay stdout changed")
    hashes = verify_hash_manifest(MERSENNE, "SHA256SUMS")
    hashes += verify_hash_manifest(MERSENNE_SOURCE, "SHA256SUMS")
    data = load_json(MERSENNE / "critical_slow_slack_verification.json")
    if data.get("schema") != "mersenne-critical-slow-slack-v1":
        raise RuntimeError("Mersenne evidence schema changed")
    rows = [
        {
            "depth": row["canonical_depth"],
            "multiplier": row["multiplier"],
            "order": row["exact_order"],
            "prime": row["p"],
        }
        for row in data["wieferich_hits"]
    ]
    return {
        "characterIdentity": data["all_odd_primes_satisfy_character_identity"],
        "oddPrimeCount": data["odd_prime_count"],
        "primeCount": data["prime_count"],
        "retirementWitness": data["retirement_witness"],
        "scanLimit": data["scan_limit"],
        "wieferichRows": rows,
    }, hashes


def replay_pell() -> tuple[dict[str, Any], int]:
    verify_hash_manifest(PELL, "SHA256SUMS.txt")
    producer = run(
        [sys.executable, "-B", "produce_correlated_all_order_packet.py"], PELL
    )
    if producer != (PELL / "producer_stdout.txt").read_text(
        encoding="utf-8"
    ).replace("\r\n", "\n"):
        raise RuntimeError("Pell producer stdout changed")
    verifier = run(
        [sys.executable, "-B", "verify_correlated_all_order_packet.py"], PELL
    )
    if verifier != (PELL / "verifier_stdout.txt").read_text(
        encoding="utf-8"
    ).replace("\r\n", "\n"):
        raise RuntimeError("Pell verifier stdout changed")
    manifest_stdout = run([sys.executable, "-B", "verify_manifest.py"], PELL)
    if "PASS" not in manifest_stdout:
        raise RuntimeError("Pell manifest replay lacks PASS")
    hashes = verify_hash_manifest(PELL, "SHA256SUMS.txt")
    data = load_json(PELL / "correlated_all_order_verification.json")
    if data.get("status") != "PASS" or data.get("errors") != []:
        raise RuntimeError("Pell verification is not exact PASS with no errors")
    verified = data["verified"]
    return {
        "coefficientPairs": verified["coefficient_pairs"],
        "depthThreeHits": verified["depth_three_hit_count"],
        "indexElevenMixedSigns": verified["index_eleven_row_has_both_signs"],
        "largestPrimeIndex": verified["all_prime_indices_through"],
        "polynomialChecks": verified["polynomial_checks"],
        "primeCandidateTests": verified["candidate_prime_tests"],
        "primeIndices": verified["prime_indices_with_exact_simple_witness"],
        "repeatedHits": verified["repeated_hits"],
        "verificationSha256": sha256(
            PELL / "correlated_all_order_verification.json"
        ),
    }, hashes


def replay_iut() -> tuple[dict[str, Any], int]:
    stdout = run([sys.executable, "-B", "verify_source_metadata.py"], IUT)
    required = (
        "PASS exact patch replay Iut/Concrete/Container.lean",
        "PASS exact patch replay Iut/Cor312/LogVolume.lean",
        "PASS exact patch replay Iut/Concrete/LocalTheory.lean",
        "PASS current-source theorem boundary and 8767-job build marker",
        "PASS SHA256SUMS exact coverage and 15 hashes",
        "PASS 13 frozen source/artifact entries",
    )
    for marker in required:
        if marker not in stdout:
            raise RuntimeError(f"IUT replay lacks marker: {marker}")
    hashes = verify_hash_manifest(IUT, "SHA256SUMS")
    metadata = load_json(IUT / "source-metadata.json")
    commit = metadata["projectLana"]["mainCommit"]
    if f"PASS Project LANA recorded main commit {commit}" not in stdout:
        raise RuntimeError("IUT replay commit marker changed")
    return {
        "buildJobs": 8767,
        "commit": commit,
        "frozenEntries": 13,
        "patchFiles": 3,
        "sealEntries": hashes,
    }, hashes


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    affine, affine_hashes = replay_affine()
    mersenne, mersenne_hashes = replay_mersenne()
    pell, pell_hashes = replay_pell()
    iut, iut_hashes = replay_iut()
    document = {
        "affine": affine,
        "hashEntries": {
            "affine": affine_hashes,
            "iut": iut_hashes,
            "mersenneComputationAndSource": mersenne_hashes,
            "pell": pell_hashes,
            "total": affine_hashes + mersenne_hashes + pell_hashes + iut_hashes,
        },
        "iut": iut,
        "mersenne": mersenne,
        "pell": pell,
        "schema": "abc-signed-slow-correlated-admissible-evidence-v1",
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
        f"affine={affine['cubicLedgers']} cubic; "
        f"Mersenne={mersenne['oddPrimeCount']} odd primes; "
        f"Pell={pell['primeIndices']} prime indices; "
        f"IUT={iut['buildJobs']} recorded build jobs; "
        f"hashes={document['hashEntries']['total']}"
    )


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        raise
