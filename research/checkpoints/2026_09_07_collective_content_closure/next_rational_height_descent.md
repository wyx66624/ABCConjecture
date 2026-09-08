# RD1--RD3. Rational descent of the local-height expression to z squared

Next-only complete ordinary candidate, continuing ZS and DS. No zero list,
rational-point classification or Lean claim is made. The reduction concerns
the same fixed curve and height function, not a varying family.

Put u=z^2 and S(u)=u^3-27u^2+99u-9. The actual quotient coordinates are

    x1=(u-9)/4,       y1=W/8,
    x2=(33-9/u)/4,    y2=-9W/(8z^3).

Thus y1^2=S(u)/64 and y2^2=81S(u)/(64u^3).

## RD1. A derivative formula for the ninth-multiple parameter

On either short model E: y^2=x^3+ax+b, let psi=psi_9 and

    phi=x psi_9^2-psi_10 psi_8,
    D=phi' psi-2phi psi'.

Both psi and phi are integer polynomials in x: the two even-index division
polynomials in the product psi_10 psi_8 contribute a factor (2y)^2,
which is replaced by 4(x^3+ax+b). Primes here denote derivatives in x.
As rational functions on E one has

    x([9]Q)=phi/psi^2,
    y([9]Q)=y D/(9 psi^3),
    t([9]Q)=-9 phi psi/(y D),
    delta(Q)=t([9]Q)/psi_9(Q)=-9 phi/(y D).             (RD1)

Proof. The first equality is the standard division-polynomial expression
for the actual multiplication map. Write this rational function as X(x).
The invariant differential satisfies [9]^*(dx/(2y))=9 dx/(2y), so on the
open set where all displayed denominators are nonzero,

    X'(x)/(2 y([9]Q))=9/(2y),
    X'(x)=(phi' psi-2phi psi')/psi^3.

These prove the second equality and then the last two. They are rational
function identities, hence hold after cancellation at any removable point.
The differentiation fixes the sign of the ordinate as well as the factor
nine. In particular D is not the zero polynomial: X is a nonconstant
characteristic-zero rational function. QED.

Equivalently, if the usual ninth-multiple ordinate is written as
omega_9/psi_9^3, then yD=9omega_9 and delta=-phi/omega_9.
This provides a direct check against a division-polynomial implementation.

## RD2. All non-series inputs are rational functions in u

Use subscripts for the two minimal models and evaluate their polynomials
at x1(u) and x2(u). Define the following rational functions over Q:

    Xcal(u)=-9 u^39 phi1(x1) D2(x2)/(phi2(x2) D1(x1)),

    V1(u)=5184 phi1(x1)^2 psi1(x1)^2/(S(u) D1(x1)^2),

    V2(u)=64 u^3 phi2(x2)^2 psi2(x2)^2/(S(u) D2(x2)^2).

For every actual point of C(Q5), interpreting removable values by the
already established local extensions, these satisfy

    Xi(P)=Xcal(z^2),       T1(P)^2=V1(z^2),
    T2(P)^2=V2(z^2).                                   (RD2)

Proof. The two factors -9 in RD1 cancel in the ratio of the deltas,
and y2/y1=-9/z^3. Thus multiplying this ratio by z^81 gives
-9z^78=-9u^39 times the displayed polynomial quotient. Squaring
the formula for t([9]Q) and substituting the two displayed ordinate
squares gives 81*64=5184 for V1 and 81*64/81=64 for V2.
The identities first hold on the common nonempty open set, hence as
rational functions. ZS3 supplies the removable extensions on actual
local points, including the zero and infinity fibers. QED.

In particular Xcal is finite and nonzero and V1,V2 lie in 25Z5 on
the image of the actual local curve. This assertion is restricted to
that image. It does not assert the same valuation bounds for every
u in Q5, or for every point over an extension field. At exceptional
fibers, evaluating an uncancelled displayed quotient is not valid.

## RD3. A square-root-free expression for the same analytic function

Since R_0i(t) are even and L_i(t) are odd, there are unique formal
rational series Rhat_i and Mhat_i satisfying

    Rhat_i(t^2)=R_0i(t),       Mhat_i(t^2)=L_i(t)^2.

On the image of C(Q5), the extended height function is

    F0(P)=-2/81 [log_5 Xcal(u)+Rhat_1(V1(u))-Rhat_2(V2(u))]
          -alpha_1^0/81 Mhat_1(V1(u))
          +alpha_2^0/81 Mhat_2(V2(u)),       u=z^2.     (RD3)

Proof. Regrouping the convergent even series by t^2 preserves their
values at t in 5Z5. The square of the convergent logarithm series is
its convergent Cauchy product. Substitution of RD2 in ZS9 therefore
gives the displayed identity, with exactly the same alpha constants.
The ZS all-tail bounds continue to apply when the truncations are
matched by their original t-degrees. QED.

This removes W and numerical choices of its square root from the function
evaluation itself. The actual local-curve condition and chart coverage
are still required. On the nonzero finite representative disks, u=z^2
has derivative 2z in Z5 units, so it is a valid analytic coordinate.
At z=0 it is ramified of order two; at infinity use 1/u=q^2, also
ramified of order two. DS's even-order condition is consistent with
this ramification and must be preserved by any zero-counting procedure.

Rational-function denominator estimates, log_5 Xcal error propagation,
and complete root certificates remain to be proved for each chosen chart.
RD supplies an exact algebraic reduction and does not discharge those
analytic obligations by itself.
