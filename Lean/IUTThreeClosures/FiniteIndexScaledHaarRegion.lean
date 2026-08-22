/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FiniteIndexHaarCorrection
import IUTThreeClosures.HonestFinitePositiveLogVolume

/-!
# Scaled finite-index Haar regions

A measurable finite-index additive order in a compact additive ambient order
is automatically a finite-positive measured region.  After normalizing the
ambient Haar measure to have total mass one, its base logarithmic volume is
exactly minus the logarithm of its index.  Iterating any genuine measure
scaling law therefore gives

`logVol(T^[n](H)) = n * logJacobian - log(index H)`.

For a local scalar `q`, once the multiplicative modulus theorem identifies the
Jacobian with `log ‖q‖`, this becomes the precise factor-level formula

`logVol(q^n H) = n * log ‖q‖ - log(index H)`.

Thus the integral-order discrepancy is a canonical index term; it is neither a
free real error nor something that may be erased by choosing coordinates.
-/

namespace IUTThreeClosures

open MeasureTheory Set

universe u

variable {G : Type u} [AddGroup G] [MeasurableSpace G] [MeasurableAdd G]
variable (μ : Measure G) [Measure.IsAddLeftInvariant μ]
variable (H : AddSubgroup G) [H.FiniteIndex]

/-- A normalized measurable finite-index subgroup as an honest
finite-positive region. -/
noncomputable def finiteIndexHaarRegion
    (hH : MeasurableSet (H : Set G))
    (hnorm : μ Set.univ = 1) :
    FinitePositiveRegion G μ where
  carrier := H
  measurable := hH
  measure_ne_zero := by
    intro hzero
    have h := finiteIndex_index_mul_measure_eq_one μ H hH hnorm
    rw [hzero, mul_zero] at h
    exact zero_ne_one h
  measure_ne_top := by
    have hle : μ (H : Set G) ≤ 1 := by
      calc
        μ (H : Set G) ≤ μ Set.univ := measure_mono (Set.subset_univ _)
        _ = 1 := hnorm
    exact ne_of_lt (hle.trans_lt ENNReal.one_lt_top)

/-- The honest region has exactly the finite-index logarithmic correction. -/
theorem finiteIndexHaarRegion_logVolume
    (hH : MeasurableSet (H : Set G))
    (hnorm : μ Set.univ = 1) :
    (finiteIndexHaarRegion μ H hH hnorm).logVolume =
      -Real.log (H.index : ℝ) := by
  exact finiteIndex_log_measure_eq_neg_log_index μ H hH hnorm

/-- Iterating a genuine scaling law on a normalized finite-index order gives
its Jacobian contribution plus the exact negative log-index correction. -/
theorem scaledFiniteIndexHaarRegion_logVolume
    {transform : Set G → Set G} {a : ℝ}
    (F : FinitePositiveRegion.ScalingLaw (μ := μ) transform a)
    (hH : MeasurableSet (H : Set G))
    (hnorm : μ Set.univ = 1)
    (n : ℕ) :
    ((F.iterate n).pullback
      (finiteIndexHaarRegion μ H hH hnorm)).logVolume =
        (n : ℝ) * a - Real.log (H.index : ℝ) := by
  rw [(F.iterate n).logVolume_pullback,
    finiteIndexHaarRegion_logVolume μ H hH hnorm]
  ring

end IUTThreeClosures
