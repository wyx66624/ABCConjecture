import IUTThreeClosures.FreyCalibratedIUTIVBridge
import IUTThreeClosures.FreyDiscriminantConductor

/-!
# Frey-conductor calibration of the source main term

The Frey-calibrated bridge still asks for a uniform estimate of the canonical
source main term by the elementary abc conductor.  The arithmetic part of that
estimate is already exact once the source main term is identified with the
radical conductor of the actual Frey discriminant:

`rad(abc) ≤ rad(Δ_Frey) ≤ 16 rad(abc)`.

Consequently

`freyDiscriminantConductor ≤ conductor + log 16`,

and hence, for every positive epsilon,

`freyDiscriminantConductor ≤ (1 + epsilon) conductor + log 16`.

This module removes the freely supplied `mainTerm_estimate` field.  The only
remaining source-level main-term obligation is the equality identifying the
canonical IUT IV main term with the actual Frey discriminant conductor.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- A fully arithmetic-calibrated downstream bridge.  Neither a height error
nor a conductor estimate is supplied by the caller. -/
structure FreyConductorCalibratedIUTIVBridge
    (F : PointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input) :
    Type (max u v w z) where
  corridor : CanonicalCoefficientCorridor F
  /-- The source q-pilot is the actual Frey `j`-height. -/
  qLog_eq_freyJHeight : ∀ P : ABCPoint,
    corridor.qLog P =
      Heights.normalizedLogHeight ℚ (abcFreyCurve P).j
  /-- The canonical source main term is the radical conductor of the actual
  integral Frey discriminant. -/
  mainTerm_eq_freyDiscriminantConductor : ∀ P : ABCPoint,
    corridor.mainTerm P = P.freyDiscriminantConductor

namespace ABCPoint

/-- The elementary logarithmic abc conductor is nonnegative. -/
theorem conductor_nonneg (P : ABCPoint) : 0 ≤ P.conductor := by
  unfold conductor
  apply Real.log_nonneg
  exact_mod_cast (Nat.one_le_iff_ne_zero.mpr
    (Nat.ne_of_gt (abcRadical_pos (P.a * P.b * P.c))))

end ABCPoint

namespace FreyConductorCalibratedIUTIVBridge

variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- The source main-term estimate follows with the explicit constant `log 16`. -/
theorem mainTerm_estimate
    (B : FreyConductorCalibratedIUTIVBridge F) :
    ∀ ε : ℝ, 0 < ε →
      ∃ C : ℝ, ∀ P : ABCPoint,
        B.corridor.mainTerm P ≤ (1 + ε) * P.conductor + C := by
  intro ε hε
  refine ⟨Real.log 16, ?_⟩
  intro P
  rw [B.mainTerm_eq_freyDiscriminantConductor P]
  have hdisc := P.freyDiscriminantConductor_le
  have hnonneg := P.conductor_nonneg
  nlinarith [mul_nonneg hε.le hnonneg]

/-- Forget the conductor calibration to recover the Frey-height calibrated
bridge, with its main-term estimate now proved rather than postulated. -/
noncomputable def toFreyCalibrated
    (B : FreyConductorCalibratedIUTIVBridge F) :
    FreyCalibratedIUTIVBridge F where
  corridor := B.corridor
  qLog_eq_freyJHeight := B.qLog_eq_freyJHeight
  mainTerm_estimate := B.mainTerm_estimate

/-- The fully Frey-calibrated source corridor implies abc. -/
theorem abc (B : FreyConductorCalibratedIUTIVBridge F) : ABCConjecture :=
  B.toFreyCalibrated.abc

/-- Auditable pointwise bound with the explicit arithmetic constant. -/
theorem pointwise_height_bound
    (B : FreyConductorCalibratedIUTIVBridge F)
    {ε : ℝ} (hε : 0 < ε) (P : ABCPoint) :
    P.height ≤
      (1 + ε) * P.conductor +
        (Real.log 16 + Real.log 8 / 6) := by
  exact B.toFreyCalibrated.pointwise_height_bound hε
    (C := Real.log 16) ((B.mainTerm_estimate ε hε).choose_spec) P

end FreyConductorCalibratedIUTIVBridge

end IUTThreeClosures
