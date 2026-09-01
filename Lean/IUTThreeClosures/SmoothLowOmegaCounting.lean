/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Finite counting of smooth integers with few distinct prime factors

The paper proof was established first in
`research/ANALYTIC_ROUTE_SESSION_2026_08_30.md`, Theorem 2.1.

Positive integers `n ≤ N` with every prime divisor at most `Y` and at most
`w` distinct prime divisors admit a length-`w` prime-power encoding. Every
exponent is at most `Nat.log 2 N`, and the encoding alphabet has cardinality
at most `1 + Y * Nat.log 2 N`. Hence their number is at most
`(1 + Y * Nat.log 2 N) ^ w`.

This is a theorem about actual natural-number prime factorizations. The
encoding is constructed in the proof, not supplied as an assumption.
No analytic counting theorem or abc statement is axiomatized here.
-/

namespace IUTThreeClosures
namespace SmoothLowOmegaCounting

open scoped BigOperators

/-- Products of exactly `w` letters from a finite alphabet. -/
def wordProducts (alphabet : Finset ℕ) : ℕ → Finset ℕ
  | 0 => {1}
  | w + 1 =>
      (alphabet ×ˢ wordProducts alphabet w).image (fun z => z.1 * z.2)

theorem mul_mem_wordProducts {alphabet : Finset ℕ} {w a b : ℕ}
    (ha : a ∈ alphabet) (hb : b ∈ wordProducts alphabet w) :
    a * b ∈ wordProducts alphabet (w + 1) := by
  exact Finset.mem_image.mpr ⟨(a, b), Finset.mem_product.mpr ⟨ha, hb⟩, rfl⟩

/-- Padding by `1` gives a word of every length. -/
theorem one_mem_wordProducts {alphabet : Finset ℕ} (hone : 1 ∈ alphabet)
    (w : ℕ) : 1 ∈ wordProducts alphabet w := by
  induction w with
  | zero => simp [wordProducts]
  | succ w ih => simpa using mul_mem_wordProducts hone ih

/-- The product of at most `w` alphabet letters is a product of exactly `w`
letters when the alphabet contains `1`. -/
theorem finset_prod_mem_wordProducts {α : Type*}
    (s : Finset α) (f : α → ℕ) {alphabet : Finset ℕ}
    (hone : 1 ∈ alphabet) {w : ℕ} (hcard : s.card ≤ w)
    (hmem : ∀ a ∈ s, f a ∈ alphabet) :
    (∏ a ∈ s, f a) ∈ wordProducts alphabet w := by
  classical
  induction s using Finset.induction_on generalizing w with
  | empty => simpa using one_mem_wordProducts hone w
  | @insert a s ha ih =>
      cases w with
      | zero => simp [Finset.card_insert_of_notMem ha] at hcard
      | succ w =>
          rw [Finset.prod_insert ha]
          apply mul_mem_wordProducts (hmem a (Finset.mem_insert_self a s))
          apply ih
          · simpa [Finset.card_insert_of_notMem ha] using hcard
          · intro b hb
            exact hmem b (Finset.mem_insert_of_mem hb)

