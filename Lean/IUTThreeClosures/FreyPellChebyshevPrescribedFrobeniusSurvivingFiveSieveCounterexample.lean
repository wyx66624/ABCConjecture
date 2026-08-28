/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyPellChebyshevPrescribedFrobeniusCounterexample

/-!
# A prescribed-Frobenius counterexample surviving the base modulo-five sieve

At `(p,X)=(37,239)`, the base satisfies `X % 24 = 23` and `X % 5 = 4`,
while every prime factor of the odd Chebyshev quotient is split modulo five.
The complete factorization and four primality certificates were checked by
PARI and an independent BigInt verifier.  Lean kernel-replays the recurrence,
residues, exact valuation-one statements and nonsquare obstruction, and keeps
the four primality conclusions behind one transparent frozen-computation
proposition.  There is no hidden axiom or instance.
-/

namespace IUTThreeClosures

def survivingFiveSieveFactorOne : ℕ := 204841621

def survivingFiveSieveFactorTwo : ℕ := 11179222169639

def survivingFiveSieveFactorThree : ℕ := 1748257245007335071

def survivingFiveSieveFactorFour : ℕ :=
  719281385924874743830923395004066559868875967047929887269

/-- Transparent boundary for the four independently verified exact primality
certificates. -/
def FrozenPocklingtonPrimeCertificateThirtySevenTwoThirtyNine : Prop :=
  Nat.Prime survivingFiveSieveFactorOne ∧
    Nat.Prime survivingFiveSieveFactorTwo ∧
    Nat.Prime survivingFiveSieveFactorThree ∧
    Nat.Prime survivingFiveSieveFactorFour

/-- Exact complete factorization of `H_18(239) = T_37(239) / 239`. -/
theorem pellOddChebyshevQuotient_eighteen_twoThirtyNine_factorization :
    pellOddChebyshevQuotient 18 239 =
      (survivingFiveSieveFactorOne : ℤ) *
        survivingFiveSieveFactorTwo *
        survivingFiveSieveFactorThree *
        survivingFiveSieveFactorFour := by
  set_option maxRecDepth 100000 in
    norm_num [pellOddChebyshevQuotient, survivingFiveSieveFactorOne,
      survivingFiveSieveFactorTwo, survivingFiveSieveFactorThree,
      survivingFiveSieveFactorFour]

theorem twoThirtyNine_mod_twentyFour : (239 : ℤ) % 24 = 23 := by norm_num

theorem twoThirtyNine_mod_five : (239 : ℤ) % 5 = 4 := by norm_num

theorem thirtySeven_prime : Nat.Prime 37 := by norm_num

theorem thirtySeven_atLeastThirtySeven : 37 ≤ (37 : ℕ) := by norm_num

theorem survivingFiveSieveFactorOne_mod_five :
    survivingFiveSieveFactorOne % 5 = 1 := by
  norm_num [survivingFiveSieveFactorOne]

theorem survivingFiveSieveFactorTwo_mod_five :
    survivingFiveSieveFactorTwo % 5 = 4 := by
  norm_num [survivingFiveSieveFactorTwo]

theorem survivingFiveSieveFactorThree_mod_five :
    survivingFiveSieveFactorThree % 5 = 1 := by
  norm_num [survivingFiveSieveFactorThree]

theorem survivingFiveSieveFactorFour_mod_five :
    survivingFiveSieveFactorFour % 5 = 4 := by
  norm_num [survivingFiveSieveFactorFour]

