#!/usr/bin/env python3
"""Exact-support search for three-arm valuation-incidence successor gates.

All factorization, support-subset, modulus, radical, and defect calculations
are integer exact.  Floating-point logarithms are used only to rank the
resulting exact candidates and to solve the finite fractional transport
problem after its integer support has been fixed.
"""

from __future__ import annotations

import argparse
import csv
import json
import math
from dataclasses import dataclass
from functools import lru_cache
from itertools import combinations
from pathlib import Path


@lru_cache(maxsize=None)
def factor(n: int) -> tuple[tuple[int, int], ...]:
    out: list[tuple[int, int]] = []
    d = 2
    while d * d <= n:
        if n % d == 0:
            e = 0
            while n % d == 0:
                n //= d
                e += 1
            out.append((d, e))
        d = 3 if d == 2 else d + 2
    if n > 1:
        out.append((n, 1))
    return tuple(out)


@dataclass(frozen=True)
class Vertex:
    arm: str
    p: int
    e: int

    @property
    def modulus(self) -> int:
        return self.p**self.e

    @property
    def radical(self) -> int:
        return self.p

    @property
    def defect(self) -> int:
        return self.p ** (self.e - 1)


def vertices(a: int, b: int, c: int) -> tuple[Vertex, ...]:
    return tuple(
        Vertex(arm, p, e)
        for arm, n in (("A", a), ("B", b), ("C", c))
        for p, e in factor(n)
    )


def radical(n: int) -> int:
    ans = 1
    for p, _ in factor(n):
        ans *= p
    return ans


def optimal_monotone_unmatched(
    sources: list[tuple[int, float]], sinks: list[tuple[int, float]]
) -> float:
    """Minimum unmatched source mass for edges p -> q allowed when p <= q.

    The one-dimensional nested-neighbourhood problem is solved exactly up to
    floating arithmetic by processing sources and sinks from largest key to
    smallest.  Only display/ranking data depend on these logarithms.
    """
    src = sorted([[p, w] for p, w in sources], reverse=True)
    snk = sorted([[q, w] for q, w in sinks], reverse=True)
    unmatched = 0.0
    j = 0
    for p, amount in src:
        while amount > 1e-15:
            while j < len(snk) and snk[j][1] <= 1e-15:
                j += 1
            if j == len(snk) or snk[j][0] < p:
                unmatched += amount
                break
            moved = min(amount, snk[j][1])
            amount -= moved
            snk[j][1] -= moved
            if snk[j][1] <= 1e-15:
                j += 1
    unmatched = max(0.0, unmatched)

    # Nested-neighbourhood max-flow/min-cut certificate: for p -> q allowed
    # exactly when p <= q, the only cuts that matter are upper tails.  The
    # minimum unmatched source mass is their largest positive excess.
    thresholds = {0}
    thresholds.update(p for p, _ in sources)
    thresholds.update(q for q, _ in sinks)
    hall_value = max(
        0.0,
        *(
            sum(w for p, w in sources if p > t)
            - sum(w for q, w in sinks if q > t)
            for t in thresholds
        ),
    )
    if not math.isclose(unmatched, hall_value, rel_tol=1e-10, abs_tol=1e-10):
        raise AssertionError((sources, sinks, unmatched, hall_value))
    return unmatched


def regression_checks() -> None:
    # A sink too small for the current largest source must remain available
    # for later smaller sources.  This case caught an earlier pointer bug.
    got = optimal_monotone_unmatched([(5, 1.0), (2, 1.0)], [(3, 1.0)])
    assert math.isclose(got, 1.0, rel_tol=0.0, abs_tol=1e-12), got


