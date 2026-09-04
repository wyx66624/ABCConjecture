/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCSignedEndpointPrimeTokenTransport20260903
import Mathlib.Tactic

/-!
# Bidirectional endpoint transport with relative logarithmic drop

The ordinary proofs precede this formalization in
`research/ABC_BIDIRECTIONAL_PRIME_TRANSPORT_SUCCESSOR_2026_09_03.md`.

Removing every order condition from fractional transport makes its optimal
unmatched mass equal to the positive part of the scalar source-minus-sink
mass.  At the endpoint this is exactly the positive part of height minus
conductor, so the completely unordered gate is equivalent to `ABCConjecture`
and supplies no independent mechanism.

The surviving candidate allows every edge but charges the relative
logarithmic downward displacement.  Its energy is unmatched mass plus this
nonnegative cost.  A uniform small-energy theorem would imply the unchanged
standard `ABCConjecture`.  No such theorem is assumed or proved here, and no
claim is made that the prime-square family satisfies the candidate.
-/

namespace IUTThreeClosures

open scoped BigOperators

noncomputable section

namespace ABCBidirectionalPrimeTransportSuccessor20260903

open SignedEndpointPrimeTokenTransport

/-! ## Unrestricted finite flows and the scalar degeneration -/

variable {α β : Type*} [Fintype α] [Fintype β]

/-- A bidirectional flow is represented by a monotone flow with constant
zero keys.  Thus every source-sink matrix entry is admissible. -/
abbrev BidirectionalWeightedFlow
    (sourceWeight : α → ℝ) (sinkWeight : β → ℝ) :=
  MonotoneWeightedFlow sourceWeight sinkWeight (fun _ => 0) (fun _ => 0)

/-- The zero matrix inhabits every bidirectional flow space with nonnegative
source and sink weights. -/
def zeroBidirectionalWeightedFlow
    {sourceWeight : α → ℝ} {sinkWeight : β → ℝ}
    (hsource : ∀ i, 0 ≤ sourceWeight i)
    (hsink : ∀ j, 0 ≤ sinkWeight j) :
    BidirectionalWeightedFlow sourceWeight sinkWeight where
  flow := fun _ _ => 0
  flow_nonneg := by simp
  source_capacity := by
    intro i
    simpa using hsource i
  sink_capacity := by
    intro j
    simpa using hsink j
  monotone := by simp

/-- Any chosen source-sink pair can carry any nonnegative amount that fits
both endpoint capacities.  This makes the absence of a hard edge-order
restriction explicit. -/
def singleEdgeBidirectionalWeightedFlow
    {sourceWeight : α → ℝ} {sinkWeight : β → ℝ}
    [DecidableEq α] [DecidableEq β]
    (hsource : ∀ i, 0 ≤ sourceWeight i)
    (hsink : ∀ j, 0 ≤ sinkWeight j)
    (i0 : α) (j0 : β) (x : ℝ)
    (hx : 0 ≤ x) (hxsource : x ≤ sourceWeight i0)
    (hxsink : x ≤ sinkWeight j0) :
    BidirectionalWeightedFlow sourceWeight sinkWeight where
  flow := fun i j => if i = i0 ∧ j = j0 then x else 0
  flow_nonneg := by
    intro i j
    split <;> simp_all
  source_capacity := by
    intro i
    by_cases hi : i = i0
    · subst i
      simpa using hxsource
    · simpa [hi] using hsource i
  sink_capacity := by
    intro j
    by_cases hj : j = j0
    · subst j
      simpa using hxsink
    · simpa [hj] using hsink j
  monotone := by simp

theorem singleEdgeBidirectionalWeightedFlow_selected
    {sourceWeight : α → ℝ} {sinkWeight : β → ℝ}
    [DecidableEq α] [DecidableEq β]
    (hsource : ∀ i, 0 ≤ sourceWeight i)
    (hsink : ∀ j, 0 ≤ sinkWeight j)
    (i0 : α) (j0 : β) (x : ℝ)
    (hx : 0 ≤ x) (hxsource : x ≤ sourceWeight i0)
    (hxsink : x ≤ sinkWeight j0) :
    (singleEdgeBidirectionalWeightedFlow hsource hsink i0 j0 x hx hxsource hxsink).flow
        i0 j0 = x := by
  simp [singleEdgeBidirectionalWeightedFlow]

