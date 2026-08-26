import IUTThreeClosures.FreyAdelicPacketCompensationAudit

/-!
# Scalar core of the Frey multibranch-cancellation audit

The companion note computes all four two-torsion translates of the fixed-field
Pell--Frey point.  Besides the odd bad-fibre row and the archimedean row, it
keeps the good-finite denominator row which is forced by the product formula.

This file verifies the rational coordinate identities, the resulting
three-row slope ledger, its centered deficit matrix, and the sharp positive
weight no-go.  It does not formalize elliptic-curve addition, local Neron
functions, canonical heights, or the paper-level asymptotic calculation.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## The four translated abscissae and the doubled point -/

/-- Adding the two-torsion point at the root `0` sends the displayed
abscissa `2` to `-b/2` in the usual chord formula. -/
theorem pellMultibranch_translateZeroX (b : ℝ) :
    0 + ((0 - 1) * (0 + b)) / (2 - 0) = -b / 2 := by
  ring

/-- Adding the two-torsion point at the root `1` sends `2` to `b+2`. -/
theorem pellMultibranch_translateOneX (b : ℝ) :
    1 + ((1 - 0) * (1 + b)) / (2 - 1) = b + 2 := by
  ring

/-- Adding the two-torsion point at the root `-b` introduces the important
denominator `b+2`. -/
theorem pellMultibranch_translateMinusBX
    (b : ℝ) (hb : b + 2 ≠ 0) :
    -b + ((-b - 0) * (-b - 1)) / (2 - (-b)) =
      -b / (b + 2) := by
  rw [show (2 : ℝ) - (-b) = b + 2 by ring]
  field_simp [hb]
  ring

/-- The tangent formula at the point of abscissa `2` gives the displayed
abscissa of its double. -/
theorem pellMultibranch_doubleX
    (b : ℝ) (hb : b + 2 ≠ 0) :
    (3 * b + 8) ^ 2 / (8 * (b + 2)) - (b - 1) - 4 =
      (b + 4) ^ 2 / (8 * (b + 2)) := by
  field_simp
  ring

/-- On the Pell--Frey family the new denominator is exactly `3*r^2`. -/
theorem pellMultibranch_goodDenominator
    (b r : ℝ) (hb : b = 3 * r ^ 2 - 2) :
    b + 2 = 3 * r ^ 2 := by
  linarith

/-! ## The complete leading-slope ledger

The weights `u,v,w,z` correspond respectively to
`Q`, `Q+T_0`, `Q+T_1`, and `Q+T_{-b}`.  The definitions encode the leading
coefficients of `log b` proved in the companion note.
-/

/-- Odd bad-fibre component slope for a positive weighted collection. -/
def pellMultibranchBadSlope (u v w z : ℝ) : ℝ :=
  u / 3 + (v + w) / 12 - z / 6

/-- Good-finite denominator slope.  Only the `T_{-b}` translate has a
growing denominator. -/
def pellMultibranchGoodSlope (_u _v _w z : ℝ) : ℝ :=
  z / 2

/-- Degree-normalized archimedean Green slope. -/
def pellMultibranchArchSlope (u v w z : ℝ) : ℝ :=
  -u / 12 + (v + w) / 6 - z / 12

/-- Every torsion translate has canonical-height slope `1/4`. -/
def pellMultibranchHeightSlope (u v w z : ℝ) : ℝ :=
  (u + v + w + z) / 4

/-- Bad finite, good finite, and archimedean slopes restore the full
canonical-height slope for every fixed global weighting. -/
theorem pellMultibranch_completeLedger (u v w z : ℝ) :
    pellMultibranchBadSlope u v w z +
        pellMultibranchGoodSlope u v w z +
        pellMultibranchArchSlope u v w z =
      pellMultibranchHeightSlope u v w z := by
  simp only [pellMultibranchBadSlope, pellMultibranchGoodSlope,
    pellMultibranchArchSlope, pellMultibranchHeightSlope]
  ring

