import IUTThreeClosures.FreyAsymmetricDivisionBranchAudit
import IUTThreeClosures.FreySameCharacterRankTwoObstruction

/-!
# Scalar core of the adelic packet-compensation audit

The companion paper separates the full Tate local height into its Bernoulli
component and theta/intersection parts, computes a fixed-discriminant Pell
family, and audits the archimedean compensation.  This module proves only the
cycle-free scalar consequences.  It does not assert a local-height formula,
an elliptic-surface height calculation, or an abc inequality.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## The sharp Bernoulli lower bound -/

/-- The Bernoulli polynomial used in the Tate component term. -/
def adelicCompensationBernoulliTwo (x : ℝ) : ℝ :=
  x ^ 2 - x + 1 / 6

/-- Completing the square exposes the sharp minimum `-1/12`. -/
theorem adelicCompensationBernoulliTwo_completedSquare (x : ℝ) :
    adelicCompensationBernoulliTwo x =
      (x - 1 / 2) ^ 2 - 1 / 12 := by
  unfold adelicCompensationBernoulliTwo
  ring

/-- The component Bernoulli polynomial is never below `-1/12`. -/
theorem adelicCompensationBernoulliTwo_lower (x : ℝ) :
    -(1 / 12 : ℝ) ≤ adelicCompensationBernoulliTwo x := by
  rw [adelicCompensationBernoulliTwo_completedSquare]
  nlinarith [sq_nonneg (x - 1 / 2)]

/-- The identity component has Bernoulli value `1/6`. -/
theorem adelicCompensationBernoulliTwo_identity :
    adelicCompensationBernoulliTwo 0 = 1 / 6 := by
  norm_num [adelicCompensationBernoulliTwo]

/-- On a Frey fibre of depth `e`, the identity component contributes `e/6`. -/
theorem freyAdelic_identityComponent (e : ℝ) :
    ((2 * e) / 2) * adelicCompensationBernoulliTwo 0 = e / 6 := by
  rw [adelicCompensationBernoulliTwo_identity]
  ring

/-- Every Frey component contribution is bounded below by `-e/12`. -/
theorem freyAdelic_component_lower
    {e x : ℝ} (he : 0 ≤ e) :
    -(e / 12) ≤ ((2 * e) / 2) * adelicCompensationBernoulliTwo x := by
  have hB := adelicCompensationBernoulliTwo_lower x
  nlinarith

/-- The opposite half-packet attains the lower bound exactly. -/
theorem freyAdelic_oppositeComponent (e : ℝ) :
    ((2 * e) / 2) * adelicCompensationBernoulliTwo (1 / 2) =
      -(e / 12) := by
  norm_num [adelicCompensationBernoulliTwo]
  ring

/-! ## Finite selected-versus-adverse ledger -/

/-- A nonnegative theta term cannot worsen the sharp component lower bound. -/
theorem freyAdelic_localLower_withTheta
    {e component theta : ℝ}
    (hcomponent : -(e / 12) ≤ component)
    (htheta : 0 ≤ theta) :
    -(e / 12) ≤ component + theta := by
  linarith

/-- The scalar form of the odd finite lower bound: selected identity mass is
booked with coefficient `1/6`, every adverse component with coefficient
`-1/12`, and a nonnegative theta total can only improve the result. -/
theorem freyAdelic_finiteLower
    {selectedDepth adverseDepth adverseComponent theta : ℝ}
    (hcomp : -(adverseDepth / 12) ≤ adverseComponent)
    (htheta : 0 ≤ theta) :
    selectedDepth / 6 - adverseDepth / 12 ≤
      selectedDepth / 6 + adverseComponent + theta := by
  linarith

/-- Once the full global ledger is zero-centered, a positive selected deficit
is exactly the negative of its adelic complement. -/
theorem freyAdelic_complement_exact
    {selected complement : ℝ}
    (hzero : selected + complement = 0) :
    complement = -selected := by
  linarith

/-- A strict selected surplus forces a strict negative complement. -/
theorem freyAdelic_complement_negative
    {selected complement : ℝ}
    (hzero : selected + complement = 0)
    (hselected : 0 < selected) :
    complement < 0 := by
  linarith

/-! ## The Pell slope and the coefficient-12 equivalence -/

/-- The fixed-field point used in the paper really has square class `6` on
the Pell--Frey family. -/
theorem pellAdelic_originalPointRadicand (r : ℤ) :
    let b := 3 * r ^ 2 - 2
    (2 : ℤ) * (2 - 1) * (2 + b) = 6 * r ^ 2 :=
  pellFrey_firstRadicand r

/-- The displayed double-angle parametrization preserves the Pell equation. -/
theorem pellAdelic_doubleParametrization
    {p q : ℤ} (hpell : q ^ 2 - 3 * p ^ 2 = 1) :
    (q ^ 2 + 3 * p ^ 2) ^ 2 - 3 * (2 * p * q) ^ 2 = 1 :=
  pellFrey_doubleParametrization hpell

/-- The Pell finite slope minus its archimedean slope is the global slope. -/
theorem pellAdelic_heightLedger :
    (1 / 3 : ℝ) + (-(1 / 12 : ℝ)) = 1 / 4 := by
  norm_num

/-- Equivalently, global slope minus finite slope forces `-1/12`. -/
theorem pellAdelic_archimedeanSlope :
    (1 / 4 : ℝ) - 1 / 3 = -(1 / 12 : ℝ) := by
  norm_num

/-- Exact, error-free coefficient conversion.  A radical lower bound for an
archimedean term of slope `-H/12` is the height bound with coefficient
`12 * kappa`. -/
theorem pellAdelic_criticalCoefficientEquiv
    (H R κ C : ℝ) :
    -(H / 12) ≥ -κ * R - C ↔
      H ≤ 12 * κ * R + 12 * C := by
  constructor <;> intro h <;> linarith

/-- Forward implication with a bounded error in the archimedean asymptotic. -/
theorem pellAdelic_archLower_implies_heightUpper
    {H R κ C C₀ arch : ℝ}
    (herr : |arch + H / 12| ≤ C₀)
    (harch : arch ≥ -κ * R - C) :
    H ≤ 12 * κ * R + 12 * (C + C₀) := by
  have hupper : arch + H / 12 ≤ C₀ :=
    (abs_le.mp herr).2
  linarith

/-- Reverse implication with the bounded error carried explicitly. -/
theorem pellAdelic_heightUpper_implies_archLower
    {H R κ C C₀ arch : ℝ}
    (herr : |arch + H / 12| ≤ C₀)
    (hheight : H ≤ 12 * κ * R + C) :
    arch ≥ -κ * R - (C / 12 + C₀) := by
  have hlower : -C₀ ≤ arch + H / 12 :=
    (abs_le.mp herr).1
  linarith

/-- A fixed normalized field-discriminant cost is only a change of the
bounded constant; it cannot alter the radical coefficient. -/
theorem fixedDiscriminantCost_absorbed
    (arch κ R μ discCost C : ℝ) :
    arch ≥ -κ * R - μ * discCost - C ↔
      arch ≥ -κ * R - (C + μ * discCost) := by
  constructor <;> intro h <;> linarith

end


end IUTThreeClosures
