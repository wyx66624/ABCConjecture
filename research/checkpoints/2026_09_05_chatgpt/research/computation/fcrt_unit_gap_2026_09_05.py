#!/usr/bin/env python3
"""Exact, standard-library replay for the 2026-09-05 FCRT research supplement.

No floating-point logarithms, probabilistic primality tests, or external packages.
This program checks finite cases. It is not a proof of abc, nor a Lean checker.
Run from the repository root:
  python3 research/computation/fcrt_unit_gap_2026_09_05.py --output results.json
"""
from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import math
from dataclasses import dataclass
from fractions import Fraction
from pathlib import Path
from typing import Iterable

BASE_COMMIT = "6118955d20b4edd32e577e06d1060f3945358dd9"


def require(test: bool, message: str) -> None:
    # Deliberately not a Python assert: checks remain active under python -O.
    if not test:
        raise AssertionError(message)


def prime_trial(n: int) -> bool:
    if n < 2:
        return False
    if n % 2 == 0:
        return n == 2
    return all(n % d for d in range(3, math.isqrt(n) + 1, 2))


def sieve_spf(limit: int) -> list[int]:
    spf = list(range(limit + 1))
    for p in range(2, math.isqrt(limit) + 1):
        if spf[p] == p:
            for n in range(p * p, limit + 1, p):
                if spf[n] == n:
                    spf[n] = p
    return spf


def factor_spf(n: int, spf: list[int]) -> dict[int, int]:
    if not 1 <= n < len(spf):
        raise ValueError("SPF input outside its certified range")
    result: dict[int, int] = {}
    while n > 1:
        p = spf[n]
        e = 0
        while n % p == 0:
            n //= p
            e += 1
        result[p] = e
    return result


def factor_trial(n: int) -> dict[int, int]:
    if n < 1:
        raise ValueError("positive integer required")
    result: dict[int, int] = {}
    d = 2
    while d * d <= n:
        e = 0
        while n % d == 0:
            n //= d
            e += 1
        if e:
            result[d] = e
        d = 3 if d == 2 else d + 2
    if n > 1:
        result[n] = result.get(n, 0) + 1
    return result


def validate_factorization(n: int, factors: dict[int, int]) -> None:
    require(all(e >= 1 and prime_trial(p) for p, e in factors.items()),
            "invalid prime factor or exponent")
    require(math.prod(p ** e for p, e in factors.items()) == n,
            "factorization product mismatch")


def submasks(mask: int, *, nonempty: bool = True) -> Iterable[int]:
    s = mask
    while s:
        yield s
        s = (s - 1) & mask
    if not nonempty:
        yield 0


def fraction_json(value: Fraction | int) -> dict[str, int]:
    value = Fraction(value)
    return {"numerator": value.numerator, "denominator": value.denominator}


@dataclass
class Point:
    a: int
    b: int
    fa: dict[int, int]
    fb: dict[int, int]
    fc: dict[int, int]

    def __post_init__(self) -> None:
        require(self.a >= 1 and self.b >= 1 and math.gcd(self.a, self.b) == 1,
                "point must be positive and primitive")
        require(math.prod(p**e for p, e in self.fa.items()) == self.a,
                "a factorization mismatch")
        require(math.prod(p**e for p, e in self.fb.items()) == self.b,
                "b factorization mismatch")
        require(math.prod(p**e for p, e in self.fc.items()) == self.c,
                "c factorization mismatch")
        self.sources = tuple(sorted(p for p, e in self.fc.items() if e >= 2))
        self.sinks = tuple(sorted(set(self.fa) | set(self.fb)))
        self.i_all = (1 << len(self.sources)) - 1
        self.j_all = (1 << len(self.sinks)) - 1
        self.d = tuple(p ** (self.fc[p] - 1) for p in self.sources)
        self.moduli = tuple(p ** self.fc[p] for p in self.sources)
        self.packet_cache: dict[int, tuple[int, int, int]] = {0: (1, 1, 1)}

    @property
    def c(self) -> int:
        return self.a + self.b

    @property
    def radical(self) -> int:
        return math.prod(set(self.fa) | set(self.fb) | set(self.fc))

    def packet(self, mask: int) -> tuple[int, int, int]:
        if mask not in self.packet_cache:
            bit = mask & -mask
            j = bit.bit_length() - 1
            q = self.sinks[j]
            aa, bb, qq = self.packet(mask ^ bit)
            self.packet_cache[mask] = (
                aa * q ** self.fa.get(q, 0),
                bb * q ** self.fb.get(q, 0), qq * q)
        return self.packet_cache[mask]

    def source_product(self, mask: int) -> int:
        return math.prod(v for i, v in enumerate(self.d) if mask >> i & 1)

    def source_modulus(self, mask: int) -> int:
        return math.prod(v for i, v in enumerate(self.moduli) if mask >> i & 1)

    def label(self, target: int, mask: int) -> int:
        aa, bb, _ = self.packet(mask)
        m = self.moduli[target]
        return aa * pow(bb, -1, m) % m

    def compatible(self, source_mask: int, sink_mask: int) -> bool:
        aa, bb, _ = self.packet(sink_mask)
        return (aa + bb) % self.source_modulus(source_mask) == 0