/-- Scalar relaxation of a completely unordered capacitated flow. -/
structure UnorderedMassRelaxation (sourceMass sinkMass : ℝ) where
  carried : ℝ
  carried_nonneg : 0 ≤ carried
  carried_le_source : carried ≤ sourceMass
  carried_le_sink : carried ≤ sinkMass

namespace UnorderedMassRelaxation

/-- Source mass left unmatched in the scalar relaxation. -/
def unmatched {sourceMass sinkMass : ℝ}
    (R : UnorderedMassRelaxation sourceMass sinkMass) : ℝ :=
  sourceMass - R.carried

/-- Every unordered relaxation leaves at least the positive part of the
source-minus-sink mass. -/
theorem positivePart_le_unmatched
    {sourceMass sinkMass : ℝ}
    (R : UnorderedMassRelaxation sourceMass sinkMass) :
    max (sourceMass - sinkMass) 0 ≤ R.unmatched := by
  apply max_le
  · unfold unmatched
    linarith [R.carried_le_sink]
  · unfold unmatched
    linarith [R.carried_le_source]

/-- The scalar optimum carries the smaller of total source and sink mass. -/
def optimal
    {sourceMass sinkMass : ℝ}
    (hsource : 0 ≤ sourceMass) (hsink : 0 ≤ sinkMass) :
    UnorderedMassRelaxation sourceMass sinkMass where
  carried := min sourceMass sinkMass
  carried_nonneg := le_min hsource hsink
  carried_le_source := min_le_left _ _
  carried_le_sink := min_le_right _ _

/-- Exact value of the scalar unordered optimum. -/
theorem optimal_unmatched_eq_positivePart
    {sourceMass sinkMass : ℝ}
    (hsource : 0 ≤ sourceMass) (hsink : 0 ≤ sinkMass) :
    (optimal hsource hsink).unmatched = max (sourceMass - sinkMass) 0 := by
  change sourceMass - min sourceMass sinkMass =
    max (sourceMass - sinkMass) 0
  by_cases h : sourceMass ≤ sinkMass
  · rw [min_eq_left h, max_eq_right (sub_nonpos.mpr h)]
    simp
  · have h' : sinkMass ≤ sourceMass := le_of_not_ge h
    rw [min_eq_right h', max_eq_left (sub_nonneg.mpr h')]

end UnorderedMassRelaxation

namespace BidirectionalWeightedFlow

variable {sourceWeight : α → ℝ} {sinkWeight : β → ℝ}

/-- Forgetting the matrix but retaining its total carried mass gives the
scalar unordered relaxation. -/
def toUnorderedMassRelaxation
    (F : BidirectionalWeightedFlow sourceWeight sinkWeight) :
    UnorderedMassRelaxation F.sourceMass F.sinkMass where
  carried := F.carriedMass
  carried_nonneg := by
    classical
    unfold MonotoneWeightedFlow.carriedMass
    exact Finset.sum_nonneg fun i _ =>
      Finset.sum_nonneg fun j _ => F.flow_nonneg i j
  carried_le_source := by
    classical
    unfold MonotoneWeightedFlow.carriedMass MonotoneWeightedFlow.sourceMass
    exact Finset.sum_le_sum fun i _ => F.source_capacity i
  carried_le_sink := by
    classical
    unfold MonotoneWeightedFlow.carriedMass MonotoneWeightedFlow.sinkMass
    rw [Finset.sum_comm]
    exact Finset.sum_le_sum fun j _ => F.sink_capacity j

/-- Matrix form of the universal positive-part lower bound. -/
theorem positivePart_source_sub_sink_le_unmatchedMass
    (F : BidirectionalWeightedFlow sourceWeight sinkWeight) :
    max (F.sourceMass - F.sinkMass) 0 ≤ F.unmatchedMass := by
  have h := F.toUnorderedMassRelaxation.positivePart_le_unmatched
  rw [UnorderedMassRelaxation.unmatched] at h
  rw [F.unmatchedMass_eq_sourceMass_sub_carriedMass]
  exact h

end BidirectionalWeightedFlow

/-! ## Endpoint specialization and exact unordered collapse -/

