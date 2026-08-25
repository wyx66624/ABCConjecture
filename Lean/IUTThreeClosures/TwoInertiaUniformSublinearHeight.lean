/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TwoInertiaLinearHeight

/-!
# Uniform sublinear growth of two-inertia auxiliary primes

For the abc conjecture, the additive constant must be chosen before the abc
triple.  A pointwise statement

`forall P, exists C_P, log ell(P) <= eta*h(P)+C_P`

is therefore insufficient.  The Euclidean two-inertia selector admits the
stronger quantifier order because its explicit upper bound depends only on the
fixed threshold `B`, the common linear coefficient `L`, and the height `h`.

This module proves

`exists C(B,L,eta), forall m1 m2 D h, ...`.

The constant is obtained once from the sublinearity of
`log(1 + B!*L^2*h^2)` and is independent of the selected exponents, prime, and
abc point.
-/

namespace IUTThreeClosures

/-- **Uniform two-inertia logarithmic prime bound.**  The additive constant is
chosen before all local exponents and all heights. -/
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

/-- Uniform specialization to the common Frey candidate coefficient
`2/log 2`. -/
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
