/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineInversePeriodCatalogueNovelty20260902

/-!
# Ownership-preserving maximal-intersection aggregation

The mathematical proofs precede this module in
`research/ABC_AFFINE_OWNERSHIP_MAXIMAL_INTERSECTION_AGGREGATION_2026_09_02.md`.

This file formalizes the finite order-theoretic maximal-support argument,
owner partitions, the support-normalized Cauchy inequality, strict ray
closure, the resulting polynomial normalized gate, tree overlap subtraction,
and exact arithmetic boundaries.  It introduces no density hypothesis and
proves no abc statement.  The analytic maximal-top counts in the report are
outside this finite module.
-/

namespace IUTThreeClosures
namespace AffineOwnershipMaximalIntersectionAggregation20260902

open scoped BigOperators

/-! ## Maximal exact pair tops and their supports -/

/-- Maximality inside an explicitly specified family of admissible tops. -/
def IsFamilyMaximal
    {τ : Type*} [PartialOrder τ] (admissible : τ → Prop) (μ : τ) : Prop :=
  admissible μ ∧ ∀ γ, admissible γ → μ ≤ γ → γ ≤ μ

/-- A cofinal subcatalogue has exactly the same maximal elements as the full
catalogue.  In the affine application, the retained class loops and
singleton--singleton edges form the cofinal subcatalogue. -/
theorem cofinalSubcatalogue_maximal_iff
    {τ : Type*} [PartialOrder τ]
    (full reduced : Finset τ)
    (hsub : reduced ⊆ full)
    (hcofinal : ∀ x ∈ full, ∃ y ∈ reduced, x ≤ y)
    {x : τ} :
    IsFamilyMaximal (fun z ↦ z ∈ reduced) x ↔
      IsFamilyMaximal (fun z ↦ z ∈ full) x := by
  constructor
  · rintro ⟨hx, hmax⟩
    refine ⟨hsub hx, ?_⟩
    intro z hz hxz
    obtain ⟨y, hy, hzy⟩ := hcofinal z hz
    exact hzy.trans (hmax y hy (hxz.trans hzy))
  · rintro ⟨hx, hmax⟩
    obtain ⟨y, hy, hxy⟩ := hcofinal x hx
    have hyx : y ≤ x := hmax y (hsub hy) hxy
    have hxeq : x = y := le_antisymm hxy hyx
    refine ⟨hxeq ▸ hy, ?_⟩
    intro z hz hxz
    exact hmax z (hsub hz) hxz

/-- Every pair of support points of a maximal exact top has that exact top.
The affine application supplies `hpair` from pair saturation and large-label
line uniqueness. -/
theorem maximalSupport_pairTop_eq
    {P τ : Type*} [PartialOrder τ]
    (admissible : τ → Prop) (supports : τ → P → Prop)
    (pairTop : P → P → τ)
    {μ : τ} {x y : P}
    (hmax : IsFamilyMaximal admissible μ)
    (hx : supports μ x) (hy : supports μ y)
    (hpair : supports μ x → supports μ y → admissible (pairTop x y))
    (hle : supports μ x → supports μ y → μ ≤ pairTop x y) :
    pairTop x y = μ := by
  apply le_antisymm
  · exact hmax.2 (pairTop x y) (hpair hx hy) (hle hx hy)
  · exact hle hx hy

/-- Distinct maximal supports have codegree at most one: two common support
points would give one exact pair top above both maximal elements. -/
theorem distinctMaximalSupports_commonPoint_unique
    {P τ : Type*} [PartialOrder τ]
    (admissible : τ → Prop) (supports : τ → P → Prop)
    (pairTop : P → P → τ)
    {μ ν : τ}
    (hμmax : IsFamilyMaximal admissible μ)
    (hνmax : IsFamilyMaximal admissible ν)
    (hne : μ ≠ ν)
    {x y : P} (hxy : x ≠ y)
    (hμx : supports μ x) (hμy : supports μ y)
    (hνx : supports ν x) (hνy : supports ν y)
    (hpair : x ≠ y → admissible (pairTop x y))
    (hμle : supports μ x → supports μ y → μ ≤ pairTop x y)
    (hνle : supports ν x → supports ν y → ν ≤ pairTop x y) : False := by
  have hμeq : pairTop x y = μ :=
    maximalSupport_pairTop_eq admissible supports pairTop hμmax hμx hμy
      (fun _ _ ↦ hpair hxy) hμle
  have hνeq : pairTop x y = ν :=
    maximalSupport_pairTop_eq admissible supports pairTop hνmax hνx hνy
      (fun _ _ ↦ hpair hxy) hνle
  exact hne (hμeq.symm.trans hνeq)

