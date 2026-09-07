#!/usr/bin/env python3
"""Bind the reviewed fourteenth-round delivery; exclude all next-only notes."""
from pathlib import Path
import argparse
import hashlib
import json

HERE = Path(__file__).resolve().parent
FILES = [
    "README.md",
    "review.md",
    "adaptive_precision.md",
    "two_owner_concentration.md",
    "private_density_gain.md",
    "ordinary_formal_scope.md",
    "Lean/AdaptiveOwnerArithmetic.lean",
    "paper/adaptive_precision.tex",
    "paper/private_density_gain.tex",
    "verify_owner.py",
    "verification/owner_validation.json",
    "verification/owner-lean.log",
    "seal_sources.py",
]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--write", action="store_true")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    assert args.write != args.check, "Choose exactly one of --write and --check"
    manifest = json.loads((HERE / "verification/owner_validation.json").read_bytes())
    assert manifest["status"].startswith("PASS:")
    assert manifest["new_declarations"] == 12
    assert manifest["dependency_declarations"] == 15
    data = {name: (HERE / name).read_bytes() for name in FILES}
    source_hash = hashlib.sha256(data["Lean/AdaptiveOwnerArithmetic.lean"]).hexdigest()
    assert source_hash == manifest["modules"]["AdaptiveOwnerArithmetic"]["sha256"]
    for name, value in data.items():
        if name.endswith(".tex"):
            assert not any(byte < 32 and byte not in (9, 10, 13) for byte in value), name
    record = {
        "scope": "Reviewed AP/OC/DG ordinary papers and twelve finite declarations; no next-only candidate included.",
        "source_files": [
            {"path": name, "bytes": len(data[name]),
             "sha256": hashlib.sha256(data[name]).hexdigest()}
            for name in FILES
        ],
        "new_declarations": 12,
        "old_local_dependencies_freshly_compiled": 15,
        "excluded": ["next_* candidates", "rendered PDF visual QA", "complete ABC proof"],
    }
    target = HERE / "source_evidence.json"
    payload = (json.dumps(record, indent=2) + "\n").encode("utf-8")
    if args.write:
        target.write_bytes(payload)
    else:
        assert target.read_bytes() == payload, "Delivery source bytes differ from the recorded seal"
    print(json.dumps({"status": "PASS", "files": len(FILES),
                      "mode": "write" if args.write else "check",
                      "source_evidence_sha256": hashlib.sha256(payload).hexdigest()}))


if __name__ == "__main__":
    main()
