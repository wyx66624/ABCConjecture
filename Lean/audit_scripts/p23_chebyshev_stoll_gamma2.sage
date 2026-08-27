# Stoll Lemma 2.4 / Corollary 3.2 / Lemma 3.10 certificate for p=23.
# SageMath 10.9.  This deliberately tests against the full eleven-
# dimensional global over-approximation W, not merely a computed Selmer
# subgroup.  Precision 16000 is required by the seventh halving at m=5.

load('Lean/audit_scripts/p23_chebyshev_global_dyadic_overapprox.sage')

fmQ = Qx(x^23-92*x^21+3680*x^19-83904*x^17+1201152*x^15
    -11210752*x^13+68583424*x^11-269434880*x^9+646643712*x^7
    -862191616*x^5+530579456*x^3-96468992*x+20971520)
U1Q = Qx(x^11-2*x^10-40*x^9+72*x^8+576*x^7-896*x^6-3584*x^5
    +4480*x^4+8960*x^3-7680*x^2-6144*x+2048)
U9Q = Qx(x^11+2*x^10-40*x^9-72*x^8+576*x^7+896*x^6-3584*x^5
    -4480*x^4+8960*x^3+7680*x^2-6144*x-2048)
gAQ = Qx(x^11-x^10-40*x^9+36*x^8+576*x^7-448*x^6-3584*x^5
    +2240*x^4+8960*x^3-3840*x^2-6144*x+1024)
gBQ = Qx(-3*x^10+108*x^8-1344*x^6+6720*x^4-11520*x^2+3072)
assert fmQ-2048^2 == (x+4)*U1Q^2
assert fmQ-6144^2 == (x-4)*U9Q^2
assert (fmQ-gBQ^2) % gAQ == 0

# Exact Cantor composition, not merely equality of mod-two Kummer classes:
# [U1,2048]+[U9,6144]=[gA,gB] in J(Q).
def cantor_add_coprime(ua,va,ub,vb):
    gg,s,t=xgcd(ua,ub)
    assert gg == 1
    uc=ua*ub
    vc=(va*t*ub+vb*s*ua) % uc
    while uc.degree() > 11:
        assert (fmQ-vc^2) % uc == 0
        un=(fmQ-vc^2)//uc
        un=un/un.leading_coefficient()
        vc=(-vc) % un
        uc=un
    uc=uc/uc.leading_coefficient(); vc=vc % uc
    assert (fmQ-vc^2) % uc == 0
    return uc,vc
sumA,sumB=cantor_add_coprime(U1Q,Qx(2048),U9Q,Qx(6144))
assert sumA == gAQ and sumB == gBQ
thetaQ = -(2*a+a^22)
assert Qx(thetaQ.minpoly()) == fmQ

prec = 16000
Qh = Qp(2,prec)
Rh.<X> = Qh[]
Kh.<ah> = Qh.extension(X^23-2)
theta = -(2*ah+ah^22)
fh = Rh(fmQ)
g = 11

def pad(s,n):
    return list(s)+[Qh(0)]*(n-len(s))
def keval(poly,z):
    return sum(Kh(poly[i])*z^i for i in range(poly.degree()+1))
theta_rows = matrix(Qh,[pad((theta^i).polynomial().list(),23)
                          for i in range(23)])
assert theta_rows.rank() == 23
theta_inv = theta_rows.inverse()
def theta_poly(z):
    cv = vector(Qh,pad(z.polynomial().list(),23))*theta_inv
    out = Rh(list(cv))
    assert (keval(out,theta)-z).valuation() > 1000
    return out
def coeffs(poly,n):
    return [poly[i] for i in range(n)]
def minval(poly,n):
    return Infinity if n <= 0 else min(poly[i].valuation() for i in range(n))
def assert_reduced_input(ap,bp):
    assert ap.leading_coefficient() == 1 and ap.degree() <= g
    assert bp.degree() < ap.degree()
    assert gcd(ap,ap.derivative()).degree() == 0
    assert gcd(ap,fh).degree() == 0

