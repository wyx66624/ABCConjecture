/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.KFullRadicalCompression

/-!
# Walsh's elliptic 3-powerful family and a squarefull-denominator reduction

Walsh proves that, for suitable positive-rank Mordell curves, infinitely many
pairwise coprime integer solutions arise from

`x^3 + y^3 = p^4 z^3`

with `p ∣ z`.  Such solutions give the classical critical `(3,3,3)`-full abc
family.  This file isolates a strict successor.

If the denominator coordinate `z` is additionally `2`-full, then `z^3` is
`6`-full.  Since every prime of `p^4` already occurs in `z^3` when `p ∣ z`,
the complete third endpoint `p^4 z^3` is `6`-full.  Thus the resulting abc
point has signature `(3,3,6)` and satisfies the exact slope

`6 * conductor ≤ 5 * height`.

Consequently an unbounded Walsh subfamily with squarefull denominator
coordinates would disprove `ABCConjecture`.

The file does not assert that such a squarefull-denominator subfamily exists.
That arithmetic statement about denominators of multiples on the Mordell curve
is left as the explicit open input.
-/

namespace IUTThreeClosures
namespace WalshSquarefullDenominator

open KFullRadicalCompression

/-- Every positive exact `k`th power is `k`-full. -/
theorem power_isKFull {x k : ℕ} (hx : x ≠ 0) :
    IsKFull k (x ^ k) := by
  apply (IsKFull.iff_prime_pow_dvd (pow_ne_zero k hx)).2
  intro q hq hqpow
  have hqx : q ∣ x := hq.dvd_of_dvd_pow hqpow
  exact pow_dvd_pow_of_dvd hqx k

/-- The cube of a nonzero squarefull integer is `6`-full. -/
theorem cube_of_twoFull_isSixFull {z : ℕ}
    (hz : IsKFull 2 z) :
    IsKFull 6 (z ^ 3) := by
  apply (IsKFull.iff_prime_pow_dvd
    (pow_ne_zero 3 hz.ne_zero)).2
  intro q hq hqz3
  have hqz : q ∣ z := hq.dvd_of_dvd_pow hqz3
  have hq2 : q ^ 2 ∣ z :=
    (IsKFull.iff_prime_pow_dvd hz.ne_zero).1 hz q hq hqz
  have hpow : (q ^ 2) ^ 3 ∣ z ^ 3 :=
    pow_dvd_pow_of_dvd hq2 3
  simpa [pow_mul] using hpow

/-- Deterministic arithmetic data extracted from one Walsh-type solution,
with the additional squarefull denominator condition isolated explicitly. -/
structure Datum where
  p : ℕ
  x : ℕ
  y : ℕ
  z : ℕ
  prime_p : p.Prime
  x_pos : 0 < x
  y_pos : 0 < y
  z_pos : 0 < z
  equation : x ^ 3 + y ^ 3 = p ^ 4 * z ^ 3
  pairwise_powered :
    PairwiseCoprimeABC (x ^ 3) (y ^ 3) (p ^ 4 * z ^ 3)
  p_dvd_z : p ∣ z
  z_twoFull : IsKFull 2 z

namespace Datum

/-- The primitive abc point attached to the Walsh equation. -/
def point (D : Datum) : ABCPoint where
  a := D.x ^ 3
  b := D.y ^ 3
  c := D.p ^ 4 * D.z ^ 3
  a_pos := pow_pos D.x_pos 3
  b_pos := pow_pos D.y_pos 3
  c_pos := mul_pos (pow_pos D.prime_p.pos 4) (pow_pos D.z_pos 3)
  sum_eq := D.equation
  pairwise_coprime := D.pairwise_powered

@[simp] theorem point_a (D : Datum) : D.point.a = D.x ^ 3 := rfl
@[simp] theorem point_b (D : Datum) : D.point.b = D.y ^ 3 := rfl
@[simp] theorem point_c (D : Datum) :
    D.point.c = D.p ^ 4 * D.z ^ 3 := rfl

/-- The first endpoint is `3`-full. -/
theorem a_threeFull (D : Datum) :
    IsKFull 3 D.point.a := by
  simpa [point] using power_isKFull (k := 3) D.x_pos.ne'

/-- The second endpoint is `3`-full. -/
theorem b_threeFull (D : Datum) :
    IsKFull 3 D.point.b := by
  simpa [point] using power_isKFull (k := 3) D.y_pos.ne'