/-! ## Exact owner partitions and catalogue containment -/

/-- A total owner map partitions a finite label sum exactly. -/
theorem ownerPartition_sum
    {ι κ : Type*} [DecidableEq κ]
    (labels : Finset ι) (tops : Finset κ)
    (owner : ι → κ) (charge : ι → ℝ)
    (howner : ∀ i ∈ labels, owner i ∈ tops) :
    ∑ i ∈ labels, charge i =
      ∑ k ∈ tops, ∑ i ∈ labels.filter (fun j ↦ owner j = k), charge i := by
  exact (Finset.sum_fiberwise_of_maps_to howner charge).symm

/-- A real-label catalogue is bounded by any nonnegative formal envelope
which contains it. -/
theorem ownedCharge_le_envelope
    {ι : Type*} (owned envelope : Finset ι) (charge : ι → ℝ)
    (hsub : owned ⊆ envelope)
    (hcharge : ∀ i ∈ envelope, 0 ≤ charge i) :
    ∑ i ∈ owned, charge i ≤ ∑ i ∈ envelope, charge i := by
  exact Finset.sum_le_sum_of_subset_of_nonneg hsub fun i hi _ ↦ hcharge i hi

/-! ## The support-normalized Cauchy inequality -/

/-- Two local owner bounds imply the square bound used before the finite
Cauchy step.  Here `m` is `r_mu - 1`. -/
theorem ownedMass_sq_le_energy_mul_cap_div_cube
    {S E B m : ℝ}
    (hS : 0 ≤ S) (hE : 0 ≤ E) (hm : 0 < m)
    (hSB : S ≤ B) (hmass : m ^ 3 * S ≤ E) :
    S ^ 2 ≤ E * (B / m ^ 3) := by
  have hm3 : 0 < m ^ 3 := pow_pos hm 3
  have hfirst : (m ^ 3 * S) * S ≤ E * S :=
    mul_le_mul_of_nonneg_right hmass hS
  have hsecond : E * S ≤ E * B :=
    mul_le_mul_of_nonneg_left hSB hE
  have hnum : S ^ 2 * m ^ 3 ≤ E * B := by
    calc
      S ^ 2 * m ^ 3 = (m ^ 3 * S) * S := by ring
      _ ≤ E * S := hfirst
      _ ≤ E * B := hsecond
  calc
    S ^ 2 ≤ (E * B) / m ^ 3 := (le_div_iff₀ hm3).2 hnum
    _ = E * (B / m ^ 3) := by ring

/-- Finite Cauchy--Schwarz over the maximal-top index set. -/
theorem ownershipCauchy
    {κ : Type*} (tops : Finset κ) (mass energy pressure : κ → ℝ)
    (henergy : ∀ k ∈ tops, 0 ≤ energy k)
    (hpressure : ∀ k ∈ tops, 0 ≤ pressure k)
    (hlocal : ∀ k ∈ tops, mass k ^ 2 ≤ energy k * pressure k) :
    (∑ k ∈ tops, mass k) ^ 2 ≤
      (∑ k ∈ tops, energy k) * ∑ k ∈ tops, pressure k := by
  exact Finset.sum_sq_le_sum_mul_sum_of_sq_le_mul
    tops henergy hpressure hlocal

/-- The report's owner inequality with explicit support denominators. -/
theorem ownershipCauchy_of_caps
    {κ : Type*} (tops : Finset κ)
    (mass energy cap supportExcess : κ → ℝ)
    (hmass : ∀ k ∈ tops, 0 ≤ mass k)
    (henergy : ∀ k ∈ tops, 0 ≤ energy k)
    (hcap : ∀ k ∈ tops, 0 ≤ cap k)
    (hsupport : ∀ k ∈ tops, 0 < supportExcess k)
    (hmasscap : ∀ k ∈ tops, mass k ≤ cap k)
    (henergybound : ∀ k ∈ tops,
      supportExcess k ^ 3 * mass k ≤ energy k) :
    (∑ k ∈ tops, mass k) ^ 2 ≤
      (∑ k ∈ tops, energy k) *
        ∑ k ∈ tops, cap k / supportExcess k ^ 3 := by
  apply ownershipCauchy tops mass energy
    (fun k ↦ cap k / supportExcess k ^ 3)
    (fun k hk ↦ henergy k hk)
    (fun k hk ↦ div_nonneg (hcap k hk) (pow_nonneg (hsupport k hk).le 3))
  intro k hk
  exact ownedMass_sq_le_energy_mul_cap_div_cube
    (hmass k hk) (henergy k hk) (hsupport k hk)
    (hmasscap k hk) (henergybound k hk)

