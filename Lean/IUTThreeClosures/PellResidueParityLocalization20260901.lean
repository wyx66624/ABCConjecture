/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Residue-parity localization in the balancing-Pell packet

The mathematical proofs precede this module in
`research/ABC_PELL_RESIDUE_PARITY_LOCALIZATION_2026_09_01.md`.

This file checks the elementary core of that note:

* the integral `(1 + sqrt 2)^n` recurrence and its negative-Pell norm;
* the exact eight-step formula and the four odd residue classes modulo eight;
* extraction of an odd, hence depth-at-least-three, exponent from a product
  in a nontrivial involution class;
* explicit factor-list packet theorems for both forced residues and the
  cross-channel negative sign;
* a combined prime-index-eleven certificate for the overstrong all-pairs
  nonresidue claim, including prime-index status, the global character, the
  actual Pell coordinates, exponent-one factors, and both cross symbols.

No assertion about the existence of a squarefull Pell packet or about the abc
conjecture is assumed.
-/

namespace IUTThreeClosures
namespace PellResidueParityLocalization20260901

/-! ## The integral unit orbit -/

/-- Integral coordinates of `(1 + sqrt 2)^n`. -/
def pellUnitPair : ℕ → ℤ × ℤ
  | 0 => (1, 0)
  | n + 1 =>
      ((pellUnitPair n).1 + 2 * (pellUnitPair n).2,
        (pellUnitPair n).1 + (pellUnitPair n).2)

@[simp] theorem pellUnitPair_zero : pellUnitPair 0 = (1, 0) := rfl

@[simp] theorem pellUnitPair_succ (n : ℕ) :
    pellUnitPair (n + 1) =
      ((pellUnitPair n).1 + 2 * (pellUnitPair n).2,
        (pellUnitPair n).1 + (pellUnitPair n).2) := rfl

/-- The recurrence preserves the alternating norm exactly. -/
theorem pellUnitPair_norm (n : ℕ) :
    (pellUnitPair n).1 ^ 2 - 2 * (pellUnitPair n).2 ^ 2 = (-1 : ℤ) ^ n := by
  induction n with
  | zero => norm_num [pellUnitPair]
  | succ n ih =>
      rw [pellUnitPair_succ]
      dsimp only
      calc
        ((pellUnitPair n).1 + 2 * (pellUnitPair n).2) ^ 2 -
              2 * ((pellUnitPair n).1 + (pellUnitPair n).2) ^ 2 =
            -((pellUnitPair n).1 ^ 2 - 2 * (pellUnitPair n).2 ^ 2) := by ring
        _ = -((-1 : ℤ) ^ n) := by rw [ih]
        _ = (-1 : ℤ) ^ (n + 1) := by rw [pow_succ]; ring

/-- Eight recurrence steps are multiplication by `577 + 408 * sqrt 2`. -/
theorem pellUnitPair_add_eight (n : ℕ) :
    pellUnitPair (n + 8) =
      (577 * (pellUnitPair n).1 + 816 * (pellUnitPair n).2,
        408 * (pellUnitPair n).1 + 577 * (pellUnitPair n).2) := by
  simp only [pellUnitPair]
  apply Prod.ext <;> dsimp only <;> ring

/-- The first coordinate is periodic modulo eight. -/
theorem pellUnitPair_fst_add_eight_modEq (n : ℕ) :
    (pellUnitPair (n + 8)).1 ≡ (pellUnitPair n).1 [ZMOD 8] := by
  rw [pellUnitPair_add_eight]
  apply Int.modEq_of_dvd
  refine ⟨-(72 * (pellUnitPair n).1 + 102 * (pellUnitPair n).2), ?_⟩
  ring

