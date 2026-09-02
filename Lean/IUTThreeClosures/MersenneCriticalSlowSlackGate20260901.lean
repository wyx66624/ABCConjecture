/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneBalancedMultiplierDepthLocalization20260901

/-!
# Critical slow-slack support compression for Mersenne order blocks

The mathematical proof precedes this file in
`research/ABC_MERSENNE_CRITICAL_SLOW_SLACK_GATE_2026_09_01.md`.

That proof replaces the fixed log-log power in the preceding Mersenne gate by
an arbitrarily slowly divergent slack.  The analytic input is still Yamada's
published pointwise valuation bound.  This module formalizes the finite core:
increasing either survivor threshold shrinks the corresponding support and
its nonnegative mass, while decreasing the slack enlarges the balanced
multiplier scale.  It also records the exact `1093` counterexample to an
overstrong parity claim.

No real asymptotic estimate, Yamada theorem, Wieferich-density statement, or
abc consequence is introduced as an assumption.
-/

namespace IUTThreeClosures
namespace MersenneCriticalSlowSlackGate20260901

open scoped BigOperators
open MersenneOrderBlockDecomposition20260901
open MersenneBalancedMultiplierDepthLocalization20260901
open MersenneCanonicalBlockWitness20260901
open MersenneMultiplierIndexTwoArm20260901

/-! ## Nested finite survivor supports -/

section FiniteSupports

variable {α : Type*}

/-- Elements whose integral multiplier survives a lower cutoff. -/
def highMultiplierSupport
    (s : Finset α) (label : α → ℕ) (H : ℕ) : Finset α :=
  s.filter (fun x => H ≤ label x)

/-- Elements whose size survives a strict lower cutoff. -/
noncomputable def aboveSizeSupport
    (s : Finset α) (size : α → ℝ) (T : ℝ) : Finset α :=
  s.filter (fun x => T < size x)

/-- Raising the multiplier threshold can only shrink the surviving support. -/
theorem highMultiplierSupport_anti
    (s : Finset α) (label : α → ℕ) {H₁ H₂ : ℕ} (hH : H₁ ≤ H₂) :
    highMultiplierSupport s label H₂ ⊆
      highMultiplierSupport s label H₁ := by
  intro x hx
  simp only [highMultiplierSupport, Finset.mem_filter] at hx ⊢
  exact ⟨hx.1, hH.trans hx.2⟩

/-- Raising the size threshold can only shrink the surviving support. -/
theorem aboveSizeSupport_anti
    (s : Finset α) (size : α → ℝ) {T₁ T₂ : ℝ} (hT : T₁ ≤ T₂) :
    aboveSizeSupport s size T₂ ⊆
      aboveSizeSupport s size T₁ := by
  intro x hx
  simp only [aboveSizeSupport, Finset.mem_filter] at hx ⊢
  exact ⟨hx.1, hT.trans_lt hx.2⟩

/-- With nonnegative weights, the mass above a larger multiplier threshold
is no larger. -/
theorem highMultiplierMass_anti
    (s : Finset α) (label : α → ℕ) (weight : α → ℝ)
    {H₁ H₂ : ℕ} (hH : H₁ ≤ H₂) (hweight : ∀ x, 0 ≤ weight x) :
    (∑ x ∈ highMultiplierSupport s label H₂, weight x) ≤
      ∑ x ∈ highMultiplierSupport s label H₁, weight x := by
  apply Finset.sum_le_sum_of_subset_of_nonneg
    (highMultiplierSupport_anti s label hH)
  intro x _ _
  exact hweight x

/-- With nonnegative weights, the mass above a larger size threshold is no
larger. -/
theorem aboveSizeMass_anti
    (s : Finset α) (size weight : α → ℝ)
    {T₁ T₂ : ℝ} (hT : T₁ ≤ T₂) (hweight : ∀ x, 0 ≤ weight x) :
    (∑ x ∈ aboveSizeSupport s size T₂, weight x) ≤
      ∑ x ∈ aboveSizeSupport s size T₁, weight x := by
  apply Finset.sum_le_sum_of_subset_of_nonneg
    (aboveSizeSupport_anti s size hT)
  intro x _ _
  exact hweight x

