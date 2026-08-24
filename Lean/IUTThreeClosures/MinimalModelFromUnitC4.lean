/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LocalMultiplicativeReductionBridge

/-!
# Minimality from an integral unit c₄

Let `R` be a discrete valuation ring with fraction field `K`. If a
Weierstrass equation over `K` is integral over `R` and its `c₄`-invariant is a
valuation unit, then the equation is minimal.

Indeed, for an admissible variable change `C` one has

`c₄(C • W) = u⁻⁴ c₄(W)` and `Δ(C • W) = u⁻¹² Δ(W)`.

If `C • W` remains integral, then its `c₄` has valuation at most one. Since
the original `c₄` has valuation one, this forces the valuation of `u⁻¹` to be
at most one. The discriminant valuation can therefore only decrease in the
multiplicative ordering, which is precisely Mathlib's maximality definition of
a minimal equation.

This closes the minimal-model part of the odd-prime Frey reduction argument.
The remaining arithmetic transfer is to prove that the completed Frey
invariants satisfy valuation `Δ < 1` and valuation `c₄ = 1` at an odd support
prime.
-/

namespace IUTThreeClosures

open WeierstrassCurve
open IsDedekindDomain.HeightOneSpectrum

universe u v

/-- An integral Weierstrass equation whose `c₄` is a valuation unit is
minimal. -/
theorem isMinimal_of_isIntegral_c4_valuation_eq_one
    {R : Type u} [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R]
    {K : Type v} [Field K] [Algebra R K] [IsFractionRing R K]
    (W : WeierstrassCurve K)
    (hIntegral : W.IsIntegral R)
    (hc4 :
      valuation K (IsDiscreteValuationRing.maximalIdeal R) W.c₄ = 1) :
    W.IsMinimal R := by
  letI : W.IsIntegral R := hIntegral
  refine ⟨⟨?_, ?_⟩⟩
  · simpa using hIntegral
  · intro C hC
    letI : (C • W).IsIntegral R := hC
    have hc4_le :
        valuation K (IsDiscreteValuationRing.maximalIdeal R)
            (C • W).c₄ ≤ 1 := by
      rw [← integralModel_c₄_eq R (C • W)]
      exact valuation_le_one
        (IsDiscreteValuationRing.maximalIdeal R)
        (integralModel R (C • W)).c₄
    have hc4_change :
        valuation K (IsDiscreteValuationRing.maximalIdeal R)
            (C • W).c₄ =
          (valuation K (IsDiscreteValuationRing.maximalIdeal R)
            (C.u⁻¹ : K)) ^ 4 := by
      simp only [variableChange_c₄, map_mul, map_pow,
        Units.val_inv_eq_inv_val, hc4, mul_one]
    have hu_pow :
        (valuation K (IsDiscreteValuationRing.maximalIdeal R)
            (C.u⁻¹ : K)) ^ 4 ≤ 1 := by
      rw [← hc4_change]
      exact hc4_le
    have hu :
        valuation K (IsDiscreteValuationRing.maximalIdeal R)
            (C.u⁻¹ : K) ≤ 1 :=
      (pow_le_one_iff (by norm_num : (4 : ℕ) ≠ 0)).mp hu_pow
    have hu12 :
        (valuation K (IsDiscreteValuationRing.maximalIdeal R)
            (C.u⁻¹ : K)) ^ 12 ≤ 1 :=
      (pow_le_one_iff (by norm_num : (12 : ℕ) ≠ 0)).mpr hu
    have hnonneg :
        0 ≤ valuation K (IsDiscreteValuationRing.maximalIdeal R) W.Δ :=
      bot_le
    have hscaled :
        (valuation K (IsDiscreteValuationRing.maximalIdeal R)
            (C.u⁻¹ : K)) ^ 12 *
            valuation K (IsDiscreteValuationRing.maximalIdeal R) W.Δ ≤
          valuation K (IsDiscreteValuationRing.maximalIdeal R) W.Δ := by
      simpa only [one_mul] using
        (mul_le_mul_of_nonneg_right hu12 hnonneg)
    have hdisc :
        valuation K (IsDiscreteValuationRing.maximalIdeal R) (C • W).Δ ≤
          valuation K (IsDiscreteValuationRing.maximalIdeal R) W.Δ := by
      simpa only [variableChange_Δ, map_mul, map_pow,
        Units.val_inv_eq_inv_val] using hscaled
    change
      (valuation_Δ_aux R (C • W) : ℤᵐ⁰) ≤
        (valuation_Δ_aux R W : ℤᵐ⁰)
    rw [valuation_Δ_aux_eq_of_isIntegral,
      valuation_Δ_aux_eq_of_isIntegral]
    exact hdisc

/-- Consequently, an integral equation with bad discriminant and unit `c₄`
has multiplicative reduction, without a separate minimality hypothesis. -/
theorem hasMultiplicativeReduction_of_integral_valuations
    {R : Type u} [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R]
    {K : Type v} [Field K] [Algebra R K] [IsFractionRing R K]
    (W : WeierstrassCurve K)
    (hIntegral : W.IsIntegral R)
    (hDelta :
      valuation K (IsDiscreteValuationRing.maximalIdeal R) W.Δ < 1)
    (hc4 :
      valuation K (IsDiscreteValuationRing.maximalIdeal R) W.c₄ = 1) :
    W.HasMultiplicativeReduction R := by
  exact hasMultiplicativeReduction_of_minimal_valuations
    W (isMinimal_of_isIntegral_c4_valuation_eq_one W hIntegral hc4)
      hDelta hc4

end IUTThreeClosures
