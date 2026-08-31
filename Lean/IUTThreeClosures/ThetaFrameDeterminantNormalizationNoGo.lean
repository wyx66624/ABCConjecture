/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic

/-!
# Theta-frame determinants do not create a normalized q-slope

Suppose a square theta-frame matrix is obtained from a phase/change-of-basis
matrix `Phi` by multiplying every source theta coordinate by its local
coefficient.  In matrix form this is

`Phi * diagonal a`.

The determinant factors exactly as

`det (Phi * diagonal a) = det Phi * product_i a_i`.

The same statement holds for any fixed square row/column minor: scaling the
selected source columns contributes exactly the product of those selected
coefficients.  Consequently, after normalizing by the matching source
determinant or Pluecker coordinate, the entire coefficient/tropical order
cancels and only the phase minor remains.  If that phase contribution has
scale-independent order, neither a complete determinant nor a fixed-column
minor can supply a positive linear lower slope in the Tate q-order.

This is an algebraic normalization obstruction only.  It does not rule out a
comparison with a genuinely different source subspace, a Harder--Narasimhan
slope imbalance, or a nonlinear adelic section whose source and target lines
have different boundary weights.
-/

namespace IUTThreeClosures

open scoped BigOperators

noncomputable section

namespace ThetaFrameDeterminantNormalizationNoGo

universe u v w

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

/-- Any fixed square row/column minor has the same exact normalization
factorization: the selected source-column coefficients occur once each. -/
theorem det_selected_columns_scaled
    {κ : Type w} [Fintype κ] [DecidableEq κ]
    (Phi : Matrix ι ι R) (row column : κ → ι) (a : ι → R) :
    Matrix.det (fun i j =>
        Phi (row i) (column j) * a (column j)) =
      Matrix.det (Phi.submatrix row column) *
        ∏ j, a (column j) := by
  have hmatrix :
      (fun i j => Phi (row i) (column j) * a (column j)) =
        Phi.submatrix row column *
          Matrix.diagonal (fun j => a (column j)) := by
    ext i j
    change
      (fun k => Phi (row i) (column k)) ⬝ᵥ
          (fun k => Matrix.diagonal (fun t => a (column t)) k j) =
        Phi (row i) (column j) * a (column j)
    rw [dotProduct_diagonal']
  rw [hmatrix, Matrix.det_mul, Matrix.det_diagonal]

/-- Scalar model for the order of a full frame determinant or a fixed-column
minor: matching source baseline order plus phase-minor order. -/
def rawFrameOrder (baselineOrder phaseOrder : ℝ) : ℝ :=
  baselineOrder + phaseOrder

/-- Normalizing by the matching source determinant/Pluecker coordinate cancels
the whole baseline order exactly. -/
@[simp]
theorem normalizedFrameOrder_eq_phase
    (baselineOrder phaseOrder : ℝ) :
    rawFrameOrder baselineOrder phaseOrder - baselineOrder =
      phaseOrder := by
  unfold rawFrameOrder
  ring

/-- The normalized frame order is independent of the common coefficient
baseline. -/
theorem normalizedFrameOrder_independent_of_baseline
    (baselineOrder₁ baselineOrder₂ phaseOrder : ℝ) :
    rawFrameOrder baselineOrder₁ phaseOrder - baselineOrder₁ =
      rawFrameOrder baselineOrder₂ phaseOrder - baselineOrder₂ := by
  simp

/-- If the phase contribution is independent of a nonnegative scale `q`, then
no positive linear lower slope in `q` can hold uniformly after matching source
normalization. -/
theorem no_uniform_positive_slope_after_matching_normalization
    (baselineOrder : ℝ → ℝ) {phaseOrder alpha C : ℝ}
    (halpha : 0 < alpha) :
    ¬ ∀ q : ℝ, 0 ≤ q →
        alpha * q + C ≤
          rawFrameOrder (baselineOrder q) phaseOrder -
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
#print axioms det_selected_columns_scaled
#print axioms normalizedFrameOrder_eq_phase
#print axioms normalizedFrameOrder_independent_of_baseline
#print axioms no_uniform_positive_slope_after_matching_normalization

end ThetaFrameDeterminantNormalizationNoGo
end
end IUTThreeClosures
