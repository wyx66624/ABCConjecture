# Metric-normalization obstruction for arithmetic Hodge-line arguments

## 1. Normalized Arakelov degree

Let `K` be a number field and let `L` be a rank-one projective
`O_K`-module equipped with Hermitian norms `||.||_sigma` at the archimedean
embeddings.  For a nonzero rational section `s`, the normalized Arakelov degree
has the form

\[
 \widehat{\deg}_{\!n}(\overline L)
 =\frac1{[K:\mathbb Q]}
 \left(
   \sum_{\mathfrak p}v_{\mathfrak p}(s)\log N\mathfrak p
   -\sum_{\sigma}n_\sigma\log\|s\|_\sigma
 \right),
\]

with `n_sigma=1` at a real embedding and `n_sigma=2` for a representative of a
complex-conjugate pair.  The expression is independent of `s` by the product
formula.

## 2. Rescaling theorem

### Theorem 2.1

For real numbers `t_sigma` compatible with complex conjugation, define new
metrics by

\[
  \|x\|'_\sigma=e^{-t_\sigma}\|x\|_\sigma.
\]

Then

\[
 \widehat{\deg}_{\!n}(L,\|\cdot\|')
 =\widehat{\deg}_{\!n}(L,\|\cdot\|)
 +\frac1{[K:\mathbb Q]}
   \sum_\sigma n_\sigma t_\sigma.
\]

#### Proof

The finite lattice and every finite valuation of `s` are unchanged.  At an
archimedean embedding,

\[
 -\log\|s\|'_\sigma
 =-\log\|s\|_\sigma+t_\sigma.
\]

Substitute into the definition.

### Corollary 2.2 (one-parameter ambiguity)

If all archimedean metrics are multiplied by the same factor `e^{-t}`, the
normalized Arakelov degree increases by exactly `t`.

### Corollary 2.3 (tensor powers do not remove the ambiguity)

The induced metric on `L^{\otimes r}` is rescaled by `e^{-rt}`.  Hence

\[
  \frac1r
  \widehat{\deg}_{\!n}(\overline L^{\otimes r})
\]

also changes by exactly `t`.  Passing to large symmetric or tensor powers does
not make an unspecified metric normalization into an `o(r)` error.

## 3. Consequence for the Legendre parabolic route

The following data are invariant under the rescaling above:

1. the algebraic Hodge line;
2. its geometric/parabolic degree;
3. the maximal-Higgs identity
   `L^2 = Omega^1(log{0,1,infinity})`;
4. all finite integral lattices and good-place unit statements;
5. the local monodromy and Picard--Lefschetz filtrations.

The arithmetic degree is not invariant.  Therefore these data alone cannot
imply an inequality with a specified constant such as

\[
  \widehat{\deg}(L^{\ell-1})
  \leq
  \left(\frac{\ell-1}{2}+o(\ell)\right)
  (\log\operatorname{Diff}+\log\operatorname{Cond})
  +O(\ell\log\ell).
\]

An argument must specify a canonical archimedean metric and prove its exact
comparison with the local Tate/Neron normalization.

## 4. Determinant version

Let `V` be a rank-`r` Hermitian vector bundle.  Multiplying its metric by
`e^{-t}` multiplies the determinant norm by `e^{-rt}` and shifts the normalized
slope by `t`.  Consequently an evaluation determinant or theta determinant can
be made to acquire an arbitrary additive term unless the source and target
metrics, the Jacobian, and the integral lattices are fixed before the product
formula is applied.

This is the arithmetic-line-bundle analogue of the Haar-Jacobian obstruction
already recorded for normed Rosetta comparisons.

## 5. Route decision

This theorem excludes the **metric-free** parabolic/Hodge shortcut.  It does
not exclude the route with the canonical Hodge/Petersson metric.  That route
survives and is sharpened to the following tasks:

1. use the canonical period metric, whose basic Legendre growth is
   `O(log log c)`;
2. identify the finite boundary/Tate normalization in the same metric;
3. control the level-prime and model-change Jacobians;
4. prove the remaining arithmetic maximal-slope inequality.

The branch is retained until the canonically normalized theorem is proved or a
counterexample disproves its stated bound.
