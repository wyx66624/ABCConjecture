import Mathlib

/-!
# Scalar bridge for the four-point Pell truncation

This module verifies only the exact algebra and real-number bookkeeping in
`FREY_PELL_FOUR_POINT_TRUNCATED_BRIDGE.md`:

* the four-consecutive-integer block coming from the Pell equation;
* subtraction of the two half-height square branches from a hypothetical
  coefficient-two truncated count;
* conversion of the resulting radical bound to the super-square versus
  exponent-one balance; and
* a component-correct two-index profile showing that an aggregate window
  balance does not imply its pointwise counterpart.

It does not formalize or assume a truncated Second Main Theorem, the `abc`
conjecture, Pasten's theorem, radical or height asymptotics, prime
factorization, or the Pell recurrence.
-/

namespace IUTThreeClosures

/-! ## The four consecutive values -/

/-- The Pell equation puts the two target values next to two square
branches. -/
theorem pellFourPoint_consecutiveBlock
    (s r : ℤ) (hpell : s ^ 2 - 3 * r ^ 2 = 1) :
    let b := s ^ 2 - 3
    b = 3 * r ^ 2 - 2 ∧
      b + 1 = 3 * r ^ 2 - 1 ∧
      b + 2 = 3 * r ^ 2 ∧
      b + 3 = s ^ 2 := by
  dsimp
  constructor
  · linarith
  constructor
  · linarith
  constructor <;> linarith

/-- Multiplying the two auxiliary branches exposes a fixed multiple of a
square. -/
theorem pellFourPoint_squareBranchProduct
    (b r s : ℤ)
    (hleft : b + 2 = 3 * r ^ 2)
    (hright : b + 3 = s ^ 2) :
    (b + 2) * (b + 3) = 3 * (r * s) ^ 2 := by
  rw [hleft, hright]
  ring

/-! ## Coefficient-two same-index bridge -/

/-- If a four-point truncated count has coefficient `coefficient`, while
the two square branches together cost at most one source-height unit, then
the two target branches retain coefficient `coefficient - 1`. -/
theorem pellFourPoint_generalCoefficientBridge
    (source target squareLeft squareRight coefficient : ℝ)
    (hcount : coefficient * source ≤
      target + squareLeft + squareRight)
    (hleft : squareLeft ≤ source / 2)
    (hright : squareRight ≤ source / 2) :
    (coefficient - 1) * source ≤ target := by
  linarith

/-- The conjectural four-point coefficient `2 - epsilon` leaves exactly
the required target coefficient `1 - epsilon`. -/
theorem pellFourPoint_coefficientTwoBridge
    (source target squareLeft squareRight epsilon : ℝ)
    (hcount : (2 - epsilon) * source ≤
      target + squareLeft + squareRight)
    (hleft : squareLeft ≤ source / 2)
    (hright : squareRight ≤ source / 2) :
    (1 - epsilon) * source ≤ target := by
  have h := pellFourPoint_generalCoefficientBridge
    source target squareLeft squareRight (2 - epsilon)
    hcount hleft hright
  convert h using 1
  ring

/-- Once the four-point bridge supplies the critical radical lower bound,
the exact exponent-layer ledger gives the desired same-index super-square
balance. -/
theorem pellFourPoint_radicalToSuperSquareBalance
    (source total radical excess superSquare exponentOne epsilon : ℝ)
    (htotal : total = 2 * source)
    (hfactorization : total = radical + excess)
    (hlayer : 2 * excess = total + superSquare - exponentOne)
    (hradical : (1 - epsilon) * source ≤ radical) :
    superSquare ≤ exponentOne + 2 * epsilon * source := by
  linarith

/-! ## A strict boundary for multi-index aggregation -/

/-- A two-index aggregate balance can hold exactly although the first index
violates the pointwise balance for every `epsilon < 1/3`.

The common weight `source / 3` has a component-correct interpretation.  At
the bad index, one cube fills each of two components, giving super-square
mass `2 * source / 3` and no exponent-one mass.  At the good index, each
component contains one exponent-one copy and one square copy of this weight;
it still has total height `source`, and contributes exponent-one mass
`2 * source / 3`.  The two index totals therefore balance exactly.
-/
theorem pellFourPoint_twoIndexAggregate_notPointwise
    (source epsilon : ℝ)
    (hsource : 0 < source)
    (hepsilon : epsilon < 1 / 3) :
    let weight := source / 3
    let badSuperSquare := 2 * weight
    let badExponentOne := 0
    let goodSuperSquare := 0
    let goodExponentOne := 2 * weight
    0 < weight ∧
      3 * weight = source ∧
      weight + 2 * weight = source ∧
      badSuperSquare + goodSuperSquare =
        badExponentOne + goodExponentOne ∧
      badExponentOne + 2 * epsilon * source < badSuperSquare := by
  dsimp
  constructor
  · linarith
  constructor
  · ring
  constructor
  · ring
  constructor
  · ring
  · nlinarith

end IUTThreeClosures
