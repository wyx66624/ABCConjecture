/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.DanilovGlobalIndexSieve20260831
import Mathlib.Data.Nat.PrimeFin

/-!
# Elementary kernel of the recursive Danilov prime-square lift

The complete mathematical proof precedes this file in
`research/ABC_DANILOV_RECURSIVE_LIFT_2026_09_01.md`.

This module formalizes the state-invariant update, the finite fixed-index
prime-support obstruction, and the explicit one-step countermodel.  It does
not assume the simple-primitive-divisor hypothesis, Carmichael's theorem, or
any global assertion that the surviving Danilov progression is empty.
-/

namespace IUTThreeClosures
namespace DanilovRecursiveLift20260901

open KFullRadicalCompression
open DanilovGlobalIndexSieve20260831
open scoped BigOperators

/-! ## The two-valued state multiplier -/

/-- If `h` is one or two and the forced residue lies in `[0,p)`, divisibility
by `p` produces a unique next multiplier, again equal to one or two. -/
theorem existsUnique_nextMultiplier
    {h rho p : ℕ} (hp : 0 < p) (hh : h = 1 ∨ h = 2)
    (hrho : rho < p) (hdvd : p ∣ h + 3 * rho) :
    ∃! h' : ℕ, (h' = 1 ∨ h' = 2) ∧ h + 3 * rho = h' * p := by
  rcases hdvd with ⟨k, hk⟩
  have hsum_pos : 0 < h + 3 * rho := by omega
  have hsum_lt : h + 3 * rho < 3 * p := by omega
  have hk_pos : 0 < k := by
    by_contra hnot
    have hk_zero : k = 0 := by omega
    subst k
    simp at hk
    omega
  have hpk_lt : p * k < p * 3 := by
    rw [hk] at hsum_lt
    simpa [Nat.mul_comm] using hsum_lt
  have hk_lt : k < 3 := (Nat.mul_lt_mul_left hp).mp hpk_lt
  have hk_cases : k = 1 ∨ k = 2 := by omega
  refine ⟨k, ⟨hk_cases, ?_⟩, ?_⟩
  · simpa [Nat.mul_comm] using hk
  · intro y hy
    exact Nat.mul_right_cancel hp
      (hy.2.symm.trans (by simpa [Nat.mul_comm] using hk))

