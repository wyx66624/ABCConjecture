// Exact rational Mumford certificate for Gamma=<H1+H9>.
// Magma V2.29-9.

Qx<x> := PolynomialRing(Rationals());
fm := x^19-76*x^17+2432*x^15-42560*x^13+442624*x^11-
      2782208*x^9+10272768*x^7-20545536*x^5+18677760*x^3-
      4980736*x+1310720;
C := HyperellipticCurve(fm);
J := Jacobian(C);

U1 := x^9-2*x^8-32*x^7+56*x^6+336*x^5-480*x^4-
      1280*x^3+1280*x^2+1280*x-512;
U9 := x^9+2*x^8-32*x^7-56*x^6+336*x^5+480*x^4-
      1280*x^3-1280*x^2+1280*x+512;
H1 := J![U1,512];
H9 := J![U9,1536];
G := H1+H9;

// These two polynomial identities certify that H1 and H9 are halves of
// the indicated rational point divisors (with the usual odd-degree point
// at infinity as base point).
assert fm-512^2 eq (x+4)*U1^2;
assert fm-1536^2 eq (x-4)*U9^2;
assert G eq H1+H9;
assert Degree(G[1]) le 9;
assert (fm-G[2]^2) mod G[1] eq 0;

// Fix the sign convention exactly.  Magma's [u,v] convention gives
// [(-4,512)-infinity]=-2H1 and [(4,1536)-infinity]=-2H9.
Pinf := C![1,0,0];
Dm := J![C![-4,512,1],Pinf];
Dp := J![C![4,1536,1],Pinf];
assert Dm eq -2*H1;
assert Dp eq -2*H9;

printf "H1_U=%o\nH1_V=%o\n",H1[1],H1[2];
printf "H9_U=%o\nH9_V=%o\n",H9[1],H9[2];
printf "G_U=%o\nG_V=%o\nG_N=%o\n",G[1],G[2],G[3];
printf "DM_EQ_MINUS2H1=%o DP_EQ_MINUS2H9=%o\n",
       Dm eq -2*H1,Dp eq -2*H9;
print "P19_GAMMA_RATIONAL_MUMFORD_PASS";
