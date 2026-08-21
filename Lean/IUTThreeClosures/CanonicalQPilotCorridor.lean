/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.BridgeInhabitationExact
import IUTThreeClosures.Cor312CoefficientAlgebra

/-!
# Canonical q-pilot coefficient corridor

This module removes the freely chosen `logQ` and theta-coefficient functions
from the downstream bridge.  For a pointwise IUT III source family, the
positive q-logarithm is definitionally the public q-pilot scalar
`QPilotData.absLogQ`, while the theta coefficient is definitionally the public
right-hand-side scalar divided by that q-logarithm.

The only non-elementary input is now the source-level coefficient identity.
Given that identity, public Corollary 3.12 implies the canonical lower bound
`-1 <= CTheta`, and hence the canonical q-bound.  Thus the numerical corridor
cannot be populated by setting `logQ := 6 * height` as in the previous audit.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- Source-level data needed after the public IUT III output has been fixed.
The q-logarithm and theta coefficient are not fields: they are canonical
definitions from `F.qPilot` and `F.source` below. -/
structure CanonicalCoefficientCorridor
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  /-- Arithmetic input selected by the actual source construction. -/
  encode : ABCPoint → Input
  /-- Positivity of the actual public q-logarithm. -/
  qPositive : ∀ P, 0 < (F.qPilot (encode P)).absLogQ
  /-- The positive coefficient occurring in the IUT IV coefficient formula. -/
  factor : ABCPoint → ℝ
  factorPositive : ∀ P, 0 < factor P
  /-- The arithmetic main term occurring in the coefficient formula. -/
  mainTerm : ABCPoint → ℝ
  /-- The actual source-level coefficient identity.  The left side is fixed by
  the public generated source and q-pilot; it is not supplied independently. -/
  coefficientFormula : ∀ P,
    (F.source (encode P)).toVariantData.rhsData.rhs /
        (F.qPilot (encode P)).absLogQ =
      factor P *
        (mainTerm P - (F.qPilot (encode P)).absLogQ / 6) - 1

namespace CanonicalCoefficientCorridor

variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- Canonical positive q-logarithm read directly from the source q-pilot. -/
noncomputable def qLog
    (C : CanonicalCoefficientCorridor F) (P : ABCPoint) : ℝ :=
  (F.qPilot (C.encode P)).absLogQ

/-- Canonical theta coefficient: the actual public RHS divided by the actual
q-logarithm. -/
noncomputable def thetaCoefficient
    (C : CanonicalCoefficientCorridor F) (P : ABCPoint) : ℝ :=
  (F.source (C.encode P)).toVariantData.rhsData.rhs / C.qLog P

/-- Corollary 3.12 gives the canonical coefficient lower bound. -/
theorem thetaCoefficient_ge_neg_one
    (C : CanonicalCoefficientCorridor F) (P : ABCPoint)
    (h312 : Corollary312Variant
      (F.source (C.encode P)).toVariantData) :
    -1 ≤ C.thetaCoefficient P := by
  have hraw :
      -C.qLog P ≤
        (F.source (C.encode P)).toVariantData.rhsData.rhs := by
    change (F.qPilot (C.encode P)).lhs ≤
      (F.source (C.encode P)).toVariantData.rhsData.rhs at h312
    simpa [qLog, Iut.QPilotData.lhs] using h312
  rw [thetaCoefficient]
  apply (le_div_iff₀ (C.qPositive P)).2
  nlinarith [hraw]

/-- The canonical coefficient formula converts the Corollary 3.12 lower bound
into the q-height bound. -/
theorem qLog_div_six_le_mainTerm
    (C : CanonicalCoefficientCorridor F) (P : ABCPoint)
    (h312 : Corollary312Variant
      (F.source (C.encode P)).toVariantData) :
    C.qLog P / 6 ≤ C.mainTerm P := by
  exact q_bound_of_coefficient_expression
    (C.factorPositive P)
    (C.thetaCoefficient_ge_neg_one P h312)
    (C.coefficientFormula P)

end CanonicalCoefficientCorridor

end IUTThreeClosures