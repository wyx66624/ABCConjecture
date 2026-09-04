#!/usr/bin/env python3
"""Compile the journal paper while binding its recursive TeX closure to the PDF."""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

sys.dont_write_bytecode = True

from checkpoint_scope import REPO, paper_input_closure, relative_name, sha256


def atomic_text(path: Path, value: str) -> None:
    temporary = path.with_name(path.name + ".tmp")
    temporary.write_text(value, encoding="utf-8", newline="\n")
    os.replace(temporary, path)


def atomic_json(path: Path, value: object) -> None:
    atomic_text(path, json.dumps(value, indent=2, sort_keys=True) + "\n")


def source_snapshot() -> dict[str, str]:
    return {
        relative_name(path): sha256(path)
        for path in paper_input_closure()
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--driver-script", type=Path, required=True)
    parser.add_argument(
        "--paper",
        type=Path,
        default=REPO / "paper" / "ChatGPT_ABC_Uniformity_2026.tex",
    )
    parser.add_argument(
        "--output-directory", type=Path, default=REPO / "output" / "pdf"
    )
    parser.add_argument(
        "--qa-directory",
        type=Path,
        default=(
            REPO
            / "output"
            / "pdf"
            / "ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA"
        ),
    )
    args = parser.parse_args()

    driver_script = args.driver_script.resolve()
    paper = args.paper.resolve()
    output_directory = args.output_directory.resolve()
    qa_directory = args.qa_directory.resolve()
    if not driver_script.is_file() or driver_script.is_symlink():
        raise RuntimeError(f"missing or symlinked compile driver: {driver_script}")
    if not paper.is_file() or paper.is_symlink():
        raise RuntimeError(f"missing or symlinked paper source: {paper}")
    output_directory.mkdir(parents=True, exist_ok=True)
    qa_directory.mkdir(parents=True, exist_ok=True)

    before = source_snapshot()
    started = datetime.now(timezone.utc).isoformat()
    command = [
        sys.executable,
        str(driver_script),
        str(paper),
        "--compiler",
        "tectonic",
        "--output-directory",
        str(output_directory),
        "--json",
    ]
    completed = subprocess.run(
        command,
        cwd=paper.parent,
        text=True,
        encoding="utf-8",
        errors="strict",
        capture_output=True,
        check=False,
    )
    finished = datetime.now(timezone.utc).isoformat()
    atomic_text(qa_directory / "compile_driver.exitcode", f"{completed.returncode}\n")
    if completed.stderr:
        atomic_text(qa_directory / "compile_driver.stderr.log", completed.stderr)
    try:
        driver = json.loads(completed.stdout)
    except json.JSONDecodeError as error:
        atomic_text(qa_directory / "compile_driver.stdout.log", completed.stdout)
        raise RuntimeError("compile driver did not emit valid JSON") from error
    atomic_json(qa_directory / "compile_driver.json", driver)

    attempts = driver.get("attempts")
    if not isinstance(attempts, list) or not attempts:
        raise RuntimeError("compile driver JSON has no attempt record")
    final_attempt = attempts[-1]
    if not isinstance(final_attempt, dict):
        raise RuntimeError("malformed final compiler attempt")
    engine_log = final_attempt.get("log")
    if not isinstance(engine_log, str):
        raise RuntimeError("final compiler attempt has no text log")
    engine_exit = final_attempt.get("exitCode")
    if not isinstance(engine_exit, int):
        raise RuntimeError("final compiler attempt has no integer exit code")
    atomic_text(qa_directory / "compile_latex.log", engine_log)
    atomic_text(qa_directory / "tectonic_engine.log", engine_log)
    atomic_text(qa_directory / "compile_latex.exitcode", f"{engine_exit}\n")

    after = source_snapshot()
    pdf = output_directory / "ChatGPT_ABC_Uniformity_2026.pdf"
    pdf_exists = pdf.is_file() and not pdf.is_symlink()
    driver_success = (
        completed.returncode == 0
        and driver.get("exitCode") == 0
        and driver.get("pdfExists") is True
        and engine_exit == 0
        and pdf_exists
    )
    inputs_stable = before == after

    compiler_command = final_attempt.get("command")
    compiler_version = "unknown"
    if isinstance(compiler_command, list) and compiler_command:
        version = subprocess.run(
            [str(compiler_command[0]), "--version"],
            text=True,
            encoding="utf-8",
            errors="replace",
            capture_output=True,
            check=False,
        )
        compiler_version = (version.stdout or version.stderr).strip()

    provenance = {
        "schema": "abc-paper-build-provenance-v1",
        "status": "PASS" if driver_success and inputs_stable else "FAIL",
        "started_utc": started,
        "finished_utc": finished,
        "command": command,
        "cwd": str(paper.parent),
        "driver_script_sha256": sha256(driver_script),
        "driver_json_sha256": sha256(qa_directory / "compile_driver.json"),
        "driver_exit_code": completed.returncode,
        "compiler": final_attempt.get("compiler"),
        "compiler_version": compiler_version,
        "inputs_stable_during_build": inputs_stable,
        "source_count": len(after),
        "paper_input_sha256": after,
        "pdf_bytes": pdf.stat().st_size if pdf_exists else None,
        "pdf_sha256": sha256(pdf) if pdf_exists else None,
    }
    atomic_json(qa_directory / "paper_build_provenance.json", provenance)
    print(json.dumps(provenance, indent=2, sort_keys=True))
    return 0 if provenance["status"] == "PASS" else 1


if __name__ == "__main__":
    raise SystemExit(main())
