# ABC multi-route research note v16: signed endpoint square-radical defect

**Author:** ChatGPT  
**Date:** 2026-08-30

## Status

This note corrects the v14/v15 target. The unsigned cubeful quotient gives a
valid sufficient inequality, but its proposed uniform subcritical bound is
false even on elementary adjacent triples. The correct endpoint quantity is a
*signed* square-radical defect. Its uniform subcritical bound is proved in Lean
to be exactly equivalent to `ABCConjecture`.

No proof of that equivalent bound is asserted here.

## 1. Why the unsigned cubeful target is too strong

For

\[
Q(n)=\frac{n}{\gcd(n,\operatorname{rad}(n)^2)},
\]

v14 used the valid inequality

\[
n\le\operatorname{rad}(n)^2Q(n).
\]

However, bounding `log Q` alone discards the cancellation supplied by primes
that occur to exponent one.

Consider the unconditional family

\[
1+2^N=2^N+1,\qquad N\ge2.
\]

For

\[
n=2^N(2^N+1),
\]

the two-adic valuation of `Q(n)` is at least `N-2`, so

\[
\log Q(n)\ge(N-2)\log2.
\]

On the other hand

\[
\log\operatorname{rad}(2^N(2^N+1))
\le\log(2(2^N+1))
\le(N+2)\log2.
\]

Consequently, for every fixed `epsilon<1/2`, no constant `K` can make

\[
\log Q(n)\le
2\epsilon\log\operatorname{rad}(2^N(2^N+1))+K
\]

hold for all `N`. This does not produce abc counterexamples: when the odd
endpoint has a large exponent-one radical, that radical cancels the high power
on `2^N`. The unsigned target simply failed to record the cancellation.

Thus the v14 ledger remains correct, but the global uniform `Q`-bound and the
v15 endpoint version are not viable final hypotheses.

## 2. The signed defect

For a positive primitive abc point let

\[
M=\max(a,b),\qquad
h=\log c,\qquad
R=\log\operatorname{rad}(abc).
\]

Define

\[
\boxed{
\Delta(P)=\log(Mc)-2R.
}
\]

Primewise, this quantity includes:

- coefficient `-1` for a prime appearing once in the large-endpoint product;
- coefficient `0` for exponent two;
- coefficient `e-2` for exponent `e\ge3`;
- the additional negative contribution from the radical of the small endpoint.

It is therefore precisely the signed excess left after the necessary
exponent-one cancellation.

## 3. Exact corridor

Since

\[
\frac c2\le M\le c,
\]

we have

\[
\frac{c^2}{2}\le Mc\le c^2.
\]

Taking logarithms and subtracting `2R` gives

\[
\boxed{
2h-2R-\log2
\le\Delta(P)
\le2h-2R.
}
\]

This is not an approximation: the Lean module proves both inequalities for the
repository's actual `ABCPoint`.

## 4. Exact equivalence with abc

Define the signed-defect statement:

> for every `epsilon>0`, there is a constant `K_epsilon`, independent of the
> abc point, such that
> \[
> \Delta(P)\le2\epsilon R+K_\epsilon.
> \]

The lower corridor gives

\[
2h-2R-\log2
\le2\epsilon R+K_\epsilon,
\]

hence

\[
h\le(1+\epsilon)R+
\frac{K_\epsilon+\log2}{2}.
\]

Conversely, an abc estimate

\[
h\le(1+\epsilon)R+C_\epsilon
\]

and the upper corridor give

\[
\Delta(P)\le2\epsilon R+2C_\epsilon.
\]

Therefore

\[
\boxed{
\text{uniform signed-defect control}
\iff
ABCConjecture.
}
\]

The constants and epsilon quantifiers are preserved explicitly.

## 5. Revised research target

The endpoint problem is no longer to bound the positive cubeful mass by itself.
It is to prove cancellation between:

\[
\sum_{v_p(Mc)\ge3}(v_p(Mc)-2)\log p
\]

and

\[
\sum_{v_p(Mc)=1}\log p
+2\log\operatorname{rad}(\min(a,b)).
\]

More precisely, one must prove that the positive part exceeds the negative
part by at most `2 epsilon R + O_epsilon(1)`.

This formulation treats the harmless family `(1,2^N,2^N+1)` correctly and
retains exactly the obstruction needed for abc.

## 6. Lean deliverable

```text
Lean/IUTThreeClosures/SignedEndpointSquareRadicalDefect.lean
```

Principal declarations:

```lean
ABCPoint.largeEndpointProductLog
ABCPoint.signedEndpointSquareRadicalDefect
ABCPoint.signedEndpointSquareRadicalDefect_corridor
UniformSignedEndpointSquareRadicalDefectBound
abc_of_uniformSignedEndpointSquareRadicalDefectBound
uniformSignedEndpointSquareRadicalDefectBound_of_abc
uniformSignedEndpointSquareRadicalDefectBound_iff_abc
no_uniform_subunit_bound_for_unsigned_linear_excess
```