/-- The second coordinate is periodic modulo eight. -/
theorem pellUnitPair_snd_add_eight_modEq (n : ℕ) :
    (pellUnitPair (n + 8)).2 ≡ (pellUnitPair n).2 [ZMOD 8] := by
  rw [pellUnitPair_add_eight]
  apply Int.modEq_of_dvd
  refine ⟨-(51 * (pellUnitPair n).1 + 72 * (pellUnitPair n).2), ?_⟩
  ring

theorem pellUnitPair_fst_eight_mul_add_modEq (k r : ℕ) :
    (pellUnitPair (8 * k + r)).1 ≡ (pellUnitPair r).1 [ZMOD 8] := by
  induction k with
  | zero => simp
  | succ k ih =>
      have hstep := pellUnitPair_fst_add_eight_modEq (8 * k + r)
      have hindex : 8 * (k + 1) + r = (8 * k + r) + 8 := by omega
      rw [hindex]
      exact hstep.trans ih

theorem pellUnitPair_snd_eight_mul_add_modEq (k r : ℕ) :
    (pellUnitPair (8 * k + r)).2 ≡ (pellUnitPair r).2 [ZMOD 8] := by
  induction k with
  | zero => simp
  | succ k ih =>
      have hstep := pellUnitPair_snd_add_eight_modEq (8 * k + r)
      have hindex : 8 * (k + 1) + r = (8 * k + r) + 8 := by omega
      rw [hindex]
      exact hstep.trans ih

/-- The four odd residue classes of the first coordinate. -/
theorem pellUnitPair_fst_odd_residues (k : ℕ) :
    (pellUnitPair (8 * k + 1)).1 ≡ 1 [ZMOD 8] ∧
    (pellUnitPair (8 * k + 3)).1 ≡ 7 [ZMOD 8] ∧
    (pellUnitPair (8 * k + 5)).1 ≡ 1 [ZMOD 8] ∧
    (pellUnitPair (8 * k + 7)).1 ≡ 7 [ZMOD 8] := by
  constructor
  · exact (pellUnitPair_fst_eight_mul_add_modEq k 1).trans (by norm_num [pellUnitPair])
  constructor
  · exact (pellUnitPair_fst_eight_mul_add_modEq k 3).trans (by norm_num [pellUnitPair])
  constructor
  · exact (pellUnitPair_fst_eight_mul_add_modEq k 5).trans (by norm_num [pellUnitPair])
  · exact (pellUnitPair_fst_eight_mul_add_modEq k 7).trans (by norm_num [pellUnitPair])

/-- The four odd residue classes of the second coordinate. -/
theorem pellUnitPair_snd_odd_residues (k : ℕ) :
    (pellUnitPair (8 * k + 1)).2 ≡ 1 [ZMOD 8] ∧
    (pellUnitPair (8 * k + 3)).2 ≡ 5 [ZMOD 8] ∧
    (pellUnitPair (8 * k + 5)).2 ≡ 5 [ZMOD 8] ∧
    (pellUnitPair (8 * k + 7)).2 ≡ 1 [ZMOD 8] := by
  constructor
  · exact (pellUnitPair_snd_eight_mul_add_modEq k 1).trans (by norm_num [pellUnitPair])
  constructor
  · exact (pellUnitPair_snd_eight_mul_add_modEq k 3).trans (by norm_num [pellUnitPair])
  constructor
  · exact (pellUnitPair_snd_eight_mul_add_modEq k 5).trans (by norm_num [pellUnitPair])
  · exact (pellUnitPair_snd_eight_mul_add_modEq k 7).trans (by norm_num [pellUnitPair])

/-! ## The abstract parity-extraction mechanism -/

