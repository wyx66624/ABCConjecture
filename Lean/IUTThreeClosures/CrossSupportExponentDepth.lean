/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Tactic

/-!
# Cross-support exponent-depth budgets

For a positive exponent profile

`N = ∏ p in s, p ^ e(p)`,

the squarefree first layer is `∏ p in s, p` and the remaining powerful part is

`∏ p in s, p ^ (e(p)-1)`.

This file proves the exact multiplicative and logarithmic decompositions, a
threshold/tail decomposition, and the balanced two-vector scalar identity
which converts an abc height bound into a bound for the total excess exponent
mass on two neighboring endpoints, and conversely.

No abc estimate, linear-form bound, modularity theorem, or finiteness theorem
is assumed.
-/

namespace IUTThreeClosures
namespace CrossSupportExponentDepth

open scoped BigOperators

noncomputable section

variable {ι : Type*}

/-- Product of one copy of each base in a finite support. -/
def exponentFirstLayer (s : Finset ι) (base : ι → ℕ) : ℕ :=
  ∏ i ∈ s, base i

/-- Product carrying all exponent depth beyond the first layer. -/
def exponentExcessProduct
    (s : Finset ι) (base exponent : ι → ℕ) : ℕ :=
  ∏ i ∈ s, base i ^ (exponent i - 1)

/-- Weighted logarithmic depth beyond the first layer. -/
def exponentExcessWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, ((exponent i - 1 : ℕ) : ℝ) * weight i

/-- Weighted depth remaining above a chosen cutoff. -/
def exponentTailWeight
    (D : ℕ) (s : Finset ι) (weight : ι → ℝ)
    (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, ((exponent i - 1 - D : ℕ) : ℝ) * weight i

/-- A positive exponent profile is exactly its squarefree first layer times
its excess-depth product. -/
theorem exponentProfileProduct_eq_firstLayer_mul_excessProduct
    (s : Finset ι) (base exponent : ι → ℕ)
    (hpos : ∀ i ∈ s, 0 < exponent i) :
    exponentProfileProduct s base exponent =
      exponentFirstLayer s base * exponentExcessProduct s base exponent := by
  classical
  unfold exponentProfileProduct exponentFirstLayer exponentExcessProduct
  calc
    (∏ i ∈ s, base i ^ exponent i) =
        ∏ i ∈ s, base i * base i ^ (exponent i - 1) := by
      apply Finset.prod_congr rfl
      intro i hi
      have he : exponent i = (exponent i - 1) + 1 := by
        omega
      rw [he, pow_succ, mul_comm]
    _ = (∏ i ∈ s, base i) *
        ∏ i ∈ s, base i ^ (exponent i - 1) := by
      exact Finset.prod_mul_distrib

/-- Exact weighted accounting: total exponent mass equals one radical layer
plus the excess exponent mass. -/
theorem exponentTotalWeight_eq_radical_add_excessWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hpos : ∀ i ∈ s, 0 < exponent i) :
    exponentTotalWeight s weight exponent =
      exponentRadicalWeight s weight +
        exponentExcessWeight s weight exponent := by
  classical
  unfold exponentTotalWeight exponentRadicalWeight exponentExcessWeight
  calc
    (∑ i ∈ s, (exponent i : ℝ) * weight i) =
        ∑ i ∈ s,
          weight i + ((exponent i - 1 : ℕ) : ℝ) * weight i := by
      apply Finset.sum_congr rfl
      intro i hi
      have heNat : exponent i = 1 + (exponent i - 1) := by
        omega
      have he : (exponent i : ℝ) =
          1 + ((exponent i - 1 : ℕ) : ℝ) := by
        exact_mod_cast heNat
      rw [he]
      ring
    _ = (∑ i ∈ s, weight i) +
        ∑ i ∈ s, ((exponent i - 1 : ℕ) : ℝ) * weight i := by
      rw [Finset.sum_add_distrib]

/-- If every excess depth is at most `D`, then its weighted mass is at most
`D` radical layers. -/
theorem exponentExcessWeight_le_depth_mul_radicalWeight
    {D : ℕ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hdepth : ∀ i ∈ s, exponent i - 1 ≤ D) :
    exponentExcessWeight s weight exponent ≤
      (D : ℝ) * exponentRadicalWeight s weight := by
  classical
  unfold exponentExcessWeight exponentRadicalWeight
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i hi
  have hdepthReal : ((exponent i - 1 : ℕ) : ℝ) ≤ D := by
    exact_mod_cast hdepth i hi
  exact mul_le_mul_of_nonneg_right hdepthReal (hweight i hi)

