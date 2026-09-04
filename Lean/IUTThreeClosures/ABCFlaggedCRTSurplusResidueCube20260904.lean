/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCSharedCRTIncidenceSuccessor20260903

/-!
# Proper-subface flagged CRT surplus and endpoint residue cubes

The ordinary definitions and proofs precede this module in
`research/ABC_ENDPOINT_RESIDUE_CUBE_FLAGGED_CRT_2026_09_04.md`.

This file formalizes three unconditional kernels from that note.

* `FlaggedSurplusCertificate` records residual source credits, saturated block
  masses, one-hop reuse credits bounded by both the block surplus and a
  witness-face mass, and a once-charged residual-sink inequality.  Its boundary
  satisfies the exact source-minus-sink mass bridge.
* `EndpointFlaggedCertificate` packages the resulting endpoint defect bound.
  A separately supplied uniform arithmetic admissibility gate implies the
  unchanged `ABCConjecture`; no such gate is assumed here.
* `packetLabel` is the additive finite-abelian-group form of the endpoint
  residue cube.  Complement fibres and signed exchanges of two compatible
  packets are proved.

The exact integer congruence data and logarithmic comparisons for the
primitive witnesses `(1,675,676)`, `(1,224,225)`, and
`(1,65024,65025)` are also checked.  The arithmetic construction of all
residue-unit coordinates, the Fourier estimate, and the uniform FCRT-1 bound
remain explicit open obligations.
-/

namespace IUTThreeClosures

open scoped BigOperators

noncomputable section

namespace ABCFlaggedCRTSurplusResidueCube20260904

open ABCSharedCRTIncidenceSuccessor20260903
open ABCPrimePacketBoundaryTransportSuccessor20260903
open SignedEndpointPrimeTokenTransport

/-! ## Maximal feasible source subsets for the free-target guard rail -/

variable {δ : Type*}

/-- Source subsets whose total weight fits inside a scalar sink budget. -/
def feasibleSourceSubsets
    [Fintype δ] [DecidableEq δ]
    (sourceWeight : δ → Real) (sinkBudget : Real) : Finset (Finset δ) :=
  (Finset.univ.powerset).filter fun S => S.sum sourceWeight ≤ sinkBudget

/-- A finite nonnegative sink budget admits an inclusion-maximal feasible
source subset.  Every omitted source is strictly heavier than the remaining
budget.  This is the finite selection step in the ordinary proof that
free-target block surplus collapses to scalar pooling. -/
theorem exists_maximalFeasibleSourceSubset
    [Finite δ]
    (sourceWeight : δ → Real) (sinkBudget : Real)
    (hsink : 0 ≤ sinkBudget) :
    ∃ S : Finset δ,
      S.sum sourceWeight ≤ sinkBudget ∧
      ∀ p, p ∉ S → sinkBudget - S.sum sourceWeight < sourceWeight p := by
  classical
  letI := Fintype.ofFinite δ
  have hempty : ∅ ∈ feasibleSourceSubsets sourceWeight sinkBudget := by
    simp [feasibleSourceSubsets, hsink]
  obtain ⟨S, hS⟩ :=
    (feasibleSourceSubsets sourceWeight sinkBudget).exists_maximal
      ⟨∅, hempty⟩
  refine ⟨S, ?_, ?_⟩
  · exact (Finset.mem_filter.mp hS.1).2
  · intro p hp
    by_contra hnot
    have hpWeight : sourceWeight p ≤ sinkBudget - S.sum sourceWeight :=
      le_of_not_gt hnot
    have hsumInsert : (insert p S).sum sourceWeight ≤ sinkBudget := by
      rw [Finset.sum_insert hp]
      linarith
    have hSuniv : S ⊆ (Finset.univ : Finset δ) :=
      Finset.mem_powerset.mp (Finset.mem_filter.mp hS.1).1
    have hinsertUniv : insert p S ⊆ (Finset.univ : Finset δ) :=
      Finset.insert_subset (Finset.mem_univ p) hSuniv
    have hinsert :
        insert p S ∈ feasibleSourceSubsets sourceWeight sinkBudget := by
      exact Finset.mem_filter.mpr
        ⟨Finset.mem_powerset.mpr hinsertUniv, hsumInsert⟩
    have hreverse : insert p S ⊆ S :=
      hS.2 hinsert (Finset.subset_insert p S)
    exact hp (hreverse (Finset.mem_insert_self p S))

