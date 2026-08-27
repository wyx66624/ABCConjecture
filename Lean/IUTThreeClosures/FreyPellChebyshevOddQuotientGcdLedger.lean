/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyPellChebyshevIndexThreeAudit

/-!
# Odd Chebyshev quotient: endpoint and gcd ledger

This file defines the exact integer quotient in

  T_(2m+1)(X) = X * H_m(X)

by its coefficient recurrence and proves that it is the quotient of the
repository's actual Mathlib Chebyshev evaluation.  It then proves the
congruences modulo X squared and X squared minus one, the resulting exact gcd
identity, and the modulo-eight endpoint statement for odd X.

There are no primality assumptions and no accepted external interfaces in
this module.
-/

namespace IUTThreeClosures

/-- The odd-index Chebyshev quotient, defined by its exact scalar recurrence. -/
def pellOddChebyshevQuotient : ℕ → ℤ → ℤ
  | 0, _ => 1
  | 1, x => 4 * x ^ 2 - 3
  | m + 2, x =>
      (4 * x ^ 2 - 2) * pellOddChebyshevQuotient (m + 1) x -
        pellOddChebyshevQuotient m x

@[simp]
theorem pellOddChebyshevQuotient_zero (x : ℤ) :
    pellOddChebyshevQuotient 0 x = 1 := by
  rfl

@[simp]
theorem pellOddChebyshevQuotient_one (x : ℤ) :
    pellOddChebyshevQuotient 1 x = 4 * x ^ 2 - 3 := by
  rfl

theorem pellOddChebyshevQuotient_add_two (m : ℕ) (x : ℤ) :
    pellOddChebyshevQuotient (m + 2) x =
      (4 * x ^ 2 - 2) * pellOddChebyshevQuotient (m + 1) x -
        pellOddChebyshevQuotient m x := by
  rfl

/-- The odd Chebyshev subsequence has a two-step recurrence in the half-index. -/
theorem pellChebyshev_add_four (n : ℕ) (x : ℤ) :
    pellChebyshev (n + 4) x =
      (4 * x ^ 2 - 2) * pellChebyshev (n + 2) x -
        pellChebyshev n x := by
  have h4 :
      pellChebyshev (n + 4) x =
        2 * x * pellChebyshev (n + 3) x -
          pellChebyshev (n + 2) x := by
    simpa [Nat.add_assoc] using pellChebyshev_add_two (n + 2) x
  have h3 :
      pellChebyshev (n + 3) x =
        2 * x * pellChebyshev (n + 2) x -
          pellChebyshev (n + 1) x := by
    simpa [Nat.add_assoc] using pellChebyshev_add_two (n + 1) x
  have h2 := pellChebyshev_add_two n x
  rw [h4, h3, h2]
  ring

/-- The recurrence quotient is exactly the quotient of the generic Mathlib
Chebyshev polynomial after integer evaluation. -/
theorem pellChebyshev_odd_eq_mul_quotient (m : ℕ) (x : ℤ) :
    pellChebyshev (2 * m + 1) x =
      x * pellOddChebyshevQuotient m x := by
  induction m using Nat.twoStepInduction with
  | zero =>
      simp
  | one =>
      rw [show 2 * 1 + 1 = 3 by norm_num, pellChebyshev_three]
      simp [pellOddChebyshevQuotient]
      ring
  | more m hm hm1 =>
      rw [pellOddChebyshevQuotient_add_two]
      rw [show 2 * (m + 2) + 1 = (2 * m + 1) + 4 by omega]
      rw [pellChebyshev_add_four]
      rw [show (2 * m + 1) + 2 = 2 * (m + 1) + 1 by omega]
      rw [hm1, hm]
      ring

/-- The signed linear coefficient of the odd quotient. -/
def pellOddChebyshevLinearCoefficient (m : ℕ) : ℤ :=
  (-1 : ℤ) ^ m * (2 * (m : ℤ) + 1)

theorem pellOddChebyshevLinearCoefficient_add_two (m : ℕ) :
    pellOddChebyshevLinearCoefficient (m + 2) =
      -2 * pellOddChebyshevLinearCoefficient (m + 1) -
        pellOddChebyshevLinearCoefficient m := by
  simp [pellOddChebyshevLinearCoefficient, pow_add]
  ring

