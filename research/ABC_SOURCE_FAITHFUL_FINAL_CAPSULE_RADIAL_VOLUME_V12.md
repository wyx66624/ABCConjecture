# Source-faithful Ind2 radial packets on the actual final capsule

**Author:** ChatGPT  
**Status:** mathematical proof and Lean formalization completed; this note does
not assert the IUT IV component upper bound or the abc conjecture.

## 1. Source-level correction to the Ind2 model

IUT III, Theorem 3.11(i), forms its possible-image packet as a product over a
rational place and a fixed theta label `j`.  Indeterminacy (Ind2) then acts by
independent copies of the local `Ism` action on the direct summands of the
`j+1` tensor factors.  The action is therefore fiberwise over a fixed theta
label; it is not a permutation of the theta-label set.

At the normalized radial level, a fiberwise Ind2 action leaves the theta label
`j` unchanged.  The radial exponent has the form

\[
  e_{C,j}=j^2+n_{C,j},\qquad n_{C,j}\ge0.       \tag{1.1}
\]

A norm-one Ind1 factor does not change the principal radius, and Ind3 only
increases `n_{C,j}`.

## 2. Dependent local-field packet

Let `D` be the actual `FinalCapsule` already constructed in the repository.
Its label type is

\[
  \operatorname{Label}(D)
  =\{(i,v_{\mathbb Q},w,j)\},
\]

and every label carries its own completed local field `D.field(label)`, Tate
parameter `D.qParam(label)`, and integer theta label
`D.labelInteger(label)`.

For an arbitrary family of summand fibers `F_label`, define a fiberwise choice
by

\[
  C_1(label)\in \mathcal O_{D.field(label)}^\times,
  \qquad |C_1(label)|=1,
\]

\[
  C_2(label):F_{label}\simeq F_{label},
  \qquad C_3(label)\in\mathbb N.
\]

Its local radial region is

\[
  U_{C,label}
  =q_{label}^{\,D.labelInteger(label)^2+C_3(label)}
     \mathcal O_{label}.                         \tag{2.1}
\]

The complete packet is the dependent product

\[
  P_C=\prod_{label}U_{C,label}.                 \tag{2.2}
\]

## 3. Exact packet-union theorem

### Theorem 3.1

Let

\[
  \mathcal U_D=\bigcup_C P_C.
\]

Then

\[
  \boxed{
  \mathcal U_D
  =\prod_{label}
      q_{label}^{\,D.labelInteger(label)^2}
      \mathcal O_{label}
  =D.finalCapsuleProductRegion.
  }                                               \tag{3.1}
\]

### Proof

For every choice and every label, (1.1) gives

\[
  D.labelInteger(label)^2
  \le e_{C,label}.
\]

Since every Tate parameter has norm strictly below one, increasing the exponent
shrinks the principal region.  Hence

\[
  U_{C,label}
  \subseteq
  q_{label}^{D.labelInteger(label)^2}\mathcal O_{label},
\]

and therefore every `P_C` is contained in the right-hand side of (3.1).

For the reverse inclusion, take the trivial norm-one Ind1 unit, the identity
map on every summand fiber, and zero Ind3 at every label.  This single choice
has exponent exactly `D.labelInteger(label)^2` simultaneously at all labels,
so its complete packet is the right-hand side of (3.1).  ∎

This is a literal complete-packet equality.  No interchange of a union and a
product is used.

## 4. Exact actual Haar-volume theorem

The repository already constructs, from every actual bad-place datum, the
normalized additive Haar log-volume

\[
  \operatorname{HaarLog}_{label}(U)
  =\log\mu_{label}(U),
\]

with `\mu_{label}(\mathcal O_{label})=1`.  For every natural exponent `n`, it
proves

\[
  \operatorname{HaarLog}_{label}
     (q_{label}^n\mathcal O_{label})
  =n\,\operatorname{signedHaarLog}(label).       \tag{4.1}
\]

Define the actual Haar log-volume of the native packet by the genuine finite
sum

\[
  \operatorname{Vol}_{\mathrm{native}}(D)
  =\sum_{label}
    \operatorname{HaarLog}_{label}
      \left(
       q_{label}^{D.labelInteger(label)^2}
       \mathcal O_{label}
      \right).                                   \tag{4.2}
\]

### Theorem 4.1

\[
  \boxed{
  \operatorname{Vol}_{\mathrm{native}}(D)
  =\sum_{label}
      D.labelInteger(label)^2\,
      D.signedHaarLogSum(label)
  =\operatorname{processionLogSum}(D).
  }                                               \tag{4.3}
\]

### Proof

Apply (4.1) to every summand of (4.2), with
`n=D.labelInteger(label)^2`.  The repository's local-to-final-capsule
identification says that the local signed Haar logarithm is exactly
`D.signedHaarLogSum(label)`.  Summing gives (4.3) by the definition of
`processionLogSum`.  ∎

Combining Theorems 3.1 and 4.1 connects the source-faithful radial possible
image to the actual final-capsule region and to its genuine normalized Haar
arithmetic.  No freely supplied component-volume functional is used.

## 5. Lean ledger

`IUTThreeClosures/SourceFaithfulFinalCapsuleRadialVolume.lean` proves:

1. `fiberwiseOutputRegion_eq_qPowerRegion`;
2. `fiberwiseOutputRegion_subset_native`;
3. `fiberwisePacketRegion_subset_finalCapsuleProductRegion`;
4. `ordinaryFiberwisePacketRegion`;
5. `fiberwisePacketChoiceUnion_eq_finalCapsuleProductRegion`;
6. `actualNativePacketHaarLogVolume_eq_processionLogSum`.

The module contains no `axiom`, `sorry`, or `admit`.  It was also checked
locally against the repository's pinned Lean 4.32.0 dependency graph before
submission to CI.

## 6. Remaining geometric input after this result

The radial packet and its actual Haar volume are now explicit.  What remains
is no longer a label-permutation or local-volume ambiguity.  The unresolved
step is to prove that the **full** source-derived IUT III possible image,
including its non-radial tensor/log-shell structure and the actual
mono-analytic holomorphic hull, admits the component upper estimate required
in IUT IV, Theorem 1.10.

Concretely, one must show that the non-radial Ind1/Ind2/Ind3 operations do not
force a larger hull-volume contribution than the arithmetic main and error
terms in the public Theorem 1.10 formula.  That is the next theorem-level
research target; it is not inserted here as a hypothesis or interface.
