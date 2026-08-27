// Complete single-disk certificate for Stoll, Theorem 2.1, with
// Gamma_1=<H1+H9> and Gamma_2=<H1,H9>.
//
// Curve: y^2=f(X), deg(f)=19.  Put T=X/4 and t=T+1.  The Pell branch
// X=-4 (mod 32) is exactly t in 8 Z_2.  We use P0=(-4,512) and the
// analytic y-branch through P0.  For D0=[P0-infinity]=-2H1 (certified in
// p19_extra_selmer_gamma_rational.m), the other branch satisfies
// i_P0(iota(P))=-i_P0(P)-2D0=-i_P0(P)+4H1.  Thus only Gamma_2 (which
// contains H1) gives the same coset and the same mod-2 q-set on both
// branches; Gamma_1 below is retained only as a positive-branch diagnostic.
//
// This script implements Lemma 2.4 literally.  At every node R it records
// the classes of R+T for all T in Gamma/2Gamma.  If one is zero, its half
// is unique because J(Q_2)[2]=0; Proposition 5.1 / Remark 5.2 constructs
// that half and recursion continues.  A terminal coset is asserted to be
// disjoint from the localized full 2-Selmer group.
//
// The 16 odd residues u mod 32 cover each shell v_2(t)=m.  If the measured
// maximum n_m is <=m+2, Corollary 3.2 says q is constant on each represented
// ball, since v(t-t0)>=m+5>=n_m+3.  Finally Lemma 3.10 is asserted at m=5:
// 2m-3>=n_{m,Gamma}.  Thus m=3,4 and the m=5 tail cover all t in 8Z_2.
// Magma V2.29-9.

SetSeed(1);

// Repeat the exact irreducibility certificate used by the global dyadic
// obstruction script; do not infer it from a high-precision zero test.
QQz<zq> := PolynomialRing(Rationals());
Kexact<ae> := NumberField(zq^19-2);
thetaExact := -(2*ae+ae^18);
fmExact := zq^19-76*zq^17+2432*zq^15-42560*zq^13+442624*zq^11-
           2782208*zq^9+10272768*zq^7-20545536*zq^5+18677760*zq^3-
           4980736*zq+1310720;
mpTheta := MinimalPolynomial(thetaExact);
assert Degree(mpTheta) eq 19;
assert Coefficients(mpTheta) eq Coefficients(fmExact);

prec := 4000;
Q2 := pAdicField(2,prec);
Q2x<x> := PolynomialRing(Q2);

fm := x^19-76*x^17+2432*x^15-42560*x^13+442624*x^11-
      2782208*x^9+10272768*x^7-20545536*x^5+18677760*x^3-
      4980736*x+1310720;
C := HyperellipticCurve(fm);
J := Jacobian(C);

// On the integral characteristic-two model z^2+z=Cheb_19(T)+1,
// partial/partial z is identically 1.  Hence t=T+1 is a parameter on a
// smooth residue disk, as required in Sections 3 and 3.10 of Stoll.
F2tz<t,z> := PolynomialRing(GF(2),2);
assert Derivative(z^2+z,2) eq F2tz!1;

K2<a> := ext<Q2 | x^19-2>;
theta := -(2*a+a^18);
assert Valuation(Evaluate(fm,theta)) ge 1800;

