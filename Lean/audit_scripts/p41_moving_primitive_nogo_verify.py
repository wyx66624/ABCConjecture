#!/usr/bin/env python3
"""Reproduce the accepted-computation part of the p=41 moving-q audit.

Run with any Python 3.8+ interpreter:

    python audit_scripts/p41_moving_primitive_nogo_verify.py

The script uses only the standard library.  All assertions are exact integer
or finite-ring computations.  Deterministic Miller--Rabin is used only below
2^64, where the stated base set is a proven primality test.
"""

from math import isqrt


def is_prime_u64(n: int) -> bool:
    """Deterministic Miller--Rabin for 0 <= n < 2^64."""
    if not 0 <= n < 2**64:
        raise ValueError("is_prime_u64 requires 0 <= n < 2^64")
    if n < 2:
        return False
    small = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37)
    for ell in small:
        if n % ell == 0:
            return n == ell
    d, s = n - 1, 0
    while d % 2 == 0:
        d //= 2
        s += 1
    for base in (2, 325, 9375, 28178, 450775, 9780504, 1795265022):
        if base % n == 0:
            continue
        x = pow(base, d, n)
        if x in (1, n - 1):
            continue
        for _ in range(s - 1):
            x = x * x % n
            if x == n - 1:
                break
        else:
            return False
    return True


def is_square(n: int) -> bool:
    if n < 0:
        return False
    root = isqrt(n)
    return root * root == n


def odd_quotient_mod(half_index: int, x: int, modulus: int) -> int:
    """H_(2m+1)(x) modulo modulus, using the repository recurrence."""
    x %= modulus
    if half_index == 0:
        return 1 % modulus
    h0 = 1 % modulus
    h1 = (4 * x * x - 3) % modulus
    if half_index == 1:
        return h1
    coefficient = (4 * x * x - 2) % modulus
    for _ in range(2, half_index + 1):
        h0, h1 = h1, (coefficient * h1 - h0) % modulus
    return h1


p = 41
m = 20
q = 19681
lam = 3109
B = 12317469801647
C = 24 * B - 1
K = 2 * C
X = 48 * B - 1
D = 6 * B * C

bfactors = (23, 31, 907, 2357, 8081)
cfactors = (19, 71, 219139566523)

assert p == 2 * m + 1
assert is_prime_u64(q)
assert B == 23 * 31 * 907 * 2357 * 8081
assert C == 19 * 71 * 219139566523
assert all(is_prime_u64(factor) for factor in bfactors + cfactors)
assert len(set(bfactors + cfactors)) == len(bfactors + cfactors)

assert K == 591238550479054
assert X == 591238550479055
assert D == 21847688973285879210624605814
assert X - 1 == K
assert X + 1 == 3 * B * 4**2
assert X**2 - D * 4**2 == 1
assert B % 24 == 23 and K % 24 == 22 and X % 24 == 23
assert D % 8 == 6

# The elementary minimality proof only has to exclude y=1,2,3 below y=4.
assert all(not is_square(D * y * y + 1) for y in (1, 2, 3))

assert pow(lam, 164, q) == 1
assert pow(lam, 82, q) == q - 1
assert pow(lam, 4, q) == 2180 != 1
assert pow(lam, -1, q) == 17573
assert ((lam + pow(lam, -1, q)) * pow(2, -1, q)) % q == 10341 == X % q
assert pow(17873, 2, q) == D % q
assert (X + 4 * 17873) % q == lam
assert pow(3016, 4, q) == 5
assert 287**2 - 5 * 27**2 == 4 * q

h_q2 = odd_quotient_mod(m, X, q**2)
assert h_q2 == q * 15953
assert h_q2 % q == 0 and h_q2 % q**2 != 0

assert X % 600 == 455
assert X % 625 == 305
assert X % 3125 == 930
h_3125 = odd_quotient_mod(m, X, 3125)
assert (5**2 - (4 * X * h_3125 + 5)) % 3125 == 0

h_7 = odd_quotient_mod(m, X, 7)
t_7 = X * h_7 % 7
assert X % 7 == 3 and t_7 == 3
assert (4 * t_7 + 5) % 7 == 3
assert 3 not in {a * a % 7 for a in range(7)}

print("p=41 moving-primitive diagnostic: all exact checks passed")
print("B factors:", bfactors)
print("24*B-1 factors:", cfactors)
print("v_q(H_41(X)) = 1; target holds mod 5^5 and fails mod 7")
