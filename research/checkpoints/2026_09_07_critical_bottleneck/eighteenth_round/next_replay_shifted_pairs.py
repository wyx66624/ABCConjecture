"""Exact finite original-block examples for SR4; not a resultant proof."""
from argparse import ArgumentParser
from hashlib import sha256
from math import gcd, isqrt
from pathlib import Path
import json

HERE = Path(__file__).resolve().parent
OUT = HERE / "next_shifted_pairs_exact.json"


def require(test, message):
    if not test:
        raise ValueError(message)


def multiply(z, w):
    a, b = z
    c, d = w
    return a*c-b*d, a*d+b*c+b*d


def power(z, exponent):
    value = (1, 0)
    while exponent:
        if exponent & 1:
            value = multiply(value, z)
        z = multiply(z, z)
        exponent >>= 1
    return value


def valuation(value, p):
    require(value != 0, "finite valuation requires a nonzero integer")
    result = 0
    while value % p == 0:
        value //= p
        result += 1
    return result


def owner(B, q, depth, other):
    modulus = q**(depth+1)
    residue = q**depth
    residue += modulus*((1-residue)*pow(modulus, -1, other) % other)
    step = modulus*other
    return residue + ((B-residue+step-1)//step)*step, step


def compute():
    packet = 7**4*13**5
    shift = (packet-1)//3
    require(packet == 891474493 and shift == 297158164, "exact shift")
    rows = []
    for n in (331, 337, 347):
        require(all(n % p for p in range(2, isqrt(n)+1)), "small prime index")
        B = n**4
        cases = []
        for q, depth, other in ((7, 4, 13), (13, 5, 7)):
            start, step = owner(B, q, depth, other)
            require(step == (218491 if q == 7 else 33787663), "CRT step")
            require(start % q**(depth+1) == q**depth, "exact root residue")
            require(start % other == 1, "other-prime exclusion residue")
            for k in (start, start+shift):
                require(B <= k < 2*B, "actual original-block membership")
                a, c = power((3*k, 1), n)
                total = a+c
                boundary = a*c*total
                root_norm = 9*k*k+3*k+1
                require(min(a, c, total) > 0, "all positive actual arms")
                require(gcd(a, c) == gcd(a, total) == gcd(c, total) == 1,
                        "actual pairwise coprimality")
                require(a*a+a*c+c*c == root_norm**n, "literal norm identity")
                require(valuation(boundary, q) == depth, "full marked depth")
                require(boundary % other != 0, "complete other-prime exclusion")
                require(root_norm % q != 0, "actual marked root-norm unit")
                cases.append({"prime": q, "depth": depth, "owner": k,
                              "other_prime": other, "other_depth": 0,
                              "arm_bit_lengths": [a.bit_length(), c.bit_length(),
                                                  total.bit_length()],
                              "boundary_bit_length": boundary.bit_length()})
        require(len({row["owner"] for row in cases}) == 4, "four distinct owners")
        rows.append({"n": n, "B": B, "actual_roots": cases})
    return {
        "schema": "shifted-original-pairs-v1",
        "shift": shift,
        "selected_common_packet": packet,
        "selected_positive_excess_product": 7*13**2,
        "cases": rows,
        "actual_power_count": sum(len(row["actual_roots"]) for row in rows),
        "scope": "Twelve literal original-block powers, full prescribed depths, "
                 "other-prime absence, positivity and gcd/norm identities. "
                 "No factorization of remaining primes, resultant computation, "
                 "infinite Galois theorem or full signed tail is certified here."
    }


def main():
    parser = ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--write", action="store_true")
    group.add_argument("--check", action="store_true")
    args = parser.parse_args()
    payload = (json.dumps(compute(), indent=2, sort_keys=True)+"\n").encode()
    if args.write:
        OUT.write_bytes(payload)
    else:
        require(OUT.read_bytes() == payload, "canonical result mismatch")
    print("PASS: 12 actual powers / exact paired depths; SHA256 "
          + sha256(payload).hexdigest())


if __name__ == "__main__":
    main()
