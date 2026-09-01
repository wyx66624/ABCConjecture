"""Record and verify the unchanged target, toolchain and pinned package checkouts."""
from pathlib import Path
import hashlib
import json
import subprocess

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
BASE = ROOT / "Lean/verification/2026_08_30_galois_lifts/environment.json"
previous = json.loads(BASE.read_text(encoding="utf-8"))

def run(command, cwd):
    result = subprocess.run(command, cwd=cwd, capture_output=True, text=True,
                            encoding="utf-8", errors="replace")
    assert result.returncode == 0, (command, result.stderr)
    return result.stdout.strip()

protected = {name: hashlib.sha256((ROOT / name).read_bytes()).hexdigest()
             for name in previous["protected_file_sha256"]}
packages = {name: run(["git", "rev-parse", "HEAD"], ROOT / "Lean/.lake/packages" / name)
            for name in previous["packages"]}
changes = {name: run(["git", "status", "--porcelain", "--untracked-files=no"],
                     ROOT / "Lean/.lake/packages" / name)
           for name in previous["packages"]}
record = {
    "repository_head": run(["git", "rev-parse", "HEAD"], ROOT),
    "lean": run(["lake", "env", "lean", "--version"], ROOT / "Lean"),
    "lake": run(["lake", "--version"], ROOT / "Lean"),
    "packages": packages, "package_tracked_changes": changes,
    "protected_file_sha256": protected,
    "protected_files_match_previous": protected == previous["protected_file_sha256"],
    "packages_match_previous": packages == previous["packages"],
    "package_tracked_worktrees_clean": all(not value for value in changes.values()),
    "toolchain_matches_previous": False,
}
record["toolchain_matches_previous"] = (
    record["lean"] == previous["lean"] and record["lake"] == previous["lake"])
record["all_passed"] = all(record[key] for key in [
    "protected_files_match_previous", "packages_match_previous",
    "package_tracked_worktrees_clean", "toolchain_matches_previous",
])
(RECORD / "environment.json").write_text(
    json.dumps(record, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(json.dumps(record, ensure_ascii=False))
assert record["all_passed"], "The protected target or dependency environment changed"
