/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SteinbergValuationContactSurface20260902
import Mathlib.Tactic

/-!
# Quadratic Veronese peeling in the contact complex

The mathematical proofs precede this file in
`research/ABC_QUADRATIC_VERONESE_PEELING_ANALYSIS_2026_09_02.md`.

This module isolates the five-term specialization `y = x^2`, proves its
exact rational domain and orientation, transports it to primitive positive
integer triples, and formalizes the positive-cost redistribution on the
consecutive Pythagorean-square family.  It also refutes the exact fixed
one-move calibrated-boundary policy.  It neither assumes nor proves an open
multi-move filling inequality or `ABCConjecture`.
-/

namespace IUTThreeClosures
namespace QuadraticVeronesePeeling20260902

open SteinbergValuationContactSurface20260902
open scoped BigOperators

noncomputable section

/-! ## Exact rational domain and signs -/

/-- A rational contact cell is defined away from zero and one. -/
def ContactAdmissible (z : ℚ) : Prop := z ≠ 0 ∧ z ≠ 1

/-- The ordinary five-term domain before forming its three derived cells. -/
def FiveTermAdmissible (x y : ℚ) : Prop :=
  x ≠ 0 ∧ x ≠ 1 ∧ y ≠ 0 ∧ y ≠ 1 ∧ x ≠ y

/-- The specialization `y=x^2` has exactly the exceptional parameters
`0`, `1`, and `-1`. -/
theorem fiveTermAdmissible_square_iff (x : ℚ) :
    FiveTermAdmissible x (x ^ 2) ↔ x ≠ 0 ∧ x ≠ 1 ∧ x ≠ -1 := by
  constructor
  · rintro ⟨hx0, hx1, -, hxSq1, -⟩
    refine ⟨hx0, hx1, ?_⟩
    intro hxm1
    subst x
    norm_num at hxSq1
  · rintro ⟨hx0, hx1, hxm1⟩
    have hsq0 : x ^ 2 ≠ 0 := pow_ne_zero 2 hx0
    have hsq1 : x ^ 2 ≠ 1 := by
      intro h
      have hprod : (x - 1) * (x + 1) = 0 := by
        nlinarith
      rcases mul_eq_zero.mp hprod with hm | hp
      · exact hx1 (sub_eq_zero.mp hm)
      · exact hxm1 (eq_neg_of_add_eq_zero_left hp)
    have hxsq : x ≠ x ^ 2 := by
      intro h
      have hprod : x * (x - 1) = 0 := by
        nlinarith
      rcases mul_eq_zero.mp hprod with hzero | hone
      · exact hx0 hzero
      · exact hx1 (sub_eq_zero.mp hone)
    exact ⟨hx0, hx1, hsq0, hsq1, hxsq⟩

/-- The three derived rational arguments in the quadratic specialization. -/
theorem quadratic_fiveTerm_arguments
    {x : ℚ} (hx0 : x ≠ 0) (hx1 : x ≠ 1) (hxm1 : x ≠ -1) :
    (x ^ 2) / x = x ∧
      (x ^ 2 * (1 - x)) / (x * (1 - x ^ 2)) = x / (1 + x) ∧
      (1 - x) / (1 - x ^ 2) = 1 / (1 + x) := by
  have hxp1 : 1 + x ≠ 0 := by
    intro h
    apply hxm1
    linarith
  have h1mx : 1 - x ≠ 0 := sub_ne_zero.mpr (Ne.symm hx1)
  have h1mx2 : 1 - x ^ 2 ≠ 0 := by
    rw [show 1 - x ^ 2 = (1 - x) * (1 + x) by ring]
    exact mul_ne_zero h1mx hxp1
  constructor
  · field_simp
  constructor
  · field_simp [hx0, h1mx2, hxp1]
    ring
  · field_simp [h1mx2, hxp1]
    ring

/-- Both auxiliary cells produced by the quadratic specialization avoid
zero and one, and they are complementary. -/
theorem quadratic_auxiliary_cells_admissible
    {x : ℚ} (hx0 : x ≠ 0) (hxm1 : x ≠ -1) :
    ContactAdmissible (x / (1 + x)) ∧
      ContactAdmissible (1 / (1 + x)) ∧
      1 - x / (1 + x) = 1 / (1 + x) := by
  have hxp1 : 1 + x ≠ 0 := by
    intro h
    apply hxm1
    linarith
  have hxfrac0 : x / (1 + x) ≠ 0 := div_ne_zero hx0 hxp1
  have hxfrac1 : x / (1 + x) ≠ 1 := by
    intro h
    have := (div_eq_one_iff_eq hxp1).mp h
    linarith
  have hone0 : (1 : ℚ) / (1 + x) ≠ 0 := div_ne_zero one_ne_zero hxp1
  have hone1 : (1 : ℚ) / (1 + x) ≠ 1 := by
    intro h
    have := (div_eq_one_iff_eq hxp1).mp h
    apply hx0
    linarith
  refine ⟨⟨hxfrac0, hxfrac1⟩, ⟨hone0, hone1⟩, ?_⟩
  field_simp [hxp1]
  ring

/-- Complementing a contact cell reverses its exterior orientation. -/
theorem complement_contact_reverses
    (X Y : DivisorVector) (p q : ℕ) :
    wedgeCoefficient Y X p q = -wedgeCoefficient X Y p q := by
  unfold wedgeCoefficient
  ring

/-- Coefficientwise quadratic peeling.  No positivity is needed: signs of
rational representatives disappear under the finite divisor map. -/
theorem quadratic_contact_peeling
    (X U W : DivisorVector) (p q : ℕ) :
    wedgeCoefficient (X + X) (U + W) p q =
      2 * wedgeCoefficient X U p q -
        2 * wedgeCoefficient (X - W) (-W) p q := by
  unfold wedgeCoefficient
  simp only [Pi.add_apply, Pi.sub_apply, Pi.neg_apply]
  ring

/-! ## Primitive integer transport -/

/-- The quadratic transform of a positive primitive abc point. -/
def quadraticTransformPoint (P : ABCPoint) : ABCPoint where
  a := P.a ^ 2
  b := P.b * (P.a + P.c)
  c := P.c ^ 2
  a_pos := pow_pos P.a_pos 2
  b_pos := mul_pos P.b_pos (add_pos P.a_pos P.c_pos)
  c_pos := pow_pos P.c_pos 2
  sum_eq := by
    rw [show P.c = P.a + P.b from P.sum_eq.symm]
    ring
  pairwise_coprime := by
    have hac : Nat.Coprime P.a P.c := P.pairwise_coprime.2.2.symm
    have ha_ac : Nat.Coprime P.a (P.a + P.c) :=
      Nat.coprime_self_add_right.mpr hac
    have hac_c : Nat.Coprime (P.a + P.c) P.c :=
      Nat.coprime_add_self_left.mpr hac
    refine ⟨?_, ?_, ?_⟩
    · exact (P.pairwise_coprime.1.pow_left 2).mul_right
        (ha_ac.pow_left 2)
    · exact (P.pairwise_coprime.2.1.pow_right 2).mul_left
        (hac_c.pow_right 2)
    · exact P.pairwise_coprime.2.2.pow 2 2

