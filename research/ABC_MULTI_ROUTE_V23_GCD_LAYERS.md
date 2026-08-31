# ABC multi-route research note v23: simultaneous endpoint multiplicity and gcd layers

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Simultaneous multiplicity is forced on both large endpoints

Let

\[
m=\min(a,b),\qquad M=\max(a,b),\qquad m+M=c,
\]

and write

\[
h=\log c,
\qquad
R=\log\operatorname{rad}(abc).
\]

For a positive integer `n`, put

\[
E_1(n)=\log n-\log\operatorname{rad}(n).
\]

If

\[
(1+\varepsilon)R+C<h,
\qquad \varepsilon>0,
\]

then each endpoint radical is bounded by `R`, and `M>=c/2`.  Hence

\[
\boxed{
\varepsilon h+C
<
(1+\varepsilon)E_1(c)
}
\]

and

\[
\boxed{
\varepsilon h+C-(1+\varepsilon)\log2
<
(1+\varepsilon)E_1(M).
}
\]

Thus every unbounded counterexample family carries a fixed positive
multiplicity slope on both large adjacent endpoints, not merely on one of
them.

## 2. A concrete quotient without choosing a factorization

Define

\[
Q_1(n)=
\frac{n}{\gcd(n,\operatorname{rad}(n))}.
\]

The exact identity

\[
\gcd(n,\operatorname{rad}(n))Q_1(n)=n
\]

and the inequality

\[
\gcd(n,\operatorname{rad}(n))\le\operatorname{rad}(n)
\]

give

\[
n\le\operatorname{rad}(n)Q_1(n).
\]

Therefore

\[
E_1(n)\le\log Q_1(n).
\]

The preceding violation estimates consequently force `Q_1(M)` and `Q_1(c)`
to be simultaneously height-scale.

## 3. A factorization-free second layer

Put

\[
L_1(n)=\gcd(n,\operatorname{rad}(n)),
\]

\[
L_2(n)=\gcd(L_1(n),Q_1(n)),
\]

and

\[
Q_2(n)=Q_1(n)/L_2(n).
\]

Then

\[
\boxed{
n=L_1(n)L_2(n)Q_2(n).
}
\]

Since `L_2` divides both `L_1` and `Q_1`,

\[
\boxed{
L_2(n)^2\mid n.
}
\]

For positive `n`, all three factors are positive, so

\[
\boxed{
\log Q_1(n)=\log L_2(n)+\log Q_2(n).
}
\]

Consequently, if

\[
T<\lambda\log Q_1(n),
\qquad \lambda\ge0,
\]

then

\[
\boxed{
\frac T2<\lambda\log L_2(n)
\quad\text{or}\quad
\frac T2<\lambda\log Q_2(n).
}
\]

The first alternative gives a quantitatively large genuine square divisor;
the second says that a fixed proportion of the multiplicity survives after
stripping two support layers.

Applying this independently to `M` and `c` produces a simultaneous four-way
split.  Every alleged abc counterexample must place each large endpoint in
one of the following states:

1. a large repeated-prime support, hence a large square divisor;
2. a large deeper quotient, hence substantial exponent mass at level three
   or above.

## 4. Iteration and the canonical generalized Pell branch

The gcd construction iterates.  Starting from `(L_1,Q_1)`, define

\[
L_{j+1}=\gcd(L_j,Q_j),
\qquad
Q_{j+1}=Q_j/L_{j+1}.
\]

Primewise, `L_j` is the support of exponents at least `j`, but the definition
uses only gcd and division.  One obtains

\[
n=L_1L_2\cdots L_kQ_k,
\]

and

\[
L_k^k\mid n.
\]

A finite-depth iteration therefore yields the exact alternative:

- a height-scale `k`-th-power divisor appears at some bounded layer; or
- a height-scale quotient remains after `k` layers, forcing exponents above
  `k`.

At depth two, canonical square decompositions of both large endpoints lead to

\[
M=uX^2,
\qquad
c=vY^2,
\qquad
vY^2-uX^2=m,
\]

with squarefree kernels supported on the abc radical.  The present Lean
increment formalizes the two-endpoint multiplicity theorem and the first gcd
refinement.  The full recursive layer theorem and canonical Pell conversion
are the next formalization target.

## 5. Lean modules

```text
Lean/IUTThreeClosures/BothLargeEndpointMultiplicityExcess.lean
Lean/IUTThreeClosures/BothEndpointFirstLayerExcessQuotient.lean
Lean/IUTThreeClosures/FirstLayerGCDRefinement.lean
```

These modules introduce no `axiom`, `sorry`, or `admit`, and they do not
assume an abc conclusion.
