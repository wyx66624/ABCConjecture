/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualBadPlaceProductRegion

/-!
# Product-versus-union geometry of the actual bad-place procession

The source-faithful local construction supplies, for every distinguished
procession label `m + 1`, a genuine finite-positive bad-place packet region

`U_m = prod_w q_w^((m+1)^2) O_w`.

There are two mathematically different ways to combine the labels.

* In one fixed packet ambient space the regions are nested, hence their union
  is just the first region `U_0`.  A same-ambient union therefore cannot retain
  the square-sum procession amplification.
* If the labels are retained as genuinely independent coordinates, their
  finite product is again a finite-positive region, and its logarithmic volume
  is the sum of all label packet logarithms.  Its degree- and
  procession-normalized mass is exactly the already proved procession mass.

This theorem isolates the remaining geometric source problem.  The scalar
square-average algebra is already realized by an honest product measure, but
an IUT III possible-image or mono-analytic-hull argument must justify the
independence of the label coordinates.  Identifying all labels inside one
fixed local field collapses the union to its first member.

No component formula, target inequality, abc statement, or source-existence
claim is stored in the constructions below.
-/

namespace IUTThreeClosures

noncomputable section

open Iut NumberField TateCurvesTheta
open MeasureTheory Set
open scoped BigOperators ENNReal NNReal NormedField Pointwise Valued WithZero

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

namespace ActualBadPlaceProcessionGeometry

open ActualBadPlaceQPilotPacket
open ActualBadPlaceProcessionAssembly
open ActualBadPlaceProductRegion
open MaximalValuationRingHull

/- The following instances are canonical structures on the actual adic
completion at a packet coordinate.  They are local typeclass bridges, not
fields of a source record. -/
local instance geometryNontriviallyNormedTateField
    (Q : QPilotData D) (w : Index Q) :
    NontriviallyNormedField (place Q w).TateField :=
  Valued.toNontriviallyNormedField (place Q w).TateField ℤᵐ⁰

local instance geometryTateFieldIsUltrametricDist
    (Q : QPilotData D) (w : Index Q) :
    IsUltrametricDist (place Q w).TateField :=
  LocalCompletionNormValuationBridge.completionIsUltrametricDist
    (place Q w).w.maximalIdeal

local instance geometryTateFieldProperSpace
    (Q : QPilotData D) (w : Index Q) :
    ProperSpace (place Q w).TateField :=
  LocalCompletionNormValuationBridge.completionProperSpace
    (place Q w).w.maximalIdeal

local instance geometryTateFieldMeasurableSpace
    (Q : QPilotData D) (w : Index Q) :
    MeasurableSpace (place Q w).TateField :=
  borel (place Q w).TateField

local instance geometryTateFieldBorelSpace
    (Q : QPilotData D) (w : Index Q) :
    BorelSpace (place Q w).TateField :=
  ⟨rfl⟩

local instance geometryNormalizedIntegerHaarSigmaFinite
    (Q : QPilotData D) (w : Index Q) :
    SigmaFinite
      (normalizedIntegerHaar (K := (place Q w).TateField)) := by
  unfold normalizedIntegerHaar
  infer_instance

local instance geometryCoordinateMeasureSigmaFinite
    (Q : QPilotData D) (w : Index Q) :
    SigmaFinite (coordinateMeasure Q w) := by
  change SigmaFinite
    (normalizedIntegerHaar (K := (place Q w).TateField))
  infer_instance

/-- Later distinguished labels give smaller regions in the same local Tate
field. -/
theorem coordinateRegion_antitone
    (Q : QPilotData D) {m n : ℕ} (hmn : m ≤ n) (w : Index Q) :
    (coordinateRegion Q n w : Set (place Q w).TateField) ⊆
      (coordinateRegion Q m w : Set (place Q w).TateField) := by
  have hsquare : (m + 1) ^ 2 ≤ (n + 1) ^ 2 := by
    nlinarith
  change
    ((place Q w).squareLabelRegion (n + 1) :
      Set (place Q w).TateField) ⊆
    ((place Q w).squareLabelRegion (m + 1) :
      Set (place Q w).TateField)
  rw [(place Q w).coe_squareLabelRegion,
    (place Q w).coe_squareLabelRegion]
  exact (place Q w).tate.qPowerRegion_antitone hsquare