/-- The second primitive cell appearing on the right side of peeling. -/
def quadraticAuxiliaryPoint (P : ABCPoint) : ABCPoint where
  a := P.a
  b := P.c
  c := P.a + P.c
  a_pos := P.a_pos
  b_pos := P.c_pos
  c_pos := add_pos P.a_pos P.c_pos
  sum_eq := rfl
  pairwise_coprime := by
    have hac : Nat.Coprime P.a P.c := P.pairwise_coprime.2.2.symm
    have hca : Nat.Coprime P.c P.a := P.pairwise_coprime.2.2
    exact ⟨hac, Nat.coprime_add_self_right.mpr hca,
      Nat.coprime_self_add_left.mpr hca⟩

/-- Divisors turn a square into coefficientwise doubling. -/
theorem valuationDivisor_sq (n : ℕ) :
    valuationDivisor (n ^ 2) = valuationDivisor n + valuationDivisor n := by
  funext p
  unfold valuationDivisor
  rw [Nat.factorization_pow]
  simp
  ring

/-- Divisors turn a nonzero product into coefficientwise addition. -/
theorem valuationDivisor_mul {m n : ℕ} (hm : m ≠ 0) (hn : n ≠ 0) :
    valuationDivisor (m * n) = valuationDivisor m + valuationDivisor n := by
  funext p
  unfold valuationDivisor
  rw [Nat.factorization_mul hm hn]
  simp

/-- The quadratic peeling relation for actual positive primitive integer
triples, coefficient by coefficient. -/
theorem quadraticTransform_contact
    (P : ABCPoint) (p q : ℕ) :
    abcValuationContact (quadraticTransformPoint P) p q =
      2 * abcValuationContact P p q -
        2 * abcValuationContact (quadraticAuxiliaryPoint P) p q := by
  change contactCoefficient (valuationDivisor (P.a ^ 2))
      (valuationDivisor (P.b * (P.a + P.c)))
      (valuationDivisor (P.c ^ 2)) p q = _
  rw [valuationDivisor_sq, valuationDivisor_sq,
    valuationDivisor_mul P.b_pos.ne' (add_pos P.a_pos P.c_pos).ne']
  change contactCoefficient (valuationDivisor P.a + valuationDivisor P.a)
      (valuationDivisor P.b + valuationDivisor (P.a + P.c))
      (valuationDivisor P.c + valuationDivisor P.c) p q =
    2 * contactCoefficient (valuationDivisor P.a) (valuationDivisor P.b)
      (valuationDivisor P.c) p q -
    2 * contactCoefficient (valuationDivisor P.a) (valuationDivisor P.c)
      (valuationDivisor (P.a + P.c)) p q
  unfold contactCoefficient wedgeCoefficient
  simp only [Pi.add_apply, Pi.sub_apply]
  ring

/-! ## Primewise valuation-layer flag -/

/-- Weighted mass in valuation layer `k`: a prime contributes once exactly
when its exponent is at least `k`. -/
def valuationLayerMass {ι : Type*} [Fintype ι]
    (e : ι → ℕ) (weight : ι → ℝ) (k : ℕ) : ℝ :=
  ∑ p, if k ≤ e p then weight p else 0

/-- The usual exponent-weighted logarithmic mass in a finite coordinate
model. -/
def exponentWeightedMass {ι : Type*} [Fintype ι]
    (e : ι → ℕ) (weight : ι → ℝ) : ℝ :=
  ∑ p, (e p : ℝ) * weight p

