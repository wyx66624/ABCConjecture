from __future__ import annotations

import hashlib
from pathlib import Path


ROOT = Path(__file__).resolve().parent
REPORT = ROOT.parents[1] / "ABC_DIRECT_BOUNDED_COUNTERSEARCH_2026_09_04.md"


def digest(path: Path) -> str:
    result = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1 << 20), b""):
            result.update(block)
    return result.hexdigest()


def main() -> None:
    files = sorted(
        path for path in ROOT.iterdir() if path.is_file() and path.name != "SHA256SUMS.txt"
    )
    files.append(REPORT)
    lines = []
    for path in files:
        label = path.relative_to(ROOT).as_posix() if path.parent == ROOT else "../../" + path.name
        lines.append(f"{digest(path)}  {label}")
    (ROOT / "SHA256SUMS.txt").write_text("\n".join(lines) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
