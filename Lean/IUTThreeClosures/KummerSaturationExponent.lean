/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The numerical exponent of a Kummer lattice saturation

If `B` has basis `1, alpha, ..., alpha^(N-1)` and `A` has basis
`1, pi*alpha, ..., (pi*alpha)^(N-1)`, then the determinant exponent of
`A -> B` is

`0 + 1 + ... + (N-1)`.

This file formalizes the elementary numerical identities behind the local
lattice theorem.  The DVR module isomorphism and length calculation will be
added after the relevant finite-length module API is isolated.
-/

namespace IUTThreeClosures

open Finset
open scoped BigOperators

/-- The exponent of the determinant of
`diag(1, pi, ..., pi^(N-1))`. -/
def kummerSaturationExponent (N : ℕ) : ℕ :=
  ∑ j ∈ Finset.range N, j

@[simp]
theorem kummerSaturationExponent_zero :
    kummerSaturationExponent 0 = 0 := by
  simp [kummerSaturationExponent]

@[simp]
theorem kummerSaturationExponent_succ (N : ℕ) :
    kummerSaturationExponent (N + 1) =
      kummerSaturationExponent N + N := by
  simp [kummerSaturationExponent, Finset.sum_range_succ]

/-- Twice the saturation exponent is `N(N-1)`. -/
theorem two_mul_kummerSaturationExponent (N : ℕ) :
    2 * kummerSaturationExponent N = N * (N - 1) := by
  induction N with
  | zero => simp
  | succ N ih =>
      rw [show N + 1 = Nat.succ N by rfl,
        kummerSaturationExponent_succ]
      simp only [Nat.succ_sub_one]
      have ih' :
          2 * kummerSaturationExponent N = N * (N - 1) := ih
      by_cases hN : N = 0
      · subst N
        simp
      · have hNpos : 0 < N := Nat.pos_of_ne_zero hN
        have hsub : N - 1 + 1 = N := Nat.sub_add_cancel hNpos
        nlinarith

/-- The full multiplicity decomposes into one radical copy and the normalized
saturation defect, in denominator-free form. -/
theorem multiplicity_square_decomposition (N : ℕ) :
    N * N = N + 2 * kummerSaturationExponent N := by
  cases N with
  | zero => simp
  | succ N =>
      have h := two_mul_kummerSaturationExponent (N + 1)
      simp only [Nat.succ_sub_one] at h
      nlinarith

/-- Rationally normalized form of the preceding identity. -/
theorem multiplicity_eq_one_add_normalized_saturation
    {N : ℕ} (hN : 0 < N) :
    (N : ℚ) =
      1 + 2 * (kummerSaturationExponent N : ℚ) / N := by
  have hNat := multiplicity_square_decomposition N
  have hRat :
      (N : ℚ) * N =
        N + 2 * (kummerSaturationExponent N : ℚ) := by
    exact_mod_cast hNat
  have hN0 : (N : ℚ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hN)
  field_simp [hN0]
  nlinarith

end IUTThreeClosures
