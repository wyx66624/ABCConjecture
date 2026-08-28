/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LowRadicalNeighbourTransfer

/-!
# The exact k-full threshold for an abc disproof route

Call a positive integer `n` `k`-full when

`abcRadical n ^ k ∣ n`.

If every entry of a primitive abc triple is `k`-full, then

`abcRadical (a*b*c)^k ≤ a*b*c ≤ c^3`.

Taking logarithms gives the exact slope inequality

`k * conductor ≤ 3 * height`.

Consequently an unbounded family of primitive `k`-full abc triples disproves
`ABCConjecture` for every fixed `k ≥ 4`, since `3/k < 1`.  The exponent three
is the critical boundary: this argument gives only coefficient one when
`k = 3`.

This file proves only the deterministic threshold and contradiction transfer.
It does not assume or assert the existence of an unbounded `k`-full family.
-/

namespace IUTThreeClosures

/-- Radical formulation of a `k`-full natural number. -/
def IsKFull (k n : ℕ) : Prop :=
  abcRadical n ^ k ∣ n

namespace IsKFull

/-- On a positive `k`-full integer, the `k`th power of the radical is bounded
by the integer itself. -/
theorem radical_pow_le {k n : ℕ} (h : IsKFull k n) (hn : 0 < n) :
    abcRadical n ^ k ≤ n := by
  exact Nat.le_of_dvd hn h

end IsKFull

/-- A primitive positive abc point all three of whose entries are `k`-full. -/
structure KFullABCPoint (k : ℕ) where
  point : ABCPoint
  full_a : IsKFull k point.a
  full_b : IsKFull k point.b
  full_c : IsKFull k point.c

namespace ABCPoint

