"""Freeze this new stage once, after all proof and visual checks pass.

Refuses to replace an existing manifest and never writes an older record.
Routine later integrity checks must use ../verify_manifest.py instead.
"""
from pathlib import Path
import importlib.util

HERE = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("acceptance_verifier", HERE / "verify_manifest.py")
verifier = importlib.util.module_from_spec(spec)
spec.loader.exec_module(verifier)
if verifier.MANIFEST.exists():
    raise SystemExit("This acceptance is already frozen; use the read-only verifier")
history = verifier.history_checks()
if any(item["failures"] for item in history):
    raise SystemExit(f"Frozen history verification failed: {history}")
failures = verifier.metadata_checks()
if failures:
    raise SystemExit(f"Final proof or visual metadata is incomplete: {failures}")
files = verifier.scoped_files()
if not all(path.is_file() for path in files):
    raise SystemExit("A scoped file is missing")
values = [(verifier.digest(path), path.relative_to(verifier.ROOT).as_posix()) for path in files]
scope_failures = verifier.verify(values)
if scope_failures:
    raise SystemExit(f"Current paths or bytes are invalid before freezing: {scope_failures}")
contents = "".join(f"{sha}  {name}\n" for sha, name in values)
with verifier.MANIFEST.open("x", encoding="utf-8") as stream:
    stream.write(contents)
verifier.main()
