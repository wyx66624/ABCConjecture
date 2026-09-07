#!/usr/bin/env python3
"""Try exactly six direct wrappers over the completed 12-module leaf probe.

All sources are unmodified and hash checked against the pinned full import
inventory. Compilation is sequential, olean only, and stops on the first failure.
The old Mathlib and previous leaf artifacts are read only.
"""
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import re
import signal
import subprocess
import time
import urllib.request


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--graph", type=Path, required=True)
    parser.add_argument("--probe", type=Path, required=True)
    parser.add_argument("--leaf-work", type=Path,
                        default=Path("/root/abc-flt-leaf-probe-432-rss"))
    parser.add_argument("--work", type=Path,
                        default=Path("/root/abc-flt-wrapper-probe-432"))
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    graph = json.loads(gzip.decompress(args.graph.read_bytes()))
    prior = json.loads(args.probe.read_text())
    if prior["status"] != "PASS: bounded leaf source compatibility only":
        raise ValueError("Prerequisite leaf probe is incomplete")
    if graph["commit"] != prior["upstream_commit"]:
        raise ValueError("Pins differ")
    modules = graph["modules"]
    cached = set(prior["selected_modules"])
    targets = ["Theorems.Thm_" + m.split(".")[-1][2:] for m in cached
               if m.startswith("P2M.Sol.")]
    targets.sort()
    if len(targets) != 6:
        raise ValueError("This bounded probe requires precisely six wrappers")
    cache = Path("/root/abc-lean-build/.lake/packages")
    work = args.work.resolve()
    if work == args.leaf_work.resolve() or Path("/root/abc-lean-build") in work.parents:
        raise ValueError("Refusing to write into a prerequisite cache")
    work.mkdir(parents=True, exist_ok=True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    for m in cached:
        p = args.leaf_work / modules[m]["path"]
        if sha(p) != modules[m]["sha256"] or not p.with_suffix(".olean").is_file():
            raise ValueError("Bad prerequisite: " + m)
    for m in targets:
        if {i for i in modules[m]["imports"] if i in modules} - cached:
            raise ValueError("Unexpected additional dependency: " + m)
    lean = subprocess.check_output(["/root/.elan/bin/elan", "which", "lean"], text=True,
             env={**os.environ, "ELAN_TOOLCHAIN": "leanprover/lean4:v4.32.0"}).strip()
    version = subprocess.check_output([lean, "--version"], text=True).strip()
    mathlib = subprocess.check_output(["git", "-C", str(cache / "mathlib"),
                                      "rev-parse", "HEAD"], text=True).strip()
    if version != prior["compiler"] or mathlib != prior["mathlib_commit"]:
        raise ValueError("Compiler or Mathlib pin changed")
    env = {**os.environ, "LEAN_NUM_THREADS": "2",
           "LEAN_PATH": ":".join([str(work), str(args.leaf_work.resolve())] + sorted(
               str(p) for p in cache.glob("*/.lake/build/lib/lean")))}
    state = {"status": "RUNNING", "full_FLT_verified": False,
             "scope": "Six exact wrappers and their named exported declarations only",
             "upstream_commit": graph["commit"], "compiler": version,
             "mathlib_commit": mathlib, "prerequisite_report_sha256": sha(args.probe),
             "new_modules": targets, "runs": [], "axioms": {},
             "max_parallel_processes": 1, "lean_threads": 2,
             "resident_memory_stop_bytes": 8 * 1024**3,
             "timeout_seconds": 180, "requested_C_or_object_output": False}

    def save():
        args.output.write_text(json.dumps(state, indent=2) + "\n")

    def run(label, relative):
        log = work / (label + ".log")
        command = [lean, "-o", relative[:-5] + ".olean", relative]
        start, peak, stopped = time.monotonic(), 0, None
        with log.open("wb") as stream:
            proc = subprocess.Popen(command, cwd=work, env=env, stdout=stream,
                                    stderr=subprocess.STDOUT, start_new_session=True)
            while proc.poll() is None:
                try:
                    lines = Path(f"/proc/{proc.pid}/status").read_text().splitlines()
                    peak = max(peak, next((int(s.split()[1]) for s in lines
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
        output = log.read_text()
        state["runs"].append({"label": label, "command": command,
            "cwd": str(work), "exit_code": proc.returncode, "resource_stop": stopped,
            "elapsed_seconds": round(time.monotonic()-start, 3),
            "observed_peak_rss_kib": peak, "output": output,
            "source_sha256": sha(work / relative)})
        print(label, proc.returncode, flush=True)
        if proc.returncode or stopped or "sorryAx" in output:
            state["status"] = "STOPPED at first failed wrapper or audit"
            save()
            raise SystemExit(1)
        save()
        return output

    declarations = []
    for m in targets:
        row = modules[m]
        p = work / row["path"]
        p.parent.mkdir(parents=True, exist_ok=True)
        if not p.exists():
            url = "https://raw.githubusercontent.com/anthropics/fermats-last-theorem/"
            with urllib.request.urlopen(url + graph["commit"] + "/" + row["path"],
                                        timeout=60) as response:
                p.write_bytes(response.read())
        if sha(p) != row["sha256"]:
            raise ValueError("Source hash differs: " + m)
        # These six selected wrappers use a fully qualified theorem name without
        # an enclosing namespace. Reject a different form instead of guessing.
        source = p.read_text()
        names = re.findall(r"^theorem ([^\s(]+)", source, re.MULTILINE)
        if len(names) != 1 or re.search(r"^namespace\b", source, re.MULTILINE):
            raise ValueError("Unexpected declaration form: " + m)
        declarations.extend(names)
        run(m, row["path"])
    bridge = ("\n".join("import " + m for m in targets) + "\n\n" +
              "\n".join("#print axioms " + n for n in declarations) + "\n")
    (work / "WrapperAxiomBridge.lean").write_text(bridge)
    (args.output.parent / "WrapperAxiomBridge.lean").write_text(bridge)
    output = run("WrapperAxiomBridge", "WrapperAxiomBridge.lean")
    pairs = re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", output)
    found = {name: sorted(x.strip() for x in body.split(",") if x.strip())
             for name, body in pairs}
    allowed = sorted(["propext", "Classical.choice", "Quot.sound"])
    passed = (len(pairs) == len(declarations) and set(found) == set(declarations)
              and all(a == allowed for a in found.values()))
    state["axioms"] = found
    state["status"] = "PASS" if passed else "FAIL: axiom inventory differs"
    state["artifacts"] = [{"path": str(p.relative_to(work)), "bytes": p.stat().st_size,
                           "sha256": sha(p)} for p in sorted(work.rglob("*.olean"))]
    save()
    print(state["status"], flush=True)
    if not passed:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