/-- A weighted excess larger than `D` radical layers forces a coordinate of
excess depth strictly larger than `D`. -/
theorem exists_excessDepth_gt_of_excessWeight_gt
    {D : ℕ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hlarge :
      (D : ℝ) * exponentRadicalWeight s weight <
        exponentExcessWeight s weight exponent) :
    ∃ i ∈ s, D < exponent i - 1 := by
  classical
  by_contra hnone
  have hdepth : ∀ i ∈ s, exponent i - 1 ≤ D := by
    intro i hi
    exact Nat.le_of_not_gt fun hgt => hnone ⟨i, hi, hgt⟩
  have hbound := exponentExcessWeight_le_depth_mul_radicalWeight
    s weight exponent hweight hdepth
  linarith

/-- Exact elementary threshold inequality on one coordinate. -/
theorem excessDepth_le_cutoff_add_tail (e D : ℕ) :
    e - 1 ≤ D + (e - 1 - D) := by
  omega

/-- Every exponent profile splits into a low-depth budget and a tail above the
cutoff. -/
theorem exponentExcessWeight_le_depthBudget_add_tail
    (D : ℕ)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentExcessWeight s weight exponent ≤
      (D : ℝ) * exponentRadicalWeight s weight +
        exponentTailWeight D s weight exponent := by
  classical
  unfold exponentExcessWeight exponentRadicalWeight exponentTailWeight
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_le_sum
  intro i hi
  have hdepthReal : ((exponent i - 1 : ℕ) : ℝ) ≤
      (D : ℝ) + ((exponent i - 1 - D : ℕ) : ℝ) := by
    exact_mod_cast excessDepth_le_cutoff_add_tail (exponent i) D
  calc
    ((exponent i - 1 : ℕ) : ℝ) * weight i ≤
        ((D : ℝ) + ((exponent i - 1 - D : ℕ) : ℝ)) * weight i :=
      mul_le_mul_of_nonneg_right hdepthReal (hweight i hi)
    _ = (D : ℝ) * weight i +
        ((exponent i - 1 - D : ℕ) : ℝ) * weight i := by ring

/-- Two supported exponent vectors satisfy the sum of the two individual
depth bounds. -/
theorem twoSupport_excessWeight_le_depth_mul_radicalWeight
    {D : ℕ}
    (s₁ s₂ : Finset ι) (weight : ι → ℝ)
    (e₁ e₂ : ι → ℕ)
    (hweight₁ : ∀ i ∈ s₁, 0 ≤ weight i)
    (hweight₂ : ∀ i ∈ s₂, 0 ≤ weight i)
    (hdepth₁ : ∀ i ∈ s₁, e₁ i - 1 ≤ D)
    (hdepth₂ : ∀ i ∈ s₂, e₂ i - 1 ≤ D) :
    exponentExcessWeight s₁ weight e₁ +
        exponentExcessWeight s₂ weight e₂ ≤
      (D : ℝ) *
        (exponentRadicalWeight s₁ weight +
          exponentRadicalWeight s₂ weight) := by
  have h₁ := exponentExcessWeight_le_depth_mul_radicalWeight
    s₁ weight e₁ hweight₁ hdepth₁
  have h₂ := exponentExcessWeight_le_depth_mul_radicalWeight
    s₂ weight e₂ hweight₂ hdepth₂
  linarith

/-- If the total mass of two vectors exceeds `D` times their total radical
weight, one of the two supports contains a coordinate deeper than `D`. -/
theorem exists_twoSupport_excessDepth_gt
    {D : ℕ}
    (s₁ s₂ : Finset ι) (weight : ι → ℝ)
    (e₁ e₂ : ι → ℕ)
    (hweight₁ : ∀ i ∈ s₁, 0 ≤ weight i)
    (hweight₂ : ∀ i ∈ s₂, 0 ≤ weight i)
    (hlarge :
      (D : ℝ) *
          (exponentRadicalWeight s₁ weight +
            exponentRadicalWeight s₂ weight) <
        exponentExcessWeight s₁ weight e₁ +
          exponentExcessWeight s₂ weight e₂) :
    (∃ i ∈ s₁, D < e₁ i - 1) ∨
      ∃ i ∈ s₂, D < e₂ i - 1 := by
  classical
  by_contra hnone
  push_neg at hnone
  have hdepth₁ : ∀ i ∈ s₁, e₁ i - 1 ≤ D := by
    intro i hi
    exact Nat.le_of_not_gt (hnone.1 i hi)
  have hdepth₂ : ∀ i ∈ s₂, e₂ i - 1 ≤ D := by
    intro i hi
    exact Nat.le_of_not_gt (hnone.2 i hi)
  have hbound := twoSupport_excessWeight_le_depth_mul_radicalWeight
    s₁ s₂ weight e₁ e₂ hweight₁ hweight₂ hdepth₁ hdepth₂
  linarith

