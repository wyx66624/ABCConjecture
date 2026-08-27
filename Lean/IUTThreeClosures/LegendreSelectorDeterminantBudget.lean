/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LegendreSimultaneousSelector

/-!
# The determinant budget of the simultaneous Legendre selector

For the congruence lattice attached to a positive triple `a + b = c`, the
simultaneous selector `(b,-a)` has sup-size `max a b`, whereas the lattice has
determinant `a*b*c`.  The corresponding integral residual is therefore

`min a b * c`.

This module proves that the residual lies strictly above `a*b` and at most
`2*a*b`.  On the balanced primitive family `(n,n+1,2*n+1)`, it is at least one
third of the square of the height.  Consequently, the unmodified determinant
quotient does not itself discard prime-power multiplicities.  This is a no-go
result for one naive metric completion only; it is not a no-go theorem for a
parabolic or conductor-normalized successor.
-/

namespace IUTThreeClosures

/-- The integral determinant quotient after dividing the congruence-lattice
covolume `a*b*c` by the selector sup-size `max a b`.  The equality with that
quotient is expressed without natural-number division by
`max_mul_legendreResidualDeterminant`. -/
def legendreResidualDeterminant (a b c : ℕ) : ℕ :=
  min a b * c

/-- Exact determinant factorization:
`max(a,b) * (min(a,b) * c) = a*b*c`. -/
theorem max_mul_legendreResidualDeterminant
    (a b c : ℕ) :
    max a b * legendreResidualDeterminant a b c = a * b * c := by
  unfold legendreResidualDeterminant
  rcases le_total a b with hab | hba
  · rw [min_eq_left hab, max_eq_right hab]
    ac_rfl
  · rw [min_eq_right hba, max_eq_left hba]
    ac_rfl

/-- For a positive additive triple, the residual strictly exceeds `a*b`. -/
theorem mul_lt_legendreResidualDeterminant
    {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b)
    (hadd : a + b = c) :
    a * b < legendreResidualDeterminant a b c := by
  unfold legendreResidualDeterminant
  rcases le_total a b with hab | hba
  · rw [min_eq_left hab]
    have hbc : b < c := by omega
    exact mul_lt_mul_of_pos_left hbc ha
  · rw [min_eq_right hba]
    have hac : a < c := by omega
    calc
      a * b = b * a := by ac_rfl
      _ < b * c := mul_lt_mul_of_pos_left hac hb

/-- The same residual is at most `2*a*b`. -/
theorem legendreResidualDeterminant_le_two_mul
    {a b c : ℕ}
    (hadd : a + b = c) :
    legendreResidualDeterminant a b c ≤ 2 * (a * b) := by
  unfold legendreResidualDeterminant
  rw [← hadd]
  rcases le_total a b with hab | hba
  · rw [min_eq_left hab]
    have hmul : a * a ≤ a * b := mul_le_mul_left' hab a
    nlinarith
  · rw [min_eq_right hba]
    have hmul : b * b ≤ b * a := mul_le_mul_left' hba b
    nlinarith

/-- Exact elementary window for the determinant residual. -/
theorem legendreResidualDeterminant_window
    {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b)
    (hadd : a + b = c) :
    a * b < legendreResidualDeterminant a b c ∧
      legendreResidualDeterminant a b c ≤ 2 * (a * b) := by
  exact ⟨mul_lt_legendreResidualDeterminant ha hb hadd,
    legendreResidualDeterminant_le_two_mul hadd⟩

/-- The residual is never smaller than the height for positive legs. -/
theorem height_le_legendreResidualDeterminant
    {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b) :
    c ≤ legendreResidualDeterminant a b c := by
  unfold legendreResidualDeterminant
  have hmin : 1 ≤ min a b := by omega
  calc
    c = 1 * c := by simp
    _ ≤ min a b * c := mul_le_mul_right' hmin c

/-- Therefore any proposed upper bound for the residual already bounds the
height by the same quantity. -/
theorem height_le_of_legendreResidualDeterminant_le
    {a b c B : ℕ}
    (ha : 0 < a) (hb : 0 < b)
    (hB : legendreResidualDeterminant a b c ≤ B) :
    c ≤ B :=
  le_trans (height_le_legendreResidualDeterminant ha hb) hB

/-- Exact residual on the balanced family `(n,n+1,2*n+1)`. -/
theorem balanced_legendreResidualDeterminant
    (n : ℕ) :
    legendreResidualDeterminant n (n + 1) (2 * n + 1) =
      n * (2 * n + 1) := by
  simp [legendreResidualDeterminant]

/-- On the balanced family, the residual is at least one third of the square
of the height, expressed without division. -/
theorem balanced_height_sq_le_three_residual
    {n : ℕ}
    (hn : 1 ≤ n) :
    (2 * n + 1) * (2 * n + 1) ≤
      3 * legendreResidualDeterminant n (n + 1) (2 * n + 1) := by
  have hc : 2 * n + 1 ≤ 3 * n := by omega
  calc
    (2 * n + 1) * (2 * n + 1) ≤
        (3 * n) * (2 * n + 1) :=
      mul_le_mul_right' hc (2 * n + 1)
    _ = 3 * (n * (2 * n + 1)) := by ac_rfl
    _ = 3 * legendreResidualDeterminant n (n + 1) (2 * n + 1) := by
      rw [balanced_legendreResidualDeterminant]

end IUTThreeClosures
