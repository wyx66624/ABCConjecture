/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Pointwise source decay does not imply uniform decay

The relative-source-term route to ABC needs one source index that works for
all abc points at once.  It is therefore not enough to prove that, for each
fixed point, its source defect tends to zero along the admissible-prime
sequence.

The diagonal family below is the exact obstruction.  For every fixed point
`p`, the defect is eventually zero, but at every source index `n` the point
`p = n` still has defect one.  Thus no uniform half-bound exists.

This counterexample does not rule out the asymptotic route.  It proves that the
required convergence theorem must be uniform in the abc input, or must provide
explicit point-independent scalar majorants.
-/

namespace IUTThreeClosures

open Filter
open scoped Topology

/-- The diagonal defect: source index `n` fails only at input `p = n`. -/
def diagonalSourceDefect (n p : ℕ) : ℝ :=
  if n = p then 1 else 0

/-- For every fixed input, the diagonal defect tends to zero. -/
theorem diagonalSourceDefect_pointwise_tendsto (p : ℕ) :
    Tendsto (fun n : ℕ => diagonalSourceDefect n p) atTop (𝓝 0) := by
  refine (tendsto_congr' ?_).mpr tendsto_const_nhds
  refine Filter.eventually_atTop.2 ⟨p + 1, ?_⟩
  intro n hn
  have hne : n ≠ p := by omega
  simp [diagonalSourceDefect, hne]

/-- Nevertheless no single tail makes the defects uniformly at most one half
for all inputs. -/
theorem diagonalSourceDefect_not_uniform_half :
    ¬ ∃ N : ℕ,
      ∀ n : ℕ, N ≤ n →
        ∀ p : ℕ, diagonalSourceDefect n p ≤ (1 : ℝ) / 2 := by
  rintro ⟨N, hN⟩
  have h := hN N le_rfl N
  norm_num [diagonalSourceDefect] at h

/-- Hence pointwise convergence alone cannot imply the simultaneous uniform
smallness condition consumed by the relative-absorption theorem. -/
theorem no_pointwise_to_uniform_decay_principle :
    ¬ (∀ f : ℕ → ℕ → ℝ,
      (∀ p, Tendsto (fun n => f n p) atTop (𝓝 0)) →
      ∃ N : ℕ,
        ∀ n : ℕ, N ≤ n →
          ∀ p : ℕ, f n p ≤ (1 : ℝ) / 2) := by
  intro h
  rcases h diagonalSourceDefect
      diagonalSourceDefect_pointwise_tendsto with ⟨N, hN⟩
  exact diagonalSourceDefect_not_uniform_half ⟨N, hN⟩

end IUTThreeClosures
