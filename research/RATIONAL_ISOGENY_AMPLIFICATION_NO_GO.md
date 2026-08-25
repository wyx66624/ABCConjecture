# Rational cyclic isogenies cannot supply polynomial exceptional-set amplification

## 1. Set-up

The exceptional-set amplification criterion requires, for a triple of height in
`[X,2X]`, at least `X^beta` distinct exceptional outputs for some `beta>0`,
unless another part of the incidence argument supplies an equivalent growing
multiplicity.

A natural proposal is to attach the Frey elliptic curve `E/Q` and use its
rational cyclic isogenies to create many new curves, then convert those curves
back to abc triples.

## 2. Uniform boundedness of rational cyclic subgroups

The Mazur--Kenku classification gives a finite set `N_iso` of integers that can
occur as degrees of rational cyclic isogenies of elliptic curves over `Q`.
For a fixed degree `N`, a cyclic subgroup of order `N` is a point of the finite
set of cyclic subgroups of `E[N]`; its cardinality is at most

\[
  \psi(N)=N\prod_{p\mid N}\left(1+\frac1p\right).
\]

Hence the absolute constant

\[
  M_{\rm iso}=\sum_{N\in N_{\rm iso}}\psi(N)
\]

bounds the number of rational cyclic subgroup schemes of every elliptic curve
over `Q`.

### Theorem 2.1

Let `A_iso(E)` be any set containing at most one output for each rational cyclic
subgroup of `E/Q`. Then

\[
  |A_{\rm iso}(E)|\le M_{\rm iso},
\]

where the right side is independent of `E` and of its height.

## 3. Failure of the amplification inequality

Suppose one uses only such rational isogeny outputs in the abstract
amplification theorem. Then for every `beta>0` and all sufficiently large `X`,

\[
  |A_{\rm iso}(E)|<X^\beta.
\]

Thus the amplification exponent is necessarily

\[
  \beta=0.
\]

The required strict inequality

\[
  \beta>\gamma+\kappa\alpha
\]

cannot hold when `alpha,gamma,kappa` are nonnegative and the known exceptional
set exponent satisfies `alpha>0`.

### Corollary 3.1

A construction using only rational cyclic isogenies of the Frey curve, with a
bounded number of abc outputs per rational subgroup, cannot upgrade a
power-saving exceptional-set estimate to finiteness.

The same conclusion applies to rational torsion/level structures of bounded
degree over `Q`: uniform boundedness supplies only `O(1)` rational structures
per input curve.

## 4. Surviving isogeny variants

This no-go theorem does not eliminate:

1. isogenies defined over number fields whose degree grows with the input;
2. full Galois orbits of cyclic subgroups combined with a controlled norm or
   descent operation;
3. iterated isogeny graphs, provided one proves that many vertices descend to
   distinct rational abc triples with controlled radical;
4. isogeny data used as an auxiliary certificate rather than as the source of
   the amplification multiplicity.

Any surviving variant must pay for field degree, different, overlap, and the
new prime support introduced by descent.  Merely citing the large number of
geometric `ell`-subgroups over an algebraic closure is not enough.
