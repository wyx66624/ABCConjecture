# Packet-level Ind2 and the mono-analytic product hull

**Author:** ChatGPT  
**Status:** mathematical proof completed; Lean formalization is contained in
`ArbitraryInd2ComponentCollapse.lean` and
`SpectrumPreservingInd2Envelope.lean`; no IUT IV or abc estimate is assumed.

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

where `C_2` is the candidate Ind2 permutation, `C_3(j)\ge0`, and
`\mathcal O` is the normalized integral unit ball.  The full packet attached
to one choice `C` is

\[
  P_C=\prod_j U_{C,j}.
\]

An earlier theorem showed that if a zero label exists and Ind2 is allowed to
be an arbitrary permutation, then the independent coordinate union
`\bigcup_C U_{C,j}` equals `\mathcal O` at every coordinate.  That theorem did
not yet rule out the possibility that retaining complete packets before taking
the hull preserves useful correlations.  The present theorem resolves exactly
that issue.

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

Every exponent in a candidate packet is nonnegative.  Since
`|q|<1`, every Tate-power region is contained in `\mathcal O`; hence

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
`\lambda(z_0)=0`, and allow arbitrary Ind2 permutations.  Then
`\mathcal B` is the least product region containing `\mathcal U`.
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
`x\in\mathcal O`.  Choose an Ind2 permutation sending `j` to the zero label
`z_0`, take the trivial Ind1 unit, and take Ind3 equal to zero.  At coordinate
`j` the resulting exponent is zero, so its output region is exactly
`\mathcal O`.

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
to every Tate-power region.  Therefore one genuine complete packet contains
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

which proves (3.1).  Notice that the proof uses one complete packet for each
coordinate spike; it never replaces a union of products by a product of
unions.  ∎

## 4. Consequence for the arbitrary-Ind2 candidate

The public hull interface returns a product-valued hull.  Theorem 3.1 shows
that, for the arbitrary-permutation candidate, passing the complete possible
image through such a hull erases every positive q-exponent.  The result is the
unit packet, whose normalized component log-volumes carry no negative
q-radius contribution.

Thus the arbitrary-permutation candidate cannot be the missing source-faithful
IUT III possible image used in the upper estimate of IUT IV, Theorem 1.10.
This is a concrete no-go theorem for that submodel, not a rejection of IUT or
of packet-level possible images in general.

## 5. Spectrum-preserving alternative

Define a choice to be spectrum preserving when

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
native packet with identity Ind2 and zero Ind3.  It is spectrum preserving and
its coordinate region is exactly `q^{\lambda(j)^2}\mathcal O` for every
`j` simultaneously.  Therefore that one complete packet is `\mathcal N`, and
`\mathcal N\subseteq\mathcal U_{\mathrm{sp}}`.  ∎

Again, (5.2) is a joint packet equality, not a coordinatewise approximation.
It retains the native q-radii and is therefore compatible with the already
formalized square-label Haar-volume laws.

## 6. What has and has not been closed

This result closes one authentic ambiguity in the geometric interface:
retaining complete packets does **not** save the arbitrary-Ind2 candidate from
collapse.  It also proves an exact non-collapsing packet formula under the
spectrum-preserving replacement.

It does not yet prove the global IUT IV component upper bound or
`ABCConjecture`.  The next genuine source-level question is now sharper:

1. identify the actual IUT Ind2 operation on the source-derived theta packet;
2. prove from the native anabelian/tempered construction that it preserves the
   relevant radius or label spectrum, or replace (5.1) by the exact invariant
   it really preserves;
3. transport the resulting packet equality to the actual final-capsule Haar
   volume and then to the public theta-hull component estimate.

No target-equivalent structure, external conjecture, or unrestricted bridge is
introduced in this note.
