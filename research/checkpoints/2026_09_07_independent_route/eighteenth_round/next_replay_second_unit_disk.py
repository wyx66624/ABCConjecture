"""Exact finite certificate for the second unit disk's mod25 obstruction.

The complete analytic tail argument is in next_second_unit_disk_certificate.md.
This imports only the previously audited exact algebra, not numerical software.
"""
from argparse import ArgumentParser
from fractions import Fraction as F
from hashlib import sha256
import json
from pathlib import Path

from next_replay_unit_disk import Dual, division, require
import next_replay_zero_slope as zs

HERE = Path(__file__).resolve().parent
OUT = HERE / "next_second_unit_disk_exact.json"


def sextic(z):
    return z**6-27*z**4+99*z*z-9


def sqrt_lift(z, prec):
    # The fixed ordinate branch is congruent to 2 modulo five.
    root, modulus = 2, 5
    require((root*root-sextic(z)) % 5 == 0, "wrong starting branch")
    for _ in range(1, prec):
        candidates = [root+j*modulus for j in range(5)
                      if ((root+j*modulus)**2-sextic(z)) % (5*modulus) == 0]
        require(len(candidates) == 1, "Hensel lift is not unique")
        root, modulus = candidates[0], 5*modulus
    return root


def local_rows(z0, prec):
    modulus = 5**prec
    Dual.p = modulus
    root = sqrt_lift(z0, prec)
    deriv = (6*z0**5-108*z0**3+198*z0)*pow(2*root, -1, modulus) % modulus
    z, W = Dual(z0, 1), Dual(root, deriv)
    rows = [division(-9, -9, (z*z-9)/4, W/8),
            division(-189, 999, (33-9/z**2)/4, -9*W/(8*z**3))]
    return {"z": z0, "modulus": modulus, "W": root,
            "W_derivative": deriv, "rows": rows}


def log_unit_residue(q, prec):
    modulus = 5**prec
    require(q % 5 != 0, "log input is not a unit")
    h = (pow(q, 4, modulus)-1) % modulus
    require(h % 5 == 0, "fourth power is not 1 modulo five")
    # For j>2prec the ordinary valuation bound j-v5(j)>=ceil(j/2)
    # puts the entire omitted tail beyond the requested precision.
    value = sum((F((-1)**(j+1)*h**j, j)
                 for j in range(1, 2*prec+1)), F(0))/4
    return zs.integral_residue(value, prec)


def constant_row(z0, prec, alphas):
    data = local_rows(z0, prec)
    r1, r2 = data["rows"]
    modulus, small = 5**prec, 5**(prec-1)
    xi = pow(z0, 81, modulus)*r1["delta"][0]*pow(r2["delta"][0], -1, modulus) % modulus
    lx, l3 = log_unit_residue(xi, prec), log_unit_residue(3, prec)
    T = [r1["formal_T"][0], r2["formal_T"][0]]
    require(all(t % 5 == 0 for t in T), "nonformal parameter")
    # L(T)-T is in 5^4 A and R0(T) is in 5^4 A, by SU's all-tail
    # bounds. At prec<=3 the following is therefore exact modulo 5^prec.
    require(2 <= prec <= 3, "finite constant evaluator has a bounded scope")
    logs = [(t//5)*pow(9, -1, small) % small for t in T]
    g = (-2*pow(81, -1, small)*(lx//5)
         -alphas[0]*logs[0]**2+alphas[1]*logs[1]**2
         +4*pow(3, -1, small)*(l3//5)) % small
    data.update({"Xi": xi, "log_Xi": lx, "log_3": l3,
                 "T": T, "log_E_div5": logs,
                 "normalized_f_residue": g})
    return data


def compute():
    global_rows = zs.compute()["rows"]
    alphas = [row["five_alpha0_mod_5pow8"] % 25 for row in global_rows]
    require(alphas == [16, 3], "global alpha normalization changed")
    center = constant_row(2, 2, alphas)
    row1, row2 = center["rows"]
    beta = (81*pow(2, -1, 5)+row1["log_delta_derivative"]
            -row2["log_delta_derivative"]) % 5
    local_slope = -2*pow(81, -1, 5)*beta % 5
    l1, l2 = center["log_E_div5"]
    b1 = 4*pow(center["W"], -1, 5) % 5
    b2 = -2*pow(center["W"], -1, 5) % 5
    coefficients = [center["normalized_f_residue"],
                    (local_slope-2*alphas[0]*l1*b1+2*alphas[1]*l2*b2) % 5,
                    (-alphas[0]*b1*b1+alphas[1]*b2*b2) % 5]
    require(coefficients == [4, 3, 4], "initial polynomial changed")
    roots = [s for s in range(5)
             if sum(c*s**j for j, c in enumerate(coefficients)) % 5 == 0]
    require(roots == [4], "initial candidate residue changed")
    require((coefficients[1]+2*coefficients[2]*4) % 5 == 0,
            "candidate residue is not the double root")
    subcenter = constant_row(22, 3, alphas)
    require(subcenter["W"] == 32 and subcenter["Xi"] == 24
            and subcenter["T"] == [90, 10], "exact subcenter inputs changed")
    require(subcenter["normalized_f_residue"] == 15,
            "complete subdisk obstruction changed")
    return {"status": "PASS",
            "scope": "exact finite inputs to SU's complete whole-disk exclusion; all analytic tails and the double-root Taylor exclusion are ordinary proofs, not supplied by this finite calculation alone",
            "global_five_alpha_mod25": alphas,
            "center_mod25": center, "candidate_subcenter_mod125": subcenter,
            "log_Xi_derivative_mod5": beta, "local_height_slope_mod5": local_slope,
            "elliptic_log_slopes_mod5": [b1, b2],
            "normalized_f_mod5_coefficients": coefficients,
            "candidate_residue": 4,
            "entire_candidate_subdisk_normalized_f_mod25": 15,
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
    print("PASS exact second-unit-disk obstruction; SHA256", sha256(data).hexdigest())
