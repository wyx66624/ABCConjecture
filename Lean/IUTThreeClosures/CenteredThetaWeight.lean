/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The centered even-theta weight has coefficient one sixth

For an odd level `ell = 2*m+1`, the centered residue representatives are

`-m, ..., -1, 0, 1, ..., m`.

The sum of their squares is

`ell * (ell^2 - 1) / 12`.

For the two-dimensional theta coefficient lattice modulo sign, the total
leading tropical exponent is the same centered square sum.  The irreducible
symmetric transverse-kernel packet has size

`ell * (ell^2 - 1) / 2`,

so the exponent is exactly one sixth of the packet size.  This module
kernel-checks the scalar identities; the theta-lattice and pure-metric
identification are separate arithmetic-geometric layers.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-- Real sum of the squares of the centered representatives of
`Z/(2*m+1)Z`. -/
noncomputable def centeredResidueSquareSum (m : ℕ) : ℝ :=
  2 * ∑ j in Finset.range (m + 1), (j : ℝ) ^ 2

/-- Sum-of-squares formula in a denominator-free real form. -/
theorem six_mul_sum_range_squares_real (m : ℕ) :
    6 * (∑ j in Finset.range (m + 1), (j : ℝ) ^ 2) =
      (m : ℝ) * ((m : ℝ) + 1) * (2 * (m : ℝ) + 1) := by
  induction m with
  | zero => norm_num
  | succ m ih =>
      simp only [Nat.succ_eq_add_one, Finset.sum_range_succ]
      push_cast
      rw [mul_add, ih]
      ring

/-- Exact centered square sum for the odd level `ell = 2*m+1`. -/
theorem centeredResidueSquareSum_eq (m : ℕ) :
    centeredResidueSquareSum m =
      ((2 * m + 1 : ℕ) : ℝ) *
        ((((2 * m + 1 : ℕ) : ℝ) ^ 2) - 1) / 12 := by
  unfold centeredResidueSquareSum
  have h := six_mul_sum_range_squares_real m
  apply (eq_div_iff (by norm_num : (12 : ℝ) ≠ 0)).2
  calc
    12 * (2 * ∑ j in Finset.range (m + 1), (j : ℝ) ^ 2) =
        4 *
          (6 * ∑ j in Finset.range (m + 1), (j : ℝ) ^ 2) := by ring
    _ = 4 * ((m : ℝ) * ((m : ℝ) + 1) *
          (2 * (m : ℝ) + 1)) := by rw [h]
    _ = ((2 * m + 1 : ℕ) : ℝ) *
          ((((2 * m + 1 : ℕ) : ℝ) ^ 2) - 1) := by
      push_cast
      ring

/-- Scalar size of the irreducible symmetric transverse-kernel packet at odd
level `2*m+1`. -/
noncomputable def irreducibleSymmetricPacketSizeFromHalf (m : ℕ) : ℝ :=
  ((2 * m + 1 : ℕ) : ℝ) *
    ((((2 * m + 1 : ℕ) : ℝ) ^ 2) - 1) / 2

/-- **Exact one-sixth identity.** The centered even-theta tropical weight is
one sixth of the irreducible symmetric packet size. -/
theorem centeredResidueSquareSum_eq_oneSixth_packet (m : ℕ) :
    centeredResidueSquareSum m =
      irreducibleSymmetricPacketSizeFromHalf m / 6 := by
  rw [centeredResidueSquareSum_eq]
  unfold irreducibleSymmetricPacketSizeFromHalf
  ring

/-- The elementary two-dimensional/sign-orbit normalization: if the full
ordered-pair weight is twice the centered square sum, quotienting nonzero
coordinates by sign returns the centered sum. -/
theorem half_twoDimensionalWeight_eq_centered (m : ℕ) :
    (1 / 2 : ℝ) * (2 * centeredResidueSquareSum m) =
      centeredResidueSquareSum m := by
  ring

end IUTThreeClosures
