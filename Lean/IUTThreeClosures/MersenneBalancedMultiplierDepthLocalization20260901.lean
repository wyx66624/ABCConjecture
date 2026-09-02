/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneMultiplierIndexTwoArm20260901
import IUTThreeClosures.MersenneSuperWieferichDepth20260901

/-!
# Balanced multiplier and depth localization for Mersenne order blocks

The mathematical proofs precede this file in
`research/ABC_MERSENNE_BALANCED_MULTIPLIER_DEPTH_LOCALIZATION_2026_09_01.md`.

The new finite core is a multiplier-energy estimate.  Distinct positive
integral labels below `H` have total label at most `H * (H - 1) / 2` and
cardinality at most `H - 1`.  Consequently, any nonnegative weight admitting
a pointwise affine envelope in the multiplier has an exact triangular-energy
bound.  The paper combines this fact with Yamada's published explicit
`p`-adic logarithm estimate.  That external analytic theorem, and the passage
to moving real logarithmic thresholds and little-oh estimates, remain paper
mathematics rather than new Lean axioms.

The final section composes two controlled arms before applying the existing
two-arm alternative.  It also checks the actual `3511` certificate: the
base-two Wieferich prime has exact order `1755` and multiplier two, so any
universal pointwise lower bound of three is false.
-/

namespace IUTThreeClosures
namespace MersenneBalancedMultiplierDepthLocalization20260901

open scoped BigOperators
open MersenneOrderBlockDecomposition20260901
open MersenneMultiplierIndexTwoArm20260901
open MersenneSuperWieferichDepth20260901

/-! ## Triangular multiplier energy -/

/-- Injective natural labels below `H` have at most the full triangular
energy of `Finset.range H`. -/
theorem sum_injective_labels_lt_le_triangular
    (s : Finset ℕ) (label : ℕ → ℕ) (H : ℕ)
    (hinj : Set.InjOn label (s : Set ℕ))
    (hlt : ∀ x ∈ s, label x < H) :
    (∑ x ∈ s, label x) ≤ H * (H - 1) / 2 := by
  have hsubset : s.image label ⊆ Finset.range H := by
    intro y hy
    rcases Finset.mem_image.mp hy with ⟨x, hx, rfl⟩
    exact Finset.mem_range.mpr (hlt x hx)
  have hsum :
      (∑ y ∈ s.image label, y) ≤ ∑ y ∈ Finset.range H, y :=
    Finset.sum_le_sum_of_subset hsubset
  rw [Finset.sum_image hinj] at hsum
  simpa [Finset.sum_range_id] using hsum

/-- Positivity removes the zero label, sharpening the capacity from `H` to
`H - 1`. -/
theorem card_le_pred_of_positive_injective_labels_lt
    (s : Finset ℕ) (label : ℕ → ℕ) (H : ℕ)
    (hinj : Set.InjOn label (s : Set ℕ))
    (hpos : ∀ x ∈ s, 0 < label x)
    (hlt : ∀ x ∈ s, label x < H) :
    s.card ≤ H - 1 := by
  apply card_le_of_injective_multiplier_lt
      s (fun x => label x - 1) (H - 1)
  · intro x hx y hy hxy
    apply hinj hx hy
    have hxpos := hpos x hx
    have hypos := hpos y hy
    exact Nat.pred_inj hxpos hypos (by
      simpa [Nat.pred_eq_sub_one] using hxy)
  · intro x hx
    have hxpos := hpos x hx
    have hxlt := hlt x hx
    omega