/-- The four individual slope rows, ordered as
`Q, Q+T_0, Q+T_1, Q+T_{-b}`. -/
theorem pellMultibranch_individualSlopeTable :
    (pellMultibranchBadSlope 1 0 0 0,
      pellMultibranchGoodSlope 1 0 0 0,
      pellMultibranchArchSlope 1 0 0 0) =
        (1 / 3, 0, -(1 / 12)) ∧
    (pellMultibranchBadSlope 0 1 0 0,
      pellMultibranchGoodSlope 0 1 0 0,
      pellMultibranchArchSlope 0 1 0 0) =
        (1 / 12, 0, 1 / 6) ∧
    (pellMultibranchBadSlope 0 0 1 0,
      pellMultibranchGoodSlope 0 0 1 0,
      pellMultibranchArchSlope 0 0 1 0) =
        (1 / 12, 0, 1 / 6) ∧
    (pellMultibranchBadSlope 0 0 0 1,
      pellMultibranchGoodSlope 0 0 0 1,
      pellMultibranchArchSlope 0 0 0 1) =
        (-(1 / 6), 1 / 2, -(1 / 12)) := by
  norm_num [pellMultibranchBadSlope, pellMultibranchGoodSlope,
    pellMultibranchArchSlope]

/-! ## Centering each row at one quarter of the doubled point -/

/-- Centered odd-bad deficit. -/
def pellMultibranchBadDeficit (u _v _w z : ℝ) : ℝ :=
  (u - z) / 4

/-- Centered good-finite deficit. -/
def pellMultibranchGoodDeficit (u v w z : ℝ) : ℝ :=
  (-u - v - w + 3 * z) / 8

/-- Centered archimedean deficit. -/
def pellMultibranchArchDeficit (u v w z : ℝ) : ℝ :=
  (-u + v + w - z) / 8

/-- Every global weighted column has total centered deficit zero. -/
theorem pellMultibranch_deficitConservation (u v w z : ℝ) :
    pellMultibranchBadDeficit u v w z +
        pellMultibranchGoodDeficit u v w z +
        pellMultibranchArchDeficit u v w z = 0 := by
  simp only [pellMultibranchBadDeficit, pellMultibranchGoodDeficit,
    pellMultibranchArchDeficit]
  ring

/-- The explicit centered matrix.  Its rows are odd bad, good finite, and
archimedean, and its columns are the four translates. -/
theorem pellMultibranch_deficitMatrix :
    (pellMultibranchBadDeficit 1 0 0 0,
      pellMultibranchBadDeficit 0 1 0 0,
      pellMultibranchBadDeficit 0 0 1 0,
      pellMultibranchBadDeficit 0 0 0 1) =
        (1 / 4, 0, 0, -(1 / 4)) ∧
    (pellMultibranchGoodDeficit 1 0 0 0,
      pellMultibranchGoodDeficit 0 1 0 0,
      pellMultibranchGoodDeficit 0 0 1 0,
      pellMultibranchGoodDeficit 0 0 0 1) =
        (-(1 / 8), -(1 / 8), -(1 / 8), 3 / 8) ∧
    (pellMultibranchArchDeficit 1 0 0 0,
      pellMultibranchArchDeficit 0 1 0 0,
      pellMultibranchArchDeficit 0 0 1 0,
      pellMultibranchArchDeficit 0 0 0 1) =
        (-(1 / 8), 1 / 8, 1 / 8, -(1 / 8)) := by
  norm_num [pellMultibranchBadDeficit, pellMultibranchGoodDeficit,
    pellMultibranchArchDeficit]

/-- Averaging all four global columns kills every centered row. -/
theorem pellMultibranch_fullAverageZero (t : ℝ) :
    pellMultibranchBadDeficit t t t t = 0 ∧
    pellMultibranchGoodDeficit t t t t = 0 ∧
    pellMultibranchArchDeficit t t t t = 0 := by
  simp [pellMultibranchBadDeficit, pellMultibranchGoodDeficit,
    pellMultibranchArchDeficit]
  ring

