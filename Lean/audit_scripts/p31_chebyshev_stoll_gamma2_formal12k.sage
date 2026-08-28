# Prime-31 Stoll--Gamma_2 shell certificate on the Pell dyadic disk.
# SageMath 10.9.
#
# This script loads and repeats the exact p=31 global squareclass / dyadic
# certificate.  It then implements Stoll Lemma 2.4 literally for
# Gamma_2=<H1,H9>.  The mathematical interpretation accepts Stoll,
# "Chabauty Without the Mordell-Weil Group", Theorem 2.1, Lemma 2.4,
# Corollary 3.2, Lemma 3.10, Proposition 5.1, and Remark 5.2, together with
# standard odd-degree hyperelliptic Kummer theory.  These accepted theorem
# interfaces are not re-proved by this finite Sage certificate.
#
# The shell depth and the modulus on odd units are found adaptively, starting
# at m=3 and unit modulus 2^3.  No p=23 shell depth is assumed.  Terminal
# membership in the fifteen-dimensional global over-approximation W is
# decided by an invertible fifteen-coordinate Hilbert signature, followed
# by one direct local square test against the uniquely selected W candidate;
# this avoids enumerating all 2^15 elements of W.

import os

global_source = 'p31_chebyshev_global_dyadic_verify.sage'
if not os.path.exists(global_source):
    global_source = 'Lean/audit_scripts/' + global_source
load(global_source)
P2 = P2s[0]
Btest = B2
n = len(reps)
assert n == 20

# Exact endpoint Mumford data and exact Cantor composition over QQ.
fmQ = Qx(curvefm)
U1Q = Qx(Uminus)
U9Q = Qx(Uplus)
endpoint_y1 = ZZ(2^15)
endpoint_y9 = ZZ(3*2^15)


def cantor_add_coprime(ua, va, ub, vb):
    """Exact coprime Cantor composition and reduction over QQ."""
    gg, s, t = xgcd(ua, ub)
    assert gg == 1
    uc = ua*ub
    vc = (va*t*ub + vb*s*ua) % uc
    rounds = 0
    while uc.degree() > 15:
        assert (fmQ-vc^2) % uc == 0
        un = (fmQ-vc^2)//uc
        un = un/un.leading_coefficient()
        vc = (-vc) % un
        uc = un
        rounds += 1
    uc = uc/uc.leading_coefficient()
    vc = vc % uc
    assert (fmQ-vc^2) % uc == 0
    return uc, vc, rounds


assert fmQ-endpoint_y1^2 == (x+4)*U1Q^2
assert fmQ-endpoint_y9^2 == (x-4)*U9Q^2
gAQ, gBQ, cantor_rounds = cantor_add_coprime(
    U1Q, Qx(endpoint_y1), U9Q, Qx(endpoint_y9))
gAQ_frozen = Qx(x^15-x^14-56*x^13+52*x^12+1248*x^11-1056*x^10
    -14080*x^9+10560*x^8+84480*x^7-53760*x^6-258048*x^5
    +129024*x^4+344064*x^3-114688*x^2-131072*x+16384)
gBQ_frozen = Qx(-3*x^14+156*x^12-3168*x^10+31680*x^8-161280*x^6
    +387072*x^4-344064*x^2+49152)
assert cantor_rounds == 8
assert gAQ == gAQ_frozen and gBQ == gBQ_frozen
print('P31_EXACT_CANTOR_SUM_PASS', 'ROUNDS', cantor_rounds,
      'GA', gAQ, 'GB', gBQ, flush=True)

# On the integral model z^2+z=T_31(T)+1, partial/partial z is one in
# characteristic two.  Thus t=T+1 is a regular parameter at T=-1.
F2tz = PolynomialRing(GF(2), names=('tt', 'zz'))
tt, zz = F2tz.gens()
assert (zz^2+zz).derivative(zz) == 1

# The isolated 10k/12k first-m5-node calibration found the layer-4 c3
# bottleneck at 2315/4315 respectively.  This formal run uses 12000 bits;
# every constructed identity must retain valuation strictly above 2000.
prec = 12000
required_identity_valuation = 2000
Qh = Qp(2, prec)
Rh.<X> = Qh[]
Kh.<ah> = Qh.extension(X^31-2)
theta = -(2*ah+ah^30)
fh = Rh(fmQ)
g = 15


