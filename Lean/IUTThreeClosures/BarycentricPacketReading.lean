import IUTThreeClosures.ProductWeightMarginalization
import Mathlib.Algebra.BigOperators.Ring.Finset

/-!
# Barycentric q-pilot readings on tensor packets

The native q-action need not be assigned to a single label.  Any linear
allocation across the labels whose coefficients sum to one has the same
packet-normalized reading, because product packet weights have the original
place distribution as every coordinate marginal.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v

variable {L : Type u} {V : Type v}

/-- Expectation of a labelwise linear combination under a product weight. -/
theorem product_weight_barycentric
    [Fintype L] [DecidableEq L] [Fintype V] [DecidableEq V]
    (coeff : L → ℝ) (weight value : V → ℝ)
    (hweight : ∑ v, weight v = 1) :
    (∑ c : L → V,
        (∏ j, weight (c j)) *
          (∑ j, coeff j * value (c j))) =
      (∑ j, coeff j) * (∑ v, weight v * value v) := by
  calc
    (∑ c : L → V,
        (∏ j, weight (c j)) *
          (∑ j, coeff j * value (c j))) =
      ∑ c : L → V, ∑ j : L,
        (∏ k, weight (c k)) * (coeff j * value (c j)) := by
          apply Finset.sum_congr rfl
          intro c hc
          rw [Finset.mul_sum]
    _ = ∑ j : L, ∑ c : L → V,
        (∏ k, weight (c k)) * (coeff j * value (c j)) := by
          rw [Finset.sum_comm]
    _ = ∑ j, coeff j *
        (∑ c : L → V, (∏ k, weight (c k)) * value (c j)) := by
          apply Finset.sum_congr rfl
          intro j hj
          rw [Finset.mul_sum]
          apply Finset.sum_congr rfl
          intro c hc
          ring
    _ = ∑ j, coeff j * (∑ v, weight v * value v) := by
          apply Finset.sum_congr rfl
          intro j hj
          rw [product_weight_marginal j weight value hweight]
    _ = (∑ j, coeff j) * (∑ v, weight v * value v) := by
          rw [Finset.sum_mul]

/-- A barycentric allocation (coefficients summing to one) has exactly the
ordinary weighted local reading. -/
theorem product_weight_barycentric_of_sum_one
    [Fintype L] [DecidableEq L] [Fintype V] [DecidableEq V]
    (coeff : L → ℝ) (weight value : V → ℝ)
    (hcoeff : ∑ j, coeff j = 1)
    (hweight : ∑ v, weight v = 1) :
    (∑ c : L → V,
        (∏ j, weight (c j)) *
          (∑ j, coeff j * value (c j))) =
      ∑ v, weight v * value v := by
  rw [product_weight_barycentric coeff weight value hweight, hcoeff, one_mul]

end IUTThreeClosures