/-- The triangular multiplier energy and the positive-label capacity combine
with a pointwise affine weight envelope.  In the paper `slope` is the
Yamada coefficient times `d / log d`, while `error` is a logarithmic cap. -/
theorem weighted_mass_le_triangular_envelope
    (s : Finset ℕ) (label : ℕ → ℕ) (weight : ℕ → ℝ)
    (H : ℕ) {slope error : ℝ}
    (hinj : Set.InjOn label (s : Set ℕ))
    (hpos : ∀ x ∈ s, 0 < label x)
    (hlt : ∀ x ∈ s, label x < H)
    (hslope : 0 ≤ slope) (herror : 0 ≤ error)
    (henv : ∀ x ∈ s,
      weight x ≤ slope * (label x : ℝ) + error) :
    (∑ x ∈ s, weight x) ≤
      slope * (H * (H - 1) / 2 : ℕ) +
        error * (H - 1 : ℕ) := by
  have hpoint :
      (∑ x ∈ s, weight x) ≤
        ∑ x ∈ s, (slope * (label x : ℝ) + error) := by
    exact Finset.sum_le_sum fun x hx => henv x hx
  have hlabelNat :
      (∑ x ∈ s, label x) ≤ H * (H - 1) / 2 :=
    sum_injective_labels_lt_le_triangular s label H hinj hlt
  have hlabel :
      (∑ x ∈ s, (label x : ℝ)) ≤
        (H * (H - 1) / 2 : ℕ) := by
    exact_mod_cast hlabelNat
  have hcardNat : s.card ≤ H - 1 :=
    card_le_pred_of_positive_injective_labels_lt
      s label H hinj hpos hlt
  have hcard : (s.card : ℝ) ≤ (H - 1 : ℕ) := by
    exact_mod_cast hcardNat
  calc
    (∑ x ∈ s, weight x) ≤
        ∑ x ∈ s, (slope * (label x : ℝ) + error) := hpoint
    _ = slope * (∑ x ∈ s, (label x : ℝ)) +
          error * s.card := by
      rw [Finset.sum_add_distrib]
      simp only [← Finset.mul_sum, Finset.sum_const, nsmul_eq_mul]
      ring
    _ ≤ slope * (H * (H - 1) / 2 : ℕ) +
          error * (H - 1 : ℕ) := by
      gcongr

/-! ## The actual exact-order fibre -/

/-- At an actual positive exact-order prime, the `p`-adic depth at the
Fermat exponent `p - 1` equals the canonical depth at the exact order.  This
is the exact LTE transport used before applying Yamada's paper theorem. -/
theorem factorization_fermat_eq_exactOrder
    {d p : ℕ} (hd : 0 < d) (hpMem : p ∈ exactOrderPrimeFiber d) :
    (2 ^ (p - 1) - 1).factorization p =
      (2 ^ d - 1).factorization p := by
  have hpPrimeFactors : p ∈ (2 ^ d - 1).primeFactors :=
    (Finset.mem_filter.mp hpMem).1
  have hpOrder : mersenneExactOrder p = d :=
    (Finset.mem_filter.mp hpMem).2
  have hp : p.Prime := Nat.prime_of_mem_primeFactors hpPrimeFactors
  have hpDvd : p ∣ 2 ^ d - 1 :=
    Nat.dvd_of_mem_primeFactors hpPrimeFactors
  have hdDvd : d ∣ p - 1 := by
    simpa [hpOrder] using
      (mersenneExactOrder_dvd_prime_sub_one hd hp hpDvd)
  have hpm : p ∣ 2 ^ (p - 1) - 1 :=
    hpDvd.trans (Nat.pow_sub_one_dvd_pow_sub_one 2 hdDvd)
  have hpTwo : 2 ≤ p := hp.two_le
  have hpPredPos : 0 < p - 1 := by omega
  have hlte := factorization_mersenne_eq_exactOrder_add_index
    hpPredPos hp hpm
  have hpNotDvdPred : ¬ p ∣ p - 1 := by
    intro h
    have hle : p ≤ p - 1 := Nat.le_of_dvd hpPredPos h
    omega
  have hpredFac : (p - 1).factorization p = 0 :=
    Nat.factorization_eq_zero_of_not_dvd hpNotDvdPred
  rw [hpOrder, hpredFac, add_zero] at hlte
  exact hlte

/-- Positivity of the actual order multiplier sharpens the existing exact
fibre capacity by one. -/
theorem lowMultiplierExactOrderPrimes_card_le_pred
    {d H : ℕ} (hd : 0 < d) :
    (lowMultiplierExactOrderPrimes d H).card ≤ H - 1 := by
  apply card_le_pred_of_positive_injective_labels_lt
      (lowMultiplierExactOrderPrimes d H)
      (fun p : ℕ => (p - 1) / d) H
  · intro p hp q hq hpq
    exact exactOrder_multiplier_injectiveOn d hd
      (Finset.mem_filter.mp hp).1 (Finset.mem_filter.mp hq).1 hpq
  · intro p hp
    exact exactOrder_multiplier_pos hd (Finset.mem_filter.mp hp).1
  · intro p hp
    exact (Finset.mem_filter.mp hp).2

/-- The actual multipliers below `H` obey the triangular-energy bound. -/
theorem lowMultiplierExactOrderPrimes_sum_multiplier_le
    {d H : ℕ} (hd : 0 < d) :
    (∑ p ∈ lowMultiplierExactOrderPrimes d H,
      (p - 1) / d) ≤ H * (H - 1) / 2 := by
  apply sum_injective_labels_lt_le_triangular
      (lowMultiplierExactOrderPrimes d H)
      (fun p : ℕ => (p - 1) / d) H
  · intro p hp q hq hpq
    exact exactOrder_multiplier_injectiveOn d hd
      (Finset.mem_filter.mp hp).1 (Finset.mem_filter.mp hq).1 hpq
  · intro p hp
    exact (Finset.mem_filter.mp hp).2

