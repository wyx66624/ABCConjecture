/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.QuantifierCorrectPublicFreyTheorem110
import IUTThreeClosures.FiniteExceptionalSet

/-!
# Public Frey Theorem 1.10 outside a finite exceptional set

The actual admissible-prime source need not exist for the finitely many Frey
curves whose rational j-invariant may be integral (and hence may be CM).  It is
therefore too strong to require one total `PublicFreyTheorem110Bridge` on all
abc points.

This module formulates the exact public Theorem 1.10 bridge on a subtype of
abc points satisfying an arbitrary predicate `Good`.  Its quantifier-correct
version still selects source data separately for every positive epsilon, but
requires different/error bounds only on `Good` points.  When `Good P` is
`P ∉ exceptional` for a finite set, the resulting pointwise estimate extends
to every abc point by increasing the additive constant.

No q-bound or abc inequality is a structure field.  The outside estimate is
derived from the actual public theta coefficient, the complete Frey j-packet,
and the Frey radical-conductor comparison; the finite-set extension is the
already verified elementary lemma `extend_inequality_across_finset`.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}
variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}
variable {Good : ABCPoint → Prop}

/-- The abc points on which an actual IUT source has been constructed. -/
def ABCPointSatisfying (Good : ABCPoint → Prop) :=
  {P : ABCPoint // Good P}

/-- Exact public Frey Theorem 1.10 source data on a restricted abc locus. -/
structure PublicFreyTheorem110OnBridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input)
    (Good : ABCPoint → Prop) :
    Type (max u v w z) where
  /-- Arithmetic input selected for each good abc point. -/
  encode : ABCPointSatisfying Good → Input
  /-- Positivity of the actual root-normalized q-pilot. -/
  qPositive : ∀ P : ABCPointSatisfying Good,
    0 < (F.qPilot (encode P)).absLogQ
  /-- Actual local component estimates for the public theta hull. -/
  estimate : ∀ P : ABCPointSatisfying Good,
    ThetaHullComponentUpperEstimate
      (F.source (encode P)).toVariantData.rhsData
  /-- Actual different term on the good locus. -/
  different : ABCPointSatisfying Good → ℝ
  different_nonneg : ∀ P : ABCPointSatisfying Good,
    0 ≤ different P
  /-- Remaining actual source error term on the good locus. -/
  error : ABCPointSatisfying Good → ℝ
  error_nonneg : ∀ P : ABCPointSatisfying Good,
    0 ≤ error P
  /-- Numerical prime range required by Theorem 1.10. -/
  ell_ge_seven : ∀ P : ABCPointSatisfying Good,
    7 ≤ initialThetaEllReal (F.data (encode P))
  /-- The actual local-to-global component calculation on the good locus. -/
  componentFormula : ∀ P : ABCPointSatisfying Good,
    (estimate P).processionUpperAverage ≤
      (F.qPilot (encode P)).absLogQ *
        (((initialThetaEllReal (F.data (encode P)) + 1) /
            (4 * (F.qPilot (encode P)).absLogQ)) *
          ((1 + 12 * initialThetaModuliDegree (F.data (encode P)) /
              initialThetaEllReal (F.data (encode P))) *
              (different P + P.1.freyDiscriminantConductor) +
            10 * error P -
            (1 / 6 : ℝ) *
              (1 - 12 /
                initialThetaEllReal (F.data (encode P)) ^ 2) *
              completeGlobalJPacket ℚ (abcFreyCurve P.1).j) - 1)

namespace PublicFreyTheorem110OnBridge

/-- The restricted component formula gives the exact public theta-coefficient
upper bound. -/
theorem publicThetaCoefficient_upper
    (B : PublicFreyTheorem110OnBridge F Good)
    (P : ABCPointSatisfying Good) :
    publicThetaCoefficient
        (F.source (B.encode P)).toVariantData ≤
      ((initialThetaEllReal (F.data (B.encode P)) + 1) /
          (4 * (F.qPilot (B.encode P)).absLogQ)) *
        ((1 + 12 * initialThetaModuliDegree (F.data (B.encode P)) /
            initialThetaEllReal (F.data (B.encode P))) *
            (B.different P + P.1.freyDiscriminantConductor) +
          10 * B.error P -
          (1 / 6 : ℝ) *
            (1 - 12 /
              initialThetaEllReal (F.data (B.encode P)) ^ 2) *
            completeGlobalJPacket ℚ (abcFreyCurve P.1).j) - 1 := by
  exact (B.estimate P).publicThetaCoefficient_le_of_processionUpper
    (B.qPositive P) (B.componentFormula P)

