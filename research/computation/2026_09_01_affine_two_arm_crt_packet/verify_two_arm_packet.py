#!/usr/bin/env python3
"""Exact replay for the affine two-arm CRT packet.

The script proves only finite integer identities and verifies supplied prime
factorizations with deterministic Miller--Rabin for 64-bit integers.  It makes
no asymptotic inference and does not use a finite no-hit as mathematical
evidence.
"""
from __future__ import annotations

import argparse
from math import gcd
from pathlib import Path


def is_prime_u64(n: int) -> bool:
    """Deterministic Miller--Rabin primality test for n < 2^64."""
    if n < 2:
        return False
    small = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37)
    for p in small:
        if n % p == 0:
            return n == p
    d = n - 1
    s = 0
    while d % 2 == 0:
        s += 1
        d //= 2
    for a in (2, 325, 9375, 28178, 450775, 9780504, 1795265022):
        if a % n == 0:
            continue
        x = pow(a, d, n)
        if x in (1, n - 1):
            continue
        for _ in range(s - 1):
            x = x * x % n
            if x == n - 1:
                break
        else:
            return False
    return True


def value_of_factorization(factors: dict[int, int]) -> int:
    value = 1
    for p, exponent in factors.items():
        assert exponent > 0 and is_prime_u64(p)
        value *= p**exponent
    return value


def radical_from_factorization(factors: dict[int, int]) -> int:
    value = 1
    for p in factors:
        value *= p
    return value


def radical_trial(n: int) -> int:
    """Small-input exact radical, used only for the seed product."""
    assert n > 0
    answer = 1
    p = 2
    while p * p <= n:
        if n % p == 0:
            answer *= p
            while n % p == 0:
                n //= p
        p = 3 if p == 2 else p + 2
    if n > 1:
        answer *= n
    return answer


