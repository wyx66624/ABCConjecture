# Packet-level Ind2 and the mono-analytic product hull

**Author:** ChatGPT  
**Status:** mathematical proof completed; Lean formalization is contained in
`ArbitraryInd2ComponentCollapse.lean`,
`SpectrumPreservingInd2Envelope.lean`, and
`SourceFaithfulInd2RadialShadow.lean`; no IUT IV or abc estimate is assumed.

## 1. Why this step attacks the genuine geometric input

The public Corollary 3.12 formalization already expresses the theta right-hand
side as the procession average of product-weighted local component volumes of
the actual holomorphic hull.  Consequently the remaining IUT IV task is not a
scalar rearrangement: one must identify and bound the genuine possible-image
packet before the product-valued hull is taken.

The concrete candidate in `ActualHodgeTheaterOutput.lean` assigns to a theta
label `j` the local region

\[
  U_{C,j}=q^{(\lambda(C_2j))^2+C_3(j)}\mathcal O,
\]

where `C_2` is a candidate permutation of the theta-label type,
`C_3(j)\ge0`, and `\mathcal O` is the normalized integral unit ball.  The full
packet attached to one choice `C` is

\[
  P_C=\prod_j U_{C,j}.
\]

An earlier theorem showed that if a zero label exists and `C_2` is allowed to
be an arbitrary label permutation, then the independent coordinate union
`\bigcup_C U_{C,j}` equals `\mathcal O` at every coordinate.  That theorem did
not yet rule out the possibility that retaining complete packets before taking
the hull preserves useful correlations.  Sections 2--5 resolve exactly that
issue.  Section 6 then compares this candidate with the actual description of
Ind2 in IUT III.

## 2. Complete-packet union

Let

\[
  \mathcal U=\bigcup_C P_C
\]

be the literal union of the complete candidate packets, and let

\[
  \mathcal B=\prod_j\mathcal O
\]

be the unit packet.

Every exponent in a candidate packet is nonnegative.  Since `|q|<1`, every
Tate-power region is contained in `\mathcal O`; hence

\[
  \mathcal U\subseteq\mathcal B. \tag{2.1}
\]

The relevant mono-analytic hulls are rectangular/product regions.  Write

\[
  V=\prod_j V_j.
\]

The following theorem identifies the least such region containing
`\mathcal U`.

## 3. Packet-level collapse theorem

### Theorem 3.1

Assume that the label spectrum contains a label `z_0` with
`\lambda(z_0)=0`, and allow arbitrary permutations of the theta-label set.
Then `\mathcal B` is the least product region containing `\mathcal U`.
Equivalently,

\[
  \mathcal U\subseteq\mathcal B,
  \qquad
  \bigl(\mathcal U\subseteq\prod_jV_j\bigr)
  \Longrightarrow
  \mathcal B\subseteq\prod_jV_j. \tag{3.1}
\]

### Proof

The first inclusion is (2.1).  For minimality, fix a coordinate `j` and any
`x\in\mathcal O`.  Choose a candidate label permutation sending `j` to the
zero label `z_0`, take the trivial norm-one Ind1 unit, and take Ind3 equal to
zero.  At coordinate `j` the resulting exponent is zero, so its output region
is exactly `\mathcal O`.

Define the coordinate spike

\[
  e_{j,x}(k)=
  \begin{cases}
    x,&k=j,\\
    0,&k\ne j.
  \end{cases}
\]

At coordinate `j`, the spike belongs to the zero-power region
`\mathcal O`.  At every other coordinate the spike is zero, and zero belongs
to every Tate-power region.  Therefore one complete candidate packet contains
`e_{j,x}`, so

\[
  e_{j,x}\in\mathcal U. \tag{3.2}
\]

Now suppose `\mathcal U\subseteq\prod_kV_k`.  From (3.2) we obtain
`x=e_{j,x}(j)\in V_j`.  Since `j` and `x\in\mathcal O` were arbitrary,
`\mathcal O\subseteq V_j` for every `j`.  Hence

\[
  \prod_j\mathcal O\subseteq\prod_jV_j,
\]

which proves (3.1).  The proof uses one complete packet for each coordinate
spike; it never replaces a union of products by a product of unions.  ∎

## 4. Consequence for the arbitrary-label-permutation candidate

The public hull interface returns a product-valued hull.  Theorem 3.1 shows
that, for the arbitrary-label-permutation candidate, passing the complete
possible image through such a hull erases every positive q-exponent.  The
result is the unit packet, whose normalized component log-volumes carry no
negative q-radius contribution.

Thus arbitrary permutation of theta labels cannot be the missing
source-faithful IUT III Ind2 operation used in the upper estimate of IUT IV,
Theorem 1.10.  This is a concrete no-go theorem for that submodel, not a
rejection of IUT or of packet-level possible images in general.

## 5. Spectrum-preserving packet theorem

Define a candidate choice to be spectrum preserving when

\[
  \lambda(C_2j)=\lambda(j)
  \quad\text{for every }j. \tag{5.1}
\]

