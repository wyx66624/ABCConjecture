"""Exact replay for the next two-step compatibility note.

No external packages are required. The twelve displayed factorizations are
checked by multiplication and deterministic trial-division primality proofs.
The Hensel experiment proves only the indicated local divisibilities; its
unfactored second norms are never classified as compressed.
"""

from functools import lru_cache
from math import gcd, isqrt, prod
from pathlib import Path
import json


def mul(z, w, modulus=None):
    a, b = z
    c, d = w
    result = (a * c - b * d, a * d + b * c + b * d)
    return result if modulus is None else tuple(v % modulus for v in result)


def power(n, modulus=None):
    result, base = (1, 0), (2, 1)
    while n:
        if n & 1:
            result = mul(result, base, modulus)
        base = mul(base, base, modulus)
        n //= 2
    return result


def norm(z):
    a, b = z
    return a * a + a * b + b * b


def quartic(z):
    a, b = z
    return a**4 + 3 * a**3 * b + 5 * a * a * b * b + 3 * a * b**3 + b**4


def direction_data(p, period, exponent):
    step = power(period, p * p)
    assert step[0] % p == 1 and step[1] % p == 0
    delta = ((step[0] - 1) // p, step[1] // p)
    a, b = power(exponent, p)
    tangent = mul((a, b), delta, p)
    gradient = (4*a**3 + 9*a*a*b + 10*a*b*b + 3*b**3,
                3*a**3 + 10*a*a*b + 9*a*b*b + 4*b**3)
    derivative = sum(x*y for x, y in zip(gradient, tangent)) % p
    assert derivative != 0 and quartic((a, b)) % p == 0
    return delta, (a, b), derivative


def lift_index(p, period, exponent, depth, derivative):
    modulus = p ** (depth + 1)
    residue = quartic(power(exponent, modulus)) % modulus
    assert residue % p**depth == 0
    digit = residue // p**depth
    correction = (-digit * pow(derivative, -1, p)) % p
    answer = exponent + period * p ** (depth - 1) * correction
    assert quartic(power(answer, modulus)) % modulus == 0
    return answer


def compatible_crt(a, m, b, n):
    common = gcd(m, n)
    assert (b-a) % common == 0
    multiplier = ((b-a)//common * pow(m//common, -1, n//common)) % (n//common)
    modulus = m * (n//common)
    answer = (a+m*multiplier) % modulus
    assert answer % m == a % m and answer % n == b % n
    return answer, modulus


@lru_cache(None)
def prime_by_trial_division(p):
    if p < 2:
        return False
    if p % 2 == 0:
        return p == 2
    return all(p % d for d in range(3, isqrt(p) + 1, 2))


FACTORS = [
    [67],
    [3361],
    [124147],
    [7652401],
    [8779, 45817],
    [13, 1183856677],
    [967, 898639891],
    [47820544913761],
    [1171, 1624875577777],
    [13, 777181, 9715493617],
    [10333, 65881, 8295929329],
    [3121, 885169, 84834483889],
]


def main():
    rows = []
    for exponent, factors in enumerate(FACTORS, 1):
        a, b = power(exponent)
        rotation = 0
        while not (a > 0 and b > 0):
            a, b = -b, a + b
            rotation += 1
            assert rotation <= 5
        c = a + b
        m0, m1 = norm((a, b)), quartic((a, b))
        assert gcd(a, b) == 1 and m0 == 7**exponent
        assert m1 == c**4 - a * b * c * c + (a * b) ** 2
        assert gcd(m1, a * b * c * m0) == 1
        assert len(set(factors)) == len(factors)
        assert all(prime_by_trial_division(p) for p in factors)
        assert prod(factors) == m1
        rows.append(dict(g=exponent, rotation=rotation, a=str(a), b=str(b),
                         M0=str(m0), M1=str(m1),
                         complete_prime_factors=[str(p) for p in factors],
                         squarefree=True, second_content=1,
                         any_second_compression_lambda_at_least=1))

    # Complete residue checks supporting the elementary polynomial proofs.
    roots13 = [x for x in range(13) if quartic((x, 1)) % 13 == 0]
    assert roots13 == [1]
    assert all((x * x + 5 * x + 1) % 13 for x in range(13))
    for b in range(169):
        if b % 13:
            for u in range(13):
                a = (b + 13 * u) % 169
                assert quartic((a, b)) % 169 == 13 * b**4 % 169 != 0
    assert all(quartic((a, b)) % 3 == 1
               for a in range(3) for b in range(3) if a or b)

    # The fixed residue class that yields the strict 13-adic obstruction.
    assert power(12, 13) == (1, 0)
    assert power(10, 13) == (6, 6)

    # Positive local construction: arbitrary-depth second-norm 67-adic contact.
    p = 67
    first_step = power(66, p * p)
    assert first_step == (3954, 1541)
    delta = ((first_step[0] - 1) // p, first_step[1] // p)
    assert delta == (59, 23)
    tangent = mul((2, 1), delta, p)
    derivative = (91 * tangent[0] + 86 * tangent[1]) % p
    assert derivative == 22
    index = 1
    lift_rows = []
    for depth in range(1, 9):
        modulus = p ** (depth + 1)
        residue = quartic(power(index, modulus)) % modulus
        assert residue % p**depth == 0
        next_digit = residue // p**depth
        correction = (-next_digit * pow(derivative, -1, p)) % p
        lifted = index + 66 * p ** (depth - 1) * correction
        assert quartic(power(lifted, modulus)) % modulus == 0
        lift_rows.append(dict(depth=depth, exponent_class=str(index),
                              class_modulus=str(66 * p ** (depth - 1)),
                              next_digit=next_digit, correction=correction,
                              next_exponent_class=str(lifted),
                              claim="local divisibility only; full factorization not asserted"))
        index = lifted
    assert lift_rows[0]["next_exponent_class"] == "199"

    # This first lifted index already gives a positive pair after multiplication by -1.
    a, b = power(199)
    assert a < 0 and b < 0
    a, b = -a, -b
    m1 = quartic((a, b))
    value, depth = m1, 0
    while value % p == 0:
        value //= p
        depth += 1
    assert depth == 2
    local_witness = dict(g=199, a=str(a), b=str(b), first_norm="7^199",
                         second_norm_67_valuation=depth,
                         second_norm_decimal_digits=len(str(m1)),
                         full_second_norm_factorization="not attempted; no compression claim")

    # Two independently liftable prime targets, genuinely compatible at every displayed depth pair.
    assert direction_data(67, 66, 21) == ((59, 23), (33, 66), 7)
    assert direction_data(967, 966, 651) == ((759, 279), (53, 172), 39)
    assert prime_by_trial_division(967)
    rows67, rows967 = [], []
    for p, period, start, derivative, bucket in [
            (67, 66, 21, 7, rows67), (967, 966, 651, 39, rows967)]:
        index = start
        for depth in range(1, 7):
            bucket.append((index, period*p**(depth-1)))
            assert index % 6 == 3
            index = lift_index(p, period, index, depth, derivative)
    pair_rows = []
    for k, (a, m) in enumerate(rows67, 1):
        for ell, (b, n) in enumerate(rows967, 1):
            assert gcd(m, n) == 6
            exponent, modulus = compatible_crt(a, m, b, n)
            assert quartic(power(exponent, 67**k)) % 67**k == 0
            assert quartic(power(exponent, 967**ell)) % 967**ell == 0
            pair_rows.append(dict(depth67=k, depth967=ell,
                                  exponent_class=str(exponent), modulus=str(modulus),
                                  claim="simultaneous local divisibility only"))
    assert pair_rows[0]["exponent_class"] == "7413"
    assert pair_rows[0]["modulus"] == "10626"

    report = dict(status="passed", arithmetic="integer and trial-division only",
                  fully_factored_rows=rows, roots_mod13=roots13,
                  hensel_prime=67, exponent_direction_derivative=22,
                  lift_rows=lift_rows, local_witness=local_witness,
                  simultaneous_prime_pair=[67, 967], simultaneous_lift_rows=pair_rows)
    target = Path(__file__).with_name("two_step_compatibility_output.json")
    target.write_bytes((json.dumps(report, indent=2) + "\n").encode("utf-8"))
    print(json.dumps(dict(status=report["status"], complete_factorizations=len(rows),
                          locally_verified_hensel_levels=len(lift_rows),
                          simultaneous_depth_pairs=len(pair_rows),
                          g199_second_norm_67_valuation=local_witness["second_norm_67_valuation"],
                          output=str(target))))


if __name__ == "__main__":
    main()
