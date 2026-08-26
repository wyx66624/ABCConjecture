// Exploratory exact global/norm/Q_3 ledger for the p=19 Chebyshev curve.
// Magma V2.29-9.  The GRH switch is used only to generate representatives
// quickly; the class group of Q(2^(1/19)) is independently certified by PARI.

SetSeed(1);
SetClassGroupBounds("GRH");

Q := Rationals();
Qx<X> := PolynomialRing(Q);
F2 := GF(2);
F3 := GF(3);
F3x<t3> := PolynomialRing(F3);
fac3 := Factorization(t3^19 - F3!2);
printf "MOD3_FACTOR_DEGREES=%o\n", [<Degree(z[1]), z[2]> : z in fac3];

K<a> := NumberField(X^19 - 2);
O := MaximalOrder(K);

Sset := {};
for p in [2, 3, 19] do
    for z in Factorization(p*O) do
        Include(~Sset, z[1]);
    end for;
end for;

G, gm := pSelmerGroup(2, Sset);
printf "GLOBAL_DIM=%o SIZE=%o INV=%o S_SIZE=%o\n",
       Ngens(G), #G, Invariants(G), #Sset;
reps := [G.i @@ gm : i in [1..Ngens(G)]];

// Decondition the candidate basis.  The separate PARI certificate proves
// class number one, so the S-unit theorem gives dim K(S,2)=14.  Here we
// check exact S-support and all 2^14-1 possible square relations.
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
printf "REPRESENTATIVES_S_SUPPORTED=%o NO_NONTRIVIAL_SQUARE_PRODUCT=%o BADMASK=%o\n",
       supportOK, indep, badmask;

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
       F2!(Integers()!(Valuation(nr, 19) mod 2))]);
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

n := Ngens(G);
V := VectorSpace(F2, n);
ZN := Zero(VectorSpace(F2, Ncols(NM)));
ZL := Zero(VectorSpace(F2, Ncols(LM)));
validNorm := [];
valid3 := [];
for mask in [0..2^n - 1] do
    c := V![F2!((mask div 2^(i - 1)) mod 2) : i in [1..n]];
    if c*NM eq ZN then
        Append(~validNorm, c);
        ell3 := c*LM;
        if ell3 eq ZL or ell3 eq ld9 then
            Append(~valid3, c);
        end if;
    end if;
end for;
WN := sub<V | validNorm>;
W3 := sub<V | valid3>;

printf "NORM_RANK=%o NORM_KERNEL_DIM=%o\n", Rank(NM), Dimension(WN);
printf "LOCAL3_AMBIENT_DIM=%o LOCAL3_RANK=%o D1_LOCAL=%o D9_LOCAL=%o\n",
       Ncols(LM), Rank(LM), ld1, ld9;
printf "AFTER_Q3_DIM=%o COUNTS=%o,%o\n",
       Dimension(W3), #validNorm, #valid3;
