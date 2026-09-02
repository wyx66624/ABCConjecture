# Admissible scaling and an exact integral-order index in the IUT route

**Author:** ChatGPT
**Date:** 2 September 2026
**Status:** proved local results; the corrected same-pilot theorem, IUT, and the
abc conjecture remain open

## 1. Scope and source basis

This note advances two adjoining seams in the IUT/LANA route.

1. It audits the log-volume interface at the current Project LANA `iut`
   commit `c65b28c9f9631635e742294c3a5df15759e7c74c`.  The interface still states a
   prime-preimage translation law for every set, although its own prose says
   that normalization laws concern the finite, nonzero-volume regime.
2. It proves an exact finite-index formula for the elementary congruence
   order that models the failure of an integral tensor order to equal the
   product of maximal orders after a semisimple decomposition.

The mathematical references are Mochizuki, *Inter-universal Teichmüller
Theory III*, Proposition 3.9 and Remark 3.9.5, for normalized log-volume and
admissible hulls, and the current LANA files
`Iut/Cor312/LogVolume.lean`, `Iut/Concrete/LocalTheory.lean`, and
`Iut/Concrete/Container.lean`.  The local copy of IUT III used in this audit
is recorded in `research/sources/uniform_gate_2026_08_30/`.

### 1.1 The new upstream existence theorem

The current commit adds `Iut/Concrete/Existence.lean`, a substantial positive
advance that was absent from the 1 September snapshot.  It constructs initial
theta data from an elliptic curve, its arithmetic and Tate data, a mod-`ell`
representation, and the explicit anabelian existence input.  In particular,
the theorem `CurveInputs.concreteThetaDataExistence` now proves the older
`ConcreteThetaDataExistence` interface from

* `AnabelianExistence`;
* a provider `LTp` of `LocalTheory` for every constructed theta datum;
* providers of `ThetaLocalData` and `TowerArithmetic`.

The new endpoint `cor312Variant_implies_abc_curves` still quantifies over all
of those providers, a `Genl.HeightTheory.ProofPackage`, the analytic prime
bounds, and the concrete Corollary 3.12 comparison `h312`.  Thus it genuinely
removes one assembly gap, but it is a conditional implication rather than an
unconditional proof of `T.StatementI` or integer abc.  Moreover, the current
unrestricted `LocalTheory.componentVol_prime_preimage` makes the literal
provider `LTp` impossible before the quantifier repair below.  The source
ledger freezes both this positive theorem and its exact remaining premises.

No result below constructs the multiradial algorithm, proves the horizontal
same-pilot comparison, proves IUT III Corollary 3.12, or proves abc.  The exact
counterexamples retire only the explicitly quantified interfaces that they
falsify.

## 2. Why a total real-valued scaling law is impossible

Let `X` be a type, let `s : X -> X`, let `V : Set X -> R`, and let
`delta : R`.  Consider the assertion

\[
 V(s^{-1}U)=V(U)+\delta \qquad\text{for every }U\subseteq X.       \tag{2.1}
\]

### Theorem 2.1 (empty-set obstruction)

If (2.1) holds, then `delta = 0`.

#### Proof

The inverse image of the empty set is empty.  Substituting
`U = emptyset` into (2.1) gives

\[
 V(\varnothing)=V(\varnothing)+\delta.
\]

Cancellation in the additive group of real numbers gives `delta = 0`.
∎

For the LANA field, `delta = log p` with `p` prime.  Since `p >= 2`,
`log p > 0`; therefore the current all-set field is inconsistent.

### Theorem 2.2 (nonempty is not a sufficient repair)

Assume `X` is nonempty.  If (2.1) is required merely for every nonempty set,
then again `delta = 0`.

#### Proof

The whole space `X` is nonempty, and `s^{-1}(X)=X`.  Substitution gives
`V(X)=V(X)+delta`, hence `delta=0`. ∎

Thus adding only a hypothesis `U.Nonempty` would move the contradiction from
the empty set to the whole set.  The scaling law must be restricted to an
admissible finite, nonzero-volume class that excludes both pathologies.

