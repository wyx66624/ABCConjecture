import IUTThreeClosures.FreyPellChebyshevUniformSelmerExactResidual

/-!
# Fixed elliptic reconstruction of the Chebyshev--Pell family: scalar kernel

This file verifies the rational-function identities used in the companion audit
`FREY_PELL_CHEBYSHEV_FIXED_ELLIPTIC_KUMMER_AUDIT.md`.

The fixed curves are

* `V^2 = U (U + 2) (2 U + 1)`, and
* after `X = 2 U`, `Y = 2 V`,
  `Y^2 = X (X + 1) (X + 4)`.

Only scalar identities over `ℚ` are formalized here.  In particular, this file
does not formalize elliptic-curve group schemes, the identification with
`X_0(24)`, cusp divisors, Kummer covers, Wohlfahrt's theorem, congruence or
noncongruence subgroups, quadratic twists, Mordell--Weil ranks, or any
rational-point classification.  It introduces no Diophantine closure axiom.
-/

namespace IUTThreeClosures

/-- The denominator-free Chebyshev relation puts `(U, yU)` on the first fixed
elliptic model. -/
theorem pellChebyshev_fixedElliptic_unscaled
    (U y : ℚ)
    (hCheb : y ^ 2 * U = 2 * U ^ 2 + 5 * U + 2) :
    (y * U) ^ 2 = U * (U + 2) * (2 * U + 1) := by
  nlinarith

/-- The scaling `(X,Y)=(2U,2V)` carries the first model to
`Y^2=X(X+1)(X+4)`. -/
theorem pellChebyshev_fixedElliptic_scale
    (U V : ℚ)
    (hCurve : V ^ 2 = U * (U + 2) * (2 * U + 1)) :
    (2 * V) ^ 2 = (2 * U) * (2 * U + 1) * (2 * U + 4) := by
  nlinarith

/-- The coordinate involution induced by `U -> U⁻¹` preserves the scaled fixed
elliptic equation. -/
theorem pellChebyshev_fixedElliptic_involution
    (X Y : ℚ)
    (hX : X ≠ 0)
    (hCurve : Y ^ 2 = X * (X + 1) * (X + 4)) :
    (4 * Y / X ^ 2) ^ 2 =
      (4 / X) * (4 / X + 1) * (4 / X + 4) := by
  field_simp [hX]
  nlinarith

/-- The chord through `Q=(0,0)` and `-P=(X,-Y)` has the `x`-coordinate
`4/X` prescribed by the involution.  This is the scalar group-law check for
`ι(P)=Q-P`. -/
theorem pellChebyshev_fixedElliptic_Q_sub_x
    (X Y : ℚ)
    (hX : X ≠ 0)
    (hCurve : Y ^ 2 = X * (X + 1) * (X + 4)) :
    (-Y / X) ^ 2 - 5 - X = 4 / X := by
  field_simp [hX]
  nlinarith

/-- The corresponding `y`-coordinate in the same chord computation is
`4Y/X^2`. -/
theorem pellChebyshev_fixedElliptic_Q_sub_y
    (X Y : ℚ)
    (hX : X ≠ 0) :
    (-Y / X) * (0 - 4 / X) = 4 * Y / X ^ 2 := by
  field_simp [hX]
  ring

/-- The rational point `H=(-2,-2)` lies on the fixed curve and its tangent
doubles to `Q=(0,0)`.  The three conjuncts respectively check membership,
tangent slope, and the resulting doubled coordinates. -/
theorem pellChebyshev_fixedElliptic_halfQ :
    ((-2 : ℚ) ^ 2 = (-2 : ℚ) * ((-2 : ℚ) + 1) * ((-2 : ℚ) + 4)) ∧
      ((3 * (-2 : ℚ) ^ 2 + 10 * (-2 : ℚ) + 4) /
          (2 * (-2 : ℚ)) = 1) ∧
      ((1 : ℚ) ^ 2 - 5 - 2 * (-2 : ℚ) = 0 ∧
        -(-2 : ℚ) + 1 * ((-2 : ℚ) - 0) = 0) := by
  norm_num

/-- Translating `(2U,2yU)` by `-H=(-2,2)` has rational `x`-coordinate
`-2(y+1)/(y-1)`. -/
theorem pellChebyshev_fixedElliptic_translate_x
    (U y : ℚ)
    (hU : U + 1 ≠ 0)
    (hy : y - 1 ≠ 0)
    (hCheb : y ^ 2 * U = 2 * U ^ 2 + 5 * U + 2) :
    ((y * U - 1) / (U + 1)) ^ 2 - 5 - 2 * U + 2 =
      -2 * (y + 1) / (y - 1) := by
  field_simp [hU, hy]
  linear_combination (U * (y - 1) - 2) * hCheb

/-- For `x=-2(y+1)/(y-1)`, the cubic on the fixed elliptic curve has the
factorization used by the four-consecutive-square twist. -/
theorem pellChebyshev_fixedElliptic_translated_cubic
    (y : ℚ)
    (hy : y - 1 ≠ 0) :
    let X := -2 * (y + 1) / (y - 1)
    X * (X + 1) * (X + 4) =
      4 * (y + 1) * (y + 3) * (y - 3) / (y - 1) ^ 3 := by
  dsimp
  field_simp [hy]
  ring

/-- The four consecutive squareclasses put the translated point on the
quadratic twist `D W^2 = X(X+1)(X+4)`, with `D=3AB` and the displayed
rational square root. -/
theorem pellChebyshev_fourConsecutive_twist_square
    (y A B a v r s : ℚ)
    (hA : A ≠ 0)
    (hB : B ≠ 0)
    (hv : v ≠ 0)
    (hPlusOne : y + 1 = 6 * r ^ 2)
    (hPlusThree : y + 3 = 2 * s ^ 2)
    (hMinusThree : y - 3 = 2 * A * a ^ 2)
    (hMinusOne : y - 1 = 2 * B * v ^ 2) :
    (4 * (y + 1) * (y + 3) * (y - 3) / (y - 1) ^ 3) /
        (3 * A * B) =
      (2 * a * r * s / (B ^ 2 * v ^ 3)) ^ 2 := by
  rw [hPlusOne, hPlusThree, hMinusThree, hMinusOne]
  field_simp [hA, hB, hv]
  ring

/-- The conjugate coordinates of `(2U,2yU)` agree with the fixed-curve
involution when conjugation sends `U` to `U⁻¹`. -/
theorem pellChebyshev_fixedElliptic_conjugate_coordinates
    (U y : ℚ)
    (hU : U ≠ 0) :
    2 / U = 4 / (2 * U) ∧
      2 * y / U = 4 * (2 * y * U) / (2 * U) ^ 2 := by
  constructor <;> field_simp [hU] <;> ring

#print axioms pellChebyshev_fixedElliptic_unscaled
#print axioms pellChebyshev_fixedElliptic_scale
#print axioms pellChebyshev_fixedElliptic_involution
#print axioms pellChebyshev_fixedElliptic_Q_sub_x
#print axioms pellChebyshev_fixedElliptic_Q_sub_y
#print axioms pellChebyshev_fixedElliptic_halfQ
#print axioms pellChebyshev_fixedElliptic_translate_x
#print axioms pellChebyshev_fixedElliptic_translated_cubic
#print axioms pellChebyshev_fourConsecutive_twist_square
#print axioms pellChebyshev_fixedElliptic_conjugate_coordinates

end IUTThreeClosures
