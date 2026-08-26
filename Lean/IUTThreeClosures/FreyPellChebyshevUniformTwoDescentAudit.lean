import IUTThreeClosures.FreyPellChebyshevPrimeIndexUniformGenusAudit

/-!
# Uniform Chebyshev two-descent audit: scalar kernel

This file checks the two explicit square factorizations of the reduced
Chebyshev polynomials at prime indices 11, 13, and 17.  They are finite
specializations of the uniform identities in the companion note
`FREY_PELL_CHEBYSHEV_UNIFORM_TWO_DESCENT_AUDIT.md`.

It does not formalize Chebyshev root fields, number-field discriminants,
local squareclasses, Jacobians, Selmer groups, Magma or PARI computations,
or Coleman integration.  In particular, it introduces no rank upper bound
and no uniform rational-point classification.
-/

namespace IUTThreeClosures

/-- At index 11, both distinguished fibers of the reduced polynomial are
a linear factor times a square. -/
theorem pellChebyshevReducedEleven_halfFactors (x : ℤ) :
    let q :=
      -2 * x ^ 11 + 22 * x ^ 9 - 88 * x ^ 7 + 154 * x ^ 5 -
        110 * x ^ 3 + 22 * x + 5
    let pOne :=
      x ^ 5 + x ^ 4 - 4 * x ^ 3 - 3 * x ^ 2 + 3 * x + 1
    let pNine :=
      x ^ 5 - x ^ 4 - 4 * x ^ 3 + 3 * x ^ 2 + 3 * x - 1
    q - 1 = -2 * (x - 2) * pOne ^ 2 ∧
      q - 9 = -2 * (x + 2) * pNine ^ 2 := by
  dsimp
  constructor <;> ring

/-- At index 13, both distinguished fibers of the reduced polynomial are
a linear factor times a square. -/
theorem pellChebyshevReducedThirteen_halfFactors (x : ℤ) :
    let q :=
      -2 * x ^ 13 + 26 * x ^ 11 - 130 * x ^ 9 + 312 * x ^ 7 -
        364 * x ^ 5 + 182 * x ^ 3 - 26 * x + 5
    let pOne :=
      x ^ 6 + x ^ 5 - 5 * x ^ 4 - 4 * x ^ 3 + 6 * x ^ 2 + 3 * x - 1
    let pNine :=
      x ^ 6 - x ^ 5 - 5 * x ^ 4 + 4 * x ^ 3 + 6 * x ^ 2 - 3 * x - 1
    q - 1 = -2 * (x - 2) * pOne ^ 2 ∧
      q - 9 = -2 * (x + 2) * pNine ^ 2 := by
  dsimp
  constructor <;> ring

/-- At index 17, both distinguished fibers of the reduced polynomial are
a linear factor times a square. -/
theorem pellChebyshevReducedSeventeen_halfFactors (x : ℤ) :
    let q :=
      -2 * x ^ 17 + 34 * x ^ 15 - 238 * x ^ 13 + 884 * x ^ 11 -
        1870 * x ^ 9 + 2244 * x ^ 7 - 1428 * x ^ 5 +
        408 * x ^ 3 - 34 * x + 5
    let pOne :=
      x ^ 8 + x ^ 7 - 7 * x ^ 6 - 6 * x ^ 5 + 15 * x ^ 4 +
        10 * x ^ 3 - 10 * x ^ 2 - 4 * x + 1
    let pNine :=
      x ^ 8 - x ^ 7 - 7 * x ^ 6 + 6 * x ^ 5 + 15 * x ^ 4 -
        10 * x ^ 3 - 10 * x ^ 2 + 4 * x + 1
    q - 1 = -2 * (x - 2) * pOne ^ 2 ∧
      q - 9 = -2 * (x + 2) * pNine ^ 2 := by
  dsimp
  constructor <;> ring

#print axioms pellChebyshevReducedEleven_halfFactors
#print axioms pellChebyshevReducedThirteen_halfFactors
#print axioms pellChebyshevReducedSeventeen_halfFactors

end IUTThreeClosures
