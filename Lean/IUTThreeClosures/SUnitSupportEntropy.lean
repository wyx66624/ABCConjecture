/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SUnitUniformTripod

/-!
# Support entropy and the varying-S S-unit barrier

This file isolates the finite-support optimization which a quantitative
S-unit or Subspace-Theorem argument would have to pass after the exact
rational-tripod reformulation.

The positive result is a smooth/rough splitting lemma.  A support overhead
is absorbable with arbitrarily small conductor slope when, outside one fixed
finite set, its local cost is at most `epsilon` times the logarithmic prime
weight.  In particular a constant cost per support prime is harmless once
large primes are charged against their logarithms and the finitely many
small primes are put into the additive constant.

The negative results are equally explicit:

* a fixed positive multiple of the full logarithmic mass is not
  epsilon-absorbable for smaller epsilon;
* a two-place product of logarithmic weights is not linearly absorbable;
* even one point per exact support, and finitely many points in every fixed
  finite support, does not control the largest height.

These last statements audit particular inference patterns.  They do not
assert counterexamples among actual S-unit solutions.  No S-unit theorem,
Subspace Theorem, Baker estimate, abc bound, or target inequality is stored
as a field or hypothesis in this module.
-/

namespace IUTThreeClosures

open scoped BigOperators

noncomputable section

variable {ι : Type*}

/-! ## Abstract logarithmic support accounting -/

/-- Total logarithmic mass of a finite support with arbitrary real weights. -/
def finiteSupportMass (S : Finset ι) (weight : ι → ℝ) : ℝ :=
  ∑ i ∈ S, weight i

/-- The part of `S` lying in a fixed finite ("smooth") universe `U`. -/
def supportSmall [DecidableEq ι] (U S : Finset ι) : Finset ι :=
  S.filter fun i => i ∈ U

/-- The complementary ("rough") part of `S`. -/
def supportTail [DecidableEq ι] (U S : Finset ι) : Finset ι :=
  S.filter fun i => i ∉ U

/-- Exact partition of support mass into its fixed-small and varying-tail
parts. -/
theorem finiteSupportMass_small_add_tail
    [DecidableEq ι] (U S : Finset ι) (weight : ι → ℝ) :
    finiteSupportMass (supportSmall U S) weight +
        finiteSupportMass (supportTail U S) weight =
      finiteSupportMass S weight := by
  unfold finiteSupportMass supportSmall supportTail
  simpa using
    (Finset.sum_filter_add_sum_filter_not S
      (fun i => i ∈ U) weight)

/-- Exact cardinality partition for the same split. -/
theorem supportSmall_card_add_supportTail_card
    [DecidableEq ι] (U S : Finset ι) :
    (supportSmall U S).card + (supportTail U S).card = S.card := by
  unfold supportSmall supportTail
  simpa using
    (Finset.card_filter_add_card_filter_not (s := S) (fun i => i ∈ U))

/-- The small part is contained in the fixed universe. -/
theorem supportSmall_subset_left
    [DecidableEq ι] (U S : Finset ι) :
    supportSmall U S ⊆ U := by
  intro i hi
  exact (Finset.mem_filter.mp hi).2

/-- The tail is contained in the original support. -/
theorem supportTail_subset_right
    [DecidableEq ι] (U S : Finset ι) :
    supportTail U S ⊆ S := by
  intro i hi
  exact (Finset.mem_filter.mp hi).1

/-- Nonnegative weights make the mass monotone under passage to the tail. -/
theorem finiteSupportMass_tail_le
    [DecidableEq ι] (U S : Finset ι) (weight : ι → ℝ)
    (hweight : ∀ i ∈ S, 0 ≤ weight i) :
    finiteSupportMass (supportTail U S) weight ≤
      finiteSupportMass S weight := by
  unfold finiteSupportMass
  apply Finset.sum_le_sum_of_subset_of_nonneg
    (supportTail_subset_right U S)
  intro i hiS hiNotTail
  exact hweight i hiS

/-- If every tail weight is at least `threshold`, its cardinality times the
threshold is bounded by its logarithmic mass. -/
theorem threshold_mul_supportTail_card_le_mass
    [DecidableEq ι] (U S : Finset ι) (weight : ι → ℝ)
    (threshold : ℝ)
    (htail : ∀ i ∈ S, i ∉ U → threshold ≤ weight i) :
    threshold * ((supportTail U S).card : ℝ) ≤
      finiteSupportMass (supportTail U S) weight := by
  calc
    threshold * ((supportTail U S).card : ℝ) =
        ∑ i ∈ supportTail U S, threshold := by
          simp [mul_comm]
    _ ≤ ∑ i ∈ supportTail U S, weight i := by
      apply Finset.sum_le_sum
      intro i hi
      have hi' := Finset.mem_filter.mp hi
      exact htail i hi'.1 hi'.2
    _ = finiteSupportMass (supportTail U S) weight := rfl

