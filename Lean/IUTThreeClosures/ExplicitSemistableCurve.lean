import Mathlib

/-!
# The explicit discriminant-37 elliptic curve

The curve

`E₃₇ : y² + y = x³ - x`

is the natural fixed global curve for the admissible-prime construction route.
Its integral Weierstrass coefficients are
`a₁ = 0`, `a₂ = 0`, `a₃ = 1`, `a₄ = -1`, `a₆ = 0`.
This file verifies its standard invariants directly in Lean.  In particular,
its discriminant is `37`, so it is an elliptic curve over `ℚ`, and every
possible bad reduction place lies over the single rational prime `37` once
the local minimal-model comparison is supplied.
-/

namespace IUTThreeClosures

open WeierstrassCurve

/-- The integral model `y² + y = x³ - x`. -/
def E37Z : WeierstrassCurve ℤ where
  a₁ := 0
  a₂ := 0
  a₃ := 1
  a₄ := -1
  a₆ := 0

/-- The same curve over `ℚ`. -/
def E37 : WeierstrassCurve ℚ :=
  E37Z.baseChange ℚ

@[simp] theorem E37Z_b₂ : E37Z.b₂ = 0 := by
  norm_num [E37Z, WeierstrassCurve.b₂]

@[simp] theorem E37Z_b₄ : E37Z.b₄ = -2 := by
  norm_num [E37Z, WeierstrassCurve.b₄]

@[simp] theorem E37Z_b₆ : E37Z.b₆ = 1 := by
  norm_num [E37Z, WeierstrassCurve.b₆]

@[simp] theorem E37Z_b₈ : E37Z.b₈ = -1 := by
  norm_num [E37Z, WeierstrassCurve.b₈]

@[simp] theorem E37Z_c₄ : E37Z.c₄ = 48 := by
  norm_num [WeierstrassCurve.c₄]

@[simp] theorem E37Z_c₆ : E37Z.c₆ = -216 := by
  norm_num [WeierstrassCurve.c₆]

@[simp] theorem E37Z_Δ : E37Z.Δ = 37 := by
  norm_num [WeierstrassCurve.Δ]

@[simp] theorem E37_b₂ : E37.b₂ = 0 := by
  simp [E37]

@[simp] theorem E37_b₄ : E37.b₄ = -2 := by
  simp [E37]

@[simp] theorem E37_b₆ : E37.b₆ = 1 := by
  simp [E37]

@[simp] theorem E37_b₈ : E37.b₈ = -1 := by
  simp [E37]

@[simp] theorem E37_c₄ : E37.c₄ = 48 := by
  simp [E37]

@[simp] theorem E37_c₆ : E37.c₆ = -216 := by
  simp [E37]

@[simp] theorem E37_Δ : E37.Δ = 37 := by
  simp [E37]

/-- The discriminant-37 model is nonsingular over `ℚ`. -/
noncomputable instance E37_isElliptic : E37.IsElliptic where
  isUnit := by
    rw [E37_Δ]
    norm_num

/-- The `j`-invariant of `E₃₇`. -/
theorem E37_j : E37.j = (110592 / 37 : ℚ) := by
  rw [WeierstrassCurve.j]
  change (E37.Δ' : ℚ)⁻¹ * E37.c₄ ^ 3 = _
  rw [WeierstrassCurve.coe_Δ', E37_Δ, E37_c₄]
  norm_num

end IUTThreeClosures