"""Exact finite replay of actual arm division and signed-credit inequalities.

Only integer arithmetic, Fraction, trial division and canonical JSON are used.
The asymptotic logarithmic-form theorem is not inferred from these checks.
"""
import argparse
from fractions import Fraction
from hashlib import sha256
import json
from math import gcd, isqrt
from pathlib import Path


def mul(x, y):
    a, b = x
    c, d = y
    return a*c-b*d, a*d+b*c+b*d


def power(x, n):
    result = (1, 0)
    while n:
        if n & 1:
            result = mul(result, x)
        x = mul(x, x)
        n //= 2
    return result


def factors(x):
    x = abs(x)
    assert x > 0
    result = {}
    p = 2
    while p*p <= x:
        while x % p == 0:
            result[p] = result.get(p, 0)+1
            x //= p
        p = 3 if p == 2 else p+2
    if x > 1:
        result[x] = result.get(x, 0)+1
    return result


def is_prime_trial(p):
    return p >= 2 and all(p % d for d in range(2, isqrt(p)+1))


def signed_weight(fs, cutoff):
    result = Fraction(1)
    for p, e in fs.items():
        if p > cutoff:
            result *= Fraction(p)**(e-3)
    return result


def product(values):
    answer = 1
    for value in values:
        answer *= value
    return answer


def actual_row(a, b, n, given=None):
    Q = a*a+a*b+b*b
    assert gcd(a, b) == 1 and Q >= 7 and Q % 3 and n % 6 in (1, 5)
    old = (a, b, a+b)
    assert all(old)
    A, B = power((a, b), n)
    if n % 6 == 5:
        A, B = A+B, -B
    arms = (A, B, A+B)
    assert all(arms) and gcd(A, B) == 1
    assert all(x % y == 0 for x, y in zip(arms, old))
    ds = tuple(x//y for x, y in zip(arms, old))
    assert all(gcd(ds[i], ds[j]) == 1 for i in range(3) for j in range(i))
    assert a*ds[0]+b*ds[1] == (a+b)*ds[2]
    T, T1 = abs(product(arms)), abs(product(old))
    assert T1*abs(product(ds)) == T
    assert A*A+A*B+B*B == Q**n
    c, c1 = max(map(abs, arms)), max(map(abs, old))
    assert all(abs(d) <= c and abs(d)*c*c*c1 >= T for d in ds)
    fs = [factors(d) for d in ds] if given is None else given
    for d, f in zip(ds, fs):
        assert abs(d) == product(p**e for p, e in f.items())
        assert all(is_prime_trial(p) for p in f)
    total_fs = factors(T1)
    for f in fs:
        for p, e in f.items():
            total_fs[p] = total_fs.get(p, 0)+e
    assert product(p**e for p, e in total_fs.items()) == T
    checks = []
    for cutoff in (5, 11):
        W = signed_weight(total_fs, cutoff)
        L = product(p**e for p, e in total_fs.items() if p <= cutoff)
        E = [product(p**max(e-2, 0) for p, e in f.items() if p > cutoff) for f in fs]
        R = [product(p for p in f if p > cutoff) for f in fs]
        for k in range(3):
            i, j = [v for v in range(3) if v != k]
            # This is exp(2 times SA5), with no numerical logarithms.
            rhs = Fraction(c**3, T)**2*c1**2*T1**2*L
            rhs *= Fraction((E[i]*E[j])**3, R[k]**6)
            assert W**2 <= rhs
            checks.append([cutoff, k, True])
    return dict(a=a, b=b, n=n, norm=Q, quotients=list(ds),
                factors=[[[p, e] for p, e in sorted(f.items())] for f in fs],
                exact_squared_signed_checks=checks)


def polynomial_rows(n):
    # Coefficient index j means a^(n-j)b^j. Multiplication is exact.
    A, B = [1], [0]
    for _ in range(n):
        next_a = [0]*(len(A)+1)
        next_b = [0]*(len(B)+1)
        for j, x in enumerate(A):
            next_a[j] += x
            next_b[j+1] += x
        for j, x in enumerate(B):
            next_a[j+1] -= x
            next_b[j] += x
            next_b[j+1] += x
        A, B = next_a, next_b
    if n % 6 == 5:
        A, B = [x+y for x, y in zip(A, B)], [-x for x in B]
    assert A[-1] == B[0] == 0
    q1, q2 = A[:-1], B[1:]
    C = [x+y for x, y in zip(A, B)]
    q3, previous = [], 0
    for x in C[:-1]:
        previous = x-previous
        q3.append(previous)
    assert C[-1] == q3[-1]
    assert [q1[0]]+[q1[j]+q2[j-1] for j in range(1, n)]+[q2[-1]] == C
    return dict(n=n, quotient_coefficients=[q1, q2, q3])


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    rows = []
    for a in range(-5, 6):
        for b in range(-5, 6):
            Q = a*a+a*b+b*b
            if gcd(a, b) != 1 or Q < 7 or not Q % 3:
                continue
            for n in (5, 7):
                rows.append(actual_row(a, b, n))
    for a, b in ((2, 1), (3, 1), (1, 3), (2, -3)):
        for n in (11, 13):
            rows.append(actual_row(a, b, n))
    given = [
        {5:1, 31:4, 168541:1, 11208719:1},
        {571:1, 640049:1, 119336975731:1},
        {181:1, 659:1, 2131:1, 263129:1, 130411:1},
    ]
    private = actual_row(54345, 1, 5, given)
    assert given[0][31] == 4
    assert all(e == 1 for f in given[1:] for e in f.values())
    # The ramified boundary is explicitly excluded by SA1's hypotheses.
    A, B = power((1, 1), 5)
    A, B = A+B, -B
    assert (A, B, (A+B)//2) == (-9, -9, -9)
    result = dict(
        scope='Finite exact arithmetic only; no asymptotic membership or Lean claim.',
        polynomial_rows=[polynomial_rows(n) for n in (5, 7, 11, 13, 25, 35)],
        actual_rows=rows, private_depth_example=private,
        ramified_excluded_example=dict(a=1,b=1,n=5,norm=3,quotients=[-9,-9,-9]),
        signed_inequality_count=6*(len(rows)+1),
    )
    compact = json.dumps(result, sort_keys=True, separators=(',', ':')).encode('utf-8')
    result['payload_sha256'] = sha256(compact).hexdigest()
    blob = (json.dumps(result, sort_keys=True, indent=2)+'\n').encode('utf-8')
    path = Path(__file__).with_name('finite_replay.json')
    if args.check:
        assert path.read_bytes() == blob
    else:
        path.write_bytes(blob)
    print(json.dumps(dict(status='PASS', actual_rows=len(rows)+1,
        signed_inequalities=result['signed_inequality_count'],
        payload_sha256=result['payload_sha256'], file_sha256=sha256(blob).hexdigest()), sort_keys=True))


if __name__ == '__main__':
    main()