/-- Algebraic cancellation used after the maximal full-sink block sends its
free surplus to one omitted source. -/
theorem freeTarget_residualMass_eq_scalar
    (totalSource sinkBudget selectedSource surplus : Real)
    (hsurplus : surplus = sinkBudget - selectedSource) :
    totalSource - selectedSource - surplus = totalSource - sinkBudget := by
  rw [hsurplus]
  ring

/-! ## Proper-subface flags -/

variable {Source Sink : Type*}

/-- Abstract arithmetic shape of a legal FCRT-1 reuse flag.  The concrete
compatibility predicate is the full endpoint prime-power divisibility
condition. -/
structure ProperSubfaceFlag
    [DecidableEq Sink]
    (Compatible : Source → Finset Sink → Prop) where
  target : Source
  block : Finset Sink
  witness : Finset Sink
  witness_nonempty : witness.Nonempty
  witness_subset : witness ⊆ block
  witness_ne_block : witness ≠ block
  compatible : Compatible target witness

namespace ProperSubfaceFlag

variable [DecidableEq Sink]
variable {Compatible : Source → Finset Sink → Prop}

/-- A flag witness is a strict subface of its block. -/
theorem witness_ssubset (F : ProperSubfaceFlag Compatible) :
    F.witness ⊂ F.block :=
  ⟨F.witness_subset, fun hreverse =>
    F.witness_ne_block (Finset.Subset.antisymm F.witness_subset hreverse)⟩

/-- Logarithmic mass of the proper witness face. -/
def witnessMass
    (F : ProperSubfaceFlag Compatible) (sinkWeight : Sink → Real) : Real :=
  F.witness.sum sinkWeight

end ProperSubfaceFlag

/-! ## Explicit one-owner token accounting -/

variable {Token Target : Type*}

/-- Mass sent to one target by a family of indivisible tokens with at most one
owner each.  `none` means that the token is unused. -/
def ownedMass
    [Fintype Token] [DecidableEq Target]
    (owner : Token → Option Target) (weight : Token → Real)
    (i : Target) : Real :=
  ∑ q, if owner q = some i then weight q else 0

/-- Summing over all targets never charges an owned nonnegative token more
than once.  Several distinct tokens may have the same target. -/
theorem sum_ownedMass_le_total
    [Fintype Token] [Fintype Target] [DecidableEq Target]
    (owner : Token → Option Target) (weight : Token → Real)
    (hweight : ∀ q, 0 ≤ weight q) :
    (∑ i, ownedMass owner weight i) ≤ ∑ q, weight q := by
  change (∑ i, ∑ q, if owner q = some i then weight q else 0) ≤
    ∑ q, weight q
  rw [Finset.sum_comm]
  apply Finset.sum_le_sum
  intro q _hq
  cases howner : owner q with
  | none =>
      simp [hweight q]
  | some i =>
      simp

/-- Residual demand after all one-hop credits have arrived. -/
def clippedResidual (sourceWeight credit : Real) : Real :=
  max (sourceWeight - credit) 0

/-- Credit plus its clipped residual always covers the original source
demand.  Excess credit is discarded rather than generating another token. -/
theorem sourceWeight_le_credit_add_clippedResidual
    (sourceWeight credit : Real) :
    sourceWeight ≤ credit + clippedResidual sourceWeight credit := by
  unfold clippedResidual
  have h := le_max_left (sourceWeight - credit) 0
  linarith

/-! An explicit owner configuration used to derive the accounting certificate
without assuming a pre-aggregated total-credit inequality. -/

variable {α β γ : Type*}

