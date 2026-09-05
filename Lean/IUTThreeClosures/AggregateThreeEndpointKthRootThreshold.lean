/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ThreeEndpointKthRootThreshold
import Mathlib.Tactic

/-!
# Aggregate improvement of the three-endpoint higher-power threshold

The pointwise radical-pigeonhole theorem gives the gain

`8 + 3*epsilon - 2*k`.

A stronger argument sums the three canonical root ledgers before selecting the
largest root.  In the non-short-gap branch the three endpoint heights have
aggregate source coefficient

`(6 + 5*epsilon) / (2*(1+epsilon))`.

Using the full radical sum only once improves the gain to

`8 + 5*epsilon - 2*k`.

At `k=4`, every hypothetical abc violation in the non-short-gap branch thus
forces one endpoint to have a canonical fourth-root weight with coefficient
`5*epsilon`, rather than `3*epsilon`.  The result remains deterministic and
contains no global Diophantine estimate.
-/

namespace IUTThreeClosures
namespace AggregateThreeEndpointKthRootThreshold

open scoped BigOperators
open ThreeEndpointKthRootThreshold

noncomputable section

variable {ι : Type*}

/-- One of three real numbers is at least one third of their sum. -/
theorem sum_le_triple_one
    {q₁ q₂ q₃ : ℝ} :
    q₁ + q₂ + q₃ ≤ 3 * q₁ ∨
      q₁ + q₂ + q₃ ≤ 3 * q₂ ∨
      q₁ + q₂ + q₃ ≤ 3 * q₃ := by
  by_cases h₁ : q₁ + q₂ + q₃ ≤ 3 * q₁
  · exact Or.inl h₁
  · by_cases h₂ : q₁ + q₂ + q₃ ≤ 3 * q₂
    · exact Or.inr (Or.inl h₂)
    · right
      right
      have h₁' : 3 * q₁ < q₁ + q₂ + q₃ := lt_of_not_ge h₁
      have h₂' : 3 * q₂ < q₁ + q₂ + q₃ := lt_of_not_ge h₂
      nlinarith

/-- Aggregate three-profile selector.  The source-height hypothesis is the
scaled form of

`T₁+T₂+T₃ >= ((6+5*epsilon)/(2*(1+epsilon)))h - L`.

The exact gain is

`6+5*epsilon-2*(k-1) = 8+5*epsilon-2*k`. -/
theorem one_endpoint_has_kthRootScale_from_aggregate
    {k : ℕ} (hk : 2 ≤ k)
    (s₁ s₂ s₃ : Finset ι)
    (weight : ι → ℝ)
    (e₁ e₂ e₃ : ι → ℕ)
    (hw₁ : ∀ i ∈ s₁, 0 ≤ weight i)
    (hw₂ : ∀ i ∈ s₂, 0 ≤ weight i)
    (hw₃ : ∀ i ∈ s₃, 0 ≤ weight i)
    {epsilon C h R L : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradicalSum :
      exponentRadicalWeight s₁ weight +
          exponentRadicalWeight s₂ weight +
          exponentRadicalWeight s₃ weight ≤ R)
    (htotalAggregate :
      (6 + 5 * epsilon) * h - 2 * (1 + epsilon) * L ≤
        2 * (1 + epsilon) *
          (exponentTotalWeight s₁ weight e₁ +
            exponentTotalWeight s₂ weight e₂ +
            exponentTotalWeight s₃ weight e₃)) :
    let gain :=
      (6 + 5 * epsilon - 2 * ((k - 1 : ℕ) : ℝ)) * h +
        2 * ((k - 1 : ℕ) : ℝ) * C
    gain <
        6 * (k : ℝ) * (1 + epsilon) *
            kthRootWeight k s₁ weight e₁ +
          2 * (1 + epsilon) * L ∨
      gain <
        6 * (k : ℝ) * (1 + epsilon) *
            kthRootWeight k s₂ weight e₂ +
          2 * (1 + epsilon) * L ∨
      gain <
        6 * (k : ℝ) * (1 + epsilon) *
            kthRootWeight k s₃ weight e₃ +
          2 * (1 + epsilon) * L := by
  dsimp
  have hone : 0 < 1 + epsilon := by linarith
  have hkpos : 0 < k := by omega
  have hkminusNat : 0 < k - 1 := by omega
  have hkminus : 0 < (((k - 1 : ℕ) : ℝ)) := by
    exact_mod_cast hkminusNat
  have hroot₁ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      hkpos s₁ weight e₁ hw₁
  have hroot₂ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      hkpos s₂ weight e₂ hw₂
  have hroot₃ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      hkpos s₃ weight e₃ hw₃
  have hrootSum :
      exponentTotalWeight s₁ weight e₁ +
          exponentTotalWeight s₂ weight e₂ +
          exponentTotalWeight s₃ weight e₃ ≤
        ((k - 1 : ℕ) : ℝ) *
            (exponentRadicalWeight s₁ weight +
              exponentRadicalWeight s₂ weight +
              exponentRadicalWeight s₃ weight) +
          (k : ℝ) *
            (kthRootWeight k s₁ weight e₁ +
              kthRootWeight k s₂ weight e₂ +
              kthRootWeight k s₃ weight e₃) := by
    nlinarith
  have hrootScaled :=
    mul_le_mul_of_nonneg_left hrootSum
      (show 0 ≤ 2 * (1 + epsilon) by positivity)
  have hradicalScaled :=
    mul_le_mul_of_nonneg_left hradicalSum
      (show 0 ≤ 2 * ((k - 1 : ℕ) : ℝ) * (1 + epsilon) by positivity)
  have hviolationScaled :=
    mul_lt_mul_of_pos_left hviolation
      (show 0 < 2 * ((k - 1 : ℕ) : ℝ) by positivity)
  have haggregate :
      (6 + 5 * epsilon - 2 * ((k - 1 : ℕ) : ℝ)) * h +
          2 * ((k - 1 : ℕ) : ℝ) * C <
        2 * (k : ℝ) * (1 + epsilon) *
            (kthRootWeight k s₁ weight e₁ +
              kthRootWeight k s₂ weight e₂ +
              kthRootWeight k s₃ weight e₃) +
          2 * (1 + epsilon) * L := by
    nlinarith
  rcases sum_le_triple_one
      (q₁ := kthRootWeight k s₁ weight e₁)
      (q₂ := kthRootWeight k s₂ weight e₂)
      (q₃ := kthRootWeight k s₃ weight e₃) with hmax₁ | hmax₂ | hmax₃
  · left
    have hscaled :=
      mul_le_mul_of_nonneg_left hmax₁
        (show 0 ≤ 2 * (k : ℝ) * (1 + epsilon) by positivity)
    nlinarith
  · right
    left
    have hscaled :=
      mul_le_mul_of_nonneg_left hmax₂
        (show 0 ≤ 2 * (k : ℝ) * (1 + epsilon) by positivity)
    nlinarith
  · right
    right
    have hscaled :=
      mul_le_mul_of_nonneg_left hmax₃
        (show 0 ≤ 2 * (k : ℝ) * (1 + epsilon) by positivity)
    nlinarith

