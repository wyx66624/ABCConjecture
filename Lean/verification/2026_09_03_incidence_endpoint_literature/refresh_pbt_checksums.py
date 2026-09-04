#!/usr/bin/env python3
"""Atomically refresh the exact PBT computation checksum inventory."""

from __future__ import annotations

import os
import sys

sys.dont_write_bytecode = True

from checkpoint_scope import PBT, REPO, repo_path, sha256


OUTPUT = PBT / "SHA256SUMS.txt"
FILES = (
    "research/ABC_PRIME_PACKET_BOUNDARY_COMPUTATION_2026_09_03.md",
    "research/ABC_PRIME_PACKET_BOUNDARY_THEORETICAL_AUDIT_2026_09_03.md",
    "research/computation/2026_09_03_prime_packet_boundary_transport/OUTPUT.json",
    "research/computation/2026_09_03_prime_packet_boundary_transport/README.md",
    "research/computation/2026_09_03_prime_packet_boundary_transport/RUN.log",
    "research/computation/2026_09_03_prime_packet_boundary_transport/"
    "search_prime_packet_boundary.py",
    "research/computation/2026_09_03_prime_packet_boundary_transport/"
    "STRUCTURED_FAMILIES.csv",
    "research/computation/2026_09_03_prime_packet_boundary_transport/"
    "validate_prime_packet_boundary.py",
    "research/computation/2026_09_03_prime_packet_boundary_transport/VALIDATION.log",
)


def main() -> int:
    if sys.flags.optimize != 0:
        raise SystemExit("checksum refresh forbids Python -O/PYTHONOPTIMIZE")
    if len(FILES) != 9 or len(FILES) != len(set(FILES)):
        raise SystemExit("unexpected PBT checksum inventory")
    rows = [f"{sha256(repo_path(name))}  {name}\n" for name in FILES]
    temporary = OUTPUT.with_name(OUTPUT.name + ".tmp")
    temporary.write_text("".join(rows), encoding="utf-8", newline="\n")
    os.replace(temporary, OUTPUT)
    print(f"wrote {len(rows)} entries to {OUTPUT.relative_to(REPO).as_posix()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
