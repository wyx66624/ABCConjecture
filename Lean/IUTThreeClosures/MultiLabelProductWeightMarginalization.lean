/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ProductWeightMarginalization

/-!
# Additive marginalization for several procession labels

For normalized product weights on components `c : L → V`, the existing
one-label marginal theorem reduces a function of `c j₀` to the corresponding
weighted local sum. This file proves the simultaneous additive version:

`Σ_c (Π_j w(c j)) (Σ_j f_j(c j)) = Σ_j Σ_v w(v) f_j(v)`.

Thus, if more than one capsule label carries a local q-pilot exponent, the
packet logarithm is the sum of the label contributions. The theorem is a
finite product-measure identity; it introduces no arithmetic source,
possible-image, height estimate, or abc assumption.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v

variable {L : Type u} {V : Type v}

/-- Additive observables on all coordinates marginalize one coordinate at a
time under normalized product weights. -/
theorem product_weight_additive_marginal
    [Fintype L] [DecidableEq L]
    [Fintype V] [DecidableEq V]
    [Fintype (L → V)]
    (w : V → ℝ) (f : L → V → ℝ)
    (hw : ∑ v, w v = 1) :
    (∑ c : L → V,
        (∏ j, w (c j)) * (∑ j, f j (c j))) =
      ∑ j : L, ∑ v : V, w v * f j v := by
  calc
    (∑ c : L → V,
        (∏ j, w (c j)) * (∑ j, f j (c j))) =
      ∑ c : L → V, ∑ j : L,
        (∏ k, w (c k)) * f j (c j) := by
          apply Finset.sum_congr rfl
          intro c hc
          rw [Finset.mul_sum]
    _ = ∑ j : L, ∑ c : L → V,
        (∏ k, w (c k)) * f j (c j) := by
          rw [Finset.sum_comm]
    _ = ∑ j : L, ∑ v : V, w v * f j v := by
          apply Finset.sum_congr rfl
          intro j hj
          exact product_weight_marginal j w (f j) hw

/-- If every label has a scalar coefficient `a j` multiplying one common local
observable `g`, then the packet coefficient is the sum of the label
coefficients. -/
theorem product_weight_separable_additive_marginal
    [Fintype L] [DecidableEq L]
    [Fintype V] [DecidableEq V]
    [Fintype (L → V)]
    (w : V → ℝ) (a : L → ℝ) (g : V → ℝ)
    (hw : ∑ v, w v = 1) :
    (∑ c : L → V,
        (∏ j, w (c j)) *
          (∑ j, a j * g (c j))) =
      (∑ j, a j) * (∑ v, w v * g v) := by
  calc
    (∑ c : L → V,
        (∏ j, w (c j)) *
          (∑ j, a j * g (c j))) =
      ∑ j : L, ∑ v : V, w v * (a j * g v) :=
        product_weight_additive_marginal
          w (fun j v => a j * g v) hw
    _ = ∑ j : L, a j * (∑ v : V, w v * g v) := by
          apply Finset.sum_congr rfl
          intro j hj
          rw [Finset.mul_sum]
          apply Finset.sum_congr rfl
          intro x hx
          ring
    _ = (∑ j, a j) * (∑ v, w v * g v) := by
          rw [Finset.sum_mul]

end IUTThreeClosures
