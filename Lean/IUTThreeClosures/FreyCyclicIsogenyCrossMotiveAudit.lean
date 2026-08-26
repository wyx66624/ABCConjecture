import IUTThreeClosures.FreyAdelicPacketCompensationAudit
import IUTThreeClosures.NeronNodeDihedralConservation

/-!
# Scalar core of the cyclic two-isogeny cross-motive audit

The companion note computes the three cyclic two-isogeny images of the
fixed-field Pell--Frey point.  This file verifies the Bernoulli distribution
identities, the three quotient abscissae, the complete bad/good/archimedean
slope ledger, and the resulting positive-weight no-go.

It does not formalize Tate curves, isogenies, local Neron functions,
canonical heights, or the Pell specialization theorem.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## Local scalar distribution under the three cyclic quotients -/

/-- The identity-kernel quotient doubles the Tate depth and preserves the
normalized component parameter, so its Bernoulli term is the sum of the two
source terms at `u` and `-u`. -/
theorem cyclicIsogeny_identityKernel_bernoulliDistribution
    (n t : ℝ) :
    ((2 * n) / 2) * adelicCompensationBernoulliTwo t =
      2 * ((n / 2) * adelicCompensationBernoulliTwo t) := by
  ring

/-- On the first half of the component circle, quotienting by a
nonidentity component kernel sends `t` to `2t`; the two source Bernoulli
terms add to the target term. -/
theorem cyclicIsogeny_nonidentityKernel_bernoulliDistribution
    (n t : ℝ) :
    (n / 2) * adelicCompensationBernoulliTwo t +
        (n / 2) * adelicCompensationBernoulliTwo (t + 1 / 2) =
      ((n / 2) / 2) * adelicCompensationBernoulliTwo (2 * t) := by
  unfold adelicCompensationBernoulliTwo
  ring

/-- For an identity source point on `I_(2e)`, the identity-kernel quotient
has component contribution `e/3`. -/
theorem cyclicIsogeny_identityKernel_identityValue (e : ℝ) :
    ((4 * e) / 2) * adelicCompensationBernoulliTwo 0 = e / 3 := by
  norm_num [adelicCompensationBernoulliTwo]
  ring

/-- Either nonidentity-kernel quotient has component contribution `e/12`. -/
theorem cyclicIsogeny_nonidentityKernel_identityValue (e : ℝ) :
    (e / 2) * adelicCompensationBernoulliTwo 0 = e / 12 := by
  norm_num [adelicCompensationBernoulliTwo]
  ring

/-- The three quotient identity-component values average back to the
source value `e/6`. -/
theorem cyclicIsogeny_threeIdentityValues_conserve (e : ℝ) :
    e / 3 + e / 12 + e / 12 = 3 * (e / 6) := by
  ring

/-! ## The three quotient-image abscissae on the Pell--Frey family -/

/-- Quotienting by the torsion point at `0` gives image abscissa
`(b+2)/2`. -/
theorem pellCyclicQuotient_zeroImageX
    (b r : ℝ) (hb : b + 2 = 3 * r ^ 2) :
    (6 * r ^ 2) / (2 : ℝ) ^ 2 = (b + 2) / 2 := by
  rw [hb]
  ring

/-- Quotienting by the torsion point at `1` gives image abscissa
`2(b+2)`. -/
theorem pellCyclicQuotient_oneImageX
    (b r : ℝ) (hb : b + 2 = 3 * r ^ 2) :
    (6 * r ^ 2) / ((2 : ℝ) - 1) ^ 2 = 2 * (b + 2) := by
  rw [hb]
  ring

/-- The third quotient image has the growing good-prime denominator
`b+2=3r^2`. -/
theorem pellCyclicQuotient_minusBImageX
    (b r : ℝ) (hb : b + 2 = 3 * r ^ 2)
    (hden : b + 2 ≠ 0) :
    (6 * r ^ 2) / (2 + b) ^ 2 = 2 / (b + 2) := by
  rw [show (2 : ℝ) + b = b + 2 by ring, hb] at ⊢
  have hr : r ^ 2 ≠ 0 := by
    intro hr0
    apply hden
    rw [hb, hr0]
    norm_num
  field_simp [hr]
  ring

