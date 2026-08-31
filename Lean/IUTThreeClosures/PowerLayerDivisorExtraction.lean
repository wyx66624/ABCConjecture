/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ExponentLayerCakeSelector
import Mathlib.Tactic

/-!
# Exact power divisor extracted from an exponent layer

For a finite base/exponent profile, the product of all bases whose exponent is
at least `j`, raised to the `j`-th power, divides the represented integer.  An
explicit complementary quotient is constructed, so the result needs no
unique-factorization or primality hypothesis on the bases.
-/

namespace IUTThreeClosures
namespace PowerLayerDivisorExtraction

open scoped BigOperators

noncomputable section

variable {ι : Type*}

/-- Product of the bases lying in the exponent-at-least-`j` layer. -/
def exponentAtLeastLayerProduct
    (j : ℕ) (s : Finset ι) (base exponent : ι → ℕ) : ℕ :=
  ∏ i in s, if j ≤ exponent i then base i else 1

/-- Explicit quotient left after extracting the `j`-th power of the layer
product. -/
def exponentLayerQuotient
    (j : ℕ) (s : Finset ι) (base exponent : ι → ℕ) : ℕ :=
  ∏ i in s,
    if j ≤ exponent i then base i ^ (exponent i - j)
    else base i ^ exponent i

/-- Exact factorization of the finite exponent profile by its `j`-layer. -/
theorem layerProduct_pow_mul_quotient_eq_profile
    (j : ℕ) (s : Finset ι) (base exponent : ι → ℕ) :
    exponentAtLeastLayerProduct j s base exponent ^ j *
        exponentLayerQuotient j s base exponent =
      exponentProfileProduct s base exponent := by
  classical
  unfold exponentAtLeastLayerProduct exponentLayerQuotient
    exponentProfileProduct
  rw [Finset.prod_pow, ← Finset.prod_mul_distrib]
  apply Finset.prod_congr rfl
  intro i hi
  by_cases hj : j ≤ exponent i
  · simp only [if_pos hj]
    rw [← pow_add, Nat.add_sub_of_le hj]
  · simp [hj]

/-- The selected layer product gives an actual `j`-th-power divisor. -/
theorem layerProduct_pow_dvd_profile
    (j : ℕ) (s : Finset ι) (base exponent : ι → ℕ) :
    exponentAtLeastLayerProduct j s base exponent ^ j ∣
      exponentProfileProduct s base exponent := by
  refine ⟨exponentLayerQuotient j s base exponent, ?_⟩
  exact (layerProduct_pow_mul_quotient_eq_profile
    j s base exponent).symm

/-- Numerical size inequality for the extracted power divisor. -/
theorem layerProduct_pow_le_profile
    (j : ℕ) (s : Finset ι) (base exponent : ι → ℕ)
    (hprofile : 0 < exponentProfileProduct s base exponent) :
    exponentAtLeastLayerProduct j s base exponent ^ j ≤
      exponentProfileProduct s base exponent :=
  Nat.le_of_dvd hprofile
    (layerProduct_pow_dvd_profile j s base exponent)

/-- The layer product itself is nonzero when all bases on the finite support
are nonzero. -/
theorem layerProduct_ne_zero
    (j : ℕ) (s : Finset ι) (base exponent : ι → ℕ)
    (hbase : ∀ i ∈ s, base i ≠ 0) :
    exponentAtLeastLayerProduct j s base exponent ≠ 0 := by
  classical
  unfold exponentAtLeastLayerProduct
  apply Finset.prod_ne_zero_iff.mpr
  intro i hi
  by_cases hj : j ≤ exponent i
  · simpa [hj] using hbase i hi
  · simp [hj]

#print axioms layerProduct_pow_mul_quotient_eq_profile
#print axioms layerProduct_pow_dvd_profile
#print axioms layerProduct_pow_le_profile
#print axioms layerProduct_ne_zero

end
end PowerLayerDivisorExtraction
end IUTThreeClosures
