/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.UpperSemicompatiblePossibleImageSystem
import IUTThreeClosures.HonestFinitePositiveLogVolume

/-!
# From upper-semicompatible possible images to an honest measured theta hull

The source theorem and the measured-volume theorem are logically distinct.
`UpperSemicompatiblePossibleImageSystem` proves the set-theoretic relations

`native region ⊆ possible-image union ⊆ explicit envelope`.

A holomorphic hull operator turns the possibly nonmeasurable union into one
actual measurable finite-positive region.  Its extensivity and minimality then
produce the measured sandwich

`native region ⊆ actual theta hull ⊆ explicit envelope`.

This module performs that passage without requiring the possible-image type to
be finite or countable and without assigning a real log-volume to arbitrary
sets.  The remaining geometric tasks are precisely the construction of the
genuine source operations, the actual holomorphic hull, the finite-positive
native/envelope regions, and the native q-volume calibration.
-/

namespace IUTThreeClosures

open MeasureTheory

universe u v w x y

/-- A holomorphic-hull operation whose output is automatically a measurable
finite-positive region.  `IsHull` records the source-specific class of
admissible product/hull regions. -/
structure MeasuredHullOperator
    (α : Type y) [MeasurableSpace α] (μ : Measure α) :
    Type (y + 1) where
  IsHull : Set α → Prop
  hull : Set α → FinitePositiveRegion α μ
  subset_hull : ∀ U, U ⊆ (hull U : Set α)
  hull_minimal : ∀ U E,
    U ⊆ E → IsHull E → (hull U : Set α) ⊆ E

/-- Actual finite-positive data attached to an upper-semicompatible source. -/
structure MeasuredUpperSemicompatibleSource
    {α : Type y} [MeasurableSpace α] (μ : Measure α)
    (S : UpperSemicompatiblePossibleImageSystem.{u, v, w, x, y} α) :
    Type (max (u + 1) (v + 1) (w + 1) (x + 1) (y + 1)) where
  hullOp : MeasuredHullOperator α μ
  native : FinitePositiveRegion α μ
  native_carrier : (native : Set α) = S.nativeRegion
  envelope : FinitePositiveRegion α μ
  envelope_carrier : (envelope : Set α) = S.envelope
  envelope_isHull : hullOp.IsHull (envelope : Set α)
  qLog : ℝ
  qLog_pos : 0 < qLog
  nativeVolume : native.logVolume = -qLog

namespace MeasuredUpperSemicompatibleSource

variable {α : Type y} [MeasurableSpace α] {μ : Measure α}
variable {S : UpperSemicompatiblePossibleImageSystem.{u, v, w, x, y} α}

/-- The actual measured holomorphic hull of the complete possible-image
family. -/
noncomputable def theta
    (M : MeasuredUpperSemicompatibleSource μ S) :
    FinitePositiveRegion α μ :=
  M.hullOp.hull S.possibleUnion

/-- The distinguished native q-pilot region is contained in the actual theta
hull.  This is the source relation used for the Corollary 3.12 lower bound. -/
theorem native_le_theta
    (M : MeasuredUpperSemicompatibleSource μ S) :
    (M.native : Set α) ⊆ (M.theta : Set α) := by
  intro z hz
  have hzNative : z ∈ S.nativeRegion := by
    rw [← M.native_carrier]
    exact hz
  have hzUnion : z ∈ S.possibleUnion := S.actualNativeImage hzNative
  exact M.hullOp.subset_hull S.possibleUnion hzUnion

/-- The actual theta hull is contained in the explicit multiradial envelope.
This is the source relation used by the IUT IV upper estimate. -/
theorem theta_le_envelope
    (M : MeasuredUpperSemicompatibleSource μ S) :
    (M.theta : Set α) ⊆ (M.envelope : Set α) := by
  apply M.hullOp.hull_minimal
  · intro z hz
    have hzEnv : z ∈ S.envelope := S.actualPossibleImageEnvelope hz
    rw [← M.envelope_carrier] at hzEnv
    exact hzEnv
  · exact M.envelope_isHull

/-- The honest lower and upper log-volume bounds. -/
theorem logVolume_sandwich
    (M : MeasuredUpperSemicompatibleSource μ S) :
    -M.qLog ≤ M.theta.logVolume ∧
      M.theta.logVolume ≤ M.envelope.logVolume := by
  constructor
  · rw [← M.nativeVolume]
    exact M.native.logVolume_mono M.native_le_theta
  · exact M.theta.logVolume_mono M.theta_le_envelope

/-- Canonical theta coefficient. -/
noncomputable def thetaCoefficient
    (M : MeasuredUpperSemicompatibleSource μ S) : ℝ :=
  M.theta.logVolume / M.qLog

/-- Canonical explicit-envelope coefficient. -/
noncomputable def envelopeCoefficient
    (M : MeasuredUpperSemicompatibleSource μ S) : ℝ :=
  M.envelope.logVolume / M.qLog

/-- Source-derived Corollary 3.12 lower bound. -/
theorem thetaCoefficient_ge_neg_one
    (M : MeasuredUpperSemicompatibleSource μ S) :
    -1 ≤ M.thetaCoefficient := by
  rw [thetaCoefficient]
  apply (le_div_iff₀ M.qLog_pos).2
  simpa only [neg_mul, one_mul] using M.logVolume_sandwich.1

/-- Source-derived IUT IV envelope upper bound for the same coefficient. -/
theorem thetaCoefficient_le_envelopeCoefficient
    (M : MeasuredUpperSemicompatibleSource μ S) :
    M.thetaCoefficient ≤ M.envelopeCoefficient := by
  unfold thetaCoefficient envelopeCoefficient
  exact (div_le_div_iff_of_pos_right M.qLog_pos).2
    M.logVolume_sandwich.2

end MeasuredUpperSemicompatibleSource

end IUTThreeClosures
