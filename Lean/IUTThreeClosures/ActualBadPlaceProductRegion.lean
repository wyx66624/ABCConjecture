/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualBadPlaceProcessionAssembly
import IUTThreeClosures.FiniteProductLogVolume

/-!
# Actual finite bad-place product regions

The existing source-faithful IUT route constructs, at every actual bad place
`w` and every distinguished procession label `m + 1`, the genuine
finite-positive Tate region

`q_w ^ ((m + 1)^2) O_w`.

It also defines the scalar packet log as the sum of the local logarithmic
volumes.  This file closes the intervening geometric step: the local regions
are assembled into an actual dependent finite product rectangle equipped with
the product of the normalized additive Haar measures.  The logarithmic volume
of that rectangle is proved to be exactly the existing packet scalar.

No component-volume formula, packet sum, target inequality, or abc statement
is stored in the product region.  The result follows from the genuine product
measure theorem and the already proved local Tate/Haar calculation.
-/

namespace IUTThreeClosures

noncomputable section

open Iut NumberField TateCurvesTheta
open MeasureTheory
open scoped BigOperators ENNReal NNReal NormedField Pointwise Valued WithZero

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

namespace ActualBadPlaceProductRegion

open ActualBadPlaceQPilotPacket
open ActualBadPlaceProcessionAssembly
open MaximalValuationRingHull

/- The following structures are all canonical structures on the actual adic
completion at the packet coordinate.  They are local instances, not fields of
a source record. -/
local instance productNontriviallyNormedTateField
    (Q : QPilotData D) (w : Index Q) :
    NontriviallyNormedField (place Q w).TateField :=
  Valued.toNontriviallyNormedField (place Q w).TateField ℤᵐ⁰

local instance productTateFieldIsUltrametricDist
    (Q : QPilotData D) (w : Index Q) :
    IsUltrametricDist (place Q w).TateField :=
  LocalCompletionNormValuationBridge.completionIsUltrametricDist
    (place Q w).w.maximalIdeal

local instance productTateFieldProperSpace
    (Q : QPilotData D) (w : Index Q) :
    ProperSpace (place Q w).TateField :=
  LocalCompletionNormValuationBridge.completionProperSpace
    (place Q w).w.maximalIdeal

local instance productTateFieldMeasurableSpace
    (Q : QPilotData D) (w : Index Q) :
    MeasurableSpace (place Q w).TateField :=
  borel (place Q w).TateField

local instance productTateFieldBorelSpace
    (Q : QPilotData D) (w : Index Q) :
    BorelSpace (place Q w).TateField :=
  ⟨rfl⟩

local instance productNormalizedIntegerHaarSigmaFinite
    (Q : QPilotData D) (w : Index Q) :
    SigmaFinite
      (normalizedIntegerHaar (K := (place Q w).TateField)) := by
  unfold normalizedIntegerHaar
  infer_instance

/-- The dependent family of normalized additive Haar measures over the actual
finite bad-place packet. -/
noncomputable def coordinateMeasure (Q : QPilotData D) :
    ∀ w : Index Q, Measure (place Q w).TateField :=
  fun _ => normalizedIntegerHaar

/-- Typeclass exposure of the sigma-finiteness already proved for each
normalized local Haar measure.  This explicit bridge is needed because the
measure family is wrapped by `coordinateMeasure`. -/
local instance coordinateMeasureSigmaFinite
    (Q : QPilotData D) (w : Index Q) :
    SigmaFinite (coordinateMeasure Q w) := by
  change SigmaFinite
    (normalizedIntegerHaar (K := (place Q w).TateField))
  infer_instance

/-- The actual square-label Tate region at one packet coordinate. -/
noncomputable def coordinateRegion
    (Q : QPilotData D) (m : ℕ) (w : Index Q) :
    FinitePositiveRegion (place Q w).TateField
      (coordinateMeasure Q w) :=
  (place Q w).squareLabelRegion (m + 1)

/-- The genuine dependent finite product rectangle

`prod_w q_w^((m+1)^2) O_w`

