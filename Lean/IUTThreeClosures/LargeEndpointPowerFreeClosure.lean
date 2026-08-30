/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyDiscriminantConductor
import Mathlib.Data.Nat.Factorization.PrimePow
import Mathlib.Data.Nat.Squarefree
import Mathlib.Tactic

/-!
# Power-free closure on the two large abc endpoints

Let `M = max a b` for a positive primitive triple `a+b=c`.  Since `c <= 2M`,

`c^2 <= 2 M c`.

If every prime exponent in `M*c` is at most `k`, then

`M*c <= rad(M*c)^k <= rad(abc)^k`.

Hence

`2 * height <= log 2 + k * conductor`.

At `k=2` this is a coefficient-one abc estimate with an explicit constant.
Consequently every violation of that strong estimate forces a prime cube in
one of the two large adjacent endpoints (equivalently in their product).

No distribution theorem for power-free values is assumed.
-/

namespace IUTThreeClosures
namespace LargeEndpointPowerFreeClosure

open UniqueFactorizationMonoid

noncomputable section

/-- Every prime exponent of `n` is at most `k`. -/
def IsExponentAtMost (k n : ℕ) : Prop :=
  n ≠ 0 ∧ ∀ p : ℕ, p.Prime → n.factorization p ≤ k

namespace IsExponentAtMost

variable {k n : ℕ}

@[simp] theorem ne_zero (h : IsExponentAtMost k n) : n ≠ 0 := h.1

/-- A `k`-power-free integer divides the `k`-th power of its radical. -/
theorem dvd_radical_pow (h : IsExponentAtMost k n) :
    n ∣ abcRadical n ^ k := by
  rw [abcRadical_eq_natRadical]
  have hrad : radical n ^ k ≠ 0 :=
    pow_ne_zero k (Nat.ne_of_gt (Nat.radical_pos n))
  rw [← Nat.factorization_le_iff_dvd h.ne_zero hrad]
  intro p
  rw [Nat.factorization_pow]
  change n.factorization p ≤ k * (radical n).factorization p
  by_cases hp : p.Prime
  · by_cases hpn : p ∣ n
    · have hprad : p ∣ radical n :=
        (UniqueFactorizationMonoid.dvd_radical_iff_of_irreducible
          hp h.ne_zero).2 hpn
      have hfac : (radical n).factorization p = 1 :=
        Nat.factorization_eq_one_of_squarefree
          (UniqueFactorizationMonoid.squarefree_radical (a := n))
          hp hprad
      rw [hfac, mul_one]
      exact h.2 p hp
    · rw [Nat.factorization_eq_zero_of_not_dvd hpn]
      simp
  · rw [Nat.factorization_eq_zero_of_not_prime _ hp]
    simp

/-- Numerical radical expansion for a power-free integer. -/
theorem le_radical_pow (h : IsExponentAtMost k n) :
    n ≤ abcRadical n ^ k :=
  Nat.le_of_dvd
    (Nat.pos_of_ne_zero
      (pow_ne_zero k (Nat.ne_of_gt (abcRadical_pos n))))
    h.dvd_radical_pow

/-- Failure of the exponent cap produces a prime power one level higher. -/
theorem exists_prime_pow_succ_dvd_of_not
    (hn : n ≠ 0) (hnot : ¬ IsExponentAtMost k n) :
    ∃ p : ℕ, p.Prime ∧ p ^ (k + 1) ∣ n := by
  classical
  have hnotall :
      ¬ ∀ p : ℕ, p.Prime → n.factorization p ≤ k := by
    intro hall
    exact hnot ⟨hn, hall⟩
  push Not at hnotall
  obtain ⟨p, hp, hgt⟩ := hnotall
  refine ⟨p, hp, (hp.pow_dvd_iff_le_factorization hn).2 ?_⟩
  omega

end IsExponentAtMost

end
end LargeEndpointPowerFreeClosure

open LargeEndpointPowerFreeClosure
open UniqueFactorizationMonoid

noncomputable section

namespace ABCPoint

/-- The larger of the two summands. -/
def largeEndpoint (P : ABCPoint) : ℕ := max P.a P.b

@[simp] theorem largeEndpoint_pos (P : ABCPoint) : 0 < P.largeEndpoint := by
  unfold largeEndpoint
  exact lt_of_lt_of_le P.a_pos (le_max_left _ _)

/-- The sum is at most twice its larger summand. -/
theorem c_le_two_mul_largeEndpoint (P : ABCPoint) :
    P.c ≤ 2 * P.largeEndpoint := by
  have ha : P.a ≤ P.largeEndpoint := le_max_left _ _
  have hb : P.b ≤ P.largeEndpoint := le_max_right _ _
  rw [← P.sum_eq]
  omega

/-- The two large adjacent endpoints divide the full abc product. -/
theorem largeEndpoint_mul_c_dvd_abcProduct (P : ABCPoint) :
    P.largeEndpoint * P.c ∣ P.a * P.b * P.c := by
  by_cases hab : P.a ≤ P.b
  · have hmax : P.largeEndpoint = P.b := by
      simp [largeEndpoint, hab]
    rw [hmax]
    refine ⟨P.a, ?_⟩
    ring
  · have hba : P.b ≤ P.a := by omega
    have hmax : P.largeEndpoint = P.a := by
      simp [largeEndpoint, hba]
    rw [hmax]
    refine ⟨P.b, ?_⟩
    ring

