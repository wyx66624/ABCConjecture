"""Exact finite checks of the actual three-arm CRT construction.

Selected prime depths only: this deliberately does not factor every arm
or claim a signed-tail counterexample or simultaneous pure-power seed.
"""
import argparse
import json
from hashlib import sha256
from math import gcd
from pathlib import Path


def prime(q):
    if q < 2:
        return False
    d = 2
    while d*d <= q:
        if q % d == 0:
            return False
        d += 1
    return True


def divisors(n):
    return [d for d in range(1, n+1) if n % d == 0]


def pair_mul(u, v, modulus=None):
    a, b = u
    c, d = v
    value = (a*c-b*d, a*d+b*c+b*d)
    return value if modulus is None else tuple(x % modulus for x in value)


def pair_power(a, n, modulus=None):
    result = (1, 0)
    base = (a, 1)
    while n:
        if n % 2:
            result = pair_mul(result, base, modulus)
        base = pair_mul(base, base, modulus)
        n //= 2
    return result


def normalized(a, n, modulus=None):
    A, B = pair_power(a, n, modulus)
    value = (A, B) if n % 6 == 1 else (A+B, -B)
    return value if modulus is None else tuple(x % modulus for x in value)


def quotient_mod(a, n, i, modulus):
    A, B = normalized(a, n, modulus)
    numerator = (A, B, A+B)[i]
    denominator = (a, 1, a+1)[i]
    return numerator * pow(denominator, -1, modulus) % modulus


def valuation(value, q):
    assert value != 0
    value = abs(value)
    e = 0
    while value % q == 0:
        value //= q
        e += 1
    return e


def chosen_primes(n):
    out = []
    j = 1
    while len(out) < 3:
        q = 6*n*j+1
        if prime(q):
            out.append(q)
        j += 1
    return out


def order_element(q, n):
    N = 6*n
    for v in range(2, q):
        t = pow(v, (q-1)//N, q)
        if pow(t, N, q) == 1 and all(pow(t, d, q) != 1 for d in divisors(N)[:-1]):
            return t
    raise AssertionError('No exact order element in a certified prime field')


def crt(residues):
    r, modulus = 0, 1
    for b, m in residues:
        assert gcd(modulus, m) == 1
        r += modulus * ((b-r)*pow(modulus, -1, m) % m)
        modulus *= m
        assert 0 <= r < modulus
    return r, modulus


def build_row(n, depths):
    primes = chosen_primes(n)
    local = []
    residues = [(0, 3)]
    powers = (2, 6, 4) if n % 6 == 1 else (4, 6, 2)
    for i, (q, s) in enumerate(zip(primes, depths)):
        t = order_element(q, n)
        z = pow(t, n, q)
        assert (z*z-z+1) % q == 0 and z != (1-z) % q
        alpha = pow(t, powers[i], q)
        r = (alpha*(1-z)-z)*pow(1-alpha, -1, q) % q
        assert r not in (0, q-1)
        assert (r*r+r+1) % q != 0
        eta = pow(alpha, 3, q)
        assert pow(eta, n, q) == 1
        assert all(pow(eta, d, q) != 1 for d in divisors(n)[:-1])
        assert quotient_mod(r, n, i, q) == 0
        assert all(quotient_mod(r, n, j, q) != 0 for j in range(3) if j != i)
        # Exhaustively verify uniqueness of each selected Hensel lift.
        for e in range(1, s):
            lifts = [r+j*q**e for j in range(q)
                     if quotient_mod(r+j*q**e, n, i, q**(e+1)) == 0]
            assert len(lifts) == 1
            r = lifts[0]
        lifts = [r+j*q**s for j in range(q)]
        zeros = [x for x in lifts if quotient_mod(x, n, i, q**(s+1)) == 0]
        assert len(zeros) == 1
        r = next(x for x in lifts if x != zeros[0])
        assert quotient_mod(r, n, i, q**s) == 0
        assert quotient_mod(r, n, i, q**(s+1)) != 0
        local.append(dict(arm=i+1, q=q, depth=s, order_element=t,
                          residue=r, modulus=q**(s+1)))
        residues.append((r, q**(s+1)))
    r, modulus = crt(residues)
    examples = []
    for shift in (1, 2):
        a = r+shift*modulus
        assert a >= modulus and a % 3 == 0
        Q = a*a+a+1
        A, B = normalized(a, n)
        assert gcd(A, B) == 1 and A*B*(A+B) != 0
        assert A % a == 0 and (A+B) % (a+1) == 0
        D = (A//a, B, (A+B)//(a+1))
        assert all(gcd(D[i], D[j]) == 1 for i in range(3) for j in range(i))
        assert a*D[0]+D[1] == (a+1)*D[2]
        assert A*A+A*B+B*B == Q**n
        T = abs(A*B*(A+B))
        assert T == a*(a+1)*abs(D[0]*D[1]*D[2])
        for i, (q, s) in enumerate(zip(primes, depths)):
            assert a % local[i]['modulus'] == local[i]['residue']
            assert gcd(q, a*(a+1)*Q) == 1
            theta = pow(local[i]['order_element'], n, q)
            actual_ratio = (a+theta)*pow(a+1-theta, -1, q) % q
            actual_eta = pow(actual_ratio, 3, q)
            assert pow(actual_eta, n, q) == 1
            assert all(pow(actual_eta, d, q) != 1 for d in divisors(n)[:-1])
            assert valuation(D[i], q) == valuation(T, q) == s
            assert all(valuation(D[j], q) == 0 for j in range(3) if j != i)
            assert q**6 > n
        selected = 1
        for q, s in zip(primes, depths):
            selected *= q**(s-2)
        c = max(abs(A), abs(B), abs(A+B))
        assert selected < modulus <= a and a**n < c
        examples.append(dict(a=a, root_norm=Q, output_height=c,
                             quotient_arms=list(D), selected_excess_product=selected))
    return dict(n=n, depths=list(depths), local=local,
                crt_residue=r, crt_modulus=modulus, examples=examples)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    rows = [build_row(n, (4, 5, 6)) for n in (5, 7, 11, 25, 35)]
    result = dict(scope='Actual CRT roots and selected exact private depths; no full arm factorization or signed-tail counterexample.',
                  rows=rows, parameter_rows=len(rows), actual_roots=2*len(rows),
                  selected_depth_checks=6*len(rows),
                  simultaneous_second_pure_power_asserted=False)
    blob = (json.dumps(result, indent=2, sort_keys=True)+'\n').encode('utf-8')
    target = Path(__file__).with_name('three_arm_depth_results.json')
    if args.check:
        assert target.read_bytes() == blob
    else:
        target.write_bytes(blob)
    print(json.dumps(dict(status='PASS', sha256=sha256(blob).hexdigest(),
                          parameter_rows=len(rows), actual_roots=2*len(rows),
                          selected_depth_checks=6*len(rows)), sort_keys=True))


if __name__ == '__main__':
    main()
