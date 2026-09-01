/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PellSquareRootDescent20260831

/-!
# An exact Hall squarefull counterexample gate

The complete integer proof precedes this file in
`research/ABC_HALL_SQUAREFULL_GATE_2026_08_31.md`.

For primitive positive data `X^3 + K = Y^2`, squarefullness of `K` and the
exact size condition `K^2 <= X` imply

`rad(X^3*K*Y^2)^12 < (Y^2)^11`.

Thus a height-unbounded family of such data would contradict the unchanged
standard `ABCConjecture`.  This file does not assert that such a family
exists.
-/

namespace IUTThreeClosures
namespace HallSquarefullCounterexample20260831

open KFullRadicalCompression

noncomputable section

/-- One primitive Hall datum with an exact square-root-sized squarefull
remainder. -/
structure Datum where
  X : ℕ
  Y : ℕ
  K : ℕ
  X_pos : 0 < X
  Y_pos : 0 < Y
  K_pos : 0 < K
  equation : X ^ 3 + K = Y ^ 2
  XY_coprime : Nat.Coprime X Y
  K_twoFull : IsKFull 2 K
  K_sq_le_X : K ^ 2 ≤ X

namespace Datum

/-- The associated Hall abc point. -/
def point (D : Datum) : ABCPoint where
  a := D.X ^ 3
  b := D.K
  c := D.Y ^ 2
  a_pos := pow_pos D.X_pos 3
  b_pos := D.K_pos
  c_pos := pow_pos D.Y_pos 2
  sum_eq := D.equation
  pairwise_coprime := by
    have hXYpow : Nat.Coprime (D.X ^ 3) (D.Y ^ 2) :=
      (D.XY_coprime.pow_left 3).pow_right 2
    have hXK : Nat.Coprime (D.X ^ 3) D.K := by
      rw [← Nat.coprime_self_add_right]
      simpa [D.equation] using hXYpow
    have hKY : Nat.Coprime D.K (D.Y ^ 2) := by
      rw [← D.equation, Nat.coprime_add_self_right]
      exact hXK.symm
    exact ⟨hXK, hKY, hXYpow.symm⟩

@[simp] theorem point_a (D : Datum) : D.point.a = D.X ^ 3 := rfl
@[simp] theorem point_b (D : Datum) : D.point.b = D.K := rfl
@[simp] theorem point_c (D : Datum) : D.point.c = D.Y ^ 2 := rfl

