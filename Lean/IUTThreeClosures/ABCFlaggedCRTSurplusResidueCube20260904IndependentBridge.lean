/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCFlaggedCRTSurplusResidueCube20260904

/-!
# Independent bridge audit for flagged CRT surplus

The ordinary proofs precede this file in
`research/ABC_FLAGGED_CRT_LEAN_INDEPENDENT_AUDIT_2026_09_04.md`.

This module fills two purely logical links without changing the audited
implementation.

* Every explicit owner configuration canonically yields an aggregate
  `FlaggedSurplusCertificate`; capping overfilled source credits preserves its
  clipped boundary exactly.
* An aggregate or owner certificate yields an endpoint certificate once the
  endpoint defect is explicitly identified with its source-minus-sink mass.

The latter equality is an argument, not an axiom or a field manufactured by
this module.  No arithmetic admissibility or uniform FCRT estimate is proved.
-/

namespace IUTThreeClosures

open scoped BigOperators

noncomputable section

namespace ABCFlaggedCRTSurplusResidueCube20260904IndependentBridge

open ABCFlaggedCRTSurplusResidueCube20260904
open ABCSharedCRTIncidenceSuccessor20260903
open ABCPrimePacketBoundaryTransportSuccessor20260903
open SignedEndpointPrimeTokenTransport

variable {Token Target : Type*}

/-- The mass arriving at one target through an `Option` owner map is
nonnegative when every token weight is nonnegative. -/
theorem ownedMass_nonneg
    [Fintype Token] [DecidableEq Target]
    (owner : Token → Option Target) (weight : Token → Real)
    (hweight : ∀ q, 0 ≤ weight q) (i : Target) :
    0 ≤ ownedMass owner weight i := by
  unfold ownedMass
  apply Finset.sum_nonneg
  intro q _hq
  by_cases howner : owner q = some i
  · simp [howner, hweight q]
  · simp [howner]

/-- Removing credit above the demand converts subtraction into the clipped
residual used by the explicit owner model. -/
theorem sub_min_eq_clippedResidual (sourceWeight credit : Real) :
    sourceWeight - min sourceWeight credit =
      clippedResidual sourceWeight credit := by
  unfold clippedResidual
  by_cases hcredit : credit ≤ sourceWeight
  · rw [min_eq_right hcredit, max_eq_left (sub_nonneg.mpr hcredit)]
  · have hsource : sourceWeight ≤ credit := le_of_not_ge hcredit
    rw [min_eq_left hsource, sub_self,
      max_eq_right (sub_nonpos.mpr hsource)]

/-- The bare endpoint certificate is always inhabited by clipping the defect
at zero.  Arithmetic content therefore comes from admissibility and a small
boundary estimate, not from mere inhabitation of this structure. -/
def tautologicalEndpointCertificate (P : ABCPoint) :
    EndpointFlaggedCertificate P where
  boundary := max (signedEndpointCoreDefect P) 0
  boundary_nonneg := le_max_right _ _
  defect_le_boundary := le_max_left _ _

variable {α β γ : Type*}
variable [Fintype α] [Fintype β] [Fintype γ] [DecidableEq α]

/-- Raw source credit in an owner configuration is nonnegative. -/
theorem ownedSourceCredit_nonneg
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ))
    (i : α) :
    0 ≤ C.sourceCredit i := by
  unfold OwnedFlaggedConfiguration.sourceCredit
  exact add_nonneg
    (ownedMass_nonneg C.sinkOwner C.sinkWeight C.sinkWeight_nonneg i)
    (ownedMass_nonneg C.reuseOwner C.reuseCredit C.reuseCredit_nonneg i)

/-- Effective aggregate credit after discarding any part that overfills its
target source. -/
def cappedSourceCredit
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ))
    (i : α) : Real :=
  min (C.sourceWeight i) (C.sourceCredit i)

/-- Capped credit remains nonnegative. -/
theorem cappedSourceCredit_nonneg
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ))
    (i : α) :
    0 ≤ cappedSourceCredit C i := by
  apply le_min
  · exact C.sourceWeight_nonneg i
  · exact ownedSourceCredit_nonneg C i

/-- Capped credit never exceeds its source demand. -/
theorem cappedSourceCredit_le_sourceWeight
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ))
    (i : α) :
    cappedSourceCredit C i ≤ C.sourceWeight i :=
  min_le_left _ _

/-- Capping can only decrease the raw incoming credit. -/
theorem cappedSourceCredit_le_sourceCredit
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ))
    (i : α) :
    cappedSourceCredit C i ≤ C.sourceCredit i :=
  min_le_right _ _

