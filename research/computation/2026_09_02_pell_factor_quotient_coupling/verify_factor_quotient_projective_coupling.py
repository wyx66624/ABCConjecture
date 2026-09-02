#!/usr/bin/env python3
"""Independent verifier for the factor-quotient/projective packet."""

from __future__ import annotations

import argparse
import hashlib
import json
import math
from math import comb, isqrt, prod
from pathlib import Path


def pell_pair(n: int, modulus: int | None = None) -> tuple[int, int]:
    """Independent binary powering in Z[s]/(s^2-2)."""
    ra, rb = 1, 0
    ba, bb = 1, 1
    for bit in bin(n)[:1:-1]:
        if bit == "1":
            ra, rb = ra * ba + 2 * rb * bb, ra * bb + rb * ba
            if modulus:
                ra %= modulus
                rb %= modulus
        ba, bb = ba * ba + 2 * bb * bb, 2 * ba * bb
        if modulus:
            ba %= modulus
            bb %= modulus
    return ra, rb


def legendre(a: int, p: int) -> int:
    z = pow(a % p, (p - 1) // 2, p)
    return -1 if z == p - 1 else z


def is_prime_u64(n: int) -> bool:
    if n < 2:
        return False
    for p in (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37):
        if n % p == 0:
            return n == p
    d, s = n - 1, 0
    while d % 2 == 0:
        d //= 2
        s += 1
    for a in (2, 325, 9375, 28178, 450775, 9780504, 1795265022):
        if a % n == 0:
            continue
        z = pow(a, d, n)
        if z in (1, n - 1):
            continue
        for _ in range(s - 1):
            z = z * z % n
            if z == n - 1:
                break
        else:
            return False
    return True


def verify_pocklington(n: int, cert: dict) -> bool:
    factors = {int(p): int(e) for p, e in cert["factorization_n_minus_one"].items()}
    bases = {int(p): int(a) for p, a in cert["bases"].items()}
    known = prod(p**e for p, e in factors.items())
    if known != n - 1 or known <= isqrt(n) or set(factors) != set(bases):
        return False
    for p, a in bases.items():
        if p >= 2**64 or not is_prime_u64(p):
            return False
        if pow(a, n - 1, n) != 1:
            return False
        if math.gcd(pow(a, (n - 1) // p, n) - 1, n) != 1:
            return False
    return True


def closed_coefficients(ell: int) -> list[tuple[int, int]]:
    """Independent closed-binomial reconstruction of both coefficient lists."""
    theta = (ell - 1) // 2
    out = []
    for j in range(theta + 1):
        d = comb(theta + j, 2 * j)
        num = ell * d
        c, rem = divmod(num, 2 * j + 1)
        if rem:
            raise AssertionError(f"nonintegral closed coefficient ({ell},{j})")
        out.append((c, d))
    return out


def elem3_recursive(ts: list[int]) -> tuple[int, int, int]:
    k = c = h = 0
    for t in reversed(ts):
        h = t * c + h
        c = t * k + c
        k = t + k
    return k, c, h


def companion_a_jet(x: int, k: int, c: int, h: int) -> int:
    return 6 + 8*x*k + x*x*(8*c + 4*k*k) + x**3*(8*h + 8*k*c)


def companion_b_jet(x: int, k: int, c: int, h: int) -> int:
    return 6 + 16*x*k + x*x*(16*c + 8*k*k) + x**3*(16*h + 16*k*c)


def ledger(ell: int, aa: tuple[int, int, int], bb: tuple[int, int, int]) -> int:
    ka, ca, ha = aa
    kb, cb, hb = bb
    return (ka - 2*kb + ell*(ka*ka - 2*kb*kb) + 2*ell*(ca - 2*cb)
            + 4*ell**2*(ha - 2*hb + ka*ca - 2*kb*cb)
            + 4*ell**3*(ca*ca - 2*cb*cb))


def endpoint_line(ell: int) -> tuple[str, dict]:
    A, B = pell_pair(ell)
    U = A * B
    v = 2 * (A*A + 2*B*B)
    coeff = closed_coefficients(ell)
    alpha = [32**j * c for j, (c, _) in enumerate(coeff)]
    beta = [32**j * d for j, (_, d) in enumerate(coeff)]
    theta = (ell - 1) // 2
    top = alpha[-1]
    a_prev, b_prev = alpha[-2], beta[-2]
    E = a_prev + top*U*U
    F = b_prev + top*U*U
    delta = (v*F)*(ell*top) - (v*top)*((ell-2)*E)
    curvature = 2*v*top*top
    assert A*A - 2*B*B == -1
    assert v*v - 32*U*U == 4
    assert top == beta[-1] == 32**theta
    assert (ell-2)*a_prev == ell*b_prev
    assert delta == curvature*U*U
    assert math.gcd(curvature, U) == 1
    assert delta % U**3 != 0
    line = f"{ell},{A},{B},{U},{v},{a_prev},{b_prev},{top},{curvature},{delta % (U**3)}\n"
    row = {
        "index": ell, "A": str(A), "B": str(B), "U": str(U), "v": str(v),
        "a_prev": str(a_prev), "b_prev": str(b_prev), "top": str(top),
        "curvature": str(curvature), "delta": str(delta),
        "delta_mod_U_cube": str(delta % U**3),
    }
    return line, row


def verify_witness(row: dict, certs: dict) -> str | None:
    ell, q, channel = int(row["index"]), int(row["prime"]), row["channel"]
    if q < 2**64:
        prime = is_prime_u64(q)
    else:
        prime = str(q) in certs and verify_pocklington(q, certs[str(q)])
    if not prime:
        return f"no primality proof for witness {q} at {ell}"
    A, B = pell_pair(ell, q*q)
    z = A if channel == "A" else B
    if z % q != 0 or z % (q*q) == 0:
        return f"not an exponent-one witness at {ell}"
    expected = 1 if channel == "A" else legendre(2, q) % (2*ell)
    if q % (2*ell) != expected:
        return f"rank residue mismatch at {ell}"
    return None


def quotient_lists(ell: int, fa: dict[int, int], fb: dict[int, int]) -> tuple[list[int], list[int]]:
    x = 2*ell
    ta, tb = [], []
    for p, e in sorted(fa.items()):
        if (p-1) % x:
            raise AssertionError("A quotient is nonintegral")
        ta += [(p-1)//x] * e
    for p, e in sorted(fb.items()):
        s = legendre(2, p)
        if (p-s) % x:
            raise AssertionError("B quotient is nonintegral")
        tb += [s*((p-s)//x)] * e
    return ta, tb


def verify_factor_row(stored: dict) -> dict:
    ell = int(stored["index"])
    A, B = pell_pair(ell)
    fa = {int(p): int(e) for p, e in stored["A_factorization"].items()}
    fb = {int(p): int(e) for p, e in stored["B_factorization"].items()}
    assert all(p < 2**64 and is_prime_u64(p) for p in (*fa, *fb))
    assert prod(p**e for p, e in fa.items()) == A
    assert prod(p**e for p, e in fb.items()) == B
    ta, tb = quotient_lists(ell, fa, fb)
    assert ta == stored["A_quotient_list"] and tb == stored["B_quotient_list"]
    aa, bb = elem3_recursive(ta), elem3_recursive(tb)
    assert list(aa) == stored["A_coefficients"] and list(bb) == stored["B_coefficients"]
    x, sell = 2*ell, legendre(2, ell)
    assert prod(1+x*t for t in ta) == A
    assert prod(1+x*t for t in tb) == sell*B
    a, b = (A-1)//x, (sell*B-1)//x
    assert (a - (aa[0]+x*aa[1]+x*x*aa[2])) % x**3 == 0
    assert (b - (bb[0]+x*bb[1]+x*x*bb[2])) % x**3 == 0
    L = ledger(ell, aa, bb)
    assert L % (8*ell**3) == 0
    assert L // (8*ell**3) == stored["third_ledger_quotient"]
    v = 4*A*A+2
    va, vb = companion_a_jet(x, *aa), companion_b_jet(x, *bb)
    assert va % x**4 == vb % x**4 == v % x**4
    top, curvature = 32**((ell-1)//2), 2*v*32**(ell-1)
    assert curvature == 2*v*top*top
    assert (2*top*top*va-curvature) % x**4 == 0
    oa = [p for p,e in fa.items() if e&1]
    ob = [p for p,e in fb.items() if e&1]
    edge_count = 0
    for r in ob:
        signs = [legendre(q,r) for q in oa]
        edge_count += len(signs)
        assert prod(signs) == legendre(2,r)
    for q in oa:
        assert prod(legendre(q,r) for r in ob) == legendre(B,q)
    squarefull = all(e>=2 for e in fa.values()) and all(e>=2 for e in fb.values())
    assert squarefull == stored["squarefull"]
    return {"index":ell,"factor_count":len(fa)+len(fb),"edge_count":edge_count,
            "squarefull":squarefull,"third_ledger_ok":True,"two_jets_ok":True}


def verify_local(row: dict) -> None:
    ell,q,r,k,h = (int(row[z]) for z in ("ell","q","r","k","h"))
    assert (ell,q,r,k,h) == (3,7,797,1,133)
    assert is_prime_u64(ell) and is_prime_u64(q) and is_prime_u64(r)
    assert q == 1+2*ell*k and r == -1+2*ell*h
    assert q%8 == 7 and r%8 == 5 and k%4 == h%4 == 1
    aa,bb = elem3_recursive([k]*3),elem3_recursive([-h]*3)
    assert list(aa)==row["A_coefficients"] and list(bb)==row["B_coefficients"]
    L=ledger(ell,aa,bb)
    assert L==row["ledger"] and L%(8*ell**3)==0
    assert legendre(q,r)==legendre(ell,q)==legendre(ell,r)==-1
    assert q**6-2*r**6+1==int(row["negative_pell_defect"])!=0


def main() -> None:
    parser=argparse.ArgumentParser()
    here=Path(__file__).resolve().parent
    parser.add_argument("--input",type=Path,default=here/"factor_quotient_projective_packet.json")
    parser.add_argument("--output",type=Path,default=here/"factor_quotient_projective_verification.json")
    args=parser.parse_args()
    data=json.loads(args.input.read_text(encoding="utf-8"))
    errors=[]
    if data.get("schema")!="pell-factor-quotient-projective-coupling-v1":
        errors.append("schema mismatch")
    witnesses=data["finite_actual_packet_exclusion"]["witnesses"]
    certs=data["finite_actual_packet_exclusion"]["pocklington_certificates"]
    for row in witnesses:
        err=verify_witness(row,certs)
        if err: errors.append(err)
    digest=hashlib.sha256(); selected=[]
    try:
        for row in witnesses:
            line,detail=endpoint_line(int(row["index"]));digest.update(line.encode("ascii"))
            if int(row["index"]) in (3,7,271):selected.append(detail)
        endpoint=data["endpoint_audit"]
        if digest.hexdigest()!=endpoint["sha256"]:errors.append("endpoint digest mismatch")
        if selected!=endpoint["selected_rows"]:errors.append("selected endpoint rows mismatch")
    except AssertionError as exc:
        errors.append(f"endpoint audit: {exc}")
    factor_summary=[]
    try:
        factor_summary=[verify_factor_row(row) for row in data["factor_quotient_rows"]]
    except AssertionError as exc:
        errors.append(f"factor quotient audit: {exc}")
    try: verify_local(data["local_ledger_counterexample"])
    except AssertionError as exc: errors.append(f"local counterexample: {exc}")
    result={
        "schema":"pell-factor-quotient-projective-verification-v1",
        "status":"PASS" if not errors else "FAIL",
        "errors":errors,
        "verified":{
            "exact_simple_witnesses":len(witnesses),
            "all_prime_indices_through":max(int(x["index"]) for x in witnesses),
            "endpoint_exact_and_sharp_rows":len(witnesses),
            "factor_quotient_rows":factor_summary,
            "local_L3_counterexample":not errors or not any("local counterexample" in e for e in errors),
            "actual_squarefull_packets_in_factored_rows":sum(x["squarefull"] for x in factor_summary),
        },
        "claim_boundary":"Finite exponent-one witnesses end at 271; no unbounded squarefull exclusion is claimed.",
    }
    args.output.write_text(json.dumps(result,indent=2)+"\n",encoding="utf-8")
    print(json.dumps(result,indent=2))
    raise SystemExit(0 if not errors else 1)


if __name__=="__main__":main()
