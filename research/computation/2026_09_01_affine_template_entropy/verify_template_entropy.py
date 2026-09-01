#!/usr/bin/env python3
"""Exact finite checks for the affine template-entropy note.

The mathematical separation and packing arguments are proved in the paper
and formalized in Lean.  This script checks the numerical constants, the
explicit determinant-only counterexample, and a bounded exhaustive stress
test of the abstract hypotheses.  A finite no-hit is not used to close any
route.
"""

from __future__ import annotations

from math import gcd


def pairwise_coprime(a: int, b: int, c: int) -> bool:
    return gcd(a, b) == gcd(a, c) == gcd(b, c) == 1


def cancellation_hypotheses(
    b: int, c: int, du: int, dv: int, dw: int
) -> bool:
    return (
        gcd(dv, c) == 1
        and gcd(dw, b) == 1
        and gcd(du, c) == 1
        and gcd(dw, c - b) == 1
        and gcd(du, b) == 1
        and gcd(dv, c - b) == 1
    )


def check_counterexample() -> None:
    b, c, ell, threshold = 1, 2, 1, 10
    du, dv, dw = 31, 1, 1
    xu = xv = xw = 1
    p, q = (30, 1), (30, 2)
    x, y = p[0] - q[0], p[1] - q[1]
    height = max(abs(x), abs(y))
    determinant = du * dv * dw

    assert pairwise_coprime(du, dv, dw)
    assert cancellation_hypotheses(b, c, du, dv, dw)
    assert x % du == (x + c * y) % dv == (x + b * y) % dw == 0
    assert 1 + p[0] == 1 + q[0] == 31
    assert determinant > (c + 1) ** 2 * ell**3
    assert determinant > threshold > (c + 1) ** 2 * ell**3
    assert max(ell * xu, ell * xv, ell * xw) < threshold
    assert height == ell

    # Any admissible X_U is at least d_U, so the missing cap inequality
    # L X_U < T < D cannot hold for this example.
    assert du > xu and ell * du == determinant


def bounded_abstract_stress() -> int:
    checked = 0
    for c in range(2, 7):
        for b in range(1, c):
            for ell in range(1, 5):
                cubic_gate = (c + 1) ** 2 * ell**3
                for du in range(1, 17):
                    for dv in range(1, 17):
                        for dw in range(1, 17):
                            determinant = du * dv * dw
                            if determinant <= max(
                                cubic_gate, ell * du, ell * dv, ell * dw
                            ):
                                continue
                            if not pairwise_coprime(du, dv, dw):
                                continue
                            if not cancellation_hypotheses(
                                b, c, du, dv, dw
                            ):
                                continue
                            checked += 1
                            for x in range(-ell, ell + 1):
                                for y in range(-ell, ell + 1):
                                    if x == 0 and y == 0:
                                        continue
                                    same_template_difference = (
                                        x % du == 0
                                        and (x + c * y) % dv == 0
                                        and (x + b * y) % dw == 0
                                    )
                                    assert not same_template_difference
    return checked


def check_canonical_constants(limit: int = 1000) -> int:
    checked = 0
    for c in range(6, limit + 1):
        ell = c**4 // 13
        assert ell > 0
        for radical in range(6, c):
            threshold_numerator = radical * c**14

            # Each comparison is the paper inequality after multiplication
            # by 8192, so no floating-point arithmetic occurs.
            assert 8192 * (c + 1) ** 2 * ell**3 < threshold_numerator
            assert 8192 * ell * c**6 < threshold_numerator
            assert 8192 * ell * c**7 < threshold_numerator

            m = c**6 // (4 * radical)
            cells = (m + ell) // (ell + 1)
            assert 36 * radical <= 5 * c**2
            assert 3721 < 12 * 324
            assert 324 * (13 * c**2 + 4 * radical) ** 2 <= (
                16 * 3721 * c**4
            )
            assert (13 * c**2 + 4 * radical) ** 2 < 16 * 12 * c**4
            assert cells * cells * radical**2 < 12 * c**4
            checked += 1
    return checked


def main() -> None:
    check_counterexample()
    abstract_cases = bounded_abstract_stress()
    canonical_pairs = check_canonical_constants()
    print("scope=exact_constants_plus_bounded_stress_not_asymptotic")
    print("determinant_only_counterexample=(B,C,L)=(1,2,1)")
    print("counterexample_moduli=(31,1,1)")
    print("counterexample_points=(30,1),(30,2)")
    print("counterexample_D=31>9")
    print("counterexample_threshold=31>10>9")
    print("counterexample_sup_distance=1")
    print("all_pairwise_and_cancellation_hypotheses=true")
    print("omitted_individual_modulus_cap=d_U<=X_U:false")
    print(f"bounded_abstract_parameter_cases={abstract_cases}")
    print("bounded_abstract_counterexamples=0")
    print(f"canonical_(c,R)_pairs_checked={canonical_pairs}")
    print("canonical_range=6<=c<=1000,6<=R<c")
    print("separation_scale=floor(c^4/13)")
    print("template_bound_constant=12")
    print("all_exact_integer_constant_checks=true")
    print("route_status=affine_route_open")


if __name__ == "__main__":
    main()