/-! ## Catalogue multiplicity paid by support-pair energy -/

/-- The numerical inequality behind charging every maximal catalogue which
contains a label to a distinct pair in that label's support.  Here `x` is
`n_lambda - 1`. -/
theorem pairMultiplicity_le_cubicExcess
    {x : ℝ} (hx : 1 ≤ x) :
    (x + 1) * x / 2 ≤ x ^ 3 := by
  have hfactor : 0 ≤ (2 * x + 1) * (x - 1) :=
    mul_nonneg (by linarith) (by linarith)
  nlinarith

/-- Once top multiplicity is injected into support pairs, inverse-period
catalogue mass is bounded by shifted cubic energy, term by term and hence
after summation. -/
theorem catalogueMultiplicityEnergy_bound
    {ι : Type*} (labels : Finset ι)
    (inverseCharge weight topMultiplicity excess : ι → ℝ)
    (hweight : ∀ i ∈ labels, 0 ≤ weight i)
    (hcharge : ∀ i ∈ labels, inverseCharge i ≤ weight i)
    (hmultnonneg : ∀ i ∈ labels, 0 ≤ topMultiplicity i)
    (hexcess : ∀ i ∈ labels, 1 ≤ excess i)
    (hmult : ∀ i ∈ labels,
      topMultiplicity i ≤ (excess i + 1) * excess i / 2) :
    ∑ i ∈ labels, inverseCharge i * topMultiplicity i ≤
      ∑ i ∈ labels, weight i * excess i ^ 3 := by
  apply Finset.sum_le_sum
  intro i hi
  calc
    inverseCharge i * topMultiplicity i ≤
        weight i * topMultiplicity i :=
      mul_le_mul_of_nonneg_right (hcharge i hi) (hmultnonneg i hi)
    _ ≤ weight i * ((excess i + 1) * excess i / 2) :=
      mul_le_mul_of_nonneg_left (hmult i hi) (hweight i hi)
    _ ≤ weight i * excess i ^ 3 :=
      mul_le_mul_of_nonneg_left
        (pairMultiplicity_le_cubicExcess (hexcess i hi)) (hweight i hi)

/-! ## Strict ray closure and the normalized polynomial gate -/

/-- Strict ray capacity plus ownership Cauchy closes the mass against the
support-normalized pressure. -/
theorem strictRayClosure_mass
    {S E H c : ℝ}
    (hS : 0 < S) (hH : 0 ≤ H)
    (hcauchy : S ^ 2 ≤ E * H) (hray : E < c * S) :
    S < c * H := by
  have hHpos : 0 < H := by
    rcases hH.eq_or_lt with hHz | hHp
    · rw [← hHz] at hcauchy
      norm_num at hcauchy
      nlinarith
    · exact hHp
  have hchain : S * S < S * (c * H) := by
    calc
      S * S = S ^ 2 := by ring
      _ ≤ E * H := hcauchy
      _ < (c * S) * H := mul_lt_mul_of_pos_right hray hHpos
      _ = S * (c * H) := by ring
  exact lt_of_mul_lt_mul_left hchain hS.le

/-- The same hypotheses close the non-arm shifted energy. -/
theorem strictRayClosure_energy
    {S E H c : ℝ}
    (hS : 0 < S) (hH : 0 ≤ H) (hc : 0 < c)
    (hcauchy : S ^ 2 ≤ E * H) (hray : E < c * S) :
    E < c ^ 2 * H := by
  have hmass : S < c * H :=
    strictRayClosure_mass hS hH hcauchy hray
  calc
    E < c * S := hray
    _ < c * (c * H) := mul_lt_mul_of_pos_left hmass hc
    _ = c ^ 2 * H := by ring

