#!/usr/bin/env python3
"""Bounded, restartable compatibility probe; never builds the complete FLT target.

At most twelve actual leaf dependencies are tried, sequentially, using two Lean
threads, a resident-memory monitor and a three-minute timeout. No C output
is requested. This next-only experiment is separate from the certified S2 bridge.
"""
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import resource
import signal
import subprocess
import time
import urllib.request


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--graph", type=Path, required=True)
    parser.add_argument("--work", type=Path, default=Path("/root/abc-flt-leaf-probe-432-rss"))
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    graph = json.loads(gzip.decompress(args.graph.read_bytes()))
    pin = graph["commit"]
    if pin != "aa2d8b34692b16c70f699536de0d8e75b9a3e9ef":
        raise ValueError("Unexpected upstream pin")
    cache = Path("/root/abc-lean-build/.lake/packages")
    work = args.work.resolve()
    if Path("/root/abc-lean-build") in work.parents:
        raise ValueError("Refusing to write in the old build")
    work.mkdir(parents=True, exist_ok=True)
    modules = graph["modules"]
    eligible = [name for name in graph["closures"]["FinalCheck"]["local_modules"]
                if name != "P2M.Util" and modules[name]["bytes"] < 25000
                and {i for i in modules[name]["imports"] if i in modules} <= {"P2M.Util"}]
    chosen = (["P2M.Util"]
              + sorted(x for x in eligible if x.startswith("Definitions."))[:5]
              + sorted(x for x in eligible if x.startswith("P2M.Sol."))[:6])
    lean = subprocess.check_output(
        ["/root/.elan/bin/elan", "which", "lean"],
        env={**os.environ, "ELAN_TOOLCHAIN": "leanprover/lean4:v4.32.0"}, text=True).strip()
    env = os.environ.copy()
    env["LEAN_NUM_THREADS"] = "2"
    env["LEAN_PATH"] = ":".join([str(work)] + sorted(
        str(p) for p in cache.glob("*/.lake/build/lib/lean")))
    state_file = work / "state.json"
    state = json.loads(state_file.read_text()) if state_file.exists() else {
        "status": "RUNNING", "upstream_commit": pin, "compiler": subprocess.check_output(
            [lean, "--version"], text=True).strip(),
        "mathlib_commit": subprocess.check_output(
            ["git", "-C", str(cache / "mathlib"), "rev-parse", "HEAD"], text=True).strip(),
        "max_parallel_processes": 1, "lean_threads": 2, "resident_memory_stop_bytes": 8 * 1024**3,
        "resident_memory_poll_seconds": 0.25,
        "per_process_timeout_seconds": 180, "requested_C_or_object_output": False,
        "selected_modules": chosen, "runs": [], "full_FLT_verified": False}
    if state["selected_modules"] != chosen:
        raise ValueError("Existing checkpoint does not match this sample")

    def save():
        data = (json.dumps(state, indent=2) + "\n").encode()
        state_file.write_bytes(data)
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_bytes(data)

    finished = {r["module"] for r in state["runs"] if r["exit_code"] == 0}
    for name in chosen:
        rel = modules[name]["path"]
        source = work / rel
        source.parent.mkdir(parents=True, exist_ok=True)
        if not source.exists():
            url = f"https://raw.githubusercontent.com/anthropics/fermats-last-theorem/{pin}/{rel}"
            with urllib.request.urlopen(url, timeout=60) as response:
                source.write_bytes(response.read())
        if hashlib.sha256(source.read_bytes()).hexdigest() != modules[name]["sha256"]:
            raise ValueError(f"Hash mismatch: {name}")
        if name in finished and source.with_suffix(".olean").is_file():
            continue
        command = [lean, "-o", rel[:-5] + ".olean", rel]
        begin = time.monotonic()
        log = work / (name + ".log")
        timed_out, memory_stopped, peak_rss_kib = False, False, 0
        with log.open("wb") as stream:
            process = subprocess.Popen(command, cwd=work, env=env, stdout=stream,
                                       stderr=subprocess.STDOUT, start_new_session=True)
            while process.poll() is None:
                try:
                    lines = Path(f"/proc/{process.pid}/status").read_text().splitlines()
                    rss = next((int(line.split()[1]) for line in lines
                                if line.startswith("VmRSS:")), 0)
                    peak_rss_kib = max(peak_rss_kib, rss)
                except FileNotFoundError:
                    pass
                timed_out = time.monotonic() - begin > 180
                memory_stopped = peak_rss_kib * 1024 > 8 * 1024**3
                if timed_out or memory_stopped:
                    try:
                        os.killpg(process.pid, signal.SIGKILL)
                    except ProcessLookupError:
                        pass
                    process.wait()
                    break
                time.sleep(0.25)
        output = log.read_text()
        row = {"module": name, "source_sha256": modules[name]["sha256"],
               "command": command, "exit_code": process.returncode,
               "timed_out": timed_out, "memory_stopped": memory_stopped,
               "observed_peak_rss_kib": peak_rss_kib,
               "elapsed_seconds": round(time.monotonic()-begin, 3),
               "output": output, "batch_max_child_rss_kib": resource.getrusage(
                   resource.RUSAGE_CHILDREN).ru_maxrss}
        state["runs"].append(row)
        print(name, process.returncode, row["elapsed_seconds"], flush=True)
        if process.returncode != 0 or "sorryAx" in output:
            state["status"] = "STOPPED at first failed unchanged source"
            save()
            print(output, flush=True)
            return
        save()
    state["status"] = "PASS: bounded leaf source compatibility only"
    state["artifacts"] = [{"path": str(p.relative_to(work)), "bytes": p.stat().st_size}
                          for p in work.rglob("*") if p.is_file() and p.suffix in
                          (".olean", ".ilean", ".c", ".o")]
    save()
    print(state["status"], flush=True)


if __name__ == "__main__":
    main()
