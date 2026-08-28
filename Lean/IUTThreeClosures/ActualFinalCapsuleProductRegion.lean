/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualDistinguishedProcessionProductRegion

/-!
# Actual final-capsule product region

The standard procession of length `n = (ell - 1) / 2` has nested capsules

`S_2 subset S_3 subset ... subset S_(n+1)`,

where the last capsule has labels `0, ..., n`.  The preceding module takes the
new distinguished label `m + 1` from each capsule and constructs one genuine
two-level product region over those labels and all actual bad places.

This file constructs the equivalent region obtained by taking every label of
the last capsule exactly once.  Label zero contributes the normalized integer
ball and hence logarithmic volume zero; the remaining labels are precisely
`1, ..., n`.  Consequently the final-capsule product has exactly the same
logarithmic Haar volume as the complete distinguished procession product.

This theorem resolves a finite combinatorial/geometric ambiguity: old labels
must not be counted again in every later nested capsule.  It does not identify
cross-label arithmetic holomorphic structures, construct the complete IUT III
possible-image union or mono-analytic hull, or supply an IUT IV
height--different--conductor estimate.
-/

namespace IUTThreeClosures

noncomputable section

open Iut NumberField TateCurvesTheta
open MeasureTheory
open scoped BigOperators ENNReal NNReal NormedField Pointwise Valued WithZero

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

namespace ActualFinalCapsuleProductRegion

open ActualBadPlaceQPilotPacket
open ActualBadPlaceProcessionAssembly
open ActualBadPlaceProductRegion
open ActualDistinguishedProcessionProductRegion
open MaximalValuationRingHull

/- These are the canonical structures on the actual finite-place completions.
They remain local implementation instances, not assumptions stored in a source
record. -/
local instance finalCapsuleNontriviallyNormedTateField
    (Q : QPilotData D) (w : Index Q) :
    NontriviallyNormedField (place Q w).TateField :=
  Valued.toNontriviallyNormedField (place Q w).TateField ℤᵐ⁰

local instance finalCapsuleTateFieldIsUltrametricDist
    (Q : QPilotData D) (w : Index Q) :
    IsUltrametricDist (place Q w).TateField :=
  LocalCompletionNormValuationBridge.completionIsUltrametricDist
    (place Q w).w.maximalIdeal

local instance finalCapsuleTateFieldProperSpace
    (Q : QPilotData D) (w : Index Q) :
    ProperSpace (place Q w).TateField :=
  LocalCompletionNormValuationBridge.completionProperSpace
    (place Q w).w.maximalIdeal

local instance finalCapsuleTateFieldMeasurableSpace
    (Q : QPilotData D) (w : Index Q) :
    MeasurableSpace (place Q w).TateField :=
  borel (place Q w).TateField

local instance finalCapsuleTateFieldBorelSpace
    (Q : QPilotData D) (w : Index Q) :
    BorelSpace (place Q w).TateField :=
  ⟨rfl⟩

local instance finalCapsuleNormalizedIntegerHaarSigmaFinite
    (Q : QPilotData D) (w : Index Q) :
    SigmaFinite
      (normalizedIntegerHaar (K := (place Q w).TateField)) := by
  unfold normalizedIntegerHaar
  infer_instance

local instance finalCapsuleCoordinateMeasureSigmaFinite
    (Q : QPilotData D) (w : Index Q) :
    SigmaFinite (coordinateMeasure Q w) := by
  change SigmaFinite
    (normalizedIntegerHaar (K := (place Q w).TateField))
  infer_instance

local instance finalCapsulePacketMeasureSigmaFinite (Q : QPilotData D) :
    SigmaFinite (packetMeasure Q) := by
  unfold packetMeasure
  infer_instance

/-- The combinatorial last capsule of the standard procession.  Its label set
is the source label set `S_(n+1) = {0, ..., n}`. -/
def finalCapsule (D : InitialThetaData AG TG) : Iut.Capsule ℕ :=
  ⟨Iut.procLabels (processionLength D)⟩

/-- A convenient finite coordinate type for the last capsule. -/
abbrev FinalCapsuleIndex (D : InitialThetaData AG TG) :=
  Fin (processionLength D + 1)

/-- The convenient `Fin` coordinates are canonically equivalent to the actual
source label type of the last standard capsule. -/
def finalCapsuleIndexEquivLabelType (D : InitialThetaData AG TG) :
    FinalCapsuleIndex D ≃ (finalCapsule D).LabelType where
  toFun j :=
    ⟨j.1, Iut.mem_procLabels.mpr (Nat.le_of_lt_succ j.2)⟩
  invFun j :=
    ⟨j.1, Nat.lt_succ_of_le (Iut.mem_procLabels.mp j.2)⟩
  left_inv j := by
    ext
    rfl
  right_inv j := by
    ext
    rfl

