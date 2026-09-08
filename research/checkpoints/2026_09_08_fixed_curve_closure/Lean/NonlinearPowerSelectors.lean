import Mathlib.RingTheory.Coprime.Lemmas
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

/-!
# Actual square and cube root-parameter selectors

Integer coordinates use `zeta^2 = zeta - 1`. Both outputs below are literal
products of the root `(3*k, 1)`. This module proves only their elementary
arithmetic. Density, CRT packets, separability and infinite tails are outside
its scope.
-/

set_option autoImplicit false
set_option maxHeartbeats 800000

namespace ABCNonlinearPowerSelectors

abbrev Pair := ℤ × ℤ

def mul (z w : Pair) : Pair :=
  (z.1 * w.1 - z.2 * w.2, z.1 * w.2 + z.2 * w.1 + z.2 * w.2)

def norm (z : Pair) : ℤ := z.1 ^ 2 + z.1 * z.2 + z.2 ^ 2

def boundary (z : Pair) : ℤ := z.1 * z.2 * (z.1 + z.2)

def root (k : ℤ) : Pair := (3 * k, 1)

def square (k : ℤ) : Pair := mul (root k) (root k)

def cube (k : ℤ) : Pair := mul (square k) (root k)

theorem root_norm_formula (k : ℤ) : norm (root k) = 9 * k ^ 2 + 3 * k + 1 := by
  dsimp [norm, root]
  ring

theorem root_norm_mod_three (k : ℤ) : norm (root k) % 3 = 1 := by
  rw [root_norm_formula]
  have h : 9 * k ^ 2 + 3 * k + 1 = 3 * (3 * k ^ 2 + k) + 1 := by ring
  rw [h]
  omega

theorem root_norm_gt_one (k : ℤ) (hk : 1 ≤ k) : 1 < norm (root k) := by
  rw [root_norm_formula]
  nlinarith [sq_nonneg k]

theorem square_coordinates (k : ℤ) : square k = (9 * k ^ 2 - 1, 6 * k + 1) := by
  ext <;> dsimp [square, mul, root] <;> ring

theorem square_sum (k : ℤ) : (square k).1 + (square k).2 = 3 * k * (3 * k + 2) := by
  rw [square_coordinates]
  dsimp
  ring

theorem square_norm (k : ℤ) : norm (square k) = norm (root k) ^ 2 := by
  rw [square_coordinates, root_norm_formula]
  dsimp [norm]
  ring

theorem square_boundary (k : ℤ) :
    boundary (square k) = (3 * k - 1) * (3 * k + 1) * (6 * k + 1) *
      (3 * k) * (3 * k + 2) := by
  rw [square_coordinates]
  dsimp [boundary]
  ring

theorem square_positive (k : ℤ) (hk : 1 ≤ k) :
    0 < (square k).1 ∧ 0 < (square k).2 ∧
      0 < (square k).1 + (square k).2 ∧ 0 < boundary (square k) := by
  have h1 : 0 < (square k).1 := by
    rw [square_coordinates]
    dsimp
    nlinarith [sq_nonneg (k - 1)]
  have h2 : 0 < (square k).2 := by
    rw [square_coordinates]
    dsimp
    omega
  exact ⟨h1, h2, add_pos h1 h2, mul_pos (mul_pos h1 h2) (add_pos h1 h2)⟩

theorem square_coprime (k : ℤ) : IsCoprime (square k).1 (square k).2 := by
  rw [square_coordinates]
  refine ⟨-12 * k ^ 2 - 1, 3 * k ^ 2 * (6 * k - 1), ?_⟩
  dsimp
  ring

theorem cube_coordinates (k : ℤ) :
    cube k = ((3 * k) ^ 3 - 3 * (3 * k) - 1, 3 * (3 * k) * (3 * k + 1)) := by
  ext <;> dsimp [cube, square, mul, root] <;> ring

theorem cube_sum (k : ℤ) :
    (cube k).1 + (cube k).2 = (3 * k) ^ 3 + 3 * (3 * k) ^ 2 - 1 := by
  rw [cube_coordinates]
  dsimp
  ring

theorem cube_norm (k : ℤ) : norm (cube k) = norm (root k) ^ 3 := by
  rw [cube_coordinates, root_norm_formula]
  dsimp [norm]
  ring

theorem cube_boundary (k : ℤ) :
    boundary (cube k) = 3 * (3 * k) * (3 * k + 1) *
      ((3 * k) ^ 3 - 3 * (3 * k) - 1) *
      ((3 * k) ^ 3 + 3 * (3 * k) ^ 2 - 1) := by
  rw [cube_coordinates]
  dsimp [boundary]
  ring

