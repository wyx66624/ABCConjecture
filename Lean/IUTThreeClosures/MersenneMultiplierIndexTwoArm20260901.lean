/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneFixedPolylogBlockMassTriage20260901

/-!
# Multiplier-index compression for the Mersenne exact-order gate

The mathematical proofs precede this file in
`research/ABC_MERSENNE_MULTIPLIER_INDEX_TWO_ARM_2026_09_01.md`.

If a prime `p` has exact base-two order `d`, then `d ∣ p - 1`.  The quotient
`(p - 1) / d` is a positive multiplier, and it determines `p` injectively
inside the exact-order fibre.  Therefore any subfibre whose multipliers lie
below `H` has at most `H` members.  This is the finite arithmetic core of an
elementary estimate for all repeated exact-order primes below a moving
near-quadratic cutoff.

After that low-multiplier mass is removed, only two nonnegative arms remain:
deep valuation excess and primes whose exact order is at most a moving
polylogarithmic multiple of the square root of their size.  The final section
formalizes the exact two-arm subtraction, its composition over the existing
fixed-polylogarithmic window, and the sharp abstract ceiling one half.

No order-distribution, Wieferich-density, cyclotomic squarefreeness, or abc
assertion is introduced as an axiom.
-/

namespace IUTThreeClosures
namespace MersenneMultiplierIndexTwoArm20260901

open scoped BigOperators
open MersenneOrderBlockDecomposition20260901
open MersenneWeightedOrderTail20260901
open MersenneTotientDivisorConcentration20260901
open MersennePolylogCodivisorGate20260901
open MersenneFixedPolylogBlockMassTriage20260901

/-! ## Exact-order multiplier packets -/

/-- The finite prime fibre having exact base-two order `d`. -/
noncomputable def exactOrderPrimeFiber (d : ℕ) : Finset ℕ :=
  (2 ^ d - 1).primeFactors.filter
    (fun p => mersenneExactOrder p = d)

/-- Every prime in the positive exact-order fibre is represented by its
integral multiplier `(p - 1) / d`. -/
theorem exactOrder_prime_eq_one_add_mul_multiplier
    {d p : ℕ} (hd : 0 < d) (hpMem : p ∈ exactOrderPrimeFiber d) :
    p = 1 + d * ((p - 1) / d) := by
  have hpPrimeFactors : p ∈ (2 ^ d - 1).primeFactors :=
    (Finset.mem_filter.mp hpMem).1
  have hpOrder : mersenneExactOrder p = d :=
    (Finset.mem_filter.mp hpMem).2
  have hp : p.Prime := Nat.prime_of_mem_primeFactors hpPrimeFactors
  have hpDvd : p ∣ 2 ^ d - 1 := Nat.dvd_of_mem_primeFactors hpPrimeFactors
  have hdDvd : d ∣ p - 1 := by
    simpa [hpOrder] using
      (mersenneExactOrder_dvd_prime_sub_one hd hp hpDvd)
  have hmul : d * ((p - 1) / d) = p - 1 :=
    Nat.mul_div_cancel' hdDvd
  have hpPos : 0 < p := hp.pos
  omega

/-- The multiplier in a positive exact-order fibre is positive. -/
theorem exactOrder_multiplier_pos
    {d p : ℕ} (hd : 0 < d) (hpMem : p ∈ exactOrderPrimeFiber d) :
    0 < (p - 1) / d := by
  have hpPrimeFactors : p ∈ (2 ^ d - 1).primeFactors :=
    (Finset.mem_filter.mp hpMem).1
  have hpOrder : mersenneExactOrder p = d :=
    (Finset.mem_filter.mp hpMem).2
  have hp : p.Prime := Nat.prime_of_mem_primeFactors hpPrimeFactors
  have hpDvd : p ∣ 2 ^ d - 1 := Nat.dvd_of_mem_primeFactors hpPrimeFactors
  have hdDvd : d ∣ p - 1 := by
    simpa [hpOrder] using
      (mersenneExactOrder_dvd_prime_sub_one hd hp hpDvd)
  have hpTwo : 2 ≤ p := hp.two_le
  have hpPredPos : 0 < p - 1 := by omega
  exact Nat.div_pos (Nat.le_of_dvd hpPredPos hdDvd) hd

