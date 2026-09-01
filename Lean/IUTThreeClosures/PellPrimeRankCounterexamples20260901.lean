/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PellPrimeIndexDichotomy20260831

/-!
# A prime-rank repeated-value counterexample at index seven

This module formalizes the finite calculation from Section 5 of
`research/ABC_PELL_GLOBAL_PACKET_ATTACK_2026_09_01.md`.  It records that the
`B` coordinate at index
seven is `13^2`, that the corresponding balancing coordinate has exact
`13`-adic depth two, and that the associated polynomial has a nonzero formal
derivative modulo `13` despite its value being divisible by `13^2`.

The last two theorems package the calculation as an explicit existential
witness and as the negation of the proposed universal implication

`q | F(x) -> q \nmid F'(x) -> q^2 \nmid F(x)`.

No literature theorem, infinitude assertion, or statement about the abc
conjecture is used here.
-/

namespace IUTThreeClosures
namespace PellPrimeRankCounterexamples20260901

open Polynomial
open PellCampanaCounterexample20260831
open PellSquareRootDescent20260831

/-- The degree-six prime-rank polynomial at index seven. -/
noncomputable def primeRankSevenPolynomial : ℤ[X] :=
  X ^ 6 - C 5 * X ^ 4 + C 6 * X ^ 2 - C 1

/-- The square-root Pell `B` coordinate at index seven. -/
theorem sqrtTwoOrbit_seven_B : (sqrtTwoOrbit 7).2 = 169 := by
  rw [PellPrimeIndexDichotomy20260831.sqrtTwoOrbit_seven]

/-- The same coordinate is the square of the prime `13`. -/
theorem sqrtTwoOrbit_seven_B_eq_thirteen_sq :
    (sqrtTwoOrbit 7).2 = 13 ^ 2 := by
  rw [sqrtTwoOrbit_seven_B]
  norm_num

/-- The balancing coordinate `u_7` is divisible by `13^2`. -/
theorem thirteen_sq_dvd_pellOrbit_seven :
    13 ^ 2 ∣ (pellOrbit 7).2 := by
  rw [PellPrimeIndexDichotomy20260831.pellOrbit_seven_snd]
  norm_num

/-- The balancing coordinate `u_7` is not divisible by `13^3`. -/
theorem thirteen_cube_not_dvd_pellOrbit_seven :
    ¬ 13 ^ 3 ∣ (pellOrbit 7).2 := by
  rw [PellPrimeIndexDichotomy20260831.pellOrbit_seven_snd]
  norm_num

theorem seven_prime : Nat.Prime 7 := by
  norm_num

theorem thirteen_prime : Nat.Prime 13 := by
  norm_num

/-- The witness prime is the least positive representative of the
`-1 mod 2ℓ` channel at `ℓ = 7`. -/
theorem thirteen_eq_two_mul_seven_sub_one :
    13 = 2 * 7 - 1 := by
  norm_num

/-- Direct evaluation of `X^6 - 5X^4 + 6X^2 - 1` at `X = 6`. -/
theorem primeRankSevenPolynomial_eval_six :
    primeRankSevenPolynomial.eval 6 = 40391 := by
  norm_num [primeRankSevenPolynomial]

/-- The formal derivative has value `42408` at `X = 6`. -/
theorem primeRankSevenPolynomial_derivative_eval_six :
    primeRankSevenPolynomial.derivative.eval 6 = 42408 := by
  norm_num [primeRankSevenPolynomial, derivative_sub, derivative_add,
    derivative_mul, derivative_X_pow, derivative_C]

/-- The derivative value is congruent to `2`, hence nonzero, modulo `13`. -/
theorem primeRankSevenPolynomial_derivative_eval_six_mod_thirteen :
    primeRankSevenPolynomial.derivative.eval 6 % 13 = 2 := by
  rw [primeRankSevenPolynomial_derivative_eval_six]
  norm_num

theorem thirteen_dvd_primeRankSevenPolynomial_eval_six :
    (13 : ℤ) ∣ primeRankSevenPolynomial.eval 6 := by
  rw [primeRankSevenPolynomial_eval_six]
  norm_num

theorem thirteen_not_dvd_primeRankSevenPolynomial_derivative_eval_six :
    ¬ (13 : ℤ) ∣ primeRankSevenPolynomial.derivative.eval 6 := by
  rw [primeRankSevenPolynomial_derivative_eval_six]
  norm_num

theorem thirteen_sq_dvd_primeRankSevenPolynomial_eval_six :
    (13 : ℤ) ^ 2 ∣ primeRankSevenPolynomial.eval 6 := by
  rw [primeRankSevenPolynomial_eval_six]
  norm_num

/-- The polynomial value is exactly the integer cast of the balancing
coordinate `u_7`. -/
theorem primeRankSevenPolynomial_eval_six_eq_pellOrbit_seven :
    primeRankSevenPolynomial.eval 6 = ((pellOrbit 7).2 : ℤ) := by
  rw [primeRankSevenPolynomial_eval_six,
    PellPrimeIndexDichotomy20260831.pellOrbit_seven_snd]
  norm_num

