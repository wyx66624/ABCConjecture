/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineCollinearPeriodEnergy20260901

/-!
# Actual catalogue weight and monotone overlap in the affine route

The mathematical proofs precede this module in
`research/ABC_AFFINE_CATALOGUE_WEIGHT_OVERLAP_2026_09_01.md`.

This file proves the exact Euler-totient weight of the downward divisor
catalogue, a finite lower bound for its determinant-large tail, the monotone
cubic aggregation of overlapping canonical-kernel catalogues, and a weighted
cubic incidence inequality.  It also checks the precise powerful,
pairwise-coprime counterexample to the false shortcut that subtracts only the
threshold.  It assumes no exceptional-point lower bound and proves no abc
statement.
-/

namespace IUTThreeClosures
namespace AffineCatalogueWeightOverlap20260901

open scoped BigOperators

/-! ## Exact actual divisor-catalogue weights -/

/-- Euler-totient weight of one three-coordinate divisor label. -/
def totientTripleWeight (eU eV eW : ℕ) : ℕ :=
  Nat.totient eU * Nat.totient eV * Nat.totient eW

/-- Total weight of the complete downward divisor catalogue. -/
def divisorTripleCatalogueWeight (dU dV dW : ℕ) : ℕ :=
  ∑ eU ∈ dU.divisors,
    ∑ eV ∈ dV.divisors,
      ∑ eW ∈ dW.divisors, totientTripleWeight eU eV eW

/-- Weight of divisor labels whose component product is at most `T`. -/
def smallDivisorTripleWeight (dU dV dW T : ℕ) : ℕ :=
  ∑ eU ∈ dU.divisors,
    ∑ eV ∈ dV.divisors,
      ∑ eW ∈ dW.divisors,
        if eU * eV * eW ≤ T then totientTripleWeight eU eV eW else 0

/-- Weight of divisor labels whose component product is larger than `T`. -/
def largeDivisorTripleWeight (dU dV dW T : ℕ) : ℕ :=
  ∑ eU ∈ dU.divisors,
    ∑ eV ∈ dV.divisors,
      ∑ eW ∈ dW.divisors,
        if T < eU * eV * eW then totientTripleWeight eU eV eW else 0

/-- Number of triples in the complete downward divisor catalogue. -/
def divisorTripleCatalogueCard (dU dV dW : ℕ) : ℕ :=
  dU.divisors.card * dV.divisors.card * dW.divisors.card

/-- The actual three-coordinate catalogue has total totient weight exactly
the product of its three top components. -/
theorem divisorTripleCatalogueWeight_eq_product (dU dV dW : ℕ) :
    divisorTripleCatalogueWeight dU dV dW = dU * dV * dW := by
  simp only [divisorTripleCatalogueWeight, totientTripleWeight]
  simp_rw [← Finset.mul_sum]
  rw [Nat.sum_totient]
  simp_rw [← Finset.sum_mul]
  have hUV :
      (∑ eU ∈ dU.divisors,
        ∑ eV ∈ dV.divisors,
          Nat.totient eU * Nat.totient eV) = dU * dV := by
    simp_rw [← Finset.mul_sum]
    rw [Nat.sum_totient]
    simp_rw [← Finset.sum_mul]
    rw [Nat.sum_totient]
  rw [hUV]

/-- The small- and large-product pieces partition the full catalogue. -/
theorem small_add_large_eq_catalogue (dU dV dW T : ℕ) :
    smallDivisorTripleWeight dU dV dW T +
      largeDivisorTripleWeight dU dV dW T =
        divisorTripleCatalogueWeight dU dV dW := by
  simp only [smallDivisorTripleWeight, largeDivisorTripleWeight,
    divisorTripleCatalogueWeight]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro eU heU
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro eV heV
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro eW heW
  by_cases h : eU * eV * eW ≤ T
  · simp [h, Nat.not_lt_of_ge h]
  · have hlt : T < eU * eV * eW := Nat.lt_of_not_ge h
    simp [h, hlt]

