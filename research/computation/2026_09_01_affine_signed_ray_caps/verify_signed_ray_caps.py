#!/usr/bin/env python3
"""Independent finite pressure tests for the signed affine ray-cap note.

The proof in the note is symbolic.  This script exhaustively checks small
instances of every algebraic ledger, searches for counterexamples to the
named over-strengthenings with all of their stated premises, and enumerates
actual canonical affine divisor fibres in several small boxes.
"""

from __future__ import annotations

import json
from collections import defaultdict
from fractions import Fraction
from itertools import product
from math import gcd
from pathlib import Path


HERE = Path(__file__).resolve().parent


def divisors(n: int) -> list[int]:
    lo, hi = [], []
    d = 1
    while d * d <= n:
        if n % d == 0:
            lo.append(d)
            if d * d != n:
                hi.append(n // d)
        d += 1
    return lo + hi[::-1]


def radical(n: int) -> int:
    out, p = 1, 2
    while p * p <= n:
        if n % p == 0:
            out *= p
            while n % p == 0:
                n //= p
        p += 1
    if n > 1:
        out *= n
    return out


def totient(n: int) -> int:
    out, m, p = n, n, 2
    while p * p <= m:
        if m % p == 0:
            out -= out // p
            while m % p == 0:
                m //= p
        p += 1
    if m > 1:
        out -= out // m
    return out


def powerful_kernel(n: int) -> int:
    """Product of the exact prime powers p^e || n with e >= 2."""
    out, m, p = 1, n, 2
    while p * p <= m:
        power = 1
        while m % p == 0:
            power *= p
            m //= p
        if power >= p * p:
            out *= power
        p += 1
    return out


def direction_tests() -> dict:
    tested = 0
    equality = None
    zeros = {"U": 0, "V": 0, "W": 0}
    for b in range(1, 9):
        for c in range(b + 1, 10):
            k = (b + 1) * (c + 1)
            for s, t in product(range(-10, 11), repeat=2):
                if (s, t) == (0, 0):
                    continue
                tested += 1
                au, av, aw = s, s + c * t, s + b * t
                l = max(abs(s), abs(t))
                zero_count = sum(x == 0 for x in (au, av, aw))
                assert zero_count <= 1
                if zero_count == 0:
                    p = abs(au * av * aw)
                    assert p <= k * l**3
                    if p == k * l**3 and gcd(abs(s), abs(t)) == 1 and equality is None:
                        equality = {"B": b, "C": c, "s": s, "t": t,
                                    "P": p, "K_times_L3": k * l**3}
                elif au == 0:
                    q = abs(t)
                    assert abs(av * aw) == b * c * q**2
                    zeros["U"] += 1
                elif av == 0:
                    q = abs(t)
                    assert abs(au * aw) == c * (c - b) * q**2
                    zeros["V"] += 1
                else:
                    q = abs(t)
                    assert abs(au * av) == b * (c - b) * q**2
                    zeros["W"] += 1
    assert equality is not None
    return {"tested": tested, "sharp_universal_constant_witness": equality,
            "zero_direction_counts": zeros}


def ledger_tests() -> dict:
    cubic_cases = 0
    quadratic_cases = 0
    best_cubic = Fraction(0)
    best_quadratic = Fraction(0)

    # Exhaustive small pure cubic ledger.
    for h, t, ell, k, n, capture in product(
        range(0, 13), range(1, 9), range(1, 6), range(1, 13),
        range(1, 21), range(1, 81)
    ):
        if h * ell > n or capture > k * ell**3 or n * n >= t * capture:
            continue
        for card in range(h // t + 2):
            if card > h // t + 1:
                continue
            cubic_cases += 1
            a = max(card - 1, 0)
            assert a * n * ell < capture
            assert a**3 * t**2 * ell**3 < capture * n
            assert a**3 * t**2 < k * n
            if a:
                best_cubic = max(best_cubic, Fraction(a**3 * t**2, k * n))

    # Exhaustive small normalized quadratic ledger.
    for h, t, ell, j, k, n, capture in product(
        range(0, 11), range(1, 7), range(1, 5), range(1, 6),
        range(1, 21), range(1, 21), range(1, 61)
    ):
        if h * j * ell > n or capture > k * ell**2 or n * n >= t * capture:
            continue
        for card in range(h // t + 2):
            if card > h // t + 1:
                continue
            quadratic_cases += 1
            a = max(card - 1, 0)
            assert a * n * j * ell < capture
            assert a**2 * t * j**2 * ell**2 < capture
            assert a**2 * t * j**2 < k
            assert a**3 * t**2 * j**3 < k * n
            if a:
                best_quadratic = max(best_quadratic,
                                     Fraction(a**2 * t * j**2, k))

    # Full-premise witnesses against adding one more period factor.
    witness = {"card": 2, "H": 3, "T": 3, "capture": 6,
               "D": 18, "N": 3, "K": 6, "L": 1, "J": 1}
    a = witness["card"] - 1
    assert witness["card"] <= witness["H"] // witness["T"] + 1
    assert witness["H"] * witness["L"] <= witness["N"]
    assert witness["T"] * witness["capture"] == witness["D"]
    assert witness["capture"] <= witness["K"] * witness["L"]**3
    assert witness["N"]**2 < witness["D"]
    assert a**3 * witness["T"]**2 < witness["K"] * witness["N"]
    assert not (a**3 * witness["T"]**3 < witness["K"] * witness["N"])
    assert a**2 * witness["T"] < witness["K"]
    assert not (a**2 * witness["T"]**2 < witness["K"])

    closed_threshold_witness = {"card": 2, "H": 1, "T": 1,
                                "capture": 1, "D": 1, "N": 1,
                                "L": 1}
    assert closed_threshold_witness["card"] <= (
        closed_threshold_witness["H"] // closed_threshold_witness["T"] + 1)
    assert closed_threshold_witness["H"] * closed_threshold_witness["L"] <= closed_threshold_witness["N"]
    assert closed_threshold_witness["T"] * closed_threshold_witness["capture"] == closed_threshold_witness["D"]
    assert closed_threshold_witness["N"]**2 == closed_threshold_witness["D"]
    assert not ((closed_threshold_witness["card"] - 1) * closed_threshold_witness["N"] *
                closed_threshold_witness["L"] < closed_threshold_witness["capture"])

    return {
        "cubic_ledger_cases": cubic_cases,
        "quadratic_ledger_cases": quadratic_cases,
        "largest_cubic_ratio": str(best_cubic),
        "largest_quadratic_ratio": str(best_quadratic),
        "extra_period_factor_counterexample": witness,
        "closed_large_threshold_counterexample": closed_threshold_witness,
    }


def bridge_tests() -> dict:
    for n in range(0, 1001):
        a = max(n - 1, 0)
        assert n**3 <= 1 + 7 * a**3
    assert not (2**3 <= 1 + 6 * (2 - 1)**3)
    return {"counts_tested": 1001, "optimal_constant": 7,
            "factor_six_counterexample": {"occupancy": 2, "lhs": 8,
                                           "factor_six_rhs": 7}}


def primitive_direction(points: list[tuple[int, int]]) -> tuple[int, int, int, list[int]]:
    p0, p1 = points[0], points[1]
    dx, dy = p1[0] - p0[0], p1[1] - p0[1]
    g = gcd(abs(dx), abs(dy))
    s, t = dx // g, dy // g
    indices = []
    for x, y in points:
        if s:
            num = x - p0[0]
            assert num % s == 0
            z = num // s
        else:
            num = y - p0[1]
            assert num % t == 0
            z = num // t
        assert (x, y) == (p0[0] + z * s, p0[1] + z * t)
        indices.append(z)
    mn, mx = min(indices), max(indices)
    return s, t, mx - mn, [z - mn for z in indices]


def canonical_owner_global_test(
    b: int,
    c: int,
    nside: int,
    points: list[tuple[int, int]],
    arms: dict[tuple[int, int], tuple[int, int, int]],
) -> dict:
    """Replay the owner moments and (8.5) on actual powerful kernels."""
    kernels = {
        p: tuple(powerful_kernel(x) for x in arms[p])
        for p in points
    }
    classes = sorted(set(kernels.values()))
    fibres: dict[tuple[int, int, int], set[tuple[int, int]]] = defaultdict(set)
    threshold = nside * nside
    for p in points:
        ku, kv, kw = kernels[p]
        for label in product(divisors(ku), divisors(kv), divisors(kw)):
            if label[0] * label[1] * label[2] > threshold:
                fibres[label].add(p)

    owner_mass = sum(ku * kv * kw for ku, kv, kw in classes)
    owner_moment = [
        sum(ku * kv * kw * kernel[z] ** 3 for kernel in classes
            for ku, kv, kw in [kernel])
        for z in range(3)
    ]
    label_mass = 0
    coordinate_moment = [0, 0, 0]
    energy = 0
    shifted = 0
    arm_shifted = 0
    nonarm_shifted = 0
    inverse_period_sum = Fraction(0)
    repeated = 0
    nonarm_repeated = 0
    arm_repeated = {"U": 0, "V": 0, "W": 0}
    assigned_mass: dict[tuple[int, int, int], int] = defaultdict(int)
    assigned_moment: dict[tuple[int, int, int], list[int]] = defaultdict(
        lambda: [0, 0, 0]
    )
    for label, fibre_set in fibres.items():
        owners = [kernel for kernel in classes
                  if all(kernel[z] % label[z] == 0 for z in range(3))]
        assert owners
        owner = owners[0]
        assert all(owner[z] % label[z] == 0 for z in range(3))

        weight = totient(label[0]) * totient(label[1]) * totient(label[2])
        assigned_mass[owner] += weight
        label_mass += weight
        for z in range(3):
            assigned_moment[owner][z] += weight * label[z] ** 3
            coordinate_moment[z] += weight * label[z] ** 3
        count = len(fibre_set)
        a = count - 1
        energy += weight * count**3
        shifted += weight * a**3
        if count == 1:
            continue

        repeated += 1
        pts = sorted(fibre_set)
        s, t, hspan, indices = primitive_direction(pts)
        assert gcd(abs(s), abs(t)) == 1
        ell = max(abs(s), abs(t))
        assert hspan * ell <= nside
        coeff = (s, s + c * t, s + b * t)
        abs_coeff = tuple(abs(x) for x in coeff)
        captures = tuple(gcd(d, aa) for d, aa in zip(label, abs_coeff))
        capture = captures[0] * captures[1] * captures[2]
        periods = tuple(d // g for d, g in zip(label, captures))
        period = periods[0] * periods[1] * periods[2]
        assert period * capture == label[0] * label[1] * label[2]
        assert all(abs(x - y) % period == 0 for x in indices for y in indices)
        assert a * period <= hspan
        assert a * nside * ell < capture

        zeros = [z for z, value in enumerate(coeff) if value == 0]
        assert len(zeros) <= 1
        if zeros:
            z = zeros[0]
            expected = ((0, c, b), (c, 0, 1), (b, 1, 0))[z]
            assert abs_coeff == expected
            assert capture == label[z]
            arm_repeated["UVW"[z]] += 1
            arm_shifted += weight * a**3
        else:
            nonarm_repeated += 1
            assert a**3 * period**2 < (b + 1) * (c + 1) * nside
            nonarm_shifted += weight * a**3
            inverse_period_sum += Fraction(weight, period**2)

    for kernel in classes:
        kernel_mass = kernel[0] * kernel[1] * kernel[2]
        assert assigned_mass[kernel] <= kernel_mass
        assert all(assigned_moment[kernel][z] <= kernel_mass * kernel[z] ** 3
                   for z in range(3))
    assert label_mass <= owner_mass
    assert all(coordinate_moment[z] <= owner_moment[z] for z in range(3))
    assert energy <= label_mass + 7 * shifted
    assert shifted == arm_shifted + nonarm_shifted
    nonarm_rhs = (b + 1) * (c + 1) * nside * inverse_period_sum
    assert nonarm_shifted <= nonarm_rhs
    assert Fraction(arm_shifted) <= Fraction(
        owner_moment[0], nside**3
    ) + Fraction(owner_moment[1], (nside * c) ** 3) + Fraction(
        owner_moment[2], (nside * b) ** 3
    )
    global_rhs = Fraction(owner_mass) + 7 * (b + 1) * (c + 1) * nside * inverse_period_sum
    global_rhs += Fraction(7, nside**3) * (
        owner_moment[0] + Fraction(owner_moment[1], c**3) +
        Fraction(owner_moment[2], b**3)
    )
    assert energy <= global_rhs
    return {
        "kernel_classes": len(classes),
        "large_labels": len(fibres),
        "repeated_large_labels": repeated,
        "nonarm_repeated": nonarm_repeated,
        "arm_repeated": arm_repeated,
        "deduplicated_weight": label_mass,
        "owner_mass_bound": owner_mass,
        "coordinate_moments": coordinate_moment,
        "owner_coordinate_bounds": owner_moment,
        "large_cubic_energy": energy,
        "arm_shifted_energy": arm_shifted,
        "nonarm_shifted_energy": nonarm_shifted,
        "nonarm_rhs_8_3": str(nonarm_rhs),
        "global_rhs_8_5": str(global_rhs),
    }


def canonical_owner_case(b: int, m: int) -> dict:
    """Build one canonical box without the broader all-divisor catalogue."""
    c = b + 1
    r = radical(b * c)
    points = []
    arms = {}
    for h, k in product(range(1, m + 1), repeat=2):
        u = 1 + r * h
        v = 1 + r * (h + c * k)
        w = 1 + r * (h + b * k)
        if gcd(u, k) != 1:
            continue
        if gcd(u, v) != 1 or gcd(u, w) != 1 or gcd(v, w) != 1:
            continue
        points.append((h, k))
        arms[(h, k)] = (u, v, w)
    result = canonical_owner_global_test(b, c, m - 1, points, arms)
    return {"B": b, "C": c, "R": r, "M": m, "N": m - 1,
            "admissible_points": len(points), **result}


def actual_box_test(b: int, m: int) -> dict:
    c = b + 1
    r = radical(b * c)
    nside = m - 1
    points = []
    arms = {}
    for h, k in product(range(1, m + 1), repeat=2):
        u = 1 + r * h
        v = 1 + r * (h + c * k)
        w = 1 + r * (h + b * k)
        if gcd(u, k) != 1:
            continue
        if gcd(u, v) != 1 or gcd(u, w) != 1 or gcd(v, w) != 1:
            continue
        p = (h, k)
        points.append(p)
        arms[p] = (u, v, w)

    fibres: dict[tuple[int, int, int], set[tuple[int, int]]] = defaultdict(set)
    threshold = nside * nside
    for p in points:
        u, v, w = arms[p]
        for du, dv, dw in product(divisors(u), divisors(v), divisors(w)):
            if du * dv * dw > threshold:
                fibres[(du, dv, dw)].add(p)

    labels = len(fibres)
    repeated = 0
    nonarm = 0
    arm_counts = {"U": 0, "V": 0, "W": 0}
    w_total = 0
    e_total = 0
    e_shift = 0
    s2 = Fraction(0)
    capture_cubic_charge = Fraction(0)
    arm_shifted = {"U": 0, "V": 0, "W": 0}
    arm_capture_charge = {"U": Fraction(0), "V": Fraction(0), "W": Fraction(0)}
    max_occupancy = 0
    for label, fibre_set in fibres.items():
        pts = sorted(fibre_set)
        count = len(pts)
        max_occupancy = max(max_occupancy, count)
        weight = totient(label[0]) * totient(label[1]) * totient(label[2])
        w_total += weight
        e_total += weight * count**3
        a = count - 1
        e_shift += weight * a**3
        if count == 1:
            continue
        repeated += 1
        s, t, hspan, indices = primitive_direction(pts)
        assert gcd(abs(s), abs(t)) == 1
        ell = max(abs(s), abs(t))
        assert hspan * ell <= nside
        au, av, aw = s, s + c * t, s + b * t
        abs_coeff = (abs(au), abs(av), abs(aw))
        captures = tuple(gcd(d, aa) for d, aa in zip(label, abs_coeff))
        capture = captures[0] * captures[1] * captures[2]
        periods = tuple(d // g for d, g in zip(label, captures))
        period = periods[0] * periods[1] * periods[2]
        assert period * capture == label[0] * label[1] * label[2]
        for x in indices:
            for y in indices:
                assert abs(x - y) % period == 0
        assert a * period <= hspan
        assert a * nside * ell < capture

        zeros = [i for i, coeff in enumerate((au, av, aw)) if coeff == 0]
        assert len(zeros) <= 1
        if not zeros:
            pshape = abs(au * av * aw)
            assert a**3 * period**2 * ell**3 < pshape * nside
            assert capture <= pshape
            assert (b + 1) * (c + 1) * ell**2 > nside
            gamma = Fraction(pshape, ell**3)
            nonarm += 1
        else:
            z = zeros[0]
            if z == 0:
                assert abs_coeff == (0, c, b)
                assert ell == 1
                assert gcd(label[1], c) == 1
                assert gcd(label[2], b) == 1
            elif z == 1:
                assert abs_coeff == (c, 0, 1)
                assert ell == c
                assert gcd(label[0], c) == 1
            else:
                assert abs_coeff == (b, 1, 0)
                assert ell == b
                assert gcd(label[0], b) == 1
            assert capture == label[z]
            assert a**2 * period * ell**2 < label[z]
            assert a**3 * period**2 * ell**3 < label[z] * nside
            gamma = Fraction(label[z], ell**3)
            arm_counts["UVW"[z]] += 1
            arm_shifted["UVW"[z]] += weight * a**3
            arm_capture_charge["UVW"[z]] += weight * Fraction(label[z]**3, ell**3)
        s2 += weight * gamma / period**2
        capture_cubic_charge += weight * Fraction(capture**3, ell**3)

    assert e_total <= w_total + 7 * e_shift
    assert Fraction(e_shift) <= nside * s2
    assert nside**3 * e_shift < capture_cubic_charge
    for arm in "UVW":
        if arm_shifted[arm]:
            assert nside**3 * arm_shifted[arm] < arm_capture_charge[arm]
    owner_global = canonical_owner_global_test(b, c, nside, points, arms)
    return {
        "B": b, "C": c, "R": r, "M": m, "N": nside,
        "admissible_points": len(points), "large_labels": labels,
        "repeated_large_labels": repeated, "max_occupancy": max_occupancy,
        "nonarm_repeated": nonarm, "arm_repeated": arm_counts,
        "catalogue_weight": w_total, "large_cubic_energy": e_total,
        "shifted_energy": e_shift,
        "N_times_mixed_period_shape_charge": str(nside * s2),
        "capture_cubic_charge": str(capture_cubic_charge),
        "arm_shifted_energy": arm_shifted,
        "arm_capture_cubic_charge": {k: str(v) for k, v in arm_capture_charge.items()},
        "canonical_owner_global_audit": owner_global,
    }


def exact_capture_boundary_tests() -> dict:
    primitive_cases = {"U": 0, "V": 0, "W": 0}
    for b in range(1, 9):
        c = b + 1
        directions = {"U": (0, c, b), "V": (c, 0, 1), "W": (b, 1, 0)}
        for label in product(range(1, 21), repeat=3):
            if any(gcd(label[i], label[j]) != 1 for i, j in ((0, 1), (0, 2), (1, 2))):
                continue
            for z, arm in enumerate("UVW"):
                if arm == "U":
                    full_premises = gcd(label[1], c) == 1 and gcd(label[2], b) == 1
                elif arm == "V":
                    full_premises = gcd(label[0], c) == 1
                else:
                    full_premises = gcd(label[0], b) == 1
                if not full_premises:
                    continue
                primitive_cases[arm] += 1
                coeff = directions[arm]
                capture = 1
                for d, aa in zip(label, coeff):
                    capture *= gcd(d, aa)
                assert capture == label[z]

    b, c, q = 2, 3, 5
    nonprimitive = []
    for arm, label, coeff, target in (
        ("U", (1, 5, 1), (0, c * q, b * q), 1),
        ("V", (5, 1, 1), (c * q, 0, q), 1),
        ("W", (5, 1, 1), (b * q, q, 0), 1),
    ):
        assert all(gcd(label[i], label[j]) == 1 for i, j in ((0, 1), (0, 2), (1, 2)))
        if arm == "U":
            assert gcd(label[1], c) == 1 and gcd(label[2], b) == 1
        elif arm == "V":
            assert gcd(label[0], c) == 1
        else:
            assert gcd(label[0], b) == 1
        capture = 1
        for d, aa in zip(label, coeff):
            capture *= gcd(d, aa)
        assert capture == 5 and capture != target
        nonprimitive.append({"arm": arm, "label": label, "B": b, "C": c,
                             "scale": q, "absolute_coefficients": coeff,
                             "capture": capture, "claimed_arm_component": target})

    missing_coprime = []
    for arm, dropped, label, coeff, target in (
        ("U", "gcd(d_V,C)=1", (1, 3, 1), (0, 3, 2), 1),
        ("U", "gcd(d_W,B)=1", (1, 1, 2), (0, 3, 2), 1),
        ("V", "gcd(d_U,C)=1", (3, 1, 1), (3, 0, 1), 1),
        ("W", "gcd(d_U,B)=1", (2, 1, 1), (2, 1, 0), 1),
    ):
        assert all(gcd(label[i], label[j]) == 1 for i, j in ((0, 1), (0, 2), (1, 2)))
        if dropped != "gcd(d_V,C)=1":
            assert gcd(label[1], c) == 1
        if dropped != "gcd(d_W,B)=1":
            assert gcd(label[2], b) == 1
        if dropped not in ("gcd(d_U,C)=1", "gcd(d_U,B)=1"):
            assert gcd(label[0], c) == 1 and gcd(label[0], b) == 1
        capture = 1
        for d, aa in zip(label, coeff):
            capture *= gcd(d, aa)
        assert capture > target
        missing_coprime.append({"arm": arm, "dropped_premise": dropped,
                                "label": label, "B": 2, "C": 3,
                                "absolute_coefficients": coeff,
                                "capture": capture, "claimed_arm_component": target})
    return {
        "primitive_exact_capture_cases_by_arm": primitive_cases,
        "primitive_exact_capture_cases": sum(primitive_cases.values()),
        "nonprimitive_counterexamples_all_arms": nonprimitive,
        "missing_coefficient_coprimality_counterexamples_each_premise": missing_coprime,
    }


def main() -> None:
    boxes = [actual_box_test(b, 10) for b in range(1, 5)]
    first = boxes[0]
    all_divisor_weight = first["catalogue_weight"]
    selected_owner_mass = first["canonical_owner_global_audit"]["owner_mass_bound"]
    assert all_divisor_weight > selected_owner_mass
    report = {
        "schema": "affine-signed-ray-caps-v2",
        "direction_tests": direction_tests(),
        "ledger_tests": ledger_tests(),
        "bridge_tests": bridge_tests(),
        "capture_boundary_tests": exact_capture_boundary_tests(),
        "owner_membership_boundary_counterexample": {
            "B": first["B"], "C": first["C"], "M": first["M"],
            "N": first["N"], "admissible_points": first["admissible_points"],
            "all_arm_divisor_large_weight": all_divisor_weight,
            "distinct_kernel_classes":
                first["canonical_owner_global_audit"]["kernel_classes"],
            "selected_kernel_owner_mass": selected_owner_mass,
            "false_all_divisor_owner_inequality":
                f"{all_divisor_weight} <= {selected_owner_mass}",
        },
        "actual_affine_boxes": boxes,
        "canonical_owner_nonarm_stress_case": canonical_owner_case(4, 30),
    }
    text = json.dumps(report, indent=2, sort_keys=True)
    (HERE / "verification.json").write_text(text + "\n", encoding="utf-8")
    print(text)
    print("PASS: all signed-ray, arm-cap, owner-global, and actual-box checks")


if __name__ == "__main__":
    main()
