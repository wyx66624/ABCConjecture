/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TwoInertiaSublinearHeight

/-!
# Two inertia parameters with a common linear height bound

The actual Picard--Lefschetz parameter may be a fixed multiple of a local
valuation.  Thus the natural quantitative hypothesis is

`m₁ ≤ L*h`, `m₂ ≤ L*h`,

where `h` is the logarithmic abc height and `L` is point-independent.
The Euclidean selector then gives

`ell ≤ 1 + B! * L^2 * h^2`.

Its logarithm is still bounded by `eta*h + O(B,L,eta)` for every positive
`eta`.  This is the form directly consumed by the actual odd and two-adic
candidate inertia exponents.
-/

namespace IUTThreeClosures

/-- Quadratic upper bound from two common linear height estimates. -/
theorem twoInertiaPrime_le_of_linear_height
    {B m₁ m₂ : ℕ}
    (D : TwoInertiaPrimeData B m₁ m₂)
    {L h : ℝ}
    (hL : 0 ≤ L) (hh : 0 ≤ h)
    (hm₁ : (m₁ : ℝ) ≤ L * h)
    (hm₂ : (m₂ : ℝ) ≤ L * h) :
    (D.ell : ℝ) ≤
      1 + (B.factorial : ℝ) * L ^ 2 * h ^ 2 := by
  have hprod :
      (m₁ : ℝ) * (m₂ : ℝ) ≤ (L * h) ^ 2 := by
    have hLh : 0 ≤ L * h := mul_nonneg hL hh
    have hmul := mul_le_mul hm₁ hm₂ (by positivity) hLh
    simpa [pow_two] using hmul
  have hraw :
      (D.ell : ℝ) ≤
        (B.factorial : ℝ) * ((m₁ : ℝ) * (m₂ : ℝ)) + 1 := by
    exact_mod_cast D.explicit_upper_bound
  have hfac : (0 : ℝ) ≤ B.factorial := by positivity
  have hscaled := mul_le_mul_of_nonneg_left hprod hfac
  calc
    (D.ell : ℝ) ≤
        (B.factorial : ℝ) * ((m₁ : ℝ) * (m₂ : ℝ)) + 1 := hraw
    _ ≤ (B.factorial : ℝ) * (L * h) ^ 2 + 1 := by linarith
    _ = 1 + (B.factorial : ℝ) * L ^ 2 * h ^ 2 := by ring

/-- **General sublinear theorem.**  Two actual inertia parameters bounded
linearly by one logarithmic height yield a selected prime with arbitrarily
small logarithmic height slope. -/
theorem twoInertiaPrime_log_sublinear_of_linear_height
    {B m₁ m₂ : ℕ}
    (D : TwoInertiaPrimeData B m₁ m₂)
    {L h η : ℝ}
    (hL : 0 ≤ L) (hh : 0 ≤ h)
    (hm₁ : (m₁ : ℝ) ≤ L * h)
    (hm₂ : (m₂ : ℝ) ≤ L * h)
    (hη : 0 < η) :
    ∃ C : ℝ, Real.log D.ell ≤ η * h + C := by
  let A : ℝ := (B.factorial : ℝ) * L ^ 2
  have hA : 0 ≤ A := by
    dsimp [A]
    positivity
  rcases log_one_add_mul_sq_sublinear hA hη with ⟨C, hC⟩
  refine ⟨C, ?_⟩
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

end IUTThreeClosures