/-- Two-support threshold/tail decomposition. -/
theorem twoSupport_excessWeight_le_depthBudget_add_tails
    (D : ℕ)
    (s₁ s₂ : Finset ι) (weight : ι → ℝ)
    (e₁ e₂ : ι → ℕ)
    (hweight₁ : ∀ i ∈ s₁, 0 ≤ weight i)
    (hweight₂ : ∀ i ∈ s₂, 0 ≤ weight i) :
    exponentExcessWeight s₁ weight e₁ +
        exponentExcessWeight s₂ weight e₂ ≤
      (D : ℝ) *
          (exponentRadicalWeight s₁ weight +
            exponentRadicalWeight s₂ weight) +
        exponentTailWeight D s₁ weight e₁ +
        exponentTailWeight D s₂ weight e₂ := by
  have h₁ := exponentExcessWeight_le_depthBudget_add_tail
    D s₁ weight e₁ hweight₁
  have h₂ := exponentExcessWeight_le_depthBudget_add_tail
    D s₂ weight e₂ hweight₂
  linarith

/-! ## Balanced endpoint conversion -/

/-- An abc-type upper bound for the larger endpoint implies the precise total
excess-height budget for the two endpoint exponent vectors. -/
theorem abcHeightBound_implies_twoVectorExcessBound
    {ε K hM hc rA rB rC eR eS : ℝ}
    (hMdef : hM = rA + eR)
    (hcdef : hc = rB + eS)
    (hM_le_hc : hM ≤ hc)
    (habc : hc ≤ (1 + ε) * (rA + rB + rC) + K) :
    eR + eS ≤
      (1 + 2 * ε) * (rA + rB) +
        2 * (1 + ε) * rC + 2 * K := by
  nlinarith

/-- Conversely, a total excess-height budget for the two exponent vectors,
together with a bounded logarithmic gap between the neighboring endpoints,
implies the corresponding abc-type height bound. -/
theorem twoVectorExcessBound_implies_abcHeightBound
    {ε K L hM hc rA rB rC eR eS : ℝ}
    (hMdef : hM = rA + eR)
    (hcdef : hc = rB + eS)
    (hc_le_hM_add : hc ≤ hM + L)
    (hexcess :
      eR + eS ≤
        (1 + 2 * ε) * (rA + rB) +
          2 * (1 + ε) * rC + K) :
    hc ≤ (1 + ε) * (rA + rB + rC) + (K + L) / 2 := by
  nlinarith

/-- Failure of the total two-vector budget forces failure on at least one of
the two naturally allocated one-sided budgets. -/
theorem twoVectorExcessFailure_forces_oneSide
    {ε K rA rB rC eR eS : ℝ}
    (hfail :
      (1 + 2 * ε) * (rA + rB) +
          2 * (1 + ε) * rC + K < eR + eS) :
    (1 + 2 * ε) * rA + (1 + ε) * rC + K / 2 < eR ∨
      (1 + 2 * ε) * rB + (1 + ε) * rC + K / 2 < eS := by
  by_contra hnone
  push_neg at hnone
  nlinarith

#print axioms exponentProfileProduct_eq_firstLayer_mul_excessProduct
#print axioms exponentTotalWeight_eq_radical_add_excessWeight
#print axioms exponentExcessWeight_le_depth_mul_radicalWeight
#print axioms exists_excessDepth_gt_of_excessWeight_gt
#print axioms exponentExcessWeight_le_depthBudget_add_tail
#print axioms twoSupport_excessWeight_le_depth_mul_radicalWeight
#print axioms exists_twoSupport_excessDepth_gt
#print axioms twoSupport_excessWeight_le_depthBudget_add_tails
#print axioms abcHeightBound_implies_twoVectorExcessBound
#print axioms twoVectorExcessBound_implies_abcHeightBound
#print axioms twoVectorExcessFailure_forces_oneSide

end
end CrossSupportExponentDepth
end IUTThreeClosures
