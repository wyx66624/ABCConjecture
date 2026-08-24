/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootRadialSkeleton
import Mathlib.Topology.Instances.AddCircle.Real

/-!
# The actual theta-root radial skeleton has period `ell`

Let `r^ell = q`.  The normalized radial coordinate is chosen so that one
corrected theta-root deck step acts by `rho ↦ rho + 1`.  The original Tate
period `q` acts by multiplication by `r^ell`, hence by `rho ↦ rho + ell`.
Consequently the radial skeleton of the theta-root cover is naturally the
additive circle

`R / ell Z`,

not `R / Z`.  The theta-root deck generator is translation by the class of
`1`, while its `ell`-th iterate is the original Tate period and becomes
trivial on the skeleton.

Mathlib already supplies the properly discontinuous translation action of
`ell Z` on `R` and compactness of the corresponding additive circle when
`ell > 0`.  Thus the topological quotient is completely constructed at the
radial-skeleton level.  This is not yet a construction of the full Berkovich
Tate curve or its tempered fundamental group: angular/unit directions and the
analytic compactification remain additional geometry.
-/

namespace IUTThreeClosures

open TateCurvesTheta AddSubgroup Set

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootCycleSkeleton

/-- The oriented radial skeleton of an `ell`-th theta-root cover. -/
abbrev Skeleton (ell : ℕ) := AddCircle (ell : ℝ)

/-- The actual theta-root point mapped to its radial skeleton class. -/
noncomputable def point
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (z : TateThetaRootPullbackPoint t ell) : Skeleton ell :=
  (TateThetaRootRadialSkeleton.coordinate t ell r z : ℝ)

/-- One actual theta-root deck step is translation by the class of `1` on the
period-`ell` skeleton. -/
theorem point_shift
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    point t ell r
        (TateThetaRootPullbackPoint.shift t ell r hr z) =
      point t ell r z + (((1 : ℝ) : Skeleton ell)) := by
  rw [point, point,
    TateThetaRootRadialSkeleton.coordinate_shift]
  exact AddCircle.coe_add _ _ _

/-- The `n`-th positive deck iterate is translation by the class of `n`. -/
theorem point_shiftNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    point t ell r
        (TateThetaRootPullbackPoint.shiftNat t ell r hr n z) =
      point t ell r z + ((((n : ℕ) : ℝ) : Skeleton ell)) := by
  rw [point, point,
    TateThetaRootRadialSkeleton.coordinate_shiftNat]
  exact AddCircle.coe_add _ _ _

/-- The `ell`-th theta-root deck iterate is the original Tate multiplication
by `q` on the base coordinate. -/
theorem shiftNat_ell_base
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    (TateThetaRootPullbackPoint.shiftNat t ell r hr ell z).base =
      t.q * z.base := by
  rw [TateThetaRootPullbackPoint.shiftNat_base, hr]

/-- The original Tate period is trivial on the period-`ell` radial skeleton. -/
theorem point_shiftNat_ell
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    point t ell r
        (TateThetaRootPullbackPoint.shiftNat t ell r hr ell z) =
      point t ell r z := by
  rw [point_shiftNat]
  simp [Skeleton]

/-- Translation by `ell Z` on the universal radial line is properly
discontinuous. -/
theorem period_translation_properlyDiscontinuous (ell : ℕ) :
    ProperlyDiscontinuousVAdd
      (zmultiples (ell : ℝ)).op ℝ := by
  infer_instance

/-- For positive `ell`, the radial skeleton quotient is compact. -/
theorem skeleton_isCompact
    {ell : ℕ} (hell : 0 < ell) :
    IsCompact (Set.univ : Set (Skeleton ell)) := by
  letI : Fact (0 < (ell : ℝ)) :=
    ⟨by exact_mod_cast hell⟩
  exact isCompact_univ

/-- For prime `ell`, the one-step skeleton translation is nontrivial. -/
theorem one_class_ne_zero
    {ell : ℕ} (hell : Nat.Prime ell) :
    (((1 : ℝ) : Skeleton ell)) ≠ 0 := by
  intro h
  have hmod : (1 : ℝ) ≡ 0 [PMOD (ell : ℝ)] := by
    simpa [Skeleton] using h
  rcases hmod with ⟨k, hk⟩
  have hellReal : (1 : ℝ) < ell := by
    exact_mod_cast hell.one_lt
  have hkabs : |(k : ℝ) * ell| = 1 := by
    rw [← hk]
    norm_num
  have hkzero_or : k = 0 ∨ 1 ≤ |k| := by
    exact Int.eq_zero_or_one_le_abs k
  rcases hkzero_or with rfl | hk
  · norm_num at hkabs
  · have : (1 : ℝ) < |(k : ℝ) * ell| := by
      rw [abs_mul, abs_of_nonneg (by positivity : (0 : ℝ) ≤ ell)]
      have hkreal : (1 : ℝ) ≤ |(k : ℝ)| := by exact_mod_cast hk
      nlinarith
    linarith

end TateThetaRootCycleSkeleton

end IUTThreeClosures
