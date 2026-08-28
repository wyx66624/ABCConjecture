/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Scalar core of the Steinberg sup-packet

At a split Tate place, one cyclic `ell`-line has logarithmic energy
`A_ell * L` and the other `ell` lines have energy `B_ell * L`, where

`A_ell = (ell - 1) / 12`,
`B_ell = -(ell - 1) / (12 * ell)`.

Their linear average cancels, but their maximum is the canonical value.  The
energy vector is exactly the distinguished augmentation vector in the
permutation representation on `ell+1` lines.  These are the elementary scalar
facts behind the Galois-invariant nonlinear sup-packet route.
-/

namespace IUTThreeClosures

/-- Canonical cyclic-line Tate coefficient. -/
def steinbergCanonicalCoeff (ell : ℝ) : ℝ :=
  (ell - 1) / 12

/-- Noncanonical cyclic-line Tate coefficient. -/
def steinbergNoncanonicalCoeff (ell : ℝ) : ℝ :=
  -(ell - 1) / (12 * ell)

/-- One canonical plus `ell` noncanonical coefficients cancel exactly. -/
theorem steinbergCoeff_cancellation
    {ell : ℝ} (hell : ell ≠ 0) :
    steinbergCanonicalCoeff ell +
      ell * steinbergNoncanonicalCoeff ell = 0 := by
  unfold steinbergCanonicalCoeff steinbergNoncanonicalCoeff
  field_simp [hell]
  ring

/-- The canonical coefficient is nonnegative for `ell >= 1`. -/
theorem steinbergCanonicalCoeff_nonneg
    {ell : ℝ} (hell : 1 ≤ ell) :
    0 ≤ steinbergCanonicalCoeff ell := by
  unfold steinbergCanonicalCoeff
  positivity

/-- The noncanonical coefficient is nonpositive for `ell >= 1`. -/
theorem steinbergNoncanonicalCoeff_nonpos
    {ell : ℝ} (hell : 1 ≤ ell) :
    steinbergNoncanonicalCoeff ell ≤ 0 := by
  have hellpos : 0 < ell := zero_lt_one.trans_le hell
  have hnum : 0 ≤ ell - 1 := sub_nonneg.mpr hell
  have hden : 0 ≤ 12 * ell := (mul_nonneg (by norm_num) hellpos.le)
  unfold steinbergNoncanonicalCoeff
  exact neg_nonpos.mpr (div_nonneg hnum hden)

/-- The nonarchimedean sup norm automatically selects the canonical line,
without choosing a globally fixed line. -/
theorem steinbergSup_selects_canonical
    {ell L : ℝ} (hell : 1 ≤ ell) (hL : 0 ≤ L) :
    max
      (steinbergCanonicalCoeff ell * L)
      (steinbergNoncanonicalCoeff ell * L) =
        steinbergCanonicalCoeff ell * L := by
  apply max_eq_left
  have hcan : 0 ≤ steinbergCanonicalCoeff ell * L :=
    mul_nonneg (steinbergCanonicalCoeff_nonneg hell) hL
  have hnon : steinbergNoncanonicalCoeff ell * L ≤ 0 :=
    mul_nonpos_of_nonpos_of_nonneg
      (steinbergNoncanonicalCoeff_nonpos hell) hL
  exact hnon.trans hcan

/-- The canonical/noncanonical gap. -/
theorem steinbergCoeff_gap
    {ell : ℝ} (hell : ell ≠ 0) :
    steinbergCanonicalCoeff ell -
      steinbergNoncanonicalCoeff ell =
        (ell ^ 2 - 1) / (12 * ell) := by
  unfold steinbergCanonicalCoeff steinbergNoncanonicalCoeff
  field_simp [hell]
  ring

/-- The canonical coordinate of the distinguished augmentation vector. -/
theorem steinbergAugmentation_canonical
    {ell : ℝ} (hell : 0 < ell) :
    (steinbergCanonicalCoeff ell -
        steinbergNoncanonicalCoeff ell) *
        (ell / (ell + 1)) =
      steinbergCanonicalCoeff ell := by
  have hell0 : ell ≠ 0 := hell.ne'
  have hell1 : ell + 1 ≠ 0 := by linarith
  unfold steinbergCanonicalCoeff steinbergNoncanonicalCoeff
  field_simp [hell0, hell1]
  ring

/-- Every noncanonical coordinate of the distinguished augmentation vector. -/
theorem steinbergAugmentation_noncanonical
    {ell : ℝ} (hell : 0 < ell) :
    (steinbergCanonicalCoeff ell -
        steinbergNoncanonicalCoeff ell) *
        (-1 / (ell + 1)) =
      steinbergNoncanonicalCoeff ell := by
  have hell0 : ell ≠ 0 := hell.ne'
  have hell1 : ell + 1 ≠ 0 := by linarith
  unfold steinbergCanonicalCoeff steinbergNoncanonicalCoeff
  field_simp [hell0, hell1]
  ring

end IUTThreeClosures
