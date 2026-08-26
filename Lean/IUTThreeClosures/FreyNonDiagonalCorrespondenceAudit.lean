import IUTThreeClosures.FreyCyclicIsogenyCrossMotiveAudit

/-!
# Scalar core of the non-diagonal Frey correspondence audit

The companion note studies the product of the three cyclic two-isogeny
quotients of a full-two-torsion Frey curve.  After transport by the dual
isogenies, the three selected points are the same point.  The resulting
Neron--Tate Gram form is therefore rank one.

This file checks the exact quadratic forms used in the Rosati and
Neron--Severi calculation.  In particular it distinguishes the product
polarization from the transverse Laplacian polarization.  The latter has
the same normalized coordinate restrictions, but vanishes on the selected
diagonal.  Interpolating between them lowers the global height only by
lowering the complete local ledger by the same factor.

No elliptic curve, isogeny, dual isogeny, Hom group, Rosati involution,
Neron--Severi group, Poincare bundle, local height, conductor, or abc
assertion is formalized here.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## Product and transverse quadratic forms -/

/-- Pulling the product principal polarization through the three degree-two
isogenies gives the scalar matrix `2 I`. -/
def freyCorrespondenceProductForm (x y z : ℝ) : ℝ :=
  2 * (x ^ 2 + y ^ 2 + z ^ 2)

/-- The normalized Laplacian form.  In the paper four copies of this
rational class are the honest sum of the three dual-isogeny difference
pullbacks. -/
def freyCorrespondenceLaplacianForm (x y z : ℝ) : ℝ :=
  (x - y) ^ 2 + (x - z) ^ 2 + (y - z) ^ 2

/-- The honest integral Laplacian is four times the normalized form. -/
def freyCorrespondenceIntegralLaplacianForm (x y z : ℝ) : ℝ :=
  4 * freyCorrespondenceLaplacianForm x y z

/-- Matrix identity for the normalized Laplacian: its matrix is
`3 I - J`, with diagonal entries `2` and off-diagonal entries `-1`. -/
theorem freyCorrespondence_laplacianMatrixIdentity (x y z : ℝ) :
    freyCorrespondenceLaplacianForm x y z =
      2 * (x ^ 2 + y ^ 2 + z ^ 2) -
        2 * (x * y + x * z + y * z) := by
  simp only [freyCorrespondenceLaplacianForm]
  ring

/-- The product and normalized Laplacian have the same restriction to each
coordinate axis. -/
theorem freyCorrespondence_sameCoordinateAxes (x : ℝ) :
    freyCorrespondenceProductForm x 0 0 = 2 * x ^ 2 ∧
      freyCorrespondenceLaplacianForm x 0 0 = 2 * x ^ 2 := by
  simp [freyCorrespondenceProductForm,
    freyCorrespondenceLaplacianForm]
  ring

/-- The transverse Laplacian vanishes identically on the selected diagonal. -/
theorem freyCorrespondence_laplacian_vanishesOnDiagonal (x : ℝ) :
    freyCorrespondenceLaplacianForm x x x = 0 := by
  simp [freyCorrespondenceLaplacianForm]

/-- On the sum-zero plane, the Laplacian has eigenvalue `3`. -/
theorem freyCorrespondence_laplacian_onSumZero
    {x y z : ℝ} (hsum : x + y + z = 0) :
    freyCorrespondenceLaplacianForm x y z =
      3 * (x ^ 2 + y ^ 2 + z ^ 2) := by
  rw [freyCorrespondence_laplacianMatrixIdentity]
  nlinarith [sq_nonneg (x + y + z)]

/-- A convex interpolation between the product and transverse Laplacian
forms. -/
def freyCorrespondenceInterpolatedForm (t x y z : ℝ) : ℝ :=
  (1 - t) * freyCorrespondenceProductForm x y z +
    t * freyCorrespondenceLaplacianForm x y z

