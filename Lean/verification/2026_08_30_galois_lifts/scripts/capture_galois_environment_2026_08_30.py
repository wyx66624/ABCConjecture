"""Verify protected core/pins and capture the actual compiler/package state."""
from pathlib import Path
import hashlib
import json
import re
import subprocess

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_30_galois_lifts"
OLD = ROOT / "Lean/verification/2026_08_30_uniform_gate"
previous = json.loads((OLD / "environment.json").read_text(encoding="utf-8"))
def command(args, cwd=ROOT):
    result = subprocess.run(args, cwd=cwd, capture_output=True, text=True,
                            encoding="utf-8", errors="replace", check=True)
    return result.stdout.strip()
protected = {}
for path, expected in previous["protected_file_sha256"].items():
    protected[path] = hashlib.sha256((ROOT/path).read_bytes()).hexdigest()
    assert protected[path] == expected, f"Protected file changed: {path}"
packages = {p: command(["git", "rev-parse", "HEAD"], ROOT/"Lean/.lake/packages"/p)
            for p in previous["packages"]}
assert packages == previous["packages"], "Pinned dependency revision changed"
package_tracked_changes = {
    p: command(["git", "status", "--porcelain", "--untracked-files=no"],
               ROOT/"Lean/.lake/packages"/p) for p in packages}
assert not any(package_tracked_changes.values()), "Tracked package sources changed"
environment = {
    "repository_head": command(["git", "rev-parse", "HEAD"]),
    "lean": command(["lake", "env", "lean", "--version"], ROOT/"Lean"),
    "lake": command(["lake", "--version"], ROOT/"Lean"),
    "packages": packages, "protected_file_sha256": protected,
    "package_tracked_changes": package_tracked_changes,
    "protected_files_match_previous": True, "packages_match_previous": True,
    "commands": {},
}
for mode in ["build", "audit", "previous-uniform", "previous-continuation"]:
    run = json.loads((RECORD/f"{mode}-run.json").read_text(encoding="utf-8"))
    assert run["exit_code"] == 0, mode
    environment["commands"][mode] = {"command": run["command"], "exit_code": run["exit_code"]}
legacy = {}
for key, count in [("previous-uniform", 89), ("previous-continuation", 43)]:
    log = (RECORD/f"{key}-axioms.txt").read_text(encoding="utf-8")
    deps = re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", log, re.S)
    zero = re.findall(r"'([^']+)' does not depend on any axioms", log)
    assert len(deps)+len(zero) == count, (key, len(deps), len(zero))
    assert "error:" not in log and "sorryAx" not in log
    for name, contents in deps:
        assert {x.strip() for x in contents.split(",") if x.strip()} <= {
            "propext", "Classical.choice", "Quot.sound"}, name
    legacy[key] = {"declarations": count, "standard_axioms_only": True, "exit_code": 0}
(RECORD/"environment.json").write_text(
    json.dumps(environment, ensure_ascii=False, indent=2)+"\n", encoding="utf-8")
(RECORD/"previous-audit-summary.json").write_text(
    json.dumps(legacy, indent=2)+"\n", encoding="utf-8")
print(json.dumps({"protected_files_unchanged": len(protected), "pinned_packages_unchanged": len(packages),
                  "repository_head": environment["repository_head"], "previous_audits": legacy}))
