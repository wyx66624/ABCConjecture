import IUTThreeClosures.FreyPellChebyshevIndexNineteenDyadicObstruction

/-!
# Prime-nineteen Selmer--Chabauty boundary: scalar companion

The external Sage transcript computes two known Coleman logarithms at 5 and
the external Magma transcript computes the curve's singleton fake 2-Selmer
set.  This file checks only copied finite-field arithmetic, elementary local
counterexamples, cover-degree arithmetic, and the final point-count case
split.  It does not formalize Coleman integration, Selmer groups, Jacobians,
or the Magma/Sage calculations, and it does not assert a complete list of
rational points.
-/

namespace IUTThreeClosures

/-- With genus nine and Mordell--Weil rank at most three, a true annihilator
has dimension at least six.  The two known logarithms cut out a
seven-dimensional ambient annihilator. -/
theorem pellChebyshevNineteen_unknownGeneratorDimensionLedger :
    (9 - 3 : ℕ) = 6 ∧ (9 - 2 : ℕ) = 7 ∧ (7 - 1 : ℕ) = 6 := by
  norm_num

/-- The two copied reduced logarithm rows annihilate all five displayed
witness numerators.  These scalar divisibilities are the finite-field
membership checks performed again by the Sage certificate. -/
theorem pellChebyshevNineteen_modFiveWitnessMembershipLedger :
    15 % 5 = 0 ∧ 10 % 5 = 0 ∧
      35 % 5 = 0 ∧ 25 % 5 = 0 ∧
      35 % 5 = 0 ∧ 20 % 5 = 0 ∧
      25 % 5 = 0 ∧ 15 % 5 = 0 := by
  norm_num

/-- For the all-disc witness `1 + 3*x^8`, the values at `0, 1, -1` and
infinity are respectively `1, 4, 4, 3` modulo five. -/
theorem pellChebyshevNineteen_allDiscWitnessLedger :
    1 % 5 = 1 ∧ 4 % 5 = 4 ∧ 196609 % 5 = 4 ∧ 3 % 5 = 3 := by
  norm_num

/-- Columns zero and one of the two known reduced logarithm rows give a
unit minor.  It permits an exact characteristic-zero lift of the all-disc
witness that annihilates both known logarithms while preserving reduction. -/
theorem pellChebyshevNineteen_knownLogUnitMinorLedger :
    (3 * 3 - 3 * 1 : ℕ) % 5 = 1 := by
  norm_num

/-- The exceptional affine witnesses vanish at `x=1` and `x=-1=4`, with
nonzero first derivatives; the Weierstrass and infinity witnesses have the
copied first nonzero coefficients. -/
theorem pellChebyshevNineteen_exceptionalOrderLedger :
    10 % 5 = 0 ∧ 61 % 5 = 1 ∧
      246785 % 5 = 0 ∧ 480256 % 5 = 1 ∧
      1 % 5 = 1 ∧ 4 % 5 = 4 := by
  norm_num

/-- Reduction order does not imply uniqueness after lifting.  The first
primitive has two distinct roots in `5*Z_5`; the second has three.  The
identities are checked over the rationals, so no p-adic implementation is
hidden here. -/
theorem pellChebyshevNineteen_reducedOrderLiftCounterexamples :
    (5 : ℚ) * (-10) + (-10) ^ 2 / 2 = 0 ∧
      (-10 : ℚ) ≠ 0 ∧
      (5 : ℚ) ^ 3 - 25 * 5 = 0 ∧
      (-5 : ℚ) ^ 3 - 25 * (-5) = 0 := by
  norm_num

/-- Multiplication by two is invertible modulo 25 and 125.  This is the
scalar shadow of why a mod-2 Kummer coset at the good odd prime 5 contains
an unrestricted formal-group neighbourhood. -/
theorem pellChebyshevNineteen_twoUnitAtFivePowerLedger :
    (2 * 13) % 25 = 1 ∧ (2 * 63) % 125 = 1 := by
  norm_num

/-- The four possible exceptional residue types all give the same upper
bound seven.  The terms account respectively for the two affine conjugate
types, the Weierstrass disc, and the infinity disc. -/
theorem pellChebyshevNineteen_atMostSevenCaseLedger :
    2 * 2 + 2 + 1 = 7 ∧
      2 + 2 + 2 + 1 = 7 ∧
      2 + 2 + 0 + 3 = 7 := by
  norm_num

