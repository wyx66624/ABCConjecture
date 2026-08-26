import Mathlib

/-!
# Scalar kernel for the Tatuzawa class-number family audit

The companion note applies Tatuzawa's theorem to the pairwise-distinct
fundamental discriminants `D_n = 4*A_n`.  This file verifies only the
division-free logical core:

* injectivity pulls an at-most-one exceptional discriminant back to an
  at-most-one exceptional index;
* the norm-two and Yokoi trace-coordinate identities are exact;
* a lower `L`-value bound controls the product `h*R` from below;
* an upper `L`-value bound and `1 <= h` control `R` from above; and
* the scalar profile `sqrtA = R`, `h = L = 1` is compatible with both
  directions.

It does not formalize Dirichlet characters, Tatuzawa's theorem, analytic
class-number formulas, real quadratic fields, logarithms, or asymptotics.
-/

namespace IUTThreeClosures

/-- The squarefree decomposition `c = A*y^2` and the family identity
`c = s^2 - 2` give the norm-two equation.  The second conjunct is the
rational coordinate in `(s + y*sqrt A)^2 = 2*epsilon`. -/
theorem pellClassNumber_normTwoCoordinates
    (A y s c : ℤ)
    (hsquarefreePart : c = A * y ^ 2)
    (hpell : c = s ^ 2 - 2) :
    s ^ 2 - A * y ^ 2 = 2 ∧
      s ^ 2 + A * y ^ 2 = 2 * (c + 1) := by
  constructor <;> nlinarith

/-- In Yokoi's notation the trace coordinate decomposes as
`t = A*m + 2` with the exact candidate `m = 2*y^2`.  For `A > 2`, this
also makes `m = floor (t/A)`; the floor statement is left to the note. -/
theorem pellYokoi_trace_decomposition
    (A y c : ℤ)
    (hsquarefreePart : c = A * y ^ 2) :
    2 * (c + 1) = A * (2 * y ^ 2) + 2 := by
  rw [hsquarefreePart]
  ring

/-- If exceptional discriminants form an at-most-one set and the discriminant
map is injective, then exceptional indices also form an at-most-one set. -/
theorem pellTatuzawa_exceptionalIndex_unique
    {Index Disc : Type*}
    (disc : Index → Disc)
    (hdisc : Function.Injective disc)
    (exceptional : Disc → Prop)
    (hone : ∀ ⦃D E⦄, exceptional D → exceptional E → D = E)
    ⦃m n : Index⦄
    (hm : exceptional (disc m))
    (hn : exceptional (disc n)) :
    m = n := by
  exact hdisc (hone hm hn)

/-- In the scalar class-number formula `h*R = sqrtA*L`, a lower bound for
`L` gives a lower bound for the product `h*R`.  It does not isolate an upper
bound for `R`. -/
theorem pellClassNumber_lowerL_controls_product
    (h R sqrtA L lower : ℝ)
    (hsqrtA : 0 ≤ sqrtA)
    (hlower : lower ≤ L)
    (hformula : h * R = sqrtA * L) :
    sqrtA * lower ≤ h * R := by
  calc
    sqrtA * lower ≤ sqrtA * L :=
      mul_le_mul_of_nonneg_left hlower hsqrtA
    _ = h * R := hformula.symm

/-- If one additionally has an upper bound for the class number, the lower
`L`-bound points toward a lower bound for `R` (written without division). -/
theorem pellClassNumber_lowerL_with_classUpper
    (h R sqrtA L lower classUpper : ℝ)
    (hRnonneg : 0 ≤ R)
    (hsqrtA : 0 ≤ sqrtA)
    (hlower : lower ≤ L)
    (hclass : h ≤ classUpper)
    (hformula : h * R = sqrtA * L) :
    sqrtA * lower ≤ classUpper * R := by
  calc
    sqrtA * lower ≤ h * R :=
      pellClassNumber_lowerL_controls_product
        h R sqrtA L lower hsqrtA hlower hformula
    _ ≤ classUpper * R := mul_le_mul_of_nonneg_right hclass hRnonneg

/-- The inequality useful for a parameter lower bound has the other polarity:
an upper `L`-bound together with `1 <= h` gives `R <= sqrtA*upper`. -/
theorem pellClassNumber_upperL_controls_regulator
    (h R sqrtA L upper : ℝ)
    (hRnonneg : 0 ≤ R)
    (hsqrtA : 0 ≤ sqrtA)
    (hone : 1 ≤ h)
    (hupper : L ≤ upper)
    (hformula : h * R = sqrtA * L) :
    R ≤ sqrtA * upper := by
  calc
    R = 1 * R := by ring
    _ ≤ h * R := mul_le_mul_of_nonneg_right hone hRnonneg
    _ = sqrtA * L := hformula
    _ ≤ sqrtA * upper := mul_le_mul_of_nonneg_left hupper hsqrtA

/-- Scalar compatibility profile from the companion note.  Set
`sqrtA = R = t` and `h = L = 1`.  Any lower profile at most one and any
upper profile at least one are simultaneously compatible with the exact
class-number scalar identity. -/
theorem pellClassNumber_subcriticalScalarProfile
    (t lower upper : ℝ)
    (ht : 0 ≤ t)
    (hlower : lower ≤ 1)
    (hupper : 1 ≤ upper) :
    (1 : ℝ) * t = t * 1 ∧
      t * lower ≤ (1 : ℝ) * t ∧
      (1 : ℝ) * t ≤ t * upper := by
  constructor
  · ring
  constructor
  · simpa using mul_le_mul_of_nonneg_left hlower ht
  · simpa using mul_le_mul_of_nonneg_left hupper ht

end IUTThreeClosures
