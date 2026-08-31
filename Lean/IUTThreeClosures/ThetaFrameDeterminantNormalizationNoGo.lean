/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic

/-!
# Full theta-frame determinants do not create a normalized q-slope

Suppose a square theta-frame matrix is obtained from a phase/change-of-basis
matrix `Phi` by multiplying every source theta coordinate by its common local
coefficient.  In matrix form this is

`Phi * diagonal a`.

The determinant factors exactly as

`det (Phi * diagonal a) = det Phi * product_i a_i`.

The second factor is already the determinant of the source coefficient
lattice.  Consequently, after normalizing by that source determinant, the
entire coefficient/tropical order cancels and only the phase determinant
remains.  In particular, if the phase determinant has scale-independent
order, a full square frame determinant cannot supply a positive linear lower
slope in the Tate q-order.

This is an algebraic normalization obstruction only.  It does not rule out a
proper subdeterminant, a Harder--Narasimhan slope argument, or a nonlinear
adelic section whose source and target determinant lines have genuinely
different boundary weights.
-/

namespace IUTThreeClosures

open scoped BigOperators

noncomputable section

namespace ThetaFrameDeterminantNormalizationNoGo

universe u v

variable {ι : Type u} [Fintype ι] [DecidableEq ι]
variable {R : Type v} [CommRing R]

/-- A phase matrix followed by diagonal theta coefficients has determinant
`det Phi` times the complete source coefficient product. -/
theorem det_phase_mul_diagonal
    (Phi : Matrix ι ι R) (a : ι → R) :
    Matrix.det (Phi * Matrix.diagonal a) =
      Matrix.det Phi * ∏ i, a i := by
  rw [Matrix.det_mul, Matrix.det_diagonal]

/-- The same factorization when the diagonal coefficient matrix is written on
the left. -/
theorem det_diagonal_mul_phase
    (Phi : Matrix ι ι R) (a : ι → R) :
    Matrix.det (Matrix.diagonal a * Phi) =
      (∏ i, a i) * Matrix.det Phi := by
  rw [Matrix.det_mul, Matrix.det_diagonal]

/-- Scalar model for the order of a full frame determinant: source baseline
order plus phase-determinant order. -/
def rawFullFrameOrder (baselineOrder phaseOrder : ℝ) : ℝ :=
  baselineOrder + phaseOrder

/-- Normalizing a full frame determinant by the complete source determinant
cancels the whole baseline order exactly. -/
@[simp]
theorem normalizedFullFrameOrder_eq_phase
    (baselineOrder phaseOrder : ℝ) :
    rawFullFrameOrder baselineOrder phaseOrder - baselineOrder =
      phaseOrder := by
  unfold rawFullFrameOrder
  ring

/-- The normalized full-frame order is independent of the common coefficient
baseline. -/
theorem normalizedFullFrameOrder_independent_of_baseline
    (baselineOrder₁ baselineOrder₂ phaseOrder : ℝ) :
    rawFullFrameOrder baselineOrder₁ phaseOrder - baselineOrder₁ =
      rawFullFrameOrder baselineOrder₂ phaseOrder - baselineOrder₂ := by
  simp

/-- If the phase contribution is independent of a nonnegative scale `q`, then
no positive linear lower slope in `q` can hold uniformly after source
normalization. -/
theorem no_uniform_positive_slope_after_full_determinant_normalization
    (baselineOrder : ℝ → ℝ) {phaseOrder alpha C : ℝ}
    (halpha : 0 < alpha) :
    ¬ ∀ q : ℝ, 0 ≤ q →
        alpha * q + C ≤
          rawFullFrameOrder (baselineOrder q) phaseOrder -
            baselineOrder q := by
  intro h
  let q : ℝ := (|phaseOrder - C| + 1) / alpha
  have hq_nonneg : 0 ≤ q := by
    dsimp [q]
    positivity
  have hq := h q hq_nonneg
  have hconst : alpha * q + C ≤ phaseOrder := by
    simpa using hq
  have hmul : alpha * q = |phaseOrder - C| + 1 := by
    dsimp [q]
    field_simp [ne_of_gt halpha]
  rw [hmul] at hconst
  have habs : phaseOrder - C ≤ |phaseOrder - C| :=
    le_abs_self (phaseOrder - C)
  linarith

#print axioms det_phase_mul_diagonal
#print axioms det_diagonal_mul_phase
#print axioms normalizedFullFrameOrder_eq_phase
#print axioms normalizedFullFrameOrder_independent_of_baseline
#print axioms no_uniform_positive_slope_after_full_determinant_normalization

end ThetaFrameDeterminantNormalizationNoGo
end
end IUTThreeClosures
