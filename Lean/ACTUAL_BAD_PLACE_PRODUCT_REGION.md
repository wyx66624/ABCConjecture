# Actual finite bad-place product-region theorem

**Author:** ChatGPT  
**Status:** mathematical proof implemented in Lean; kernel status determined by the branch CI.

## 1. Statement

Let `D` be actual initial theta data, let `Q` be its q-pilot data, and write

\[
S_Q=\{w: w\in Q.\mathrm{badFinset}\}.
\]

For every `w in S_Q`, let `K_w` be the actual completed local field, let
`q_w` be the source Tate parameter, and let `mu_w` be additive Haar measure
normalized by

\[
\mu_w(\mathcal O_w)=1.
\]

For a distinguished procession index `m >= 0`, put

\[
U_{m,w}=q_w^{(m+1)^2}\mathcal O_w.
\]

Every `U_{m,w}` is a measurable compact set of finite nonzero Haar measure.
Hence the dependent rectangle

\[
U_m=\prod_{w\in S_Q}U_{m,w}
\]

is a genuine finite-positive region for the product measure

\[
\mu_Q=\bigotimes_{w\in S_Q}\mu_w.
\]

The theorem proved in
`IUTThreeClosures/ActualBadPlaceProductRegion.lean` is

\[
\log \mu_Q(U_m)
 =\sum_{w\in S_Q}\log\mu_w(U_{m,w})
 =L_{\mathrm{packet}}(Q,m).
\]

Using the already proved local Tate/Haar normalization gives

\[
\log \mu_Q(U_m)
 =(m+1)^2\sum_{w\in S_Q}\log\chi_w(q_w),
\]

and therefore

\[
-\frac{\log\mu_Q(U_m)}{[F:\mathbf Q]}
 =(m+1)^2\,\operatorname{arithmeticLogQ}(Q).
\]

Under the separately documented public weight-degree compatibility condition,
the right side is also `(m+1)^2 * Q.logQ`.

## 2. Proof

For each coordinate, the source-faithful local module constructs
`U_{m,w}` as a `FinitePositiveRegion`. The local calculation proves

\[
\log\mu_w(U_{m,w})
 =\operatorname{componentLog}(Q,m,w).
\]

The finite product-measure theorem for rectangular regions proves

\[
\log\mu_Q\!\left(\prod_w U_{m,w}\right)
 =\sum_w\log\mu_w(U_{m,w}).
\]

The finite type used by the product is the subtype of places belonging to
`Q.badFinset`; its `Finset.univ` is exactly `Q.badFinset.attach`. Thus the sum
on the right is definitionally the same finite packet enumeration used by
`distinguishedLabelPacketLog`. Substitution proves the first identity. The
remaining identities follow from the previously proved packet-sum and
arithmetic-divisor-degree theorems.

## 3. What this closes

Previously, every local component was a genuine finite-positive Haar region,
but the global bad-place packet was represented only by a finite sum of local
logarithms. This theorem constructs the actual dependent product rectangle and
proves that its canonical product-measure logarithmic volume equals that
scalar. It therefore closes the finite-product geometric realization for one
complete distinguished-label slice of the standard procession.

## 4. What remains open

This result does **not** establish the complete IUT III possible-image union or
its mono-analytic hull. It also does not construct the full product over all
labels in every capsule, the cross-label multiradial/AHS comparison, the
archimedean and different/conductor estimates of IUT IV Theorem 1.10, or an
unparameterized proof of `ABCConjecture`.

No field of the construction assumes a component formula, packet identity,
abc inequality, or target-equivalent existence statement.
