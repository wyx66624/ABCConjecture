# ABC multi-route research note v17: signed prime-exponent layers

**Author:** ChatGPT  
**Date:** 2026-08-30

## Status

This note advances the corrected signed-endpoint route. It does not assert the
remaining uniform estimate and therefore does not claim a complete proof of
the abc conjecture.

## 1. The exact prime-exponent sign pattern

Let a positive integer have prime factorization

\[
n=\prod_{p\mid n}p^{e_p}.
\]

The square-radical defect is

\[
\delta_2(n)
=
\log n-2\log\operatorname{rad}(n)
=
\sum_{p\mid n}(e_p-2)\log p.
\]

This contains three qualitatively different layers:

- if `e_p=1`, the contribution is `-log p`;
- if `e_p=2`, the contribution is zero;
- if `e_p>=3`, the contribution is `(e_p-2)log p`.

Define

\[
W_1(n)=\sum_{e_p=1}\log p,
\qquad
W_{>2}(n)=\sum_{e_p\ge3}(e_p-2)\log p.
\]

Then the exact identity is

\[
\boxed{
\delta_2(n)=W_{>2}(n)-W_1(n).
}
\]

The accompanying Lean module first proves this for an arbitrary finite
positive exponent profile with arbitrary real weights. Thus the identity is
not tied to an analytic approximation or to a chosen ordering of primes.

## 2. Ordered abc endpoints

For a positive primitive abc point, write

\[
m=\min(a,b),\qquad M=\max(a,b).
\]

Then

\[
mM=ab,
\]

and pairwise coprimality gives

\[
\gcd(m,M)=\gcd(m,c)=\gcd(M,c)=1.
\]

Consequently

\[
\boxed{
\operatorname{rad}(abc)
=
\operatorname{rad}(m)
\operatorname{rad}(M)
\operatorname{rad}(c).
}
\]

If

\[
R=\log\operatorname{rad}(abc),
\]

then

\[
R=\log\operatorname{rad}(m)
 +\log\operatorname{rad}(M)
 +\log\operatorname{rad}(c).
\]

## 3. Exact decomposition of the signed endpoint defect

The corrected v16 endpoint quantity is

\[
\Delta(P)=\log(Mc)-2R.
\]

Define the one-integer defect

\[
\delta_2(x)=\log x-2\log\operatorname{rad}(x).
\]

Using the radical factorization above and `gcd(M,c)=1`, one obtains

\[
\boxed{
\Delta(P)
=
\delta_2(M)+\delta_2(c)
-2\log\operatorname{rad}(m).
}
\]

Thus the remaining obstruction is not merely a high power on one endpoint.
It is the net excess above exponent two after subtracting the complete
exponent-one layer and the small-endpoint radical charge.

## 4. One-endpoint localization of every violation

Suppose, for fixed real `epsilon` and `C`, that

\[
\log c>(1+\varepsilon)R+C.
\]

The v16 corridor gives

\[
\Delta(P)>
2\varepsilon R+2C-\log2.
\]

Substituting the exact decomposition yields

\[
\delta_2(M)+\delta_2(c)
>
2\log\operatorname{rad}(m)
+2\varepsilon R+2C-\log2.
\]

Therefore at least one `x` in `{M,c}` satisfies

\[
\boxed{
\delta_2(x)
>
\log\operatorname{rad}(m)
+\varepsilon R+C-rac{\log2}{2}.
}
\]

Equivalently, on one large endpoint the above-two prime-exponent mass exceeds
its exponent-one prime mass by the displayed conductor-scale threshold.

This is stronger than the v15 statement that one prime cube occurs on one
endpoint. A fixed cube is harmless; the present theorem forces an entire
signed exponent budget to become large.

## 5. Corrected positive target

The subsequent dyadic audit shows that the two large endpoints must be
controlled together. Separate uniform subcritical bounds for each quantity

\[
W_{>2}(x)-W_1(x),
\]

are false. The family

\[
1+2^N=2^N+1
\]

gives `delta_2(2^N)=(N-2)log 2`, while the full conductor is at most
`(N+2)log 2`. Thus any separate-endpoint bound with slope below one fails
uniformly. This uses only a radical upper bound for the odd neighbour; it
does not assert that its exponent-one mass always supplies enough cancellation.

The exact remaining arithmetic problem is consequently:

> bound the sum of the two signed endpoint defects, after subtracting twice
> the small-endpoint radical logarithm, by an arbitrarily small conductor
> slope plus a constant independent of the triple.

This formulation is compatible with analytic short-interval methods,
powerful-number gap results, Frey--Szpiro estimates, and source-derived IUT
height comparisons, while retaining the possibility of cancellation between
the two endpoints. The one-endpoint event in Section 4 is a necessary
condition on a violation, not a sufficient criterion for producing one.
The complete correction and the kernel-checked unbounded obstruction are in
`SIGNED_LAYER_ARITHMETIC_SESSION_2026_08_30.md`.

## 6. Lean deliverable

```text
Lean/IUTThreeClosures/SignedPrimeExponentLayer.lean
```

Principal declarations:

```lean
SignedPrimeExponentLayer.exponentOneWeight
SignedPrimeExponentLayer.exponentAboveTwoWeight
SignedPrimeExponentLayer.total_sub_two_radical_eq_aboveTwo_sub_one
ABCPoint.singleEndpointSquareRadicalDefect
ABCPoint.abcRadical_eq_signedLayer_threeFactors
ABCPoint.conductor_eq_signedLayer_threeRadicalLogs
ABCPoint.signedEndpointSquareRadicalDefect_eq_endpoint_sum
ABCPoint.endpoint_signed_defect_large_of_height_violation
```

No unresolved distribution theorem, abc estimate, `sorry`, or `admit` is
introduced.
