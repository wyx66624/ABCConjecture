"""Bind the fixed eighteenth-round delivery list; exclude next-only notes."""

from argparse import ArgumentParser
from hashlib import sha256
import json
from pathlib import Path


BASE = Path(__file__).resolve().parent
DEST = BASE / "source_evidence.json"
FILES = (
    "README.md",
    "affine_owner_selectors.md",
    "paper/affine_owner_selectors.tex",
    "replay_affine_selectors.py",
    "verification/affine_selector_exact.json",
    "collective_lean_and_partition_review.md",
    "height_transport_review.md",
    "local_height_review.md",
    "peer_seventeenth_transcription_review.md",
    "peer_eighteenth_transcription_review.md",
    "verify_source_evidence.py",
)


def main():
    parser = ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    rows = []
    for name in FILES:
        raw = (BASE / name).read_bytes()
        rows.append(dict(path=name, bytes=len(raw), sha256=sha256(raw).hexdigest()))
        if name.endswith(".tex"):
            assert not any(c < 32 and c not in (9, 10, 13) for c in raw)
    data = dict(
        scope="fixed own eighteenth-round delivery; next-only research excluded",
        files=rows,
        execution="source integrity only; does not rerun mathematics or a compiler",
    )
    raw = (json.dumps(data, indent=2, sort_keys=True) + "\n").encode()
    if args.check:
        assert DEST.read_bytes() == raw, "source evidence does not match current bytes"
    else:
        DEST.write_bytes(raw)
    print("PASS", len(rows), "files", sha256(raw).hexdigest())


if __name__ == "__main__":
    main()