theorem cube_positive (k : ℤ) (hk : 1 ≤ k) :
    0 < (cube k).1 ∧ 0 < (cube k).2 ∧
      0 < (cube k).1 + (cube k).2 ∧ 0 < boundary (cube k) := by
  have ha : (3 : ℤ) ≤ 3 * k := by omega
  have h1 : 0 < (cube k).1 := by
    rw [cube_coordinates]
    dsimp
    nlinarith [sq_nonneg (3 * k), mul_nonneg (sub_nonneg.mpr ha) (sq_nonneg (3 * k))]
  have h2 : 0 < (cube k).2 := by
    rw [cube_coordinates]
    dsimp
    positivity
  exact ⟨h1, h2, add_pos h1 h2, mul_pos (mul_pos h1 h2) (add_pos h1 h2)⟩

theorem cube_coprime (k : ℤ) : IsCoprime (cube k).1 (cube k).2 := by
  rw [cube_coordinates]
  dsimp
  have h3 : IsCoprime ((3 * k) ^ 3 - 3 * (3 * k) - 1) (3 : ℤ) := by
    refine ⟨-1, 9 * k ^ 3 - 3 * k, ?_⟩
    ring
  have ha : IsCoprime ((3 * k) ^ 3 - 3 * (3 * k) - 1) (3 * k) := by
    refine ⟨-1, (3 * k) ^ 2 - 3, ?_⟩
    ring
  have hb : IsCoprime ((3 * k) ^ 3 - 3 * (3 * k) - 1) (3 * k + 1) := by
    refine ⟨1, -((3 * k) ^ 2 - 3 * k - 2), ?_⟩
    ring
  exact (h3.mul_right ha).mul_right hb

/-- The three actual arms of any coprime integer pair have gcd one pairwise. -/
theorem coprime_arm_gcds (a b : ℤ) (h : IsCoprime a b) :
    Int.gcd a b = 1 ∧ Int.gcd a (a + b) = 1 ∧ Int.gcd b (a + b) = 1 := by
  obtain ⟨u, v, huv⟩ := h
  have h1 : IsCoprime a b := ⟨u, v, huv⟩
  have h2 : IsCoprime a (a + b) := by
    refine ⟨u - v, v, ?_⟩
    linear_combination huv
  have h3 : IsCoprime b (a + b) := by
    refine ⟨v - u, u, ?_⟩
    linear_combination huv
  exact ⟨Int.isCoprime_iff_gcd_eq_one.mp h1, Int.isCoprime_iff_gcd_eq_one.mp h2,
    Int.isCoprime_iff_gcd_eq_one.mp h3⟩

theorem square_pairwise_gcd (k : ℤ) :
    Int.gcd (square k).1 (square k).2 = 1 ∧
      Int.gcd (square k).1 ((square k).1 + (square k).2) = 1 ∧
      Int.gcd (square k).2 ((square k).1 + (square k).2) = 1 :=
  coprime_arm_gcds _ _ (square_coprime k)

theorem cube_pairwise_gcd (k : ℤ) :
    Int.gcd (cube k).1 (cube k).2 = 1 ∧
      Int.gcd (cube k).1 ((cube k).1 + (cube k).2) = 1 ∧
      Int.gcd (cube k).2 ((cube k).1 + (cube k).2) = 1 :=
  coprime_arm_gcds _ _ (cube_coprime k)

/-- Over a field, a boundary zero and a norm zero force both coordinates to vanish. -/
theorem boundary_norm_common_zero {F : Type*} [Field F] (a b : F)
    (hboundary : a * b * (a + b) = 0) (hnorm : a ^ 2 + a * b + b ^ 2 = 0) :
    a = 0 ∧ b = 0 := by
  rcases mul_eq_zero.mp hboundary with hab | hab
  · rcases mul_eq_zero.mp hab with ha | hb
    · subst a
      simp only [zero_pow (by decide : 2 ≠ 0), zero_mul, zero_add] at hnorm
      exact ⟨rfl, eq_zero_of_pow_eq_zero hnorm⟩
    · subst b
      simp only [zero_pow (by decide : 2 ≠ 0), mul_zero, add_zero] at hnorm
      exact ⟨eq_zero_of_pow_eq_zero hnorm, rfl⟩
  · have hb : b ^ 2 = 0 := by linear_combination hnorm - a * hab
    have hb0 : b = 0 := eq_zero_of_pow_eq_zero hb
    exact ⟨by simpa [hb0] using hab, hb0⟩