def half_ab(ap,bp):
    assert_reduced_input(ap,bp)
    d = ap.degree()
    sq = (-1)^d*keval(ap,theta)
    assert sq.is_square()
    sp = theta_poly(sq.square_root())
    nu = ceil(QQ(d)/2); nv = g+floor(QQ(d)/2)+1; nw = g+1
    rows = []
    for i in range(nu):
        up=X^i; vp=Rh(0); wp=Rh(0)
        rows.append(vector(Qh,coeffs((vp-wp*sp)%fh,23)
                              +coeffs((vp-up*bp)%ap,d)))
    for i in range(nv):
        up=Rh(0); vp=X^i; wp=Rh(0)
        rows.append(vector(Qh,coeffs((vp-wp*sp)%fh,23)
                              +coeffs((vp-up*bp)%ap,d)))
    for i in range(nw):
        up=Rh(0); vp=Rh(0); wp=X^i
        rows.append(vector(Qh,coeffs((vp-wp*sp)%fh,23)
                              +coeffs((vp-up*bp)%ap,d)))
    N = matrix(Qh,rows).left_kernel()
    assert N.dimension() == 1
    sol = N.basis()[0]
    up=Rh(list(sol[:nu])); vp=Rh(list(sol[nu:nu+nv])); wp=Rh(list(sol[nu+nv:]))
    lc=wp.leading_coefficient(); up/=lc; vp/=lc; wp/=lc
    wd=wp.degree()
    invrows=matrix(Qh,[vector(Qh,coeffs((up*X^i)%wp,wd)) for i in range(wd)])
    iv=vector(Qh,[1]+[0]*(wd-1))*invrows.inverse()
    ui=Rh(list(iv)); rp=(-vp*ui)%wp
    c1=minval((up*ui)%wp-1,wd)
    ident=up^2*fh-(vp^2-(-1)^d*ap*wp^2)
    c2=minval(ident,ident.degree()+1)
    c3=minval((fh-rp^2)%wp,wd)
    cert=min(c1,c2,c3)
    assert cert > 1000
    assert_reduced_input(wp,rp)
    return wp,rp,cert

def half_sum(ap,bp,a0,b0):
    assert_reduced_input(ap,bp)
    assert_reduced_input(a0,b0)
    da=ap.degree(); d0=a0.degree(); d=da+d0
    assert d <= 23 and gcd(ap,a0).degree() == 0
    assert gcd(a0,fh).degree() == 0
    sq=(-1)^d*keval(ap*a0,theta)
    assert sq.is_square()
    sp=theta_poly(sq.square_root())
    nu=ceil(QQ(d)/2); nv=g+floor(QQ(d)/2)+1; nw=g+1
    rows=[]
    for i in range(nu):
        up=X^i; vp=Rh(0); wp=Rh(0)
        rows.append(vector(Qh,coeffs((vp-wp*sp)%fh,23)
            +coeffs((vp-up*bp)%ap,da)+coeffs((vp-up*b0)%a0,d0)))
    for i in range(nv):
        up=Rh(0); vp=X^i; wp=Rh(0)
        rows.append(vector(Qh,coeffs((vp-wp*sp)%fh,23)
            +coeffs((vp-up*bp)%ap,da)+coeffs((vp-up*b0)%a0,d0)))
    for i in range(nw):
        up=Rh(0); vp=Rh(0); wp=X^i
        rows.append(vector(Qh,coeffs((vp-wp*sp)%fh,23)
            +coeffs((vp-up*bp)%ap,da)+coeffs((vp-up*b0)%a0,d0)))
    N=matrix(Qh,rows).left_kernel()
    assert N.dimension() == 1
    sol=N.basis()[0]
    up=Rh(list(sol[:nu])); vp=Rh(list(sol[nu:nu+nv])); wp=Rh(list(sol[nu+nv:]))
    lc=wp.leading_coefficient(); up/=lc; vp/=lc; wp/=lc
    wd=wp.degree()
    invrows=matrix(Qh,[vector(Qh,coeffs((up*X^i)%wp,wd)) for i in range(wd)])
    iv=vector(Qh,[1]+[0]*(wd-1))*invrows.inverse()
    ui=Rh(list(iv)); rp=(-vp*ui)%wp
    c1=minval((up*ui)%wp-1,wd)
    ident=up^2*fh-(vp^2-(-1)^d*ap*a0*wp^2)
    c2=minval(ident,ident.degree()+1)
    c3=minval((fh-rp^2)%wp,wd)
    cert=min(c1,c2,c3)
    assert cert > 1000
    assert_reduced_input(wp,rp)
    return wp,rp,cert

