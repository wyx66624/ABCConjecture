/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.HonestFinitePositiveLogVolume
import Mathlib.MeasureTheory.Measure.Haar.DistribChar
import Mathlib.MeasureTheory.Group.Pointwise

/-!
# Genuine distributive Haar scaling on finite-positive regions

The old public logarithmic-volume interface asserted a real-valued scaling law
on every set, including the empty set.  The present theorem works only on
measurable regions of finite nonzero measure.

Let a group `G` act continuously and distributively on a locally compact
additive group `A`.  Mathlib's distributive Haar character `distribHaarChar A g`
is the unique positive factor satisfying

`μ (g • U) = distribHaarChar A g * μ U`

for an additive Haar measure `μ`.  Consequently multiplication by `g` gives an
honest `FinitePositiveRegion.ScalingLaw`, with logarithmic Jacobian
`log (distribHaarChar A g)`.

This is the actual measure-theoretic scaling theorem.  Identifying the
character with a local norm, determinant, or residue-index expression is a
separate arithmetic theorem and is not built into the definition.
-/

namespace IUTThreeClosures

open MeasureTheory
open scoped ENNReal NNReal Pointwise

universe u v

variable {G : Type u} {A : Type v}
variable [Group G] [AddCommGroup A] [DistribMulAction G A]
variable [TopologicalSpace A] [IsTopologicalAddGroup A]
variable [LocallyCompactSpace A] [ContinuousConstSMul G A]
variable [MeasurableSpace A] [BorelSpace A] [MeasurableConstSMul G A]
variable {μ : Measure A} [μ.IsAddHaarMeasure] [Regular μ]

namespace FinitePositiveRegion

/-- Continuous multiplication by a group element sends a finite-positive
region to another finite-positive region. -/
noncomputable def distribSmul
    (g : G) (U : FinitePositiveRegion A μ) :
    FinitePositiveRegion A μ where
  carrier := g • (U : Set A)
  measurable := U.measurable.const_smul g
  measure_ne_zero := by
    rw [← MeasureTheory.distribHaarChar_mul μ g (U : Set A)]
    exact mul_ne_zero (by simp [MeasureTheory.distribHaarChar_pos]) U.measure_ne_zero
  measure_ne_top := by
    rw [← MeasureTheory.distribHaarChar_mul μ g (U : Set A)]
    simp [U.measure_ne_top]

@[simp]
theorem coe_distribSmul
    (g : G) (U : FinitePositiveRegion A μ) :
    (U.distribSmul g : Set A) = g • (U : Set A) :=
  rfl

/-- Exact logarithmic Jacobian formula for genuine additive Haar measure. -/
theorem logVolume_distribSmul
    (g : G) (U : FinitePositiveRegion A μ) :
    (U.distribSmul g).logVolume =
      Real.log (MeasureTheory.distribHaarChar A g : ℝ) + U.logVolume := by
  apply logVolume_eq_add_of_measure_toReal_eq_mul
  · exact_mod_cast MeasureTheory.distribHaarChar_pos (A := A) (g := g)
  · have h := congrArg ENNReal.toReal
      (MeasureTheory.distribHaarChar_mul μ g (U : Set A))
    simpa using h.symm

/-- The distributive Haar character produces a consistent scaling law on the
finite-positive domain. -/
noncomputable def distribScalingLaw (g : G) :
    ScalingLaw (μ := μ) (fun U : Set A => g • U)
      (Real.log (MeasureTheory.distribHaarChar A g : ℝ)) where
  pullback := fun U => U.distribSmul g
  carrier_pullback := fun U => rfl
  logVolume_pullback := by
    intro U
    rw [logVolume_distribSmul]
    ring

end FinitePositiveRegion

end IUTThreeClosures
