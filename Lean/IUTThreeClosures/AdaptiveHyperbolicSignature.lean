/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AggregateThreeEndpointKthRootThreshold
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Tactic

/-!
# Adaptive hyperbolic generalized-Fermat signatures

The fixed fourth-root theorem is not the strongest consequence of the
non-short-gap abc ledger.  For each endpoint separately, choose an exponent
from its height-to-radical ratio.

For margin `delta`, total weight `T`, and radical weight `r>0`, define

`k = floor ((1-delta)T/r) + 1`.

Then

* `k-1 <= (1-delta)T/r`, so the canonical `k`-th root carries at least
  `delta*T` after multiplication by `k`;
* `(1-delta)T/r < k`, so `1/k < r/((1-delta)T)`.

For the three endpoints in the non-short-gap branch, take

`alpha = (2+epsilon)/(2(1+epsilon))`,
`delta = epsilon/(2(2+epsilon))`.

The abc radical budget implies

`sum r_i / ((1-delta)T_i) < 1`.

Consequently the three adaptive integer exponents are all at least two, their
reciprocals have sum strictly below one, and every corresponding canonical
power root has positive source-height scale.  Thus every hypothetical
counterexample in this branch produces a genuine hyperbolic moving-coefficient
generalized-Fermat signature, rather than merely the spherical fixed signature
`(4,3,2)`.

No uniform generalized-Fermat finiteness or abc estimate is assumed.
-/

namespace IUTThreeClosures
namespace AdaptiveHyperbolicSignature

open scoped BigOperators
open ThreeEndpointKthRootThreshold

noncomputable section

variable {ι : Type*}

/-- Common endpoint source fraction in the non-short-gap branch. -/
def sourceFraction (epsilon : ℝ) : ℝ :=
  (2 + epsilon) / (2 * (1 + epsilon))

/-- A fixed fraction of endpoint height retained in every adaptive power
root. -/
def marginFraction (epsilon : ℝ) : ℝ :=
  epsilon / (2 * (2 + epsilon))

/-- Adaptive integer exponent attached to a positive total/radical pair. -/
def adaptiveExponent (delta T r : ℝ) : ℕ :=
  ⌊((1 - delta) * T / r)⌋₊ + 1

/-- The source fraction is positive. -/
theorem sourceFraction_pos
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    0 < sourceFraction epsilon := by
  unfold sourceFraction
  positivity

/-- The margin fraction lies strictly between zero and one. -/
theorem marginFraction_pos
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    0 < marginFraction epsilon := by
  unfold marginFraction
  positivity

theorem marginFraction_lt_one
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    marginFraction epsilon < 1 := by
  unfold marginFraction
  have hden : 0 < 2 * (2 + epsilon) := by positivity
  apply (div_lt_iff₀ hden).2
  nlinarith

/-- Exact product of the retained margin and the endpoint source fraction. -/
theorem one_sub_margin_mul_source
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    (1 - marginFraction epsilon) * sourceFraction epsilon =
      (4 + epsilon) / (4 * (1 + epsilon)) := by
  unfold marginFraction sourceFraction
  have h₁ : 1 + epsilon ≠ 0 := by linarith
  have h₂ : 2 + epsilon ≠ 0 := by linarith
  field_simp [h₁, h₂]
  ring

@[simp]
theorem adaptiveExponent_pos
    (delta T r : ℝ) :
    0 < adaptiveExponent delta T r := by
  unfold adaptiveExponent
  omega

/-- The defining real ratio is strictly below the adaptive exponent. -/
theorem ratio_lt_adaptiveExponent
    (delta T r : ℝ) :
    (1 - delta) * T / r < (adaptiveExponent delta T r : ℝ) := by
  simpa [adaptiveExponent, Nat.cast_add, Nat.cast_one] using
    (Nat.lt_floor_add_one ((1 - delta) * T / r))

/-- If the defining ratio is at least one, the adaptive exponent is at least
two. -/
theorem two_le_adaptiveExponent
    {delta T r : ℝ}
    (hratio : 1 ≤ (1 - delta) * T / r) :
    2 ≤ adaptiveExponent delta T r := by
  have hfloor : 1 ≤ ⌊((1 - delta) * T / r)⌋₊ :=
    (Nat.one_le_floor_iff ((1 - delta) * T / r)).2 hratio
  unfold adaptiveExponent
  omega

