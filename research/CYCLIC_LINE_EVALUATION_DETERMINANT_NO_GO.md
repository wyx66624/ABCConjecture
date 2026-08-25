# The cyclic-line evaluation determinant is singular

## 1. Set-up

Let `E/k` be an elliptic curve with origin `O`, and let `C subset E(kbar)` be
a cyclic subgroup of odd prime order `ell`.  Put

\[
  D_C=\sum_{P\in C\setminus\{O\}}(P).
\]

The divisor `D_C` has degree `ell-1`.  Consider the evaluation map

\[
  \operatorname{ev}_C:
  H^0\!\left(E,\mathcal O_E((\ell-1)O)\right)
  \longrightarrow
  \bigoplus_{P\in C\setminus\{O\}}
    \mathcal O_E((\ell-1)O)|_P.
\]

Both vector spaces have dimension `ell-1`.

## 2. Divisor relation

### Theorem 2.1

\[
  D_C\sim (\ell-1)O.
\]

### Proof

For a degree-zero divisor on an elliptic curve, its class in
`Pic^0(E) ≅ E` is the group-law sum of its points.  The class of

\[
  D_C-(\ell-1)O
\]

is therefore

\[
  \sum_{P\in C\setminus\{O\}}P.
\]

The sum of all elements of a finite cyclic group of odd order is zero: pairing
`P` with `-P` exhausts the nonzero elements.  Hence the displayed divisor has
trivial class in `Pic^0(E)` and is principal.

Equivalently, there exists a nonzero rational function `f_C` with

\[
  \operatorname{div}(f_C)=D_C-(\ell-1)O.
\]

## 3. Evaluation-map no-go theorem

### Theorem 3.1

The map `ev_C` is not injective.  In particular, every square matrix obtained
by choosing bases for this evaluation map has determinant zero.

### Proof

The function `f_C` of Theorem 2.1 is a nonzero section of

\[
  \mathcal O_E((\ell-1)O).
\]

Its zero divisor is exactly `D_C`, so it vanishes at every point of
`C\setminus\{O\}`.  Thus

\[
  f_C\in\ker(\operatorname{ev}_C),
  \qquad f_C\ne0.
\]

Therefore the evaluation map is singular.

## 4. Consequence for the proposed three-line determinant route

A determinant formed by evaluating the complete space

\[
  H^0(E,\mathcal O_E((\ell-1)O))
\]

at all nonzero points of one cyclic `ell`-subgroup is identically zero, before
any local metric or product formula is introduced.  It cannot serve as a
nonzero global arithmetic element whose local norms encode the Tate parameter.

This eliminates the naive cyclic-line evaluation-determinant formulation by a
concrete geometric kernel, not by lack of technique.

## 5. Surviving corrections

The following modified constructions are not excluded by Theorem 3.1.

1. **Quotient determinant.**  Divide the source by the canonical one-dimensional
   kernel `k f_C`, and compare the quotient with a codimension-one target.
2. **Jet-augmented evaluation.**  Add one derivative or tangent evaluation at
   the origin or at one point of `C` so that the principal section no longer
   lies in the kernel.
3. **Degree-ell line bundle.**  Use `O_E(ell O)` and an `ell`-point evaluation
   scheme, while recording the resulting extra Hodge and local terms.
4. **Deligne pairing or determinant of cohomology.**  Replace point evaluation
   by a canonical determinant line whose nonvanishing is built into an exact
   sequence.
5. **Globally labelled parabolic Hodge line.**  Work on the Legendre base with
   its three cusps rather than on one fixed cyclic subgroup after
   specialization.

Every corrected construction must recompute its exact local Tate slope,
archimedean metric, integral Jacobian, and field-of-definition cost.  None may
reuse the singular determinant's claimed coefficient without proof.

## 6. Route policy

The original cyclic-line evaluation-determinant subroute is now ruled out and
may be removed after this no-go theorem is preserved on `main`.  The broader
locally adaptive torsion-energy and globally labelled parabolic-Higgs routes
remain active because they do not require `ev_C` itself to be invertible.
