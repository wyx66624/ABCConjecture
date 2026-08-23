/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.NormControlledSourceGenerators
import IUTThreeClosures.HonestFinitePositiveLogVolume

/-!
# Outer-measure volume of the genuine possible-image union

An arbitrary union of measurable possible-image regions need not be measurable.
It is nevertheless unnecessary to introduce a universal holomorphic-hull
operator merely to obtain the numerical volume sandwich. A `Measure` evaluates
all sets through its underlying outer measure, and this evaluation is monotone.

For an upper-semicompatible source we already have the source-derived relations

`nativeRegion ⊆ possibleUnion ⊆ envelope`.

If the native region and the explicit envelope have finite, nonzero measure,
then monotonicity proves that the literal possible-image union itself has
finite, nonzero outer measure. Its canonical outer log-volume therefore lies
between the native and envelope log-volumes. This removes both countability and
measurability of the union from the lower/upper coefficient argument.

The module also records a no-go theorem for an overstrong interface: on a
space of infinite total measure, there cannot be an operation assigning to
every set a finite-positive measurable container. In particular, a universal
finite-positive hull operator is not an honest interface for additive Haar
measure on a noncompact local field.

Identifying the outer-volume coefficient below with the paper's precise
holomorphic-theta coefficient remains a source-definition theorem; no such
identification, height estimate, or abc conclusion is assumed here.
-/

namespace IUTThreeClosures

open MeasureTheory

universe u v w x y

/-- A set of finite, strictly positive outer measure. Measurability is not
required. -/
structure FinitePositiveOuterRegion
    (α : Type y) [MeasurableSpace α] (μ : Measure α) where
  carrier : Set α
  measure_ne_zero : μ carrier ≠ 0
  measure_ne_top : μ carrier ≠ ⊤

namespace FinitePositiveOuterRegion

variable {α : Type y} [MeasurableSpace α] {μ : Measure α}

instance : SetLike (FinitePositiveOuterRegion α μ) α where
  coe U := U.carrier
  coe_injective := by
    intro U V h
    cases U
    cases V
    simp_all

@[ext]
theorem ext {U V : FinitePositiveOuterRegion α μ}
    (h : (U : Set α) = (V : Set α)) : U = V :=
  SetLike.coe_injective h

/-- Canonical logarithmic outer volume. -/
noncomputable def logVolume (U : FinitePositiveOuterRegion α μ) : ℝ :=
  Real.log (μ U.carrier).toReal

/-- Finite positive outer measure converts to a positive real number. -/
theorem measure_toReal_pos (U : FinitePositiveOuterRegion α μ) :
    0 < (μ U.carrier).toReal :=
  ENNReal.toReal_pos U.measure_ne_zero U.measure_ne_top

/-- Outer log-volume is monotone under inclusion. -/
theorem logVolume_mono {U V : FinitePositiveOuterRegion α μ}
    (hUV : (U : Set α) ⊆ (V : Set α)) :
    U.logVolume ≤ V.logVolume := by
  have hμ : μ U.carrier ≤ μ V.carrier := measure_mono hUV
  have hreal : (μ U.carrier).toReal ≤ (μ V.carrier).toReal :=
    ENNReal.toReal_mono V.measure_ne_top hμ
  exact Real.strictMonoOn_log.monotoneOn
    U.measure_toReal_pos V.measure_toReal_pos hreal

/-- Every finite-positive measurable region is a finite-positive outer region. -/
def ofFinitePositive (U : FinitePositiveRegion α μ) :
    FinitePositiveOuterRegion α μ where
  carrier := U.carrier
  measure_ne_zero := U.measure_ne_zero
  measure_ne_top := U.measure_ne_top

@[simp]
theorem coe_ofFinitePositive (U : FinitePositiveRegion α μ) :
    (ofFinitePositive U : Set α) = (U : Set α) := rfl

@[simp]
theorem logVolume_ofFinitePositive (U : FinitePositiveRegion α μ) :
    (ofFinitePositive U).logVolume = U.logVolume := rfl

/-- Compare a measurable finite-positive region with an outer region. -/
theorem logVolume_mono_from_finitePositive
    (U : FinitePositiveRegion α μ)
    (V : FinitePositiveOuterRegion α μ)
    (hUV : (U : Set α) ⊆ (V : Set α)) :
    U.logVolume ≤ V.logVolume := by
  simpa using
    (logVolume_mono (U := ofFinitePositive U) (V := V) hUV)

/-- Compare an outer region with a measurable finite-positive region. -/
theorem logVolume_mono_to_finitePositive
    (U : FinitePositiveOuterRegion α μ)
    (V : FinitePositiveRegion α μ)
    (hUV : (U : Set α) ⊆ (V : Set α)) :
    U.logVolume ≤ V.logVolume := by
  simpa using
    (logVolume_mono (U := U) (V := ofFinitePositive V) hUV)

end FinitePositiveOuterRegion

/-- On an infinite-total-measure space there is no operation assigning every
set a finite-positive measurable container. -/
theorem no_universal_finitePositive_container_of_measure_univ_eq_top
    {α : Type y} [MeasurableSpace α] (μ : Measure α)
    (hμ : μ (Set.univ : Set α) = ⊤) :
    ¬ ∃ H : Set α → FinitePositiveRegion α μ,
      ∀ U : Set α, U ⊆ (H U : Set α) := by
  rintro ⟨H, hH⟩
  have hcarrier : (H (Set.univ : Set α) : Set α) = Set.univ :=
    Set.Subset.antisymm (Set.subset_univ _) (hH Set.univ)
  apply (H (Set.univ : Set α)).measure_ne_top
  rw [hcarrier]
  exact hμ

