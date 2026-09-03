/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PellLucasFactorQuotientProjectiveCoupling20260902

/-!
# Transverse Hensel specialization for the balancing Pell--Lucas packet

The mathematical proofs precede this module in
`research/ABC_PELL_POLYNOMIAL_HENSEL_SPECIALIZATION_2026_09_02.md`.

This file kernel-checks the reusable integer core of the one-digit Hensel
law, uniqueness under a coprime derivative, the two derivative-transversality
readouts, exact Taylor congruences for the index-three polynomials, the
global moving-parameter counterexample, and the actual index-seven
specialization collision.  No polynomial square-freeness theorem, Lucas
rank theorem, full squarefull packet, or abc statement is added as an axiom.
-/

namespace IUTThreeClosures
namespace PellPolynomialHenselSpecialization20260902

/-! ## The algebraic Hensel digit -/

/-- Cancelling the nonzero factor `p^e` turns divisibility by `p^(e+1)`
into divisibility of the residual quotient by `p`. -/
theorem pow_succ_dvd_scaled_iff
    (p c : ℤ) (e : ℕ) (hp : p ≠ 0) :
    p ^ (e + 1) ∣ p ^ e * c ↔ p ∣ c := by
  constructor
  · rintro ⟨k, hk⟩
    refine ⟨k, ?_⟩
    apply mul_left_cancel₀ (pow_ne_zero e hp)
    calc
      p ^ e * c = p ^ (e + 1) * k := hk
      _ = p ^ e * (p * k) := by rw [pow_succ]; ring
  · rintro ⟨k, rfl⟩
    refine ⟨k, ?_⟩
    rw [pow_succ]
    ring

/-- The exact affine divisibility equivalence behind one Hensel digit. -/
theorem linearized_hensel_dvd_iff
    (p c fp h : ℤ) (e : ℕ) (hp : p ≠ 0) :
    p ^ (e + 1) ∣ p ^ e * c + p ^ e * h * fp ↔
      p ∣ c + h * fp := by
  rw [show p ^ e * c + p ^ e * h * fp =
      p ^ e * (c + h * fp) by ring]
  exact pow_succ_dvd_scaled_iff p (c + h * fp) e hp

/-- Version of the Hensel digit law after naming the old value `f`. -/
theorem hensel_digit_dvd_iff
    (p f c fp h : ℤ) (e : ℕ) (hp : p ≠ 0)
    (hf : f = p ^ e * c) :
    p ^ (e + 1) ∣ f + p ^ e * h * fp ↔
      p ∣ c + h * fp := by
  rw [hf]
  exact linearized_hensel_dvd_iff p c fp h e hp

/-- The old representative is itself the next lift exactly when its residual
quotient has one more factor of `p`. -/
theorem fixed_representative_persists_iff
    (p f c : ℤ) (e : ℕ) (hp : p ≠ 0)
    (hf : f = p ^ e * c) :
    p ^ (e + 1) ∣ f ↔ p ∣ c := by
  rw [hf]
  exact pow_succ_dvd_scaled_iff p c e hp

/-- A coprime derivative makes the Hensel digit unique modulo `p`. -/
theorem hensel_digit_unique_mod
    (p c fp h₁ h₂ : ℤ)
    (hcop : IsCoprime fp p)
    (h₁root : p ∣ c + h₁ * fp)
    (h₂root : p ∣ c + h₂ * fp) :
    h₁ ≡ h₂ [ZMOD p] := by
  apply Int.modEq_of_dvd
  rcases h₁root with ⟨k₁, hk₁⟩
  rcases h₂root with ⟨k₂, hk₂⟩
  have hscaled : p ∣ fp * (h₂ - h₁) := by
    refine ⟨k₂ - k₁, ?_⟩
    calc
      fp * (h₂ - h₁) =
          (c + h₂ * fp) - (c + h₁ * fp) := by ring
      _ = p * (k₂ - k₁) := by rw [hk₁, hk₂]; ring
  exact hcop.symm.dvd_of_dvd_mul_right (by
    simpa [mul_comm] using hscaled)

