/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineSignedRayCanonicalCaps20260901

/-!
# Incidence cancellation and inverse-period catalogue structure

The mathematical proofs precede this module in
research/ABC_AFFINE_INVERSE_PERIOD_CATALOGUE_NOVELTY_2026_09_02.md.

This file formalizes the optimal incidence-based shifted-cube bridges,
finite class/label double counting, the resulting baseline-free diagonal
comparison, the exact multiplicity/novelty ledger, an abstract support
skeleton cover, and the rational period/capture identity.  It proves no abc
statement and makes no unproved density or catalogue-sparsity assumption.
-/

namespace IUTThreeClosures
namespace AffineInversePeriodCatalogueNovelty20260902

open scoped BigOperators
open AffineCatalogueWeightOverlap20260901
open AffineSignedRayCanonicalCaps20260901

/-! ## Optimal occupancy bridges -/

/-- Replacing the union baseline by exact incidence lowers the optimal
shifted-cube coefficient from seven to six. -/
theorem cube_le_self_add_six_shiftedCube (n : ℕ) :
    n ^ 3 ≤ n + 6 * (n - 1) ^ 3 := by
  by_cases hn0 : n = 0
  · subst n
    norm_num
  by_cases hn1 : n = 1
  · subst n
    norm_num
  let a := n - 1
  have hna : n = a + 1 := by
    dsimp [a]
    omega
  have ha : 0 < a := by
    dsimp [a]
    omega
  obtain ⟨b, hb⟩ : ∃ b, a = b + 1 :=
    Nat.exists_eq_succ_of_ne_zero (ne_of_gt ha)
  rw [hna, hb]
  simp only [Nat.add_sub_cancel]
  have hid :
      (b + 1 + 1) + 6 * (b + 1) ^ 3 =
        (b + 1 + 1) ^ 3 + (b + 1) * b * (5 * (b + 1) + 2) := by
    ring
  rw [hid]
  omega

/-- Occupancy two forces coefficient six. -/
theorem factorFive_incidenceShift_counterexample :
    ¬ (2 ^ 3 ≤ 2 + 5 * (2 - 1) ^ 3) := by
  norm_num

/-- Occupancy two proves optimality of coefficient six over all rational
coefficients, not merely among natural numbers. -/
theorem six_le_incidenceCoefficient_of_occupancyTwo
    {c : ℚ}
    (h : (2 : ℚ) ^ 3 ≤ 2 + c * ((2 : ℚ) - 1) ^ 3) :
    6 ≤ c := by
  norm_num at h ⊢
  linarith

/-- Once occupancy is at least three, the exact optimal coefficient is
three. -/
theorem cube_le_self_add_three_shiftedCube_of_three_le
    {n : ℕ} (hn : 3 ≤ n) :
    n ^ 3 ≤ n + 3 * (n - 1) ^ 3 := by
  let a := n - 1
  have hna : n = a + 1 := by
    dsimp [a]
    omega
  have ha : 2 ≤ a := by
    dsimp [a]
    omega
  obtain ⟨b, hb⟩ : ∃ b, a = b + 2 := by
    use a - 2
    omega
  rw [hna, hb]
  simp only [Nat.add_sub_cancel]
  have hid :
      (b + 2 + 1) + 3 * (b + 2) ^ 3 =
        (b + 2 + 1) ^ 3 + (b + 2) * b * (2 * (b + 2) + 1) := by
    ring
  rw [hid]
  omega

/-- Occupancy three forces coefficient three. -/
theorem factorTwo_incidenceShift_counterexample :
    ¬ (3 ^ 3 ≤ 3 + 2 * (3 - 1) ^ 3) := by
  norm_num

/-- Occupancy three proves optimality of coefficient three over all rational
coefficients on the range of occupancies at least three. -/
theorem three_le_incidenceCoefficient_of_occupancyThree
    {c : ℚ}
    (h : (3 : ℚ) ^ 3 ≤ 3 + c * ((3 : ℚ) - 1) ^ 3) :
    3 ≤ c := by
  norm_num at h ⊢
  linarith