/-- Canonical conversion from the explicit one-owner model to the aggregate
certificate.  Every accounting field is inherited; only overfilled source
credit is capped at the source demand. -/
def toFlaggedSurplusCertificate
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ)) :
    FlaggedSurplusCertificate (α := α) (β := β) (γ := γ) where
  sourceWeight := C.sourceWeight
  sinkWeight := C.sinkWeight
  blockSourceWeight := C.blockSourceWeight
  blockSinkWeight := C.blockSinkWeight
  witnessWeight := C.witnessWeight
  sourceCredit := cappedSourceCredit C
  reuseCredit := C.reuseCredit
  sourceCredit_nonneg := cappedSourceCredit_nonneg C
  sourceCredit_le := cappedSourceCredit_le_sourceWeight C
  blockSource_nonneg := C.blockSource_nonneg
  blockSink_nonneg := C.blockSink_nonneg
  witnessWeight_nonneg := C.witnessWeight_nonneg
  reuseCredit_nonneg := C.reuseCredit_nonneg
  block_saturated := C.block_saturated
  reuse_le_surplus := C.reuse_le_surplus
  reuse_le_witness := C.reuse_le_witness
  totalSourceCredit_le := by
    calc
      (∑ i, cappedSourceCredit C i) ≤ ∑ i, C.sourceCredit i :=
        Finset.sum_le_sum fun i _hi => cappedSourceCredit_le_sourceCredit C i
      _ ≤ (∑ j, C.sinkWeight j) + ∑ k, C.reuseCredit k :=
        C.totalSourceCredit_le_sink_add_reuse

/-- The conversion does not change total source mass. -/
theorem toFlaggedSurplusCertificate_sourceMass
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ)) :
    (toFlaggedSurplusCertificate C).sourceMass = C.sourceMass := by
  rfl

/-- The conversion does not change total sink mass. -/
theorem toFlaggedSurplusCertificate_sinkMass
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ)) :
    (toFlaggedSurplusCertificate C).sinkMass = C.sinkMass := by
  rfl

/-- Capping overfilled credits preserves the clipped owner boundary exactly. -/
theorem toFlaggedSurplusCertificate_boundary
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ)) :
    (toFlaggedSurplusCertificate C).boundary = C.boundary := by
  unfold FlaggedSurplusCertificate.boundary
    OwnedFlaggedConfiguration.boundary OwnedFlaggedConfiguration.residual
    toFlaggedSurplusCertificate cappedSourceCredit
  apply Finset.sum_congr rfl
  intro i _hi
  exact sub_min_eq_clippedResidual _ _

/-- The owner-level mass bridge is recovered through the canonical aggregate
certificate, with no assumed aggregate-credit field. -/
theorem owner_massBridge_via_aggregate
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ)) :
    C.sourceMass - C.sinkMass ≤ C.boundary := by
  have h :=
    (toFlaggedSurplusCertificate C).sourceMass_sub_sinkMass_le_boundary
  simpa only [toFlaggedSurplusCertificate_sourceMass,
    toFlaggedSurplusCertificate_sinkMass,
    toFlaggedSurplusCertificate_boundary] using h

/-- An aggregate accounting certificate becomes an endpoint certificate once
the endpoint source-minus-sink decomposition is supplied explicitly. -/
def endpointCertificateOfAggregate
    (P : ABCPoint)
    (C : FlaggedSurplusCertificate (α := α) (β := β) (γ := γ))
    (hdecomposition :
      signedEndpointCoreDefect P = C.sourceMass - C.sinkMass) :
    EndpointFlaggedCertificate P where
  boundary := C.boundary
  boundary_nonneg := C.boundary_nonneg
  defect_le_boundary := by
    rw [hdecomposition]
    exact C.sourceMass_sub_sinkMass_le_boundary

omit [DecidableEq α] in
/-- The endpoint boundary produced from an aggregate certificate is exactly
its accounting boundary. -/
theorem endpointCertificateOfAggregate_boundary
    (P : ABCPoint)
    (C : FlaggedSurplusCertificate (α := α) (β := β) (γ := γ))
    (hdecomposition :
      signedEndpointCoreDefect P = C.sourceMass - C.sinkMass) :
    (endpointCertificateOfAggregate P C hdecomposition).boundary = C.boundary := by
  rfl

/-- Owner-level endpoint constructor obtained by composing the canonical
aggregate conversion with the explicit endpoint decomposition. -/
def endpointCertificateOfOwned
    (P : ABCPoint)
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ))
    (hdecomposition :
      signedEndpointCoreDefect P = C.sourceMass - C.sinkMass) :
    EndpointFlaggedCertificate P :=
  endpointCertificateOfAggregate P (toFlaggedSurplusCertificate C) (by
    simpa only [toFlaggedSurplusCertificate_sourceMass,
      toFlaggedSurplusCertificate_sinkMass] using hdecomposition)

/-- The owner-to-endpoint construction preserves the original clipped
boundary propositionally. -/
theorem endpointCertificateOfOwned_boundary
    (P : ABCPoint)
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ))
    (hdecomposition :
      signedEndpointCoreDefect P = C.sourceMass - C.sinkMass) :
    (endpointCertificateOfOwned P C hdecomposition).boundary = C.boundary := by
  change (toFlaggedSurplusCertificate C).boundary = C.boundary
  exact toFlaggedSurplusCertificate_boundary C

/-- The existing pointwise height theorem is therefore available from an
owner configuration once, and only once, its endpoint decomposition is
proved. -/
theorem height_le_conductor_add_ownedBoundary
    (P : ABCPoint)
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ))
    (hdecomposition :
      signedEndpointCoreDefect P = C.sourceMass - C.sinkMass) :
    P.height ≤ P.conductor + C.boundary := by
  have hheight := height_le_conductor_add_flaggedBoundary P
    (endpointCertificateOfOwned P C hdecomposition)
  simpa only [endpointCertificateOfOwned_boundary] using hheight

end ABCFlaggedCRTSurplusResidueCube20260904IndependentBridge
end
end IUTThreeClosures
