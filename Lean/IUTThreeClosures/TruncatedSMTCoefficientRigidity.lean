/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArakelovFermatLogCanonical

/-!
# Coefficient rigidity for truncated-SMT cover arguments

This file formalizes the scalar core of three audits of a proposed
Fermat/Kummer or higher-dimensional truncated second-main-theorem argument.

* At a tame place, reduced boundary plus normalized different has coefficient
  exactly one for every ramification index.  Positive averaging, towers, and
  extra ramification cannot lower it.
* A fixed error coefficient can be diluted by one sufficiently large cover.
  The additive constant may depend arbitrarily on that chosen cover: what is
  essential is uniformity in the arithmetic point and its varying support for
  the fixed cover.
* Amortizing one counting/discriminant budget across several correlated lifts
  would be powerful, but an inequality of that shape is false on an unbounded
  family as soon as its net height slope exceeds two.  In a genuine ambient
  theorem the correlated diagonal can therefore be part of the exceptional
  locus.

The last section records the numerical Riemann--Hurwitz obstruction to
creating infinitely many support-preserving self-maps of the punctured
tripod: three totally ramified fibres force degree one.

All statements are elementary consequences of ordered-field algebra.  No
Vojta, Subspace, S-unit, or `abc` estimate is assumed or stored as data.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-! ## Tame log-budget rigidity -/

/-- Normalized reduced-boundary coefficient for ramification index `e`. -/
noncomputable def abstractTameBoundaryWeight (e : ℕ) : ℝ :=
  1 / (e : ℝ)

/-- Normalized tame-different coefficient for ramification index `e`. -/
noncomputable def abstractTameDifferentWeight (e : ℕ) : ℝ :=
  ((e : ℝ) - 1) / (e : ℝ)