def crt_pair(a: int, m: int, b: int, n: int) -> int:
    assert gcd(m, n) == 1
    return (a + ((b - a) * pow(m, -1, n) % n) * m) % (m * n)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--write-output",
        action="store_true",
        help="replace OUTPUT.txt with the regenerated exact certificate",
    )
    args = parser.parse_args()

    a, b, c = 1, 242, 243
    R = radical_trial(a * b * c)
    assert a + b == c and gcd(a, b) == 1 and R == 66 and R < c

    M = c**6 // (4 * R)
    lower = M // 2 + 1
    upper = M
    assert M == 779_890_651_873 and lower == 389_945_325_937

    D, F = 5, 7
    d2, f2 = D * D, F * F
    alpha = R * (c + 1)
    beta = R * (b + 1)
    assert alpha == 16_104 and beta == 16_038
    assert gcd(alpha, d2) == gcd(beta, f2) == gcd(d2, f2) == 1

    residue_d = -pow(alpha, -1, d2) % d2
    residue_f = -pow(beta, -1, f2) % f2
    modulus = d2 * f2
    residue = crt_pair(residue_d, d2, residue_f, f2)
    assert (residue_d, residue_f, modulus, residue) == (6, 13, 1225, 356)
    assert (1 + alpha * residue) % d2 == 0
    assert (1 + beta * residue) % f2 == 0

    # Verify the two polynomial identities for every t by their coefficients.
    v_const, v_step = 229_321, 789_096
    w_const, w_step = 116_521, 400_950
    assert 1 + alpha * residue == d2 * v_const
    assert alpha * modulus == d2 * v_step
    assert 1 + beta * residue == f2 * w_const
    assert beta * modulus == f2 * w_step

    first = lower + (residue - lower) % modulus
    last = upper - (upper - residue) % modulus
    count = (last - first) // modulus + 1
    t_min = (first - residue) // modulus
    t_max = (last - residue) // modulus
    assert first == 389_945_326_231
    assert last == 779_890_650_881
    assert (t_min, t_max, count) == (318_322_715, 636_645_429, 318_322_715)
    assert first >= lower and last <= upper

    # The first row is the exact counterexample to two-arm sufficiency.
    h = k = first
    U = 1 + R * h
    V = 1 + R * (h + c * k)
    W = 1 + R * (h + b * k)
    assert (U, V, W) == (
        25_736_391_531_247,
        6_279_679_533_624_025,
        6_253_943_142_092_779,
    )
    assert gcd(U, k) == 1
    assert d2 == 25 and V % d2 == 0
    assert f2 == 49 and W % f2 == 0

    factors_u = {17: 1, 1_513_905_384_191: 1}
    factors_v = {5: 2, 23: 1, 37: 1, 139_267: 1, 2_119_433: 1}
    factors_w = {7: 2, 17_431: 1, 7_322_098_141: 1}
    assert value_of_factorization(factors_u) == U
    assert value_of_factorization(factors_v) == V
    assert value_of_factorization(factors_w) == W

    rad_u = radical_from_factorization(factors_u)
    rad_v = radical_from_factorization(factors_v)
    rad_w = radical_from_factorization(factors_w)
    excess_u, excess_v, excess_w = U // rad_u, V // rad_v, W // rad_w
    assert (excess_u, excess_v, excess_w) == (1, 5, 7)

    gate = R * c
    assert gate < 8192 * excess_v and gate < 8192 * excess_w
    assert U <= c**6 and V <= c**7 and W <= c**7

    A, B, C = a * U, b * V, c * W
    assert (A, B, C) == (
        25_736_391_531_247,
        1_519_682_447_137_014_050,
        1_519_708_183_528_545_297,
    )
    assert A + B == C
    assert gcd(A, B) == gcd(B, C) == gcd(C, A) == 1
    assert C < c**8

    output_radical = R * rad_u * rad_v * rad_w
    assert output_radical == 1_905_965_152_082_355_653_156_023_025_952_426_333_444_740_670
    is_exception = output_radical**4 < C**3
    assert not is_exception

    short_carrier = 139_267 * 2_119_433 * 17_431
    assert short_carrier == 5_145_057_294_975_341
    assert all(is_prime_u64(p) for p in (139_267, 2_119_433, 17_431))
    assert (A * B * C) % short_carrier == 0
    assert short_carrier**4 > C**3

    # The full inherited excess threshold fails overwhelmingly, explaining why
    # the two marginal gates do not imply exceptionality.
    assert not (R * c**14 < 8192 * excess_u * excess_v * excess_w)

    lines = [
        "scope=exact_finite_certificate_not_asymptotic",
        f"seed=({a},{b},{c})",
        f"R={R}",
        f"M={M}",
        f"I_M=[{lower},{upper}]",
        f"local_residues=k_mod_25:{residue_d},k_mod_49:{residue_f}",
        f"crt_residue={residue}",
        f"crt_modulus={modulus}",
        f"packet_t_range=[{t_min},{t_max}]",
        f"packet_k_range=[{first},{last}]",
        f"packet_count={count}",
        "packet_identity_V=25*(229321+789096*t)",
        "packet_identity_W=49*(116521+400950*t)",
        f"first_hk=({h},{k})",
        f"first_UVW=({U},{V},{W})",
        "first_factor_U=17*1513905384191",
        "first_factor_V=5^2*23*37*139267*2119433",
        "first_factor_W=7^2*17431*7322098141",
        "all_displayed_factors_prime=true",
        f"first_excess=({excess_u},{excess_v},{excess_w})",
        f"two_arm_gate=Rc:{gate}<8192E(V):{8192*excess_v},8192E(W):{8192*excess_w}",
        f"first_ABC=({A},{B},{C})",
        "primitive_abc_identity=true",
        "canonical_caps=true",
        f"output_radical={output_radical}",
        f"short_squarefree_carrier={short_carrier}",
        f"three_quarter_exception={str(is_exception).lower()}",
        "full_product_threshold=false",
    ]
    body = "\n".join(lines) + "\n"
    print(body, end="")

    output_path = Path(__file__).with_name("OUTPUT.txt")
    if args.write_output:
        output_path.write_text(body, encoding="utf-8", newline="\n")
        print("captured_output_written=true")
    elif output_path.exists():
        assert output_path.read_text(encoding="utf-8") == body
        print("captured_output_match=true")


if __name__ == "__main__":
    main()
