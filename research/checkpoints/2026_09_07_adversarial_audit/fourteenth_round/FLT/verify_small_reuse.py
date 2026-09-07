#!/usr/bin/env python3
"""Compile a two-file official FLT subproof in an isolated Lean 4.32 directory.

Run inside WSL. The existing ABC project and its dependency cache are read-only.
This script does not import FinalCheck, fetch a Mathlib cache, or build full FLT.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import tempfile
import urllib.request

PIN = "aa2d8b34692b16c70f699536de0d8e75b9a3e9ef"
MATHLIB = "81a5d257c8e410db227a6665ed08f64fea08e997"
TOOLCHAIN = "leanprover/lean4:v4.32.0"
SOURCES = {
    "P2M/Util.lean":
        "66f62069b83c0cf97531f88e5bd2c249e471df011ad873b0bd034eb959b1d8da",
    "P2M/Sol/S_ModularForm_S2_Gamma0_2_eq_zero.lean":
        "e9c16a42e589727cf2902879750087479c936629236ba07a943047bccd276d63",
}
IMPORTS = [
    "NumberTheory/ModularForms/NormTrace",
    "NumberTheory/ModularForms/DimensionFormulas/LevelOne",
    "NumberTheory/ModularForms/CongruenceSubgroups",
    "NumberTheory/ModularForms/ArithmeticSubgroups",
    "GroupTheory/Index", "Data/ZMod/Basic", "Tactic/FinCases",
]
BRIDGE = """import P2M.Sol.S_ModularForm_S2_Gamma0_2_eq_zero

/-- An actual import of the pinned official subproof with Mathlib's types. -/
theorem abc_s2_gamma0_two_zero
    (f : CuspForm (CongruenceSubgroup.Gamma0 2) 2) : f = 0 :=
  P2MW.S_ModularForm_S2_Gamma0_2_eq_zero.solution f

#print axioms P2MW.S_ModularForm_S2_Gamma0_2_eq_zero.solution
#print axioms abc_s2_gamma0_two_zero
#check abc_s2_gamma0_two_zero
"""


def digest(data):
    return hashlib.sha256(data).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--abc-cache", type=Path, default=Path("/root/abc-lean-build"))
    parser.add_argument("--work-root", type=Path, default=Path("/root/abc-flt-small-432"))
    parser.add_argument("--elan", default="/root/.elan/bin/elan")
    parser.add_argument("--source-dir", type=Path,
                        help="Optional already downloaded pinned sources; hashes still checked")
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    cache = args.abc_cache.resolve()
    work_root = args.work_root.resolve()
    if work_root == cache or cache in work_root.parents:
        raise ValueError("The isolated work root must not be inside the existing ABC build")
    ml = cache / ".lake/packages/mathlib"
    rev = subprocess.check_output(["git", "-C", str(ml), "rev-parse", "HEAD"], text=True).strip()
    if rev != MATHLIB:
        raise ValueError(f"Mathlib pin mismatch: {rev}")
    for rel in IMPORTS:
        if not (ml / ".lake/build/lib/lean/Mathlib" / (rel + ".olean")).is_file():
            raise FileNotFoundError(rel)
    compiler = subprocess.check_output(
        [args.elan, "run", TOOLCHAIN, "lean", "--version"], text=True).strip()
    work_root.mkdir(parents=True, exist_ok=True)
    work = Path(tempfile.mkdtemp(prefix="fresh-reuse-", dir=work_root))
    source_rows = []
    for rel, expected in SOURCES.items():
        url = f"https://raw.githubusercontent.com/anthropics/fermats-last-theorem/{PIN}/{rel}"
        if args.source_dir:
            data = (args.source_dir / rel).read_bytes()
        else:
            with urllib.request.urlopen(url, timeout=60) as response:
                data = response.read()
        if digest(data) != expected:
            raise ValueError(f"Source hash mismatch: {rel}")
        p = work / rel
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_bytes(data)
        source_rows.append({"path": rel, "sha256": expected, "url": url})
    (work / "S2Bridge.lean").write_bytes(BRIDGE.encode())
    env = os.environ.copy()
    env["LEAN_NUM_THREADS"] = "2"
    env["LEAN_PATH"] = ":".join([str(work)] + sorted(
        str(p) for p in (cache / ".lake/packages").glob("*/.lake/build/lib/lean")))
    runs = []
    for rel in [*SOURCES, "S2Bridge.lean"]:
        cmd = [args.elan, "run", TOOLCHAIN, "lean", "-o", rel[:-5] + ".olean", rel]
        result = subprocess.run(cmd, cwd=work, env=env, capture_output=True, text=True, timeout=180)
        content = result.stdout + result.stderr
        log = work / (Path(rel).stem + ".log")
        log.write_bytes(content.encode())
        runs.append({"source": rel, "command": cmd, "exit_code": result.returncode,
                     "log": str(log), "log_sha256": digest(log.read_bytes()),
                     "output": content})
        if result.returncode != 0 or "sorryAx" in content:
            raise RuntimeError(f"Compile failed: {rel}\n{content}")
    expected_names = ["P2MW.S_ModularForm_S2_Gamma0_2_eq_zero.solution",
                      "abc_s2_gamma0_two_zero"]
    for name in expected_names:
        line = f"'{name}' depends on axioms: [propext, Classical.choice, Quot.sound]"
        if line not in runs[-1]["output"]:
            raise RuntimeError(f"Missing exact axiom audit: {name}")
    report = {"status": "PASS", "compiler": compiler, "mathlib_commit": rev,
              "upstream_commit": PIN, "work_dir": str(work), "sources": source_rows,
              "bridge_sha256": digest((work / "S2Bridge.lean").read_bytes()),
              "runs": runs, "axiom_union": ["propext", "Classical.choice", "Quot.sound"],
              "official_source_modified": False, "full_FLT_import_verified": False,
              "old_ABC_environment_modified": False,
              "scope": "Two official sources freshly compiled; pinned existing Mathlib oleans reused"}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes((json.dumps(report, ensure_ascii=False, indent=2) + "\n").encode())
    print(json.dumps({"status": "PASS", "output": str(args.output),
                      "sha256": digest(args.output.read_bytes())}))


if __name__ == "__main__":
    main()
