"""Exact finite inputs to the separate ordinary infinity-disk proof."""

from argparse import ArgumentParser
from fractions import Fraction
from hashlib import sha256
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
SOURCE = HERE.parent / "2026_09_07_independent_route" / "eighteenth_round"
sys.path.insert(0, str(SOURCE))
import next_replay_unit_disk as ud
import next_replay_zero_slope as zs

OUT = HERE / "next_verification" / "infinity_inputs.json"


def require(condition, message):
    if not condition:
        raise ValueError(message)


def valuation(x, p):
    x = Fraction(x)
    require(x != 0, "this finite valuation call requires a nonzero value")
    a, b = abs(x.numerator), x.denominator
    v = 0
    while a % p == 0:
        a //= p
        v += 1
    while b % p == 0:
        b //= p
        v -= 1
    return v


def compute():
    P = tuple(map(Fraction, [6, 9]))
    twice = zs.add(P, P, -189)
    require(twice == (Fraction(33, 4), Fraction(9, 8)), "doubling differs")
    x, y = twice[0], -twice[1]
    require(y*y == x*x*x-189*x+999, "infinity quotient is off curve")
    ud.Dual.p = 5
    # x=(33-9q^2)/4, y=-9 sqrt(1-27q^2+99q^4-9q^6)/8.
    # These are their complete first jets in q^2 modulo five.
    row = ud.division(-189, 999, ud.Dual(2, 4), ud.Dual(2, 3))
    require(row["psi"][9][0] == 0, "center is not in the ninefold kernel mod5")
    require(row["phi"][0] != 0 and row["omega"][0] != 0, "unit denominator fails")
    psi3 = 3*x**4-1134*x*x+11988*x-35721
    at_three = {
        "x": valuation(x, 3), "y": valuation(y, 3),
        "A": valuation(3*x*x-189, 3), "B": valuation(2*y, 3),
        "C": valuation(psi3, 3), "c4": valuation(9072, 3),
    }
    require(at_three["x"] == 1 and at_three["y"] == 2, "three-adic coordinates differ")
    require(at_three["A"] > 0 and at_three["B"] == 2 and
            at_three["C"] >= 3*at_three["B"] and at_three["c4"] > 0,
            "Cremona case (c) premises fail")
    require(valuation(x, 2) == -2 and valuation(3*x*x-189, 2) < 0,
            "two-adic Cremona case (a) premises fail")
    alpha = zs.compute()["rows"][0]["five_alpha0_mod_5pow8"] % 5
    require(alpha == 1 and (-4*alpha) % 5 == 1, "quadratic leading unit differs")
    return {
        "status": "PASS",
        "scope": "finite quotient, local-height premises and division jets; IF ordinary proof supplies the entire analytic zero certificate",
        "twice_Pprime": [str(t) for t in twice],
        "infinity_quotient": [str(x), str(y)],
        "q_squared_jet_mod5": row,
        "three_adic_height_case": at_three,
        "two_adic_x_valuation": valuation(x, 2),
        "five_alpha1_mod5": alpha,
        "normalized_quadratic_coefficient_mod5": (-4*alpha) % 5,
        "unit_disk_verifier_sha256": sha256((SOURCE / "next_replay_unit_disk.py").read_bytes()).hexdigest(),
        "zero_slope_verifier_sha256": sha256((SOURCE / "next_replay_zero_slope.py").read_bytes()).hexdigest(),
    }


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    raw = (json.dumps(compute(), indent=2, sort_keys=True)+"\n").encode()
    if args.check:
        require(OUT.read_bytes() == raw, "canonical infinity inputs differ")
    else:
        OUT.parent.mkdir(parents=True, exist_ok=True)
        OUT.write_bytes(raw)
    print("PASS infinity quotient, units, height premises; SHA256", sha256(raw).hexdigest())
