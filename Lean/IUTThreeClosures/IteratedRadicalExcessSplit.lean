/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointPrimePowerLocalization
import Mathlib.Data.Nat.Factorization.PrimePow
import Mathlib.RingTheory.Radical.NatInt
import Mathlib.Tactic

/-!
# Splitting the cubeful excess between the two large abc endpoints

For a positive natural number, define the second radical quotient directly
from its prime factorization by retaining exponent `max(v_p(n)-2,0)` at every
prime.  This quantity is multiplicative on coprime natural numbers.  Since
`max(a,b)` and `c` are coprime, the complete excess ledger splits exactly
between these two adjacent endpoints.

Consequently every violation of an abc bound forces conductor-scale excess on
at least one individual endpoint, not merely on their product.
-/

namespace IUTThreeClosures
namespace IteratedRadicalExcessSplit

open UniqueFactorizationMonoid

noncomputable section

/-- The finitely supported prime-exponent profile above level two. -/
def exponentAboveTwo (n : ℕ) : ℕ →₀ ℕ :=
  n.factorization.mapRange (fun e => e - 2) (by simp)

/-- Every index in the support of the excess profile is prime. -/
theorem prime_of_mem_exponentAboveTwo_support
    {n p : ℕ} (hp : p ∈ (exponentAboveTwo n).support) : p.Prime := by
  have hne : exponentAboveTwo n p ≠ 0 := Finsupp.mem_support_iff.mp hp
  have hfac : n.factorization p ≠ 0 := by
    intro hzero
    apply hne
    simp [exponentAboveTwo, hzero]
  have hmem : p ∈ n.factorization.support :=
    Finsupp.mem_support_iff.mpr hfac
  exact Nat.prime_of_mem_primeFactors (by simpa using hmem)

/-- Remove the first two copies of every prime factor. -/
def secondRadicalQuotient (n : ℕ) : ℕ :=
  (exponentAboveTwo n).prod fun p e => p ^ e

/-- The second radical quotient has exactly the excess exponent profile. -/
theorem secondRadicalQuotient_factorization (n : ℕ) :
    (secondRadicalQuotient n).factorization = exponentAboveTwo n := by
  unfold secondRadicalQuotient
  exact Nat.prod_pow_factorization_eq_self
    (fun p hp => prime_of_mem_exponentAboveTwo_support hp)

/-- The second radical quotient of a positive integer is positive. -/
theorem secondRadicalQuotient_pos {n : ℕ} (_hn : 0 < n) :
    0 < secondRadicalQuotient n := by
  classical
  unfold secondRadicalQuotient Finsupp.prod
  exact Finset.prod_pos fun p hp =>
    pow_pos (prime_of_mem_exponentAboveTwo_support hp).pos _

/-- The excess profile is additive on coprime inputs. -/
theorem exponentAboveTwo_mul_of_coprime {m n : ℕ}
    (h : Nat.Coprime m n) :
    exponentAboveTwo (m * n) =
      exponentAboveTwo m + exponentAboveTwo n := by
  by_cases hm : m = 0
  · subst m
    have hn : n = 1 := by simpa using h
    subst n
    simp [exponentAboveTwo]
  by_cases hn : n = 0
  · subst n
    have hm1 : m = 1 := by simpa using h
    subst m
    simp [exponentAboveTwo]
  ext p
  simp only [exponentAboveTwo, Finsupp.mapRange_apply]
  rw [congrFun (congrArg DFunLike.coe (Nat.factorization_mul hm hn)) p]
  simp only [Finsupp.add_apply]
  by_cases hp : p.Prime
  · have hzero :
        m.factorization p = 0 ∨ n.factorization p = 0 := by
      by_contra hnot
      push Not at hnot
      have hpm : p ∣ m := by
        by_contra hpd
        exact hnot.1 (Nat.factorization_eq_zero_of_not_dvd hpd)
      have hpn : p ∣ n := by
        by_contra hpd
        exact hnot.2 (Nat.factorization_eq_zero_of_not_dvd hpd)
      exact hp.ne_one (Nat.eq_one_of_dvd_coprimes h hpm hpn)
    rcases hzero with hzero | hzero <;> simp [hzero]
  · have hm0 := Nat.factorization_eq_zero_of_not_prime m hp
    have hn0 := Nat.factorization_eq_zero_of_not_prime n hp
    simp [hm0, hn0]

