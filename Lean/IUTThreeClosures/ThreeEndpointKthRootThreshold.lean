/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Tactic

/-!
# Three-endpoint higher-power extraction under an abc-height violation

For a finite exponent profile and `k >= 2`, the canonical extracted `k`-th
root uses exponent `floor(e/k)` at every coordinate.  The residue budget gives

`total <= (k-1) * radical + k * kthRoot`.

If three pairwise-disjoint endpoint profiles have total radical weight at most
`R`, one of them has three times its radical weight at most `R`.  Combining
this pigeonhole fact with an abc-height violation and a common lower source
height gives an exact higher-power threshold.

At the non-short-gap source fraction

`(2+epsilon) / (2*(1+epsilon))`,

the remaining height coefficient for the `k`-th root is

`8 + 3*epsilon - 2*k`.

Consequently `k=4` has the strictly positive coefficient `3*epsilon` for every
positive epsilon.  Thus the three-square/non-short-gap branch of any
hypothetical abc counterexample forces a height-scale canonical fourth root on
at least one endpoint.  This file proves only the deterministic finite-profile
and real-algebra statements; it does not assume a global Diophantine estimate.
-/

namespace IUTThreeClosures
namespace ThreeEndpointKthRootThreshold

open scoped BigOperators

noncomputable section

variable {ι : Type*}

/-- Logarithmic weight of the canonical extracted `k`-th root. -/
def kthRootWeight
    (k : ℕ) (s : Finset ι) (weight : ι → ℝ)
    (exponent : ι → ℕ) : ℝ :=
  exponentQuotientWeight k s weight exponent

/-- General coefficient/root ledger for a finite exponent profile. -/
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

/-- Among three real radical weights with sum at most `R`, one is at most
one third of `R`. -/
theorem one_of_three_triple_le
    {r₁ r₂ r₃ R : ℝ}
    (hsum : r₁ + r₂ + r₃ ≤ R) :
    3 * r₁ ≤ R ∨ 3 * r₂ ≤ R ∨ 3 * r₃ ≤ R := by
  by_cases h₁ : 3 * r₁ ≤ R
  · exact Or.inl h₁
  · by_cases h₂ : 3 * r₂ ≤ R
    · exact Or.inr (Or.inl h₂)
    · right
      right
      have h₁' : R < 3 * r₁ := lt_of_not_ge h₁
      have h₂' : R < 3 * r₂ := lt_of_not_ge h₂
      nlinarith

/-- One-endpoint product-form transfer.  The scaled source-height hypothesis
is exactly the denominator-free form of

`((2+epsilon)/(2*(1+epsilon))) * h - L <= T`.

The conclusion exhibits the exact gain coefficient
`3*(2+epsilon)-2*(k-1) = 8+3*epsilon-2*k`. -/
theorem endpoint_kthRootScale_product
    {k : ℕ} (hk : 2 ≤ k)
    {epsilon C h R r T q L : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradical : 3 * r ≤ R)
    (htotal :
      (2 + epsilon) * h - 2 * (1 + epsilon) * L ≤
        2 * (1 + epsilon) * T)
    (hroot :
      T ≤ ((k - 1 : ℕ) : ℝ) * r + (k : ℝ) * q) :
    (3 * (2 + epsilon) - 2 * ((k - 1 : ℕ) : ℝ)) * h +
        2 * ((k - 1 : ℕ) : ℝ) * C <
      6 * (k : ℝ) * (1 + epsilon) * q +
        6 * (1 + epsilon) * L := by
  have hone : 0 < 1 + epsilon := by linarith
  have hkminusNat : 0 < k - 1 := by omega
  have hkminus : 0 < (((k - 1 : ℕ) : ℝ)) := by
    exact_mod_cast hkminusNat
  have htotal3 :=
    mul_le_mul_of_nonneg_left htotal (by norm_num : (0 : ℝ) ≤ 3)
  have hroot6 :=
    mul_le_mul_of_nonneg_left hroot
      (show 0 ≤ 6 * (1 + epsilon) by positivity)
  have hradicalScaled :=
    mul_le_mul_of_nonneg_left hradical
      (show 0 ≤ 2 * ((k - 1 : ℕ) : ℝ) * (1 + epsilon) by positivity)
  have hviolationScaled :=
    mul_lt_mul_of_pos_left hviolation
      (show 0 < 2 * ((k - 1 : ℕ) : ℝ) by positivity)
  nlinarith

