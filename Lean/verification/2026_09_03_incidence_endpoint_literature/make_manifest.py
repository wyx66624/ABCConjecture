#!/usr/bin/env python3
"""Seal the exact checkpoint scope, including the final journal PDF."""

from __future__ import annotations

import os
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
    expected_manifest_names,
    relative_name,
    repo_path,
    sha256,
)


OUTPUT = HERE / "SHA256SUMS"


def require_current_verification_snapshot(verification: dict[str, object]) -> None:
    snapshot_names = expected_manifest_names(include_verification_summary=False)
    current_snapshot = {name: sha256(repo_path(name)) for name in snapshot_names}
    if verification.get("sealed_inputs_sha256") != current_snapshot:
        raise SystemExit("a sealed input changed after final verification")

    authored = verification.get("authored_artifacts")
    if not isinstance(authored, dict):
        raise SystemExit("verification lacks authored-artifact snapshot")
    recorded_authored = authored.get("sha256")
    current_authored = {
        relative_name(path): sha256(path) for path in authored_artifact_paths()
    }
    if recorded_authored != current_authored:
        raise SystemExit("authored source changed after final verification")

    paper = verification.get("paper_seal")
    if not isinstance(paper, dict):
        raise SystemExit("verification lacks paper seal")
    current_paper = {
        name: sha256(repo_path(name)) for name in FINAL_PAPER_ARTIFACT_RELATIVE_PATHS
    }
    if paper.get("artifact_sha256") != current_paper:
        raise SystemExit("paper artifact changed after final verification")


def main() -> int:
    if sys.flags.optimize != 0:
        raise SystemExit("manifest creation forbids Python -O/PYTHONOPTIMIZE")
    verification = json.loads((HERE / "verification_summary.json").read_text(encoding="utf-8"))
    run_summary = json.loads((HERE / "run_summary.json").read_text(encoding="utf-8"))
    if verification.get("status") != "PASS" or run_summary.get("status") != "PASS":
        raise SystemExit("refusing to seal non-PASS verification evidence")
    if verification.get("paper_seal", {}).get("status") != "PASS":
        raise SystemExit("refusing to seal a deferred or failed paper audit")
    require_current_verification_snapshot(verification)
    caches = [
        path
        for root in (HERE, ENDPOINT, SUCCESSOR, PBT)
        for path in root.rglob("__pycache__")
        if path.is_dir()
    ]
    if caches:
        raise SystemExit(f"remove Python bytecode caches before sealing: {caches}")
    names = expected_manifest_names()
    if not names:
        raise SystemExit("refusing to create an empty manifest")
    rows = [f"{sha256(repo_path(name))}  {name}\n" for name in names]
    temporary = OUTPUT.with_name(OUTPUT.name + ".tmp")
    temporary.write_text("".join(rows), encoding="utf-8", newline="\n")
    os.replace(temporary, OUTPUT)
    print(f"sealed {len(rows)} exact files in {OUTPUT.name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