/-- If a finite product of powers in `{1, rho}` is the nontrivial
involution `rho`, at least one occurrence of `rho` has odd exponent. -/
theorem exists_odd_rho_of_product
    {G : Type*} [CommMonoid G]
    (rho : G) (hrho : rho ^ 2 = 1) (hrho_ne : rho ≠ 1)
    (xs : List (G × ℕ))
    (hclass : ∀ z ∈ xs, z.1 = 1 ∨ z.1 = rho)
    (hprod : (xs.map fun z => z.1 ^ z.2).prod = rho) :
    ∃ z ∈ xs, z.1 = rho ∧ Odd z.2 := by
  by_contra hnone
  have hno : ∀ z ∈ xs, z.1 = rho → ¬ Odd z.2 := by
    intro z hz hzr hodd
    exact hnone ⟨z, hz, hzr, hodd⟩
  have hterm : ∀ z ∈ xs, z.1 ^ z.2 = 1 := by
    intro z hz
    rcases hclass z hz with hOne | hRho
    · simp [hOne]
    · rcases Nat.even_or_odd z.2 with hEven | hOdd
      · rcases hEven with ⟨j, hj⟩
        rw [hRho, hj, pow_add]
        calc
          rho ^ j * rho ^ j = (rho * rho) ^ j := (mul_pow rho rho j).symm
          _ = (rho ^ 2) ^ j := by rw [pow_two]
          _ = 1 := by rw [hrho]; simp
      · exact False.elim ((hno z hz hRho) hOdd)
  have hall : (xs.map fun z => z.1 ^ z.2).prod = 1 := by
    apply List.prod_eq_one
    intro y hy
    rcases List.mem_map.mp hy with ⟨z, hz, rfl⟩
    exact hterm z hz
  apply hrho_ne
  calc
    rho = (xs.map fun z => z.1 ^ z.2).prod := hprod.symm
    _ = 1 := hall

/-- Under squarefull exponents, the extracted odd exponent is at least three. -/
theorem exists_depth_three_rho_of_product
    {G : Type*} [CommMonoid G]
    (rho : G) (hrho : rho ^ 2 = 1) (hrho_ne : rho ≠ 1)
    (xs : List (G × ℕ))
    (hclass : ∀ z ∈ xs, z.1 = 1 ∨ z.1 = rho)
    (hfull : ∀ z ∈ xs, 2 ≤ z.2)
    (hprod : (xs.map fun z => z.1 ^ z.2).prod = rho) :
    ∃ z ∈ xs, z.1 = rho ∧ Odd z.2 ∧ 3 ≤ z.2 := by
  rcases exists_odd_rho_of_product rho hrho hrho_ne xs hclass hprod with
    ⟨z, hz, hzr, hodd⟩
  refine ⟨z, hz, hzr, hodd, ?_⟩
  have htwo := hfull z hz
  rcases hodd with ⟨j, hj⟩
  omega

/-- The `7 mod 8` specialization used by the `A` channel. -/
theorem zmodEight_exists_depth_three_seven
    (xs : List (ZMod 8 × ℕ))
    (hclass : ∀ z ∈ xs, z.1 = 1 ∨ z.1 = 7)
    (hfull : ∀ z ∈ xs, 2 ≤ z.2)
    (hprod : (xs.map fun z => z.1 ^ z.2).prod = 7) :
    ∃ z ∈ xs, z.1 = 7 ∧ Odd z.2 ∧ 3 ≤ z.2 := by
  exact exists_depth_three_rho_of_product (7 : ZMod 8)
    (by decide) (by decide) xs hclass hfull hprod

/-- The `5 mod 8` specialization used by the `B` channel. -/
theorem zmodEight_exists_depth_three_five
    (xs : List (ZMod 8 × ℕ))
    (hclass : ∀ z ∈ xs, z.1 = 1 ∨ z.1 = 5)
    (hfull : ∀ z ∈ xs, 2 ≤ z.2)
    (hprod : (xs.map fun z => z.1 ^ z.2).prod = 5) :
    ∃ z ∈ xs, z.1 = 5 ∧ Odd z.2 ∧ 3 ≤ z.2 := by
  exact exists_depth_three_rho_of_product (5 : ZMod 8)
    (by decide) (by decide) xs hclass hfull hprod

/-! ### The explicit two-channel factor-list interface

