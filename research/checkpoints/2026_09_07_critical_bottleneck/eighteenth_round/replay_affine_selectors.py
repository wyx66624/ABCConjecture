"""Exact finite checks for LM; no infinite sieve or power-family membership claim."""
from argparse import ArgumentParser
from fractions import Fraction
from hashlib import sha256
import json
from math import comb, gcd, prod
from pathlib import Path

BASE = Path(__file__).resolve().parent
DEST = BASE / "verification" / "affine_selector_exact.json"


def mul(z, w):
    a, b = z
    c, d = w
    return a*c-b*d, a*d+b*c+b*d


def power(z, n):
    r = (1, 0)
    while n:
        if n & 1:
            r = mul(r, z)
        z = mul(z, z)
        n //= 2
    return r


def norm(z):
    a, b = z
    return a*a+a*b+b*b


def boundary(z):
    a, b = z
    return a*b*(a+b)


def det(z, w):
    return z[0]*w[1]-z[1]*w[0]


def val(m, p):
    assert m
    m = abs(m)
    e = 0
    while m % p == 0:
        e += 1
        m //= p
    return e


def prime_divisors(n):
    n = abs(n)
    assert n
    ans = set()
    p = 2
    while p*p <= n:
        if n % p == 0:
            ans.add(p)
            while n % p == 0:
                n //= p
        p += 1
    if n > 1:
        ans.add(n)
    return ans


def primes_to(n):
    sieve = bytearray(b"\1")*(n+1)
    sieve[:2] = b"\0\0"
    for p in range(2, n+1):
        if sieve[p]:
            for a in range(p*p, n+1, p):
                sieve[a] = 0
    return [p for p in range(2, n+1) if sieve[p]]


def signed_packet(z, primes):
    return prod((Fraction(p)**(val(boundary(z), p)-3) for p in primes), start=Fraction(1))


def selector(k1, k2, p1, p2):
    z1, z2 = power((3*k1, 1), 2), power((3*k2, 1), 2)
    assert k1 > k2 and gcd(*z1) == gcd(*z2) == 1
    D = det(z1, z2)
    assert D
    e1, e2 = val(boundary(z1), p1), val(boundary(z2), p2)
    assert e1 > 0 and e2 > 0 and norm(z1) % p1 and norm(z2) % p2
    assert boundary(z2) % p1 and boundary(z1) % p2  # genuinely distinct owners
    m1, m2 = p1**(e1+1), p2**(e2+1)
    M = m1*m2
    t0 = m2*pow(m2, -1, m1) % M
    expected = Fraction(p1)**(e1-3)*Fraction(p2)**(e2-3)
    rows = []
    for j in range(-2, 3):
        t = t0+j*M
        U = tuple(t*a+(1-t)*b for a, b in zip(z1, z2))
        g = gcd(*U)
        V = tuple(a//g for a in U)
        assert g > 0 and D % g == 0 and gcd(g, M) == 1
        assert gcd(*V) == 1 and val(boundary(V), p1) == e1
        assert val(boundary(V), p2) == e2 and signed_packet(V, (p1, p2)) == expected
        assert abs(t) >= m2 and abs(1-t) >= m1
        # Squared, exact post-content Gram lower bounds; no floating logarithm.
        assert 4*norm(V)*norm(z2) >= 3*t*t
        assert 4*norm(V)*norm(z1) >= 3*(1-t)**2
        rows.append(dict(t=str(t), content=str(g), primitive=[str(x) for x in V]))
    return dict(k1=k1, k2=k2, z1=z1, z2=z2, delta=str(D),
                primes=[p1, p2], depths=[e1, e2], t0=str(t0), modulus=str(M),
                signed_packet=[str(expected.numerator), str(expected.denominator)], rows=rows)


def frozen_progression():
    z1, z2 = (80, 19), (35, 13)
    a0, b0 = z1[0]-z2[0], z1[1]-z2[1]
    m1, m2 = 19**2, 13**2
    M = m1*m2
    t0 = m2*pow(m2, -1, m1) % M
    E = set()
    for n in (6, M, det(z1, z2), a0, b0, a0+b0):
        E.update(prime_divisors(n))
    U0 = (z2[0]+t0*a0, z2[1]+t0*b0)
    assert min(U0) > 0
    F = {p: val(boundary(U0), p) for p in sorted(E)}
    H = prod(p**(F[p]+1) for p in E)
    g = gcd(*U0)
    assert H % M == H % g == 0
    constants = (U0[0]//g, U0[1]//g, sum(U0)//g)
    slopes = (H*a0//g, H*b0//g, H*(a0+b0)//g)
    depths = {p: F[p]-3*val(g, p) for p in E}
    assert all(f >= 0 for f in depths.values())
    for j in range(1, 257):
        U = (U0[0]+j*H*a0, U0[1]+j*H*b0)
        assert gcd(*U) == g
        V = tuple(x//g for x in U)
        assert min(V) > 0 and gcd(*V) == 1
        assert all(val(boundary(V), p) == f for p, f in depths.items())
    local = []
    for p in primes_to(997):
        if p in E:
            continue
        m = p*p
        assert all(s % p for s in slopes)
        roots = [(-a*pow(s, -1, m)) % m for a, s in zip(constants, slopes)]
        assert len({r % p for r in roots}) == 3
        for i, r in enumerate(roots):
            assert (constants[i]+slopes[i]*r) % m == 0
            assert all((constants[l]+slopes[l]*r) % p for l in range(3) if l != i)
        local.append([p, roots])
    return dict(exceptional_primes=sorted(E), raw_depths=F, primitive_depths=depths,
                t0=t0, H=str(H), content=g,
                fixed_primitive_progression_checks=256, local_prime_rows=local)


def kernel_rows():
    rows = []
    for n in (2, 5, 7, 11, 17, 331):
        B = max(n, n**4)
        s = [0, 0]
        for j in range(n+2):
            z = power((3*(B+j), 1), n)
            c = (-1)**j*comb(n+1, j)
            s[0] += c*z[0]
            s[1] += c*z[1]
            assert abs(c) <= 2**(n+1)
        assert s == [0, 0]
        rows.append(dict(n=n, B=B, roots=n+2, sum=s, nonzero_first_coefficient=1))
    return rows


def compute():
    examples = [
        selector(3, 2, 19, 13),
        # Both selected depths are positive excess, in an extended n=2 root block.
        selector(21720+2*19**5, 61882+13**6, 19, 13),
    ]
    assert examples[0]["depths"] == [1, 1]
    assert examples[1]["depths"] == [4, 5]
    return dict(status="PASS", examples=examples, frozen=frozen_progression(),
                kernels=kernel_rows(),
                scope="actual exact CRT depths, content, squared height and finite local roots; no infinite density or original US far-tail claim")


def main():
    ap = ArgumentParser()
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args()
    data = compute()
    raw = (json.dumps(data, sort_keys=True, indent=2)+"\n").encode()
    if args.check:
        assert DEST.read_bytes() == raw, "canonical result changed"
    else:
        DEST.parent.mkdir(parents=True, exist_ok=True)
        DEST.write_bytes(raw)
    print("PASS", sha256(raw).hexdigest(), "10 actual selectors; 256 fixed progression rows;",
          len(data["frozen"]["local_prime_rows"]), "local prime rows; 6 actual kernels")


if __name__ == "__main__":
    main()