/-- Every interpolation retains the same normalized coordinate axes. -/
theorem freyCorrespondence_interpolation_sameAxes (t x : ℝ) :
    freyCorrespondenceInterpolatedForm t x 0 0 = 2 * x ^ 2 := by
  simp only [freyCorrespondenceInterpolatedForm,
    freyCorrespondenceProductForm,
    freyCorrespondenceLaplacianForm]
  ring

/-- The selected-diagonal cost falls from `6` to `6(1-t)`. -/
theorem freyCorrespondence_interpolation_diagonal (t x : ℝ) :
    freyCorrespondenceInterpolatedForm t x x x =
      6 * (1 - t) * x ^ 2 := by
  simp only [freyCorrespondenceInterpolatedForm,
    freyCorrespondenceProductForm,
    freyCorrespondenceLaplacianForm]
  ring

/-- On the transverse sum-zero plane, the interpolated eigenvalue is
`2+t`. -/
theorem freyCorrespondence_interpolation_onSumZero
    {t x y z : ℝ} (hsum : x + y + z = 0) :
    freyCorrespondenceInterpolatedForm t x y z =
      (2 + t) * (x ^ 2 + y ^ 2 + z ^ 2) := by
  rw [freyCorrespondenceInterpolatedForm,
    freyCorrespondence_laplacian_onSumZero hsum]
  simp only [freyCorrespondenceProductForm]
  ring