/-- The quotient modulo X squared is its signed linear coefficient. -/
theorem pellOddChebyshevQuotient_mod_sq (m : ℕ) (x : ℤ) :
    pellOddChebyshevQuotient m x ≡
      pellOddChebyshevLinearCoefficient m [ZMOD x ^ 2] := by
  induction m using Nat.twoStepInduction with
  | zero =>
      simp [pellOddChebyshevLinearCoefficient]
  | one =>
      rw [pellOddChebyshevQuotient_one]
      rw [show pellOddChebyshevLinearCoefficient 1 = -3 by
        norm_num [pellOddChebyshevLinearCoefficient]]
      apply Int.modEq_of_dvd
      refine ⟨-4, by ring⟩
  | more m hm hm1 =>
      rw [pellOddChebyshevQuotient_add_two]
      rw [pellOddChebyshevLinearCoefficient_add_two]
      have hfactor :
          4 * x ^ 2 - 2 ≡ -2 [ZMOD x ^ 2] := by
        apply Int.modEq_of_dvd
        refine ⟨-4, by ring⟩
      exact (hfactor.mul hm1).sub hm

/-- The weaker modulo-X form used by the gcd ledger. -/
theorem pellOddChebyshevQuotient_mod_base (m : ℕ) (x : ℤ) :
    pellOddChebyshevQuotient m x ≡
      pellOddChebyshevLinearCoefficient m [ZMOD x] := by
  apply Int.ModEq.of_dvd
    (show x ∣ x ^ 2 by
      refine ⟨x, by ring⟩)
  exact pellOddChebyshevQuotient_mod_sq m x

/-- Exact gcd ledger, valid for every half-index and every integer base. -/
theorem gcd_pellOddChebyshevQuotient (m : ℕ) (x : ℤ) :
    gcd x (pellOddChebyshevQuotient m x) =
      gcd x (2 * (m : ℤ) + 1) := by
  have hcongr := pellOddChebyshevQuotient_mod_base m x
  have hdiff :
      x ∣ pellOddChebyshevQuotient m x -
        pellOddChebyshevLinearCoefficient m := by
    have h := hcongr.dvd
    rw [show
      pellOddChebyshevQuotient m x -
          pellOddChebyshevLinearCoefficient m =
        -(pellOddChebyshevLinearCoefficient m -
          pellOddChebyshevQuotient m x) by ring]
    exact dvd_neg.mpr h
  rw [gcd_eq_of_dvd_sub_right hdiff]
  by_cases hm : Even m
  · rw [pellOddChebyshevLinearCoefficient, hm.neg_one_pow]
    simp
  · have hmOdd : Odd m := Nat.not_even_iff_odd.mp hm
    rw [pellOddChebyshevLinearCoefficient, hmOdd.neg_one_pow]
    have hneg :
        (-1 : ℤ) * (2 * (m : ℤ) + 1) =
          -(2 * (m : ℤ) + 1) := by
      ring
    rw [hneg, gcd_neg]

/-- At both Pell endpoints X squared equals one, so every odd quotient is one. -/
theorem pellOddChebyshevQuotient_mod_sq_sub_one (m : ℕ) (x : ℤ) :
    pellOddChebyshevQuotient m x ≡ 1 [ZMOD x ^ 2 - 1] := by
  induction m using Nat.twoStepInduction with
  | zero =>
      simp
  | one =>
      rw [pellOddChebyshevQuotient_one]
      apply Int.modEq_of_dvd
      refine ⟨-4, by ring⟩
  | more m hm hm1 =>
      rw [pellOddChebyshevQuotient_add_two]
      have hfactor :
          4 * x ^ 2 - 2 ≡ 2 [ZMOD x ^ 2 - 1] := by
        apply Int.modEq_of_dvd
        refine ⟨-4, by ring⟩
      simpa using (hfactor.mul hm1).sub hm

/-- The elementary parity bridge from an odd base to modulus eight. -/
theorem eight_dvd_sq_sub_one_of_odd (x : ℤ) (hx : Odd x) :
    8 ∣ x ^ 2 - 1 := by
  rcases hx with ⟨k, hk⟩
  rcases Int.two_dvd_mul_add_one k with ⟨j, hj⟩
  refine ⟨j, ?_⟩
  rw [hk]
  calc
    (2 * k + 1) ^ 2 - 1 = 4 * (k * (k + 1)) := by ring
    _ = 4 * (2 * j) := by rw [hj]
    _ = 8 * j := by ring

/-- For an odd integer base, every odd Chebyshev quotient is one modulo eight. -/
theorem pellOddChebyshevQuotient_mod_eight_of_odd
    (m : ℕ) (x : ℤ) (hx : Odd x) :
    pellOddChebyshevQuotient m x ≡ 1 [ZMOD 8] := by
  exact Int.ModEq.of_dvd (eight_dvd_sq_sub_one_of_odd x hx)
    (pellOddChebyshevQuotient_mod_sq_sub_one m x)

#print axioms pellChebyshev_odd_eq_mul_quotient
#print axioms pellOddChebyshevQuotient_mod_sq
#print axioms gcd_pellOddChebyshevQuotient
#print axioms pellOddChebyshevQuotient_mod_sq_sub_one
#print axioms pellOddChebyshevQuotient_mod_eight_of_odd

end IUTThreeClosures
