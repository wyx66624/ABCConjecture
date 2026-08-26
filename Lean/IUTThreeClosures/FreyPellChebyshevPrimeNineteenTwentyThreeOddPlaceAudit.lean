import IUTThreeClosures.FreyPellChebyshevUniformSelmerExactResidual

/-!
# Prime 19/23 Chebyshev odd-place audit: scalar kernel

The companion note records an unconditional PARI/Magma certificate at index
`19` and a conditional pattern diagnostic at index `23`.  This file checks
only polynomial and dimension arithmetic copied from that note.

It does not formalize class groups, number fields, local Kummer maps,
Jacobians, Selmer groups, PARI, or Magma.  In particular it proves neither
the missing dyadic rank statement nor either fixed-index Diophantine
exclusion.
-/

namespace IUTThreeClosures

/-- The exact PARI discriminant output equals the pure-field formula at 19. -/
theorem pellChebyshevNineteen_pureFieldDiscriminant :
    -(2 : ℤ) ^ 18 * 19 ^ 19 = -518630842213417245507316350976 := by
  norm_num

/-- The two half-factor identities for the reduced index-19 curve. -/
theorem pellChebyshevReducedNineteen_halfFactors (x : ℤ) :
    let q :=
      -2 * x ^ 19 + 38 * x ^ 17 - 304 * x ^ 15 + 1330 * x ^ 13 -
        3458 * x ^ 11 + 5434 * x ^ 9 - 5016 * x ^ 7 +
        2508 * x ^ 5 - 570 * x ^ 3 + 38 * x + 5
    let pOne :=
      x ^ 9 + x ^ 8 - 8 * x ^ 7 - 7 * x ^ 6 + 21 * x ^ 5 +
        15 * x ^ 4 - 20 * x ^ 3 - 10 * x ^ 2 + 5 * x + 1
    let pNine :=
      x ^ 9 - x ^ 8 - 8 * x ^ 7 + 7 * x ^ 6 + 21 * x ^ 5 -
        15 * x ^ 4 - 20 * x ^ 3 + 10 * x ^ 2 + 5 * x - 1
    q - 1 = -2 * (x - 2) * pOne ^ 2 ∧
      q - 9 = -2 * (x + 2) * pNine ^ 2 := by
  dsimp
  constructor <;> ring

/-- If the norm space has dimension `g+r-1` and the odd local quotient has
dimension `r-1`, full odd localization leaves exactly genus dimension. -/
theorem pellChebyshev_oddPlaceFullRank_dimension
    (g r : ℕ) (hr : 1 ≤ r) :
    (g + r - 1) - (r - 1) = g := by
  omega

/-- Scalar ledger copied from the unconditional index-19 computation. -/
theorem pellChebyshevNineteen_oddPlaceLedger :
    (14 - 4 : ℕ) = 10 ∧ (10 - 1 : ℕ) = 9 ∧ (19 - 1) / 2 = 9 := by
  norm_num

/-- Scalar ledger copied from the conditional index-23 pattern diagnostic. -/
theorem pellChebyshevTwentyThree_oddPlaceLedger :
    (17 - 4 : ℕ) = 13 ∧ (13 - 2 : ℕ) = 11 ∧ (23 - 1) / 2 = 11 := by
  norm_num

/-- Rank-nullity arithmetic: on a genus-size survivor, proving that the
forced two-plane is the complete kernel requires rank `g-2`. -/
theorem pellChebyshev_dyadicRank_of_kernelTwo
    (g rank : ℕ) (hg : 2 ≤ g) (hRankNullity : rank + 2 = g) :
    rank = g - 2 := by
  omega

/-- The fixed numerical dyadic ranks demanded at indices 19 and 23. -/
theorem pellChebyshevNineteenTwentyThree_requiredDyadicRanks :
    (9 - 2 : ℕ) = 7 ∧ (11 - 2 : ℕ) = 9 := by
  norm_num

#print axioms pellChebyshevNineteen_pureFieldDiscriminant
#print axioms pellChebyshevReducedNineteen_halfFactors
#print axioms pellChebyshev_oddPlaceFullRank_dimension
#print axioms pellChebyshevNineteen_oddPlaceLedger
#print axioms pellChebyshevTwentyThree_oddPlaceLedger
#print axioms pellChebyshev_dyadicRank_of_kernelTwo
#print axioms pellChebyshevNineteenTwentyThree_requiredDyadicRanks

end IUTThreeClosures