The following records do not assert that a supplied list is a complete
factorization of a particular Pell coordinate.  That arithmetic
specialization is proved in the mathematical note.  They package exactly the
finite-list hypotheses used after a complete factorization has been supplied:
primality of each base, the permitted residue classes, and squarefull
exponents. -/

/-- One prime and its positive factorization exponent. -/
structure PellPrimeExponent where
  p : ℕ
  exponent : ℕ
  isPrime : Nat.Prime p

/-- Reduce a prime-exponent list to the residue-exponent list consumed by the
involution lemma. -/
def residueExponentList (xs : List PellPrimeExponent) :
    List (ZMod 8 × ℕ) :=
  xs.map fun z => ((z.p : ZMod 8), z.exponent)

/-- The finite factor-list data needed for the two residue channels.  In the
actual Pell specialization, `aFactors` and `bFactors` are the complete prime
factorizations of `A_ell` and `B_ell`. -/
structure ResidueFactorListPacket where
  aFactors : List PellPrimeExponent
  bFactors : List PellPrimeExponent
  aAllowed : ∀ z ∈ aFactors,
    (z.p : ZMod 8) = 1 ∨ (z.p : ZMod 8) = 7
  bAllowed : ∀ z ∈ bFactors,
    (z.p : ZMod 8) = 1 ∨ (z.p : ZMod 8) = 5
  aSquarefull : ∀ z ∈ aFactors, 2 ≤ z.exponent
  bSquarefull : ∀ z ∈ bFactors, 2 ≤ z.exponent

/-- The `A` half of the forced-residue theorem at the factor-list interface.
The total-residue hypothesis is supplied by the mod-eight Pell orbit for
indices congruent to `3` or `7`. -/
theorem ResidueFactorListPacket.existsASevenDepthThree
    (P : ResidueFactorListPacket)
    (hprod : (residueExponentList P.aFactors |>.map
      fun z => z.1 ^ z.2).prod = 7) :
    ∃ z ∈ P.aFactors,
      (z.p : ZMod 8) = 7 ∧ Odd z.exponent ∧ 3 ≤ z.exponent := by
  have hclass : ∀ w ∈ residueExponentList P.aFactors,
      w.1 = 1 ∨ w.1 = 7 := by
    intro w hw
    rcases List.mem_map.mp hw with ⟨z, hz, rfl⟩
    exact P.aAllowed z hz
  have hfull : ∀ w ∈ residueExponentList P.aFactors, 2 ≤ w.2 := by
    intro w hw
    rcases List.mem_map.mp hw with ⟨z, hz, rfl⟩
    exact P.aSquarefull z hz
  rcases zmodEight_exists_depth_three_seven
      (residueExponentList P.aFactors) hclass hfull hprod with
    ⟨w, hw, hseven, hodd, hthree⟩
  rcases List.mem_map.mp hw with ⟨z, hz, rfl⟩
  exact ⟨z, hz, hseven, hodd, hthree⟩

/-- The `B` half of the forced-residue theorem at the factor-list interface.
The total-residue hypothesis is supplied by the mod-eight Pell orbit for
indices congruent to `3` or `5`. -/
theorem ResidueFactorListPacket.existsBFiveDepthThree
    (P : ResidueFactorListPacket)
    (hprod : (residueExponentList P.bFactors |>.map
      fun z => z.1 ^ z.2).prod = 5) :
    ∃ z ∈ P.bFactors,
      (z.p : ZMod 8) = 5 ∧ Odd z.exponent ∧ 3 ≤ z.exponent := by
  have hclass : ∀ w ∈ residueExponentList P.bFactors,
      w.1 = 1 ∨ w.1 = 5 := by
    intro w hw
    rcases List.mem_map.mp hw with ⟨z, hz, rfl⟩
    exact P.bAllowed z hz
  have hfull : ∀ w ∈ residueExponentList P.bFactors, 2 ≤ w.2 := by
    intro w hw
    rcases List.mem_map.mp hw with ⟨z, hz, rfl⟩
    exact P.bSquarefull z hz
  rcases zmodEight_exists_depth_three_five
      (residueExponentList P.bFactors) hclass hfull hprod with
    ⟨w, hw, hfive, hodd, hthree⟩
  rcases List.mem_map.mp hw with ⟨z, hz, rfl⟩
  exact ⟨z, hz, hfive, hodd, hthree⟩

