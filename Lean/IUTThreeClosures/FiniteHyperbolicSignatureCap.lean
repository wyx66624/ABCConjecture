/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AdaptiveHyperbolicSignature
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Tactic

/-!
# Capping adaptive exponents to a finite hyperbolic signature list

The adaptive exponents can vary with the abc point.  For fixed
`epsilon > 0`, this file caps them by the explicit integer

`floor (6*(4+epsilon)/epsilon) + 1`.

Capping an exponent can only improve the canonical root margin, because the
residue budget uses fewer radical layers.  The reciprocal sum increases by at
most three times the reciprocal of the cap.  The chosen cap is large enough
that the strict hyperbolic inequality survives.

Thus, for fixed epsilon, the adaptive reduction can be placed in a finite list
of hyperbolic signatures.  The coefficients still move, so this does not by
itself prove abc.
-/

namespace IUTThreeClosures
namespace FiniteHyperbolicSignatureCap

open ThreeEndpointKthRootThreshold
open AdaptiveHyperbolicSignature

noncomputable section

variable {ι : Type*}

/-- Explicit finite exponent cap for fixed positive epsilon. -/
def signatureCap (epsilon : ℝ) : ℕ :=
  ⌊(6 * (4 + epsilon) / epsilon)⌋₊ + 1

/-- Cap an adaptive exponent without letting it fall below either input. -/
def cappedExponent (epsilon : ℝ) (k : ℕ) : ℕ :=
  min k (signatureCap epsilon)

/-- The defining real cap ratio lies strictly below the integer cap. -/
theorem cap_ratio_lt
    (epsilon : ℝ) :
    6 * (4 + epsilon) / epsilon < (signatureCap epsilon : ℝ) := by
  simpa [signatureCap, Nat.cast_add, Nat.cast_one] using
    (Nat.lt_floor_add_one (6 * (4 + epsilon) / epsilon))

/-- The explicit cap is at least two. -/
theorem two_le_signatureCap
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    2 ≤ signatureCap epsilon := by
  have hratio : 1 ≤ 6 * (4 + epsilon) / epsilon := by
    apply (le_div_iff₀ hepsilon).2
    nlinarith
  have hfloor : 1 ≤ ⌊(6 * (4 + epsilon) / epsilon)⌋₊ :=
    (Nat.one_le_floor_iff (6 * (4 + epsilon) / epsilon)).2 hratio
  unfold signatureCap
  omega

/-- The reciprocal price of capping three exponents is less than half of the
available adaptive hyperbolic slack. -/
theorem three_div_signatureCap_lt_half_slack
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    (3 : ℝ) / (signatureCap epsilon : ℝ) <
      epsilon / (2 * (4 + epsilon)) := by
  have hcap : 0 < (signatureCap epsilon : ℝ) := by
    exact_mod_cast (lt_of_lt_of_le (by norm_num : 0 < 2)
      (two_le_signatureCap hepsilon))
  have hden : 0 < 2 * (4 + epsilon) := by positivity
  have hratio := cap_ratio_lt epsilon
  have hcross :
      6 * (4 + epsilon) < (signatureCap epsilon : ℝ) * epsilon :=
    (div_lt_iff₀ hepsilon).1 hratio
  apply (div_lt_div_iff₀ hcap hden).2
  nlinarith

@[simp]
theorem cappedExponent_le_left
    (epsilon : ℝ) (k : ℕ) :
    cappedExponent epsilon k ≤ k := by
  unfold cappedExponent
  exact min_le_left _ _

@[simp]
theorem cappedExponent_le_cap
    (epsilon : ℝ) (k : ℕ) :
    cappedExponent epsilon k ≤ signatureCap epsilon := by
  unfold cappedExponent
  exact min_le_right _ _

/-- If both the adaptive exponent and the cap are at least two, so is their
minimum. -/
theorem two_le_cappedExponent
    {epsilon : ℝ} {k : ℕ}
    (hk : 2 ≤ k) (hcap : 2 ≤ signatureCap epsilon) :
    2 ≤ cappedExponent epsilon k := by
  unfold cappedExponent
  exact le_min hk hcap

