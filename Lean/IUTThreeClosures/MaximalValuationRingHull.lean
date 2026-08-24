/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FiniteProductLogVolume
import IUTThreeClosures.TateParameterUnitBallRegion
import Mathlib.MeasureTheory.Measure.Haar.DistribChar
import Mathlib.Topology.Algebra.Valued.LocallyCompact

/-!
# Least products of scaled maximal valuation rings

This file proves the local compact-hull statement needed before one can speak
about a logarithmic volume of a theta-output packet.  No hull, leastness, or
volume conclusion is stored in an input structure.

For a finite family of nonarchimedean normed fields, write

`B(a) = {x | forall c, ‖x c‖ <= ‖a c‖}`.

The norm-unit ball is the genuine valuation-integer ring `𝒪[K]`.  If the
closure of `U` is compact and every coordinate projection of `U` contains a
nonzero element, the coordinatewise maxima of the norm give a nonzero scale
`a` for which `B(a)` is the least such product containing `U`.

The second part constructs normalized additive Haar measure directly from the
positive compact unit ball.  It proves finite positivity for every nonzero
scaled ball.  Identifying the distributive Haar character with a
residue-cardinality/order expression is deliberately not assumed here.
-/

namespace IUTThreeClosures.MaximalValuationRingHull

open MeasureTheory Set TopologicalSpace
open scoped ENNReal NNReal NormedField Pointwise Valued

universe u v

/-! ## The actual maximal valuation-integer ball -/

/-- A scalar-radius presentation of a product of scaled norm-unit balls. -/
def productHull {C : Type v} {K : C → Type u}
    [∀ c, NormedField (K c)] (a : ∀ c, K c) : Set (∀ c, K c) :=
  {x | ∀ c, ‖x c‖ ≤ ‖a c‖}

@[simp]
theorem mem_productHull {C : Type v} {K : C → Type u}
    [∀ c, NormedField (K c)] {a x : ∀ c, K c} :
    x ∈ productHull a ↔ ∀ c, ‖x c‖ ≤ ‖a c‖ :=
  Iff.rfl

/-- Multiplying the norm-unit ball by `a` gives exactly the closed norm ball
of radius `‖a‖`; this includes the degenerate case `a = 0`. -/
theorem scaled_normIntegralRegion_eq_normBall
    {K : Type u} [NormedField K] (a : K) :
    TateCurvesTheta.scaledRegion a
        (TateCurvesTheta.normIntegralRegion (K := K)) =
      {x : K | ‖x‖ ≤ ‖a‖} := by
  ext x
  constructor
  · rintro ⟨y, hy, rfl⟩
    change ‖a * y‖ ≤ ‖a‖
    calc
      ‖a * y‖ = ‖a‖ * ‖y‖ := norm_mul _ _
      _ ≤ ‖a‖ * 1 :=
        mul_le_mul_of_nonneg_left hy (norm_nonneg a)
      _ = ‖a‖ := mul_one _
  · intro hx
    by_cases ha : a = 0
    · subst a
      have hx0 : x = 0 := by
        apply norm_eq_zero.mp
        exact le_antisymm (by simpa using hx) (norm_nonneg x)
      subst x
      exact ⟨0, by simp [TateCurvesTheta.normIntegralRegion], by simp⟩
    · refine ⟨a⁻¹ * x, ?_, by simp [ha]⟩
      change ‖a⁻¹ * x‖ ≤ 1
      have hna : 0 < ‖a‖ := norm_pos_iff.mpr ha
      simpa [norm_mul, norm_inv, div_eq_mul_inv, mul_comm] using
        (div_le_one hna).2 hx

/-- `productHull a` really is the finite product of scalar images of the
norm-unit ball. -/
theorem productHull_eq_pi_scaled_normIntegralRegion
    {C : Type v} {K : C → Type u} [∀ c, NormedField (K c)]
    (a : ∀ c, K c) :
    productHull a =
      Set.pi Set.univ (fun c =>
        TateCurvesTheta.scaledRegion (a c)
          (TateCurvesTheta.normIntegralRegion (K := K c))) := by
  ext x
  simp only [mem_productHull, Set.mem_pi, Set.mem_univ, forall_true_left]
  exact forall_congr' fun c => by
    rw [scaled_normIntegralRegion_eq_normBall]
    rfl