/-- Bidirectional flows between actual excess layers of `c` and actual prime
support tokens of `a*b`. -/
abbrev EndpointBidirectionalFlow (P : ABCPoint) :=
  BidirectionalWeightedFlow
    (fun s : PrimeExcessToken P.c => primeExcessTokenWeight s)
    (fun q : PrimeSupportToken (P.a * P.b) => primeSupportTokenWeight q)

theorem primeExcessTokenWeight_nonneg
    {n : ℕ} (s : PrimeExcessToken n) :
    0 ≤ primeExcessTokenWeight s := by
  unfold primeExcessTokenWeight
  apply Real.log_nonneg
  exact_mod_cast (Nat.prime_of_mem_primeFactors s.1.2).one_le

theorem primeSupportTokenWeight_nonneg
    {n : ℕ} (q : PrimeSupportToken n) :
    0 ≤ primeSupportTokenWeight q := by
  unfold primeSupportTokenWeight
  apply Real.log_nonneg
  exact_mod_cast (Nat.prime_of_mem_primeFactors q.2).one_le

/-- The zero endpoint flow makes the bidirectional candidate type nonempty
for every positive primitive point. -/
def zeroEndpointBidirectionalFlow (P : ABCPoint) :
    EndpointBidirectionalFlow P :=
  zeroBidirectionalWeightedFlow primeExcessTokenWeight_nonneg
    primeSupportTokenWeight_nonneg

theorem endpointBidirectionalFlow_nonempty (P : ABCPoint) :
    Nonempty (EndpointBidirectionalFlow P) :=
  ⟨zeroEndpointBidirectionalFlow P⟩

theorem endpointBidirectionalFlow_sourceMass_eq_log_core
    (P : ABCPoint) (F : EndpointBidirectionalFlow P) :
    F.sourceMass = Real.log (endpointCore P : ℝ) := by
  unfold MonotoneWeightedFlow.sourceMass endpointCore
  exact sum_primeExcessTokenWeight_eq_log_powerfulPart P.c P.c_pos.ne'

theorem endpointBidirectionalFlow_sinkMass_eq_log_externalRadical
    (P : ABCPoint) (F : EndpointBidirectionalFlow P) :
    F.sinkMass = Real.log (externalRadical P : ℝ) := by
  unfold MonotoneWeightedFlow.sinkMass externalRadical
  exact sum_primeSupportTokenWeight_eq_log_radical (P.a * P.b)

/-- Completely unordered endpoint matching can do no better, at the scalar
level, than the positive part of the signed endpoint defect. -/
def endpointUnorderedOptimalUnmatched (P : ABCPoint) : ℝ :=
  max (signedEndpointCoreDefect P) 0

theorem endpointUnorderedOptimalUnmatched_eq_positive_height_defect
    (P : ABCPoint) :
    endpointUnorderedOptimalUnmatched P =
      max (P.height - P.conductor) 0 := by
  unfold endpointUnorderedOptimalUnmatched
  rw [height_sub_conductor_eq_signedEndpointCoreDefect]

/-- Every actual bidirectional endpoint matrix has at least the unordered
scalar optimum as unmatched mass. -/
theorem endpointUnorderedOptimalUnmatched_le_unmatchedMass
    (P : ABCPoint) (F : EndpointBidirectionalFlow P) :
    endpointUnorderedOptimalUnmatched P ≤ F.unmatchedMass := by
  have h := F.positivePart_source_sub_sink_le_unmatchedMass
  rw [endpointBidirectionalFlow_sourceMass_eq_log_core P F,
    endpointBidirectionalFlow_sinkMass_eq_log_externalRadical P F] at h
  simpa [endpointUnorderedOptimalUnmatched, signedEndpointCoreDefect] using h

/-- The scalar optimal relaxation at the actual endpoint. -/
def endpointOptimalScalarRelaxation (P : ABCPoint) :
    UnorderedMassRelaxation
      (Real.log (endpointCore P : ℝ))
      (Real.log (externalRadical P : ℝ)) :=
  UnorderedMassRelaxation.optimal
    (Real.log_nonneg (by exact_mod_cast (endpointCore_pos P)))
    (Real.log_nonneg (by exact_mod_cast (externalRadical_pos P)))

