from __future__ import annotations

import hashlib
import json
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path


ROOT = Path(__file__).resolve().parent
FROZEN = ("ABC_HITS.csv", "SCAN_SUMMARY.txt", "STRUCTURED_OUTPUT.json", "OUTPUT.json")


def run(command: list[str], cwd: Path) -> str:
    completed = subprocess.run(
        command,
        cwd=cwd,
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        encoding="utf-8",
    )
    return completed.stdout


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1 << 20), b""):
            digest.update(block)
    return digest.hexdigest()


def main() -> None:
    compiler = shutil.which("g++")
    if compiler is None:
        raise SystemExit("g++ is required")
    with tempfile.TemporaryDirectory(prefix="abc_direct_replay_") as temp_name:
        temp = Path(temp_name)
        producer_exe = temp / "search_direct_abc.exe"
        validator_exe = temp / "validate_direct_abc.exe"
        run([compiler, "-O3", "-std=c++17", "-fopenmp", str(ROOT / "search_direct_abc.cpp"), "-o", str(producer_exe)], ROOT)
        run([compiler, "-O3", "-std=c++17", "-fopenmp", str(ROOT / "validate_direct_abc.cpp"), "-o", str(validator_exe)], ROOT)
        run(
            [
                str(producer_exe),
                "--max-c",
                "100000",
                "--hits",
                str(temp / "ABC_HITS.csv"),
                "--summary",
                str(temp / "SCAN_SUMMARY.txt"),
                "--threads",
                "8",
            ],
            ROOT,
        )
        validator_stdout = run(
            [
                str(validator_exe),
                "--max-c",
                "100000",
                "--hits",
                str(temp / "ABC_HITS.csv"),
                "--threads",
                "8",
            ],
            ROOT,
        )
        assert "all_csv_rows_exactly_reproduced=true" in validator_stdout
        run(
            [sys.executable, str(ROOT / "search_structured_families.py"), "--output", str(temp / "STRUCTURED_OUTPUT.json")],
            ROOT,
        )
        run(
            [
                sys.executable,
                str(ROOT / "analyze_direct_abc.py"),
                "--hits",
                str(temp / "ABC_HITS.csv"),
                "--summary",
                str(temp / "SCAN_SUMMARY.txt"),
                "--structured",
                str(temp / "STRUCTURED_OUTPUT.json"),
                "--output",
                str(temp / "OUTPUT.json"),
            ],
            ROOT,
        )
        hashes: dict[str, str] = {}
        for name in FROZEN:
            replayed = temp / name
            frozen = ROOT / name
            assert replayed.read_bytes() == frozen.read_bytes(), f"byte replay mismatch: {name}"
            hashes[name] = sha256(frozen)
    print(
        json.dumps(
            {
                "status": "PASS",
                "max_c": 100_000,
                "threads": 8,
                "independent_cpp_validator_passed": True,
                "frozen_files_replayed_byte_for_byte": list(FROZEN),
                "sha256": hashes,
            },
            indent=2,
            sort_keys=True,
        )
    )


if __name__ == "__main__":
    main()
