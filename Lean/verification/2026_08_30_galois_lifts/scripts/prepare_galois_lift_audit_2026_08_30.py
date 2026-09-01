"""List all written public theorems and separately audit proof-carrying constructions."""

from pathlib import Path
import argparse
import json
import re

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_30_galois_lifts"
MODULES = [
    "IUTFullGaloisWordLift20260830",
    "IUTThreeLabelMinimumLayer20260830",
    "Frey139Tate210Realization20260830",
    "SL2TransvectionGeneration20260830",
    "Frey43BalancedRealization20260830",
    "IUTGeneralTameSquareLabels20260830",
    "TraceDualPreidealHull20260831",
]
CONSTRUCTIONS = {
    "IUTFullGaloisWordLift20260830": ["frameEquiv", "crossHandleAut"],
    "IUTThreeLabelMinimumLayer20260830": ["crossEquiv", "transvectionEquiv"],
    "Frey139Tate210Realization20260830": [
        "firstTriple", "firstCurve_isElliptic", "firstCurve5_isElliptic",
        "directTriple", "directCurve_isElliptic", "directCurve5_isElliptic",
    ],
    "SL2TransvectionGeneration20260830": ["upper", "lower"],
    "Frey43BalancedRealization20260830": [
        "balancedTriple", "balancedCurve_isElliptic", "balancedCurve5_isElliptic",
    ],
}
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("--add-module", action="append", default=[])
args = parser.parse_args()
MODULES.extend(args.add_module)

declarations = {}
constructors = {}
for module in MODULES:
    source = (ROOT / "Lean/IUTThreeClosures" / f"{module}.lean").read_text(encoding="utf-8-sig")
    # The explicit public declarations are distinguished from automatically
    # generated structure lemmas, private auxiliaries, and local instances.
    names = re.findall(r"^\s*(?:theorem|lemma)\s+([A-Za-z0-9_'.]+)", source, re.M)
    prefix = f"IUTThreeClosures.{module}."
    declarations[module] = [prefix + name for name in names]
    constructors[module] = [prefix + name for name in CONSTRUCTIONS.get(module, [])]
    assert len(names) == len(set(names)), module

RECORD.mkdir(parents=True, exist_ok=True)
(RECORD / "declarations.json").write_text(
    json.dumps(declarations, indent=2) + "\n", encoding="utf-8")
(RECORD / "constructions.json").write_text(
    json.dumps(constructors, indent=2) + "\n", encoding="utf-8")
lines = [
    "/-", "Copyright (c) 2026 ChatGPT. All rights reserved.",
    "Released under Apache 2.0 license as described in the file LICENSE.",
    "Authors: ChatGPT", "-/",
]
lines += [f"import IUTThreeClosures.{module}" for module in MODULES]
lines += ["", "/-! Dependency audit for the separately accepted Galois-lift continuation. -/",
          "", "#print IUTThreeClosures.ABCConjecture", ""]
for mapping in [declarations, constructors]:
    for module, names in mapping.items():
        lines += [f"-- {module}", "section", f"open IUTThreeClosures.{module}"]
        for name in names:
            short_name = name.removeprefix(f"IUTThreeClosures.{module}.")
            lines += [f"#check {short_name}", f"#print axioms {short_name}"]
        lines += ["end", ""]
(ROOT / "Lean/IUTThreeClosures/ResearchGaloisLifts20260830Audit.lean").write_text(
    "\n".join(lines), encoding="utf-8")
print(json.dumps({"theorems": {m: len(v) for m, v in declarations.items()},
                  "total_public_theorems": sum(map(len, declarations.values())),
                  "additional_constructions": sum(map(len, constructors.values()))}, indent=2))
