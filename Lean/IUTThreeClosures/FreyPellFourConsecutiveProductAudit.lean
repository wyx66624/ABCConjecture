import Mathlib

/-!
# Four-consecutive-product audit for the Pell radical route

This file verifies the elementary algebra and the scalar coefficient barrier
used in `FREY_PELL_FOUR_CONSECUTIVE_PRODUCT_AUDIT.md`.  It does not formalize
squarefree kernels, radicals, continued fractions, the Bennett--Walsh theorem,
simultaneous Pell theorems, Thue--Mahler estimates, or any conjecture.
-/

namespace IUTThreeClosures

/-! ## Exact four-consecutive algebra -/

/-- The classical four-consecutive-product identity. -/
theorem fourConsecutive_product_add_one (b : ℤ) :
    b * (b + 1) * (b + 2) * (b + 3) + 1 =
      (b ^ 2 + 3 * b + 1) ^ 2 := by
  ring

/-- The first Pell coordinate has the additional square constraint that is
not visible from its two neighboring squarefree kernels alone. -/
theorem fourConsecutive_coordinate_add_five (b : ℤ) :
    4 * (b ^ 2 + 3 * b + 1) + 5 = (2 * b + 3) ^ 2 := by
  ring

/-- If the last two members of the block are the Pell square branches, the
four-consecutive identity becomes a norm-one equation. -/
theorem pellFourConsecutive_productNormOne
    (b r s : ℤ)
    (hthree : b + 2 = 3 * r ^ 2)
    (hsquare : b + 3 = s ^ 2) :
    (b ^ 2 + 3 * b + 1) ^ 2 -
        3 * b * (b + 1) * (r * s) ^ 2 = 1 := by
  have hid := fourConsecutive_product_add_one b
  calc
    (b ^ 2 + 3 * b + 1) ^ 2 -
          3 * b * (b + 1) * (r * s) ^ 2
        = (b ^ 2 + 3 * b + 1) ^ 2 -
            b * (b + 1) * (b + 2) * (b + 3) := by
              rw [hthree, hsquare]
              ring
    _ = 1 := by linarith

/-- After writing the first two coprime factors as a squarefree coefficient
times a square, the product norm equation has discriminant coefficient
`3 * A * B`. -/
theorem pellFourConsecutive_decomposedNormOne
    (b A B u v r s : ℤ)
    (hA : b = A * u ^ 2)
    (hB : b + 1 = B * v ^ 2)
    (hthree : b + 2 = 3 * r ^ 2)
    (hsquare : b + 3 = s ^ 2) :
    (b ^ 2 + 3 * b + 1) ^ 2 -
        3 * A * B * (u * v * r * s) ^ 2 = 1 := by
  have hnorm := pellFourConsecutive_productNormOne b r s hthree hsquare
  calc
    (b ^ 2 + 3 * b + 1) ^ 2 -
          3 * A * B * (u * v * r * s) ^ 2
        = (b ^ 2 + 3 * b + 1) ^ 2 -
            3 * b * (b + 1) * (r * s) ^ 2 := by
              rw [hB, hA]
              ring
    _ = 1 := hnorm

/-- The four consecutive values give three adjacent quadratic equations.
This is the exact simultaneous-Pell input; no radical estimate is included. -/
theorem pellFourConsecutive_adjacentSystem
    (b A B u v r s : ℤ)
    (hA : b = A * u ^ 2)
    (hB : b + 1 = B * v ^ 2)
    (hthree : b + 2 = 3 * r ^ 2)
    (hsquare : b + 3 = s ^ 2) :
    B * v ^ 2 - A * u ^ 2 = 1 ∧
      3 * r ^ 2 - B * v ^ 2 = 1 ∧
      s ^ 2 - 3 * r ^ 2 = 1 := by
  constructor
  · linarith
  constructor <;> linarith

