# A prime--unit--label vector bridge for the IUT same-pilot problem

**Author:** ChatGPT  
**Research date:** 2026-09-01  
**Status:** unconditional algebraic reconstruction, labelled-packet, and
vector-holonomy theorems; complete counterexamples to three weakened
interfaces.  The theorems give a sufficient coordinate layer for a future
same-pilot comparison.  They do not construct the IUT multiradial map, prove
that it preserves these coordinates, prove IUT III Corollary 3.12, prove or
disprove IUT, or prove or disprove abc.

## 1. Why the scalar gate should be lifted before taking volume

The corrected-volume continuation proved two facts that constrain the next
same-pilot step.

1. A closed pointed loop has zero real logarithmic holonomy, and rational
   combinations of logarithms of distinct rational primes cancel
   prime-by-prime.
2. Even strictly positive normalized weights do not make one scalar weighted
   log-volume injective on labelled packets.

Thus a scalar identity may be a consequence of a same-pilot theorem, but it
cannot by itself be used to reconstruct the pilot.  This note retains three
layers until the object comparison is finished:

* the rational prime, through its valuation exponent;
* the complete local unit part, rather than only its norm or first residue;
* the procession or packet label, rather than an unordered orbit of labels.

This choice follows the type boundary visible in the primary sources.  IUT
III distinguishes unit/coric portions and mono-analytic log-shells before
passing to scalar log-volume.  In the current Project LANA container, a packet
component is a function from the capsule label type to the fiber of places
over a rational place; the comments explicitly say that the rational-place
decomposition and procession labels are retained.  Its scalar `packetVol`
is applied only later.  Neither source supplies the coordinate-preservation
theorem proved below for the actual multiradial construction.

The point of the present model is therefore precise.  It proves that a
prime--unit--label certificate is logically strong enough and records sharp
failure modes of natural weakenings.  It does not assert that a published IUT
arrow already carries such a certificate.

The exact primary-source anchors are as follows.

