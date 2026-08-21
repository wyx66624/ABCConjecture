import IUTThreeClosures.FreyJHeightCorridor
import IUTThreeClosures.SourceDerivedIUTIVBridge

/-!
# Frey-calibrated source-derived IUT IV bridge

`SourceDerivedIUTIVBridge` still accepts a free real constant and a separately
supplied comparison between the abc height and the source q-logarithm.  This
module removes that freedom.  The q-logarithm must be identified with the
actual absolute Weil height of the Frey `j`-invariant, after which the explicit
arithmetic theorem

`height(P) ≤ h(j(E_P))/6 + log(8)/6`

supplies the height comparison automatically.

Thus the remaining non-elementary inputs are reduced to:

1. the actual source coefficient corridor;
2. the source theorem identifying its q-pilot with the Frey `j`-height;
3. the uniform conductor estimate for the canonical source main term.

No field of this structure is `ABCConjecture`, and no arbitrary real-valued
height function or height-error constant can be populated by the caller.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- A strict source-derived bridge calibrated by the actual Frey
`j`-invariant height. -/
structure FreyCalibratedIUTIVBridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  /-- The canonical q-pilot/theta-coefficient corridor. -/
  corridor : CanonicalCoefficientCorridor F
  /-- Source-level calibration: the actual q-pilot logarithm is the actual
  absolute Weil height of the Frey `j`-invariant attached to the abc point. -/
  qLog_eq_freyJHeight : ∀ P : ABCPoint,
    corridor.qLog P =
      Heights.normalizedLogHeight ℚ (abcFreyCurve P).j
  /-- Uniform source estimate for the canonical IUT IV main term. -/
  mainTerm_estimate :
    ∀ ε : ℝ, 0 < ε →
      ∃ C : ℝ, ∀ P : ABCPoint,
        corridor.mainTerm P ≤ (1 + ε) * P.conductor + C

namespace FreyCalibratedIUTIVBridge

variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- The Frey height corridor supplies the q-height comparison with the fixed
explicit constant `log 8 / 6`. -/
theorem height_le_qLog
    (B : FreyCalibratedIUTIVBridge F) (P : ABCPoint) :
    P.height ≤ B.corridor.qLog P / 6 + Real.log 8 / 6 := by
  have h := P.height_le_normalizedLogHeight_abcFrey_j
  rw [← B.qLog_eq_freyJHeight P] at h
  exact h

/-- Forgetting the source calibration gives the earlier source-derived bridge,
with a now canonical and explicit height-error constant. -/
noncomputable def toSourceDerived
    (B : FreyCalibratedIUTIVBridge F) :
    SourceDerivedIUTIVBridge F where
  corridor := B.corridor
  heightError := Real.log 8 / 6
  height_le := B.height_le_qLog
  mainTerm_estimate := B.mainTerm_estimate

/-- The Frey-calibrated source theorem implies the logarithmic abc
conjecture. -/
theorem abc (B : FreyCalibratedIUTIVBridge F) : ABCConjecture :=
  B.toSourceDerived.abc

/-- Direct form of the final height estimate, useful for auditing constants. -/
theorem pointwise_height_bound
    (B : FreyCalibratedIUTIVBridge F)
    {ε : ℝ} (hε : 0 < ε)
    {C : ℝ}
    (hC : ∀ P : ABCPoint,
      B.corridor.mainTerm P ≤ (1 + ε) * P.conductor + C)
    (P : ABCPoint) :
    P.height ≤
      (1 + ε) * P.conductor + (C + Real.log 8 / 6) := by
  have h312 : Corollary312Variant
      (F.source (B.corridor.encode P)).toVariantData :=
    F.corollary312Variant (B.corridor.encode P)
  have hq : B.corridor.qLog P / 6 ≤ B.corridor.mainTerm P :=
    B.corridor.qLog_div_six_le_mainTerm P h312
  have hh := B.height_le_qLog P
  have hm := hC P
  calc
    P.height ≤ B.corridor.qLog P / 6 + Real.log 8 / 6 := hh
    _ ≤ B.corridor.mainTerm P + Real.log 8 / 6 := by linarith
    _ ≤ ((1 + ε) * P.conductor + C) + Real.log 8 / 6 := by linarith
    _ = (1 + ε) * P.conductor + (C + Real.log 8 / 6) := by ring

end FreyCalibratedIUTIVBridge

end IUTThreeClosures
