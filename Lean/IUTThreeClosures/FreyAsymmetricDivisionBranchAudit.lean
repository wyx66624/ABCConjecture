import IUTThreeClosures.FreyDivisionHeightConservation

/-!
# A scalar audit of asymmetric division branches on a Frey--Tate fibre

This module isolates the algebra that is needed when one follows one
division branch rather than averaging all `m^2` branches.

The paper companion proves the arithmetic statements about Tate
uniformization, local fields, Galois packets, discriminants, and global
canonical heights.  Here we check only the cycle-free scalar core:

* an orbit containing `d` equally weighted component packets has identity
  Bernoulli coefficient `1 / d^2` times the original coefficient;
* the multiplicity inside each packet (local degree, roots of unity, or
  identity-direction conjugates) cancels from the normalized average;
* relative to the `1 / m^2` canonical-height scaling, a packet image of
  order `d` gives the exact gain `(m / d)^2`;
* for halving, a single identity packet retains `e / 6`, whereas the two
  component packets average to `e / 24`;
* globally aligning the two signed square roots at a retained divisor has
  a quadratic elementary height cost.

No declaration below asserts the existence of a global division point or
of a simultaneous small-packet selector.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## Partial component-packet orbits -/

/-- The second Bernoulli polynomial appearing in the component term of a
Tate local height. -/
def asymmetricDivisionBernoulliTwo (x : ℝ) : ℝ :=
  x ^ 2 - x + 1 / 6

/-- The Bernoulli multiplication formula applied to the number `d` of
component packets actually occurring in one algebraic orbit.  The parameter
`x` records the coset of that packet subgroup. -/
theorem packetCoset_bernoulliSum
    (d : ℕ) (hd : 0 < d) (x : ℝ) :
    ∑ t ∈ Finset.range d,
        asymmetricDivisionBernoulliTwo
          ((x + (t : ℝ)) / (d : ℝ)) =
      asymmetricDivisionBernoulliTwo x / (d : ℝ) := by
  simpa [asymmetricDivisionBernoulliTwo, freyDivisionBernoulliTwo] using
    freyDivisionBernoulliTwo_divisionDistribution d hd x

/-- For the subgroup of `d` equally spaced component packets above the
identity component, the Bernoulli sum is `1 / (6d)`.  Unlike the full
`m`-branch formula, `d` is the size of the component image of the one
global branch being followed. -/
theorem identityPacket_bernoulliSum
    (d : ℕ) (hd : 0 < d) :
    ∑ t ∈ Finset.range d,
        asymmetricDivisionBernoulliTwo ((t : ℝ) / (d : ℝ)) =
      1 / (6 * (d : ℝ)) := by
  calc
    (∑ t ∈ Finset.range d,
        asymmetricDivisionBernoulliTwo ((t : ℝ) / (d : ℝ))) =
        asymmetricDivisionBernoulliTwo 0 / (d : ℝ) := by
          simpa only [zero_add] using
            packetCoset_bernoulliSum d hd 0
    _ = 1 / (6 * (d : ℝ)) := by
      have hdR : (d : ℝ) ≠ 0 := by positivity
      unfold asymmetricDivisionBernoulliTwo
      field_simp
      ring

/-- The normalized component coefficient of a uniformly weighted packet
coset.  Substituting `x = r / s` gives the paper formula
`B₂(r/s) / d²`. -/
theorem packetCoset_componentAverage
    (d : ℕ) (hd : 0 < d) (x tateScale : ℝ) :
    (∑ t ∈ Finset.range d,
        (tateScale / 2) *
          asymmetricDivisionBernoulliTwo
            ((x + (t : ℝ)) / (d : ℝ))) /
        (d : ℝ) =
      ((tateScale / 2) * asymmetricDivisionBernoulliTwo x) /
        (d : ℝ) ^ 2 := by
  rw [← Finset.mul_sum]
  rw [packetCoset_bernoulliSum d hd x]
  have hdR : (d : ℝ) ≠ 0 := by positivity
  field_simp

