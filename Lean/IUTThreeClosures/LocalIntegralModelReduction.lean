/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MinimalModelFromUnitC4
import IUTThreeClosures.GoodReductionFromUnitDiscriminant

/-!
# Local reduction from an integral model over a DVR

Let `R` be a discrete valuation ring with fraction field `K`, and let `W₀` be
a Weierstrass equation over `R`.  Its base change to `K` is automatically an
integral equation.  Membership of `Δ(W₀)` and `c₄(W₀)` in the maximal ideal
then translates directly into the multiplicative valuation conditions used by
Mathlib:

* `Δ ∉ m` gives valuation `Δ = 1`, hence good reduction;
* `Δ ∈ m` and `c₄ ∉ m` give valuation `Δ < 1`, valuation `c₄ = 1`, hence
  multiplicative reduction.

This removes minimality from the source-facing local theorem and reduces
reduction after extension to ideal membership of the mapped integral model.
-/

namespace IUTThreeClosures

open WeierstrassCurve
open IsDedekindDomain.HeightOneSpectrum

universe u v

/-- Base change of an integral Weierstrass equation over a DVR to its fraction
field. -/
noncomputable def fractionCurve
    (R : Type u) [CommRing R] [IsDomain R]
    (K : Type v) [Field K] [Algebra R K]
    (W : WeierstrassCurve R) : WeierstrassCurve K :=
  W.map (algebraMap R K)

/-- A curve obtained by base change from a DVR equation is integral. -/
theorem fractionCurve_isIntegral
    (R : Type u) [CommRing R] [IsDomain R]
    (K : Type v) [Field K] [Algebra R K]
    (W : WeierstrassCurve R) :
    (fractionCurve R K W).IsIntegral R := by
  unfold fractionCurve
  apply isIntegral_of_exists_lift R
  all_goals
    refine ⟨_, ?_⟩
    rfl

/-- The discriminant valuation of the fraction-field curve is one exactly when
the integral discriminant is outside the maximal ideal. -/
theorem fractionCurve_delta_valuation_eq_one
    (R : Type u) [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R]
    (K : Type v) [Field K] [Algebra R K] [IsFractionRing R K]
    (W : WeierstrassCurve R)
    (hDelta : W.Δ ∉ IsLocalRing.maximalIdeal R) :
    valuation K (IsDiscreteValuationRing.maximalIdeal R)
        (fractionCurve R K W).Δ = 1 := by
  change valuation K (IsDiscreteValuationRing.maximalIdeal R)
      (algebraMap R K W.Δ) = 1
  exact valuation_eq_one_iff_notMem.mpr hDelta

/-- The discriminant valuation is strictly below one exactly when the integral
discriminant belongs to the maximal ideal. -/
theorem fractionCurve_delta_valuation_lt_one
    (R : Type u) [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R]
    (K : Type v) [Field K] [Algebra R K] [IsFractionRing R K]
    (W : WeierstrassCurve R)
    (hDelta : W.Δ ∈ IsLocalRing.maximalIdeal R) :
    valuation K (IsDiscreteValuationRing.maximalIdeal R)
        (fractionCurve R K W).Δ < 1 := by
  change valuation K (IsDiscreteValuationRing.maximalIdeal R)
      (algebraMap R K W.Δ) < 1
  exact valuation_lt_one_iff_mem.mpr hDelta

/-- The `c₄` valuation is one when the integral invariant is outside the
maximal ideal. -/
theorem fractionCurve_c4_valuation_eq_one
    (R : Type u) [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R]
    (K : Type v) [Field K] [Algebra R K] [IsFractionRing R K]
    (W : WeierstrassCurve R)
    (hc4 : W.c₄ ∉ IsLocalRing.maximalIdeal R) :
    valuation K (IsDiscreteValuationRing.maximalIdeal R)
        (fractionCurve R K W).c₄ = 1 := by
  change valuation K (IsDiscreteValuationRing.maximalIdeal R)
      (algebraMap R K W.c₄) = 1
  exact valuation_eq_one_iff_notMem.mpr hc4

/-- Integral model with unit discriminant gives good reduction. -/
theorem fractionCurve_hasGoodReduction
    (R : Type u) [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R]
    (K : Type v) [Field K] [Algebra R K] [IsFractionRing R K]
    (W : WeierstrassCurve R)
    (hDelta : W.Δ ∉ IsLocalRing.maximalIdeal R) :
    (fractionCurve R K W).HasGoodReduction R := by
  exact hasGoodReduction_of_integral_delta_valuation_eq_one
    (fractionCurve R K W)
    (fractionCurve_isIntegral R K W)
    (fractionCurve_delta_valuation_eq_one R K W hDelta)

/-- Integral model with nonunit discriminant and unit `c₄` gives
multiplicative reduction. -/
theorem fractionCurve_hasMultiplicativeReduction
    (R : Type u) [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R]
    (K : Type v) [Field K] [Algebra R K] [IsFractionRing R K]
    (W : WeierstrassCurve R)
    (hDelta : W.Δ ∈ IsLocalRing.maximalIdeal R)
    (hc4 : W.c₄ ∉ IsLocalRing.maximalIdeal R) :
    (fractionCurve R K W).HasMultiplicativeReduction R := by
  exact hasMultiplicativeReduction_of_integral_valuations
    (fractionCurve R K W)
    (fractionCurve_isIntegral R K W)
    (fractionCurve_delta_valuation_lt_one R K W hDelta)
    (fractionCurve_c4_valuation_eq_one R K W hc4)

end IUTThreeClosures
