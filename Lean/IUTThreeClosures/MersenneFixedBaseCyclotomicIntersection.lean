/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneFirstOrderLiftSieve

/-!
# Prime-step cyclotomic layers at the fixed base two

This file formalizes the local multiplicity calculation used to separate
primitive Mersenne--Wieferich depth from imprimitive cyclotomic factors.

For an odd prime `p`, if `A = 1 mod p`, then

`1 + A + ... + A^(p-1)`

contains exactly one factor of `p`.  Applied to
`A = 2^(d*p^j)`, this is the quotient between two consecutive levels
`2^(d*p^j)-1` and `2^(d*p^(j+1))-1`.  Thus the new imprimitive layer carries
one radical copy of `p`, independently of the multiplicity already present
at the first order.

The file proves only this finite algebraic core.  It does not assume or prove
a cyclotomic powerful-part bound, a fixed-base distribution theorem, an
Arakelov intersection inequality, or the abc conjecture.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-! ## The prime-step geometric factor -/

/-- The geometric factor relating `A^p-1` to `A-1`. -/
def primeStepGeomFactor (A : ℤ) (p : ℕ) : ℤ :=
  ∑ i ∈ Finset.range p, A ^ i

/-- The exact geometric-factor identity. -/
theorem primeStepGeomFactor_mul_sub_one
    (A : ℤ) (p : ℕ) :
    primeStepGeomFactor A p * (A - 1) = A ^ p - 1 := by
  exact geom_sum_mul A p

/-- If an odd prime divides `A-1` but not `A`, the prime-step geometric
factor has extended multiplicity exactly one. -/
theorem emultiplicity_primeStepGeomFactor_eq_one
    (p : ℕ) (A : ℤ)
    (hp : p.Prime) (hpodd : Odd p)
    (hcong : (p : ℤ) ∣ A - 1)
    (hunit : ¬(p : ℤ) ∣ A) :
    emultiplicity (p : ℤ) (primeStepGeomFactor A p) = 1 := by
  have hpInt : Prime (p : ℤ) :=
    (Nat.prime_iff_prime_int).mp hp
  simpa [primeStepGeomFactor] using
    (emultiplicity_geom_sum₂_eq_one
      (R := ℤ) hpInt hpodd hcong hunit)

/-- Divisibility formulation of exact multiplicity one. -/
theorem prime_dvd_primeStepGeomFactor_and_square_not_dvd
    (p : ℕ) (A : ℤ)
    (hp : p.Prime) (hpodd : Odd p)
    (hcong : (p : ℤ) ∣ A - 1)
    (hunit : ¬(p : ℤ) ∣ A) :
    (p : ℤ) ∣ primeStepGeomFactor A p ∧
      ¬(p : ℤ) ^ 2 ∣ primeStepGeomFactor A p := by
  have hmult := emultiplicity_primeStepGeomFactor_eq_one
    p A hp hpodd hcong hunit
  simpa using (emultiplicity_eq_coe.mp hmult)

/-! ## Consecutive Mersenne `p`-tower layers -/

/-- The geometric quotient at the step
`d*p^j -> d*p^(j+1)` of the Mersenne tower. -/
def mersennePrimeStepFactor (p d j : ℕ) : ℤ :=
  primeStepGeomFactor ((2 : ℤ) ^ (d * p ^ j)) p

/-- The prime-step factor times the lower Mersenne value is the upper
Mersenne value. -/
theorem mersennePrimeStepFactor_mul_lower
    (p d j : ℕ) :
    mersennePrimeStepFactor p d j *
        ((2 : ℤ) ^ (d * p ^ j) - 1) =
      (2 : ℤ) ^ (d * p ^ (j + 1)) - 1 := by
  simpa [mersennePrimeStepFactor, pow_succ, pow_mul, mul_assoc] using
    (primeStepGeomFactor_mul_sub_one
      ((2 : ℤ) ^ (d * p ^ j)) p)

/-- Every imprimitive prime-tower step carries exactly one copy of the odd
prime.  The conclusion is independent of the multiplicity at the lower
order-level block. -/
theorem mersennePrimeStepFactor_exact_primeMultiplicity
    (p d j : ℕ)
    (hp : p.Prime) (hpodd : Odd p)
    (hpd : (p : ℤ) ∣ (2 : ℤ) ^ d - 1) :
    (p : ℤ) ∣ mersennePrimeStepFactor p d j ∧
      ¬(p : ℤ) ^ 2 ∣ mersennePrimeStepFactor p d j := by
  have hbaseDvd :
      (2 : ℤ) ^ d - 1 ∣ (2 : ℤ) ^ (d * p ^ j) - 1 := by
    have h := sub_dvd_pow_sub_pow ((2 : ℤ) ^ d) 1 (p ^ j)
    simpa [pow_mul] using h
  have hcong :
      (p : ℤ) ∣ (2 : ℤ) ^ (d * p ^ j) - 1 :=
    hpd.trans hbaseDvd
  have hpneTwo : p ≠ 2 := by
    intro h
    subst p
    norm_num at hpodd
  have hunitNat : ¬p ∣ 2 ^ (d * p ^ j) := by
    intro hdiv
    have hpDvdTwo : p ∣ 2 := hp.dvd_of_dvd_pow hdiv
    have hpEqTwo : p = 2 :=
      (Nat.dvd_prime Nat.prime_two).mp hpDvdTwo |>.resolve_left hp.ne_one
    exact hpneTwo hpEqTwo
  have hunitInt : ¬(p : ℤ) ∣ (2 : ℤ) ^ (d * p ^ j) := by
    exact_mod_cast hunitNat
  exact prime_dvd_primeStepGeomFactor_and_square_not_dvd
    p ((2 : ℤ) ^ (d * p ^ j)) hp hpodd hcong hunitInt

end IUTThreeClosures