def pad(seq, n):
    return list(seq)+[Qh(0)]*(n-len(seq))


def keval(poly, z):
    return sum(Kh(poly[i])*z^i for i in range(poly.degree()+1))


theta_rows = matrix(Qh, [pad((theta^i).polynomial().list(), 31)
                          for i in range(31)])
assert theta_rows.rank() == 31
theta_inv = theta_rows.inverse()


def theta_poly(z):
    cv = vector(Qh, pad(z.polynomial().list(), 31))*theta_inv
    out = Rh(list(cv))
    assert (keval(out, theta)-z).valuation() > required_identity_valuation
    return out


def coeffs(poly, n):
    return [poly[i] for i in range(n)]


def minval(poly, n):
    return Infinity if n <= 0 else min(poly[i].valuation() for i in range(n))


def assert_reduced_input(ap, bp):
    assert ap.leading_coefficient() == 1 and ap.degree() <= g
    assert bp.degree() < ap.degree()
    assert gcd(ap, ap.derivative()).degree() == 0
    assert gcd(ap, fh).degree() == 0


def solve_half(ap, bp, a0=None, b0=None):
    """Stoll Proposition 5.1 / Remark 5.2 translated-halving system."""
    assert_reduced_input(ap, bp)
    if a0 is None:
        factors = [(ap, bp)]
    else:
        assert_reduced_input(a0, b0)
        assert gcd(ap, a0).degree() == 0
        factors = [(ap, bp), (a0, b0)]

    d = sum(q.degree() for q, _ in factors)
    aprod = prod(q for q, _ in factors)
    assert d <= 31
    sq = (-1)^d*keval(aprod, theta)
    assert sq.is_square()
    sp = theta_poly(sq.square_root())

    nu = ceil(QQ(d)/2)
    nv = g+floor(QQ(d)/2)+1
    nw = g+1
    rows = []
    for block, count in enumerate([nu, nv, nw]):
        for i in range(count):
            up = X^i if block == 0 else Rh(0)
            vp = X^i if block == 1 else Rh(0)
            wp = X^i if block == 2 else Rh(0)
            row = coeffs((vp-wp*sp) % fh, 31)
            for aq, bq in factors:
                row += coeffs((vp-up*bq) % aq, aq.degree())
            rows.append(vector(Qh, row))

    kernel = matrix(Qh, rows).left_kernel()
    assert kernel.dimension() == 1
    sol = kernel.basis()[0]
    up = Rh(list(sol[:nu]))
    vp = Rh(list(sol[nu:nu+nv]))
    wp = Rh(list(sol[nu+nv:]))
    lc = wp.leading_coefficient()
    assert lc != 0
    up /= lc
    vp /= lc
    wp /= lc

    wd = wp.degree()
    assert 0 < wd <= g
    invrows = matrix(Qh, [vector(Qh, coeffs((up*X^i) % wp, wd))
                          for i in range(wd)])
    iv = vector(Qh, [1]+[0]*(wd-1))*invrows.inverse()
    ui = Rh(list(iv))
    rp = (-vp*ui) % wp

    c1 = minval((up*ui) % wp-1, wd)
    identity = up^2*fh-(vp^2-(-1)^d*aprod*wp^2)
    c2 = minval(identity, identity.degree()+1)
    c3 = minval((fh-rp^2) % wp, wd)
    certificate_valuation = min(c1, c2, c3)
    assert certificate_valuation > required_identity_valuation
    assert_reduced_input(wp, rp)
    return wp, rp, certificate_valuation


U1 = Rh(U1Q)
U9 = Rh(U9Q)
gA = Rh(gAQ)
gB = Rh(gBQ)
d1e = (-1)^U1.degree()*keval(U1, theta)
d9e = (-1)^U9.degree()*keval(U9, theta)
ge = (-1)^gA.degree()*keval(gA, theta)


def global_to_high(e):
    pe = e.polynomial()
    return sum(Kh(QQ(pe[i]))*ah^i for i in range(pe.degree()+1))