/-- Finite flagged configuration at the owner level.  `β` indexes residual
sink tokens, `γ` indexes selected blocks and their one-hop reuse tokens, and
`α` indexes residual sources. -/
structure OwnedFlaggedConfiguration
    [Fintype α] [Fintype β] [Fintype γ] where
  sourceWeight : α → Real
  sinkWeight : β → Real
  blockSourceWeight : γ → Real
  blockSinkWeight : γ → Real
  witnessWeight : γ → Real
  reuseCredit : γ → Real
  sinkOwner : β → Option α
  reuseOwner : γ → Option α
  sourceWeight_nonneg : ∀ i, 0 ≤ sourceWeight i
  sinkWeight_nonneg : ∀ j, 0 ≤ sinkWeight j
  blockSource_nonneg : ∀ k, 0 ≤ blockSourceWeight k
  blockSink_nonneg : ∀ k, 0 ≤ blockSinkWeight k
  witnessWeight_nonneg : ∀ k, 0 ≤ witnessWeight k
  reuseCredit_nonneg : ∀ k, 0 ≤ reuseCredit k
  block_saturated : ∀ k, blockSourceWeight k ≤ blockSinkWeight k
  reuse_le_surplus :
    ∀ k, reuseCredit k ≤ blockSinkWeight k - blockSourceWeight k
  reuse_le_witness : ∀ k, reuseCredit k ≤ witnessWeight k

namespace OwnedFlaggedConfiguration

variable [Fintype α] [Fintype β] [Fintype γ] [DecidableEq α]

/-- Total one-hop credit arriving at a residual source. -/
def sourceCredit (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ))
    (i : α) : Real :=
  ownedMass C.sinkOwner C.sinkWeight i +
    ownedMass C.reuseOwner C.reuseCredit i

/-- Clipped residual at one source. -/
def residual (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ))
    (i : α) : Real :=
  clippedResidual (C.sourceWeight i) (C.sourceCredit i)

/-- Sum of all residual source demands. -/
def boundary (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ)) :
    Real :=
  ∑ i, C.residual i

/-- Total source mass before selected blocks and residual sources are
recombined. -/
def sourceMass (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ)) :
    Real :=
  (∑ k, C.blockSourceWeight k) + ∑ i, C.sourceWeight i

/-- Total once-charged sink mass. -/
def sinkMass (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ)) :
    Real :=
  (∑ k, C.blockSinkWeight k) + ∑ j, C.sinkWeight j

/-- Collisions of independently owned tokens at one source preserve the
once-charged global bound. -/
theorem totalSourceCredit_le_sink_add_reuse
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ)) :
    (∑ i, C.sourceCredit i) ≤
      (∑ j, C.sinkWeight j) + ∑ k, C.reuseCredit k := by
  have hsink :=
    sum_ownedMass_le_total C.sinkOwner C.sinkWeight C.sinkWeight_nonneg
  have hreuse :=
    sum_ownedMass_le_total C.reuseOwner C.reuseCredit C.reuseCredit_nonneg
  unfold sourceCredit
  rw [Finset.sum_add_distrib]
  linarith

omit [DecidableEq α] in
/-- Total reusable mass is bounded by the surplus of the selected blocks. -/
theorem totalReuse_le_totalSurplus
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ)) :
    (∑ k, C.reuseCredit k) ≤
      ∑ k, (C.blockSinkWeight k - C.blockSourceWeight k) :=
  Finset.sum_le_sum fun k _ => C.reuse_le_surplus k

/-- Explicit-owner form of the once-charged FCRT-1 mass bridge. -/
theorem sourceMass_sub_sinkMass_le_boundary
    (C : OwnedFlaggedConfiguration (α := α) (β := β) (γ := γ)) :
    C.sourceMass - C.sinkMass ≤ C.boundary := by
  have hcover : (∑ i, C.sourceWeight i) ≤
      (∑ i, C.sourceCredit i) + C.boundary := by
    unfold boundary
    have hpoint : ∀ i : α,
        C.sourceWeight i ≤ C.sourceCredit i + C.residual i :=
      fun i => sourceWeight_le_credit_add_clippedResidual _ _
    have hsum := Finset.sum_le_sum fun i (_hi : i ∈ Finset.univ) => hpoint i
    rw [Finset.sum_add_distrib] at hsum
    exact hsum
  have hcredit := C.totalSourceCredit_le_sink_add_reuse
  have hreuse := C.totalReuse_le_totalSurplus
  unfold sourceMass sinkMass
  rw [Finset.sum_sub_distrib] at hreuse
  linarith

end OwnedFlaggedConfiguration

/-! ## Once-charged flagged-surplus accounting -/

/-- Finite accounting certificate after all concrete block and proper-subface
congruences have been checked.

