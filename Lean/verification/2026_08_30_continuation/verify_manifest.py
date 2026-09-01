"""Verify this working-tree snapshot; use --write only to record a new snapshot."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
MANIFEST = HERE / "SHA256SUMS"


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def snapshot_files() -> list[Path]:
    fixed = [
        "README.md",
        "Lean/RESEARCH_STATUS.md",
        "Lean/RESEARCH_ROUTE_REGISTRY.md",
        "Lean/lean-toolchain",
        "Lean/lakefile.toml",
        "Lean/lake-manifest.json",
        "research/ABC_MULTI_ROUTE_V17_SIGNED_PRIME_EXPONENT_LAYER.md",
        "paper/ChatGPT_ABC_Uniformity_2026.tex",
        "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf",
    ]
    files = {ROOT / name for name in fixed}
    files.update((ROOT / "Lean").glob("*.lean"))
    files.update((ROOT / "Lean/IUTThreeClosures").rglob("*.lean"))
    files.update((ROOT / "research").glob("*2026_08_30.md"))
    files.update(p for p in (ROOT / "research/sources").rglob("*") if p.is_file())
    files.update((ROOT / "paper").glob("continuation_*.tex"))
    files.update(
        p for p in (ROOT / "Lean/verification/2026_08_30").rglob("*") if p.is_file()
    )
    files.update(p for p in HERE.iterdir() if p.is_file() and p != MANIFEST)
    return sorted(files, key=lambda p: p.relative_to(ROOT).as_posix())


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true")
    args = parser.parse_args()
    if args.write:
        lines = [f"{digest(p)}  {p.relative_to(ROOT).as_posix()}" for p in snapshot_files()]
        MANIFEST.write_text("\n".join(lines) + "\n", encoding="utf-8")

    checked = 0
    seen: set[str] = set()
    failures: list[str] = []
    for line in MANIFEST.read_text(encoding="utf-8-sig").splitlines():
        if not line:
            continue
        expected, name = line.split("  ", 1)
        path = (ROOT / name).resolve()
        if not path.is_relative_to(ROOT.resolve()):
            failures.append(f"Path leaves the repository: {name}")
            continue
        if name in seen:
            failures.append(f"Duplicate manifest entry: {name}")
        seen.add(name)
        if not path.is_file():
            failures.append(f"Missing file: {name}")
        elif digest(path) != expected:
            failures.append(f"Hash mismatch: {name}")
        checked += 1

    summary = json.loads((HERE / "validation_summary.json").read_text(encoding="utf-8-sig"))
    pdf = ROOT / "output/pdf/ChatGPT_ABC_Uniformity_2026.pdf"
    if digest(pdf) != summary["pdf_sha256"]:
        failures.append("PDF differs from the visually inspected artifact")
    if summary.get("inspected_pages") != list(range(1, summary["pdf_pages"] + 1)):
        failures.append("PDF visual inspection is incomplete")
    if summary.get("unexpected_axioms") or summary.get("audit_has_sorryAx"):
        failures.append("The recorded declaration audit has an unexpected dependency")

    print(json.dumps({"checked_files": checked, "failures": failures}, ensure_ascii=False))
    if failures:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
