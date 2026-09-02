# Actual Haar admissibility and the uniformizer preimage orbit

**Author:** ChatGPT  
**Date:** 2 September 2026  
**Status:** unconditional local theorems; the tensor/place normalization,
same-pilot comparison, IUT, and the abc conjecture remain open

## 1. Scope and source boundary

This note replaces an abstract scaling model by an actual normalized additive
Haar measure on a nonarchimedean local field.  It addresses the admissibility
seam isolated in
`ABC_IUT_ADMISSIBLE_SCALING_ORDER_INDEX_2026_09_02.md`: a nonzero translation
law cannot hold on every subset, but it should hold on the genuine domain on
which logarithmic Haar volume is finite.

The source convention is Mochizuki, *Inter-universal Teichmüller Theory III*,
Proposition 3.9(i), pp. 115--116, and Remark 3.9.5(i), p. 127.  Proposition
3.9(i) takes the nonarchimedean log-volume domain to be nonempty compact-open
subsets, normalizes the integral structure to log-volume zero, and normalizes
multiplication by the local rational prime to subtract its logarithm.  Remark
3.9.5 constructs the least scaled-integral hull of a relatively compact
region.  The local source PDF used here is
`research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf`.

The present result is local.  It does not identify the repository's concrete
candidate Ind1/Ind2/Ind3 images with every IUT possible image, construct the
multiradial algorithm, prove the horizontal same-pilot comparison, or prove
IUT III Corollary 3.12.  It also does not prove abc.

## 2. Honest finite-positive regions

Let `K` be a nontrivially normed field with proper metric, let `mu` be a
regular additive Haar measure, and let `a` be a nonzero element of `K`.
(The nonarchimedean local fields used below have this properness property.)
Define

\[
  m_a:K\longrightarrow K,\qquad m_a(x)=ax.
\]

Write `Delta(a)` for the distributive Haar character, characterized by

\[
  \mu(aU)=\Delta(a)\mu(U).                              \tag{2.1}
\]

The honest real log-volume domain is

\[
 \mathcal F_\mu=
 \{U\subseteq K:U\text{ is measurable and }0<\mu(U)<\infty\}, \tag{2.2}
\]

and its canonical log-volume is

\[
 L_\mu(U)=\log \mu(U).                                  \tag{2.3}
\]

Here and below an extended nonnegative Haar measure is converted to a real
number only after both finiteness and positivity have been proved.

### Theorem 2.1 (exact scalar-preimage identity)

For every subset `U` of `K`,

\[
 m_a^{-1}(U)=a^{-1}U.                                   \tag{2.4}
\]

#### Proof

If `x` is in the left side, put `y=ax`.  Then `y` is in `U` and
`x=a^{-1}y`, so `x` is in the right side.  Conversely, if
`x=a^{-1}y` with `y` in `U`, then `ax=y` is in `U`.  This proves equality of
the carriers.  ∎

### Theorem 2.2 (preimage closure and genuine change of variables)

If `U` belongs to `F_mu`, then `m_a^{-1}(U)` also belongs to `F_mu`, and

\[
 \mu(m_a^{-1}U)=\Delta(a^{-1})\mu(U),                    \tag{2.5}
\]

\[
 L_\mu(m_a^{-1}U)
 =L_\mu(U)+\log\Delta(a^{-1}).                           \tag{2.6}
\]

#### Proof

Multiplication by `a` is a homeomorphism, hence its inverse image preserves
measurability.  By Theorem 2.1 and (2.1),

\[
 \mu(m_a^{-1}U)=\mu(a^{-1}U)=\Delta(a^{-1})\mu(U).
\]

The Haar character is a strictly positive finite real number.  Multiplying a
finite positive number by it again gives a finite positive number, proving
closure of (2.2).  Taking real logarithms and using the logarithm product law
gives (2.6).  ∎

This theorem is stronger than merely exhibiting one compatible family: every
finite-positive measurable region has a finite-positive scalar preimage.  It
does not say that every such region has compact closure, so the exact
compact-open source domain remains a proper subdomain.

### Corollary 2.3 (the exact compact-open domain is preimage-stable)

Let

\[
 \mathcal M_\mu=\{U\in\mathcal F_\mu:
 U\text{ is compact and open}\}.
\]

Then `m_a^{-1}` maps `M_mu` to itself and obeys (2.5)--(2.6) there.

#### Proof