/-- After removing actual singleton labels, coefficient eight controls the
whole repeated-label cube. -/
theorem cube_le_eight_shiftedCube_of_two_le
    {n : ℕ} (hn : 2 ≤ n) :
    n ^ 3 ≤ 8 * (n - 1) ^ 3 := by
  let a := n - 1
  have hna : n = a + 1 := by
    dsimp [a]
    omega
  have ha : 1 ≤ a := by
    dsimp [a]
    omega
  have htwo : a + 1 ≤ 2 * a := by omega
  rw [hna]
  calc
    (a + 1) ^ 3 ≤ (2 * a) ^ 3 := Nat.pow_le_pow_left htwo 3
    _ = 8 * a ^ 3 := by ring
    _ = 8 * ((a + 1) - 1) ^ 3 := by simp

/-- Occupancy two forces coefficient eight when no incidence term remains. -/
theorem factorSeven_noSingleton_counterexample :
    ¬ (2 ^ 3 ≤ 7 * (2 - 1) ^ 3) := by
  norm_num

/-- Occupancy two proves optimality of coefficient eight over all rational
coefficients once the singleton incidence is removed. -/
theorem eight_le_noSingletonCoefficient_of_occupancyTwo
    {c : ℚ}
    (h : (2 : ℚ) ^ 3 ≤ c * ((2 : ℚ) - 1) ^ 3) :
    8 ≤ c := by
  norm_num at h ⊢
  exact h

/-- Weighted global form of the optimal incidence-plus-shift bridge. -/
theorem weightedCubicEnergy_le_incidence_add_sixShifted
    {α : Type*} (s : Finset α) (weight count : α → ℕ) :
    ∑ i ∈ s, weight i * count i ^ 3 ≤
      (∑ i ∈ s, weight i * count i) +
        6 * ∑ i ∈ s, weight i * (count i - 1) ^ 3 := by
  calc
    ∑ i ∈ s, weight i * count i ^ 3 ≤
        ∑ i ∈ s, weight i *
          (count i + 6 * (count i - 1) ^ 3) := by
      exact Finset.sum_le_sum fun i _hi ↦
        Nat.mul_le_mul_left (weight i)
          (cube_le_self_add_six_shiftedCube (count i))
    _ = (∑ i ∈ s, weight i * count i) +
        6 * ∑ i ∈ s, weight i * (count i - 1) ^ 3 := by
      simp_rw [mul_add]
      rw [Finset.sum_add_distrib, Finset.mul_sum]
      congr 1
      apply Finset.sum_congr rfl
      intro i _hi
      ring

/-- Label-specific shifted caps aggregate with the incidence baseline and
the optimal coefficient six. -/
theorem weightedCubicEnergy_le_incidence_add_sixCaps
    {α : Type*} (s : Finset α) (weight count cap : α → ℕ)
    (hcap : ∀ i ∈ s, (count i - 1) ^ 3 ≤ cap i) :
    ∑ i ∈ s, weight i * count i ^ 3 ≤
      (∑ i ∈ s, weight i * count i) +
        6 * ∑ i ∈ s, weight i * cap i := by
  refine (weightedCubicEnergy_le_incidence_add_sixShifted
    s weight count).trans ?_
  apply Nat.add_le_add_left
  apply Nat.mul_le_mul_left
  exact Finset.sum_le_sum fun i hi ↦
    Nat.mul_le_mul_left (weight i) (hcap i hi)

/-! ## Exact class incidence and the baseline-free comparison -/

/-- Finite Tonelli identity for class-tail incidence. -/
theorem weightedSupportIncidence_eq_classIncidence
    {κ ι : Type*}
    (classes : Finset κ) (labels : Finset ι)
    (supports : κ → ι → Prop) [DecidableRel supports]
    (weight : ι → ℕ) (multiplicity : κ → ℕ) (occupancy : ι → ℕ)
    (hoccupancy : ∀ e ∈ labels,
      occupancy e =
        ∑ k ∈ classes with supports k e, multiplicity k) :
    ∑ e ∈ labels, weight e * occupancy e =
      ∑ k ∈ classes, multiplicity k *
        (∑ e ∈ labels with supports k e, weight e) := by
  classical
  calc
    ∑ e ∈ labels, weight e * occupancy e =
        ∑ e ∈ labels, weight e *
          (∑ k ∈ classes with supports k e, multiplicity k) := by
      apply Finset.sum_congr rfl
      intro e he
      rw [hoccupancy e he]
    _ = ∑ k ∈ classes, multiplicity k *
        (∑ e ∈ labels with supports k e, weight e) := by
      simp_rw [Finset.mul_sum, Finset.sum_filter]
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro k hk
      apply Finset.sum_congr rfl
      intro e he
      by_cases h : supports k e <;> simp [h, mul_comm]