/-- Taking products can only reduce the number of words. -/
theorem wordProducts_card_le (alphabet : Finset ℕ) (w : ℕ) :
    (wordProducts alphabet w).card ≤ alphabet.card ^ w := by
  induction w with
  | zero => simp [wordProducts]
  | succ w ih =>
      calc
        (wordProducts alphabet (w + 1)).card
            ≤ (alphabet ×ˢ wordProducts alphabet w).card :=
          Finset.card_image_le
        _ = alphabet.card * (wordProducts alphabet w).card :=
          Finset.card_product _ _
        _ ≤ alphabet.card * alphabet.card ^ w := Nat.mul_le_mul_left _ ih
        _ = alphabet.card ^ (w + 1) := by rw [pow_succ'];

/-- A deliberately overcounted alphabet containing `1` and each `p^e` with
`1 ≤ p ≤ Y` and `1 ≤ e ≤ L`. Primality is not needed for its cardinality. -/
def primePowerAlphabet (Y L : ℕ) : Finset ℕ :=
  insert 1 ((Finset.range Y ×ˢ Finset.range L).image
    (fun z => (z.1 + 1) ^ (z.2 + 1)))

theorem one_mem_primePowerAlphabet (Y L : ℕ) :
    1 ∈ primePowerAlphabet Y L := Finset.mem_insert_self _ _

theorem pow_mem_primePowerAlphabet {Y L p e : ℕ}
    (hp : 0 < p) (hpY : p ≤ Y) (he : 0 < e) (heL : e ≤ L) :
    p ^ e ∈ primePowerAlphabet Y L := by
  apply Finset.mem_insert_of_mem
  apply Finset.mem_image.mpr
  refine ⟨(p - 1, e - 1), ?_, ?_⟩
  · simp only [Finset.mem_product, Finset.mem_range]
    omega
  · simp only [Nat.sub_add_cancel (by omega : 1 ≤ p),
      Nat.sub_add_cancel (by omega : 1 ≤ e)]

theorem primePowerAlphabet_card_le (Y L : ℕ) :
    (primePowerAlphabet Y L).card ≤ 1 + Y * L := by
  calc
    (primePowerAlphabet Y L).card
        ≤ ((Finset.range Y ×ˢ Finset.range L).image
          (fun z => (z.1 + 1) ^ (z.2 + 1))).card + 1 :=
      Finset.card_insert_le _ _
    _ ≤ (Finset.range Y ×ˢ Finset.range L).card + 1 :=
      Nat.add_le_add_right Finset.card_image_le 1
    _ = 1 + Y * L := by simp [Nat.add_comm]

/-- The exponent of any prime factor of a positive `n ≤ N` is at most
the integer base-two logarithm of `N`. -/
theorem factorization_le_log_two {n N p : ℕ}
    (hn : 0 < n) (hnN : n ≤ N) (hp : p.Prime) :
    n.factorization p ≤ Nat.log 2 N := by
  apply Nat.le_log_of_pow_le (by decide : 1 < (2 : ℕ))
  have hdvd : p ^ n.factorization p ∣ n :=
    (hp.pow_dvd_iff_le_factorization hn.ne').mpr le_rfl
  calc
    2 ^ n.factorization p ≤ p ^ n.factorization p :=
      Nat.pow_le_pow_left hp.two_le _
    _ ≤ n := Nat.le_of_dvd hn hdvd
    _ ≤ N := hnN

/-- Every actual smooth low-omega integer belongs to the finite word-product
set: prime powers come from its actual unique factorization. -/
theorem mem_wordProducts_of_smooth_lowOmega {n N Y w : ℕ}
    (hn : 0 < n) (hnN : n ≤ N)
    (hsmooth : ∀ p ∈ n.primeFactors, p ≤ Y)
    (hcard : n.primeFactors.card ≤ w) :
    n ∈ wordProducts (primePowerAlphabet Y (Nat.log 2 N)) w := by
  rw [Nat.prod_primeFactors_pow_factorization hn.ne']
  apply finset_prod_mem_wordProducts n.primeFactors
    (fun p => p ^ n.factorization p) (one_mem_primePowerAlphabet _ _) hcard
  intro p hp
  have hpprime : p.Prime := Nat.prime_of_mem_primeFactors hp
  have hpdvd : p ∣ n := Nat.dvd_of_mem_primeFactors hp
  exact pow_mem_primePowerAlphabet hpprime.pos (hsmooth p hp)
    (hpprime.factorization_pos_of_dvd hn.ne' hpdvd)
    (factorization_le_log_two hn hnN hpprime)

/-- The finite set counted in the elementary theorem. -/
noncomputable def smoothLowOmegaUpTo (N Y w : ℕ) : Finset ℕ := by
  classical
  exact (Finset.Icc 1 N).filter
    (fun n => (∀ p ∈ n.primeFactors, p ≤ Y) ∧ n.primeFactors.card ≤ w)

/-- Exact finite support-counting bound, with no analytic assumptions. -/
theorem smoothLowOmegaUpTo_card_le (N Y w : ℕ) :
    (smoothLowOmegaUpTo N Y w).card ≤ (1 + Y * Nat.log 2 N) ^ w := by
  classical
  have hsub : smoothLowOmegaUpTo N Y w ⊆
      wordProducts (primePowerAlphabet Y (Nat.log 2 N)) w := by
    intro n hn
    obtain ⟨hnrange, hsmooth, hcard⟩ := Finset.mem_filter.mp hn
    obtain ⟨hnpos, hnN⟩ := Finset.mem_Icc.mp hnrange
    exact mem_wordProducts_of_smooth_lowOmega (by omega) hnN hsmooth hcard
  calc
    (smoothLowOmegaUpTo N Y w).card
        ≤ (wordProducts (primePowerAlphabet Y (Nat.log 2 N)) w).card :=
      Finset.card_le_card hsub
    _ ≤ (primePowerAlphabet Y (Nat.log 2 N)).card ^ w := wordProducts_card_le _ _
    _ ≤ (1 + Y * Nat.log 2 N) ^ w :=
      Nat.pow_le_pow_left (primePowerAlphabet_card_le _ _) _

/-- The same bound applies to the low-omega part of any packet of distinct
positive smooth integers below `N`, including a short interval. -/
theorem packet_lowOmega_card_le (s : Finset ℕ) {N Y w : ℕ}
    (hrange : ∀ n ∈ s, 0 < n ∧ n ≤ N)
    (hsmooth : ∀ n ∈ s, ∀ p ∈ n.primeFactors, p ≤ Y) :
    (s.filter (fun n => n.primeFactors.card ≤ w)).card
      ≤ (1 + Y * Nat.log 2 N) ^ w := by
  classical
  apply le_trans (Finset.card_le_card ?_) (smoothLowOmegaUpTo_card_le N Y w)
  intro n hn
  obtain ⟨hns, hcard⟩ := Finset.mem_filter.mp hn
  apply Finset.mem_filter.mpr
  refine ⟨Finset.mem_Icc.mpr ⟨by have := (hrange n hns).1; omega,
      (hrange n hns).2⟩, hsmooth n hns, hcard⟩

/-- All but at most the finite encoding bound have more than `w` distinct
prime factors. Natural subtraction records the trivial bound when the
packet is smaller than the encoding bound. -/
theorem packet_highOmega_card_lower (s : Finset ℕ) {N Y w : ℕ}
    (hrange : ∀ n ∈ s, 0 < n ∧ n ≤ N)
    (hsmooth : ∀ n ∈ s, ∀ p ∈ n.primeFactors, p ≤ Y) :
    s.card - (1 + Y * Nat.log 2 N) ^ w
      ≤ (s.filter (fun n => w < n.primeFactors.card)).card := by
  classical
  have hlow := packet_lowOmega_card_le s hrange hsmooth (w := w)
  have hsplit := s.card_filter_add_card_filter_not
    (fun n => n.primeFactors.card ≤ w)
  simp only [not_le] at hsplit
  omega

/-- An exact first-moment lower bound for every finite smooth packet. This
is Corollary 2.3 of the mathematical proof, before any analytic limit. -/
theorem packet_omega_sum_lower (s : Finset ℕ) {N Y w : ℕ}
    (hrange : ∀ n ∈ s, 0 < n ∧ n ≤ N)
    (hsmooth : ∀ n ∈ s, ∀ p ∈ n.primeFactors, p ≤ Y) :
    (w + 1) * (s.card - (1 + Y * Nat.log 2 N) ^ w)
      ≤ ∑ n ∈ s, n.primeFactors.card := by
  classical
  let high := s.filter (fun n => w < n.primeFactors.card)
  calc
    (w + 1) * (s.card - (1 + Y * Nat.log 2 N) ^ w)
        ≤ (w + 1) * high.card :=
      Nat.mul_le_mul_left _ (packet_highOmega_card_lower s hrange hsmooth)
    _ = ∑ _n ∈ high, (w + 1) := by simp [Nat.mul_comm]
    _ ≤ ∑ n ∈ high, n.primeFactors.card := by
      apply Finset.sum_le_sum
      intro n hn
      exact (Finset.mem_filter.mp hn).2
    _ ≤ ∑ n ∈ s, n.primeFactors.card :=
      Finset.sum_le_sum_of_subset (Finset.filter_subset _ _)

/-- An abundant smooth packet must contain an integer with more than `w`
distinct prime factors. -/
theorem exists_highOmega_of_packet_card (s : Finset ℕ) {N Y w : ℕ}
    (hrange : ∀ n ∈ s, 0 < n ∧ n ≤ N)
    (hsmooth : ∀ n ∈ s, ∀ p ∈ n.primeFactors, p ≤ Y)
    (hlarge : (1 + Y * Nat.log 2 N) ^ w < s.card) :
    ∃ n ∈ s, w < n.primeFactors.card := by
  classical
  by_contra h
  have hall : ∀ n ∈ s, n.primeFactors.card ≤ w := by
    intro n hn
    by_contra hnot
    exact h ⟨n, hn, by omega⟩
  have hfilt : s.filter (fun n => n.primeFactors.card ≤ w) = s :=
    Finset.filter_eq_self.mpr hall
  have hbound := packet_lowOmega_card_le s hrange hsmooth (w := w)
  rw [hfilt] at hbound
  omega

#print axioms wordProducts_card_le
#print axioms factorization_le_log_two
#print axioms mem_wordProducts_of_smooth_lowOmega
#print axioms smoothLowOmegaUpTo_card_le
#print axioms packet_lowOmega_card_le
#print axioms packet_highOmega_card_lower
#print axioms packet_omega_sum_lower
#print axioms exists_highOmega_of_packet_card

end SmoothLowOmegaCounting
end IUTThreeClosures