/-- Any affine depth envelope on the actual low-multiplier fibre inherits the
exact triangular bound.  This is deliberately generic: no unformalized
valuation estimate is asserted by the theorem. -/
theorem lowMultiplierExactOrderWeight_le_triangular_envelope
    {d H : ℕ} (hd : 0 < d) (weight : ℕ → ℝ)
    {slope error : ℝ} (hslope : 0 ≤ slope) (herror : 0 ≤ error)
    (henv : ∀ p ∈ lowMultiplierExactOrderPrimes d H,
      weight p ≤ slope * (((p - 1) / d : ℕ) : ℝ) + error) :
    (∑ p ∈ lowMultiplierExactOrderPrimes d H, weight p) ≤
      slope * (H * (H - 1) / 2 : ℕ) +
        error * (H - 1 : ℕ) := by
  apply weighted_mass_le_triangular_envelope
      (lowMultiplierExactOrderPrimes d H)
      (fun p : ℕ => (p - 1) / d) weight H
  · intro p hp q hq hpq
    exact exactOrder_multiplier_injectiveOn d hd
      (Finset.mem_filter.mp hp).1 (Finset.mem_filter.mp hq).1 hpq
  · intro p hp
    exact exactOrder_multiplier_pos hd (Finset.mem_filter.mp hp).1
  · intro p hp
    exact (Finset.mem_filter.mp hp).2
  · exact hslope
  · exact herror
  · exact henv

#print axioms sum_injective_labels_lt_le_triangular
#print axioms card_le_pred_of_positive_injective_labels_lt
#print axioms weighted_mass_le_triangular_envelope
#print axioms factorization_fermat_eq_exactOrder
#print axioms lowMultiplierExactOrderPrimes_card_le_pred
#print axioms lowMultiplierExactOrderPrimes_sum_multiplier_le
#print axioms lowMultiplierExactOrderWeight_le_triangular_envelope

/-! ## Two controlled arms and two surviving arms -/

/-- Once the one-copy low-multiplier arm and the low-multiplier deep arm fit
inside one common error budget, the surviving high-multiplier deep arm or the
balanced near-square-root arm carries `share`. -/
theorem highDeep_or_balancedNearSquare_of_two_low_budgets
    {target lowOne lowDeep highDeep nearSquare share : ℝ}
    (htotal : target ≤ lowOne + lowDeep + highDeep + nearSquare)
    (hlow : lowOne + lowDeep ≤ target - 2 * share) :
    share ≤ highDeep ∨ share ≤ nearSquare := by
  apply deep_or_nearSquare_of_low_budget
      (target := target) (low := lowOne + lowDeep)
      (deep := highDeep) (nearSquare := nearSquare)
  · linarith
  · exact hlow

/-- One half remains the exact algebraic ceiling after both controlled arms
vanish. -/
theorem one_half_is_sharp_after_two_controlled_arms
    {c : ℝ} (hc : (1 : ℝ) / 2 < c) :
    ∃ target lowOne lowDeep highDeep nearSquare : ℝ,
      0 ≤ target ∧ 0 ≤ lowOne ∧ 0 ≤ lowDeep ∧
      0 ≤ highDeep ∧ 0 ≤ nearSquare ∧
      target = lowOne + lowDeep + highDeep + nearSquare ∧
      lowOne = 0 ∧ lowDeep = 0 ∧
      ¬ (c * target ≤ highDeep ∨ c * target ≤ nearSquare) := by
  refine ⟨2, 0, 0, 1, 1, ?_⟩
  constructor
  · norm_num
  constructor
  · norm_num
  constructor
  · norm_num
  constructor
  · norm_num
  constructor
  · norm_num
  constructor
  · norm_num
  constructor
  · norm_num
  constructor
  · norm_num
  push Not
  constructor <;> nlinarith

#print axioms highDeep_or_balancedNearSquare_of_two_low_budgets
#print axioms one_half_is_sharp_after_two_controlled_arms

/-! ## Exact counterexamples to overstrong finite inferences -/

