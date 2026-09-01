"""Run and retain one explicitly selected continuation Lean check."""
from pathlib import Path
import argparse
import hashlib
import json
import re
import subprocess

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
JOBS = {
    "trace": ["lake", "build", "IUTThreeClosures.TraceCovariantRationalReturn20260831"],
    "fibre": ["lake", "build", "IUTThreeClosures.ABCOddPartFibre20260831"],
    "analytic": ["lake", "build", "IUTThreeClosures.ABCTwoPrimeSupport20260831"],
    "geometry": ["lake", "build", "IUTThreeClosures.FreyEntireIsogenyArithmetic20260831"],
    "height": ["lake", "build", "IUTThreeClosures.FreyIsogenyWeilHeight20260831"],
    "build": ["lake", "build"],
    "audit": ["lake", "env", "lean", "IUTThreeClosures/ResearchUniformContinuation20260831Audit.lean"],
    "previous-galois": ["lake", "env", "lean", "IUTThreeClosures/ResearchGaloisLifts20260830Audit.lean"],
    "previous-uniform": ["lake", "env", "lean", "IUTThreeClosures/ResearchUniformGate20260830Audit.lean"],
    "previous-continuation": ["lake", "env", "lean", "IUTThreeClosures/ResearchContinuation20260830Audit.lean"],
}
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("mode", choices=JOBS)
args = parser.parse_args()
command = JOBS[args.mode]
tracked_inputs = [ROOT / "Lean/IUTThreeClosures.lean",
                  ROOT / "Lean/IUTThreeClosures/ResearchUniformContinuation20260831Audit.lean",
                  RECORD / "declarations.json"]
scope = json.loads((RECORD / "declarations.json").read_text(encoding="utf-8"))
tracked_inputs.extend(ROOT / data["source"] for data in scope.values())
input_hashes = {path.relative_to(ROOT).as_posix(): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in tracked_inputs}
result = subprocess.run(command, cwd=ROOT/"Lean", capture_output=True, text=True,
                        encoding="utf-8", errors="replace")
changed_inputs = [name for name, expected in input_hashes.items()
                  if hashlib.sha256((ROOT/name).read_bytes()).hexdigest() != expected]
output = result.stdout + result.stderr
name = f"{args.mode}-output.txt"
(RECORD/name).write_text(output, encoding="utf-8")
metadata = {"mode": args.mode, "command": command, "exit_code": result.returncode,
            "input_sha256": input_hashes, "inputs_changed_during_run": changed_inputs,
            "output_file": (RECORD/name).relative_to(ROOT).as_posix(),
            "warnings": len(re.findall(r"^warning:", output, re.M)),
            "completion": re.findall(r"Build completed successfully \(\d+ jobs\)\.", output),
            "dependency_reports": len(re.findall(r"depends on axioms:|does not depend on any axioms", output)),
            "tail": output.splitlines()[-12:] if result.returncode else []}
(RECORD/f"{args.mode}-run.json").write_text(
    json.dumps(metadata, ensure_ascii=False, indent=2)+"\n", encoding="utf-8")
print(json.dumps(metadata, ensure_ascii=False))
raise SystemExit(result.returncode or (1 if changed_inputs else 0))
