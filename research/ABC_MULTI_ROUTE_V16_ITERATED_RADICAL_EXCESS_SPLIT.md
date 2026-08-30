# ABC multi-route research note v16: exact splitting of the high-multiplicity excess

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Definition

For a positive integer `n`, write

\[
D(n)=\frac{n}{\operatorname{rad}(n)}
\]

and define the second radical quotient

\[
Q_2(n)=D(D(n)).
\]

Primewise, if `v_p(n)=e`, then

\[
v_p(Q_2(n))=\max(e-2,0).
\]

Thus `Q_2` records precisely the multiplicity mass above level two. It is an
algebraically convenient version of the cubeful-excess quantity introduced in
v14.

## 2. Multiplicativity on coprime inputs

If `gcd(m,n)=1`, then

\[
\operatorname{rad}(mn)=\operatorname{rad}(m)\operatorname{rad}(n),
\]

and therefore

\[
D(mn)=D(m)D(n).
\]

The divisors `D(m)` and `D(n)` remain coprime, so applying the same identity a
second time gives

\[
\boxed{Q_2(mn)=Q_2(m)Q_2(n).}
\]

This is formalized without assuming any distribution theorem.

## 3. Radical-square ledger

The exact double factorization is

\[
n=\operatorname{rad}(n)
\operatorname{rad}(D(n))Q_2(n).
\]

Since `D(n)` divides `n`, radical monotonicity gives

\[
\operatorname{rad}(D(n))\le\operatorname{rad}(n).
\]

Hence

\[
\boxed{n\le\operatorname{rad}(n)^2Q_2(n).}
\]

For a primitive abc point let

\[
M=\max(a,b).
\]

Using `c^2<=2Mc`, radical monotonicity, and the preceding inequality gives

\[
\boxed{
c^2\le2\operatorname{rad}(abc)^2Q_2(Mc).
}
\]

Taking logarithms yields

\[
2\log c\le
\log2+2\log\operatorname{rad}(abc)+\log Q_2(Mc).
\]

## 4. Exact endpoint splitting

The v15 localization theorem proves `gcd(M,c)=1`. Therefore

\[
\boxed{Q_2(Mc)=Q_2(M)Q_2(c)}
\]

and

\[
\boxed{
\log Q_2(Mc)=\log Q_2(M)+\log Q_2(c).
}
\]

This removes the final product ambiguity in the quantitative excess ledger.

## 5. Necessary one-endpoint concentration

Suppose an abc point violates

\[
\log c\le
(1+\varepsilon)\log\operatorname{rad}(abc)+C.
\]

Then the ledger implies

\[
\log Q_2(Mc)>
2\varepsilon\log\operatorname{rad}(abc)+2C-\log2.
\]

By the exact additive splitting, at least one endpoint satisfies

\[
\boxed{
\log Q_2(M)>
\varepsilon\log\operatorname{rad}(abc)+C-\frac{\log2}{2}
}
\]

or

\[
\boxed{
\log Q_2(c)>
\varepsilon\log\operatorname{rad}(abc)+C-\frac{\log2}{2}.
}
\]

Thus every unbounded counterexample family must place conductor-scale
high-multiplicity mass on one individual integer in the short-gap pair, rather
than distributing it harmlessly across their product.

## 6. Remaining theorem

A complete proof via this route would follow from the uniform estimate

\[
\log Q_2(Mc)\le
2\varepsilon\log\operatorname{rad}(abc)+K_\varepsilon.
\]

Equivalently, using the exact splitting, it is enough to control the sum of the
individual excesses on `M` and `c`. The current note proves the reduction and
the necessary concentration theorem, not this still-open uniform estimate.

## 7. Lean deliverable

```text
Lean/IUTThreeClosures/IteratedRadicalExcessSplit.lean
```

Core declarations:

```lean
divRadical_mul_of_coprime
secondRadicalQuotient_mul_of_coprime
le_radical_sq_mul_secondRadicalQuotient
ABCPoint.largeEndpointSecondRadicalQuotient_eq_mul
ABCPoint.two_mul_height_le_log_two_add_two_mul_conductor_add_log_secondQuotient
ABCPoint.log_largeEndpointSecondRadicalQuotient_eq_add
ABCPoint.endpoint_secondRadicalQuotient_large_of_height_violation
abc_of_uniformSecondRadicalQuotientBound
```
