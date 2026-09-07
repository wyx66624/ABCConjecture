"""Canonical exact arithmetic and PARI replay; no ABC or modular elimination claim."""
from __future__ import annotations

import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess

BASE = Path(__file__).resolve().parent


def add(a, b):
    return a[0] + b[0], a[1] + b[1]


def scale(n, a):
    return n * a[0], n * a[1]


def mul(a, b):
    return a[0] * b[0] - 3 * a[1] * b[1], a[0] * b[1] + a[1] * b[0]


def v2(n):
    if n == 0:
        return 10**9
    return (abs(n) & -abs(n)).bit_length() - 1


def local_v2(z):
    # O_K = Z[(1+r)/2], so z = (U-V) + 2V zeta.
    return min(v2(z[0] - z[1]), 1 + v2(z[1]))


def tate_coefficients(a, b):
    x, y = a*a + b*b, a+b
    aa, bb = 12*y, (18*y*y, 6*x)
    if y % 2 == 0:
        rr = (2, 0)
        tt = (2 if y % 4 == 0 else -2, 2)
    else:
        rr = (1, 1)
        even = a if a % 2 == 0 else b
        tt = (4, 0) if even % 4 == 0 else (2, 2)
    rr2 = mul(rr, rr)
    return [add((aa, 0), scale(3, rr)), scale(2, tt),
            add(add(bb, scale(2*aa, rr)), scale(3, rr2)),
            add(add(add(mul(rr2, rr), scale(aa, rr2)), mul(bb, rr)),
                scale(-1, mul(tt, tt)))]


def run_gp(name):
    path = BASE / name
    gp = shutil.which("gp")
    if gp:
        cmd = [gp, "-f", "-q", "-s", "128000000", str(path)]
    else:
        linux_path = "/mnt/" + path.drive[0].lower() + path.as_posix()[2:]
        cmd = ["wsl", "-d", "Ubuntu-24.04", "-u", "root", "--",
               "/usr/bin/gp", "-f", "-q", "-s", "128000000", linux_path]
    result = subprocess.run(cmd, capture_output=True, text=True, check=True)
    stdout = result.stdout.replace("\r\n", "\n").replace("\r", "\n")
    stderr = re.sub(r"\x1b\[[0-9;]*m", "", result.stderr).strip()
    if stderr:
        raise AssertionError(f"PARI diagnostics for {name}: {stderr}")
    target = BASE / name.replace(".gp", "_results.txt")
    target.write_bytes(stdout.encode("utf-8"))
    return stdout, hashlib.sha256(stdout.encode("utf-8")).hexdigest()


def main():
    # Residue-complete validation of the explicit Tate divisibilities.
    # Every coefficient modulo 32 is determined by (a,b) modulo 32 and
    # the displayed branch modulo 4. This is supplementary to the proof.
    checked = 0
    for a in range(32):
        for b in range(32):
            if a % 2 == b % 2 == 0:
                continue
            vals = list(map(local_v2, tate_coefficients(a, b)))
            assert vals[0] == 1 and vals[1] >= 3
            assert vals[2] == 3 and vals[3] >= 5, (a, b, vals)
            x, y = a*a+b*b, a+b
            f = a**4+3*a**3*b+5*a*a*b*b+3*a*b**3+b**4
            assert x*x+3*y**4 == 4*f
            assert 2*x-y*y == (a-b)**2
            checked += 1

    files = {}
    local, files["frey_local_probe_results.txt"] = run_gp("frey_local_probe.gp")
    rows = local.splitlines()
    assert len(rows) == 159
    assert all("[6, -6, [1," in row and "[2, -3, [1," in row for row in rows)
    modular, files["modular_spaces_probe_results.txt"] = run_gp("modular_spaces_probe.gp")
    dims = {}
    for row in modular.splitlines():
        match = re.match(r"^\[(36|72|144|288|576), (\d+), \[", row)
        if match:
            dims[int(match.group(1))] = int(match.group(2))
    assert dims == {36: 2, 72: 0, 144: 2, 288: 4, 576: 8}
    boundary, files["boundary_probe_results.txt"] = run_gp("boundary_probe.gp")
    assert "[5, [-8]]" in boundary and "[7, [-4, 4]]" in boundary
    assert "[13, [4, -4]]" in boundary
    summary = {
        "scope": "Exact finite arithmetic and software replay; no eigenform elimination or ABC proof",
        "tate_residue_pairs_mod_32": checked,
        "primitive_local_samples_1_to_16": len(rows),
        "local_types": {"2": {"conductor": 6, "Kodaira": "I2*"},
                        "3": {"conductor": 2, "Kodaira": "III*"}},
        "newspace_dimensions_character_12_weight_2": dims,
        "canonical_output_sha256": files,
    }
    data = (json.dumps(summary, indent=2, sort_keys=True)+"\n").encode("utf-8")
    (BASE / "exact_frey_results.json").write_bytes(data)
    print(data.decode("utf-8"), end="")
    print("JSON SHA256", hashlib.sha256(data).hexdigest())


if __name__ == "__main__":
    main()