/-- Finite-positive native/envelope data attached to a source-generated
possible-image system. No measurable theta hull is supplied. -/
structure OuterMeasuredUpperSemicompatibleSource
    {α : Type y} [MeasurableSpace α] (μ : Measure α)
    (S : UpperSemicompatiblePossibleImageSystem.{u, v, w, x, y} α) :
    Type (max (u + 1) (v + 1) (w + 1) (x + 1) (y + 1)) where
  native : FinitePositiveRegion α μ
  native_carrier : (native : Set α) = S.nativeRegion
  envelope : FinitePositiveRegion α μ
  envelope_carrier : (envelope : Set α) = S.envelope
  qLog : ℝ
  qLog_pos : 0 < qLog
  nativeVolume : native.logVolume = -qLog

namespace OuterMeasuredUpperSemicompatibleSource

variable {α : Type y} [MeasurableSpace α] {μ : Measure α}
variable {S : UpperSemicompatiblePossibleImageSystem.{u, v, w, x, y} α}

/-- The literal possible-image union, equipped with its automatically finite
and positive outer measure. -/
noncomputable def possible
    (M : OuterMeasuredUpperSemicompatibleSource μ S) :
    FinitePositiveOuterRegion α μ where
  carrier := S.possibleUnion
  measure_ne_zero := by
    intro hzero
    have hsub : (M.native : Set α) ⊆ S.possibleUnion := by
      rw [M.native_carrier]
      exact S.actualNativeImage
    have hle : μ (M.native : Set α) ≤ μ S.possibleUnion := measure_mono hsub
    rw [hzero] at hle
    exact M.native.measure_ne_zero (bot_unique hle)
  measure_ne_top := by
    intro htop
    have hsub : S.possibleUnion ⊆ (M.envelope : Set α) := by
      rw [M.envelope_carrier]
      exact S.actualPossibleImageEnvelope
    have hle : μ S.possibleUnion ≤ μ (M.envelope : Set α) := measure_mono hsub
    rw [htop] at hle
    exact M.envelope.measure_ne_top (top_unique hle)

/-- The native q-pilot region is contained in the literal possible-image
union. -/
theorem native_le_possible
    (M : OuterMeasuredUpperSemicompatibleSource μ S) :
    (M.native : Set α) ⊆ (M.possible : Set α) := by
  change (M.native : Set α) ⊆ S.possibleUnion
  rw [M.native_carrier]
  exact S.actualNativeImage

/-- The literal possible-image union is contained in the explicit envelope. -/
theorem possible_le_envelope
    (M : OuterMeasuredUpperSemicompatibleSource μ S) :
    (M.possible : Set α) ⊆ (M.envelope : Set α) := by
  change S.possibleUnion ⊆ (M.envelope : Set α)
  rw [M.envelope_carrier]
  exact S.actualPossibleImageEnvelope

/-- The honest outer-log-volume sandwich. -/
theorem logVolume_sandwich
    (M : OuterMeasuredUpperSemicompatibleSource μ S) :
    -M.qLog ≤ M.possible.logVolume ∧
      M.possible.logVolume ≤ M.envelope.logVolume := by
  constructor
  · rw [← M.nativeVolume]
    exact FinitePositiveOuterRegion.logVolume_mono_from_finitePositive
      M.native M.possible M.native_le_possible
  · exact FinitePositiveOuterRegion.logVolume_mono_to_finitePositive
      M.possible M.envelope M.possible_le_envelope

/-- Canonical coefficient defined by the outer measure of the complete
possible-image union. -/
noncomputable def possibleCoefficient
    (M : OuterMeasuredUpperSemicompatibleSource μ S) : ℝ :=
  M.possible.logVolume / M.qLog

/-- Canonical coefficient of the explicit envelope. -/
noncomputable def envelopeCoefficient
    (M : OuterMeasuredUpperSemicompatibleSource μ S) : ℝ :=
  M.envelope.logVolume / M.qLog

/-- Source-derived lower bound for the possible-image outer-volume
coefficient. -/
theorem possibleCoefficient_ge_neg_one
    (M : OuterMeasuredUpperSemicompatibleSource μ S) :
    -1 ≤ M.possibleCoefficient := by
  rw [possibleCoefficient]
  apply (le_div_iff₀ M.qLog_pos).2
  simpa only [neg_mul, one_mul] using M.logVolume_sandwich.1

/-- The possible-image outer-volume coefficient is bounded by the explicit
envelope coefficient. -/
theorem possibleCoefficient_le_envelopeCoefficient
    (M : OuterMeasuredUpperSemicompatibleSource μ S) :
    M.possibleCoefficient ≤ M.envelopeCoefficient := by
  unfold possibleCoefficient envelopeCoefficient
  exact (div_le_div_iff_of_pos_right M.qLog_pos).2
    M.logVolume_sandwich.2

end OuterMeasuredUpperSemicompatibleSource

end IUTThreeClosures
