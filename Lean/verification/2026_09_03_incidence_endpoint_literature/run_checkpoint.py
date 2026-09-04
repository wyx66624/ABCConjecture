#!/usr/bin/env python3
"""Replay the incidence/endpoint/successor Lean and computation checkpoint."""

from __future__ import annotations

import argparse
import json
import os
import platform
import subprocess
import sys
import time
from pathlib import Path

sys.dont_write_bytecode = True

from checkpoint_scope import (
    ENDPOINT,
    HERE,
    LEAN,
    MODULES,
    PBT,
    REPO,
    SUCCESSOR,
    config_paths,
    environment_audit_input_paths,
    evidence_names,
    module_input_paths,
    relative_name,
    sha256,
    umbrella_input_paths,
)


RUN_SUMMARY = HERE / "run_summary.json"
VERIFICATION_SUMMARY = HERE / "verification_summary.json"
ENDPOINT_REPLAY = HERE / "endpoint-replay-output.json"
SUCCESSOR_REPLAY = HERE / "successor-replay-output.json"
PBT_REPLAY = HERE / "pbt-replay" / "OUTPUT.json"
PBT_REPLAY_CSV = HERE / "pbt-replay" / "STRUCTURED_FAMILIES.csv"


def atomic_text(path: Path, content: str, *, encoding: str = "utf-8") -> None:
    temporary = path.with_name(path.name + ".tmp")
    temporary.write_text(content, encoding=encoding, newline="\n")
    os.replace(temporary, path)


def input_digests(paths: tuple[Path, ...]) -> dict[str, str]:
    pairs = sorted((relative_name(path), path) for path in paths)
    if len(pairs) != len({name for name, _ in pairs}):
        raise ValueError("duplicate command input")
    return {name: sha256(path) for name, path in pairs}


def current_inputs_match(record: dict[str, object]) -> bool:
    inputs = record.get("input_sha256")
    if not isinstance(inputs, dict) or not inputs:
        return False
    return all(
        isinstance(name, str)
        and isinstance(digest, str)
        and (REPO / Path(*name.split("/"))).is_file()
        and sha256(REPO / Path(*name.split("/"))) == digest
        for name, digest in inputs.items()
    )


def relative_argument(path: Path, cwd: Path) -> str:
    return os.path.relpath(path, cwd).replace("\\", "/")


def run(
    name: str,
    argv: list[str],
    cwd: Path,
    inputs: tuple[Path, ...],
    *,
    recorded_argv: list[str] | None = None,
) -> dict[str, object]:
    before = input_digests(inputs)
    start = time.monotonic()
    child_environment = os.environ.copy()
    child_environment.update(
        {
            "PYTHONDONTWRITEBYTECODE": "1",
            "PYTHONHASHSEED": "0",
            "PYTHONOPTIMIZE": "0",
        }
    )
    try:
        proc = subprocess.run(
            argv,
            cwd=cwd,
            env=child_environment,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            encoding="utf-8",
            errors="replace",
            check=False,
        )
        output = proc.stdout
        exit_code = proc.returncode
    except OSError as exc:
        output = f"COMMAND LAUNCH FAILURE: {type(exc).__name__}: {exc}\n"
        exit_code = 127
    elapsed = round(time.monotonic() - start, 3)
    after = input_digests(inputs)
    atomic_text(HERE / f"{name}.log", output)
    atomic_text(HERE / f"{name}.exitcode", f"{exit_code}\n", encoding="ascii")
    print(f"{name}: exit={exit_code} seconds={elapsed}", flush=True)
    return {
        "name": name,
        "argv": recorded_argv if recorded_argv is not None else argv,
        "cwd": relative_name(cwd),
        "exit_code": exit_code,
        "elapsed_seconds": elapsed,
        "output_bytes": len(output.encode("utf-8")),
        "input_sha256": before,
        "inputs_stable_during_command": before == after,
    }


