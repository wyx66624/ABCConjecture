/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.DistinguishedMultiradialBranch
import IUTThreeClosures.ActualHodgeTheaterOutput

/-!
# The ordinary branch in the concrete Tate--Kummer candidate model

The concrete local model already implemented in `ActualHodgeTheaterOutput`
associates to an Ind1/Ind2/Ind3 choice a packet of Tate-power regions.  Its
ordinary choice has no norm-one twist, no label permutation, and no extra
Ind3 exponent.  The resulting packet is exactly the native squared-label
Tate packet.

This file packages that equality as a `DistinguishedGenuineBranch`.  It closes
the lower/native branch for the candidate model.  The remaining Theorem 3.11
source theorem is to identify an actual Hodge-theater output with this
candidate ordinary branch and to prove soundness for all other genuine
outputs.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe v w

variable {K : Type v} [NormedField K]
variable {Label : Type w}

/-- Native squared-label packet attached to one Tate parameter. -/
def nativeSquaredLabelPacket
    (t : TateParameter K)
    (labelNat : Label → ℕ) : Set (Label → K) :=
  {x | ∀ j, x j ∈ t.qPowerRegion ((labelNat j) ^ 2)}

/-- Regions represented by the concrete candidate choices. -/
def candidateChoiceRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label) : Set (Label → K) :=
  C.packetRegion t labelNat

/-- The ordinary concrete candidate is exactly the distinguished native
q-pilot packet. -/
def candidateOrdinaryDistinguishedBranch
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    DistinguishedGenuineBranch
      (ThetaIndeterminacyChoice K Label)
      (candidateChoiceRegion t labelNat)
      (nativeSquaredLabelPacket t labelNat) where
  output := ThetaIndeterminacyChoice.ordinary
  output_region := by
    exact ThetaIndeterminacyChoice.ordinary_packetRegion t labelNat

/-- Consequently the native packet is contained in the full union of concrete
candidate output regions. -/
theorem nativeSquaredLabelPacket_le_candidateUnion
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    nativeSquaredLabelPacket t labelNat ⊆
      representedUnion (candidateChoiceRegion t labelNat) :=
  (candidateOrdinaryDistinguishedBranch t labelNat).native_le_genuineUnion

end IUTThreeClosures