/-- Every small-product label has weight at most the threshold; summing over
the actual number of divisor triples gives the finite discarded-weight
bound. -/
theorem smallDivisorTripleWeight_le
    (dU dV dW T : ℕ) :
    smallDivisorTripleWeight dU dV dW T ≤
      T * divisorTripleCatalogueCard dU dV dW := by
  simp only [smallDivisorTripleWeight, divisorTripleCatalogueCard]
  calc
    (∑ eU ∈ dU.divisors,
      ∑ eV ∈ dV.divisors,
        ∑ eW ∈ dW.divisors,
          if eU * eV * eW ≤ T then
            totientTripleWeight eU eV eW else 0) ≤
        ∑ _eU ∈ dU.divisors,
          ∑ _eV ∈ dV.divisors,
            ∑ _eW ∈ dW.divisors, T := by
      apply Finset.sum_le_sum
      intro eU heU
      apply Finset.sum_le_sum
      intro eV heV
      apply Finset.sum_le_sum
      intro eW heW
      split_ifs with h
      · have hweight : totientTripleWeight eU eV eW ≤
            eU * eV * eW := by
          exact Nat.mul_le_mul
            (Nat.mul_le_mul (Nat.totient_le eU) (Nat.totient_le eV))
            (Nat.totient_le eW)
        exact hweight.trans h
      · exact Nat.zero_le T
    _ = T *
        (dU.divisors.card * dV.divisors.card * dW.divisors.card) := by
      simp [mul_assoc, mul_comm, mul_left_comm]

/-- Exact finite tail inequality: the top product is paid for by the large
catalogue plus at most `T` for every possible divisor triple. -/
theorem product_le_largeWeight_add_threshold_mul_card
    (dU dV dW T : ℕ) :
    dU * dV * dW ≤
      largeDivisorTripleWeight dU dV dW T +
        T * divisorTripleCatalogueCard dU dV dW := by
  have hpartition := small_add_large_eq_catalogue dU dV dW T
  have hsmall := smallDivisorTripleWeight_le dU dV dW T
  rw [divisorTripleCatalogueWeight_eq_product] at hpartition
  omega

/-- Subtraction-free margin form of the large-tail estimate. -/
theorem margin_le_largeDivisorTripleWeight
    {dU dV dW T Q : ℕ}
    (hmargin :
      T * divisorTripleCatalogueCard dU dV dW + Q ≤ dU * dV * dW) :
    Q ≤ largeDivisorTripleWeight dU dV dW T := by
  have htail :=
    product_le_largeWeight_add_threshold_mul_card dU dV dW T
  omega

/-- The top divisor label itself belongs to the large catalogue whenever its
product exceeds the threshold.  This gives a nonzero baseline even when the
coarse divisor-count margin is not positive. -/
theorem topLabelWeight_le_largeDivisorTripleWeight
    {dU dV dW T : ℕ}
    (hU : 0 < dU) (hV : 0 < dV) (hW : 0 < dW)
    (hlarge : T < dU * dV * dW) :
    totientTripleWeight dU dV dW ≤
      largeDivisorTripleWeight dU dV dW T := by
  have hUd : dU ∈ dU.divisors :=
    Nat.mem_divisors.mpr ⟨dvd_rfl, Nat.ne_of_gt hU⟩
  have hVd : dV ∈ dV.divisors :=
    Nat.mem_divisors.mpr ⟨dvd_rfl, Nat.ne_of_gt hV⟩
  have hWd : dW ∈ dW.divisors :=
    Nat.mem_divisors.mpr ⟨dvd_rfl, Nat.ne_of_gt hW⟩
  simp only [largeDivisorTripleWeight]
  calc
    totientTripleWeight dU dV dW =
        if T < dU * dV * dW then totientTripleWeight dU dV dW else 0 := by
      simp [hlarge]
    _ ≤ ∑ eW ∈ dW.divisors,
        if T < dU * dV * eW then totientTripleWeight dU dV eW else 0 := by
      exact Finset.single_le_sum
        (s := dW.divisors)
        (f := fun eW ↦
          if T < dU * dV * eW then totientTripleWeight dU dV eW else 0)
        (fun _ _ ↦ Nat.zero_le _) hWd
    _ ≤ ∑ eV ∈ dV.divisors,
        ∑ eW ∈ dW.divisors,
          if T < dU * eV * eW then totientTripleWeight dU eV eW else 0 := by
      exact Finset.single_le_sum
        (s := dV.divisors)
        (f := fun eV ↦
          ∑ eW ∈ dW.divisors,
            if T < dU * eV * eW then totientTripleWeight dU eV eW else 0)
        (fun _ _ ↦ Nat.zero_le _) hVd
    _ ≤ ∑ eU ∈ dU.divisors,
        ∑ eV ∈ dV.divisors,
          ∑ eW ∈ dW.divisors,
            if T < eU * eV * eW then totientTripleWeight eU eV eW else 0 := by
      exact Finset.single_le_sum
        (s := dU.divisors)
        (f := fun eU ↦
          ∑ eV ∈ dV.divisors,
            ∑ eW ∈ dW.divisors,
              if T < eU * eV * eW then totientTripleWeight eU eV eW else 0)
        (fun _ _ ↦ Nat.zero_le _) hUd

