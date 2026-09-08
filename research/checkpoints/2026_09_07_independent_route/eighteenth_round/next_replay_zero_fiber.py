"""Exact finite inputs to the whole zero-fiber disk exclusion (ZD).

The ordinary proof supplies cancellation, integrality, and all analytic tails.
"""
from argparse import ArgumentParser
from hashlib import sha256
import json
from pathlib import Path

from next_replay_unit_disk import Dual, division, require
from next_replay_second_unit_disk import log_unit_residue
import next_replay_zero_slope as zs

HERE = Path(__file__).resolve().parent
OUT = HERE / "next_zero_fiber_exact.json"


def ordinate(prec):
    root, modulus = 1, 5
    for _ in range(1, prec):
        candidates = [root+j*modulus for j in range(5)
                      if ((root+j*modulus)**2+9) % (5*modulus) == 0]
        require(len(candidates) == 1, "nonunique root of minus nine")
        root, modulus = candidates[0], 5*modulus
    return root


def center_row(prec, alpha):
    modulus, small = 5**prec, 5**(prec-1)
    W0 = ordinate(prec)
    Dual.p = modulus
    # Both coordinates of R1 are even in z, so their z derivatives at
    # zero vanish. This is the actual curve jet, not an arbitrary pair.
    row = division(-9, -9, Dual(-9)/4, Dual(W0)/8)
    factor = -W0*pow(2, -1, modulus) % modulus
    xi = row["delta"][0]*pow(factor, 81, modulus) % modulus
    lx, l3 = log_unit_residue(xi, prec), log_unit_residue(3, prec)
    t = row["formal_T"][0]
    require(t % 5 == 0, "first quotient is not sent into the formal group")
    ell1 = (t//5)*pow(9, -1, small) % small
    g0 = (-2*pow(81, -1, small)*(lx//5)-alpha*ell1**2
          +4*pow(3, -1, small)*(l3//5)) % small
    return {"modulus": modulus, "W0": W0, "R1_jet": row,
            "Xi_center": xi, "log_Xi": lx, "log_3": l3,
            "T1": t, "ell1_div5": ell1,
            "normalized_f_center": g0}


def compute():
    global_rows = zs.compute()["rows"]
    alphas = [row["five_alpha0_mod_5pow8"] % 25 for row in global_rows]
    require(alphas == [16, 3], "global constants changed")
    mod25, mod125 = center_row(2, alphas[0]), center_row(3, alphas[0])
    require(mod25["W0"] == 21 and mod25["Xi_center"] == 16
            and mod25["T1"] == 20, "first-precision zero-fiber inputs changed")
    # Xi is even; ell1 has no linear term; ell2 has derivative -2/W0.
    b2 = -2*pow(mod25["W0"], -1, 5) % 5
    coefficients = [mod25["normalized_f_center"], 0,
                    alphas[1]*b2*b2 % 5]
    require(coefficients == [0, 0, 2], "zero-fiber polynomial changed")
    require(mod125["W0"] == 46 and mod125["Xi_center"] == 66
            and mod125["T1"] == 95, "second-precision inputs changed")
    require(mod125["normalized_f_center"] == 20,
            "entire central subdisk obstruction changed")
    return {"status": "PASS",
            "scope": "exact finite zero-fiber inputs; ZD proves the removable-factor unit series, parity, full tails, and whole-subdisk exclusion; no finite-point height identity is assumed at the nonrational center",
            "global_five_alpha_mod25": alphas,
            "center_mod25": mod25, "center_mod125": mod125,
            "normalized_f_mod5_coefficients": coefficients,
            "candidate_residue": 0,
            "entire_candidate_subdisk_normalized_f_mod25": 20,
            "ordinary_zero_count_on_representative_disk": 0}


if __name__ == "__main__":
    ap = ArgumentParser()
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args()
    data = (json.dumps(compute(), sort_keys=True, indent=2)+"\n").encode()
    if args.check:
        require(OUT.read_bytes() == data, "canonical certificate differs")
    else:
        OUT.write_bytes(data)
    print("PASS exact zero-fiber obstruction; SHA256", sha256(data).hexdigest())
