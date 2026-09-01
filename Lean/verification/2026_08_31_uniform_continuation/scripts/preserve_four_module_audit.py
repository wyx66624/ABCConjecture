"""Preserve the already checked 79-declaration intermediate audit exactly once."""
from pathlib import Path
import hashlib
import json
import shutil

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
OUT = RECORD / "interim_four_modules"
assert not OUT.exists(), "The intermediate audit has already been preserved"
OUT.mkdir()
names = ["declarations.json", "audit-run.json", "audit-output.txt", "axiom-summary.json",
         "axiom-dependencies.json", "build-run.json", "build-output.txt",
         "proof-and-history-verification.json"]
files = {name: RECORD / name for name in names}
files["ResearchUniformContinuation20260831Audit.lean"] = (
    ROOT / "Lean/IUTThreeClosures/ResearchUniformContinuation20260831Audit.lean")
files["IUTThreeClosures.lean"] = ROOT / "Lean/IUTThreeClosures.lean"
records = []
for name, source in files.items():
    target = OUT / name
    shutil.copyfile(source, target)
    assert target.read_bytes() == source.read_bytes()
    records.append({"original_path": source.relative_to(ROOT).as_posix(),
                    "preserved_path": target.relative_to(ROOT).as_posix(),
                    "sha256": hashlib.sha256(target.read_bytes()).hexdigest()})
(OUT / "snapshot.json").write_text(json.dumps({"public_theorems": 70,
    "additional_proof_bearing_declarations": 9, "audited_declarations": 79,
    "status": "intermediate proof audit only; no independent PDF acceptance", "files": records},
    ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(json.dumps({"copied_files": len(records), "directory": OUT.as_posix()}, ensure_ascii=False))
