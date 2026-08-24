/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LegendreTwoInertiaSL2
import Mathlib.NumberTheory.PrimeFactorization

/-!
# Two canonical boundary supports of a nontrivial ABC triple

Let `a,b,c` be positive, pairwise coprime natural numbers with `a+b=c`.
The coordinate `c` is always larger than one.  Unless `a=b=1`, at least one
of `a,b` is also larger than one.  This gives two distinct Legendre boundary
directions with coprime nonunit coordinates.

For every coordinate `n>1`, choose its least prime factor and the exponent of
that prime in the canonical factorization of `n`.  We prove that this exponent
is positive and that

`2^exponent ≤ n`.

Thus every nontrivial ABC triple supplies two distinct local places and two
positive local exponent bounds of precisely the form consumed by the
sublinear two-inertia auxiliary-prime theorem.

This module is elementary number theory.  It does not yet identify the local
Galois inertia matrices with Picard--Lefschetz transvections.
-/

namespace IUTThreeClosures

open LegendreTwoInertia

namespace ABCTwoBoundarySupports

/-- The elementary positive pairwise-coprime ABC tuple. -/
structure Triple where
  a : ℕ
  b : ℕ
  c : ℕ
  a_pos : 0 < a
  b_pos : 0 < b
  c_pos : 0 < c
  sum_eq : a + b = c
  coprime_ab : Nat.Coprime a b
  coprime_ac : Nat.Coprime a c
  coprime_bc : Nat.Coprime b c

/-- Boundary coordinate corresponding to `0`, `1`, or `infinity`. -/
def boundaryValue (T : Triple) : BoundaryDirection → ℕ
  | .zero => T.a
  | .one => T.b
  | .infinity => T.c

/-- Least supporting prime of a nonunit coordinate. -/
def supportPrime (n : ℕ) : ℕ :=
  n.minFac

/-- Canonical exponent of the least supporting prime. -/
noncomputable def supportExponent (n : ℕ) : ℕ :=
  (Nat.factorization n) (supportPrime n)

/-- The least supporting factor is prime. -/
theorem supportPrime_prime
    {n : ℕ} (hn : 1 < n) :
    (supportPrime n).Prime := by
  unfold supportPrime
  exact Nat.minFac_prime (by omega)

/-- The least supporting prime divides the coordinate. -/
theorem supportPrime_dvd
    {n : ℕ} (hn : 1 < n) :
    supportPrime n ∣ n := by
  unfold supportPrime
  exact Nat.minFac_dvd n

/-- The canonical supporting exponent is positive. -/
theorem supportExponent_pos
    {n : ℕ} (hn : 1 < n) :
    0 < supportExponent n := by
  unfold supportExponent
  have hp := supportPrime_prime hn
  have hpdvd := supportPrime_dvd hn
  exact?

/-- The supporting prime power divides the coordinate. -/
theorem supportPrime_pow_supportExponent_dvd
    {n : ℕ} (hn : 1 < n) :
    supportPrime n ^ supportExponent n ∣ n := by
  unfold supportExponent
  have hn0 : n ≠ 0 := by omega
  exact?

/-- The canonical exponent satisfies the binary power bound. -/
theorem two_pow_supportExponent_le
    {n : ℕ} (hn : 1 < n) :
    2 ^ supportExponent n ≤ n := by
  have hpPrime := supportPrime_prime hn
  have hpowDiv := supportPrime_pow_supportExponent_dvd hn
  have hpowLe :
      supportPrime n ^ supportExponent n ≤ n :=
    Nat.le_of_dvd (by omega) hpowDiv
  have htwoLe :
      2 ^ supportExponent n ≤
        supportPrime n ^ supportExponent n := by
    exact Nat.pow_le_pow_left hpPrime.two_le _
  exact htwoLe.trans hpowLe

/-- Canonical local support attached to one nonunit boundary coordinate. -/
structure BoundarySupport (T : Triple) where
  direction : BoundaryDirection
  value_gt_one : 1 < boundaryValue T direction

namespace BoundarySupport

/-- Underlying coordinate. -/
def value {T : Triple} (S : BoundarySupport T) : ℕ :=
  boundaryValue T S.direction

/-- Canonical supporting prime. -/
def prime {T : Triple} (S : BoundarySupport T) : ℕ :=
  supportPrime S.value

/-- Canonical local exponent. -/
noncomputable def exponent {T : Triple} (S : BoundarySupport T) : ℕ :=
  supportExponent S.value

/-- The selected supporting prime is prime. -/
theorem prime_prime {T : Triple} (S : BoundarySupport T) :
    S.prime.Prime :=
  supportPrime_prime S.value_gt_one

