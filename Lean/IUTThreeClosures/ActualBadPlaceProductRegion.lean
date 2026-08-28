/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualBadPlaceProcessionAssembly
import IUTThreeClosures.FiniteProductLogVolume

/-!
# Actual finite bad-place product regions

The existing source-faithful q-pilot development constructs, at every actual
bad finite place, a genuine finite-positive Tate region with normalized
additive Haar measure.  It also proves the exact local logarithmic-volume
formula.  This file performs the missing finite-product assembly.

For a q-pilot packet `Q` and label `j`, the coordinate at `w` is the actual
region

`q_w^(j^2) O_{F_w}`.

Their dependent product is an honest `FinitePositiveRegion` for the product
Haar measure.  Its canonical logarithmic volume is exactly the sum of the
local entries, hence

`logVol(packetRegion Q j) = j^2 * signedHaarLogSum Q`.

At label one this identifies the negative, degree-normalized product volume
with the normalized degree of the explicit arithmetic q-divisor.  No
component-volume field, target inequality, abc statement, or IUT IV bridge is
assumed.
-/

namespace IUTThreeClosures

noncomputable section

open Iut NumberField TateCurvesTheta
open MeasureTheory
open scoped BigOperators ENNReal NNReal NormedField Pointwise Valued WithZero

universe u

namespace ActualBadPlaceProductRegion

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- The actual finite bad-place index type. -/
abbrev Index (Q : QPilotData D) :=
  ActualBadPlaceQPilotPacket.Index Q

/-- The completed local field at one actual bad place. -/
abbrev TateField (Q : QPilotData D) (w : Index Q) :=
  (ActualBadPlaceQPilotPacket.place Q w).TateField

/-!
The following instances are the same source-derived structures used by the
single-place normalization.  Repeating them here only exposes a dependent
family of local fields to `Measure.pi`; it introduces no new arithmetic data.
-/

local instance packetNontriviallyNormedField
    (Q : QPilotData D) (w : Index Q) :
    NontriviallyNormedField (TateField Q w) :=
  Valued.toNontriviallyNormedField (TateField Q w) ℤᵐ⁰

local instance packetNormValued
    (Q : QPilotData D) (w : Index Q) :
    Valued (TateField Q w) ℝ≥0 :=
  NormedField.toValued

local instance packetIsUltrametricDist
    (Q : QPilotData D) (w : Index Q) :
    IsUltrametricDist (TateField Q w) :=
  LocalCompletionNormValuationBridge.completionIsUltrametricDist
    (ActualBadPlaceQPilotPacket.place Q w).w.maximalIdeal

local instance packetProperSpace
    (Q : QPilotData D) (w : Index Q) :
    ProperSpace (TateField Q w) :=
  LocalCompletionNormValuationBridge.completionProperSpace
    (ActualBadPlaceQPilotPacket.place Q w).w.maximalIdeal

local instance packetMeasurableSpace
    (Q : QPilotData D) (w : Index Q) :
    MeasurableSpace (TateField Q w) :=
  borel (TateField Q w)

local instance packetBorelSpace
    (Q : QPilotData D) (w : Index Q) :
    BorelSpace (TateField Q w) :=
  ⟨rfl⟩

/-- The normalized additive Haar measure at one packet coordinate. -/
noncomputable def localMeasure
    (Q : QPilotData D) (w : Index Q) :
    Measure (TateField Q w) :=
  MaximalValuationRingHull.normalizedIntegerHaar

local instance localMeasureSigmaFinite
    (Q : QPilotData D) (w : Index Q) :
    SigmaFinite (localMeasure Q w) := by
  dsimp [localMeasure, MaximalValuationRingHull.normalizedIntegerHaar]
  infer_instance

/-- The honest local label-`j` region at an actual bad place. -/
noncomputable def localRegion
    (Q : QPilotData D) (w : Index Q) (j : ℕ) :
    FinitePositiveRegion (TateField Q w) (localMeasure Q w) := by
  simpa [localMeasure] using
    (ActualBadPlaceQPilotPacket.place Q w).squareLabelRegion j

/-- Its canonical logarithmic volume is the square-label multiple of the
actual local q-pilot Haar entry. -/
@[simp]
theorem localRegion_logVolume_eq
    (Q : QPilotData D) (w : Index Q) (j : ℕ) :
    (localRegion Q w j).logVolume =
      ((j : ℝ) ^ 2) * ActualBadPlaceQPilotPacket.entry Q w := by
  simpa [localRegion, localMeasure, ActualBadPlaceQPilotPacket.entry] using
    (ActualBadHodgeTheaterPlace.squareLabelRegion_logVolume_eq_sq_mul_localHaarLog
      (H := ActualBadPlaceQPilotPacket.place Q w) j)

/-- The dependent finite product of all actual bad-place label regions. -/
noncomputable def packetRegion
    (Q : QPilotData D) (j : ℕ) :
    FinitePositiveRegion
      (∀ w : Index Q, TateField Q w)
      (Measure.pi (localMeasure Q)) :=
  FinitePositiveRegion.pi (localMeasure Q) (fun w => localRegion Q w j)