/-- The elementary abc conductor is nonnegative. -/
theorem conductor_nonneg (P : ABCPoint) : 0 ≤ P.conductor := by
  unfold conductor
  have hOneNat : 1 ≤ abcRadical (P.a * P.b * P.c) :=
    Nat.one_le_iff_ne_zero.2
      (abcRadical_pos (P.a * P.b * P.c)).ne'
  have hOneReal :
      (1 : ℝ) ≤ (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast hOneNat
  exact Real.log_nonneg hOneReal

end ABCPoint

namespace KFullABCPoint

variable {k : ℕ}

/-- Submultiplicativity bounds the radical of the abc product by the product
of the three individual radicals. -/
theorem radical_product_le (D : KFullABCPoint k) :
    abcRadical (D.point.a * D.point.b * D.point.c) ≤
      abcRadical D.point.a * abcRadical D.point.b *
        abcRadical D.point.c := by
  calc
    abcRadical (D.point.a * D.point.b * D.point.c) ≤
        abcRadical (D.point.a * D.point.b) *
          abcRadical D.point.c :=
      abcRadical_mul_le_mul (D.point.a * D.point.b) D.point.c
    _ ≤ (abcRadical D.point.a * abcRadical D.point.b) *
          abcRadical D.point.c :=
      Nat.mul_le_mul_right _
        (abcRadical_mul_le_mul D.point.a D.point.b)

/-- Raising the preceding radical bound to `k` and using `k`-fullness gives
`rad(abc)^k ≤ abc`. -/
theorem radical_product_pow_le_product (D : KFullABCPoint k) :
    abcRadical (D.point.a * D.point.b * D.point.c) ^ k ≤
      D.point.a * D.point.b * D.point.c := by
  have hpow :
      abcRadical (D.point.a * D.point.b * D.point.c) ^ k ≤
        (abcRadical D.point.a * abcRadical D.point.b *
          abcRadical D.point.c) ^ k :=
    pow_le_pow_left' D.radical_product_le k
  have ha : abcRadical D.point.a ^ k ≤ D.point.a :=
    D.full_a.radical_pow_le D.point.a_pos
  have hb : abcRadical D.point.b ^ k ≤ D.point.b :=
    D.full_b.radical_pow_le D.point.b_pos
  have hc : abcRadical D.point.c ^ k ≤ D.point.c :=
    D.full_c.radical_pow_le D.point.c_pos
  calc
    abcRadical (D.point.a * D.point.b * D.point.c) ^ k ≤
        (abcRadical D.point.a * abcRadical D.point.b *
          abcRadical D.point.c) ^ k := hpow
    _ = (abcRadical D.point.a ^ k * abcRadical D.point.b ^ k) *
          abcRadical D.point.c ^ k := by
      simp only [mul_pow]
    _ ≤ (D.point.a * D.point.b) * D.point.c :=
      Nat.mul_le_mul (Nat.mul_le_mul ha hb) hc

/-- Every positive abc product is at most the cube of its largest entry `c`. -/
theorem point_product_le_cube (D : KFullABCPoint k) :
    D.point.a * D.point.b * D.point.c ≤ D.point.c ^ 3 := by
  have ha : D.point.a ≤ D.point.c := D.point.a_lt_c.le
  have hb : D.point.b ≤ D.point.c := D.point.b_lt_c.le
  calc
    D.point.a * D.point.b * D.point.c ≤
        D.point.c * D.point.c * D.point.c :=
      Nat.mul_le_mul (Nat.mul_le_mul ha hb) le_rfl
    _ = D.point.c ^ 3 := by ring

/-- The exact arithmetic inequality behind the threshold `3/k`. -/
theorem radical_product_pow_le_cube (D : KFullABCPoint k) :
    abcRadical (D.point.a * D.point.b * D.point.c) ^ k ≤
      D.point.c ^ 3 :=
  D.radical_product_pow_le_product.trans D.point_product_le_cube

/-- Logarithmic form of the arithmetic inequality:
`k * conductor ≤ 3 * height`. -/
theorem k_mul_conductor_le_three_mul_height (D : KFullABCPoint k) :
    (k : ℝ) * D.point.conductor ≤ 3 * D.point.height := by
  have hRadPos :
      0 < (abcRadical (D.point.a * D.point.b * D.point.c) : ℝ) := by
    exact_mod_cast abcRadical_pos
      (D.point.a * D.point.b * D.point.c)
  have hReal :
      (abcRadical (D.point.a * D.point.b * D.point.c) : ℝ) ^ k ≤
        (D.point.c : ℝ) ^ 3 := by
    exact_mod_cast D.radical_product_pow_le_cube
  have hLog := Real.log_le_log (pow_pos hRadPos k) hReal
  rw [Real.log_pow, Real.log_pow] at hLog
  rw [D.point.height_eq_log_c]
  simpa [ABCPoint.conductor] using hLog

/-- At exponent three the deterministic route reaches exactly the abc
coefficient one, with no strict saving. -/
theorem conductor_le_height_of_threeFull (D : KFullABCPoint 3) :
    D.point.conductor ≤ D.point.height := by
  have h := D.k_mul_conductor_le_three_mul_height
  norm_num at h
  linarith

end KFullABCPoint

/-- An unbounded family of primitive `k`-full abc triples for any fixed
`k ≥ 4` contradicts the abc conjecture. -/
theorem not_abc_of_unbounded_kFullABC
    {k : ℕ}
    (hk : 4 ≤ k)
    (D : ℕ → KFullABCPoint k)
    (hunbounded :
      ∀ C : ℝ, ∃ n : ℕ, C < (D n).point.height) :
    ¬ ABCConjecture := by
  intro hABC
  have hε : 0 < (1 / 6 : ℝ) := by norm_num
  rcases hABC (1 / 6 : ℝ) hε with ⟨C, hC⟩
  rcases hunbounded (8 * C) with ⟨n, hn⟩
  let P : ABCPoint := (D n).point
  have hABCRaw := hC
    P.a P.b P.c
    P.a_pos P.b_pos P.c_pos
    P.sum_eq P.pairwise_coprime
  have hABCPoint :
      P.height ≤ (1 + (1 / 6 : ℝ)) * P.conductor + C := by
    simpa [ABCPoint.height, ABCPoint.conductor] using hABCRaw
  have hkReal : (4 : ℝ) ≤ (k : ℝ) := by
    exact_mod_cast hk
  have hFourToK :
      4 * P.conductor ≤ (k : ℝ) * P.conductor :=
    mul_le_mul_of_nonneg_right hkReal P.conductor_nonneg
  have hSlope :
      (k : ℝ) * P.conductor ≤ 3 * P.height := by
    simpa [P] using (D n).k_mul_conductor_le_three_mul_height
  have hFour : 4 * P.conductor ≤ 3 * P.height :=
    hFourToK.trans hSlope
  linarith

/-- The first strict case, isolated for direct reuse. -/
theorem not_abc_of_unbounded_fourFullABC
    (D : ℕ → KFullABCPoint 4)
    (hunbounded :
      ∀ C : ℝ, ∃ n : ℕ, C < (D n).point.height) :
    ¬ ABCConjecture :=
  not_abc_of_unbounded_kFullABC (by norm_num) D hunbounded

end IUTThreeClosures
