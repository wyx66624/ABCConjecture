# ABC multi-route research note v42: canonical square-divisor extraction

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Canonical construction

Let

\[
n=\prod_p p^{e_p}>0.
\]

Define

\[
q(n)=\prod_p p^{\lfloor e_p/2\rfloor}.
\]

This is an actual positive integer. Primewise,

\[
2\left\lfloor\frac{e_p}{2}\right\rfloor\le e_p,
\]

so

\[
\boxed{q(n)^2\mid n.}
\]

The complementary inequality

\[
e_p\le1+2\left\lfloor\frac{e_p}{2}\right\rfloor
\]

implies

\[
\boxed{
n\mid\operatorname{rad}(n)q(n)^2.
}
\]

Consequently

\[
n\le\operatorname{rad}(n)q(n)^2.
\]

## 2. Logarithmic multiplicity excess

Taking logarithms gives

\[
\boxed{
\log n-\log\operatorname{rad}(n)
\le2\log q(n).
}
\]

Thus the explicit repeated-prime statistic appearing in the v41 minimal
split-square theorem always yields a genuine square divisor. In particular,
if

\[
\log n-\log\operatorname{rad}(n)
>\delta H-B,
\]

then

\[
\boxed{
\log q(n)>
\frac\delta2H-rac B2.
}
\]

## 3. Application to the companion sum

For a height-minimal split-square counterexample, v41 gives

\[
\log(y+x)-\log\operatorname{rad}(y+x)
>
\frac{\varepsilon}{1+\varepsilon}\log y-\log2.
\]

Therefore its canonical square root satisfies

\[
\boxed{
\log q(y+x)
>
\frac{\varepsilon}{2(1+\varepsilon)}\log y
-
\frac{\log2}{2},
}
\]

and

\[
q(y+x)^2\mid y+x.
\]

The companion sum hence contains an actual height-scale square divisor, not
only an abstract weighted square budget.

## 4. Lean module

```text
Lean/IUTThreeClosures/CanonicalSquareDivisor.lean
```

Core declarations:

```lean
squareRootFactorization
canonicalSquareRoot
factorization_canonicalSquareRoot
canonicalSquareRoot_sq_dvd
self_dvd_radical_mul_canonicalSquareRoot_sq
log_sub_log_abcRadical_le_two_log_canonicalSquareRoot
```

The construction is derived directly from `Nat.factorization` and contains no
ABC assumption.