/-- Exact Frey specialization of the final public Theorem 1.10 q-bound on the
good locus. -/
theorem completeFreyJPacket_div_six_le
    (B : PublicFreyTheorem110OnBridge F Good)
    (P : ABCPointSatisfying Good) :
    completeGlobalJPacket ℚ (abcFreyCurve P.1).j / 6 ≤
      (1 + 20 * initialThetaModuliDegree (F.data (B.encode P)) /
          initialThetaEllReal (F.data (B.encode P))) *
        (B.different P + P.1.freyDiscriminantConductor) +
      20 * B.error P := by
  let X := (F.source (B.encode P)).toVariantData
  have h312 : Corollary312Variant X :=
    F.corollary312Variant (B.encode P)
  exact theorem110_q_bound_of_publicTheta_upper
    X (B.qPositive P) h312
    (B.ell_ge_seven P)
    (initialThetaModuliDegree_ge_one (F.data (B.encode P)))
    (B.different_nonneg P)
    (freyDiscriminantConductor_nonneg P.1)
    (B.error_nonneg P)
    (B.publicThetaCoefficient_upper P)

/-- Pointwise abc-height estimate on the good locus, before epsilon-dependent
prime selection and source-term absorption. -/
theorem pointwise_height_bound
    (B : PublicFreyTheorem110OnBridge F Good)
    (P : ABCPointSatisfying Good) :
    P.1.height ≤
      (1 + 20 * initialThetaModuliDegree (F.data (B.encode P)) /
          initialThetaEllReal (F.data (B.encode P))) *
        (B.different P + P.1.freyDiscriminantConductor) +
      20 * B.error P + Real.log 8 / 6 := by
  have hh := abcHeight_le_completeFreyJPacket P.1
  have hq := B.completeFreyJPacket_div_six_le P
  linarith

end PublicFreyTheorem110OnBridge

/-- The varying correction coefficient on a restricted abc locus. -/
noncomputable def publicFreyTheorem110OnCorrection
    (B : PublicFreyTheorem110OnBridge F Good)
    (P : ABCPointSatisfying Good) : ℝ :=
  20 * initialThetaModuliDegree (F.data (B.encode P)) /
    initialThetaEllReal (F.data (B.encode P))

/-- The restricted correction coefficient is nonnegative. -/
theorem publicFreyTheorem110OnCorrection_nonneg
    (B : PublicFreyTheorem110OnBridge F Good)
    (P : ABCPointSatisfying Good) :
    0 ≤ publicFreyTheorem110OnCorrection B P := by
  have hdegree :
      0 ≤ initialThetaModuliDegree (F.data (B.encode P)) := by
    linarith [initialThetaModuliDegree_ge_one (F.data (B.encode P))]
  have hell :
      0 ≤ initialThetaEllReal (F.data (B.encode P)) := by
    linarith [B.ell_ge_seven P]
  exact div_nonneg (mul_nonneg (by norm_num) hdegree) hell

/-- Epsilon-dependent exact public Theorem 1.10 sources on a restricted abc
locus. -/
structure QuantifierCorrectPublicFreyTheorem110OnBridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input)
    (Good : ABCPoint → Prop) :
    Type (max u v w z) where
  /-- Select an actual restricted source for every positive epsilon. -/
  bridge : ∀ ε : ℝ, 0 < ε → PublicFreyTheorem110OnBridge F Good
  /-- The source prime is large enough relative to its moduli degree. -/
  correction_le_epsilon :
    ∀ (ε : ℝ) (hε : 0 < ε) (P : ABCPointSatisfying Good),
      publicFreyTheorem110OnCorrection (bridge ε hε) P ≤ ε
  /-- At fixed epsilon, actual different and error terms are uniformly bounded
  on the good locus. -/
  bounded_different_error :
    ∀ (ε : ℝ) (hε : 0 < ε),
      ∃ D E : ℝ,
        (∀ P : ABCPointSatisfying Good,
          (bridge ε hε).different P ≤ D) ∧
        (∀ P : ABCPointSatisfying Good,
          (bridge ε hε).error P ≤ E)

namespace QuantifierCorrectPublicFreyTheorem110OnBridge

