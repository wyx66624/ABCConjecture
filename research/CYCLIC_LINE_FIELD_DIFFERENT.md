# Normalized different of a cyclic `ell`-line field

Let `E/Q` be semistable, let `ell>=5`, and assume the mod-`ell` image acts
transitively on `P(E[ell])`. For a cyclic subgroup `C` of order `ell`, let
`L_C` be its field of definition. Then `[L_C:Q]=ell+1`.

## Theorem 1 (tame primes)

For `p != ell`, good reduction gives no ramification in `L_C`. At a
multiplicative prime, inertia on `E[ell]` is trivial or a transvection. A
nontrivial transvection has one fixed point and one orbit of length `ell` on
`P^1(F_ell)`. The tame discriminant exponent of the associated permutation
extension is therefore

\[
  (\ell+1)-2=\ell-1.
\]

Hence

\[
  v_p(D_{L_C})\leq \ell-1
\]

for every `p|N_E`, and it is zero for `p not dividing ell N_E`.

## Theorem 2 (the level prime)

For a finite extension of `Q_ell` with ramification index `e`, the local
different exponent satisfies

\[
  d\leq e-1+e v_\ell(e).
\]

After summing over all completions of the degree `ell+1` field `L_C`, this
gives

\[
  \frac{v_\ell(D_{L_C})}{\ell+1}\leq2.
\]

## Corollary 3 (global normalized different)

\[
  \frac{1}{\ell+1}\log|D_{L_C}|
  \leq
  \frac{\ell-1}{\ell+1}\log N_E+2\log\ell.
\]

For a curve made semistable over one fixed extension, only an additional fixed
constant is introduced.

Thus the cyclic-line field has the conductor-plus-log-level discriminant cost
required by the classical three-line determinant route. The remaining
source-facing problem is the asymptotically sharp archimedean evaluation
determinant, plus finite-place unitness outside the conductor, level prime, and
different.