The residual source weights omit the sources closed by the selected blocks.
The residual sink weights omit the sinks consumed by those blocks.  A reuse
credit is capped both by its block surplus and by the weight of its proper
subface witness.  The total residual source credit is bounded by residual
sink capacity plus the sum of these one-hop reuse credits. -/
structure FlaggedSurplusCertificate
    [Fintype α] [Fintype β] [Fintype γ] where
  sourceWeight : α → Real
  sinkWeight : β → Real
  blockSourceWeight : γ → Real
  blockSinkWeight : γ → Real
  witnessWeight : γ → Real
  sourceCredit : α → Real
  reuseCredit : γ → Real
  sourceCredit_nonneg : ∀ i, 0 ≤ sourceCredit i
  sourceCredit_le : ∀ i, sourceCredit i ≤ sourceWeight i
  blockSource_nonneg : ∀ k, 0 ≤ blockSourceWeight k
  blockSink_nonneg : ∀ k, 0 ≤ blockSinkWeight k
  witnessWeight_nonneg : ∀ k, 0 ≤ witnessWeight k
  reuseCredit_nonneg : ∀ k, 0 ≤ reuseCredit k
  block_saturated : ∀ k, blockSourceWeight k ≤ blockSinkWeight k
  reuse_le_surplus :
    ∀ k, reuseCredit k ≤ blockSinkWeight k - blockSourceWeight k
  reuse_le_witness : ∀ k, reuseCredit k ≤ witnessWeight k
  totalSourceCredit_le :
    (∑ i, sourceCredit i) ≤ (∑ j, sinkWeight j) + ∑ k, reuseCredit k

namespace FlaggedSurplusCertificate

variable [Fintype α] [Fintype β] [Fintype γ]

/-- Total source mass, including sources already closed by saturated blocks. -/
def sourceMass (C : FlaggedSurplusCertificate (α := α) (β := β) (γ := γ)) :
    Real :=
  (∑ k, C.blockSourceWeight k) + ∑ i, C.sourceWeight i

/-- Total sink mass, with every block and residual sink charged once. -/
def sinkMass (C : FlaggedSurplusCertificate (α := α) (β := β) (γ := γ)) :
    Real :=
  (∑ k, C.blockSinkWeight k) + ∑ j, C.sinkWeight j

/-- Residual boundary after the certified source credits. -/
def boundary (C : FlaggedSurplusCertificate (α := α) (β := β) (γ := γ)) :
    Real :=
  ∑ i, (C.sourceWeight i - C.sourceCredit i)

/-- The flagged boundary is nonnegative. -/
theorem boundary_nonneg
    (C : FlaggedSurplusCertificate (α := α) (β := β) (γ := γ)) :
    0 ≤ C.boundary := by
  unfold boundary
  exact Finset.sum_nonneg fun i _ => sub_nonneg.mpr (C.sourceCredit_le i)

/-- Total reusable credit is bounded by total block surplus. -/
theorem totalReuse_le_totalSurplus
    (C : FlaggedSurplusCertificate (α := α) (β := β) (γ := γ)) :
    (∑ k, C.reuseCredit k) ≤
      ∑ k, (C.blockSinkWeight k - C.blockSourceWeight k) :=
  Finset.sum_le_sum fun k _ => C.reuse_le_surplus k

/-- Total reusable credit is also bounded by total proper-face witness mass. -/
theorem totalReuse_le_totalWitness
    (C : FlaggedSurplusCertificate (α := α) (β := β) (γ := γ)) :
    (∑ k, C.reuseCredit k) ≤ ∑ k, C.witnessWeight k :=
  Finset.sum_le_sum fun k _ => C.reuse_le_witness k

/-- The finite once-charged mass inequality underlying FCRT-1. -/
theorem sourceMass_sub_sinkMass_le_boundary
    (C : FlaggedSurplusCertificate (α := α) (β := β) (γ := γ)) :
    C.sourceMass - C.sinkMass ≤ C.boundary := by
  have hreuse := C.totalReuse_le_totalSurplus
  have hcredit := C.totalSourceCredit_le
  unfold sourceMass sinkMass boundary at *
  rw [Finset.sum_sub_distrib] at hreuse ⊢
  linarith

end FlaggedSurplusCertificate

/-! ## Endpoint bridge and conditional uniform gate -/

/-- Kernel output of an actual endpoint FCRT-1 configuration.  Arithmetic
admissibility is kept as a separate predicate below. -/
structure EndpointFlaggedCertificate (P : ABCPoint) where
  boundary : Real
  boundary_nonneg : 0 ≤ boundary
  defect_le_boundary : signedEndpointCoreDefect P ≤ boundary