def min_product_table(point: Point, target: int, mask: int) -> dict[int, tuple[int, int]]:
    """Residue -> (minimum radical product, nonempty witness mask).

    Reading the OLD table, not in-place updates, prevents reusing a prime.
    In particular no empty subset occupies residue 1.
    """
    m = point.moduli[target]
    table: dict[int, tuple[int, int]] = {}
    for j, q in enumerate(point.sinks):
        bit = 1 << j
        if not mask & bit:
            continue
        g = point.label(target, bit)
        old = table
        new = old.copy()
        options = [(g, q, bit)]
        options.extend((r * g % m, w * q, witness | bit)
                       for r, (w, witness) in old.items())
        for r, w, witness in options:
            if r not in new or w < new[r][0]:
                new[r] = (w, witness)
        table = new
    return table


def brute_min_table(point: Point, target: int, mask: int) -> dict[int, tuple[int, int]]:
    table: dict[int, tuple[int, int]] = {}
    for dmask in submasks(mask):
        r = point.label(target, dmask)
        weight = point.packet(dmask)[2]
        if r not in table or weight < table[r][0]:
            table[r] = (weight, dmask)
    return table


def best_flag_brute(point: Point, block_s: int, block_t: int,
                    target: int) -> tuple[Fraction, int] | None:
    d = point.source_product(block_s)
    q = point.packet(block_t)[2]
    require(d <= q, "unsaturated block supplied to flag optimizer")
    result: tuple[Fraction, int] | None = None
    for u in submasks(block_t):
        if u == block_t:
            continue
        if point.compatible(1 << target, u):
            credit = min(Fraction(q, d), Fraction(point.packet(u)[2]))
            if result is None or credit > result[0]:
                result = (credit, u)
    return result


def boundary_factor(point: Point, blocks: list[tuple[int, int]],
                    owners: dict[int, int],
                    flags: list[tuple[int, Fraction, int] | None]) -> Fraction:
    used_i = 0
    used_j = 0
    for s, t in blocks:
        require(s != 0 and t != 0 and not (s & used_i) and not (t & used_j),
                "invalid or overlapping blocks")
        require(point.compatible(s, t), "arithmetic block congruence failed")
        require(point.source_product(s) <= point.packet(t)[2], "block not saturated")
        used_i |= s
        used_j |= t
    residual_i = point.i_all ^ used_i
    residual_j = point.j_all ^ used_j
    credits = {i: Fraction(1) for i in range(len(point.sources)) if residual_i >> i & 1}
    for j, i in owners.items():
        require(residual_j >> j & 1 and i in credits, "invalid residual owner")
        credits[i] *= point.sinks[j]
    require(len(flags) == len(blocks), "flag list length mismatch")
    for (s, t), flag in zip(blocks, flags):
        if flag is None:
            continue
        i, f, u = flag
        require(i in credits and u != 0 and u != t and u & t == u,
                "invalid target or proper face")
        require(point.compatible(1 << i, u), "flag congruence failed")
        expected = min(Fraction(point.packet(t)[2], point.source_product(s)),
                       Fraction(point.packet(u)[2]))
        require(f == expected and f >= 1, "incorrect capped token")
        credits[i] *= f
    result = math.prod((max(Fraction(point.d[i], 1) / k, Fraction(1))
                        for i, k in credits.items()), start=Fraction(1))
    require(result >= 1 and point.radical * result >= point.c,
            "once-charge arithmetic bridge failed")
    return result