/-- The second radical quotient is multiplicative on coprime naturals. -/
theorem secondRadicalQuotient_mul_of_coprime {m n : ℕ}
    (h : Nat.Coprime m n) :
    secondRadicalQuotient (m * n) =
      secondRadicalQuotient m * secondRadicalQuotient n := by
  unfold secondRadicalQuotient
  rw [exponentAboveTwo_mul_of_coprime h]
  exact Finsupp.prod_add_index'
    (fun p => pow_zero p)
    (fun p a b => pow_add p a b)

/-- The original integer divides radical square times the excess profile. -/
theorem dvd_radical_sq_mul_secondRadicalQuotient (n : ℕ) :
    n ∣ abcRadical n ^ 2 * secondRadicalQuotient n := by
  by_cases hn : n = 0
  · subst n
    simp
  have hradne : abcRadical n ^ 2 ≠ 0 :=
    pow_ne_zero 2 (abcRadical_pos n).ne'
  have hqne : secondRadicalQuotient n ≠ 0 :=
    (secondRadicalQuotient_pos (Nat.pos_of_ne_zero hn)).ne'
  have htarget :
      abcRadical n ^ 2 * secondRadicalQuotient n ≠ 0 :=
    mul_ne_zero hradne hqne
  rw [← Nat.factorization_le_iff_dvd hn htarget]
  intro p
  rw [Nat.factorization_mul hradne hqne,
    Nat.factorization_pow,
    secondRadicalQuotient_factorization]
  change n.factorization p ≤
    2 * (abcRadical n).factorization p +
      (n.factorization p - 2)
  by_cases hp : p.Prime
  · by_cases hpn : p ∣ n
    · have hprad : p ∣ radical n :=
        (UniqueFactorizationMonoid.dvd_radical_iff_of_irreducible
          hp hn).2 hpn
      have hfac : (abcRadical n).factorization p = 1 := by
        rw [abcRadical_eq_natRadical]
        exact Nat.factorization_eq_one_of_squarefree
          (UniqueFactorizationMonoid.squarefree_radical (a := n))
          hp hprad
      rw [hfac]
      omega
    · rw [Nat.factorization_eq_zero_of_not_dvd hpn]
      simp
  · rw [Nat.factorization_eq_zero_of_not_prime n hp]
    simp

/-- The same radical-square inequality as the gcd-defined cubeful excess, now
with an excess that is exactly multiplicative on coprime inputs. -/
theorem le_radical_sq_mul_secondRadicalQuotient (n : ℕ) :
    n ≤ abcRadical n ^ 2 * secondRadicalQuotient n := by
  by_cases hn : n = 0
  · subst n
    simp
  exact Nat.le_of_dvd
    (mul_pos (pow_pos (abcRadical_pos n) 2)
      (secondRadicalQuotient_pos (Nat.pos_of_ne_zero hn)))
    (dvd_radical_sq_mul_secondRadicalQuotient n)

end
end IteratedRadicalExcessSplit

open IteratedRadicalExcessSplit

noncomputable section

namespace ABCPoint

/-- Second radical quotient of the product of the two large adjacent
endpoints. -/
def largeEndpointSecondRadicalQuotient (P : ABCPoint) : ℕ :=
  secondRadicalQuotient (P.largeEndpoint * P.c)