/-- A simultaneous increase of both survivor thresholds shrinks the sum of
the two surviving nonnegative arms. -/
theorem twoSurvivorMass_anti
    (sDeep sOne : Finset α) (multiplier : α → ℕ) (size : α → ℝ)
    (deepWeight oneWeight : α → ℝ) {H₁ H₂ : ℕ} {T₁ T₂ : ℝ}
    (hH : H₁ ≤ H₂) (hT : T₁ ≤ T₂)
    (hdeep : ∀ x, 0 ≤ deepWeight x) (hone : ∀ x, 0 ≤ oneWeight x) :
    (∑ x ∈ highMultiplierSupport sDeep multiplier H₂, deepWeight x) +
        (∑ x ∈ aboveSizeSupport sOne size T₂, oneWeight x) ≤
      (∑ x ∈ highMultiplierSupport sDeep multiplier H₁, deepWeight x) +
        (∑ x ∈ aboveSizeSupport sOne size T₁, oneWeight x) := by
  exact add_le_add
    (highMultiplierMass_anti sDeep multiplier deepWeight hH hdeep)
    (aboveSizeMass_anti sOne size oneWeight hT hone)

end FiniteSupports

#print axioms highMultiplierSupport_anti
#print axioms aboveSizeSupport_anti
#print axioms highMultiplierMass_anti
#print axioms aboveSizeMass_anti
#print axioms twoSurvivorMass_anti

/-! ## Exact cutoff balance and slack comparison -/

/-- Abstract realization of `log(3m) * L_m * sigma(m)`. -/
def slowSlackSizeCutoff (A L σ : ℝ) : ℝ := A * L * σ

/-- The squared, unrounded multiplier scale paired with the size cutoff. -/
noncomputable def slowSlackMultiplierScaleSq (A L σ : ℝ) : ℝ := A / (L * σ)

/-- The two scales have constant product `A^2`; this is the exact balance
behind the identical `1 / sigma` losses in the paper proof. -/
theorem slowSlack_cutoff_mul_multiplierScaleSq
    {A L σ : ℝ} (hL : L ≠ 0) (hσ : σ ≠ 0) :
    slowSlackSizeCutoff A L σ * slowSlackMultiplierScaleSq A L σ = A ^ 2 := by
  unfold slowSlackSizeCutoff slowSlackMultiplierScaleSq
  field_simp

/-- Increasing the slack increases the size-cutoff denominator. -/
theorem slowSlackSizeCutoff_mono
    {A L σ₁ σ₂ : ℝ} (hA : 0 ≤ A) (hL : 0 ≤ L) (hσ : σ₁ ≤ σ₂) :
    slowSlackSizeCutoff A L σ₁ ≤ slowSlackSizeCutoff A L σ₂ := by
  unfold slowSlackSizeCutoff
  gcongr

/-- Increasing a positive slack decreases the squared multiplier scale. -/
theorem slowSlackMultiplierScaleSq_anti
    {A L σ₁ σ₂ : ℝ} (hA : 0 ≤ A) (hL : 0 < L)
    (hσ₁ : 0 < σ₁) (hσ : σ₁ ≤ σ₂) :
    slowSlackMultiplierScaleSq A L σ₂ ≤
      slowSlackMultiplierScaleSq A L σ₁ := by
  unfold slowSlackMultiplierScaleSq
  have hden₁ : 0 < L * σ₁ := mul_pos hL hσ₁
  have hden : L * σ₁ ≤ L * σ₂ :=
    mul_le_mul_of_nonneg_left hσ hL.le
  exact div_le_div_of_nonneg_left hA hden₁ hden

/-- The two directions of the slack comparison are recorded together. -/
theorem slowSlack_scale_comparison
    {A L σ₁ σ₂ : ℝ} (hA : 0 ≤ A) (hL : 0 < L)
    (hσ₁ : 0 < σ₁) (hσ : σ₁ ≤ σ₂) :
    slowSlackSizeCutoff A L σ₁ ≤ slowSlackSizeCutoff A L σ₂ ∧
      slowSlackMultiplierScaleSq A L σ₂ ≤
        slowSlackMultiplierScaleSq A L σ₁ := by
  exact ⟨slowSlackSizeCutoff_mono hA hL.le hσ,
    slowSlackMultiplierScaleSq_anti hA hL hσ₁ hσ⟩

#print axioms slowSlack_cutoff_mul_multiplierScaleSq
#print axioms slowSlackSizeCutoff_mono
#print axioms slowSlackMultiplierScaleSq_anti
#print axioms slowSlack_scale_comparison

/-! ## Finite ledger after enlarging the controlled region -/

/-- The existing two-survivor alternative applies unchanged after the two
controlled arms have been enlarged.  The theorem is finite and contains no
asymptotic premise. -/
theorem criticalHigh_or_criticalNearSquare_of_enlarged_low_budgets
    {target oldLow newlyRemovedDeep newlyRemovedOne
        criticalHigh criticalNear share : ℝ}
    (htotal : target ≤
      oldLow + newlyRemovedDeep + newlyRemovedOne +
        criticalHigh + criticalNear)
    (hlow : oldLow + newlyRemovedDeep + newlyRemovedOne ≤
      target - 2 * share) :
    share ≤ criticalHigh ∨ share ≤ criticalNear := by
  apply highDeep_or_balancedNearSquare_of_two_low_budgets
      (target := target) (lowOne := oldLow)
      (lowDeep := newlyRemovedDeep + newlyRemovedOne)
      (highDeep := criticalHigh) (nearSquare := criticalNear)
  · linarith
  · linarith

