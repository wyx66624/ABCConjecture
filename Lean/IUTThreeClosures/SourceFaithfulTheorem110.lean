import IUTThreeClosures.ActualHodgeTheaterOutput
import IUTThreeClosures.CorrectedQPilotDivisor
import IUTThreeClosures.MaximalValuationRingHull
import IUTThreeClosures.PublicLogVolumeInconsistency

/-!
# The first source-derived local component calculation for IUT IV, Theorem 1.10

This module deliberately does not introduce a structure containing a component
formula, a final estimate, or an error term.  The current public
`Iut.LogVolumeData` cannot serve as the carrier of a concrete Theorem 1.10
constructor: its scaling field is quantified over the empty set, and
`not_nonempty_generatedRHSData` proves that the resulting generated source is
uninhabited.

Instead, this file starts the source-faithful replacement on the honest domain
of finite, positive Haar-measurable regions.  For an actual Tate parameter
`q`, multiplication by `q^n` is an additive automorphism.  Uniqueness of Haar
measure therefore computes the component volume of `q^n O` by the genuine
distributive Haar character.  This is the first nonarchimedean local
calculation in Step (v) of the proof of IUT IV, Theorem 1.10.

The next arithmetic identification is intentionally not asserted here: one
must still prove that the distributive Haar character agrees with the chosen
residue-cardinality normalization and hence with the normalized integer
`qOrder`.  The global Ind1/Ind2/Ind3 realization, procession average,
different/conductor comparison, and prime-counting error also remain separate
source theorems.
-/

namespace IUTThreeClosures
namespace SourceFaithfulTheorem110

open MeasureTheory
open scoped ENNReal NNReal Pointwise

universe u

variable {K : Type u}
variable [NontriviallyNormedField K] [ProperSpace K]
variable [MeasurableSpace K] [BorelSpace K]

open MaximalValuationRingHull TateCurvesTheta

/-- The honest finite-positive region underlying the local Tate component
`q^n O_K`.  It is constructed from the actual normalized additive Haar
measure, rather than supplied together with a desired volume. -/
noncomputable def tatePowerFinitePositiveRegion
    (t : TateParameter K) (n : ℕ) :
    FinitePositiveRegion K (normalizedIntegerHaar (K := K)) :=
  scaledFinitePositiveRegion ((t.q : K) ^ n)
    (pow_ne_zero n t.q.ne_zero)

/-- The carrier of the honest region is exactly the source-derived Tate-power
region. -/
@[simp]
theorem coe_tatePowerFinitePositiveRegion
    (t : TateParameter K) (n : ℕ) :
    (tatePowerFinitePositiveRegion t n : Set K) = t.qPowerRegion n := by
  rw [tatePowerFinitePositiveRegion,
    coe_scaledFinitePositiveRegion]
  rfl

/-- Haar scaling computes the measure of the actual local component.  The
right-hand side is canonical: it is the distributive Haar character of the
unit `q^n`, not an independently populated real-valued component function. -/
theorem normalizedIntegerHaar_tatePowerRegion
    (t : TateParameter K) (n : ℕ) :
    normalizedIntegerHaar (K := K) (t.qPowerRegion n) =
      (distribHaarChar K (t.q ^ n) : ℝ≥0∞) := by
  let μ : Measure K := normalizedIntegerHaar (K := K)
  letI : μ.IsAddHaarMeasure := by
    dsimp [μ, normalizedIntegerHaar]
    infer_instance
  have hscale := distribHaarChar_mul (μ := μ) (t.q ^ n)
    (normIntegralRegion (K := K))
  have hunit : μ (normIntegralRegion (K := K)) = 1 := by
    change normalizedIntegerHaar (K := K)
      (normIntegralRegion (K := K)) = 1
    exact normalizedIntegerHaar_apply_normIntegralRegion (K := K)
  have hset :
      (t.q ^ n) • normIntegralRegion (K := K) = t.qPowerRegion n := by
    ext x
    constructor
    · rintro ⟨y, hy, rfl⟩
      exact ⟨y, hy, by simp⟩
    · rintro ⟨y, hy, rfl⟩
      exact ⟨y, hy, by simp [smul_eq_mul]⟩
  rw [hunit, mul_one, hset] at hscale
  exact hscale.symm

/-- **First source-derived component lemma.**  The canonical logarithmic
volume of `q^n O_K` is the logarithm of the genuine Haar character, and hence
is `n` times the logarithmic volume contribution of `q O_K`. -/
theorem tatePower_component_logVolume
    (t : TateParameter K) (n : ℕ) :
    (tatePowerFinitePositiveRegion t n).logVolume =
      (n : ℝ) * Real.log ((distribHaarChar K t.q : ℝ≥0) : ℝ) := by
  rw [FinitePositiveRegion.logVolume]
  have hcarrier :
      (tatePowerFinitePositiveRegion t n).carrier = t.qPowerRegion n :=
    coe_tatePowerFinitePositiveRegion t n
  rw [hcarrier, normalizedIntegerHaar_tatePowerRegion]
  rw [map_pow, ENNReal.coe_toReal]
  exact Real.log_pow _ n

end SourceFaithfulTheorem110
end IUTThreeClosures