/-- The excess on the larger summand alone. -/
def maxEndpointSecondRadicalQuotient (P : ABCPoint) : ℕ :=
  secondRadicalQuotient P.largeEndpoint

/-- The excess on `c` alone. -/
def cSecondRadicalQuotient (P : ABCPoint) : ℕ :=
  secondRadicalQuotient P.c

@[simp]
theorem maxEndpointSecondRadicalQuotient_pos (P : ABCPoint) :
    0 < P.maxEndpointSecondRadicalQuotient := by
  exact secondRadicalQuotient_pos P.largeEndpoint_pos

@[simp]
theorem cSecondRadicalQuotient_pos (P : ABCPoint) :
    0 < P.cSecondRadicalQuotient := by
  exact secondRadicalQuotient_pos P.c_pos

@[simp]
theorem largeEndpointSecondRadicalQuotient_pos (P : ABCPoint) :
    0 < P.largeEndpointSecondRadicalQuotient := by
  exact secondRadicalQuotient_pos
    (mul_pos P.largeEndpoint_pos P.c_pos)

/-- Exact multiplicative splitting between the two coprime endpoints. -/
theorem largeEndpointSecondRadicalQuotient_eq_mul (P : ABCPoint) :
    P.largeEndpointSecondRadicalQuotient =
      P.maxEndpointSecondRadicalQuotient *
        P.cSecondRadicalQuotient := by
  exact secondRadicalQuotient_mul_of_coprime P.largeEndpoint_coprime_c

/-- Radical-square control of the large-endpoint product. -/
theorem largeEndpoint_mul_c_le_abcRadical_sq_mul_secondRadicalQuotient
    (P : ABCPoint) :
    P.largeEndpoint * P.c ≤
      abcRadical (P.a * P.b * P.c) ^ 2 *
        P.largeEndpointSecondRadicalQuotient := by
  calc
    P.largeEndpoint * P.c ≤
        abcRadical (P.largeEndpoint * P.c) ^ 2 *
          P.largeEndpointSecondRadicalQuotient := by
      simpa [largeEndpointSecondRadicalQuotient] using
        le_radical_sq_mul_secondRadicalQuotient
          (P.largeEndpoint * P.c)
    _ ≤ abcRadical (P.a * P.b * P.c) ^ 2 *
          P.largeEndpointSecondRadicalQuotient := by
      exact Nat.mul_le_mul_right _
        (Nat.pow_le_pow_left P.radical_largeEndpoint_mul_c_le_abcRadical 2)

/-- Exact height ledger using the multiplicative second radical quotient. -/
theorem two_mul_height_le_log_two_add_two_mul_conductor_add_log_secondQuotient
    (P : ABCPoint) :
    2 * P.height ≤
      Real.log 2 + 2 * P.conductor +
        Real.log (P.largeEndpointSecondRadicalQuotient : ℝ) := by
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hradpos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hqpos :
      0 < (P.largeEndpointSecondRadicalQuotient : ℝ) := by
    exact_mod_cast P.largeEndpointSecondRadicalQuotient_pos
  have hnat :
      P.c ^ 2 ≤
        2 * (abcRadical (P.a * P.b * P.c) ^ 2 *
          P.largeEndpointSecondRadicalQuotient) := by
    calc
      P.c ^ 2 ≤ 2 * (P.largeEndpoint * P.c) :=
        P.c_sq_le_two_largeEndpoint_mul_c
      _ ≤ 2 * (abcRadical (P.a * P.b * P.c) ^ 2 *
          P.largeEndpointSecondRadicalQuotient) :=
        Nat.mul_le_mul_left 2
          P.largeEndpoint_mul_c_le_abcRadical_sq_mul_secondRadicalQuotient
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * ((abcRadical (P.a * P.b * P.c) : ℝ) ^ 2 *
          (P.largeEndpointSecondRadicalQuotient : ℝ)) := by
    exact_mod_cast hnat
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0)
        (mul_pos (pow_pos hradpos 2) hqpos).ne',
      Real.log_mul (pow_pos hradpos 2).ne' hqpos.ne',
      Real.log_pow] at hlog
  rw [P.height_eq_log_c]
  unfold ABCPoint.conductor
  ring_nf at hlog ⊢
  exact hlog