/-- Every prime dividing the full boundary of a primitive pair is coprime to its norm. -/
theorem primitive_boundary_norm_unit (z : Pair) (hprim : IsCoprime z.1 z.2)
    (q : ℕ) (hq : q.Prime) (hboundary : (q : ℤ) ∣ boundary z) :
    IsUnit ((norm z : ℤ) : ZMod q) := by
  letI : Fact q.Prime := ⟨hq⟩
  apply isUnit_iff_ne_zero.mpr
  intro hzero
  have hb : (z.1 : ZMod q) * (z.2 : ZMod q) * ((z.1 : ZMod q) + z.2) = 0 := by
    have h := (ZMod.intCast_zmod_eq_zero_iff_dvd (boundary z) q).mpr hboundary
    simpa only [boundary, Int.cast_mul, Int.cast_add] using h
  have hn : (z.1 : ZMod q) ^ 2 + (z.1 : ZMod q) * z.2 + (z.2 : ZMod q) ^ 2 = 0 := by
    simpa only [norm, Int.cast_add, Int.cast_pow, Int.cast_mul] using hzero
  obtain ⟨ha, hc⟩ := boundary_norm_common_zero _ _ hb hn
  obtain ⟨u, v, huv⟩ := hprim
  have hcast := congrArg (fun t : ℤ ↦ (t : ZMod q)) huv
  simp only [Int.cast_add, Int.cast_mul, Int.cast_one, ha, hc, mul_zero, zero_add] at hcast
  exact zero_ne_one hcast

theorem square_boundary_root_norm_unit (k : ℤ) (q : ℕ) (hq : q.Prime)
    (hboundary : (q : ℤ) ∣ boundary (square k)) : IsUnit ((norm (root k) : ℤ) : ZMod q) := by
  letI : Fact q.Prime := ⟨hq⟩
  have hunit := primitive_boundary_norm_unit (square k) (square_coprime k) q hq hboundary
  apply isUnit_iff_ne_zero.mpr
  intro hzero
  apply hunit.ne_zero
  rw [square_norm, Int.cast_pow, hzero]
  norm_num

theorem cube_boundary_root_norm_unit (k : ℤ) (q : ℕ) (hq : q.Prime)
    (hboundary : (q : ℤ) ∣ boundary (cube k)) : IsUnit ((norm (root k) : ℤ) : ZMod q) := by
  letI : Fact q.Prime := ⟨hq⟩
  have hunit := primitive_boundary_norm_unit (cube k) (cube_coprime k) q hq hboundary
  apply isUnit_iff_ne_zero.mpr
  intro hzero
  apply hunit.ne_zero
  rw [cube_norm, Int.cast_pow, hzero]
  norm_num

theorem square_boundary_root_norm_not_dvd (k : ℤ) (q : ℕ) (hq : q.Prime)
    (hboundary : (q : ℤ) ∣ boundary (square k)) : ¬(q : ℤ) ∣ norm (root k) := by
  letI : Fact q.Prime := ⟨hq⟩
  intro hdiv
  exact (square_boundary_root_norm_unit k q hq hboundary).ne_zero
    ((ZMod.intCast_zmod_eq_zero_iff_dvd _ q).mpr hdiv)

theorem cube_boundary_root_norm_not_dvd (k : ℤ) (q : ℕ) (hq : q.Prime)
    (hboundary : (q : ℤ) ∣ boundary (cube k)) : ¬(q : ℤ) ∣ norm (root k) := by
  letI : Fact q.Prime := ⟨hq⟩
  intro hdiv
  exact (cube_boundary_root_norm_unit k q hq hboundary).ne_zero
    ((ZMod.intCast_zmod_eq_zero_iff_dvd _ q).mpr hdiv)

#print axioms root_norm_formula
#print axioms root_norm_mod_three
#print axioms root_norm_gt_one
#print axioms square_coordinates
#print axioms square_sum
#print axioms square_norm
#print axioms square_boundary
#print axioms square_positive
#print axioms square_coprime
#print axioms cube_coordinates
#print axioms cube_sum
#print axioms cube_norm
#print axioms cube_boundary
#print axioms cube_positive
#print axioms cube_coprime
#print axioms coprime_arm_gcds
#print axioms square_pairwise_gcd
#print axioms cube_pairwise_gcd
#print axioms boundary_norm_common_zero
#print axioms primitive_boundary_norm_unit
#print axioms square_boundary_root_norm_unit
#print axioms cube_boundary_root_norm_unit
#print axioms square_boundary_root_norm_not_dvd
#print axioms cube_boundary_root_norm_not_dvd

end ABCNonlinearPowerSelectors