/-- Within one exact-order fibre, the integral multiplier determines the
prime injectively. -/
theorem exactOrder_multiplier_injectiveOn
    (d : ℕ) (hd : 0 < d) :
    Set.InjOn (fun p : ℕ => (p - 1) / d)
      (exactOrderPrimeFiber d : Set ℕ) := by
  intro p hp q hq hpq
  change (p - 1) / d = (q - 1) / d at hpq
  calc
    p = 1 + d * ((p - 1) / d) :=
      exactOrder_prime_eq_one_add_mul_multiplier hd hp
    _ = 1 + d * ((q - 1) / d) := by rw [hpq]
    _ = q := (exactOrder_prime_eq_one_add_mul_multiplier hd hq).symm

/-- A finite family with an injective natural label below `H` has at most
`H` members. -/
theorem card_le_of_injective_multiplier_lt
    (s : Finset ℕ) (multiplier : ℕ → ℕ) (H : ℕ)
    (hinj : Set.InjOn multiplier (s : Set ℕ))
    (hlt : ∀ p ∈ s, multiplier p < H) :
    s.card ≤ H := by
  have hmaps : Set.MapsTo multiplier (s : Set ℕ)
      (Finset.range H : Set ℕ) := by
    intro p hp
    exact Finset.mem_range.mpr (hlt p hp)
  have hcard : s.card ≤ (Finset.range H).card :=
    Finset.card_le_card_of_injOn multiplier hmaps hinj
  simpa using hcard

/-- Exact-order primes whose multiplier is below `H`.  The repeated-prime
support used in the paper is a subset of this stronger fibre. -/
noncomputable def lowMultiplierExactOrderPrimes (d H : ℕ) : Finset ℕ :=
  (exactOrderPrimeFiber d).filter
    (fun p => (p - 1) / d < H)

/-- The actual low-multiplier exact-order fibre has cardinality at most the
multiplier cutoff. -/
theorem lowMultiplierExactOrderPrimes_card_le
    {d H : ℕ} (hd : 0 < d) :
    (lowMultiplierExactOrderPrimes d H).card ≤ H := by
  apply card_le_of_injective_multiplier_lt
      (lowMultiplierExactOrderPrimes d H)
      (fun p : ℕ => (p - 1) / d) H
  · intro p hp q hq hpq
    exact exactOrder_multiplier_injectiveOn d hd
      (Finset.mem_filter.mp hp).1 (Finset.mem_filter.mp hq).1 hpq
  · intro p hp
    exact (Finset.mem_filter.mp hp).2

/-- Logarithmic mass of the actual low-multiplier fibre. -/
noncomputable def lowMultiplierExactOrderLogMass (d H : ℕ) : ℝ :=
  ∑ p ∈ lowMultiplierExactOrderPrimes d H, Real.log (p : ℝ)

/-- A pointwise logarithmic cap and multiplier injectivity give the exact
finite mass bound `H * cap`. -/
theorem lowMultiplierExactOrderLogMass_le
    {d H : ℕ} (hd : 0 < d) {cap : ℝ} (hcapNonneg : 0 ≤ cap)
    (hcap : ∀ p ∈ lowMultiplierExactOrderPrimes d H,
      Real.log (p : ℝ) ≤ cap) :
    lowMultiplierExactOrderLogMass d H ≤ (H : ℝ) * cap := by
  have hsum :
      lowMultiplierExactOrderLogMass d H ≤
        ((lowMultiplierExactOrderPrimes d H).card : ℝ) * cap := by
    unfold lowMultiplierExactOrderLogMass
    calc
      (∑ p ∈ lowMultiplierExactOrderPrimes d H, Real.log (p : ℝ)) ≤
          ∑ _p ∈ lowMultiplierExactOrderPrimes d H, cap := by
            exact Finset.sum_le_sum fun p hp => hcap p hp
      _ = ((lowMultiplierExactOrderPrimes d H).card : ℝ) * cap := by
            simp
  have hcard :
      ((lowMultiplierExactOrderPrimes d H).card : ℝ) ≤ (H : ℝ) := by
    exact_mod_cast lowMultiplierExactOrderPrimes_card_le (d := d) (H := H) hd
  exact hsum.trans (mul_le_mul_of_nonneg_right hcard hcapNonneg)

#print axioms exactOrder_prime_eq_one_add_mul_multiplier
#print axioms exactOrder_multiplier_pos
#print axioms exactOrder_multiplier_injectiveOn
#print axioms card_le_of_injective_multiplier_lt
#print axioms lowMultiplierExactOrderPrimes_card_le
#print axioms lowMultiplierExactOrderLogMass_le

/-! ## Two-arm subtraction -/