/-- Radical monotonicity from the large-endpoint product into `abc`. -/
theorem radical_largeEndpoint_mul_c_le_abcRadical (P : ABCPoint) :
    abcRadical (P.largeEndpoint * P.c) ≤
      abcRadical (P.a * P.b * P.c) := by
  have htarget : P.a * P.b * P.c ≠ 0 :=
    (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos).ne'
  have hdiv :
      radical (P.largeEndpoint * P.c) ∣
        radical (P.a * P.b * P.c) :=
    radical_dvd_radical P.largeEndpoint_mul_c_dvd_abcProduct htarget
  have hle := Nat.le_of_dvd
    (Nat.radical_pos (P.a * P.b * P.c)) hdiv
  simpa [abcRadical_eq_natRadical] using hle

/-- `c^2` is at most twice the product of the two large endpoints. -/
theorem c_sq_le_two_largeEndpoint_mul_c (P : ABCPoint) :
    P.c ^ 2 ≤ 2 * (P.largeEndpoint * P.c) := by
  have hmul := Nat.mul_le_mul_right P.c P.c_le_two_mul_largeEndpoint
  calc
    P.c ^ 2 = P.c * P.c := by ring
    _ ≤ (2 * P.largeEndpoint) * P.c := hmul
    _ = 2 * (P.largeEndpoint * P.c) := by ring

/-- General natural-number power-free endpoint estimate. -/
theorem c_sq_le_two_abcRadical_pow
    (P : ABCPoint) {k : ℕ}
    (hfree : IsExponentAtMost k (P.largeEndpoint * P.c)) :
    P.c ^ 2 ≤ 2 * abcRadical (P.a * P.b * P.c) ^ k := by
  calc
    P.c ^ 2 ≤ 2 * (P.largeEndpoint * P.c) :=
      P.c_sq_le_two_largeEndpoint_mul_c
    _ ≤ 2 * abcRadical (P.largeEndpoint * P.c) ^ k :=
      Nat.mul_le_mul_left 2 hfree.le_radical_pow
    _ ≤ 2 * abcRadical (P.a * P.b * P.c) ^ k := by
      exact Nat.mul_le_mul_left 2
        (Nat.pow_le_pow_left P.radical_largeEndpoint_mul_c_le_abcRadical k)

/-- Logarithmic form: exponent cap `k` gives height coefficient `k/2`. -/
theorem two_mul_height_le_log_two_add_k_mul_conductor
    (P : ABCPoint) {k : ℕ}
    (hfree : IsExponentAtMost k (P.largeEndpoint * P.c)) :
    2 * P.height ≤ Real.log 2 + (k : ℝ) * P.conductor := by
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hradpos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * (abcRadical (P.a * P.b * P.c) : ℝ) ^ k := by
    exact_mod_cast P.c_sq_le_two_abcRadical_pow hfree
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0)
        (pow_pos hradpos k).ne',
      Real.log_pow] at hlog
  rw [P.height_eq_log_c]
  unfold ABCPoint.conductor
  linarith

/-- General coefficient transfer for power-free large endpoints. -/
theorem height_le_half_k_mul_conductor_add_log_two_div_two
    (P : ABCPoint) {k : ℕ}
    (hfree : IsExponentAtMost k (P.largeEndpoint * P.c)) :
    P.height ≤
      ((k : ℝ) / 2) * P.conductor + Real.log 2 / 2 := by
  have h := P.two_mul_height_le_log_two_add_k_mul_conductor hfree
  nlinarith

/-- Cube-free large-endpoint product gives a strong coefficient-one abc bound. -/
theorem height_le_conductor_add_log_two_div_two_of_cubeFreeLargeProduct
    (P : ABCPoint)
    (hfree : IsExponentAtMost 2 (P.largeEndpoint * P.c)) :
    P.height ≤ P.conductor + Real.log 2 / 2 := by
  have h :=
    P.height_le_half_k_mul_conductor_add_log_two_div_two hfree
  norm_num at h ⊢
  linarith

/-- Every violation of the strong bound forces a prime cube in the product of
the two large adjacent endpoints. -/
theorem exists_prime_cube_dvd_largeProduct_of_strong_violation
    (P : ABCPoint)
    (hviolation : P.conductor + Real.log 2 / 2 < P.height) :
    ∃ p : ℕ, p.Prime ∧ p ^ 3 ∣ P.largeEndpoint * P.c := by
  have hn : P.largeEndpoint * P.c ≠ 0 :=
    (mul_pos P.largeEndpoint_pos P.c_pos).ne'
  have hnot :
      ¬ IsExponentAtMost 2 (P.largeEndpoint * P.c) := by
    intro hfree
    have hbound :=
      P.height_le_conductor_add_log_two_div_two_of_cubeFreeLargeProduct hfree
    linarith
  obtain ⟨p, hp, hpow⟩ :=
    IsExponentAtMost.exists_prime_pow_succ_dvd_of_not hn hnot
  exact ⟨p, hp, by simpa using hpow⟩

end ABCPoint

namespace LargeEndpointPowerFreeClosure

#print axioms IsExponentAtMost.dvd_radical_pow
#print axioms IsExponentAtMost.le_radical_pow
#print axioms IsExponentAtMost.exists_prime_pow_succ_dvd_of_not
#print axioms ABCPoint.c_sq_le_two_abcRadical_pow
#print axioms ABCPoint.two_mul_height_le_log_two_add_k_mul_conductor
#print axioms ABCPoint.height_le_conductor_add_log_two_div_two_of_cubeFreeLargeProduct
#print axioms ABCPoint.exists_prime_cube_dvd_largeProduct_of_strong_violation

end LargeEndpointPowerFreeClosure
end
end IUTThreeClosures