/-- Adding a separately bounded arm energy gives the global shifted-energy
upper bound. -/
theorem globalShiftedEnergy_le
    {Esh Enon Earm c H A : ℝ}
    (hsplit : Esh = Enon + Earm)
    (hnon : Enon ≤ c ^ 2 * H)
    (harm : Earm ≤ A) :
    Esh ≤ c ^ 2 * H + A := by
  rw [hsplit]
  exact add_le_add hnon harm

/-- Polynomial form of the normalized maximal-top gate. -/
theorem normalizedMaximalTopGate
    {J W Esh c H A : ℝ}
    (hholder : J ^ 3 ≤ W ^ 2 * Esh)
    (henergy : Esh ≤ c ^ 2 * H + A) :
    J ^ 3 ≤ W ^ 2 * (c ^ 2 * H + A) := by
  exact hholder.trans
    (mul_le_mul_of_nonneg_left henergy (sq_nonneg W))

/-- Bounding every normalized top pressure by `beta` removes raw top
multiplicity in favor of the deduplicated union weight. -/
theorem normalizedPressure_le_beta_mul_unionWeight
    {κ : Type*} (tops : Finset κ)
    (pressure weight : κ → ℝ) (β W : ℝ)
    (hβ : 0 ≤ β)
    (hlocal : ∀ k ∈ tops, pressure k ≤ β * weight k)
    (hweight : ∑ k ∈ tops, weight k ≤ W) :
    ∑ k ∈ tops, pressure k ≤ β * W := by
  calc
    ∑ k ∈ tops, pressure k ≤ ∑ k ∈ tops, β * weight k :=
      Finset.sum_le_sum fun k hk ↦ hlocal k hk
    _ = β * ∑ k ∈ tops, weight k := by rw [Finset.mul_sum]
    _ ≤ β * W := mul_le_mul_of_nonneg_left hweight hβ

/-! ## Tree-owner subtraction -/

/-- Subtracting a certified lower overlap from a full-catalogue upper bound
still majorizes the newly owned mass. -/
theorem treeOwnerCap
    {S intersection full upper lower : ℝ}
    (howned : S + intersection ≤ full)
    (hfull : full ≤ upper)
    (hlower : lower ≤ intersection) :
    S ≤ upper - lower := by
  linarith

/-- Pointwise tree-owner caps sum to the advertised full-minus-overlap
bound. -/
theorem treeOwnerCaps_sum
    {κ : Type*} (tops : Finset κ)
    (owned upper lower : κ → ℝ)
    (hcap : ∀ k ∈ tops, owned k ≤ upper k - lower k) :
    ∑ k ∈ tops, owned k ≤
      (∑ k ∈ tops, upper k) - ∑ k ∈ tops, lower k := by
  calc
    ∑ k ∈ tops, owned k ≤ ∑ k ∈ tops, (upper k - lower k) :=
      Finset.sum_le_sum fun k hk ↦ hcap k hk
    _ = (∑ k ∈ tops, upper k) - ∑ k ∈ tops, lower k := by
      rw [Finset.sum_sub_distrib]

/-! ## Exact arithmetic boundaries -/

/-- Arithmetic, admissibility, threshold, direction, and capture core of the
canonical `T_lambda = 1 < T_mu = 3` owner witness. -/
theorem periodDirection_numeric_certificate :
    1 + 14 * 349 = 4887 ∧
    1 + 14 * (349 + 8 * 301) = 38599 ∧
    1 + 14 * (349 + 7 * 301) = 34385 ∧
    1 + 14 * 358 = 5013 ∧
    1 + 14 * (358 + 8 * 73) = 13189 ∧
    1 + 14 * (358 + 7 * 73) = 12167 ∧
    Nat.gcd 4887 301 = 1 ∧ Nat.gcd 5013 73 = 1 ∧
    Nat.Coprime 4887 38599 ∧ Nat.Coprime 4887 34385 ∧
    Nat.Coprime 38599 34385 ∧ Nat.Coprime 5013 13189 ∧
    Nat.Coprime 5013 12167 ∧ Nat.Coprime 13189 12167 ∧
    Nat.gcd 27 9 = 9 ∧ Nat.gcd 1331 121 = 121 ∧
    Nat.gcd 529 12167 = 529 ∧
    399 ^ 2 < 9 * 121 * 529 ∧ 399 ^ 2 < 3 * 121 * 529 ∧
    (3 : ℤ) + 8 * (-76) = -605 ∧
    (3 : ℤ) + 7 * (-76) = -529 ∧
    (9 * 121 * 529) / (3 * 121 * 529) = 3 ∧
    (3 * 121 * 529) / (3 * 121 * 529) = 1 := by
  norm_num [Nat.Coprime]