theorem endpointOptimalScalarRelaxation_unmatched
    (P : ABCPoint) :
    (endpointOptimalScalarRelaxation P).unmatched =
      endpointUnorderedOptimalUnmatched P := by
  unfold endpointOptimalScalarRelaxation
  rw [UnorderedMassRelaxation.optimal_unmatched_eq_positivePart]
  rfl

/-- The completely unordered scalar endpoint gate. -/
def UniformUnorderedEndpointRelaxationBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ C : ℝ, ∀ P : ABCPoint,
      endpointUnorderedOptimalUnmatched P ≤ epsilon * P.conductor + C

theorem abc_of_uniformUnorderedEndpointRelaxationBound
    (hgate : UniformUnorderedEndpointRelaxationBound) : ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨C, hC⟩ := hgate epsilon hepsilon
  refine ⟨C, ?_⟩
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
  have hdefect : P.height - P.conductor ≤
      endpointUnorderedOptimalUnmatched P := by
    rw [endpointUnorderedOptimalUnmatched_eq_positive_height_defect]
    exact le_max_left _ _
  have hbound := hC P
  have hpoint : P.height ≤ (1 + epsilon) * P.conductor + C := by
    linarith
  have ha_le : P.a ≤ P.c := Nat.le_of_lt P.a_lt_c
  have hb_le : P.b ≤ P.c := Nat.le_of_lt P.b_lt_c
  have hmax : max P.a (max P.b P.c) = P.c := by
    simp [max_eq_right hb_le, max_eq_right ha_le]
  simpa [P, ABCPoint.height, ABCPoint.conductor, hmax] using hpoint

theorem uniformUnorderedEndpointRelaxationBound_of_abc
    (habc : ABCConjecture) : UniformUnorderedEndpointRelaxationBound := by
  intro epsilon hepsilon
  obtain ⟨C, hC⟩ := habc epsilon hepsilon
  refine ⟨max C 0, ?_⟩
  intro P
  have ha_le : P.a ≤ P.c := Nat.le_of_lt P.a_lt_c
  have hb_le : P.b ≤ P.c := Nat.le_of_lt P.b_lt_c
  have hmax : max P.a (max P.b P.c) = P.c := by
    simp [max_eq_right hb_le, max_eq_right ha_le]
  have habcP := hC P.a P.b P.c P.a_pos P.b_pos P.c_pos P.sum_eq
    P.pairwise_coprime
  have hheight : P.height ≤ (1 + epsilon) * P.conductor + C := by
    simpa [ABCPoint.height, ABCPoint.conductor, hmax] using habcP
  have hdefect : P.height - P.conductor ≤ epsilon * P.conductor + C := by
    linarith
  rw [endpointUnorderedOptimalUnmatched_eq_positive_height_defect]
  apply max_le
  · linarith [le_max_left C 0]
  · exact add_nonneg
      (mul_nonneg hepsilon.le P.conductor_nonneg) (le_max_right C 0)

/-- Exact degeneration diagnosis: the fully unordered endpoint relaxation is
equivalent to the target conjecture. -/
theorem uniformUnorderedEndpointRelaxationBound_iff_abc :
    UniformUnorderedEndpointRelaxationBound ↔ ABCConjecture :=
  ⟨abc_of_uniformUnorderedEndpointRelaxationBound,
    uniformUnorderedEndpointRelaxationBound_of_abc⟩

/-! ## Relative logarithmic drop and the surviving energy candidate -/

/-- Relative downward displacement on the logarithmic key scale. -/
def relativeLogDrop
    (sourceKey : α → ℕ) (sinkKey : β → ℕ) (i : α) (j : β) : ℝ :=
  max 0
    ((Real.log (sourceKey i : ℝ) - Real.log (sinkKey j : ℝ)) /
      Real.log (sourceKey i : ℝ))

omit [Fintype α] [Fintype β] in
theorem relativeLogDrop_nonneg
    (sourceKey : α → ℕ) (sinkKey : β → ℕ) (i : α) (j : β) :
    0 ≤ relativeLogDrop sourceKey sinkKey i j := by
  exact le_max_left _ _

