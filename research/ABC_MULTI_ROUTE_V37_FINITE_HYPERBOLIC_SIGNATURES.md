# ABC multi-route research note v37: finite hyperbolic signature reduction

**Author:** ChatGPT  
**Date:** 2026-08-31

## Status

The v36 adaptive construction assigns three hyperbolic exponents to every
hypothetical non-short-gap abc counterexample, but those exponents may vary
with the point.  This note proves that, for each fixed positive epsilon, the
adaptive exponents can be lowered to a bounded finite range while preserving:

1. exponent at least two;
2. strict hyperbolicity;
3. a fixed positive canonical-root height margin.

Thus moving exponents are no longer a necessary obstruction.  The remaining
uniformity problem lies in the conductor-supported residue coefficients and
points, not in an unbounded set of signatures.

## 1. Starting adaptive estimates

Let the v36 adaptive exponents be

\[
a_i=
\left\lfloor
\frac{(1-\delta)T_i}{r_i}
\right\rfloor+1,
\qquad i=1,2,3,
\]

where

\[
\delta=rac{\varepsilon}{2(2+\varepsilon)}.
\]

They satisfy

\[
a_i\ge2,                                                \tag{1.1}
\]

\[
\frac1{a_1}+\frac1{a_2}+\frac1{a_3}
<
\frac4{4+\varepsilon},                                  \tag{1.2}
\]

and, for the canonical `a_i`-th root weights,

\[
\delta T_i\le a_i Q_{a_i,i}.                            \tag{1.3}
\]

The explicit value on the right of (1.2), rather than merely `<1`, leaves a
slack

\[
1-rac4{4+\varepsilon}
=
\frac{\varepsilon}{4+\varepsilon}.                     \tag{1.4}
\]

## 2. Explicit finite cap

Define

\[
\boxed{
K_\varepsilon
=
\left\lfloor
\frac{6(4+\varepsilon)}{\varepsilon}
\right\rfloor+1.
}                                                       \tag{2.1}
\]

Then

\[
K_\varepsilon>
\frac{6(4+\varepsilon)}{\varepsilon},                  \tag{2.2}
\]

so

\[
\boxed{
\frac3{K_\varepsilon}
<
\frac{\varepsilon}{2(4+\varepsilon)}.
}                                                       \tag{2.3}
\]

In particular, `K_epsilon>=2`.

For each endpoint set

\[
\boxed{k_i=\min(a_i,K_\varepsilon).}                   \tag{2.4}
\]

Then

\[
2\le k_i\le K_\varepsilon.                             \tag{2.5}
\]

## 3. Hyperbolicity survives capping

For positive integers `a,K`,

\[
\boxed{
\frac1{\min(a,K)}
\le
\frac1a+\frac1K.
}                                                       \tag{3.1}
\]

Indeed, if `a<=K`, the left side is `1/a`; if `K<=a`, it is `1/K`.
Summing (3.1) and applying (1.2)--(2.3),

\[
\begin{aligned}
\frac1{k_1}+\frac1{k_2}+\frac1{k_3}
&\le
\frac1{a_1}+\frac1{a_2}+\frac1{a_3}
+rac3{K_\varepsilon}\\
&<
\frac4{4+\varepsilon}
+
\frac{\varepsilon}{2(4+\varepsilon)}\\
&=
1-rac{\varepsilon}{2(4+\varepsilon)}\\
&<1.
\end{aligned}                                          \tag{3.2}
\]

Therefore the capped signature remains strictly hyperbolic and belongs to the
finite set

\[
\boxed{
\left\{
(k_1,k_2,k_3):
2\le k_i\le K_\varepsilon,
\quad
\sum_i\frac1{k_i}<1
\right\}.
}                                                       \tag{3.3}
\]

## 4. Root margins survive lowering the exponent

Since

\[
k_i\le a_i,
\]

we have

\[
k_i-1\le a_i-1
\le
\frac{(1-\delta)T_i}{r_i}.                             \tag{4.1}
\]

The canonical `k_i`-th-root ledger gives

\[
T_i\le(k_i-1)r_i+k_iQ_{k_i,i}.                         \tag{4.2}
\]

Using (4.1),

\[
\boxed{
\delta T_i\le k_iQ_{k_i,i}.
}                                                       \tag{4.3}
\]

Thus capping does not weaken the fixed endpoint-height margin.  Lowering an
exponent reduces the number of radical layers that the residue coefficient is
allowed to consume.

## 5. Resulting generalized-Fermat family

Every sufficiently large hypothetical non-short-gap counterexample therefore
has a decomposition

\[
\kappa_1X_1^{k_1}
+
\kappa_2X_2^{k_2}
=
\kappa_3X_3^{k_3},                                     \tag{5.1}
\]

where

\[
2\le k_i\le K_\varepsilon,
\qquad
\frac1{k_1}+\frac1{k_2}+\frac1{k_3}<1,                \tag{5.2}
\]

and

\[
\delta T_i\le k_i\log X_i.                            \tag{5.3}
\]

For fixed epsilon, only finitely many signatures occur.  This removes the
quantifier problem caused by applying a different fixed-signature theorem to
an unbounded sequence of exponents.

## 6. Remaining uniformity problem

The finite-signature reduction still does not complete abc because the
power-free residue coefficients

\[
\kappa_1,\kappa_2,\kappa_3
\]

move with the point.  Their prime support lies inside the abc conductor, but
their magnitudes can still be a fixed positive fraction of endpoint height.

The decisive remaining theorem can now be stated without moving exponents:

> For every fixed positive epsilon and every hyperbolic signature in the
> finite set (3.3), prove a height bound uniform in all primitive coefficient
> triples whose support is contained in the abc conductor and whose canonical
> roots satisfy (5.3).

Equivalently, one may prove that a violation forces a positive conductor-slope
increase after a Frey/descent step for at least one of the finitely many
signatures.

## 7. Lean implementation

The module

```text
Lean/IUTThreeClosures/FiniteHyperbolicSignatureCap.lean
```

formalizes:

```lean
signatureCap
cappedExponent
cap_ratio_lt
two_le_signatureCap
three_div_signatureCap_lt_half_slack
reciprocal_cappedExponent_le_add
capped_reciprocal_sum_lt_one
capped_root_margin
capped_profile_signature
```

The cap and all three exponents are explicit.  The file introduces no
finiteness theorem, modularity hypothesis, abc conclusion, `axiom`, `sorry`,
or `admit`.
