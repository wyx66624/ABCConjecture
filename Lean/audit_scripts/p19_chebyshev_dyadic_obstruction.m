// Exact fixed-index p=19 dyadic Selmer-intersection obstruction.
// Magma V2.29-9.
//
// The GRH switch is used only to reproduce the 14 candidate representatives
// from p19_chebyshev_global_local.m inside the official 60-second calculator.
// Their completeness is deconditioned below exactly as in that frozen script:
// PARI bnfcertify gives class number one, the theoretical dimension is 14,
// and this script checks S-support and every nontrivial square relation.
// All local square tests and matrix ranks below are exact.

SetSeed(1);
SetClassGroupBounds("GRH");

Q := Rationals();
Qx<X> := PolynomialRing(Q);
F2 := GF(2);

fm := X^19 - 76*X^17 + 2432*X^15 - 42560*X^13 +
      442624*X^11 - 2782208*X^9 + 10272768*X^7 -
      20545536*X^5 + 18677760*X^3 - 4980736*X + 1310720;
U1 := X^9 - 2*X^8 - 32*X^7 + 56*X^6 + 336*X^5 -
      480*X^4 - 1280*X^3 + 1280*X^2 + 1280*X - 512;
U9 := X^9 + 2*X^8 - 32*X^7 - 56*X^6 + 336*X^5 +
      480*X^4 - 1280*X^3 - 1280*X^2 + 1280*X + 512;
assert fm - 512^2 eq (X + 4)*U1^2;
assert fm - 1536^2 eq (X - 4)*U9^2;

// Seven additional closed dyadic points.  For each polynomial h, the field
// Q(beta) has a unique prime over 2 and fm(beta) is a square in its completion.
h3 := X^5 - 185*X^4 + 37170*X^3 - 7104250*X^2 +
      760006225*X - 16597164509;
h4 := X^5 + 6940*X^3 - 1899520*X^2 - 106221680*X -
      13680418896;
h5 := X^6 + 180*X^5 + 21348*X^4 + 11527776*X^3 +
      1320882288*X^2 + 136720457280*X + 5573570416576;
h6 := X^5 - 80*X^4 + 5560*X^3 - 53360*X^2 +
      13991360*X - 49066816;
h7 := X^5 - 100*X^4 + 6480*X^3 - 500960*X^2 +
      8587840*X - 449775424;
h8 := X^5 - 80*X^4 + 4880*X^3 - 314240*X^2 +
      24531680*X - 980471440;
h9 := X^7 - 252*X^5 + 135856*X^4 - 3461920*X^3 +
      136310720*X^2 - 1479802688*X + 26132215488;

// Reconstruct and decondition the global K(S,2) basis.
K<a> := NumberField(X^19 - 2);
O := MaximalOrder(K);
Sset := {};
for p in [2, 3, 19] do
    for z in Factorization(p*O) do
        Include(~Sset, z[1]);
    end for;
end for;
G, gm := pSelmerGroup(2, Sset);
reps := [G.i @@ gm : i in [1..Ngens(G)]];
assert Ngens(G) eq 14 and #Sset eq 4;

supportOK := true;
for r in reps do
    for z in Factorization(r*O) do
        if (z[2] mod 2 ne 0) and (not z[1] in Sset) then
            supportOK := false;
        end if;
    end for;
