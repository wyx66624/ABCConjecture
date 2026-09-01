# ABC multi-route research note v27: exact affine residual core

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Why the residual coefficients are now central

The preceding endpoint reductions extract large coprime divisibility moduli
from the two large endpoints of a hypothetical abc counterexample.  The
Bezout adjacency construction shows that the moduli alone do not force a
positive additive gap.  The remaining arithmetic is therefore carried by the
coefficients left after division by those moduli.

This note gives the complete integral parametrization of those coefficients,
proves that primitive endpoint triples still occur in an infinite affine
subfamily, and records the exact discriminant and simple-root structure of the
residual product.  None of the statements assumes an abc or radical estimate.

## 2. Unimodular residual coordinates

Fix integers `R,S,x,y` with

\[
Rx+Sy=1.
\]

For a prescribed gap `m` and parameter `t`, define

\[
A_t=-mx+tS,
\qquad
B_t=my+tR.
\]

Then

\[
\boxed{SB_t-RA_t=m}
\tag{2.1}
\]

and

\[
\boxed{yA_t+xB_t=t.}
\tag{2.2}
\]

Equivalently,

\[
\binom{A_t}{B_t}
=
\begin{pmatrix}-x&S\\y&R\end{pmatrix}
\binom m t,
\]

and the determinant is `-1`.  Thus `(m,t)` and `(A_t,B_t)` are related by an
integral unimodular change of variables.

For every integer `d`,

\[
\boxed{
 d\mid A_t,\ d\mid B_t
 \quad\Longleftrightarrow\quad
 d\mid m,\ d\mid t.
}
\tag{2.3}
\]

In the usual nonnegative normalization this is

\[
\gcd(A_t,B_t)=\gcd(m,t).
\]

## 3. Completeness and uniqueness

Conversely, if integers `A,B` satisfy

\[
SB-RA=m,
\]

then with

\[
t=yA+xB
\]

one has

\[
A=A_t,
\qquad B=B_t.
\]

The parameter is unique.  Hence

\[
\boxed{
SB-RA=m
\quad\Longleftrightarrow\quad
\exists!t\in\mathbf Z:\ (A,B)=(A_t,B_t).
}
\tag{3.1}
\]

For two parameters,

\[
\boxed{A_tB_u-A_uB_t=m(t-u).}
\tag{3.2}
\]

## 4. Endpoint family

Set

\[
M_t=RA_t,
\qquad C_t=SB_t.
\]

Then

\[
R\mid M_t,
\qquad S\mid C_t,
\qquad
\boxed{C_t-M_t=m.}
\]

For sufficiently large `t`, both endpoints are positive when `R,S>0`, and

\[
\boxed{M_tC_u-M_uC_t=RSm(t-u).}
\tag{4.1}
\]

Thus all correlations between different members of the affine family are
explicit.

## 5. Primitive triples survive in an infinite progression

Suppose

\[
\alpha m+\beta RSt=1.
\]

Direct expansion gives explicit Bezout certificates for each of the three
pairs among

\[
m,\quad M_t,\quad C_t.
\]

In particular, they form a pairwise primitive endpoint triple.

If the weaker base certificate

\[
\alpha m+\beta RS=1
\tag{5.1}
\]

holds, then every parameter

\[
\boxed{t=1+km}
\tag{5.2}
\]

has an explicit certificate of the required form:

\[
[\alpha(1+km)-k]m+\beta RS(1+km)=1.
\]

Consequently the family contains infinitely many distinct primitive residual
pairs and pairwise primitive endpoint triples while retaining the prescribed
moduli and the prescribed gap.  Divisibility, a short gap, residual
primitivity, and endpoint primitivity therefore do not by themselves control
the radical.

## 6. Residual-product discriminant

Define

\[
F_t=A_tB_t,
\qquad
D_t=SB_t+RA_t.
\]

The exact expansions are

\[
F_t=RSt^2+m(Sy-Rx)t-m^2xy,
\]

\[
D_t=2RSt+m(Sy-Rx).
\]

Using `Rx+Sy=1` gives

\[
\boxed{D_t^2-4RSF_t=m^2.}
\tag{6.1}
\]

Thus the residual product is a split quadratic polynomial whose discriminant
is exactly the square of the additive gap.

If an integer `d` divides both `F_t` and `D_t`, (6.1) implies

\[
\boxed{d\mid m^2.}
\tag{6.2}
\]

Hence, away from gap primes, a divisor of the residual product cannot also
divide its linear discriminant factor.  This is the exact simple-root
statement needed for local lifting or sieve arguments.

The differences are also exact:

\[
A_t-A_u=S(t-u),
\qquad
B_t-B_u=R(t-u),
\]

\[
D_t-D_u=2RS(t-u).
\]

If `d` has a Bezout certificate with `S`, two zeros of `A_t` modulo `d` lie in
the same parameter class modulo `d`; the analogous statement holds for
`B_t` and `R`.  Moreover, a divisor of both residual factors must divide `m`,
so the two root classes are disjoint away from the gap.

## 7. What has and has not been achieved

The remaining radical is now an explicit polynomial object:

\[
\boxed{
A_tB_t=(-mx+tS)(my+tR).
}
\]

A successful positive argument must exploit the additional abc-derived
constraints on the moving data `R,S,m,t` and prove a pointwise lower bound for
the radical of these two correlated affine forms.  Average squarefree-value
results, the existence of many good parameters, or a density-zero exceptional
set do not supply the required uniform pointwise conclusion.

The present results also rule out any closure using only:

- large coprime perfect-power divisors in the two endpoints;
- a very short additive gap;
- primitive residual coefficients;
- a primitive endpoint triple;
- or the fact that the residual product has a split square discriminant.

The v27 theorems are unconditional classification and local-structure results;
they are not a proof of the remaining radical lower bound and therefore are
not a complete proof of the abc conjecture.

## 8. Lean formalization

The files are

```text
Lean/IUTThreeClosures/AffineResidualParametrization.lean
Lean/IUTThreeClosures/AffinePrimitiveEndpointFamily.lean
Lean/IUTThreeClosures/AffineResidualDiscriminant.lean
```

Principal declarations include

```lean
residual_gap_identity
residual_parameter_identity
common_divisor_iff
residual_parametrization
gap_equation_iff_exists_parameter
parameter_unique
residual_cross_determinant
endpoint_gap_identity
endpoint_cross_determinant
primitive_endpoint_bezout_certificates
lift_coprimality_certificate_one_mod_gap
one_mod_gap_residual_pair_injective
residual_discriminant_identity
common_divisor_product_discriminant_dvd_gap_sq
residualA_root_class_rigid
residualB_root_class_rigid
not_both_residual_factors_of_not_dvd_gap
```

No `axiom`, `sorry`, or `admit` is introduced.
