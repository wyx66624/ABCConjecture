/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LocalMultiplicativeReductionBridge
import Mathlib.Tactic

/-!
# Unit-c4 minimality and semistable reduction over a DVR

This module closes the minimality part of the local Frey reduction seam.
Let `R` be a discrete valuation ring with fraction field `K`, and let `W` be
an integral Weierstrass equation over `K`.

An admissible change of variables `C = (u,r,s,t)` satisfies

`c4(C • W) = u⁻⁴ c4(W)` and `Delta(C • W) = u⁻¹² Delta(W)`.

If `c4(W)` is a unit, then integrality of `C • W` forces the fourth power of
the valuation of `u⁻¹` to be at most one.  Hence its twelfth power is also at
most one, so the discriminant valuation of `C • W` cannot exceed that of `W`.
Thus `W` is minimal.  The same conclusion follows immediately when the
integral discriminant itself is a unit.

Consequently:

* integral plus unit discriminant gives good reduction;
* integral plus unit `c4` and bad discriminant gives multiplicative reduction;
* every integral equation with unit `c4` has either good or multiplicative
  reduction.

No reduction certificate, Szpiro estimate, IUT bridge, or abc statement is
assumed.
-/

namespace IUTThreeClosures
namespace UnitC4SemistableReduction

open WeierstrassCurve
open IsDiscreteValuationRing IsDedekindDomain.HeightOneSpectrum

universe u v

variable {R : Type u} [CommRing R] [IsDomain R]
variable [IsDiscreteValuationRing R]
variable {K : Type v} [Field K] [Algebra R K] [IsFractionRing R K]

/-- An integral Weierstrass equation whose `c4` has unit valuation is already
minimal. -/
theorem isMinimal_of_isIntegral_c4_unit
    (W : WeierstrassCurve K)
    [hW : W.IsIntegral R]
    (hc4 : valuation K (maximalIdeal R) W.c₄ = 1) :
    W.IsMinimal R := by
  refine ⟨⟨?_, ?_⟩⟩
  · simpa only [one_smul] using hW
  · intro C hC
    letI : (C • W).IsIntegral R := hC
    simp only [one_smul]
    rw [valuation_Δ_aux_eq_of_isIntegral R (C • W),
      valuation_Δ_aux_eq_of_isIntegral R W]
    have hc4le :
        valuation K (maximalIdeal R) (C • W).c₄ ≤ 1 := by
      rw [← integralModel_c₄_eq R (C • W)]
      exact valuation_le_one (maximalIdeal R)
        (integralModel R (C • W)).c₄
    have hu4 :
        (valuation K (maximalIdeal R) ((C.u⁻¹ : Kˣ) : K)) ^ 4 ≤ 1 := by
      simpa only [variableChange_c₄, map_mul, map_pow, hc4, mul_one] using hc4le
    have hu :
        valuation K (maximalIdeal R) ((C.u⁻¹ : Kˣ) : K) ≤ 1 :=
      (pow_le_one_iff (by norm_num : (4 : ℕ) ≠ 0)).mp hu4
    have hu12 :
        (valuation K (maximalIdeal R) ((C.u⁻¹ : Kˣ) : K)) ^ 12 ≤ 1 :=
      (pow_le_one_iff (by norm_num : (12 : ℕ) ≠ 0)).mpr hu
    calc
      valuation K (maximalIdeal R) (C • W).Δ =
          (valuation K (maximalIdeal R) ((C.u⁻¹ : Kˣ) : K)) ^ 12 *
            valuation K (maximalIdeal R) W.Δ := by
              simp only [variableChange_Δ, map_mul, map_pow]
      _ ≤ 1 * valuation K (maximalIdeal R) W.Δ :=
        mul_le_mul_right' hu12 _
      _ = valuation K (maximalIdeal R) W.Δ := one_mul _

/-- An integral Weierstrass equation whose discriminant has unit valuation is
minimal. -/
theorem isMinimal_of_isIntegral_delta_unit
    (W : WeierstrassCurve K)
    [hW : W.IsIntegral R]
    (hDelta : valuation K (maximalIdeal R) W.Δ = 1) :
    W.IsMinimal R := by
  refine ⟨⟨?_, ?_⟩⟩
  · simpa only [one_smul] using hW
  · intro C hC
    letI : (C • W).IsIntegral R := hC
    simp only [one_smul]
    rw [valuation_Δ_aux_eq_of_isIntegral R (C • W),
      valuation_Δ_aux_eq_of_isIntegral R W]
    have hle : valuation K (maximalIdeal R) (C • W).Δ ≤ 1 := by
      rw [← integralModel_Δ_eq R (C • W)]
      exact valuation_le_one (maximalIdeal R)
        (integralModel R (C • W)).Δ
    simpa only [hDelta] using hle

/-- Unit discriminant gives good reduction without a separately supplied
minimality certificate. -/
theorem hasGoodReduction_of_integral_delta_unit
    (W : WeierstrassCurve K)
    [W.IsIntegral R]
    (hDelta : valuation K (maximalIdeal R) W.Δ = 1) :
    W.HasGoodReduction R := by
  letI : W.IsMinimal R := isMinimal_of_isIntegral_delta_unit W hDelta
  exact { goodReduction := hDelta }

/-- Unit `c4` together with a bad discriminant gives multiplicative reduction
without a separately supplied minimality certificate. -/
theorem hasMultiplicativeReduction_of_integral_c4_unit
    (W : WeierstrassCurve K)
    [W.IsIntegral R]
    (hc4 : valuation K (maximalIdeal R) W.c₄ = 1)
    (hDelta : valuation K (maximalIdeal R) W.Δ < 1) :
    W.HasMultiplicativeReduction R := by
  letI : W.IsMinimal R := isMinimal_of_isIntegral_c4_unit W hc4
  exact {
    badReduction := hDelta
    multiplicativeReduction := hc4
  }

/-- An integral equation with unit `c4` is semistable in the local sense:
its reduction is either good or multiplicative. -/
theorem hasGoodReduction_or_hasMultiplicativeReduction_of_integral_c4_unit
    (W : WeierstrassCurve K)
    [W.IsIntegral R]
    (hc4 : valuation K (maximalIdeal R) W.c₄ = 1) :
    W.HasGoodReduction R ∨ W.HasMultiplicativeReduction R := by
  have hDeltaLe : valuation K (maximalIdeal R) W.Δ ≤ 1 := by
    rw [← integralModel_Δ_eq R W]
    exact valuation_le_one (maximalIdeal R) (integralModel R W).Δ
  rcases lt_or_eq_of_le hDeltaLe with hDelta | hDelta
  · exact Or.inr
      (hasMultiplicativeReduction_of_integral_c4_unit W hc4 hDelta)
  · exact Or.inl (hasGoodReduction_of_integral_delta_unit W hDelta)

#print axioms isMinimal_of_isIntegral_c4_unit
#print axioms isMinimal_of_isIntegral_delta_unit
#print axioms hasGoodReduction_of_integral_delta_unit
#print axioms hasMultiplicativeReduction_of_integral_c4_unit
#print axioms hasGoodReduction_or_hasMultiplicativeReduction_of_integral_c4_unit

end UnitC4SemistableReduction
end IUTThreeClosures
