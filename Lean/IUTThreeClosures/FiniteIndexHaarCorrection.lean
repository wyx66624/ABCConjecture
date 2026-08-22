/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.MeasureTheory.Group.Measure
import Mathlib.Analysis.SpecialFunctions.Log.Basic

/-!
# Finite-index Haar corrections

Let `H` be a measurable finite-index additive subgroup of a group equipped
with a normalized additive Haar measure.  The cosets of `H` partition the
ambient group, so

`H.index * μ(H) = μ(univ) = 1`.

Consequently

`log μ(H) = - log H.index`.

This is the exact measure-theoretic mechanism by which a proper integral order
inside the product of the integral closures contributes a logarithmic index
term.  It is not legitimate to identify the two integral structures by
definition; their discrepancy is a finite-index Haar Jacobian and belongs in
the different/discriminant correction.
-/

namespace IUTThreeClosures

open MeasureTheory Set

universe u

variable {G : Type u} [AddGroup G] [MeasurableSpace G] [MeasurableAdd G]
variable (μ : Measure G) [IsAddLeftInvariant μ]
variable (H : AddSubgroup G) [H.FiniteIndex]

/-- A finite-index subgroup of a nonempty group has positive index. -/
theorem addSubgroup_index_pos : 0 < H.index := by
  rw [AddSubgroup.index]
  exact Nat.card_pos

/-- In a normalized additive Haar measure, the subgroup measure multiplied by
its index is exactly one. -/
theorem finiteIndex_index_mul_measure_eq_one
    (hH : MeasurableSet (H : Set G))
    (hnorm : μ Set.univ = 1) :
    (H.index : ℝ≥0∞) * μ H = 1 := by
  simpa [hnorm] using AddSubgroup.index_mul_measure H hH μ

/-- Real-valued form of the normalized finite-index measure identity. -/
theorem finiteIndex_index_mul_measureToReal_eq_one
    (hH : MeasurableSet (H : Set G))
    (hnorm : μ Set.univ = 1) :
    (H.index : ℝ) * (μ H).toReal = 1 := by
  have h := congrArg ENNReal.toReal
    (finiteIndex_index_mul_measure_eq_one μ H hH hnorm)
  simpa using h

/-- Exact logarithmic Haar correction attached to a finite-index integral
subgroup. -/
theorem finiteIndex_log_measure_eq_neg_log_index
    (hH : MeasurableSet (H : Set G))
    (hnorm : μ Set.univ = 1) :
    Real.log (μ H).toReal = -Real.log (H.index : ℝ) := by
  have hmul := finiteIndex_index_mul_measureToReal_eq_one μ H hH hnorm
  have hindex : 0 < (H.index : ℝ) := by
    exact_mod_cast addSubgroup_index_pos H
  have hmeasure : 0 < (μ H).toReal := by
    nlinarith
  have hlog :
      Real.log (H.index : ℝ) + Real.log (μ H).toReal = 0 := by
    rw [← Real.log_mul hindex.ne' hmeasure.ne', hmul, Real.log_one]
  linarith

/-- Relative-order version: normalize Haar measure on the larger compact
additive order `K`; a finite-index suborder contributes minus the logarithm of
the relative index. -/
theorem finiteIndex_suborder_log_correction
    {K : AddSubgroup G} (hHK : H ≤ K)
    (ν : Measure K) [IsAddLeftInvariant ν]
    [(H.subgroupOf K).FiniteIndex]
    (hH : MeasurableSet ((H.subgroupOf K : AddSubgroup K) : Set K))
    (hnorm : ν Set.univ = 1) :
    Real.log (ν (H.subgroupOf K)).toReal =
      -Real.log (H.relIndex K : ℝ) := by
  simpa [AddSubgroup.relIndex] using
    finiteIndex_log_measure_eq_neg_log_index
      ν (H.subgroupOf K) hH hnorm

end IUTThreeClosures