/-! ## Complete leading-slope ledger -/

/-- Odd bad-fibre slope for weights on the quotients by
`T_0,T_1,T_{-b}`. -/
def pellCyclicQuotientBadSlope (u v w : ℝ) : ℝ :=
  5 * (u + v) / 12 + w / 6

/-- Growing good-finite denominator slope. -/
def pellCyclicQuotientGoodSlope (_u _v w : ℝ) : ℝ :=
  w / 2

/-- Archimedean Green slope forced by the global height identity. -/
def pellCyclicQuotientArchSlope (u v w : ℝ) : ℝ :=
  (u + v) / 12 - w / 6

/-- Each degree-two isogeny image has canonical-height slope `1/2`. -/
def pellCyclicQuotientHeightSlope (u v w : ℝ) : ℝ :=
  (u + v + w) / 2

/-- All three local rows restore the sum of the three target heights. -/
theorem pellCyclicQuotient_completeLedger (u v w : ℝ) :
    pellCyclicQuotientBadSlope u v w +
        pellCyclicQuotientGoodSlope u v w +
        pellCyclicQuotientArchSlope u v w =
      pellCyclicQuotientHeightSlope u v w := by
  simp only [pellCyclicQuotientBadSlope, pellCyclicQuotientGoodSlope,
    pellCyclicQuotientArchSlope, pellCyclicQuotientHeightSlope]
  ring

/-- The three target rows, ordered by kernels `T_0,T_1,T_{-b}`. -/
theorem pellCyclicQuotient_individualSlopeTable :
    (pellCyclicQuotientBadSlope 1 0 0,
      pellCyclicQuotientGoodSlope 1 0 0,
      pellCyclicQuotientArchSlope 1 0 0,
      pellCyclicQuotientHeightSlope 1 0 0) =
        (5 / 12, 0, 1 / 12, 1 / 2) ∧
    (pellCyclicQuotientBadSlope 0 1 0,
      pellCyclicQuotientGoodSlope 0 1 0,
      pellCyclicQuotientArchSlope 0 1 0,
      pellCyclicQuotientHeightSlope 0 1 0) =
        (5 / 12, 0, 1 / 12, 1 / 2) ∧
    (pellCyclicQuotientBadSlope 0 0 1,
      pellCyclicQuotientGoodSlope 0 0 1,
      pellCyclicQuotientArchSlope 0 0 1,
      pellCyclicQuotientHeightSlope 0 0 1) =
        (1 / 6, 1 / 2, -(1 / 6), 1 / 2) := by
  norm_num [pellCyclicQuotientBadSlope, pellCyclicQuotientGoodSlope,
    pellCyclicQuotientArchSlope, pellCyclicQuotientHeightSlope]

/-! ## Centered cross-motive deficits -/

/-- Odd-bad deviation from the three-motive row average. -/
def pellCyclicQuotientBadDeficit (u v w : ℝ) : ℝ :=
  (u + v - 2 * w) / 12

/-- Good-finite deviation from the three-motive row average. -/
def pellCyclicQuotientGoodDeficit (u v w : ℝ) : ℝ :=
  (-u - v + 2 * w) / 6

/-- Archimedean deviation from its zero row average. -/
def pellCyclicQuotientArchDeficit (u v w : ℝ) : ℝ :=
  (u + v - 2 * w) / 12

/-- In this family the bad and archimedean deviations are identical, while
the good-finite deviation is minus twice either one. -/
theorem pellCyclicQuotient_deficitRigidity (u v w : ℝ) :
    pellCyclicQuotientBadDeficit u v w =
        pellCyclicQuotientArchDeficit u v w ∧
      pellCyclicQuotientGoodDeficit u v w =
        -2 * pellCyclicQuotientBadDeficit u v w := by
  constructor
  · rfl
  · simp only [pellCyclicQuotientBadDeficit,
      pellCyclicQuotientGoodDeficit]
    ring

