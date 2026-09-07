"""Exact actual cyclotomic/rank checks, with a finite retained prime set."""
from __future__ import annotations

import argparse
from fractions import Fraction
from hashlib import sha256
from json import dumps, loads
from math import gcd, isqrt, prod
from pathlib import Path


def mul(x, y):
    a, b = x
    c, d = y
    return a*c-b*d, a*d+b*c+b*d


def conjugate(x):
    a, b = x
    return a+b, -b


def power(x, n, modulus=None):
    out = (1, 0)
    while n:
        if n & 1:
            out = mul(out, x)
            if modulus:
                out = tuple(c % modulus for c in out)
        x = mul(x, x)
        if modulus:
            x = tuple(c % modulus for c in x)
        n //= 2
    return out


def norm(x):
    a, b = x
    return a*a+a*b+b*b


def boundary(x):
    a, b = x
    return a*b*(a+b)


def valuation(n, p):
    assert n
    e = 0
    while n % p == 0:
        n //= p
        e += 1
    return e


def divisors(n):
    return [d for d in range(1, n+1) if n % d == 0]


def exact_poly_division(numerator, denominator):
    assert denominator[-1] == 1
    out = [0]*(len(numerator)-len(denominator)+1)
    rem = numerator[:]
    for degree in range(len(out)-1, -1, -1):
        coefficient = rem[degree+len(denominator)-1]
        out[degree] = coefficient
        for j, entry in enumerate(denominator):
            rem[degree+j] -= coefficient*entry
    assert not any(rem)
    return out


def cyclotomic_polynomials(maximum):
    values = {}
    for n in range(1, maximum+1):
        poly = [-1]+[0]*(n-1)+[1]
        for d in divisors(n)[:-1]:
            poly = exact_poly_division(poly, values[d])
        values[n] = poly
        degree = sum(gcd(j, n) == 1 for j in range(1, n+1))
        assert len(poly)-1 == degree
        if n > 1:
            assert poly == poly[::-1]
    return values


def evaluate_homogeneous(poly, x, y):
    degree = len(poly)-1
    out = [0, 0]
    for j, coefficient in enumerate(poly):
        term = mul(power(x, j), power(y, degree-j))
        out = [out[k]+coefficient*term[k] for k in range(2)]
    return tuple(out)


def primes_through(maximum):
    return [p for p in range(2, maximum+1)
            if all(p % q for q in range(2, isqrt(p)+1))]


def run():
    maximum_index = 30
    polynomials = cyclotomic_polynomials(maximum_index)
    primes = primes_through(499)
    rows = []
    for w in [(2, 1), (3, 1), (3, 2), (5, 1), (4, 3), (5, -2)]:
        q = norm(w)
        assert gcd(*w) == 1 and q >= 7 and q % 3
        eta = power(w, 3)
        eta_bar = conjugate(eta)
        assert (eta[0]-eta_bar[0], eta[1]-eta_bar[1]) == (
            -3*boundary(w), 6*boundary(w))
        factors = {1: boundary(w)}
        for d in range(2, maximum_index+1):
            value = evaluate_homogeneous(polynomials[d], eta, eta_bar)
            assert value[1] == 0 and value[0]
            factors[d] = value[0]
            phi = len(polynomials[d])-1
            assert value[0]**2 <= 4**phi*q**(3*phi)
        assert factors[1]**2 <= q**3
        for n in range(1, maximum_index+1):
            assert prod(factors[d] for d in divisors(n)) == boundary(power(w, n))
            assert sum(len(polynomials[d])-1 for d in divisors(n)) == n

        ranks = {}
        tested_valuations = 0
        for p in primes:
            if p <= 3 or q % p == 0:
                continue
            # (w/barw)^3=w^6/Q^3 in the quadratic algebra modulo p.
            inverse_q3 = pow(pow(q, 3, p), -1, p)
            alpha = tuple(c*inverse_q3 % p for c in power(w, 6, p))
            chi = 1 if p % 3 == 1 else -1
            current = (1, 0)
            rank = None
            for d in range(1, p-chi+1):
                current = tuple(c % p for c in mul(current, alpha))
                if current == (1, 0):
                    rank = d
                    break
            assert rank and (p-chi) % rank == 0 and rank % p
            first_depth = valuation(boundary(power(w, rank)), p)
            assert first_depth >= 1
            ranks[p] = (rank, first_depth)
            for n, value in factors.items():
                expected = 0
                if n == rank:
                    expected = first_depth
                elif n % rank == 0:
                    quotient = n // rank
                    while quotient > 1 and quotient % p == 0:
                        quotient //= p
                    if quotient == 1:
                        expected = 1
                assert valuation(value, p) == expected
                tested_valuations += 1

        packet_rows = 0
        for cutoff in (5, 11, 23):
            packet_full = {d: 1 for d in factors}
            packet_signed = {d: Fraction(1) for d in factors}
            for p, (rank, first_depth) in ranks.items():
                if p > cutoff and rank <= maximum_index:
                    packet_full[rank] *= p**first_depth
                    packet_signed[rank] *= Fraction(p)**(first_depth-3)
            for d in factors:
                assert abs(factors[d]) % packet_full[d] == 0
            for n in range(1, maximum_index+1):
                signed_value = Fraction(1)
                lifting = 1
                actual_boundary = boundary(power(w, n))
                for p in ranks:
                    if p <= cutoff or actual_boundary % p:
                        continue
                    signed_value *= Fraction(p)**(valuation(actual_boundary, p)-3)
                    lifting *= p**valuation(n, p)
                assembled = prod(packet_signed[d] for d in divisors(n))*lifting
                assert assembled == signed_value and n % lifting == 0
                packet_rows += 1
        rows.append(dict(w=list(w), norm=q,
                         integer_factors=[factors[d] for d in factors],
                         tested_rank_primes=len(ranks),
                         tested_cyclotomic_valuations=tested_valuations,
                         exact_retained_packet_rows=packet_rows))
    return dict(scope="Actual cyclotomic and finite-prime rank identities; not full-tail verification",
                maximum_index=maximum_index, retained_prime_bound=499,
                cutoff_rows=[5, 11, 23], roots=rows)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    payload = run()
    canonical = dumps(payload, sort_keys=True, separators=(",", ":"))
    result = dict(payload=payload, canonical_sha256=sha256(canonical.encode()).hexdigest())
    path = Path(__file__).with_name("finite_replay.json")
    if args.check:
        assert loads(path.read_text(encoding="utf-8")) == result
    else:
        path.write_bytes((dumps(result, sort_keys=True, indent=2)+"\n").encode("utf-8"))
    print(dumps(dict(status="PASS", canonical_sha256=result["canonical_sha256"],
                     actual_roots=len(payload["roots"]),
                     actual_factorizations=len(payload["roots"])*payload["maximum_index"],
                     exact_valuation_checks=sum(r["tested_cyclotomic_valuations"] for r in payload["roots"]),
                     retained_packet_rows=sum(r["exact_retained_packet_rows"] for r in payload["roots"])),
                sort_keys=True))


if __name__ == "__main__":
    main()
