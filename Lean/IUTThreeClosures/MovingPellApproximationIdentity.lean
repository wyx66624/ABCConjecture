/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCPointSquarefreePellWitness
import Mathlib.Tactic

/-!
# Exact approximation identities behind the moving Pell equation

For

`m + u*x^2 = v*y^2`

with positive `u` and `y`, the associated rational-square approximation is
not merely asymptotic.  It satisfies the exact identity

`v/u - (x/y)^2 = m/(u*y^2)`.

After multiplying by `u/v`, the relative approximation error is exactly the
relative additive gap:

`(u/v) * (v/u - (x/y)^2) = m/(v*y^2)`.

For an abc squarefree Pell witness, `v*y^2=c` and `m=min(a,b)`, so this is
precisely

`(u/v) * error = min(a,b)/c`.

Thus the ordinary real approximation gain contains no hidden saving beyond
the relative abc gap.  Any closure must use the restricted prime support or a
genuinely uniform moving-field theorem, rather than the metric approximation
identity alone.
-/

namespace IUTThreeClosures
namespace MovingPellApproximationIdentity

noncomputable section

/-- Exact rational-square approximation supplied by a moving Pell equation. -/
theorem rational_square_gap_identity
    {m u v x y : ℕ}
    (hu : 0 < u) (hy : 0 < y)
    (hgap : m + u * x ^ 2 = v * y ^ 2) :
    (v : ℚ) / (u : ℚ) - ((x : ℚ) / (y : ℚ)) ^ 2 =
      (m : ℚ) / ((u : ℚ) * (y : ℚ) ^ 2) := by
  have hu0 : (u : ℚ) ≠ 0 := by exact_mod_cast hu.ne'
  have hy0 : (y : ℚ) ≠ 0 := by exact_mod_cast hy.ne'
  have hgapQ :
      (m : ℚ) + (u : ℚ) * (x : ℚ) ^ 2 =
        (v : ℚ) * (y : ℚ) ^ 2 := by
    exact_mod_cast hgap
  field_simp [hu0, hy0]
  nlinarith

/-- Source-scale form: the scaled approximation error is exactly the gap
relative to the large endpoint `v*y^2`. -/
theorem relative_gap_eq_scaled_square_error
    {m u v x y : ℕ}
    (hu : 0 < u) (hv : 0 < v) (hy : 0 < y)
    (hgap : m + u * x ^ 2 = v * y ^ 2) :
    (m : ℚ) / ((v : ℚ) * (y : ℚ) ^ 2) =
      ((u : ℚ) / (v : ℚ)) *
        ((v : ℚ) / (u : ℚ) - ((x : ℚ) / (y : ℚ)) ^ 2) := by
  have hu0 : (u : ℚ) ≠ 0 := by exact_mod_cast hu.ne'
  have hv0 : (v : ℚ) ≠ 0 := by exact_mod_cast hv.ne'
  have hy0 : (y : ℚ) ≠ 0 := by exact_mod_cast hy.ne'
  rw [rational_square_gap_identity hu hy hgap]
  field_simp [hu0, hv0, hy0]

/-- Clearing denominators shows that the integer numerator of the
approximation error is exactly the additive gap. -/
theorem denominator_sq_mul_square_error_eq_gap
    {m u v x y : ℕ}
    (hu : 0 < u) (hy : 0 < y)
    (hgap : m + u * x ^ 2 = v * y ^ 2) :
    ((u : ℚ) * (y : ℚ) ^ 2) *
        ((v : ℚ) / (u : ℚ) - ((x : ℚ) / (y : ℚ)) ^ 2) =
      (m : ℚ) := by
  have hu0 : (u : ℚ) ≠ 0 := by exact_mod_cast hu.ne'
  have hy0 : (y : ℚ) ≠ 0 := by exact_mod_cast hy.ne'
  rw [rational_square_gap_identity hu hy hgap]
  field_simp [hu0, hy0]

namespace ABCPoint

/-- Specialization to the concrete squarefree witness of an abc point. -/
theorem SquarefreePellWitness.relative_gap_identity
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    ((W.w * W.z ^ 2 : ℕ) : ℚ) /
        (((W.v : ℚ) * (W.y : ℚ) ^ 2)) =
      ((W.u : ℚ) / (W.v : ℚ)) *
        ((W.v : ℚ) / (W.u : ℚ) -
          ((W.x : ℚ) / (W.y : ℚ)) ^ 2) := by
  exact relative_gap_eq_scaled_square_error
    W.u_pos W.v_pos W.y_pos W.conic_eq

/-- The same identity written directly with the ordered abc endpoints. -/
theorem SquarefreePellWitness.endpoint_ratio_eq_scaled_square_error
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    (P.endpointMin : ℚ) / (P.c : ℚ) =
      ((W.u : ℚ) / (W.v : ℚ)) *
        ((W.v : ℚ) / (W.u : ℚ) -
          ((W.x : ℚ) / (W.y : ℚ)) ^ 2) := by
  rw [W.small_eq, W.c_eq]
  exact W.relative_gap_identity

end ABCPoint

#print axioms rational_square_gap_identity
#print axioms relative_gap_eq_scaled_square_error
#print axioms denominator_sq_mul_square_error_eq_gap
#print axioms ABCPoint.SquarefreePellWitness.relative_gap_identity
#print axioms ABCPoint.SquarefreePellWitness.endpoint_ratio_eq_scaled_square_error

end
end MovingPellApproximationIdentity
end IUTThreeClosures
