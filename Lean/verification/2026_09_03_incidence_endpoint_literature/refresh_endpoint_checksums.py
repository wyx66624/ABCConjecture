#!/usr/bin/env python3
"""Refresh the endpoint evidence checksum file after the final axiom audit."""

from __future__ import annotations

import hashlib
import os
import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
OUTPUT = (
    REPO
    / "research"
    / "computation"
    / "2026_09_03_signed_endpoint_prime_token_transport"
    / "SHA256SUMS.txt"
)
FILES = [
    "research/ABC_SIGNED_ENDPOINT_PRIME_TOKEN_TRANSPORT_2026_09_03.md",
    "Lean/IUTThreeClosures/ABCSignedEndpointPrimeTokenTransport20260903.lean",
    "Lean/IUTThreeClosures/ABCSignedEndpointPrimeTokenTransport20260903AxiomAudit.lean",
    "research/computation/2026_09_03_signed_endpoint_prime_token_transport/search_endpoint_token_transport.py",
    "research/computation/2026_09_03_signed_endpoint_prime_token_transport/README.md",
    "research/computation/2026_09_03_signed_endpoint_prime_token_transport/OUTPUT.json",
    "research/computation/2026_09_03_signed_endpoint_prime_token_transport/RUN.log",
    "research/computation/2026_09_03_signed_endpoint_prime_token_transport/LEAN_VERIFICATION.txt",
]


def digest(path: Path) -> str:
    value = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1 << 20), b""):
            value.update(block)
    return value.hexdigest()


def main() -> None:
    if sys.flags.optimize != 0:
        raise SystemExit("checksum refresh forbids Python -O/PYTHONOPTIMIZE")
    missing = [name for name in FILES if not (REPO / name).is_file()]
    if missing:
        raise SystemExit(f"missing endpoint evidence: {missing}")
    temporary = OUTPUT.with_name(OUTPUT.name + ".tmp")
    temporary.write_text(
        "".join(f"{digest(REPO / name)}  {name}\n" for name in FILES),
        encoding="utf-8",
        newline="\n",
    )
    os.replace(temporary, OUTPUT)
    print(f"wrote {len(FILES)} entries to {OUTPUT.relative_to(REPO).as_posix()}")


if __name__ == "__main__":
    main()