/-- The degree-normalized component coefficient for a uniform orbit of
`d` identity-subgroup packets is the original identity coefficient divided
by `d^2`. -/
theorem identityPacket_componentAverage
    (d : ℕ) (hd : 0 < d) (tateScale : ℝ) :
    (∑ t ∈ Finset.range d,
        (tateScale / 2) *
          asymmetricDivisionBernoulliTwo ((t : ℝ) / (d : ℝ))) /
        (d : ℝ) =
      (tateScale / 12) / (d : ℝ) ^ 2 := by
  rw [← Finset.mul_sum]
  rw [identityPacket_bernoulliSum d hd]
  have hdR : (d : ℝ) ≠ 0 := by positivity
  field_simp
  ring

/-- Repeating every component packet with the same positive multiplicity
does not alter its degree-normalized average.  This is the scalar reason
that local degree and roots-of-unity multiplicity must not be confused with
the number `d` of distinct component packets. -/
theorem uniformPacketMultiplicity_cancels
    (d multiplicity : ℕ) (hd : 0 < d) (hmul : 0 < multiplicity)
    (packetSum : ℝ) :
    ((multiplicity : ℝ) * packetSum) /
        ((d : ℝ) * (multiplicity : ℝ)) =
      packetSum / (d : ℝ) := by
  have hdR : (d : ℝ) ≠ 0 := by positivity
  have hmulR : (multiplicity : ℝ) ≠ 0 := by positivity
  field_simp

/-- With both the packet sum and its common multiplicity displayed, the
normalized coefficient still depends only on the component-image size
`d`. -/
theorem identityPacket_degreeNormalizedAverage
    (d multiplicity : ℕ) (hd : 0 < d) (hmul : 0 < multiplicity)
    (tateScale : ℝ) :
    ((multiplicity : ℝ) *
        (∑ t ∈ Finset.range d,
          (tateScale / 2) *
            asymmetricDivisionBernoulliTwo ((t : ℝ) / (d : ℝ)))) /
        ((d : ℝ) * (multiplicity : ℝ)) =
      (tateScale / 12) / (d : ℝ) ^ 2 := by
  rw [uniformPacketMultiplicity_cancels d multiplicity hd hmul]
  exact identityPacket_componentAverage d hd tateScale

/-! ## Exact gain relative to canonical-height scaling -/

/-- If `[m]Q=P`, global canonical height scales by `1 / m^2`.  A component
orbit of order `d` scales only by `1 / d^2`, so the exact relative gain is
`(m/d)^2`. -/
theorem asymmetricPacket_exactGain
    (m d : ℕ) (hm : 0 < m) (hd : 0 < d) (tateScale : ℝ) :
    (tateScale / 12) / (d : ℝ) ^ 2 =
      ((m : ℝ) / (d : ℝ)) ^ 2 *
        ((tateScale / 12) / (m : ℝ) ^ 2) := by
  have hmR : (m : ℝ) ≠ 0 := by positivity
  have hdR : (d : ℝ) ≠ 0 := by positivity
  field_simp

/-- When `d ≤ m`, the asymmetric packet coefficient is at least the
full-branch average for every nonnegative Tate scale. -/
theorem asymmetricPacket_ge_fullAverage
    (m d : ℕ) (hm : 0 < m) (hd : 0 < d) (hdm : d ≤ m)
    {tateScale : ℝ} (hscale : 0 ≤ tateScale) :
    (tateScale / 12) / (m : ℝ) ^ 2 ≤
      (tateScale / 12) / (d : ℝ) ^ 2 := by
  have hmR : 0 < (m : ℝ) := by positivity
  have hdR : 0 < (d : ℝ) := by positivity
  have hdmR : (d : ℝ) ≤ (m : ℝ) := by exact_mod_cast hdm
  have hsq : (d : ℝ) ^ 2 ≤ (m : ℝ) ^ 2 := by nlinarith
  exact div_le_div_of_nonneg_left (by positivity) (by positivity) hsq

