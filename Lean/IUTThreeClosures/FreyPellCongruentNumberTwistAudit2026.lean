import Mathlib.Data.Int.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring

/-!
# Scalar companion to the Pell congruent-number-twist audit

The accepted arithmetic input in the accompanying note is Bennett's theorem
that, for fixed positive `a,b,c`, the simultaneous equations

`a*x^2 - b*y^2 = 1`, `b*y^2 - c*z^2 = 1`

have at most one positive solution.  This file does not formalize that deep
theorem.  It checks the exact integral map to

`Y^2 = X^3 - D^2*X`,

the square-class factor identities, the injectivity consequence when the
accepted uniqueness theorem is supplied with its genuine quantifiers, and
the scalar ratio which identifies the required large-point boundary.
-/

namespace IUTThreeClosures

/-- The two consecutive-square equations give the three factors on the
congruent-number curve. -/
theorem pellSquarebase_congruent_factors
    (A s r y : ℤ)
    (hleft : s ^ 2 - 3 * r ^ 2 = 1)
    (hright : 3 * r ^ 2 - A * y ^ 2 = 1) :
    let D := 3 * A
    let X := 9 * A * r ^ 2
    X - D = 3 * A ^ 2 * y ^ 2 ∧
      X + D = 3 * A * s ^ 2 := by
  dsimp
  constructor
  · linear_combination 3 * A * hright
  · linear_combination -3 * A * hleft

/-- Exact denominator-free map from the simultaneous Pell system to the
quadratic twist `Y^2 = X^3 - D^2 X`. -/
theorem pellSquarebase_on_congruentCurve
    (A s r y : ℤ)
    (hleft : s ^ 2 - 3 * r ^ 2 = 1)
    (hright : 3 * r ^ 2 - A * y ^ 2 = 1) :
    let D := 3 * A
    let X := 9 * A * r ^ 2
    let Y := 9 * A ^ 2 * s * r * y
    Y ^ 2 = X ^ 3 - D ^ 2 * X := by
  dsimp
  have hminus : 9 * A * r ^ 2 - 3 * A = 3 * A ^ 2 * y ^ 2 := by
    linear_combination 3 * A * hright
  have hplus : 9 * A * r ^ 2 + 3 * A = 3 * A * s ^ 2 := by
    linear_combination -3 * A * hleft
  calc
    (9 * A ^ 2 * s * r * y) ^ 2 =
        (9 * A * r ^ 2) * (3 * A ^ 2 * y ^ 2) * (3 * A * s ^ 2) := by ring
    _ = (9 * A * r ^ 2) *
        ((9 * A * r ^ 2) - (3 * A)) *
        ((9 * A * r ^ 2) + (3 * A)) := by rw [hminus, hplus]
    _ = (9 * A * r ^ 2) ^ 3 - (3 * A) ^ 2 * (9 * A * r ^ 2) := by ring

/-- The explicit x-coordinate has exactly the square-excess ratio recorded
in the paper: `X / D^2 = y^2/3 + 1/(3A)`. -/
theorem congruent_x_ratio
    (A y : ℝ) (hA : A ≠ 0) :
    (3 * A * (A * y ^ 2 + 1)) / (3 * A) ^ 2 =
      y ^ 2 / 3 + 1 / (3 * A) := by
  field_simp [hA]

/-- Abstract form of Bennett's accepted uniqueness theorem, specialized to
the coefficients `(1,3,A)`. -/
def BennettConsecutiveUnique : Prop :=
  ∀ A s₁ r₁ y₁ s₂ r₂ y₂ : ℕ,
    0 < A →
    0 < s₁ → 0 < r₁ → 0 < y₁ →
    0 < s₂ → 0 < r₂ → 0 < y₂ →
    s₁ ^ 2 = 3 * r₁ ^ 2 + 1 →
    3 * r₁ ^ 2 = A * y₁ ^ 2 + 1 →
    s₂ ^ 2 = 3 * r₂ ^ 2 + 1 →
    3 * r₂ ^ 2 = A * y₂ ^ 2 + 1 →
    s₁ = s₂ ∧ r₁ = r₂ ∧ y₁ = y₂

/-- Bennett uniqueness plus injectivity of the increasing Pell coordinate
implies injectivity of the moving squarefree coefficient. -/
theorem pellSquarebase_core_injective
    (A s r y : ℕ → ℕ)
    (hBennett : BennettConsecutiveUnique)
    (hsInjective : Function.Injective s)
    (hAPos : ∀ n, 0 < A n)
    (hsPos : ∀ n, 0 < s n)
    (hrPos : ∀ n, 0 < r n)
    (hyPos : ∀ n, 0 < y n)
    (hleft : ∀ n, s n ^ 2 = 3 * r n ^ 2 + 1)
    (hright : ∀ n, 3 * r n ^ 2 = A n * y n ^ 2 + 1) :
    Function.Injective A := by
  intro m n hA
  have htriple := hBennett (A m)
    (s m) (r m) (y m) (s n) (r n) (y n)
    (hAPos m)
    (hsPos m) (hrPos m) (hyPos m)
    (hsPos n) (hrPos n) (hyPos n)
    (hleft m) (hright m) (hleft n) (by simpa [hA] using hright n)
  exact hsInjective htriple.1

#print axioms pellSquarebase_congruent_factors
#print axioms pellSquarebase_on_congruentCurve
#print axioms congruent_x_ratio
#print axioms pellSquarebase_core_injective

end IUTThreeClosures