/-- Three finite endpoint profiles: one canonical `k`-th root crosses the
exact source-height threshold.  All root weights in the conclusion are
computed from the supplied exponent profiles; no target estimate is stored as
data. -/
theorem one_endpoint_has_kthRootScale
    {k : ℕ} (hk : 2 ≤ k)
    (s₁ s₂ s₃ : Finset ι)
    (weight : ι → ℝ)
    (e₁ e₂ e₃ : ι → ℕ)
    (hw₁ : ∀ i ∈ s₁, 0 ≤ weight i)
    (hw₂ : ∀ i ∈ s₂, 0 ≤ weight i)
    (hw₃ : ∀ i ∈ s₃, 0 ≤ weight i)
    {epsilon C h R L₁ L₂ L₃ : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradicalSum :
      exponentRadicalWeight s₁ weight +
          exponentRadicalWeight s₂ weight +
          exponentRadicalWeight s₃ weight ≤ R)
    (htotal₁ :
      (2 + epsilon) * h - 2 * (1 + epsilon) * L₁ ≤
        2 * (1 + epsilon) * exponentTotalWeight s₁ weight e₁)
    (htotal₂ :
      (2 + epsilon) * h - 2 * (1 + epsilon) * L₂ ≤
        2 * (1 + epsilon) * exponentTotalWeight s₂ weight e₂)
    (htotal₃ :
      (2 + epsilon) * h - 2 * (1 + epsilon) * L₃ ≤
        2 * (1 + epsilon) * exponentTotalWeight s₃ weight e₃) :
    let gain :=
      (3 * (2 + epsilon) - 2 * ((k - 1 : ℕ) : ℝ)) * h +
        2 * ((k - 1 : ℕ) : ℝ) * C
    gain <
        6 * (k : ℝ) * (1 + epsilon) *
            kthRootWeight k s₁ weight e₁ +
          6 * (1 + epsilon) * L₁ ∨
      gain <
        6 * (k : ℝ) * (1 + epsilon) *
            kthRootWeight k s₂ weight e₂ +
          6 * (1 + epsilon) * L₂ ∨
      gain <
        6 * (k : ℝ) * (1 + epsilon) *
            kthRootWeight k s₃ weight e₃ +
          6 * (1 + epsilon) * L₃ := by
  dsimp
  have hkpos : 0 < k := by omega
  have hroot₁ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      hkpos s₁ weight e₁ hw₁
  have hroot₂ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      hkpos s₂ weight e₂ hw₂
  have hroot₃ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      hkpos s₃ weight e₃ hw₃
  rcases one_of_three_triple_le hradicalSum with hsmall₁ | hsmall₂ | hsmall₃
  · left
    exact endpoint_kthRootScale_product hk hepsilon hviolation
      hsmall₁ htotal₁ hroot₁
  · right
    left
    exact endpoint_kthRootScale_product hk hepsilon hviolation
      hsmall₂ htotal₂ hroot₂
  · right
    right
    exact endpoint_kthRootScale_product hk hepsilon hviolation
      hsmall₃ htotal₃ hroot₃

/-- Quartic specialization.  The general gain coefficient becomes
`3*epsilon`; after division by three, one endpoint has a canonical fourth-root
weight satisfying the displayed height-scale lower bound. -/
theorem one_endpoint_has_fourthRootScale
    (s₁ s₂ s₃ : Finset ι)
    (weight : ι → ℝ)
    (e₁ e₂ e₃ : ι → ℕ)
    (hw₁ : ∀ i ∈ s₁, 0 ≤ weight i)
    (hw₂ : ∀ i ∈ s₂, 0 ≤ weight i)
    (hw₃ : ∀ i ∈ s₃, 0 ≤ weight i)
    {epsilon C h R L₁ L₂ L₃ : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradicalSum :
      exponentRadicalWeight s₁ weight +
          exponentRadicalWeight s₂ weight +
          exponentRadicalWeight s₃ weight ≤ R)
    (htotal₁ :
      (2 + epsilon) * h - 2 * (1 + epsilon) * L₁ ≤
        2 * (1 + epsilon) * exponentTotalWeight s₁ weight e₁)
    (htotal₂ :
      (2 + epsilon) * h - 2 * (1 + epsilon) * L₂ ≤
        2 * (1 + epsilon) * exponentTotalWeight s₂ weight e₂)
    (htotal₃ :
      (2 + epsilon) * h - 2 * (1 + epsilon) * L₃ ≤
        2 * (1 + epsilon) * exponentTotalWeight s₃ weight e₃) :
    epsilon * h + 2 * C <
        8 * (1 + epsilon) * kthRootWeight 4 s₁ weight e₁ +
          2 * (1 + epsilon) * L₁ ∨
      epsilon * h + 2 * C <
        8 * (1 + epsilon) * kthRootWeight 4 s₂ weight e₂ +
          2 * (1 + epsilon) * L₂ ∨
      epsilon * h + 2 * C <
        8 * (1 + epsilon) * kthRootWeight 4 s₃ weight e₃ +
          2 * (1 + epsilon) * L₃ := by
  have h := one_endpoint_has_kthRootScale
    (k := 4) (by norm_num) s₁ s₂ s₃ weight e₁ e₂ e₃
    hw₁ hw₂ hw₃ hepsilon hviolation hradicalSum
    htotal₁ htotal₂ htotal₃
  norm_num at h
  rcases h with h₁ | h₂ | h₃
  · left
    nlinarith
  · right
    left
    nlinarith
  · right
    right
    nlinarith

/-- The quartic threshold is the largest integer exponent whose gain remains
strictly positive for every positive epsilon.  At exponent five the gain is
`3*epsilon-2`, so small epsilon gives no positive uniform height coefficient. -/
theorem quartic_gain_pos_and_quintic_gain_nonpos_for_small_epsilon
    {epsilon : ℝ}
    (hepsilon : 0 < epsilon)
    (hepsilonSmall : epsilon ≤ 2 / 3) :
    0 < 8 + 3 * epsilon - 2 * (4 : ℝ) ∧
      8 + 3 * epsilon - 2 * (5 : ℝ) ≤ 0 := by
  constructor <;> norm_num <;> linarith

#print axioms totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
#print axioms one_of_three_triple_le
#print axioms endpoint_kthRootScale_product
#print axioms one_endpoint_has_kthRootScale
#print axioms one_endpoint_has_fourthRootScale
#print axioms quartic_gain_pos_and_quintic_gain_nonpos_for_small_epsilon

end
end ThreeEndpointKthRootThreshold
end IUTThreeClosures