/-- Monotone overlap plus the optimal incidence bridge removes the
deduplicated union baseline from the diagonal comparison. -/
theorem classDiagonal_le_classIncidence_add_sixShifted
    {κ ι : Type*}
    (classes : Finset κ) (labels : Finset ι)
    (supports : κ → ι → Prop) [DecidableRel supports]
    (weight : ι → ℕ) (multiplicity : κ → ℕ) (occupancy : ι → ℕ)
    (hoccupancy : ∀ e ∈ labels,
      occupancy e =
        ∑ k ∈ classes with supports k e, multiplicity k) :
    ∑ k ∈ classes, multiplicity k ^ 3 *
        (∑ e ∈ labels with supports k e, weight e) ≤
      (∑ k ∈ classes, multiplicity k *
        (∑ e ∈ labels with supports k e, weight e)) +
        6 * ∑ e ∈ labels, weight e * (occupancy e - 1) ^ 3 := by
  have hlower :
      ∑ k ∈ classes, multiplicity k ^ 3 *
          (∑ e ∈ labels with supports k e, weight e) ≤
        ∑ e ∈ labels, weight e * occupancy e ^ 3 := by
    apply monotone_overlap_cubicEnergy_lower
    intro e he
    exact Nat.le_of_eq (hoccupancy e he).symm
  calc
    ∑ k ∈ classes, multiplicity k ^ 3 *
        (∑ e ∈ labels with supports k e, weight e) ≤
        ∑ e ∈ labels, weight e * occupancy e ^ 3 := hlower
    _ ≤ (∑ e ∈ labels, weight e * occupancy e) +
        6 * ∑ e ∈ labels, weight e * (occupancy e - 1) ^ 3 :=
      weightedCubicEnergy_le_incidence_add_sixShifted
        labels weight occupancy
    _ = (∑ k ∈ classes, multiplicity k *
        (∑ e ∈ labels with supports k e, weight e)) +
        6 * ∑ e ∈ labels, weight e * (occupancy e - 1) ^ 3 := by
      rw [weightedSupportIncidence_eq_classIncidence
        classes labels supports weight multiplicity occupancy hoccupancy]

/-- Pure ledger form of J = A1 + Omega: within-class multiplicity and
cross-class novelty deficit add exactly. -/
theorem shiftedIncidence_eq_multiplicity_add_novelty
    {I W J A0 A1 Ω : ℕ}
    (hincidence : I = A0 + A1)
    (hunion : A0 = W + Ω)
    (hshift : I = W + J) :
    J = A1 + Ω := by
  omega

/-- The same identity in the subtraction notation used in the report. -/
theorem shiftedIncidence_eq_multiplicity_add_novelty_of_sub
    {I W A0 A1 : ℕ}
    (hWA : W ≤ A0)
    (hincidence : I = A0 + A1)
    (hWI : W ≤ I) :
    I - W = A1 + (A0 - W) := by
  omega

/-- Re-export of the large-tail owner coordinate argument: the mass
parameter may be the exact large tail, not the full top product. -/
theorem weightedCoordinateMoment_le_ownerLargeTail
    {α κ : Type*} [DecidableEq κ]
    (labels : Finset α) (classes : Finset κ)
    (owner : α → κ) (weight coordinate : α → ℕ)
    (largeTail cap : κ → ℕ)
    (hmaps : ∀ i ∈ labels, owner i ∈ classes)
    (hcoordinate : ∀ i ∈ labels, coordinate i ≤ cap (owner i))
    (hmass : ∀ k ∈ classes,
      ∑ i ∈ labels.filter (fun i ↦ owner i = k), weight i ≤ largeTail k) :
    ∑ i ∈ labels, weight i * coordinate i ^ 3 ≤
      ∑ k ∈ classes, largeTail k * cap k ^ 3 :=
  weightedCoordinateMoment_le_ownerCatalogue
    labels classes owner weight coordinate largeTail cap
      hmaps hcoordinate hmass

/-! ## Abstract support-skeleton double counting -/

/-- Interchanging edge and label sums records the exact number of skeleton
edges containing each label. -/
theorem pairCatalogue_doubleCount
    {α ε : Type*}
    (labels : Finset α) (edges : Finset ε)
    (contains : ε → α → Prop) [DecidableRel contains]
    (charge : α → ℕ) :
    ∑ e ∈ edges, ∑ i ∈ labels with contains e i, charge i =
      ∑ i ∈ labels,
        (edges.filter (fun e ↦ contains e i)).card * charge i := by
  classical
  simp_rw [Finset.sum_filter]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro i hi
  calc
    (∑ x ∈ edges, if contains x i then charge i else 0) =
        ∑ x ∈ edges.filter (fun e ↦ contains e i), charge i := by
      rw [Finset.sum_filter]
    _ = (edges.filter (fun e ↦ contains e i)).card * charge i :=
      Finset.sum_const_nat fun _ _ ↦ rfl

