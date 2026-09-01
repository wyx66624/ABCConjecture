# ABC multi-route research note v29: two-sided exponent height and support congruences

**Author:** ChatGPT  
**Date:** 2026-09-01

## 1. Objective

The canonical powerful--residual decomposition of a primitive abc point is

\[
m=\min(a,b),\qquad M=\max(a,b),
\]

\[
M=RA,\qquad c=SB,
\]

where

\[
A=\operatorname{rad}(M),\quad R=M/A,
\qquad
B=\operatorname{rad}(c),\quad S=c/B.
\]

The exact residual equation is

\[
SB-RA=m.
\tag{1.1}
\]

The residuals `A,B` are squarefree, the opposite data are coprime, and

\[
\operatorname{rad}(R)\mid A,\qquad
\operatorname{rad}(S)\mid B.
\tag{1.2}
\]

This note directly exploits these facts in two ways:

1. it proves that every hypothetical abc violation forces **both** exponent
   vectors, not merely their sum, to have height-scale weighted size;
2. it turns support saturation (1.2) into explicit opposite congruence classes
   for the unique affine residual parameter.

Neither result assumes an exponent-height estimate or an abc conclusion.

## 2. Logarithmic coordinates

Write

\[
r=\log\operatorname{rad}(m),\qquad
\alpha=\log A,\qquad
\beta=\log B,
\]

\[
u=\log R,\qquad v=\log S,\qquad h=\log c.
\]

Pairwise coprimality gives

\[
\log\operatorname{rad}(abc)=r+\alpha+\beta.
\tag{2.1}
\]

The sum endpoint has the exact decomposition

\[
h=v+\beta.
\tag{2.2}
\]

Since `M` is the larger summand and `m+M=c`,

\[
M\ge c/2,
\]

hence

\[
h-\log2\le u+\alpha.
\tag{2.3}
\]

## 3. Two-sided exponent-vector lower bounds

Assume that a triple violates a proposed abc bound:

\[
(1+\varepsilon)(r+\alpha+\beta)+C<h.
\tag{3.1}
\]

Using (2.2), subtracting `beta`, and collecting terms gives

\[
\boxed{
(1+\varepsilon)(r+\alpha)
+\varepsilon\beta+C<v.
}
\tag{3.2}
\]

Using (2.3) gives the opposite estimate

\[
\boxed{
\varepsilon\alpha
+(1+\varepsilon)(r+\beta)
+C-\log2<u.
}
\tag{3.3}
\]

Thus the exponent vectors are not allowed to concentrate on only one large
endpoint.  Each one must dominate the radical of the gap and the squarefree
support of the opposite endpoint.

Adding (3.2) and (3.3) yields

\[
\boxed{
(1+2\varepsilon)(\alpha+\beta)
+2(1+\varepsilon)r+2C-\log2<u+v.
}
\tag{3.4}
\]

There is also a height-normalized version.  Since both `A` and `B` contribute
to the full conductor, (3.1) implies

\[
\boxed{
\varepsilon h+C<(1+\varepsilon)v,
}
\tag{3.5}
\]

and

\[
\boxed{
\varepsilon h+C-(1+\varepsilon)\log2
<(1+\varepsilon)u.
}
\tag{3.6}
\]

Consequently every unbounded counterexample sequence for fixed positive
`epsilon` must satisfy

\[
\liminf\frac{\log R}{\log c}
\ge\frac{\varepsilon}{1+\varepsilon},
\qquad
\liminf\frac{\log S}{\log c}
\ge\frac{\varepsilon}{1+\varepsilon}.
\]

This is stronger than an aggregate cubeful-excess statement: both disjoint
prime-support exponent vectors must independently be macroscopic.

## 4. Affine parameter and support saturation

Choose Bezout coefficients

\[
Rx+Sy=1.
\tag{4.1}
\]

The v27 affine classification writes every residual solution uniquely as

\[
A=-mx+tS,\qquad B=my+tR,
\tag{4.2}
\]

with inverse parameter

\[
t=yA+xB.
\tag{4.3}
\]

A direct calculation gives

\[
\boxed{
t-mxy=yA+tRx,
}
\tag{4.4}
\]

and

\[
\boxed{
t+mxy=xB+tSy.
}
\tag{4.5}
\]

Now use the genuinely canonical support conditions.  If

\[
d_R\mid A,\qquad d_R\mid R,
\]

then (4.4) gives

\[
d_R\mid t-mxy.
\]

Taking `d_R=rad(R)` gives

\[
\boxed{
\operatorname{rad}(R)\mid t-mxy.
}
\tag{4.6}
\]

Similarly,

\[
\boxed{
\operatorname{rad}(S)\mid t+mxy.
}
\tag{4.7}
\]

Since `R` and `S` are coprime, so are their radicals.  Multiplying the two
opposite congruences gives

\[
\boxed{
\operatorname{rad}(R)\operatorname{rad}(S)
\mid t^2-m^2x^2y^2.
}
\tag{4.8}
\]

This is the first parameter-level divisibility theorem that uses the shared
modulus--residual support, rather than merely recording it as metadata.

## 5. What the result does and does not control

Equations (3.2)--(3.6) show exactly how large the exponent vectors would have
to be in a counterexample.  Equations (4.6)--(4.8) constrain their prime
supports through a low-degree polynomial in the affine parameter.

The remaining gap is now a mixed support/exponent problem:

> use the opposite CRT conditions (4.6)--(4.8), the small radical of `m`, and
> the height-scale lower bounds (3.5)--(3.6) to prevent both `R` and `S` from
> carrying macroscopic exponent height.

Support congruences alone cannot bound the exponents: they see each prime only
once.  Any closing argument therefore needs an additional mechanism that
lifts support information to prime-power information, for example a genuinely
uniform p-adic linear-form estimate, an arithmetic-derivative/nondegeneracy
argument, or a modular-height inequality.  Introducing the desired conclusion
as a field would merely restate abc and is not counted as progress.

## 6. Lean formalization

The two modules are

```text
Lean/IUTThreeClosures/CanonicalExponentHeightLedger.lean
Lean/IUTThreeClosures/CanonicalAffineSupportCongruence.lean
```

The main declarations are

```lean
rightModulus_crossSupport_lower
leftModulus_crossSupport_lower
totalModulus_crossSupport_lower
rightModulus_heightScale
leftModulus_heightScale
bothModuli_heightScale
height_le_of_rightModulus_not_heightScale
height_le_of_leftModulus_not_heightScale

leftParameterShift_identity
rightParameterShift_identity
commonDivisor_left_dvd_parameterShift
commonDivisor_right_dvd_parameterShift
solution_leftSupport_dvd_parameterShift
solution_rightSupport_dvd_parameterShift
coprimeProduct_dvd_parameterSquare_sub
canonical_support_parameter_congruences
canonical_support_product_dvd_parameterSquare_sub
```

No `axiom`, `sorry`, or `admit` is introduced.  These are unconditional
reductions and partial closure criteria, not a complete proof of the abc
conjecture.
