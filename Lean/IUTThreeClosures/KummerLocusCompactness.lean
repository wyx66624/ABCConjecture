/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.KummerRootNormBounds
import Mathlib.Topology.MetricSpace.ProperSpace

/-!
# Compactness of bounded Kummer loci

Let `B` be a compact set and let `f : X → K` be continuous.  If `‖f(x)‖` is
uniformly bounded above on `B`, then the locus

`{(x,y) | x ∈ B, y^(n+1)=f(x)}`

is compact whenever closed balls in `K` are compact.  Indeed every root lies
in the fixed ball of radius `max 1 M`, by `KummerRootNormBounds`; inside the
compact product of `B` with that ball, the Kummer equation is a closed
condition.

For the actual theta-root strip, the remaining analytic inputs are therefore:
compactness of the base annulus, continuity of the theta product, and a uniform
upper bound on its norm. Nonvanishing supplies the stronger lower annulus bound
but is not needed for compactness of the equation locus in `K`.
-/

namespace IUTThreeClosures

open Set Metric

universe u v

variable {X : Type u} {K : Type v}
variable [TopologicalSpace X]
variable [NormedField K] [ProperSpace K]

/-- The Kummer equation locus over a prescribed base set. -/
def kummerLocus
    (B : Set X) (f : X → K) (n : ℕ) : Set (X × K) :=
  {p | p.1 ∈ B ∧ p.2 ^ (n + 1) = f p.1}

/-- The equation part of the Kummer locus is closed for a continuous right-hand
side. -/
theorem isClosed_kummerEquation
    {f : X → K} (hf : Continuous f) (n : ℕ) :
    IsClosed {p : X × K | p.2 ^ (n + 1) = f p.1} := by
  exact isClosed_eq
    (continuous_snd.pow (n + 1))
    (hf.comp continuous_fst)

/-- Uniform upper bounds on the right-hand side put all Kummer roots in one
fixed closed ball. -/
theorem kummerLocus_subset_product_closedBall
    {B : Set X} {f : X → K} {M : ℝ} {n : ℕ}
    (hupper : ∀ x ∈ B, ‖f x‖ ≤ M) :
    kummerLocus B f n ⊆
      B ×ˢ closedBall (0 : K) (max 1 M) := by
  rintro ⟨x, y⟩ ⟨hx, hy⟩
  refine ⟨hx, ?_⟩
  rw [mem_closedBall, dist_zero_right]
  apply le_max_one_of_pow_succ_le (norm_nonneg y)
  rw [← norm_pow, hy]
  exact hupper x hx

/-- The Kummer locus is exactly the intersection of its compact bounding
product with the closed equation set. -/
theorem kummerLocus_eq_bounded_inter
    {B : Set X} {f : X → K} {M : ℝ} {n : ℕ}
    (hupper : ∀ x ∈ B, ‖f x‖ ≤ M) :
    kummerLocus B f n =
      (B ×ˢ closedBall (0 : K) (max 1 M)) ∩
        {p : X × K | p.2 ^ (n + 1) = f p.1} := by
  ext p
  constructor
  · intro hp
    exact ⟨kummerLocus_subset_product_closedBall hupper hp, hp.2⟩
  · rintro ⟨hpBound, hpEq⟩
    exact ⟨hpBound.1, hpEq⟩

/-- **Compact Kummer-locus theorem.** -/
theorem isCompact_kummerLocus
    {B : Set X} {f : X → K} {M : ℝ} {n : ℕ}
    (hB : IsCompact B)
    (hf : Continuous f)
    (hupper : ∀ x ∈ B, ‖f x‖ ≤ M) :
    IsCompact (kummerLocus B f n) := by
  rw [kummerLocus_eq_bounded_inter hupper]
  have hproduct :
      IsCompact (B ×ˢ closedBall (0 : K) (max 1 M)) :=
    hB.prod isCompact_closedBall
  exact hproduct.inter_right (isClosed_kummerEquation hf n)

end IUTThreeClosures