/-- General tail-local absorption lemma.  The arbitrary cost on the fixed
small universe contributes only the fixed sum over `U`; every tail cost is
charged with slope `epsilon` against its own logarithmic weight. -/
theorem finiteSupportCost_le_epsilon_mass_add_fixed
    (U S : Finset ι) (weight cost : ι → ℝ) (epsilon : ℝ)
    (hepsilon : 0 ≤ epsilon)
    (hweight : ∀ i ∈ S, 0 ≤ weight i)
    (hfixedCost : ∀ i ∈ U, 0 ≤ cost i)
    (htailCost : ∀ i ∈ S, i ∉ U → cost i ≤ epsilon * weight i) :
    finiteSupportMass S cost ≤
      epsilon * finiteSupportMass S weight +
        finiteSupportMass U cost := by
  classical
  have hsmall :
      finiteSupportMass (supportSmall U S) cost ≤
        finiteSupportMass U cost := by
    unfold finiteSupportMass
    apply Finset.sum_le_sum_of_subset_of_nonneg
      (supportSmall_subset_left U S)
    intro i hiU hiNotSmall
    exact hfixedCost i hiU
  have htailPointwise :
      finiteSupportMass (supportTail U S) cost ≤
        epsilon * finiteSupportMass (supportTail U S) weight := by
    unfold finiteSupportMass
    rw [Finset.mul_sum]
    apply Finset.sum_le_sum
    intro i hi
    have hi' := Finset.mem_filter.mp hi
    exact htailCost i hi'.1 hi'.2
  have htailMass := finiteSupportMass_tail_le U S weight hweight
  have htail :
      finiteSupportMass (supportTail U S) cost ≤
        epsilon * finiteSupportMass S weight :=
    htailPointwise.trans
      (mul_le_mul_of_nonneg_left htailMass hepsilon)
  have hcostSplit := finiteSupportMass_small_add_tail U S cost
  linarith

/-- Constant cost per support element is absorbable after a smooth/rough
split.  The tail condition says that the chosen cutoff has logarithmic
weight large enough that `unitCost <= epsilon * weight`; the small part costs
at most `unitCost * card U`, a fixed additive constant. -/
theorem supportCardCost_le_epsilon_mass_add_fixed
    (U S : Finset ι) (weight : ι → ℝ)
    (unitCost epsilon threshold : ℝ)
    (hunitCost : 0 ≤ unitCost)
    (hepsilon : 0 ≤ epsilon)
    (hweight : ∀ i ∈ S, 0 ≤ weight i)
    (hcutoff : unitCost ≤ epsilon * threshold)
    (htailWeight : ∀ i ∈ S, i ∉ U → threshold ≤ weight i) :
    unitCost * (S.card : ℝ) ≤
      epsilon * finiteSupportMass S weight +
        unitCost * (U.card : ℝ) := by
  classical
  have h := finiteSupportCost_le_epsilon_mass_add_fixed
    U S weight (fun _ => unitCost) epsilon hepsilon hweight
    (by intro i hi; exact hunitCost)
    (by
      intro i hiS hiU
      exact hcutoff.trans
        (mul_le_mul_of_nonneg_left (htailWeight i hiS hiU) hepsilon))
  simpa [finiteSupportMass, mul_comm] using h

/-! ## Uniformizing the finitely many small supports -/

/-- An explicit common upper envelope for arbitrary constants attached to
subsets of one fixed finite universe. -/
def finiteSubsetConstantEnvelope
    [DecidableEq ι] (U : Finset ι) (constant : Finset ι → ℝ) : ℝ :=
  ∑ A ∈ U.powerset, |constant A|

/-- Every support-dependent constant on a subset of the fixed small universe
is bounded by the single finite envelope above. -/
theorem finiteSubsetConstant_le_envelope
    [DecidableEq ι]
    (U A : Finset ι) (constant : Finset ι → ℝ)
    (hA : A ⊆ U) :
    constant A ≤ finiteSubsetConstantEnvelope U constant := by
  have hmem : A ∈ U.powerset := Finset.mem_powerset.mpr hA
  have habs :
      |constant A| ≤ ∑ B ∈ U.powerset, |constant B| := by
    exact Finset.single_le_sum
      (fun B hB => abs_nonneg (constant B)) hmem
  exact (le_abs_self (constant A)).trans habs

