# ABC multi-route research note v18: exact endpoint radical/excess budget

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Ordered endpoint decomposition

For a positive primitive triple `a+b=c`, put

\[
m=\min(a,b),\qquad M=\max(a,b).
\]

Then

\[
mM=ab,
\]

and pairwise coprimality gives

\[
\gcd(m,Mc)=1.
\]

Consequently

\[
\boxed{
\operatorname{rad}(abc)
=
\operatorname{rad}(m)\operatorname{rad}(Mc).
}
\]

Writing

\[
S=\log\operatorname{rad}(m),\qquad
L=\log\operatorname{rad}(Mc),
\]

the elementary conductor splits exactly as

\[
\boxed{R=S+L.}
\]

## 2. Sharpened large-pair ledger

Let

\[
Q_2(n)=D(D(n)),\qquad D(n)=n/\operatorname{rad}(n).
\]

The v16 radical-square estimate can be applied directly to `Mc`, without
first enlarging its radical to the full `abc` radical:

\[
Mc\le\operatorname{rad}(Mc)^2Q_2(Mc).
\]

Since `c^2<=2Mc`,

\[
\boxed{
c^2\le2\operatorname{rad}(Mc)^2Q_2(Mc).
}
\]

Taking logarithms gives

\[
\boxed{
2\log c\le\log2+2L+\log Q_2(Mc).
}
\]

The small endpoint radical does not occur in the coefficient-two base term.

## 3. Exact sufficient budget

For a fixed `epsilon>0`, suppose

\[
\boxed{
\log Q_2(Mc)
\le
2\varepsilon L+2(1+\varepsilon)S+K.
}
\]

Then

\[
2\log c
\le
\log2+2(1+\varepsilon)(L+S)+K,
\]

and therefore

\[
\boxed{
\log c\le
(1+\varepsilon)R+rac{K+\log2}{2}.
}
\]

Thus this split estimate is a sufficient route to the standard abc bound.

## 4. Necessary obstruction in a violation

If

\[
\log c>(1+\varepsilon)R+C,
\]

then the same ledger forces

\[
\boxed{
\log Q_2(Mc)>
2\varepsilon L+2(1+\varepsilon)S+2C-\log2.
}
\]

This is sharper than charging the repeated-prime excess only against the full
conductor. A counterexample family would need both:

1. unusually small radical mass on the smaller endpoint, so that `S` cannot
   absorb the excess;
2. unusually large multiplicity-above-two mass on the two large adjacent
   endpoints.

Combined with v12, any coefficient-three symmetric-product route need only
control this joint obstruction on the power-saving endpoint locus.

## 5. Scope

The split estimate above is sufficient, not asserted unconditionally here.
The Lean module proves the exact radical factorization, the sharpened ledger,
the closure implication, and its quantitative contrapositive.

## 6. Lean deliverable

```text
Lean/IUTThreeClosures/EndpointRadicalExcessBudget.lean
```

Core declarations:

```lean
ABCPoint.endpointMin_mul_largeEndpoint_eq_ab
ABCPoint.endpointMin_coprime_largePair
ABCPoint.abcRadical_eq_small_mul_largePair
ABCPoint.conductor_eq_smallEndpointRadicalLog_add_largePairRadicalLog
ABCPoint.two_mul_height_le_log_two_add_two_mul_largePairRadicalLog_add_log_secondQuotient
ABCPoint.height_le_of_split_excess_bound
ABCPoint.split_excess_large_of_height_violation
abc_of_uniformSplitEndpointExcessBound
```