/-- Direct factor-list counterpart of the two implications in the
forced-residue depth-three theorem. -/
theorem factorListPacket_forcedResidueDepthThree
    (P : ResidueFactorListPacket) :
    ((residueExponentList P.aFactors |>.map
        fun z => z.1 ^ z.2).prod = 7 →
      ∃ z ∈ P.aFactors,
        (z.p : ZMod 8) = 7 ∧ Odd z.exponent ∧ 3 ≤ z.exponent) ∧
    ((residueExponentList P.bFactors |>.map
        fun z => z.1 ^ z.2).prod = 5 →
      ∃ z ∈ P.bFactors,
        (z.p : ZMod 8) = 5 ∧ Odd z.exponent ∧ 3 ≤ z.exponent) := by
  exact ⟨P.existsASevenDepthThree, P.existsBFiveDepthThree⟩

/-- A finite product of signs equal to `-1` contains a negative sign. -/
theorem exists_neg_one_of_sign_product
    (xs : List ℤ)
    (hsign : ∀ x ∈ xs, x = 1 ∨ x = -1)
    (hprod : xs.prod = -1) :
    ∃ x ∈ xs, x = -1 := by
  by_contra hnone
  have hall : ∀ x ∈ xs, x = 1 := by
    intro x hx
    rcases hsign x hx with hOne | hNeg
    · exact hOne
    · exact False.elim (hnone ⟨x, hx, hNeg⟩)
  have hone : xs.prod = 1 := List.prod_eq_one hall
  omega

/-! ### The explicit cross-channel factor-list interface -/

/-- One entry of the flattened odd-support product `O_A × O_B`.  The two
primality fields ensure that the stored Legendre symbol really is attached to
a pair of primes. -/
structure CrossFactorRecord where
  q : ℕ
  r : ℕ
  qExponent : ℕ
  rExponent : ℕ
  qPrime : Nat.Prime q
  rPrime : Nat.Prime r

/-- The actual Legendre symbol attached to a cross-factor record.  The
recorded primality proof supplies the typeclass argument required by
`legendreSym`. -/
def CrossFactorRecord.character (z : CrossFactorRecord) : ℤ :=
  @legendreSym z.r ⟨z.rPrime⟩ z.q

/-- The hypotheses used after flattening the cross-character product.  The
records are precisely the pairs from the two odd-exponent supports; the
fields state oddness, squarefull lower bounds, the sign range, and the global
negative product. -/
structure CrossFactorListPacket where
  records : List CrossFactorRecord
  qOdd : ∀ z ∈ records, Odd z.qExponent
  rOdd : ∀ z ∈ records, Odd z.rExponent
  qSquarefull : ∀ z ∈ records, 2 ≤ z.qExponent
  rSquarefull : ∀ z ∈ records, 2 ≤ z.rExponent
  signRange : ∀ z ∈ records,
    z.character = 1 ∨ z.character = -1
  signProduct : (records.map fun z => z.character).prod = -1

