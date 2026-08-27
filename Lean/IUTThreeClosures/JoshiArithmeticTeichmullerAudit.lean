/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

/-!
# Elementary certificates for the Joshi arithmetic-Teichmuller audit

This file formalizes only the elementary algebra and sign checks used in the
audit of arXiv:2401.13508v4 and arXiv:2403.10430v2.  It does not formalize the
papers' arithmetic-Teichmuller constructions and does not assert `abc`.

The three checks are:

* the pure-tensor rule is not additive, already after identifying
  `ℚ ⊗_ℚ ℚ` with `ℚ`;
* a Tate parameter of real norm strictly between zero and one has negative
  logarithm;
* a positive normalized divisor degree cannot equal a negative local-log sum,
  and a nonpositive `-|logVolume| / ellStar` cannot dominate a positive
  right-hand side.
-/

namespace IUTThreeClosures
namespace JoshiArithmeticTeichmullerAudit

/-- The scalar model of `(x, y) ↦ x ⊗ y` under the canonical identification
`ℚ ⊗_ℚ ℚ ≃ ℚ`. -/
def pureTensorScalar (x : ℚ × ℚ) : ℚ := x.1 * x.2

/-- The pure-tensor rule from a product is not an additive map.  This is the
two-factor counterexample to the "natural homomorphism of `ℚ_p`-vector
spaces" asserted on page 120 of arXiv:2401.13508v4. -/
theorem pureTensorScalar_not_additive :
    ¬ ∀ x y : ℚ × ℚ,
      pureTensorScalar (x + y) =
        pureTensorScalar x + pureTensorScalar y := by
  intro h
  have hbad := h (1, 0) (0, 1)
  norm_num [pureTensorScalar] at hbad

/-- A normalized Tate parameter has negative logarithmic norm. -/
theorem tateParameter_log_neg
    {qNorm : ℝ} (hqPos : 0 < qNorm) (hqLtOne : qNorm < 1) :
    Real.log qNorm < 0 :=
  Real.log_neg hqPos hqLtOne

/-- A positive normalized Tate-divisor degree cannot be identified with a
strictly negative sum of logarithmic local norms.  This isolates the sign
conflict in equation (6.11.7) on page 71 of arXiv:2403.10430v2. -/
theorem positive_degree_ne_negative_localLogSum
    (ell qDegree localLogSum : ℝ)
    (hell : 0 < ell) (hqDegree : 0 < qDegree)
    (hlocal : localLogSum < 0) :
    qDegree / (2 * ell) ≠ localLogSum := by
  have hden : 0 < 2 * ell := mul_pos (by norm_num) hell
  have hlhs : 0 < qDegree / (2 * ell) := div_pos hqDegree hden
  linarith

/-- The displayed sign in Corollary 9.11.1.1 on page 128 of
arXiv:2401.13508v4 is impossible when its right-hand side is positive:
`-|logVolume| / ellStar` is always nonpositive. -/
theorem corollary_9_11_1_1_sign_impossible
    (ellStar logVolume rhs : ℝ)
    (hellStar : 0 < ellStar) (hrhs : 0 < rhs) :
    ¬ rhs ≤ -(abs logVolume) / ellStar := by
  intro hdisplayed
  have hnonpos : -(abs logVolume) / ellStar ≤ 0 :=
    div_nonpos_of_nonpos_of_nonneg
      (neg_nonpos.mpr (abs_nonneg logVolume)) hellStar.le
  linarith

end JoshiArithmeticTeichmullerAudit
end IUTThreeClosures