/-- Reciprocal cost of replacing `k` by `min(k,K)`. -/
theorem reciprocal_cappedExponent_le_add
    {epsilon : ℝ} {k : ℕ}
    (hk : 0 < k)
    (hcap : 0 < signatureCap epsilon) :
    (1 : ℝ) / (cappedExponent epsilon k : ℝ) ≤
      (1 : ℝ) / (k : ℝ) +
        (1 : ℝ) / (signatureCap epsilon : ℝ) := by
  by_cases hle : k ≤ signatureCap epsilon
  · rw [show cappedExponent epsilon k = k by
      simp [cappedExponent, hle]]
    have hnonneg : 0 ≤ (1 : ℝ) / (signatureCap epsilon : ℝ) := by
      positivity
    linarith
  · have hge : signatureCap epsilon ≤ k := le_of_not_ge hle
    rw [show cappedExponent epsilon k = signatureCap epsilon by
      simp [cappedExponent, hge]]
    have hnonneg : 0 ≤ (1 : ℝ) / (k : ℝ) := by positivity
    linarith

/-- A three-term adaptive reciprocal bound with the exact abc slack remains
hyperbolic after capping. -/
theorem capped_reciprocal_sum_lt_one
    {epsilon : ℝ} (hepsilon : 0 < epsilon)
    {k₁ k₂ k₃ : ℕ}
    (hk₁ : 0 < k₁) (hk₂ : 0 < k₂) (hk₃ : 0 < k₃)
    (hadaptive :
      (1 : ℝ) / (k₁ : ℝ) +
          (1 : ℝ) / (k₂ : ℝ) +
          (1 : ℝ) / (k₃ : ℝ) <
        4 / (4 + epsilon)) :
    (1 : ℝ) / (cappedExponent epsilon k₁ : ℝ) +
        (1 : ℝ) / (cappedExponent epsilon k₂ : ℝ) +
        (1 : ℝ) / (cappedExponent epsilon k₃ : ℝ) < 1 := by
  have hcapNat : 0 < signatureCap epsilon :=
    lt_of_lt_of_le (by norm_num : 0 < 2) (two_le_signatureCap hepsilon)
  have h₁ := reciprocal_cappedExponent_le_add hk₁ hcapNat
  have h₂ := reciprocal_cappedExponent_le_add hk₂ hcapNat
  have h₃ := reciprocal_cappedExponent_le_add hk₃ hcapNat
  have hcost := three_div_signatureCap_lt_half_slack hepsilon
  have hsum :
      (1 : ℝ) / (cappedExponent epsilon k₁ : ℝ) +
          (1 : ℝ) / (cappedExponent epsilon k₂ : ℝ) +
          (1 : ℝ) / (cappedExponent epsilon k₃ : ℝ) <
        4 / (4 + epsilon) + epsilon / (2 * (4 + epsilon)) := by
    nlinarith
  have hden : 0 < 2 * (4 + epsilon) := by positivity
  have hfinal :
      4 / (4 + epsilon) + epsilon / (2 * (4 + epsilon)) < 1 := by
    field_simp [show 4 + epsilon ≠ 0 by linarith]
    nlinarith
  linarith