/-- The selected prime divides the coordinate. -/
theorem prime_dvd_value {T : Triple} (S : BoundarySupport T) :
    S.prime ∣ S.value :=
  supportPrime_dvd S.value_gt_one

/-- The selected exponent is positive. -/
theorem exponent_pos {T : Triple} (S : BoundarySupport T) :
    0 < S.exponent :=
  supportExponent_pos S.value_gt_one

/-- Binary power bound for the selected local exponent. -/
theorem two_pow_exponent_le_value
    {T : Triple} (S : BoundarySupport T) :
    2 ^ S.exponent ≤ S.value :=
  two_pow_supportExponent_le S.value_gt_one

end BoundarySupport

/-- Two different coprime nonunit boundary supports. -/
structure TwoSupports (T : Triple) where
  first : BoundarySupport T
  second : BoundarySupport T
  directions_ne : first.direction ≠ second.direction
  values_coprime : Nat.Coprime first.value second.value

namespace TwoSupports

/-- The two selected supporting primes are distinct. -/
theorem primes_ne {T : Triple} (S : TwoSupports T) :
    S.first.prime ≠ S.second.prime := by
  intro hEq
  have hpFirst : S.first.prime ∣ S.first.value :=
    S.first.prime_dvd_value
  have hpSecond : S.first.prime ∣ S.second.value := by
    rw [hEq]
    exact S.second.prime_dvd_value
  have hpgcd :
      S.first.prime ∣ Nat.gcd S.first.value S.second.value :=
    Nat.dvd_gcd hpFirst hpSecond
  rw [S.values_coprime.gcd_eq_one] at hpgcd
  exact S.first.prime_prime.not_dvd_one hpgcd

/-- Product of the two canonical exponents is positive. -/
theorem exponent_product_pos {T : Triple} (S : TwoSupports T) :
    0 < S.first.exponent * S.second.exponent :=
  Nat.mul_pos S.first.exponent_pos S.second.exponent_pos

end TwoSupports

/-- The unique tuple with both lower coordinates equal to one. -/
theorem eq_trivial_of_a_eq_one_of_b_eq_one
    (T : Triple) (ha : T.a = 1) (hb : T.b = 1) :
    T.c = 2 := by
  omega

/-- **Every nontrivial ABC tuple has two canonical coprime boundary
supports.** -/
theorem exists_twoSupports
    (T : Triple)
    (hnontrivial : ¬ (T.a = 1 ∧ T.b = 1)) :
    Nonempty (TwoSupports T) := by
  by_cases ha : T.a = 1
  · have hb : T.b ≠ 1 := by
      intro hb
      exact hnontrivial ⟨ha, hb⟩
    have hbgt : 1 < T.b := by omega
    have hcgt : 1 < T.c := by omega
    refine ⟨{
      first := {
        direction := .one
        value_gt_one := by simpa [boundaryValue] using hbgt }
      second := {
        direction := .infinity
        value_gt_one := by simpa [boundaryValue] using hcgt }
      directions_ne := by decide
      values_coprime := by
        simpa [BoundarySupport.value, boundaryValue] using
          T.coprime_bc }⟩
  · have hagt : 1 < T.a := by omega
    have hcgt : 1 < T.c := by omega
    refine ⟨{
      first := {
        direction := .zero
        value_gt_one := by simpa [boundaryValue] using hagt }
      second := {
        direction := .infinity
        value_gt_one := by simpa [boundaryValue] using hcgt }
      directions_ne := by decide
      values_coprime := by
        simpa [BoundarySupport.value, boundaryValue] using
          T.coprime_ac }⟩

/-- The two canonical local exponents are positive and each satisfies a binary
power bound by the global maximum coordinate `c`. -/
theorem exists_two_exponents_bounded_by_c
    (T : Triple)
    (hnontrivial : ¬ (T.a = 1 ∧ T.b = 1)) :
    ∃ S : TwoSupports T,
      0 < S.first.exponent ∧
      0 < S.second.exponent ∧
      2 ^ S.first.exponent ≤ T.c ∧
      2 ^ S.second.exponent ≤ T.c := by
  let S : TwoSupports T := Classical.choice (exists_twoSupports T hnontrivial)
  refine ⟨S, S.first.exponent_pos, S.second.exponent_pos, ?_, ?_⟩
  · have hlocal := S.first.two_pow_exponent_le_value
    cases S.first.direction <;>
      simp [BoundarySupport.value, boundaryValue] at hlocal ⊢ <;>
      omega
  · have hlocal := S.second.two_pow_exponent_le_value
    cases S.second.direction <;>
      simp [BoundarySupport.value, boundaryValue] at hlocal ⊢ <;>
      omega

end ABCTwoBoundarySupports

end IUTThreeClosures
