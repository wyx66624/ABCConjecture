/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyTwoBoundaryInertiaPackage
import IUTThreeClosures.TwoInertiaUniformSublinearHeight

/-!
# A uniform selected-prime bound for every Frey two-boundary input

The common Frey candidate coefficient `2/log 2` is independent of the abc
point.  Therefore, at a fixed lower threshold `B` and target slope `eta`, one
single additive constant controls the logarithm of every prime selected from
every admissible two-boundary package.

This is the precise uniformity required by the final abc quantifiers.
-/

namespace IUTThreeClosures

namespace FreyTwoBoundaryInertiaData

/-- **Uniform Frey selected-prime theorem.**  The constant is chosen before the
abc integer `c` and before the local boundary package. -/
theorem exists_uniform_selectedPrime_log_bound
    (B : ℕ)
    {η : ℝ} (hη : 0 < η) :
    ∃ C : ℝ,
      ∀ {c : ℕ}
        (D : FreyTwoBoundaryInertiaData c),
        0 < c →
        Real.log (D.selectPrime B).ell ≤
          η * Real.log c + C := by
  rcases exists_uniform_freyCandidatePrime_log_bound B hη with
    ⟨C, hC⟩
  refine ⟨C, ?_⟩
  intro c D hc
  have hheight : 0 ≤ Real.log c := by
    apply Real.log_nonneg
    exact_mod_cast
      (Nat.one_le_iff_ne_zero.mpr (Nat.ne_of_gt hc))
  exact hC (D.selectPrime B) hheight
    (D.first.parameter_le_log_height hc)
    (D.second.parameter_le_log_height hc)

/-- A threshold depending on the correction budget still gives a constant
uniform in every abc input. -/
theorem exists_uniform_selectedPrime_log_bound_at_budget
    (threshold : ℝ → ℕ)
    {δ η : ℝ} (hη : 0 < η) :
    ∃ C : ℝ,
      ∀ {c : ℕ}
        (D : FreyTwoBoundaryInertiaData c),
        0 < c →
        Real.log (D.selectPrime (threshold δ)).ell ≤
          η * Real.log c + C :=
  exists_uniform_selectedPrime_log_bound (threshold δ) hη

end FreyTwoBoundaryInertiaData

end IUTThreeClosures
