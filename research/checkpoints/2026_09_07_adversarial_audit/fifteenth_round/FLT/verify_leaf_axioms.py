#!/usr/bin/env python3
"""Audit six actually compiled leaf solutions, without building further modules.

Run under WSL with the unchanged, completed lean-only leaf probe available.
The old Mathlib cache is read only. This is not a full-FLT verification script.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import signal
import subprocess
import time


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--probe", type=Path, required=True)
    parser.add_argument("--work", type=Path,
                        default=Path("/root/abc-flt-leaf-probe-432-rss"))
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    previous = json.loads(args.probe.read_text())
    if previous["status"] != "PASS: bounded leaf source compatibility only":
        raise ValueError("The prerequisite leaf probe has not completed")
    work = args.work.resolve()
    cache = Path("/root/abc-lean-build/.lake/packages")
    current_mathlib = subprocess.check_output(
        ["git", "-C", str(cache / "mathlib"), "rev-parse", "HEAD"], text=True).strip()
    if current_mathlib != previous["mathlib_commit"]:
        raise ValueError("Mathlib pin changed")
    for row in previous["runs"]:
        path = work / (row["module"].replace(".", "/") + ".lean")
        if digest(path) != row["source_sha256"] or not path.with_suffix(".olean").is_file():
            raise ValueError("Prerequisite source or compiled artifact changed: " + str(path))
    modules = [m for m in previous["selected_modules"] if m.startswith("P2M.Sol.")]
    names = ["P2MW." + m.split(".")[-1] + ".solution" for m in modules]
    bridge = ("\n".join("import " + m for m in modules) + "\n\n"
              + "\n".join("#print axioms " + n for n in names) + "\n")
    args.output.parent.mkdir(parents=True, exist_ok=True)
    source = args.output.parent / "LeafAxiomBridge.lean"
    source.write_text(bridge)
    run_dir = work / "axiom-audit"
    run_dir.mkdir(exist_ok=True)
    local_source = run_dir / "LeafAxiomBridge.lean"
    local_source.write_text(bridge)
    lean = subprocess.check_output(
        ["/root/.elan/bin/elan", "which", "lean"], text=True,
        env={**os.environ, "ELAN_TOOLCHAIN": "leanprover/lean4:v4.32.0"}).strip()
    version = subprocess.check_output([lean, "--version"], text=True).strip()
    if version != previous["compiler"]:
        raise ValueError("Lean compiler changed")
    env = {**os.environ, "LEAN_NUM_THREADS": "2",
           "LEAN_PATH": ":".join([str(work)] + sorted(
               str(p) for p in cache.glob("*/.lake/build/lib/lean")))}
    command = [lean, "-o", "LeafAxiomBridge.olean", "LeafAxiomBridge.lean"]
    logfile = args.output.parent / "leaf_axiom_audit.log"
    start = time.monotonic()
    peak = 0
    stopped = None
    with logfile.open("wb") as stream:
        proc = subprocess.Popen(command, cwd=run_dir, env=env, stdout=stream,
                                stderr=subprocess.STDOUT, start_new_session=True)
        while proc.poll() is None:
            try:
                status = Path(f"/proc/{proc.pid}/status").read_text().splitlines()
                peak = max(peak, next((int(s.split()[1]) for s in status
                                       if s.startswith("VmRSS:")), 0))
            except FileNotFoundError:
                pass
            if peak > 8 * 1024**2:
                stopped = "resident memory exceeded 8 GiB"
            elif time.monotonic() - start > 180:
                stopped = "timeout exceeded 180 seconds"
            if stopped:
                try:
                    os.killpg(proc.pid, signal.SIGKILL)
                except ProcessLookupError:
                    pass
                proc.wait()
                break
            time.sleep(0.25)
    output = logfile.read_text()
    found = re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", output)
    axioms = {name: sorted(s.strip() for s in body.split(",") if s.strip())
              for name, body in found}
    allowed = sorted(["propext", "Classical.choice", "Quot.sound"])
    passed = (proc.returncode == 0 and stopped is None
              and len(found) == len(names) and set(axioms) == set(names)
              and all(a == allowed for a in axioms.values())
              and "sorryAx" not in output)
    report = {
        "status": "PASS" if passed else "FAIL",
        "scope": "Only the six named leaf solution declarations; not full FLT",
        "full_FLT_verified": False,
        "upstream_commit": previous["upstream_commit"],
        "prerequisite_report_sha256": digest(args.probe),
        "compiler": version, "mathlib_commit": current_mathlib,
        "source_path": str(source.resolve()), "source_sha256": digest(source),
        "command": command, "cwd": str(run_dir), "exit_code": proc.returncode,
        "elapsed_seconds": round(time.monotonic() - start, 3),
        "observed_peak_rss_kib": peak, "resource_stop": stopped,
        "log_path": str(logfile.resolve()), "log_sha256": digest(logfile),
        "declarations": axioms, "requested_C_or_object_output": False,
        "olean_sha256": digest(run_dir / "LeafAxiomBridge.olean") if passed else None,
    }
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(report["status"], len(axioms), "declarations", flush=True)
    if not passed:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