/-- A genuinely single identity packet has no component decay at all. -/
theorem singleIdentityPacket_noComponentDecay (tateScale : ℝ) :
    (tateScale / 2) * asymmetricDivisionBernoulliTwo 0 =
      tateScale / 12 := by
  unfold asymmetricDivisionBernoulliTwo
  ring

/-! ## The halving dichotomy -/

/-- For an `I_(2e)` fibre, an identity half contributes `e/6`, while an
opposite-component half contributes `-e/12`; a two-packet global orbit has
the normalized value `e/24`. -/
theorem halfTwoPacket_componentAverage (weightedDepth : ℝ) :
    (weightedDepth / 6 + (-weightedDepth / 12)) / 2 =
      weightedDepth / 24 := by
  ring

/-- A single identity half retains four times the two-packet normalized
component value. -/
theorem halfSinglePacket_fourfoldGain (weightedDepth : ℝ) :
    weightedDepth / 6 = 4 * (weightedDepth / 24) := by
  ring

/-- The opposite half is not a small positive contribution: its component
term is exactly minus one half of the identity term. -/
theorem halfOppositePacket_signCost (weightedDepth : ℝ) :
    -weightedDepth / 12 = -(1 / 2) * (weightedDepth / 6) := by
  ring

/-- The four sign patterns of a full-two-torsion half recover all three
pair products.  This is the scalar linear algebra behind the paper claim
that the field of one half (hence of all its rational two-torsion
translates) contains the component-controlling square-root ratios. -/
theorem halfTranslationSums_recoverPairProducts (A B C : ℝ) :
    (((A + B + C) + (A - B - C)) / 2 = A) ∧
    (((A + B + C) + (-A + B - C)) / 2 = B) ∧
    (((A + B + C) + (-A - B + C)) / 2 = C) := by
  constructor
  · ring
  constructor <;> ring

/-! ## Elementary cost of globally aligning the two square roots -/

/-- Suppose signed roots `r,s` satisfy `r^2=j` and `s^2=j-source`.
If a retained positive divisor is forced into the identity sign
`r-s`, then its square is at most `4j`.  Thus retaining a divisor of
size `A` by a globally fixed square-root sign forces `j ≥ A^2/4`.

This is only an elementary archimedean/naive-height obstruction.  It does
not identify naive height with canonical height. -/
theorem alignedHalf_retainedDivisor_quadraticCost
    {source j r s retained : ℝ}
    (hsource : 0 ≤ source)
    (hretained : 0 ≤ retained)
    (hr : r ^ 2 = j)
    (hs : s ^ 2 = j - source)
    (halign : retained ≤ |r - s|) :
    retained ^ 2 ≤ 4 * j := by
  have hsle : s ^ 2 ≤ r ^ 2 := by
    rw [hr, hs]
    linarith
  have hsum : 0 ≤ (r + s) ^ 2 := sq_nonneg (r + s)
  have hdiff : (r - s) ^ 2 ≤ 4 * r ^ 2 := by
    nlinarith
  have habs_nonneg : 0 ≤ |r - s| := abs_nonneg (r - s)
  have hret_sq : retained ^ 2 ≤ |r - s| ^ 2 := by
    nlinarith
  have habs_sq : |r - s| ^ 2 = (r - s) ^ 2 := by
    rw [sq_abs]
  rw [habs_sq] at hret_sq
  rw [← hr]
  linarith

/-- Full sign alignment at a positive source of size `source` already
forces the same quadratic cost. -/
theorem alignedHalf_fullSource_quadraticCost
    {source j r s : ℝ}
    (hsource : 0 ≤ source)
    (hr : r ^ 2 = j)
    (hs : s ^ 2 = j - source)
    (halign : source ≤ |r - s|) :
    source ^ 2 ≤ 4 * j := by
  exact alignedHalf_retainedDivisor_quadraticCost
    hsource hsource hr hs halign

end

end IUTThreeClosures
