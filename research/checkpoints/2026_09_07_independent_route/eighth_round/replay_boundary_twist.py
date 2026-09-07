"""Exact full-Sturm arithmetic comparison; PARI supplies modular coefficients."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess


def gamma0_index(n):
    result, remainder, prime = n, n, 2
    while prime * prime <= remainder:
        if remainder % prime == 0:
            result = result // prime * (prime + 1)
            while remainder % prime == 0:
                remainder //= prime
        prime += 1
    if remainder > 1:
        result = result // remainder * (remainder + 1)
    return result


def quadratic_value(discriminant, n):
    if n % 2 == 0:
        return 0
    if discriminant == -8:
        return 1 if n % 8 in (1, 3) else -1
    if discriminant == 8:
        return 1 if n % 8 in (1, 7) else -1
    raise ValueError(discriminant)


def field_sigma(row, exponent):
    a, b, c, d = row
    if exponent == 7:
        return [a, -d, -c, -b]
    if exponent == 5:
        return [a, -b, c, -d]
    raise ValueError(exponent)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    parser.add_argument('--gp', default=shutil.which('gp'))
    args = parser.parse_args()
    if not args.gp:
        raise SystemExit('Run with PARI/GP 2.15.4 available or pass --gp.')
    base = Path(__file__).resolve().parent
    proc = subprocess.run([args.gp, '-q', '-f', str(base/'boundary_twist_certificate.gp')],
                          capture_output=True, text=True, check=True)
    # GP can print an error while exiting with status zero. Permit only the
    # exact type of notice produced by this script's fixed stack allocation.
    stderr = re.sub(r'\x1b\[[0-9;]*m', '', proc.stderr)
    allowed_notice = r'\s*\*\*\*\s+Warning: new stack size = 128000000 \([0-9.]+ Mbytes\)\.\s*'
    if stderr.strip() and re.fullmatch(allowed_notice, stderr) is None:
        raise RuntimeError(proc.stderr)
    lines = [json.loads(line) for line in proc.stdout.splitlines() if line.strip()]
    assert len(lines) == 3
    header, data288, data576 = lines
    assert header == ['header', [2,15,4], 36864, 73728, 12288, 1, 3, 4, 8]
    assert data288[0] == 'series288' and data576[0] == 'series576'
    v288, v576 = data288[1], data576[1]
    level = 576 * 8**2
    index = gamma0_index(level)
    bound = 2 * index // 12
    assert level == 36864 and index == 73728 and bound == 12288
    assert level % 288 == 0
    assert len(v288) == len(v576) == bound+1
    for series in (v288, v576):
        assert all(len(row) == 4 and all(type(x) is int for x in row) for row in series)
        assert series[0] == [0,0,0,0] and series[1] == [1,0,0,0]
    checks = []
    for exponent, discriminant in ((7,-8),(5,8)):
        for n, (left, right) in enumerate(zip(v288, v576)):
            assert field_sigma(left, exponent) == [quadratic_value(discriminant,n)*x for x in right], n
        checks.append(dict(automorphism_power=exponent,
                           quadratic_discriminant=discriminant,
                           coefficients_checked=bound+1,
                           first_mismatch=None))
    result = dict(
        scope='Exact modular-form software plus full coefficient comparison; no Lean modularity proof.',
        pari_version=[2,15,4], coefficient_field_polynomial='y^4+1',
        coefficient_basis=['1','y','y^2','y^3'], nebentypus_discriminant=12,
        level_288_orbit=1, level_576_orbit=3, newspace_dimensions=[4,8],
        common_level=level, gamma0_index=index, weight=2, sturm_bound=bound,
        relations=checks, coefficients_288=v288, coefficients_576=v576
    )
    blob = (json.dumps(result, indent=2, sort_keys=True)+'\n').encode('utf-8')
    target = base/'boundary_twist_results.json'
    if args.check:
        assert target.read_bytes() == blob
    else:
        target.write_bytes(blob)
    print(json.dumps(dict(status='PASS', sha256=hashlib.sha256(blob).hexdigest(),
                          common_level=level, sturm_bound=bound,
                          coefficient_rows_per_form=bound+1), sort_keys=True))


if __name__ == '__main__':
    main()
