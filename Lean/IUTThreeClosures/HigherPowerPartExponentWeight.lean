/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Tactic

/-!
# Higher-power roots capture exponent mass above the radical layers

For a finite exponent profile and an integer `k>0`, the canonical extracted
`k`-th-power root has exponent `floor(e/k)` at each coordinate.  The exact
residue decomposition and the residue budget imply

`total weight <= (k-1) * radical weight + k * kth-root weight`.

At `k=3`, all exponent mass above two radical layers is therefore captured by
at most three times the canonical cube-root weight.  This is the deterministic
step converting positive cubeful excess into a large cube divisor.

No abc estimate, modularity theorem, or gap theorem is assumed.
-/

namespace IUTThreeClosures
namespace HigherPowerPartExponentWeight

open scoped BigOperators

noncomputable section

variable {ι : Type*}

/-- Logarithmic weight of the canonical extracted `k`-th root. -/
def kthRootWeight
    (k : ℕ) (s : Finset ι) (weight : ι → ℝ)
    (exponent : ι → ℕ) : ℝ :=
  exponentQuotientWeight k s weight exponent

/-- General higher-power extraction inequality. -/
theorem totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
    {k : ℕ} (hk : 0 < k)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentTotalWeight s weight exponent ≤
      ((k - 1 : ℕ) : ℝ) * exponentRadicalWeight s weight +
        (k : ℝ) * kthRootWeight k s weight exponent := by
  have hdecomp :=
    exponentTotalWeight_eq_residue_add_n_mul_quotient
      k s weight exponent
  have hres :=
    exponentResidueWeight_le_radical_budget
      hk s weight exponent hweight
  unfold kthRootWeight
  rw [hdecomp]
  linarith

/-- Exponent mass above `k-1` radical layers is bounded by the extracted
`k`-th-root weight. -/
theorem excessAboveRadicalLayers_le_k_mul_kthRootWeight
    {k : ℕ} (hk : 0 < k)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentTotalWeight s weight exponent -
        ((k - 1 : ℕ) : ℝ) * exponentRadicalWeight s weight ≤
      (k : ℝ) * kthRootWeight k s weight exponent := by
  have h :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      hk s weight exponent hweight
  linarith

/-- Cube specialization: cubeful exponent mass is bounded by three times the
canonical cube-root weight. -/
theorem cubefulExcessWeight_le_three_mul_cubeRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentTotalWeight s weight exponent -
        2 * exponentRadicalWeight s weight ≤
      3 * kthRootWeight 3 s weight exponent := by
  have h :=
    excessAboveRadicalLayers_le_k_mul_kthRootWeight
      (k := 3) (by norm_num) s weight exponent hweight
  norm_num at h ⊢
  exact h

/-- Positive cubeful excess forces one third as much cube-root weight. -/
theorem one_third_cubefulExcess_le_cubeRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    (exponentTotalWeight s weight exponent -
        2 * exponentRadicalWeight s weight) / 3 ≤
      kthRootWeight 3 s weight exponent := by
  have h :=
    cubefulExcessWeight_le_three_mul_cubeRootWeight
      s weight exponent hweight
  linarith

/-- A positive height slope in cubeful excess forces one third of that slope
in the extracted cube root. -/
theorem cubeRootWeight_large_of_cubefulExcess_large
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {delta H K : ℝ}
    (hexcess :
      delta * H + K <
        exponentTotalWeight s weight exponent -
          2 * exponentRadicalWeight s weight) :
    (delta * H + K) / 3 <
      kthRootWeight 3 s weight exponent := by
  have hthird :=
    one_third_cubefulExcess_le_cubeRootWeight
      s weight exponent hweight
  nlinarith

#print axioms totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
#print axioms excessAboveRadicalLayers_le_k_mul_kthRootWeight
#print axioms cubefulExcessWeight_le_three_mul_cubeRootWeight
#print axioms one_third_cubefulExcess_le_cubeRootWeight
#print axioms cubeRootWeight_large_of_cubefulExcess_large

end
end HigherPowerPartExponentWeight
end IUTThreeClosures