/-- Product logarithmic volume is the finite sum of the actual local label
volumes. -/
theorem packetRegion_logVolume_eq_sum
    (Q : QPilotData D) (j : ℕ) :
    (packetRegion Q j).logVolume =
      ∑ w : Index Q,
        ((j : ℝ) ^ 2) * ActualBadPlaceQPilotPacket.entry Q w := by
  rw [packetRegion, FinitePositiveRegion.logVolume_pi]
  apply Finset.sum_congr rfl
  intro w hw
  exact localRegion_logVolume_eq Q w j

/-- Summation over the dependent index type is the existing attached-finset
packet sum. -/
theorem sum_entry_eq_signedHaarLogSum
    (Q : QPilotData D) :
    (∑ w : Index Q, ActualBadPlaceQPilotPacket.entry Q w) =
      ActualBadPlaceQPilotPacket.signedHaarLogSum Q := by
  classical
  calc
    (∑ w : Index Q, ActualBadPlaceQPilotPacket.entry Q w) =
        ∑ w in Q.badFinset.attach,
          ActualBadPlaceQPilotPacket.entry Q w := by
      apply Finset.sum_congr
      · ext w
        simp
      · intro w hw
        rfl
    _ = ActualBadPlaceQPilotPacket.signedHaarLogSum Q := by
      rfl

/-- Exact finite-product packet formula at every label. -/
theorem packetRegion_logVolume_eq_sq_mul_signedHaarLogSum
    (Q : QPilotData D) (j : ℕ) :
    (packetRegion Q j).logVolume =
      ((j : ℝ) ^ 2) *
        ActualBadPlaceQPilotPacket.signedHaarLogSum Q := by
  rw [packetRegion_logVolume_eq_sum, ← Finset.mul_sum,
    sum_entry_eq_signedHaarLogSum]

/-- The actual product region corresponding to procession label `m+1`. -/
noncomputable def distinguishedPacketRegion
    (Q : QPilotData D) (m : ℕ) :
    FinitePositiveRegion
      (∀ w : Index Q, TateField Q w)
      (Measure.pi (localMeasure Q)) :=
  packetRegion Q (m + 1)

/-- The scalar previously called `distinguishedLabelPacketLog` is now
realized as the canonical log-volume of an honest finite product region. -/
theorem distinguishedPacketRegion_logVolume_eq_distinguishedLabelPacketLog
    (Q : QPilotData D) (m : ℕ) :
    (distinguishedPacketRegion Q m).logVolume =
      ActualBadPlaceProcessionAssembly.distinguishedLabelPacketLog Q m := by
  rw [distinguishedPacketRegion,
    packetRegion_logVolume_eq_sq_mul_signedHaarLogSum]
  rfl

/-- The label-one q-pilot product region. -/
noncomputable def qPacketRegion
    (Q : QPilotData D) :
    FinitePositiveRegion
      (∀ w : Index Q, TateField Q w)
      (Measure.pi (localMeasure Q)) :=
  packetRegion Q 1

/-- At label one, product log-volume is exactly the signed local packet sum. -/
theorem qPacketRegion_logVolume_eq_signedHaarLogSum
    (Q : QPilotData D) :
    (qPacketRegion Q).logVolume =
      ActualBadPlaceQPilotPacket.signedHaarLogSum Q := by
  simpa [qPacketRegion] using
    (packetRegion_logVolume_eq_sq_mul_signedHaarLogSum Q 1)

/-- The negative product log-volume is the degree of the explicit arithmetic
q-divisor. -/
theorem neg_qPacketRegion_logVolume_eq_arithmeticDivisorDegree
    (Q : QPilotData D) :
    -(qPacketRegion Q).logVolume =
      Iut4Sec1.arithmeticDivisorDegree (qArithmeticDivisor Q) := by
  rw [qPacketRegion_logVolume_eq_signedHaarLogSum]
  exact
    ActualBadPlaceQPilotPacket.neg_signedHaarLogSum_eq_arithmeticDivisorDegree Q

/-- The positive degree-normalized product mass. -/
noncomputable def normalizedPacketLogQ (Q : QPilotData D) : ℝ :=
  -(qPacketRegion Q).logVolume / (Module.finrank ℚ D.F : ℝ)

/-- The honest finite product region reconstructs the arithmetic q-log
without a supplied product-volume formula. -/
theorem normalizedPacketLogQ_eq_arithmeticLogQ
    (Q : QPilotData D) :
    normalizedPacketLogQ Q = arithmeticLogQ Q := by
  rw [normalizedPacketLogQ, qPacketRegion_logVolume_eq_signedHaarLogSum]
  simpa [ActualBadPlaceQPilotPacket.normalizedHaarLogQ] using
    (ActualBadPlaceQPilotPacket.normalizedHaarLogQ_eq_arithmeticLogQ Q)

/-- Under the already-explicit public weight compatibility condition, the
same honest product volume equals the public q scalar. -/
theorem normalizedPacketLogQ_eq_publicLogQ
    (Q : QPilotData D) (hcompat : QPilotWeightDegreeCompatible Q) :
    normalizedPacketLogQ Q = Q.logQ := by
  rw [normalizedPacketLogQ_eq_arithmeticLogQ,
    arithmeticLogQ_eq_publicLogQ Q hcompat]

end ActualBadPlaceProductRegion

end
end IUTThreeClosures