/-- An explicit prime, polynomial, and integer point at which the value has
depth at least two although the derivative is nonzero modulo that prime. -/
theorem exists_prime_repeated_value_with_nonsingular_derivative :
    ∃ (F : ℤ[X]) (q : ℕ) (x : ℤ),
      q.Prime ∧
      (q : ℤ) ∣ F.eval x ∧
      ¬ (q : ℤ) ∣ F.derivative.eval x ∧
      (q : ℤ) ^ 2 ∣ F.eval x := by
  exact ⟨primeRankSevenPolynomial, 13, 6, thirteen_prime,
    thirteen_dvd_primeRankSevenPolynomial_eval_six,
    thirteen_not_dvd_primeRankSevenPolynomial_derivative_eval_six,
    thirteen_sq_dvd_primeRankSevenPolynomial_eval_six⟩

/-- Therefore nonvanishing of the derivative modulo a prime does not, for a
fixed integer lift `x`, force the polynomial value to have exact prime depth
one. -/
theorem not_derivative_nonzero_forces_prime_square_not_dvd :
    ¬ (∀ (F : ℤ[X]) (q : ℕ) (x : ℤ),
      q.Prime →
      (q : ℤ) ∣ F.eval x →
      ¬ (q : ℤ) ∣ F.derivative.eval x →
      ¬ (q : ℤ) ^ 2 ∣ F.eval x) := by
  intro h
  exact h primeRankSevenPolynomial 13 6 thirteen_prime
    thirteen_dvd_primeRankSevenPolynomial_eval_six
    thirteen_not_dvd_primeRankSevenPolynomial_derivative_eval_six
    thirteen_sq_dvd_primeRankSevenPolynomial_eval_six

/-! ## Counterexamples exposed by the Fellini--Murty source-proof audit -/

/-- At `x=2,p=3,f=2,i=1`, the printed cyclotomic quotient identity in the
second case of Lemma 6.4 has values `Phi_6(2)=3` and `21` on its two sides. -/
theorem printed_cyclotomic_quotient_counterexample_values :
    2 ^ 2 - 2 + 1 = 3 ∧
      (2 ^ 6 - 1) / (2 ^ 2 - 1) = 21 := by
  norm_num

/-- Hence the displayed intermediate equality used in that printed proof is
false.  This statement does not deny the repairable valuation conclusion. -/
theorem not_printed_cyclotomic_quotient_identity :
    ¬ (2 ^ 2 - 2 + 1 = (2 ^ 6 - 1) / (2 ^ 2 - 1)) := by
  norm_num

/-- The order-one exceptional case at a prime index is real: `3` divides
`Phi_3(4)=21` while the base is one modulo `3`.  It is precisely excluded by
the `(x-1)` condition in the repaired argument. -/
theorem prime_index_order_one_exception_values :
    4 ^ 2 + 4 + 1 = 21 ∧ 3 ∣ 21 ∧ 4 % 3 = 1 := by
  norm_num

#check sqrtTwoOrbit_seven_B_eq_thirteen_sq
#check thirteen_sq_dvd_pellOrbit_seven
#check thirteen_cube_not_dvd_pellOrbit_seven
#check seven_prime
#check thirteen_prime
#check thirteen_eq_two_mul_seven_sub_one
#check primeRankSevenPolynomial_eval_six
#check primeRankSevenPolynomial_derivative_eval_six
#check primeRankSevenPolynomial_derivative_eval_six_mod_thirteen
#check exists_prime_repeated_value_with_nonsingular_derivative
#check not_derivative_nonzero_forces_prime_square_not_dvd
#check printed_cyclotomic_quotient_counterexample_values
#check not_printed_cyclotomic_quotient_identity
#check prime_index_order_one_exception_values

#print axioms sqrtTwoOrbit_seven_B_eq_thirteen_sq
#print axioms thirteen_sq_dvd_pellOrbit_seven
#print axioms thirteen_cube_not_dvd_pellOrbit_seven
#print axioms seven_prime
#print axioms thirteen_prime
#print axioms thirteen_eq_two_mul_seven_sub_one
#print axioms primeRankSevenPolynomial_eval_six
#print axioms primeRankSevenPolynomial_derivative_eval_six
#print axioms primeRankSevenPolynomial_derivative_eval_six_mod_thirteen
#print axioms exists_prime_repeated_value_with_nonsingular_derivative
#print axioms not_derivative_nonzero_forces_prime_square_not_dvd
#print axioms printed_cyclotomic_quotient_counterexample_values
#print axioms not_printed_cyclotomic_quotient_identity
#print axioms prime_index_order_one_exception_values

end PellPrimeRankCounterexamples20260901
end IUTThreeClosures