/-! ## Derivative readouts force transverse support -/

/-- The Fibonacci-channel derivative is coprime to the support modulus once
`4*F' + B = ell*A` and coprimality of `p` with `ell*A` are supplied. -/
theorem fibonacci_derivative_transverse
    (p ell A B Fprime : ℤ)
    (hcop : IsCoprime p (ell * A))
    (hB : p ∣ B)
    (hread : 4 * Fprime + B = ell * A) :
    IsCoprime p Fprime := by
  rcases hcop with ⟨x, y, hxy⟩
  rcases hB with ⟨k, hk⟩
  refine ⟨x + y * k, 4 * y, ?_⟩
  calc
    (x + y * k) * p + 4 * y * Fprime =
        x * p + y * (4 * Fprime + B) := by rw [hk]; ring
    _ = x * p + y * (ell * A) := by rw [hread]
    _ = 1 := hxy

/-- The companion-channel readout `L'=ell*B` transfers coprimality
immediately. -/
theorem lucas_derivative_transverse
    (p ell B Lprime : ℤ)
    (hcop : IsCoprime p (ell * B))
    (hread : Lprime = ell * B) :
    IsCoprime p Lprime := by
  rw [hread]
  exact hcop

/-! ## Index-three Taylor laws and simultaneous steering -/

def F3 (T : ℤ) : ℤ := T ^ 2 + 1
def F3prime (T : ℤ) : ℤ := 2 * T
def L3 (T : ℤ) : ℤ := T ^ 3 + 3 * T
def L3prime (T : ℤ) : ℤ := 3 * T ^ 2 + 3

/-- Exact first-order Taylor congruence for `F3`. -/
theorem F3_taylor_mod_square (p t h : ℤ) :
    F3 (t + p * h) ≡ F3 t + p * h * F3prime t [ZMOD p ^ 2] := by
  apply Int.modEq_of_dvd
  refine ⟨-(h ^ 2), ?_⟩
  simp only [F3, F3prime]
  ring

/-- Exact first-order Taylor congruence for `L3`. -/
theorem L3_taylor_mod_square (p t h : ℤ) :
    L3 (t + p * h) ≡ L3 t + p * h * L3prime t [ZMOD p ^ 2] := by
  apply Int.modEq_of_dvd
  refine ⟨-(h ^ 2 * (3 * t + p * h)), ?_⟩
  simp only [L3, L3prime]
  ring

/-- The two simple roots at the base parameter `2` and their first Hensel
digits are exact. -/
theorem index_three_base_and_digits :
    L3 2 = 14 ∧ L3prime 2 = 15 ∧
    F3 2 = 5 ∧ F3prime 2 = 4 ∧
    7 ∣ L3 (2 + 7 * 5) ∧ 7 ^ 2 ∣ L3 (2 + 7 * 5) ∧
    5 ∣ F3 (2 + 5 * 1) ∧ 5 ^ 2 ∣ F3 (2 + 5 * 1) := by
  norm_num [L3, L3prime, F3, F3prime]

/-- The two lifted residue classes have the unique CRT representative `282`
modulo `49*25`. -/
theorem index_three_crt_residue :
    (282 : ℤ) ≡ 37 [ZMOD 49] ∧
    (282 : ℤ) ≡ 7 [ZMOD 25] ∧
    (282 : ℤ) ≡ 2 [ZMOD 35] := by
  norm_num [Int.ModEq]

