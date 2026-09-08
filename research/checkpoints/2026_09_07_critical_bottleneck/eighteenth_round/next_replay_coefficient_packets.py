"""Bounded exact checks for CG; no factorization or infinite claim.

The ordinary note proves the asymptotic counterexample and resultant theorem.
Here the original block, exact two-owner depths, literal polynomial content,
norms and two actual evaluations are independently constructed using integers.
"""
from argparse import ArgumentParser
from hashlib import sha256
from math import comb, gcd, isqrt
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
OUT = HERE / "next_coefficient_packet_exact.json"
UNITS = [(1, 0), (0, 1), (-1, 1), (-1, 0), (0, -1), (1, -1)]


def require(condition, text):
    if not condition:
        raise ValueError(text)


def mul(z, w):
    a, b = z
    c, d = w
    return a*c-b*d, a*d+b*c+b*d


def power(z, n):
    result = (1, 0)
    while n:
        if n & 1:
            result = mul(result, z)
        z, n = mul(z, z), n//2
    return result


def norm(z):
    a, b = z
    return a*a+a*b+b*b


def boundary(z):
    a, b = z
    return a*b*(a+b)


def valuation(x, p):
    require(x != 0, "zero valuation input")
    e = 0
    while x % p == 0:
        e, x = e+1, x//p
    return e


def convolution(a, b):
    c = [0]*(len(a)+len(b)-1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            c[i+j] += x*y
    return c


def evaluate(a, x):
    y = 0
    for c in reversed(a):
        y = y*x+c
    return y


def literal_polynomial(n):
    a, b = [0]*(n+1), [0]*(n+1)
    for j in range(n+1):
        u, v = UNITS[j % 6]
        coefficient = comb(n, j)*3**(n-j)
        a[n-j], b[n-j] = coefficient*u, coefficient*v
    t = convolution(convolution(a, b), [x+y for x, y in zip(a, b)])
    while t[-1] == 0:
        t.pop()
    content = 0
    for c in t:
        content = gcd(content, c)
    require(content == 3, "literal polynomial content is not 3")
    require(len(t)-1 == 3*n-1 and t[0] == 0 and t[1] == 3*n,
            "literal degree or linear coefficient is wrong")
    f = [c//3 for c in t]
    require(sum(map(abs, f)) <= 64**n//3, "coefficient l1 bound failed")
    return f


def row(n):
    require(n > 324 and all(n % d for d in range(2, isqrt(n)+1)),
            "index is not an original-domain prime")
    block = n**4
    modulus = 3125*n
    residue = 625+3125*((1-625)*pow(3125, -1, n) % n)
    k1 = block+(residue-block) % modulus
    require(block <= k1 < 2*block and k1 != block, "owner left the block")
    require(k1 % 3125 == 625 and k1 % n == 1, "owner CRT failed")
    f = literal_polynomial(n)
    values = []
    depth_rows = []
    for k in [block, k1]:
        z = power((3*k, 1), n)
        t = boundary(z)
        require(z[0] > 0 and z[1] > 0 and gcd(*z) == 1,
                "actual power is not positive primitive")
        require(norm(z) == norm((3*k, 1))**n, "actual power norm failed")
        require(evaluate(f, k)*3 == t, "polynomial and power evaluations differ")
        values.append(t//3)
        depth_rows.append({str(p): valuation(t, p) for p in [3, 5, n]})
    require(depth_rows[0] == {"3": 1, "5": 0, str(n): 5}, "first depth row failed")
    require(depth_rows[1]["5"] == 4 and depth_rows[1][str(n)] == 0,
            "second owner depths failed")
    m = 625*values[0]
    require(gcd(values[0], 15) == 1 and values[1] % 625 == 0,
            "actual packet moduli failed")
    # The monic G=(X-B)(X-k1) is coprime to F because both values are positive.
    # Its exact resultant is their product, including all packet moduli.
    resultant = values[0]*values[1]
    require(resultant % m == 0, "two-owner resultant is not divisible by packet")
    require(12*m > 625*(3*block)**(2*n), "ordinary lower bound failed")
    require(m > (64**n)**10, "fixed exponent ten comparison failed")
    return {"prime_index": n, "B": block, "k1": k1,
            "polynomial_degree": len(f)-1, "content_before_dividing": 3,
            "coefficient_l1_bits": sum(map(abs, f)).bit_length(),
            "packet_modulus_bits": m.bit_length(),
            "actual_depths_at_3_5_n": depth_rows,
            "norm_units_at_positive_labels": [
                norm((3*block, 1)) % n, norm((3*k1, 1)) % 5],
            "coefficient_eval_and_actual_power_equal": True,
            "automatic_owner_resultant_divisible_by_M": True,
            "M_greater_than_64_to_10n": True}


def compute():
    return {"status": "PASS", "rows": [row(n) for n in [331, 337, 347]],
            "scope": "three actual original-domain indices; complete integer coordinates and polynomial coefficients, exact selected depths, CRT, and automatic resultant; no full factorization, far signed sum, density, or Lean claim"}


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    data = (json.dumps(compute(), sort_keys=True, indent=2)+"\n").encode()
    if args.check:
        require(OUT.read_bytes() == data, "canonical finite certificate differs")
    else:
        OUT.write_bytes(data)
    print("PASS CG three original prime indices; six actual powers; SHA256", sha256(data).hexdigest())
