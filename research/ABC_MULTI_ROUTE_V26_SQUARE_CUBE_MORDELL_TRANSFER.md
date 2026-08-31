# ABC multi-route research note v26: square--cube transfer and the primitive-core audit

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Mixed multiplicity depth

The endpoint-depth reductions naturally lead to two mixed cases.  With
positive integers `u,v,x,y,z,m`, one obtains either

\[
vz^3-ux^2=m
\tag{1}
\]

or

\[
vy^2-ux^3=m.
\tag{2}
\]

Here the two large adjacent abc endpoints are represented by a square layer
and a cube layer, while `m` is the smaller additive endpoint.

## 2. Exact Mordell transformations

From (1), define

\[
X=uvz,
\qquad
Y=u^2vx,
\qquad
D=u^3v^2m.
\]

Then

\[
\boxed{X^3=Y^2+D.}
\]

Indeed,

\[
X^3=u^3v^2(vz^3),
\qquad
Y^2=u^3v^2(ux^2),
\]

so their difference is `u^3v^2m`.

From (2), define

\[
X=uvx,
\qquad
Y=uv^2y,
\qquad
D=u^2v^3m.
\]

Then

\[
\boxed{Y^2=X^3+D.}
\]

## 3. The transformed Mordell triple is not primitive

The three terms in the first transformation are

\[
X^3=u^3v^2(vz^3),
\]

\[
Y^2=u^3v^2(ux^2),
\]

and

\[
D=u^3v^2m.
\]

Thus they share the exact visible factor

\[
\boxed{g=u^3v^2.}
\]

Similarly, the second transformation has the common factor

\[
\boxed{g=u^2v^3.}
\]

If `g>1`, the first two Mordell terms are not coprime.  Dividing all three
terms by `g` recovers the original generalized Fermat equation.  Therefore the
Mordell conversion does not create a new primitive abc triple; it is a
monomial rescaling of the original one.

This is an important route audit.  Applying a generic Hall or abc-type radical
estimate to the rescaled Mordell equation cannot yield a new proof unless the
argument uses arithmetic information that survives primitive reduction.

## 4. What information can still survive the transfer

The transfer remains useful for attaching elliptic curves and local
representations, but only if one exploits data beyond the common scaling:

1. the squarefree or cubefree kernels `u,v`;
2. local reduction types at primes dividing `u`, `v`, and `m`;
3. restrictions on the integral point produced by the canonical gcd layers;
4. a conductor estimate that distinguishes the residual coefficients from
   the common monomial factor;
5. simultaneous information from both possible square/cube orientations.

A proof based only on the numerical smallness of
`|X^3-Y^2|` is circular after primitive reduction.

## 5. Lean formalization

The identities and common-factor obstruction are formalized in

```text
Lean/IUTThreeClosures/SquareCubeMordellTransfer.lean
```

The module proves:

```lean
cube_minus_square_to_mordell
square_minus_cube_to_mordell
cube_minus_square_scaled_terms
square_minus_cube_scaled_terms
cube_minus_square_common_factor
square_minus_cube_common_factor
cube_minus_square_not_coprime
square_minus_cube_not_coprime
```

No `axiom`, `sorry`, or `admit` is introduced, and no abc or Hall estimate is
assumed.
