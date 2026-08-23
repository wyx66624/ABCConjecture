/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.HonestFinitePositiveLogVolume

/-!
# Honest native--theta--envelope sandwiches

The genuine IUT possible-image family need not be countable merely from the
public interface, and an arbitrary union of measurable regions need not be
measurable.  The numerical argument does not require such a union once the
actual holomorphic theta hull has been constructed.

The correct measured object is a sandwich

`native q-pilot region ⊆ actual theta hull ⊆ explicit IUT-IV envelope`,

where all three regions are measurable and have finite, nonzero measure.  The
first inclusion gives the Corollary 3.12 lower bound; the second gives the
component/procession upper bound.  Both logarithmic volumes are canonical
logs of actual measures, so the inconsistent total `LogVolumeData` interface
is never used.
-/

namespace IUTThreeClosures

open MeasureTheory
open scoped BigOperators

universe u v

/-- One measured native--theta--envelope sandwich. -/
structure HonestThetaHullSandwich
    (α : Type u) [MeasurableSpace α] (μ : Measure α) where
  native : FinitePositiveRegion α μ
  theta : FinitePositiveRegion α μ
  envelope : FinitePositiveRegion α μ
  native_le_theta : (native : Set α) ⊆ theta
  theta_le_envelope : (theta : Set α) ⊆ envelope
  qLog : ℝ
  qLog_pos : 0 < qLog
  nativeVolume : native.logVolume = -qLog

namespace HonestThetaHullSandwich

variable {α : Type u} [MeasurableSpace α] {μ : Measure α}

/-- The native q-pilot log-volume is bounded by the actual theta hull. -/
theorem neg_qLog_le_thetaVolume
    (W : HonestThetaHullSandwich α μ) :
    -W.qLog ≤ W.theta.logVolume := by
  rw [← W.nativeVolume]
  exact W.native.logVolume_mono W.native_le_theta

/-- The actual theta hull is bounded by the explicit multiradial envelope. -/
theorem thetaVolume_le_envelopeVolume
    (W : HonestThetaHullSandwich α μ) :
    W.theta.logVolume ≤ W.envelope.logVolume :=
  W.theta.logVolume_mono W.theta_le_envelope

/-- The complete measured sandwich. -/
theorem logVolume_sandwich
    (W : HonestThetaHullSandwich α μ) :
    -W.qLog ≤ W.theta.logVolume ∧
      W.theta.logVolume ≤ W.envelope.logVolume :=
  ⟨W.neg_qLog_le_thetaVolume, W.thetaVolume_le_envelopeVolume⟩

/-- Canonical theta coefficient. -/
noncomputable def thetaCoefficient
    (W : HonestThetaHullSandwich α μ) : ℝ :=
  W.theta.logVolume / W.qLog

/-- Canonical explicit-envelope coefficient. -/
noncomputable def envelopeCoefficient
    (W : HonestThetaHullSandwich α μ) : ℝ :=
  W.envelope.logVolume / W.qLog

/-- Corollary 3.12 lower bound. -/
theorem thetaCoefficient_ge_neg_one
    (W : HonestThetaHullSandwich α μ) :
    -1 ≤ W.thetaCoefficient := by
  rw [thetaCoefficient]
  apply (le_div_iff₀ W.qLog_pos).2
  simpa only [neg_mul, one_mul] using W.neg_qLog_le_thetaVolume

/-- IUT-IV envelope upper bound for the same coefficient. -/
theorem thetaCoefficient_le_envelopeCoefficient
    (W : HonestThetaHullSandwich α μ) :
    W.thetaCoefficient ≤ W.envelopeCoefficient := by
  unfold thetaCoefficient envelopeCoefficient
  exact (div_le_div_iff_of_pos_right W.qLog_pos).2
    W.thetaVolume_le_envelopeVolume

end HonestThetaHullSandwich

