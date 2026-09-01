/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneOrderBlockAsymptotic20260901

/-!
# A nontrivial canonical Mersenne order block

The paper proof comes first in
`research/ABC_MERSENNE_PRIME_LAYER_RADICAL_2026_09_01.md`, Section 7.4.
This file formalizes its finite arithmetic conclusion.  The prime `1093`
occurs to exact depth two at its exact base-two order `364`, so the canonical
block `E_364` contains a factor `1093`.  This refutes only the universal
strengthening that every canonical block is one; a single fixed block does
not refute the asymptotic hypothesis `log E_d = o(phi(d))`.
-/

namespace IUTThreeClosures
namespace MersenneCanonicalBlockWitness20260901

open MersenneOrderBlockDecomposition20260901
open MersenneOrderBlockAsymptotic20260901

/-- The three proper-prime-quotient checks already certified in the
Wieferich barrier determine the exact order of two modulo `1093`. -/
theorem mersenneExactOrder_1093 :
    mersenneExactOrder 1093 = 364 := by
  unfold mersenneExactOrder
  apply orderOf_eq_of_pow_and_pow_div_prime (n := 364)
  · norm_num
  · apply zmod_two_pow_eq_one_of_prime_dvd_mersenne prime_1093
    exact (dvd_pow_self 1093 (n := 2) (by norm_num)).trans
      wieferich_1093_sq_dvd_two_pow_364_sub_one
  · intro p hp hpd
    have hfactor : (364 : ℕ) = 2 ^ 2 * 7 * 13 := by norm_num
    rw [hfactor] at hpd
    have hp_cases : p = 2 ∨ p = 7 ∨ p = 13 := by
      rcases hp.dvd_mul.mp hpd with hleft | h13
      · rcases hp.dvd_mul.mp hleft with htwo | h7
        · exact Or.inl <|
            (Nat.prime_dvd_prime_iff_eq hp (by decide)).mp
              (hp.dvd_of_dvd_pow htwo)
        · exact Or.inr <| Or.inl <|
            (Nat.prime_dvd_prime_iff_eq hp (by decide)).mp h7
      · exact Or.inr <| Or.inr <|
          (Nat.prime_dvd_prime_iff_eq hp (by decide)).mp h13
    rcases wieferich_1093_order_checks with ⟨h182, h52, h28⟩
    rcases hp_cases with rfl | rfl | rfl
    · intro hpow
      have hdiv : 364 / 2 = 182 := by norm_num
      rw [hdiv] at hpow
      have hcast :
          ((2 ^ 182 : ℕ) : ZMod 1093) = (1 : ZMod 1093) := by
        simpa only [Nat.cast_pow, Nat.cast_ofNat] using hpow
      have hmod :=
        (ZMod.natCast_eq_natCast_iff' (2 ^ 182) 1 1093).mp hcast
      rw [h182] at hmod
      norm_num at hmod
    · intro hpow
      have hdiv : 364 / 7 = 52 := by norm_num
      rw [hdiv] at hpow
      have hcast :
          ((2 ^ 52 : ℕ) : ZMod 1093) = (1 : ZMod 1093) := by
        simpa only [Nat.cast_pow, Nat.cast_ofNat] using hpow
      have hmod :=
        (ZMod.natCast_eq_natCast_iff' (2 ^ 52) 1 1093).mp hcast
      rw [h52] at hmod
      norm_num at hmod
    · intro hpow
      have hdiv : 364 / 13 = 28 := by norm_num
      rw [hdiv] at hpow
      have hcast :
          ((2 ^ 28 : ℕ) : ZMod 1093) = (1 : ZMod 1093) := by
        simpa only [Nat.cast_pow, Nat.cast_ofNat] using hpow
      have hmod :=
        (ZMod.natCast_eq_natCast_iff' (2 ^ 28) 1 1093).mp hcast
      rw [h28] at hmod
      norm_num at hmod

/-- The factor at `1093` has exact exponent two in `2^364 - 1`. -/
theorem factorization_mersenne_364_at_1093 :
    (2 ^ 364 - 1).factorization 1093 = 2 := by
  have hn : 2 ^ 364 - 1 ≠ 0 :=
    (mersenne_sub_one_pos (by norm_num : 0 < 364)).ne'
  have hge : 2 ≤ (2 ^ 364 - 1).factorization 1093 :=
    (prime_1093.pow_dvd_iff_le_factorization hn).mp
      wieferich_1093_sq_dvd_two_pow_364_sub_one
  have hlt : (2 ^ 364 - 1).factorization 1093 < 3 := by
    apply Nat.lt_of_not_ge
    intro hgeThree
    exact wieferich_1093_cube_not_dvd_two_pow_364_sub_one
      ((prime_1093.pow_dvd_iff_le_factorization hn).mpr hgeThree)
  omega

set_option maxRecDepth 4000 in
/-- The canonical exact-order block at `364` contains the factor `1093`. -/
theorem prime_1093_dvd_mersenneCanonicalOrderBlock_364 :
    1093 ∣ mersenneCanonicalOrderBlock 364 := by
  classical
  have hn : 2 ^ 364 - 1 ≠ 0 :=
    (mersenne_sub_one_pos (by norm_num : 0 < 364)).ne'
  have hpDvd : 1093 ∣ 2 ^ 364 - 1 :=
    (dvd_pow_self 1093 (n := 2) (by norm_num)).trans
      wieferich_1093_sq_dvd_two_pow_364_sub_one
  have hpMem : 1093 ∈ (2 ^ 364 - 1).primeFactors :=
    Nat.mem_primeFactors.mpr ⟨prime_1093, hpDvd, hn⟩
  have hpFiber :
      1093 ∈ (2 ^ 364 - 1).primeFactors.filter
        (fun p => mersenneExactOrder p = 364) :=
    Finset.mem_filter.mpr ⟨hpMem, mersenneExactOrder_1093⟩
  have hterm :
      1093 ^ ((2 ^ 364 - 1).factorization 1093 - 1) ∣
        mersenneCanonicalOrderBlock 364 := by
    unfold mersenneCanonicalOrderBlock
    exact Finset.dvd_prod_of_mem
      (fun p => p ^ ((2 ^ 364 - 1).factorization p - 1)) hpFiber
  rw [factorization_mersenne_364_at_1093] at hterm
  norm_num at hterm
  exact hterm

/-- In particular, the canonical block `E_364` is genuinely nontrivial. -/
theorem one_lt_mersenneCanonicalOrderBlock_364 :
    1 < mersenneCanonicalOrderBlock 364 := by
  have hle : 1093 ≤ mersenneCanonicalOrderBlock 364 :=
    Nat.le_of_dvd (mersenneCanonicalOrderBlock_pos 364)
      prime_1093_dvd_mersenneCanonicalOrderBlock_364
  omega

/-- The fully quantified strengthening asserting that every canonical block
is one is false. -/
theorem not_all_mersenneCanonicalOrderBlock_eq_one :
    ¬ ∀ d : ℕ, mersenneCanonicalOrderBlock d = 1 := by
  intro hall
  have h := one_lt_mersenneCanonicalOrderBlock_364
  rw [hall 364] at h
  omega

#print axioms mersenneExactOrder_1093
#print axioms factorization_mersenne_364_at_1093
#print axioms prime_1093_dvd_mersenneCanonicalOrderBlock_364
#print axioms one_lt_mersenneCanonicalOrderBlock_364
#print axioms not_all_mersenneCanonicalOrderBlock_eq_one

end MersenneCanonicalBlockWitness20260901
end IUTThreeClosures
