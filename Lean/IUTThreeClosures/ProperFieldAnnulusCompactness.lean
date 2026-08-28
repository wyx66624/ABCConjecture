/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Topology.MetricSpace.ProperSpace

/-!
# Compact norm annuli in proper normed fields

In a proper normed field, every closed norm annulus

`{x | delta <= ‖x‖ and ‖x‖ <= R}`

is compact.  This supplies the base compactness input for the logarithmic
fundamental strip of a local Tate/theta-root cover once the completion is known
to be a proper local field.
-/

namespace IUTThreeClosures

open Set Metric

universe u

variable {K : Type u} [NormedField K] [ProperSpace K]

/-- A closed norm annulus. -/
def normClosedAnnulus (δ R : ℝ) : Set K :=
  {x | δ ≤ ‖x‖ ∧ ‖x‖ ≤ R}

/-- The outer-radius condition is the ordinary closed ball around zero. -/
theorem normClosedAnnulus_eq_closedBall_inter
    (δ R : ℝ) :
    normClosedAnnulus (K := K) δ R =
      closedBall (0 : K) R ∩ {x : K | δ ≤ ‖x‖} := by
  ext x
  simp [normClosedAnnulus, mem_closedBall, dist_zero_right,
    and_left_comm]

/-- The inner-radius condition is closed. -/
theorem isClosed_norm_ge (δ : ℝ) :
    IsClosed {x : K | δ ≤ ‖x‖} := by
  exact isClosed_Ici.preimage continuous_norm

/-- Every closed norm annulus in a proper normed field is compact. -/
theorem isCompact_normClosedAnnulus (δ R : ℝ) :
    IsCompact (normClosedAnnulus (K := K) δ R) := by
  rw [normClosedAnnulus_eq_closedBall_inter]
  exact isCompact_closedBall.inter_right (isClosed_norm_ge δ)

end IUTThreeClosures
