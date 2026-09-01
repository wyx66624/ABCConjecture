/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineShearAmplification20260831

/-!
# Deterministic core of the sharpened affine exceptional-set upper bound

The mathematical proof precedes this file in
`research/ABC_AFFINE_EXCESS_LOWER_BOUND_2026_08_31.md`.

The external de Bruijn radical-counting estimate is deliberately not declared
as an axiom here.  This module checks the three pair-projection injections,
the same-prime exclusion forced by primitivity, and the cube-free integer form
of the geometric-mean step used by the analytic proof.
-/

namespace IUTThreeClosures
namespace AffineShearAmplification20260831
namespace Seed

/-- The first two unscaled cofactors recover both affine parameters. -/
theorem pair_UV_injective (S : Seed) :
    Function.Injective
      (fun hk : ℕ × ℕ => (S.U hk.1, S.V hk.1 hk.2)) := by
  rintro ⟨h, k⟩ ⟨h', k'⟩ heq
  have hU : S.U h = S.U h' := congrArg Prod.fst heq
  have hPh : S.P * h = S.P * h' := by simpa [U] using hU
  have hh : h = h' := Nat.mul_left_cancel S.P_pos hPh
  subst h'
  have hV : S.V h k = S.V h k' := congrArg Prod.snd heq
  have hPk : S.P * S.c * k = S.P * S.c * k' := by
    simpa [S.V_eq_U_add] using hV
  have hk : k = k' := Nat.mul_left_cancel (mul_pos S.P_pos S.c_pos) hPk
  subst k'
  rfl

/-- The first and third unscaled cofactors recover both affine parameters. -/
theorem pair_UW_injective (S : Seed) :
    Function.Injective
      (fun hk : ℕ × ℕ => (S.U hk.1, S.W hk.1 hk.2)) := by
  rintro ⟨h, k⟩ ⟨h', k'⟩ heq
  have hU : S.U h = S.U h' := congrArg Prod.fst heq
  have hPh : S.P * h = S.P * h' := by simpa [U] using hU
  have hh : h = h' := Nat.mul_left_cancel S.P_pos hPh
  subst h'
  have hW : S.W h k = S.W h k' := congrArg Prod.snd heq
  have hPk : S.P * S.b * k = S.P * S.b * k' := by
    simpa [S.W_eq_U_add] using hW
  have hk : k = k' := Nat.mul_left_cancel (mul_pos S.P_pos S.b_pos) hPk
  subst k'
  rfl

/-- The final two unscaled cofactors also recover both affine parameters. -/
theorem pair_VW_injective (S : Seed) :
    Function.Injective
      (fun hk : ℕ × ℕ => (S.V hk.1 hk.2, S.W hk.1 hk.2)) := by
  rintro ⟨h, k⟩ ⟨h', k'⟩ heq
  have hV : S.V h k = S.V h' k' := congrArg Prod.fst heq
  have hW : S.W h k = S.W h' k' := congrArg Prod.snd heq
  have hsum : S.W h k + S.P * S.a * k =
      S.W h k + S.P * S.a * k' := by
    calc
      S.W h k + S.P * S.a * k = S.V h k := (S.V_eq_W_add h k).symm
      _ = S.V h' k' := hV
      _ = S.W h' k' + S.P * S.a * k' := S.V_eq_W_add h' k'
      _ = S.W h k + S.P * S.a * k' := by rw [hW]
  have hPk : S.P * S.a * k = S.P * S.a * k' := Nat.add_left_cancel hsum
  have hk : k = k' := Nat.mul_left_cancel (mul_pos S.P_pos S.a_pos) hPk
  subst k'
  have hinside : h + S.c * k = h' + S.c * k := by
    apply Nat.mul_left_cancel S.P_pos
    simpa [V] using hV
  have hh : h = h' := Nat.add_right_cancel hinside
  subst h'
  rfl

namespace Parameter

variable {S : Seed}

/-- At an admissible point, no prime can divide two of the three cofactors. -/
theorem local_pairwise_prime_exclusion (q : Parameter S) {p : ℕ}
    (hp : p.Prime) :
    ¬ (p ∣ S.U q.h ∧ p ∣ S.V q.h q.k) ∧
    ¬ (p ∣ S.U q.h ∧ p ∣ S.W q.h q.k) ∧
    ¬ (p ∣ S.V q.h q.k ∧ p ∣ S.W q.h q.k) := by
  constructor
  · rintro ⟨hpU, hpV⟩
    apply hp.not_dvd_one
    rw [← q.U_coprime_V.gcd_eq_one]
    exact Nat.dvd_gcd hpU hpV
  constructor
  · rintro ⟨hpU, hpW⟩
    apply hp.not_dvd_one
    rw [← q.U_coprime_W.gcd_eq_one]
    exact Nat.dvd_gcd hpU hpW
  · rintro ⟨hpV, hpW⟩
    apply hp.not_dvd_one
    rw [← q.V_coprime_W.gcd_eq_one]
    exact Nat.dvd_gcd hpV hpW

end Parameter
end Seed
end AffineShearAmplification20260831

namespace AffineExcessUpperBound20260831

/-- Cube-free integer form of the geometric-mean step: if the triple product
is below a cube, at least one pair product is below the corresponding square. -/
theorem min_pair_product_lt_square_of_triple_lt_cube
    {x y z B : ℕ} (h : x * y * z < B ^ 3) :
    x * y < B ^ 2 ∨ x * z < B ^ 2 ∨ y * z < B ^ 2 := by
  by_contra hnone
  push Not at hnone
  rcases hnone with ⟨hxy, hxz, hyz⟩
  have hpairs : B ^ 6 ≤ (x * y * z) ^ 2 := by
    calc
      B ^ 6 = (B ^ 2) * (B ^ 2) * (B ^ 2) := by ring
      _ ≤ (x * y) * (x * z) * (y * z) :=
        Nat.mul_le_mul (Nat.mul_le_mul hxy hxz) hyz
      _ = (x * y * z) ^ 2 := by ring
  have hsquare : (x * y * z) ^ 2 < (B ^ 3) ^ 2 :=
    Nat.pow_lt_pow_left h (by norm_num)
  have hcubesquare : (B ^ 3) ^ 2 = B ^ 6 := by ring
  rw [hcubesquare] at hsquare
  exact (Nat.not_lt_of_ge hpairs) hsquare

#print axioms AffineShearAmplification20260831.Seed.pair_UV_injective
#print axioms AffineShearAmplification20260831.Seed.pair_UW_injective
#print axioms AffineShearAmplification20260831.Seed.pair_VW_injective
#print axioms AffineShearAmplification20260831.Seed.Parameter.local_pairwise_prime_exclusion
#print axioms min_pair_product_lt_square_of_triple_lt_cube

end AffineExcessUpperBound20260831
end IUTThreeClosures
