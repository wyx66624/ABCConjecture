# Alternative abc Quality Metrics: the Packing-Efficiency Boundary

**Author:** ChatGPT
**Date:** 3 September 2026
**Status:** source-audited algebraic bridge and an exact abstract
counterexample to a false transfer principle; no claim of a proof or
disproof of the standard abc conjecture.

## 1. Latest-source audit

Akilan Sankaran's June 2026 preprint *Variants on the abc-Conjecture using
Alternative Quality Metrics* (arXiv:2606.08416v1) introduces the doubly
geometric mean quality and a power-mean family.  It proves unconditional
divergence for an alternative quality by applying Chen's theorem.  The
paper also defines the packing efficiency

\[
 \eta=\frac GA,
\]

where `G` and `A` are the geometric and arithmetic means of the logarithms
of the distinct primes dividing `abc`, and obtains the exact identity

\[
 q_{\rm std}=\eta q_{\rm DGM}.                     \tag{1.1}
\]

Its Theorem 4.15 rewrites the standard abc inequality as

\[
 q_{\rm DGM}\le\frac{1+\varepsilon}{\eta}.         \tag{1.2}
\]

This is a useful coordinate description, but (1.2) is pointwise equivalent
to the original standard-quality bound.  It supplies no new estimate on
either factor.  In particular, divergence of `q_DGM` is compatible with a
bounded standard quality when `eta` decays.

The official arXiv PDF, a searchable extraction, hashes, metadata and an
independent standard-library verifier are archived in
`research/sources/alternative_quality_metrics_2026_09_03/`.

## 2. Exact positive transfer

### Proposition 2.1 (packing-coordinate equivalence)

Let `q_s,q_D,eta,B` be real numbers.  Suppose

\[
 q_s=\eta q_D,\qquad \eta>0.                       \tag{2.1}
\]

Then

\[
 q_s\le B\quad\Longleftrightarrow\quad
 q_D\le\frac B\eta.                               \tag{2.2}
\]

#### Proof

Substitute (2.1).  Division of the inequality
`eta*q_D <= B` by the positive number `eta` preserves its direction and
gives `q_D <= B/eta`.  Multiplication by `eta` proves the converse.
\(\square\)

This proposition proves exactly what the packing reformulation contributes:
it transfers a bound without loss once the reciprocal efficiency has been
controlled.  Taking `B=1+epsilon` gives (1.2).

### Proposition 2.2 (AM--GM one-sided comparison)

Suppose

\[
 q_s=\eta q_D,\qquad 0\le\eta\le1,\qquad q_D\ge0.
\]

Then

\[
 0\le q_s\le q_D.                                  \tag{2.3}
\]

#### Proof

Both factors in `q_s=eta*q_D` are nonnegative, so `q_s>=0`.  Multiplying
`eta<=1` by the nonnegative number `q_D` yields
`eta*q_D<=q_D`, which is (2.3).  \(\square\)

Thus a sufficiently strong upper bound for the alternative quality would
imply the corresponding standard bound.  An alternative-quality lower
bound or divergence result runs in the opposite direction and needs a
lower bound on `eta` before it can force large standard quality.

### Proposition 2.3 (clustered logarithms prevent efficiency decay)

Let `L>0`, `C>=0`, and suppose positive mean values `G,A` satisfy

\[
 L\le G\le A\le L+C.
\]

Then

\[
 \frac GA\ge\frac{L}{L+C}.                         \tag{2.4}
\]

#### Proof

Because `A<=L+C` and `L/(L+C)>=0`,

\[
 \frac{L}{L+C}A\le L\le G.
\]

Division by the positive number `A` gives (2.4).  \(\square\)

For logarithms of distinct primes in `[X,e^C X]`, one has
`L=log X`, `G>=L`, and `A<=L+C`; hence `eta>=L/(L+C)->1` as `X->infinity`,
independently of how many such primes are selected.  For every fixed `C>0`,
the prime number theorem supplies arbitrarily large finite clusters in the
fixed multiplicative interval `[X,e^C X]`.  Thus the number of prime
coordinates and the size of the largest coordinate alone do not force
packing efficiency to vanish.

This exposes a scope issue in one extension following Theorem 4.13 of the
source.  The decay clause of Lemma 4.12 explicitly holds when the number of
primes and the complementary product `N_0` remain fixed while one prime
`P` grows.  The later application has a growing `omega_n` and does not hold
`N_n/P_n` fixed.  Its displayed conclusion about `eta_n` therefore does not
follow from the stated additional largest-prime hypothesis alone.  The source
also glosses `log P_n = O(log c_n)` as `P_n ~ c_n^kappa`; Big-O gives only a
power upper bound and is not equivalent to that asymptotic relation.

A second, separate caution concerns the proof of Theorem 4.10 at the critical
boundary: its displayed argument invokes Lemma 4.11 for an upper estimate but
then describes the limiting constant as exact.  The main limsup inequality in
Theorem 4.13 needs only the upper estimate, so none of the algebra formalized
here uses the unproved reverse bound.

The exact factorization (1.1), the Chen-based alternative-metric divergence
theorem, and the packing equivalence remain unaffected by these two scope
issues.  The clustered-prime stress test is not asserted to arise from actual
additive abc triples; an arithmetic constraint on such triples could still
provide the missing dispersion.

## 3. Exact counterexample to divergence transfer

### Proposition 3.1 (vanishing packing absorbs divergence)

There are sequences `eta,q_D,q_s : N -> R` such that, for every `n`,

\[
 0<\eta_n\le1,
 \qquad q_{D,n}>0,
 \qquad q_{s,n}=\eta_nq_{D,n},                     \tag{3.1}
\]

the sequence `q_D` is unbounded above, but

\[
 q_{s,n}=1                                         \tag{3.2}
\]

for every `n`.

#### Proof

Set

\[
 q_{D,n}=n+1,
 \qquad \eta_n=\frac1{n+1},
 \qquad q_{s,n}=1.
\]

All conditions in (3.1) are immediate, and the product identity is exact.
Given a real `K`, the Archimedean property supplies a natural number `n`
with `K<n`; then `K<n+1=q_{D,n}`, so `q_D` is unbounded.  Equation (3.2)
holds by definition.  \(\square\)

This is a full-premise counterexample to the **abstract inference**

> unbounded `q_D`, together with `0<eta<=1` and
> `q_s=eta*q_D`, forces `q_s` above one.

It is not a family of integer abc triples and therefore is not a
counterexample to abc or to any arithmetic assertion in Sankaran's paper.
It deletes only the metric-only inference.  The arithmetic route remains
active: it must prove a lower packing-efficiency estimate, or a correlated
estimate in which growth of `q_DGM` dominates decay of `eta`, on actual abc
triples.

## 4. Formalization boundary

The companion Lean module
`AlternativeQualityPackingBridge20260903` formalizes Propositions 2.1--2.3
and 3.1 over the real numbers.  Its witness is deliberately abstract,
so the formal statement cannot be mistaken for an arithmetic
counterexample.

The next positive gate is a theorem about actual prime-log vectors:
construct a family of primitive abc triples and prove either

\[
 \eta q_{\rm DGM}>1+\delta
\]

often enough to force standard-quality excess, or the upper correlation
needed to recover the standard abc bound.  No such unconditional estimate
is currently known.

## Reference

Akilan Sankaran, *Variants on the abc-Conjecture using Alternative Quality
Metrics*, arXiv:2606.08416v1 (7 June 2026),
<https://arxiv.org/abs/2606.08416>.