function Pad(s,n,z0)
    return s cat [z0 : i in [#s+1..n]];
end function;

function EvalAt(poly,z0)
    return &+[K2!Coefficient(poly,i)*z0^i : i in [0..Degree(poly)]];
end function;

thetaRows := Matrix(Q2,
    [Pad(Eltseq(theta^i),19,Q2!0) : i in [0..18]]);
assert Determinant(thetaRows) ne 0;
thetaRowsInv := thetaRows^-1;

function ThetaPolynomial(z0)
    zv := Vector(Q2,Pad(Eltseq(z0),19,Q2!0));
    cv := zv*thetaRowsInv;
    s := Q2x![cv[i] : i in [1..19]];
    assert Valuation(EvalAt(s,theta)-z0) ge 1600;
    return s;
end function;

function CoeffVector(poly,n)
    return [Coefficient(poly,i) : i in [0..n-1]];
end function;

function MinCoeffVal(poly,n)
    return Min([Valuation(Coefficient(poly,i)) : i in [0..n-1]]);
end function;

// Stoll Proposition 5.1, coprime squarefree case.
function HalfAB(ap,bp)
    d := Degree(ap);
    assert IsMonic(ap) and d lt 19;
    assert Degree(GCD(ap,Derivative(ap))) eq 0;
    sqval := EvalAt((-1)^d*ap,theta);
    ok,sroot := IsSquare(sqval);
    assert ok;
    sp := ThetaPolynomial(sroot);
    assert Valuation(EvalAt((sp^2-(-1)^d*ap) mod fm,theta)) ge 1400;

    nu := Ceiling(d/2);
    nv := 9+Floor(d/2)+1;
    nw := 10;
    cols := [];
    for i in [0..nu-1] do
        up := x^i; vp := Q2x!0; wp := Q2x!0;
        Append(~cols,Vector(Q2,
            CoeffVector((vp-wp*sp) mod fm,19) cat
            CoeffVector((vp-up*bp) mod ap,d)));
    end for;
    for i in [0..nv-1] do
        up := Q2x!0; vp := x^i; wp := Q2x!0;
        Append(~cols,Vector(Q2,
            CoeffVector((vp-wp*sp) mod fm,19) cat
            CoeffVector((vp-up*bp) mod ap,d)));
    end for;
    for i in [0..nw-1] do
        up := Q2x!0; vp := Q2x!0; wp := x^i;
        Append(~cols,Vector(Q2,
            CoeffVector((vp-wp*sp) mod fm,19) cat
            CoeffVector((vp-up*bp) mod ap,d)));
    end for;

    N := Nullspace(Matrix(cols));
    assert Dimension(N) eq 1;
    sol := Basis(N)[1];
    up := Q2x![sol[i+1] : i in [0..nu-1]];
    vp := Q2x![sol[nu+i+1] : i in [0..nv-1]];
    wp := Q2x![sol[nu+nv+i+1] : i in [0..nw-1]];
    lc := LeadingCoefficient(wp);
    assert lc ne 0;
    wd := Degree(wp);
    up /:= lc; vp /:= lc;
    wp := x^wd+&+[Coefficient(wp,i)/lc*x^i : i in [0..wd-1]];

    invrows := Matrix([Vector(Q2,CoeffVector((up*x^i) mod wp,wd))
                       : i in [0..wd-1]]);
    iv := Vector(Q2,[1] cat [0 : i in [2..wd]])*invrows^-1;
    ui := Q2x![iv[i] : i in [1..wd]];
    assert MinCoeffVal((up*ui mod wp)-1,wd) ge 300;
    rp := (-vp*ui) mod wp;
    rel := up^2*fm-(vp^2-(-1)^d*ap*wp^2);
    assert MinCoeffVal(rel,Degree(rel)+1) ge 200;
    assert MinCoeffVal((fm-rp^2) mod wp,Degree(wp)) ge 200;
    return wp,rp;
end function;

// Stoll Remark 5.2: halve [ap,bp]+[a0,b0] without first adding them.
function HalfSumAB(ap,bp,a0,b0)
    da := Degree(ap); d0 := Degree(a0); d := da+d0;
    assert d le 19 and IsMonic(ap) and IsMonic(a0);
    assert Degree(GCD(ap,Derivative(ap))) eq 0;
    assert Degree(GCD(a0,Derivative(a0))) eq 0;
    assert Degree(GCD(ap,a0)) eq 0;
    sqval := EvalAt((-1)^d*ap*a0,theta);
    ok,sroot := IsSquare(sqval);
    assert ok;
    sp := ThetaPolynomial(sroot);
    assert Valuation(EvalAt((sp^2-(-1)^d*ap*a0) mod fm,theta)) ge 1200;

    nu := Ceiling(d/2);
    nv := 9+Floor(d/2)+1;
    nw := 10;
    cols := [];
    for i in [0..nu-1] do
        up := x^i; vp := Q2x!0; wp := Q2x!0;
        Append(~cols,Vector(Q2,
            CoeffVector((vp-wp*sp) mod fm,19) cat
            CoeffVector((vp-up*bp) mod ap,da) cat
            CoeffVector((vp-up*b0) mod a0,d0)));
    end for;
    for i in [0..nv-1] do
        up := Q2x!0; vp := x^i; wp := Q2x!0;
        Append(~cols,Vector(Q2,
            CoeffVector((vp-wp*sp) mod fm,19) cat
            CoeffVector((vp-up*bp) mod ap,da) cat
            CoeffVector((vp-up*b0) mod a0,d0)));
    end for;
    for i in [0..nw-1] do
        up := Q2x!0; vp := Q2x!0; wp := x^i;
        Append(~cols,Vector(Q2,
            CoeffVector((vp-wp*sp) mod fm,19) cat
            CoeffVector((vp-up*bp) mod ap,da) cat
            CoeffVector((vp-up*b0) mod a0,d0)));
    end for;

    N := Nullspace(Matrix(cols));
    assert Dimension(N) eq 1;
    sol := Basis(N)[1];
    up := Q2x![sol[i+1] : i in [0..nu-1]];
    vp := Q2x![sol[nu+i+1] : i in [0..nv-1]];
    wp := Q2x![sol[nu+nv+i+1] : i in [0..nw-1]];
    lc := LeadingCoefficient(wp);
    assert lc ne 0;
    wd := Degree(wp);
    up /:= lc; vp /:= lc;
    wp := x^wd+&+[Coefficient(wp,i)/lc*x^i : i in [0..wd-1]];

    invrows := Matrix([Vector(Q2,CoeffVector((up*x^i) mod wp,wd))
                       : i in [0..wd-1]]);
    iv := Vector(Q2,[1] cat [0 : i in [2..wd]])*invrows^-1;
    ui := Q2x![iv[i] : i in [1..wd]];
    assert MinCoeffVal((up*ui mod wp)-1,wd) ge 300;
    rp := (-vp*ui) mod wp;
    rel := up^2*fm-(vp^2-(-1)^d*ap*a0*wp^2);
    assert MinCoeffVal(rel,Degree(rel)+1) ge 200;
    assert MinCoeffVal((fm-rp^2) mod wp,Degree(wp)) ge 200;
    return wp,rp;
end function;

// Exact rational Mumford representatives.
U1 := x^9-2*x^8-32*x^7+56*x^6+336*x^5-480*x^4-
      1280*x^3+1280*x^2+1280*x-512;
U9 := x^9+2*x^8-32*x^7-56*x^6+336*x^5+480*x^4-
      1280*x^3-1280*x^2+1280*x+512;
gA := x^9-x^8-32*x^7+28*x^6+336*x^5-240*x^4-
      1280*x^3+640*x^2+1280*x-256;
gB := -3*x^8+84*x^6-720*x^4+1920*x^2-768;

d1elt := EvalAt((-1)^Degree(U1)*U1,theta);
d9elt := EvalAt((-1)^Degree(U9)*U9,theta);
gelt := EvalAt((-1)^Degree(gA)*gA,theta);
assert IsSquare(gelt/(d1elt*d9elt));
assert not IsSquare(d1elt) and not IsSquare(d9elt) and not IsSquare(gelt);

// Localized extra Selmer generator and the full localized Selmer subgroup.
extraelt := -14*a^18+4*a^17+7*a^16-26*a^15+6*a^14+4*a^13-
            21*a^12+2*a^11+10*a^10-8*a^9-8*a^8+30*a^7-7*a^6-
            8*a^5+37*a^4-8*a^3-7*a^2+20*a+5;
globalElts := [K2!1,d1elt,d9elt,d1elt*d9elt,extraelt,
               extraelt*d1elt,extraelt*d9elt,extraelt*d1elt*d9elt];
for i in [1..#globalElts] do
    for j in [i+1..#globalElts] do
        assert not IsSquare(globalElts[i]/globalElts[j]);
    end for;
end for;

function InGlobalSelmer(z0)
    for h in globalElts do
        if IsSquare(z0/h) then return true; end if;
    end for;
    return false;
end function;

function FindGammaClass(z0,repElts)
    ans := 0;
    for i in [1..#repElts] do
        if IsSquare(z0/repElts[i]) then
            assert ans eq 0;
            ans := i;
        end if;
    end for;
    return ans;
end function;

// Return sup nu(R+Gamma) and one terminal primitive square class.
function GammaChain(ap,bp,repElts,repAs,repBs)
    depth := 0;
    while depth le 20 do
        z0 := EvalAt((-1)^Degree(ap)*ap,theta);
        idx := FindGammaClass(z0,repElts);
        if idx eq 0 then
            // The terminal q-layer is z0*im(Gamma); since im(Gamma) is
            // contained in loc(Sel_2), this entire coset is disjoint from
            // loc(Sel_2) exactly when z0 is not itself in loc(Sel_2).
            assert not InGlobalSelmer(z0);
            return depth,z0;
        end if;
        // Exactly one of R+T, T in Gamma/2Gamma, is divisible by two.
        if idx eq 1 then
            ap,bp := HalfAB(ap,bp);
        else
            ap,bp := HalfSumAB(ap,bp,repAs[idx],repBs[idx]);
        end if;
        depth +:= 1;
    end while;
    assert false;
    return 0,K2!0;
end function;

// Frozen nine-dimensional local Kummer basis, used only to print the two
// requested primitive sample classes in fully explicit coordinates.
h3 := x^5-185*x^4+37170*x^3-7104250*x^2+760006225*x-16597164509;
h4 := x^5+6940*x^3-1899520*x^2-106221680*x-13680418896;
h5 := x^6+180*x^5+21348*x^4+11527776*x^3+1320882288*x^2+
      136720457280*x+5573570416576;
h6 := x^5-80*x^4+5560*x^3-53360*x^2+13991360*x-49066816;
h7 := x^5-100*x^4+6480*x^3-500960*x^2+8587840*x-449775424;
h8 := x^5-80*x^4+4880*x^3-314240*x^2+24531680*x-980471440;
h9 := x^7-252*x^5+135856*x^4-3461920*x^3+136310720*x^2-
      1479802688*x+26132215488;
HB := [U1,U9,h3,h4,h5,h6,h7,h8,h9];
Uloc := [EvalAt((-1)^Degree(h)*h,theta) : h in HB];
V := VectorSpace(GF(2),9);

function LocalCoordinates(z0)
    ans := [];
    for mask in [0..511] do
        c := V![GF(2)!((mask div 2^(i-1)) mod 2) : i in [1..9]];
        w := K2!1;
        for i in [1..9] do
            if c[i] eq 1 then w *:= Uloc[i]; end if;
        end for;
        if IsSquare(z0/w) then Append(~ans,c); end if;
    end for;
    assert #ans eq 1;
    return ans[1];
end function;

assert LocalCoordinates(gelt) eq V.1+V.2;
assert LocalCoordinates(extraelt) eq V.6+V.8+V.9;

P0 := C![Q2!-4,Q2!512,1];
oddUnits := [u : u in [1..31] | IsOdd(u)];
assert #oddUnits eq 16;

// Gamma/2Gamma data.  Index 1 is zero; the remaining entries give an
// actual Mumford representative for the corresponding local class.
repElts1 := [K2!1,gelt];
repAs1 := [Q2x!1,gA];
repBs1 := [Q2x!0,gB];
repElts2 := [K2!1,d1elt,d9elt,gelt];
repAs2 := [Q2x!1,U1,U9,gA];
repBs2 := [Q2x!0,Q2x!512,Q2x!1536,gB];

for gammaRank in [2] do
    if gammaRank eq 1 then
        repElts := repElts1; repAs := repAs1; repBs := repBs1;
        print "GAMMA_RANK=1 IMAGE={000000000,110000000}";
    else
        repElts := repElts2; repAs := repAs2; repBs := repBs2;
        print "GAMMA_RANK=2 IMAGE={000000000,100000000,010000000,110000000}";
    end if;

    shellMax := [];
    for m in [3..5] do
        maxnu := 0;
        for u in oddUnits do
            tt := 2^m*u;
            XX := -4+4*tt;
            ok,yy := IsSquare(Q2!Evaluate(fm,XX));
            assert ok;
            if Valuation(yy/512-1) lt 2 then yy := -yy; end if;
            assert Valuation(yy/512-1) ge 2;
            PP := C![Q2!XX,yy,1];
            DD := J![PP,P0];
            nu,terminal := GammaChain(DD[1],DD[2],repElts,repAs,repBs);
            // A positive depth certifies that the initial Lemma 2.4 layer
            // is A itself; the terminal layer is disjoint from loc(Sel_2).
            assert nu gt 0;
            assert nu le m+2;
            maxnu := Max(maxnu,nu);
            printf "RANK=%o M=%o UNIT_MOD32=%o X=%o NU_GAMMA=%o ",
                   gammaRank,m,u,XX,nu;
            if gammaRank eq 1 then
                print "Q_CAP_LOCSEL={000000000,110000000}";
            else
                print "Q_CAP_LOCSEL={000000000,100000000,010000000,110000000}";
            end if;
            if m eq 3 and (u eq 1 or u eq 3) then
                printf "SPECIAL_X=%o TERMINAL_PRIMITIVE_COORD=%o\n",
                       XX,LocalCoordinates(terminal);
            end if;
        end for;
        Append(~shellMax,maxnu);
        printf "SHELL_SUMMARY RANK=%o M=%o UNIT_MODULUS=32 REPS=16 MAX_NU=%o\n",
               gammaRank,m,maxnu;
        assert maxnu le m+2;
    end for;

    // Lemma 3.10 tail condition at m=5.  Gamma cap 2J(Q2)=2Gamma follows
    // from independence of the displayed primitive Gamma images.
    assert 2*5-3 ge shellMax[3];
    printf "TAIL_LEMMA_3_10 RANK=%o M_TAIL=5 BOUND=%o MAX_NU=%o PASS=true\n",
           gammaRank,2*5-3,shellMax[3];
    print "FULL_DISK_Q_CAP_LOCSEL_EQUALS_GAMMA_IMAGE";
end for;

print "P19_STOLL_GAMMA_FULL_DISK_CERTIFICATE_PASS";
