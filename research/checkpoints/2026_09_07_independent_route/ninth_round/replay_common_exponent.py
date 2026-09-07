"""Finite exact supplements for CE; does not find or certify a pure seed family."""
import argparse
from fractions import Fraction
from hashlib import sha256
from math import gcd
import json
from pathlib import Path


def factor(n):
    out = {}
    d = 2
    while d * d <= n:
        while n % d == 0:
            out[d] = out.get(d, 0) + 1
            n //= d
        d = 3 if d == 2 else d + 2
    if n > 1:
        out[n] = out.get(n, 0) + 1
    return out


def vp(n, p):
    e = 0
    while n % p == 0:
        e += 1
        n //= p
    return e


def quartic(a, b):
    return a**4 + 3*a**3*b + 5*a*a*b*b + 3*a*b**3 + b**4


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    rows = []
    for p in (3, 5, 7, 11):
        cap = 20 if p < 11 else 5
        for r in range(1, 5):
            for qbase in range(r*r+1, cap+1):
                if gcd(qbase, r) != 1:
                    continue
                d = qbase-r*r
                s = sum(qbase**(p-1-j) * r**(2*j) for j in range(p))
                assert d*s == qbase**p-r**(2*p)
                fs = factor(s)
                prod = 1
                bad_s = 1
                for prime, e in fs.items():
                    prod *= prime**e
                    assert gcd(qbase*r, prime) == 1
                    if prime == p:
                        assert e == 1 and d % p == 0
                    else:
                        t = qbase * pow(r*r, -1, prime) % prime
                        assert t != 1 and pow(t, p, prime) == 1
                        assert (prime-1) % p == 0
                    if prime % p != 1:
                        bad_s *= prime**e
                assert prod == s
                assert bad_s in (1, p)
                assert (p in fs) == (d % p == 0)
                assert vp(s, p) == int(d % p == 0)
                fd = factor(d)
                total_bad = 1
                for prime in fs.keys() | fd.keys():
                    if prime % p != 1:
                        total_bad *= prime**(fs.get(prime, 0)+fd.get(prime, 0))
                assert (p*d) % total_bad == 0
                rows.append(dict(p=p, R=r, Q=qbase, D=d, S=s,
                                 factor_S=sorted(fs.items()), full_bad_S=bad_s,
                                 full_bad_product=total_bad))

    seed_count = 0
    for a in range(1, 81):
        for b in range(1, 81):
            if gcd(a, b) != 1:
                continue
            c = a+b
            m = a*a+a*b+b*b
            f = quartic(a, b)
            assert f-m*m == a*b*c*c
            assert gcd(m, a*b*c) == gcd(m, f) == 1
            t = Fraction(a*b, c*c)
            assert 0 < t <= Fraction(1, 4)
            assert 4*(1-t)**2-9*t == (1-4*t)*(4-t)
            assert Fraction(a*b*c*c, m*m) <= Fraction(4, 9)
            assert 4*m*m-9*a*b*c*c == (a-b)**2*(4*a*a+7*a*b+4*b*b)
            seed_count += 1

    result = dict(
        scope='Finite exact CE supplements, not existence or nonexistence of simultaneous pure-power seeds.',
        arithmetic_rows=rows, arithmetic_count=len(rows),
        primitive_seed_identity_count=seed_count,
        primitive_seed_coordinate_range=[1, 80],
        pure_power_seed_existence_tested=False,
    )
    blob = (json.dumps(result, indent=2, sort_keys=True)+'\n').encode('utf-8')
    target = Path(__file__).with_name('common_exponent_results.json')
    if args.check:
        assert target.read_bytes() == blob
    else:
        target.write_bytes(blob)
    print(json.dumps(dict(status='PASS', sha256=sha256(blob).hexdigest(),
                          arithmetic_rows=len(rows), primitive_seed_identities=seed_count),
                     sort_keys=True))


if __name__ == '__main__':
    main()