U1=Rh(U1Q); U9=Rh(U9Q); gA=Rh(gAQ); gB=Rh(gBQ)
d1e=(-1)^11*keval(U1,theta)
d9e=(-1)^11*keval(U9,theta)
ge=(-1)^11*keval(gA,theta)
def global_to_high(e):
    pe=e.polynomial()
    return sum(Kh(QQ(pe[i]))*ah^i for i in range(pe.degree()+1))
assert (d1e/global_to_high(d1)).is_square()
assert (d9e/global_to_high(d9)).is_square()
assert (ge/(d1e*d9e)).is_square()
repE=[Kh(1),d1e,d9e,ge]
repA=[Rh(1),U1,U9,gA]
repB=[Rh(0),Rh(2048),Rh(6144),gB]
for i in range(4):
    for j in range(i):
        assert not (repE[i]/repE[j]).is_square()

# A separate low-precision local field is sufficient for square/non-square
# decisions.  Rank 11 is rechecked here before the 2048 products are used.
Ql=Qp(2,240)
Rl.<u>=Ql[]
Kl.<al>=Ql.extension(u^23-2)
def low(z):
    return sum(Kl(Ql(c))*al^i for i,c in enumerate(z.polynomial().list()))
Wlow=[]
for e in Welts:
    pe=e.polynomial()
    Wlow.append(sum(Kl(QQ(pe[i]))*al^i for i in range(pe.degree()+1)))
Wprod=[Kl(1)]
for e in Wlow:
    assert not any((e/q).is_square() for q in Wprod)
    Wprod += [e*q for q in list(Wprod)]
assert len(Wprod) == 2048
def inW(z):
    zl=low(z)
    return any((zl/q).is_square() for q in Wprod)
def gammaidx(z):
    ans=[i for i,e in enumerate(repE) if (z/e).is_square()]
    assert len(ans) <= 1
    return ans[0] if ans else None
def chain(ap,bp):
    depth=0; cert=Infinity
    while depth <= 20:
        z=(-1)^ap.degree()*keval(ap,theta)
        idx=gammaidx(z)
        if idx is None:
            return depth,inW(z),cert
        if idx == 0:
            ap,bp,c=half_ab(ap,bp)
        else:
            ap,bp,c=half_sum(ap,bp,repA[idx],repB[idx])
        cert=min(cert,c); depth += 1
    raise RuntimeError('unexpected recursion depth')
def initial_divisor(xx,yy):
    ap=(X-Qh(xx))*(X+4)
    slope=(yy+2048)/(xx+4)
    bp=yy+slope*(X-xx)
    assert minval((fh-bp^2)%ap,2) > 1000
    return ap,bp

odds=list(range(1,32,2))
summ=[]
for m in range(3,6):
    mx=0; shellcert=Infinity
    for uu in odds:
        tt=2^m*uu
        xx=Qh(-4+4*tt)
        val=fh(xx)
        assert val.is_square()
        yy=val.square_root()
        if (yy/2048-1).valuation() < 2:
            yy=-yy
        ap,bp=initial_divisor(xx,yy)
        depth,terminal_in_W,cert=chain(ap,bp)
        print('M',m,'U',uu,'NU',depth,'TERMINAL_IN_W',terminal_in_W,
              'MIN_ID_VAL',cert,flush=True)
        assert depth == m+2 and not terminal_in_W
        mx=max(mx,depth); shellcert=min(shellcert,cert)
    summ.append(mx)
    print('SHELL_SUMMARY','M',m,'REPS',len(odds),'MAX_NU',mx,
          'MIN_ID_VAL',shellcert,flush=True)
assert 2*5-3 >= summ[-1]
print('TAIL_LEMMA_3_10','M',5,'BOUND',2*5-3,'MAX_NU',summ[-1],'PASS',True)
print('P23_STOLL_W3_OVERAPPROX_PASS',summ)
