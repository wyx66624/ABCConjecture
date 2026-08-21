/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PublicIUTIVTheorem110
import IUTThreeClosures.CompleteGlobalJPacket
import IUTThreeClosures.FreyDiscriminantConductor
import IUTThreeClosures.QuantifierCorrectClosure

/-!
# The exact public IUT IV coefficient bridge for the Frey packet

This module connects three quantities without identifying any two of them by
definition:

* the actual public theta coefficient, obtained from the procession-normalized
  volume of the public holomorphic theta hull;
* the radical conductor of the integral Frey discriminant;
* the complete all-place packet of the Frey `j`-invariant.

The source prime `ell` and the degree `d_mod = [F_mod : Q]` are canonical
projections of the selected initial theta data.  The only geometric input is a
componentwise upper estimate for the actual public theta hull whose procession
average satisfies the coefficient formula of IUT IV, Theorem 1.10.

The resulting theorem is the exact printed q-bound with

`rawQ = completeGlobalJPacket Q (abcFreyCurve P).j`

and

`conductor = P.freyDiscriminantConductor`.

No q-bound, abc inequality, arbitrary height function, or arbitrary conductor
function is stored in the input structure.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- Canonical real source prime. -/
noncomputable def initialThetaEllReal
    (D : InitialThetaData AG TG) : ℝ := (D.ℓ : ℝ)

/-- Canonical degree of the field of moduli. -/
noncomputable def initialThetaModuliDegree
    (D : InitialThetaData AG TG) : ℝ :=
  (Module.finrank ℚ ↥(fieldOfModuli D.F D.E) : ℝ)

/-- A number field has positive degree, so the canonical moduli degree is at
least one. -/
theorem initialThetaModuliDegree_ge_one
    (D : InitialThetaData AG TG) :
    1 ≤ initialThetaModuliDegree D := by
  unfold initialThetaModuliDegree
  exact_mod_cast
    (show 1 ≤ Module.finrank ℚ ↥(fieldOfModuli D.F D.E) from
      Nat.one_le_iff_ne_zero.mpr
        (Module.finrank_pos.ne'))

/-- The logarithmic radical conductor of the Frey discriminant is
nonnegative. -/
theorem freyDiscriminantConductor_nonneg (P : ABCPoint) :
    0 ≤ P.freyDiscriminantConductor := by
  unfold ABCPoint.freyDiscriminantConductor
  apply Real.log_nonneg
  exact_mod_cast
    (Nat.one_le_iff_ne_zero.mpr
      (abcRadical_pos P.freyDiscriminantNat).ne')

/-- Exact source data required to specialize the public component calculation
to IUT IV, Theorem 1.10 and the Frey all-place packet. -/
structure PublicFreyTheorem110Bridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  /-- Arithmetic input selected by the actual source. -/
  encode : ABCPoint → Input
  /-- Positivity of the actual public root-normalized q-pilot. -/
  qPositive : ∀ P : ABCPoint,
    0 < (F.qPilot (encode P)).absLogQ
  /-- Actual local component estimates for the public holomorphic theta hull. -/
  estimate : ∀ P : ABCPoint,
    ThetaHullComponentUpperEstimate
      (F.source (encode P)).toVariantData.rhsData
  /-- The actual different term in the IUT IV source estimate. -/
  different : ABCPoint → ℝ
  different_nonneg : ∀ P : ABCPoint, 0 ≤ different P
  /-- The remaining actual source error term. -/
  error : ABCPoint → ℝ
  error_nonneg : ∀ P : ABCPoint, 0 ≤ error P
  /-- The selected admissible prime lies in the numerical range of Theorem
  1.10.  This is a prime-selection condition, not a height estimate. -/
  ell_ge_seven : ∀ P : ABCPoint,
    7 ≤ initialThetaEllReal (F.data (encode P))
  /-- The actual local-to-global component calculation.  The source prime and
  moduli degree are canonical, the main conductor is the Frey discriminant
  conductor, and the negative q-term is the complete Frey all-place packet. -/
  componentFormula : ∀ P : ABCPoint,
    (estimate P).processionUpperAverage ≤
      (F.qPilot (encode P)).absLogQ *
        (((initialThetaEllReal (F.data (encode P)) + 1) /
            (4 * (F.qPilot (encode P)).absLogQ)) *
          ((1 + 12 * initialThetaModuliDegree (F.data (encode P)) /
              initialThetaEllReal (F.data (encode P))) *
              (different P + P.freyDiscriminantConductor) +
            10 * error P -
            (1 / 6 : ℝ) *
              (1 - 12 /
                initialThetaEllReal (F.data (encode P)) ^ 2) *
              completeGlobalJPacket ℚ (abcFreyCurve P).j) - 1)

namespace PublicFreyTheorem110Bridge

variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- The actual component formula gives the exact public theta-coefficient
upper bound of IUT IV, Theorem 1.10. -/
theorem publicThetaCoefficient_upper
    (B : PublicFreyTheorem110Bridge F)
    (P : ABCPoint) :
    publicThetaCoefficient
        (F.source (B.encode P)).toVariantData ≤
      ((initialThetaEllReal (F.data (B.encode P)) + 1) /
          (4 * (F.qPilot (B.encode P)).absLogQ)) *
        ((1 + 12 * initialThetaModuliDegree (F.data (B.encode P)) /
            initialThetaEllReal (F.data (B.encode P))) *
            (B.different P + P.freyDiscriminantConductor) +
          10 * B.error P -
          (1 / 6 : ℝ) *
            (1 - 12 /
              initialThetaEllReal (F.data (B.encode P)) ^ 2) *
            completeGlobalJPacket ℚ (abcFreyCurve P).j) - 1 := by
  exact (B.estimate P).publicThetaCoefficient_le_of_processionUpper
    (B.qPositive P) (B.componentFormula P)

/-- Exact Frey specialization of the final q-bound in IUT IV,
Theorem 1.10. -/
theorem completeFreyJPacket_div_six_le
    (B : PublicFreyTheorem110Bridge F)
    (P : ABCPoint) :
    completeGlobalJPacket ℚ (abcFreyCurve P).j / 6 ≤
      (1 + 20 * initialThetaModuliDegree (F.data (B.encode P)) /
          initialThetaEllReal (F.data (B.encode P))) *
        (B.different P + P.freyDiscriminantConductor) +
      20 * B.error P := by
  let X := (F.source (B.encode P)).toVariantData
  have h312 : Corollary312Variant X :=
    F.corollary312Variant (B.encode P)
  exact theorem110_q_bound_of_publicTheta_upper
    X (B.qPositive P) h312
    (B.ell_ge_seven P)
    (initialThetaModuliDegree_ge_one (F.data (B.encode P)))
    (B.different_nonneg P)
    (freyDiscriminantConductor_nonneg P)
    (B.error_nonneg P)
    (B.publicThetaCoefficient_upper P)

/-- Corresponding pointwise abc-height estimate before the prime-choice and
different/error absorption steps. -/
theorem pointwise_height_bound
    (B : PublicFreyTheorem110Bridge F)
    (P : ABCPoint) :
    P.height ≤
      (1 + 20 * initialThetaModuliDegree (F.data (B.encode P)) /
          initialThetaEllReal (F.data (B.encode P))) *
        (B.different P + P.freyDiscriminantConductor) +
      20 * B.error P + Real.log 8 / 6 := by
  have hh := abcHeight_le_completeFreyJPacket P
  have hq := B.completeFreyJPacket_div_six_le P
  linarith

end PublicFreyTheorem110Bridge

end IUTThreeClosures
