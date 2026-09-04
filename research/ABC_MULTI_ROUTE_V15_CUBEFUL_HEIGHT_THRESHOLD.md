# ABC multi-route research note v15: the exact cubeful-excess height threshold

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Why the conductor-relative v14 target is too strong

Let

\[
Q_2(n)=\frac{n}{\gcd(n,\operatorname{rad}(n)^2)}.
\]

The v14 ledger correctly gives

\[
2\log c\le \log2+2\log\operatorname{rad}(abc)
  +\log Q_2(\max(a,b)c).
\]

However, the proposed uniform estimate

\[
\log Q_2(\max(a,b)c)
 \le 2\varepsilon\log\operatorname{rad}(abc)+O_\varepsilon(1)
\]

is not a plausible universal target.  For the primitive family

\[
1+2^k=2^k+1,
\]

the factor `2^k` alone contributes approximately one full height unit to
`log Q_2`, while the opposite endpoint can contribute enough radical to make
the abc inequality harmless.  Thus one large cubeful endpoint is compatible
with abc; the excess must be compared to height before it can be used as a
necessary obstruction.

## 2. Correct exact ledger

Set

\[
M=\max(a,b),\qquad Q_P=Q_2(Mc).
\]

Since `c <= 2M`,

\[
c^2\le2Mc.
\]

Moreover

\[
Mc\le\operatorname{rad}(Mc)^2Q_P
   \le\operatorname{rad}(abc)^2Q_P.
\]

Therefore

\[
\boxed{
2h\le\log2+2R+\log Q_P,
}
\]

where

\[
h=\log c,\qquad R=\log\operatorname{rad}(abc).
\]

This identity separates the ordinary radical budget from exactly the prime
exponent mass above level two.

## 3. Bounded excess gives a strong partial abc theorem

If

\[
\log Q_P\le K,
\]

then

\[
\boxed{
h\le R+\frac{K+\log2}{2}.
}
\]

Thus every class of triples with uniformly bounded cubeful excess satisfies a
coefficient-one abc estimate, with no epsilon loss.

More generally, if

\[
\log Q_P\le 2\delta h+K,
\qquad \delta<1,
\]

then

\[
\boxed{
h\le
\frac{2R+K+\log2}{2(1-\delta)}.
}
\]

This is the exact height-relative transfer threshold.

## 4. Every abc violation forces positive height-slope excess

Assume

\[
h>(1+\varepsilon)R+C,
\qquad \varepsilon>0.
\]

Rearranging the ledger gives

\[
2h-\log2-2R\le\log Q_P.
\]

Multiplying by `1+epsilon` and using the violation yields

\[
\boxed{
2\varepsilon h+2C-(1+\varepsilon)\log2
 <(1+\varepsilon)\log Q_P.
}
\]

Equivalently,

\[
\log Q_P>
\frac{2\varepsilon}{1+\varepsilon}h
 +\frac{2C}{1+\varepsilon}-\log2.
\]

Consequently an unbounded counterexample family cannot merely contain an
isolated prime cube.  Its exponent mass above level two must occupy a fixed
positive proportion of the logarithmic height.

## 5. Remaining arithmetic problem

The next step cannot be the false universal assertion `Q_P=rad^{o(1)}`.
Instead one must exploit how the excess is distributed between the two
coprime nearby integers

\[
M,\qquad c=M+\min(a,b).
\]

The model family `1+2^k=2^k+1` shows why localization matters: one endpoint
may carry linear cubeful excess, provided the other endpoint supplies nearly
one full height unit of radical.  A genuine counterexample must defeat this
compensation.  The next target is therefore a two-endpoint dichotomy:

* either the opposite endpoint has sufficiently large radical and abc closes;
* or both nearby endpoints carry positive-height repeated-prime mass, reducing
  the problem to a quantitative gap theorem for two highly powerful coprime
  integers.

## 6. Lean deliverable

The formalization is

```text
Lean/IUTThreeClosures/LargeEndpointCubefulHeightThreshold.lean
```

Its main declarations are:

```lean
gcd_mul_cubefulExcess_eq
le_radical_sq_mul_cubefulExcess
ABCPoint.c_sq_le_two_radical_sq_mul_largePairCubefulExcess
ABCPoint.two_mul_height_le_log_two_add_two_mul_conductor_add_log_largePairCubefulExcess
ABCPoint.height_le_conductor_add_constant_of_log_largePairCubefulExcess_le
ABCPoint.height_le_of_largePairCubefulExcess_heightSlope
ABCPoint.largePairCubefulExcess_heightSlope_large_of_abc_violation
```

No abc conclusion or estimate for the cubeful excess is assumed as an axiom.
