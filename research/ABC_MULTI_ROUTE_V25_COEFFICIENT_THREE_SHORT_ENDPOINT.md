# ABC multi-route research note v25: coefficient three forces a short endpoint

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Exact transfer

For a positive primitive triple

\[
a+b=c,
\qquad
m=\min(a,b),
\]

write

\[
h=\log c,
\quad
R=\log\operatorname{rad}(abc),
\quad
S=\log(abc).
\]

The elementary endpoint corridor is

\[
\boxed{2h+\log m-\log2\le S.}
\]

Assume a pointwise coefficient-three product estimate

\[
S\le3R+\eta h+K
\]

and suppose the same point violates a proposed abc bound:

\[
(1+\varepsilon)R+C<h,
\qquad \varepsilon>0.
\]

Multiplying the endpoint corridor and product estimate by
`1+epsilon`, then using

\[
(1+\varepsilon)R<h-C,
\]

gives

\[
\boxed{
(1+\varepsilon)\log m
<
\bigl(1-2\varepsilon+\eta(1+\varepsilon)\bigr)h
+(1+\varepsilon)(K+\log2)-3C.
}
\]

No asymptotic notation is used in this identity.

## 2. The exact relative-error threshold

The leading endpoint coefficient is strictly below one precisely when

\[
\eta<\frac{2\varepsilon}{1+\varepsilon}.
\]

Thus a coefficient-three product theorem with an arbitrarily small relative
height error cannot leave balanced abc violations.  Every remaining violation
must have a power-saving small summand.

A convenient choice is

\[
\eta=\frac{\varepsilon}{1+\varepsilon}.
\]

Then

\[
\boxed{
(1+\varepsilon)\log m
<
(1-\varepsilon)h
+(1+\varepsilon)(K+\log2)-3C.
}
\]

Once

\[
2\left|(1+\varepsilon)(K+\log2)-3C\right|
\le\varepsilon h,
\]

this becomes

\[
\boxed{
2(1+\varepsilon)\log m
<
(2-\varepsilon)h.
}
\]

Equivalently, along an unbounded violating family,

\[
m<c^{\frac{2-\varepsilon}{2(1+\varepsilon)}+o(1)}.
\]

For a truly sublinear product error `eta=o(1)`, the sharper limiting exponent
is

\[
\boxed{
\frac{1-2\varepsilon}{1+\varepsilon}
=
1-\frac{3\varepsilon}{1+\varepsilon}.
}
\]

## 3. Consequence for the IUT/coefficient-three route

A verified coefficient-three symmetric-product estimate does not by itself
prove abc, but its unresolved locus is now exact: it consists solely of
power-saving short-endpoint triples.  In particular, under such an estimate
the “all three endpoints multiplicity-rich but balanced” branch is absent.

The remaining task is therefore not another global coefficient conversion.
It is a short-interval radical theorem for two coprime large endpoints

\[
M,
\qquad
M+m=c,
\]

where `m` lies in the explicit power-saving range above and an abc violation
forces height-scale multiplicity on both `M` and `c`.

## 4. Lean module

```text
Lean/IUTThreeClosures/CoefficientThreeForcesShortEndpoint.lean
```

The module proves the exact pointwise inequality, the convenient relative
error specialization, and the eventual denominator-free power-saving bound.
It introduces no `axiom`, `sorry`, or `admit` and does not assume an abc
conclusion.
