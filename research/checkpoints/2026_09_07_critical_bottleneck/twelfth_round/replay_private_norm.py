"""Exact finite checks for PN private norm support and tuple phases.

This is finite evidence only. It does not certify the asymptotic density,
Brun--Titchmarsh, the deep-prime membership hypothesis, or any farther tail.
All arithmetic used for certification is integer arithmetic.
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import math
from collections import Counter
from pathlib import Path


BLOCKS = (16, 32, 64, 128, 256, 625, 2401)
ROOT = Path(__file__).resolve().parent
OUTPUT = ROOT / "verification" / "private_norm_replay.json"


def primes_upto(limit: int) -> list[int]:
    mark = bytearray(b"\1") * (limit + 1)
    mark[:2] = b"\0\0"
    for p in range(2, math.isqrt(limit) + 1):
        if mark[p]:
            start = p * p
            mark[start : limit + 1 : p] = b"\0" * ((limit - start) // p + 1)
    return [p for p in range(2, limit + 1) if mark[p]]


def factor(m: int, primes: list[int]) -> list[list[int]]:
    out = []
    for p in primes:
        if p * p > m:
            break
        if m % p == 0:
            e = 0
            while m % p == 0:
                m //= p
                e += 1
            out.append([p, e])
    if m > 1:
        out.append([m, 1])
    return out


def mul(x: tuple[int, int], y: tuple[int, int]) -> tuple[int, int]:
    a, b = x
    c, d = y
    return a * c - b * d, a * d + b * c + b * d


def replay() -> dict:
    top = max(BLOCKS)
    primes = primes_upto(math.isqrt(49 * top * top) + 1)
    all_rows = []
    block_rows = []
    tuple_rows = []
    tuple_digest = hashlib.sha256()
    tuple_total = 0
    private_total = 0
    for block in BLOCKS:
        values = []
        private = []
        occurrences: dict[int, list[int]] = {}
        for k in range(block, 2 * block):
            a = 3 * k
            qnorm = a * a + a + 1
            fs = factor(qnorm, primes)
            assert math.prod(p**e for p, e in fs) == qnorm
            assert 9 * block * block <= qnorm < 49 * block * block
            assert all(p % 3 == 1 for p, _e in fs)
            big = [(p, e) for p, e in fs if p > 12 * block]
            assert len(big) <= 1
            if big:
                p, e = big[0]
                assert e == 1
                assert p * p > qnorm
                # In the split component zeta=-a, w=a+zeta vanishes;
                # the conjugate has nonzero component 2a+1.
                assert ((-a) ** 2 - (-a) + 1) % p == 0
                assert (2 * a + 1) % p != 0
                private.append((k, p))
            for p, _e in fs:
                occurrences.setdefault(p, []).append(k)
            values.append((k, a, qnorm))
            all_rows.append([block, k, qnorm, fs, big[0][0] if big else 0])
        for k, p in private:
            assert occurrences[p] == [k]
        private_total += len(private)
        block_rows.append(
            {
                "B": block,
                "full_norm_factorizations": block,
                "private_root_count": len(private),
                "density_exact_fraction": [len(private), block],
            }
        )
        # Exhaustive ordered pairs/triples on a specified finite subset.
        # Equal actual ratio products must have equal index multisets.
        sample = [k for k, _p in private[:10]]
        for nu in (2, 3):
            fibers: dict[tuple[int, int], tuple[tuple[int, ...], int]] = {}
            for indices in itertools.product(sample, repeat=nu):
                product = (1, 0)
                for k in indices:
                    product = mul(product, (3 * k, 1))
                r, s = product
                assert r > 0 and s > 0
                d = math.gcd(r, s)
                phase = (r // d, s // d)
                multiset = tuple(sorted(indices))
                if phase in fibers:
                    previous, count = fibers[phase]
                    assert previous == multiset
                    fibers[phase] = (previous, count + 1)
                else:
                    fibers[phase] = (multiset, 1)
                tuple_digest.update(
                    json.dumps(
                        [block, nu, indices, product, phase, multiset],
                        separators=(",", ":"),
                    ).encode("ascii")
                    + b"\n"
                )
                tuple_total += 1
            histogram = Counter()
            for multiset, count in fibers.values():
                multiplicities = Counter(multiset)
                expected = math.factorial(nu) // math.prod(
                    math.factorial(e) for e in multiplicities.values()
                )
                assert count == expected <= math.factorial(nu)
                histogram[count] += 1
            tuple_rows.append(
                {
                    "B": block,
                    "nu": nu,
                    "specified_private_indices": sample,
                    "ordered_tuples": len(sample) ** nu,
                    "distinct_actual_phases": len(fibers),
                    "fiber_size_histogram": sorted(histogram.items()),
                }
            )
    payload = {
        "schema": 1,
        "scope": (
            "Exact finite full norm factorizations, unique split-prime witnesses, "
            "and ordered tuple phase fibers on the stated finite subsets. "
            "No asymptotic density, deep-boundary membership, or tail certificate."
        ),
        "blocks": block_rows,
        "norm_rows": all_rows,
        "tuple_checks": tuple_rows,
        "tuple_rows_sha256": tuple_digest.hexdigest(),
        "counts": {
            "full_norm_factorizations": len(all_rows),
            "private_prime_witnesses": private_total,
            "ordered_tuples": tuple_total,
        },
    }
    seal = hashlib.sha256(
        json.dumps(payload, sort_keys=True, separators=(",", ":")).encode("ascii")
    ).hexdigest()
    return {"payload": payload, "canonical_payload_sha256": seal}


def main() -> None:
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--write", action="store_true")
    group.add_argument("--check", action="store_true")
    args = parser.parse_args()
    result = replay()
    exact_bytes = (
        json.dumps(result, sort_keys=True, indent=2, ensure_ascii=True) + "\n"
    ).encode("ascii")
    if args.write:
        OUTPUT.parent.mkdir(parents=True, exist_ok=True)
        OUTPUT.write_bytes(exact_bytes)
    else:
        assert OUTPUT.read_bytes() == exact_bytes, "Finite replay differs"
    print(
        json.dumps(
            {
                "status": "PASS",
                "mode": "write" if args.write else "check",
                **result["payload"]["counts"],
                "canonical_payload_sha256": result["canonical_payload_sha256"],
                "json_file_sha256": hashlib.sha256(exact_bytes).hexdigest(),
            },
            sort_keys=True,
        )
    )


if __name__ == "__main__":
    main()
