#!/usr/bin/env python3
"""Replay the finite quadratic-peeling audit and verify frozen hashes."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path

from quadratic_veronese_peeling_scan import build_results


ROOT = Path(__file__).resolve().parent


def verify_hashes() -> list[dict[str, object]]:
    rows: list[dict[str, object]] = []
    for line in (ROOT / "SHA256SUMS").read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        expected, name = line.split("  ", 1)
        actual = hashlib.sha256((ROOT / name).read_bytes()).hexdigest()
        rows.append({"file": name, "pass": actual == expected})
    return rows


def main() -> None:
    frozen = json.loads((ROOT / "scan_results.json").read_text(encoding="utf-8"))
    replay = build_results(int(frozen["limit"]), int(frozen["power_k_max"]))
    hashes = verify_hashes()
    checks = {
        "schema": frozen.get("schema") == "quadratic-veronese-peeling-audit-v1",
        "frozen_all_checks": frozen.get("all_checks") is True,
        "exact_replay": replay == frozen,
        "hashes": all(bool(row["pass"]) for row in hashes),
        "status_boundary":
            frozen["interpretation"]["arbitrary_multi_move_gate_VF"] == "open",
        "status_abc": frozen["interpretation"]["abc_conjecture"] == "open",
    }
    result = {"all_checks": all(checks.values()), "checks": checks, "hashes": hashes}
    print(json.dumps(result, indent=2, sort_keys=True))
    if not result["all_checks"]:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
