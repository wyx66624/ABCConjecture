#!/usr/bin/env python3
"""Verify the frozen SHA-256 manifest and reject missing or extra files."""

import hashlib
from pathlib import Path

HERE = Path(__file__).resolve().parent
MANIFEST = HERE / "SHA256SUMS"
EXCLUDED = {"SHA256SUMS"}


def included(path: Path) -> bool:
    return (
        path.is_file()
        and path.name not in EXCLUDED
        and path.suffix.lower() != ".exe"
        and "__pycache__" not in path.parts
    )


expected = {}
for raw in MANIFEST.read_text(encoding="ascii").splitlines():
    digest, name = raw.split("  ", 1)
    expected[name] = digest

actual_names = {
    path.relative_to(HERE).as_posix()
    for path in HERE.rglob("*")
    if included(path)
}
if actual_names != set(expected):
    raise SystemExit(
        f"manifest membership mismatch: missing={sorted(set(expected)-actual_names)}, "
        f"extra={sorted(actual_names-set(expected))}"
    )

for name, digest in expected.items():
    actual = hashlib.sha256((HERE / name).read_bytes()).hexdigest()
    if actual != digest:
        raise SystemExit(f"hash mismatch: {name}: expected {digest}, got {actual}")

print(f"manifest_files={len(expected)}")
print("verification=PASS")