| Primary source | Type information used here |
|---|---|
| [IUT III, May 2020 author PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf), Propositions 3.1--3.5 and Remark 3.9.5 | Tensor packets, unit/coric portions, mono-analytic log-shells, possible-image operations, and the later log-volume hull occur as distinct layers. |
| [Project LANA `Container.lean`, commit `ddaddc2`, lines 79--133](https://github.com/lana-agents/iut/blob/ddaddc274281adb5674d647e24fa478745ac6d40/Iut/Cor312/Container.lean#L79-L133) | A component retains the rational place and is a function from the capsule label type to the fiber of places. |
| [Project LANA `LogVolume.lean`, lines 74--120](https://github.com/lana-agents/iut/blob/ddaddc274281adb5674d647e24fa478745ac6d40/Iut/Cor312/LogVolume.lean#L74-L120) and [lines 127--193](https://github.com/lana-agents/iut/blob/ddaddc274281adb5674d647e24fa478745ac6d40/Iut/Cor312/LogVolume.lean#L127-L193) | Place weights are positive and normalized; packet weights are products over labels; permutation invariance and scalar packet/procession volumes are separate statements. |
| [Project LANA README at the same commit](https://github.com/lana-agents/iut/blob/ddaddc274281adb5674d647e24fa478745ac6d40/README.md) | The Corollary 3.12 variant is deliberately unproved, and the theta-pilot region is input data rather than the output of a constructed multiradial algorithm. |

The repository's read-only remote check on 2026-09-01 found the pinned commit
`ddaddc274281adb5674d647e24fa478745ac6d40` still at both Project LANA `HEAD`
and `main`.

## 2. Exact local coordinates and a field-summand template

Fix a rational prime \(p\).  For \(x\in\mathbb Q^\times\), define

\[
 e_p(x)=v_p(x)\in\mathbb Z,
 \qquad
 u_p(x)=\frac{x}{p^{e_p(x)}}\in\mathbb Q^\times .       \tag{2.1}
\]

Here negative powers have their usual rational meaning.  Call

\[
 C_p(x)=(e_p(x),u_p(x))                                \tag{2.2}
\]

the complete local prime--unit coordinate of \(x\).

### Theorem 2.1 (normalization and exact reconstruction)

For every \(x\in\mathbb Q^\times\),

\[
 v_p(u_p(x))=0,
 \qquad
 p^{e_p(x)}u_p(x)=x.                                   \tag{2.3}
\]

Consequently \(C_p\colon\mathbb Q^\times\to
\mathbb Z\times\mathbb Q^\times\) is injective.

#### Proof

Both \(x\) and \(p^{e_p(x)}\) are nonzero.  Additivity of the rational
\(p\)-adic valuation and \(v_p(p)=1\) give

\[
\begin{aligned}
 v_p(u_p(x))
 &=v_p(x)-v_p\!\left(p^{e_p(x)}\right)\\
 &=e_p(x)-e_p(x)v_p(p)=0.
\end{aligned}
\]

The second identity is direct cancellation:

\[
 p^{e_p(x)}u_p(x)
 =p^{e_p(x)}\frac{x}{p^{e_p(x)}}=x.
\]

If \(C_p(x)=C_p(y)\), applying the reconstruction expression to the two
equal coordinates yields \(x=y\).  Hence \(C_p\) is injective. \(\square\)

The theorem uses only standard unique valuation decomposition in
\(\mathbb Q^\times\).  In particular, the unit coordinate is not a new
axiom: it is explicitly defined and reconstructed.

### Theorem 2.2 (actual \(p\)-adic local-field coordinate)

Let \(\mathbb Q_p\) be the complete \(p\)-adic field with its integral
additive valuation, normalized by \(v_p(p)=1\).  For
\(x\in\mathbb Q_p^\times\), put

\[
 \widehat e_p(x)=v_p(x),\qquad
 \widehat u_p(x)=\frac{x}{p^{\widehat e_p(x)}}.          \tag{2.4}
\]

Then

\[
 v_p(\widehat u_p(x))=0,\qquad
 p^{\widehat e_p(x)}\widehat u_p(x)=x,                 \tag{2.5}
\]

and \(x\mapsto(\widehat e_p(x),\widehat u_p(x))\) is
injective on \(\mathbb Q_p^\times\).

#### Proof

Because \(x\ne0\) and \(p\ne0\), all displayed inverses exist.  Valuation
additivity, the valuation law for integral powers, and \(v_p(p)=1\) give

\[
\begin{aligned}
 v_p(\widehat u_p(x))
 &=v_p(x)-v_p\!\left(p^{v_p(x)}\right)\\
 &=v_p(x)-v_p(x)v_p(p)=0.
\end{aligned}
\]

Multiplying (2.4) by the nonzero power \(p^{\widehat e_p(x)}\) proves the
reconstruction formula.  Equality of the two coordinates for \(x,y\) makes
their reconstruction formulas equal, so \(x=y\). \(\square\)

Thus the positive coordinate result is not confined to a rational toy
carrier: it is formalized on Mathlib's actual complete field `ℚ_[p]`.  What
remains model-specific is the transport theorem saying that the IUT arrows
preserve these coordinates on their actual packet summands.

### Theorem 2.3 (field-summand scale reconstruction)

Let \(K\) be any field, let \(\pi\in K^\times\), and let
\(e:K^\times\to\mathbb Z\) be any integer-valued exponent map.  Define

\[
 u_{\pi,e}(x)=\frac{x}{\pi^{e(x)}}.                    \tag{2.6}
\]

Then \(u_{\pi,e}(x)\ne0\),

\[
 \pi^{e(x)}u_{\pi,e}(x)=x,                             \tag{2.7}
\]

and the coordinate map \(x\mapsto(e(x),u_{\pi,e}(x))\) is injective.

#### Proof

The scale power is nonzero because \(\pi\ne0\), so the quotient in (2.6) is
nonzero.  Cancelling that same scale power proves (2.7).  If both coordinates
of \(x\) and \(y\) agree, their two reconstruction formulas have identical
right-hand expressions, hence \(x=y\). \(\square\)

For a discretely valued local-field summand, take \(\pi\) to be a
uniformizer and \(e\) its normalized valuation.  The valuation calculation in
Theorem 2.2 then proves that (2.6) is genuinely a unit.  This field-level
template applies separately to every semisimple packet summand once the
source construction supplies its actual field, uniformizer, and transport.

## 3. The labelled vector reconstruction theorem

Let \(L\) be a label set and let a rational pilot packet be a function

\[
 P:L\longrightarrow\mathbb Q^\times .
\]

Its labelled local signature at \(p\) is the vector

\[
 \Sigma_p(P)=\bigl(C_p(P(i))\bigr)_{i\in L}.            \tag{3.1}
\]

### Theorem 3.1 (one-place labelled reconstruction)

If two packets \(P,Q:L\to\mathbb Q^\times\) satisfy

\[
 e_p(P(i))=e_p(Q(i)),\qquad
 u_p(P(i))=u_p(Q(i))\quad(i\in L),                      \tag{3.2}
\]

then \(P=Q\).

More generally, if \(\sigma:L\simeq M\) and

\[
 C_p(P(i))=C_p(Q(\sigma i))\quad(i\in L),              \tag{3.3}
\]

then \(P(i)=Q(\sigma i)\) for every \(i\).

#### Proof

For every fixed label, (3.2), or respectively (3.3), is equality of the two
coordinates in (2.2).  Theorem 2.1 gives equality of the corresponding
nonzero rationals.  Function extensionality gives \(P=Q\) in the
label-preserving case. \(\square\)

Only one place is needed in this rational model because the *complete* unit
part at that place still contains all information complementary to the
valuation.  This is deliberately stronger than keeping a norm, square class,
or residue class.  In an actual local-field or IUT instantiation, the burden is
to define the appropriate complete unit/coric coordinate and prove its
faithfulness after every permitted quotient.

### Corollary 3.2 (actual \(p\)-adic labelled reconstruction)

Let \(P,Q:L\to\mathbb Q_p^\times\).  If
\(\widehat e_p(P(i))=\widehat e_p(Q(i))\) and
\(\widehat u_p(P(i))=\widehat u_p(Q(i))\) at every fixed label, then
\(P=Q\).

#### Proof

Apply the injectivity conclusion of Theorem 2.2 at each label and then use
function extensionality. \(\square\)

### Corollary 3.3 (universal weighted-observable transfer)

Let \(L\) be finite.  Under the hypotheses of Theorem 3.1, for every weight
function \(w:L\to\mathbb R\) and every observable
\(f:\mathbb Q^\times\to\mathbb R\),

\[
 \sum_{i\in L}w_i f(P(i))
 =\sum_{i\in L}w_i f(Q(i)).                             \tag{3.4}
\]

In particular, (3.4) holds for every strictly positive normalized weight
system.

#### Proof

Theorem 3.1 gives \(P(i)=Q(i)\) at each label.  Therefore every summand on
the two sides is equal. \(\square\)

This is stronger than equality of one chosen weighted log-volume: the same
coordinate certificate works simultaneously for every weight and every
observable.

## 4. A non-circular pointed same-pilot bridge

The preceding theorem has a useful abstract form.  Let \(X\) be an object
carrier, \(V\) a set of places, and \(U\) a unit-tag carrier.  A faithful
prime--unit fingerprint consists of maps

\[
 E:V\times X\to\mathbb Z,\qquad U_0:V\times X\to U,     \tag{4.1}
\]

such that equality of all \(E\)- and \(U_0\)-coordinates implies equality in
\(X\).  No existence is hidden in this definition: faithfulness is a proof
obligation.  Theorem 2.1 supplies an inhabited example with
\(X=\mathbb Q^\times\), one chosen rational prime, and
\(U=\mathbb Q^\times\); Theorem 2.2 supplies the corresponding actual
\(\mathbb Q_p^\times\) example; and Theorem 2.3 supplies a reusable template
for arbitrary field summands.

### Theorem 4.1 (faithful labelled fingerprint bridge)

Let \(P,Q:L\to X\).  If their prime and unit coordinates agree at every
place and every *fixed* label, then \(P=Q\).  Consequently, for any numerical
functional \(\nu:(L\to X)\to\mathbb R\) and threshold \(T\),

\[
 \nu(Q)\le T\quad\Longrightarrow\quad\nu(P)\le T.       \tag{4.2}
\]

#### Proof

At each label, faithfulness of (4.1) gives \(P(i)=Q(i)\).  Hence \(P=Q\).
Substitution in the assumed output bound proves (4.2). \(\square\)

### Theorem 4.2 (faithful vector-image bridge for pilot regions)

Let \(\Sigma\) be the labelled signature induced by a faithful fingerprint,
and let \(A,B\subseteq(L\to X)\) be packet regions.  If

\[
 \Sigma(A)\subseteq\Sigma(B),                           \tag{4.3}
\]

then \(A\subseteq B\).  Equality of the two signature images implies
\(A=B\).  Moreover, if \(\mu\) is any monotone real-valued region functional
and

\[
 \mu(B)\le T,                                          \tag{4.4}
\]

then \(\mu(A)\le T\).

#### Proof

Take \(P\in A\).  By (4.3), \(\Sigma(P)\in\Sigma(B)\), so some \(Q\in B\)
satisfies \(\Sigma(Q)=\Sigma(P)\).  Theorem 4.1 gives \(Q=P\), hence
\(P\in B\).  Therefore \(A\subseteq B\).  Applying this argument in both
directions proves the equality assertion.  Finally monotonicity gives
\(\mu(A)\le\mu(B)\), and (4.4) finishes by transitivity. \(\square\)

This theorem is the region-level positive bridge missing from a scalar-only
model.  It requires neither equality of the regions nor equality of one
chosen volume as an input: independently proved containment of their complete
coordinate images is enough.  The monotonicity premise must be proved on the
correct finite-positive-volume domain; the inconsistent unrestricted
`LogVolumeData` law audited earlier cannot supply it.

Applied to the IUT same-pilot problem, \(P\) is the pointed native q-pilot
packet and \(Q\) is the globally synchronized selected output packet.  The
new positive target is now explicit.  At the point level one may prove the
coordinate equality in Theorem 4.1; at the region level it is enough to prove
the coordinate-image containment (4.3).  Concretely one must:

1. define a faithful prime--unit fingerprint on the actual common carrier;
2. prove that the theta link, log-Kummer correction, determinant
   normalization, and every required Ind1--Ind3 branch preserve that
   fingerprint at every fixed label;
3. invoke Theorem 4.1 or 4.2 before taking log-volume.

This would turn an independently verified vector equality into the scalar
order statement.  Defining the packet quotient so that equal scalar volumes
are called equal would not satisfy the faithfulness premise and would be
circular.

## 5. Vector holonomy, including the unit coordinate

Let \(P,Q:L\to\mathbb Q^\times\).  A labelled local vector transport at
\(p\) with exponent shift \(\delta:L\to\mathbb Z\) and unit twist
\(\tau:L\to\mathbb Q\) satisfies

\[
\begin{aligned}
 e_p(Q(i))&=e_p(P(i))+\delta_i,\\
 u_p(Q(i))&=u_p(P(i))\tau_i
 \qquad(i\in L).                                      \tag{5.1}
\end{aligned}
\]

### Lemma 5.1 (the twists are genuine local units)

Whenever (5.1) holds,

\[
 \tau_i\ne0,\qquad v_p(\tau_i)=0\quad(i\in L).          \tag{5.2}
\]

#### Proof

Both unit parts in the second line of (5.1) are nonzero, so \(\tau_i\ne0\).
Taking \(p\)-adic valuations and using Theorem 2.1 gives

\[
 0=v_p(u_p(Q(i)))=v_p(u_p(P(i)))+v_p(\tau_i)
  =v_p(\tau_i).
\]

Thus every twist is itself a \(p\)-adic unit. \(\square\)

### Theorem 5.2 (composition law)

If \(P\to Q\) has data \((\delta,\tau)\) and \(Q\to R\) has data
\((\epsilon,\upsilon)\), then \(P\to R\) has data

\[
 (\delta+\epsilon,\tau\upsilon),                       \tag{5.3}
\]

where both operations are labelwise.

#### Proof

Substitute the first exponent equation into the second and use associativity
of addition.  Substitute the first unit equation into the second and use
associativity of multiplication. \(\square\)

### Theorem 5.3 (pointed vector zero-holonomy)

If a transport (5.1) is closed as a *labelled* loop, so \(Q=P\), then

\[
 \delta_i=0,\qquad \tau_i=1\quad(i\in L).               \tag{5.4}
\]

#### Proof

After substituting \(Q=P\), the exponent equation reads
\(e_p(P(i))=e_p(P(i))+\delta_i\), hence \(\delta_i=0\).
The unit equation reads
\(u_p(P(i))=u_p(P(i))\tau_i\).  Theorem 2.1 says that
\(u_p(P(i))\ne0\), so cancellation gives \(\tau_i=1\). \(\square\)

This result has no rationality restriction on a real scalar coefficient,
because it is proved before applying logarithm.  It also detects unit
holonomy that a valuation or total-product ledger can miss.

## 6. Complete counterexample when the unit coordinate is deleted

Consider the natural weakening of Theorem 3.1 that keeps the prime exponent
and the fixed label but deletes the unit part.

### Proposition 6.1 (labelled exponent-only reconstruction is false)

At \(p=5\), take the one-label packets

\[
 P(*)=1,\qquad Q(*)=2,\qquad w(*)=1.                    \tag{6.1}
\]

Then all of the following hold:

* the unique weight is strictly positive and normalized;
* both packet entries are nonzero;
* \(e_5(P(*))=e_5(Q(*))=0\);
* the label is fixed;
* nevertheless \(P\ne Q\).

#### Proof

Neither \(1\) nor \(2\) is divisible by \(5\), so both 5-adic valuations
are zero.  The weight is one.  Finally \(1\ne2\). \(\square\)

The missing information is exactly visible in (2.1):
\(u_5(1)=1\) and \(u_5(2)=2\).  This is a full counterexample to the stated
exponent-only interface, so that weakened mechanism may be discarded.  It is
not a counterexample to a bridge that retains the unit coordinate.

## 7. A first unit residue is still insufficient

One might try to repair Proposition 6.1 by recording only the reduction of a
unit modulo \(p\).

### Proposition 7.1 (valuation plus residue-unit reconstruction is false)

At \(p=5\), take one-label packets with entries \(1\) and \(6\), and give
their unique label weight \(1\).  The entries satisfy

\[
 v_5(1)=v_5(6)=0,\qquad 1\equiv6\pmod5,\qquad 1\ne6.    \tag{7.1}
\]

Thus the exponent, fixed label, first residue of the unit, and strictly
positive normalized weight do not reconstruct the local input.

#### Proof

Neither integer is divisible by \(5\), so both valuations vanish.  Their
difference is \(5\), giving the congruence, while their inequality is
immediate.  The unique weight is \(1>0\) and its sum is one. \(\square\)

This proposition closes only the one-residue truncation.  Higher compatible
unit data, an inverse limit, or an independently proved faithful unit/coric
object remains active.

## 8. Complete counterexample when labels are forgotten

Now retain each *complete* coordinate but compare only the unordered packet.
Let \(L=\{0,1\}\), again at \(p=5\), and take

\[
 P=(1,2),\qquad Q=(2,1),\qquad w_0=w_1=\frac12.         \tag{8.1}
\]

### Proposition 8.1 (unlabelled exact-coordinate reconstruction is false)

The two packets in (8.1) have the same multiset of complete prime--unit
coordinates, the weights are strictly positive and normalized, and the
coordinate matching is exact after the transposition \(0\leftrightarrow1\).
Nevertheless \(P\ne Q\) as labelled packets.

Moreover, regarding (8.1) as a transport at the fixed labels, its exponent
shifts are \((0,0)\), its unit twists are

\[
 (\tau_0,\tau_1)=(2,1/2),\qquad \tau_0\tau_1=1,         \tag{8.2}
\]

but neither unit twist is one.

#### Proof

Transposition sends the first entry of \(P\) to the equal second entry of
\(Q\), and similarly for the other entry, so the complete coordinates match
after that permutation.  The weights are both \(1/2\).  At the fixed label
\(0\), however, \(P(0)=1\ne2=Q(0)\), so the labelled packets differ.

All four entries are 5-adic units, so the exponent shifts vanish.  The unit
parts equal the entries themselves, giving twists \(2/1=2\) and
\(1/2\); their product is one.  This proves every claim. \(\square\)

Thus even exact local coordinates plus vanishing *aggregate* unit holonomy do
not recover a pointed labelled pilot.  The label-by-label conclusion in
Theorem 5.3 is essential.  This counterexample closes the unlabelled
reconstruction mechanism, not Ind2 or the broad IUT route: an actual Ind2
argument may transport labels through a specified permutation and then undo
that permutation before claiming pointed closure.

## 9. Exact boundary and next IUT obligation

The results separate four statements.

| Statement | Disposition |
|---|---|
| Complete prime--unit coordinates reconstruct rational and actual \(p\)-adic packets; a valuation-free scale-complement coordinate reconstructs an arbitrary field-summand packet | **Proved**, Theorems 2.1--2.3 and Theorem 3.1/Corollary 3.2 |
| A faithful labelled fingerprint transfers any output numerical bound to the same input pilot | **Proved**, Theorem 4.1 |
| Containment of faithful labelled signature images lifts to actual region containment and hence any monotone volume bound | **Proved**, Theorem 4.2 |
| Every vector-transport twist is a local unit, and a closed labelled transport has zero exponent shift and trivial unit twist label-by-label | **Proved**, Lemma 5.1 and Theorem 5.3 |
| Exponents alone, one unit residue, or unordered complete coordinates reconstruct the labelled pilot | **Refuted under every stated hypothesis**, Propositions 6.1, 7.1, and 8.1 |
| The actual IUT multiradial construction preserves a faithful prime--unit--label fingerprint | **Open here** |
| IUT III Corollary 3.12, IUT, or abc | **Neither proved nor refuted; routes remain active** |

The next non-circular IUT step is no longer “compare two volumes somehow.”
It is to define the actual local coordinate functor on the common packet
carrier and prove a globally synchronized, label-aware preservation theorem
through the theta link, log-Kummer correction, determinant power,
normalization, and each allowed Ind1--Ind3 branch.  A quotient of the full
unit/coric data must come with a faithfulness theorem; Proposition 7.1 shows
why a finite residue truncation cannot simply be presumed sufficient.

## 10. Lean formalization and primary sources

All propositions above are formalized, after the paper proofs, in

`Lean/IUTThreeClosures/IUTPrimeUnitLabelVectorBridge20260901.lean`.

The module defines the normalized rational coordinate, proves its unit
valuation and reconstruction identities, proves generic faithful-fingerprint
and labelled-packet bridges, lifts signature-image containment to region
containment and monotone bounds, proves vector-transport composition and
pointed zero holonomy, and checks all three explicit counterexamples.  It
imports no open conjecture and introduces no axiom.

Direct reproduction from the repository root is:

```powershell
Set-Location Lean
lake env lean IUTThreeClosures/IUTPrimeUnitLabelVectorBridge20260901.lean
```

The direct run completed with exit code zero and no warnings.  Thirty
`#print axioms` checks had the combined dependency set
`{propext, Classical.choice, Quot.sound}`; in particular, no `sorryAx`, native
decision axiom, or conjectural theorem appears.

The primary-source ledger is

`research/sources/iut_prime_unit_label_vector_bridge_2026_09_01/`.

It pins the current Project LANA main commit and the exact local copies of its
container and log-volume declarations, together with Mochizuki's unchanged
May 2020 author PDF of IUT III.  The sources justify the problem's type
boundary and terminology; they do not prove the new elementary reconstruction
theorems or the missing IUT preservation theorem.

The source ledger is reproduced with:

```powershell
Set-Location research/sources/iut_prime_unit_label_vector_bridge_2026_09_01
python verify_source_metadata.py
```

It checks four primary files by byte length and SHA-256 and separately freezes
the ledger files in `SHA256SUMS`.