/-- Reduced boundary and tame different have total coefficient one for every
positive ramification index. -/
theorem abstract_tame_boundary_add_different
    (e : ℕ) (he : 0 < e) :
    abstractTameBoundaryWeight e + abstractTameDifferentWeight e = 1 := by
  simp only [abstractTameBoundaryWeight, abstractTameDifferentWeight]
  have he' : (e : ℝ) ≠ 0 := by exact_mod_cast he.ne'
  field_simp [he']
  ring

/-- The same identity after multiplying by an arbitrary local logarithmic
mass. -/
theorem abstract_tame_local_budget
    (e : ℕ) (mass : ℝ) (he : 0 < e) :
    (abstractTameBoundaryWeight e + abstractTameDifferentWeight e) * mass =
      mass := by
  rw [abstract_tame_boundary_add_different e he, one_mul]

/-- Extra ramification away from the reduced boundary contributes a
nonnegative normalized error and cannot improve the coefficient one. -/
theorem abstract_tame_budget_with_extra_ge
    (e : ℕ) (extra : ℝ) (he : 0 < e) (hextra : 0 ≤ extra) :
    1 ≤ abstractTameBoundaryWeight e + abstractTameDifferentWeight e +
      extra / (e : ℝ) := by
  rw [abstract_tame_boundary_add_different e he]
  have heR : 0 ≤ (e : ℝ) := by positivity
  exact le_add_of_nonneg_right (div_nonneg hextra heR)

/-- Every positive weighted average of complete tame budgets still has
coefficient one.  Thus mixing several covering degrees cannot create a
coefficient below one. -/
theorem weighted_average_tame_budget_eq_one
    {I : Type*} (S : Finset I) (weight : I → ℝ) (index : I → ℕ)
    (hindex : ∀ i ∈ S, 0 < index i)
    (hweight : ∑ i ∈ S, weight i = 1) :
    ∑ i ∈ S,
        weight i *
          (abstractTameBoundaryWeight (index i) +
            abstractTameDifferentWeight (index i)) = 1 := by
  calc
    ∑ i ∈ S,
        weight i *
          (abstractTameBoundaryWeight (index i) +
            abstractTameDifferentWeight (index i)) =
        ∑ i ∈ S, weight i := by
          apply Finset.sum_congr rfl
          intro i hi
          rw [abstract_tame_boundary_add_different (index i) (hindex i hi),
            mul_one]
    _ = 1 := hweight

/-! ## Which constants actually need to be uniform -/

/-- If a fixed-cover estimate has error slope at most
`epsilon/(1+epsilon)`, it gives the target `1+epsilon` coefficient.  The
constant in this theorem is the constant of this one selected cover; no
bound in terms of the cover degree is used. -/
theorem fixed_cover_error_rearrangement
    {epsilon height count errorSlope constant : ℝ}
    (hepsilon : 0 < epsilon) (hheight : 0 ≤ height)
    (hslope : errorSlope ≤ epsilon / (1 + epsilon))
    (hestimate :
      height ≤ count + errorSlope * height + constant) :
    height ≤
      (1 + epsilon) * count + (1 + epsilon) * constant := by
  have hslopeHeight :
      errorSlope * height ≤ epsilon / (1 + epsilon) * height :=
    mul_le_mul_of_nonneg_right hslope hheight
  have hVojta :
      height ≤ count + epsilon / (1 + epsilon) * height + constant := by
    linarith
  exact vojta_eta_rearrangement hepsilon hVojta

/-- The version used after a local boundary--different estimate.  Both
additive constants may depend arbitrarily on the one cover selected for the
given `epsilon`; they only have to be independent of the varying arithmetic
point for that fixed cover. -/
theorem fixed_cover_local_budget_rearrangement
    {epsilon height localBudget count errorSlope localConstant smtConstant : ℝ}
    (hepsilon : 0 < epsilon) (hheight : 0 ≤ height)
    (hslope : errorSlope ≤ epsilon / (1 + epsilon))
    (hlocal : localBudget ≤ count + localConstant)
    (hSMT : height ≤ localBudget + errorSlope * height + smtConstant) :
    height ≤
      (1 + epsilon) * count +
        (1 + epsilon) * (localConstant + smtConstant) := by
  apply fixed_cover_error_rearrangement hepsilon hheight hslope
  linarith

/-- A purely algebraic cover-degree specialization.  It exposes the only
degree condition used by the transfer: `kappa/degree` must be small.  There
is deliberately no upper bound on `localConstant` or `smtConstant` as
functions of `degree`. -/
theorem cover_degree_dilution_rearrangement
    {epsilon height localBudget count kappa degree localConstant smtConstant : ℝ}
    (hepsilon : 0 < epsilon) (hheight : 0 ≤ height)
    (hdegree : 0 < degree)
    (hdilute : kappa / degree ≤ epsilon / (1 + epsilon))
    (hlocal : localBudget ≤ count + localConstant)
    (hSMT : height ≤ localBudget + (kappa / degree) * height + smtConstant) :
    height ≤
      (1 + epsilon) * count +
        (1 + epsilon) * (localConstant + smtConstant) := by
  have _hdegreeNonzero : degree ≠ 0 := hdegree.ne'
  exact fixed_cover_local_budget_rearrangement hepsilon hheight hdilute
    hlocal hSMT

/-! ## The correlated-product exceptional-locus obstruction -/

/-- Formal scalar gain one would obtain if `copies` correlated lifts shared
one counting/discriminant budget. -/
theorem correlated_product_amortization
    {copies errorSlope height count constant : ℝ}
    (hnet : 0 < copies - errorSlope)
    (hproduct : copies * height ≤ count + errorSlope * height + constant) :
    height ≤ count / (copies - errorSlope) +
      constant / (copies - errorSlope) := by
  rw [← add_div]
  apply (le_div_iff₀ hnet).2
  linarith

/-- Abstract strict counterexample mechanism for the preceding
amortization.  On any family with unbounded nonnegative height and
`count ≤ 2*height`, no uniform correlated-product inequality can have net
height slope larger than two. -/
theorem no_correlated_product_bound_above_two
    {I : Type*} (height count : I → ℝ)
    (hunbounded : ∀ T : ℝ, ∃ i : I, T < height i)
    (hcount : ∀ i : I, count i ≤ 2 * height i)
    {copies errorSlope constant : ℝ}
    (hgap : 2 < copies - errorSlope) :
    ¬ ∀ i : I,
      copies * height i ≤ count i + errorSlope * height i + constant := by
  intro hall
  have hpositive : 0 < copies - errorSlope - 2 := by linarith
  obtain ⟨i, hi⟩ :=
    hunbounded ((|constant| + 1) / (copies - errorSlope - 2))
  have hdenmul :
      |constant| + 1 <
        (copies - errorSlope - 2) * height i := by
    simpa [mul_comm] using (div_lt_iff₀ hpositive).mp hi
  have hC : constant ≤ |constant| := le_abs_self constant
  have h := hall i
  have hq := hcount i
  linarith

/-- A concrete logical model of the exceptional-locus issue: every
correlated pair lies on the diagonal. -/
def correlatedDiagonal {X : Type*} : Set (X × X) :=
  {P | P.1 = P.2}

theorem diagonal_pair_mem_correlatedDiagonal {X : Type*} (x : X) :
    (x, x) ∈ correlatedDiagonal := by
  rfl

/-- The diagonal is a proper subset as soon as two distinct points exist.
Hence a theorem valid only away from an unspecified proper exceptional set
may exclude every correlated pair. -/
theorem correlatedDiagonal_ne_univ
    {X : Type*} [Nontrivial X] :
    correlatedDiagonal (X := X) ≠ Set.univ := by
  obtain ⟨x, y, hxy⟩ := exists_pair_ne X
  intro h
  have hmem : (x, y) ∈ correlatedDiagonal (X := X) := by
    rw [h]
    trivial
  exact hxy hmem

/-! ## Support-preserving tripod self-map rigidity -/

/-- Numerical Riemann--Hurwitz core: a self-map of `P¹` with three totally
ramified fibres has degree one.  Geometrically, a rational map satisfying
`f⁻¹{0,1,∞} ⊆ {0,1,∞}` has precisely such three fibres, so this
rules out higher-degree support-preserving tripod self-maps. -/
theorem three_totally_ramified_fibres_force_degree_one
    {degree : ℤ} (hdegree : 1 ≤ degree)
    (hRiemannHurwitz : 3 * (degree - 1) ≤ 2 * degree - 2) :
    degree = 1 := by
  omega

/-! ## Multiplicity and reduced-support costs of new boundary points -/

/-- Let a degree-`degree` rational self-map be tested against the tripod.
Write `oldMultiplicity` for the total multiplicity in the pullback of the
three target boundary points supported at the three old source boundary
points, and `newBoundaryDegree = 3*degree-oldMultiplicity` for the remaining
pullback degree.  Riemann--Hurwitz gives
`oldMultiplicity-3 ≤ 2*degree-2`.  After the new boundary is paid for, the
net height gain of the map is

`degree-newBoundaryDegree = oldMultiplicity-2*degree ≤ 1`.

This is a multiplicity-cost surrogate.  `newBoundaryDegree` counts total
multiplicity, not the number of distinct points in the reduced pullback, so
the theorem must not be read as a level-one truncated-support formula. -/
theorem tripod_correspondence_net_gain_le_one
    {degree oldMultiplicity newBoundaryDegree : ℤ}
    (hboundary : newBoundaryDegree = 3 * degree - oldMultiplicity)
    (hRiemannHurwitz : oldMultiplicity - 3 ≤ 2 * degree - 2) :
    degree - newBoundaryDegree ≤ 1 := by
  omega

/-- Positive integral gain for the multiplicity-cost surrogate is possible
only in its extremal case.  This statement is not yet the reduced-support
truncation theorem below. -/
theorem positive_tripod_correspondence_gain_is_extremal
    {degree oldMultiplicity newBoundaryDegree : ℤ}
    (hboundary : newBoundaryDegree = 3 * degree - oldMultiplicity)
    (hRiemannHurwitz : oldMultiplicity - 3 ≤ 2 * degree - 2)
    (hgain : 0 < degree - newBoundaryDegree) :
    degree - newBoundaryDegree = 1 ∧
      oldMultiplicity = 2 * degree + 1 ∧
      newBoundaryDegree = degree - 1 := by
  have hle : degree - newBoundaryDegree ≤ 1 :=
    tripod_correspondence_net_gain_le_one hboundary hRiemannHurwitz
  constructor
  · omega
  constructor <;> omega

/-- If the old-boundary multiplicity is at most `2*degree`, the
multiplicity-cost surrogate has nonpositive gain. -/
theorem deforming_tripod_correspondence_gain_nonpos
    {degree oldMultiplicity newBoundaryDegree : ℤ}
    (hboundary : newBoundaryDegree = 3 * degree - oldMultiplicity)
    (hdeform : oldMultiplicity ≤ 2 * degree) :
    degree - newBoundaryDegree ≤ 0 := by
  omega

/-- Correct level-one version.  Let `oldSupport` be the number of distinct
points of the reduced pullback lying in the old tripod, and `newSupport` the
number of all other distinct pullback points.  The three target fibres have
total ramification `3*degree-(oldSupport+newSupport)`.  Riemann--Hurwitz and
`oldSupport ≤ 3` force the net reduced-support gain
`degree-newSupport` to be at most one. -/
theorem reduced_tripod_support_net_gain_le_one
    {degree oldSupport newSupport : ℤ}
    (hold : oldSupport ≤ 3)
    (hRiemannHurwitz :
      3 * degree - (oldSupport + newSupport) ≤ 2 * degree - 2) :
    degree - newSupport ≤ 1 := by
  omega

/-- Positive reduced-support gain is rigid: it is exactly one, all three old
tripod points occur, there are exactly `degree-1` new support points, and the
three target fibres consume the complete Riemann--Hurwitz budget. -/
theorem positive_reduced_tripod_support_gain_is_extremal
    {degree oldSupport newSupport : ℤ}
    (hold : oldSupport ≤ 3)
    (hRiemannHurwitz :
      3 * degree - (oldSupport + newSupport) ≤ 2 * degree - 2)
    (hgain : 0 < degree - newSupport) :
    degree - newSupport = 1 ∧
      oldSupport = 3 ∧
      newSupport = degree - 1 ∧
      3 * degree - (oldSupport + newSupport) = 2 * degree - 2 := by
  have hle : degree - newSupport ≤ 1 :=
    reduced_tripod_support_net_gain_le_one hold hRiemannHurwitz
  constructor
  · omega
  constructor
  · omega
  constructor <;> omega

/-- With at most two old tripod support points, the reduced-support net gain
is nonpositive. -/
theorem reduced_tripod_support_gain_nonpos_of_oldSupport_le_two
    {degree oldSupport newSupport : ℤ}
    (hold : oldSupport ≤ 2)
    (hRiemannHurwitz :
      3 * degree - (oldSupport + newSupport) ≤ 2 * degree - 2) :
    degree - newSupport ≤ 0 := by
  omega

/-! ## A bounded shear and the surface coefficient -/

/-- Absolute rational height is subadditive under multiplication. -/
theorem rational_normalizedLogHeight_mul_le (x y : ℚ) :
    Heights.normalizedLogHeight ℚ (x * y) ≤
      Heights.normalizedLogHeight ℚ x +
        Heights.normalizedLogHeight ℚ y := by
  simpa [Heights.normalizedLogHeight] using Height.logHeight₁_mul_le x y

/-- Multiplication by one fixed nonzero rational changes height by at most
the height of the multiplier.  This is the abstract height estimate behind
the shear `(lambda,u*lambda)`. -/
theorem rational_shear_height_bounds
    (u x : ℚ) (hu : u ≠ 0) :
    Heights.normalizedLogHeight ℚ x -
        Heights.normalizedLogHeight ℚ u ≤
      Heights.normalizedLogHeight ℚ (u * x) ∧
    Heights.normalizedLogHeight ℚ (u * x) ≤
      Heights.normalizedLogHeight ℚ x +
        Heights.normalizedLogHeight ℚ u := by
  constructor
  · have hmul := rational_normalizedLogHeight_mul_le (u * x) u⁻¹
    have hinv :
        Heights.normalizedLogHeight ℚ u⁻¹ =
          Heights.normalizedLogHeight ℚ u := by
      simpa [Heights.normalizedLogHeight] using Height.logHeight₁_inv u
    have hx : (u * x) * u⁻¹ = x := by
      field_simp
    rw [hx, hinv] at hmul
    linarith
  · simpa [add_comm] using rational_normalizedLogHeight_mul_le u x

/-- Finite exceptional-set avoidance in its combinatorial form.  Once a
bounded candidate set has more elements than the forbidden fibre, one
candidate escapes. -/
theorem finite_candidate_escape
    {X : Type*}
    (candidates forbidden : Finset X)
    (hcard : forbidden.card < candidates.card) :
    ∃ x ∈ candidates, x ∉ forbidden := by
  classical
  by_contra! hall
  have hsubset : candidates ⊆ forbidden := by
    intro x hx
    exact hall x hx
  exact (not_le_of_gt hcard) (Finset.card_le_card hsubset)

/-- Exact scalar transfer for the bounded-shear correction.  Here `total`
is the `O(1,1)` height, `unionCount` is the level-one count of the reduced
union divisor (not a sum of separately truncated components), and
`fixedLoss` absorbs the bounded multiplier height. -/
theorem sheared_surface_smt_rearrangement
    {epsilon height total unionCount count fixedLoss smtConstant : ℝ}
    (hepsilon : 0 < epsilon)
    (htotalLower : 2 * height - fixedLoss ≤ total)
    (htotalUpper : total ≤ 2 * height + fixedLoss)
    (hunion : unionCount ≤ count + height + fixedLoss)
    (hSMT :
      total ≤ unionCount +
        (epsilon / (2 * (1 + epsilon))) * total + smtConstant) :
    height ≤
      (1 + epsilon) * count +
        (1 + epsilon) *
          (smtConstant +
            (2 + epsilon / (2 * (1 + epsilon))) * fixedLoss) := by
  have hden : 0 < 1 + epsilon := by linarith
  have htwoDen : 0 < 2 * (1 + epsilon) := mul_pos (by norm_num) hden
  have heta :
      2 * (epsilon / (2 * (1 + epsilon))) =
        epsilon / (1 + epsilon) := by
    field_simp [hden.ne']
  have hetaHeight :
      (epsilon / (2 * (1 + epsilon))) * (2 * height) =
        (epsilon / (1 + epsilon)) * height := by
    calc
      (epsilon / (2 * (1 + epsilon))) * (2 * height) =
          (2 * (epsilon / (2 * (1 + epsilon)))) * height := by ring
      _ = (epsilon / (1 + epsilon)) * height := by rw [heta]
  have hcombined :
      2 * height - fixedLoss ≤
        count + height + fixedLoss +
          (epsilon / (2 * (1 + epsilon))) *
            (2 * height + fixedLoss) + smtConstant := by
    calc
      2 * height - fixedLoss ≤ total := htotalLower
      _ ≤ unionCount +
          (epsilon / (2 * (1 + epsilon))) * total + smtConstant := hSMT
      _ ≤ (count + height + fixedLoss) +
          (epsilon / (2 * (1 + epsilon))) *
            (2 * height + fixedLoss) + smtConstant := by
        have hetaNonneg : 0 ≤ epsilon / (2 * (1 + epsilon)) :=
          div_nonneg hepsilon.le htwoDen.le
        nlinarith [mul_le_mul_of_nonneg_left htotalUpper hetaNonneg]
  rw [mul_add, hetaHeight] at hcombined
  let eta : ℝ := epsilon / (2 * (1 + epsilon))
  have hcore :
      (1 - 2 * eta) * height ≤
        count + smtConstant + (2 + eta) * fixedLoss := by
    dsimp [eta]
    nlinarith
  have hscale : (1 + epsilon) * (1 - 2 * eta) = 1 := by
    dsimp [eta]
    field_simp [hden.ne']
    ring
  have hscaled := mul_le_mul_of_nonneg_left hcore hden.le
  calc
    height = (1 + epsilon) * ((1 - 2 * eta) * height) := by
      rw [← mul_assoc, hscale, one_mul]
    _ ≤ (1 + epsilon) *
        (count + smtConstant + (2 + eta) * fixedLoss) := hscaled
    _ = (1 + epsilon) * count +
        (1 + epsilon) *
          (smtConstant +
            (2 + epsilon / (2 * (1 + epsilon))) * fixedLoss) := by
      dsimp [eta]
      ring

/-! ## A strict audit of product-of-place-log constants -/

/-- A two-place product such as `(log p)(log q)` cannot be bounded by a
uniform linear function of `log p + log q`.  This does not refute Baker's
method; it proves that an estimate retaining such a product cannot by itself
be absorbed into an `abc`-scale conductor coefficient. -/
theorem two_place_log_product_not_linearly_absorbable
    (alpha : ℝ) :
    ¬ ∃ constant : ℝ, ∀ t : ℝ, 0 ≤ t →
      t * t ≤ alpha * (t + t) + constant := by
  rintro ⟨constant, hconstant⟩
  let t : ℝ := 2 * |alpha| + |constant| + 2
  have ht : 0 ≤ t := by
    dsimp [t]
    positivity
  have hbound := hconstant t ht
  have ha : alpha ≤ |alpha| := le_abs_self alpha
  have hc : constant ≤ |constant| := le_abs_self constant
  have habsa : 0 ≤ |alpha| := abs_nonneg alpha
  have habsc : 0 ≤ |constant| := abs_nonneg constant
  dsimp [t] at hbound
  nlinarith [mul_nonneg habsa habsc]

end IUTThreeClosures
