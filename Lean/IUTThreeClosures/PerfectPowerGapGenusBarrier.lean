/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Genus complexity forced by a sub-threshold perfect-power gap

A function-field abc estimate on a genus-`g` parameter curve gives a gap lower
bound of the form

`alpha * D - G ≤ z`,

where `G` is the fixed geometric error (typically `2g-2`).  If a proposed
family has `z ≤ theta * D` with `theta < alpha`, then necessarily

`(alpha-theta) * D ≤ G`.

Thus a fixed saving below the Mason threshold forces the genus/error complexity
to grow linearly with the parameter degree.  Fixed-curve parametrizations are
impossible, and even varying curves must pay a quantified complexity cost.
-/

namespace IUTThreeClosures

/-- Abstract complexity lower bound obtained by comparing lower and upper gap
estimates. -/
theorem perfectPowerGap_geometricError_lower_bound
    {α θ D z G : ℝ}
    (hlower : α * D - G ≤ z)
    (hupper : z ≤ θ * D) :
    (α - θ) * D ≤ G := by
  linarith

/-- If the total degree is positive and the exponent saving is strict, the
geometric error is strictly positive. -/
theorem perfectPowerGap_geometricError_pos
    {α θ D z G : ℝ}
    (hD : 0 < D)
    (hθ : θ < α)
    (hlower : α * D - G ≤ z)
    (hupper : z ≤ θ * D) :
    0 < G := by
  have h := perfectPowerGap_geometricError_lower_bound hlower hupper
  have : 0 < (α - θ) * D :=
    mul_pos (sub_pos.mpr hθ) hD
  linarith

/-- Square--cube specialization: every saving below `1/6` forces a linear
function-field genus/error term. -/
theorem squareCubeGap_genusError_lower_bound
    {θ D z G : ℝ}
    (hlower : D / 6 - G ≤ z)
    (hupper : z ≤ θ * D) :
    (1 / 6 - θ) * D ≤ G := by
  have h := perfectPowerGap_geometricError_lower_bound
    (α := (1 / 6 : ℝ)) (θ := θ) (D := D) (z := z) (G := G)
    (by simpa [div_eq_mul_inv, mul_comm] using hlower) hupper
  simpa using h

end IUTThreeClosures
