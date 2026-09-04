# Independent Lean audit of flagged CRT surplus

Date: 2026-09-04  
Audited module: `Lean/IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904.lean`  
Audited snapshot SHA-256:
`CC3A6CA2041EAAA42C455CA8D27B53FF6D2ED3600BCDE5FCB3FF6FB4E15D74A0`

This note is an independent logical audit.  It does not modify the primary
research note or the implementation being audited.  Ordinary proofs of the
new bridge results appear here before their Lean formalization.

## 1. Audit verdict

Every theorem stated in the audited snapshot has the indicated logical
direction, and both the implementation and its axiom-audit file compile with
warnings as errors.  No theorem in the file closes the uniform flagged-CRT
gate or the standard `ABCConjecture` unconditionally.

The distinctions below are essential.

1. `exists_maximalFeasibleSourceSubset` is valid without a source-weight
   nonnegativity hypothesis: inclusion maximality alone says that every
   omitted singleton would exceed the remaining budget.  Its use in the
   intended endpoint model still specializes to positive logarithmic weights.
   `freeTarget_residualMass_eq_scalar` is exactly the stated ring identity;
   these two lemmas formalize only the selection and cancellation steps, not
   the complete free-target collapse theorem.
2. `sum_ownedMass_le_total` is a sound once-charge lemma.  An `Option`-valued
   owner assigns each token to zero or one target.  Nonnegative token weights
   then imply that the sum received by all targets is at most the sum of all
   token weights.  Many different tokens may meet at one target without
   duplicating any token.
3. `OwnedFlaggedConfiguration.sourceMass_sub_sinkMass_le_boundary` is a sound
   consequence of that owner lemma and the per-block surplus cap.  Overflow
   credit is removed by `max (sourceWeight-credit) 0`, so it cannot be reused
   a second time.
4. `FlaggedSurplusCertificate.sourceMass_sub_sinkMass_le_boundary` is also
   sound, but `totalSourceCredit_le` is a field of this aggregate certificate.
   The audited module did not construct this field from an owner map.  Section
   2 below supplies that missing conversion without strengthening the owner
   hypotheses.
5. `ProperSubfaceFlag` is not connected to `OwnedFlaggedConfiguration` in the
   audited module.  In particular, an owner configuration stores neither the
   block source set nor a proof that the reuse target is outside that source
   set, and its `witnessWeight` is not proved to be the sum of the weights in a
   `ProperSubfaceFlag.witness`.  Therefore the owner structure is an accounting
   kernel, not yet a concrete arithmetic FCRT configuration.
6. Several fields are intentionally stronger than the algebraic proof needs
   or are redundant at the kernel level.  The witness cap is not used in the
   mass bridge; it restricts arithmetic admissibility.  Moreover
   `reuseCredit_nonneg` together with `reuse_le_surplus` already implies
   `block_saturated`.  These redundancies do not make the proved inequality
   false, but they must not be mistaken for a construction of a legal flag.
7. `EndpointFlaggedCertificate.defect_le_boundary` is an explicit premise,
   while `UniformAdmissibleFlaggedCRTBoundary` is an uninhabited conditional
   gate.  Thus `abc_of_uniformAdmissibleFlaggedCRTBoundary` has no hidden proof
   of `ABCConjecture` and no logical cycle.  The missing arithmetic work is to
   identify the endpoint defect with the source-minus-sink mass of an actual
   disjoint configuration.  Section 3 exposes precisely this premise.  The
   endpoint structure is deliberately thin and could be manufactured from any
   already-known defect upper bound; it acquires new arithmetic content only
   after a concrete `Admissible` predicate and this decomposition are proved.
8. The additive residue-cube identities are correct for every additive
   commutative group, a mild generalization of the intended finite abelian
   setting.  They prove complement and same-fibre exchange identities only.
   They do not formalize the multiplicative residue-unit construction, the
   inverse system in the source face, the Boolean collision count, or any
   weighted/Fourier estimate.
9. The integer and logarithmic statements for the three witnesses are true.
   The Lean statements check their factorizations, singleton/full-face
   congruences, cap comparisons, and selected boundary inequalities.  They do
   not themselves formalize exhaustive optimality of the finite FCRT, SCRT,
   or PBT programs.

No exact route is refuted by this audit.  The unformalized arithmetic links
remain open obligations rather than reasons to abandon FCRT or SCRT.

## 2. Owner configuration to aggregate certificate

Let an owner configuration have residual source demand \(x_i\), raw incoming
credit \(c_i\), and clipped residual

\[
 R_i=\max\{x_i-c_i,0\}.
\]