/-- Direct factor-list counterpart of the forced cross-channel nonresidue
theorem.  It combines the sign-product lemma with odd squarefull exponents. -/
theorem factorListPacket_crossChannelNonresidue
    (P : CrossFactorListPacket) :
    ∃ z ∈ P.records,
      z.character = -1 ∧
      Odd z.qExponent ∧ 3 ≤ z.qExponent ∧
      Odd z.rExponent ∧ 3 ≤ z.rExponent := by
  have hsign : ∀ s ∈ (P.records.map fun z => z.character),
      s = 1 ∨ s = -1 := by
    intro s hs
    rcases List.mem_map.mp hs with ⟨z, hz, rfl⟩
    exact P.signRange z hz
  rcases exists_neg_one_of_sign_product
      (P.records.map fun z => z.character) hsign P.signProduct with
    ⟨s, hs, hneg⟩
  rcases List.mem_map.mp hs with ⟨z, hz, rfl⟩
  have hqthree : 3 ≤ z.qExponent := by
    rcases P.qOdd z hz with ⟨j, hj⟩
    have htwo := P.qSquarefull z hz
    omega
  have hrthree : 3 ≤ z.rExponent := by
    rcases P.rOdd z hz with ⟨j, hj⟩
    have htwo := P.rSquarefull z hz
    omega
  exact ⟨z, hz, hneg, P.qOdd z hz, hqthree,
    P.rOdd z hz, hrthree⟩

/-! ## The exact index-eleven counterexample -/

theorem pellUnitPair_eleven : pellUnitPair 11 = (8119, 5741) := by
  norm_num [pellUnitPair]

theorem indexEleven_A_factorization : (8119 : ℕ) = 23 * 353 := by norm_num

theorem prime_eleven : Nat.Prime 11 := by norm_num
theorem indexEleven_odd : Odd (11 : ℕ) := by norm_num
theorem prime_twentyThree : Nat.Prime 23 := by norm_num
theorem prime_threeHundredFiftyThree : Nat.Prime 353 := by norm_num
theorem prime_fiveThousandSevenHundredFortyOne : Nat.Prime 5741 := by norm_num

local instance : Fact (Nat.Prime 11) := ⟨prime_eleven⟩
local instance : Fact (Nat.Prime 5741) := ⟨prime_fiveThousandSevenHundredFortyOne⟩

/-- A prime occurs to exponent exactly one when it divides the integer but
its square does not.  This predicate makes the odd-exponent premise in the
index-eleven counterexample explicit. -/
def HasExponentOne (p N : ℕ) : Prop :=
  Nat.Prime p ∧ p ∣ N ∧ ¬ p ^ 2 ∣ N

theorem indexEleven_twentyThree_exponentOne : HasExponentOne 23 8119 := by
  norm_num [HasExponentOne]

theorem indexEleven_threeHundredFiftyThree_exponentOne :
    HasExponentOne 353 8119 := by
  norm_num [HasExponentOne]

theorem indexEleven_fiveThousandSevenHundredFortyOne_exponentOne :
    HasExponentOne 5741 5741 := by
  norm_num [HasExponentOne]

/-- The global character at the prime index eleven is negative. -/
theorem indexEleven_global_character : legendreSym 11 2 = -1 := by
  norm_num

/-- Explicit square witness for the positive cross symbol. -/
theorem indexEleven_residue_witness :
    (252 : ZMod 5741) ^ 2 = 353 := by
  decide

/-- The small Euler-criterion computation used after reciprocity for the
negative cross symbol. -/
theorem indexEleven_nonresidue_euler_certificate :
    (14 : ZMod 23) ^ 11 = -1 := by
  decide

/-- One cross pair is a quadratic nonresidue. -/
theorem indexEleven_legendre_twentyThree : legendreSym 5741 23 = -1 := by
  norm_num

/-- The other cross pair is a quadratic residue. -/
theorem indexEleven_legendre_threeHundredFiftyThree :
    legendreSym 5741 353 = 1 := by
  norm_num

/-- The global character product remains the required negative sign. -/
theorem indexEleven_legendre_product :
    legendreSym 5741 23 * legendreSym 5741 353 = -1 := by
  norm_num