/-- The complete bad-place packet rectangles are nested in the label index. -/
theorem distinguishedLabelProductRegion_antitone
    (Q : QPilotData D) {m n : ℕ} (hmn : m ≤ n) :
    (distinguishedLabelProductRegion Q n :
        Set (∀ w : Index Q, (place Q w).TateField)) ⊆
      (distinguishedLabelProductRegion Q m :
        Set (∀ w : Index Q, (place Q w).TateField)) := by
  change
    (Set.pi Set.univ fun w =>
      (coordinateRegion Q n w : Set (place Q w).TateField)) ⊆
    (Set.pi Set.univ fun w =>
      (coordinateRegion Q m w : Set (place Q w).TateField))
  intro x hx
  rw [Set.mem_pi] at hx ⊢
  intro w hw
  exact coordinateRegion_antitone Q hmn w (hx w hw)

/-- In one fixed packet ambient space, the union of all distinguished-label
regions in the nonempty standard procession is exactly its first member. -/
theorem distinguishedProcessionUnion_eq_first
    (Q : QPilotData D) :
    (⋃ m : Fin (processionLength D),
        (distinguishedLabelProductRegion Q m.1 :
          Set (∀ w : Index Q, (place Q w).TateField))) =
      (distinguishedLabelProductRegion Q 0 :
        Set (∀ w : Index Q, (place Q w).TateField)) := by
  apply Set.Subset.antisymm
  · intro x hx
    rcases Set.mem_iUnion.mp hx with ⟨m, hm⟩
    exact distinguishedLabelProductRegion_antitone Q
      (Nat.zero_le m.1) hm
  · intro x hx
    exact Set.mem_iUnion.mpr
      ⟨⟨0, processionLength_pos (D := D)⟩, hx⟩

/-- The same-ambient procession union, represented by the equal first packet
region. -/
noncomputable def distinguishedProcessionUnionRegion
    (Q : QPilotData D) :
    FinitePositiveRegion
      (∀ w : Index Q, (place Q w).TateField)
      (Measure.pi (coordinateMeasure Q)) :=
  distinguishedLabelProductRegion Q 0

/-- The carrier of the union region is the actual union of all distinguished
label packet carriers. -/
theorem coe_distinguishedProcessionUnionRegion
    (Q : QPilotData D) :
    (distinguishedProcessionUnionRegion Q :
        Set (∀ w : Index Q, (place Q w).TateField)) =
      ⋃ m : Fin (processionLength D),
        (distinguishedLabelProductRegion Q m.1 :
          Set (∀ w : Index Q, (place Q w).TateField)) := by
  rw [distinguishedProcessionUnionRegion,
    distinguishedProcessionUnion_eq_first]

/-- Consequently the same-ambient union carries only the first packet
logarithm, not the square-sum procession logarithm. -/
theorem distinguishedProcessionUnionRegion_logVolume
    (Q : QPilotData D) :
    (distinguishedProcessionUnionRegion Q).logVolume =
      signedHaarLogSum Q := by
  rw [distinguishedProcessionUnionRegion,
    distinguishedLabelProductRegion_logVolume_eq_sq_mul_signedHaarLogSum]
  norm_num

/-- The repeated packet product measure, one independent bad-place packet for
every distinguished procession label. -/
noncomputable def labelPacketMeasure (Q : QPilotData D) :
    ∀ _ : Fin (processionLength D),
      Measure (∀ w : Index Q, (place Q w).TateField) :=
  fun _ => Measure.pi (coordinateMeasure Q)

local instance geometryPacketMeasureSigmaFinite
    (Q : QPilotData D) :
    SigmaFinite (Measure.pi (coordinateMeasure Q)) := by
  infer_instance

local instance geometryLabelPacketMeasureSigmaFinite
    (Q : QPilotData D) (m : Fin (processionLength D)) :
    SigmaFinite (labelPacketMeasure Q m) := by
  change SigmaFinite (Measure.pi (coordinateMeasure Q))
  infer_instance

/-- The genuine independent-label product rectangle

