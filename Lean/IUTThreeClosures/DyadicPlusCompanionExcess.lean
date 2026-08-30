/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.OneSidedConcentrationNoGo
import IUTThreeClosures.LargeEndpointExternalRadical
import Mathlib.Tactic

/-!
# The exact companion-radical gate for the dyadic endpoint family

The infinite family `1 + 2^k = 2^k+1` shows that one-sided concentration is
not itself contradictory. In this family the complete abc defect is exactly
the repeated-prime excess of the companion `2^k+1`, up to the fixed term
`log 2`.

Every repeated prime factor of the companion is also a base-two lifting prime
at index `2k`. If that index divides `p-1`, the prime is a standard base-two
Wieferich prime. The file does not assume a weighted bound for these primes.
-/

namespace IUTThreeClosures
namespace DyadicPlusCompanionExcess

open OneSidedConcentrationNoGo

noncomputable section

/-- Logarithmic repeated-prime mass of an integer. -/
def repeatedPrimeExcess (n : ℕ) : ℝ :=
  Real.log (n : ℝ) - Real.log (abcRadical n : ℝ)

/-- The primitive abc point `1 + 2^k = 2^k+1`. -/
def dyadicPlusPoint (k : ℕ) (hk : 0 < k) : ABCPoint :=
  { a := 1
    b := 2 ^ k
    c := 2 ^ k + 1
    a_pos := by norm_num
    b_pos := pow_pos (by norm_num) k
    c_pos := by positivity
    sum_eq := by omega
    pairwise_coprime := by
      simp [PairwiseCoprimeABC] }

@[simp] theorem dyadicPlusPoint_height (k : ℕ) (hk : 0 < k) :
    (dyadicPlusPoint k hk).height =
      Real.log ((2 ^ k + 1 : ℕ) : ℝ) := by
  rw [(dyadicPlusPoint k hk).height_eq_log_c]
  rfl

