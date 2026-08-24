/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.AlgebraicGeometry.EllipticCurve.Reduction

/-!
# Good reduction from an integral unit discriminant

Over a discrete valuation ring, an integral Weierstrass equation whose
discriminant has valuation one is automatically minimal: every integral
variable change has discriminant valuation at most one, while the original
model already attains this maximal value.  It therefore has good reduction in
Mathlib's sense.

Together with `MinimalModelFromUnitC4`, this gives direct local constructors
for both branches of stable reduction after a finite extension:

* unit discriminant -> good reduction;
* nonunit discriminant and unit `c₄` -> multiplicative reduction.
-/

namespace IUTThreeClosures

open WeierstrassCurve
open IsDedekindDomain.HeightOneSpectrum

universe u v

/-- An integral Weierstrass equation with unit discriminant is minimal. -/
theorem isMinimal_of_isIntegral_delta_valuation_eq_one
    {R : Type u} [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R]
    {K : Type v} [Field K] [Algebra R K] [IsFractionRing R K]
    (W : WeierstrassCurve K)
    (hIntegral : W.IsIntegral R)
    (hDelta :
      valuation K (IsDiscreteValuationRing.maximalIdeal R) W.Δ = 1) :
    W.IsMinimal R := by
  letI : W.IsIntegral R := hIntegral
  refine ⟨⟨?_, ?_⟩⟩
  · simpa using hIntegral
  · intro C hC
    letI : (C • W).IsIntegral R := hC
    change valuation_Δ_aux R (C • W) ≤ valuation_Δ_aux R W
    rw [valuation_Δ_aux_eq_of_isIntegral,
      valuation_Δ_aux_eq_of_isIntegral,
      hDelta]
    exact valuation_le_one
      (IsDiscreteValuationRing.maximalIdeal R) (C • W).Δ

/-- An integral equation with unit discriminant has good reduction. -/
theorem hasGoodReduction_of_integral_delta_valuation_eq_one
    {R : Type u} [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R]
    {K : Type v} [Field K] [Algebra R K] [IsFractionRing R K]
    (W : WeierstrassCurve K)
    (hIntegral : W.IsIntegral R)
    (hDelta :
      valuation K (IsDiscreteValuationRing.maximalIdeal R) W.Δ = 1) :
    W.HasGoodReduction R := by
  letI : W.IsMinimal R :=
    isMinimal_of_isIntegral_delta_valuation_eq_one
      W hIntegral hDelta
  exact { goodReduction := hDelta }

end IUTThreeClosures