/-- Complete numerical certificate for the moving global negative-Pell
counterexample. -/
theorem index_three_global_moving_counterexample :
    F3 282 = 79525 ∧
    L3 282 = 22426614 ∧
    (79525 : ℤ) = 5 ^ 2 * 3181 ∧
    (11213307 : ℤ) = 3 ^ 2 * 7 ^ 2 * 47 * 541 ∧
    (19882 : ℤ) = 2 * 9941 ∧
    (7 : ℤ) ^ 2 ∣ 11213307 ∧
    (5 : ℤ) ^ 2 ∣ 79525 ∧
    (11213307 : ℤ) ^ 2 - 19882 * 79525 ^ 2 = -1 ∧
    (22426614 : ℤ) ^ 2 - ((282 : ℤ) ^ 2 + 4) * 79525 ^ 2 = -4 := by
  norm_num [F3, L3]

/-- The nonrepeated factors in the moving point are explicit, so the point
is not mislabeled as a full squarefull packet. -/
theorem index_three_moving_point_not_full_packet :
    ¬ (47 : ℤ) ^ 2 ∣ 11213307 ∧
    ¬ (3181 : ℤ) ^ 2 ∣ 79525 := by
  norm_num

/-- The displayed odd factor of the moving Pell coefficient is prime. -/
theorem moving_coefficient_large_factor_prime : Nat.Prime 9941 := by
  norm_num

/-- The moving Pell coefficient in the counterexample is squarefree. -/
theorem moving_coefficient_squarefree : Squarefree (19882 : ℕ) := by
  rw [show (19882 : ℕ) = 2 * 9941 by norm_num, Nat.squarefree_mul_iff]
  constructor
  · norm_num
  exact ⟨Nat.prime_two.squarefree, moving_coefficient_large_factor_prime.squarefree⟩

/-- The exact index-three moving packet whose existence the retired
strengthening denied. -/
def IndexThreeMovingPacket (t A B D : ℤ) : Prop :=
  t ≡ 2 [ZMOD 35] ∧
  2 * A = L3 t ∧
  B = F3 t ∧
  4 * D = t ^ 2 + 4 ∧
  A ^ 2 - D * B ^ 2 = -1 ∧
  (7 : ℤ) ^ 2 ∣ A ∧
  (5 : ℤ) ^ 2 ∣ B

/-- A precise moving-parameter exclusion statement, isolated so that its
counterexample does not affect the fixed coefficient-two Pell route. -/
def IndexThreeMovingExclusion : Prop :=
  ∀ t A B D : ℤ, ¬ IndexThreeMovingPacket t A B D

/-- The global moving exclusion is false, witnessed by the fully checked
parameter `282`; this says nothing about the fixed parameter `2`. -/
theorem not_indexThreeMovingExclusion : ¬ IndexThreeMovingExclusion := by
  intro h
  apply h 282 11213307 79525 19882
  norm_num [IndexThreeMovingPacket, F3, L3, Int.ModEq]

/-! ## The actual index-seven specialization collision -/

def F7 (T : ℤ) : ℤ := T ^ 6 + 5 * T ^ 4 + 6 * T ^ 2 + 1
def F7prime (T : ℤ) : ℤ := 6 * T ^ 5 + 20 * T ^ 3 + 12 * T

/-- `F7(2)=13^2` is a simple polynomial root modulo `13`, fixed through
level two but not level three. -/
theorem index_seven_transverse_collision :
    F7 2 = 169 ∧
    F7prime 2 = 376 ∧
    (13 : ℤ) ^ 2 ∣ F7 2 ∧
    ¬ (13 : ℤ) ^ 3 ∣ F7 2 ∧
    ¬ (13 : ℤ) ∣ F7prime 2 := by
  norm_num [F7, F7prime]

/-- The unique next digit is one: the lifted root moves from `2` to `171`
at level three and exits again at level four. -/
theorem index_seven_next_hensel_digit :
    F7 171 = 25006385400373 ∧
    (13 : ℤ) ^ 3 ∣ F7 171 ∧
    ¬ (13 : ℤ) ^ 4 ∣ F7 171 := by
  norm_num [F7]