/-- The conductor is exactly the fixed prime two plus the companion radical. -/
theorem dyadicPlusPoint_conductor (k : ℕ) (hk : 0 < k) :
    (dyadicPlusPoint k hk).conductor =
      Real.log 2 + Real.log (abcRadical (2 ^ k + 1) : ℝ) := by
  have hcop : Nat.Coprime (2 ^ k) (2 ^ k + 1) :=
    Nat.coprime_add_self_right.mpr (by simp)
  have hrad :
      abcRadical ((dyadicPlusPoint k hk).a *
        (dyadicPlusPoint k hk).b *
        (dyadicPlusPoint k hk).c) =
        2 * abcRadical (2 ^ k + 1) := by
    change abcRadical (1 * 2 ^ k * (2 ^ k + 1)) =
      2 * abcRadical (2 ^ k + 1)
    simp only [one_mul]
    rw [abcRadical_mul_of_coprime hcop, abcRadical_two_pow hk]
  have hradpos : 0 < (abcRadical (2 ^ k + 1) : ℝ) := by
    exact_mod_cast abcRadical_pos (2 ^ k + 1)
  unfold ABCPoint.conductor
  rw [hrad, Nat.cast_mul,
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hradpos.ne']

/-- Exact identity: dyadic abc quality equals companion repeated-prime excess
minus the fixed prime-two contribution. -/
theorem dyadicPlusPoint_height_sub_conductor
    (k : ℕ) (hk : 0 < k) :
    (dyadicPlusPoint k hk).height -
        (dyadicPlusPoint k hk).conductor =
      repeatedPrimeExcess (2 ^ k + 1) - Real.log 2 := by
  rw [dyadicPlusPoint_height, dyadicPlusPoint_conductor]
  unfold repeatedPrimeExcess
  ring

/-- A prime square which divides `2^k+1` is a base-two lifting prime at
index `2k`. -/
def BaseTwoLiftPrimeAt (p n : ℕ) : Prop :=
  p ^ 2 ∣ 2 ^ n - 1

theorem repeated_plus_divisor_is_liftPrime
    {p k : ℕ} (hp2 : p ^ 2 ∣ 2 ^ k + 1) :
    BaseTwoLiftPrimeAt p (2 * k) := by
  unfold BaseTwoLiftPrimeAt
  have hmul :
      p ^ 2 ∣ (2 ^ k - 1) * (2 ^ k + 1) :=
    dvd_mul_of_dvd_right hp2 (2 ^ k - 1)
  have hid :
      (2 ^ k - 1) * (2 ^ k + 1) = 2 ^ (2 * k) - 1 := by
    have hx : 1 ≤ 2 ^ k := by positivity
    have heq : 2 ^ k = (2 ^ k - 1) + 1 := by omega
    rw [heq]
    ring
  rwa [hid] at hmul

/-- Every prime in the repeated-prime support of `2^k+1` is a lifting
prime at index `2k`. -/
theorem repeated_companion_prime_is_liftPrime
    {p k : ℕ} (hp : p.Prime)
    (hfac : 2 ≤ (2 ^ k + 1).factorization p) :
    BaseTwoLiftPrimeAt p (2 * k) := by
  have hne : 2 ^ k + 1 ≠ 0 := by positivity
  have hp2 : p ^ 2 ∣ 2 ^ k + 1 :=
    (hp.pow_dvd_iff_le_factorization hne).2 hfac
  exact repeated_plus_divisor_is_liftPrime hp2

/-- If the lifting index divides `p-1`, the repeated companion prime is a
standard base-two Wieferich prime. -/
theorem repeated_plus_divisor_is_wieferich
    {p k : ℕ}
    (hp2 : p ^ 2 ∣ 2 ^ k + 1)
    (hindex : 2 * k ∣ p - 1) :
    p ^ 2 ∣ 2 ^ (p - 1) - 1 := by
  obtain ⟨t, ht⟩ := hindex
  have hlift := repeated_plus_divisor_is_liftPrime hp2
  unfold BaseTwoLiftPrimeAt at hlift
  have hdiv :
      2 ^ (2 * k) - 1 ∣ 2 ^ ((2 * k) * t) - 1 := by
    exact pow_sub_one_dvd_pow_mul_sub_one 2 (2 * k) t
  have htarget : p ^ 2 ∣ 2 ^ ((2 * k) * t) - 1 :=
    dvd_trans hlift hdiv
  rwa [← ht]

/-- Uniform abc restricted to the dyadic plus-one family. -/
def DyadicPlusABC : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ C : ℝ, ∀ k : ℕ, ∀ hk : 0 < k,
      (dyadicPlusPoint k hk).height ≤
        (1 + epsilon) * (dyadicPlusPoint k hk).conductor + C

/-- Uniform sublinear repeated-prime mass for the companion values. -/
def UniformDyadicPlusRepeatedExcessBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ K : ℝ, ∀ k : ℕ, 0 < k →
      repeatedPrimeExcess (2 ^ k + 1) ≤
        epsilon * Real.log (abcRadical (2 ^ k + 1) : ℝ) + K

/-- The explicit companion excess estimate implies abc on the dyadic family. -/
theorem dyadicPlusABC_of_uniformRepeatedExcess
    (hbound : UniformDyadicPlusRepeatedExcessBound) :
    DyadicPlusABC := by
  intro epsilon hepsilon
  obtain ⟨K, hK⟩ := hbound epsilon hepsilon
  refine ⟨K, ?_⟩
  intro k hk
  have hexcess := hK k hk
  have hlogtwo : 0 ≤ Real.log 2 := Real.log_nonneg (by norm_num)
  rw [dyadicPlusPoint_height, dyadicPlusPoint_conductor]
  unfold repeatedPrimeExcess at hexcess
  nlinarith

/-- Conversely, dyadic abc gives the repeated-prime companion estimate with
an adjusted fixed constant. -/
theorem uniformRepeatedExcess_of_dyadicPlusABC
    (habc : DyadicPlusABC) :
    UniformDyadicPlusRepeatedExcessBound := by
  intro epsilon hepsilon
  obtain ⟨C, hC⟩ := habc epsilon hepsilon
  refine ⟨C + (1 + epsilon) * Real.log 2, ?_⟩
  intro k hk
  have hpoint := hC k hk
  rw [dyadicPlusPoint_height, dyadicPlusPoint_conductor] at hpoint
  unfold repeatedPrimeExcess
  nlinarith

/-- Exact equivalence for the dyadic endpoint subproblem. -/
theorem uniformRepeatedExcess_iff_dyadicPlusABC :
    UniformDyadicPlusRepeatedExcessBound ↔ DyadicPlusABC :=
  ⟨dyadicPlusABC_of_uniformRepeatedExcess,
   uniformRepeatedExcess_of_dyadicPlusABC⟩

/-- If the companion is squarefree in radical form, the dyadic point satisfies
an even stronger coefficient-one inequality. -/
theorem dyadicPlusPoint_height_le_conductor_of_radical_eq
    (k : ℕ) (hk : 0 < k)
    (hrad : abcRadical (2 ^ k + 1) = 2 ^ k + 1) :
    (dyadicPlusPoint k hk).height ≤
      (dyadicPlusPoint k hk).conductor := by
  rw [dyadicPlusPoint_height, dyadicPlusPoint_conductor, hrad]
  have hlogtwo : 0 ≤ Real.log 2 := Real.log_nonneg (by norm_num)
  linarith

#print axioms dyadicPlusPoint_height
#print axioms dyadicPlusPoint_conductor
#print axioms dyadicPlusPoint_height_sub_conductor
#print axioms repeated_plus_divisor_is_liftPrime
#print axioms repeated_companion_prime_is_liftPrime
#print axioms repeated_plus_divisor_is_wieferich
#print axioms dyadicPlusABC_of_uniformRepeatedExcess
#print axioms uniformRepeatedExcess_of_dyadicPlusABC
#print axioms uniformRepeatedExcess_iff_dyadicPlusABC
#print axioms dyadicPlusPoint_height_le_conductor_of_radical_eq

end
end DyadicPlusCompanionExcess
end IUTThreeClosures
