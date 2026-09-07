import Std

/-!
# Finite algebra core for product-tripod rigidity

This file proves integer rectangle and mixed-map identities only. The classification of regular
morphisms of products of punctured lines is an ordinary theorem in the adjacent README; the geometric
objects and that classification are not encoded or assumed here.
-/

namespace ProductTripodRectangle

/-- Two rank-one conditions force the additive rectangle identity. -/
theorem rectangle_additive (a b c d : Int)
    (h : a * d = b * c) (hc : (1 - a) * (1 - d) = (1 - b) * (1 - c)) :
    a + d = b + c := by
  grind

/-- A rank-one integer rectangle whose complement has rank one has zero mixed variation. -/
theorem rectangle_zero_product (a b c d : Int)
    (h : a * d = b * c) (hc : (1 - a) * (1 - d) = (1 - b) * (1 - c)) :
    (a - b) * (a - c) = 0 := by
  have ha := rectangle_additive a b c d h hc
  grind

/-- Every such rectangle is constant along rows or along columns. -/
theorem rectangle_dichotomy (a b c d : Int)
    (h : a * d = b * c) (hc : (1 - a) * (1 - d) = (1 - b) * (1 - c)) :
    (a = b ∧ c = d) ∨ (a = c ∧ b = d) := by
  have ha := rectangle_additive a b c d h hc
  have hp := rectangle_zero_product a b c d h hc
  have hz := Int.mul_eq_zero.mp hp
  omega

/-- Variation in the first coordinate forces constancy in the second on this rectangle. -/
theorem rectangle_nonzero_variation (a b c d : Int)
    (h : a * d = b * c) (hc : (1 - a) * (1 - d) = (1 - b) * (1 - c))
    (hne : a ≠ c) : a = b ∧ c = d := by
  have hd := rectangle_dichotomy a b c d h hc
  grind

/-- A product of two separated factors gives the first rank-one equality. -/
theorem separated_rectangle (u v s t : Int) : (u * s) * (v * t) = (u * t) * (v * s) := by
  grind

/-- If every rectangle and its complement have rank one, the whole integer-valued matrix depends
on at most one coordinate. The base points are explicit, so no hidden nonemptiness premise is used. -/
theorem matrix_coordinate_separation {X Y : Type} (f : X → Y → Int) (x₀ : X) (y₀ : Y)
    (h : ∀ x x' y y', f x y * f x' y' = f x y' * f x' y)
    (hc : ∀ x x' y y', (1 - f x y) * (1 - f x' y') =
      (1 - f x y') * (1 - f x' y)) :
    (∀ x y, f x y = f x y₀) ∨ (∀ x y, f x y = f x₀ y) := by
  classical
  by_cases hx : ∀ x, f x y₀ = f x₀ y₀
  · right
    intro x y
    have ha := rectangle_additive (f x₀ y₀) (f x₀ y) (f x y₀) (f x y)
      (h x₀ x y₀ y) (hc x₀ x y₀ y)
    have he := hx x
    omega
  · obtain ⟨x₁, h₁⟩ := Classical.not_forall.mp hx
    have hb : ∀ y, f x₀ y = f x₀ y₀ := by
      intro y
      have hn : f x₀ y₀ ≠ f x₁ y₀ := by omega
      have he := rectangle_nonzero_variation (f x₀ y₀) (f x₀ y) (f x₁ y₀) (f x₁ y)
        (h x₀ x₁ y₀ y) (hc x₀ x₁ y₀ y) hn
      omega
    left
    intro x y
    have ha := rectangle_additive (f x₀ y₀) (f x₀ y) (f x y₀) (f x y)
      (h x₀ x y₀ y) (hc x₀ x y₀ y)
    have he := hb y
    omega

/-- Algebraic numerator identity for the mixed map `f(x,y)=x*y` along `x+y=1`. -/
theorem mixed_numerator (a b : Int) : (a + b)^2 - a*b = a^2 + a*b + b^2 := by
  grind

/-- The mixed map preserves the displayed additive equation. -/
theorem mixed_addition (a b : Int) : a*b + (a^2 + a*b + b^2) = (a+b)^2 := by
  grind

/-- The new numerator is at least three quarters of the squared height. -/
theorem mixed_size_lower (a b : Int) : 3 * (a+b)^2 ≤ 4 * (a^2 + a*b + b^2) := by
  have h := Int.sq_nonneg (a-b)
  have he : 4 * (a^2 + a*b + b^2) - 3 * (a+b)^2 = (a-b)^2 := by grind
  omega

/-- Positivity of both old summands gives the strict upper size bound. -/
theorem mixed_size_upper (a b : Int) (ha : 0 < a) (hb : 0 < b) :
    a^2 + a*b + b^2 < (a+b)^2 := by
  have hp := Int.mul_pos ha hb
  have he := mixed_addition a b
  omega

end ProductTripodRectangle

#print axioms ProductTripodRectangle.rectangle_additive
#print axioms ProductTripodRectangle.rectangle_zero_product
#print axioms ProductTripodRectangle.rectangle_dichotomy
#print axioms ProductTripodRectangle.rectangle_nonzero_variation
#print axioms ProductTripodRectangle.separated_rectangle
#print axioms ProductTripodRectangle.matrix_coordinate_separation
#print axioms ProductTripodRectangle.mixed_numerator
#print axioms ProductTripodRectangle.mixed_addition
#print axioms ProductTripodRectangle.mixed_size_lower
#print axioms ProductTripodRectangle.mixed_size_upper