/-- Uniform pointwise height bound on the good locus. -/
theorem pointwise_height_bound
    (U : QuantifierCorrectPublicFreyTheorem110OnBridge F Good)
    {ε : ℝ} (hε : 0 < ε)
    {D E : ℝ}
    (hD : ∀ P : ABCPointSatisfying Good,
      (U.bridge ε hε).different P ≤ D)
    (hE : ∀ P : ABCPointSatisfying Good,
      (U.bridge ε hε).error P ≤ E)
    (P : ABCPointSatisfying Good) :
    P.1.height ≤
      (1 + ε) * P.1.conductor +
        ((1 + ε) * (D + Real.log 16) +
          20 * E + Real.log 8 / 6) := by
  let B : PublicFreyTheorem110OnBridge F Good := U.bridge ε hε
  have hpoint :
      P.1.height ≤
        (1 + publicFreyTheorem110OnCorrection B P) *
            (B.different P + P.1.freyDiscriminantConductor) +
          20 * B.error P + Real.log 8 / 6 := by
    simpa [B, publicFreyTheorem110OnCorrection] using
      B.pointwise_height_bound P
  have hcorrection :
      publicFreyTheorem110OnCorrection B P ≤ ε := by
    simpa [B] using U.correction_le_epsilon ε hε P
  have hbase_nonneg :
      0 ≤ B.different P + P.1.freyDiscriminantConductor :=
    add_nonneg (B.different_nonneg P)
      (freyDiscriminantConductor_nonneg P.1)
  have hcoefficient :
      1 + publicFreyTheorem110OnCorrection B P ≤ 1 + ε := by
    linarith
  have hcoefficient_term :
      (1 + publicFreyTheorem110OnCorrection B P) *
          (B.different P + P.1.freyDiscriminantConductor) ≤
        (1 + ε) *
          (B.different P + P.1.freyDiscriminantConductor) :=
    mul_le_mul_of_nonneg_right hcoefficient hbase_nonneg
  have hD' : B.different P ≤ D := by
    simpa [B] using hD P
  have hE' : B.error P ≤ E := by
    simpa [B] using hE P
  have hsum :
      B.different P + P.1.freyDiscriminantConductor ≤
        D + (P.1.conductor + Real.log 16) :=
    add_le_add hD' P.1.freyDiscriminantConductor_le
  have htarget_coefficient_nonneg : 0 ≤ 1 + ε := by
    linarith
  have hsum_term :
      (1 + ε) *
          (B.different P + P.1.freyDiscriminantConductor) ≤
        (1 + ε) * (D + (P.1.conductor + Real.log 16)) :=
    mul_le_mul_of_nonneg_left hsum htarget_coefficient_nonneg
  have herror_term : 20 * B.error P ≤ 20 * E :=
    mul_le_mul_of_nonneg_left hE' (by norm_num)
  calc
    P.1.height ≤
        (1 + publicFreyTheorem110OnCorrection B P) *
            (B.different P + P.1.freyDiscriminantConductor) +
          20 * B.error P + Real.log 8 / 6 := hpoint
    _ ≤ (1 + ε) *
          (B.different P + P.1.freyDiscriminantConductor) +
        20 * B.error P + Real.log 8 / 6 := by
      linarith
    _ ≤ (1 + ε) * (D + (P.1.conductor + Real.log 16)) +
        20 * E + Real.log 8 / 6 := by
      linarith
    _ = (1 + ε) * P.1.conductor +
        ((1 + ε) * (D + Real.log 16) +
          20 * E + Real.log 8 / 6) := by
      ring

/-- If the restricted source exists outside a finite set, the finite points
are absorbed into the additive abc constant. -/
theorem abc_outside_finset
    [DecidableEq ABCPoint]
    (s : Finset ABCPoint)
    (U : QuantifierCorrectPublicFreyTheorem110OnBridge
      F (fun P => P ∉ s)) :
    ABCConjecture := by
  intro ε hε
  rcases U.bounded_different_error ε hε with
    ⟨D, E, hD, hE⟩
  let Cout : ℝ :=
    (1 + ε) * (D + Real.log 16) +
      20 * E + Real.log 8 / 6
  have hout :
      ∀ P : ABCPoint, P ∉ s →
        P.height ≤ (1 + ε) * P.conductor + Cout := by
    intro P hP
    let Q : ABCPointSatisfying (fun R => R ∉ s) := ⟨P, hP⟩
    have h := U.pointwise_height_bound hε hD hE Q
    simpa [Q, Cout] using h
  rcases extend_inequality_across_finset s
      (fun P : ABCPoint => P.height)
      (fun P : ABCPoint => (1 + ε) * P.conductor)
      Cout hout with
    ⟨C, hC⟩
  refine ⟨C, ?_⟩
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
  have h := hC P
  simpa [ABCPoint.height, ABCPoint.conductor, P] using h

end QuantifierCorrectPublicFreyTheorem110OnBridge

end IUTThreeClosures