/-- Each displayed factor occurs to exact exponent one.  This arithmetic fact
does not require their primality. -/
theorem survivingFiveSieveFactors_exactlyOnce :
    ((survivingFiveSieveFactorOne : ℤ) ∣
        pellOddChebyshevQuotient 18 239 ∧
      ¬ (survivingFiveSieveFactorOne : ℤ) ^ 2 ∣
        pellOddChebyshevQuotient 18 239) ∧
    ((survivingFiveSieveFactorTwo : ℤ) ∣
        pellOddChebyshevQuotient 18 239 ∧
      ¬ (survivingFiveSieveFactorTwo : ℤ) ^ 2 ∣
        pellOddChebyshevQuotient 18 239) ∧
    ((survivingFiveSieveFactorThree : ℤ) ∣
        pellOddChebyshevQuotient 18 239 ∧
      ¬ (survivingFiveSieveFactorThree : ℤ) ^ 2 ∣
        pellOddChebyshevQuotient 18 239) ∧
    ((survivingFiveSieveFactorFour : ℤ) ∣
        pellOddChebyshevQuotient 18 239 ∧
      ¬ (survivingFiveSieveFactorFour : ℤ) ^ 2 ∣
        pellOddChebyshevQuotient 18 239) := by
  rw [pellOddChebyshevQuotient_eighteen_twoThirtyNine_factorization]
  norm_num [survivingFiveSieveFactorOne, survivingFiveSieveFactorTwo,
    survivingFiveSieveFactorThree, survivingFiveSieveFactorFour,
    Int.dvd_iff_emod_eq_zero]

/-- Every prime divisor is one of the four displayed factors, conditional on
the named exact primality packet. -/
theorem prime_dvd_survivingFiveSieveQuotient_cases_of_frozen_certificate
    (hcert : FrozenPocklingtonPrimeCertificateThirtySevenTwoThirtyNine)
    {r : ℕ} (hr : Nat.Prime r)
    (hrdvd : (r : ℤ) ∣ pellOddChebyshevQuotient 18 239) :
    r = survivingFiveSieveFactorOne ∨
      r = survivingFiveSieveFactorTwo ∨
      r = survivingFiveSieveFactorThree ∨
      r = survivingFiveSieveFactorFour := by
  rcases hcert with ⟨hprime1, hprime2, hprime3, hprime4⟩
  rw [pellOddChebyshevQuotient_eighteen_twoThirtyNine_factorization] at hrdvd
  have hrdvdNat : r ∣ survivingFiveSieveFactorOne *
      survivingFiveSieveFactorTwo * survivingFiveSieveFactorThree *
        survivingFiveSieveFactorFour := by
    exact_mod_cast hrdvd
  rcases hr.dvd_mul.mp hrdvdNat with hleft | hfour
  · rcases hr.dvd_mul.mp hleft with hleft | hthree
    · rcases hr.dvd_mul.mp hleft with hone | htwo
      · exact Or.inl <|
          ((Nat.dvd_prime hprime1).mp hone).resolve_left hr.ne_one
      · exact Or.inr <| Or.inl <|
          ((Nat.dvd_prime hprime2).mp htwo).resolve_left hr.ne_one
    · exact Or.inr <| Or.inr <| Or.inl <|
        ((Nat.dvd_prime hprime3).mp hthree).resolve_left hr.ne_one
  · exact Or.inr <| Or.inr <| Or.inr <|
      ((Nat.dvd_prime hprime4).mp hfour).resolve_left hr.ne_one

/-- There is no inert prime divisor in this quotient, even though the base
survives the modulo-five sieve, at the named frozen certificate boundary. -/
theorem no_inert_prime_dvd_survivingFiveSieveQuotient_of_frozen_certificate
    (hcert : FrozenPocklingtonPrimeCertificateThirtySevenTwoThirtyNine) :
    ¬ ∃ r : ℕ, Nat.Prime r ∧
      (r : ℤ) ∣ pellOddChebyshevQuotient 18 239 ∧
      (r % 5 = 2 ∨ r % 5 = 3) := by
  rintro ⟨r, hr, hrdvd, hinert⟩
  rcases prime_dvd_survivingFiveSieveQuotient_cases_of_frozen_certificate
      hcert hr hrdvd with rfl | rfl | rfl | rfl
  · rw [survivingFiveSieveFactorOne_mod_five] at hinert
    omega
  · rw [survivingFiveSieveFactorTwo_mod_five] at hinert
    omega
  · rw [survivingFiveSieveFactorThree_mod_five] at hinert
    omega
  · rw [survivingFiveSieveFactorFour_mod_five] at hinert
    omega

