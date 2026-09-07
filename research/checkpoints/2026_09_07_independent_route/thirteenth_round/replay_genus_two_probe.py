"""Bounded GP point search with exact Python checks; not all rational points."""
import argparse
from fractions import Fraction
import hashlib
import json
from math import gcd, isqrt
from pathlib import Path
import re
import shutil
import subprocess


def evaluate(coefficients, value):
    total = Fraction(0)
    for c in coefficients:
        total = total * value + c
    return total


def trim(p):
    p = list(p)
    while len(p) > 1 and p[-1] == 0:
        p.pop()
    return p


def add(p, q):
    r = [0] * max(len(p), len(q))
    for i, a in enumerate(p):
        r[i] += a
    for i, a in enumerate(q):
        r[i] += a
    return trim(r)


def scale(p, a):
    return trim([a*c for c in p])


def multiply(p, q):
    r = [0] * (len(p)+len(q)-1)
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            r[i+j] += a*b
    return trim(r)


def power(p, n):
    r = [1]
    for _ in range(n):
        r = multiply(r, p)
    return r


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    base = Path(__file__).resolve().parent
    script = base / 'genus_two_probe.gp'
    gp = shutil.which('gp')
    if gp:
        command = [gp, '-q', '-f', str(script)]
    else:
        drive = script.drive[0].lower()
        unix_path = '/mnt/' + drive + script.as_posix()[2:]
        command = ['wsl', '-d', 'Ubuntu-24.04', '--', '/usr/bin/gp',
                   '-q', '-f', unix_path]
    proc = subprocess.run(command, capture_output=True, text=True, check=True)
    stderr = re.sub(r'\x1b\[[0-9;]*m', '', proc.stderr)
    notice = r'\s*\*\*\*\s+Warning: new maximum stack size = 512000000 \([0-9.]+ Mbytes\)\.\s*'
    if stderr.strip() and not re.fullmatch(notice, stderr):
        raise RuntimeError(stderr)
    rows = [json.loads(line) for line in proc.stdout.splitlines() if line.strip()]
    assert rows[0] == ['header', [2, 15, 4], 1000, 1000]
    assert rows[-1] == ['complete', 9] and len(rows) == 11
    expected_models = []
    a, b = [-1,-3,0,1], [0,3,3]
    for _ in range(3):
        c, d = add(a, b), add(b, scale(a, -3))
        expected_models.extend([multiply(b,c), multiply(b,d), multiply(c,d)])
        a, b = scale(b, -1), add(a,b)
    curves = []
    independent_cases = 0
    for row in rows[1:-1]:
        tag, unit_power, quotient, coefficients, encoded = row
        assert tag == 'curve'
        assert list(reversed(coefficients)) == expected_models[3*unit_power+quotient-1]
        points = set()
        for xy in encoded:
            x, y = (Fraction(*pair) for pair in xy)
            assert evaluate(coefficients, x) == y*y
            assert abs(x.numerator) <= 1000 and x.denominator <= 1000
            points.add((x, y))
        # Independent exhaustive rational abscissa enumeration in a smaller
        # box. This checks the bounded API against a different implementation.
        independent = set()
        for denominator in range(1, 81):
            for numerator in range(-80, 81):
                if gcd(numerator, denominator) != 1:
                    continue
                x = Fraction(numerator, denominator)
                value = evaluate(coefficients, x)
                independent_cases += 1
                if value < 0:
                    continue
                a, b = isqrt(value.numerator), isqrt(value.denominator)
                if a*a == value.numerator and b*b == value.denominator:
                    y = Fraction(a, b)
                    independent.add((x, y))
                    independent.add((x, -y))
        assert independent == {(x, y) for x, y in points
                               if abs(x.numerator) <= 80 and x.denominator <= 80}
        curves.append(dict(unit_power=unit_power, quotient=quotient,
                           polynomial_descending=coefficients,
                           affine_points=encoded,
                           affine_point_count=len(points),
                           independent_box_point_count=len(independent)))
    positive_sources = []
    for unit_power in range(3):
        first = curves[3*unit_power]
        second = curves[3*unit_power+1]
        xs1 = {Fraction(*p[0]) for p in first['affine_points']}
        xs2 = {Fraction(*p[0]) for p in second['affine_points']}
        for x in xs1 & xs2:
            a, b = x**3-3*x-1, 3*x*(x+1)
            for _ in range(unit_power):
                a, b = -b, a+b
            if b and 0 < a/b < Fraction(1, 3):
                positive_sources.append([unit_power, x.numerator, x.denominator])
    assert not positive_sources
    # At source infinity the homogeneous leading pairs give r=infinity,
    # r=0, r=-1 for the three units, respectively: none is a positive locus.
    # The local sextic has no primitive square value even modulo 27.
    squares27 = {y*y % 27 for y in range(27)}
    local_cases = 0
    for s in range(27):
        for t in range(27):
            if s % 3 == 0 and t % 3 == 0:
                continue
            c = s**3 + 3*s*s*t - t**3
            e = s**3 - s*s*t - 4*s*t*t - t**3
            assert (-3*c*e) % 27 not in squares27
            local_cases += 1
    # New elliptic maps, checked by exact integer polynomial coefficients.
    p = [1,3,-3,-11,-3,3,1]
    xp, dp = [-2,-5,-2], [1,1]
    first_rhs = add(add(power(xp,3), scale(multiply(xp,power(dp,4)),-9)),
                    scale(power(dp,6),-9))
    assert first_rhs == p
    xq, dq = [6,-21,6], [-1,1]
    second_rhs = add(add(power(xq,3), scale(multiply(xq,power(dq,4)),-189)),
                     scale(power(dq,6),999))
    assert second_rhs == scale(p,81)
    even = [0]
    for i, c in enumerate(p):
        even = add(even,scale(multiply(power([1,1],i),power([-1,1],6-i)),c))
    assert even == [1,0,-27,0,99,0,-9]
    assert add(power([5,2],2),scale(power([2,1],2),-4)) == [9,4]
    elliptic = []
    for a,b,x,y,twice in [(-9,-9,-2,1,(Fraction(25,4),Fraction(-107,8))),
                         (-189,999,6,9,(Fraction(33,4),Fraction(9,8)))]:
        assert y*y == x**3+a*x+b
        slope = Fraction(3*x*x+a,2*y)
        x2 = slope*slope-2*x
        y2 = slope*(x-x2)-y
        assert (x2,y2) == twice
        elliptic.append(dict(a=a,b=b,discriminant=-16*(4*a**3+27*b*b),
                             point=[x,y],double=[[x2.numerator,x2.denominator],
                                                [y2.numerator,y2.denominator]]))
    assert [c['discriminant'] for c in elliptic] == [11664,944784]
    result = dict(
        status='PASS', pari_version=[2, 15, 4],
        scope='Bounded affine point search only; no complete rational-point or rank assertion.',
        gp_abscissa_box=dict(max_abs_numerator=1000, max_denominator=1000),
        independent_abscissa_box=dict(max_abs_numerator=80, max_denominator=80),
        independently_checked_curve_abscissas=independent_cases,
        primitive_local_mod27_pairs=local_cases,
        positive_common_sources_in_gp_box=positive_sources,
        positive_source_at_infinity=False,
        exact_polynomial_checks=['nine quotient models','first elliptic map',
                                 'second elliptic map','even sextic transformation',
                                 'inverse quadratic discriminant'],
        elliptic_exact_doublings=elliptic,
        curves=curves,
        complete_rational_point_computation=False,
        elliptic_rank_certified_by_this_script=False)
    blob = (json.dumps(result, sort_keys=True, indent=2) + '\n').encode('utf-8')
    target = base / 'verification' / 'genus_two_probe.json'
    if args.check:
        assert target.read_bytes() == blob
    else:
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(blob)
    print(json.dumps(dict(status='PASS', curves=len(curves),
                          affine_points=sum(c['affine_point_count'] for c in curves),
                          independent_abscissas=independent_cases,
                          local_pairs=local_cases,
                          sha256=hashlib.sha256(blob).hexdigest()), sort_keys=True))


if __name__ == '__main__':
    main()