def optimize_exact(point: Point, mode: str = "FCRT") -> dict:
    if mode not in {"FCRT", "SCRT", "PBT"}:
        raise ValueError("mode must be FCRT, SCRT or PBT")
    if not point.sources:
        return {"factor": fraction_json(1), "configurations": 1,
                "certificate": {"blocks": [], "owners": {}, "flags": []}}
    q_all = point.packet(point.j_all)[2]
    if mode != "PBT" and point.source_product(point.i_all) <= q_all:
        value = boundary_factor(point, [(point.i_all, point.j_all)], {}, [None])
        require(value == 1, "full saturated block must have zero boundary")
        return {"factor": fraction_json(value), "configurations": 1,
                "certificate": {"blocks": [[point.i_all, point.j_all]],
                                "owners": {}, "flags": [None]}}
    candidates: list[tuple[int, int]] = []
    if mode != "PBT":
        for s in submasks(point.i_all):
            for t in submasks(point.j_all):
                if (point.source_product(s) <= point.packet(t)[2]
                        and point.compatible(s, t)):
                    candidates.append((s, t))
    best: Fraction | None = None
    best_cert = None
    checked = 0

    def evaluate(blocks: list[tuple[int, int]], used_i: int, used_j: int) -> None:
        nonlocal best, best_cert, checked
        ri = [i for i in range(len(point.sources)) if not used_i >> i & 1]
        rj = [j for j in range(len(point.sinks)) if not used_j >> j & 1]
        options: list[list[tuple[int, Fraction, int] | None]] = []
        for s, t in blocks:
            opts: list[tuple[int, Fraction, int] | None] = [None]
            if mode == "FCRT":
                for i in ri:
                    flag = best_flag_brute(point, s, t, i)
                    if flag is not None and flag[0] > 1:
                        opts.append((i, flag[0], flag[1]))
            options.append(opts)
        for flags in itertools.product(*options):
            # All residual sinks can be assigned without making the boundary worse.
            assignments = itertools.product(ri, repeat=len(rj)) if ri else [()]
            for assignment in assignments:
                owners = dict(zip(rj, assignment))
                value = boundary_factor(point, blocks, owners, list(flags))
                checked += 1
                if best is None or value < best:
                    best = value
                    best_cert = {
                        "blocks": [list(x) for x in blocks],
                        "owners": {str(j): i for j, i in owners.items()},
                        "flags": [None if f is None else
                                  {"target_index": f[0], "factor": fraction_json(f[1]),
                                   "witness_mask": f[2]} for f in flags]}

    def visit(start: int, blocks: list[tuple[int, int]], used_i: int, used_j: int) -> None:
        evaluate(blocks, used_i, used_j)
        for idx in range(start, len(candidates)):
            s, t = candidates[idx]
            if not (used_i & s or used_j & t):
                visit(idx + 1, blocks + [(s, t)], used_i | s, used_j | t)

    visit(0, [], 0, 0)
    require(best is not None, "optimizer omitted empty block family")
    return {"factor": fraction_json(best), "configurations": checked,
            "certificate": best_cert}


def small_point(a: int, b: int, spf: list[int]) -> Point:
    return Point(a, b, factor_spf(a, spf), factor_spf(b, spf), factor_spf(a + b, spf))


