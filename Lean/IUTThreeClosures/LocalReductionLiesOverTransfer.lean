/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LocalIntegralModelReduction

/-!
# Transfer of local reduction signatures through a lying-over prime

Let `f : R → S` be a ring homomorphism and let `q` be the maximal ideal of a
DVR `S`.  If its contraction is a prime ideal `p` of `R`, then for every
`r : R`

`f(r) ∈ q ↔ r ∈ p`.

Applying this tautological contraction identity to the discriminant and `c₄`
of an integral Weierstrass equation transfers the exact good/multiplicative
reduction signature to the fraction field of `S`.

Thus preservation of semistable reduction under the relevant number-field
extension requires no separate reduction theorem once the integral model and
the lying-over identity for the chosen prime are available.
-/

namespace IUTThreeClosures

open WeierstrassCurve

universe u v w

/-- Membership is reflected and preserved by a prime ideal lying over its
contraction. -/
theorem mem_ideal_iff_of_comap_eq
    {R : Type u} {S : Type v}
    [CommRing R] [CommRing S]
    (f : R →+* S)
    (p : Ideal R) (q : Ideal S)
    (hcomap : Ideal.comap f q = p)
    (r : R) :
    f r ∈ q ↔ r ∈ p := by
  change r ∈ Ideal.comap f q ↔ r ∈ p
  rw [hcomap]

/-- Discriminant membership transfers through contraction for a mapped
integral model. -/
theorem map_delta_mem_iff_of_comap_eq
    {R : Type u} {S : Type v}
    [CommRing R] [CommRing S]
    (f : R →+* S)
    (p : Ideal R) (q : Ideal S)
    (hcomap : Ideal.comap f q = p)
    (W : WeierstrassCurve R) :
    (W.map f).Δ ∈ q ↔ W.Δ ∈ p := by
  rw [map_Δ]
  exact mem_ideal_iff_of_comap_eq f p q hcomap W.Δ

/-- `c₄` membership transfers through contraction. -/
theorem map_c4_mem_iff_of_comap_eq
    {R : Type u} {S : Type v}
    [CommRing R] [CommRing S]
    (f : R →+* S)
    (p : Ideal R) (q : Ideal S)
    (hcomap : Ideal.comap f q = p)
    (W : WeierstrassCurve R) :
    (W.map f).c₄ ∈ q ↔ W.c₄ ∈ p := by
  rw [map_c₄]
  exact mem_ideal_iff_of_comap_eq f p q hcomap W.c₄

/-- A unit discriminant at the contracted base prime gives good reduction at
the lying-over DVR. -/
theorem mappedFractionCurve_hasGoodReduction_of_liesOver
    {R : Type u} [CommRing R]
    {S : Type v} [CommRing S] [IsDomain S]
    [IsDiscreteValuationRing S]
    {L : Type w} [Field L] [Algebra S L] [IsFractionRing S L]
    (f : R →+* S)
    (p : Ideal R)
    (hcomap :
      Ideal.comap f (IsLocalRing.maximalIdeal S) = p)
    (W : WeierstrassCurve R)
    (hDelta : W.Δ ∉ p) :
    (fractionCurve S L (W.map f)).HasGoodReduction S := by
  apply fractionCurve_hasGoodReduction S L (W.map f)
  intro hmem
  exact hDelta <|
    (map_delta_mem_iff_of_comap_eq
      f p (IsLocalRing.maximalIdeal S) hcomap W).mp hmem

/-- A nonunit discriminant and unit `c₄` at the contracted base prime give
multiplicative reduction at the lying-over DVR. -/
theorem mappedFractionCurve_hasMultiplicativeReduction_of_liesOver
    {R : Type u} [CommRing R]
    {S : Type v} [CommRing S] [IsDomain S]
    [IsDiscreteValuationRing S]
    {L : Type w} [Field L] [Algebra S L] [IsFractionRing S L]
    (f : R →+* S)
    (p : Ideal R)
    (hcomap :
      Ideal.comap f (IsLocalRing.maximalIdeal S) = p)
    (W : WeierstrassCurve R)
    (hDelta : W.Δ ∈ p)
    (hc4 : W.c₄ ∉ p) :
    (fractionCurve S L (W.map f)).HasMultiplicativeReduction S := by
  apply fractionCurve_hasMultiplicativeReduction S L (W.map f)
  · exact (map_delta_mem_iff_of_comap_eq
      f p (IsLocalRing.maximalIdeal S) hcomap W).mpr hDelta
  · intro hmem
    exact hc4 <|
      (map_c4_mem_iff_of_comap_eq
        f p (IsLocalRing.maximalIdeal S) hcomap W).mp hmem

end IUTThreeClosures