/-- Because `p ∣ z`, the factor `p^4` introduces no new prime support beyond
`z^3`.  Squarefullness of `z` therefore makes the entire third endpoint
`6`-full. -/
theorem c_sixFull (D : Datum) :
    IsKFull 6 D.point.c := by
  have hz6 : IsKFull 6 (D.z ^ 3) :=
    cube_of_twoFull_isSixFull D.z_twoFull
  have hcne : D.p ^ 4 * D.z ^ 3 ≠ 0 :=
    mul_ne_zero (pow_ne_zero 4 D.prime_p.ne_zero)
      (pow_ne_zero 3 D.z_pos.ne')
  apply (IsKFull.iff_prime_pow_dvd hcne).2
  intro q hq hqc
  have hqz3 : q ∣ D.z ^ 3 := by
    rcases hq.dvd_mul.mp hqc with hqp4 | hqz3
    · have hqp : q ∣ D.p := hq.dvd_of_dvd_pow hqp4
      have hqz : q ∣ D.z := hqp.trans D.p_dvd_z
      exact dvd_pow hqz (by norm_num)
    · exact hqz3
  have hq6 : q ^ 6 ∣ D.z ^ 3 :=
    (IsKFull.iff_prime_pow_dvd
      (pow_ne_zero 3 D.z_pos.ne')).1 hz6 q hq hqz3
  exact dvd_mul_of_dvd_right hq6 (D.p ^ 4)

/-- Radical submultiplicativity for the Walsh abc product. -/
theorem radical_product_le (D : Datum) :
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

/-- Exact arithmetic slope before taking logarithms:

`rad(abc)^6 ≤ c^5`.
-/
theorem radical_product_pow_six_le_c_pow_five (D : Datum) :
    abcRadical (D.point.a * D.point.b * D.point.c) ^ 6 ≤
      D.point.c ^ 5 := by
  have hpow :
      abcRadical (D.point.a * D.point.b * D.point.c) ^ 6 ≤
        (abcRadical D.point.a * abcRadical D.point.b *
          abcRadical D.point.c) ^ 6 :=
    pow_le_pow_left' D.radical_product_le 6
  have ha3 : abcRadical D.point.a ^ 3 ≤ D.point.a :=
    D.a_threeFull.radical_pow_le
  have hb3 : abcRadical D.point.b ^ 3 ≤ D.point.b :=
    D.b_threeFull.radical_pow_le
  have hc6 : abcRadical D.point.c ^ 6 ≤ D.point.c :=
    D.c_sixFull.radical_pow_le
  have ha6 : abcRadical D.point.a ^ 6 ≤ D.point.a ^ 2 := by
    calc
      abcRadical D.point.a ^ 6 =
          (abcRadical D.point.a ^ 3) ^ 2 := by ring
      _ ≤ D.point.a ^ 2 := pow_le_pow_left' ha3 2
  have hb6 : abcRadical D.point.b ^ 6 ≤ D.point.b ^ 2 := by
    calc
      abcRadical D.point.b ^ 6 =
          (abcRadical D.point.b ^ 3) ^ 2 := by ring
      _ ≤ D.point.b ^ 2 := pow_le_pow_left' hb3 2
  have ha : D.point.a ≤ D.point.c := D.point.a_lt_c.le
  have hb : D.point.b ≤ D.point.c := D.point.b_lt_c.le
  calc
    abcRadical (D.point.a * D.point.b * D.point.c) ^ 6 ≤
        (abcRadical D.point.a * abcRadical D.point.b *
          abcRadical D.point.c) ^ 6 := hpow
    _ = abcRadical D.point.a ^ 6 *
          abcRadical D.point.b ^ 6 *
            abcRadical D.point.c ^ 6 := by ring
    _ ≤ D.point.a ^ 2 * D.point.b ^ 2 * D.point.c :=
      Nat.mul_le_mul (Nat.mul_le_mul ha6 hb6) hc6
    _ ≤ D.point.c ^ 2 * D.point.c ^ 2 * D.point.c :=
      Nat.mul_le_mul
        (Nat.mul_le_mul
          (pow_le_pow_left' ha 2)
          (pow_le_pow_left' hb 2))
        le_rfl
    _ = D.point.c ^ 5 := by ring

/-- Logarithmic `(3,3,6)` slope: `6 * conductor ≤ 5 * height`. -/
theorem six_mul_conductor_le_five_mul_height (D : Datum) :
    6 * D.point.conductor ≤ 5 * D.point.height := by
  have hRadPos :
      0 < (abcRadical
        (D.point.a * D.point.b * D.point.c) : ℝ) := by
    exact_mod_cast abcRadical_pos
      (D.point.a * D.point.b * D.point.c)
  have hReal :
      (abcRadical
        (D.point.a * D.point.b * D.point.c) : ℝ) ^ 6 ≤
      (D.point.c : ℝ) ^ 5 := by
    exact_mod_cast D.radical_product_pow_six_le_c_pow_five
  have hLog := Real.log_le_log (pow_pos hRadPos 6) hReal
  rw [Real.log_pow, Real.log_pow, D.point.height_eq_log_c] at hLog
  simpa [ABCPoint.conductor] using hLog

end Datum

/-- An unbounded squarefull-denominator Walsh subfamily would disprove abc. -/
theorem not_abc_of_unbounded_squarefullWalshFamily
    (D : ℕ → Datum)
    (hunbounded :
      ∀ C : ℝ, ∃ n : ℕ, C < (D n).point.height) :
    ¬ ABCConjecture := by
  intro hABC
  have hε : 0 < (1 / 10 : ℝ) := by norm_num
  rcases hABC (1 / 10 : ℝ) hε with ⟨C, hC⟩
  rcases hunbounded (12 * C) with ⟨n, hn⟩
  let P : ABCPoint := (D n).point
  have hABCRaw := hC
    P.a P.b P.c
    P.a_pos P.b_pos P.c_pos
    P.sum_eq P.pairwise_coprime
  have hABCPoint :
      P.height ≤ (1 + (1 / 10 : ℝ)) * P.conductor + C := by
    simpa [ABCPoint.height, ABCPoint.conductor] using hABCRaw
  have hSlope : 6 * P.conductor ≤ 5 * P.height := by
    simpa [P] using (D n).six_mul_conductor_le_five_mul_height
  linarith

end WalshSquarefullDenominator
end IUTThreeClosures
