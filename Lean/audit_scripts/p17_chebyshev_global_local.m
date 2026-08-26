// Exact fixed-index p=17 global/norm/Q_3 ledger, Magma V2.29-9.
//
// SetClassGroupBounds("GRH") is used only to make Magma generate the
// squareclass representatives inside the official calculator's 60-second
// limit.  The corresponding class and fundamental-unit data for the same
// number field are certified independently and unconditionally by the PARI
// script p17_chebyshev_class_cert.gp (bnfcertify = 1).  No theorem in the
// companion note depends on GRH.

SetSeed(1);
SetClassGroupBounds("GRH");

Q := Rationals();
Qx<X> := PolynomialRing(Q);
F2 := GF(2);
F3 := GF(3);
F3x<t3> := PolynomialRing(F3);
fac3 := Factorization(t3^17 - F3!2);
printf "MOD3_FACTOR_DEGREES=%o\n",
       [<Degree(z[1]), z[2]> : z in fac3];

fm := X^17 - 68*X^15 + 1904*X^13 - 28288*X^11 +
      239360*X^9 - 1148928*X^7 + 2924544*X^5 -
      3342336*X^3 + 1114112*X + 327680;
K<a> := NumberField(fm);
O := MaximalOrder(K);

Sset := {};
for p in [2, 3, 17] do
    for t in Factorization(p*O) do
        Include(~Sset, t[1]);
    end for;
end for;

G, gm := pSelmerGroup(2, Sset);
printf "GLOBAL_DIM=%o SIZE=%o INV=%o\n",
       Ngens(G), #G, Invariants(G);
reps := [G.i @@ gm : i in [1..Ngens(G)]];

// Do not infer completeness of this Magma basis merely from the GRH switch.
// First verify directly that every representative is supported at S modulo
// even valuations.  Then exhaust all 2^13-1 nontrivial products and ask the
// number field, exactly, whether any product is a square.
supportOK := true;
for r in reps do
    for z in Factorization(r*O) do
        if (z[2] mod 2 ne 0) and (not z[1] in Sset) then
            supportOK := false;
        end if;
    end for;
end for;

CRM := Matrix(F2,
  [[F2!z : z in Eltseq(gm(r))] : r in reps]);
indep := true;
badmask := 0;
for mask in [1..2^#reps - 1] do
    pr := K!1;
    for i in [1..#reps] do
        if ((mask div 2^(i - 1)) mod 2) eq 1 then
            pr *:= reps[i];
        end if;
    end for;
    if IsSquare(pr) then
        indep := false;
        badmask := mask;
        break;
    end if;
end for;
printf "S_SIZE=%o REPRESENTATIVES_S_SUPPORTED=%o\n", #Sset, supportOK;
printf "REP_COORD_RANK=%o NO_NONTRIVIAL_SQUARE_PRODUCT=%o BADMASK=%o\n",
       Rank(CRM), indep, badmask;

u1 := X^8 + X^7 - 7*X^6 - 6*X^5 + 15*X^4 +
      10*X^3 - 10*X^2 - 4*X + 1;
u9 := X^8 - X^7 - 7*X^6 + 6*X^5 + 15*X^4 -
      10*X^3 - 10*X^2 + 4*X + 1;
U1 := (-2)^8 * Evaluate(u1, -X/2);
U9 := (-2)^8 * Evaluate(u9, -X/2);
d1 := Evaluate(U1, a);
d9 := Evaluate(U9, a);
printf "D1=%o D9=%o\nU1=%o\nU9=%o\n",
       gm(d1), gm(d9), U1, U9;

// The global norm-square condition in the basis [-1,2,3,17].
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

// Concatenate the squareclass maps at all primes above 3.
dec3 := Factorization(3*O);
lmaps := [LocalTwoSelmerMap(t[1]) : t in dec3];
localrows := [];
for r in reps do
    Append(~localrows,
      &cat[[F2!z : z in Eltseq(lm(r))] : lm in lmaps]);
end for;
LM := Matrix(F2, localrows);
ld9 := Vector(F2,
  &cat[[F2!z : z in Eltseq(lm(d9))] : lm in lmaps]);
ld1 := Vector(F2,
  &cat[[F2!z : z in Eltseq(lm(d1))] : lm in lmaps]);

// Since x^17-2 has two Q_3 factors, dim J(Q_3)/2J(Q_3)=1.
// The nonzero vector ld9 therefore spans the full local Kummer image.
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

printf "NORM_RANK=%o NORM_KERNEL_DIM=%o\n",
       Rank(NM), Dimension(WN);
printf "LOCAL3_AMBIENT_DIM=%o D9_LOCAL=%o D1_LOCAL=%o\n",
       Ncols(LM), ld9, ld1;
printf "AFTER_Q3_DIM=%o COUNTS=%o,%o\n",
       Dimension(W3), #validNorm, #valid3;