equipped with the product of the actual normalized additive Haar measures. -/
noncomputable def distinguishedLabelProductRegion
    (Q : QPilotData D) (m : ℕ) :
    FinitePositiveRegion
      (∀ w : Index Q, (place Q w).TateField)
      (Measure.pi (coordinateMeasure Q)) :=
  FinitePositiveRegion.pi (coordinateMeasure Q)
    (coordinateRegion Q m)

/-- The finite-type enumeration of the subtype of bad places is exactly the
attached bad-place finset used by the pre-existing packet sums. -/
private theorem index_univ_eq_badFinset_attach (Q : QPilotData D) :
    (Finset.univ : Finset (Index Q)) = Q.badFinset.attach := by
  ext w
  simp

/-- The coordinate region has precisely the logarithmic volume used by the
source-faithful procession scalar. -/
theorem coordinateRegion_logVolume_eq_componentLog
    (Q : QPilotData D) (m : ℕ) (w : Index Q) :
    (coordinateRegion Q m w).logVolume = componentLog Q m w := by
  change ((place Q w).squareLabelRegion (m + 1)).logVolume =
    componentLog Q m w
  exact (componentLog_eq_squareLabelRegion_logVolume Q m w).symm

/-- **Actual product-region identity.**  The packet scalar is the logarithmic
volume of a genuine finite-positive product rectangle; it is not merely a
formal sum of independently supplied component values. -/
theorem distinguishedLabelProductRegion_logVolume
    (Q : QPilotData D) (m : ℕ) :
    (distinguishedLabelProductRegion Q m).logVolume =
      distinguishedLabelPacketLog Q m := by
  classical
  rw [distinguishedLabelProductRegion,
    FinitePositiveRegion.logVolume_pi]
  rw [distinguishedLabelPacketLog,
    ← index_univ_eq_badFinset_attach Q]
  apply Finset.sum_congr rfl
  intro w hw
  exact coordinateRegion_logVolume_eq_componentLog Q m w

/-- The product rectangle therefore has the exact square-label multiple of
the signed actual q-packet Haar logarithm. -/
theorem distinguishedLabelProductRegion_logVolume_eq_sq_mul_signedHaarLogSum
    (Q : QPilotData D) (m : ℕ) :
    (distinguishedLabelProductRegion Q m).logVolume =
      (((m + 1 : ℕ) : ℝ) ^ 2) * signedHaarLogSum Q := by
  rw [distinguishedLabelProductRegion_logVolume,
    distinguishedLabelPacketLog_eq_sq_mul_signedHaarLogSum]

/-- The sign-corrected, number-field-degree-normalized product volume is the
square-label multiple of the normalized arithmetic degree of the explicit
q-divisor. -/
theorem neg_logVolume_div_finrank_eq_sq_mul_arithmeticLogQ
    (Q : QPilotData D) (m : ℕ) :
    -(distinguishedLabelProductRegion Q m).logVolume /
        (Module.finrank ℚ D.F : ℝ) =
      (((m + 1 : ℕ) : ℝ) ^ 2) * arithmeticLogQ Q := by
  rw [distinguishedLabelProductRegion_logVolume_eq_sq_mul_signedHaarLogSum,
    ← normalizedHaarLogQ_eq_arithmeticLogQ]
  unfold normalizedHaarLogQ
  ring

/-- The same normalized product-volume identity in the public q-pilot scalar,
under exactly the documented weight-degree compatibility hypothesis. -/
theorem neg_logVolume_div_finrank_eq_sq_mul_publicLogQ
    (Q : QPilotData D) (m : ℕ)
    (hcompat : QPilotWeightDegreeCompatible Q) :
    -(distinguishedLabelProductRegion Q m).logVolume /
        (Module.finrank ℚ D.F : ℝ) =
      (((m + 1 : ℕ) : ℝ) ^ 2) * Q.logQ := by
  rw [neg_logVolume_div_finrank_eq_sq_mul_arithmeticLogQ,
    arithmeticLogQ_eq_publicLogQ Q hcompat]

end ActualBadPlaceProductRegion

end
end IUTThreeClosures
