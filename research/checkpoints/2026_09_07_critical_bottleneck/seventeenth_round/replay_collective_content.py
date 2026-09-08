"""Exact finite replay of CC incidence/content; not an asymptotic certificate."""
from __future__ import annotations
import argparse
import hashlib
import itertools
import json
from math import gcd, isqrt
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE / 'verification' / 'collective_content_exact.json'


def primes_to(n):
    a = bytearray(b'\x01') * (n + 1)
    a[:2] = b'\x00\x00'
    for p in range(2, isqrt(n) + 1):
        if a[p]:
            a[p*p:n+1:p] = b'\x00' * ((n-p*p)//p+1)
    return [p for p in range(2, n+1) if a[p]]


def mul(z, w):
    a, b = z
    c, d = w
    return a*c-b*d, a*d+b*c+b*d


def norm(z):
    a, b = z
    return a*a+a*b+b*b


def conjugate(z):
    return z[0]+z[1], -z[1]


def content(z):
    return gcd(abs(z[0]), abs(z[1]))


def int_hash(n):
    return hashlib.sha256(hex(n).encode()).hexdigest()


def run():
    blocks = list(range(2, 65)) + [81, 96, 128, 192, 256, 512, 1024]
    primes = primes_to(6*max(blocks))
    factor_cache = {}

    def factors(k):
        if k in factor_cache:
            return factor_cache[k]
        a = 3*k
        original = a*a+a+1
        q, f = original, {}
        for p in primes:
            if p*p > q:
                break
            e = 0
            while q % p == 0:
                e += 1
                q //= p
            if e:
                f[p] = e
        if q > 1:
            f[q] = f.get(q, 0)+1
        rebuilt = 1
        for p, e in f.items():
            assert p % 3 == 1 and p >= 7
            rebuilt *= p**e
        assert rebuilt == original
        # Distinguish the two roots a and -a-1 modulo p consistently.
        oriented = {p: (e if a % p < (-a-1) % p else -e)
                    for p, e in f.items()}
        assert all((a % p) != ((-a-1) % p) for p in f)
        factor_cache[k] = oriented
        return oriented

    def actual(exponents):
        z = (1, 0)
        U, D = {}, {}
        for k, x in exponents.items():
            w = (3*k, 1)
            if x < 0:
                w = conjugate(w)
            for _ in range(abs(x)):
                z = mul(z, w)
            for p, d in factors(k).items():
                U[p] = U.get(p, 0) + abs(x)*abs(d)
                D[p] = D.get(p, 0) + x*d
        c = content(z)
        predicted_c, predicted_primitive_norm = 1, 1
        rows = []
        for p in sorted(U):
            twice = U[p]-abs(D[p])
            assert twice >= 0 and twice % 2 == 0
            predicted_c *= p**(twice//2)
            predicted_primitive_norm *= p**abs(D[p])
            rows.append([p, U[p], D[p], twice//2])
        assert c == predicted_c
        primitive = (z[0]//c, z[1]//c)
        assert content(primitive) == 1
        assert norm(primitive) == predicted_primitive_norm
        assert norm(z) == c*c*norm(primitive)
        return z, c, rows

    block_rows = []
    interval_checks = deletion_checks = 0
    for B in blocks:
        indices = list(range(B, 2*B))
        z, c, rows = actual(dict.fromkeys(indices, 1))
        assert all(p <= 12*B-5 for p, _, _, e in rows if e)
        for lo, hi in [(B, B), (B, B+B//2),
                       (B+B//3, B+2*B//3), (B+B//2, 2*B)]:
            zi, ci, ir = actual(dict.fromkeys(range(lo, hi), 1))
            assert all(p <= 12*B-5 for p, _, _, e in ir if e)
            interval_checks += 1
        # All partitions are of actual distinct roots; F is the complement.
        for J in [indices[::2], indices[:B//3], [], indices]:
            chosen = set(J)
            F = [k for k in indices if k not in chosen]
            zj, cj, _ = actual(dict.fromkeys(J, 1))
            zf, cf, _ = actual(dict.fromkeys(F, 1))
            assert mul(zj, zf) == z
            nf = norm(zf)
            assert nf % cf == 0
            assert (cj*(nf//cf)) % c == 0
            deletion_checks += 1
        block_rows.append(dict(B=B, actual_root_count=B,
                               content_hash=int_hash(c),
                               coordinate_hashes=[int_hash(v) for v in z],
                               content_binary_length=c.bit_length(),
                               primitive_norm_binary_length=(norm(z)//(c*c)).bit_length(),
                               full_oriented_rows=rows))

    signed_checks = 0
    for B in [2, 3, 5, 7, 11, 17, 31]:
        indices = list(range(B, min(2*B, B+4)))
        for xs in itertools.product(range(-2, 3), repeat=len(indices)):
            z, c, rows = actual(dict(zip(indices, xs)))
            assert all(p <= 12*B-5 for p, _, _, e in rows if e)
            signed_checks += 1

    return dict(schema=1, scope='exact finite content, orientation and deletion only; no PNT/asymptotic/signed-tail certificate',
                counts=dict(blocks=len(blocks), full_root_occurrences=sum(blocks),
                            distinct_norm_factorizations=len(factor_cache),
                            interval_checks=interval_checks,
                            deletion_checks=deletion_checks,
                            signed_vector_checks=signed_checks),
                blocks=block_rows)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    result = run()
    raw = (json.dumps(result, indent=2, sort_keys=True) + '\n').encode()
    if args.check:
        assert OUT.read_bytes() == raw, 'canonical finite evidence mismatch'
    else:
        OUT.parent.mkdir(parents=True, exist_ok=True)
        OUT.write_bytes(raw)
    print('PASS', json.dumps(result['counts'], sort_keys=True), hashlib.sha256(raw).hexdigest())


if __name__ == '__main__':
    main()
