# ABC multi-route research note v32: concrete moving-Pell witnesses and exact approximation scale

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Purpose

The v31 reduction used finite prime-exponent profiles to show that a
hypothetical abc violation forces simultaneous square parts and hence a moving
Pell equation.  This note removes the remaining bookkeeping distance between
that profile theorem and an actual positive primitive abc triple.

For every abc point, it constructs positive squarefree coefficients and
positive integral square roots directly from the three ordered endpoints.  It
then proves the exact rational approximation identities attached to the
resulting moving Pell equation.

No estimate for the moving Pell equation and no abc conclusion are assumed.

## 2. Concrete squarefree decomposition

Let

\[
a+b=c,
\qquad
m=\min(a,b),
\qquad
M=\max(a,b).
\]

Every positive integer `n` has a decomposition

\[
n=d r^2
\]

with `d>0`, `r>0`, and `d` squarefree.  Apply this independently to the three
ordered endpoints:

\[
m=wz^2,
\qquad
M=ux^2,
\qquad
c=vy^2,
\]

where

\[
w,u,v>0,
\qquad
x,y,z>0,
\]

and `w,u,v` are squarefree.

Because

\[
m+M=c,
\]

we obtain the exact ternary quadratic equation

\[
\boxed{wz^2+ux^2=vy^2.}
\]

Multiplying by `v` gives the moving Pell norm equation

\[
\boxed{(vy)^2-(uv)x^2=v(wz^2).}
\]

Equivalently,

\[
(vy)^2=(uv)x^2+v(wz^2).
\]

## 3. Primitivity survives square extraction

The original three integers `m,M,c` are pairwise coprime.  Moreover,

\[
wz\mid wz^2=m,
\qquad
ux\mid ux^2=M,
\qquad
vy\mid vy^2=c.
\]

Therefore

\[
\boxed{\gcd(wz,ux)=\gcd(wz,vy)=\gcd(ux,vy)=1.}
\]

In particular,

\[
\gcd(x,y)=\gcd(z,x)=\gcd(z,y)=1.
\]

Thus the passage to squarefree kernels does not hide a common divisor that
could later be cancelled from the Pell equation.  The resulting moving conic
is genuinely primitive across its three terms.

## 4. Exact approximation identity

From

\[
m+ux^2=vy^2
\]

we get, over the rationals,

\[
vy^2-ux^2=m.
\]

Dividing by `u y^2` yields

\[
\boxed{
\frac vu-\left(\frac xy\right)^2
=
\frac{m}{u y^2}.
}
\]

This is an identity, not an asymptotic estimate.

Multiplying by `u/v` gives

\[
\boxed{
\frac uv
\left(
\frac vu-\left(\frac xy\right)^2
\right)
=
\frac{m}{v y^2}.
}
\]

Since `v y^2=c`, the actual abc specialization is

\[
\boxed{
\frac uv
\left(
\frac vu-\left(\frac xy\right)^2
\right)
=
\frac{\min(a,b)}{c}.
}
\]

Finally, clearing the denominator gives

\[
\boxed{
u y^2
\left(
\frac vu-\left(\frac xy\right)^2
\right)=m.
}
\]

Hence the integer numerator of the rational-square approximation is exactly
the additive gap.

## 5. Consequence for the remaining strategy

The real approximation supplied by the Pell equation contains no independent
metric gain: after the natural scaling by `u/v`, its error is exactly the
relative abc gap `m/c`.

Consequently, a proof cannot close the remaining branch merely by observing
that `x/y` approximates `sqrt(v/u)`.  Pell equations themselves naturally
produce approximations at the quadratic, denominator-squared scale.

The additional information that remains available, and that a successful
argument must use, is arithmetic rather than purely metric:

1. `w,u,v` are squarefree;
2. `wz`, `ux`, and `vy` are pairwise coprime;
3. all coefficient and root prime support comes from the original abc triple;
4. a hypothetical abc violation forces the relevant square roots to have a
   fixed positive height slope;
5. the numerator `m` has the exceptionally small radical budget inherited
   from the same triple.

Thus the next genuine target is a support-sensitive moving-Pell theorem, not
an ordinary irrationality estimate for one fixed quadratic irrational.

## 6. Lean implementation

The concrete witness is formalized in

```text
Lean/IUTThreeClosures/ABCPointSquarefreePellWitness.lean
```

with principal declarations

```lean
ABCPoint.endpointMin_add_largeEndpoint
ABCPoint.SquarefreePellWitness
ABCPoint.exists_squarefreePellWitness
ABCPoint.SquarefreePellWitness.x_coprime_y
ABCPoint.SquarefreePellWitness.z_coprime_x
ABCPoint.SquarefreePellWitness.z_coprime_y
```

The approximation identities are formalized in

```text
Lean/IUTThreeClosures/MovingPellApproximationIdentity.lean
```

with principal declarations

```lean
rational_square_gap_identity
relative_gap_eq_scaled_square_error
denominator_sq_mul_square_error_eq_gap
ABCPoint.SquarefreePellWitness.relative_gap_identity
ABCPoint.SquarefreePellWitness.endpoint_ratio_eq_scaled_square_error
```

The result is a non-circular structural advance.  It does not claim that the
remaining support-sensitive moving-Pell estimate has already been proved.
