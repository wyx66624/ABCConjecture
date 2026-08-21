import IUTThreeClosures.NonCircularDownstream
import Mathlib.AlgebraicGeometry.EllipticCurve.Weierstrass

/-!
# The Legendre curve attached to an abc point

For a positive coprime triple `a + b = c`, set `λ = a / c`.  Then
`0 < λ < 1`, and the Legendre equation

`y² = x (x - 1) (x - λ)`

has discriminant `16 λ² (1 - λ)²`, hence defines an elliptic curve over `ℚ`.
This is the canonical point-dependent global curve needed by the geometric
inhabitant route; unlike a fixed auxiliary elliptic curve, its height varies
with the abc input.
-/

namespace IUTThreeClosures

open WeierstrassCurve

namespace ABCPoint

/-- The tripod coordinate `λ = a/c`. -/
noncomputable def lambda (P : ABCPoint) : ℚ :=
  (P.a : ℚ) / (P.c : ℚ)

theorem lambda_pos (P : ABCPoint) : 0 < P.lambda := by
  apply div_pos
  · exact_mod_cast P.a_pos
  · exact_mod_cast P.c_pos

theorem a_lt_c (P : ABCPoint) : P.a < P.c := by
  omega

theorem b_lt_c (P : ABCPoint) : P.b < P.c := by
  omega

theorem lambda_lt_one (P : ABCPoint) : P.lambda < 1 := by
  apply (div_lt_one (by exact_mod_cast P.c_pos)).2
  exact_mod_cast P.a_lt_c

theorem lambda_ne_zero (P : ABCPoint) : P.lambda ≠ 0 :=
  ne_of_gt P.lambda_pos

theorem one_sub_lambda_pos (P : ABCPoint) : 0 < 1 - P.lambda :=
  sub_pos.mpr P.lambda_lt_one

theorem one_sub_lambda_ne_zero (P : ABCPoint) : 1 - P.lambda ≠ 0 :=
  ne_of_gt P.one_sub_lambda_pos

/-- For a positive abc point, the elementary maximum is exactly `c`. -/
theorem max_eq_c (P : ABCPoint) : max P.a (max P.b P.c) = P.c := by
  rw [max_eq_right (Nat.le_of_lt P.a_lt_c)]
  rw [max_eq_right (Nat.le_of_lt P.b_lt_c)]

/-- The elementary logarithmic height is `log c`. -/
theorem height_eq_log_c (P : ABCPoint) :
    P.height = Real.log (P.c : ℝ) := by
  rw [ABCPoint.height, P.max_eq_c]

/-- The numerator and denominator of `λ = a/c` are coprime. -/
theorem coprime_a_c (P : ABCPoint) : Nat.Coprime P.a P.c :=
  P.pairwise_coprime.2.2.symm

end ABCPoint

/-- The Legendre Weierstrass equation
`y² = x³ - (1 + λ)x² + λx`. -/
noncomputable def abcLegendreCurve (P : ABCPoint) : WeierstrassCurve ℚ where
  a₁ := 0
  a₂ := -(1 + P.lambda)
  a₃ := 0
  a₄ := P.lambda
  a₆ := 0

@[simp] theorem abcLegendre_b₂ (P : ABCPoint) :
    (abcLegendreCurve P).b₂ = -4 * (1 + P.lambda) := by
  simp [abcLegendreCurve, WeierstrassCurve.b₂]
  ring

@[simp] theorem abcLegendre_b₄ (P : ABCPoint) :
    (abcLegendreCurve P).b₄ = 2 * P.lambda := by
  simp [abcLegendreCurve, WeierstrassCurve.b₄]

@[simp] theorem abcLegendre_b₆ (P : ABCPoint) :
    (abcLegendreCurve P).b₆ = 0 := by
  simp [abcLegendreCurve, WeierstrassCurve.b₆]

@[simp] theorem abcLegendre_b₈ (P : ABCPoint) :
    (abcLegendreCurve P).b₈ = -(P.lambda ^ 2) := by
  simp [abcLegendreCurve, WeierstrassCurve.b₈]
  ring

@[simp] theorem abcLegendre_c₄ (P : ABCPoint) :
    (abcLegendreCurve P).c₄ =
      16 * (1 - P.lambda + P.lambda ^ 2) := by
  simp [WeierstrassCurve.c₄]
  ring

@[simp] theorem abcLegendre_Δ (P : ABCPoint) :
    (abcLegendreCurve P).Δ =
      16 * P.lambda ^ 2 * (1 - P.lambda) ^ 2 := by
  simp [WeierstrassCurve.Δ]
  ring

/-- Every positive abc point produces a nonsingular Legendre elliptic curve. -/
noncomputable instance abcLegendre_isElliptic (P : ABCPoint) :
    (abcLegendreCurve P).IsElliptic where
  isUnit := by
    rw [abcLegendre_Δ]
    apply isUnit_iff_ne_zero.mpr
    exact mul_ne_zero
      (mul_ne_zero (by norm_num) (pow_ne_zero _ P.lambda_ne_zero))
      (pow_ne_zero _ P.one_sub_lambda_ne_zero)

/-- The classical Legendre `j`-invariant formula. -/
theorem abcLegendre_j (P : ABCPoint) :
    (abcLegendreCurve P).j =
      256 * (1 - P.lambda + P.lambda ^ 2) ^ 3 /
        (P.lambda ^ 2 * (1 - P.lambda) ^ 2) := by
  rw [WeierstrassCurve.j]
  change ((abcLegendreCurve P).Δ' : ℚ)⁻¹ *
      (abcLegendreCurve P).c₄ ^ 3 = _
  rw [WeierstrassCurve.coe_Δ', abcLegendre_Δ, abcLegendre_c₄]
  field_simp [P.lambda_ne_zero, P.one_sub_lambda_ne_zero]
  ring

end IUTThreeClosures