/-- Every endpoint flagged certificate gives the pointwise height bridge. -/
theorem height_le_conductor_add_flaggedBoundary
    (P : ABCPoint) (C : EndpointFlaggedCertificate P) :
    P.height ≤ P.conductor + C.boundary := by
  have hdefect := C.defect_le_boundary
  rw [← height_sub_conductor_eq_signedEndpointCoreDefect P] at hdefect
  linarith

/-- Predicate selecting endpoint certificates that arise from concrete,
disjoint saturated blocks and legal proper-subface flags. -/
abbrev EndpointFlaggedAdmissibility :=
  ∀ P : ABCPoint, EndpointFlaggedCertificate P → Prop

/-- Uniform small-boundary FCRT-1 gate for a specified arithmetic
admissibility predicate.  This definition supplies no inhabitant. -/
def UniformAdmissibleFlaggedCRTBoundary
    (Admissible : EndpointFlaggedAdmissibility) : Prop :=
  ∀ epsilon : Real, 0 < epsilon →
    ∃ K : Real, ∀ P : ABCPoint,
      ∃ C : EndpointFlaggedCertificate P,
        Admissible P C ∧ C.boundary ≤ epsilon * P.conductor + K

/-- The quantified FCRT-1 gate, if proved with its concrete arithmetic
admissibility predicate, implies the standard logarithmic abc conjecture. -/
theorem abc_of_uniformAdmissibleFlaggedCRTBoundary
    (Admissible : EndpointFlaggedAdmissibility)
    (hgate : UniformAdmissibleFlaggedCRTBoundary Admissible) :
    ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨K, hK⟩ := hgate epsilon hepsilon
  refine ⟨K, ?_⟩
  intro a b c ha hb hc hsum hcoprime
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hsum
      pairwise_coprime := hcoprime }
  obtain ⟨C, _hAdmissible, hC⟩ := hK P
  have hheight := height_le_conductor_add_flaggedBoundary P C
  have hpoint : P.height ≤ (1 + epsilon) * P.conductor + K := by
    calc
      P.height ≤ P.conductor + C.boundary := hheight
      _ ≤ P.conductor + (epsilon * P.conductor + K) := by linarith
      _ = (1 + epsilon) * P.conductor + K := by ring
  simpa [P, ABCPoint.height, ABCPoint.conductor, P.max_eq_c] using hpoint

/-! ## Additive endpoint residue cube -/

section ResidueCube

variable {ι G : Type*} [DecidableEq ι] [Fintype ι] [AddCommGroup G]

/-- Additive label of a Boolean packet.  Multiplicative endpoint unit groups
are represented through their additive copy in this abstract kernel. -/
def packetLabel (label : ι → G) (T : Finset ι) : G :=
  T.sum label

/-- Compatibility is membership in one fixed residue fibre. -/
def IsCompatiblePacket (label : ι → G) (eta : G) (T : Finset ι) : Prop :=
  packetLabel label T = eta

/-- A packet and its complement add to the full endpoint label. -/
theorem packetLabel_add_compl
    (label : ι → G) (T : Finset ι) :
    packetLabel label T + packetLabel label Tᶜ =
      packetLabel label Finset.univ := by
  have hdis : Disjoint T Tᶜ := disjoint_compl_right
  rw [packetLabel, packetLabel, packetLabel, ← Finset.sum_union hdis]
  congr
  ext q
  simp

/-- When the full endpoint label is `eta`, its `eta`-fibre is exactly the
complement of the zero fibre. -/
theorem compatible_iff_compl_zero
    (label : ι → G) (eta : G)
    (htotal : packetLabel label Finset.univ = eta)
    (T : Finset ι) :
    IsCompatiblePacket label eta T ↔ packetLabel label Tᶜ = 0 := by
  constructor
  · intro hT
    have h := packetLabel_add_compl label T
    rw [hT, htotal] at h
    simpa using h
  · intro hcompl
    have h := packetLabel_add_compl label T
    rw [hcompl, add_zero, htotal] at h
    exact h

