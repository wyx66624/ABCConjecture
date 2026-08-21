import IUTThreeClosures.LegendreArithmetic

/-!
# The integral Frey curve attached to an abc point

For a primitive positive triple `a + b = c`, consider

`E_P : y² = x (x - a) (x + b)`.

This equation is integral over `ℤ`, has

* `c₄ = 16 (a² + ab + b²)`,
* `Δ = 16 a² b² c²`,
* `j = 256 (a² + ab + b²)³ / (a² b² c²)`.

The last expression agrees with the `j`-invariant of the Legendre curve at
`λ = a/c`.  The integral model is the useful one for local reduction: the
core `a²+ab+b²` is coprime to `abc`, so at every odd prime dividing `abc` the
`c₄` invariant is a unit while the discriminant has positive order.
-/

namespace IUTThreeClosures

open WeierstrassCurve

/-- Integral Frey equation `y² = x(x-a)(x+b)`. -/
def abcFreyCurveZ (P : ABCPoint) : WeierstrassCurve ℤ where
  a₁ := 0
  a₂ := (P.b : ℤ) - P.a
  a₃ := 0
  a₄ := -((P.a : ℤ) * P.b)
  a₆ := 0

/-- The Frey curve over `ℚ`. -/
def abcFreyCurve (P : ABCPoint) : WeierstrassCurve ℚ :=
  (abcFreyCurveZ P).baseChange ℚ

@[simp] theorem abcFreyZ_b₂ (P : ABCPoint) :
    (abcFreyCurveZ P).b₂ = 4 * ((P.b : ℤ) - P.a) := by
  simp [abcFreyCurveZ, WeierstrassCurve.b₂]
  ring

@[simp] theorem abcFreyZ_b₄ (P : ABCPoint) :
    (abcFreyCurveZ P).b₄ = -2 * (P.a : ℤ) * P.b := by
  simp [abcFreyCurveZ, WeierstrassCurve.b₄]
  ring

@[simp] theorem abcFreyZ_b₆ (P : ABCPoint) :
    (abcFreyCurveZ P).b₆ = 0 := by
  simp [abcFreyCurveZ, WeierstrassCurve.b₆]

@[simp] theorem abcFreyZ_b₈ (P : ABCPoint) :
    (abcFreyCurveZ P).b₈ = -((P.a : ℤ) ^ 2 * (P.b : ℤ) ^ 2) := by
  simp [abcFreyCurveZ, WeierstrassCurve.b₈]
  ring

@[simp] theorem abcFreyZ_c₄ (P : ABCPoint) :
    (abcFreyCurveZ P).c₄ = 16 * (P.legendreCore : ℤ) := by
  rw [WeierstrassCurve.c₄, abcFreyZ_b₂, abcFreyZ_b₄]
  unfold ABCPoint.legendreCore
  push_cast
  ring

@[simp] theorem abcFreyZ_Δ (P : ABCPoint) :
    (abcFreyCurveZ P).Δ =
      16 * (P.a : ℤ) ^ 2 * (P.b : ℤ) ^ 2 * (P.c : ℤ) ^ 2 := by
  rw [WeierstrassCurve.Δ, abcFreyZ_b₂, abcFreyZ_b₄,
    abcFreyZ_b₆, abcFreyZ_b₈]
  have hsum : (P.a : ℤ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcFrey_c₄ (P : ABCPoint) :
    (abcFreyCurve P).c₄ = 16 * (P.legendreCore : ℚ) := by
  simp [abcFreyCurve]

@[simp] theorem abcFrey_Δ (P : ABCPoint) :
    (abcFreyCurve P).Δ =
      16 * (P.a : ℚ) ^ 2 * (P.b : ℚ) ^ 2 * (P.c : ℚ) ^ 2 := by
  simp [abcFreyCurve]

/-- The Frey equation is nonsingular. -/
noncomputable instance abcFrey_isElliptic (P : ABCPoint) :
    (abcFreyCurve P).IsElliptic where
  isUnit := by
    rw [abcFrey_Δ]
    apply isUnit_iff_ne_zero.mpr
    exact mul_ne_zero
      (mul_ne_zero
        (mul_ne_zero (by norm_num)
          (pow_ne_zero _ (by exact_mod_cast P.a_pos.ne')))
        (pow_ne_zero _ (by exact_mod_cast P.b_pos.ne')))
      (pow_ne_zero _ (by exact_mod_cast P.c_pos.ne'))

/-- Exact `j`-invariant of the integral Frey model. -/
theorem abcFrey_j (P : ABCPoint) :
    (abcFreyCurve P).j =
      256 * (P.legendreCore : ℚ) ^ 3 /
        ((P.a : ℚ) ^ 2 * (P.b : ℚ) ^ 2 * (P.c : ℚ) ^ 2) := by
  rw [WeierstrassCurve.j]
  change ((abcFreyCurve P).Δ' : ℚ)⁻¹ *
      (abcFreyCurve P).c₄ ^ 3 = _
  rw [WeierstrassCurve.coe_Δ', abcFrey_Δ, abcFrey_c₄]
  have ha : (P.a : ℚ) ≠ 0 := by exact_mod_cast P.a_pos.ne'
  have hb : (P.b : ℚ) ≠ 0 := by exact_mod_cast P.b_pos.ne'
  have hc : (P.c : ℚ) ≠ 0 := by exact_mod_cast P.c_pos.ne'
  field_simp [ha, hb, hc]
  ring

/-- The integral Frey curve and the Legendre curve have the same `j`. -/
theorem abcFrey_j_eq_legendre_j (P : ABCPoint) :
    (abcFreyCurve P).j = (abcLegendreCurve P).j := by
  rw [abcFrey_j, abcLegendre_j_eq_core]

end IUTThreeClosures