assert (d1e/global_to_high(d1)).is_square()
assert (d9e/global_to_high(d9)).is_square()
assert (ge/(d1e*d9e)).is_square()
repE = [Kh(1), d1e, d9e, ge]
repA = [Rh(1), U1, U9, gA]
repB = [Rh(0), Rh(endpoint_y1), Rh(endpoint_y9), gB]
for i in range(4):
    for j in range(i):
        assert not (repE[i]/repE[j]).is_square()
assert Gamma2sig.rank() == 2
print('P31_GAMMA2_LOCAL_INDEPENDENCE_PASS', flush=True)

# Build the fifteen exact basis elements of W from the frozen global basis.
Welts = []
for c in WB:
    e = K(1)
    for i in range(n):
        if c[i]:
            e *= reps[i]
    Welts.append(e)
Whigh = [global_to_high(e) for e in Welts]
assert len(Welts) == len(Whigh) == W.dimension() == 15

# Frozen from the exact scout and re-derived to detect any basis-order drift.
signature_columns = [3,4,5,6,7,8,9,10,11,12,13,14,15,17,18]
assert signature_columns == list(W2sig.pivots())
Wsignature = W2sig.matrix_from_columns(signature_columns)
assert len(signature_columns) == 15
assert Wsignature.nrows() == Wsignature.ncols() == 15
assert Wsignature.rank() == 15
assert Wsignature.det() == 1
print('P31_W_SIGNATURE_MINOR', signature_columns,
      'DETERMINANT', Wsignature.det(), flush=True)
terminal_membership_cache = []


def exact_shadow(z):
    """Return a small exact K element in the local squareclass of z."""
    valuation = ZZ(z.valuation())
    square_scale_exponent = 2*ZZ(floor(QQ(valuation)/2))
    zn = z/(ah^square_scale_exponent)
    assert zn.valuation() in [0,1]
    zp = zn.polynomial()
    # Coefficient error O(2^8) has Kh valuation at least 8*31, far beyond
    # 2*v_K(2)=62.  The direct square assertion below is the operative check.
    ze = sum(K(QQ(zp[i].add_bigoh(8)))*a^i
             for i in range(zp.degree()+1))
    assert ze != 0
    assert (zn/global_to_high(ze)).is_square()
    return ze


def in_global_overapproximation(z):
    """Signature-select one W candidate, then verify it by a square test."""
    for entry in terminal_membership_cache:
        if (z/entry['local']).is_square():
            return entry['inW'], entry['class_index']

    ze = exact_shadow(z)
    sig = vector(F2, [hs(ze, Btest[j], P2) for j in signature_columns])
    coords = Wsignature.transpose().solve_right(sig)
    assert coords*Wsignature == sig
    candidate = Kh(1)
    for i in range(15):
        if coords[i]:
            candidate *= Whigh[i]
    answer = (z/candidate).is_square()
    class_index = len(terminal_membership_cache)
    terminal_membership_cache.append({
        'local': z,
        'inW': answer,
        'class_index': class_index,
        'signature': sig,
        'coordinates': coords,
        'shadow': ze,
    })
    print('NEW_TERMINAL_SQUARECLASS', class_index,
          'SIGNATURE_COLUMNS', signature_columns,
          'SIGNATURE', sig, 'W_COORDINATES', coords,
          'DIRECT_SQUARE_MEMBERSHIP', answer,
          'EXACT_SHADOW', ze, flush=True)
    return answer, class_index


def gammaidx(z):
    matches = [i for i, e in enumerate(repE) if (z/e).is_square()]
    assert len(matches) <= 1
    return matches[0] if matches else None


def chain(ap, bp):
    depth = 0
    certificate_valuation = Infinity
    while depth <= 30:
        z = (-1)^ap.degree()*keval(ap, theta)
        idx = gammaidx(z)
        if idx is None:
            terminal_in_W, class_index = in_global_overapproximation(z)
            return depth, terminal_in_W, class_index, certificate_valuation
        if idx == 0:
            ap, bp, cert = solve_half(ap, bp)
        else:
            ap, bp, cert = solve_half(ap, bp, repA[idx], repB[idx])
        certificate_valuation = min(certificate_valuation, cert)
        depth += 1
    raise RuntimeError('unexpected recursion depth > 30')