omit [Fintype ι] in
/-- Decompose a packet into its intersection with another packet and its
relative complement. -/
theorem packetLabel_inter_add_sdiff
    (label : ι → G) (T U : Finset ι) :
    packetLabel label (T ∩ U) + packetLabel label (T \ U) =
      packetLabel label T := by
  have hdis : Disjoint (T ∩ U) (T \ U) := by
    rw [Finset.disjoint_left]
    intro q hqInter hqDiff
    simp only [Finset.mem_inter] at hqInter
    simp only [Finset.mem_sdiff] at hqDiff
    exact hqDiff.2 hqInter.2
  rw [packetLabel, packetLabel, packetLabel, ← Finset.sum_union hdis]
  congr
  ext q
  by_cases hq : q ∈ U <;> simp [hq]

omit [Fintype ι] in
/-- Equal residue fibres produce an equality between the two disjoint sides
of their symmetric difference. -/
theorem packetLabel_sdiff_eq_of_eq
    (label : ι → G) {T U : Finset ι}
    (hTU : packetLabel label T = packetLabel label U) :
    packetLabel label (T \ U) = packetLabel label (U \ T) := by
  apply add_left_cancel (a := packetLabel label (T ∩ U))
  calc
    packetLabel label (T ∩ U) + packetLabel label (T \ U) =
        packetLabel label T :=
      packetLabel_inter_add_sdiff label T U
    _ = packetLabel label U := hTU
    _ = packetLabel label (T ∩ U) + packetLabel label (U \ T) := by
      rw [Finset.inter_comm]
      exact (packetLabel_inter_add_sdiff label U T).symm

omit [Fintype ι] in
/-- Two compatible packets lie in the same fibre and hence have equal signed
symmetric-difference labels. -/
theorem compatiblePacket_sdiff_eq
    (label : ι → G) (eta : G) {T U : Finset ι}
    (hT : IsCompatiblePacket label eta T)
    (hU : IsCompatiblePacket label eta U) :
    packetLabel label (T \ U) = packetLabel label (U \ T) :=
  packetLabel_sdiff_eq_of_eq label (hT.trans hU.symm)

end ResidueCube

/-! ## Exact arithmetic and logarithmic witnesses -/

theorem witness675_sum : (1 : Nat) + 675 = 676 := by norm_num

theorem witness675_factor_b : (675 : Nat) = 3 ^ 3 * 5 ^ 2 := by norm_num

theorem witness675_factor_c : (676 : Nat) = 2 ^ 2 * 13 ^ 2 := by norm_num

theorem witness675_threeFace_for_two : (2 ^ 2 : Nat) ∣ 1 + 3 ^ 3 := by
  norm_num

theorem witness675_fiveFace_not_for_two :
    ¬(2 ^ 2 : Nat) ∣ 1 + 5 ^ 2 := by
  norm_num

theorem witness675_threeFace_not_for_thirteen :
    ¬(13 ^ 2 : Nat) ∣ 1 + 3 ^ 3 := by
  norm_num

theorem witness675_fiveFace_not_for_thirteen :
    ¬(13 ^ 2 : Nat) ∣ 1 + 5 ^ 2 := by
  norm_num

theorem witness675_fullFace_for_both :
    (2 ^ 2 * 13 ^ 2 : Nat) ∣ 1 + 3 ^ 3 * 5 ^ 2 := by
  norm_num

theorem witness675_reuseCap_is_surplus :
    Real.log 15 - Real.log 13 < Real.log 3 := by
  have hpos : (0 : Real) < 15 / 13 := by norm_num
  have hthree : (0 : Real) < 3 := by norm_num
  have hlt : (15 / 13 : Real) < 3 := by norm_num
  rw [← Real.log_div (by norm_num : (15 : Real) ≠ 0)
    (by norm_num : (13 : Real) ≠ 0)]
  exact Real.strictMonoOn_log hpos hthree hlt

theorem witness675_flaggedBoundary_eq_scalarDefect :
    Real.log 2 - (Real.log 15 - Real.log 13) =
      Real.log 26 - Real.log 15 := by
  rw [show (26 : Real) = 2 * 13 by norm_num,
    Real.log_mul (by norm_num : (2 : Real) ≠ 0)
      (by norm_num : (13 : Real) ≠ 0)]
  ring

theorem witness224_sum : (1 : Nat) + 224 = 225 := by norm_num

theorem witness224_factor_b : (224 : Nat) = 2 ^ 5 * 7 := by norm_num

theorem witness224_factor_c : (225 : Nat) = 3 ^ 2 * 5 ^ 2 := by norm_num

