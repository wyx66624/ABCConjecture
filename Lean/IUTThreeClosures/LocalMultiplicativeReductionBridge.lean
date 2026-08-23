/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Iut.Cor312.ThetaData.GlobalField

/-!
# The exact local multiplicative-reduction bridge

Mathlib defines multiplicative reduction of a Weierstrass equation over the
fraction field of a discrete valuation ring by three conditions:

* the equation is minimal;
* the valuation of its discriminant is strictly below one;
* the valuation of `c₄` is one.

This module records the exact constructor and equivalence in a form that can
be consumed by the Frey odd-prime calculation. It also records the immediate
passage from multiplicative to stable reduction at a number-field place.

Thus the remaining Frey local theorem is no longer the whole reduction
predicate: it is precisely the proof that the completed integral Frey model is
minimal and that the elementary divisibility signature maps to the two
valuation statements. No global, IUT III, height or abc input occurs here.
-/

namespace IUTThreeClosures

open WeierstrassCurve
open IsDedekindDomain.HeightOneSpectrum

universe u v

/-- A minimal local equation with bad discriminant and unit `c₄` has
multiplicative reduction. -/
theorem hasMultiplicativeReduction_of_minimal_valuations
    {R : Type u} [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R]
    {K : Type v} [Field K] [Algebra R K] [IsFractionRing R K]
    (W : WeierstrassCurve K)
    (hmin : W.IsMinimal R)
    (hDelta :
      valuation K (IsDiscreteValuationRing.maximalIdeal R) W.Δ < 1)
    (hc4 :
      valuation K (IsDiscreteValuationRing.maximalIdeal R) W.c₄ = 1) :
    W.HasMultiplicativeReduction R := by
  letI : W.IsMinimal R := hmin
  exact {
    badReduction := hDelta
    multiplicativeReduction := hc4
  }

/-- Multiplicative reduction is exactly minimality plus the two valuation
conditions used by the Frey local signature. -/
theorem hasMultiplicativeReduction_iff_minimal_valuations
    {R : Type u} [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R]
    {K : Type v} [Field K] [Algebra R K] [IsFractionRing R K]
    (W : WeierstrassCurve K) :
    W.HasMultiplicativeReduction R ↔
      W.IsMinimal R ∧
      valuation K (IsDiscreteValuationRing.maximalIdeal R) W.Δ < 1 ∧
      valuation K (IsDiscreteValuationRing.maximalIdeal R) W.c₄ = 1 := by
  constructor
  · intro h
    exact ⟨h.toIsMinimal, h.badReduction, h.multiplicativeReduction⟩
  · rintro ⟨hmin, hDelta, hc4⟩
    exact hasMultiplicativeReduction_of_minimal_valuations
      W hmin hDelta hc4

/-- Multiplicative reduction at a number-field place is one of the two stable
reduction alternatives. -/
theorem hasStableReductionAt_of_multiplicative
    {F : Type u} [Field F] [NumberField F]
    (E : WeierstrassCurve F)
    (w : NumberField.FinitePlace F)
    (h : Iut.HasMultiplicativeReductionAt E w) :
    Iut.HasStableReductionAt E w :=
  Or.inr h

end IUTThreeClosures