/-- Strengthened prescribed-Frobenius target including the necessary
modulo-five square-residue condition on the base. -/
def PrescribedInertPrimitiveDivisorSurvivingFiveSieveTarget
    (Primitive : ℕ → ℤ → ℕ → Prop) : Prop :=
  ∀ p : ℕ, Nat.Prime p → 37 ≤ p →
    ∀ X : ℤ, 1 < X → X % 24 = 23 →
      (X % 5 = 0 ∨ X % 5 = 1 ∨ X % 5 = 4) →
      ∃ r : ℕ, Nat.Prime r ∧
        (r : ℤ) ∣ pellOddChebyshevQuotient ((p - 1) / 2) X ∧
        Primitive p X r ∧ (r % 5 = 2 ∨ r % 5 = 3)

/-- Even the residue-restricted target is false at the named frozen exact
certificate boundary, witnessed by `(p,X)=(37,239)`. -/
theorem not_prescribedInertPrimitiveDivisorSurvivingFiveSieveTarget_of_frozen_certificate
    (hcert : FrozenPocklingtonPrimeCertificateThirtySevenTwoThirtyNine)
    (Primitive : ℕ → ℤ → ℕ → Prop) :
    ¬ PrescribedInertPrimitiveDivisorSurvivingFiveSieveTarget Primitive := by
  intro htarget
  obtain ⟨r, hr, hrdvd, _hprimitive, hinert⟩ :=
    htarget 37 thirtySeven_prime thirtySeven_atLeastThirtySeven
      239 (by norm_num) twoThirtyNine_mod_twentyFour
      (Or.inr (Or.inr twoThirtyNine_mod_five))
  rw [show ((37 : ℕ) - 1) / 2 = 18 by norm_num] at hrdvd
  exact
    no_inert_prime_dvd_survivingFiveSieveQuotient_of_frozen_certificate
      hcert ⟨r, hr, hrdvd, hinert⟩

/-! ## The example is not a shifted-square solution -/

theorem survivingFiveSieve_shiftedSquareRhs_mod_thirteen :
    (4 * pellChebyshev 37 239 + 5) % 13 = 6 := by
  rw [show (37 : ℕ) = 2 * 18 + 1 by norm_num,
    pellChebyshev_odd_eq_mul_quotient,
    pellOddChebyshevQuotient_eighteen_twoThirtyNine_factorization]
  norm_num [survivingFiveSieveFactorOne, survivingFiveSieveFactorTwo,
    survivingFiveSieveFactorThree, survivingFiveSieveFactorFour]

theorem intSquare_mod_thirteen_ne_six (y : ℤ) :
    y ^ 2 % 13 ≠ 6 := by
  intro h
  have hcast : (y : ZMod 13) ^ 2 = 6 := by
    calc
      (y : ZMod 13) ^ 2 = ((y ^ 2 : ℤ) : ZMod 13) := by norm_num
      _ = (((y ^ 2) % 13 : ℤ) : ZMod 13) :=
        (ZMod.intCast_mod (y ^ 2) 13).symm
      _ = 6 := by rw [h]; norm_num
  have hfinite : ∀ z : ZMod 13, z ^ 2 ≠ 6 := by decide
  exact hfinite y hcast

theorem survivingFiveSieve_no_global_shiftedSquare (y : ℤ) :
    y ^ 2 ≠ 4 * pellChebyshev 37 239 + 5 := by
  intro hy
  have hrem := congrArg (fun z : ℤ => z % 13) hy
  rw [survivingFiveSieve_shiftedSquareRhs_mod_thirteen] at hrem
  exact intSquare_mod_thirteen_ne_six y hrem

#print axioms pellOddChebyshevQuotient_eighteen_twoThirtyNine_factorization
#print axioms survivingFiveSieveFactors_exactlyOnce
#print axioms
  prime_dvd_survivingFiveSieveQuotient_cases_of_frozen_certificate
#print axioms
  no_inert_prime_dvd_survivingFiveSieveQuotient_of_frozen_certificate
#print axioms
  not_prescribedInertPrimitiveDivisorSurvivingFiveSieveTarget_of_frozen_certificate
#print axioms survivingFiveSieve_shiftedSquareRhs_mod_thirteen
#print axioms survivingFiveSieve_no_global_shiftedSquare

end IUTThreeClosures