The map `m_a` is a homeomorphism.  Its inverse image preserves openness, and
its inverse image of `U` is the continuous image `a^{-1}U`, so it preserves
compactness.  The remaining fields and the volume identities are exactly
Theorem 2.2.  ∎

Thus the local domain denoted `M(-)` in IUT III, Proposition 3.9(i), has now
been constructed and proved stable under scalar preimages.  The larger
finite-positive domain is retained because its monotonicity gives a useful
envelope obstruction in Section 5.

## 3. Residue normalization

Now suppose that `K` is nonarchimedean, its valuation-integer ring `O_K` is a
discrete valuation ring, and its residue field `k` is finite.  Put

\[
 q=|k|.
\]

Normalize the additive Haar measure by

\[
 \mu(O_K)=1.                                             \tag{3.1}
\]

Let `pi` be a uniformizer.  The repository has already proved the finite-coset
normalization

\[
 \Delta(\pi)=q^{-1}.                                     \tag{3.2}
\]

For completeness, the mathematical argument is recalled next.

### Theorem 3.1 (uniformizer Haar character)

Under (3.1), equation (3.2) holds.

#### Proof

The maximal ideal is `pi O_K`, and the additive quotient
`O_K/pi O_K` is the residue field, with exactly `q` cosets.  Translation
invariance gives the same measure to every coset of `pi O_K`.  These cosets
partition `O_K`, hence

\[
 q\mu(\pi O_K)=\mu(O_K)=1.
\]

Thus `mu(pi O_K)=q^{-1}`.  Applying (2.1) to `O_K` and using (3.1) gives
`Delta(pi)=q^{-1}`.  ∎

### Corollary 3.2 (source-oriented preimage shift)

For every `U` in `F_mu`,

\[
 L_\mu(m_\pi^{-1}U)=L_\mu(U)+\log q.                    \tag{3.3}
\]

#### Proof

Since the Haar character is a group homomorphism,
`Delta(pi^{-1})=Delta(pi)^{-1}=q`.  Substitute this identity into (2.6).  ∎

Thus the corrected admissible preimage law is now derived from an actual
measure.  It is no longer a field of an input structure.

## 4. The compact-open uniformizer orbit

For every natural number `n`, define

\[
 B_n=\pi^{-n}O_K.                                        \tag{4.1}
\]

### Theorem 4.1 (honest admissibility of every orbit point)

Every `B_n` is nonempty, compact, open, measurable, and has finite positive
Haar measure.

#### Proof

The unit ball `O_K` is a closed ball of positive radius.  In an ultrametric
space such a ball is also open; properness makes it compact.  Multiplication
by the nonzero scalar `pi^{-n}` is a homeomorphism, so it preserves
nonemptiness, compactness, and openness.  A compact set has finite Haar
measure, and a nonempty open set has positive Haar measure.  ∎

### Theorem 4.2 (exact orbit recurrence and volume)

For every natural number `n`,

\[
 m_\pi^{-1}(B_n)=B_{n+1},                                \tag{4.2}
\]

\[
 L_\mu(B_n)=n\log q.                                     \tag{4.3}
\]

#### Proof

Equation (4.2) follows from Theorem 2.1:

\[
 m_\pi^{-1}(\pi^{-n}O_K)
 =\pi^{-1}\pi^{-n}O_K=\pi^{-(n+1)}O_K.
\]

The base region `B_0=O_K` has log-volume zero by (3.1).  Inductively, (3.3)
adds `log q` at every preimage step.  This gives (4.3).  ∎

### Corollary 4.3 (injectivity and absence of periodicity)

The map `n -> B_n` is injective.  In particular, the actual admissible
preimage orbit is infinite and has no cycle.

#### Proof

A finite residue field is nontrivial, so `q>1` and `log q>0`.  If
`B_m=B_n`, applying (4.3) gives `m log q=n log q`; cancellation gives `m=n`.
∎

## 5. A new envelope obstruction

The preceding orbit gives an exact restriction on any proposed compact
admissible implementation.

### Theorem 5.1 (no finite-positive common envelope)

There is no `V` in `F_mu` such that

\[
 B_n\subseteq V\qquad\text{for every }n\ge 0.             \tag{5.1}
\]

#### Proof

If (5.1) held, monotonicity of measure and logarithm would give

\[
 n\log q=L_\mu(B_n)\le L_\mu(V)
\]