/-- Pointwise height bookkeeping obtained from the tail-local overhead lemma
and finite uniformization of all small-support constants.  This is a numeric
implication, not a stored global Diophantine conjecture. -/
theorem height_le_one_add_epsilon_mass_of_tail_local_cost
    [DecidableEq ι]
    (U S : Finset ι) (weight cost : ι → ℝ)
    (smallConstant : Finset ι → ℝ)
    (height epsilon : ℝ)
    (hepsilon : 0 ≤ epsilon)
    (hweight : ∀ i ∈ S, 0 ≤ weight i)
    (hfixedCost : ∀ i ∈ U, 0 ≤ cost i)
    (htailCost : ∀ i ∈ S, i ∉ U → cost i ≤ epsilon * weight i)
    (hheight :
      height ≤ finiteSupportMass S weight + finiteSupportMass S cost +
        smallConstant (supportSmall U S)) :
    height ≤
      (1 + epsilon) * finiteSupportMass S weight +
        finiteSupportMass U cost +
        finiteSubsetConstantEnvelope U smallConstant := by
  have hoverhead := finiteSupportCost_le_epsilon_mass_add_fixed
    U S weight cost epsilon hepsilon hweight hfixedCost htailCost
  have hsmallSubset := supportSmall_subset_left U S
  have hconstant := finiteSubsetConstant_le_envelope
    U (supportSmall U S) smallConstant hsmallSubset
  linarith

/-! ## Strict non-absorption barriers -/

/-- A fixed positive residual slope on the full logarithmic mass cannot be
absorbed with any strictly smaller slope and one uniform additive constant. -/
theorem fixed_mass_slope_not_absorbable
    {residualSlope targetSlope : ℝ}
    (hslope : targetSlope < residualSlope) :
    ¬ ∃ constant : ℝ, ∀ mass : ℝ, 0 ≤ mass →
      residualSlope * mass ≤ targetSlope * mass + constant := by
  rintro ⟨constant, hconstant⟩
  have hgap : 0 < residualSlope - targetSlope := sub_pos.mpr hslope
  let mass : ℝ := (|constant| + 1) / (residualSlope - targetSlope)
  have hmass : 0 ≤ mass := by
    dsimp [mass]
    positivity
  have hbound := hconstant mass hmass
  have hidentity :
      (residualSlope - targetSlope) * mass = |constant| + 1 := by
    dsimp [mass]
    field_simp [hgap.ne']
  have hconstantAbs : constant ≤ |constant| := le_abs_self constant
  nlinarith

/-- A product of two independently large place weights cannot be converted
into a uniform linear function of their sum. -/
theorem two_place_weight_product_not_linearly_absorbable
    (linearSlope : ℝ) :
    ¬ ∃ constant : ℝ, ∀ weight : ℝ, 0 ≤ weight →
      weight * weight ≤ linearSlope * (weight + weight) + constant := by
  rintro ⟨constant, hconstant⟩
  let weight : ℝ := 2 * |linearSlope| + |constant| + 2
  have hweight : 0 ≤ weight := by
    dsimp [weight]
    positivity
  have hbound := hconstant weight hweight
  have hslopeAbs : linearSlope ≤ |linearSlope| := le_abs_self linearSlope
  have hconstantAbs : constant ≤ |constant| := le_abs_self constant
  have hslopeNonneg : 0 ≤ |linearSlope| := abs_nonneg linearSlope
  have hconstantNonneg : 0 ≤ |constant| := abs_nonneg constant
  dsimp [weight] at hbound
  nlinarith [mul_nonneg hslopeNonneg hconstantNonneg]

/-! ## Counts and gap principles do not locate the last solution -/

/-- A toy family with one label per exact support. -/
def supportEntropyToySupport (weight : ℝ) : Finset ℝ := {weight}

/-- Its assigned logarithmic mass. -/
def supportEntropyToyMass (weight : ℝ) : ℝ := weight

/-- Its deliberately quadratic height. -/
def supportEntropyToyHeight (weight : ℝ) : ℝ := weight * weight

/-- Exact support determines the toy point, so every exact support contains
at most one point. -/
theorem supportEntropyToySupport_injective :
    Function.Injective supportEntropyToySupport := by
  intro x y hxy
  simpa [supportEntropyToySupport] using hxy

/-- Every fixed finite support universe contains only finitely many toy
points. -/
theorem supportEntropyToy_fixed_support_finite (U : Finset ℝ) :
    Set.Finite {weight : ℝ | supportEntropyToySupport weight ⊆ U} := by
  apply U.finite_toSet.subset
  intro weight hweight
  exact Finset.singleton_subset_iff.mp hweight

/-- Nonetheless no uniform linear height bound follows, even though exact
support multiplicity is one and fixed-universe solution sets are finite. -/
theorem supportEntropyToy_no_uniform_linear_height :
    ¬ ∃ linearSlope constant : ℝ, ∀ weight : ℝ, 0 ≤ weight →
      supportEntropyToyHeight weight ≤
        linearSlope * supportEntropyToyMass weight + constant := by
  rintro ⟨linearSlope, constant, hbound⟩
  have hquadratic := two_place_weight_product_not_linearly_absorbable
    (linearSlope / 2)
  apply hquadratic
  refine ⟨constant, ?_⟩
  intro weight hweight
  have h := hbound weight hweight
  calc
    weight * weight ≤ linearSlope * weight + constant := by
      simpa [supportEntropyToyHeight, supportEntropyToyMass] using h
    _ = (linearSlope / 2) * (weight + weight) + constant := by ring

end

end IUTThreeClosures
