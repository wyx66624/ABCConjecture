from __future__ import annotations

import hashlib
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parent
META = json.loads((ROOT / "source-metadata.json").read_text(encoding="utf-8"))


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1 << 20), b""):
            h.update(block)
    return h.hexdigest()


def main() -> None:
    checked: list[dict[str, object]] = []
    for name, expected in META["files"].items():
        path = ROOT / name
        actual = sha256(path)
        if actual != expected["sha256"]:
            raise SystemExit(f"SHA-256 mismatch for {name}: {actual}")
        if "bytes" in expected and path.stat().st_size != expected["bytes"]:
            raise SystemExit(f"byte-size mismatch for {name}")
        checked.append({"file": name, "sha256": actual, "bytes": path.stat().st_size})

    raw = (ROOT / "Mueller_Taktikos_2601.11376v2.txt").read_text(encoding="utf-8")
    normalized = (ROOT / "Mueller_Taktikos_2601.11376v2.normalized.txt").read_text(
        encoding="utf-8"
    )
    if raw.count("\x00") != 1 or raw.replace("\x00", "") != normalized:
        raise SystemExit("normalized extraction is not exactly the one-NUL removal")

    required = [
        "Definition 2.6",
        "Theorem 2.7",
        "The approximation gain is always smaller or equal to the quality",
        "bounding approximation gain and power gain separately",
    ]
    for phrase in required:
        if phrase not in normalized:
            raise SystemExit(f"missing source anchor: {phrase}")

    print(json.dumps({"status": "PASS", "files": checked, "anchors": required}, indent=2))


if __name__ == "__main__":
    main()

