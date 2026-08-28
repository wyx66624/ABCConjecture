/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualBadPlaceProductRegion

/-!
# Actual product region over the distinguished standard procession

For every distinguished label `m + 1` of the standard procession, the
source-faithful bad-place route already constructs the genuine finite-positive
packet region

`prod_w q_w^((m+1)^2) O_w`

with its normalized product Haar measure.  This file assembles all of those
packet regions into one further finite dependent product, indexed by every
`m : Fin ((ell - 1) / 2)`.

The logarithmic volume of the resulting region is proved from the genuine
finite product measure theorem.  It is exactly the existing procession log
sum.  After procession and number-field normalization it is therefore the
already proved square-average multiple of the arithmetic q-divisor degree.
For the canonically reweighted q-pilot, the same identity is expressed in the
public `logQ` scalar without a compatibility hypothesis.

This is the complete product over the distinguished new label of each standard
capsule.  It is not the product over every label in every capsule, does not
supply cross-label AHS/untilt identifications, and does not prove that these
rectangles exhaust the full IUT III possible-image union.  No component
formula, packet identity, IUT IV estimate, abc inequality, or target-equivalent
existence statement is stored as data.
-/

namespace IUTThreeClosures

noncomputable section

open Iut NumberField TateCurvesTheta
open MeasureTheory
open scoped BigOperators ENNReal NNReal NormedField Pointwise Valued WithZero

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

namespace ActualDistinguishedProcessionProductRegion

open ActualBadPlaceQPilotPacket
open ActualBadPlaceProcessionAssembly
open ActualBadPlaceProductRegion
open MaximalValuationRingHull

/- The local structures below are canonical structures on the actual adic
completion at a bad-place packet coordinate.  They are repeated here because
the corresponding instances in the one-label product module are intentionally
local rather than exported source assumptions. -/
local instance processionProductNontriviallyNormedTateField
    (Q : QPilotData D) (w : Index Q) :
    NontriviallyNormedField (place Q w).TateField :=
  Valued.toNontriviallyNormedField (place Q w).TateField ℤᵐ⁰

local instance processionProductTateFieldIsUltrametricDist
    (Q : QPilotData D) (w : Index Q) :
    IsUltrametricDist (place Q w).TateField :=
  LocalCompletionNormValuationBridge.completionIsUltrametricDist
    (place Q w).w.maximalIdeal

local instance processionProductTateFieldProperSpace
    (Q : QPilotData D) (w : Index Q) :
    ProperSpace (place Q w).TateField :=
  LocalCompletionNormValuationBridge.completionProperSpace
    (place Q w).w.maximalIdeal

local instance processionProductTateFieldMeasurableSpace
    (Q : QPilotData D) (w : Index Q) :
    MeasurableSpace (place Q w).TateField :=
  borel (place Q w).TateField

local instance processionProductTateFieldBorelSpace
    (Q : QPilotData D) (w : Index Q) :
    BorelSpace (place Q w).TateField :=
  ⟨rfl⟩

local instance processionProductNormalizedIntegerHaarSigmaFinite
    (Q : QPilotData D) (w : Index Q) :
    SigmaFinite
      (normalizedIntegerHaar (K := (place Q w).TateField)) := by
  unfold normalizedIntegerHaar
  infer_instance

local instance processionProductCoordinateMeasureSigmaFinite
    (Q : QPilotData D) (w : Index Q) :
    SigmaFinite (coordinateMeasure Q w) := by
  change SigmaFinite
    (normalizedIntegerHaar (K := (place Q w).TateField))
  infer_instance

/-- The completed bad-place packet type for one distinguished label. -/
abbrev Packet (Q : QPilotData D) :=
  ∀ w : Index Q, (place Q w).TateField

/-- The normalized product Haar measure on one actual bad-place packet. -/
noncomputable def packetMeasure (Q : QPilotData D) : Measure (Packet Q) :=
  Measure.pi (coordinateMeasure Q)

local instance packetMeasureSigmaFinite (Q : QPilotData D) :
    SigmaFinite (packetMeasure Q) := by
  unfold packetMeasure
  infer_instance

/-- The constant family of actual packet measures indexed by every
distinguished member of the standard procession. -/
noncomputable def processionCoordinateMeasure (Q : QPilotData D) :
    ∀ _m : Fin (processionLength D), Measure (Packet Q) :=
  fun _ => packetMeasure Q

local instance processionCoordinateMeasureSigmaFinite
    (Q : QPilotData D) (m : Fin (processionLength D)) :
    SigmaFinite (processionCoordinateMeasure Q m) := by
  change SigmaFinite (packetMeasure Q)
  infer_instance

/-- The actual bad-place packet region at one distinguished procession
coordinate. -/
noncomputable def processionCoordinateRegion
    (Q : QPilotData D) (m : Fin (processionLength D)) :
    FinitePositiveRegion (Packet Q) (processionCoordinateMeasure Q m) := by
  change FinitePositiveRegion (Packet Q) (packetMeasure Q)
  exact distinguishedLabelProductRegion Q m.1

