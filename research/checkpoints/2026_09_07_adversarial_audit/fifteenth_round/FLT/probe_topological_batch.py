#!/usr/bin/env python3
"""One bounded topological batch after the first eighteen compatible sources.

At most 30 new unchanged source modules, at most 600 seconds for the batch,
one compiler process with explicit -j2, and 8 GiB monitored resident memory.
The first failure stops the batch. No C or native object output is requested.
"""
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import signal
import subprocess
import time
import urllib.request


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--graph", type=Path, required=True)
    parser.add_argument("--leaf-report", type=Path, required=True)
    parser.add_argument("--wrapper-report", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--work", type=Path,
                        default=Path("/root/abc-flt-topological-probe-432"))
    args = parser.parse_args()
    graph = json.loads(gzip.decompress(args.graph.read_bytes()))
    leaf = json.loads(args.leaf_report.read_text())
    wrap = json.loads(args.wrapper_report.read_text())
    if leaf["status"] != "PASS: bounded leaf source compatibility only" or wrap["status"] != "PASS":
        raise ValueError("Prerequisite probes are not complete")
    pin = "aa2d8b34692b16c70f699536de0d8e75b9a3e9ef"
    if any(x != pin for x in (graph["commit"], leaf["upstream_commit"], wrap["upstream_commit"])):
        raise ValueError("Unexpected upstream pin")
    modules = graph["modules"]
    leaf_dir = Path("/root/abc-flt-leaf-probe-432-rss")
    wrap_dir = Path("/root/abc-flt-wrapper-probe-432")
    cache = Path("/root/abc-lean-build/.lake/packages")
    work = args.work.resolve()
    if any(work == p or p in work.parents for p in
           (leaf_dir, wrap_dir, Path("/root/abc-lean-build"))):
        raise ValueError("Refusing a prerequisite directory")
    work.mkdir(parents=True, exist_ok=True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    cached = set(leaf["selected_modules"] + wrap["new_modules"])
    for m in cached:
        p = (wrap_dir if m in wrap["new_modules"] else leaf_dir) / modules[m]["path"]
        if digest(p) != modules[m]["sha256"] or not p.with_suffix(".olean").is_file():
            raise ValueError("Changed prerequisite: " + m)
    known = set(cached)
    chosen = []
    local = set(graph["closures"]["FinalCheck"]["local_modules"])
    prefixes = ["Definitions.", "P2M.Sol.", "Theorems."]
    for step in range(30):
        eligible = sorted(m for m in local - known if modules[m]["bytes"] <= 50000
                          and {i for i in modules[m]["imports"] if i in modules} <= known)
        if not eligible:
            break
        preferred = [m for m in eligible if m.startswith(prefixes[step % 3])]
        target = (preferred or eligible)[0]
        chosen.append(target)
        known.add(target)
    lean = subprocess.check_output(["/root/.elan/bin/elan", "which", "lean"], text=True,
            env={**os.environ, "ELAN_TOOLCHAIN": "leanprover/lean4:v4.32.0"}).strip()
    version = subprocess.check_output([lean, "--version"], text=True).strip()
    mathlib = subprocess.check_output(["git", "-C", str(cache / "mathlib"),
                                      "rev-parse", "HEAD"], text=True).strip()
    if version != leaf["compiler"] or mathlib != leaf["mathlib_commit"]:
        raise ValueError("Compiler or Mathlib changed")
    env = {**os.environ, "LEAN_NUM_THREADS": "2",
           "LEAN_PATH": ":".join([str(work), str(wrap_dir), str(leaf_dir)] + sorted(
               str(p) for p in cache.glob("*/.lake/build/lib/lean")))}
    checkpoint = work / "state.json"
    state = json.loads(checkpoint.read_text()) if checkpoint.exists() else {
        "status": "RUNNING", "full_FLT_verified": False,
        "scope": "Bounded unchanged-source compatibility; no exhaustive axiom audit",
        "upstream_commit": pin, "compiler": version, "mathlib_commit": mathlib,
        "prerequisite_reports": {"leaf": digest(args.leaf_report),
                                  "wrappers": digest(args.wrapper_report)},
        "selected_modules": chosen, "prerequisite_module_count": len(cached),
        "max_parallel_processes": 1, "explicit_lean_threads": 2,
        "resident_memory_stop_bytes": 8 * 1024**3, "batch_timeout_seconds": 600,
        "module_timeout_seconds": 120, "requested_C_or_object_output": False,
        "runs": []}
    if state["selected_modules"] != chosen:
        raise ValueError("Checkpoint selection differs")
    if state["status"].startswith("STOPPED"):
        raise ValueError("Prior failure must be inspected; no automatic retry or skipping")

    def save():
        data = (json.dumps(state, indent=2) + "\n").encode()
        checkpoint.write_bytes(data)
        args.output.write_bytes(data)

    finished = {row["module"]: row for row in state["runs"] if row["exit_code"] == 0}
    batch_start = time.monotonic()
    save()
    for m in chosen:
        source = work / modules[m]["path"]
        source.parent.mkdir(parents=True, exist_ok=True)
        if time.monotonic() - batch_start >= 600:
            state["status"] = "PAUSED: bounded batch time reached"
            save()
            return
        try:
            if not source.exists():
                url = "https://raw.githubusercontent.com/anthropics/fermats-last-theorem/"
                with urllib.request.urlopen(url + pin + "/" + modules[m]["path"], timeout=60) as r:
                    source.write_bytes(r.read())
            if digest(source) != modules[m]["sha256"]:
                raise ValueError("Source hash mismatch")
        except Exception as error:
            state["status"] = "STOPPED: source acquisition or hash failure"
            state["failure"] = {"module": m, "error": str(error)}
            save()
            raise
        olean = source.with_suffix(".olean")
        if m in finished:
            if not olean.is_file() or digest(olean) != finished[m]["olean_sha256"]:
                raise ValueError("Changed completed artifact: " + m)
            continue
        command = [lean, "-j2", "-o", str(olean.relative_to(work)),
                   str(source.relative_to(work))]
        log = work / (m + ".log")
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
                elif time.monotonic() - start > 120:
                    stopped = "module timeout exceeded 120 seconds"
                elif time.monotonic() - batch_start > 600:
                    stopped = "batch timeout exceeded 600 seconds"
                if stopped:
                    try:
                        os.killpg(proc.pid, signal.SIGKILL)
                    except ProcessLookupError:
                        pass
                    proc.wait()
                    break
                time.sleep(0.25)
        output = log.read_text()
        row = {"module": m, "source_sha256": digest(source), "command": command,
               "cwd": str(work), "exit_code": proc.returncode, "resource_stop": stopped,
               "elapsed_seconds": round(time.monotonic()-start, 3),
               "observed_peak_rss_kib": peak, "output": output,
               "olean_sha256": digest(olean) if proc.returncode == 0 else None}
        state["runs"].append(row)
        print(m, proc.returncode, row["elapsed_seconds"], flush=True)
        if proc.returncode or stopped or "sorryAx" in output or "declaration uses 'sorry'" in output:
            state["status"] = "STOPPED at first failed unchanged module"
            save()
            raise SystemExit(1)
        save()
    state["status"] = "PASS: selected topological batch only"
    save()
    print(state["status"], flush=True)


if __name__ == "__main__":
    main()
