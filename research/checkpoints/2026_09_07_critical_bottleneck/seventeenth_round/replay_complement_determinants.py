"""Exact finite replay of CD, including actual large-prime-index powers."""
from __future__ import annotations
import argparse
import hashlib
import json
from math import gcd
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE / 'verification' / 'complement_determinants_exact.json'


def mul(z, w):
    a, b = z
    c, d = w
    return a*c-b*d, a*d+b*c+b*d


def power(z, n):
    out = (1, 0)
    while n:
        if n & 1:
            out = mul(out, z)
        z = mul(z, z)
        n //= 2
    return out


def norm(z):
    a, b = z
    return a*a+a*b+b*b


def cont(z):
    return gcd(abs(z[0]), abs(z[1]))


def rotate(z):
    return -z[1], z[0]+z[1]


def det(z, w):
    return z[0]*w[1]-z[1]*w[0]


def check(W, V):
    assert cont(W) == 1 and V != (0, 0)
    Z = mul(V, W)
    c, d = cont(Z), cont(V)
    U, V0 = tuple(a//c for a in Z), tuple(a//d for a in V)
    assert cont(U) == cont(V0) == 1
    x = det(U, V0)
    D = det(U, rotate(V0))
    y = det(U, rotate(rotate(V0)))
    nv = norm(V)
    assert nv % (c*d) == 0
    r = nv//(c*d)
    a, b = W
    assert r > 0 and (x, D, y) == (-r*b, r*a, r*(a+b))
    assert gcd(gcd(abs(x), abs(D)), abs(y)) == r
    assert x+y == D
    assert (x//r, D//r, y//r) == (-b, a, a+b)
    assert abs((x//r)*(D//r)*(y//r)) == abs(a*b*(a+b))
    return c, d, r


def run():
    bound = 8
    small_count = zero_arm_count = 0
    for a in range(-bound, bound+1):
        for b in range(-bound, bound+1):
            if gcd(abs(a), abs(b)) != 1:
                continue
            for v0 in range(-bound, bound+1):
                for v1 in range(-bound, bound+1):
                    if v0 == v1 == 0:
                        continue
                    check((a, b), (v0, v1))
                    small_count += 1
                    zero_arm_count += (a*b*(a+b) == 0)
    actual_rows = []
    for n in [331, 337, 347]:
        B = n**4
        roots = [power((3*(B+j), 1), n) for j in range(3)]
        for j, W in enumerate(roots):
            V = (1, 0)
            for h, R in enumerate(roots):
                if h != j:
                    V = mul(V, R)
            c, d, r = check(W, V)
            actual_rows.append(dict(n=n, B=B, owner_index=B+j,
                                    whole_content_sha256=hashlib.sha256(hex(c).encode()).hexdigest(),
                                    complement_content_sha256=hashlib.sha256(hex(d).encode()).hexdigest(),
                                    determinant_gcd_sha256=hashlib.sha256(hex(r).encode()).hexdigest()))
    return dict(schema=1, scope='exact finite CD identities; no all-prime signed bound',
                counts=dict(small_pairs=small_count, zero_arm_pairs=zero_arm_count,
                            actual_prime_index_complements=len(actual_rows)),
                small_coordinate_bound=bound, actual_rows=actual_rows)


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--check', action='store_true')
    args = p.parse_args()
    result = run()
    raw = (json.dumps(result, sort_keys=True, indent=2)+'\n').encode()
    if args.check:
        assert OUT.read_bytes() == raw, 'canonical mismatch'
    else:
        OUT.parent.mkdir(parents=True, exist_ok=True)
        OUT.write_bytes(raw)
    print('PASS', json.dumps(result['counts'], sort_keys=True), hashlib.sha256(raw).hexdigest())


if __name__ == '__main__':
    main()
