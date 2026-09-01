"""Prepare the explicitly scoped continuation dependency audit (writes files)."""
from pathlib import Path
import hashlib
import json
import re

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
MODULES = {
    "ABCTwoPrimeSupport20260831": [],
    "TraceCovariantRationalReturn20260831": [],
    "ABCOddPartFibre20260831": ["parityMap", "fibreFinite", "exampleP", "exampleQ"],
    "FreyEntireIsogenyArithmetic20260831": [
        "prime3", "prime7", "familyTriple", "residueCurve_isElliptic", "familyCurve_isElliptic"
    ],
    "FreyIsogenyWeilHeight20260831": [],
}

lines = [
    "/-",
    "Copyright (c) 2026 ChatGPT. All rights reserved.",
    "Released under Apache 2.0 license as described in the file LICENSE.",
    "Authors: ChatGPT",
    "-/",
]
lines.extend(f"import IUTThreeClosures.{module}" for module in MODULES)
lines.extend([
    "", "/-! Types and kernel dependency reports for this separately scoped continuation.",
    "This file supplies no proof of ABCConjecture or its negation. -/", "",
    "#print IUTThreeClosures.ABCConjecture", "",
])
record = {}
for module, extra in MODULES.items():
    source = ROOT / f"Lean/IUTThreeClosures/{module}.lean"
    data = source.read_bytes()
    text = data.decode("utf-8-sig")
    declarations = re.findall(r"^(?:theorem|lemma)\s+(\w+)", text, re.M)
    assert declarations and len(set(declarations)) == len(declarations)
    for name in extra:
        assert re.search(rf"^(?:local )?(?:instance|def)\s+{re.escape(name)}\b", text, re.M), name
    record[module] = {
        "source": source.relative_to(ROOT).as_posix(),
        "source_sha256": hashlib.sha256(data).hexdigest(),
        "source_bytes": len(data),
        "public_theorems": declarations,
        "additional_proof_bearing_declarations": extra,
    }
    lines.extend([f"-- {module}", "section", f"open IUTThreeClosures.{module}"])
    for name in declarations:
        lines.extend([f"#check {name}", f"#print axioms {name}"])
    if extra:
        lines.extend(["", "-- Actual proof-bearing definitions and instances, including the two local prime Facts."])
        for name in extra:
            lines.extend([f"#check {name}", f"#print axioms {name}"])
    lines.extend(["end", ""])

target = ROOT / "Lean/IUTThreeClosures/ResearchUniformContinuation20260831Audit.lean"
target.write_text("\n".join(lines), encoding="utf-8")
(RECORD / "declarations.json").write_text(
    json.dumps(record, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(json.dumps({
    "modules": len(record),
    "public_theorems": sum(len(v["public_theorems"]) for v in record.values()),
    "additional_proof_bearing_declarations": sum(
        len(v["additional_proof_bearing_declarations"]) for v in record.values()),
    "audit_source": target.relative_to(ROOT).as_posix(),
}, ensure_ascii=False))