Define the capped aggregate credit

\[
                         \widehat c_i=\min\{x_i,c_i\}.
\]

### Proposition 2.1 (nonnegative raw credit)

For every source \(i\), \(c_i\ge 0\).

### Proof

Every summand owned by \(i\) is either zero or the nonnegative weight of one
residual sink.  The same statement holds for every reuse token.  Both finite
sums are nonnegative, hence so is their sum \(c_i\).  QED.

### Proposition 2.2 (capped-credit identity)

For all real \(x,c\),

\[
                 x-\min\{x,c\}=\max\{x-c,0\}.          \tag{2.1}
\]

### Proof

If \(c\le x\), the two sides are both \(x-c\).  If \(x\le c\), the two sides
are both zero.  QED.

### Theorem 2.3 (canonical aggregate certificate)

Every `OwnedFlaggedConfiguration` canonically determines a
`FlaggedSurplusCertificate` by retaining all weights and reuse credits and
using \(\widehat c_i\) as its aggregate source credit.  The aggregate boundary
is exactly the original clipped boundary.

### Proof

Source demand and raw credit are nonnegative, so
\(0\le\widehat c_i\le x_i\).  Also \(\widehat c_i\le c_i\); summing and then
using the once-owner estimate gives

\[
 \sum_i\widehat c_i
 \le \sum_i c_i
 \le \sum_{j\in J_0}y_j+\sum_\nu\rho_\nu.
\]

All block, witness, saturation, and reuse-cap fields are inherited verbatim.
These facts provide every field of `FlaggedSurplusCertificate`.  Finally,
(2.1), summed over the residual sources, identifies its boundary with the
owner boundary.  QED.

This conversion is information-preserving at the boundary even when several
tokens overfill a source: only the unusable overflow is removed.

## 3. Explicit endpoint connection

Before connecting the accounting model, one must observe that the bare
endpoint structure is always inhabited.

### Proposition 3.1 (tautological endpoint certificate)

For every `ABCPoint` \(P\), setting

\[
 D=\operatorname{signedEndpointCoreDefect}(P),\qquad
 B=\max\{D,0\}
\]

gives an `EndpointFlaggedCertificate P`.

### Proof

By definition, \(B\ge0\) and \(D\le B\).  These are exactly the two proof
fields.  QED.

Consequently, mere existence of an endpoint certificate carries no FCRT
content.  The uniform small-boundary estimate and a concrete admissibility
proof are the substantive requirements.

Let \(C\) be an aggregate certificate for an `ABCPoint` \(P\).  The honest
endpoint premise is

\[
 \operatorname{signedEndpointCoreDefect}(P)
     = C.\operatorname{sourceMass}-C.\operatorname{sinkMass}.       \tag{3.1}
\]

### Theorem 3.2 (aggregate-to-endpoint bridge)

Under (3.1), \(C\) constructs an `EndpointFlaggedCertificate P` with boundary
exactly `C.boundary`.

### Proof

The aggregate boundary is nonnegative.  Its mass bridge and (3.1) give

\[
 \operatorname{signedEndpointCoreDefect}(P)
 =C.\operatorname{sourceMass}-C.\operatorname{sinkMass}
 \le C.\operatorname{boundary}.
\]

These are exactly the two proof fields of the endpoint certificate.  QED.

Combining Theorems 2.3 and 3.2 gives the same construction directly from an
owner configuration.  Its endpoint boundary is propositionally equal to the
original clipped boundary.  The equality (3.1), rather than the elementary
once-charge algebra, is the remaining endpoint decomposition obligation.

## 4. Independent check of the finite witnesses

For \((1,675,676)\), the full block with source \(13\) has surplus factor
\(15/13\), and the proper face \(\{3\}\) certifies residual source \(2\)
because \(4\mid 28\).  Since \(15/13<3\), the surplus cap binds and the
remaining factor is \(2/(15/13)=26/15\), the scalar defect.

For \((1,224,225)\), neither \(33=1+2^5\) nor \(8=1+7\) is divisible by
\(9\) or \(25\), so no full-block surplus has a proper-face flag.  The best
exclusive assignment has boundary factor \(3/2>15/14\).

For \((1,65024,65025)\),

\[
65024=2^9\cdot127,\qquad65025=3^2\cdot5^2\cdot17^2.
\]

The face \(\{2\}\) gives \(513\), divisible by \(9\) and by neither \(25\)
nor \(289\); the face \(\{127\}\) gives \(128\), divisible by none of them.
The full sink block can close source factor \(5\cdot17=85\).  Its surplus
factor \(254/85\) exceeds the witness factor \(2\), so the face cap binds and
leaves boundary factor \(3/2\).  Direct enumeration gives SCRT factor \(3\)
and PBT factor \(15/2\).  Hence