for every `n`.  Since `log q>0`, the Archimedean property supplies an `n`
with `n log q>L_mu(V)`, a contradiction.  ∎

### Corollary 5.2 (bounded-orbit interface is impossible)

An admissible class that contains `O_K`, is closed under uniformizer
preimages, and satisfies the genuine Haar shift cannot require the entire
preimage orbit to lie in one finite-positive hull.  In particular, it cannot
be a finite or periodic family.

This eliminates only that precise bounded-orbit design.  It does not eliminate
the Haar/IUT route.  It also does not contradict the compact-indeterminacy
statement in Remark 3.9.5: that statement fixes a region `P` and bounds its
hull approximants inside the hull of that fixed `P`; Theorem 5.1 varies the
region by repeated prime preimage.

## 6. Finite packets and the rational-prime coefficient

Let `I` be finite.  For each `i` in `I`, let `K_i` be a local field with
uniformizer `pi_i`, residue cardinality `q_i`, normalized Haar measure `mu_i`,
and finite-positive region `U_i`.  On the rectangular region

\[
 U=\prod_{i\in I}U_i
\]

use the product measure.  Its logarithmic volume is

\[
 L(U)=\sum_{i\in I}L_i(U_i).                             \tag{6.1}
\]

### Theorem 6.1 (simultaneous uniformizer-preimage shift)

Taking a uniformizer preimage in every coordinate gives

\[
 L\left(\prod_i m_{\pi_i}^{-1}U_i\right)
 =L(U)+\sum_i\log q_i.                                  \tag{6.2}
\]

#### Proof

Apply Corollary 3.2 in each coordinate and then use (6.1).  ∎

This is the raw Haar formula.  The public LANA field, however, takes preimage
under the **rational prime** `p`, not under one local uniformizer.  At a place
with ramification index `e` and residue degree `f`, write

\[
 p=u\pi^e,\qquad |u|=1,\qquad q=p^f.                     \tag{6.3}
\]

### Theorem 6.2 (raw rational-prime shift)

Under (6.3), inverse image under multiplication by `p` changes raw Haar
log-volume by

\[
 e\log q=ef\log p.                                      \tag{6.4}
\]

#### Proof

The norm-one factor `u` has Haar character one.  The character is
multiplicative, while Theorem 3.1 gives `Delta(pi)=q^{-1}`.  Hence

\[
 \Delta(p)=\Delta(u)\Delta(\pi)^e=q^{-e},
 \qquad \Delta(p^{-1})=q^e.
\]

Theorem 2.2 gives the shift `log(q^e)=e log q`.  Finally
`q=p^f` gives (6.4).  ∎

### Theorem 6.3 (component normalization)

Assume `e,f>0` and define the packet-normalized component volume by

\[
 L^{\mathrm{pkt}}(U)=\frac{L(U)}{ef}.                    \tag{6.5}
\]

Then rational-prime preimage satisfies exactly

\[
 L^{\mathrm{pkt}}(p^{-1}U)
 =L^{\mathrm{pkt}}(U)+\log p.                            \tag{6.6}
\]

#### Proof

Divide the identity of Theorem 6.2 by `ef`; positivity makes the denominator
nonzero.  ∎

### Theorem 6.4 (packet weight normalization)

For component-normalized volumes (6.5), let

\[
 L_w^{\mathrm{pkt}}(U)=\sum_iw_iL_i^{\mathrm{pkt}}(U_i).
\]

If `sum_i w_i=1`, simultaneous rational-prime preimage changes this weighted
volume by exactly `log p`.

#### Proof

By Theorem 6.3 every summand changes by `log p`.  Therefore the total change
is `(sum_i w_i) log p=log p`.  ∎

This is the source-compatible two-stage normalization: local Haar volume is
first divided by the local degree `e_i f_i`, and the already normalized place
weights are then summed.

### Proposition 6.5 (raw Haar plus ordinary weight normalization is insufficient)

If the division in (6.5) is omitted, the condition `sum_i w_i=1` alone does
not imply a `log p` shift.

#### Proof and full-premise counterexample

Take a one-element index set, weight `w=1`, and an unramified degree-two
numeric local datum `e=1`, `f=2`, `q=p^2`, where `p>1`.  The weights sum to
one, but the raw shift is

\[
 \log(p^2)=2\log p\ne\log p.
\]