/-- The exponent-minus-one part consumes at most the non-margin share of the
source height. -/
theorem adaptiveExponent_sub_one_mul_radical_le
    {delta T r : ℝ}
    (hdelta : delta ≤ 1)
    (hT : 0 ≤ T)
    (hr : 0 < r) :
    (((adaptiveExponent delta T r - 1 : ℕ) : ℝ)) * r ≤
      (1 - delta) * T := by
  have hratioNonneg : 0 ≤ (1 - delta) * T / r := by
    positivity
  have hfloor :
      ((⌊((1 - delta) * T / r)⌋₊ : ℕ) : ℝ) ≤
        (1 - delta) * T / r :=
    Nat.floor_le hratioNonneg
  have hmul := mul_le_mul_of_nonneg_right hfloor hr.le
  have hsub :
      adaptiveExponent delta T r - 1 =
        ⌊((1 - delta) * T / r)⌋₊ := by
    unfold adaptiveExponent
    omega
  rw [hsub]
  calc
    ((⌊((1 - delta) * T / r)⌋₊ : ℕ) : ℝ) * r ≤
        ((1 - delta) * T / r) * r := hmul
    _ = (1 - delta) * T := by field_simp [hr.ne']

/-- Reciprocal control supplied by the strict upper rounding. -/
theorem adaptiveExponent_reciprocal_lt
    {delta T r : ℝ}
    (hdelta : delta < 1)
    (hT : 0 < T)
    (hr : 0 < r) :
    (1 : ℝ) / (adaptiveExponent delta T r : ℝ) <
      r / ((1 - delta) * T) := by
  have hk : 0 < (adaptiveExponent delta T r : ℝ) := by
    exact_mod_cast adaptiveExponent_pos delta T r
  have hden : 0 < (1 - delta) * T := by positivity
  have hratio := ratio_lt_adaptiveExponent delta T r
  have hcross :
      (1 - delta) * T < (adaptiveExponent delta T r : ℝ) * r :=
    (div_lt_iff₀ hr).1 hratio
  apply (div_lt_div_iff₀ hk hden).2
  simpa [mul_comm] using hcross

/-- The canonical root at the adaptive exponent retains the prescribed margin
of source height. -/
theorem adaptive_root_margin
    {delta T r q : ℝ}
    (hdeltaNonneg : 0 ≤ delta)
    (hdelta : delta < 1)
    (hT : 0 < T)
    (hr : 0 < r)
    (hledger :
      T ≤ (((adaptiveExponent delta T r - 1 : ℕ) : ℝ)) * r +
        (adaptiveExponent delta T r : ℝ) * q) :
    delta * T ≤ (adaptiveExponent delta T r : ℝ) * q := by
  have hconsume :=
    adaptiveExponent_sub_one_mul_radical_le hdelta.le hT.le hr
  nlinarith

/-- Generic three-coordinate adaptive hyperbolicity criterion. -/
theorem adaptive_exponents_are_hyperbolic
    {delta T₁ T₂ T₃ r₁ r₂ r₃ : ℝ}
    (hdelta : delta < 1)
    (hT₁ : 0 < T₁) (hT₂ : 0 < T₂) (hT₃ : 0 < T₃)
    (hr₁ : 0 < r₁) (hr₂ : 0 < r₂) (hr₃ : 0 < r₃)
    (hratio₁ : 1 ≤ (1 - delta) * T₁ / r₁)
    (hratio₂ : 1 ≤ (1 - delta) * T₂ / r₂)
    (hratio₃ : 1 ≤ (1 - delta) * T₃ / r₃)
    (hscaled :
      r₁ / ((1 - delta) * T₁) +
          r₂ / ((1 - delta) * T₂) +
          r₃ / ((1 - delta) * T₃) < 1) :
    2 ≤ adaptiveExponent delta T₁ r₁ ∧
      2 ≤ adaptiveExponent delta T₂ r₂ ∧
      2 ≤ adaptiveExponent delta T₃ r₃ ∧
      (1 : ℝ) / (adaptiveExponent delta T₁ r₁ : ℝ) +
          (1 : ℝ) / (adaptiveExponent delta T₂ r₂ : ℝ) +
          (1 : ℝ) / (adaptiveExponent delta T₃ r₃ : ℝ) < 1 := by
  have hk₁ := two_le_adaptiveExponent hratio₁
  have hk₂ := two_le_adaptiveExponent hratio₂
  have hk₃ := two_le_adaptiveExponent hratio₃
  have hrec₁ := adaptiveExponent_reciprocal_lt hdelta hT₁ hr₁
  have hrec₂ := adaptiveExponent_reciprocal_lt hdelta hT₂ hr₂
  have hrec₃ := adaptiveExponent_reciprocal_lt hdelta hT₃ hr₃
  refine ⟨hk₁, hk₂, hk₃, ?_⟩
  linarith

/-- The abc source/radical inequalities imply the scaled reciprocal budget
needed by the adaptive selector. -/
theorem abc_scaled_radical_sum_lt_one
    {epsilon h R T₁ T₂ T₃ r₁ r₂ r₃ : ℝ}
    (hepsilon : 0 < epsilon)
    (hh : 0 < h)
    (hviolation : (1 + epsilon) * R < h)
    (hr₁ : 0 ≤ r₁) (hr₂ : 0 ≤ r₂) (hr₃ : 0 ≤ r₃)
    (hradicalSum : r₁ + r₂ + r₃ ≤ R)
    (hT₁ : sourceFraction epsilon * h ≤ T₁)
    (hT₂ : sourceFraction epsilon * h ≤ T₂)
    (hT₃ : sourceFraction epsilon * h ≤ T₃) :
    r₁ / ((1 - marginFraction epsilon) * T₁) +
        r₂ / ((1 - marginFraction epsilon) * T₂) +
        r₃ / ((1 - marginFraction epsilon) * T₃) < 1 := by
  have hone : 0 < 1 + epsilon := by linarith
  have hsource : 0 < sourceFraction epsilon :=
    sourceFraction_pos hepsilon
  have hmargin : marginFraction epsilon < 1 :=
    marginFraction_lt_one hepsilon
  have hcommon :
      0 < (1 - marginFraction epsilon) *
        (sourceFraction epsilon * h) := by positivity
  have hT₁pos : 0 < T₁ :=
    lt_of_lt_of_le (mul_pos hsource hh) hT₁
  have hT₂pos : 0 < T₂ :=
    lt_of_lt_of_le (mul_pos hsource hh) hT₂
  have hT₃pos : 0 < T₃ :=
    lt_of_lt_of_le (mul_pos hsource hh) hT₃
  have hden₁ :
      (1 - marginFraction epsilon) *
          (sourceFraction epsilon * h) ≤
        (1 - marginFraction epsilon) * T₁ :=
    mul_le_mul_of_nonneg_left hT₁ (sub_nonneg.mpr hmargin.le)
  have hden₂ :
      (1 - marginFraction epsilon) *
          (sourceFraction epsilon * h) ≤
        (1 - marginFraction epsilon) * T₂ :=
    mul_le_mul_of_nonneg_left hT₂ (sub_nonneg.mpr hmargin.le)
  have hden₃ :
      (1 - marginFraction epsilon) *
          (sourceFraction epsilon * h) ≤
        (1 - marginFraction epsilon) * T₃ :=
    mul_le_mul_of_nonneg_left hT₃ (sub_nonneg.mpr hmargin.le)
  have hdiv₁ :
      r₁ / ((1 - marginFraction epsilon) * T₁) ≤
        r₁ / ((1 - marginFraction epsilon) *
          (sourceFraction epsilon * h)) := by
    exact div_le_div_of_nonneg_left hr₁ hcommon hden₁
  have hdiv₂ :
      r₂ / ((1 - marginFraction epsilon) * T₂) ≤
        r₂ / ((1 - marginFraction epsilon) *
          (sourceFraction epsilon * h)) := by
    exact div_le_div_of_nonneg_left hr₂ hcommon hden₂
  have hdiv₃ :
      r₃ / ((1 - marginFraction epsilon) * T₃) ≤
        r₃ / ((1 - marginFraction epsilon) *
          (sourceFraction epsilon * h)) := by
    exact div_le_div_of_nonneg_left hr₃ hcommon hden₃
  have hR : R < h / (1 + epsilon) :=
    (lt_div_iff₀ hone).2 (by simpa [mul_comm] using hviolation)
  have hidentity := one_sub_margin_mul_source hepsilon
  have hcommonFormula :
      (1 - marginFraction epsilon) *
          (sourceFraction epsilon * h) =
        ((4 + epsilon) / (4 * (1 + epsilon))) * h := by
    rw [← mul_assoc, hidentity]
  have hdiff :
      ((4 + epsilon) / (4 * (1 + epsilon))) * h -
          h / (1 + epsilon) =
        epsilon * h / (4 * (1 + epsilon)) := by
    field_simp [hone.ne']
    ring
  have hdiffpos :
      0 < epsilon * h / (4 * (1 + epsilon)) := by positivity
  have hRcommon :
      R < (1 - marginFraction epsilon) *
        (sourceFraction epsilon * h) := by
    rw [hcommonFormula]
    linarith
  have hsumCommon :
      r₁ / ((1 - marginFraction epsilon) *
            (sourceFraction epsilon * h)) +
          r₂ / ((1 - marginFraction epsilon) *
            (sourceFraction epsilon * h)) +
          r₃ / ((1 - marginFraction epsilon) *
            (sourceFraction epsilon * h)) ≤
        R / ((1 - marginFraction epsilon) *
          (sourceFraction epsilon * h)) := by
    apply (div_le_div_iff₀ hcommon hcommon).2
    nlinarith
  have hRdiv :
      R / ((1 - marginFraction epsilon) *
        (sourceFraction epsilon * h)) < 1 :=
    (div_lt_one hcommon).2 hRcommon
  linarith

/-- Complete finite-profile adaptive signature theorem.  The three exponents
are computed from the actual total and radical weights, have hyperbolic
reciprocal sum, and every canonical root retains the fixed margin fraction of
its endpoint total weight. -/
theorem adaptive_profile_signature
    (s₁ s₂ s₃ : Finset ι)
    (weight : ι → ℝ)
    (e₁ e₂ e₃ : ι → ℕ)
    (hw₁ : ∀ i ∈ s₁, 0 ≤ weight i)
    (hw₂ : ∀ i ∈ s₂, 0 ≤ weight i)
    (hw₃ : ∀ i ∈ s₃, 0 ≤ weight i)
    {delta : ℝ}
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
    (hscaled :
      exponentRadicalWeight s₁ weight /
          ((1 - delta) * exponentTotalWeight s₁ weight e₁) +
        exponentRadicalWeight s₂ weight /
          ((1 - delta) * exponentTotalWeight s₂ weight e₂) +
        exponentRadicalWeight s₃ weight /
          ((1 - delta) * exponentTotalWeight s₃ weight e₃) < 1) :
    let k₁ := adaptiveExponent delta
      (exponentTotalWeight s₁ weight e₁)
      (exponentRadicalWeight s₁ weight)
    let k₂ := adaptiveExponent delta
      (exponentTotalWeight s₂ weight e₂)
      (exponentRadicalWeight s₂ weight)
    let k₃ := adaptiveExponent delta
      (exponentTotalWeight s₃ weight e₃)
      (exponentRadicalWeight s₃ weight)
    2 ≤ k₁ ∧ 2 ≤ k₂ ∧ 2 ≤ k₃ ∧
      (1 : ℝ) / (k₁ : ℝ) + (1 : ℝ) / (k₂ : ℝ) +
          (1 : ℝ) / (k₃ : ℝ) < 1 ∧
      delta * exponentTotalWeight s₁ weight e₁ ≤
        (k₁ : ℝ) * kthRootWeight k₁ s₁ weight e₁ ∧
      delta * exponentTotalWeight s₂ weight e₂ ≤
        (k₂ : ℝ) * kthRootWeight k₂ s₂ weight e₂ ∧
      delta * exponentTotalWeight s₃ weight e₃ ≤
        (k₃ : ℝ) * kthRootWeight k₃ s₃ weight e₃ := by
  dsimp
  have hhyper := adaptive_exponents_are_hyperbolic
    hdelta hT₁ hT₂ hT₃ hr₁ hr₂ hr₃
    hratio₁ hratio₂ hratio₃ hscaled
  rcases hhyper with ⟨hk₁, hk₂, hk₃, hrec⟩
  have hledger₁ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      (adaptiveExponent_pos delta
        (exponentTotalWeight s₁ weight e₁)
        (exponentRadicalWeight s₁ weight))
      s₁ weight e₁ hw₁
  have hledger₂ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      (adaptiveExponent_pos delta
        (exponentTotalWeight s₂ weight e₂)
        (exponentRadicalWeight s₂ weight))
      s₂ weight e₂ hw₂
  have hledger₃ :=
    totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
      (adaptiveExponent_pos delta
        (exponentTotalWeight s₃ weight e₃)
        (exponentRadicalWeight s₃ weight))
      s₃ weight e₃ hw₃
  have hmargin₁ := adaptive_root_margin
    hdeltaNonneg hdelta hT₁ hr₁ hledger₁
  have hmargin₂ := adaptive_root_margin
    hdeltaNonneg hdelta hT₂ hr₂ hledger₂
  have hmargin₃ := adaptive_root_margin
    hdeltaNonneg hdelta hT₃ hr₃ hledger₃
  exact ⟨hk₁, hk₂, hk₃, hrec, hmargin₁, hmargin₂, hmargin₃⟩

#print axioms sourceFraction_pos
#print axioms marginFraction_pos
#print axioms marginFraction_lt_one
#print axioms one_sub_margin_mul_source
#print axioms ratio_lt_adaptiveExponent
#print axioms two_le_adaptiveExponent
#print axioms adaptiveExponent_sub_one_mul_radical_le
#print axioms adaptiveExponent_reciprocal_lt
#print axioms adaptive_root_margin
#print axioms adaptive_exponents_are_hyperbolic
#print axioms abc_scaled_radical_sum_lt_one
#print axioms adaptive_profile_signature

end
end AdaptiveHyperbolicSignature
end IUTThreeClosures
