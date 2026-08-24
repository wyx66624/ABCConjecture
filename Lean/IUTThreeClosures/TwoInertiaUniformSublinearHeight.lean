/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TwoInertiaLinearHeight

/-!
# Uniform sublinear growth of two-inertia auxiliary primes

The additive constant required by the abc conjecture must be chosen before the
abc triple.  The explicit Euclidean bound permits exactly this quantifier
order: one constant depending only on `B`, `L`, and `eta` works for every pair
of local exponents and every height.
-/

namespace IUTThreeClosures

/-- The additive constant is independent of the local exponents, selected
prime, height, and abc input. -/
theorem exists_uniform_twoInertiaPrime_log_bound
    (B : ℕ)
    {L η : ℝ}
    (hL : 0 ≤ L)
    (hη : 0 < η) :
    ∃ C : ℝ,
      ∀ {m₁ m₂ : ℕ}
        (D : TwoInertiaPrimeData B m₁ m₂)
        {h : ℝ},
        0 ≤ h →
        (m₁ : ℝ) ≤ L * h →
        (m₂ : ℝ) ≤ L * h →
        Real.log D.ell ≤ η * h + C := by
  let A : ℝ := (B.factorial : ℝ) * L ^ 2
  have hA : 0 ≤ A := by
    dsimp [A]
    positivity
  rcases log_one_add_mul_sq_sublinear hA hη with ⟨C, hC⟩
  refine ⟨C, ?_⟩
  intro m₁ m₂ D h hh hm₁ hm₂
  have hEll : (D.ell : ℝ) ≤ 1 + A * h ^ 2 := by
    dsimp [A]
    exact twoInertiaPrime_le_of_linear_height
      D hL hh hm₁ hm₂
  have hEllPos : (0 : ℝ) < D.ell := by
    exact_mod_cast D.ell_prime.pos
  have hRightPos : 0 < 1 + A * h ^ 2 := by positivity
  have hlogEll :
      Real.log D.ell ≤ Real.log (1 + A * h ^ 2) :=
    Real.strictMonoOn_log.monotoneOn hEllPos hRightPos hEll
  exact hlogEll.trans (hC h hh)

/-- Uniform specialization to the common Frey candidate coefficient. -/
theorem exists_uniform_freyCandidatePrime_log_bound
    (B : ℕ)
    {η : ℝ} (hη : 0 < η) :
    ∃ C : ℝ,
      ∀ {m₁ m₂ : ℕ}
        (D : TwoInertiaPrimeData B m₁ m₂)
        {h : ℝ},
        0 ≤ h →
        (m₁ : ℝ) ≤ freyInertiaHeightCoefficient * h →
        (m₂ : ℝ) ≤ freyInertiaHeightCoefficient * h →
        Real.log D.ell ≤ η * h + C :=
  exists_uniform_twoInertiaPrime_log_bound
    B freyInertiaHeightCoefficient_pos.le hη

end IUTThreeClosures
