# Adaptive root-stack saturation and the fixed-order obstruction

## 1. Local exponent model

For positive integers `e,m`, the least exponent of `p` in an integer whose
`m`-th power is divisible by `p^e` is

\[
  \left\lceil\frac em\right\rceil.
\]

Equivalently, Mathlib's divisibility-theoretic ceiling root satisfies

\[
  \operatorname{ceilRoot}_m(p^e)
  =p^{\lceil e/m\rceil}.
\]

This is the exact exponent arithmetic behind root stacks and Kummer saturation
at a boundary contact of order `e`.

## 2. Adaptive radicalization theorem

### Theorem 2.1

For every prime `p` and every positive integer `e`,

\[
  \operatorname{ceilRoot}_e(p^e)=p.
\]

Thus choosing the root order to equal the actual contact multiplicity changes a
prime-power contact to contact order one.

### Proof

The least `b` such that `p^e` divides `b^e` is `p`; equivalently the ceiling
of `e/e` is one.

For an integer

\[
  n=\prod_{p\mid n}p^{e_p},
\]

performing this operation separately at each supporting prime produces

\[
  \prod_{p\mid n}p=\operatorname{rad}(n).
\]

This explains precisely why a **point-dependent multi-root construction** is
capable of seeing the radical.

## 3. Fixed-order no-go theorem

### Theorem 3.1

Fix `m>=1`. For every `k>=0`,

\[
  \operatorname{ceilRoot}_m(p^{km})=p^k.
\]

In particular the residual exponent is unbounded as `k` grows.

### Consequence

No root stack with one fixed stabilizer order `m`, and no finite collection of
fixed root orders, can truncate arbitrary valuation multiplicities to support
one. For example, contacts `p^{km}` retain exponent `k` after the `m`-th root
operation.

This eliminates the naive proposal that one fixed stacky curve

\[
  \mathbb P^1[(0,m),(1,m),(\infty,m)]
\]

could by itself replace every local multiplicity by a radical indicator.

It does **not** eliminate adaptive multi-root stacks whose indices depend on the
actual valuation vector. Those objects vary with the arithmetic point and
therefore incur a globalization/discriminant cost.

## 4. Complexity of adaptive indices

For a finite support `P` with multiplicities `e_p`, the information needed to
record the variable indices is

\[
  \mathcal E=\sum_{p\in P}\log(e_p+1).
\]

The separate multiplicity-entropy theorem proves that for every `eta>0`,

\[
  \mathcal E
  \le
  \eta\sum_{p\in P}e_p\log p+C_\eta.
\]

The Kummer root-discriminant theorem likewise gives a globalization field with

\[
  \log\operatorname{rd}(K)
  \le
  \log\operatorname{rad}(n)
  +\eta\log n+C_\eta.
\]

Hence the **index complexity** of adaptive radicalization is of the correct
quantifier shape for an abc argument.

## 5. The exact surviving theorem

The remaining issue is not the local exponent arithmetic. It is the existence
of a functorial adelic or stacky object `Sat(n)` such that:

1. its local tautological parameter has contact one at every `p|n`;
2. its positive finite degree is `log rad(n)`;
3. its failure to descend to one ordinary global line is bounded by the
   root-discriminant and entropy estimates above;
4. its canonical archimedean metric and level-prime terms have arbitrarily
   small slope relative to the Frey height;
5. a geometric comparison recovers the original Tate/Hodge quantity without
   reintroducing the full multiplicity through an ordinary tensor-power
   identity.

The last condition is essential. If an ordinary metrized line `R` satisfies an
isometric identity `R^tensor e = Q`, then

\[
  \widehat\deg Q=e\,\widehat\deg R,
\]

so the original multiplicity returns exactly. A successful construction must
therefore use genuinely stacky pushforward, a nonlinear determinant/hull, or a
maximal-slope operation whose Jacobian is explicitly controlled.

## 6. Formalization status

`AdaptiveRootSaturation.lean` kernel-checks:

- exact adaptive radicalization on prime powers;
- the fixed-order prime-power formula;
- unbounded residual multiplicity for every fixed positive root order;
- the corresponding ceiling-division identities.

No global stack, Arakelov source theorem, IUT comparison, or `ABCConjecture`
conclusion is assumed in the Lean file.