/-- The unique entire `F3`-channel squarefull value in the certified moving
search, together with the explicit simple factors in the other channel. -/
theorem index_three_bounded_single_channel_squarefull :
    F3 682 = 465125 ∧
    (465125 : ℤ) = 5 ^ 3 * 61 ^ 2 ∧
    L3 682 = 317216614 ∧
    (158608307 : ℤ) = 11 * 13 * 31 * 37 * 967 ∧
    ¬ (11 : ℤ) ^ 2 ∣ 158608307 ∧
    (116282 : ℤ) = 2 * 53 * 1097 ∧
    (158608307 : ℤ) ^ 2 - 116282 * 465125 ^ 2 = -1 := by
  norm_num [F3, L3]

/-- The bounded-search point also has the displayed squarefree Pell
coefficient `116282 = 2*53*1097`. -/
theorem index_three_bounded_coefficient_squarefree :
    Squarefree (116282 : ℕ) := by
  rw [show (116282 : ℕ) = (2 * 53) * 1097 by norm_num,
    Nat.squarefree_mul_iff, Nat.squarefree_mul_iff]
  constructor
  · norm_num
  constructor
  · constructor
    · norm_num
    exact ⟨Nat.prime_two.squarefree,
      (by norm_num : Nat.Prime 53).squarefree⟩
  · exact (by norm_num : Nat.Prime 1097).squarefree

/-- The exact naive specialization claim contradicted by `F7(2)=13^2`. -/
def IndexSevenSimpleRootForcesNoSquare : Prop :=
  (¬ (13 : ℤ) ∣ F7prime 2) → ¬ (13 : ℤ) ^ 2 ∣ F7 2

/-- A simple polynomial root need not have exponent one after integer
specialization. -/
theorem not_indexSevenSimpleRootForcesNoSquare :
    ¬ IndexSevenSimpleRootForcesNoSquare := by
  intro h
  exact h index_seven_transverse_collision.2.2.2.2
    index_seven_transverse_collision.2.2.1

#check pow_succ_dvd_scaled_iff
#check linearized_hensel_dvd_iff
#check hensel_digit_dvd_iff
#check fixed_representative_persists_iff
#check hensel_digit_unique_mod
#check fibonacci_derivative_transverse
#check lucas_derivative_transverse
#check F3_taylor_mod_square
#check L3_taylor_mod_square
#check index_three_base_and_digits
#check index_three_crt_residue
#check index_three_global_moving_counterexample
#check index_three_moving_point_not_full_packet
#check moving_coefficient_large_factor_prime
#check moving_coefficient_squarefree
#check not_indexThreeMovingExclusion
#check index_seven_transverse_collision
#check index_seven_next_hensel_digit
#check index_three_bounded_single_channel_squarefull
#check index_three_bounded_coefficient_squarefree
#check not_indexSevenSimpleRootForcesNoSquare

#print axioms pow_succ_dvd_scaled_iff
#print axioms linearized_hensel_dvd_iff
#print axioms hensel_digit_dvd_iff
#print axioms fixed_representative_persists_iff
#print axioms hensel_digit_unique_mod
#print axioms fibonacci_derivative_transverse
#print axioms lucas_derivative_transverse
#print axioms F3_taylor_mod_square
#print axioms L3_taylor_mod_square
#print axioms index_three_base_and_digits
#print axioms index_three_crt_residue
#print axioms index_three_global_moving_counterexample
#print axioms index_three_moving_point_not_full_packet
#print axioms moving_coefficient_large_factor_prime
#print axioms moving_coefficient_squarefree
#print axioms not_indexThreeMovingExclusion
#print axioms index_seven_transverse_collision
#print axioms index_seven_next_hensel_digit
#print axioms index_three_bounded_single_channel_squarefull
#print axioms index_three_bounded_coefficient_squarefree
#print axioms not_indexSevenSimpleRootForcesNoSquare

end PellPolynomialHenselSpecialization20260902
end IUTThreeClosures
