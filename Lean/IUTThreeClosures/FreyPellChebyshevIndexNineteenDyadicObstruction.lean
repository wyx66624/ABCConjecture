import IUTThreeClosures.FreyPellChebyshevPrimeNineteenTwentyThreeOddPlaceAudit

/-!
# Prime-nineteen dyadic obstruction: scalar trust boundary

The companion Magma certificate computes the complete dyadic Kummer image
and finds a three-dimensional intersection with the frozen odd-place survivor.
Thus the previously requested quotient rank `7` is false: the exact quotient
rank is `6`, and the resulting 2-Selmer dimension is `3`.

This file checks only the integer polynomial identities and the scalar
rank-nullity arithmetic copied from that external transcript.  It does not
reimplement number fields, local fields, Hilbert symbols, Kummer maps,
Jacobians, Selmer groups, PARI, or Magma.  No external computation is inserted
as a Lean axiom.
-/

namespace IUTThreeClosures

/-! ## Exact horizontal sections -/

/-- The two exact horizontal identities supplying the rational local divisor
classes `D₁` and `D₉` on the monic genus-nine model. -/
theorem pellChebyshevNineteen_monicHorizontalIdentities (x : ℤ) :
    let fm :=
      x ^ 19 - 76 * x ^ 17 + 2432 * x ^ 15 - 42560 * x ^ 13 +
        442624 * x ^ 11 - 2782208 * x ^ 9 + 10272768 * x ^ 7 -
          20545536 * x ^ 5 + 18677760 * x ^ 3 - 4980736 * x + 1310720
    let U1 :=
      x ^ 9 - 2 * x ^ 8 - 32 * x ^ 7 + 56 * x ^ 6 + 336 * x ^ 5 -
        480 * x ^ 4 - 1280 * x ^ 3 + 1280 * x ^ 2 + 1280 * x - 512
    let U9 :=
      x ^ 9 + 2 * x ^ 8 - 32 * x ^ 7 - 56 * x ^ 6 + 336 * x ^ 5 +
        480 * x ^ 4 - 1280 * x ^ 3 - 1280 * x ^ 2 + 1280 * x + 512
    fm - 512 ^ 2 = (x + 4) * U1 ^ 2 ∧
      fm - 1536 ^ 2 = (x - 4) * U9 ^ 2 := by
  dsimp
  constructor <;> ring

/-! ## Dimension ledgers -/

/-- The local squareclass, norm-kernel, local Kummer, and intersection
dimensions copied from the exact dyadic certificate. -/
theorem pellChebyshevNineteen_dyadicDimensionLedger :
    (21 - 3 : ℕ) = 18 ∧
      (19 - 1) / 2 = 9 ∧
      (9 + 9 - 15 : ℕ) = 3 ∧
      (15 - 9 : ℕ) = 6 := by
  norm_num

/-- Rank-nullity exposes the strict reversal of the proposed rank-seven
statement: a three-dimensional kernel in a nine-dimensional source has rank
six, whereas a two-dimensional kernel would have rank seven. -/
theorem pellChebyshevNineteen_rankSix_not_rankSeven :
    (9 - 3 : ℕ) = 6 ∧
      (9 - 2 : ℕ) = 7 ∧
      (9 - 3 : ℕ) ≠ 7 := by
  norm_num

/-- The displayed extra coefficient has nonzero entries away from both
endpoint coordinates.  This is only a scalar witness; its membership in the
dyadic intersection is part of the external exact matrix certificate. -/
theorem pellChebyshevNineteen_extraCoefficientLedger :
    let extra : List ℕ := [0, 1, 1, 1, 0, 0, 1, 1, 0]
    extra.length = 9 ∧ extra[1]? = some 1 ∧ extra[6]? = some 1 := by
  norm_num

/-- Once the external Selmer computation gives dimension three and the two
known rational classes give the lower bound, the only possible Mordell--Weil
ranks are two and three. -/
theorem pellChebyshevNineteen_rankDichotomy
    (rank : ℕ) (lower : 2 ≤ rank) (upper : rank ≤ 3) :
    rank = 2 ∨ rank = 3 := by
  omega

/-- Classical Chabauty's numerical inequality remains available even in the
larger of the two possible rank cases. -/
theorem pellChebyshevNineteen_chabautyDimensionLedger : (3 : ℕ) < 9 := by
  norm_num

#print axioms pellChebyshevNineteen_monicHorizontalIdentities
#print axioms pellChebyshevNineteen_dyadicDimensionLedger
#print axioms pellChebyshevNineteen_rankSix_not_rankSeven
#print axioms pellChebyshevNineteen_extraCoefficientLedger
#print axioms pellChebyshevNineteen_rankDichotomy
#print axioms pellChebyshevNineteen_chabautyDimensionLedger

end IUTThreeClosures