theorem witness224_twoFace_not_for_three :
    ¬(3 ^ 2 : Nat) ∣ 1 + 2 ^ 5 := by
  norm_num

theorem witness224_sevenFace_not_for_three :
    ¬(3 ^ 2 : Nat) ∣ 1 + 7 := by
  norm_num

theorem witness224_twoFace_not_for_five :
    ¬(5 ^ 2 : Nat) ∣ 1 + 2 ^ 5 := by
  norm_num

theorem witness224_sevenFace_not_for_five :
    ¬(5 ^ 2 : Nat) ∣ 1 + 7 := by
  norm_num

theorem witness224_fullFace_for_both :
    (3 ^ 2 * 5 ^ 2 : Nat) ∣ 1 + 2 ^ 5 * 7 := by
  norm_num

theorem witness224_boundary_strictly_above_scalarDefect :
    Real.log 15 - Real.log 14 < Real.log 3 - Real.log 2 := by
  rw [← Real.log_div (by norm_num : (15 : Real) ≠ 0)
      (by norm_num : (14 : Real) ≠ 0),
    ← Real.log_div (by norm_num : (3 : Real) ≠ 0)
      (by norm_num : (2 : Real) ≠ 0)]
  exact Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)

theorem witness65025_sum : (1 : Nat) + 65024 = 65025 := by norm_num

theorem witness65025_factor_b :
    (65024 : Nat) = 2 ^ 9 * 127 := by
  norm_num

theorem witness65025_factor_c :
    (65025 : Nat) = 3 ^ 2 * 5 ^ 2 * 17 ^ 2 := by
  norm_num

theorem witness65025_twoFace_for_three :
    (3 ^ 2 : Nat) ∣ 1 + 2 ^ 9 := by
  norm_num

theorem witness65025_twoFace_not_for_five :
    ¬(5 ^ 2 : Nat) ∣ 1 + 2 ^ 9 := by
  norm_num

theorem witness65025_twoFace_not_for_seventeen :
    ¬(17 ^ 2 : Nat) ∣ 1 + 2 ^ 9 := by
  norm_num

theorem witness65025_127Face_not_for_three :
    ¬(3 ^ 2 : Nat) ∣ 1 + 127 := by
  norm_num

theorem witness65025_127Face_not_for_five :
    ¬(5 ^ 2 : Nat) ∣ 1 + 127 := by
  norm_num

theorem witness65025_127Face_not_for_seventeen :
    ¬(17 ^ 2 : Nat) ∣ 1 + 127 := by
  norm_num

theorem witness65025_fullFace_for_all :
    (3 ^ 2 * 5 ^ 2 * 17 ^ 2 : Nat) ∣ 1 + 2 ^ 9 * 127 := by
  norm_num

/-- In the four-layer witness, the proper face, rather than the much larger
block surplus, is the active reuse cap. -/
theorem witness65025_reuseCap_is_witness :
    Real.log 2 < Real.log 254 - Real.log 85 := by
  rw [← Real.log_div (by norm_num : (254 : Real) ≠ 0)
    (by norm_num : (85 : Real) ≠ 0)]
  exact Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)

/-- Exact strict order of the exponentiated scalar, FCRT-1, SCRT-0, and PBT
boundaries at `(1,65024,65025)`. -/
theorem witness65025_fourBoundaryLevels_strict :
    Real.log 255 - Real.log 254 <
        Real.log 3 - Real.log 2 ∧
      Real.log 3 - Real.log 2 < Real.log 3 ∧
      Real.log 3 < Real.log 15 - Real.log 2 := by
  constructor
  · rw [← Real.log_div (by norm_num : (255 : Real) ≠ 0)
        (by norm_num : (254 : Real) ≠ 0),
      ← Real.log_div (by norm_num : (3 : Real) ≠ 0)
        (by norm_num : (2 : Real) ≠ 0)]
    exact Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)
  constructor
  · have htwo : 0 < Real.log 2 := Real.log_pos (by norm_num)
    linarith
  · rw [← Real.log_div (by norm_num : (15 : Real) ≠ 0)
      (by norm_num : (2 : Real) ≠ 0)]
    exact Real.strictMonoOn_log (by norm_num) (by norm_num) (by norm_num)

end ABCFlaggedCRTSurplusResidueCube20260904
end
end IUTThreeClosures