/-- Logarithmic excess splits additively between the two endpoints. -/
theorem log_largeEndpointSecondRadicalQuotient_eq_add (P : ABCPoint) :
    Real.log (P.largeEndpointSecondRadicalQuotient : ℝ) =
      Real.log (P.maxEndpointSecondRadicalQuotient : ℝ) +
        Real.log (P.cSecondRadicalQuotient : ℝ) := by
  rw [P.largeEndpointSecondRadicalQuotient_eq_mul]
  push_cast
  rw [Real.log_mul
    (by exact_mod_cast P.maxEndpointSecondRadicalQuotient_pos.ne')
    (by exact_mod_cast P.cSecondRadicalQuotient_pos.ne')]

/-- Every abc violation forces half of the quantitative excess lower bound on
one individual large endpoint. -/
theorem endpoint_secondRadicalQuotient_large_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    epsilon * P.conductor + C - Real.log 2 / 2 <
        Real.log (P.maxEndpointSecondRadicalQuotient : ℝ) ∨
      epsilon * P.conductor + C - Real.log 2 / 2 <
        Real.log (P.cSecondRadicalQuotient : ℝ) := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_log_secondQuotient
  have htotal :
      2 * epsilon * P.conductor + 2 * C - Real.log 2 <
        Real.log (P.largeEndpointSecondRadicalQuotient : ℝ) := by
    nlinarith
  rw [P.log_largeEndpointSecondRadicalQuotient_eq_add] at htotal
  by_contra hnot
  push Not at hnot
  nlinarith

end ABCPoint

namespace IteratedRadicalExcessSplit

/-- Uniform control of the split second radical quotient. -/
def UniformSecondRadicalQuotientBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ K : ℝ, ∀ P : ABCPoint,
      Real.log (P.largeEndpointSecondRadicalQuotient : ℝ) ≤
        2 * epsilon * P.conductor + K

/-- The split excess target implies abc. -/
theorem abc_of_uniformSecondRadicalQuotientBound
    (hbound : UniformSecondRadicalQuotientBound) :
    ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨K, hK⟩ := hbound epsilon hepsilon
  refine ⟨(K + Real.log 2) / 2, ?_⟩
  intro a b c ha hb hc hsum hcoprime
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hsum
      pairwise_coprime := hcoprime }
  have hledger :=
    ABCPoint.two_mul_height_le_log_two_add_two_mul_conductor_add_log_secondQuotient P
  have hexcess := hK P
  have hpoint :
      P.height ≤
        (1 + epsilon) * P.conductor + (K + Real.log 2) / 2 := by
    nlinarith
  simpa [P, ABCPoint.height, ABCPoint.conductor] using hpoint

#print axioms prime_of_mem_exponentAboveTwo_support
#print axioms secondRadicalQuotient_factorization
#print axioms exponentAboveTwo_mul_of_coprime
#print axioms secondRadicalQuotient_mul_of_coprime
#print axioms dvd_radical_sq_mul_secondRadicalQuotient
#print axioms le_radical_sq_mul_secondRadicalQuotient
#print axioms ABCPoint.largeEndpointSecondRadicalQuotient_eq_mul
#print axioms ABCPoint.two_mul_height_le_log_two_add_two_mul_conductor_add_log_secondQuotient
#print axioms ABCPoint.log_largeEndpointSecondRadicalQuotient_eq_add
#print axioms ABCPoint.endpoint_secondRadicalQuotient_large_of_height_violation
#print axioms abc_of_uniformSecondRadicalQuotientBound

end IteratedRadicalExcessSplit
end
end IUTThreeClosures
