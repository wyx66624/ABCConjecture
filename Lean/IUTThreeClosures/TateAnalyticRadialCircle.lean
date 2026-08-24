/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateAnalyticTopologicalQuotient
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Topology.Instances.AddCircle.Real

/-!
# The radial circle of the Tate analytic quotient

The logarithmic norm gives a homomorphism from `Kˣ` to the additive real line.
After normalization by `log ‖q‖`, multiplication by the Tate parameter adds
one.  Reducing modulo integers therefore gives a circle-valued homomorphism
which is invariant under the complete `qᶻ` deck group and descends to the
actual topological quotient `Kˣ/qᶻ`.

Unlike the real skeleton quotient, this map need not be an equivalence on
`K`-rational points: norm-one angular directions remain in its fibers.  It is
the canonical radial projection whose Berkovich extension is expected to be
the skeleton retraction.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

namespace TateAnalyticRadialCircle

variable {K : Type u} [NormedField K]

/-- The normalized real logarithmic radius. -/
noncomputable def radialCoordinate (T : TateDatum K) (u : Kˣ) : ℝ :=
  Real.log ‖(u : K)‖ / Real.log ‖(T.q : K)‖

/-- The Tate normalizing logarithm is strictly negative. -/
theorem log_norm_q_neg (T : TateDatum K) :
    Real.log ‖(T.q : K)‖ < 0 :=
  Real.log_neg T.norm_q_pos T.norm_q_lt_one

/-- Hence the normalizing logarithm is nonzero. -/
theorem log_norm_q_ne_zero (T : TateDatum K) :
    Real.log ‖(T.q : K)‖ ≠ 0 :=
  T.log_norm_q_neg.ne

/-- The radial coordinate is additive under multiplication. -/
theorem radialCoordinate_mul (T : TateDatum K) (u v : Kˣ) :
    radialCoordinate T (u * v) =
      radialCoordinate T u + radialCoordinate T v := by
  have hu : ‖(u : K)‖ ≠ 0 :=
    ne_of_gt (norm_pos_iff.mpr (Units.ne_zero u))
  have hv : ‖(v : K)‖ ≠ 0 :=
    ne_of_gt (norm_pos_iff.mpr (Units.ne_zero v))
  unfold radialCoordinate
  rw [Units.val_mul, norm_mul, Real.log_mul hu hv]
  ring

/-- The Tate parameter itself has normalized radius one. -/
@[simp]
theorem radialCoordinate_q (T : TateDatum K) :
    radialCoordinate T T.q = 1 := by
  unfold radialCoordinate
  exact div_self T.log_norm_q_ne_zero

/-- Integer deck translation adds the corresponding integer radius. -/
theorem radialCoordinate_deckShift
    (T : TateDatum K) (n : ℤ) (u : Kˣ) :
    radialCoordinate T
        (TateAnalyticTopologicalQuotient.deckShift T n u) =
      radialCoordinate T u + (n : ℝ) := by
  unfold TateAnalyticTopologicalQuotient.deckShift
  rw [radialCoordinate_mul]
  have hq :
      radialCoordinate T (T.q ^ n) = (n : ℝ) := by
    induction n using Int.induction_on with
    | hz => simp
    | hp n ih =>
        rw [zpow_add_one₀ T.q.ne_zero, radialCoordinate_mul,
          radialCoordinate_q, ih]
        push_cast
        ring
    | hn n ih =>
        rw [zpow_sub_one₀ T.q.ne_zero, radialCoordinate_mul]
        have hinv : radialCoordinate T T.q⁻¹ = -1 := by
          have hzero := radialCoordinate_mul T T.q T.q⁻¹
          simp only [mul_inv_cancel, radialCoordinate_q] at hzero
          have hone : radialCoordinate T (1 : Kˣ) = 0 := by
            unfold radialCoordinate
            simp
          rw [hone] at hzero
          linarith
        rw [hinv, ih]
        push_cast
        ring
  rw [hq]
  ring

/-- Circle-valued radial homomorphism on the covering space `Kˣ`. -/
noncomputable def radialCircleHom (T : TateDatum K) :
    Kˣ →* Multiplicative UnitAddCircle where
  toFun u := Multiplicative.ofAdd
    ((radialCoordinate T u : ℝ) : UnitAddCircle)
  map_one' := by
    change ((radialCoordinate T (1 : Kˣ) : ℝ) : UnitAddCircle) = 0
    unfold radialCoordinate
    simp
  map_mul' u v := by
    change
      ((radialCoordinate T (u * v) : ℝ) : UnitAddCircle) =
        ((radialCoordinate T u : ℝ) : UnitAddCircle) +
          ((radialCoordinate T v : ℝ) : UnitAddCircle)
    rw [radialCoordinate_mul]
    simp

/-- The Tate parameter maps to the identity of the multiplicative circle. -/
@[simp]
theorem radialCircleHom_q (T : TateDatum K) :
    T.radialCircleHom T.q = 1 := by
  change ((radialCoordinate T T.q : ℝ) : UnitAddCircle) = 0
  simp

/-- Every deck-subgroup element lies in the kernel. -/
theorem qpowers_le_radialCircle_kernel (T : TateDatum K) :
    T.qpowers ≤ T.radialCircleHom.ker := by
  intro u hu
  rcases Subgroup.mem_zpowers_iff.mp hu with ⟨n, rfl⟩
  change T.radialCircleHom (T.q ^ n) = 1
  rw [map_zpow, radialCircleHom_q, one_zpow]

/-- The circle-valued radial homomorphism descends to `Kˣ/qᶻ`. -/
noncomputable def quotientRadialCircleHom (T : TateDatum K) :
    T.AnalyticQuotient →* Multiplicative UnitAddCircle :=
  QuotientGroup.lift T.qpowers T.radialCircleHom
    T.qpowers_le_radialCircle_kernel

@[simp]
theorem quotientRadialCircleHom_mk
    (T : TateDatum K) (u : Kˣ) :
    T.quotientRadialCircleHom
        (QuotientGroup.mk' T.qpowers u) =
      T.radialCircleHom u :=
  rfl

/-- Unwrapped additive-circle radial coordinate on the analytic quotient. -/
noncomputable def quotientRadialCircle
    (T : TateDatum K) (x : T.AnalyticQuotient) : UnitAddCircle :=
  Multiplicative.toAdd (T.quotientRadialCircleHom x)

@[simp]
theorem quotientRadialCircle_mk
    (T : TateDatum K) (u : Kˣ) :
    T.quotientRadialCircle (QuotientGroup.mk' T.qpowers u) =
      ((radialCoordinate T u : ℝ) : UnitAddCircle) :=
  rfl

/-- The covering-space formula is explicitly invariant under every integer
deck shift. -/
theorem radialCircle_deckShift
    (T : TateDatum K) (n : ℤ) (u : Kˣ) :
    ((radialCoordinate T
        (TateAnalyticTopologicalQuotient.deckShift T n u) : ℝ) :
        UnitAddCircle) =
      ((radialCoordinate T u : ℝ) : UnitAddCircle) := by
  rw [radialCoordinate_deckShift]
  change
    ((radialCoordinate T u + (n : ℝ) : ℝ) : UnitAddCircle) =
      (radialCoordinate T u : UnitAddCircle)
  simp

end TateAnalyticRadialCircle

end IUTThreeClosures