### Proposition 2.3 (fixed-region obstruction)

Let `A` be any class of sets on which (2.1) is required.  If an admissible
`U in A` satisfies `s^{-1}U=U`, then `delta=0`.

#### Proof

Apply the admissible scaling law to `U` and replace `s^{-1}U` by `U`.
Cancellation gives the result. ∎

This proposition is a design test rather than a rejection of the scaling
route.  In a genuine nonarchimedean field, multiplication by a nonunit moves
finite nonzero Haar regions through an infinite chain of distinct valuation
balls, so the intended regions do not violate the test.

## 3. A corrected admissible interface

A logically adequate local interface has the following data.

* `componentVol` is total, so callers may still mention arbitrary sets.
* `componentAdmissible U` says that `U` is in the finite,
  nonzero-volume regime.
* admissible regions are nonempty.
* a prime preimage of an admissible region is admissible.
* the translation law is asserted only from a proof that `U` is admissible.

In symbols,

\[
\begin{aligned}
 U\in\mathcal A &\Longrightarrow U\ne\varnothing,\\
 U\in\mathcal A &\Longrightarrow p^{-1}U\in\mathcal A,\\
 U\in\mathcal A &\Longrightarrow
 V(p^{-1}U)=V(U)+\log p.                                  \tag{3.1}
\end{aligned}
\]

The first line blocks the empty-set substitution.  Admissibility must also
exclude any fixed region when `log p != 0`, by Proposition 2.3.  Relative
compactness and finite nonzero Haar measure are the intended analytic
conditions; simply declaring a set nonempty is insufficient.

The source patch accompanying this note makes precisely this quantifier
change in `LocalTheory`, transports the admissible predicate and closure law
to `LogVolumeData`, and supplies them in `Concrete.Container.vol`.  It does
not postulate a numerical equality on junk regions.

### Proposition 3.1 (iteration on its exact domain)

Suppose (3.1) holds and admissibility is closed under prime preimage.  For
every admissible `U` and every natural number `r`,

\[
 V(p^{-r}U)=V(U)+r\log p.                                  \tag{3.2}
\]

#### Proof

Induct on `r`.  At `r=0`, both sides are `V(U)`.  For the induction step,
closure makes `p^{-r}U` admissible.  Apply (3.1) to it and then the induction
hypothesis:

\[
 V(p^{-(r+1)}U)
 =V(p^{-r}U)+\log p
 =V(U)+(r+1)\log p.
\]

∎

### Corollary 3.2 (no periodic admissible orbit)

If `log p != 0`, the admissible preimage orbit of any admissible region is
injective.  In particular, it is not periodic.

#### Proof

If the `r`-th and `s`-th regions were equal, (3.2) would give
`r log p = s log p`.  Since `log p != 0`, cancellation gives `r=s`. ∎

This positive orbit behavior was previously proved for the repository's
abstract admissible-region model and for valuation balls in `Q_p`.  The new
point here is that the same admissibility boundary is inserted into the
current upstream source interface and tested against the whole source tree.

## 4. The congruence order and its exact quotient

For a natural number `n`, define

\[
 \mathcal O_n=\{(a,b)\in\mathbb Z^2:n\mid a-b\}.             \tag{4.1}
\]

It is a subring of `Z x Z`.  Define the difference map

\[
 \delta_n:\mathbb Z^2\longrightarrow\mathbb Z/n\mathbb Z,
 \qquad (a,b)\longmapsto a-b\pmod n.                       \tag{4.2}
\]

### Theorem 4.1 (exact congruence-order quotient)

The map `delta_n` is a surjective additive homomorphism with kernel
`O_n`.  Consequently

\[
 \mathbb Z^2/\mathcal O_n\simeq\mathbb Z/n\mathbb Z,
 \qquad [\mathbb Z^2:\mathcal O_n]=n.                      \tag{4.3}
\]

The statement includes `n=0` under the standard cardinal-index convention:
both sides then have infinite cardinality and their `Nat.card` is zero.

#### Proof