/-- Cancelling the archimedean deficit also kills every odd-bad surplus
over the three-motive average. -/
theorem pellCyclicQuotient_archDeficitCancellation
    {u v w : ℝ}
    (harch : pellCyclicQuotientArchDeficit u v w = 0) :
    pellCyclicQuotientBadDeficit u v w = 0 := by
  rw [pellCyclicQuotient_deficitRigidity u v w |>.1]
  exact harch

/-- Equal weights cancel both the bad and archimedean deviations. -/
theorem pellCyclicQuotient_equalWeightDeficits (t : ℝ) :
    pellCyclicQuotientBadDeficit t t t = 0 ∧
      pellCyclicQuotientGoodDeficit t t t = 0 ∧
      pellCyclicQuotientArchDeficit t t t = 0 := by
  simp only [pellCyclicQuotientBadDeficit,
    pellCyclicQuotientGoodDeficit, pellCyclicQuotientArchDeficit]
  constructor
  · ring
  constructor <;> ring

/-! ## Positive-weight no-go and sharp boundaries -/

/-- For nonnegative weight on the denominator-bearing quotient, the odd
bad mass is at most `5/6` of the correctly counted target-height cost. -/
theorem pellCyclicQuotient_bad_le_fiveSixths_height
    {u v w : ℝ} (hw : 0 ≤ w) :
    pellCyclicQuotientBadSlope u v w ≤
      (5 / 6) * pellCyclicQuotientHeightSlope u v w := by
  simp only [pellCyclicQuotientBadSlope,
    pellCyclicQuotientHeightSlope]
  linarith

/-- Every nonzero nonnegative collection has strictly more target height
than selected odd-bad mass. -/
theorem pellCyclicQuotient_strictNoGain
    {u v w : ℝ}
    (hw : 0 ≤ w)
    (hnonzero : 0 < u + v + w) :
    pellCyclicQuotientBadSlope u v w <
      pellCyclicQuotientHeightSlope u v w := by
  simp only [pellCyclicQuotientBadSlope,
    pellCyclicQuotientHeightSlope]
  linarith

/-- Exact archimedean cancellation has ratio `2/3`: the bad, good, and
height slopes are respectively `w`, `w/2`, and `3w/2`. -/
theorem pellCyclicQuotient_exactArchCancellation
    {u v w : ℝ}
    (harch : pellCyclicQuotientArchSlope u v w = 0) :
    pellCyclicQuotientBadSlope u v w = w ∧
      pellCyclicQuotientGoodSlope u v w = w / 2 ∧
      pellCyclicQuotientHeightSlope u v w = 3 * w / 2 := by
  simp only [pellCyclicQuotientArchSlope] at harch
  simp only [pellCyclicQuotientBadSlope, pellCyclicQuotientGoodSlope,
    pellCyclicQuotientHeightSlope]
  constructor
  · linarith
  constructor
  · trivial
  · linarith

/-- With all three quotient motives used once, the archimedean slopes cancel
but the odd bad mass is only two thirds of the total height. -/
theorem pellCyclicQuotient_allThreeBoundary :
    pellCyclicQuotientBadSlope 1 1 1 = 1 ∧
      pellCyclicQuotientGoodSlope 1 1 1 = 1 / 2 ∧
      pellCyclicQuotientArchSlope 1 1 1 = 0 ∧
      pellCyclicQuotientHeightSlope 1 1 1 = 3 / 2 := by
  norm_num [pellCyclicQuotientBadSlope, pellCyclicQuotientGoodSlope,
    pellCyclicQuotientArchSlope, pellCyclicQuotientHeightSlope]

end

end IUTThreeClosures