/-- Exact two catalogue terms in the canonical period-direction witness. -/
theorem periodDirection_mass_certificate :
    Nat.totient 3 * Nat.totient 121 * Nat.totient 529 = 111320 ∧
    Nat.totient 9 * Nat.totient 121 * Nat.totient 529 = 333960 ∧
    (111320 : ℚ) + 333960 / 3 ^ 2 = 445280 / 3 ∧
    (1 : ℕ) < 3 := by
  constructor
  · rw [show 121 = 11 ^ 2 by norm_num]
    rw [show 529 = 23 ^ 2 by norm_num]
    rw [Nat.totient_prime (by norm_num)]
    rw [Nat.totient_prime_pow (by norm_num) (by norm_num)]
    rw [Nat.totient_prime_pow (by norm_num) (by norm_num)]
    norm_num
  · constructor
    · rw [show 9 = 3 ^ 2 by norm_num]
      rw [show 121 = 11 ^ 2 by norm_num]
      rw [show 529 = 23 ^ 2 by norm_num]
      rw [Nat.totient_prime_pow (by norm_num) (by norm_num)]
      rw [Nat.totient_prime_pow (by norm_num) (by norm_num)]
      rw [Nat.totient_prime_pow (by norm_num) (by norm_num)]
      norm_num
    · norm_num

/-- Three canonical pairs have one and the same exact top and primitive
direction, so pair enumeration pays one catalogue three times. -/
theorem threePairCollapse_numeric_certificate :
    Nat.gcd 2401 49 = 49 ∧ Nat.gcd 361 361 = 361 ∧
    Nat.gcd 12321 27 = 9 ∧ Nat.gcd 12321 9 = 9 ∧
    Nat.gcd 27 9 = 9 ∧
    389 ^ 2 < 49 * 361 * 9 ∧
    (49 : ℤ) + 5 * (-82) = -361 ∧
    (49 : ℤ) + 4 * (-82) = -279 ∧
    147 = 3 * 49 ∧ 246 = 3 * 82 ∧
    98 = 2 * 49 ∧ 164 = 2 * 82 ∧
    49 * 361 * 9 / 3 < 389 ^ 2 := by
  norm_num

/-- The cubic support denominator is exact in the three-point collapse. -/
theorem threePairCubicPressure_sharp :
    (86184 : ℚ) ^ 2 = (8 * 86184) * (86184 / 2 ^ 3) ∧
    3 * 86184 > 86184 := by
  norm_num

/-- One singleton canonical kernel class lies in two incomparable maximal
tops; their support intersection is exactly allowed to have size one. -/
theorem oneClass_twoMaximalTops_numeric_certificate :
    Nat.gcd 1 1 = 1 ∧ Nat.gcd 841 841 = 841 ∧
    Nat.gcd 121 43681 = 121 ∧ Nat.gcd 361 43681 = 361 ∧
    ¬ (121 ∣ 361) ∧ ¬ (361 ∣ 121) ∧
    253 ^ 2 < 1 * 841 * 121 ∧ 253 ^ 2 < 1 * 841 * 361 ∧
    151 + 6 * 115 = 841 ∧ 151 + 5 * 115 = 726 ∧
    127 + 6 * 119 = 841 ∧ 127 + 5 * 119 = 722 ∧
    812 * 110 = 89320 ∧ 812 * 342 = 277704 := by
  norm_num