def write_run_summary(
    records: list[dict[str, object]],
    computation_status: str,
    status: str,
    *,
    error: str | None = None,
) -> None:
    summary: dict[str, object] = {
        "schema": "abc-incidence-endpoint-successor-pbt-replay-v3",
        "python": {
            "implementation": platform.python_implementation(),
            "version": platform.python_version(),
            "optimize": sys.flags.optimize,
        },
        "controlled_environment": {
            "PYTHONDONTWRITEBYTECODE": "1",
            "PYTHONHASHSEED": "0",
            "PYTHONOPTIMIZE": "0",
        },
        "computation_status": computation_status,
        "records": records,
        "status": status,
    }
    if error is not None:
        summary["error"] = error
    atomic_text(
        RUN_SUMMARY,
        json.dumps(summary, indent=2, sort_keys=True) + "\n",
    )


def invalidate_old_evidence() -> None:
    for name in (*evidence_names(), "SHA256SUMS"):
        (HERE / name).unlink(missing_ok=True)
    for temporary in HERE.glob("*.tmp"):
        temporary.unlink(missing_ok=True)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--skip-computation",
        action="store_true",
        help="run Lean checks only; produces PARTIAL evidence and exits 2",
    )
    args = parser.parse_args()

    invalidate_old_evidence()
    records: list[dict[str, object]] = []
    computation_status = "NOT_STARTED"
    try:
        if sys.flags.optimize != 0:
            raise RuntimeError("checkpoint runner forbids Python -O/PYTHONOPTIMIZE")

        records.append(
            run(
                "lean-version",
                ["lake", "env", "lean", "--version"],
                LEAN,
                config_paths(),
            )
        )

        # Refresh every imported olean before any direct axiom audit.  Later
        # checks must retain the same complete local source/config hashes.
        records.append(
            run(
                "umbrella-build",
                ["lake", "build", "IUTThreeClosures"],
                LEAN,
                umbrella_input_paths(),
            )
        )

        for stem, module, _, _ in MODULES:
            records.append(
                run(
                    f"{stem}-main-strict",
                    [
                        "lake",
                        "env",
                        "lean",
                        "-DwarningAsError=true",
                        f"IUTThreeClosures/{module}.lean",
                    ],
                    LEAN,
                    module_input_paths(module, audit=False),
                )
            )
            records.append(
                run(
                    f"{stem}-axiom-audit-strict",
                    [
                        "lake",
                        "env",
                        "lean",
                        "-DwarningAsError=true",
                        f"IUTThreeClosures/{module}AxiomAudit.lean",
                    ],
                    LEAN,
                    module_input_paths(module, audit=True),
                )
            )

        records.append(
            run(
                "environment-axiom-audit-strict",
                [
                    "lake",
                    "env",
                    "lean",
                    "-DwarningAsError=true",
                    "verification/2026_09_03_incidence_endpoint_literature/"
                    "EnvironmentAxiomAudit.lean",
                ],
                LEAN,
                environment_audit_input_paths(),
            )
        )

        if args.skip_computation:
            computation_status = "SKIPPED"
        else:
            endpoint_output_name = relative_name(ENDPOINT_REPLAY)
            endpoint_output_argument = relative_argument(ENDPOINT_REPLAY, ENDPOINT)
            records.append(
                run(
                    "endpoint-computation-replay",
                    [
                        sys.executable,
                        "search_endpoint_token_transport.py",
                        "--limit",
                        "5000",
                        "--lte-k-limit",
                        "12",
                        "--output",
                        endpoint_output_argument,
                    ],
                    ENDPOINT,
                    (ENDPOINT / "search_endpoint_token_transport.py",),
                    recorded_argv=[
                        "python",
                        "search_endpoint_token_transport.py",
                        "--limit",
                        "5000",
                        "--lte-k-limit",
                        "12",
                        "--output",
                        endpoint_output_name,
                    ],
                )
            )
            records.append(
                run(
                    "endpoint-independent-hall-audit",
                    [
                        sys.executable,
                        "independent_endpoint_hall_audit.py",
                        "--limit",
                        "5000",
                    ],
                    HERE,
                    (HERE / "independent_endpoint_hall_audit.py",),
                    recorded_argv=[
                        "python",
                        "independent_endpoint_hall_audit.py",
                        "--limit",
                        "5000",
                    ],
                )
            )
            successor_output_name = relative_name(SUCCESSOR_REPLAY)
            successor_output_argument = relative_argument(SUCCESSOR_REPLAY, SUCCESSOR)
            records.append(
                run(
                    "successor-computation-replay",
                    [
                        sys.executable,
                        "search_three_arm_successor.py",
                        "--cmax",
                        "1200",
                        "--rmax",
                        "12",
                        "--tmax",
                        "80",
                        "--output",
                        successor_output_argument,
                    ],
                    SUCCESSOR,
                    (SUCCESSOR / "search_three_arm_successor.py",),
                    recorded_argv=[
                        "python",
                        "search_three_arm_successor.py",
                        "--cmax",
                        "1200",
                        "--rmax",
                        "12",
                        "--tmax",
                        "80",
                        "--output",
                        successor_output_name,
                    ],
                )
            )
            pbt_output_name = relative_name(PBT_REPLAY)
            pbt_output_argument = relative_argument(PBT_REPLAY, PBT)
            pbt_csv_name = relative_name(PBT_REPLAY_CSV)
            pbt_csv_argument = relative_argument(PBT_REPLAY_CSV, PBT)
            records.append(
                run(
                    "pbt-computation-replay",
                    [
                        sys.executable,
                        "search_prime_packet_boundary.py",
                        "--cmax",
                        "3000",
                        "--coarse-ratio-denominator",
                        "120",
                        "--fine-ratio-denominator",
                        "12000",
                        "--structured-prime-limit",
                        "5000",
                        "--smooth-power-limit",
                        "8",
                        "--output",
                        pbt_output_argument,
                        "--structured-csv",
                        pbt_csv_argument,
                    ],
                    PBT,
                    (PBT / "search_prime_packet_boundary.py",),
                    recorded_argv=[
                        "python",
                        "search_prime_packet_boundary.py",
                        "--cmax",
                        "3000",
                        "--coarse-ratio-denominator",
                        "120",
                        "--fine-ratio-denominator",
                        "12000",
                        "--structured-prime-limit",
                        "5000",
                        "--smooth-power-limit",
                        "8",
                        "--output",
                        pbt_output_name,
                        "--structured-csv",
                        pbt_csv_name,
                    ],
                )
            )
            records.append(
                run(
                    "pbt-independent-full-audit",
                    [
                        sys.executable,
                        "validate_prime_packet_boundary.py",
                        "--directory",
                        ".",
                        "--skip-replay",
                    ],
                    PBT,
                    (
                        PBT / "validate_prime_packet_boundary.py",
                        PBT / "search_prime_packet_boundary.py",
                        PBT / "OUTPUT.json",
                        PBT / "STRUCTURED_FAMILIES.csv",
                    ),
                    recorded_argv=[
                        "python",
                        "validate_prime_packet_boundary.py",
                        "--directory",
                        ".",
                        "--skip-replay",
                    ],
                )
            )
            computation_status = "REPLAYED_AND_INDEPENDENTLY_AUDITED"

        all_successful = all(
            row["exit_code"] == 0
            and row["inputs_stable_during_command"] is True
            and current_inputs_match(row)
            for row in records
        )
        if args.skip_computation:
            status = "PARTIAL"
            return_code = 2
        else:
            status = "PASS" if all_successful else "FAIL"
            return_code = 0 if status == "PASS" else 1
        write_run_summary(records, computation_status, status)
        print(json.dumps({"tasks": len(records), "status": status}, sort_keys=True))
        return return_code
    except Exception as exc:
        write_run_summary(
            records,
            computation_status,
            "FAIL",
            error=f"{type(exc).__name__}: {exc}",
        )
        print(f"FAIL: {type(exc).__name__}: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