/-- If the archimedean deficits cancel, every retained odd-bad deficit is
paid exactly by the good-finite deficit. -/
theorem pellMultibranch_archDeficitCancellation
    {u v w z : ℝ}
    (harch : pellMultibranchArchDeficit u v w z = 0) :
    pellMultibranchGoodDeficit u v w z =
      -pellMultibranchBadDeficit u v w z := by
  have hzero := pellMultibranch_deficitConservation u v w z
  linarith

/-- In particular, a strict odd-bad surplus and zero archimedean deficit
force a strict adverse good-finite deficit. -/
theorem pellMultibranch_selectedBadForcesGoodLoss
    {u v w z : ℝ}
    (hbad : 0 < pellMultibranchBadDeficit u v w z)
    (harch : pellMultibranchArchDeficit u v w z = 0) :
    pellMultibranchGoodDeficit u v w z < 0 := by
  rw [pellMultibranch_archDeficitCancellation harch]
  linarith

/-! ## Sharp positive-weight no-go -/

/-- With nonnegative multiplicity on the denominator-bearing fourth branch,
a nonnegative leading archimedean sum prevents the selected odd bad term
from exceeding the total canonical height. -/
theorem pellMultibranch_noStrictGain
    {u v w z : ℝ}
    (hz : 0 ≤ z)
    (harch : 0 ≤ pellMultibranchArchSlope u v w z) :
    pellMultibranchBadSlope u v w z ≤
      pellMultibranchHeightSlope u v w z := by
  rw [← pellMultibranch_completeLedger u v w z]
  have hgood : 0 ≤ pellMultibranchGoodSlope u v w z := by
    simp only [pellMultibranchGoodSlope]
    linarith
  linarith

/-- Equality in the preceding bound is rigid: the fourth branch has weight
zero and the archimedean leading slope itself is zero. -/
theorem pellMultibranch_criticalEquality
    {u v w z : ℝ}
    (hz : 0 ≤ z)
    (harch : 0 ≤ pellMultibranchArchSlope u v w z)
    (heq : pellMultibranchBadSlope u v w z =
      pellMultibranchHeightSlope u v w z) :
    z = 0 ∧ pellMultibranchArchSlope u v w z = 0 := by
  have hledger := pellMultibranch_completeLedger u v w z
  have hgood : 0 ≤ pellMultibranchGoodSlope u v w z := by
    simp only [pellMultibranchGoodSlope]
    linarith
  have hgoodZero : pellMultibranchGoodSlope u v w z = 0 := by
    linarith
  constructor
  · simpa [pellMultibranchGoodSlope] using hgoodZero
  · linarith

/-- Equivalently, equality forces the exact critical ratio
`u = 2 * (v+w)` once the fourth weight vanishes. -/
theorem pellMultibranch_criticalWeightRatio
    {u v w z : ℝ}
    (hz : z = 0)
    (harch : pellMultibranchArchSlope u v w z = 0) :
    u = 2 * (v + w) := by
  simp only [pellMultibranchArchSlope] at harch
  rw [hz] at harch
  linarith

/-- The formal critical mixture consists of two copies of the selected
branch and one cross translate.  It reaches equality but gives no strict
margin. -/
theorem pellMultibranch_criticalMixture :
    pellMultibranchBadSlope 2 1 0 0 = 3 / 4 ∧
    pellMultibranchGoodSlope 2 1 0 0 = 0 ∧
    pellMultibranchArchSlope 2 1 0 0 = 0 ∧
    pellMultibranchHeightSlope 2 1 0 0 = 3 / 4 := by
  norm_num [pellMultibranchBadSlope, pellMultibranchGoodSlope,
    pellMultibranchArchSlope, pellMultibranchHeightSlope]

end

end IUTThreeClosures
