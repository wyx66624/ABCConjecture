/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PublicThetaHullUpperBound
import IUTThreeClosures.QuantifierCorrectClosure
import IUTThreeClosures.CompleteGlobalJPacket
import IUTThreeClosures.FreyDiscriminantConductor

/-!
# A source-faithful public theta/Frey component bridge

This module connects the actual public theta coefficient to the two canonical
arithmetic quantities needed in the abc application:

* the radical conductor of the integral Frey discriminant;
* the complete all-place packet of the Frey `j`-invariant.

Unlike the earlier calibration that identified the public root-normalized
q-pilot itself with the complete global `j`-height, the bridge below keeps
these two quantities distinct.  The public q-pilot occurs only as the positive
normalizing denominator of the public theta coefficient.  The complete Frey
packet occurs inside the componentwise IUT IV coefficient estimate:

`CTheta ≤ factor * (FreyConductor - completeFreyJPacket / 6) - 1`.

Corollary 3.12 supplies `-1 ≤ CTheta`; hence the complete Frey packet divided
by six is bounded by the Frey conductor.  The already verified Frey height
corridor and radical comparison then imply abc.

The only non-elementary field is the actual component calculation: a family
of pointwise theta-hull component estimates whose procession upper average
satisfies the displayed coefficient bound.  It is strictly local-to-global
source data and contains neither `ABCConjecture` nor an abc height inequality.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- Actual public component estimates calibrated by the Frey conductor and
the complete all-place Frey `j`-packet. -/
structure PublicFreyComponentBridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  /-- Arithmetic input selected by the actual source construction. -/
  encode : ABCPoint → Input
  /-- Positivity of the actual public root-normalized q-pilot. -/
  qPositive : ∀ P : ABCPoint,
    0 < (F.qPilot (encode P)).absLogQ
  /-- Actual local component estimates for the public theta hull. -/
  estimate : ∀ P : ABCPoint,
    ThetaHullComponentUpperEstimate
      (F.source (encode P)).toVariantData.rhsData
  /-- The positive coefficient in the IUT IV component formula. -/
  factor : ABCPoint → ℝ
  factorPositive : ∀ P : ABCPoint, 0 < factor P
  /-- The source-level component calculation, after product weighting,
  all-place summation and procession averaging. -/
  componentFormula : ∀ P : ABCPoint,
    (estimate P).processionUpperAverage ≤
      (F.qPilot (encode P)).absLogQ *
        (factor P *
          (P.freyDiscriminantConductor -
            completeGlobalJPacket ℚ (abcFreyCurve P).j / 6) - 1)

namespace PublicFreyComponentBridge

variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- The actual component formula and public Corollary 3.12 imply that the
complete all-place Frey packet divided by six is bounded by the Frey
conductor. -/
theorem completeFreyJPacket_div_six_le_freyConductor
    (B : PublicFreyComponentBridge F)
    (P : ABCPoint) :
    completeGlobalJPacket ℚ (abcFreyCurve P).j / 6 ≤
      P.freyDiscriminantConductor := by
  let X := (F.source (B.encode P)).toVariantData
  have h312 : Corollary312Variant X :=
    F.corollary312Variant (B.encode P)
  have h := (B.estimate P).qTerm_le_main_of_componentUpper
    (B.qPositive P) h312 (B.factorPositive P)
    (B.componentFormula P)
  change (1 / 6 : ℝ) * completeGlobalJPacket ℚ (abcFreyCurve P).j ≤
    P.freyDiscriminantConductor at h
  nlinarith

/-- Auditable pointwise abc-height bound with completely explicit constants. -/
theorem pointwise_height_bound
    (B : PublicFreyComponentBridge F)
    (P : ABCPoint) :
    P.height ≤
      P.conductor + Real.log 16 + Real.log 8 / 6 := by
  have hheight := abcHeight_le_completeFreyJPacket P
  have hpacket := B.completeFreyJPacket_div_six_le_freyConductor P
  have hcond := P.freyDiscriminantConductor_le
  linarith

/-- The source-faithful public component bridge implies the standard
logarithmic abc conjecture. -/
theorem abc (B : PublicFreyComponentBridge F) : ABCConjecture := by
  intro ε hε
  refine ⟨Real.log 16 + Real.log 8 / 6, ?_⟩
  intro a b c ha hb hc hab hcop
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hab
      pairwise_coprime := hcop }
  have hpoint := B.pointwise_height_bound P
  have hcond : 0 ≤ P.conductor := by
    unfold ABCPoint.conductor
    apply Real.log_nonneg
    exact_mod_cast
      (Nat.one_le_iff_ne_zero.mpr
        (abcRadical_pos (P.a * P.b * P.c)).ne')
  have hfinal :
      P.height ≤
        (1 + ε) * P.conductor +
          (Real.log 16 + Real.log 8 / 6) := by
    nlinarith [mul_nonneg hε.le hcond]
  simpa [ABCPoint.height, ABCPoint.conductor, P] using hfinal

end PublicFreyComponentBridge

end IUTThreeClosures
