/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Extracting a low-statistic element from a tilted finite sum

Let `stat : α → ℕ` be a nonnegative arithmetic statistic, for example the
number of distinct prime factors.  If a weight is no larger above a threshold
`w` than it is at `w`, then a tilted sum strictly exceeding the value obtained
by putting every element at the threshold forces at least one element with
`stat < w`.

For the smooth-neighbour route, one may take

`stat n = n.primeFactors.card`

and use a decreasing weight such as `exp (-t * stat n)`.  The hard analytic
input then becomes a lower bound for the local tilted sum.  The extraction
step in this file is unconditional.
-/

namespace IUTThreeClosures
namespace TiltedStatisticExtraction

open scoped BigOperators

/-- A strict tilted first-moment lower bound forces an element below the
chosen statistic threshold. -/
theorem exists_stat_lt_of_tilted_sum
    {α : Type*} [DecidableEq α]
    (s : Finset α)
    (stat : α → ℕ)
    (weight : ℕ → ℝ)
    (w : ℕ)
    (hweight : ∀ m : ℕ, w ≤ m → weight m ≤ weight w)
    (hsum :
      (s.card : ℝ) * weight w <
        ∑ x ∈ s, weight (stat x)) :
    ∃ x ∈ s, stat x < w := by
  classical
  by_contra hgood
  have hstat : ∀ x ∈ s, w ≤ stat x := by
    intro x hx
    by_contra hlt
    apply hgood
    refine ⟨x, hx, ?_⟩
    omega
  have hpoint : ∀ x ∈ s, weight (stat x) ≤ weight w := by
    intro x hx
    exact hweight (stat x) (hstat x hx)
  have hle :
      (∑ x ∈ s, weight (stat x)) ≤
        ∑ x ∈ s, weight w := by
    exact Finset.sum_le_sum fun x hx => hpoint x hx
  have hconst :
      (∑ x ∈ s, weight w) = (s.card : ℝ) * weight w := by
    simp [mul_comm]
  rw [hconst] at hle
  exact (not_lt_of_ge hle) hsum

/-- Exponential tilting is decreasing in a natural-valued statistic when the
tilt parameter is nonnegative. -/
theorem exponential_tilt_antitone_at
    (t : ℝ) (ht : 0 ≤ t) (w m : ℕ) (hwm : w ≤ m) :
    Real.exp (-t * (m : ℝ)) ≤ Real.exp (-t * (w : ℝ)) := by
  apply Real.exp_le_exp.mpr
  have hcast : (w : ℝ) ≤ (m : ℝ) := by exact_mod_cast hwm
  nlinarith

/-- Concrete extraction theorem for the exponential tilt
`exp (-t * stat)`. -/
theorem exists_stat_lt_of_exponential_tilt
    {α : Type*} [DecidableEq α]
    (s : Finset α)
    (stat : α → ℕ)
    (t : ℝ) (ht : 0 ≤ t)
    (w : ℕ)
    (hsum :
      (s.card : ℝ) * Real.exp (-t * (w : ℝ)) <
        ∑ x ∈ s, Real.exp (-t * (stat x : ℝ))) :
    ∃ x ∈ s, stat x < w := by
  apply exists_stat_lt_of_tilted_sum
    s stat (fun m => Real.exp (-t * (m : ℝ))) w
  · intro m hwm
    exact exponential_tilt_antitone_at t ht w m hwm
  · simpa using hsum

#print axioms exists_stat_lt_of_tilted_sum
#print axioms exponential_tilt_antitone_at
#print axioms exists_stat_lt_of_exponential_tilt

end TiltedStatisticExtraction
end IUTThreeClosures