/-- The interpolation is positive semidefinite throughout `0 <= t <= 1`. -/
theorem freyCorrespondence_interpolation_nonnegative
    {t x y z : ℝ} (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    0 ≤ freyCorrespondenceInterpolatedForm t x y z := by
  unfold freyCorrespondenceInterpolatedForm
  have hprod : 0 ≤ freyCorrespondenceProductForm x y z := by
    unfold freyCorrespondenceProductForm
    positivity
  have hlap : 0 ≤ freyCorrespondenceLaplacianForm x y z := by
    unfold freyCorrespondenceLaplacianForm
    positivity
  exact add_nonneg
    (mul_nonneg (sub_nonneg.mpr ht1) hprod)
    (mul_nonneg ht0 hlap)

/-! ## Clearing the rational Laplacian denominator -/

/-- The honest cleared form corresponding to rational parameter `p/q` is
`4(q-p)` product copies plus `p` integral Laplacian copies. -/
def freyCorrespondenceClearedForm (p q x y z : ℝ) : ℝ :=
  4 * (q - p) * freyCorrespondenceProductForm x y z +
    p * freyCorrespondenceIntegralLaplacianForm x y z

/-- Clearing denominators gives every coordinate axis coefficient `8q`. -/
theorem freyCorrespondence_cleared_sameAxes (p q x : ℝ) :
    freyCorrespondenceClearedForm p q x 0 0 =
      8 * q * x ^ 2 := by
  simp only [freyCorrespondenceClearedForm,
    freyCorrespondenceProductForm,
    freyCorrespondenceIntegralLaplacianForm,
    freyCorrespondenceLaplacianForm]
  ring

/-- The integral Laplacian still contributes zero on the selected graph. -/
theorem freyCorrespondence_cleared_diagonal (p q x : ℝ) :
    freyCorrespondenceClearedForm p q x x x =
      24 * (q - p) * x ^ 2 := by
  simp only [freyCorrespondenceClearedForm,
    freyCorrespondenceProductForm,
    freyCorrespondenceIntegralLaplacianForm,
    freyCorrespondenceLaplacianForm]
  ring

/-- After division by the common axis scale, the cleared honest form is
exactly the rational interpolation. -/
theorem freyCorrespondence_cleared_normalizes
    {p q x y z : ℝ} (hq : q ≠ 0) :
    freyCorrespondenceClearedForm p q x y z / (4 * q) =
      freyCorrespondenceInterpolatedForm (p / q) x y z := by
  unfold freyCorrespondenceClearedForm
  unfold freyCorrespondenceIntegralLaplacianForm
  unfold freyCorrespondenceInterpolatedForm
  field_simp [hq]

/-! ## Rank-one transported Neron--Tate Gram form -/

/-- After applying the three dual isogenies, all three selected points are
the same point `P=2Q`; their Gram form is `H (x+y+z)^2`. -/
def freyTransportedPointGramForm (H x y z : ℝ) : ℝ :=
  H * (x + y + z) ^ 2

/-- The two difference directions are the exact kernel of the displayed
rank-one Gram form. -/
theorem freyTransportedPointGram_differenceKernel
    (H x y : ℝ) :
    freyTransportedPointGramForm H x (-x) 0 = 0 ∧
      freyTransportedPointGramForm H 0 y (-y) = 0 := by
  simp [freyTransportedPointGramForm]

/-- The diagonal direction has eigenvalue `3H` (quadratic value `9Hx^2`
on a vector of squared norm `3x^2`). -/
theorem freyTransportedPointGram_diagonal (H x : ℝ) :
    freyTransportedPointGramForm H x x x = 9 * H * x ^ 2 := by
  simp only [freyTransportedPointGramForm]
  ring

/-! ## The Rosati matrix and the primitive integral obstruction -/

/-- Scalar pullback of a symmetric Rosati matrix.  Diagonal coefficients
pull back with factor `2`, while a primitive pairwise degree-four
correspondence gives off-diagonal matrix entry `4 k`, hence quadratic cross
coefficient `8 k`. -/
def freyRosatiCorrespondenceForm
    (a0 a1 a2 k01 k02 k12 x y z : ℝ) : ℝ :=
  2 * a0 * x ^ 2 + 2 * a1 * y ^ 2 + 2 * a2 * z ^ 2 +
    8 * k01 * x * y + 8 * k02 * x * z + 8 * k12 * y * z

/-- Evaluation on the selected diagonal is the exact restriction degree. -/
theorem freyRosatiCorrespondence_diagonal
    (a0 a1 a2 k01 k02 k12 x : ℝ) :
    freyRosatiCorrespondenceForm a0 a1 a2 k01 k02 k12 x x x =
      (2 * (a0 + a1 + a2) + 8 * (k01 + k02 + k12)) * x ^ 2 := by
  simp only [freyRosatiCorrespondenceForm]
  ring

/-- Exact change to the two eigen-directions for one unit-axis cross term. -/
theorem freyPrimitiveCross_eigenDecomposition (k x y : ℝ) :
    2 * x ^ 2 + 2 * y ^ 2 + 8 * k * x * y =
      (1 + 2 * k) * (x + y) ^ 2 +
        (1 - 2 * k) * (x - y) ^ 2 := by
  ring

/-- A nonzero integral multiple of a primitive degree-four cross
correspondence is incompatible with two unit coordinate axes: one of the
two integral test directions is strictly negative. -/
theorem freyPrimitiveCross_unitAxes_indefinite
    (k : ℤ) (hk : k ≠ 0) :
    (2 * (1 : ℝ) ^ 2 + 2 * (1 : ℝ) ^ 2 +
          8 * (k : ℝ) * 1 * (-1) < 0) ∨
      (2 * (1 : ℝ) ^ 2 + 2 * (1 : ℝ) ^ 2 +
          8 * (k : ℝ) * 1 * 1 < 0) := by
  rcases lt_or_gt_of_ne hk with hkneg | hkpos
  · right
    have hkInt : k ≤ -1 := by omega
    have hk' : (k : ℝ) ≤ -1 := by exact_mod_cast hkInt
    norm_num
    linarith
  · left
    have hkInt : 1 ≤ k := by omega
    have hk' : (1 : ℝ) ≤ (k : ℝ) := by exact_mod_cast hkInt
    norm_num
    linarith

/-! ## Complete Pell ledger for the natural interpolation -/

/-- Odd bad-fibre slope for the canonically trivialized interpolation. -/
def freyNonDiagonalNaturalBadSlope (t : ℝ) : ℝ := 1 - t

/-- The growing good-denominator row, including the third quotient. -/
def freyNonDiagonalNaturalGoodSlope (t : ℝ) : ℝ := (1 - t) / 2

/-- The three target archimedean rows cancel before and after scaling. -/
def freyNonDiagonalNaturalArchSlope (_t : ℝ) : ℝ := 0

/-- Global canonical-height slope on the selected graph. -/
def freyNonDiagonalNaturalHeightSlope (t : ℝ) : ℝ :=
  3 * (1 - t) / 2

/-- The complete bad/good/archimedean ledger remains exact. -/
theorem freyNonDiagonalNatural_completeLedger (t : ℝ) :
    freyNonDiagonalNaturalBadSlope t +
        freyNonDiagonalNaturalGoodSlope t +
        freyNonDiagonalNaturalArchSlope t =
      freyNonDiagonalNaturalHeightSlope t := by
  simp only [freyNonDiagonalNaturalBadSlope,
    freyNonDiagonalNaturalGoodSlope,
    freyNonDiagonalNaturalArchSlope,
    freyNonDiagonalNaturalHeightSlope]
  ring

/-- Lowering the graph cost by a transverse correspondence lowers the odd
bad mass by exactly the same factor: the ratio remains `2/3`. -/
theorem freyNonDiagonalNatural_twoThirdsBoundary (t : ℝ) :
    3 * freyNonDiagonalNaturalBadSlope t =
      2 * freyNonDiagonalNaturalHeightSlope t := by
  simp only [freyNonDiagonalNaturalBadSlope,
    freyNonDiagonalNaturalHeightSlope]
  ring

/-- At the pure Laplacian endpoint every row on the selected graph is zero. -/
theorem freyNonDiagonalNatural_laplacianEndpoint :
    freyNonDiagonalNaturalBadSlope 1 = 0 ∧
      freyNonDiagonalNaturalGoodSlope 1 = 0 ∧
      freyNonDiagonalNaturalArchSlope 1 = 0 ∧
      freyNonDiagonalNaturalHeightSlope 1 = 0 := by
  norm_num [freyNonDiagonalNaturalBadSlope,
    freyNonDiagonalNaturalGoodSlope,
    freyNonDiagonalNaturalArchSlope,
    freyNonDiagonalNaturalHeightSlope]

/-- If one changes the rational section so as to keep the full unit odd-bad
row while using the reduced graph height, the sum of all nonselected rows
is forced to be `1/2 - 3t/2`. -/
theorem freyNonDiagonal_retainedBad_forcedCompensation (t : ℝ) :
    freyNonDiagonalNaturalHeightSlope t - 1 =
      1 / 2 - 3 * t / 2 := by
  simp only [freyNonDiagonalNaturalHeightSlope]
  ring

/-- Once the reduced height is below the retained odd-bad mass, the omitted
good-plus-archimedean compensation is necessarily strictly negative. -/
theorem freyNonDiagonal_retainedBad_requiresNegativeCompensation
    {t : ℝ} (ht : 1 / 3 < t) :
    freyNonDiagonalNaturalHeightSlope t - 1 < 0 := by
  rw [freyNonDiagonal_retainedBad_forcedCompensation]
  linarith

/-- A complete local ledger with nonnegative good and archimedean rows can
never have odd-bad mass larger than its global height. -/
theorem freyNonDiagonal_nonnegativeCompensation_noGain
    {bad good arch height : ℝ}
    (hledger : bad + good + arch = height)
    (hgood : 0 ≤ good) (harch : 0 ≤ arch) :
    bad ≤ height := by
  linarith

/-! ## The three two-target subledgers -/

/-- The first two quotients avoid the growing good denominator but retain a
positive archimedean cost. -/
theorem freyNonDiagonal_firstTwoLedger :
    (5 / 6 : ℝ) + 0 + 1 / 6 = 1 := by
  norm_num

/-- Either pair containing the third quotient pays its good denominator and
has the displayed negative archimedean term. -/
theorem freyNonDiagonal_thirdPairLedger :
    (7 / 12 : ℝ) + 1 / 2 - 1 / 12 = 1 := by
  norm_num

end

end IUTThreeClosures