/-- Radical submultiplicativity removes the perfect-power exponents. -/
theorem point_radical_le (D : Datum) :
    abcRadical (D.point.a * D.point.b * D.point.c) ≤
      D.X * abcRadical D.K * D.Y := by
  calc
    abcRadical (D.point.a * D.point.b * D.point.c) =
        abcRadical (D.X ^ 3 * D.K * D.Y ^ 2) := by rfl
    _ ≤ abcRadical (D.X ^ 3 * D.K) * abcRadical (D.Y ^ 2) :=
      abcRadical_mul_le_mul (D.X ^ 3 * D.K) (D.Y ^ 2)
    _ ≤ (abcRadical (D.X ^ 3) * abcRadical D.K) *
        abcRadical (D.Y ^ 2) :=
      Nat.mul_le_mul_right _ (abcRadical_mul_le_mul (D.X ^ 3) D.K)
    _ = abcRadical D.X * abcRadical D.K * abcRadical D.Y := by
      rw [abcRadical_pow (by norm_num : (3 : ℕ) ≠ 0),
        abcRadical_pow (by norm_num : (2 : ℕ) ≠ 0)]
    _ ≤ D.X * abcRadical D.K * D.Y :=
      Nat.mul_le_mul
        (Nat.mul_le_mul_right (abcRadical D.K)
          (abcRadical_le_self D.X_pos.ne'))
        (abcRadical_le_self D.Y_pos.ne')

/-- The exact twelfth-power form of the `11/12` Hall radical slope. -/
theorem point_radical_pow_twelve_lt_height_pow_eleven (D : Datum) :
    abcRadical (D.point.a * D.point.b * D.point.c) ^ 12 <
      D.point.c ^ 11 := by
  let R := abcRadical (D.point.a * D.point.b * D.point.c)
  have hrad : R ≤ D.X * abcRadical D.K * D.Y := by
    simpa [R] using D.point_radical_le
  have hradPow := Nat.pow_le_pow_left hrad 12
  have hKrad : abcRadical D.K ^ 2 ≤ D.K :=
    D.K_twoFull.radical_pow_le
  have hKradTwelve : abcRadical D.K ^ 12 ≤ D.K ^ 6 := by
    have h := Nat.pow_le_pow_left hKrad 6
    calc
      abcRadical D.K ^ 12 = (abcRadical D.K ^ 2) ^ 6 := by ring
      _ ≤ D.K ^ 6 := h
  have hKSix : D.K ^ 6 ≤ D.X ^ 3 := by
    have h := Nat.pow_le_pow_left D.K_sq_le_X 3
    calc
      D.K ^ 6 = (D.K ^ 2) ^ 3 := by ring
      _ ≤ D.X ^ 3 := h
  have hXcube : D.X ^ 3 < D.Y ^ 2 := by
    nlinarith [D.equation, D.K_pos]
  have hXfifteen : D.X ^ 15 < D.Y ^ 10 := by
    have h := Nat.pow_lt_pow_left hXcube (by norm_num : (5 : ℕ) ≠ 0)
    calc
      D.X ^ 15 = (D.X ^ 3) ^ 5 := by ring
      _ < (D.Y ^ 2) ^ 5 := h
      _ = D.Y ^ 10 := by ring
  simp only [point_c]
  calc
    R ^ 12 ≤ (D.X * abcRadical D.K * D.Y) ^ 12 := hradPow
    _ = D.X ^ 12 * abcRadical D.K ^ 12 * D.Y ^ 12 := by ring
    _ ≤ D.X ^ 12 * D.K ^ 6 * D.Y ^ 12 :=
      Nat.mul_le_mul_right (D.Y ^ 12)
        (Nat.mul_le_mul_left (D.X ^ 12) hKradTwelve)
    _ ≤ D.X ^ 12 * D.X ^ 3 * D.Y ^ 12 :=
      Nat.mul_le_mul_right (D.Y ^ 12)
        (Nat.mul_le_mul_left (D.X ^ 12) hKSix)
    _ = D.X ^ 15 * D.Y ^ 12 := by ring
    _ < D.Y ^ 10 * D.Y ^ 12 :=
      Nat.mul_lt_mul_of_pos_right hXfifteen (pow_pos D.Y_pos 12)
    _ = (D.Y ^ 2) ^ 11 := by ring

/-- Logarithmic form of the exact Hall compression. -/
theorem point_conductor_lt_eleven_twelfths_height (D : Datum) :
    D.point.conductor < (11 / 12 : ℝ) * D.point.height := by
  let R := abcRadical (D.point.a * D.point.b * D.point.c)
  have hnat : R ^ 12 < (D.Y ^ 2) ^ 11 := by
    simpa [R] using D.point_radical_pow_twelve_lt_height_pow_eleven
  have hreal : (R : ℝ) ^ 12 < ((D.Y ^ 2 : ℕ) : ℝ) ^ 11 := by
    exact_mod_cast hnat
  have hRpos : 0 < (R : ℝ) := by
    exact_mod_cast (abcRadical_pos _)
  have hlog := Real.log_lt_log (pow_pos hRpos 12) hreal
  rw [Real.log_pow, Real.log_pow] at hlog
  rw [ABCPoint.conductor, D.point.height_eq_log_c]
  simp only [point_c]
  change Real.log (R : ℝ) < _
  norm_num at hlog ⊢
  nlinarith

end Datum

/-- A height-unbounded family of exact Hall squarefull data disproves the
standard abc conjecture. -/
theorem not_abcConjecture_of_unbounded_Hall_squarefull_family
    (D : ℕ → Datum)
    (hunbounded : ∀ B : ℝ, ∃ n : ℕ, B < (D n).point.height) :
    ¬ ABCConjecture := by
  apply not_abcConjecture_of_subcritical_radical_slope
    (fun n => (D n).point.a) (fun n => (D n).point.b)
    (fun n => (D n).point.c) (11 / 12) 0 (1 / 12)
  · norm_num
  · norm_num
  · exact fun n => (D n).point.a_pos
  · exact fun n => (D n).point.b_pos
  · exact fun n => (D n).point.c_pos
  · exact fun n => (D n).point.sum_eq
  · exact fun n => (D n).point.pairwise_coprime
  · exact hunbounded
  · intro n
    have h := (D n).point_conductor_lt_eleven_twelfths_height
    simpa [familyABCRadicalLog, familyABCHeightLog,
      ABCPoint.conductor, ABCPoint.height] using h.le

#print axioms Datum.point
#print axioms Datum.point_radical_le
#print axioms Datum.point_radical_pow_twelve_lt_height_pow_eleven
#print axioms Datum.point_conductor_lt_eleven_twelfths_height
#print axioms not_abcConjecture_of_unbounded_Hall_squarefull_family

end

end HallSquarefullCounterexample20260831
end IUTThreeClosures