#print axioms divisorTripleCatalogueWeight_eq_product
#print axioms small_add_large_eq_catalogue
#print axioms smallDivisorTripleWeight_le
#print axioms product_le_largeWeight_add_threshold_mul_card
#print axioms margin_le_largeDivisorTripleWeight
#print axioms topLabelWeight_le_largeDivisorTripleWeight

/-! ## Cubic aggregation of overlapping catalogues -/

/-- Cubing is superadditive on a finite family of natural numbers. -/
theorem sum_cube_le_cube_sum
    {α : Type*} (s : Finset α) (a : α → ℕ) :
    ∑ i ∈ s, a i ^ 3 ≤ (∑ i ∈ s, a i) ^ 3 := by
  let A := ∑ i ∈ s, a i
  have hai : ∀ i ∈ s, a i ≤ A := by
    intro i hi
    exact Finset.single_le_sum (fun _ _ ↦ Nat.zero_le _) hi
  calc
    ∑ i ∈ s, a i ^ 3 ≤ ∑ i ∈ s, a i * A ^ 2 := by
      apply Finset.sum_le_sum
      intro i hi
      have hsquare : a i ^ 2 ≤ A ^ 2 := Nat.pow_le_pow_left (hai i hi) 2
      calc
        a i ^ 3 = a i * a i ^ 2 := by ring
        _ ≤ a i * A ^ 2 := Nat.mul_le_mul_left (a i) hsquare
    _ = A ^ 3 := by
      rw [← Finset.sum_mul]
      simp only [A]
      ring

/-- Monotone-overlap theorem.  If the occupancy of every label dominates the
sum of the sizes of all kernel classes supporting that label, overlapping
catalogues can only increase the weighted cubic energy. -/
theorem monotone_overlap_cubicEnergy_lower
    {κ ι : Type*}
    (kernels : Finset κ) (labels : Finset ι)
    (supports : κ → ι → Prop) (weight : ι → ℕ)
    [DecidableRel supports]
    (multiplicity : κ → ℕ) (occupancy : ι → ℕ)
    (hoccupancy : ∀ e ∈ labels,
      ∑ k ∈ kernels with supports k e, multiplicity k ≤ occupancy e) :
    ∑ k ∈ kernels,
        multiplicity k ^ 3 *
          (∑ e ∈ labels with supports k e, weight e) ≤
      ∑ e ∈ labels, weight e * occupancy e ^ 3 := by
  classical
  calc
    ∑ k ∈ kernels,
        multiplicity k ^ 3 *
          (∑ e ∈ labels with supports k e, weight e) =
      ∑ e ∈ labels,
        weight e *
          (∑ k ∈ kernels with supports k e, multiplicity k ^ 3) := by
      simp_rw [Finset.mul_sum, Finset.sum_filter]
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro e he
      apply Finset.sum_congr rfl
      intro k hk
      by_cases h : supports k e <;> simp [h, mul_comm]
    _ ≤ ∑ e ∈ labels, weight e * occupancy e ^ 3 := by
      apply Finset.sum_le_sum
      intro e he
      apply Nat.mul_le_mul_left
      calc
        ∑ k ∈ kernels with supports k e, multiplicity k ^ 3 ≤
            (∑ k ∈ kernels with supports k e, multiplicity k) ^ 3 :=
          sum_cube_le_cube_sum _ _
        _ ≤ occupancy e ^ 3 :=
          Nat.pow_le_pow_left (hoccupancy e he) 3

#print axioms sum_cube_le_cube_sum
#print axioms monotone_overlap_cubicEnergy_lower

/-! ## Weighted cubic incidence inequality -/

