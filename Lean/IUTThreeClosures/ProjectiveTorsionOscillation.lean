/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Projective oscillation of the Tate cyclic-line orbit

The canonical and noncanonical local Tate-line coefficients cancel under a
linear average.  Their projective oscillation and centered quadratic energy do
not cancel.  These nonlinear quantities are invariant under permutation of the
lines and under a common additive rescaling of all logarithmic coordinates.

This file formalizes the scalar identities used by the projective theta-packet
research route.  It does not construct the global packet or assert a height
bound.
-/

namespace IUTThreeClosures

/-- Canonical cyclic-line coefficient. -/
noncomputable def torsionCanonicalCoefficient (ell : ℝ) : ℝ :=
  (ell - 1) / 12

/-- Noncanonical cyclic-line coefficient. -/
noncomputable def torsionNoncanonicalCoefficient (ell : ℝ) : ℝ :=
  -(ell - 1) / (12 * ell)

/-- One canonical coefficient and `ell` noncanonical coefficients cancel. -/
theorem torsionCoefficient_linear_cancel
    {ell : ℝ} (hell : ell ≠ 0) :
    torsionCanonicalCoefficient ell +
        ell * torsionNoncanonicalCoefficient ell = 0 := by
  unfold torsionCanonicalCoefficient torsionNoncanonicalCoefficient
  field_simp [hell]
  ring

/-- The canonical/noncanonical projective gap. -/
theorem torsionCoefficient_gap
    {ell : ℝ} (hell : ell ≠ 0) :
    torsionCanonicalCoefficient ell -
        torsionNoncanonicalCoefficient ell =
      (ell ^ 2 - 1) / (12 * ell) := by
  unfold torsionCanonicalCoefficient torsionNoncanonicalCoefficient
  field_simp [hell]
  ring

/-- The centered quadratic energy of one canonical and `ell`
noncanonical coordinates. -/
theorem torsionCoefficient_quadratic_energy
    {ell : ℝ} (hell : ell ≠ 0) :
    torsionCanonicalCoefficient ell ^ 2 +
        ell * torsionNoncanonicalCoefficient ell ^ 2 =
      (ell - 1) ^ 2 * (ell + 1) / (144 * ell) := by
  unfold torsionCanonicalCoefficient torsionNoncanonicalCoefficient
  field_simp [hell]
  ring

/-- Adding a common logarithmic normalization does not change a two-coordinate
projective oscillation. -/
theorem max_sub_min_add_common
    (x y c : ℝ) :
    max (x + c) (y + c) - min (x + c) (y + c) =
      max x y - min x y := by
  rw [max_add_add_right, min_add_add_right]
  ring

/-- Permuting the two extremal coordinates does not change their
oscillation. -/
theorem max_sub_min_swap (x y : ℝ) :
    max y x - min y x = max x y - min x y := by
  rw [max_comm, min_comm]

/-- For a genuine auxiliary prime `ell > 1`, the canonical coefficient is
strictly larger than the noncanonical coefficient. -/
theorem torsionNoncanonical_lt_canonical
    {ell : ℝ} (hell : 1 < ell) :
    torsionNoncanonicalCoefficient ell <
      torsionCanonicalCoefficient ell := by
  have hell0 : 0 < ell := lt_trans zero_lt_one hell
  unfold torsionCanonicalCoefficient torsionNoncanonicalCoefficient
  apply (div_lt_iff₀ (show (0 : ℝ) < 12 * ell by positivity)).2
  nlinarith

/-- The actual max-minus-min oscillation is the explicit coefficient gap. -/
theorem torsionCoefficient_projective_oscillation
    {ell L : ℝ} (hell : 1 < ell) (hL : 0 ≤ L) :
    max
        (torsionCanonicalCoefficient ell * L)
        (torsionNoncanonicalCoefficient ell * L) -
      min
        (torsionCanonicalCoefficient ell * L)
        (torsionNoncanonicalCoefficient ell * L) =
      ((ell ^ 2 - 1) / (12 * ell)) * L := by
  have hcoeff :
      torsionNoncanonicalCoefficient ell ≤
        torsionCanonicalCoefficient ell :=
    (torsionNoncanonical_lt_canonical hell).le
  have hmul :
      torsionNoncanonicalCoefficient ell * L ≤
        torsionCanonicalCoefficient ell * L :=
    mul_le_mul_of_nonneg_right hcoeff hL
  rw [max_eq_left hmul, min_eq_right hmul]
  rw [← sub_mul, torsionCoefficient_gap (ne_of_gt (lt_trans zero_lt_one hell))]

end IUTThreeClosures