/-- Capsule-indexed measured sandwiches with procession normalization. -/
structure HonestProcessionHullSandwich
    (I : Type v) [Fintype I]
    (α : I → Type u)
    [∀ i, MeasurableSpace (α i)]
    (μ : ∀ i, Measure (α i)) where
  native : ∀ i, FinitePositiveRegion (α i) (μ i)
  theta : ∀ i, FinitePositiveRegion (α i) (μ i)
  envelope : ∀ i, FinitePositiveRegion (α i) (μ i)
  native_le_theta : ∀ i, (native i : Set (α i)) ⊆ theta i
  theta_le_envelope : ∀ i, (theta i : Set (α i)) ⊆ envelope i
  qLog : ℝ
  qLog_pos : 0 < qLog
  nativeAverage :
    (∑ i, (native i).logVolume) / Fintype.card I = -qLog

namespace HonestProcessionHullSandwich

variable {I : Type v} [Fintype I]
variable {α : I → Type u} [∀ i, MeasurableSpace (α i)]
variable {μ : ∀ i, Measure (α i)}

/-- Procession-normalized theta-hull log-volume. -/
noncomputable def thetaAverage
    (W : HonestProcessionHullSandwich I α μ) : ℝ :=
  (∑ i, (W.theta i).logVolume) / Fintype.card I

/-- Procession-normalized explicit-envelope log-volume. -/
noncomputable def envelopeAverage
    (W : HonestProcessionHullSandwich I α μ) : ℝ :=
  (∑ i, (W.envelope i).logVolume) / Fintype.card I

/-- The native procession average is bounded by the theta-hull average. -/
theorem neg_qLog_le_thetaAverage
    (W : HonestProcessionHullSandwich I α μ) :
    -W.qLog ≤ W.thetaAverage := by
  rw [← W.nativeAverage, thetaAverage]
  by_cases hI : Fintype.card I = 0
  · simp [hI]
  · have hpos : (0 : ℝ) < Fintype.card I := by
      exact_mod_cast Nat.pos_of_ne_zero hI
    apply (div_le_div_iff_of_pos_right hpos).2
    apply Finset.sum_le_sum
    intro i hi
    exact (W.native i).logVolume_mono (W.native_le_theta i)

/-- The theta-hull average is bounded by the explicit-envelope average. -/
theorem thetaAverage_le_envelopeAverage
    (W : HonestProcessionHullSandwich I α μ) :
    W.thetaAverage ≤ W.envelopeAverage := by
  unfold thetaAverage envelopeAverage
  by_cases hI : Fintype.card I = 0
  · simp [hI]
  · have hpos : (0 : ℝ) < Fintype.card I := by
      exact_mod_cast Nat.pos_of_ne_zero hI
    apply (div_le_div_iff_of_pos_right hpos).2
    apply Finset.sum_le_sum
    intro i hi
    exact (W.theta i).logVolume_mono (W.theta_le_envelope i)

/-- Complete procession-normalized measured sandwich. -/
theorem average_sandwich
    (W : HonestProcessionHullSandwich I α μ) :
    -W.qLog ≤ W.thetaAverage ∧
      W.thetaAverage ≤ W.envelopeAverage :=
  ⟨W.neg_qLog_le_thetaAverage, W.thetaAverage_le_envelopeAverage⟩

/-- Canonical procession theta coefficient. -/
noncomputable def thetaCoefficient
    (W : HonestProcessionHullSandwich I α μ) : ℝ :=
  W.thetaAverage / W.qLog

/-- Canonical procession envelope coefficient. -/
noncomputable def envelopeCoefficient
    (W : HonestProcessionHullSandwich I α μ) : ℝ :=
  W.envelopeAverage / W.qLog

/-- Procession form of the Corollary 3.12 lower bound. -/
theorem thetaCoefficient_ge_neg_one
    (W : HonestProcessionHullSandwich I α μ) :
    -1 ≤ W.thetaCoefficient := by
  rw [thetaCoefficient]
  apply (le_div_iff₀ W.qLog_pos).2
  simpa only [neg_mul, one_mul] using W.neg_qLog_le_thetaAverage

/-- Procession form of the IUT-IV envelope upper bound. -/
theorem thetaCoefficient_le_envelopeCoefficient
    (W : HonestProcessionHullSandwich I α μ) :
    W.thetaCoefficient ≤ W.envelopeCoefficient := by
  unfold thetaCoefficient envelopeCoefficient
  exact (div_le_div_iff_of_pos_right W.qLog_pos).2
    W.thetaAverage_le_envelopeAverage

end HonestProcessionHullSandwich

end IUTThreeClosures