/-- Lowering an adaptive exponent to the finite cap preserves the fixed root
margin. -/
theorem capped_root_margin
    {epsilon delta T r q : ℝ}
    (hdeltaNonneg : 0 ≤ delta)
    (hdelta : delta < 1)
    (hT : 0 < T)
    (hr : 0 < r)
    (hledger :
      T ≤
        (((cappedExponent epsilon (adaptiveExponent delta T r) - 1 : ℕ) : ℝ)) * r +
          (cappedExponent epsilon (adaptiveExponent delta T r) : ℝ) * q) :
    delta * T ≤
      (cappedExponent epsilon (adaptiveExponent delta T r) : ℝ) * q := by
  have hle :
      cappedExponent epsilon (adaptiveExponent delta T r) ≤
        adaptiveExponent delta T r :=
    cappedExponent_le_left epsilon (adaptiveExponent delta T r)
  have hsubNat :
      cappedExponent epsilon (adaptiveExponent delta T r) - 1 ≤
        adaptiveExponent delta T r - 1 :=
    Nat.sub_le_sub_right hle 1
  have hsub :
      (((cappedExponent epsilon (adaptiveExponent delta T r) - 1 : ℕ) : ℝ)) ≤
        (((adaptiveExponent delta T r - 1 : ℕ) : ℝ)) := by
    exact_mod_cast hsubNat
  have hmul := mul_le_mul_of_nonneg_right hsub hr.le
  have hadaptive :=
    adaptiveExponent_sub_one_mul_radical_le hdelta.le hT.le hr
  have hconsume :
      (((cappedExponent epsilon (adaptiveExponent delta T r) - 1 : ℕ) : ℝ)) * r ≤
        (1 - delta) * T :=
    hmul.trans hadaptive
  nlinarith