/-- A formalized version of the last combinatorial step.  Each disjunct is
one possible exceptional type (or no exceptional type).  The analytic
hypothesis producing the disjunction belongs to the external Coleman
certificate, not to this scalar companion. -/
theorem pellChebyshevNineteen_pointCount_of_residueBounds
    (nInf nW nPlus nMinus : ℕ)
    (hcases :
      (nInf ≤ 1 ∧ nW = 0 ∧ nPlus ≤ 2 ∧ nMinus ≤ 2) ∨
      (nInf ≤ 1 ∧ nW = 0 ∧ nPlus ≤ 4 ∧ nMinus ≤ 2) ∨
      (nInf ≤ 1 ∧ nW = 0 ∧ nPlus ≤ 2 ∧ nMinus ≤ 4) ∨
      (nInf ≤ 1 ∧ nW ≤ 2 ∧ nPlus ≤ 2 ∧ nMinus ≤ 2) ∨
      (nInf ≤ 3 ∧ nW = 0 ∧ nPlus ≤ 2 ∧ nMinus ≤ 2)) :
    nInf + nW + nPlus + nMinus ≤ 7 := by
  rcases hcases with h | h | h | h | h <;> omega

/-- If at most two points remain beyond the five visible points and affine
points occur in hyperelliptic-conjugate pairs, the total is five or seven. -/
theorem pellChebyshevNineteen_fiveOrSeven_of_pairing
    (extra : ℕ) (hbound : extra ≤ 2) (hpair : Even extra) :
    extra = 0 ∨ extra = 2 := by
  obtain ⟨k, rfl⟩ := hpair
  omega

/-- The neutral full `[2]`-pullback has degree `2^(2g)` and the displayed
unramified-cover genus. -/
theorem pellChebyshevNineteen_neutralCoverGenusLedger :
    2 ^ (2 * 9) = 262144 ∧
      1 + 2 ^ 18 * (9 - 1) = 2097153 := by
  norm_num

/-- The visible fibres `X=4` and `X=-4` of the pure-field conic equation are the
squares `(a+1)^2` and `(a-1)^2`. -/
theorem pellChebyshevNineteen_visibleNeutralCoverFibres (a : ℚ) :
    a ^ 2 + (4 / 2 : ℚ) * a + 1 = (a + 1) ^ 2 ∧
      a ^ 2 + ((-4) / 2 : ℚ) * a + 1 = (a - 1) ^ 2 := by
  constructor <;> ring

/-- A three-dimensional 2-Selmer group and rank two or three leave exactly
the scalar alternatives `dim Sha[2]=1` and `dim Sha[2]=0`.  Selecting one
requires arithmetic input not present in this file. -/
theorem pellChebyshevNineteen_selmerRankAlternativeLedger :
    (3 - 2 : ℕ) = 1 ∧ (3 - 3 : ℕ) = 0 := by
  norm_num

/-- Scalar shadow of the finite-level Cassels--Tate argument.  A pairing
rank at most one that is even must vanish.  In the external arithmetic, the
rank bound comes from a two-dimensional known Mordell--Weil subspace inside
the radical of an alternating pairing on the three-dimensional 2-Selmer
group; its zero radical quotient says every class has a 4-Selmer lift. -/
theorem pellChebyshevNineteen_forcedFourLiftRankLedger
    (pairingRank : ℕ) (hsmall : pairingRank ≤ 1)
    (heven : Even pairingRank) : pairingRank = 0 := by
  obtain ⟨k, rfl⟩ := heven
  omega

#print axioms pellChebyshevNineteen_unknownGeneratorDimensionLedger
#print axioms pellChebyshevNineteen_modFiveWitnessMembershipLedger
#print axioms pellChebyshevNineteen_allDiscWitnessLedger
#print axioms pellChebyshevNineteen_knownLogUnitMinorLedger
#print axioms pellChebyshevNineteen_exceptionalOrderLedger
#print axioms pellChebyshevNineteen_reducedOrderLiftCounterexamples
#print axioms pellChebyshevNineteen_twoUnitAtFivePowerLedger
#print axioms pellChebyshevNineteen_atMostSevenCaseLedger
#print axioms pellChebyshevNineteen_pointCount_of_residueBounds
#print axioms pellChebyshevNineteen_fiveOrSeven_of_pairing
#print axioms pellChebyshevNineteen_neutralCoverGenusLedger
#print axioms pellChebyshevNineteen_visibleNeutralCoverFibres
#print axioms pellChebyshevNineteen_selmerRankAlternativeLedger
#print axioms pellChebyshevNineteen_forcedFourLiftRankLedger

end IUTThreeClosures
