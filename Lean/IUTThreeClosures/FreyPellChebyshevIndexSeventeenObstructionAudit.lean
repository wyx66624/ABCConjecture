import IUTThreeClosures.FreyPellChebyshevUniformTwoDescentAudit

/-!
# Index-seventeen Chebyshev obstruction audit: scalar kernel

The companion audit note records exact external PARI/GP, Magma, and SageMath
computations for the genus-eight curve at index `17`.  This file checks only
two small integer ledgers copied from the Sage Frobenius transcript:

* the `67`-Weil reciprocal coefficient relations for the displayed degree-16
  polynomial;
* the middle coefficient modulo `67`, which is the scalar ordinarity test.

It does **not** formalize finite-field Jacobians, Frobenius, irreducibility,
resultants, cyclotomic polynomials, endomorphism algebras, Néron--Severi
groups, specialization, real multiplication, Selmer groups, local Kummer
maps, or Chabauty.  In particular it asserts neither a rank upper bound nor
the elimination of the index-seventeen residual.
-/

namespace IUTThreeClosures

/-- The coefficient pairs in the exact Sage polynomial at `67` satisfy the
degree-16 Weil reciprocity ledger.  The middle coefficient is unpaired. -/
theorem pellChebyshevSeventeen_frobenius67_reciprocityLedger :
    (406067677556641 : ℤ) = 67 ^ 8 ∧
      (12121423210646 : ℤ) = 2 * 67 ^ 7 ∧
      (27499348179376 : ℤ) = 304 * 67 ^ 6 ∧
      (1017994330678 : ℤ) = 754 * 67 ^ 5 ∧
      (1031011954844 : ℤ) = 51164 * 67 ^ 4 ∧
      (36135471398 : ℤ) = 120146 * 67 ^ 3 ∧
      (25459381456 : ℤ) = 5671504 * 67 ^ 2 ∧
      (813010294 : ℤ) = 12134482 * 67 := by
  norm_num

/-- The exact middle Frobenius coefficient is nonzero modulo `67`; the
external note explains why this is the ordinary-reduction criterion. -/
theorem pellChebyshevSeventeen_frobenius67_middleMod :
    (446805222 : ℤ) % 67 = 44 := by
  norm_num

/-- Re-export the already checked pair of rational half-factor identities so
the fixed-index trust boundary can be inspected from this scalar file. -/
theorem pellChebyshevSeventeen_halfFactors (x : ℤ) :
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
      q - 9 = -2 * (x + 2) * pNine ^ 2 :=
  pellChebyshevReducedSeventeen_halfFactors x

#print axioms pellChebyshevSeventeen_frobenius67_reciprocityLedger
#print axioms pellChebyshevSeventeen_frobenius67_middleMod
#print axioms pellChebyshevSeventeen_halfFactors

end IUTThreeClosures