#print axioms criticalHigh_or_criticalNearSquare_of_enlarged_low_budgets

/-! ## Exact-order Euler-character core -/

/-- If an odd prime has exact base-two order `d` and `p - 1 = d * r`,
Euler's half-power is exactly `(-1)^r`.  Composing this with Euler's
criterion gives the quadratic-character identity `(2/p) = (-1)^r` used in
the mathematical report. -/
theorem exactOrder_eulerPower_eq_negOnePow_multiplier
    {p d r : ℕ} (hp : p.Prime) (hpOdd : Odd p)
    (horder : orderOf (2 : ZMod p) = d)
    (hpred : p - 1 = d * r) :
    (2 : ZMod p) ^ ((p - 1) / 2) = (-1 : ZMod p) ^ r := by
  letI : Fact p.Prime := ⟨hp⟩
  have hpPredPos : 0 < p - 1 := by
    have : 2 ≤ p := hp.two_le
    omega
  have hpNeTwo : p ≠ 2 := by
    intro hpTwo
    subst p
    norm_num at hpOdd
  have htwo : (2 : ZMod p) ≠ 0 := by
    intro hzero
    have hpDvdTwo : p ∣ 2 :=
      (CharP.cast_eq_zero_iff (ZMod p) p 2).mp hzero
    exact hpNeTwo ((Nat.prime_dvd_prime_iff_eq hp Nat.prime_two).mp hpDvdTwo)
  have hordDvd : orderOf (2 : ZMod p) ∣ p - 1 :=
    ZMod.orderOf_dvd_card_sub_one htwo
  have hordPos : 0 < orderOf (2 : ZMod p) :=
    Nat.pos_of_dvd_of_pos hordDvd hpPredPos
  have hdPos : 0 < d := by simpa [horder] using hordPos
  have hpowd : (2 : ZMod p) ^ d = 1 := by
    rw [← horder]
    exact pow_orderOf_eq_one _
  obtain ⟨s, hrs | hrs⟩ := Nat.even_or_odd' r
  · subst r
    have hhalf : (p - 1) / 2 = d * s := by
      rw [hpred]
      calc
        d * (2 * s) / 2 = (d * s) * 2 / 2 := by
          congr 1
          ring
        _ = d * s := Nat.mul_div_left _ (by norm_num)
    rw [hhalf, pow_mul, hpowd, one_pow]
    simp
  · subst r
    have hrOdd : Odd (2 * s + 1) := by simp
    have hpPredEven : Even (p - 1) :=
      Nat.Odd.sub_odd hpOdd (by norm_num : Odd (1 : ℕ))
    rw [hpred] at hpPredEven
    have hdEven : Even d := by
      by_contra hdNotEven
      have hdOdd : Odd d := Nat.not_even_iff_odd.mp hdNotEven
      exact (Nat.not_odd_iff_even.mpr hpPredEven) (hdOdd.mul hrOdd)
    rcases hdEven with ⟨t, ht⟩
    have htPos : 0 < t := by omega
    have hhalf : (p - 1) / 2 = t * (2 * s + 1) := by
      rw [hpred, ht]
      calc
        (t + t) * (2 * s + 1) / 2 =
            (t * (2 * s + 1)) * 2 / 2 := by
          congr 1
          ring
        _ = t * (2 * s + 1) := Nat.mul_div_left _ (by norm_num)
    have hpowTwoT : (2 : ZMod p) ^ (t + t) = 1 := by
      simpa [ht] using hpowd
    have hsquare :
        ((2 : ZMod p) ^ t) * ((2 : ZMod p) ^ t) = 1 := by
      rw [← pow_add]
      exact hpowTwoT
    have hhalfOrder : (2 : ZMod p) ^ t = -1 := by
      rcases (mul_self_eq_one_iff.mp hsquare) with hOne | hNeg
      · have hdDvdT : d ∣ t := by
          rw [← horder]
          exact orderOf_dvd_of_pow_eq_one hOne
        have hdLeT : d ≤ t := Nat.le_of_dvd htPos hdDvdT
        omega
      · exact hNeg
    rw [hhalf, pow_mul, hhalfOrder]

