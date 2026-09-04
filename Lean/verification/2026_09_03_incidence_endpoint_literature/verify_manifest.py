#!/usr/bin/env python3
"""Read-only exact-set SHA-256 verification for this checkpoint and PDF."""

from __future__ import annotations

import re
import json
import sys

sys.dont_write_bytecode = True

from checkpoint_scope import (
    ENDPOINT,
    FINAL_PAPER_ARTIFACT_RELATIVE_PATHS,
    HERE,
    PBT,
    SUCCESSOR,
    authored_artifact_paths,
    canonical_relative_path,
    expected_manifest_names,
    relative_name,
    repo_path,
    sha256,
)


MANIFEST = HERE / "SHA256SUMS"
ROW = re.compile(r"^([0-9a-f]{64})  (.+)$")


def require_current_verification_snapshot(verification: dict[str, object]) -> None:
    snapshot_names = expected_manifest_names(include_verification_summary=False)
    current_snapshot = {name: sha256(repo_path(name)) for name in snapshot_names}
    if verification.get("sealed_inputs_sha256") != current_snapshot:
        raise SystemExit("sealed all-input snapshot is stale")

    authored = verification.get("authored_artifacts")
    if not isinstance(authored, dict):
        raise SystemExit("verification lacks authored-artifact snapshot")
    current_authored = {
        relative_name(path): sha256(path) for path in authored_artifact_paths()
    }
    if authored.get("sha256") != current_authored:
        raise SystemExit("sealed authored-source snapshot is stale")
    paper = verification.get("paper_seal")
    if not isinstance(paper, dict):
        raise SystemExit("verification lacks paper seal")
    current_paper = {
        name: sha256(repo_path(name)) for name in FINAL_PAPER_ARTIFACT_RELATIVE_PATHS
    }
    if paper.get("artifact_sha256") != current_paper:
        raise SystemExit("sealed paper-artifact snapshot is stale")


def main() -> int:
    if sys.flags.optimize != 0:
        raise SystemExit("manifest verification forbids Python -O/PYTHONOPTIMIZE")
    if MANIFEST.is_symlink() or not MANIFEST.is_file():
        raise SystemExit("missing or symlinked SHA256SUMS")
    lines = MANIFEST.read_text(encoding="utf-8").splitlines()
    if not lines:
        raise SystemExit("empty manifest")
    rows: list[tuple[str, str]] = []
    for line in lines:
        match = ROW.fullmatch(line)
        if match is None:
            raise SystemExit(f"malformed manifest row: {line!r}")
        digest, raw_name = match.groups()
        try:
            name = canonical_relative_path(raw_name)
        except ValueError as exc:
            raise SystemExit(str(exc)) from exc
        rows.append((name, digest))

    names = [name for name, _ in rows]
    if names != sorted(names) or len(names) != len(set(names)):
        raise SystemExit("manifest paths are not unique and sorted")
    expected_names = list(expected_manifest_names())
    if names != expected_names:
        missing = sorted(set(expected_names) - set(names))
        extra = sorted(set(names) - set(expected_names))
        raise SystemExit(f"manifest scope mismatch: missing={missing}, extra={extra}")

    for name, expected_digest in rows:
        try:
            path = repo_path(name)
        except (ValueError, FileNotFoundError) as exc:
            raise SystemExit(str(exc)) from exc
        observed = sha256(path)
        if observed != expected_digest:
            raise SystemExit(f"hash mismatch: {name}")
    verification = json.loads((HERE / "verification_summary.json").read_text(encoding="utf-8"))
    run_summary = json.loads((HERE / "run_summary.json").read_text(encoding="utf-8"))
    if verification.get("status") != "PASS" or run_summary.get("status") != "PASS":
        raise SystemExit("sealed summaries do not report PASS")
    if verification.get("paper_seal", {}).get("status") != "PASS":
        raise SystemExit("sealed paper audit does not report PASS")
    require_current_verification_snapshot(verification)
    caches = [
        path
        for root in (HERE, ENDPOINT, SUCCESSOR, PBT)
        for path in root.rglob("__pycache__")
        if path.is_dir()
    ]
    if caches:
        raise SystemExit(f"unsealed Python bytecode caches present: {caches}")
    print(f"PASS: verified exact set of {len(rows)} SHA-256 entries")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