/-- Weighted Hölder in polynomial form.  This fallback uses only total
weighted incidence and total catalogue weight. -/
theorem weightedIncidence_cube_le_weight_sq_mul_cubicEnergy
    {α : Type*} (s : Finset α) (weight count : α → ℝ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hcount : ∀ i ∈ s, 0 ≤ count i) :
    (∑ i ∈ s, weight i * count i) ^ 3 ≤
      (∑ i ∈ s, weight i) ^ 2 *
        ∑ i ∈ s, weight i * count i ^ 3 := by
  let I : ℝ := ∑ i ∈ s, weight i * count i
  let W : ℝ := ∑ i ∈ s, weight i
  let Q : ℝ := ∑ i ∈ s, weight i * count i ^ 2
  let E : ℝ := ∑ i ∈ s, weight i * count i ^ 3
  have hI : 0 ≤ I := by
    dsimp [I]
    exact Finset.sum_nonneg fun i hi ↦
      mul_nonneg (hweight i hi) (hcount i hi)
  have hW : 0 ≤ W := by
    dsimp [W]
    exact Finset.sum_nonneg hweight
  have hQ : 0 ≤ Q := by
    dsimp [Q]
    exact Finset.sum_nonneg fun i hi ↦
      mul_nonneg (hweight i hi) (sq_nonneg (count i))
  have hE : 0 ≤ E := by
    dsimp [E]
    exact Finset.sum_nonneg fun i hi ↦
      mul_nonneg (hweight i hi)
        (mul_nonneg (sq_nonneg (count i)) (hcount i hi))
  have hIQ : I ^ 2 ≤ W * Q := by
    dsimp [I, W, Q]
    exact Finset.sum_sq_le_sum_mul_sum_of_sq_le_mul s
      hweight
      (fun i hi ↦ mul_nonneg (hweight i hi) (sq_nonneg (count i)))
      (fun i hi ↦ by ring_nf; exact le_rfl)
  have hQE : Q ^ 2 ≤ I * E := by
    dsimp [Q, I, E]
    exact Finset.sum_sq_le_sum_mul_sum_of_sq_le_mul s
      (fun i hi ↦ mul_nonneg (hweight i hi) (hcount i hi))
      (fun i hi ↦ mul_nonneg (hweight i hi)
        (mul_nonneg (sq_nonneg (count i)) (hcount i hi)))
      (fun i hi ↦ by ring_nf; exact le_rfl)
  change I ^ 3 ≤ W ^ 2 * E
  by_cases hIz : I = 0
  · rw [hIz]
    norm_num
    exact mul_nonneg (sq_nonneg W) hE
  · have hIpos : 0 < I := lt_of_le_of_ne hI (Ne.symm hIz)
    have hIQsq : I ^ 4 ≤ W ^ 2 * Q ^ 2 := by
      have h := mul_self_le_mul_self (sq_nonneg I) hIQ
      nlinarith
    have hQEw : W ^ 2 * Q ^ 2 ≤ W ^ 2 * (I * E) :=
      mul_le_mul_of_nonneg_left hQE (sq_nonneg W)
    have hchain : I ^ 4 ≤ W ^ 2 * (I * E) := hIQsq.trans hQEw
    have hcancel : I * I ^ 3 ≤ I * (W ^ 2 * E) := by
      nlinarith
    have hfinal : I ^ 3 ≤ W ^ 2 * E :=
      le_of_mul_le_mul_left hcancel hIpos
    exact hfinal

#print axioms weightedIncidence_cube_le_weight_sq_mul_cubicEnergy

