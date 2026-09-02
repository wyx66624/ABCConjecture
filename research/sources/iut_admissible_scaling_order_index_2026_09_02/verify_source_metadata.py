#!/usr/bin/env python3
"""Verify frozen sources and replay the admissible-scaling patch exactly."""

from __future__ import annotations

import hashlib
import json
import shutil
import subprocess
import tempfile
from pathlib import Path


HERE = Path(__file__).resolve().parent
EXPECTED_PATCH_PATHS = {
    "Iut/Concrete/Container.lean",
    "Iut/Concrete/LocalTheory.lean",
    "Iut/Cor312/LogVolume.lean",
}
SEAL_NAME = "SHA256SUMS"


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def verify_file(entry: dict[str, object]) -> None:
    path = (HERE / str(entry["path"])).resolve()
    if not path.is_file():
        raise SystemExit(f"missing source: {path}")
    actual_bytes = path.stat().st_size
    expected_bytes = int(entry["bytes"])
    if actual_bytes != expected_bytes:
        raise SystemExit(
            f"byte mismatch for {path}: {actual_bytes} != {expected_bytes}"
        )
    actual_hash = sha256(path)
    expected_hash = str(entry["sha256"])
    if actual_hash != expected_hash:
        raise SystemExit(
            f"SHA-256 mismatch for {path}: {actual_hash} != {expected_hash}"
        )
    print(f"PASS {entry['path']} {actual_bytes} {actual_hash}")


def verify_ledger_seal() -> None:
    seal = HERE / SEAL_NAME
    if not seal.is_file():
        raise SystemExit(f"missing ledger seal: {seal}")
    recorded: dict[str, str] = {}
    for line_number, line in enumerate(
        seal.read_text(encoding="ascii").splitlines(), start=1
    ):
        fields = line.split("  ", 1)
        if len(fields) != 2 or len(fields[0]) != 64:
            raise SystemExit(f"malformed {SEAL_NAME} line {line_number}")
        digest, relative = fields
        path = Path(relative)
        if (
            path.is_absolute()
            or ".." in path.parts
            or path.as_posix() != relative
            or relative == SEAL_NAME
            or relative in recorded
        ):
            raise SystemExit(f"noncanonical or duplicate seal path: {relative!r}")
        recorded[relative] = digest

    actual = {
        path.relative_to(HERE).as_posix()
        for path in HERE.rglob("*")
        if path.is_file() and path.name != SEAL_NAME
    }
    if set(recorded) != actual:
        missing = sorted(actual - set(recorded))
        extra = sorted(set(recorded) - actual)
        raise SystemExit(f"ledger seal coverage mismatch: missing={missing}, extra={extra}")
    for relative, expected in recorded.items():
        observed = sha256(HERE / Path(relative))
        if observed != expected:
            raise SystemExit(
                f"ledger seal hash mismatch for {relative}: {observed} != {expected}"
            )
    print(f"PASS {SEAL_NAME} exact coverage and {len(recorded)} hashes")


def run_git_apply(root: Path, patch: Path, check: bool) -> None:
    # Disable the host's checkout conversion so the replay is byte-stable on
    # Windows as well as Unix.
    command = ["git", "-c", "core.autocrlf=false", "apply"]
    if check:
        command.append("--check")
    command.append(str(patch))
    completed = subprocess.run(
        command,
        cwd=root,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
    )
    if completed.returncode != 0:
        raise SystemExit(
            f"patch {'check' if check else 'application'} failed:\n{completed.stdout}"
        )


def verify_patch_replay(metadata: dict[str, object]) -> None:
    patch = HERE / "iut-c65b28c-admissible-scaling.patch"
    patch_text = patch.read_text(encoding="utf-8")
    touched = {
        line.split(" b/", 1)[1]
        for line in patch_text.splitlines()
        if line.startswith("diff --git a/") and " b/" in line
    }
    if touched != EXPECTED_PATCH_PATHS:
        raise SystemExit(f"unexpected patch paths: {sorted(touched)}")

    with tempfile.TemporaryDirectory(prefix="iut-admissible-replay-") as raw:
        root = Path(raw)
        for rel in EXPECTED_PATCH_PATHS:
            target = root / rel
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(HERE / "original" / rel, target)
        run_git_apply(root, patch, check=True)
        run_git_apply(root, patch, check=False)
        for rel in EXPECTED_PATCH_PATHS:
            actual = (root / rel).read_bytes()
            expected = (HERE / "patched" / rel).read_bytes()
            if actual != expected:
                raise SystemExit(f"patched byte mismatch after replay: {rel}")
            print(f"PASS exact patch replay {rel}")

    original_log_volume = (
        HERE / "original/Iut/Cor312/LogVolume.lean"
    ).read_text(encoding="utf-8")
    patched_log_volume = (
        HERE / "patched/Iut/Cor312/LogVolume.lean"
    ).read_text(encoding="utf-8")
    patched_local = (
        HERE / "patched/Iut/Concrete/LocalTheory.lean"
    ).read_text(encoding="utf-8")
    if "componentAdmissible" in original_log_volume:
        raise SystemExit("original LogVolume unexpectedly already has admissibility")
    for needle in (
        "componentAdmissible",
        "componentAdmissible_prime_preimage",
        "componentAdmissible i (.finite p) c U →",
    ):
        if needle not in patched_log_volume:
            raise SystemExit(f"patched LogVolume missing guard: {needle}")
    for needle in (
        "admissible_prime_preimage",
        "U ∈ admissible (.finite p) c →",
    ):
        if needle not in patched_local:
            raise SystemExit(f"patched LocalTheory missing guard: {needle}")

    existence = (HERE / "original/Iut/Concrete/Existence.lean").read_text(
        encoding="utf-8"
    )
    for needle in (
        "theorem concreteThetaDataExistence",
        "anab : AnabelianExistence AG TG",
        "LTp : ∀ D : InitialThetaData AG TG, LocalTheory",
        "h312 : ∀ (D : InitialThetaData AG TG)",
        "theorem cor312Variant_implies_abc_curves",
    ):
        if needle not in existence:
            raise SystemExit(f"current existence boundary missing: {needle}")

    build_log = (HERE / "logs/patched-c65b28c-build.log").read_text(
        encoding="utf-8"
    )
    if "Build completed successfully (8767 jobs)." not in build_log:
        raise SystemExit("patched current-source build success marker missing")
    print("PASS current-source theorem boundary and 8767-job build marker")


def main() -> None:
    metadata = json.loads((HERE / "source-metadata.json").read_text(encoding="utf-8"))
    expected_commit = metadata["projectLana"]["mainCommit"]
    remote_record = (HERE / "REMOTE_HEAD.txt").read_text(encoding="utf-8")
    if remote_record.count(expected_commit) < 2:
        raise SystemExit("REMOTE_HEAD.txt does not record expected HEAD and main")

    entries = (
        list(metadata["projectLana"]["originalFiles"])
        + list(metadata["projectLana"]["patchedFiles"])
        + list(metadata["artifacts"])
        + list(metadata["papers"])
    )
    for entry in entries:
        verify_file(entry)
    verify_patch_replay(metadata)
    verify_ledger_seal()
    print(f"PASS Project LANA recorded main commit {expected_commit}")
    print(f"PASS {len(entries)} frozen source/artifact entries")


if __name__ == "__main__":
    main()
