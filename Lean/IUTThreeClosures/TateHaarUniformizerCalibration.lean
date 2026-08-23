import IUTThreeClosures.TateHaarModulus

/-!
# Uniformizer calibration of actual Tate Haar volumes

This module connects the exact Haar-modulus calculation for `q^n O` with the
canonical discrete order of a Tate parameter.  The set-theoretic arithmetic
input was already proved in `TateParameterPowerRegions`:

`q^n O = π^(n * ord_π(q)) O`.

Combining that equality with the actual normalized additive Haar measure gives

`μ(q^n O) = Δ_K(π)^(n * ord_π(q))`

and hence

`log μ(q^n O) = (n * ord_π(q)) * log Δ_K(π)`.

Thus all dependence on the Tate parameter is now carried by its canonical
integer order.  The only remaining local normalization theorem is the standard
local-field identification of `Δ_K(π)` with the residue-cardinality convention
(or, equivalently after degree normalization, the rational-prime convention).
No such identification is assumed in this file.
-/

namespace TateCurvesTheta

open MeasureTheory
open scoped Pointwise ENNReal

universe u

variable {K : Type u} [NormedField K] [ProperSpace K]
variable [MeasurableSpace K] [BorelSpace K]

/-- Exact Haar measure of a uniformizer-power image of the norm-unit ball. -/
theorem normIntegralHaar_apply_uniformizerPowerRegion
    {π : K} (hπ : IsUniformizer π) (n : ℕ) :
    normIntegralHaar K
        (scaledRegion (π ^ n) (normIntegralRegion (K := K))) =
      ((MeasureTheory.distribHaarChar K (Units.mk0 π hπ.ne_zero) : ℝ≥0∞) ^ n) := by
  have h := normIntegralHaar_apply_scaledRegion
    (K := K) (π ^ n) (pow_ne_zero n hπ.ne_zero)
  have hu :
      Units.mk0 (π ^ n) (pow_ne_zero n hπ.ne_zero) =
        (Units.mk0 π hπ.ne_zero) ^ n := by
    ext
    simp
  simpa [hu] using h

namespace TateParameter

/-- The distributive Haar character of the actual Tate parameter is the
canonical-order power of the uniformizer character. -/
theorem distribHaarChar_q_eq_uniformizer_pow
    (t : TateParameter K) {π : K} (hπ : IsUniformizer π) :
    MeasureTheory.distribHaarChar K t.q =
      (MeasureTheory.distribHaarChar K (Units.mk0 π hπ.ne_zero)) ^
        (t.toOrdered hπ).orderNat := by
  have hq :
      normIntegralHaar K
          (scaledRegion (t.q : K) (normIntegralRegion (K := K))) =
        (MeasureTheory.distribHaarChar K t.q : ℝ≥0∞) := by
    simpa using normIntegralHaar_apply_scaledRegion
      (K := K) (t.q : K) t.q.ne_zero
  have hπpow := normIntegralHaar_apply_uniformizerPowerRegion
    (K := K) hπ (t.toOrdered hπ).orderNat
  apply ENNReal.coe_injective
  calc
    (MeasureTheory.distribHaarChar K t.q : ℝ≥0∞) =
        normIntegralHaar K
          (scaledRegion (t.q : K) (normIntegralRegion (K := K))) := hq.symm
    _ = normIntegralHaar K
          (scaledRegion
            (π ^ (t.toOrdered hπ).orderNat)
            (normIntegralRegion (K := K))) :=
      congrArg (normIntegralHaar K)
        (t.scaledRegion_q_eq_uniformizerPower hπ)
    _ = ((MeasureTheory.distribHaarChar K
          (Units.mk0 π hπ.ne_zero) : ℝ≥0∞) ^
            (t.toOrdered hπ).orderNat) := hπpow

/-- Exact actual Haar measure of `q^n O`, now expressed solely through the
canonical uniformizer exponent `qPowerOrder`. -/
theorem normIntegralHaar_apply_qPowerRegion_eq_uniformizer
    (t : TateParameter K) {π : K} (hπ : IsUniformizer π) (n : ℕ) :
    normIntegralHaar K (t.qPowerRegion n) =
      ((MeasureTheory.distribHaarChar K
        (Units.mk0 π hπ.ne_zero) : ℝ≥0∞) ^ t.qPowerOrder hπ n) := by
  rw [t.qPowerRegion_eq_qPowerOrder hπ n]
  exact normIntegralHaar_apply_uniformizerPowerRegion
    (K := K) hπ (t.qPowerOrder hπ n)

/-- Uniformizer-calibrated canonical log-volume of the actual Tate-power
region. -/
theorem qPowerFinitePositiveRegion_logVolume_eq_uniformizer
    (t : TateParameter K) {π : K} (hπ : IsUniformizer π) (n : ℕ) :
    (t.qPowerFinitePositiveRegion n).logVolume =
      (t.qPowerOrder hπ n : ℝ) *
        Real.log
          (MeasureTheory.distribHaarChar K
            (Units.mk0 π hπ.ne_zero) : ℝ) := by
  rw [IUTThreeClosures.FinitePositiveRegion.logVolume]
  change
    Real.log ((normIntegralHaar K (t.qPowerRegion n)).toReal) = _
  rw [t.normIntegralHaar_apply_qPowerRegion_eq_uniformizer hπ n]
  simp [Real.log_pow]

end TateParameter

end TateCurvesTheta
