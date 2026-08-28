# Actual distinguished-procession product-region theorem

**Author:** ChatGPT  
**Status:** mathematical proof implemented in Lean; kernel status is determined by branch CI.

## 1. Statement

Let `D` be actual initial theta data, let `Q` be its q-pilot data, and put

\[
n=\frac{\ell-1}{2}.
\]

For each distinguished standard-procession index `0 <= m < n` and each actual
bad place `w`, the preceding source-faithful construction supplies the genuine
finite-positive local region

\[
U_{m,w}=q_w^{(m+1)^2}\mathcal O_w.
\]

The one-label product theorem constructs

\[
U_m=\prod_{w\in S_Q}U_{m,w}
\]

with the product of the normalized local additive Haar measures. This branch
constructs the second finite product

\[
U_{\mathrm{proc}}
 =\prod_{0\le m<n}U_m
 =\prod_{0\le m<n}\prod_{w\in S_Q}
   q_w^{(m+1)^2}\mathcal O_w.
\]

It is a genuine finite-positive region for the corresponding two-level product
measure. The proved identities are

\[
\log\mu(U_{\mathrm{proc}})
 =\sum_{m=0}^{n-1}\log\mu(U_m)
 =\operatorname{processionLogSum}(Q),
\]

and

\[
\log\mu(U_{\mathrm{proc}})
 =n\,\operatorname{squareAverage}(D)
   \sum_{w\in S_Q}\log\chi_w(q_w).
\]

After dividing by the procession length and by `[F:Q]`, and changing sign,

\[
-\frac{1}{[F:\mathbf Q]}
 \frac{1}{n}\log\mu(U_{\mathrm{proc}})
 =\operatorname{squareAverage}(D)\,
   \operatorname{arithmeticLogQ}(Q).
\]

For the canonically residue-degree-reweighted q-pilot, the right side is
unconditionally the same square average times the public `logQ` scalar.

## 2. Proof

Each inner packet region is already a `FinitePositiveRegion` for a finite
product of normalized sigma-finite Haar measures. Since the standard
procession index is the finite type `Fin n`, the family of packet measures is
again sigma-finite. The finite product-region constructor therefore produces
`U_proc`.

The general theorem `FinitePositiveRegion.logVolume_pi` gives additivity of
logarithmic volume across the outer finite product. The identity
`Fin.sum_univ_eq_sum_range` identifies the outer `Fin n` sum with the existing
`Finset.range n` definition of `processionLogSum`. The remaining equalities are
substitutions of the previously proved procession-average, packet-Haar and
arithmetic-divisor identities. No numerical component value is inserted as a
field of the new region.

## 3. What this closes

Before this branch, the repository had:

1. genuine local Tate regions at every actual bad place;
2. one genuine bad-place product rectangle for every distinguished label;
3. a scalar sum over the complete distinguished standard procession.

This theorem geometrically realizes item 3 as the log-volume of one actual
finite-positive two-level product region. Thus the complete distinguished-label
slice of the standard procession is no longer represented only by a scalar
summation.

## 4. Boundary

The construction is the product over the distinguished new label of every
standard capsule. It is **not** the product over every label in every capsule.
It does not construct cross-label arithmetic-holomorphic-structure or untilt
identifications, prove soundness and completeness for the complete IUT III
possible-image union, construct its mono-analytic hull, or supply the
different/conductor/archimedean inequality of IUT IV Theorem 1.10.

No `ABCConjecture`, Corollary 3.12 inequality, component-volume formula,
procession identity, or target-equivalent existence statement is assumed by
this construction.
