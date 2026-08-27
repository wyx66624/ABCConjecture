// Exact fixed-index p=17 dyadic Kummer and Selmer-intersection certificate.
// Magma V2.29-9.
//
// The GRH switch below is used only to reproduce, within the official web
// calculator's time limit, the 13 representatives already certified in
// p17_chebyshev_global_local.m.  Completeness of that global basis is
// unconditional: p17_chebyshev_class_cert.gp returns bnfcertify=1, and the
// frozen global script checks S-support and all 8191 nontrivial products.
// The new local computations and all matrix ranks in this file are exact.

SetSeed(1);
SetClassGroupBounds("GRH");

Q := Rationals();
Qx<X> := PolynomialRing(Q);
F2 := GF(2);

fm := X^17 - 68*X^15 + 1904*X^13 - 28288*X^11 +
      239360*X^9 - 1148928*X^7 + 2924544*X^5 -
      3342336*X^3 + 1114112*X + 327680;
U1 := X^8 - 2*X^7 - 28*X^6 + 48*X^5 + 240*X^4 -
      320*X^3 - 640*X^2 + 512*X + 256;
U9 := X^8 + 2*X^7 - 28*X^6 - 48*X^5 + 240*X^4 +
      320*X^3 - 640*X^2 - 512*X + 256;

// Reconstruct the unconditional eight-dimensional survivor W3 from the
// frozen global/norm/Q_3 certificate.
KF<th> := NumberField(fm);
OF := MaximalOrder(KF);
Sset := {};
for p in [2, 3, 17] do
    for z in Factorization(p*OF) do
        Include(~Sset, z[1]);
    end for;
end for;
G, gm := pSelmerGroup(2, Sset);
reps := [G.i @@ gm : i in [1..Ngens(G)]];

normrows := [];
for r in reps do
    nr := Norm(r);
    sgn := nr lt 0 select F2!1 else F2!0;
    Append(~normrows,
      [sgn,
       F2!(Integers()!(Valuation(nr, 2) mod 2)),
       F2!(Integers()!(Valuation(nr, 3) mod 2)),
       F2!(Integers()!(Valuation(nr, 17) mod 2))]);
end for;
NM := Matrix(F2, normrows);

d1F := Evaluate(U1, th);
d9F := Evaluate(U9, th);
dec3 := Factorization(3*OF);
lmaps3 := [LocalTwoSelmerMap(z[1]) : z in dec3];
LM3 := Matrix(F2,
  [&cat[[F2!b : b in Eltseq(lm(r))] : lm in lmaps3] : r in reps]);
ld9 := Vector(F2,
  &cat[[F2!b : b in Eltseq(lm(d9F))] : lm in lmaps3]);

n := Ngens(G);
Vg := VectorSpace(F2, n);
ZN := Zero(VectorSpace(F2, Ncols(NM)));
Z3 := Zero(VectorSpace(F2, Ncols(LM3)));
valid3 := [];
for mask in [0..2^n - 1] do
    c := Vg![F2!((mask div 2^(i - 1)) mod 2) : i in [1..n]];
    if c*NM eq ZN and (c*LM3 eq Z3 or c*LM3 eq ld9) then
        Append(~valid3, c);
    end if;
end for;
W3 := sub<Vg | valid3>;
WB := Basis(W3);
d1coord := Vector(F2, [F2!b : b in Eltseq(gm(d1F))]);
d9coord := Vector(F2, [F2!b : b in Eltseq(gm(d9F))]);
assert Dimension(W3) eq 8;
assert WB[1] eq d1coord and WB[8] eq d9coord;
printf "GLOBAL_DIM=%o W3_DIM=%o\nW3_BASIS=%o\n",
       n, Dimension(W3), WB;
printf "W3_ENDPOINTS_ARE_D1_D9=true\n";

// The two remaining non-dyadic conditions are automatic, but verify them
// explicitly.  At 17 there is one totally ramified degree-17 factor, so the
// odd-prime local Kummer image has dimension r-1=0.  Every W3 basis vector
// has zero LocalTwoSelmerMap coordinate.  At the unique real embedding, the
// complex factors contribute positive norms; the norm-square condition
// therefore forces a positive real component, hence a real square.
Wglobal := [];
for c in WB do
    rr := KF!1;
    for i in [1..n] do
        if c[i] eq 1 then rr *:= reps[i]; end if;
    end for;
    Append(~Wglobal,rr);
end for;
dec17 := Factorization(17*OF);
decType17 := [<RamificationDegree(z[1]),InertiaDegree(z[1]),z[2]>
              : z in dec17];
assert decType17 eq [<17,1,17>];
lmaps17 := [LocalTwoSelmerMap(z[1]) : z in dec17];
W17coords := Matrix(F2,
  [&cat[[F2!b : b in Eltseq(lm(r))] : lm in lmaps17] : r in Wglobal]);
