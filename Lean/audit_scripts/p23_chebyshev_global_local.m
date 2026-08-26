// Exploratory exact global/norm/Q_3 ledger for the p=23 Chebyshev curve.
// Magma V2.29-9.  The GRH switch is used only to generate representatives
// quickly.  The companion note records that an independent PARI bnfcertify
// attempt did not finish, so this script is a conditional pattern diagnostic.

SetSeed(1);
SetClassGroupBounds("GRH");

Q := Rationals();
Qx<X> := PolynomialRing(Q);
F2 := GF(2);
F3 := GF(3);
F3x<t3> := PolynomialRing(F3);
fac3 := Factorization(t3^23 - F3!2);
printf "MOD3_FACTOR_DEGREES=%o\n", [<Degree(z[1]), z[2]> : z in fac3];

K<a> := NumberField(X^23 - 2);
O := MaximalOrder(K);

Sset := {};
for p in [2, 3, 23] do
    for z in Factorization(p*O) do
        Include(~Sset, z[1]);
    end for;
end for;

G, gm := pSelmerGroup(2, Sset);
printf "GLOBAL_DIM=%o SIZE=%o INV=%o S_SIZE=%o\n",
       Ngens(G), #G, Invariants(G), #Sset;
reps := [G.i @@ gm : i in [1..Ngens(G)]];

d1 := a - 1;
d9 := 3*(a + 1);
printf "D1=%o D9=%o\n", gm(d1), gm(d9);

normrows := [];
for r in reps do
    nr := Norm(r);
    sgn := nr lt 0 select F2!1 else F2!0;
    Append(~normrows,
      [sgn,
       F2!(Integers()!(Valuation(nr, 2) mod 2)),
       F2!(Integers()!(Valuation(nr, 3) mod 2)),
       F2!(Integers()!(Valuation(nr, 23) mod 2))]);
end for;
NM := Matrix(F2, normrows);

dec3 := Factorization(3*O);
lmaps := [LocalTwoSelmerMap(z[1]) : z in dec3];
localrows := [];
for r in reps do
    Append(~localrows, &cat[[F2!z : z in Eltseq(lm(r))] : lm in lmaps]);
end for;
LM := Matrix(F2, localrows);
ld1 := Vector(F2, &cat[[F2!z : z in Eltseq(lm(d1))] : lm in lmaps]);
ld9 := Vector(F2, &cat[[F2!z : z in Eltseq(lm(d9))] : lm in lmaps]);
L3 := sub<VectorSpace(F2, Ncols(LM)) | ld1, ld9>;

n := Ngens(G);
V := VectorSpace(F2, n);
ZN := Zero(VectorSpace(F2, Ncols(NM)));
validNorm := [];
valid3 := [];
for mask in [0..2^n - 1] do
    c := V![F2!((mask div 2^(i - 1)) mod 2) : i in [1..n]];
    if c*NM eq ZN then
        Append(~validNorm, c);
        if c*LM in L3 then Append(~valid3, c); end if;
    end if;
end for;
WN := sub<V | validNorm>;
W3 := sub<V | valid3>;

printf "NORM_RANK=%o NORM_KERNEL_DIM=%o\n", Rank(NM), Dimension(WN);
printf "LOCAL3_AMBIENT_DIM=%o LOCAL3_RANK=%o D1_LOCAL=%o D9_LOCAL=%o L3_DIM=%o\n",
       Ncols(LM), Rank(LM), ld1, ld9, Dimension(L3);
printf "AFTER_Q3_DIM=%o COUNTS=%o,%o\n",
       Dimension(W3), #validNorm, #valid3;
