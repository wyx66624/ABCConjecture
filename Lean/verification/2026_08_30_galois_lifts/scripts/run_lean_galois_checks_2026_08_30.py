"""Run a Lean check, retain its complete output, and print a compact result."""

from pathlib import Path
import argparse
import json
import re
import subprocess

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_30_galois_lifts"
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("mode", choices=["build", "audit", "previous-uniform", "previous-continuation"])
args = parser.parse_args()
jobs = {
    "build": (["lake", "build"], "build-output.txt"),
    "audit": (["lake", "env", "lean", "IUTThreeClosures/ResearchGaloisLifts20260830Audit.lean"], "axioms.txt"),
    "previous-uniform": (["lake", "env", "lean", "IUTThreeClosures/ResearchUniformGate20260830Audit.lean"], "previous-uniform-axioms.txt"),
    "previous-continuation": (["lake", "env", "lean", "IUTThreeClosures/ResearchContinuation20260830Audit.lean"], "previous-continuation-axioms.txt"),
}
command, name = jobs[args.mode]
result = subprocess.run(command, cwd=ROOT / "Lean", capture_output=True,
                        text=True, encoding="utf-8", errors="replace")
output = result.stdout + result.stderr
RECORD.mkdir(parents=True, exist_ok=True)
(RECORD / name).write_text(output, encoding="utf-8")
metadata = {"mode": args.mode, "command": command, "exit_code": result.returncode,
            "output_file": (RECORD / name).relative_to(ROOT).as_posix(),
            "warnings": len(re.findall(r"^warning:", output, re.M)),
            "dependency_reports": len(re.findall(r"depends on axioms:", output)),
            "completion": re.findall(r"Build completed successfully \(\d+ jobs\)\.", output),
            "tail": output.splitlines()[-8:] if result.returncode else []}
(RECORD / f"{args.mode}-run.json").write_text(
    json.dumps(metadata, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
print(json.dumps(metadata, ensure_ascii=False))
raise SystemExit(result.returncode)
