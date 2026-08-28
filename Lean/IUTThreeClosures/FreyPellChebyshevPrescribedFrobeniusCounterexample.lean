import Mathlib.Data.List.Prime
import Mathlib.NumberTheory.LucasPrimality
import IUTThreeClosures.FreyPellChebyshevOddQuotientGcdLedger
import IUTThreeClosures.FreyPellChebyshevPrimeIndexUniformGenusAudit

/-!
# A prescribed-Frobenius primitive-divisor counterexample

This file separates the cheap kernel arithmetic from one frozen exact
primality certificate.  PARI and an independent BigInt verifier checked the
partial Pocklington packet for the 83-digit Chebyshev quotient.  Lean exposes
that boundary as the transparent proposition
`FrozenPocklingtonPrimeCertificateFortyThreeFortySeven`; it is a theorem
parameter, not an axiom or hidden instance.

Conditional on that explicit certificate proposition, Lean proves that the
quotient has no prime divisor in either inert residue class modulo five and
therefore refutes the proposed uniform prescribed-Frobenius strategy.  The
Chebyshev recurrence, residue, factorization and nonsquare checks are fully
kernel-replayed and do not depend on the certificate.
-/

namespace IUTThreeClosures

theorem prime_mem_of_dvd_primeListProduct
    {r : ℕ} (hr : Nat.Prime r) (factors : List ℕ)
    (hprime : ∀ x ∈ factors, Nat.Prime x) (hdvd : r ∣ factors.prod) :
    r ∈ factors := by
  induction factors with
  | nil => simpa using (hr.not_dvd_one hdvd)
  | cons x xs ih =>
      rw [List.prod_cons] at hdvd
      rcases hr.dvd_mul.mp hdvd with hx | hxs
      · have hxprime : Nat.Prime x := hprime x (by simp)
        have hrx : r = x :=
          ((Nat.dvd_prime hxprime).mp hx).resolve_left hr.ne_one
        simp [hrx]
      · exact List.mem_cons_of_mem x
          (ih (fun y hy => hprime y (List.mem_cons_of_mem x hy)) hxs)

/-- Reusable list form of Mathlib's Lucas--Pratt primality criterion. -/
theorem lucas_primality_of_factorList
    (p a : ℕ) (factors : List ℕ)
    (hprod : factors.prod = p - 1)
    (hprime : ∀ r ∈ factors, Nat.Prime r)
    (hpow : (a : ZMod p) ^ (p - 1) = 1)
    (hnonone : ∀ r ∈ factors, (a : ZMod p) ^ ((p - 1) / r) ≠ 1) :
    Nat.Prime p := by
  apply lucas_primality p (a : ZMod p) hpow
  intro r hr hdvd
  have hdvdProd : r ∣ factors.prod := by simpa [hprod] using hdvd
  have hrmem : r ∈ factors :=
    prime_mem_of_dvd_primeListProduct hr factors hprime hdvdProd
  exact hnonone r hrmem

def prescribedFrobeniusCounterexamplePrime : ℕ :=
  74004140258268729146484924335493884636794672907656673308440413484294395629906354561

/-- Frozen exact-computation boundary for the independently verified partial
Pocklington certificate.  This definition is deliberately transparent: using
it is exactly the same as supplying the displayed primality proposition. -/
def FrozenPocklingtonPrimeCertificateFortyThreeFortySeven : Prop :=
  Nat.Prime prescribedFrobeniusCounterexamplePrime

theorem prescribedFrobeniusCounterexamplePrime_prime_of_frozen_certificate
    (hcert : FrozenPocklingtonPrimeCertificateFortyThreeFortySeven) :
    Nat.Prime prescribedFrobeniusCounterexamplePrime :=
  hcert

/-- Exact Chebyshev factorization at the counterexample base and index. -/
theorem pellChebyshev_fortyThree_fortySeven_factorization :
    pellChebyshev 43 47 =
      47 * prescribedFrobeniusCounterexamplePrime := by
  rw [show (43 : ℕ) = 2 * 21 + 1 by norm_num,
    pellChebyshev_odd_eq_mul_quotient]
  norm_num [pellOddChebyshevQuotient,
    prescribedFrobeniusCounterexamplePrime]

/-- The corresponding odd Chebyshev quotient is exactly the single integer
certified prime at the frozen boundary. -/
theorem pellOddChebyshevQuotient_twentyOne_fortySeven :
    pellOddChebyshevQuotient 21 47 =
      prescribedFrobeniusCounterexamplePrime := by
  norm_num [pellOddChebyshevQuotient, prescribedFrobeniusCounterexamplePrime]

theorem fortySeven_mod_twentyFour : 47 % 24 = 23 := by norm_num

theorem prescribedFrobeniusCounterexamplePrime_mod_five :
    prescribedFrobeniusCounterexamplePrime % 5 = 1 := by
  norm_num [prescribedFrobeniusCounterexamplePrime]

