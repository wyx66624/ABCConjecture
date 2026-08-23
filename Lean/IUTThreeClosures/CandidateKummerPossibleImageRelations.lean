/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualHodgeTheaterOutput

/-!
# Native and envelope relations for the explicit Kummer-choice model

`ActualHodgeTheaterOutput` constructs an explicit candidate for the three local
indeterminacies.  Every output coordinate is a norm-one unit times a
nonnegative power of the actual Tate parameter.  Consequently every output
packet lies in the product of local norm-unit balls, while the ordinary choice
is literally one member of the possible-image union.

This is a closed theorem for the explicit candidate model.  It is deliberately
not advertised as the coverage theorem for all genuine IUT possible images;
that final identification must be obtained from the actual log-link/Kummer
source or from the weaker upper-semicompatible envelope theorem.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u v

namespace ThetaIndeterminacyChoice

variable {K : Type u} [NormedField K]
variable {Label : Type v}

/-- Product of the canonical local norm-unit balls. -/
def integralPacketEnvelope : Set (Label → K) :=
  {x | ∀ j, x j ∈ normIntegralRegion (K := K)}

/-- Literal union of all regions produced by the explicit Ind1/Ind2/Ind3
candidate choices. -/
def candidatePossibleUnion
    (t : TateParameter K) (labelNat : Label → ℕ) : Set (Label → K) :=
  ⋃ C : ThetaIndeterminacyChoice K Label, C.packetRegion t labelNat

/-- The ordinary q-pilot packet is one of the candidate possible images. -/
theorem candidateNativeImage
    (t : TateParameter K) (labelNat : Label → ℕ) :
    (ordinary : ThetaIndeterminacyChoice K Label).packetRegion t labelNat ⊆
      candidatePossibleUnion t labelNat := by
  intro z hz
  exact Set.mem_iUnion.mpr
    ⟨(ordinary : ThetaIndeterminacyChoice K Label), hz⟩

/-- Every concrete candidate output packet lies in the product integral
packet.  The proof uses only that all output exponents are nonnegative and
that the actual Tate parameter has norm at most one. -/
theorem packetRegion_le_integralPacketEnvelope
    (t : TateParameter K) (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label) :
    C.packetRegion t labelNat ⊆
      (integralPacketEnvelope : Set (Label → K)) := by
  intro z hz j
  have hj : z j ∈ C.outputRegion t labelNat j := hz j
  rw [C.outputRegion_eq_qPowerRegion t labelNat j] at hj
  have hsub :
      t.qPowerRegion (C.outputPower labelNat j) ⊆ t.qPowerRegion 0 :=
    t.qPowerRegion_antitone (Nat.zero_le _)
  have hz0 := hsub hj
  simpa [TateParameter.qPowerRegion_zero] using hz0

/-- The whole explicit candidate possible-image union lies in the canonical
integral packet envelope. -/
theorem candidatePossibleImageEnvelope
    (t : TateParameter K) (labelNat : Label → ℕ) :
    candidatePossibleUnion t labelNat ⊆
      (integralPacketEnvelope : Set (Label → K)) := by
  intro z hz
  rcases Set.mem_iUnion.mp hz with ⟨C, hzC⟩
  exact C.packetRegion_le_integralPacketEnvelope t labelNat hzC

/-- Both candidate source relations in one theorem. -/
theorem candidateSourceRelations
    (t : TateParameter K) (labelNat : Label → ℕ) :
    (ordinary : ThetaIndeterminacyChoice K Label).packetRegion t labelNat ⊆
        candidatePossibleUnion t labelNat ∧
      candidatePossibleUnion t labelNat ⊆
        (integralPacketEnvelope : Set (Label → K)) :=
  ⟨candidateNativeImage t labelNat,
    candidatePossibleImageEnvelope t labelNat⟩

end ThetaIndeterminacyChoice

end IUTThreeClosures
