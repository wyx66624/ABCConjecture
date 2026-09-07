#!/usr/bin/env python3
"""Verify the complete import graph; optional bounded refetch checks every source.

Default --check is offline, recomputes graph closures, and does not rewrite any
certificate. --refetch additionally streams the pinned archive without unpacking
it to disk. Neither mode starts a Lean or C compilation.
"""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import tarfile
import urllib.request


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="Offline closure check (default)")
    parser.add_argument("--refetch", action="store_true", help="Also verify every pinned source remotely")
    args = parser.parse_args()
    base = Path(__file__).parent / "verification"
    compressed = (base / "full_import_graph.json.gz").read_bytes()
    raw = gzip.decompress(compressed)
    summary = json.loads((base / "full_import_summary.json").read_text())
    assert hashlib.sha256(raw).hexdigest() == summary["full_graph_sha256"]
    assert hashlib.sha256(compressed).hexdigest() == summary["gzip_sha256"]
    graph = json.loads(raw)
    modules = graph["modules"]
    assert len(modules) == 60478
    assert summary["external_import_count"] == len(summary["external_imports"]) == 1706
    assert summary["mathlib_import_count"] == len(summary["mathlib_imports"]) == 1705
    assert summary["standard_library_imports"] == ["Lean"]
    assert summary["mathlib_imports"] == [x for x in summary["external_imports"]
                                           if x.startswith("Mathlib")]
    for start, expected in graph["closures"].items():
        seen, external, pending = set(), set(), [start]
        while pending:
            name = pending.pop()
            if name in seen:
                continue
            if name not in modules:
                external.add(name)
                continue
            seen.add(name)
            pending.extend(modules[name]["imports"])
        assert sorted(seen) == expected["local_modules"]
        assert sorted(external) == expected["external_imports"]
        assert len(seen) == expected["local_module_count"]
    assert graph["closures"]["FinalCheck"]["local_module_count"] == 60475
    assert graph["closures"]["Theorems.Thm_fermat_last_theorem"]["local_module_count"] == 60474
    assert graph["closures"]["P2M.Sol.S_fermat_last_theorem"]["local_module_count"] == 60473
    if args.refetch:
        class BoundedReader:
            def __init__(self, response):
                self.response, self.count = response, 0

            def read(self, size=-1):
                data = self.response.read(size)
                self.count += len(data)
                if self.count > 512 * 1024**2:
                    raise RuntimeError("Compressed archive exceeded 512 MiB")
                return data

        found, expanded = set(), 0
        with urllib.request.urlopen(graph["archive_url"], timeout=90) as response:
            with tarfile.open(fileobj=BoundedReader(response), mode="r|gz") as archive:
                for member in archive:
                    expanded += member.size
                    if expanded > 16 * 1024**3:
                        raise RuntimeError("Expanded stream exceeded 16 GiB")
                    prefix = "fermats-last-theorem-" + graph["commit"] + "/"
                    if not member.name.startswith(prefix):
                        continue
                    rel = member.name[len(prefix):]
                    if not member.isfile() or not rel.endswith(".lean"):
                        continue
                    name = rel[:-5].replace("/", ".")
                    data = archive.extractfile(member).read()
                    imports = [word for line in data.decode().splitlines()
                               if line.startswith("import ") for word in line[7:].split()]
                    assert hashlib.sha256(data).hexdigest() == modules[name]["sha256"], name
                    assert imports == modules[name]["imports"], name
                    found.add(name)
        assert found == set(modules)
    print(json.dumps({"status": "PASS", "source_modules": len(modules),
                      "closure_counts": {k: v["local_module_count"]
                                         for k, v in graph["closures"].items()},
                      "remote_sources_refetched_this_run": args.refetch,
                      "compiler_invoked": False}))


if __name__ == "__main__":
    main()