/-- A scalar appears in exactly `e` of the first `N` layers when `e≤N`. -/
theorem sum_range_layer_indicator
    (e N : ℕ) (h : e ≤ N) (weight : ℝ) :
    (∑ k ∈ Finset.range N, if k + 1 ≤ e then weight else 0) =
      (e : ℝ) * weight := by
  have hfilter :
      (Finset.range N).filter (fun k => k + 1 ≤ e) = Finset.range e := by
    ext k
    simp only [Finset.mem_filter, Finset.mem_range]
    omega
  calc
    (∑ k ∈ Finset.range N, if k + 1 ≤ e then weight else 0) =
        (∑ k ∈ Finset.range N,
          (if k + 1 ≤ e then (1 : ℝ) else 0)) * weight := by
      rw [Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro k hk
      split <;> simp_all
    _ = (((Finset.range N).filter (fun k => k + 1 ≤ e)).card : ℝ) *
        weight := by
      rw [Finset.sum_boole]
    _ = (e : ℝ) * weight := by
      rw [hfilter, Finset.card_range]

/-- Exact layer-cake identity: summing the valuation layers recovers the
full exponent-weighted mass. -/
theorem sum_valuationLayerMass_eq_exponentWeightedMass
    {ι : Type*} [Fintype ι]
    (e : ι → ℕ) (weight : ι → ℝ) (N : ℕ)
    (hbound : ∀ p, e p ≤ N) :
    (∑ k ∈ Finset.range N, valuationLayerMass e weight (k + 1)) =
      exponentWeightedMass e weight := by
  classical
  unfold valuationLayerMass exponentWeightedMass
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro p hp
  exact sum_range_layer_indicator (e p) N (hbound p) (weight p)

/-- The first layer is radical mass and every layer numbered at least two
is an exact summand of the radical defect. -/
theorem exponentWeightedMass_eq_firstLayer_add_higherLayers
    {ι : Type*} [Fintype ι]
    (e : ι → ℕ) (weight : ι → ℝ) (N : ℕ)
    (hbound : ∀ p, e p ≤ N + 1) :
    exponentWeightedMass e weight =
      valuationLayerMass e weight 1 +
        ∑ k ∈ Finset.range N, valuationLayerMass e weight (k + 2) := by
  have htotal :=
    sum_valuationLayerMass_eq_exponentWeightedMass e weight (N + 1) hbound
  rw [Finset.sum_range_succ'] at htotal
  calc
    exponentWeightedMass e weight =
        (∑ k ∈ Finset.range N,
          valuationLayerMass e weight (k + 1 + 1)) +
          valuationLayerMass e weight (0 + 1) := htotal.symm
    _ = valuationLayerMass e weight 1 +
        ∑ k ∈ Finset.range N, valuationLayerMass e weight (k + 2) := by
      rw [add_comm]

/-- Squaring duplicates every base layer in the odd layer immediately above
it. -/
theorem valuationLayerMass_double_odd
    {ι : Type*} [Fintype ι]
    (e : ι → ℕ) (weight : ι → ℝ) (j : ℕ) :
    valuationLayerMass (fun p => 2 * e p) weight (2 * j + 1) =
      valuationLayerMass e weight (j + 1) := by
  classical
  unfold valuationLayerMass
  apply Finset.sum_congr rfl
  intro p hp
  by_cases h : j + 1 ≤ e p
  · have h' : 2 * j + 1 ≤ 2 * e p := by omega
    simp [h, h']
  · have h' : ¬ 2 * j + 1 ≤ 2 * e p := by omega
    simp [h, h']

/-- Squaring duplicates the same base layer in the following even layer. -/
theorem valuationLayerMass_double_even
    {ι : Type*} [Fintype ι]
    (e : ι → ℕ) (weight : ι → ℝ) (j : ℕ) :
    valuationLayerMass (fun p => 2 * e p) weight (2 * j + 2) =
      valuationLayerMass e weight (j + 1) := by
  classical
  unfold valuationLayerMass
  apply Finset.sum_congr rfl
  intro p hp
  by_cases h : j + 1 ≤ e p
  · have h' : 2 * j + 2 ≤ 2 * e p := by omega
    simp [h, h']
  · have h' : ¬ 2 * j + 2 ≤ 2 * e p := by omega
    simp [h, h']

/-- Bilinear contact area is the sum of all ordered valuation-layer pairs. -/
theorem fullContactArea_sum_layers
    {ι : Type*} [Fintype ι] (A B C : ι → ℝ) :
    fullContactArea (∑ i, A i) (∑ i, B i) (∑ i, C i) =
      ∑ i, ∑ j,
        (A i * B j + B i * C j + C i * A j) := by
  classical
  unfold fullContactArea
  rw [Finset.sum_mul_sum, Finset.sum_mul_sum, Finset.sum_mul_sum]
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]

/-- Combining the layer-cake identities on three legs gives the exact
higher-dimensional layer-pair expansion of contact area. -/
theorem fullContactArea_eq_valuationLayerPairs
    {ι : Type*} [Fintype ι]
    (ea eb ec : ι → ℕ) (weight : ι → ℝ) (N : ℕ)
    (ha : ∀ p, ea p ≤ N) (hb : ∀ p, eb p ≤ N)
    (hc : ∀ p, ec p ≤ N) :
    fullContactArea (exponentWeightedMass ea weight)
        (exponentWeightedMass eb weight)
        (exponentWeightedMass ec weight) =
      ∑ k ∈ Finset.range N, ∑ l ∈ Finset.range N,
        (valuationLayerMass ea weight (k + 1) *
            valuationLayerMass eb weight (l + 1) +
         valuationLayerMass eb weight (k + 1) *
            valuationLayerMass ec weight (l + 1) +
         valuationLayerMass ec weight (k + 1) *
            valuationLayerMass ea weight (l + 1)) := by
  rw [← sum_valuationLayerMass_eq_exponentWeightedMass ea weight N ha,
    ← sum_valuationLayerMass_eq_exponentWeightedMass eb weight N hb,
    ← sum_valuationLayerMass_eq_exponentWeightedMass ec weight N hc]
  unfold fullContactArea
  rw [Finset.sum_mul_sum, Finset.sum_mul_sum, Finset.sum_mul_sum]
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro k hk
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]

/-! ## The consecutive Pythagorean specialization -/

/-- In the consecutive parametrization, the even leg and hypotenuse differ
by one. -/
theorem pythagoreanY_add_one_eq_Z (t : ℕ) :
    pythagoreanY t + 1 = pythagoreanZ t := by
  unfold pythagoreanY pythagoreanZ
  ring

/-- The sum of the even leg and hypotenuse is the square of the odd leg. -/
theorem pythagoreanY_add_Z_eq_X_sq (t : ℕ) :
    pythagoreanY t + pythagoreanZ t = pythagoreanX t ^ 2 := by
  unfold pythagoreanX pythagoreanY pythagoreanZ
  ring

/-- The base point whose quadratic transform is the Pythagorean-square
cell in the order selected by `x=Y/Z`. -/
def consecutiveBasePoint (t : ℕ) (ht : 0 < t) : ABCPoint where
  a := pythagoreanY t
  b := 1
  c := pythagoreanZ t
  a_pos := by
    unfold pythagoreanY
    positivity
  b_pos := by norm_num
  c_pos := by simp [pythagoreanZ]
  sum_eq := pythagoreanY_add_one_eq_Z t
  pairwise_coprime := by
    refine ⟨Nat.coprime_one_right _, Nat.coprime_one_left _, ?_⟩
    rw [← pythagoreanY_add_one_eq_Z t]
    exact (Nat.coprime_self_add_left
      (m := pythagoreanY t) (n := 1)).mpr (Nat.coprime_one_left _)

/-- The quadratic transform has exactly the swapped Pythagorean-square
coordinates `(Y^2,X^2,Z^2)`. -/
theorem quadraticTransform_consecutive_coordinates
    (t : ℕ) (ht : 0 < t) :
    (quadraticTransformPoint (consecutiveBasePoint t ht)).a =
        pythagoreanY t ^ 2 ∧
    (quadraticTransformPoint (consecutiveBasePoint t ht)).b =
        pythagoreanX t ^ 2 ∧
    (quadraticTransformPoint (consecutiveBasePoint t ht)).c =
        pythagoreanZ t ^ 2 := by
  refine ⟨rfl, ?_, rfl⟩
  simp only [quadraticTransformPoint, consecutiveBasePoint, one_mul]
  exact pythagoreanY_add_Z_eq_X_sq t

/-- The exact contact peeling for the genuine Pythagorean-square abc point. -/
theorem pythagoreanSquare_contact_peeling
    (t : ℕ) (ht : 0 < t) (p q : ℕ) :
    abcValuationContact
        (quadraticTransformPoint (consecutiveBasePoint t ht)) p q =
      2 * abcValuationContact (consecutiveBasePoint t ht) p q -
        2 * abcValuationContact
          (quadraticAuxiliaryPoint (consecutiveBasePoint t ht)) p q :=
  quadraticTransform_contact (consecutiveBasePoint t ht) p q

/-- The naive assertion that the actual Pythagorean-square abc family has a
uniformly bounded valuation-layer depth. -/
def UniformPythagoreanSquareLayerCutoff : Prop :=
  ∃ K : ℕ, ∀ t : ℕ, 0 < t → ∀ p : ℕ,
    (pythagoreanY t ^ 2).factorization p ≤ K

/-- Powers of two give arbitrarily deep `2`-adic layers inside genuine
primitive Pythagorean-square abc points. -/
theorem not_uniformPythagoreanSquareLayerCutoff :
    ¬ UniformPythagoreanSquareLayerCutoff := by
  rintro ⟨K, hK⟩
  let t := 2 ^ (K + 1)
  have ht : 0 < t := by
    dsimp [t]
    positivity
  have hlower :
      K + 1 ≤ (pythagoreanY t ^ 2).factorization 2 := by
    have hn : pythagoreanY t ^ 2 ≠ 0 := by
      unfold pythagoreanY
      positivity
    rw [← Nat.prime_two.pow_dvd_iff_le_factorization hn]
    refine ⟨4 * t * (t + 1) ^ 2, ?_⟩
    dsimp [t]
    unfold pythagoreanY
    ring
  have hupper := hK t ht 2
  omega

/-! ## Exact scalar cost redistribution -/

/-- Full positive contact area of the squared cell, in base log variables
`u=log X`, `v=log Y`, `w=log Z`. -/
def squareFullCost (u v w : ℝ) : ℝ := 4 * (u * v + u * w + v * w)

/-- Sum of full positive cell areas on the right side of the peeling,
including the two absolute chain coefficients. -/
def peeledFullCost (u v w : ℝ) : ℝ :=
  2 * (v * w) + 2 * (v * w + 2 * u * (v + w))

/-- Coherent outer-square cost of the original squared cell. -/
def squareCoherentCost (u v w : ℝ) : ℝ := squareFullCost u v w

/-- Coherent outer-square cost remaining after the one-move peeling. -/
def peeledCoherentCost (u v w : ℝ) : ℝ := 2 * u * (v + w)

/-- Residual base cost of the original squared cell. -/
def squareResidualCost
    (u v w dx dy dz : ℝ) : ℝ :=
  2 * (dy * (u + w) + dx * (v + w) + dz * (u + v))

/-- Residual base cost of the peeled two-cell chain. -/
def peeledResidualCost
    (u v w dx dy dz : ℝ) : ℝ :=
  4 * dy * (u + w) + 2 * dx * (v + w) + 4 * dz * (u + v)

/-- The one-move peeling conserves total positive full area exactly. -/
theorem peeledFullCost_eq_squareFullCost (u v w : ℝ) :
    peeledFullCost u v w = squareFullCost u v w := by
  unfold peeledFullCost squareFullCost
  ring

/-- Positive `Y` and `Z` masses make the coherent cost drop by more than
one half. -/
theorem peeledCoherentCost_lt_half_squareCoherentCost
    {u v w : ℝ} (hv : 0 < v) (hw : 0 < w) :
    peeledCoherentCost u v w < squareCoherentCost u v w / 2 := by
  unfold peeledCoherentCost squareCoherentCost squareFullCost
  nlinarith [mul_pos hv hw]

/-- The exact residual price of the coherent-cost reduction. -/
theorem peeledResidualCost_sub_squareResidualCost
    (u v w dx dy dz : ℝ) :
    peeledResidualCost u v w dx dy dz -
        squareResidualCost u v w dx dy dz =
      2 * dy * (u + w) + 2 * dz * (u + v) := by
  unfold peeledResidualCost squareResidualCost
  ring

/-- The residual cost cannot decrease when all base masses and defects are
nonnegative. -/
theorem squareResidualCost_le_peeledResidualCost
    {u v w dx dy dz : ℝ}
    (hu : 0 ≤ u) (hv : 0 ≤ v) (hw : 0 ≤ w)
    (hdy : 0 ≤ dy) (hdz : 0 ≤ dz) :
    squareResidualCost u v w dx dy dz ≤
      peeledResidualCost u v w dx dy dz := by
  rw [← sub_nonneg]
  rw [peeledResidualCost_sub_squareResidualCost]
  positivity

/-- Calibrated cost `Q=M+V=2 Phi-R` for the declared outer-square split. -/
def peeledCalibratedCost
    (u v w alpha beta gamma : ℝ) : ℝ :=
  2 * u * (v + w) + 4 * alpha * (u + w) +
    4 * gamma * (u + v) + 2 * beta * (v + w)

/-- The radical-mass expression for calibrated cost is exactly
`2 Phi-R`. -/
theorem peeledCalibratedCost_eq_two_full_sub_residual
    (u v w alpha beta gamma : ℝ) :
    peeledCalibratedCost u v w alpha beta gamma =
      2 * squareFullCost u v w -
        peeledResidualCost u v w (u - beta) (v - alpha) (w - gamma) := by
  unfold peeledCalibratedCost squareFullCost peeledResidualCost
  ring

/-- Exact excess over the Gate-VF leading boundary term
`2H rho = 4w(alpha+beta+gamma)`. -/
theorem peeledCalibratedCost_sub_boundaryTerm
    (u v w alpha beta gamma : ℝ) :
    peeledCalibratedCost u v w alpha beta gamma -
        4 * w * (alpha + beta + gamma) =
      2 * u * (v + w) + 4 * alpha * u +
        4 * gamma * (u + v - w) + 2 * beta * (v - w) := by
  unfold peeledCalibratedCost
  ring

/-- On the consecutive Pythagorean corridor, the calibrated-boundary excess
is already at least `4uv`, independently of factorization. -/
theorem four_mul_u_v_le_boundaryExcess
    {u v w alpha beta gamma : ℝ}
    (hu : 0 ≤ u) (hα : 0 ≤ alpha) (_hβ : 0 ≤ beta)
    (hγ : 0 ≤ gamma) (hβu : beta ≤ u)
    (hvw : v ≤ w) (hwuv : w ≤ u + v) :
    4 * u * v ≤
      peeledCalibratedCost u v w alpha beta gamma -
        4 * w * (alpha + beta + gamma) := by
  rw [peeledCalibratedCost_sub_boundaryTerm]
  have hdiff : v - w ≤ 0 := sub_nonpos.mpr hvw
  have hbetaTerm : 2 * u * (v - w) ≤ 2 * beta * (v - w) := by
    have := mul_le_mul_of_nonpos_right hβu hdiff
    nlinarith
  have hAlpha : 0 ≤ 4 * alpha * u := by positivity
  have hGamma : 0 ≤ 4 * gamma * (u + v - w) := by
    positivity
  nlinarith

/-! ## Actual fixed-chain boundary no-go -/

def xLog (t : ℕ) : ℝ := legHeight (pythagoreanX t)
def yLog (t : ℕ) : ℝ := legHeight (pythagoreanY t)
def zLog (t : ℕ) : ℝ := legHeight (pythagoreanZ t)

def xRadicalLog (t : ℕ) : ℝ := legRadicalMass (pythagoreanX t)
def yRadicalLog (t : ℕ) : ℝ := legRadicalMass (pythagoreanY t)
def zRadicalLog (t : ℕ) : ℝ := legRadicalMass (pythagoreanZ t)

def actualPeeledCalibratedCost (t : ℕ) : ℝ :=
  peeledCalibratedCost (xLog t) (yLog t) (zLog t)
    (yRadicalLog t) (xRadicalLog t) (zRadicalLog t)

def actualSquareFullCost (t : ℕ) : ℝ :=
  squareFullCost (xLog t) (yLog t) (zLog t)

def actualPeeledFullCost (t : ℕ) : ℝ :=
  peeledFullCost (xLog t) (yLog t) (zLog t)

def actualPeeledResidualCost (t : ℕ) : ℝ :=
  peeledResidualCost (xLog t) (yLog t) (zLog t)
    (xLog t - xRadicalLog t) (yLog t - yRadicalLog t)
    (zLog t - zRadicalLog t)

/-- A tempting but false fixed one-move positive-area contraction policy. -/
def FixedQuadraticPositiveAreaContraction : Prop :=
  ∃ η : ℝ, 0 < η ∧ ∃ K : ℝ, ∀ t : ℕ, 0 < t →
    actualPeeledFullCost t ≤
      (1 - η) * actualSquareFullCost t + K * (2 * zLog t)

/-- The declared outer-square residual version of the first Gate-VF
inequality, restricted to the fixed one-move quadratic policy. -/
def FixedOuterSquareResidualSubcriticality : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ K : ℝ, ∀ t : ℕ, 0 < t →
    actualPeeledResidualCost t ≤
      ε * actualPeeledCalibratedCost t + K * (2 * zLog t)

/-- The fixed one-move version of the Gate-VF calibrated-boundary target. -/
def FixedQuadraticBoundaryGate : Prop :=
  ∃ L : ℝ, ∀ t : ℕ, 0 < t →
    actualPeeledCalibratedCost t ≤
      4 * zLog t * (yRadicalLog t + xRadicalLog t + zRadicalLog t) +
        L * (2 * zLog t)

theorem pythagoreanY_lt_Z {t : ℕ} :
    pythagoreanY t < pythagoreanZ t := by
  rw [← pythagoreanY_add_one_eq_Z t]
  omega

theorem pythagoreanZ_le_X_mul_Y {t : ℕ} (ht : 0 < t) :
    pythagoreanZ t ≤ pythagoreanX t * pythagoreanY t := by
  unfold pythagoreanX pythagoreanY pythagoreanZ
  nlinarith

theorem xLog_nonneg (t : ℕ) : 0 ≤ xLog t := by
  apply legHeight_nonneg
  simp [pythagoreanX]

theorem yLog_pos {t : ℕ} (ht : 0 < t) : 0 < yLog t := by
  unfold yLog legHeight
  apply Real.log_pos
  have : 1 < pythagoreanY t := by
    unfold pythagoreanY
    nlinarith
  exact_mod_cast this

theorem zLog_pos {t : ℕ} (ht : 0 < t) : 0 < zLog t := by
  unfold zLog legHeight
  apply Real.log_pos
  have : 1 < pythagoreanZ t := by
    unfold pythagoreanZ
    nlinarith
  exact_mod_cast this

theorem yLog_le_zLog {t : ℕ} (ht : 0 < t) : yLog t ≤ zLog t := by
  unfold yLog zLog legHeight
  apply Real.log_le_log
  · have : 0 < pythagoreanY t := by
      unfold pythagoreanY
      positivity
    exact_mod_cast this
  · exact_mod_cast (Nat.le_of_lt (pythagoreanY_lt_Z (t := t)))

theorem zLog_le_xLog_add_yLog {t : ℕ} (ht : 0 < t) :
    zLog t ≤ xLog t + yLog t := by
  have hx : (pythagoreanX t : ℝ) ≠ 0 := by
    exact_mod_cast (show pythagoreanX t ≠ 0 by simp [pythagoreanX])
  have hyNat : 0 < pythagoreanY t := by
    unfold pythagoreanY
    positivity
  have hy : (pythagoreanY t : ℝ) ≠ 0 := by exact_mod_cast hyNat.ne'
  have hleR : (pythagoreanZ t : ℝ) ≤
      (pythagoreanX t : ℝ) * pythagoreanY t := by
    exact_mod_cast pythagoreanZ_le_X_mul_Y ht
  have hlog := Real.log_le_log (by
    exact_mod_cast (show 0 < pythagoreanZ t by simp [pythagoreanZ])) hleR
  rw [Real.log_mul hx hy] at hlog
  exact hlog

/-- The hypotenuse log is at most three halves of the even-leg log. -/
theorem two_mul_zLog_le_three_mul_yLog {t : ℕ} (ht : 0 < t) :
    2 * zLog t ≤ 3 * yLog t := by
  have hy4 : 4 ≤ pythagoreanY t := by
    unfold pythagoreanY
    nlinarith
  have hz2y : pythagoreanZ t ≤ 2 * pythagoreanY t := by
    rw [← pythagoreanY_add_one_eq_Z t]
    have hy1 : 1 ≤ pythagoreanY t := by omega
    omega
  have hyRpos : 0 < (pythagoreanY t : ℝ) := by
    exact_mod_cast (show 0 < pythagoreanY t by omega)
  have hzlog : zLog t ≤ Real.log 2 + yLog t := by
    have hR : (pythagoreanZ t : ℝ) ≤
        2 * (pythagoreanY t : ℝ) := by exact_mod_cast hz2y
    have h := Real.log_le_log (by
      exact_mod_cast (show 0 < pythagoreanZ t by simp [pythagoreanZ])) hR
    rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hyRpos.ne'] at h
    exact h
  have hlog4 : Real.log 4 ≤ yLog t := by
    unfold yLog legHeight
    apply Real.log_le_log (by norm_num)
    exact_mod_cast hy4
  have hlog4eq : Real.log 4 = 2 * Real.log 2 := by
    rw [show (4 : ℝ) = 2 * 2 by norm_num, Real.log_mul (by norm_num) (by norm_num)]
    ring
  rw [hlog4eq] at hlog4
  linarith

/-- Monotonicity of the logarithmic leg mass on positive naturals. -/
theorem legHeight_mono {m n : ℕ} (hm : 0 < m) (hmn : m ≤ n) :
    legHeight m ≤ legHeight n := by
  unfold legHeight
  apply Real.log_le_log
  · exact_mod_cast hm
  · exact_mod_cast hmn

/-- Logarithmic mass of a natural power. -/
theorem legHeight_pow (n k : ℕ) :
    legHeight (n ^ k) = (k : ℝ) * legHeight n := by
  unfold legHeight
  push_cast
  rw [Real.log_pow]

/-- Coarse but uniform natural-size corridor used in the power-of-two
residual obstruction. -/
theorem powerTwo_natural_corridor (k : ℕ) (hk : 2 ≤ k) :
    let t := 2 ^ k
    t ≤ pythagoreanX t ∧ pythagoreanX t ≤ t ^ 2 ∧
    t ^ 2 ≤ pythagoreanY t ∧ pythagoreanY t ≤ t ^ 3 ∧
    t ^ 2 ≤ pythagoreanZ t ∧ pythagoreanZ t ≤ t ^ 3 := by
  dsimp
  let t := 2 ^ k
  have ht4 : 4 ≤ t := by
    dsimp [t]
    calc
      4 = 2 ^ 2 := by norm_num
      _ ≤ 2 ^ k := Nat.pow_le_pow_right (by norm_num) hk
  have hsq4 : 4 * t ≤ t * t := Nat.mul_le_mul_right t ht4
  have hinner : 2 * (t + 1) ≤ t ^ 2 := by nlinarith
  have hyUpper : 2 * t * (t + 1) ≤ t ^ 3 := by
    calc
      2 * t * (t + 1) = t * (2 * (t + 1)) := by ring
      _ ≤ t * (t ^ 2) := Nat.mul_le_mul_left t hinner
      _ = t ^ 3 := by ring
  have hcubic4 : 4 * (t ^ 2) ≤ t ^ 3 := by
    calc
      4 * (t ^ 2) ≤ t * (t ^ 2) := Nat.mul_le_mul_right (t ^ 2) ht4
      _ = t ^ 3 := by ring
  have hzInner : 2 * t ^ 2 + 2 * t + 1 ≤ 4 * t ^ 2 := by
    nlinarith [sq_nonneg (t - 1)]
  have hzUpper : 2 * t ^ 2 + 2 * t + 1 ≤ t ^ 3 :=
    hzInner.trans hcubic4
  change t ≤ 2 * t + 1 ∧ 2 * t + 1 ≤ t ^ 2 ∧
    t ^ 2 ≤ 2 * t * (t + 1) ∧ 2 * t * (t + 1) ≤ t ^ 3 ∧
    t ^ 2 ≤ 2 * t ^ 2 + 2 * t + 1 ∧
      2 * t ^ 2 + 2 * t + 1 ≤ t ^ 3
  constructor
  · nlinarith
  constructor
  · nlinarith
  constructor
  · nlinarith
  exact ⟨hyUpper, by nlinarith, hzUpper⟩

/-- The corresponding logarithmic corridor, with
`L=log(2^k)`. -/
theorem powerTwo_log_corridor (k : ℕ) (hk : 2 ≤ k) :
    let t := 2 ^ k
    let L := legHeight t
    L ≤ xLog t ∧ xLog t ≤ 2 * L ∧
    2 * L ≤ yLog t ∧ yLog t ≤ 3 * L ∧
    2 * L ≤ zLog t ∧ zLog t ≤ 3 * L := by
  dsimp
  let t := 2 ^ k
  have ht : 0 < t := by
    dsimp [t]
    positivity
  rcases powerTwo_natural_corridor k hk with
    ⟨hxLo, hxHi, hyLo, hyHi, hzLo, hzHi⟩
  have h1 := legHeight_mono ht hxLo
  have h2 := legHeight_mono (by simp [pythagoreanX]) hxHi
  have h3 := legHeight_mono (pow_pos ht 2) hyLo
  have h4 := legHeight_mono (by
    unfold pythagoreanY
    positivity) hyHi
  have h5 := legHeight_mono (pow_pos ht 2) hzLo
  have h6 := legHeight_mono (by simp [pythagoreanZ]) hzHi
  rw [legHeight_pow t 2] at h2 h3 h5
  rw [legHeight_pow t 3] at h4 h6
  exact ⟨h1, h2, h3, h4, h5, h6⟩

/-- Submultiplicativity of the natural radical. -/
theorem natRadical_mul_le (m n : ℕ) :
    UniqueFactorizationMonoid.radical (m * n) ≤
      UniqueFactorizationMonoid.radical m *
        UniqueFactorizationMonoid.radical n := by
  exact Nat.le_of_dvd
    (mul_pos (Nat.radical_pos m) (Nat.radical_pos n))
    (UniqueFactorizationMonoid.radical_mul_dvd (a := m) (b := n))

/-- On the power-of-two subsequence, all repeated two-adic mass in `Y` is
lost by radical truncation. -/
theorem abcRadical_pythagoreanY_powTwo_le (k : ℕ) :
    abcRadical (pythagoreanY (2 ^ k)) ≤ 2 * (2 ^ k + 1) := by
  rw [abcRadical_eq_natRadical]
  change UniqueFactorizationMonoid.radical
      ((2 * 2 ^ k) * (2 ^ k + 1)) ≤ _
  calc
    UniqueFactorizationMonoid.radical
        ((2 * 2 ^ k) * (2 ^ k + 1)) ≤
      UniqueFactorizationMonoid.radical (2 * 2 ^ k) *
        UniqueFactorizationMonoid.radical (2 ^ k + 1) :=
      natRadical_mul_le _ _
    _ = 2 * UniqueFactorizationMonoid.radical (2 ^ k + 1) := by
      rw [show 2 * 2 ^ k = 2 ^ (k + 1) by ring,
        UniqueFactorizationMonoid.radical_pow_of_prime
          Nat.prime_two.prime (by omega)]
      rfl
    _ ≤ 2 * (2 ^ k + 1) := by
      gcongr
      exact Nat.radical_le_self_iff.mpr (by positivity)

/-- The outer-square residual defect on the `Y` leg is at least
`log(2^k)`. -/
theorem powerTwo_yLog_sub_radical_lower (k : ℕ) :
    legHeight (2 ^ k) ≤
      yLog (2 ^ k) - yRadicalLog (2 ^ k) := by
  have hr := abcRadical_pythagoreanY_powTwo_le k
  have hrlog : yRadicalLog (2 ^ k) ≤
      Real.log (((2 * (2 ^ k + 1) : ℕ) : ℝ)) := by
    unfold yRadicalLog legRadicalMass
    apply Real.log_le_log
    · exact_mod_cast abcRadical_pos (pythagoreanY (2 ^ k))
    · exact_mod_cast hr
  have hylog : yLog (2 ^ k) = legHeight (2 ^ k) +
      Real.log (((2 * (2 ^ k + 1) : ℕ) : ℝ)) := by
    unfold yLog legHeight pythagoreanY
    rw [show 2 * 2 ^ k * (2 ^ k + 1) =
      2 ^ k * (2 * (2 ^ k + 1)) by ring]
    push_cast
    rw [Real.log_mul (by positivity) (by positivity)]
  linarith

/-- Logarithmic masses of powers of two are unbounded while retaining
`k≥2`, as required by the certified corridor. -/
theorem powerTwo_legHeight_unbounded (B : ℝ) :
    ∃ k : ℕ, 2 ≤ k ∧ B < legHeight (2 ^ k) := by
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  obtain ⟨k, hk⟩ := exists_nat_gt (max 2 (B / Real.log 2))
  have hkTwoR : (2 : ℝ) < k := lt_of_le_of_lt (le_max_left _ _) hk
  have hkTwo : 2 ≤ k := by exact_mod_cast (le_of_lt hkTwoR)
  have hkB : B / Real.log 2 < (k : ℝ) :=
    lt_of_le_of_lt (le_max_right _ _) hk
  have hB : B < (k : ℝ) * Real.log 2 :=
    (div_lt_iff₀ hlog2).mp hkB
  refine ⟨k, hkTwo, ?_⟩
  rw [legHeight_pow]
  simpa [legHeight] using hB

/-- The odd-leg logarithm is unbounded on the genuine primitive family. -/
theorem xLog_unbounded (B : ℝ) :
    ∃ t : ℕ, 0 < t ∧ B < xLog t := by
  obtain ⟨t, ht⟩ := exists_nat_gt (Real.exp B)
  have htPosR : 0 < (t : ℝ) := lt_trans (Real.exp_pos B) ht
  have htPos : 0 < t := by exact_mod_cast htPosR
  have htx : t ≤ pythagoreanX t := by
    unfold pythagoreanX
    omega
  have htarget : Real.exp B < (pythagoreanX t : ℝ) := by
    have htxR : (t : ℝ) ≤ pythagoreanX t := by exact_mod_cast htx
    exact lt_of_lt_of_le ht htxR
  refine ⟨t, htPos, ?_⟩
  unfold xLog legHeight
  exact (Real.lt_log_iff_exp_lt (by
    exact_mod_cast (show 0 < pythagoreanX t by simp [pythagoreanX]))).2 htarget

/-- The squared-cell positive area contains the `4 log(X) log(Y)` block. -/
theorem four_mul_xLog_yLog_le_actualSquareFullCost
    {t : ℕ} (ht : 0 < t) :
    4 * xLog t * yLog t ≤ actualSquareFullCost t := by
  have hu0 : 0 ≤ xLog t := xLog_nonneg t
  have hv0 : 0 ≤ yLog t := (yLog_pos ht).le
  have hw0 : 0 ≤ zLog t := (zLog_pos ht).le
  unfold actualSquareFullCost squareFullCost
  nlinarith [mul_nonneg hu0 hw0, mul_nonneg hv0 hw0]

/-- Exact positive area is conserved, so no fixed positive contraction can
hold up to a linear-height error on this primitive family. -/
theorem not_fixedQuadraticPositiveAreaContraction :
    ¬ FixedQuadraticPositiveAreaContraction := by
  rintro ⟨η, hη, K, hK⟩
  obtain ⟨t, ht, huLarge⟩ :=
    xLog_unbounded (max 0 (3 * K / (4 * η)))
  have hu0 : 0 ≤ xLog t := xLog_nonneg t
  have hv0 : 0 < yLog t := yLog_pos ht
  have hw0 : 0 < zLog t := zLog_pos ht
  have harea := four_mul_xLog_yLog_le_actualSquareFullCost ht
  have hconserve : actualPeeledFullCost t = actualSquareFullCost t := by
    exact peeledFullCost_eq_squareFullCost _ _ _
  have hgate := hK t ht
  rw [hconserve] at hgate
  have hupper : η * actualSquareFullCost t ≤ 2 * K * zLog t := by
    nlinarith
  have hlower : 4 * η * xLog t * yLog t ≤
      η * actualSquareFullCost t := by
    have := mul_le_mul_of_nonneg_left harea hη.le
    nlinarith
  have hcorridor := two_mul_zLog_le_three_mul_yLog ht
  have hmax : 3 * K / (4 * η) < xLog t :=
    lt_of_le_of_lt (le_max_right _ _) huLarge
  by_cases hKnonneg : 0 ≤ K
  · have hscaled : 2 * K * zLog t ≤ 3 * K * yLog t := by
      have h := mul_le_mul_of_nonneg_left hcorridor hKnonneg
      nlinarith
    have hstrict : 3 * K * yLog t < 4 * η * xLog t * yLog t := by
      have hpos : 0 < 4 * η * yLog t := by positivity
      have h := mul_lt_mul_of_pos_right hmax hpos
      have hηne : η ≠ 0 := ne_of_gt hη
      field_simp [hηne] at h
      nlinarith
    have hchain : 4 * η * xLog t * yLog t ≤
        2 * K * zLog t := le_trans hlower hupper
    linarith
  · have hrightNeg : 2 * K * zLog t < 0 := by
      exact mul_neg_of_neg_of_pos (by linarith) hw0
    have hleftNonneg : 0 ≤ 4 * η * xLog t * yLog t := by positivity
    have hchain : 4 * η * xLog t * yLog t ≤
        2 * K * zLog t := le_trans hlower hupper
    linarith

/-- The declared outer-square residual cost is nonnegative on the actual
positive family. -/
theorem actualPeeledResidualCost_nonneg {t : ℕ} (ht : 0 < t) :
    0 ≤ actualPeeledResidualCost t := by
  have hu0 : 0 ≤ xLog t := xLog_nonneg t
  have hv0 : 0 ≤ yLog t := (yLog_pos ht).le
  have hw0 : 0 ≤ zLog t := (zLog_pos ht).le
  have hdx : 0 ≤ xLog t - xRadicalLog t := by
    exact sub_nonneg.mpr (legRadicalMass_le_legHeight (by simp [pythagoreanX]))
  have hdy : 0 ≤ yLog t - yRadicalLog t := by
    apply sub_nonneg.mpr
    exact legRadicalMass_le_legHeight (by
      unfold pythagoreanY
      positivity)
  have hdz : 0 ≤ zLog t - zRadicalLog t := by
    apply sub_nonneg.mpr
    exact legRadicalMass_le_legHeight (by simp [pythagoreanZ])
  unfold actualPeeledResidualCost peeledResidualCost
  positivity

/-- The actual calibrated cost is `2 Phi-R` for the declared split. -/
theorem actualPeeledCalibratedCost_eq_two_full_sub_residual (t : ℕ) :
    actualPeeledCalibratedCost t =
      2 * actualSquareFullCost t - actualPeeledResidualCost t := by
  unfold actualPeeledCalibratedCost actualSquareFullCost
    actualPeeledResidualCost
  exact peeledCalibratedCost_eq_two_full_sub_residual _ _ _ _ _ _

/-- Consequently calibrated cost is at most twice full area. -/
theorem actualPeeledCalibratedCost_le_two_full {t : ℕ} (ht : 0 < t) :
    actualPeeledCalibratedCost t ≤ 2 * actualSquareFullCost t := by
  rw [actualPeeledCalibratedCost_eq_two_full_sub_residual]
  exact sub_le_self _ (actualPeeledResidualCost_nonneg ht)

/-- Certified quadratic lower bound for the outer-square residual on the
power-of-two subsequence. -/
theorem powerTwo_actualResidual_lower (k : ℕ) (hk : 2 ≤ k) :
    let t := 2 ^ k
    let L := legHeight t
    12 * L ^ 2 ≤ actualPeeledResidualCost t := by
  dsimp
  let t := 2 ^ k
  let L := legHeight t
  rcases powerTwo_log_corridor k hk with
    ⟨huLo, huHi, hvLo, hvHi, hwLo, hwHi⟩
  have hLpos : 0 < L := by
    dsimp [L, t]
    rw [legHeight_pow]
    have hkpos : 0 < (k : ℝ) := by positivity
    have hlog2 : 0 < legHeight 2 := by
      unfold legHeight
      exact Real.log_pos (by norm_num)
    positivity
  have hdyLo : L ≤ yLog t - yRadicalLog t := by
    exact powerTwo_yLog_sub_radical_lower k
  have hdx0 : 0 ≤ xLog t - xRadicalLog t := by
    apply sub_nonneg.mpr
    exact legRadicalMass_le_legHeight (by simp [pythagoreanX])
  have hdy0 : 0 ≤ yLog t - yRadicalLog t := le_trans hLpos.le hdyLo
  have hdz0 : 0 ≤ zLog t - zRadicalLog t := by
    apply sub_nonneg.mpr
    exact legRadicalMass_le_legHeight (by simp [pythagoreanZ])
  have huvLo : 3 * L ≤ xLog t + zLog t := by linarith
  have hproduct : L * (3 * L) ≤
      (yLog t - yRadicalLog t) * (xLog t + zLog t) := by
    exact mul_le_mul hdyLo huvLo (by positivity) hdy0
  have hyz0 : 0 ≤ yLog t + zLog t := by linarith
  have hxy0 : 0 ≤ xLog t + yLog t := by linarith
  have hotherX : 0 ≤
      2 * (xLog t - xRadicalLog t) * (yLog t + zLog t) := by
    exact mul_nonneg (mul_nonneg (by norm_num) hdx0) hyz0
  have hotherZ : 0 ≤
      4 * (zLog t - zRadicalLog t) * (xLog t + yLog t) := by
    exact mul_nonneg (mul_nonneg (by norm_num) hdz0) hxy0
  unfold actualPeeledResidualCost peeledResidualCost
  nlinarith

/-- Coarse quadratic upper bound for full area on the same subsequence. -/
theorem powerTwo_actualSquareFull_upper (k : ℕ) (hk : 2 ≤ k) :
    let t := 2 ^ k
    let L := legHeight t
    actualSquareFullCost t ≤ 84 * L ^ 2 := by
  dsimp
  let t := 2 ^ k
  let L := legHeight t
  rcases powerTwo_log_corridor k hk with
    ⟨huLo, huHi, hvLo, hvHi, hwLo, hwHi⟩
  have hL0 : 0 ≤ L := by
    dsimp [L]
    apply legHeight_nonneg
    dsimp [t]
    positivity
  have hu0 : 0 ≤ xLog t := le_trans hL0 huLo
  have hv0 : 0 ≤ yLog t := le_trans (by positivity : 0 ≤ 2 * L) hvLo
  have hw0 : 0 ≤ zLog t := le_trans (by positivity : 0 ≤ 2 * L) hwLo
  have huv : xLog t * yLog t ≤ (2 * L) * (3 * L) :=
    mul_le_mul huHi hvHi hv0 (by positivity)
  have huw : xLog t * zLog t ≤ (2 * L) * (3 * L) :=
    mul_le_mul huHi hwHi hw0 (by positivity)
  have hvw : yLog t * zLog t ≤ (3 * L) * (3 * L) :=
    mul_le_mul hvHi hwHi hw0 (by positivity)
  unfold actualSquareFullCost squareFullCost
  nlinarith

/-- The exact fixed outer-square residual policy fails already at
`epsilon=1/100` on positive primitive Pythagorean-square abc points.  This
does not address the maximal-exponent residual used by a different policy. -/
theorem not_fixedOuterSquareResidualSubcriticality :
    ¬ FixedOuterSquareResidualSubcriticality := by
  intro G
  obtain ⟨K, hK⟩ := G (1 / 100 : ℝ) (by norm_num)
  obtain ⟨k, hk, hLlarge⟩ := powerTwo_legHeight_unbounded (max 0 K)
  let t := 2 ^ k
  let L := legHeight t
  have ht : 0 < t := by
    dsimp [t]
    positivity
  have hLpos : 0 < L := lt_of_le_of_lt (le_max_left _ _) hLlarge
  have hLK : K < L := lt_of_le_of_lt (le_max_right _ _) hLlarge
  have hRlower : 12 * L ^ 2 ≤ actualPeeledResidualCost t :=
    powerTwo_actualResidual_lower k hk
  have hPhiUpper : actualSquareFullCost t ≤ 84 * L ^ 2 :=
    powerTwo_actualSquareFull_upper k hk
  have hQUpper0 := actualPeeledCalibratedCost_le_two_full ht
  have hQUpper : actualPeeledCalibratedCost t ≤ 168 * L ^ 2 := by
    nlinarith
  have hgate := hK t ht
  norm_num at hgate
  have hgapUpper :
      actualPeeledResidualCost t -
          (1 / 100 : ℝ) * actualPeeledCalibratedCost t ≤
        2 * K * zLog t := by
    linarith
  have hgapLower :
      (258 / 25 : ℝ) * L ^ 2 ≤
        actualPeeledResidualCost t -
          (1 / 100 : ℝ) * actualPeeledCalibratedCost t := by
    nlinarith
  have hwUpper : zLog t ≤ 3 * L :=
    (powerTwo_log_corridor k hk).2.2.2.2.2
  by_cases hKnonneg : 0 ≤ K
  · have hheightUpper : 2 * K * zLog t ≤ 6 * K * L := by
      have h := mul_le_mul_of_nonneg_left hwUpper hKnonneg
      nlinarith
    have hKL : K * L < L ^ 2 := by
      have := mul_lt_mul_of_pos_right hLK hLpos
      nlinarith
    have hstrict : 6 * K * L < (258 / 25 : ℝ) * L ^ 2 := by
      nlinarith
    linarith
  · have hw0 : 0 < zLog t := zLog_pos ht
    have hrightNeg : 2 * K * zLog t < 0 := by
      exact mul_neg_of_neg_of_pos (by linarith) hw0
    have hleftPos : 0 < (258 / 25 : ℝ) * L ^ 2 := by positivity
    linarith

/-- The exact fixed quadratic chain misses the calibrated-boundary target
by an unbounded multiple of height, on positive primitive abc points. -/
theorem not_fixedQuadraticBoundaryGate : ¬ FixedQuadraticBoundaryGate := by
  rintro ⟨L, hL⟩
  obtain ⟨t, ht, huLarge⟩ := xLog_unbounded (max 0 (3 * L / 4))
  have hu0 : 0 ≤ xLog t := xLog_nonneg t
  have hv0 : 0 < yLog t := yLog_pos ht
  have hw0 : 0 < zLog t := zLog_pos ht
  have hα0 : 0 ≤ yRadicalLog t := legRadicalMass_nonneg _
  have hβ0 : 0 ≤ xRadicalLog t := legRadicalMass_nonneg _
  have hγ0 : 0 ≤ zRadicalLog t := legRadicalMass_nonneg _
  have hβu : xRadicalLog t ≤ xLog t := by
    exact legRadicalMass_le_legHeight (by simp [pythagoreanX])
  have hvw : yLog t ≤ zLog t := yLog_le_zLog ht
  have hwuv : zLog t ≤ xLog t + yLog t := zLog_le_xLog_add_yLog ht
  have hexcess := four_mul_u_v_le_boundaryExcess hu0 hα0 hβ0 hγ0 hβu hvw hwuv
  have hgate := hL t ht
  have hupper :
      actualPeeledCalibratedCost t -
          4 * zLog t *
            (yRadicalLog t + xRadicalLog t + zRadicalLog t) ≤
        2 * L * zLog t := by
    unfold actualPeeledCalibratedCost at hgate ⊢
    linarith
  have hcorridor := two_mul_zLog_le_three_mul_yLog ht
  have hmax : 3 * L / 4 < xLog t := lt_of_le_of_lt (le_max_right _ _) huLarge
  by_cases hLnonneg : 0 ≤ L
  · have hstrict : 2 * L * zLog t < 4 * xLog t * yLog t := by
      have hscaled : 2 * L * zLog t ≤ 3 * L * yLog t := by
        have h := mul_le_mul_of_nonneg_left hcorridor hLnonneg
        nlinarith
      have hyScale : 3 * L * yLog t < 4 * xLog t * yLog t := by
        have := mul_lt_mul_of_pos_right hmax hv0
        nlinarith
      exact lt_of_le_of_lt hscaled hyScale
    have hchain : 4 * xLog t * yLog t ≤ 2 * L * zLog t :=
      le_trans hexcess hupper
    exact (not_lt_of_ge hchain) hstrict
  · have hrightNeg : 2 * L * zLog t < 0 := by
      exact mul_neg_of_neg_of_pos (by linarith) hw0
    have hleftNonneg : 0 ≤ 4 * xLog t * yLog t := by positivity
    have hchain : 4 * xLog t * yLog t ≤ 2 * L * zLog t :=
      le_trans hexcess hupper
    have : 0 ≤ 2 * L * zLog t := le_trans hleftNonneg hchain
    exact (not_lt_of_ge this) hrightNeg

end
end QuadraticVeronesePeeling20260902
end IUTThreeClosures