/-- If every target label is contained in a skeleton edge, its total charge
is bounded by the sum of the edge-catalogue charges. -/
theorem targetCharge_le_pairCatalogue
    {α ε : Type*}
    (labels : Finset α) (edges : Finset ε)
    (target : α → Prop) (contains : ε → α → Prop)
    [DecidablePred target] [DecidableRel contains]
    (charge : α → ℕ)
    (hcover : ∀ i ∈ labels, target i →
      ∃ e ∈ edges, contains e i) :
    ∑ i ∈ labels with target i, charge i ≤
      ∑ e ∈ edges, ∑ i ∈ labels with contains e i, charge i := by
  classical
  rw [pairCatalogue_doubleCount labels edges contains charge]
  rw [Finset.sum_filter]
  apply Finset.sum_le_sum
  intro i hi
  by_cases ht : target i
  · simp only [ht, if_true]
    obtain ⟨e, he, hei⟩ := hcover i hi ht
    have hcard :
        1 ≤ (edges.filter (fun x ↦ contains x i)).card := by
      apply Finset.one_le_card.mpr
      exact ⟨e, Finset.mem_filter.mpr ⟨he, hei⟩⟩
    calc
      charge i = 1 * charge i := by simp
      _ ≤ (edges.filter (fun x ↦ contains x i)).card * charge i :=
        Nat.mul_le_mul_right (charge i) hcard
  · simp [ht]

/-! ## Rational inverse-period algebra -/

/-- Exact period/capture factorization rewritten as an inverse-square
identity. -/
theorem inversePeriodWeight_eq_captureRatio
    {w T C D : ℚ} (hT : T ≠ 0) (hC : C ≠ 0)
    (hfactor : T * C = D) :
    w / T ^ 2 = w * C ^ 2 / D ^ 2 := by
  rw [← hfactor]
  field_simp

/-- Three independent coordinate factors multiply to the full
inverse-period weight. -/
theorem tripleInversePeriod_factorization
    {φU φV φW dU dV dW cU cV cW : ℚ}
    (hdU : dU ≠ 0) (hdV : dV ≠ 0) (hdW : dW ≠ 0)
    (hcU : cU ≠ 0) (hcV : cV ≠ 0) (hcW : cW ≠ 0) :
    (φU * φV * φW) /
        ((dU / cU) * (dV / cV) * (dW / cW)) ^ 2 =
      (φU * cU ^ 2 / dU ^ 2) *
      (φV * cV ^ 2 / dV ^ 2) *
      (φW * cW ^ 2 / dW ^ 2) := by
  field_simp

/-! ## Concrete full-premise arithmetic boundaries -/

/-- Numerical core of the subcritical canonical period-one witness. -/
theorem subcritical_periodOne_numeric_certificate :
    6 < 9 ∧
    22142 ^ 2 < 18769 * 29929 * 1 ∧
    Nat.Coprime 18769 29929 ∧
    Nat.gcd 18769 18769 = 18769 ∧
    Nat.gcd 29929 29929 = 29929 ∧
    Nat.gcd 1 28689 = 1 ∧
    18769 + 9 * 1240 = 29929 ∧
    18769 + 8 * 1240 = 28689 ∧
    Nat.gcd 18769 1240 = 1 ∧
    22142 * 18769 < 18769 * 29929 := by
  norm_num [Nat.Coprime]

set_option maxHeartbeats 1000000 in
/- The two congruences defining the subcritical common-label fibre have
exactly the two claimed solutions in the complete parameter box. -/
theorem subcritical_commonLabel_fibre_classification
    {h k : ℕ}
    (hh : 1 ≤ h ∧ h ≤ 22143)
    (hk : 1 ≤ k ∧ k ≤ 22143)
    (hU : 18769 ∣ 1 + 6 * h)
    (hV : 29929 ∣ 1 + 6 * (h + 9 * k)) :
    (h = 3128 ∧ k = 10183) ∨
      (h = 21897 ∧ k = 11423) := by
  obtain ⟨u, hu⟩ := hU
  have hhclass : h = 3128 ∨ h = 21897 := by omega
  obtain ⟨v, hv⟩ := hV
  rcases hhclass with rfl | rfl
  · left
    constructor
    · rfl
    · omega
  · right
    constructor
    · rfl
    · omega