/-- At the frozen exact-primality boundary, every prime divisor is the same
split prime. -/
theorem prime_dvd_prescribedFrobeniusCounterexamplePrime_eq_of_frozen_certificate
    (hcert : FrozenPocklingtonPrimeCertificateFortyThreeFortySeven)
    {r : ℕ} (hr : Nat.Prime r)
    (hrdvd : r ∣ prescribedFrobeniusCounterexamplePrime) :
    r = prescribedFrobeniusCounterexamplePrime := by
  have hq :=
    prescribedFrobeniusCounterexamplePrime_prime_of_frozen_certificate hcert
  exact ((Nat.dvd_prime hq).mp hrdvd).resolve_left hr.ne_one

/-- There is no prime divisor of this block in either inert residue class
modulo five, conditional only on the named frozen primality certificate. -/
theorem no_inert_prime_dvd_prescribedFrobeniusCounterexamplePrime_of_frozen_certificate
    (hcert : FrozenPocklingtonPrimeCertificateFortyThreeFortySeven) :
    ¬ ∃ r : ℕ, Nat.Prime r ∧ r ∣ prescribedFrobeniusCounterexamplePrime ∧
      (r % 5 = 2 ∨ r % 5 = 3) := by
  rintro ⟨r, hr, hrdvd, hinert⟩
  rw [prime_dvd_prescribedFrobeniusCounterexamplePrime_eq_of_frozen_certificate
      hcert hr hrdvd,
    prescribedFrobeniusCounterexamplePrime_mod_five] at hinert
  omega

/-- The proposed uniform target, parameterized by any additional notion of
primitivity.  The counterexample does not inspect that predicate because the
block has no inert prime divisor at all. -/
def PrescribedInertPrimitiveDivisorTarget
    (Primitive : ℕ → ℤ → ℕ → Prop) : Prop :=
  ∀ p : ℕ, Nat.Prime p → 37 ≤ p →
    ∀ X : ℤ, 1 < X → X % 24 = 23 →
      ∃ r : ℕ, Nat.Prime r ∧
        (r : ℤ) ∣ pellOddChebyshevQuotient ((p - 1) / 2) X ∧
        Primitive p X r ∧ (r % 5 = 2 ∨ r % 5 = 3)

/-- For every primitive-divisor predicate, the target is false once the named
exact Pocklington certificate is supplied, witnessed by `(p,X)=(43,47)`. -/
theorem not_prescribedInertPrimitiveDivisorTarget_of_frozen_certificate
    (hcert : FrozenPocklingtonPrimeCertificateFortyThreeFortySeven)
    (Primitive : ℕ → ℤ → ℕ → Prop) :
    ¬ PrescribedInertPrimitiveDivisorTarget Primitive := by
  intro htarget
  obtain ⟨r, hr, hrdvd, _hprimitive, hinert⟩ :=
    htarget 43 (by norm_num) (by norm_num) 47 (by norm_num) (by norm_num)
  rw [show (43 - 1) / 2 = 21 by norm_num,
    pellOddChebyshevQuotient_twentyOne_fortySeven] at hrdvd
  have hrNat : r ∣ prescribedFrobeniusCounterexamplePrime := by
    exact_mod_cast hrdvd
  exact
    no_inert_prime_dvd_prescribedFrobeniusCounterexamplePrime_of_frozen_certificate
      hcert ⟨r, hr, hrNat, hinert⟩

/-- The strategy counterexample is not itself a shifted-square solution: its
right side is six modulo seven. -/
theorem prescribedFrobeniusCounterexample_shiftedSquareRhs_mod_seven :
    (4 * pellChebyshev 43 47 + 5) % 7 = 6 := by
  rw [pellChebyshev_fortyThree_fortySeven_factorization]
  norm_num [prescribedFrobeniusCounterexamplePrime]

theorem prescribedFrobeniusCounterexample_not_shiftedSquare :
    ∀ y : ℤ, y ^ 2 ≠ 4 * pellChebyshev 43 47 + 5 := by
  intro y hy
  have hres : y ^ 2 % 7 = 6 := by
    rw [hy, prescribedFrobeniusCounterexample_shiftedSquareRhs_mod_seven]
  have hcast : (y : ZMod 7) ^ 2 = 6 := by
    calc
      (y : ZMod 7) ^ 2 = ((y ^ 2 : ℤ) : ZMod 7) := by norm_num
      _ = (((y ^ 2) % 7 : ℤ) : ZMod 7) :=
        (ZMod.intCast_mod (y ^ 2) 7).symm
      _ = 6 := by rw [hres]; norm_num
  have hfinite : ∀ z : ZMod 7, z ^ 2 ≠ 6 := by decide
  exact hfinite y hcast

#print axioms lucas_primality_of_factorList
#print axioms prescribedFrobeniusCounterexamplePrime_prime_of_frozen_certificate
#print axioms pellChebyshev_fortyThree_fortySeven_factorization
#print axioms pellOddChebyshevQuotient_twentyOne_fortySeven
#print axioms
  prime_dvd_prescribedFrobeniusCounterexamplePrime_eq_of_frozen_certificate
#print axioms
  no_inert_prime_dvd_prescribedFrobeniusCounterexamplePrime_of_frozen_certificate
#print axioms not_prescribedInertPrimitiveDivisorTarget_of_frozen_certificate
#print axioms prescribedFrobeniusCounterexample_shiftedSquareRhs_mod_seven
#print axioms prescribedFrobeniusCounterexample_not_shiftedSquare

end IUTThreeClosures