Then its output exponent is

\[
  \lambda(j)^2+C_3(j)\ge\lambda(j)^2,
\]

so every candidate coordinate lies in the native region
`q^{\lambda(j)^2}\mathcal O`.  Let

\[
  \mathcal U_{\mathrm{sp}}
  =\bigcup_{C\text{ satisfying }(5.1)}P_C,
  \qquad
  \mathcal N
  =\prod_j q^{\lambda(j)^2}\mathcal O.
\]

### Theorem 5.1

\[
  \boxed{\mathcal U_{\mathrm{sp}}=\mathcal N.} \tag{5.2}
\]

### Proof

The exponent inequality above gives
`\mathcal U_{\mathrm{sp}}\subseteq\mathcal N`.  Conversely, choose the single
native packet with identity label action and zero Ind3.  It is spectrum
preserving and its coordinate region is exactly
`q^{\lambda(j)^2}\mathcal O` for every `j` simultaneously.  Therefore that
one complete packet is `\mathcal N`, and
`\mathcal N\subseteq\mathcal U_{\mathrm{sp}}`.  ∎

This is a joint packet equality, not a coordinatewise approximation.  It
retains the native q-radii and is compatible with the already formalized
square-label Haar-volume laws.

## 6. What IUT III actually says about Ind2

Theorem 3.11(i) of IUT III does not describe Ind2 as an arbitrary permutation
of the theta labels.  It first takes a product indexed by the rational place
`v_Q` and by a fixed theta label `j`.  For each such fixed pair it then applies
independent copies of the local isomorphism action to the direct summands of
the `j+1` tensor factors.  The text calls this the action of the product of the
copies of `Ism` on the direct summands of those fixed factors.

Thus the authentic Ind2 operation is **fiberwise over a fixed theta label**:
it acts inside the auxiliary summand fiber belonging to `j`; it does not send
`j` to another theta label.  Proposition 1.2(vi) is the local source for this
`Ism` action, and Theorem 3.11(i) is the global possible-image statement.
See `RIMS1758.pdf`, Proposition 1.2(vi) and Theorem 3.11(i), especially the
printed discussion on pp. 23 and 160--161.

This observation removes the need to postulate (5.1) as an extra proposition
at the radial level.  The correct radial shadow is obtained by changing the
type of Ind2 itself.

Let `F_j` be the direct-summand fiber at theta label `j`.  A fiberwise choice
has the form

\[
  C_2=(C_{2,j})_j,
  \qquad C_{2,j}:F_j\simeq F_j. \tag{6.1}
\]

Since (6.1) does not alter the label, the radial exponent is

\[
  e_{C,j}=\lambda(j)^2+C_3(j), \tag{6.2}
\]

and is independent of `C_{2,j}`.  The same proof as in Section 5 now yields a
source-derived result.

### Theorem 6.1 — fiberwise Ind2 radial shadow

Let

\[
  \mathcal U_{\mathrm{fib}}
  =\bigcup_{C_1,(C_{2,j})_j,C_3}
      \prod_j q^{\lambda(j)^2+C_3(j)}\mathcal O,
\]

where `C_1` is norm one, every `C_{2,j}` acts only in `F_j`, and
`C_3(j)\ge0`.  Then

\[
  \boxed{
  \mathcal U_{\mathrm{fib}}
  =\prod_jq^{\lambda(j)^2}\mathcal O.
  } \tag{6.3}
\]

### Proof

By (6.2), every exponent is at least `\lambda(j)^2`, so the left-hand side is
contained in the right-hand side.  Take the identity automorphism on every
fiber, the trivial norm-one Ind1 unit, and zero Ind3.  The resulting single
packet is the complete right-hand side, proving the reverse inclusion.  ∎

`SourceFaithfulInd2RadialShadow.lean` formalizes (6.1)--(6.3) without a
`PreservesLabelNat` field or hypothesis.  The theorem is therefore not another
conditional interface; label preservation follows from the source-faithful
fiberwise type of Ind2.

## 7. What has and has not been closed

The present result closes two authentic ambiguities in the geometric input:

1. retaining complete packets does **not** save the arbitrary-label-
   permutation candidate from collapse;
2. the actual description of Ind2 in IUT III is fiberwise over each fixed
   theta label, and its normalized radial shadow has the exact native packet
   (6.3).

It does not yet prove the global IUT IV component upper bound or
`ABCConjecture`.  The remaining source-level tasks are now narrower and no
longer include an arbitrary label-permutation ambiguity:

1. formalize the direct-summand `Ism` action itself and prove that its
   normalized local absolute value is invariant;
2. identify the complete source-derived possible image, including the actual
   multiradial and mono-analytic structures, with a region whose radial shadow
   is (6.3);
3. transport that packet to the actual final-capsule Haar volume and prove the
   local component upper estimate used by IUT IV, Theorem 1.10.

No target-equivalent structure, external conjecture, or unrestricted bridge is
introduced in this note.