/-- Full numerical counterexample to replacing the negative character
product by the assertion that every cross pair is a nonresidue. -/
theorem indexEleven_allPairsNonresidue_counterexample :
    legendreSym 5741 23 * legendreSym 5741 353 = -1 ∧
      ¬(legendreSym 5741 23 = -1 ∧ legendreSym 5741 353 = -1) := by
  norm_num

/-- A single certificate collecting every numerical premise used to refute
the ordinary prime-index claim that all cross pairs are nonresidues.  The
two `A`-channel primes and the `B`-channel prime occur to exponent one, so
they belong to the respective odd-exponent supports.  The positive symbol
for the pair `(353, 5741)` contradicts the all-pairs conclusion, while the
global product still has the required negative sign. -/
theorem indexEleven_fullPremise_allPairsNonresidue_counterexample :
    Nat.Prime 11 ∧
      Odd (11 : ℕ) ∧
      legendreSym 11 2 = -1 ∧
      pellUnitPair 11 = (8119, 5741) ∧
      (8119 : ℕ) = 23 * 353 ∧
      HasExponentOne 23 8119 ∧
      HasExponentOne 353 8119 ∧
      HasExponentOne 5741 5741 ∧
      legendreSym 5741 23 = -1 ∧
      legendreSym 5741 353 = 1 ∧
      legendreSym 5741 23 * legendreSym 5741 353 = -1 ∧
      ¬(legendreSym 5741 23 = -1 ∧ legendreSym 5741 353 = -1) := by
  exact ⟨prime_eleven, indexEleven_odd, indexEleven_global_character,
    pellUnitPair_eleven, indexEleven_A_factorization,
    indexEleven_twentyThree_exponentOne,
    indexEleven_threeHundredFiftyThree_exponentOne,
    indexEleven_fiveThousandSevenHundredFortyOne_exponentOne,
    indexEleven_legendre_twentyThree,
    indexEleven_legendre_threeHundredFiftyThree,
    indexEleven_allPairsNonresidue_counterexample⟩

#check pellUnitPair_norm
#check pellUnitPair_add_eight
#check pellUnitPair_fst_odd_residues
#check pellUnitPair_snd_odd_residues
#check exists_odd_rho_of_product
#check exists_depth_three_rho_of_product
#check zmodEight_exists_depth_three_seven
#check zmodEight_exists_depth_three_five
#check factorListPacket_forcedResidueDepthThree
#check exists_neg_one_of_sign_product
#check factorListPacket_crossChannelNonresidue
#check pellUnitPair_eleven
#check indexEleven_global_character
#check indexEleven_residue_witness
#check indexEleven_nonresidue_euler_certificate
#check indexEleven_legendre_twentyThree
#check indexEleven_legendre_threeHundredFiftyThree
#check indexEleven_legendre_product
#check indexEleven_allPairsNonresidue_counterexample
#check indexEleven_fullPremise_allPairsNonresidue_counterexample

#print axioms pellUnitPair_norm
#print axioms pellUnitPair_add_eight
#print axioms pellUnitPair_fst_odd_residues
#print axioms pellUnitPair_snd_odd_residues
#print axioms exists_odd_rho_of_product
#print axioms exists_depth_three_rho_of_product
#print axioms zmodEight_exists_depth_three_seven
#print axioms zmodEight_exists_depth_three_five
#print axioms factorListPacket_forcedResidueDepthThree
#print axioms exists_neg_one_of_sign_product
#print axioms factorListPacket_crossChannelNonresidue
#print axioms pellUnitPair_eleven
#print axioms indexEleven_global_character
#print axioms indexEleven_residue_witness
#print axioms indexEleven_nonresidue_euler_certificate
#print axioms indexEleven_legendre_twentyThree
#print axioms indexEleven_legendre_threeHundredFiftyThree
#print axioms indexEleven_legendre_product
#print axioms indexEleven_allPairsNonresidue_counterexample
#print axioms indexEleven_fullPremise_allPairsNonresidue_counterexample

end PellResidueParityLocalization20260901
end IUTThreeClosures