realNormSquares := &and[Norm(r) gt 0 and IsSquare(Norm(r)) : r in Wglobal];
assert IsZero(W17coords) and realNormSquares;
printf "LOCAL17_DECOMPOSITION=%o LOCAL17_COORD_RANK=%o\n",
       decType17, Rank(W17coords);
printf "REAL_PLACE_NORM_SQUARES=%o\n", realNormSquares;

// Use the simpler isomorphic root field K=Q(a), a^17=2.  The exact element
// theta=-(2a+a^16) is a root of fm and generates the same completion at 2.
K<a> := NumberField(X^17 - 2);
OK := MaximalOrder(K);
P2 := Factorization(2*OK)[1][1];
theta := -(2*a + a^16);
assert Evaluate(fm, theta) eq 0;
phi := hom<KF -> K | theta>;

Wloc := [phi(r) : r in Wglobal];

// The 19 elements below form a basis of K_2^*/K_2^{*2}: the standard
// dimension is 17+2=19, and their exact Hilbert-symbol Gram matrix has full
// rank.  This is an independent audit of the local coordinate dimension.
Bsq := [a] cat [1 + a^i : i in [1..33 by 2]] cat [1 + a^34];
HGram := Matrix(F2,
  [[HilbertSymbol(x, y, P2) eq -1 select F2!1 else F2!0
    : y in Bsq] : x in Bsq]);
assert #Bsq eq 19 and Rank(HGram) eq 19;
printf "LOCAL_SQUARECLASS_DIM=%o HILBERT_GRAM_RANK=%o\n",
       #Bsq, Rank(HGram);

// Five exact closed local points, in addition to the two rational Mumford
// divisors U1,U9.  If h is monic of degree d and beta is a root with
// fm(beta) square, its Kummer value is (-1)^d h(theta).
h3 := X^5 - 100*X^4 + 14360*X^3 - 599840*X^2 +
      34618240*X - 220850624;
h4 := X^5 - 185*X^4 + 37170*X^3 - 7104250*X^2 +
      760006225*X - 16597164509;
h5 := X^5 + 6940*X^3 - 1899520*X^2 - 106221680*X -
      13680418896;
h6 := X^5 - 300*X^4 + 21120*X^3 + 2063600*X^2 +
      183837760*X - 7615171648;
h7 := X^6 + 180*X^5 + 21348*X^4 + 11527776*X^3 +
      1320882288*X^2 + 136720457280*X + 5573570416576;

for h in [h3,h4,h5,h6,h7] do
    L<b> := NumberField(h);
    OL := MaximalOrder(L);
    dec2 := Factorization(2*OL);
    assert #dec2 eq 1;
    PL := dec2[1][1];
    sm := LocalTwoSelmerMap(PL);
    sc := sm(Evaluate(fm,b));
    assert sc eq Codomain(sm)!0;
    printf "LOCAL_DIVISOR DEG=%o E=%o F=%o SQUARECLASS=%o\n",
           Degree(h), RamificationDegree(PL), InertiaDegree(PL), sc;
end for;

// The eighth direction comes from a horizontal degree-four closed point.
// There is an exact identity fm-256^2=(X+4)U1^2.  Magma's certified Q_2
// factorization gives two irreducible quartics.  h8 and h8b are integral
// coefficient lifts of these factors modulo 2^40.
h8 := X^4 - 54965098776*X^3 + 109930197544*X^2 +
      439720790184*X - 16;
h8b := X^4 + 54965098774*X^3 - 109930197556*X^2 -
       439720790216*X - 16;
assert fm - 256^2 eq (X + 4)*U1^2;
pdiff := h8*h8b - U1;
vdiff := [Valuation(Integers()!Coefficient(pdiff,i),2) :
          i in [0..Degree(pdiff)] | Coefficient(pdiff,i) ne 0];
assert Minimum(vdiff) ge 40;

Q2 := pAdicField(2,40);
Q2x<t> := PolynomialRing(Q2);
facU1 := Factorization(Q2x!U1);
assert [Degree(z[1]) : z in facU1] eq [4,4];
function MatchMod(f,g,N)
    if Degree(f) ne Degree(g) then return false; end if;
    return &and[
      (Coefficient(f,i) - Q2!Coefficient(g,i) eq 0) or
      Valuation(Coefficient(f,i) - Q2!Coefficient(g,i)) ge N
      : i in [0..Degree(g)]];
end function;
match8 := &or[MatchMod(z[1],h8,40) : z in facU1];
match8b := &or[MatchMod(z[1],h8b,40) : z in facU1];
assert match8 and match8b;