omit [Fintype α] [Fintype β] in
theorem relativeLogDrop_eq_zero_of_le
    (sourceKey : α → ℕ) (sinkKey : β → ℕ) (i : α) (j : β)
    (hsource : 1 < sourceKey i) (hle : sourceKey i ≤ sinkKey j) :
    relativeLogDrop sourceKey sinkKey i j = 0 := by
  have hsourcePos : 0 < (sourceKey i : ℝ) := by
    exact_mod_cast (lt_trans Nat.zero_lt_one hsource)
  have hsinkPos : 0 < (sinkKey j : ℝ) := by
    exact_mod_cast (Nat.zero_lt_of_lt (lt_of_lt_of_le hsource hle))
  have hcast : (sourceKey i : ℝ) ≤ (sinkKey j : ℝ) := by
    exact_mod_cast hle
  have hlog : Real.log (sourceKey i : ℝ) ≤ Real.log (sinkKey j : ℝ) :=
    Real.strictMonoOn_log.monotoneOn hsourcePos hsinkPos hcast
  have hquot :
      (Real.log (sourceKey i : ℝ) - Real.log (sinkKey j : ℝ)) /
          Real.log (sourceKey i : ℝ) ≤ 0 := by
    apply div_nonpos_of_nonpos_of_nonneg (sub_nonpos.mpr hlog)
    exact Real.log_nonneg (by exact_mod_cast hsource.le)
  unfold relativeLogDrop
  exact max_eq_left hquot

namespace BidirectionalWeightedFlow

variable {sourceWeight : α → ℝ} {sinkWeight : β → ℝ}

/-- Total mass-weighted relative logarithmic downward displacement. -/
def downwardCost
    (sourceKey : α → ℕ) (sinkKey : β → ℕ)
    (F : BidirectionalWeightedFlow sourceWeight sinkWeight) : ℝ :=
  ∑ i, ∑ j, F.flow i j * relativeLogDrop sourceKey sinkKey i j

theorem downwardCost_nonneg
    (sourceKey : α → ℕ) (sinkKey : β → ℕ)
    (F : BidirectionalWeightedFlow sourceWeight sinkWeight) :
    0 ≤ F.downwardCost sourceKey sinkKey := by
  classical
  unfold downwardCost
  exact Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ =>
    mul_nonneg (F.flow_nonneg i j)
      (relativeLogDrop_nonneg sourceKey sinkKey i j)

end BidirectionalWeightedFlow

/-- Relative logarithmic descent cost for an actual endpoint flow. -/
def endpointDownwardCost
    {P : ABCPoint} (F : EndpointBidirectionalFlow P) : ℝ :=
  F.downwardCost
    (fun s : PrimeExcessToken P.c => primeExcessTokenPrime s)
    (fun q : PrimeSupportToken (P.a * P.b) => primeSupportTokenPrime q)

theorem endpointDownwardCost_nonneg
    {P : ABCPoint} (F : EndpointBidirectionalFlow P) :
    0 ≤ endpointDownwardCost F :=
  F.downwardCost_nonneg _ _

/-- Forgetting the hard order turns every old monotone endpoint flow into a
bidirectional flow with the same matrix. -/
def endpointPrimeFlowToBidirectional
    {P : ABCPoint} (F : EndpointPrimeFlow P) :
    EndpointBidirectionalFlow P where
  flow := F.flow
  flow_nonneg := F.flow_nonneg
  source_capacity := F.source_capacity
  sink_capacity := F.sink_capacity
  monotone := by simp

theorem endpointPrimeFlow_toBidirectional_downwardCost_eq_zero
    {P : ABCPoint} (F : EndpointPrimeFlow P) :
    endpointDownwardCost (endpointPrimeFlowToBidirectional F) = 0 := by
  classical
  unfold endpointDownwardCost BidirectionalWeightedFlow.downwardCost
  apply Finset.sum_eq_zero
  intro i _
  apply Finset.sum_eq_zero
  intro j _
  by_cases hzero : F.flow i j = 0
  · simp [endpointPrimeFlowToBidirectional, hzero]
  · have hpos : 0 < F.flow i j :=
      lt_of_le_of_ne (F.flow_nonneg i j) (Ne.symm hzero)
    have hle := F.monotone i j hpos
    have hprime : (primeExcessTokenPrime i).Prime :=
      Nat.prime_of_mem_primeFactors i.1.2
    rw [relativeLogDrop_eq_zero_of_le _ _ i j hprime.one_lt hle]
    simp