/-- In a nontrivially normed ultrametric field, the ball used above is
literally the carrier of Mathlib's valuation-integer ring `𝒪[K]`. -/
theorem normIntegralRegion_eq_valuationIntegers
    {K : Type u} [NontriviallyNormedField K] [IsUltrametricDist K] :
    TateCurvesTheta.normIntegralRegion (K := K) = (𝒪[K] : Set K) := by
  ext x
  exact (Valued.integer.mem_iff (K := K)).symm

/-! ## Existence and leastness of the compact product hull -/

/-- Coordinatewise extreme-value theorem on a compact closure.  The nonzero
projection hypothesis is used both to make the compact set nonempty and to
force the chosen radius to be nonzero. -/
theorem exists_least_productHull
    {C : Type v} [Nonempty C]
    {K : C → Type u}
    [∀ c, NontriviallyNormedField (K c)]
    [∀ c, IsUltrametricDist (K c)]
    {U : Set (∀ c, K c)}
    (hcompact : IsCompact (closure U))
    (hnonzero : ∀ c, ∃ x ∈ U, x c ≠ 0) :
    ∃ a : ∀ c, K c,
      (∀ c, a c ≠ 0) ∧
      U ⊆ productHull a ∧
      ∀ b : ∀ c, K c, U ⊆ productHull b →
        productHull a ⊆ productHull b := by
  classical
  have hmax : ∀ c, ∃ y ∈ closure U,
      ∀ x ∈ closure U, ‖x c‖ ≤ ‖y c‖ := by
    intro c
    obtain ⟨x, hxU, -⟩ := hnonzero c
    obtain ⟨y, hy, hymax⟩ := hcompact.exists_isMaxOn
      ⟨x, subset_closure hxU⟩
      ((continuous_norm.comp (continuous_apply c)).continuousOn)
    exact ⟨y, hy, hymax⟩
  choose y hy_mem hy_max using hmax
  let a : ∀ c, K c := fun c => y c c
  refine ⟨a, ?_, ?_, ?_⟩
  · intro c
    obtain ⟨x, hxU, hx0⟩ := hnonzero c
    have hpos : 0 < ‖a c‖ :=
      (norm_pos_iff.mpr hx0).trans_le
        (hy_max c x (subset_closure hxU))
    exact norm_pos_iff.mp hpos
  · intro x hxU c
    exact hy_max c x (subset_closure hxU)
  · intro b hUb x hxa c
    have hclosed : IsClosed {z : (∀ c, K c) | ‖z c‖ ≤ ‖b c‖} :=
      isClosed_le (continuous_norm.comp (continuous_apply c)) continuous_const
    have hUcoord : U ⊆ {z : (∀ c, K c) | ‖z c‖ ≤ ‖b c‖} := by
      intro z hz
      exact hUb hz c
    have hyb : ‖y c c‖ ≤ ‖b c‖ :=
      closure_minimal hUcoord hclosed (hy_mem c)
    have hab : ‖a c‖ ≤ ‖b c‖ := by
      simpa [a] using hyb
    exact (hxa c).trans hab

/-- Two least hulls are the same set.  Thus the set-valued hull is canonical
even though a scalar presenting it need not be. -/
theorem least_productHull_unique
    {C : Type v} {K : C → Type u} [∀ c, NormedField (K c)]
    {U : Set (∀ c, K c)} {a b : ∀ c, K c}
    (haU : U ⊆ productHull a)
    (haLeast : ∀ d, U ⊆ productHull d → productHull a ⊆ productHull d)
    (hbU : U ⊆ productHull b)
    (hbLeast : ∀ d, U ⊆ productHull d → productHull b ⊆ productHull d) :
    productHull a = productHull b :=
  Set.Subset.antisymm (haLeast b hbU) (hbLeast a haU)

/-! ## Genuine normalized Haar measure on the maximal integer ball -/

/-- The norm-unit region is the metric closed unit ball. -/
theorem normIntegralRegion_eq_closedBall
    {K : Type u} [NormedField K] :
    TateCurvesTheta.normIntegralRegion (K := K) =
      Metric.closedBall (0 : K) 1 := by
  ext x
  simp [TateCurvesTheta.normIntegralRegion, Metric.mem_closedBall]

