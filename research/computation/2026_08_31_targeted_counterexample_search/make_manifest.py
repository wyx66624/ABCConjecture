#!/usr/bin/env python3
from __future__ import annotations

import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
EXCLUDE = {"manifest.json"}

files = []
for path in sorted(HERE.rglob("*")):
    if not path.is_file() or path.name in EXCLUDE or "__pycache__" in path.parts:
        continue
    data = path.read_bytes()
    files.append({
        "path": path.relative_to(HERE).as_posix(),
        "bytes": len(data),
        "sha256": hashlib.sha256(data).hexdigest(),
    })

(HERE / "manifest.json").write_text(
    json.dumps({"files": files}, indent=2, sort_keys=True) + "\n",
    encoding="utf-8",
)
print(f"hashed {len(files)} files")
