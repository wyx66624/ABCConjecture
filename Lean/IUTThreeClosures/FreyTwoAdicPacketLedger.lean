import Mathlib

/-!
# Scalar core of the Frey two-adic packet ledger

The companion note classifies the minimal model of
`y^2 = x (x-a) (x+b)` at `2`, applies Tate's algorithm, and identifies the
component corrections through the relevant inverse Cartan matrices.  This
module proves only the resulting scalar identities.  It does not assert a
Kodaira classification, a Neron local-height formula, or component membership
of a point.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## The two minimal-model branches -/

/-- Multiplicative cycle length after the scale-two minimalization. -/
def freyTwoAdicMultiplicativeIndex (e : ℝ) : ℝ :=
  2 * e - 8

/-- Star index of the branch which remains additive. -/
def freyTwoAdicStarIndex (e : ℝ) : ℝ :=
  2 * e - 4

/-- Scaling a Weierstrass equation by `2` lowers the discriminant valuation
by `12`. -/
theorem freyTwoAdic_semistableDiscriminantShift (e : ℝ) :
    (4 + 2 * e) - 12 = freyTwoAdicMultiplicativeIndex e := by
  simp [freyTwoAdicMultiplicativeIndex]
  ring

/-- The additive-star branch has wild defect `2`: its minimal discriminant
valuation is `n + 8`, not the tame value `n + 6`. -/
theorem freyTwoAdic_starWildDiscriminant (e : ℝ) :
    freyTwoAdicStarIndex e + 8 = 2 * e + 4 := by
  simp [freyTwoAdicStarIndex]
  ring

/-- Both large-depth branches have the same potentially multiplicative Tate
depth `-v_2(j) = 2e-8`. -/
theorem freyTwoAdic_potentialTateDepth (e : ℝ) :
    (2 * e + 4) - 3 * 4 = freyTwoAdicMultiplicativeIndex e := by
  simp [freyTwoAdicMultiplicativeIndex]
  ring

/-! ## Exact component values -/

/-- On `I_(2e-8)`, the opposite component subtracts `N/8` from the
discriminant baseline `N/12`. -/
theorem freyTwoAdic_multiplicativeWorst (e : ℝ) :
    freyTwoAdicMultiplicativeIndex e / 12 -
        freyTwoAdicMultiplicativeIndex e / 8 =
      -(e - 4) / 12 := by
  simp [freyTwoAdicMultiplicativeIndex]
  ring

/-- On `I^*_(2e-4)`, a spinor component has inverse-Cartan diagonal
`(n+4)/4 = e/2`, hence local-height correction `e/4`. -/
theorem freyTwoAdic_starWorst (e : ℝ) :
    (2 * e + 4) / 12 - (2 * e) / 8 =
      -(e - 4) / 12 := by
  ring

/-- Identity-component value in the additive-star branch. -/
theorem freyTwoAdic_starIdentity (e : ℝ) :
    (2 * e + 4) / 12 = (e + 2) / 6 := by
  ring

/-- Vector-component value in the additive-star branch. -/
theorem freyTwoAdic_starVector (e : ℝ) :
    (2 * e + 4) / 12 - 1 / 2 = (e - 1) / 6 := by
  ring

/-- The exceptional depths `1,2,3,4` have bounded geometric minima.  At
depth `2`, the first number is the `I_1^*` branch and the second the `I_0^*`
branch. -/
theorem freyTwoAdic_exceptionalMinima :
    (6 / 12 - (1 / 2) / 2 : ℝ) = 1 / 4 ∧
    (8 / 12 - (5 / 4) / 2 : ℝ) = 1 / 24 ∧
    (8 / 12 - 1 / 2 : ℝ) = 1 / 6 ∧
    (10 / 12 - (3 / 2) / 2 : ℝ) = 1 / 12 ∧
    (12 / 12 - 2 / 2 : ℝ) = 0 := by
  norm_num

/-- The sharp coefficient is strictly negative as soon as the even depth is
larger than four. -/
theorem freyTwoAdic_worst_negative
    {e : ℝ} (he : 4 < e) :
    -(e - 4) / 12 < 0 := by
  nlinarith

/-! ## Four two-torsion translates -/

/-- In the multiplicative branch, two identity and two opposite translates
have average `(e-4)/24`. -/
theorem freyTwoAdic_multiplicativeFourAverage (e : ℝ) :
    (2 * ((e - 4) / 6) + 2 * (-(e - 4) / 12)) / 4 =
      (e - 4) / 24 := by
  ring

/-- In the additive-star branch, the isolated two-torsion point stays in the
identity component and the two close points meet the same spinor component.
Thus the multiset is two identity and two spinor translates, with average
`(e+8)/24`.  The vector scalar above is geometrically valid but is not visited
by this rational `E[2]` packet. -/
theorem freyTwoAdic_starFourAverage (e : ℝ) :
    (2 * ((e + 2) / 6) + 2 * (-(e - 4) / 12)) / 4 =
      (e + 8) / 24 := by
  ring

/-- The multiplicative four-translate average is nonnegative at every depth
where the large-depth table applies. -/
theorem freyTwoAdic_multiplicativeFourAverage_nonneg
    {e : ℝ} (he : 4 ≤ e) :
    0 ≤ (e - 4) / 24 := by
  nlinarith

/-- The additive-star four-translate average is positive at every nonnegative
depth. -/
theorem freyTwoAdic_starFourAverage_pos
    {e : ℝ} (he : 0 ≤ e) :
    0 < (e + 8) / 24 := by
  nlinarith

/-! ## Full division-packet suppression -/

/-- Dividing a component value by a positive packet square suppresses the
sharp two-adic loss by exactly the same square. -/
theorem freyTwoAdic_packetScaledLower
    {e m component : ℝ}
    (hm : 0 < m)
    (hcomponent : -(e - 4) / 12 ≤ component) :
    -(e - 4) / (12 * m ^ 2) ≤ component / m ^ 2 := by
  have hm2 : 0 < m ^ 2 := sq_pos_of_pos hm
  have hrewrite :
      -(e - 4) / (12 * m ^ 2) =
        (-(e - 4) / 12) / m ^ 2 := by
    field_simp
  rw [hrewrite]
  exact (div_le_div_iff_of_pos_right hm2).2 hcomponent

/-- A nonnegative theta/intersection term cannot worsen the packet-scaled
component lower bound. -/
theorem freyTwoAdic_packetLower_withTheta
    {e m component theta : ℝ}
    (hm : 0 < m)
    (hcomponent : -(e - 4) / 12 ≤ component)
    (htheta : 0 ≤ theta) :
    -(e - 4) / (12 * m ^ 2) ≤ component / m ^ 2 + theta := by
  have hscaled := freyTwoAdic_packetScaledLower hm hcomponent
  linarith

/-! ## The fixed-prime loss is genuinely unbounded -/

/-- The magnitude `(e-4)/12` is unbounded even though the conductor exponent
in the paper table is bounded by five. -/
theorem freyTwoAdic_worstMagnitude_unbounded (B : ℝ) :
    ∃ e : ℝ, 4 ≤ e ∧ B < (e - 4) / 12 := by
  refine ⟨12 * (max B 0 + 1) + 4, ?_, ?_⟩
  · nlinarith [le_max_right B 0]
  · nlinarith [le_max_left B 0]

/-- At depth `e`, the scalar loss coefficient is exactly `(e-4)/12`. -/
theorem freyTwoAdic_counterfamilyLoss (e : ℝ) :
    -(-(e - 4) / 12) = (e - 4) / 12 := by
  ring

end

end IUTThreeClosures