def initial_divisor(xx, yy):
    # This line passes through (xx,yy) and (-4,-2^15), so the pair is the
    # Mumford representative of [P-P0] for P0=(-4,2^15).
    ap = (X-Qh(xx))*(X+4)
    slope = (yy+endpoint_y1)/(xx+4)
    bp = yy+slope*(X-xx)
    initial_residual_valuation = minval((fh-bp^2) % ap, 2)
    print('P31_INITIAL_DIVISOR_RESIDUAL_VALUATION',
          initial_residual_valuation,flush=True)
    assert initial_residual_valuation > required_identity_valuation
    assert_reduced_input(ap, bp)
    return ap, bp


node_cache = {}


def shell_node(m, unit):
    key = (ZZ(m), ZZ(unit))
    if key in node_cache:
        return node_cache[key]
    t0 = 2^m*unit
    xx = Qh(-4+4*t0)
    value = fh(xx)
    assert value.is_square()
    yy = value.square_root()
    if (yy/endpoint_y1-1).valuation() < 2:
        yy = -yy
    assert (yy/endpoint_y1-1).valuation() >= 2
    ap, bp = initial_divisor(xx, yy)
    depth, terminal_in_W, class_index, cert = chain(ap, bp)
    assert depth > 0
    assert not terminal_in_W
    node_cache[key] = (depth, cert, class_index)
    print('NODE', 'M', m, 'UNIT', unit, 'X', ZZ(-4+4*t0),
          'NU', depth, 'TERMINAL_CLASS', class_index,
          'TERMINAL_IN_W', terminal_in_W,
          'MIN_ID_VAL', cert, flush=True)
    return node_cache[key]


# Adaptive finite shells.  For modulus 2^ell on odd units, points in the
# same represented ball differ by valuation at least m+ell.  Corollary 3.2
# applies once m+ell >= n+3 for every representative.  After a certified
# shell, Lemma 3.10 closes the tail once 2m-3 >= n_m.
shell_summaries = []
tail_m = None
for m in range(3, 13):
    shell_certified = False
    for unit_bits in range(3, 10):
        odd_units = list(range(1, 2^unit_bits, 2))
        data = [shell_node(m, unit) for unit in odd_units]
        max_depth = max(entry[0] for entry in data)
        min_identity_valuation = min(entry[1] for entry in data)
        cover_bound = m+unit_bits
        cover_required = max_depth+3
        cover_pass = cover_bound >= cover_required
        print('SHELL_REFINEMENT', 'M', m,
              'UNIT_BITS', unit_bits, 'REPS', len(odd_units),
              'MAX_NU', max_depth, 'COVER_BOUND', cover_bound,
              'COVER_REQUIRED', cover_required,
              'COVER_PASS', cover_pass, flush=True)
        if cover_pass:
            shell_certified = True
            break
    assert shell_certified
    shell_summaries.append((m, unit_bits, len(odd_units), max_depth,
                            min_identity_valuation))
    print('SHELL_SUMMARY', 'M', m,
          'UNIT_MODULUS', 2^unit_bits, 'REPS', len(odd_units),
          'MAX_NU', max_depth,
          'MIN_ID_VAL', min_identity_valuation, flush=True)

    tail_bound = 2*m-3
    tail_pass = tail_bound >= max_depth
    print('TAIL_TEST', 'M', m, 'BOUND', tail_bound,
          'MAX_NU', max_depth, 'PASS', tail_pass, flush=True)
    if tail_pass:
        tail_m = m
        print('TAIL_LEMMA_3_10', 'M', m, 'BOUND', tail_bound,
              'MAX_NU', max_depth, 'PASS', True, flush=True)
        break

assert tail_m is not None
print('TERMINAL_SQUARECLASS_COUNT', len(terminal_membership_cache))
print('ADAPTIVE_SHELL_SUMMARIES', shell_summaries)
print('P31_STOLL_GAMMA2_OVERAPPROX_PASS')