/-- Once the controlled low-multiplier arm fits below the target after two
copies of `share` are reserved, the deep or near-square-root arm carries
`share`. -/
theorem deep_or_nearSquare_of_low_budget
    {target low deep nearSquare share : ℝ}
    (htotal : target ≤ low + deep + nearSquare)
    (hlow : low ≤ target - 2 * share) :
    share ≤ deep ∨ share ≤ nearSquare := by
  by_contra h
  push Not at h
  rcases h with ⟨hdeep, hnear⟩
  linarith

/-- Exact fixed-window composition of the two-arm lemma.  A pointwise
three-term decomposition is summed over the existing strict
fixed-polylogarithmic window. -/
theorem polylogLocalizedBlockMass_twoArm_of_low_budget
    (total low deep nearSquare : ℕ → ℝ) (k m : ℕ)
    {target share : ℝ}
    (hdecomp : ∀ d, total d ≤ low d + deep d + nearSquare d)
    (htarget : target ≤ polylogLocalizedBlockMass total k m)
    (hlow : polylogLocalizedBlockMass low k m ≤ target - 2 * share) :
    share ≤ polylogLocalizedBlockMass deep k m ∨
      share ≤ polylogLocalizedBlockMass nearSquare k m := by
  have hsum :
      polylogLocalizedBlockMass total k m ≤
        polylogLocalizedBlockMass low k m +
          polylogLocalizedBlockMass deep k m +
          polylogLocalizedBlockMass nearSquare k m := by
    unfold polylogLocalizedBlockMass restrictedDivisorMass
    calc
      (∑ d ∈ m.divisors.filter
          (fun d => Real.log (m / d : ℕ) < fixedPolylogScale k m),
          total d) ≤
          ∑ d ∈ m.divisors.filter
            (fun d => Real.log (m / d : ℕ) < fixedPolylogScale k m),
            (low d + deep d + nearSquare d) := by
              exact Finset.sum_le_sum fun d _ => hdecomp d
      _ =
          (∑ d ∈ m.divisors.filter
              (fun d => Real.log (m / d : ℕ) < fixedPolylogScale k m),
              low d) +
            (∑ d ∈ m.divisors.filter
              (fun d => Real.log (m / d : ℕ) < fixedPolylogScale k m),
              deep d) +
            (∑ d ∈ m.divisors.filter
              (fun d => Real.log (m / d : ℕ) < fixedPolylogScale k m),
              nearSquare d) := by
                simp only [Finset.sum_add_distrib]
  exact deep_or_nearSquare_of_low_budget (htarget.trans hsum) hlow

/-- Convenient one-third specialization of the two-arm theorem. -/
theorem deep_or_nearSquare_of_one_controlled_arm
    {target low deep nearSquare : ℝ}
    (htotal : target ≤ low + deep + nearSquare)
    (hlow : low ≤ target / 3) :
    target / 3 ≤ deep ∨ target / 3 ≤ nearSquare := by
  apply deep_or_nearSquare_of_low_budget htotal
  calc
    low ≤ target / 3 := hlow
    _ = target - 2 * (target / 3) := by ring

#print axioms deep_or_nearSquare_of_low_budget
#print axioms polylogLocalizedBlockMass_twoArm_of_low_budget
#print axioms deep_or_nearSquare_of_one_controlled_arm

/-! ## Exact abstract ceiling -/

/-- Full finite premises for zero controlled mass and two unresolved arms. -/
def ZeroLowTwoArmPremises
    (target low deep nearSquare : ℝ) : Prop :=
  0 ≤ target ∧ 0 ≤ low ∧ 0 ≤ deep ∧ 0 ≤ nearSquare ∧
  target = low + deep + nearSquare ∧ low = 0

/-- One half is the sharp algebraic ceiling: `(2,0,1,1)` defeats every
larger coefficient under every displayed premise. -/
theorem one_half_is_sharp_two_arm_ceiling
    {c : ℝ} (hc : (1 : ℝ) / 2 < c) :
    ∃ target low deep nearSquare : ℝ,
      ZeroLowTwoArmPremises target low deep nearSquare ∧
      ¬ (c * target ≤ deep ∨ c * target ≤ nearSquare) := by
  refine ⟨2, 0, 1, 1, ?_, ?_⟩
  · norm_num [ZeroLowTwoArmPremises]
  · push Not
    constructor <;> nlinarith

#print axioms one_half_is_sharp_two_arm_ceiling

end MersenneMultiplierIndexTwoArm20260901
end IUTThreeClosures
