/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Logarithmic cancellation of the tame different

For a finite extension of discretely valued fields, let `e_i`, `f_i`, and
`d_i` denote the ramification indices, residue degrees, and different
exponents above one base prime.  The degree identity is

`sum_i e_i f_i = n`.

The ordinary different contribution plus the reduced boundary contribution,
minus the pullback of the base boundary, is

`sum_i f_i (d_i + 1 - e_i)`.

Thus tame ramification, for which `d_i = e_i - 1`, cancels exactly.  Only the
wild excess remains.  This elementary weighted identity is the scalar core of
the logarithmic Riemann--Hurwitz formula used by the adaptive Kummer route.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u

/-- Ordinary different plus reduced boundary minus base boundary equals the
weighted logarithmic ramification defect. -/
theorem logRamificationCancellation
    {ι : Type u} [Fintype ι]
    (e f d : ι → ℝ) (n : ℝ)
    (hdegree : ∑ i, e i * f i = n) :
    (∑ i, f i * d i) + (∑ i, f i) - n =
      ∑ i, f i * (d i + 1 - e i) := by
  have hcomm :
      (∑ i, f i * e i) = ∑ i, e i * f i := by
    apply Finset.sum_congr rfl
    intro i _
    ring
  simp_rw [mul_sub, mul_add, mul_one]
  rw [Finset.sum_sub_distrib, Finset.sum_add_distrib, hcomm, hdegree]

/-- Tame ramification contributes no logarithmic defect. -/
theorem logRamificationCancellation_tame
    {ι : Type u} [Fintype ι]
    (e f d : ι → ℝ) (n : ℝ)
    (hdegree : ∑ i, e i * f i = n)
    (htame : ∀ i, d i = e i - 1) :
    (∑ i, f i * d i) + (∑ i, f i) - n = 0 := by
  rw [logRamificationCancellation e f d n hdegree]
  apply Finset.sum_eq_zero
  intro i _
  rw [htame]
  ring

/-- If every local wild defect is at most `e_i * s`, then the total
logarithmic defect is at most `s` times the extension degree. -/
theorem logRamificationCancellation_le_degree_mul
    {ι : Type u} [Fintype ι]
    (e f d : ι → ℝ) (n s : ℝ)
    (hdegree : ∑ i, e i * f i = n)
    (hf : ∀ i, 0 ≤ f i)
    (hwild : ∀ i, d i + 1 - e i ≤ e i * s) :
    (∑ i, f i * d i) + (∑ i, f i) - n ≤ s * n := by
  rw [logRamificationCancellation e f d n hdegree]
  calc
    (∑ i, f i * (d i + 1 - e i)) ≤
        ∑ i, f i * (e i * s) := by
      apply Finset.sum_le_sum
      intro i _
      exact mul_le_mul_of_nonneg_left (hwild i) (hf i)
    _ = s * n := by
      rw [← hdegree]
      calc
        (∑ i, f i * (e i * s)) =
            ∑ i, s * (e i * f i) := by
          apply Finset.sum_congr rfl
          intro i _
          ring
        _ = s * ∑ i, e i * f i := by
          rw [Finset.mul_sum]

/-- Normalized form: after division by the positive extension degree, the
logarithmic defect is bounded by the common local wild slope. -/
theorem normalizedLogRamificationDefect_le
    {ι : Type u} [Fintype ι]
    (e f d : ι → ℝ) (n s : ℝ)
    (hn : 0 < n)
    (hdegree : ∑ i, e i * f i = n)
    (hf : ∀ i, 0 ≤ f i)
    (hwild : ∀ i, d i + 1 - e i ≤ e i * s) :
    ((∑ i, f i * d i) + (∑ i, f i) - n) / n ≤ s := by
  apply (div_le_iff₀ hn).2
  simpa [mul_comm] using
    logRamificationCancellation_le_degree_mul
      e f d n s hdegree hf hwild

end IUTThreeClosures