// An exact decomposition check, independent of the displayed p-adic
// coefficients: the degree-eight number field defined by U1 has two primes
// over 2, both of local degree four.
LU<bU> := NumberField(U1);
OLU := MaximalOrder(LU);
decU2 := Factorization(2*OLU);
decType := [<RamificationDegree(z[1]),InertiaDegree(z[1]),z[2]>
            : z in decU2];
assert decType eq [<1,4,1>,<1,4,1>];

e2 := RamificationDegree(P2);
vtheta := Valuation(theta,P2);
vh8 := Valuation(Evaluate(h8,theta),P2);
errorBound := 40*e2;
ratioBound := errorBound-vh8;
assert e2 eq 17 and vtheta eq 16 and vh8 eq 64;
assert ratioBound eq 616 and ratioBound gt 2*e2;
printf "HORIZONTAL_IDENTITY=true PRODUCT_ERROR_MIN_V2=%o\n", Minimum(vdiff);
printf "Q2_U1_FACTORS=%o\n", facU1;
printf "Q2_U1_FACTOR_DEGREES=%o H8_MATCH=%o H8B_MATCH=%o\n",
       [Degree(z[1]) : z in facU1], match8, match8b;
printf "EXACT_U1_PRIME_DECOMPOSITION=%o\n", decType;
printf "E=%o VTHETA=%o VH8THETA=%o ERROR_BOUND=%o RATIO_ONE_BOUND=%o HENSEL_THRESHOLD=%o\n",
       e2, vtheta, vh8, errorBound, ratioBound, 2*e2;

// Eight local divisor Kummer classes and the eight localized W3 classes.
H := [U1,U9,h3,h4,h5,h6,h7,h8];
Uloc := [(-1)^Degree(h)*Evaluate(h,theta) : h in H];
km2 := LocalTwoSelmerMap(P2);
Ucoords := Matrix(F2,
  [[F2!b : b in Eltseq(km2(u))] : u in Uloc]);
Wcoords := Matrix(F2,
  [[F2!b : b in Eltseq(km2(w))] : w in Wloc]);
assert Rank(Ucoords) eq 8 and Rank(Wcoords) eq 8;
printf "U_LOCAL_COORD_RANK=%o\nU_LOCAL_COORDS=%o\n",
       Rank(Ucoords), Ucoords;
printf "W_LOCAL_COORD_RANK=%o\nW_LOCAL_COORDS=%o\n",
       Rank(Wcoords), Wcoords;

// Direct computation of loc(W3) intersect L2.  Since the standard local
// index formula gives dim J(Q_2)/2J(Q_2)=8, the independent U rows are the
// complete Kummer image L2.  The combined rank 14 gives intersection dim 2.
Comb := VerticalJoin(Ucoords,Wcoords);
RU := RowSpace(Ucoords);
intersectionCoeffs := [];
Vw := VectorSpace(F2,#WB);
for mask in [0..2^#WB - 1] do
    c := Vw![F2!((mask div 2^(i - 1)) mod 2) : i in [1..#WB]];
    if c*Wcoords in RU then Append(~intersectionCoeffs,c); end if;
end for;
assert Rank(Comb) eq 14 and #intersectionCoeffs eq 4;
assert Vw!0 in intersectionCoeffs;
assert Vw.1 in intersectionCoeffs;
assert Vw.8 in intersectionCoeffs;
assert Vw.1+Vw.8 in intersectionCoeffs;
printf "COMBINED_LOCAL_RANK=%o QUOTIENT_RANK=%o INTERSECTION_DIM=%o\n",
       Rank(Comb), Rank(Comb)-Rank(Ucoords),
       Rank(Ucoords)+Rank(Wcoords)-Rank(Comb);
printf "INTERSECTION_COEFFS=%o\n", intersectionCoeffs;

// Independent Hilbert/Tate-pairing cross-check.  The first and last columns
// correspond to D1 and D9 and vanish; the restriction has exact rank six.
SelfPair := Matrix(F2,
  [[HilbertSymbol(u,v,P2) eq -1 select F2!1 else F2!0
    : v in Uloc] : u in Uloc]);
Pair := Matrix(F2,
  [[HilbertSymbol(u,w,P2) eq -1 select F2!1 else F2!0
    : w in Wloc] : u in Uloc]);
assert IsZero(SelfPair) and Rank(Pair) eq 6;
printf "KUMMER_SELF_PAIRING=%o SELF_PAIRING_RANK=%o\n",
       SelfPair, Rank(SelfPair);
printf "PAIRING_MATRIX=%o\nPAIRING_RANK=%o\n", Pair, Rank(Pair);
printf "DYADIC_KERNEL_BASIS=[D1,D9] DYADIC_KERNEL_DIM=2\n";