\[
             \frac{255}{254}<\frac32<3<\frac{15}{2}.
\]

The audited Lean file proves the arithmetic facts and this strict chain, but
the statements do not encode the direct enumeration just described.

## 5. Theorem-by-theorem direction inventory

The following inventory covers all 50 `theorem` declarations in the audited
snapshot.  “Valid” means that the proposition has the stated direction and
does not use the desired uniform FCRT or `ABCConjecture` conclusion as a
premise.

| Theorem(s) | Direction audit |
|---|---|
| `exists_maximalFeasibleSourceSubset` | Valid finite maximality consequence; it does not by itself construct a CRT block. |
| `freeTarget_residualMass_eq_scalar` | Valid equality after assuming the displayed definition of surplus. |
| `ProperSubfaceFlag.witness_ssubset` | Valid conversion of subset plus inequality into strict subset. |
| `sum_ownedMass_le_total` | Valid once-charge inequality; nonnegative weights are necessary and present. |
| `sourceWeight_le_credit_add_clippedResidual` | Valid for arbitrary real demand and credit. |
| `OwnedFlaggedConfiguration.totalSourceCredit_le_sink_add_reuse` | Valid sum of the two owner inequalities. |
| `OwnedFlaggedConfiguration.totalReuse_le_totalSurplus` | Valid pointwise-to-sum implication. |
| `OwnedFlaggedConfiguration.sourceMass_sub_sinkMass_le_boundary` | Valid; combines coverage, once-charge, and surplus exactly in the required direction. |
| `FlaggedSurplusCertificate.boundary_nonneg` | Valid from `sourceCredit_le`; the nonnegative-credit field is not needed for this lemma. |
| `FlaggedSurplusCertificate.totalReuse_le_totalSurplus` | Valid pointwise-to-sum implication. |
| `FlaggedSurplusCertificate.totalReuse_le_totalWitness` | Valid pointwise-to-sum implication; not used in the mass bridge. |
| `FlaggedSurplusCertificate.sourceMass_sub_sinkMass_le_boundary` | Valid, conditional on its stored aggregate-credit inequality. |
| `height_le_conductor_add_flaggedBoundary` | Valid rewrite of endpoint defect followed by the stored defect bound. |
| `abc_of_uniformAdmissibleFlaggedCRTBoundary` | Valid conditional implication; its uniform gate is an explicit, unproved argument. |
| `packetLabel_add_compl` | Valid disjoint-union identity. |
| `compatible_iff_compl_zero` | Valid in both directions under the stated full-label equality. |
| `packetLabel_inter_add_sdiff` | Valid disjoint decomposition of one packet. |
| `packetLabel_sdiff_eq_of_eq` | Valid cancellation of the common intersection. |
| `compatiblePacket_sdiff_eq` | Valid specialization to two members of the same fibre. |
| All ten `witness675_*` theorems | Each stated natural-number or logarithmic fact is valid; exact optimization is external to their types. |
| All nine `witness224_*` theorems | Each stated natural-number or logarithmic fact is valid; noncollapse optimality is external to their types. |
| All twelve `witness65025_*` theorems | Each stated factorization, congruence, cap inequality, and strict boundary-level inequality is valid; exhaustive optimization is external to their types. |

Lean's dependency report for these declarations contains only `propext`,
`Classical.choice`, and `Quot.sound`.  This rules out hidden postulates inside
their proof terms.  It does not turn a structure field such as
`defect_le_boundary` or `totalSourceCredit_le` into a proved arithmetic fact;
the audit above keeps those hypotheses visible.

## 6. Reproducible validation

From the `Lean` directory:

```text
lake env lean -DwarningAsError=true IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904.lean
lake env lean -DwarningAsError=true IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904AxiomAudit.lean
lake env lean -DwarningAsError=true IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904IndependentBridge.lean
lake build IUTThreeClosures.ABCFlaggedCRTSurplusResidueCube20260904IndependentBridge
lake env lean -DwarningAsError=true IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904IndependentBridgeAxiomAudit.lean
```

At this snapshot, the primary module has 70 public declarations and 70 axiom
queries.  The independent bridge has 18 public declarations and 18 axiom
queries.  The bridge axiom union is exactly `propext`, `Classical.choice`, and
`Quot.sound`; no `sorry`, `admit`, `unsafe`, or `native_decide` occurs.