/-- The affine index update preserves the invariant `3*T+1=h*Q`. -/
theorem stateInvariant_update
    {T Q h rho p h' : ℕ}
    (hstate : 3 * T + 1 = h * Q)
    (hlift : h + 3 * rho = h' * p) :
    3 * (T + Q * rho) + 1 = h' * (Q * p) := by
  calc
    3 * (T + Q * rho) + 1 = (3 * T + 1) + 3 * Q * rho := by ring
    _ = h * Q + 3 * Q * rho := by rw [hstate]
    _ = Q * (h + 3 * rho) := by ring
    _ = Q * (h' * p) := by rw [hlift]
    _ = h' * (Q * p) := by ring

/-- Combined recursive step: the quotient supplied by the forced residue is
unique, remains in `{1,2}`, and certifies the updated state invariant. -/
theorem existsUnique_nextStateMultiplier
    {T Q h rho p : ℕ} (hp : 0 < p) (hh : h = 1 ∨ h = 2)
    (hrho : rho < p) (hdvd : p ∣ h + 3 * rho)
    (hstate : 3 * T + 1 = h * Q) :
    ∃! h' : ℕ,
      (h' = 1 ∨ h' = 2) ∧
        h + 3 * rho = h' * p ∧
        3 * (T + Q * rho) + 1 = h' * (Q * p) := by
  obtain ⟨h', hh', huniq⟩ :=
    existsUnique_nextMultiplier hp hh hrho hdvd
  refine ⟨h', ⟨hh'.1, hh'.2, stateInvariant_update hstate hh'.2⟩, ?_⟩
  intro y hy
  exact huniq y ⟨hy.1, hy.2.1⟩

/-! ## Finite fresh-prime support at one fixed index -/

/-- A finite set of prime divisors of one nonzero natural has product dividing
that natural.  Distinctness is supplied by the `Finset` itself. -/
theorem primeFinset_product_dvd
    {S : Finset ℕ} {N : ℕ} (hN : N ≠ 0)
    (hprime : ∀ p ∈ S, p.Prime)
    (hdvd : ∀ p ∈ S, p ∣ N) :
    (∏ p ∈ S, p) ∣ N := by
  have hsubset : S ⊆ N.primeFactors := by
    intro p hpS
    exact (hprime p hpS).mem_primeFactors (hdvd p hpS) hN
  exact (Finset.prod_dvd_prod_of_subset S N.primeFactors id hsubset).trans
    (Nat.prod_primeFactors_dvd N)

/-- There cannot be more distinct prime packets at a fixed nonzero integer
than there are prime factors of that integer. -/
theorem primeFinset_card_le_primeFactors_card
    {S : Finset ℕ} {N : ℕ} (hN : N ≠ 0)
    (hprime : ∀ p ∈ S, p.Prime)
    (hdvd : ∀ p ∈ S, p ∣ N) :
    S.card ≤ N.primeFactors.card := by
  apply Finset.card_le_card
  intro p hpS
  exact (hprime p hpS).mem_primeFactors (hdvd p hpS) hN

theorem L_ne_zero (t : ℕ) : L t ≠ 0 := by
  simp [L]

/-- Fixed-index specialization used by the nested-chain contradiction. -/
theorem fixedIndex_freshPrime_card_bound
    {t : ℕ} {S : Finset ℕ}
    (hprime : ∀ p ∈ S, p.Prime)
    (hdvd : ∀ p ∈ S, p ∣ L t) :
    S.card ≤ (L t).primeFactors.card :=
  primeFinset_card_le_primeFactors_card (L_ne_zero t) hprime hdvd

/-- The finite contradiction form: no set of distinct prime packets all
dividing one fixed `L(t)` can have larger cardinality than its support. -/
theorem not_fixedIndex_more_freshPrimes_than_support
    {t : ℕ} {S : Finset ℕ}
    (hprime : ∀ p ∈ S, p.Prime)
    (hdvd : ∀ p ∈ S, p ∣ L t) :
    ¬ (L t).primeFactors.card < S.card :=
  Nat.not_lt_of_ge (fixedIndex_freshPrime_card_bound hprime hdvd)

/-! ## Explicit one-step countermodel -/

def counterUnit : Quad ℕ := ⟨9, 4⟩
def counterEta : Quad ℕ := ⟨5374978561, 2403763488⟩
def counterAlphaZero : Quad ℕ := ⟨19, 1⟩

def quadNormInt (x : Quad ℕ) : ℤ :=
  (x.re : ℤ) ^ 2 - 5 * (x.im : ℤ) ^ 2

def counterAlpha (r : ℕ) : Quad ℕ :=
  Quad.mul counterAlphaZero (Quad.pow counterEta r)

def counterL (r : ℕ) : ℕ := 2 * (counterAlpha r).re + 11
def counterK (r : ℕ) : ℕ := counterL r

theorem counterEta_eq_unit_pow : counterEta = Quad.pow counterUnit 8 := by
  norm_num [counterEta, counterUnit, Quad.pow, Quad.one, Quad.mul]

theorem counterEta_norm_one : quadNormInt counterEta = 1 := by
  norm_num [quadNormInt, counterEta]

theorem counterEta_mod49 :
    Quad.castZMod 49 counterEta = (⟨1, 35⟩ : Quad (ZMod 49)) := by
  decide

theorem counterEtaPow_mod49 (r : ℕ) :
    Quad.pow (Quad.castZMod 49 counterEta) r =
      (⟨1, (r : ZMod 49) * 35⟩ : Quad (ZMod 49)) := by
  rw [counterEta_mod49]
  apply Quad.pow_one_im_of_five_sq_eq_zero
  decide

theorem castZMod_counterAlpha (m r : ℕ) :
    Quad.castZMod m (counterAlpha r) =
      Quad.mul (Quad.castZMod m counterAlphaZero)
        (Quad.pow (Quad.castZMod m counterEta) r) := by
  simp [counterAlpha]

theorem counterL_cast49 (r : ℕ) :
    (counterL r : ZMod 49) = 7 * (r : ZMod 49) := by
  have h := congrArg Quad.re (castZMod_counterAlpha 49 r)
  have hre : ((counterAlpha r).re : ZMod 49) =
      (Quad.mul (Quad.castZMod 49 counterAlphaZero)
        (Quad.pow (Quad.castZMod 49 counterEta) r)).re := by
    simpa [Quad.castZMod] using h
  rw [counterL]
  push_cast
  rw [hre, counterEtaPow_mod49]
  change 2 * (19 * 1 + 5 * 1 * ((r : ZMod 49) * 35)) + 11 = 7 * r
  ring_nf
  rw [show (49 : ZMod 49) = 0 by decide]
  rw [show (350 : ZMod 49) = 7 by decide]
  simp

theorem counterL_modEq49 (r : ℕ) :
    counterL r ≡ 7 * r [MOD 49] := by
  apply (ZMod.natCast_eq_natCast_iff (counterL r) (7 * r) 49).1
  simpa only [Nat.cast_mul, Nat.cast_ofNat] using counterL_cast49 r

theorem counterL_zero : counterL 0 = 49 := by
  norm_num [counterL, counterAlpha, counterAlphaZero, Quad.pow, Quad.one, Quad.mul]

theorem counterSlope_mod7 : (10 * 1 * 5 : ZMod 7) = 1 := by
  decide

theorem counterSlope_mod7_ne_zero : (10 * 1 * 5 : ZMod 7) ≠ 0 := by
  decide

theorem seven_dvd_counterL (r : ℕ) : 7 ∣ counterL r := by
  have h := (counterL_modEq49 r).of_dvd (by norm_num : 7 ∣ 49)
  have hz : 7 * r ≡ 0 [MOD 7] :=
    (Nat.modEq_zero_iff_dvd).2 (Nat.dvd_mul_right 7 r)
  exact (Nat.modEq_zero_iff_dvd).1 (h.trans hz)

theorem counterParameter_mod7_of_twoFull {r : ℕ}
    (hK : IsKFull 2 (counterK r)) :
    r ≡ 0 [MOD 7] := by
  have h49 : 7 ^ 2 ∣ counterL r := by
    apply (IsKFull.iff_prime_pow_dvd hK.ne_zero).1 hK 7
    · norm_num
    · simpa [counterK] using seven_dvd_counterL r
  have hzeroL : counterL r ≡ 0 [MOD 49] := by
    simpa using (Nat.modEq_zero_iff_dvd).2 h49
  have hzeroR : 7 * r ≡ 0 [MOD 49] :=
    (counterL_modEq49 r).symm.trans hzeroL
  have hprod : 49 ∣ 7 * r := (Nat.modEq_zero_iff_dvd).1 hzeroR
  have hr : 7 ∣ r := by
    apply (Nat.mul_dvd_mul_iff_left (by norm_num : 0 < 7)).1
    norm_num
    exact hprod
  exact (Nat.modEq_zero_iff_dvd).2 hr

theorem counterK_zero_twoFull : IsKFull 2 (counterK 0) := by
  rw [counterK, counterL_zero]
  simpa using
    (PellCampanaCounterexample20260831.power_isKFull
      (x := 7) (k := 2) (by norm_num : (7 : ℕ) ≠ 0))

def counterUpdatedT : ℕ := 0
def counterUpdatedQ : ℕ := 7

theorem counterUpdated_state_values :
    counterUpdatedT = 0 + 1 * 0 ∧ counterUpdatedQ = 1 * 7 := by
  decide

/-- At the forced updated base, every prime divisor of `L(0)=49` already
divides the updated modulus `7`; hence there is no fresh successor prime. -/
theorem not_exists_fresh_prime_divisor_counterUpdated :
    ¬ ∃ q : ℕ, q.Prime ∧ q ∣ counterL counterUpdatedT ∧
      ¬ q ∣ counterUpdatedQ := by
  rintro ⟨q, hq, hqL, hfresh⟩
  apply hfresh
  have hqpow : q ∣ 7 ^ 2 := by
    simpa [counterUpdatedT, counterL_zero] using hqL
  exact hq.dvd_of_dvd_pow hqpow

#print axioms existsUnique_nextMultiplier
#print axioms stateInvariant_update
#print axioms existsUnique_nextStateMultiplier
#print axioms primeFinset_product_dvd
#print axioms fixedIndex_freshPrime_card_bound
#print axioms not_fixedIndex_more_freshPrimes_than_support
#print axioms counterEta_eq_unit_pow
#print axioms counterEta_norm_one
#print axioms counterEta_mod49
#print axioms counterL_cast49
#print axioms counterL_zero
#print axioms counterSlope_mod7_ne_zero
#print axioms counterParameter_mod7_of_twoFull
#print axioms counterK_zero_twoFull
#print axioms not_exists_fresh_prime_divisor_counterUpdated

end DanilovRecursiveLift20260901
end IUTThreeClosures