end for;
indep := true;
badmask := 0;
for mask in [1..2^#reps - 1] do
    pr := K!1;
    for i in [1..#reps] do
        if ((mask div 2^(i - 1)) mod 2) eq 1 then pr *:= reps[i]; end if;
    end for;
    if IsSquare(pr) then
        indep := false;
        badmask := mask;
        break;
    end if;
end for;
assert supportOK and indep;
printf "GLOBAL_DIM=14 S_SIZE=4 S_SUPPORT=%o INDEPENDENT=%o BADMASK=%o\n",
       supportOK, indep, badmask;

// Impose the rational norm-square and complete Q_3 Kummer conditions.
d1 := a - 1;
d9 := 3*(a + 1);
normrows := [];
for r in reps do
    nr := Norm(r);
    sgn := nr lt 0 select F2!1 else F2!0;
    Append(~normrows,
      [sgn,
       F2!(Integers()!(Valuation(nr, 2) mod 2)),
       F2!(Integers()!(Valuation(nr, 3) mod 2)),
       F2!(Integers()!(Valuation(nr, 19) mod 2))]);
end for;
NM := Matrix(F2, normrows);

dec3 := Factorization(3*O);
lmaps3 := [LocalTwoSelmerMap(z[1]) : z in dec3];
LM3 := Matrix(F2,
  [&cat[[F2!b : b in Eltseq(lm(r))] : lm in lmaps3] : r in reps]);
ld9 := Vector(F2,
  &cat[[F2!b : b in Eltseq(lm(d9))] : lm in lmaps3]);

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
d1coord := Vector(F2, [F2!b : b in Eltseq(gm(d1))]);
d9coord := Vector(F2, [F2!b : b in Eltseq(gm(d9))]);
assert Dimension(W3) eq 9;
assert WB[1] eq d1coord and WB[9] eq d9coord;
printf "NORM_RANK=%o W3_DIM=%o COUNTS=%o\nW3_BASIS=%o\n",
       Rank(NM), Dimension(W3), #valid3, WB;
printf "W3_ENDPOINTS_ARE_D1_D9=true\n";

Wglobal := [];
for c in WB do
    rr := K!1;
    for i in [1..n] do
        if c[i] eq 1 then rr *:= reps[i]; end if;
    end for;
    Append(~Wglobal, rr);
end for;

// Verify the remaining non-dyadic conditions at 19 and infinity.
dec19 := Factorization(19*O);
decType19 := [<RamificationDegree(z[1]), InertiaDegree(z[1]), z[2]>
              : z in dec19];
assert decType19 eq [<19,1,19>];
lmaps19 := [LocalTwoSelmerMap(z[1]) : z in dec19];
W19coords := Matrix(F2,
  [&cat[[F2!b : b in Eltseq(lm(r))] : lm in lmaps19] : r in Wglobal]);
realNormSquares := &and[Norm(r) gt 0 and IsSquare(Norm(r)) : r in Wglobal];
assert IsZero(W19coords) and realNormSquares;
printf "LOCAL19_DECOMPOSITION=%o LOCAL19_COORD_RANK=%o\n",
       decType19, Rank(W19coords);
printf "REAL_PLACE_NORM_SQUARES=%o\n", realNormSquares;

// Work in K_2.  theta is the monic-model root corresponding to a^19=2.
theta := -(2*a + a^18);
assert Qx!MinimalPolynomial(theta) eq fm;
dec2K := Factorization(2*O);
assert #dec2K eq 1;
P2 := dec2K[1][1];
assert RamificationDegree(P2) eq 19 and InertiaDegree(P2) eq 1 and
       dec2K[1][2] eq 19;
km2 := LocalTwoSelmerMap(P2);

// Independent audit of dim K_2^*/K_2^{*2}=21.
Bsq := [a] cat [1 + a^i : i in [1..37 by 2]] cat [1 + a^38];
HGram := Matrix(F2,
  [[HilbertSymbol(x, y, P2) eq -1 select F2!1 else F2!0
    : y in Bsq] : x in Bsq]);
assert #Bsq eq 21 and Rank(HGram) eq 21;
printf "LOCAL_SQUARECLASS_DIM=%o HILBERT_GRAM_RANK=%o\n",
       #Bsq, Rank(HGram);

// Certify the seven non-rational closed local points exactly.
Hclosed := [h3,h4,h5,h6,h7,h8,h9];
for h in Hclosed do
    L<b> := NumberField(h);
    OL := MaximalOrder(L);
    dec2 := Factorization(2*OL);
    assert #dec2 eq 1;
    PL := dec2[1][1];
    sm := LocalTwoSelmerMap(PL);
    sc := sm(Evaluate(fm,b));
    assert sc eq Codomain(sm)!0;
    printf "LOCAL_DIVISOR DEG=%o E=%o F=%o EXP=%o SQUARECLASS=%o\n",
           Degree(h), RamificationDegree(PL), InertiaDegree(PL),
           dec2[1][2], sc;
end for;

// Nine proved local divisor classes.  Their rank is the local index 9, so
// they are the complete Kummer image L_2.
H := [U1,U9] cat Hclosed;
Uloc := [(-1)^Degree(h)*Evaluate(h,theta) : h in H];
Ucoords := Matrix(F2,
  [[F2!b : b in Eltseq(km2(u))] : u in Uloc]);
Wcoords := Matrix(F2,
  [[F2!b : b in Eltseq(km2(w))] : w in Wglobal]);
assert Rank(Ucoords) eq 9 and Rank(Wcoords) eq 9;
printf "U_LOCAL_COORD_RANK=%o\nU_LOCAL_COORDS=%o\n",
       Rank(Ucoords), Ucoords;
printf "W_LOCAL_COORD_RANK=%o\nW_LOCAL_COORDS=%o\n",
       Rank(Wcoords), Wcoords;

// Direct row-space intersection.  The kernel is three-dimensional, not the
// expected two-plane: one extra coefficient vector survives.
Comb := VerticalJoin(Ucoords,Wcoords);
RU := RowSpace(Ucoords);
intersectionCoeffs := [];
Vw := VectorSpace(F2,#WB);
for mask in [0..2^#WB - 1] do
    c := Vw![F2!((mask div 2^(i - 1)) mod 2) : i in [1..#WB]];
    if c*Wcoords in RU then Append(~intersectionCoeffs,c); end if;
end for;
extra := Vw![0,1,1,1,0,0,1,1,0];
assert Rank(Comb) eq 15 and #intersectionCoeffs eq 8;
assert Vw!0 in intersectionCoeffs;
assert Vw.1 in intersectionCoeffs;
assert Vw.9 in intersectionCoeffs;
assert extra in intersectionCoeffs;
assert extra notin sub<Vw | Vw.1,Vw.9>;
assert sub<Vw | intersectionCoeffs> eq sub<Vw | Vw.1,Vw.9,extra>;
printf "COMBINED_LOCAL_RANK=%o QUOTIENT_RANK=%o INTERSECTION_DIM=%o\n",
       Rank(Comb), Rank(Comb)-Rank(Ucoords),
       Rank(Ucoords)+Rank(Wcoords)-Rank(Comb);
printf "INTERSECTION_COEFFS=%o\nEXTRA_W3_COEFF=%o\n",
       intersectionCoeffs, extra;

WBMatrix := Matrix(F2, [[F2!b : b in Eltseq(c)] : c in WB]);
extraGlobalCoord := extra*WBMatrix;
assert extraGlobalCoord eq
       Vector(F2,[0,1,1,1,0,1,0,1,1,0,0,0,0,1]);
printf "EXTRA_GLOBAL_G_COORD=%o\n", extraGlobalCoord;

// Exact bridge from the global pSelmerGroup basis to the small norm-one
// representative used by the Stoll-Gamma2 local computation.  Both products
// are formed inside K from the very same frozen representatives above.
extraGlobalEltW := K!1;
for j in [1..#Wglobal] do
    if extra[j] eq 1 then extraGlobalEltW *:= Wglobal[j]; end if;
end for;
extraGlobalEltG := K!1;
for j in [1..#reps] do
    if extraGlobalCoord[j] eq 1 then extraGlobalEltG *:= reps[j]; end if;
end for;
wToGSquare, wToGRoot := IsSquare(extraGlobalEltW/extraGlobalEltG);
assert wToGSquare and wToGRoot^2*extraGlobalEltG eq extraGlobalEltW;
delta := -14*a^18 + 4*a^17 + 7*a^16 - 26*a^15 + 6*a^14
         + 4*a^13 - 21*a^12 + 2*a^11 + 10*a^10 - 8*a^9
         - 8*a^8 + 30*a^7 - 7*a^6 - 8*a^5 + 37*a^4
         - 8*a^3 - 7*a^2 + 20*a + 5;
assert Norm(delta) eq 1;
deltaSquare, deltaRoot := IsSquare(extraGlobalEltG/delta);
assert deltaSquare and deltaRoot^2*delta eq extraGlobalEltG;
printf "EXTRA_SMALL_REP_NORM=%o EXTRA_GLOBAL_OVER_SMALL_REP_IS_SQUARE=%o\n",
       Norm(delta), deltaSquare;
printf "EXTRA_W_PRODUCT_OVER_G_PRODUCT_IS_SQUARE=%o\n", wToGSquare;
printf "EXTRA_SMALL_REP=%o\n", delta;

// Hilbert/Tate-pairing cross-check: the restriction has rank six, and the
// two endpoint classes plus the displayed extra class are in its kernel.
SelfPair := Matrix(F2,
  [[HilbertSymbol(u,v,P2) eq -1 select F2!1 else F2!0
    : v in Uloc] : u in Uloc]);
Pair := Matrix(F2,
  [[HilbertSymbol(u,w,P2) eq -1 select F2!1 else F2!0
    : w in Wglobal] : u in Uloc]);
assert IsZero(SelfPair) and Rank(Pair) eq 6;
assert IsZero(Pair*Matrix(F2,9,1,Eltseq(Vw.1)));
assert IsZero(Pair*Matrix(F2,9,1,Eltseq(Vw.9)));
assert IsZero(Pair*Matrix(F2,9,1,Eltseq(extra)));
printf "KUMMER_SELF_PAIRING_RANK=%o PAIRING_RANK=%o\n",
       Rank(SelfPair), Rank(Pair);
printf "PAIRING_MATRIX=%o\n", Pair;
printf "DYADIC_KERNEL_BASIS=[D1,D9,EXTRA] DYADIC_KERNEL_DIM=3\n";