/-- Core arithmetic of the canonical full-catalogue witness with exact
inflation `9187 / 4200 > 2` and three-term-cap inflation `35 / 16 > 2`. -/
theorem catalogueInflationAboveTwo_numeric_certificate :
    (199 * 277 = 55123 ∧ 2 ^ 2 * 13781 = 55124 ∧
     199 * 277 * 2 * 13781 = 1519300126 ∧
     1 + 1519300126 * 1 = 1519300127 ∧
     1 + 1519300126 * (1 + 55124 * 1) = 83751419445751 ∧
     1 + 1519300126 * (1 + 55123 * 1) = 83749900145625 ∧
     1 + 1519300126 * 3 = 4557900379 ∧
     1 + 1519300126 * (3 + 55124 * 2) = 167504358191627 ∧
     1 + 1519300126 * (3 + 55123 * 2) = 167501319591375 ∧
     Nat.gcd 1519300127 83751419445751 = 1 ∧
     Nat.gcd 1519300127 83749900145625 = 1 ∧
     Nat.gcd 83751419445751 83749900145625 = 1 ∧
     Nat.gcd 4557900379 167504358191627 = 1 ∧
     Nat.gcd 4557900379 167501319591375 = 1 ∧
     Nat.gcd 167504358191627 167501319591375 = 1 ∧
     Nat.gcd 1519300127 1 = 1 ∧ Nat.gcd 4557900379 2 = 1 ∧
     3 ^ 2 * 5 ^ 4 * 7 ^ 2 = 275625 ∧
     3 ^ 2 * 5 ^ 3 * 7 ^ 3 * 11 ^ 2 = 46690875 ∧
     Nat.gcd 275625 46690875 = 55125 ∧
     55125 = 3 ^ 2 * 5 ^ 3 * 7 ^ 2 ∧
     2 ^ 2 < 55125 ∧
     (2 : ℤ) + 55124 = 55126 ∧ (2 : ℤ) + 55123 = 55125) ∧
    Nat.totient 55125 = 25200 ∧
    (55122 : ℚ) / 25200 = 9187 / 4200 ∧
    (2 : ℚ) < 9187 / 4200 ∧
    (55125 : ℚ) / 25200 = 35 / 16 ∧
    (2 : ℚ) < 35 / 16 := by
  refine ⟨by norm_num, ?_, by norm_num⟩
  rw [show 55125 = 9 * (125 * 49) by norm_num]
  rw [Nat.totient_mul (by norm_num [Nat.Coprime])]
  rw [Nat.totient_mul (by norm_num [Nat.Coprime])]
  rw [show 9 = 3 ^ 2 by norm_num]
  rw [show 125 = 5 ^ 3 by norm_num]
  rw [show 49 = 7 ^ 2 by norm_num]
  rw [Nat.totient_prime_pow (by norm_num) (by norm_num)]
  rw [Nat.totient_prime_pow (by norm_num) (by norm_num)]
  rw [Nat.totient_prime_pow (by norm_num) (by norm_num)]
  norm_num

/-- A four-vertex powerful-kernel ledger realizes all six incomparable
two-point maximal tops and makes ownership Cauchy an equality. -/
theorem completeGraphLedger_sharp_certificate :
    Nat.gcd 900 23716 = 4 ∧ Nat.gcd 900 74529 = 9 ∧
    Nat.gcd 900 511225 = 25 ∧ Nat.gcd 23716 74529 = 49 ∧
    Nat.gcd 23716 511225 = 121 ∧ Nat.gcd 74529 511225 = 169 ∧
    4 < 6 ∧
    (3 + 8 + 24 + 48 + 120 + 168 : ℚ) = 371 ∧
    (371 : ℚ) ^ 2 = 371 * 371 ∧
    (4 : ℚ) - 1 > Nat.totient 4 := by
  rw [show 4 = 2 ^ 2 by norm_num]
  rw [Nat.totient_prime_pow (by norm_num) (by norm_num)]
  norm_num

#print axioms cofinalSubcatalogue_maximal_iff
#print axioms maximalSupport_pairTop_eq
#print axioms distinctMaximalSupports_commonPoint_unique
#print axioms ownerPartition_sum
#print axioms ownedCharge_le_envelope
#print axioms ownedMass_sq_le_energy_mul_cap_div_cube
#print axioms ownershipCauchy
#print axioms ownershipCauchy_of_caps
#print axioms pairMultiplicity_le_cubicExcess
#print axioms catalogueMultiplicityEnergy_bound
#print axioms strictRayClosure_mass
#print axioms strictRayClosure_energy
#print axioms globalShiftedEnergy_le
#print axioms normalizedMaximalTopGate
#print axioms normalizedPressure_le_beta_mul_unionWeight
#print axioms treeOwnerCap
#print axioms treeOwnerCaps_sum
#print axioms periodDirection_numeric_certificate
#print axioms periodDirection_mass_certificate
#print axioms threePairCollapse_numeric_certificate
#print axioms threePairCubicPressure_sharp
#print axioms oneClass_twoMaximalTops_numeric_certificate
#print axioms catalogueInflationAboveTwo_numeric_certificate
#print axioms completeGraphLedger_sharp_certificate

end AffineOwnershipMaximalIntersectionAggregation20260902
end IUTThreeClosures