/-- Euler's criterion turns the preceding exact-order identity into the
Legendre-character statement, recorded after casting to `ZMod p`. -/
theorem exactOrder_legendreTwo_cast_eq_negOnePow_multiplier
    {p d r : ℕ} [Fact p.Prime] (hpOdd : Odd p)
    (horder : orderOf (2 : ZMod p) = d)
    (hpred : p - 1 = d * r) :
    ((legendreSym p 2 : ℤ) : ZMod p) = (-1 : ZMod p) ^ r := by
  have hp : p.Prime := Fact.out
  have hhalf : p / 2 = (p - 1) / 2 := by
    rcases hpOdd with ⟨s, hs⟩
    omega
  rw [legendreSym.eq_pow, hhalf]
  simpa using exactOrder_eulerPower_eq_negOnePow_multiplier
    hp hpOdd horder hpred

/-- Actual exact-order fibres satisfy the Euler half-power identity with the
canonical integral multiplier `(p - 1) / d`. -/
theorem exactOrderPrimeFiber_eulerPower_eq_negOnePow_multiplier
    {p d : ℕ} (hd : 0 < d) (hpMem : p ∈ exactOrderPrimeFiber d) :
    (2 : ZMod p) ^ ((p - 1) / 2) =
      (-1 : ZMod p) ^ ((p - 1) / d) := by
  have hpFactors : p ∈ (2 ^ d - 1).primeFactors :=
    (Finset.mem_filter.mp hpMem).1
  have hpOrder : mersenneExactOrder p = d :=
    (Finset.mem_filter.mp hpMem).2
  have hp : p.Prime := Nat.prime_of_mem_primeFactors hpFactors
  have hpDvd : p ∣ 2 ^ d - 1 := Nat.dvd_of_mem_primeFactors hpFactors
  have hpNeTwo : p ≠ 2 :=
    prime_ne_two_of_dvd_mersenne hd hp hpDvd
  have hpOdd : Odd p := hp.odd_of_ne_two hpNeTwo
  have hpRep := exactOrder_prime_eq_one_add_mul_multiplier hd hpMem
  have hpred : p - 1 = d * ((p - 1) / d) := by omega
  exact exactOrder_eulerPower_eq_negOnePow_multiplier
    hp hpOdd hpOrder hpred

#print axioms exactOrder_eulerPower_eq_negOnePow_multiplier
#print axioms exactOrder_legendreTwo_cast_eq_negOnePow_multiplier
#print axioms exactOrderPrimeFiber_eulerPower_eq_negOnePow_multiplier

/-! ## Sharp abstract and arithmetic counterexample boundaries -/

/-- The complete positive packet from the preceding module remains a full
counterexample to every proposed linear-in-`H` energy bound.  Thus the
critical `sigma = 1` estimate cannot follow from positivity and multiplier
injectivity alone. -/
theorem critical_packet_refutes_every_fixed_linear_energy_coefficient
    (C : ℕ) :
    ∃ (H : ℕ) (s : Finset ℕ) (label : ℕ → ℕ),
      Set.InjOn label (s : Set ℕ) ∧
        (∀ x ∈ s, 0 < label x) ∧
        (∀ x ∈ s, label x < H) ∧
        C * H < ∑ x ∈ s, label x := by
  exact no_uniform_nat_linear_bound_for_positive_injective_labels C

/-- `1093` is an actual repeated base-two exact-order prime with odd
multiplier three. -/
theorem wieferich_1093_exact_order_multiplier_three_odd :
    Nat.Prime 1093 ∧
      mersenneExactOrder 1093 = 364 ∧
      1093 ^ 2 ∣ 2 ^ 364 - 1 ∧
      ¬ 1093 ^ 3 ∣ 2 ^ 364 - 1 ∧
      (1093 - 1) / 364 = 3 ∧
      Odd ((1093 - 1) / 364) := by
  exact ⟨prime_1093, mersenneExactOrder_1093,
    wieferich_1093_sq_dvd_two_pow_364_sub_one,
    wieferich_1093_cube_not_dvd_two_pow_364_sub_one,
    by norm_num, by norm_num⟩

/-- Full-premise negation of the tempting parity strengthening.  This
retires only that pointwise claim, not either asymptotic Mersenne arm. -/
theorem repeated_exact_order_multiplier_even_false :
    ¬ (∀ p d : ℕ,
      Nat.Prime p →
      mersenneExactOrder p = d →
      p ^ 2 ∣ 2 ^ d - 1 →
      Even ((p - 1) / d)) := by
  intro hall
  have hodd := hall 1093 364 prime_1093 mersenneExactOrder_1093
    wieferich_1093_sq_dvd_two_pow_364_sub_one
  norm_num at hodd

#print axioms critical_packet_refutes_every_fixed_linear_energy_coefficient
#print axioms wieferich_1093_exact_order_multiplier_three_odd
#print axioms repeated_exact_order_multiplier_even_false

end MersenneCriticalSlowSlackGate20260901
end IUTThreeClosures
