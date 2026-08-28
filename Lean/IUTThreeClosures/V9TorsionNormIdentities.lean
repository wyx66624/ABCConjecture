/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.V9TorsionIncidenceCore

/-!
# Nonlinear invariants of the Tate-line score vector

The complete projective orbit has zero linear average, but its oscillation and
Euclidean energy retain the Tate weight.  This module formalizes the scalar
identities underlying the nonlinear, Galois-invariant torsion-packet route.
-/

namespace IUTThreeClosures

/-- Difference between the canonical and noncanonical local coefficients. -/
theorem tateLineCoefficient_oscillation
    {ell : ℝ} (hell : ell ≠ 0) :
    tateCanonicalLineCoefficient ell -
        tateNoncanonicalLineCoefficient ell =
      ((ell - 1) * (ell + 1)) / (12 * ell) := by
  unfold tateCanonicalLineCoefficient tateNoncanonicalLineCoefficient
  field_simp [hell]
  ring

/-- Squared Euclidean norm of a score vector with one canonical and `ell`
noncanonical coordinates. -/
theorem tateLineCoefficient_energy
    {ell : ℝ} (hell : ell ≠ 0) :
    tateCanonicalLineCoefficient ell ^ 2 +
        ell * tateNoncanonicalLineCoefficient ell ^ 2 =
      ((ell - 1) ^ 2 * (ell + 1)) / (144 * ell) := by
  unfold tateCanonicalLineCoefficient tateNoncanonicalLineCoefficient
  field_simp [hell]
  ring

/-- For `ell > 1`, the canonical coefficient is positive. -/
theorem tateCanonicalLineCoefficient_pos
    {ell : ℝ} (hell : 1 < ell) :
    0 < tateCanonicalLineCoefficient ell := by
  unfold tateCanonicalLineCoefficient
  positivity

/-- For `ell > 1`, the noncanonical coefficient is negative. -/
theorem tateNoncanonicalLineCoefficient_neg
    {ell : ℝ} (hell : 1 < ell) :
    tateNoncanonicalLineCoefficient ell < 0 := by
  unfold tateNoncanonicalLineCoefficient
  have hellPos : 0 < ell := by linarith
  have hnum : 0 < ell - 1 := by linarith
  have hquot : 0 < (ell - 1) / (12 * ell) := by positivity
  linarith

/-- Multiplying by a positive Tate weight preserves the canonical/noncanonical
ordering. -/
theorem tateScore_canonical_gt_noncanonical
    {ell L : ℝ} (hell : 1 < ell) (hL : 0 < L) :
    tateNoncanonicalLineCoefficient ell * L <
      tateCanonicalLineCoefficient ell * L := by
  have hcoeff :
      tateNoncanonicalLineCoefficient ell <
        tateCanonicalLineCoefficient ell := by
    linarith [tateCanonicalLineCoefficient_pos hell,
      tateNoncanonicalLineCoefficient_neg hell]
  exact mul_lt_mul_of_pos_right hcoeff hL

end IUTThreeClosures
