#!/usr/bin/env python3
"""Deterministic audit of the quadratic Veronese peeling identities.

The scan is evidence for implementation/algebra checks only.  The infinite
no-go statements are proved in the mathematical note and Lean module.
"""

from __future__ import annotations

import argparse
import json
import math
from pathlib import Path


def primes_up_to(n: int) -> list[int]:
    sieve = bytearray(b"\x01") * (n + 1)
    if n >= 0:
        sieve[0:1] = b"\x00"
    if n >= 1:
        sieve[1:2] = b"\x00"
    for p in range(2, math.isqrt(n) + 1):
        if sieve[p]:
            sieve[p * p : n + 1 : p] = b"\x00" * (((n - p * p) // p) + 1)
    return [i for i in range(2, n + 1) if sieve[i]]


def factor_with_primes(n: int, primes: list[int]) -> dict[int, int]:
    assert n >= 1
    out: dict[int, int] = {}
    remainder = n
    for p in primes:
        if p * p > remainder:
            break
        if remainder % p == 0:
            e = 0
            while remainder % p == 0:
                remainder //= p
                e += 1
            out[p] = e
        if remainder == 1:
            break
    if remainder > 1:
        out[remainder] = 1
    return out


def factor_data_from_factors(n: int, factors: dict[int, int]) -> dict[str, object]:
    radical = math.prod(factors)
    exponent_gcd = 1 if n == 1 else math.gcd(*factors.values())
    height = math.log(n)
    radical_log = math.log(radical)
    root_height = height / exponent_gcd
    coherent = (exponent_gcd - 1) * root_height
    residual = root_height - radical_log
    layers = [sum(math.log(p) for p, e in factors.items() if e >= k)
              for k in range(1, max(factors.values(), default=0) + 1)]
    assert math.isclose(sum(layers), height, rel_tol=2e-13, abs_tol=2e-13)
    return {
        "factors": factors,
        "radical": radical,
        "height": height,
        "radical_log": radical_log,
        "g": exponent_gcd,
        "coherent": coherent,
        "residual": residual,
        "layers": layers,
    }


def factor_data(n: int, primes: list[int]) -> dict[str, object]:
    return factor_data_from_factors(n, factor_with_primes(n, primes))


def squared_factor_data(n: int, base: dict[str, object]) -> dict[str, object]:
    factors = {int(p): 2 * int(e) for p, e in dict(base["factors"]).items()}
    return factor_data_from_factors(n * n, factors)


def contact_area(h: list[float]) -> float:
    return h[0] * h[1] + h[1] * h[2] + h[2] * h[0]


def contact_loss(defects: list[float], heights: list[float]) -> float:
    return sum(
        defects[i] * heights[j] + defects[j] * heights[i]
        for i, j in ((0, 1), (1, 2), (2, 0))
    )


def close(a: float, b: float, scale: float = 1.0) -> bool:
    return abs(a - b) <= 2e-11 * max(scale, abs(a), abs(b), 1.0)


def one_parameter(t: int, primes: list[int]) -> dict[str, float | int | list[int]]:
    X = 2 * t + 1
    Y = 2 * t * (t + 1)
    Z = 2 * t * t + 2 * t + 1
    assert X * X + Y * Y == Z * Z
    assert Z - Y == 1
    assert Y + Z == X * X
    assert math.gcd(X, Y) == math.gcd(Y, Z) == math.gcd(Z, X) == 1

    fx, fy, fz = (factor_data(n, primes) for n in (X, Y, Z))
    u, v, w = (float(fx["height"]), float(fy["height"]), float(fz["height"]))
    beta, alpha, gamma = (
        float(fx["radical_log"]),
        float(fy["radical_log"]),
        float(fz["radical_log"]),
    )
    dx, dy, dz = u - beta, v - alpha, w - gamma

    phi_square = 4 * (u * v + u * w + v * w)
    phi_cell_1 = v * w
    phi_cell_2 = v * w + 2 * u * (v + w)
    phi_peeled = 2 * (phi_cell_1 + phi_cell_2)

    outer_v_square = phi_square
    outer_v_peeled = 2 * u * (v + w)
    outer_r_square = 2 * (dy * (u + w) + dx * (v + w) + dz * (u + v))
    outer_r_peeled = (
        4 * dy * (u + w) + 2 * dx * (v + w) + 4 * dz * (u + v)
    )
    outer_q_peeled = 2 * phi_square - outer_r_peeled
    outer_q_formula = (
        2 * u * (v + w)
        + 4 * alpha * (u + w)
        + 4 * gamma * (u + v)
        + 2 * beta * (v + w)
    )
    rho = alpha + beta + gamma
    height = 2 * w
    boundary_excess = outer_q_peeled - 2 * height * rho

    # Maximal exponent-gcd split, audited separately from the declared
    # outer-square split.  Squared factor data are reconstructed exactly.
    fsq = [
        squared_factor_data(Y, fy),
        squared_factor_data(X, fx),
        squared_factor_data(Z, fz),
    ]
    c1 = [fy, factor_data(1, primes), fz]
    c2 = [fy, fz, squared_factor_data(X, fx)]
    h_square = [float(x["height"]) for x in fsq]
    h1 = [float(x["height"]) for x in c1]
    h2 = [float(x["height"]) for x in c2]
    max_v_square = contact_loss([float(x["coherent"]) for x in fsq], h_square)
    max_r_square = contact_loss([float(x["residual"]) for x in fsq], h_square)
    max_v_peeled = 2 * (
        contact_loss([float(x["coherent"]) for x in c1], h1)
        + contact_loss([float(x["coherent"]) for x in c2], h2)
    )
    max_r_peeled = 2 * (
        contact_loss([float(x["residual"]) for x in c1], h1)
        + contact_loss([float(x["residual"]) for x in c2], h2)
    )
    max_q_peeled = 2 * phi_square - max_r_peeled

    assert close(phi_peeled, phi_square, phi_square)
    assert outer_v_peeled < 0.5 * outer_v_square
    expected_rise = 2 * dy * (u + w) + 2 * dz * (u + v)
    assert close(outer_r_peeled - outer_r_square, expected_rise, phi_square)
    assert close(outer_q_peeled, outer_q_formula, phi_square)
    assert boundary_excess + 1e-10 >= 4 * u * v
    # The exact layer duplication R_{2j-1}(n^2)=R_{2j}(n^2)=R_j(n).
    for base, square in ((fx, fsq[1]), (fy, fsq[0]), (fz, fsq[2])):
        base_layers = list(base["layers"])
        square_layers = list(square["layers"])
        duplicated = [value for value in base_layers for _ in (0, 1)]
        assert len(square_layers) == len(duplicated)
        assert all(close(a, b) for a, b in zip(square_layers, duplicated))
    assert close(contact_area(h_square), phi_square, phi_square)

    return {
        "t": t,
        "X": X,
        "Y": Y,
        "Z": Z,
        "gXYZ": [int(fx["g"]), int(fy["g"]), int(fz["g"])],
        "outer_veronese_ratio": outer_v_peeled / outer_v_square,
        "outer_residual_ratio": outer_r_peeled / outer_q_peeled,
        "maximal_residual_ratio": max_r_peeled / max_q_peeled,
        "maximal_veronese_ratio": (
            max_v_peeled / max_v_square if max_v_square > 0 else 0.0
        ),
        "boundary_excess_over_height": boundary_excess / height,
        "boundary_margin_over_4uv": boundary_excess - 4 * u * v,
        "outer_epsilon_001_gap_over_height":
            (outer_r_peeled - 0.01 * outer_q_peeled) / height,
        "max_layer_depth_square": max(
            max(f["factors"].values(), default=0) for f in fsq
        ),
        "phi_square": phi_square,
    }


def rounded_record(record: dict[str, object]) -> dict[str, object]:
    out: dict[str, object] = {}
    for key, value in record.items():
        if isinstance(value, float):
            out[key] = round(value, 12)
        else:
            out[key] = value
    return out


def build_results(limit: int = 20_000, power_k_max: int = 18) -> dict[str, object]:
    max_t = max(limit, 2**power_k_max)
    max_z = 2 * max_t * max_t + 2 * max_t + 1
    primes = primes_up_to(math.isqrt(max_z) + 1)

    top_outer: list[dict[str, object]] = []
    top_maximal: list[dict[str, object]] = []
    min_boundary_margin = math.inf
    max_identity_error = 0.0
    final_record: dict[str, object] | None = None

    for t in range(1, limit + 1):
        record = one_parameter(t, primes)
        final_record = record
        min_boundary_margin = min(
            min_boundary_margin, float(record["boundary_margin_over_4uv"])
        )
        max_identity_error = max(
            max_identity_error,
            abs(float(record["outer_veronese_ratio"])) * 0.0,
        )
        top_outer.append(record)
        top_maximal.append(record)
        top_outer.sort(key=lambda r: float(r["outer_residual_ratio"]), reverse=True)
        top_maximal.sort(
            key=lambda r: float(r["maximal_residual_ratio"]), reverse=True
        )
        del top_outer[12:]
        del top_maximal[12:]

    power_records: list[dict[str, object]] = []
    for k in range(2, power_k_max + 1):
        t = 2**k
        record = one_parameter(t, primes)
        X, Y, Z = int(record["X"]), int(record["Y"]), int(record["Z"])
        assert math.prod(factor_with_primes(Y, primes)) <= 2 * (t + 1)
        L = math.log(t)
        assert L <= math.log(X) <= 2 * L + 1e-12
        assert 2 * L <= math.log(Y) <= 3 * L + 1e-12
        assert 2 * L <= math.log(Z) <= 3 * L + 1e-12
        assert 2 * int(dict(factor_data(Y, primes)["factors"])[2]) >= 2 * (k + 1)
        power_records.append(rounded_record(record))

    assert final_record is not None
    return {
        "schema": "quadratic-veronese-peeling-audit-v1",
        "limit": limit,
        "power_k_max": power_k_max,
        "checked_full_premise_parameters": limit,
        "all_checks": True,
        "min_boundary_margin_over_4uv": round(min_boundary_margin, 12),
        "top_outer_residual_ratios": [rounded_record(r) for r in top_outer],
        "top_maximal_residual_ratios": [rounded_record(r) for r in top_maximal],
        "power_of_two_subsequence": power_records,
        "last_parameter": rounded_record(final_record),
        "interpretation": {
            "proved_by_scan": "finite replay only",
            "fixed_total_area_contraction": "refuted analytically; exact area conservation checked",
            "fixed_boundary_policy": "refuted analytically; lower margin checked",
            "outer_square_residual_policy": "refuted analytically at epsilon=0.01",
            "maximal_exponent_residual": "not refuted by the outer-square proof",
            "arbitrary_multi_move_gate_VF": "open",
            "abc_conjecture": "open",
        },
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--limit", type=int, default=20_000)
    parser.add_argument("--power-k-max", type=int, default=18)
    parser.add_argument("--output", type=Path, default=Path("scan_results.json"))
    args = parser.parse_args()
    results = build_results(args.limit, args.power_k_max)
    args.output.write_text(
        json.dumps(results, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(json.dumps({
        "all_checks": results["all_checks"],
        "checked": results["checked_full_premise_parameters"],
        "output": str(args.output),
    }, sort_keys=True))


if __name__ == "__main__":
    main()