/-- The actual local square-label region for an arbitrary nonnegative label. -/
noncomputable def labelCoordinateRegion
    (Q : QPilotData D) (j : ℕ) (w : Index Q) :
    FinitePositiveRegion (place Q w).TateField
      (coordinateMeasure Q w) :=
  (place Q w).squareLabelRegion j

/-- The genuine product over every actual bad place for one arbitrary label. -/
noncomputable def labelProductRegion
    (Q : QPilotData D) (j : ℕ) :
    FinitePositiveRegion (Packet Q) (packetMeasure Q) := by
  change FinitePositiveRegion
    (∀ w : Index Q, (place Q w).TateField)
    (Measure.pi (coordinateMeasure Q))
  exact FinitePositiveRegion.pi (coordinateMeasure Q)
    (labelCoordinateRegion Q j)

private theorem index_univ_eq_badFinset_attach (Q : QPilotData D) :
    (Finset.univ : Finset (Index Q)) = Q.badFinset.attach := by
  ext w
  simp

/-- Exact local logarithmic volume at an arbitrary last-capsule label. -/
theorem labelCoordinateRegion_logVolume
    (Q : QPilotData D) (j : ℕ) (w : Index Q) :
    (labelCoordinateRegion Q j w).logVolume =
      (j : ℝ) ^ 2 * entry Q w := by
  change ((place Q w).squareLabelRegion j).logVolume = _
  rw [ActualBadHodgeTheaterPlace.squareLabelRegion_logVolume_eq_sq_mul_localHaarLog]
  rfl

/-- Exact bad-place product logarithmic volume at an arbitrary label. -/
theorem labelProductRegion_logVolume
    (Q : QPilotData D) (j : ℕ) :
    (labelProductRegion Q j).logVolume =
      (j : ℝ) ^ 2 * signedHaarLogSum Q := by
  classical
  rw [labelProductRegion, FinitePositiveRegion.logVolume_pi,
    index_univ_eq_badFinset_attach, signedHaarLogSum]
  calc
    ∑ w ∈ Q.badFinset.attach,
        (labelCoordinateRegion Q j w).logVolume =
      ∑ w ∈ Q.badFinset.attach,
        (j : ℝ) ^ 2 * entry Q w := by
          apply Finset.sum_congr rfl
          intro w hw
          exact labelCoordinateRegion_logVolume Q j w
    _ = (j : ℝ) ^ 2 *
        ∑ w ∈ Q.badFinset.attach, entry Q w := by
          rw [Finset.mul_sum]

/-- Label zero is the normalized integer-ball packet and has logarithmic
volume zero. -/
theorem labelProductRegion_zero_logVolume (Q : QPilotData D) :
    (labelProductRegion Q 0).logVolume = 0 := by
  rw [labelProductRegion_logVolume]
  norm_num

/-- The constant family of actual packet Haar measures over the final capsule
labels. -/
noncomputable def finalCapsuleCoordinateMeasure (Q : QPilotData D) :
    ∀ _j : FinalCapsuleIndex D, Measure (Packet Q) :=
  fun _ => packetMeasure Q

local instance finalCapsuleCoordinateMeasureSigmaFinite
    (Q : QPilotData D) (j : FinalCapsuleIndex D) :
    SigmaFinite (finalCapsuleCoordinateMeasure Q j) := by
  change SigmaFinite (packetMeasure Q)
  infer_instance

/-- The actual bad-place product region at one final-capsule label. -/
noncomputable def finalCapsuleCoordinateRegion
    (Q : QPilotData D) (j : FinalCapsuleIndex D) :
    FinitePositiveRegion (Packet Q) (finalCapsuleCoordinateMeasure Q j) := by
  change FinitePositiveRegion (Packet Q) (packetMeasure Q)
  exact labelProductRegion Q j.1

/-- The genuine product over every label of the last standard capsule and
every actual bad place, with each final label counted exactly once. -/
noncomputable def finalCapsuleProductRegion
    (Q : QPilotData D) :
    FinitePositiveRegion
      (∀ j : FinalCapsuleIndex D, Packet Q)
      (Measure.pi (finalCapsuleCoordinateMeasure Q)) :=
  FinitePositiveRegion.pi (finalCapsuleCoordinateMeasure Q)
    (finalCapsuleCoordinateRegion Q)

/-- Each outer coordinate has the square-label packet logarithmic volume. -/
theorem finalCapsuleCoordinateRegion_logVolume
    (Q : QPilotData D) (j : FinalCapsuleIndex D) :
    (finalCapsuleCoordinateRegion Q j).logVolume =
      (j.1 : ℝ) ^ 2 * signedHaarLogSum Q := by
  change (labelProductRegion Q j.1).logVolume = _
  exact labelProductRegion_logVolume Q j.1