All numerical normalization premises are satisfied.  Thus the exact claim
that ordinary weight-sum normalization alone converts **raw** Haar volume to
the public coefficient is false.  This does not refute the intended
component-normalized construction of Theorems 6.3--6.4.  Only the weaker
exact claim is retired.

## 7. Counterexample pressure and route policy

The full-premise tests now separate three claims.

1. A nonzero preimage shift on **all subsets** is false: the empty set is a
   fixed point.  This exact total-domain interface was already retired.
2. A nonzero preimage shift on merely **all nonempty subsets** is false: the
   whole space is a fixed point.  This exact repair was already retired.
3. The finite-positive Haar domain is consistent and is closed under all
   nonzero scalar preimages by Theorem 2.2.  The compact-open scaled-ball
   subfamily supplies the actual infinite orbit of Section 4.

No difficulty or missing global theorem is treated as a reason to abandon the
route.  Only the two fully quantified false interfaces above, and the bounded
common-envelope subclaim of Theorem 5.1, are removed.  The corrected actual
Haar route remains active.

## 8. Exact effect on the LANA/IUT seam

The new theorem discharges the following local ingredients of the patched
interface from constructions:

* canonical real log-volume on finite-positive regions;
* nonemptiness and finite positivity;
* closure under prime/uniformizer preimage;
* the exact additive logarithmic shift;
* closure of the exact nonarchimedean compact-open source domain;
* compactness and openness for every scaled integral ball;
* an infinite, injective test orbit;
* the impossibility of a uniformly bounded preimage orbit.

It does not yet construct the complete patched `Iut.LocalTheory`.  Four seams
remain.

1. **Tensor/place normalization.**  Theorems 6.2--6.4 derive the exact
   two-stage coefficient from a factorization `p=u*pi^e`, the identity
   `q=p^f`, division by the local degree `ef`, and the existing
   `weight_sum_one`.  What remains is to construct these factorizations and
   degree identities uniformly for every actual `LocalTheory.Tensor`
   component and connect its `componentVol` to the normalized Haar formula.
2. **Tensor admissible class.**  The exact one-field compact-open domain is
   stable under preimage by Corollary 2.3.  A full direct-sum/tensor component
   class must transport that construction, retain relative compactness, and
   invoke the product least-hull theorem.
3. **Global source realization.**  Log-shells, the concrete Ind1/Ind2/Ind3
   action, theta unions, and their admissibility still have to be connected to
   the actual local class.
4. **Same-pilot comparison.**  None of the local change-of-variables results
   supplies the horizontal multiradial comparison or Corollary 3.12.

For `Q_p`, Mathlib's residue-field equivalence gives the independent exact
identity

\[
 |k_{\mathbb Q_p}|=|\mathbb Z/p\mathbb Z|=p.              \tag{8.1}
\]

This identity is formalized as well.  The remaining tensor/place coefficient
is therefore structural rather than a numerical ambiguity about the residue
field.

## 9. Formalization map

The corresponding Lean module is
`Lean/IUTThreeClosures/IUTActualHaarAdmissibleOrbit20260902.lean`.  Its main
objects and theorems are:

* `mulPreimageRegion`;
* `mulPreimageRegion_measure`;
* `mulPreimageRegion_logVolume`;
* `unitMulPreimageScalingLaw`;
* `HaarCompactOpenRegion.mulPreimage`;
* `HaarCompactOpenRegion.mulPreimage_logVolume`;
* `unitScaledHaarCompactOpenRegion`;
* `HaarCompactOpenRegion.mulPreimage_unitScaled`;
* `uniformizerPreimageScalingLaw`;
* `uniformizerExpandedBall_succ`;
* `uniformizerExpandedBall_logVolume`;
* `uniformizerExpandedBall_injective`;
* `unitScaledFinitePositiveRegion_closure_compact`;
* `unitScaledFinitePositiveRegion_isOpen`;
* `uniformizerExpandedBall_no_finitePositive_envelope`;
* `product_uniformizerPreimage_logVolume`;
* `weighted_uniformizerPreimage_logVolume`;
* `weighted_residueDegree_shift_eq_log_prime`;
* `distribHaarChar_primeScalar`;
* `primeScalarPreimage_normalizedLogVolume`;
* `weighted_normalized_primeScalarPreimage`;
* `weight_sum_one_not_sufficient`;
* `padic_residueCard`.

Every mathematical proposition above precedes its committed Lean
formalization.  The module uses no `sorry`, `admit`, `native_decide`, or custom
axiom.