def analyse(a: int, b: int, c: int) -> dict:
    vs = vertices(a, b, c)
    rtot = radical(a * b * c)
    best_raw = None
    best_flow = None
    best_scalar = None
    raw_mask = flow_mask = scalar_mask = 0
    covering = 0
    zero_defect_cover = False
    for mask in range(1 << len(vs)):
        mod = rad = defect = 1
        selected: list[Vertex] = []
        complement: list[Vertex] = []
        for i, v in enumerate(vs):
            if mask & (1 << i):
                selected.append(v)
                mod *= v.modulus
                rad *= v.radical
                defect *= v.defect
            else:
                complement.append(v)
        if mod < c:
            continue
        covering += 1
        if defect == 1:
            zero_defect_cover = True
        if best_raw is None or defect < best_raw:
            best_raw, raw_mask = defect, mask
        rcomp = rtot // rad
        scalar = max(0.0, math.log(defect) - math.log(rcomp))
        if best_scalar is None or scalar < best_scalar:
            best_scalar, scalar_mask = scalar, mask
        sources = [
            (v.p, (v.e - 1) * math.log(v.p)) for v in selected if v.e > 1
        ]
        sinks = [(v.p, math.log(v.p)) for v in complement]
        flow = optimal_monotone_unmatched(sources, sinks)
        if best_flow is None or flow < best_flow:
            best_flow, flow_mask = flow, mask

    assert best_raw is not None  # the full C arm always weakly covers c
    assert covering > 0

    def desc(mask: int) -> str:
        return ",".join(
            f"{v.arm}:{v.p}^{v.e}" for i, v in enumerate(vs) if mask & (1 << i)
        ) or "empty"

    conductor = math.log(rtot)
    return {
        "a": a,
        "b": b,
        "c": c,
        "radical": rtot,
        "support_vertices": len(vs),
        "covering_faces": covering,
        "zero_defect_cover": zero_defect_cover,
        "min_raw_defect": best_raw,
        "raw_face": desc(raw_mask),
        "raw_ratio": math.log(best_raw) / conductor if conductor else 0.0,
        "min_scalar_unmatched": best_scalar,
        "scalar_face": desc(scalar_mask),
        "scalar_ratio": best_scalar / conductor if conductor else 0.0,
        "min_monotone_unmatched": best_flow,
        "flow_face": desc(flow_mask),
        "flow_ratio": best_flow / conductor if conductor else 0.0,
    }


def primitive_rows(cmax: int) -> list[dict]:
    rows: list[dict] = []
    for c in range(2, cmax + 1):
        for a in range(1, c // 2 + 1):
            b = c - a
            if math.gcd(a, b) == 1:
                rows.append(analyse(a, b, c))
    return rows


def balanced_rows(rmax: int) -> list[dict]:
    return [analyse(2 ** (2 * r), 3**r, 2 ** (2 * r) + 3**r) for r in range(1, rmax + 1)]


def pythagorean_rows(tmax: int) -> list[dict]:
    rows: list[dict] = []
    for t in range(1, tmax + 1):
        x = 2 * t + 1
        y = 2 * t * (t + 1)
        z = 2 * t * t + 2 * t + 1
        assert x * x + y * y == z * z
        assert math.gcd(x * x, y * y) == 1
        rows.append(analyse(x * x, y * y, z * z))
    return rows


def top(rows: list[dict], key: str, n: int = 20) -> list[dict]:
    return sorted(rows, key=lambda row: row[key], reverse=True)[:n]


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--cmax", type=int, default=1500)
    parser.add_argument("--rmax", type=int, default=12)
    parser.add_argument("--tmax", type=int, default=80)
    parser.add_argument("--output", type=Path, default=Path(__file__).with_name("OUTPUT.json"))
    args = parser.parse_args()

    regression_checks()

    actual = primitive_rows(args.cmax)
    balanced = balanced_rows(args.rmax)
    pythagorean = pythagorean_rows(args.tmax)
    payload = {
        "parameters": {"cmax": args.cmax, "rmax": args.rmax, "tmax": args.tmax},
        "semantics": {
            "coverage": "selected full prime-power moduli have product >= c",
            "raw": "minimum selected multiplicity-defect product",
            "scalar": "minimum max(0, log(selected defect)-log(complement radical))",
            "flow": "minimum unmatched log mass in fractional monotone p<=q transport from selected excess layers to unselected prime vertices",
            "exactness": "factorization/subsets/modulus/radical/defect exact integers; logs only rank finite results",
        },
        "counts": {
            "actual_primitive_unordered": len(actual),
            "actual_zero_defect_failures": sum(not r["zero_defect_cover"] for r in actual),
        },
        "actual_top_raw_ratio": top(actual, "raw_ratio"),
        "actual_top_flow_ratio": top(actual, "flow_ratio"),
        "balanced": balanced,
        "pythagorean": pythagorean,
    }
    args.output.write_bytes((json.dumps(payload, indent=2) + "\n").encode("utf-8"))

    csv_path = args.output.with_suffix(".csv")
    fields = list((balanced + pythagorean)[0].keys()) + ["family", "index"]
    with csv_path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fields)
        writer.writeheader()
        for family, rows in (("balanced", balanced), ("pythagorean", pythagorean)):
            for i, row in enumerate(rows, 1):
                writer.writerow({**row, "family": family, "index": i})

    print(json.dumps({
        "output": str(args.output),
        "csv": str(csv_path),
        "counts": payload["counts"],
        "max_actual_raw_ratio": payload["actual_top_raw_ratio"][0]["raw_ratio"],
        "max_actual_flow_ratio": payload["actual_top_flow_ratio"][0]["flow_ratio"],
        "max_balanced_flow_ratio": max(r["flow_ratio"] for r in balanced),
        "max_pythagorean_flow_ratio": max(r["flow_ratio"] for r in pythagorean),
    }, indent=2))


if __name__ == "__main__":
    main()