/-- Improved quartic specialization.  One endpoint carries five epsilon units
of source-height gain before the fixed normalization by `24*(1+epsilon)`. -/
theorem one_endpoint_has_fourthRootScale_from_aggregate
    (s₁ s₂ s₃ : Finset ι)
    (weight : ι → ℝ)
    (e₁ e₂ e₃ : ι → ℕ)
    (hw₁ : ∀ i ∈ s₁, 0 ≤ weight i)
    (hw₂ : ∀ i ∈ s₂, 0 ≤ weight i)
    (hw₃ : ∀ i ∈ s₃, 0 ≤ weight i)
    {epsilon C h R L : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradicalSum :
      exponentRadicalWeight s₁ weight +
          exponentRadicalWeight s₂ weight +
          exponentRadicalWeight s₃ weight ≤ R)
    (htotalAggregate :
      (6 + 5 * epsilon) * h - 2 * (1 + epsilon) * L ≤
        2 * (1 + epsilon) *
          (exponentTotalWeight s₁ weight e₁ +
            exponentTotalWeight s₂ weight e₂ +
            exponentTotalWeight s₃ weight e₃)) :
    5 * epsilon * h + 6 * C <
        24 * (1 + epsilon) * kthRootWeight 4 s₁ weight e₁ +
          2 * (1 + epsilon) * L ∨
      5 * epsilon * h + 6 * C <
        24 * (1 + epsilon) * kthRootWeight 4 s₂ weight e₂ +
          2 * (1 + epsilon) * L ∨
      5 * epsilon * h + 6 * C <
        24 * (1 + epsilon) * kthRootWeight 4 s₃ weight e₃ +
          2 * (1 + epsilon) * L := by
  have h := one_endpoint_has_kthRootScale_from_aggregate
    (k := 4) (by norm_num) s₁ s₂ s₃ weight e₁ e₂ e₃
    hw₁ hw₂ hw₃ hepsilon hviolation hradicalSum htotalAggregate
  norm_num at h
  simpa [mul_assoc, mul_left_comm, mul_comm] using h

/-- The aggregate argument still has quartic, but not quintic, uniform gain
for all sufficiently small positive epsilon. -/
theorem aggregate_quartic_gain_pos_and_quintic_gain_nonpos
    {epsilon : ℝ}
    (hepsilon : 0 < epsilon)
    (hepsilonSmall : epsilon ≤ 2 / 5) :
    0 < 8 + 5 * epsilon - 2 * (4 : ℝ) ∧
      8 + 5 * epsilon - 2 * (5 : ℝ) ≤ 0 := by
  constructor <;> norm_num <;> linarith

#print axioms sum_le_triple_one
#print axioms one_endpoint_has_kthRootScale_from_aggregate
#print axioms one_endpoint_has_fourthRootScale_from_aggregate
#print axioms aggregate_quartic_gain_pos_and_quintic_gain_nonpos

end
end AggregateThreeEndpointKthRootThreshold
end IUTThreeClosures