/-- The full packet of positive labels below `n + 1` attains the triangular
energy bound.  Keeping `n` free is essential: one isolated packet cannot
exclude a linear bound with an arbitrary constant. -/
theorem complete_positive_label_packet (n : ℕ) :
    let s := (Finset.range (n + 1)).erase 0
    Set.InjOn (fun x : ℕ => x) (s : Set ℕ) ∧
      (∀ x ∈ s, 0 < x) ∧
      (∀ x ∈ s, x < n + 1) ∧
      (∑ x ∈ s, x) = n * (n + 1) / 2 := by
  dsimp only
  constructor
  · intro x _ y _ hxy
    exact hxy
  constructor
  · intro x hx
    have hxne : x ≠ 0 := Finset.ne_of_mem_erase hx
    omega
  constructor
  · intro x hx
    exact Finset.mem_range.mp (Finset.mem_of_mem_erase hx)
  · rw [Finset.sum_erase]
    · rw [Finset.sum_range_id]
      simp [Nat.mul_comm]
    · simp

/-- No uniform natural constant times `H` bounds the energy of positive
injective labels below `H`.  For a proposed coefficient `C`, the complete
packet below `2 * (C + 1) + 1` already exceeds `C * H`. -/
theorem no_uniform_nat_linear_bound_for_positive_injective_labels
    (C : ℕ) :
    ∃ (H : ℕ) (s : Finset ℕ) (label : ℕ → ℕ),
      Set.InjOn label (s : Set ℕ) ∧
        (∀ x ∈ s, 0 < label x) ∧
        (∀ x ∈ s, label x < H) ∧
        C * H < ∑ x ∈ s, label x := by
  let n := 2 * (C + 1)
  let H := n + 1
  let s := (Finset.range H).erase 0
  refine ⟨H, s, fun x : ℕ => x, ?_⟩
  have hpacket := complete_positive_label_packet n
  change Set.InjOn (fun x : ℕ => x) (s : Set ℕ) ∧
      (∀ x ∈ s, 0 < x) ∧
      (∀ x ∈ s, x < H) ∧
      C * H < ∑ x ∈ s, x
  have hs : s = (Finset.range (n + 1)).erase 0 := by rfl
  rw [hs]
  rcases hpacket with ⟨hinj, hpos, hlt, hsum⟩
  refine ⟨hinj, hpos, hlt, ?_⟩
  rw [hsum]
  have hmul :
      n * (n + 1) = ((C + 1) * (n + 1)) * 2 := by
    dsimp [n]
    ring
  rw [hmul]
  rw [Nat.mul_div_cancel _ (by norm_num : 0 < (2 : ℕ))]
  dsimp [H]
  nlinarith

/-- The first nontrivial complete packet already refutes the coefficient-one
bound `sum label ≤ H`; the parameterized results above give the stronger
failure for every fixed linear coefficient. -/
theorem triangular_energy_exceeds_coefficient_one_at_four :
    let s : Finset ℕ := {1, 2, 3}
    Set.InjOn (fun x : ℕ => x) (s : Set ℕ) ∧
      (∀ x ∈ s, 0 < x) ∧
      (∀ x ∈ s, x < 4) ∧
      (∑ x ∈ s, x) = 6 ∧
      ¬ ((∑ x ∈ s, x) ≤ 4) := by
  norm_num

/-- `3511` is a complete actual base-two Wieferich exact-order packet with
multiplier two. -/
theorem wieferich_3511_exact_order_multiplier_two :
    Nat.Prime 3511 ∧
      mersenneExactOrder 3511 = 1755 ∧
      3511 ^ 2 ∣ 2 ^ 1755 - 1 ∧
      (3511 - 1) / 1755 = 2 := by
  exact ⟨prime_3511, mersenneExactOrder_3511,
    wieferich_3511_sq_dvd_two_pow_1755_sub_one, by norm_num⟩

/-- Therefore a universal pointwise assertion that every repeated
exact-order prime has multiplier at least three is false under all of its
displayed arithmetic premises. -/
theorem repeated_exact_order_multiplier_ge_three_false :
    ¬ (∀ p d : ℕ,
      Nat.Prime p →
      mersenneExactOrder p = d →
      p ^ 2 ∣ 2 ^ d - 1 →
      3 ≤ (p - 1) / d) := by
  intro hall
  have h := hall 3511 1755 prime_3511 mersenneExactOrder_3511
    wieferich_3511_sq_dvd_two_pow_1755_sub_one
  norm_num at h

#print axioms complete_positive_label_packet
#print axioms no_uniform_nat_linear_bound_for_positive_injective_labels
#print axioms triangular_energy_exceeds_coefficient_one_at_four
#print axioms wieferich_3511_exact_order_multiplier_two
#print axioms repeated_exact_order_multiplier_ge_three_false

end MersenneBalancedMultiplierDepthLocalization20260901
end IUTThreeClosures