/-- Unmatched mass plus the relative logarithmic downward cost. -/
def endpointBidirectionalEnergy
    {P : ABCPoint} (F : EndpointBidirectionalFlow P) : ℝ :=
  F.unmatchedMass + endpointDownwardCost F

theorem endpointBidirectionalEnergy_nonneg
    {P : ABCPoint} (F : EndpointBidirectionalFlow P) :
    0 ≤ endpointBidirectionalEnergy F := by
  exact add_nonneg F.unmatchedMass_nonneg (endpointDownwardCost_nonneg F)

theorem unmatchedMass_le_endpointBidirectionalEnergy
    {P : ABCPoint} (F : EndpointBidirectionalFlow P) :
    F.unmatchedMass ≤ endpointBidirectionalEnergy F := by
  unfold endpointBidirectionalEnergy
  exact le_add_of_nonneg_right (endpointDownwardCost_nonneg F)

theorem signedEndpointCoreDefect_le_bidirectionalUnmatchedMass
    (P : ABCPoint) (F : EndpointBidirectionalFlow P) :
    signedEndpointCoreDefect P ≤ F.unmatchedMass := by
  have h := F.sourceMass_sub_sinkMass_le_unmatchedMass
  rw [endpointBidirectionalFlow_sourceMass_eq_log_core P F,
    endpointBidirectionalFlow_sinkMass_eq_log_externalRadical P F] at h
  exact h

theorem height_le_conductor_add_bidirectionalUnmatchedMass
    (P : ABCPoint) (F : EndpointBidirectionalFlow P) :
    P.height ≤ P.conductor + F.unmatchedMass := by
  have h := signedEndpointCoreDefect_le_bidirectionalUnmatchedMass P F
  rw [← height_sub_conductor_eq_signedEndpointCoreDefect P] at h
  linarith

theorem height_le_conductor_add_bidirectionalEnergy
    (P : ABCPoint) (F : EndpointBidirectionalFlow P) :
    P.height ≤ P.conductor + endpointBidirectionalEnergy F := by
  exact (height_le_conductor_add_bidirectionalUnmatchedMass P F).trans
    (by simpa [add_comm] using
      add_le_add_left (unmatchedMass_le_endpointBidirectionalEnergy F) P.conductor)

/-- Surviving conditional candidate: bidirectional endpoint energy is
uniformly epsilon-small relative to the conductor. -/
def UniformBidirectionalEndpointEnergyBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ C : ℝ, ∀ P : ABCPoint,
      ∃ F : EndpointBidirectionalFlow P,
        endpointBidirectionalEnergy F ≤ epsilon * P.conductor + C

/-- The bidirectional-energy candidate implies the standard logarithmic abc
conjecture.  The candidate itself is not assumed anywhere else. -/
theorem abc_of_uniformBidirectionalEndpointEnergyBound
    (hgate : UniformBidirectionalEndpointEnergyBound) : ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨C, hC⟩ := hgate epsilon hepsilon
  refine ⟨C, ?_⟩
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
  obtain ⟨F, hF⟩ := hC P
  have hheight := height_le_conductor_add_bidirectionalEnergy P F
  have hpoint : P.height ≤ (1 + epsilon) * P.conductor + C := by
    calc
      P.height ≤ P.conductor + endpointBidirectionalEnergy F := hheight
      _ ≤ P.conductor + (epsilon * P.conductor + C) :=
        by simpa [add_comm] using add_le_add_left hF P.conductor
      _ = (1 + epsilon) * P.conductor + C := by ring
  have ha_le : P.a ≤ P.c := Nat.le_of_lt P.a_lt_c
  have hb_le : P.b ≤ P.c := Nat.le_of_lt P.b_lt_c
  have hmax : max P.a (max P.b P.c) = P.c := by
    simp [max_eq_right hb_le, max_eq_right ha_le]
  simpa [P, ABCPoint.height, ABCPoint.conductor, hmax] using hpoint

end ABCBidirectionalPrimeTransportSuccessor20260903
end
end IUTThreeClosures