/-- The norm-unit ball is a positive compact in a proper normed field. -/
noncomputable def normIntegralPositiveCompacts
    (K : Type u) [NormedField K] [ProperSpace K] : PositiveCompacts K where
  carrier := TateCurvesTheta.normIntegralRegion (K := K)
  isCompact' := by
    rw [normIntegralRegion_eq_closedBall]
    exact isCompact_closedBall (0 : K) 1
  interior_nonempty' := by
    rw [normIntegralRegion_eq_closedBall]
    have hopen : IsOpen (Metric.ball (0 : K) 1) := Metric.isOpen_ball
    have hsub : Metric.ball (0 : K) 1 ⊆
        interior (Metric.closedBall (0 : K) 1) :=
      hopen.subset_interior_iff.mpr Metric.ball_subset_closedBall
    exact ⟨0, hsub (by simp)⟩

variable {K : Type u} [NormedField K] [ProperSpace K]
variable [MeasurableSpace K] [BorelSpace K]

/-- Additive Haar measure normalized by `μ(𝒪_K) = 1`. -/
noncomputable def normalizedIntegerHaar : Measure K :=
  Measure.addHaarMeasure (normIntegralPositiveCompacts K)

@[simp]
theorem normalizedIntegerHaar_apply_normIntegralRegion :
    normalizedIntegerHaar (K := K)
        (TateCurvesTheta.normIntegralRegion (K := K)) = 1 := by
  change Measure.addHaarMeasure (normIntegralPositiveCompacts K)
      (normIntegralPositiveCompacts K : Set K) = 1
  exact Measure.addHaarMeasure_self

/-- A nonzero scalar image of the maximal integer ball is an actual positive
compact, not an abstract region supplied with desired properties. -/
noncomputable def scaledPositiveCompacts (a : K) (ha : a ≠ 0) :
    PositiveCompacts K :=
  (normIntegralPositiveCompacts K).map
    (fun x : K => a * x)
    (Homeomorph.mulLeft₀ a ha).continuous
    (Homeomorph.mulLeft₀ a ha).isOpenMap

omit [MeasurableSpace K] [BorelSpace K] in
@[simp]
theorem coe_scaledPositiveCompacts (a : K) (ha : a ≠ 0) :
    (scaledPositiveCompacts a ha : Set K) =
      TateCurvesTheta.scaledRegion a
        (TateCurvesTheta.normIntegralRegion (K := K)) :=
  rfl

/-- Every nonzero scaled maximal-integer ball lies in the honest
finite-positive domain of canonical logarithmic volume. -/
noncomputable def scaledFinitePositiveRegion (a : K) (ha : a ≠ 0) :
    FinitePositiveRegion K (normalizedIntegerHaar (K := K)) where
  carrier := scaledPositiveCompacts a ha
  measurable := (scaledPositiveCompacts a ha).isCompact.isClosed.measurableSet
  measure_ne_zero := by
    letI : (normalizedIntegerHaar (K := K)).IsAddHaarMeasure := by
      unfold normalizedIntegerHaar
      infer_instance
    exact (Measure.measure_pos_of_nonempty_interior
      (normalizedIntegerHaar (K := K))
      (scaledPositiveCompacts a ha).interior_nonempty).ne'
  measure_ne_top := by
    letI : (normalizedIntegerHaar (K := K)).IsAddHaarMeasure := by
      unfold normalizedIntegerHaar
      infer_instance
    exact (scaledPositiveCompacts a ha).isCompact.measure_ne_top

@[simp]
theorem coe_scaledFinitePositiveRegion (a : K) (ha : a ≠ 0) :
    (scaledFinitePositiveRegion a ha : Set K) =
      TateCurvesTheta.scaledRegion a
        (TateCurvesTheta.normIntegralRegion (K := K)) :=
  coe_scaledPositiveCompacts a ha

/-! ## The fixed-place rational scale no-go -/

/-- If a weighted product formula has the expected specialization at every
rational prime, then the finite-place and archimedean weights coincide.  No
positivity hypothesis on the weights is needed. -/
theorem rational_prime_specialization_scale_rigidity
    (sInf : ℝ) (sPrime : ℕ → ℝ)
    (hproduct : ∀ p : ℕ, p.Prime →
      sInf * Real.log p + sPrime p * (-Real.log p) = 0) :
    ∀ p : ℕ, p.Prime → sPrime p = sInf := by
  intro p hp
  have hlog : 0 < Real.log (p : ℝ) := by
    apply Real.log_pos
    exact_mod_cast hp.one_lt
  have hpformula := hproduct p hp
  nlinarith

end IUTThreeClosures.MaximalValuationRingHull