/-- Shifted weighted Hölder.  This is the form that matches the exact affine
ray estimate, whose natural variable is `occupancy - 1`. -/
theorem weightedShiftedIncidence_cube_le
    {α : Type*} (s : Finset α) (weight : α → ℝ) (count : α → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    (∑ i ∈ s, weight i * ((count i - 1 : ℕ) : ℝ)) ^ 3 ≤
      (∑ i ∈ s, weight i) ^ 2 *
        ∑ i ∈ s, weight i * ((count i - 1 : ℕ) : ℝ) ^ 3 := by
  exact weightedIncidence_cube_le_weight_sq_mul_cubicEnergy s weight
    (fun i ↦ ((count i - 1 : ℕ) : ℝ)) hweight
    (fun _ _ ↦ Nat.cast_nonneg _)

/-- If every label in the catalogue occurs, weighted incidence splits exactly
as catalogue weight plus shifted incidence. -/
theorem weightedIncidence_eq_catalogue_add_shifted
    {α : Type*} (s : Finset α) (weight : α → ℝ) (count : α → ℕ)
    (hcount : ∀ i ∈ s, 1 ≤ count i) :
    (∑ i ∈ s, weight i * (count i : ℝ)) =
      (∑ i ∈ s, weight i) +
        ∑ i ∈ s, weight i * ((count i - 1 : ℕ) : ℝ) := by
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  have hci : 1 ≤ count i := hcount i hi
  have hdecomp : count i = 1 + (count i - 1) := by
    omega
  have hcast : (count i : ℝ) = 1 + ((count i - 1 : ℕ) : ℝ) := by
    exact_mod_cast hdecomp
  rw [hcast]
  ring

/-- Polynomial overlap lower bound.  Here `I-W` is exactly the weighted
incidence contributed beyond the first occurrence of every label. -/
theorem weightedIncidence_sub_catalogue_cube_le_shiftedEnergy
    {α : Type*} (s : Finset α) (weight : α → ℝ) (count : α → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hcount : ∀ i ∈ s, 1 ≤ count i) :
    ((∑ i ∈ s, weight i * (count i : ℝ)) -
        ∑ i ∈ s, weight i) ^ 3 ≤
      (∑ i ∈ s, weight i) ^ 2 *
        ∑ i ∈ s, weight i * ((count i - 1 : ℕ) : ℝ) ^ 3 := by
  have hsplit := weightedIncidence_eq_catalogue_add_shifted
    s weight count hcount
  have hsub :
      (∑ i ∈ s, weight i * (count i : ℝ)) -
          ∑ i ∈ s, weight i =
        ∑ i ∈ s, weight i * ((count i - 1 : ℕ) : ℝ) := by
    linarith
  rw [hsub]
  exact weightedShiftedIncidence_cube_le s weight count hweight

/-- Aggregated shifted-cap consequence.  Labels may lie on different rays;
only their individual shifted-cube caps enter, so no raw number-of-rays
factor is introduced. -/
theorem weightedShiftedIncidence_cube_le_of_caps
    {α : Type*} (s : Finset α) (weight : α → ℝ)
    (count : α → ℕ) (cap : α → ℝ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hcap : ∀ i ∈ s, ((count i - 1 : ℕ) : ℝ) ^ 3 ≤ cap i) :
    (∑ i ∈ s, weight i * ((count i - 1 : ℕ) : ℝ)) ^ 3 ≤
      (∑ i ∈ s, weight i) ^ 2 *
        ∑ i ∈ s, weight i * cap i := by
  calc
    (∑ i ∈ s, weight i * ((count i - 1 : ℕ) : ℝ)) ^ 3 ≤
        (∑ i ∈ s, weight i) ^ 2 *
          ∑ i ∈ s, weight i * ((count i - 1 : ℕ) : ℝ) ^ 3 :=
      weightedShiftedIncidence_cube_le s weight count hweight
    _ ≤ (∑ i ∈ s, weight i) ^ 2 *
          ∑ i ∈ s, weight i * cap i := by
      apply mul_le_mul_of_nonneg_left
      · apply Finset.sum_le_sum
        intro i hi
        exact mul_le_mul_of_nonneg_left (hcap i hi) (hweight i hi)
      · exact sq_nonneg _

#print axioms weightedShiftedIncidence_cube_le
#print axioms weightedIncidence_eq_catalogue_add_shifted
#print axioms weightedIncidence_sub_catalogue_cube_le_shiftedEnergy
#print axioms weightedShiftedIncidence_cube_le_of_caps

/-! ## Exact counterexample to a false tail strengthening -/

/-- The powerful, pairwise-coprime catalogue `(9,25,1)` at threshold five
has total weight `225` but small weight seven and large weight `218`. -/
theorem powerful_pairwiseCatalogue_tail_counterexample :
    Nat.Coprime 9 25 ∧ Nat.Coprime 9 1 ∧ Nat.Coprime 25 1 ∧
      5 < 9 * 25 * 1 ∧
      smallDivisorTripleWeight 9 25 1 5 = 7 ∧
      largeDivisorTripleWeight 9 25 1 5 = 218 ∧
      largeDivisorTripleWeight 9 25 1 5 < 9 * 25 * 1 - 5 := by
  decide

#print axioms powerful_pairwiseCatalogue_tail_counterexample

end AffineCatalogueWeightOverlap20260901
end IUTThreeClosures