/-- The first coordinate of the product unit lies one above an `A`-square
and one below a `3B`-square. -/
theorem pellFourConsecutive_coordinateNeighbors
    (b A B u v r s : ℤ)
    (hA : b = A * u ^ 2)
    (hB : b + 1 = B * v ^ 2)
    (hthree : b + 2 = 3 * r ^ 2)
    (hsquare : b + 3 = s ^ 2) :
    let Z := b ^ 2 + 3 * b + 1
    Z - 1 = A * (u * s) ^ 2 ∧
      Z + 1 = 3 * B * (v * r) ^ 2 := by
  dsimp
  constructor
  · calc
      b ^ 2 + 3 * b + 1 - 1 = b * (b + 3) := by ring
      _ = A * (u * s) ^ 2 := by rw [hsquare, hA]; ring
  · calc
      b ^ 2 + 3 * b + 1 + 1 = (b + 1) * (b + 2) := by ring
      _ = 3 * B * (v * r) ^ 2 := by rw [hB, hthree]; ring

/-- The first two factors also give the quartic equation to which the
Bennett--Walsh theorem can be applied with coefficients `B` and `3*A`. -/
theorem pellFourConsecutive_bennettWalshShape
    (b A B u v r : ℤ)
    (hA : b = A * u ^ 2)
    (hB : b + 1 = B * v ^ 2)
    (hthree : b + 2 = 3 * r ^ 2) :
    B ^ 2 * v ^ 4 - 3 * A * (u * r) ^ 2 = 1 := by
  calc
    B ^ 2 * v ^ 4 - 3 * A * (u * r) ^ 2
        = (b + 1) ^ 2 - b * (b + 2) := by
            rw [hB, hthree, hA]
            ring
    _ = 1 := by ring

/-! ## Exact radical bookkeeping at the logarithmic level -/

/-- In a decomposition `b=A*u^2`, `b+1=B*v^2`, the radical weight is the
weight of the parity kernels plus the radical weight of the square bases,
minus their overlap.  This theorem records only that scalar identity. -/
theorem pellFourConsecutive_radicalLedger
    (squarefreeWeight baseRadicalWeight overlap radicalWeight : ℝ)
    (hledger : radicalWeight =
      squarefreeWeight + baseRadicalWeight - overlap) :
    radicalWeight = squarefreeWeight +
      (baseRadicalWeight - overlap) := by
  linarith

/-- The minimal missing moving-coefficient Pell--Mahler estimate: a lower
bound for the new base-radical mass, after overlap, gives the desired
coefficient-one radical bound exactly. -/
theorem pellFourConsecutive_baseRadicalBridge
    (source epsilon squarefreeWeight baseRadicalWeight overlap
      radicalWeight : ℝ)
    (hledger : radicalWeight =
      squarefreeWeight + baseRadicalWeight - overlap)
    (hbase : (1 - epsilon) * source - squarefreeWeight ≤
      baseRadicalWeight - overlap) :
    (1 - epsilon) * source ≤ radicalWeight := by
  linarith

/-! ## A two-component, height-correct scalar barrier -/

/-- Two abstract cube carriers, one in each coprime factor, respect both
factor heights and the full product-unit height ledger, yet miss the
coefficient-one radical target whenever `epsilon < 1/3`.

This is a conditional scalar profile, not an assertion that such integers
occur in the fixed Pell orbit.  Its purpose is to rule out arguments using
only nonnegativity, the two separate factor heights, parity-kernel weights,
and the size of the product norm equation.
-/
theorem pellFourConsecutive_twoCubeProfile
    (source epsilon : ℝ)
    (hsource : 0 < source)
    (hepsilon : epsilon < 1 / 3) :
    let weight := source / 3
    let firstFactorTotal := 3 * weight
    let secondFactorTotal := 3 * weight
    let squarefreeWeight := 2 * weight
    let squareBaseWeight := 2 * weight
    let auxiliarySquareWeight := 3 * weight
    let productUnitHeight := 6 * weight
    let radicalWeight := 2 * weight
    0 < weight ∧
      firstFactorTotal = source ∧
      secondFactorTotal = source ∧
      firstFactorTotal + secondFactorTotal = 2 * source ∧
      squarefreeWeight / 2 + squareBaseWeight +
          auxiliarySquareWeight = productUnitHeight ∧
      productUnitHeight = 2 * source ∧
      radicalWeight < (1 - epsilon) * source := by
  dsimp
  constructor
  · linarith
  constructor
  · ring
  constructor
  · ring
  constructor
  · ring
  constructor
  · ring
  constructor
  · ring
  · nlinarith

end IUTThreeClosures
