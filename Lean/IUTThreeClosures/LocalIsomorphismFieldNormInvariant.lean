/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateParameterPowerRegions
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic.Ring

/-!
# Local isomorphisms preserve the normalized field-norm radius

For a finite extension `K/F`, multiplication by `σ(x)` is conjugate to
multiplication by `x` whenever `σ` is an `F`-automorphism.  Hence their
matrices have the same determinant, so the algebraic field norm is invariant.
The normalized nonarchimedean absolute value is obtained from the absolute
value of this determinant by the fixed degree root; it is therefore invariant
as well.

This module kernel-formalizes the finite-dimensional determinant argument and
its exact normalized-radius consequence.  The final theorem records the
corresponding invariance of Tate-power principal regions: replacing a Tate
parameter by any nonzero scalar of the same norm leaves every normalized
power region unchanged.

The result supplies the radial theorem needed for the local `Ism` actions that
occur fiberwise in IUT III, Theorem 3.11(i).  It does not identify the full
source `Ism` object with a particular matrix representation and does not assert
an IUT IV or abc inequality.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open TateCurvesTheta
open scoped Pointwise

universe u v w

namespace LocalIsomorphismFieldNormInvariant

variable {n : Type u} [Fintype n] [DecidableEq n]
variable {F : Type v} [CommRing F]
variable {K : Type w}

/-- Determinant is invariant under a matrix conjugacy represented by a pair of
mutually inverse matrices.  Only the displayed right-inverse identity is
needed for the determinant calculation. -/
theorem det_conjugate_of_mul_eq_one
    (P Q A : Matrix n n F)
    (hPQ : P * Q = 1) :
    Matrix.det (P * A * Q) = Matrix.det A := by
  rw [Matrix.det_mul, Matrix.det_mul]
  have hdet : Matrix.det P * Matrix.det Q = 1 := by
    calc
      Matrix.det P * Matrix.det Q = Matrix.det (P * Q) := by
        rw [Matrix.det_mul]
      _ = 1 := by rw [hPQ, Matrix.det_one]
  calc
    Matrix.det P * Matrix.det A * Matrix.det Q =
        Matrix.det A * (Matrix.det P * Matrix.det Q) := by ring
    _ = Matrix.det A := by rw [hdet, mul_one]

/-- Matrix form of invariance of the finite-extension field norm.  If the
multiplication matrix of `σ(x)` is conjugate to the multiplication matrix of
`x`, their determinants agree. -/
theorem determinant_invariant_of_multiplication_conjugacy
    (mulMatrix : K → Matrix n n F)
    (σ : K → K)
    (P Q : Matrix n n F)
    (hPQ : P * Q = 1)
    (hconj : ∀ x : K,
      mulMatrix (σ x) = P * mulMatrix x * Q)
    (x : K) :
    Matrix.det (mulMatrix (σ x)) =
      Matrix.det (mulMatrix x) := by
  rw [hconj x]
  exact det_conjugate_of_mul_eq_one P Q (mulMatrix x) hPQ

/-- Radius obtained from the absolute value of the determinant field norm by
taking the fixed degree root. -/
noncomputable def normalizedDeterminantRadius
    (absBase : F → ℝ)
    (mulMatrix : K → Matrix n n F)
    (degree : ℕ)
    (x : K) : ℝ :=
  Real.rpow (absBase (Matrix.det (mulMatrix x)))
    (1 / (degree : ℝ))

/-- The normalized determinant radius is invariant under multiplication-
matrix conjugacy. -/
theorem normalizedDeterminantRadius_invariant
    (absBase : F → ℝ)
    (mulMatrix : K → Matrix n n F)
    (degree : ℕ)
    (σ : K → K)
    (P Q : Matrix n n F)
    (hPQ : P * Q = 1)
    (hconj : ∀ x : K,
      mulMatrix (σ x) = P * mulMatrix x * Q)
    (x : K) :
    normalizedDeterminantRadius absBase mulMatrix degree (σ x) =
      normalizedDeterminantRadius absBase mulMatrix degree x := by
  unfold normalizedDeterminantRadius
  rw [determinant_invariant_of_multiplication_conjugacy
    mulMatrix σ P Q hPQ hconj x]

variable {L : Type v} [NormedField L]

/-- Any nonzero scalar with the same norm as a Tate parameter generates the
same normalized power region in every exponent.  This is the exact radial
consequence of local-field isometry. -/
theorem scaledPowerRegion_eq_qPowerRegion_of_norm_eq
    (t : TateParameter L)
    (q' : L)
    (hq' : q' ≠ 0)
    (hnorm : ‖q'‖ = ‖(t.q : L)‖)
    (m : ℕ) :
    scaledRegion (q' ^ m) (normIntegralRegion (K := L)) =
      t.qPowerRegion m := by
  unfold TateParameter.qPowerRegion
  apply scaledRegion_eq_of_norm_eq
  · exact pow_ne_zero _ hq'
  · simp only [norm_pow, hnorm]

/-- A norm-preserving local self-map sends the distinguished Tate scalar to a
scalar defining exactly the same radial power regions. -/
theorem localIsomorphism_preserves_qPowerRegion
    (t : TateParameter L)
    (σ : L → L)
    (hσzero : σ (t.q : L) ≠ 0)
    (hσnorm : ‖σ (t.q : L)‖ = ‖(t.q : L)‖)
    (m : ℕ) :
    scaledRegion ((σ (t.q : L)) ^ m)
        (normIntegralRegion (K := L)) =
      t.qPowerRegion m := by
  exact scaledPowerRegion_eq_qPowerRegion_of_norm_eq
    t (σ (t.q : L)) hσzero hσnorm m

#print axioms det_conjugate_of_mul_eq_one
#print axioms determinant_invariant_of_multiplication_conjugacy
#print axioms normalizedDeterminantRadius_invariant
#print axioms scaledPowerRegion_eq_qPowerRegion_of_norm_eq
#print axioms localIsomorphism_preserves_qPowerRegion

end LocalIsomorphismFieldNormInvariant

end IUTThreeClosures