/-- Exact arm values, admissibility gcds, and factorizations for the two
subcritical fibre points. -/
theorem subcritical_fibrePoints_arithmetic_certificate :
    1 + 6 * 3128 = 18769 ∧
    1 + 6 * (3128 + 9 * 10183) = 568651 ∧
    1 + 6 * (3128 + 8 * 10183) = 507553 ∧
    1 + 6 * 21897 = 131383 ∧
    1 + 6 * (21897 + 9 * 11423) = 748225 ∧
    1 + 6 * (21897 + 8 * 11423) = 679687 ∧
    Nat.gcd 18769 10183 = 1 ∧
    Nat.gcd 131383 11423 = 1 ∧
    Nat.Coprime 18769 568651 ∧
    Nat.Coprime 18769 507553 ∧
    Nat.Coprime 568651 507553 ∧
    Nat.Coprime 131383 748225 ∧
    Nat.Coprime 131383 679687 ∧
    Nat.Coprime 748225 679687 ∧
    18769 = 137 ^ 2 ∧
    29929 = 173 ^ 2 ∧
    568651 = 19 * 173 ^ 2 ∧
    748225 = 5 ^ 2 * 173 ^ 2 := by
  norm_num [Nat.Coprime]

/-- Exact totient weight of the subcritical period-one label. -/
theorem subcritical_periodOne_totientWeight :
    Nat.totient 18769 * Nat.totient 29929 = 554413792 := by
  rw [show 18769 = 137 ^ 2 by norm_num]
  rw [show 29929 = 173 ^ 2 by norm_num]
  rw [Nat.totient_prime_pow (by norm_num) (by norm_num)]
  rw [Nat.totient_prime_pow (by norm_num) (by norm_num)]
  norm_num

/-- Exact density of the subcritical common top, together with the strict
failure of a proposed `0.986` fractional saving. -/
theorem subcritical_weightRatio_certificate :
    (554413792 : ℚ) / 561737401 = 23392 / 23701 ∧
      (986 : ℚ) / 1000 < (554413792 : ℚ) / 561737401 := by
  norm_num

/-- The actual q = 3 example forces the residual Euler correction. -/
theorem reducedPeriodEulerCorrection_counterexample :
    (441 : ℚ) * (1 + 1 / 3 - 1 / 9) = 539 ∧
    ¬ ((539 : ℚ) ≤ 441) ∧
    1323 = 3 * 441 ∧
    ¬ (1323 : ℕ) ∣ 441 := by
  norm_num

#print axioms cube_le_self_add_six_shiftedCube
#print axioms factorFive_incidenceShift_counterexample
#print axioms six_le_incidenceCoefficient_of_occupancyTwo
#print axioms cube_le_self_add_three_shiftedCube_of_three_le
#print axioms factorTwo_incidenceShift_counterexample
#print axioms three_le_incidenceCoefficient_of_occupancyThree
#print axioms cube_le_eight_shiftedCube_of_two_le
#print axioms factorSeven_noSingleton_counterexample
#print axioms eight_le_noSingletonCoefficient_of_occupancyTwo
#print axioms weightedCubicEnergy_le_incidence_add_sixShifted
#print axioms weightedCubicEnergy_le_incidence_add_sixCaps
#print axioms weightedSupportIncidence_eq_classIncidence
#print axioms classDiagonal_le_classIncidence_add_sixShifted
#print axioms shiftedIncidence_eq_multiplicity_add_novelty
#print axioms shiftedIncidence_eq_multiplicity_add_novelty_of_sub
#print axioms weightedCoordinateMoment_le_ownerLargeTail
#print axioms pairCatalogue_doubleCount
#print axioms targetCharge_le_pairCatalogue
#print axioms inversePeriodWeight_eq_captureRatio
#print axioms tripleInversePeriod_factorization
#print axioms subcritical_periodOne_numeric_certificate
#print axioms subcritical_commonLabel_fibre_classification
#print axioms subcritical_fibrePoints_arithmetic_certificate
#print axioms subcritical_periodOne_totientWeight
#print axioms subcritical_weightRatio_certificate
#print axioms reducedPeriodEulerCorrection_counterexample

end AffineInversePeriodCatalogueNovelty20260902
end IUTThreeClosures