/-- Pure finite telescoping identity: labels `0, ..., n` counted once have the
same square-weight sum as the newly introduced labels `1, ..., n` counted
along the procession. -/
theorem finalCapsule_squareSum_eq_distinguished_squareSum
    (Q : QPilotData D) :
    (∑ j : FinalCapsuleIndex D,
        (j.1 : ℝ) ^ 2 * signedHaarLogSum Q) =
      ∑ m ∈ Finset.range (processionLength D),
        (((m + 1 : ℕ) : ℝ) ^ 2 * signedHaarLogSum Q) := by
  rw [Fin.sum_univ_eq_sum_range]
  rw [Finset.sum_range_succ']
  norm_num

/-- **Final capsule/procession identity.**  The logarithmic Haar volume of the
actual product over every final-capsule label equals the logarithmic volume of
the product over every distinguished new label of the standard procession. -/
theorem finalCapsuleProductRegion_logVolume_eq_processionLogSum
    (Q : QPilotData D) :
    (finalCapsuleProductRegion Q).logVolume =
      processionLogSum Q := by
  classical
  rw [finalCapsuleProductRegion, FinitePositiveRegion.logVolume_pi]
  calc
    ∑ j : FinalCapsuleIndex D,
        (finalCapsuleCoordinateRegion Q j).logVolume =
      ∑ j : FinalCapsuleIndex D,
        (j.1 : ℝ) ^ 2 * signedHaarLogSum Q := by
          apply Finset.sum_congr rfl
          intro j hj
          exact finalCapsuleCoordinateRegion_logVolume Q j
    _ = ∑ m ∈ Finset.range (processionLength D),
        (((m + 1 : ℕ) : ℝ) ^ 2 * signedHaarLogSum Q) :=
      finalCapsule_squareSum_eq_distinguished_squareSum Q
    _ = processionLogSum Q := by
      rw [processionLogSum]
      apply Finset.sum_congr rfl
      intro m hm
      exact
        (distinguishedLabelPacketLog_eq_sq_mul_signedHaarLogSum Q m).symm

/-- The final-capsule and distinguished-procession product regions have equal
logarithmic Haar volume. -/
theorem finalCapsuleProductRegion_logVolume_eq_distinguishedProcession
    (Q : QPilotData D) :
    (finalCapsuleProductRegion Q).logVolume =
      (distinguishedProcessionProductRegion Q).logVolume := by
  rw [finalCapsuleProductRegion_logVolume_eq_processionLogSum,
    distinguishedProcessionProductRegion_logVolume]

/-- Use the same number-field and procession-length normalization as the
source-faithful procession scalar. -/
noncomputable def normalizedFinalCapsuleMass (Q : QPilotData D) : ℝ :=
  -((1 / (processionLength D : ℝ)) *
      (finalCapsuleProductRegion Q).logVolume) /
    (Module.finrank ℚ D.F : ℝ)

/-- The normalized final-capsule geometric mass equals the normalized
procession mass already used by the source-faithful arithmetic theorem. -/
theorem normalizedFinalCapsuleMass_eq_normalizedProcessionMass
    (Q : QPilotData D) :
    normalizedFinalCapsuleMass Q = normalizedProcessionMass Q := by
  unfold normalizedFinalCapsuleMass normalizedProcessionMass processionAverage
  rw [finalCapsuleProductRegion_logVolume_eq_processionLogSum]

/-- Exact arithmetic q-divisor formula for the final-capsule product region. -/
theorem normalizedFinalCapsuleMass_eq_squareAverage_mul_arithmeticLogQ
    (Q : QPilotData D) :
    normalizedFinalCapsuleMass Q =
      squareAverage D * arithmeticLogQ Q := by
  rw [normalizedFinalCapsuleMass_eq_normalizedProcessionMass,
    normalizedProcessionMass_eq_squareAverage_mul_arithmeticLogQ]

/-- Public q-pilot form for the canonical residue-degree reweighting. -/
theorem canonicalQPilot_normalizedFinalCapsuleMass_eq_publicLogQ
    (Q : QPilotData D) :
    normalizedFinalCapsuleMass (canonicalQPilot Q) =
      squareAverage D * (canonicalQPilot Q).logQ := by
  rw [normalizedFinalCapsuleMass_eq_normalizedProcessionMass,
    canonicalQPilot_normalizedProcessionMass_eq_squareAverage_mul_publicLogQ]

end ActualFinalCapsuleProductRegion

end
end IUTThreeClosures
