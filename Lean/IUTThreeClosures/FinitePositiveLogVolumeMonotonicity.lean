import Mathlib

/-!
# Monotonicity of finite positive logarithmic measure
-/

namespace IUTThreeClosures

open MeasureTheory
open scoped BigOperators

theorem log_measure_toReal_mono
    {α : Type*} [MeasurableSpace α]
    (μ : Measure α) {A B : Set α}
    (hAB : A ⊆ B) (hA_ne_zero : μ A ≠ 0) (hB_ne_top : μ B ≠ ∞) :
    Real.log (μ A).toReal ≤ Real.log (μ B).toReal := by
  have hμ : μ A ≤ μ B := measure_mono hAB
  have hA_ne_top : μ A ≠ ∞ := ne_top_of_le_ne_top hB_ne_top hμ
  have hB_ne_zero : μ B ≠ 0 := by
    intro hB
    apply hA_ne_zero
    apply le_antisymm
    · simpa [hB] using hμ
    · exact bot_le
  have hApos : 0 < (μ A).toReal :=
    ENNReal.toReal_pos hA_ne_zero hA_ne_top
  have hBpos : 0 < (μ B).toReal :=
    ENNReal.toReal_pos hB_ne_zero hB_ne_top
  have hreal : (μ A).toReal ≤ (μ B).toReal :=
    ENNReal.toReal_mono hB_ne_top hμ
  exact Real.strictMonoOn_log.monotoneOn hApos hBpos hreal

theorem weighted_sum_mono
    {ι : Type*} [Fintype ι]
    (weight a b : ι → ℝ)
    (hweight : ∀ i, 0 ≤ weight i)
    (hab : ∀ i, a i ≤ b i) :
    (∑ i, weight i * a i) ≤ ∑ i, weight i * b i := by
  apply Finset.sum_le_sum
  intro i hi
  exact mul_le_mul_of_nonneg_left (hab i) (hweight i)

theorem finite_average_mono
    {ι : Type*} [Fintype ι]
    (a b : ι → ℝ) (hab : ∀ i, a i ≤ b i) :
    (∑ i, a i) / Fintype.card ι ≤
      (∑ i, b i) / Fintype.card ι := by
  by_cases hcard : Fintype.card ι = 0
  · simp [hcard]
  · have hpos : (0 : ℝ) < Fintype.card ι := by
      exact_mod_cast Nat.pos_of_ne_zero hcard
    apply (div_le_div_iff_of_pos_right hpos).2
    exact Finset.sum_le_sum fun i hi => hab i

end IUTThreeClosures
