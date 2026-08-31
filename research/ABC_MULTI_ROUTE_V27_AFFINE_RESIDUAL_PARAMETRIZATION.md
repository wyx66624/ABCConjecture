# ABC multi-route research note v27: exact affine residual parametrization

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Why the residual coefficients are now the central object

The preceding endpoint reductions can extract large coprime divisibility
moduli from the two large endpoints of an abc triple.  The general Bezout
adjacency construction shows that the moduli themselves do not force a
positive lower bound for the additive gap.  What remains are the residual
coefficients after dividing out those moduli.

This note gives the complete integral parametrization of those residual
coefficients.  It is not a new conditional interface: the formulas describe
every solution of the relevant linear equation and identify its exact common
divisor structure.

## 2. The unimodular change of variables

Fix integers `R,S,x,y` with

\[
Rx+Sy=1.
\]

For a prescribed gap `m` and an integer parameter `t`, define

\[
A_t=-mx+tS,
\qquad
B_t=my+tR.
\]

A direct calculation gives

\[
\boxed{SB_t-RA_t=m}
\tag{2.1}
\]

and the inverse identity

\[
\boxed{yA_t+xB_t=t.}
\tag{2.2}
\]

Equations (2.1)--(2.2) say that

\[
\binom{A_t}{B_t}
=
\begin{pmatrix}
-x&S\\
y&R
\end{pmatrix}
\binom{m}{t},
\]

whose determinant is

\[
-(Rx+Sy)=-1.
\]

Thus this is an integral unimodular change of variables.

## 3. Exact common-divisor theorem

For every integer `d`,

\[
\boxed{
 d\mid A_t\ \text{and}\ d\mid B_t
 \quad\Longleftrightarrow\quad
 d\mid m\ \text{and}\ d\mid t.
}
\tag{3.1}
\]

The forward implication follows because both `m` and `t` are integral linear
combinations of `A_t,B_t` by (2.1)--(2.2).  The reverse implication follows
from the defining formulas.

In a nonnegative normalization this is precisely

\[
\gcd(A_t,B_t)=\gcd(m,t).
\]

In particular, when `m=1`, every residual pair is primitive.  More generally,
choosing `t` coprime to `m` makes the residual pair primitive.  Hence even
primitivity of the residual coefficients does not remove the affine freedom.

## 4. Completeness and uniqueness

Conversely, suppose integers `A,B` satisfy

\[
SB-RA=m.
\]

Set

\[
t=yA+xB.
\]

Using the Bezout identity gives

\[
A=-mx+tS,
\qquad
B=my+tR.
\]

Therefore every integral solution occurs in the family, and (2.2) shows that
the parameter is unique.

Equivalently,

\[
\boxed{
SB-RA=m
\quad\Longleftrightarrow\quad
\exists!t\in\mathbf Z:
(A,B)=(A_t,B_t).
}
\tag{4.1}
\]

## 5. Endpoint family

Define

\[
M_t=RA_t,
\qquad
C_t=SB_t.
\]

Then

\[
R\mid M_t,
\qquad
S\mid C_t,
\qquad
\boxed{C_t-M_t=m.}
\]

For sufficiently large positive `t`, both endpoints are positive whenever
`R,S>0`.

For two parameters `t,u`, the residual cross determinant is

\[
\boxed{
A_tB_u-A_uB_t=m(t-u),
}
\tag{5.1}
\]

and consequently

\[
\boxed{
M_tC_u-M_uC_t=RSm(t-u).
}
\tag{5.2}
\]

These identities give exact correlation across the family and can be used in
future gcd and sieve arguments.

## 6. Consequence for the remaining abc core

The preceding no-go results are now exact rather than heuristic.  Prescribed
large power divisors, an arbitrarily short gap, and a primitive residual pair
are simultaneously compatible with an infinite affine family.  The missing
arithmetic is the radical of

\[
A_tB_t=(-mx+tS)(my+tR).
\]

A successful positive argument must exploit the fact that, in an abc-derived
family, the moving data `R,S,m` are themselves constrained by the conductor
and by the extracted exponent layers.  It must prove a pointwise radical lower
bound for the two correlated affine forms, not merely an average-density or
existence statement.

The explicit target can be written as follows.  For the abc-derived choices of
`R,S,m,t`, prove for every `epsilon>0`

\[
\log C_t
\le
(1+\epsilon)
\log\operatorname{rad}(mRSC_tM_t)
+O_\epsilon(1).
\]

The parametrization does not prove this inequality; it identifies the exact
remaining variables and rules out any proof that uses only divisibility,
gap size, or residual primitivity.

## 7. Lean formalization

The file

```text
Lean/IUTThreeClosures/AffineResidualParametrization.lean
```

contains the kernel-checkable declarations

```lean
residual_gap_identity
residual_parameter_identity
common_divisor_iff
residualA_recover
residualB_recover
residual_parametrization
gap_equation_iff_exists_parameter
parameter_unique
residual_cross_determinant
endpoint_gap_identity
endpoint_divisibility
endpoint_cross_determinant
endpoint_positive
gap_one_residual_bezout
common_divisor_dvd_one_of_gap_one
```

No `axiom`, `sorry`, or `admit` is introduced.  This is an unconditional
classification theorem and a sharpened reduction, not a claim that the full
abc conjecture has been proved.
