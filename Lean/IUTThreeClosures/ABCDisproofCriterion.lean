/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.NonCircularDownstream

/-!
# A quantifier-correct criterion for disproving abc

For one fixed positive `epsilon`, the logarithmic abc conjecture asserts the
existence of one additive constant valid for every primitive positive triple.
Consequently, to disprove abc it is enough—and necessary in this formulation—
to construct primitive triples whose excess

`height - (1 + epsilon) * conductor`

is unbounded above.

This elementary logical theorem is the final target of every constructive
disproof route, including the smooth-neighbour strategy.  It does not assert
that such a family exists.
-/

namespace IUTThreeClosures

/-- If one fixed positive exponent admits primitive abc points with arbitrarily
large logarithmic excess, then the abc conjecture is false. -/
theorem not_abc_of_unbounded_excess
    {ε : ℝ}
    (hε : 0 < ε)
    (hUnbounded :
      ∀ C : ℝ, ∃ P : ABCPoint,
        (1 + ε) * P.conductor + C < P.height) :
    ¬ ABCConjecture := by
  intro habc
  rcases habc ε hε with ⟨C, hC⟩
  rcases hUnbounded C with ⟨P, hP⟩
  have hBound :
      P.height ≤ (1 + ε) * P.conductor + C := by
    simpa [ABCPoint.height, ABCPoint.conductor] using
      hC P.a P.b P.c P.a_pos P.b_pos P.c_pos P.sum_eq
        P.pairwise_coprime
  exact (not_lt_of_ge hBound) hP

/-- Sequence form of `not_abc_of_unbounded_excess`: an excess larger than the
index at the `n`-th point is automatically unbounded. -/
theorem not_abc_of_violation_sequence
    {ε : ℝ}
    (hε : 0 < ε)
    (P : ℕ → ABCPoint)
    (hP : ∀ n : ℕ,
      (1 + ε) * (P n).conductor + n < (P n).height) :
    ¬ ABCConjecture := by
  apply not_abc_of_unbounded_excess hε
  intro C
  obtain ⟨n, hn⟩ := exists_nat_gt C
  refine ⟨P n, ?_⟩
  have hn' : C < (n : ℝ) := hn
  linarith [hP n]

end IUTThreeClosures
