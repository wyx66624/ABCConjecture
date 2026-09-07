"""Exact integer diagnostics; no finite null search is a global theorem."""
from hashlib import sha256
from json import dumps
from math import gcd
from pathlib import Path


def norm(a, b):
    return a*a+a*b+b*b


def quartic(a, b):
    return a**4+3*a**3*b+5*a*a*b*b+3*a*b**3+b**4


def nc(a):
    return 3*a*a+3*a+1


def fc(a):
    return 13*a**4+26*a**3+20*a*a+7*a+1


def val(x, p):
    assert x != 0
    e = 0
    while x % p == 0:
        x //= p
        e += 1
    return e


def exact_depth_class(poly, p, e):
    """Root 1 mod p; verify every unique root lift, then choose a nonroot."""
    a, modulus = 1, p
    assert poly(a) % p == 0
    for _ in range(1, e):
        lifts = [a+d*modulus for d in range(p)
                 if poly(a+d*modulus) % (modulus*p) == 0]
        assert len(lifts) == 1
        a, modulus = lifts[0], modulus*p
    root_lifts = [d for d in range(p)
                  if poly(a+d*modulus) % (modulus*p) == 0]
    assert len(root_lifts) == 1
    digit = next(d for d in range(p) if d != root_lifts[0])
    a += digit*modulus
    assert val(poly(a), p) == e
    return a, modulus*p


def crt(rows):
    a, modulus = 0, 1
    for residue, mod in rows:
        assert gcd(modulus, mod) == 1
        a += modulus*((residue-a)*pow(modulus, -1, mod) % mod)
        modulus *= mod
        a %= modulus
    assert all(a % mod == residue % mod for residue, mod in rows)
    return a, modulus


def ediv(z, prime):
    a, b = z
    r, s = prime
    q = norm(r, s)
    u, v = a*(r+s)+b*s, b*r-a*s
    assert u % q == 0 and v % q == 0
    return u//q, v//q


def emul(z, w):
    a, b = z
    c, d = w
    return a*c-b*d, a*d+b*c+b*d


def extract(z, prime, exponent):
    v = z
    for _ in range(exponent):
        v = ediv(v, prime)
    reconstructed = v
    for _ in range(exponent):
        reconstructed = emul(reconstructed, prime)
    assert reconstructed == z
    assert gcd(*v) == 1
    return v


def cbrt(n):
    low, high = 0, 1 << ((n.bit_length()+2)//3)
    while low < high:
        mid = (low+high+1)//2
        if mid**3 <= n:
            low = mid
        else:
            high = mid-1
    return low


def main():
    rows = []
    for g0, g1 in [(3,3), (3,5), (5,3), (5,7), (2,2), (6,10), (9,15)]:
        a, period = crt([exact_depth_class(nc, 7, g0),
                         exact_depth_class(fc, 67, g1), (5,169), (14,961)])
        assert a > 0
        for shift in [0,1,2]:
            aa, bb = a+shift*period, a+shift*period+1
            m0, m1 = norm(aa,bb), quartic(aa,bb)
            assert gcd(aa,bb) == gcd(aa*bb,m0) == gcd(m0,m1) == 1
            assert m0 == nc(aa) and m1 == fc(aa)
            assert val(m0,7) == g0 and val(m1,67) == g1
            assert val(m0,13) == val(m1,31) == 1
            v0 = extract((aa,bb),(1,2),g0)
            v1 = extract((aa*bb,m0),(2,7),g1)
            assert norm(*v0)*7**g0 == m0
            assert norm(*v1)*67**g1 == m1
            rows.append({'g0':g0,'g1':g1,'shift':shift,'a':str(aa),
                         'b':str(bb),'V0':str(norm(*v0)),'V1':str(norm(*v1)),
                         'v0':[str(t) for t in v0],
                         'v1':[str(t) for t in v1]})
    first, second, checked = [], [], 0
    for b in range(1,501):
        for a in range(1,b+1):
            if gcd(a,b) != 1:
                continue
            checked += 1
            m0, m1 = norm(a,b), quartic(a,b)
            if cbrt(m0)**3 == m0:
                first.append([a,b,m0,m1])
            if cbrt(m1)**3 == m1:
                second.append([a,b,m0,m1])
    direct = []
    for modulus in [2,3,7,9,13,27,67,169,1001,2**8*3**5*7**3]:
        for k in [1,2,7]:
            a,b = modulus*k, modulus*k+1
            assert gcd(a,b) == 1
            assert norm(a,b) % modulus == quartic(a,b) % modulus == 1
            direct.append([modulus,k])
    out = {'status':'finite diagnostics, not a proof of a null infinite family',
           'actual_extraction_rows':rows,'direct_residue_rows':direct,
           'cube_scan':{'bound':500,'primitive_pairs':checked,
                        'first_norm_cubes':first,'second_norm_cubes':second}}
    raw = (dumps(out,indent=2,sort_keys=True)+'\n').encode('utf-8')
    dest = Path(__file__).parent/'verification'/'results.json'
    dest.parent.mkdir(exist_ok=True)
    dest.write_bytes(raw)
    print(dumps({'sha256':sha256(raw).hexdigest(),
                 'actual_extraction_rows':len(rows),
                 'primitive_scan_pairs':checked,
                 'first_norm_cubes':len(first),'second_norm_cubes':len(second)}))


if __name__ == '__main__':
    main()
