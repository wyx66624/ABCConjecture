/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualHaarJacobian

/-!
# Degree-normalized Haar log-volume

The raw additive Haar modulus on a finite extension `L/ℚ_p` is the determinant
modulus and therefore carries the local degree. IUT IV uses log-volumes divided
by that degree. This file isolates the exact algebraic normalization step: a
raw change of `d * log ‖a‖` becomes a normalized change of `log ‖a‖`.
-/

namespace IUTThreeClosures

/-- Degree-normalization of a raw real log-volume. -/
noncomputable def degreeNormalizedLogVolume (degree : ℕ) (raw : ℝ) : ℝ :=
  raw / (degree : ℝ)

/-- The exact normalization identity used for local Haar scaling. -/
theorem degreeNormalizedLogVolume_add_degree_mul
    {degree : ℕ} (hdegree : 0 < degree)
    (raw logScale : ℝ) :
    degreeNormalizedLogVolume degree
        (raw + (degree : ℝ) * logScale) =
      degreeNormalizedLogVolume degree raw + logScale := by
  unfold degreeNormalizedLogVolume
  have hdegreeReal : (degree : ℝ) ≠ 0 := by
    exact_mod_cast hdegree.ne'
  field_simp [hdegreeReal]
  ring

/-- A raw multiplicative-Jacobian identity therefore gives the normalized
IUT scaling formula without any additional error term. -/
theorem degreeNormalizedLogVolume_scaling
    {degree : ℕ} (hdegree : 0 < degree)
    {rawBefore rawAfter logNorm : ℝ}
    (hraw : rawAfter = rawBefore + (degree : ℝ) * logNorm) :
    degreeNormalizedLogVolume degree rawAfter =
      degreeNormalizedLogVolume degree rawBefore + logNorm := by
  rw [hraw]
  exact degreeNormalizedLogVolume_add_degree_mul hdegree rawBefore logNorm

end IUTThreeClosures
