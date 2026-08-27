// Prime-19 curve-level fake 2-Selmer calculation, Magma V2.29-9.
//
// PrimeBound=30 omits some local tests and can only enlarge the surviving
// fake Selmer set.  The visible rational points make the true set nonempty.
// Completeness of the global class/unit basis is independently deconditioned
// by p19_chebyshev_class_cert.gp and p19_chebyshev_dyadic_obstruction.m.

SetSeed(1);
SetClassGroupBounds("GRH");
Q := Rationals();
Qx<X> := PolynomialRing(Q);
fm := X^19 - 76*X^17 + 2432*X^15 - 42560*X^13 +
      442624*X^11 - 2782208*X^9 + 10272768*X^7 -
      20545536*X^5 + 18677760*X^3 - 4980736*X + 1310720;
assert IsIrreducible(fm);
C := HyperellipticCurve(fm);
assert Genus(C) eq 9;
Hk, AtoHk := TwoCoverDescent(C : PrimeBound := 30);
assert #Hk eq 1;
delta := (Hk!0) @@ AtoHk;
assert delta eq Parent(delta)!1;
printf "GENUS=%o FAKE_TWO_SELMER_SIZE=%o SET=%o DELTA=%o\n",
       Genus(C), #Hk, Hk, delta;