/-- The genuine two-level finite product

`prod_(0 <= m < (ell-1)/2) prod_w q_w^((m+1)^2) O_w`.

The inner product is over the actual finite bad locus and the outer product is
over every distinguished new label of the standard procession. -/
noncomputable def distinguishedProcessionProductRegion
    (Q : QPilotData D) :
    FinitePositiveRegion
      (∀ m : Fin (processionLength D), Packet Q)
      (Measure.pi (processionCoordinateMeasure Q)) :=
  FinitePositiveRegion.pi (processionCoordinateMeasure Q)
    (processionCoordinateRegion Q)

/-- Each outer coordinate is exactly the previously constructed genuine
bad-place product region. -/
theorem processionCoordinateRegion_logVolume
    (Q : QPilotData D) (m : Fin (processionLength D)) :
    (processionCoordinateRegion Q m).logVolume =
      distinguishedLabelPacketLog Q m.1 := by
  change (distinguishedLabelProductRegion Q m.1).logVolume =
    distinguishedLabelPacketLog Q m.1
  exact distinguishedLabelProductRegion_logVolume Q m.1

/-- **Actual full distinguished-procession identity.**  The existing scalar
`processionLogSum` is the logarithmic Haar volume of one genuine finite-positive
two-level dependent product region. -/
theorem distinguishedProcessionProductRegion_logVolume
    (Q : QPilotData D) :
    (distinguishedProcessionProductRegion Q).logVolume =
      processionLogSum Q := by
  classical
  rw [distinguishedProcessionProductRegion,
    FinitePositiveRegion.logVolume_pi]
  simp [processionCoordinateRegion_logVolume, processionLogSum,
    ← Fin.sum_univ_eq_sum_range]

/-- The unnormalized total product volume is the procession length times the
existing normalized procession average. -/
theorem distinguishedProcessionProductRegion_logVolume_eq_length_mul_average
    (Q : QPilotData D) :
    (distinguishedProcessionProductRegion Q).logVolume =
      (processionLength D : ℝ) * processionAverage Q := by
  rw [distinguishedProcessionProductRegion_logVolume, processionAverage]
  have hn0 : (processionLength D : ℝ) ≠ 0 := by
    exact_mod_cast (processionLength_pos (D := D)).ne'
  field_simp [hn0]

/-- Consequently the total product logarithmic volume is the exact square
average coefficient times the signed actual q-packet Haar logarithm, with the
outer procession length restored. -/
theorem distinguishedProcessionProductRegion_logVolume_eq_length_mul_squareAverage
    (Q : QPilotData D) :
    (distinguishedProcessionProductRegion Q).logVolume =
      (processionLength D : ℝ) *
        (squareAverage D * signedHaarLogSum Q) := by
  rw [distinguishedProcessionProductRegion_logVolume_eq_length_mul_average,
    processionAverage_eq_squareAverage_mul_signedHaarLogSum]

/-- The same normalization used by the existing procession mass, now applied
directly to the logarithmic volume of the genuine two-level product region. -/
noncomputable def normalizedDistinguishedProcessionMass
    (Q : QPilotData D) : ℝ :=
  -((1 / (processionLength D : ℝ)) *
      (distinguishedProcessionProductRegion Q).logVolume) /
    (Module.finrank ℚ D.F : ℝ)

/-- The geometric two-level product normalization is definitionally the
previous source-faithful procession normalization after the product-volume
theorem. -/
theorem normalizedDistinguishedProcessionMass_eq_normalizedProcessionMass
    (Q : QPilotData D) :
    normalizedDistinguishedProcessionMass Q =
      normalizedProcessionMass Q := by
  unfold normalizedDistinguishedProcessionMass
    normalizedProcessionMass processionAverage
  rw [distinguishedProcessionProductRegion_logVolume]

/-- The normalized logarithmic volume of the genuine product region is the
square-average multiple of the normalized arithmetic q-divisor degree. -/
theorem normalizedDistinguishedProcessionMass_eq_squareAverage_mul_arithmeticLogQ
    (Q : QPilotData D) :
    normalizedDistinguishedProcessionMass Q =
      squareAverage D * arithmeticLogQ Q := by
  rw [normalizedDistinguishedProcessionMass_eq_normalizedProcessionMass,
    normalizedProcessionMass_eq_squareAverage_mul_arithmeticLogQ]

/-- For the canonically reweighted q-pilot, the same geometric product-volume
identity is expressed unconditionally in the public `logQ` scalar. -/
theorem canonicalQPilot_normalizedDistinguishedProcessionMass_eq_publicLogQ
    (Q : QPilotData D) :
    normalizedDistinguishedProcessionMass (canonicalQPilot Q) =
      squareAverage D * (canonicalQPilot Q).logQ := by
  rw [normalizedDistinguishedProcessionMass_eq_normalizedProcessionMass,
    canonicalQPilot_normalizedProcessionMass_eq_squareAverage_mul_publicLogQ]

end ActualDistinguishedProcessionProductRegion

end
end IUTThreeClosures