def run_dp_scan(limit: int, spf: list[int]) -> dict:
    primitive = 0
    tables = 0
    face_comparisons = 0
    cost_checks = 0
    bridge_checks = 0
    for c in range(2, limit + 1):
        for a in range(1, c):
            b = c - a
            if math.gcd(a, b) != 1:
                continue
            primitive += 1
            point = small_point(a, b, spf)
            if not point.sources:
                continue
            owners = {j: 0 for j in range(len(point.sinks))}
            boundary_factor(point, [], owners, [])
            bridge_checks += 1
            for i, m in enumerate(point.moduli):
                for t in submasks(point.j_all):
                    dp = min_product_table(point, i, t)
                    brute = brute_min_table(point, i, t)
                    require(dp == brute, f"DP discrepancy at {(a,b,c,i,t)}")
                    tables += 1
                    target = (-point.label(i, t)) % m
                    entry = dp.get(target)
                    faces = [u for u in submasks(t)
                             if u != t and point.compatible(1 << i, u)]
                    require(bool(faces) == (entry is not None), "face existence discrepancy")
                    if entry is not None:
                        require(entry[1] != t, "complementary deletion must be proper")
                        best_face_weight = max(point.packet(u)[2] for u in faces)
                        require(best_face_weight * entry[0] == point.packet(t)[2],
                                "minimum deletion / maximum face mismatch")
                    face_comparisons += 1
                    if point.label(i, t) == m - 1:
                        aa, bb, q = point.packet(t)
                        ex = max(point.fa.get(p, 0) + point.fb.get(p, 0)
                                 for j, p in enumerate(point.sinks) if t >> j & 1)
                        for d in submasks(t):
                            if point.label(i, d) == 1:
                                qd = point.packet(d)[2]
                                require(qd ** ex >= m + 1 and qd * (aa * bb // q) >= m + 1,
                                        "arithmetic cost obstruction failed")
                                cost_checks += 1
                    # Independently compare the exact cap for every applicable source set.
                    for s in submasks(point.i_all ^ (1 << i)):
                        if (point.source_product(s) <= point.packet(t)[2]
                                and point.compatible(s, t)):
                            direct = best_flag_brute(point, s, t, i)
                            require((direct is None) == (entry is None), "flag existence mismatch")
                            if entry is not None:
                                expected = Fraction(point.packet(t)[2],
                                                    max(point.source_product(s), entry[0]))
                                require(direct is not None and direct[0] == expected,
                                        "optimal capped factor mismatch")
    return {"c_inclusive_bound": limit, "ordered_primitive_triples": primitive,
            "dp_tables_equal_to_exhaustive_tables": tables,
            "face_normal_form_comparisons": face_comparisons,
            "arithmetic_cost_checks": cost_checks,
            "concrete_empty_block_owner_bridge_checks": bridge_checks}


def run_no_face_scan(limit: int, spf: list[int]) -> dict:
    endpoint_moduli = 0
    packets_tested = 0
    for c in range(2, limit + 1):
        fc = factor_spf(c, spf)
        moduli = [p**e for p, e in fc.items() if e >= 2 and c < p**e * (2*p**e - 1)]
        if not moduli:
            continue
        powers = [p**e for p, e in factor_spf(c - 1, spf).items()]
        products = [1]
        for x in powers:
            products += [v * x for v in products]
        proper = [v for v in products if 1 < v < c - 1]
        for m in moduli:
            endpoint_moduli += 1
            for u in proper:
                require((u + 1) % m != 0, f"threshold counterexample c={c}, M={m}, u={u}")
                packets_tested += 1
    return {"c_inclusive_bound": limit, "eligible_endpoint_modulus_pairs": endpoint_moduli,
            "proper_unitary_packets_checked": packets_tested, "counterexamples": 0}


def run_dense_gap_scan(limit: int, spf: list[int]) -> dict:
    cases = 0
    for q in range(2, limit + 1):
        fs = factor_spf(q, spf)
        if any(e != 1 for e in fs.values()):
            continue
        divisors = [1]
        previous = 1
        predicted = Fraction(1)
        for p in sorted(fs):
            predicted = max(predicted, Fraction(p, previous))
            previous *= p
            divisors += [p*d for d in divisors]
        divisors.sort()
        actual = max(Fraction(y, x) for x, y in zip(divisors, divisors[1:]))
        require(actual == predicted, "dense-divisor maximum gap mismatch")
        cases += 1
    return {"Q_inclusive_bound": limit, "squarefree_values_checked": cases}


def large_endpoint() -> tuple[Point, dict]:
    e, f = 41, 26
    m, n = 2**e, 3**f
    c = m * n
    fb = {7: 2, 439: 1, 857: 1, 2729: 1, 292183: 1, 380261663: 1}
    validate_factorization(c - 1, fb)
    point = Point(1, c - 1, {}, fb, {2: e, 3: f})
    require(max(m, n) < 2 * min(m, n) - 1, "balance failed")
    require((c - 1) % 49 == 0 and point.radical < c, "positive-defect certificate failed")
    h = 2729 * 380261663
    q = math.prod(fb)
    require(q % h == 0 and h <= 2**40 and q // h <= 3**25, "interval certificate failed")
    for i in range(2):
        require(not [u for u in submasks(point.j_all)
                     if u != point.j_all and point.compatible(1 << i, u)],
                "unexpected proper compatible face")
    return point, {"a": 1, "b": c-1, "c": c, "source_exponents": {"2": e, "3": f},
                   "b_factorization": {str(p): e for p, e in fb.items()},
                   "all_displayed_factors_prime_by_trial_division": True,
                   "radical": point.radical, "c_over_radical": fraction_json(Fraction(c, point.radical)),
                   "proper_faces_at_both_sources": 0,
                   "scalar_attaining_divisor": h, "complementary_sink_product": q // h,
                   "source_factors": [2**40, 3**25]}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path("fcrt_unit_gap_results.json"))
    parser.add_argument("--unit-gap-bound", type=int, default=200000)
    parser.add_argument("--dp-bound", type=int, default=200)
    parser.add_argument("--dense-bound", type=int, default=20000)
    args = parser.parse_args()
    require(min(args.unit_gap_bound, args.dp_bound, args.dense_bound) >= 2,
            "all bounds must be at least 2")
    spf = sieve_spf(max(args.unit_gap_bound, args.dp_bound, args.dense_bound, 65025))
    results = {"base_commit": BASE_COMMIT, "date": "2026-09-05",
               "scope": "Finite exact checks only; no abc proof; no Lean execution.",
               "arithmetic": "Python integers and fractions.Fraction; deterministic trial primality"}
    results["dynamic_program"] = run_dp_scan(args.dp_bound, spf)
    results["unit_gap_threshold"] = run_no_face_scan(args.unit_gap_bound, spf)
    results["dense_divisor_identity"] = run_dense_gap_scan(args.dense_bound, spf)
    gap_count = 0
    for m in range(2, 121):
        for s in range(1, 51):
            for t in range(1, 51):
                cbar = s*(m*t+1)-t
                if cbar != m:
                    require(cbar >= 2*m-1, "bilinear factor gap failed")
                    gap_count += 1
    results["bilinear_factor_gap"] = {"M": [2, 120], "s_and_t": [1, 50],
                                      "nonexceptional_cases_checked": gap_count}
    sharp = []
    for k in range(1, 9):
        m = 2**(2*k+1)
        c = m*(2*m-1)
        d, u = 2*m+1, m-1
        require(d*u == c-1 and math.gcd(d,u) == 1 and (u+1)%m == 0 and (d-1)%m == 0,
                "sharpness witness failed")
        require((2*m-1)%2 == 1, "full 2-adic exponent failed")
        sharp.append({"M": m, "c": c, "deletion_factor": d, "face_factor": u})
    results["sharp_threshold_witnesses"] = sharp
    e, f = 399, 252
    m, n = 2**e, 3**f
    require(e % 21 == 0 and f % 42 == 0 and max(m,n) < 2*min(m,n)-1,
            "symbolic infinite-family witness balance failed")
    require((pow(2,e,49)*pow(3,f,49)-1) % 49 == 0, "symbolic modulus failed")
    results["symbolic_family_member"] = {"e": e, "f": f, "digits_of_c": len(str(m*n)),
                                         "balance_by_exact_integer_comparison": True,
                                         "49_divides_c_minus_1": True,
                                         "factorization_of_c_minus_1_not_attempted": True}
    witnesses = [(1,675), (1,224), (1,65024), (1,4715), (343,625)]
    witness_results = []
    for a,b in witnesses:
        point = small_point(a,b,spf)
        row = {"a": a, "b": b, "c": a+b,
               "source_primes": list(point.sources), "sink_primes": list(point.sinks),
               "scalar_factor": fraction_json(max(Fraction(point.c,point.radical),Fraction(1)))}
        for mode in ("PBT","SCRT","FCRT"):
            row[mode] = optimize_exact(point,mode)
        witness_results.append(row)
    lp, large = large_endpoint()
    for mode in ("PBT","SCRT","FCRT"):
        large[mode] = optimize_exact(lp,mode)
        require(large[mode]["factor"] == large["c_over_radical"],
                "large endpoint failed scalar optimum")
    results["finite_witness_optimizations"] = witness_results
    results["large_endpoint"] = large
    # Seal expected repository witnesses independently, not merely print them.
    expected = [Fraction(26,15),Fraction(3,2),Fraction(3,2),Fraction(1),Fraction(44,35)]
    for row, want in zip(witness_results,expected):
        require(row["FCRT"]["factor"] == fraction_json(want), "known FCRT optimum mismatch")
    require(witness_results[2]["SCRT"]["factor"] == fraction_json(3), "SCRT witness mismatch")
    require(witness_results[2]["PBT"]["factor"] == fraction_json(Fraction(15,2)), "PBT witness mismatch")
    results["program_sha256"] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    results["all_checks_passed"] = True
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(results,ensure_ascii=False,indent=2)+"\n",encoding="utf-8")
    print(json.dumps({k:results[k] for k in ("dynamic_program","unit_gap_threshold",
                                          "dense_divisor_identity","bilinear_factor_gap",
                                          "symbolic_family_member","all_checks_passed")},indent=2))
    print(f"Results written to {args.output}")


if __name__ == "__main__":
    main()