/-- Finite-list cap for three deterministic adaptive profile exponents.  The
input reciprocal bound is the exact `4/(4+epsilon)` consequence of the abc
source/radical ledger. -/
theorem capped_profile_signature
    (s₁ s₂ s₃ : Finset ι)
    (weight : ι → ℝ)
    (e₁ e₂ e₃ : ι → ℕ)
    (hw₁ : ∀ i ∈ s₁, 0 ≤ weight i)
    (hw₂ : ∀ i ∈ s₂, 0 ≤ weight i)
    (hw₃ : ∀ i ∈ s₃, 0 ≤ weight i)
    {epsilon delta : ℝ}
    (hepsilon : 0 < epsilon)
    (hdeltaNonneg : 0 ≤ delta)
    (hdelta : delta < 1)
    (hT₁ : 0 < exponentTotalWeight s₁ weight e₁)
    (hT₂ : 0 < exponentTotalWeight s₂ weight e₂)
    (hT₃ : 0 < exponentTotalWeight s₃ weight e₃)
    (hr₁ : 0 < exponentRadicalWeight s₁ weight)
    (hr₂ : 0 < exponentRadicalWeight s₂ weight)
    (hr₃ : 0 < exponentRadicalWeight s₃ weight)
    (hratio₁ :
      1 ≤ (1 - delta) * exponentTotalWeight s₁ weight e₁ /
        exponentRadicalWeight s₁ weight)
    (hratio₂ :
      1 ≤ (1 - delta) * exponentTotalWeight s₂ weight e₂ /
        exponentRadicalWeight s₂ weight)
    (hratio₃ :
      1 ≤ (1 - delta) * exponentTotalWeight s₃ weight e₃ /
        exponentRadicalWeight s₃ weight)
    (hadaptiveReciprocal :
      (1 : ℝ) /
          (adaptiveExponent delta
            (exponentTotalWeight s₁ weight e₁)
            (exponentRadicalWeight s₁ weight) : ℝ) +
        (1 : ℝ) /
          (adaptiveExponent delta
            (exponentTotalWeight s₂ weight e₂)
            (exponentRadicalWeight s₂ weight) : ℝ) +
        (1 : ℝ) /
          (adaptiveExponent delta
            (exponentTotalWeight s₃ weight e₃)
            (exponentRadicalWeight s₃ weight) : ℝ) <
        4 / (4 + epsilon)) :
    let a₁ := adaptiveExponent delta
      (exponentTotalWeight s₁ weight e₁)
      (exponentRadicalWeight s₁ weight)
    let a₂ := adaptiveExponent delta
      (exponentTotalWeight s₂ weight e₂)
      (exponentRadicalWeight s₂ weight)
    let a₃ := adaptiveExponent delta
      (exponentTotalWeight s₃ weight e₃)
      (exponentRadicalWeight s₃ weight)
    let k₁ := cappedExponent epsilon a₁
    let k₂ := cappedExponent epsilon a₂
    let k₃ := cappedExponent epsilon a₃
    2 ≤ k₁ ∧ 2 ≤ k₂ ∧ 2 ≤ k₃ ∧
      k₁ ≤ signatureCap epsilon ∧
      k₂ ≤ signatureCap epsilon ∧
      k₃ ≤ signatureCap epsilon ∧
      (1 : ℝ) / (k₁ : ℝ) + (1 : ℝ) / (k₂ : ℝ) +
          (1 : ℝ) / (k₃ : ℝ) < 1 ∧
      delta * exponentTotalWeight s₁ weight e₁ ≤
        (k₁ : ℝ) * kthRootWeight k₁ s₁ weight e₁ ∧
      delta * exponentTotalWeight s₂ weight e₂ ≤
        (k₂ : ℝ) * kthRootWeight k₂ s₂ weight e₂ ∧
      delta * exponentTotalWeight s₃ weight e₃ ≤
        (k₃ : ℝ) * kthRootWeight k₃ s₃ weight e₃ := by
  dsimp
  have ha₁ : 2 ≤ adaptiveExponent delta
      (exponentTotalWeight s₁ weight e₁)
      (exponentRadicalWeight s₁ weight) :=
    two_le_adaptiveExponent hratio₁
  have ha₂ : 2 ≤ adaptiveExponent delta
      (exponentTotalWeight s₂ weight e₂)
      (exponentRadicalWeight s₂ weight) :=
    two_le_adaptiveExponent hratio₂
  have ha₃ : 2 ≤ adaptiveExponent delta
      (exponentTotalWeight s₃ weight e₃)
      (exponentRadicalWeight s₃ weight) :=
    two_le_adaptiveExponent hratio₃
  have hcap₂ := two_le_signatureCap hepsilon
  have hk₁ := two_le_cappedExponent ha₁ hcap₂
  have hk₂ := two_le_cappedExponent ha₂ hcap₂
  have hk₃ := two_le_cappedExponent ha₃ hcap₂
  have hrec := capped_reciprocal_sum_lt_one hepsilon
    (adaptiveExponent_pos delta
      (exponentTotalWeight s₁ weight e₁)
      (exponentRadicalWeight s₁ weight))
    (adaptiveExponent_pos delta
      (exponentTotalWeight s₂ weight e₂)
      (exponentRadicalWeight s₂ weight))
    (adaptiveExponent_pos delta
      (exponentTotalWeight s₃ weight e₃)
      (exponentRadicalWeight s₃ weight))
    hadaptiveReciprocal
  have hledger₁ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      (lt_of_lt_of_le (by norm_num : 0 < 2) hk₁)
      s₁ weight e₁ hw₁
  have hledger₂ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      (lt_of_lt_of_le (by norm_num : 0 < 2) hk₂)
      s₂ weight e₂ hw₂
  have hledger₃ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      (lt_of_lt_of_le (by norm_num : 0 < 2) hk₃)
      s₃ weight e₃ hw₃
  have hmargin₁ := capped_root_margin
    (epsilon := epsilon) hdeltaNonneg hdelta hT₁ hr₁ hledger₁
  have hmargin₂ := capped_root_margin
    (epsilon := epsilon) hdeltaNonneg hdelta hT₂ hr₂ hledger₂
  have hmargin₃ := capped_root_margin
    (epsilon := epsilon) hdeltaNonneg hdelta hT₃ hr₃ hledger₃
  exact ⟨hk₁, hk₂, hk₃,
    cappedExponent_le_cap epsilon _,
    cappedExponent_le_cap epsilon _,
    cappedExponent_le_cap epsilon _,
    hrec, hmargin₁, hmargin₂, hmargin₃⟩

#print axioms cap_ratio_lt
#print axioms two_le_signatureCap
#print axioms three_div_signatureCap_lt_half_slack
#print axioms reciprocal_cappedExponent_le_add
#print axioms capped_reciprocal_sum_lt_one
#print axioms capped_root_margin
#print axioms capped_profile_signature

end
end FiniteHyperbolicSignatureCap
end IUTThreeClosures
