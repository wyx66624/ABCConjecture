/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PellSquareRootDescent20260831

/-!
# Elementary kernel of the prime-index balancing dichotomy

The complete paper proof, including the cited perfect-power and Lucas
valuation theorems, precedes this module in
`research/ABC_PELL_PRIME_INDEX_DICHOTOMY_2026_08_31.md`.

This file formalizes the literature-independent exponent core, the exceptional
index-seven calculation, and the numerical two-channel lower bound.  It does
not insert Cohn's, Ljunggren's, or Sanna's theorems as project axioms.
-/

namespace IUTThreeClosures
namespace PellPrimeIndexDichotomy20260831

open KFullRadicalCompression
open PellCampanaCounterexample20260831
open PellSquareRootDescent20260831

/-- An odd exponent in a squarefull factor has depth at least three. -/
theorem odd_exponent_ge_three {e : ℕ}
    (hfull : 2 ≤ e) (hodd : e % 2 = 1) : 3 ≤ e := by
  omega

/-- The finite-exponent core used after non-squareness supplies an odd
valuation. -/
theorem squarefull_nonsquare_depth_three
    {ι : Type*} (v : ι → ℕ)
    (hfull : ∀ i, 2 ≤ v i)
    (hnonsquare : ∃ i, v i % 2 = 1) :
    ∃ i, 3 ≤ v i ∧ v i % 2 = 1 := by
  rcases hnonsquare with ⟨i, hi⟩
  exact ⟨i, odd_exponent_ge_three (hfull i) hi, hi⟩

/-- Exact square-root coordinates at the exceptional perfect-power index. -/
theorem sqrtTwoOrbit_seven : sqrtTwoOrbit 7 = (239, 169) := by
  norm_num [sqrtTwoOrbit]

/-- The corresponding balancing coordinate has one simple prime factor. -/
theorem pellOrbit_seven_snd : (pellOrbit 7).2 = 40391 := by
  rw [pellOrbit_eq_sqrtTwo_square, sqrtTwoOrbit_seven]
  norm_num

theorem two_hundred_thirty_nine_dvd_pellOrbit_seven :
    239 ∣ (pellOrbit 7).2 := by
  rw [pellOrbit_seven_snd]
  norm_num

theorem two_hundred_thirty_nine_sq_not_dvd_pellOrbit_seven :
    ¬ 239 ^ 2 ∣ (pellOrbit 7).2 := by
  rw [pellOrbit_seven_snd]
  norm_num

/-- Thus the sole nontrivial perfect-power exception in the `B` channel does
not yield a squarefull balancing term. -/
theorem pellOrbit_seven_snd_not_twoFull :
    ¬ IsKFull 2 (pellOrbit 7).2 := by
  intro hfull
  have hsquare : 239 ^ 2 ∣ (pellOrbit 7).2 :=
    (IsKFull.iff_prime_pow_dvd hfull.ne_zero).1 hfull 239
      (by norm_num) two_hundred_thirty_nine_dvd_pellOrbit_seven
  exact two_hundred_thirty_nine_sq_not_dvd_pellOrbit_seven hsquare

theorem squarefull_prime_index_ne_seven {ell : ℕ}
    (_hell : ell.Prime) (hfull : IsKFull 2 (pellOrbit ell).2) :
    ell ≠ 7 := by
  rintro rfl
  exact pellOrbit_seven_snd_not_twoFull hfull

/-- Numerical endpoint after the two factor-channel prime lower bounds. -/
theorem channel_lower_bound_product {ell pA pB : ℝ}
    (hA : 2 * ell + 1 ≤ pA) (hB : 2 * ell - 1 ≤ pB)
    (hell : 1 ≤ ell) :
    4 * ell ^ 2 - 1 ≤ pA * pB := by
  have hright : 0 ≤ 2 * ell - 1 := by linarith
  have hpA : 0 ≤ pA := by linarith
  calc
    4 * ell ^ 2 - 1 = (2 * ell + 1) * (2 * ell - 1) := by ring
    _ ≤ pA * (2 * ell - 1) := mul_le_mul_of_nonneg_right hA hright
    _ ≤ pA * pB := mul_le_mul_of_nonneg_left hB hpA

#print axioms odd_exponent_ge_three
#print axioms squarefull_nonsquare_depth_three
#print axioms sqrtTwoOrbit_seven
#print axioms pellOrbit_seven_snd_not_twoFull
#print axioms squarefull_prime_index_ne_seven
#print axioms channel_lower_bound_product

end PellPrimeIndexDichotomy20260831
end IUTThreeClosures
