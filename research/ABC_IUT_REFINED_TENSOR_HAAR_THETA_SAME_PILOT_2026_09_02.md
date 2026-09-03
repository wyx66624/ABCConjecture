# Refined tensor Haar volume, theta admissibility, and the pointed same-pilot gate

**Author:** ChatGPT
**Date:** 2 September 2026
**Status:** unconditional local and finite-packet theorems; the source-level
horizontal same-pilot identification, IUT, and the abc conjecture remain open

## 1. Scope and primary-source boundary

This note continues the actual-Haar route after
`ABC_IUT_ACTUAL_HAAR_ADMISSIBLE_ORBIT_2026_09_02.md`.  That note proved the
one-field change-of-variables formula and the local factor formula under
displayed data

\[
 p=u\pi^e,\qquad |u|=1,\qquad |k_L|=p^f.
\]

The present note performs the missing finite-etale refinement.  A tensor of
finite extensions of \(\mathbb Q_p\) is generally a finite etale algebra, not
a field.  Its components must therefore be indexed by a place tuple together
with a primitive field factor.  We prove the normalization on those actual
factors, identify the canonical factor weights, and construct an honest
finite-positive theta union from topological and Haar hypotheses.  We then
isolate the exact source statement still needed for the horizontal
same-pilot comparison.

The source conventions and exact locators are:

* Mochizuki, [*Inter-universal Teichmuller Theory III* (May 2020 author
  PDF)](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf),
  Proposition 3.9(i), printed pp. 115--116, and Remark 3.9.5(i), printed
  p. 127, for normalized logarithmic volume and holomorphic hulls;
* the same paper, Theorem 3.11(i)--(ii), printed pp. 153--156, and
  Corollary 3.12 with proof Steps (xi-b)--(xi-f), printed pp. 173--184, for
  Ind1--Ind3, IPL/SHE/APT, determinant normalization, and the pointed pilot
  issue;
