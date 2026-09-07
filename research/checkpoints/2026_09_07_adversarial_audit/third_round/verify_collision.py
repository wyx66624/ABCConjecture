"""Independent finite exact replay; no complete large-boundary factorization."""
from itertools import product, combinations
from math import gcd, isqrt, lcm
from pathlib import Path
import hashlib
import json


def mul(z, w, modulus=None):
    a, b = z
    c, d = w
    pair = (a*c-b*d, a*d+b*c+b*d)
    return pair if modulus is None else tuple(x % modulus for x in pair)


def conjugate(z):
    a, b = z
    return (a+b, -b)


def norm(z):
    a, b = z
    return a*a+a*b+b*b


def boundary(z):
    a, b = z
    return a*b*(a+b)


def primitive(z):
    return gcd(*z) == 1


def power(z, exponent, modulus):
    result = (1, 0)
    while exponent:
        if exponent & 1:
            result = mul(result, z, modulus)
        z = mul(z, z, modulus)
        exponent //= 2
    return result


def factor(n):
    result = {}
    p = 2
    while p*p <= n:
        while n % p == 0:
            result[p] = result.get(p, 0)+1
            n //= p
        p += 1
    if n > 1:
        result[n] = 1
    return result


def main():
    pairs = list(product(range(-4, 5), repeat=2))
    prim = [z for z in pairs if primitive(z)]
    units = [(1, 0), (0, 1), (-1, 1), (-1, 0), (0, -1), (1, -1)]
    overlap_cases = 0
    for x in prim:
        for y in pairs:
            assert gcd(abs(boundary(x)), abs(boundary(mul(y, x)))) == \
                   gcd(abs(boundary(x)), abs(boundary(y)))
            overlap_cases += 1
    collision_cases = 0
    nonassociate_cases = 0
    linear_prime_power_bounds = 0
    roots = [(2, 1), (3, 1), (1, 5), (1, 1), (3, 5)]
    for H in roots:
        compatible = [v for v in prim if primitive(mul(v, H)) and boundary(mul(v, H))]
        for v1, v2 in combinations(compatible, 2):
            A1, A2 = abs(boundary(mul(v1, H))), abs(boundary(mul(v2, H)))
            cross = abs(boundary(mul(v2, conjugate(v1))))
            assert gcd(A1, A2) == gcd(A1, cross)
            associates = v2 in [mul(u, v1) for u in units]
            assert (cross == 0) == associates
            if not associates:
                assert gcd(A1, A2)**2 <= (norm(v1)*norm(v2))**3
                remainder = gcd(A1, A2)
                p = 2
                while p*p <= remainder:
                    prime_power = 1
                    while remainder % p == 0:
                        remainder //= p
                        prime_power *= p
                    if prime_power > 1:
                        assert 3*prime_power**2 <= 4*norm(v1)*norm(v2)
                        linear_prime_power_bounds += 1
                    p += 1
                if remainder > 1:
                    assert 3*remainder**2 <= 4*norm(v1)*norm(v2)
                    linear_prime_power_bounds += 1
                nonassociate_cases += 1
            collision_cases += 1
    owner_rows = []
    for k in range(1, 13):
        g = 2*5**k
        modulus = 5**(k+2)
        h = power((2, 1), g, modulus)
        A1 = boundary(h) % modulus
        A2 = boundary(mul((1, 5), h, modulus)) % modulus
        assert A1 % 5**(k+1) == 0 and A1 % 5**(k+2) != 0
        assert A2 % 5 == 0 and A2 % 25 != 0
        owner_rows.append({"k": k, "g": g, "v5_A1": k+1, "v5_A2": 1})
    lattice_rows = []
    for H in roots:
        for prime_powers in [(5,), (25,), (5, 11)]:
            assert all(gcd(norm(H), pe) == 1 for pe in prime_powers)
            q = 1
            for pe in prime_powers:
                q *= pe
            for arms in product(range(3), repeat=len(prime_powers)):
                count = 0
                for v in product(range(q), repeat=2):
                    a, b = mul(v, H)
                    values = (a, b, a+b)
                    if all(values[arm] % pe == 0 for arm, pe in zip(arms, prime_powers)):
                        count += 1
                # In (Z/q)^2 an index-q lattice has exactly q residues.
                assert count == q
                lattice_rows.append({"H": H, "prime_powers": prime_powers,
                                     "arms": arms, "q": q, "kernel_residues": count})
    gram_cases = 0
    for v, w in product(pairs, repeat=2):
        a, b = v
        c, d = w
        cross = 2*a*c+a*d+b*c+2*b*d
        det = a*d-b*c
        assert 4*norm(v)*norm(w)-cross**2 == 3*det**2
        gram_cases += 1
    packet_class_cases = 0
    for H in roots:
        for q, omega in [(25, 1), (55, 2)]:
            B = 12
            assert 3*q*q > 4*B*B
            small = [v for v in prim if norm(v) <= B and boundary(mul(v, H)) % q == 0]
            classes = {min(mul(u, v) for u in units) for v in small}
            assert len(small) == 6*len(classes)
            assert len(classes) <= 3**(omega-1)
            packet_class_cases += 1
    nonowner_lcm_cases = 0
    nonowner_residual_cases = 0
    for H in roots:
        for B in range(1, 21):
            residuals = sorted({min(mul(u, v) for u in units) for v in prim
                                if norm(v) <= B and primitive(mul(v, H))
                                and boundary(mul(v, H))})
            valuations = [factor(abs(boundary(mul(v, H)))) for v in residuals]
            primes = set().union(*(set(row) for row in valuations))
            owners = {p: max(range(len(residuals)), key=lambda i: valuations[i].get(p, 0))
                      for p in primes}
            threshold = isqrt(4*B*B//3)
            envelope = lcm(*range(1, threshold+1))
            for i, row in enumerate(valuations):
                nonowned = 1
                for p, exponent in row.items():
                    if owners[p] != i:
                        assert p**exponent <= threshold
                        nonowned *= p**exponent
                assert envelope % nonowned == 0
                nonowner_residual_cases += 1
            nonowner_lcm_cases += 1
    primitive_measure_rows = []
    for p, E, H in [(2, 3, (2, 1)), (3, 2, (2, 1)),
                    (5, 4, (2, 1)), (7, 2, (3, 1)), (11, 2, (2, 1))]:
        assert gcd(norm(H), p) == 1
        q = p**E
        total = 0
        counts = [0]*E
        for v in product(range(q), repeat=2):
            if v[0] % p == 0 and v[1] % p == 0:
                continue
            total += 1
            value = boundary(mul(v, H))
            for e in range(1, E+1):
                counts[e-1] += value % p**e == 0
        assert total == p**(2*E-2)*(p*p-1)
        for e, count in enumerate(counts, 1):
            assert count*p**(e-1)*(p+1) == 3*total
        primitive_measure_rows.append({"p": p, "cap": E, "H": H,
                                       "total": total, "depth_hit_counts": counts})
    results = {"status": "passed, finite exact checks only",
               "overlap_cases": overlap_cases,
               "collision_cases": collision_cases,
               "nonassociate_bound_cases": nonassociate_cases,
               "linear_prime_power_bounds": linear_prime_power_bounds,
               "owner_depth_rows": owner_rows,
               "lattice_index_cases": len(lattice_rows),
               "lattice_rows": lattice_rows,
               "gram_identity_cases": gram_cases,
               "specified_packet_unit_class_cases": packet_class_cases,
               "nonowner_lcm_family_cases": nonowner_lcm_cases,
               "nonowner_lcm_residual_cases": nonowner_residual_cases,
               "primitive_reference_measure_rows": primitive_measure_rows,
               "large_boundary_full_factorization_attempted": False}
    output = Path(__file__).parent / "verification" / "collision_results.json"
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_bytes((json.dumps(results, indent=2)+"\n").encode("utf-8"))
    print(json.dumps({"ok": True, "overlap_cases": overlap_cases,
                      "collision_cases": collision_cases,
                      "lattice_index_cases": len(lattice_rows),
                      "sha256": hashlib.sha256(output.read_bytes()).hexdigest()}))


if __name__ == "__main__":
    main()