Additivity of (4.2) is immediate.  Every residue class `r mod n` is the
image of `(r,0)`, so the map is surjective.  Moreover,

\[
 \delta_n(a,b)=0
 \quad\Longleftrightarrow\quad
 n\mid a-b,
\]

which identifies its kernel with (4.1).  The first isomorphism theorem for
abelian groups gives the displayed quotient equivalence.  Taking cardinality
gives `n`, the cardinality of `Z/nZ`; with `Nat.card`, this also gives zero
when `n=0`. ∎

### Corollary 4.2 (properness and full projections)

If `1<n`, then `O_n` is a proper finite-index subring of `Z x Z`, while both
coordinate projections of `O_n` are all of `Z`.

#### Proof

The exact index in Theorem 4.1 is `n>1`, so the subgroup cannot be the whole
group.  Explicitly, `(1,0)` is absent because `n` does not divide `1`.
For any `z`, the diagonal point `(z,z)` lies in `O_n` and projects to `z` in
both coordinates. ∎

This is a full-premise counterexample to the claim that surjective component
projections force a product order.  It does not refute a theorem that retains
the cross-component congruence or finite-index correction.

### Corollary 4.3 (multiplicative and logarithmic correction)

For positive natural numbers `m,n`,

\[
 [\mathbb Z^2:\mathcal O_{mn}]
 =[\mathbb Z^2:\mathcal O_m]
  [\mathbb Z^2:\mathcal O_n],                              \tag{4.4}
\]

and hence

\[
 \log [\mathbb Z^2:\mathcal O_{mn}]
 =\log [\mathbb Z^2:\mathcal O_m]
  +\log [\mathbb Z^2:\mathcal O_n].                       \tag{4.5}
\]

#### Proof

By Theorem 4.1, the three indices are `mn`, `m`, and `n`.  Equation (4.4) is
therefore the multiplication law for natural numbers.  Cast to positive real
numbers and apply `log(xy)=log x+log y` to obtain (4.5). ∎

Thus a finite-index seam contributes an additive logarithmic term.  In a
local DVR model with residue-field size `q`, a quotient of length `e` has
cardinality `q^e`, so its logarithmic index is `e log q`.  Identifying the
actual IUT tensor-order quotient with a different or conductor exponent is a
further arithmetic theorem and is not inferred here.

## 5. Consequences for the same-pilot route

The results impose two independent accounting requirements.

1. A prime-scaling edge may carry a nonzero log-volume translation only on a
   moving admissible orbit.  Empty, whole, fixed, or periodic regions cannot
   be silently included in that law.
2. Passing from a tensor product of integral orders to the product of maximal
   factor orders can add a finite index.  The resulting logarithmic term is
   additive under multiplication and must appear in any closed holonomy
   ledger unless a source theorem proves it vanishes or cancels.

These requirements support a positive same-pilot proof: they specify how to
make local transport consistent and how to retain the missing integral
correction.  They also supply exact counterexamples to two tempting
shortcuts.  Neither counterexample satisfies the premises of a corrected
admissible, index-aware same-pilot theorem, so that route remains active.

## 6. Formalization and validation boundary

The companion Lean module
`IUTAdmissibleScalingOrderIndex20260901.lean` formalizes Theorems 2.1--2.2 and
4.1--4.3, including the exact quotient index.  The upstream patch is tested
by compiling the current LANA `Iut` and `Iut4Sec1` targets after the
quantifier repair: the combined build completes all 8,767 jobs, including the
new `Iut.Concrete.Existence` module.  The source ledger
`research/sources/iut_admissible_scaling_order_index_2026_09_02/` records the
current upstream files, patch, exact replay, and build log.  A sealed
validation directory records the source hashes, declaration inventory, and
axiom audit.

What remains is the hard source-specific work: construct the actual local
Haar volumes and admissible family, compute the tensor-order index at every
factor and place, prove covariance through the horizontal link and Ind3, and
then identify the pointed q-pilot after the complete corrected transport.
Only after those steps can the IUT route supply the unconditional comparison
needed for abc.