* the [July 2026 LANA formalization
  report](https://github.com/katobungen/LANA_report_202607/blob/main/LANA_report_202607.tex),
  Sections 6--7, for the explicit statement that the remaining wall is
  commutativity or identity after all three indeterminacies;
* Project LANA [`iut` commit
  `c65b28c9f9631635e742294c3a5df15759e7c74c`](https://github.com/lana-agents/iut/tree/c65b28c9f9631635e742294c3a5df15759e7c74c),
  observed at `main` on 2 September 2026 and frozen with exact hashes in
  `research/sources/iut_admissible_scaling_order_index_2026_09_02/`;
* the repository modules `TensorPacketDistribution`,
  `SemisimplePacketCoordinates`, and `RefinedFactorLocalFieldData`, which
  already construct the multilinear tuple expansion, the finite-etale
  primitive factors, and canonical mixed-characteristic local-field data on
  every factor.

No field called `samePilot`, no desired volume inequality, and no form of abc
is assumed below.  The results close the measure-theoretic part of a corrected
interface.  They do not manufacture the missing source-level horizontal map.

## 2. Primitive factors of a tensor packet

Fix a rational prime \(p\).  For one place tuple \(c=(v_j)_{j\in S}\), put

\[
 A_c=\bigotimes_{j\in S,\,\mathbb Q_p} K_{v_j}.
\]

Every \(K_{v_j}/\mathbb Q_p\) is finite separable.  Hence \(A_c\) is a
finite etale \(\mathbb Q_p\)-algebra and has a canonical Artinian
decomposition

\[
 A_c\simeq\prod_{d\in D_c}L_{c,d},                 \tag{2.1}
\]

where \(D_c\) is the finite set of maximal ideals and every \(L_{c,d}\) is a
finite extension of \(\mathbb Q_p\).  Write

\[
 e_{c,d}=e(L_{c,d}/\mathbb Q_p),\qquad
 f_{c,d}=f(L_{c,d}/\mathbb Q_p),\qquad
 n_{c,d}=[L_{c,d}:\mathbb Q_p].                         \tag{2.2}
\]

### Theorem 2.1 (actual prime factorization and local degree)

For every primitive factor \(L=L_{c,d}\) and every uniformizer \(\pi\) of
its integer ring, there is a unit \(u\in\mathcal O_L^\times\) such that

\[
 p=u\pi^e,\qquad |k_L|=p^f,\qquad [L:\mathbb Q_p]=ef.    \tag{2.3}
\]

#### Proof

The image of \(p\) in \(\mathcal O_L\) is nonzero and belongs to the maximal
ideal.  Unique factorization in the discrete valuation ring gives
\(p=u\pi^m\), with \(u\) a unit and \(m>0\).  Apply the integer-valued
valuation normalized by \(v_L(\pi)=1\).  By definition the ramification
index is \(v_L(p)=e\), while the displayed factorization gives
\(v_L(p)=m\); hence \(m=e\).

The residue extension \(k_L/\mathbb F_p\) has degree \(f\), so the elementary
cardinality formula for a finite-dimensional vector space over
\(\mathbb F_p\) gives \(|k_L|=p^f\).  Finally, finite extensions of complete
discretely valued fields are defectless, and the fundamental equality is
\([L:\mathbb Q_p]=ef\).  Equivalently, this follows from the
ramification-index-times-inertia-degree theorem for the two local DVRs.  This
proves (2.3). \(\square\)

### Corollary 2.2 (dimension conservation under primitive refinement)

Let

\[
 N_c=\dim_{\mathbb Q_p}A_c.
\]

Then

\[
 N_c=\sum_{d\in D_c}n_{c,d}
    =\sum_{d\in D_c}e_{c,d}f_{c,d}>0.                  \tag{2.4}
\]

#### Proof

The algebra equivalence (2.1) is in particular a linear equivalence.  Finite
dimension is additive on finite products, giving the first equality.  Apply
Theorem 2.1 to every summand for the second.  At least one primitive factor
exists because \(A_c\) is a nonzero unital algebra, and each local degree is
positive. \(\square\)

## 3. Genuine product Haar measure and the unique raw normalization

Normalize additive Haar measure \(\mu_{c,d}\) on \(L_{c,d}\) by
\(\mu_{c,d}(\mathcal O_{c,d})=1\).  Let \(U_{c,d}\) be nonempty compact-open
regions and put

\[
 U_c=\prod_d U_{c,d},\qquad
 \mu_c=\prod_d\mu_{c,d},\qquad
 \lambda_c^{\rm raw}(U_c)=\log\mu_c(U_c).               \tag{3.1}
\]

The region \(U_c\) is again nonempty compact-open, measurable, and of finite
positive product measure.  In particular, all logarithms below are ordinary
real logarithms of positive finite numbers.

### Theorem 3.1 (raw diagonal-prime Jacobian)

Coordinatewise inverse image under multiplication by \(p\) satisfies

\[
 \lambda_c^{\rm raw}(p^{-1}U_c)
 =\lambda_c^{\rm raw}(U_c)+N_c\log p.                  \tag{3.2}
\]

#### Proof

For one primitive factor, Theorem 2.1 and the normalized Haar character give

\[
 \mu_{c,d}(p^{-1}U_{c,d})
 =p^{e_{c,d}f_{c,d}}\mu_{c,d}(U_{c,d}).                 \tag{3.3}
\]

Product measure turns products of measures into sums of logarithms.  Summing
(3.3) over \(d\) gives a shift
\(\sum_d e_{c,d}f_{c,d}\log p=N_c\log p\) by (2.4).
\(\square\)

Define the dimension-normalized component volume

\[
 \lambda_c(U_c)=\frac{\lambda_c^{\rm raw}(U_c)}{N_c}.   \tag{3.4}
\]

### Theorem 3.2 (the exact prime coefficient in the corrected Haar model)

For every finite-positive compact-open product region,

\[
 \lambda_c(p^{-1}U_c)=\lambda_c(U_c)+\log p.            \tag{3.5}
\]

#### Proof

Divide (3.2) by the positive integer \(N_c\). \(\square\)

The normalization (3.4) is forced if the component volume is required to be
a constant multiple of the raw product Haar logarithm, to vanish on the
integral product, and to have prime-preimage shift exactly \(\log p\): if the
constant is \(a\), then (3.2) gives \(aN_c=1\), hence \(a=1/N_c\).

### Corollary 3.3 (dimension-weighted factor formula)

Put

\[
 \lambda_{c,d}(U)=
   \frac{\log\mu_{c,d}(U)}{n_{c,d}},\qquad
 \rho_{c,d}=\frac{n_{c,d}}{N_c}.                        \tag{3.6}
\]

Then \(\rho_{c,d}>0\), \(\sum_d\rho_{c,d}=1\), and

\[
 \lambda_c(U_c)=\sum_d\rho_{c,d}\lambda_{c,d}(U_{c,d}).\tag{3.7}
\]

Thus two descriptions agree exactly: normalize the raw Haar log of the whole
finite-etale algebra by its total dimension, or normalize each primitive
field by its local degree and average with relative-dimension weights.

#### Proof

Positivity and normalization of the \(\rho_{c,d}\) follow from (2.4).  For
(3.7), cancel \(n_{c,d}\) in every summand:

\[
 \sum_d\frac{n_{c,d}}{N_c}
       \frac{\log\mu_{c,d}(U_{c,d})}{n_{c,d}}
 =\frac1{N_c}\sum_d\log\mu_{c,d}(U_{c,d}).
\]

The last sum is the raw product logarithm by the product-measure theorem.
\(\square\)

### Proposition 3.4 (factor-count normalization is false)

Replacing the total degree \(N_c\) in (3.4) by the number \(|D_c|\) of
primitive factors does not in general give prime shift \(\log p\).

#### Full-premise counterexample

Take one quadratic local field \(L/\mathbb Q_p\), viewed as a one-factor
finite etale algebra.  Then \(|D_c|=1\), while \(N_c=[L:\mathbb Q_p]=2\).
For every nonempty compact-open \(U\subset L\), (3.2) gives raw shift
\(2\log p\).  Division by \(|D_c|=1\) leaves \(2\log p\ne\log p\).  The
algebra is finite etale, its unique factor is a genuine local field, and the
Haar region is finite-positive compact-open.  Thus every premise of the
factor-count rule holds.  This rejects only that normalization rule; the
total-degree normalization survives.

## 4. Refining the place-tuple weights

Let \(w(v)>0\) be the usual place weights over a rational place, with
\(\sum_vw(v)=1\).  For a label set \(S\), the existing tensor convention is

\[
 W_c=\prod_{j\in S}w(c_j),\qquad \sum_cW_c=1.           \tag{4.1}
\]

After the mandatory primitive refinement (2.1), define

\[
 \widetilde W_{c,d}=W_c\rho_{c,d}
 =W_c\frac{n_{c,d}}{N_c}.                               \tag{4.2}
\]

### Theorem 4.1 (refined packet-weight conservation)

For every tuple \(c\),

\[
 \sum_d\widetilde W_{c,d}=W_c,
\]

and globally

\[
 \sum_c\sum_d\widetilde W_{c,d}=1.                    \tag{4.3}
\]

Consequently, if every primitive normalized component changes by \(\log p\),
the complete refined packet volume also changes by exactly \(\log p\).

#### Proof

For fixed \(c\), factor out \(W_c\) and use
\(\sum_d\rho_{c,d}=1\).  Summing over \(c\) and applying (4.1) proves (4.3).
The shift of the weighted volume is therefore

\[
 \sum_{c,d}\widetilde W_{c,d}\log p=\log p.
\]

\(\square\)

### Proposition 4.2 (copying a tuple weight to every primitive factor is false)

The rule \(\widetilde W_{c,d}=W_c\) does not preserve packet normalization.

#### Full-premise counterexample

Let \(K/\mathbb Q_p\) be an unramified quadratic Galois extension.  Then

\[
 K\otimes_{\mathbb Q_p}K\simeq K\times K.              \tag{4.4}
\]

Take the only place tuple to have weight \(W_c=1\).  There are two primitive
factors.  Copying the tuple weight gives total refined weight \(2\), and the
two individually normalized component shifts aggregate to
\(2\log p\ne\log p\).  All hypotheses of the copied-weight rule are met: the
tensor algebra is finite etale, both primitive factors are genuine local
fields, the original tuple weight is positive normalized, and both regions
are compact-open of finite positive Haar measure.  Only the copied-weight
conclusion is false.  The corrected relative-dimension weights are
\(1/2,1/2\).

This counterexample retires only the copied-weight refinement.  It does not
affect the dimension-refined route.

## 5. Actual-Haar admissibility of a theta orbit

Let \(X\) be a finite product of the primitive local fields, equipped with
product Haar measure \(\mu\).  Let \(U\subseteq X\) be nonempty and open, and
let \(\{\phi_a:X\simeq X\}_{a\in A}\) be homeomorphisms.  Put

\[
 \Theta(U)=\bigcup_{a\in A}\phi_a(U).                  \tag{5.1}
\]

Assume:

1. one \(\phi_{a_0}\) is the identity;
2. every \(\phi_a(U)\) is contained in one region \(E\);
3. \(\overline E\) is compact.

### Theorem 5.1 (bounded open orbit is genuinely admissible)

Under these hypotheses, \(\Theta(U)\) is measurable, nonempty, open, has
finite positive Haar measure, and has compact closure.  In particular it is
an actual member of the repaired finite-positive admissible class; its
admissibility need not be stored as an independent structure field.

#### Proof

Every homeomorphic image of the open set \(U\) is open, and an arbitrary
union of open sets is open and hence Borel measurable.  The identity branch
contains \(U\), so the union is nonempty.  A nonempty open set has positive
Haar measure.  The union is contained in \(E\), hence its closure is contained
in \(\overline E\).  The closure is closed, so it is a closed subset of a
compact set and therefore compact.  Haar measure is finite on compact sets;
monotonicity then makes the measure of \(\Theta(U)\) finite. \(\square\)

If the index type \(A\) is finite and the seed \(U\) is compact-open, then
the orbit union is also compact-open: it is a finite union of compact sets
and an arbitrary union of open sets.  Hence in this finite case the output
belongs to the exact finite-positive compact-open class.  For an infinite
family, the hypotheses of Theorem 5.1 prove an open set with compact closure,
but do not by themselves prove that the union is closed or compact.  This is
a precise distinction between compact-open admissibility and the larger
finite-positive relatively compact class, not a reason to abandon the theta
route.

The index set \(A\) need not be finite or countable.  Openness is what makes
the arbitrary union measurable.  This observation applies directly to the
Ind1/Ind2 automorphism orbit once the source maps are constructed as
homeomorphisms and Proposition 1.4 supplies the common compact hull.

### Theorem 5.2 (upper-semicompatible Ind1--Ind3 union)

Consider the repository's inductively generated system of ordinary branches,
Ind1 maps, Ind2 maps, and a relational Ind3 step.  Suppose:

* every ordinary branch is open and one distinguished native branch is
  nonempty;
* Ind1 and Ind2 preserve openness;
* every Ind3-related target of an open reachable region is open;
* all four constructors preserve containment in an envelope \(E\) whose
  closure is compact.

Then the union of every reachable possible-image region is an actual
finite-positive, relatively compact Haar region.

#### Proof

Induction on the reachability derivation proves that every reachable region
is open.  Their arbitrary union is open.  The ordinary constructor includes
the distinguished nonempty native branch, so the union is nonempty.  The
envelope-preservation induction puts the union inside \(E\).  The remainder
is Theorem 5.1's positivity, finiteness, and compact-closure argument.
\(\square\)

### Proposition 5.3 (envelope preservation alone does not preserve admissibility)

The openness or positive-measure hypothesis on Ind3 cannot be dropped.

#### Full-premise counterexample

Use \(X=\mathbb R\) with Lebesgue Haar measure, native region
\(U=(-1,1)\), and compact envelope \(E=[-1,1]\).  Let one relational Ind3
step send \(U\) to \(V=\{0\}\).  Then

\[
 U\subseteq E,\qquad V\subseteq E,
\]

so the ordinary and Ind3 envelope conditions hold, and both sets are Borel
and relatively compact.  But \(\mu(V)=0\), so \(V\) is not in the
finite-positive admissible class.  This refutes the exact claim that the
upper-semicompatible envelope condition by itself makes every reachable
output admissible.  It does not refute an Ind3 theorem that separately proves
openness or positive measure, and therefore does not close the IUT route.

## 6. The pointed same-pilot comparison after admissibility

Let \(P\) be the actual native q-pilot region, \(\Theta\) the actual union of
reachable theta outputs, and \(H\) a finite-positive hull region.  Suppose the
object-level construction proves

\[
 P\subseteq\Theta\subseteq H.                            \tag{6.1}
\]

### Theorem 6.1 (actual-Haar same-pilot sandwich)

The canonical Haar logarithms satisfy

\[
 \log\mu(P)\le\log\mu(\Theta)\le\log\mu(H).             \tag{6.2}
\]

Consequently any independently proved output estimate
\(\log\mu(H)\le T\) gives \(\log\mu(P)\le T\).

#### Proof

Measure is monotone under each inclusion in (6.1).  All three measures are
finite and strictly positive, so conversion to real numbers and the real
logarithm preserve the order.  Apply transitivity. \(\square\)

This theorem shows that equality of endpoints is stronger than the numerical
argument needs.  A pointed inclusion of the actual q-pilot in the actual
possible-image union is enough.  No Ind map has to preserve Haar measure: the
direction of inclusion supplies the correct inequality.

The result does **not** make the missing source premise tautological.  The
ordinary constructor in a generated syntax contains whatever region was
declared to be native.  The unresolved horizontal theorem is precisely that
the region declared native after the theta link, IPL/SHE/APT transport,
log-Kummer correction, determinant normalization, and Ind3 is the same
pointed q-pilot region \(P\), or at least contains it through a specified map.
Naming an unrelated ordinary branch `native` would not prove (6.1).

### Proposition 6.2 (an unpointed output bound is insufficient)

Even finite-positive compact-open data and a common compact envelope do not
imply the first inclusion in (6.1).  In the discrete three-point Haar space
with counting measure, take

\[
 P=\{0,1\},\qquad \Theta=H=\{0\}.
\]

All three sets are compact-open and have finite positive measure, and
\(\Theta\subseteq H\), but

\[
 \log\mu(P)=\log2>0=\log\mu(H).
\]

Thus the pointed hit cannot be inferred from admissibility or an envelope
upper bound.  The example satisfies every premise of that deliberately
unpointed inference and falsifies only its conclusion.

## 7. What closes and what remains open

The following parts are now mathematical consequences rather than desired
fields.

1. Every primitive tensor factor has the exact data
   \(p=u\pi^e\), \(|k|=p^f\), and local degree \(ef\).
2. A compact-open rectangle in the refined product is genuinely
   finite-positive under product Haar measure.
3. Total-dimension normalization gives exactly one \(\log p\) under diagonal
   rational-prime preimage.
4. Primitive refinement conserves tuple weights through the canonical
   relative-dimension split.
5. A bounded open theta orbit, even for infinitely many Ind1/Ind2 maps, is an
   actual admissible region.
6. Once the pointed inclusion (6.1) is constructed, the same-pilot numerical
   inequality is immediate from actual Haar monotonicity.

Four source-specific obligations remain active.

1. Identify the actual tensor product of completed fields used in every
   capsule with the finite-etale packet and transport its integral order to
   the primitive factor rings, including the finite-index/different
   correction when the tensor order is not maximal.
2. Prove that the concrete Ind1 and Ind2 actions are the homeomorphisms used
   above and prove the required common-envelope containment for the exact
   theta regions.
3. Prove that every relational Ind3 target needed by Theorem 3.11 remains
   open or at least measurable of positive measure; envelope preservation
   alone is insufficient by Proposition 5.3.
4. Prove the pointed horizontal identification or inclusion of the original
   q-pilot through IPL/SHE/APT and the log-Kummer/determinant normalizations.
   This is the LANA same-pilot wall.  No complete-source counterexample is
   presently known, so the route remains active.

### 7.1 Route-status ledger

The labels in this table are logical statuses, not estimates of difficulty.

| Statement | Status | Consequence for the route |
|---|---|---|
| Exact primitive-factor identities \(p=u\pi^e\), \(|k|=p^f\), and \([L:\mathbb Q_p]=ef\) | **PROVED** | Supplies the actual tensor/place local data. |
| Total-degree product-Haar normalization and relative-degree weights | **PROVED** | Supplies the corrected finite-etale volume normalization. |
| Finite homeomorphism orbit of a compact-open seed is finite-positive compact-open | **PROVED** | Closes the topological/Haar gate for finite Ind1/Ind2 families once the source maps are identified. |
| Arbitrary bounded open orbit is finite-positive with compact closure | **PROVED** | Gives the larger admissible class; compactness of the set itself remains an extra premise for infinite families. |
| Divide raw volume by the number of primitive factors | **REFUTED under all premises** by Proposition 3.4 | Retire only this normalization rule. |
| Copy a tuple weight to every primitive factor | **REFUTED under all premises** by Proposition 4.2 | Retire only copied weights; retain relative-degree refinement. |
| Envelope preservation alone makes every Ind3 target finite-positive | **REFUTED under all premises** by Proposition 5.3 | Require Ind3 openness or an independent positive-measure theorem; retain the broader Ind3/IUT route. |
| Derive the native-pilot bound from unpointed finite-positive output data | **REFUTED under all premises** by Proposition 6.2 | Require a pointed hit; retain the pointed same-pilot route. |
| Concrete IUT Ind1/Ind2 maps satisfy the homeomorphism and common-envelope premises | **OPEN GAP** | No counterexample meeting the full source premises is known; continue the route. |
| Concrete Ind3 targets are open or finite-positive | **OPEN GAP** | Difficulty is not disproof; continue unless a full-premise source counterexample is found. |
| IPL/SHE/APT and determinant transport give \(P\subseteq\Theta\) for the original q-pilot | **OPEN GAP** | This is the current same-pilot gate; no full-premise counterexample is known. |
| IUT III Corollary 3.12, IUT, and abc | **OPEN** | Neither proved nor refuted here. |

### 7.2 Domain-separation audit

The argument has four interfaces, and no conclusion is silently transported
across them.

| Interface | Exact input | Exact output | What it does **not** provide |
|---|---|---|---|
| Finite-etale refinement | A finite-etale \(\mathbb Q_p\)-algebra \(A_c\) and its maximal-ideal quotients | Genuine field factors, \(p=u\pi^e\), \(|k|=p^f\), \([L:\mathbb Q_p]=ef\), and dimension conservation | A theta region, an Ind map, or a Haar-positivity theorem |
| Haar positivity | A locally compact product group with Haar measure, a nonempty open union, and containment in an envelope with compact closure | Measurability and finite positive measure; compact-open output only for the separately finite compact-open orbit | Concrete IUT Ind1--Ind3 hypotheses or a pointed pilot hit |
| Ind3 propagation | The explicit additional premise that every required relational Ind3 target of an open reachable region is open (or an independent replacement proving positive measure) | Openness of the possible-image union and access to the Haar theorem | This premise is not derived from envelope preservation, as the full-premise counterexample to the weaker claim shows |
| Pointed horizontal hit | The object-level inclusion of the original q-pilot \(P\subseteq\Theta\), together with \(\Theta\subseteq H\) | The log-volume sandwich by monotonicity | The pointed inclusion is not derived from finite-positive admissibility, the generated-syntax label `native`, or the hull bound |

Accordingly, Propositions 3.4, 4.2, 5.3, and 6.2 refute only the
factor-count, copied-weight, envelope-only, and unpointed subclaims stated
there.  They do not refute the finite-etale route, a concrete Ind3 theorem
with stronger hypotheses, the pointed same-pilot route, IUT, or abc.

## 8. Formalization and computation boundary

The companion Lean module is
`Lean/IUTThreeClosures/IUTRefinedTensorHaarThetaSamePilot20260902.lean`.
It formalizes the total-degree normalization, refined-weight conservation,
the actual finite-positive compact-open product class, finite compact-open
homeomorphism orbits, the bounded-open-orbit Haar construction, the
Ind1--Ind3 openness induction, the same-pilot sandwich, coefficient-level
counterexamples to factor-count normalization and copied weights, and exact
set-level counterexamples to envelope-only Ind3 admissibility and unpointed
comparison.  The quadratic local-field and tensor-product realizations of the
first two witnesses remain paper proofs; Lean checks their scalar consequences
rather than constructing those fields.  On each actual
`TupleFiniteEtalePacket.refinedFactorLocalFieldData`, Lean now derives the
ramification-index factorization, residue cardinality, and local-degree
identity from DVR, integral-closure, ramification, and inertia theorems; none
is introduced as an axiom.  It also derives the tuple-level identity
\(\dim_{\mathbb Q_p}A_c=\sum_d e_{c,d}f_{c,d}\) from the finite-etale
semisimple coordinate equivalence.  The module contains 38 theorem
declarations.  The separate audit prints the axioms of 19 representative
definitions and theorems; the only reported foundations are Mathlib's
standard `propext`, `Classical.choice`, and `Quot.sound`.

The computation directory
`research/computation/2026_09_02_iut_refined_tensor_haar_theta_same_pilot/`
exhaustively replays the normalization identities for bounded degree packets
and searches the same range for failures of the two rejected normalization
rules.  It checks 406,900 degree packets and 4,069,000 parent-weight
refinements using exact rational arithmetic.  Finite computation is used
only as an audit of algebraic formulas,
not as evidence for Corollary 3.12 or abc.

A directly inputtable English paper fragment is
`paper/iut_refined_tensor_haar_theta_same_pilot_2026.tex`.
It requires only `amsmath` and `amssymb` in the enclosing preamble and was
compiled through a minimal wrapper with bundled Tectonic 0.17.0.

### 8.1 Reproducible verification commands

From the repository root:

```text
cd Lean
lake env lean -DwarningAsError=true IUTThreeClosures/IUTRefinedTensorHaarThetaSamePilot20260902.lean
lake build IUTThreeClosures.IUTRefinedTensorHaarThetaSamePilot20260902
lake env lean -DwarningAsError=true IUTThreeClosures/IUTRefinedTensorHaarThetaSamePilot20260902AxiomAudit.lean
lake build IUTThreeClosures
cd ..
python research/computation/2026_09_02_iut_refined_tensor_haar_theta_same_pilot/verify_refined_tensor_normalization.py
python research/sources/iut_admissible_scaling_order_index_2026_09_02/verify_source_metadata.py
```

The placeholder scan is:

```text
rg -n "\bsorry\b|\badmit\b|\baxiom\b|native_decide" Lean/IUTThreeClosures/IUTRefinedTensorHaarThetaSamePilot20260902.lean Lean/IUTThreeClosures/IUTRefinedTensorHaarThetaSamePilot20260902AxiomAudit.lean
```

The paper-only, unformalized obligations include the four active items in
Section 7 and the two concrete local-field realizations just distinguished:
the IUT capsule-to-packet and integral-order comparison (including
finite-index/different corrections), the concrete Ind1/Ind2 maps and compact
envelope, the required concrete Ind3 openness or positivity, and the pointed
IPL/SHE/APT transport.  The TeX fragment records the same boundary.

No theorem here proves or disproves IUT III, Corollary 3.12, IUT, or the
standard abc conjecture.

## 9. References

1. S. Mochizuki, *Inter-universal Teichmuller Theory III: Canonical
   Splittings of the Log-theta-lattice*, May 2020 author version.
2. LANA contributors, *LANA Formalization Report*, July 2026, especially
   Sections 6--7.
3. Project LANA, `lana-agents/iut`, commit
   `c65b28c9f9631635e742294c3a5df15759e7c74c`.
4. The Mathlib community, `RamificationInertia`, `Padics.RingHoms`, and
   `MeasureTheory.Constructions.Pi` libraries used by the Lean companion.
