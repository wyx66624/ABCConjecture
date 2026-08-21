import Mathlib

/-!
# A consistent finite-positive logarithmic volume domain

The public `LogVolumeData` applies a real-valued logarithmic volume and its
scaling law to every set, which is inconsistent on `∅`. The mathematically
correct domain consists of measurable regions of finite, nonzero measure.

This module defines that domain directly from a measure. Log-volume is no
longer a freely populated function: it is `log ((μ U).toReal)`. Monotonicity
is proved from measure monotonicity, and scaling laws are represented by
maps between finite-positive regions rather than statements about arbitrary
sets.
-/

namespace IUTThreeClosures

open MeasureTheory

universe u

/-- A measurable region of finite, strictly positive measure. -/
structure FinitePositiveRegion
    (α : Type u) [MeasurableSpace α] (μ : Measure α) where
  carrier : Set α
  measurable : MeasurableSet carrier
  measure_ne_zero : μ carrier ≠ 0
  measure_ne_top : μ carrier ≠ ⊤

namespace FinitePositiveRegion

variable {α : Type u} [MeasurableSpace α] {μ : Measure α}

instance : SetLike (FinitePositiveRegion α μ) α where
  coe U := U.carrier
  coe_injective := by
    intro U V h
    cases U
    cases V
    simp_all

@[ext]
theorem ext {U V : FinitePositiveRegion α μ}
    (h : (U : Set α) = (V : Set α)) : U = V :=
  SetLike.coe_injective h

/-- The canonical logarithmic volume. -/
noncomputable def logVolume (U : FinitePositiveRegion α μ) : ℝ :=
  Real.log (μ U.carrier).toReal

/-- The measure of a finite-positive region is positive after conversion to
`ℝ`. -/
theorem measure_toReal_pos (U : FinitePositiveRegion α μ) :
    0 < (μ U.carrier).toReal :=
  ENNReal.toReal_pos U.measure_ne_zero U.measure_ne_top

/-- Inclusion of finite-positive regions gives monotonicity of canonical
log-volume. -/
theorem logVolume_mono {U V : FinitePositiveRegion α μ}
    (hUV : (U : Set α) ⊆ (V : Set α)) :
    U.logVolume ≤ V.logVolume := by
  have hμ : μ U.carrier ≤ μ V.carrier := measure_mono hUV
  have hreal : (μ U.carrier).toReal ≤ (μ V.carrier).toReal :=
    ENNReal.toReal_mono V.measure_ne_top hμ
  exact Real.strictMonoOn_log.monotoneOn
    U.measure_toReal_pos V.measure_toReal_pos hreal

/-- Multiplicative measure scaling becomes additive logarithmic scaling. -/
theorem logVolume_eq_add_of_measure_toReal_eq_mul
    (U V : FinitePositiveRegion α μ) (r : ℝ)
    (hr : 0 < r)
    (hscale : (μ U.carrier).toReal = r * (μ V.carrier).toReal) :
    U.logVolume = Real.log r + V.logVolume := by
  rw [logVolume, logVolume, hscale,
    Real.log_mul hr.ne' V.measure_toReal_pos.ne']

/-- A scaling operation on the honest domain. The target region is required
to remain finite-positive, so `∅` can never be fed to the scaling law. -/
structure ScalingLaw
    (transform : Set α → Set α) (logJacobian : ℝ) where
  pullback : FinitePositiveRegion α μ → FinitePositiveRegion α μ
  carrier_pullback : ∀ U, (pullback U : Set α) = transform U
  logVolume_pullback : ∀ U,
    (pullback U).logVolume = U.logVolume + logJacobian

/-- Scaling laws compose. -/
noncomputable def ScalingLaw.comp
    {f g : Set α → Set α} {a b : ℝ}
    (F : ScalingLaw (μ := μ) f a)
    (G : ScalingLaw (μ := μ) g b) :
    ScalingLaw (μ := μ) (fun U => f (g U)) (b + a) where
  pullback U := F.pullback (G.pullback U)
  carrier_pullback U := by
    rw [F.carrier_pullback, G.carrier_pullback]
  logVolume_pullback U := by
    rw [F.logVolume_pullback, G.logVolume_pullback]
    ring

/-- Iterating one scaling law multiplies its logarithmic contribution by the
number of iterations. -/
noncomputable def ScalingLaw.iterate
    {f : Set α → Set α} {a : ℝ}
    (F : ScalingLaw (μ := μ) f a) :
    (n : ℕ) → ScalingLaw (μ := μ) (f^[n]) ((n : ℝ) * a)
  | 0 =>
      { pullback := fun U => U
        carrier_pullback := by intro U; rfl
        logVolume_pullback := by intro U; simp }
  | n + 1 => by
      let G := F.iterate n
      refine
        { pullback := fun U => F.pullback (G.pullback U)
          carrier_pullback := ?_
          logVolume_pullback := ?_ }
      · intro U
        rw [F.carrier_pullback, G.carrier_pullback]
        exact (Function.iterate_succ_apply' f n (U : Set α)).symm
      · intro U
        rw [F.logVolume_pullback, G.logVolume_pullback]
        push_cast
        ring

end FinitePositiveRegion

end IUTThreeClosures