`prod_(m < n) prod_w q_w^((m+1)^2) O_w`.
-/
noncomputable def distinguishedProcessionProductRegion
    (Q : QPilotData D) :
    FinitePositiveRegion
      (∀ m : Fin (processionLength D),
        ∀ w : Index Q, (place Q w).TateField)
      (Measure.pi (labelPacketMeasure Q)) :=
  FinitePositiveRegion.pi (labelPacketMeasure Q)
    (fun m => distinguishedLabelProductRegion Q m.1)

/-- The logarithmic volume of the independent-label product is the full
procession sum. -/
theorem distinguishedProcessionProductRegion_logVolume
    (Q : QPilotData D) :
    (distinguishedProcessionProductRegion Q).logVolume =
      processionLogSum Q := by
  calc
    (distinguishedProcessionProductRegion Q).logVolume =
        ∑ m : Fin (processionLength D),
          (distinguishedLabelProductRegion Q m.1).logVolume := by
      rw [distinguishedProcessionProductRegion,
        FinitePositiveRegion.logVolume_pi]
    _ = ∑ m ∈ Finset.range (processionLength D),
          (distinguishedLabelProductRegion Q m).logVolume := by
      change
        (∑ m : Fin (processionLength D),
          (distinguishedLabelProductRegion Q m.1).logVolume) =
        ∑ m : Fin (processionLength D),
          (distinguishedLabelProductRegion Q m.1).logVolume
      rfl
    _ = processionLogSum Q := by
      rw [processionLogSum]
      apply Finset.sum_congr rfl
      intro m hm
      exact distinguishedLabelProductRegion_logVolume Q m

/-- The independent-label product has nonpositive logarithmic volume. -/
theorem distinguishedProcessionProductRegion_logVolume_le_zero
    (Q : QPilotData D) :
    (distinguishedProcessionProductRegion Q).logVolume ≤ 0 := by
  rw [distinguishedProcessionProductRegion_logVolume,
    processionLogSum]
  apply Finset.sum_nonpos
  intro m hm
  rw [distinguishedLabelPacketLog]
  apply Finset.sum_nonpos
  intro w hw
  rw [componentLog_eq_squareLabelRegion_logVolume]
  exact (place Q w).squareLabelRegion_logVolume_le_zero (m + 1)

/-- The degree- and procession-normalized mass of the genuine independent
label product. -/
noncomputable def normalizedProcessionProductMass
    (Q : QPilotData D) : ℝ :=
  -((1 / (processionLength D : ℝ)) *
      (distinguishedProcessionProductRegion Q).logVolume) /
    (Module.finrank ℚ D.F : ℝ)

/-- The geometric product mass is exactly the previously assembled procession
mass. -/
theorem normalizedProcessionProductMass_eq_normalizedProcessionMass
    (Q : QPilotData D) :
    normalizedProcessionProductMass Q = normalizedProcessionMass Q := by
  rw [normalizedProcessionProductMass,
    distinguishedProcessionProductRegion_logVolume,
    normalizedProcessionMass,
    processionAverage]

/-- The genuine independent-label product therefore recovers the exact
square-average multiple of the arithmetic q-divisor degree. -/
theorem normalizedProcessionProductMass_eq_squareAverage_mul_arithmeticLogQ
    (Q : QPilotData D) :
    normalizedProcessionProductMass Q =
      squareAverage D * arithmeticLogQ Q := by
  rw [normalizedProcessionProductMass_eq_normalizedProcessionMass,
    normalizedProcessionMass_eq_squareAverage_mul_arithmeticLogQ]

/-- After canonical residue-degree reweighting, the same geometric identity is
expressed in the public q-pilot scalar without an extra compatibility
hypothesis. -/
theorem canonicalQPilot_normalizedProcessionProductMass_eq_squareAverage_mul_publicLogQ
    (Q : QPilotData D) :
    normalizedProcessionProductMass (canonicalQPilot Q) =
      squareAverage D * (canonicalQPilot Q).logQ := by
  rw [normalizedProcessionProductMass_eq_normalizedProcessionMass,
    canonicalQPilot_normalizedProcessionMass_eq_squareAverage_mul_publicLogQ]

end ActualBadPlaceProcessionGeometry

end
end IUTThreeClosures
