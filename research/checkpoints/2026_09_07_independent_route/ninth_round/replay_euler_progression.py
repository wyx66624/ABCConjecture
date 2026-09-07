"""Finite exact EP supplements; no simultaneous-pure-power existence test."""
import argparse
from hashlib import sha256
from math import gcd
import json
from pathlib import Path
from replay_common_exponent import factor


def divisors(n):
    return [d for d in range(1, n+1) if n % d == 0]


def phi(n):
    return sum(gcd(j, n) == 1 for j in range(1, n+1))


def cyclotomic_value(n, x, y):
    vals = {}
    for m in divisors(n):
        v = x**m-y**m
        for d in divisors(m)[:-1]:
            assert v % vals[d] == 0
            v //= vals[d]
        assert v > 0
        vals[m] = v
    return vals[n]


def value_at_one(n):
    vals = {}
    for m in divisors(n)[1:]:
        v = m
        for d in divisors(m)[1:-1]:
            assert v % vals[d] == 0
            v //= vals[d]
        vals[m] = v
    return vals[n]


def valuation(n, p):
    e = 0
    while n % p == 0:
        e += 1
        n //= p
    return e


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    rows = []
    for n in (5, 7, 11, 13, 25, 35):
        bases = [(2, 1)] if n > 13 else [(2, 1), (3, 1), (3, 2)]
        for x, y in bases:
            v = cyclotomic_value(n, x, y)
            fv = factor(v)
            fn = factor(n)
            pmax = max(fn)
            lval = value_at_one(n)
            assert lval == (pmax if len(fn) == 1 else 1)
            assert v >= lval*y**phi(n)
            bad = 1
            for q, e in fv.items():
                assert gcd(q, x*y) == 1
                if q % n != 1:
                    assert q == pmax and e == 1
                    bad *= q**e
                else:
                    t = x*pow(y, -1, q) % q
                    assert pow(t, n, q) == 1
                    assert all(pow(t, d, q) != 1 for d in divisors(n)[:-1])
            assert pmax % bad == 0
            rows.append(dict(n=n, X=x, Y=y, phi=phi(n), top_factor=v,
                             factorization=sorted(fv.items()), value_at_one=lval,
                             largest_prime=pmax, full_bad_part=bad))

    # Exact depth-one bad-prime examples beyond the fully factored range.
    exceptions = []
    for n, x, y, q, expected in (
            (55, 3, 1, 11, 1), (605, 3, 1, 11, 1),
            (275, 3, 1, 11, 0), (35, 2, 1, 7, 0)):
        v = cyclotomic_value(n, x, y)
        exponent = valuation(v, q)
        assert exponent == expected
        exceptions.append(dict(n=n, X=x, Y=y, q=q, valuation=exponent))

    result = dict(
        scope='Finite exact cyclotomic supplements; not an actual simultaneous-pure-power family.',
        completely_factored_rows=rows,
        exact_exception_valuations=exceptions,
        pure_power_seed_existence_tested=False,
    )
    blob = (json.dumps(result, indent=2, sort_keys=True)+'\n').encode('utf-8')
    target = Path(__file__).with_name('euler_progression_results.json')
    if args.check:
        assert target.read_bytes() == blob
    else:
        target.write_bytes(blob)
    print(json.dumps(dict(status='PASS', factored_rows=len(rows),
                          exceptional_rows=len(exceptions), sha256=sha256(blob).hexdigest()),
                     sort_keys=True))


if __name__ == '__main__':
    main()
