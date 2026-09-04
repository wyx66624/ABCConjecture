/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCStatement
import Mathlib.Tactic.NormNum

/-!
# Logical and arithmetic boundary for the direct abc countersearch

The ordinary proofs and the independently replayable finite computation
precede this module in
`research/ABC_DIRECT_BOUNDED_COUNTERSEARCH_2026_09_04.md`.

This file formalizes the quantifier distinction used by that report, the fact
that every finite family of real excesses is bounded, and exact arithmetic
certificates for the three principal adversarial triples.  It does not import
the 1.52-billion-row computation into the Lean kernel and it proves neither
`ABCConjecture` nor its negation.
-/

namespace IUTThreeClosures
namespace ABCDirectCountersearchBoundary20260904

open scoped BigOperators

/-- Negating a uniform additive bound requires one fixed positive parameter
whose excess is unbounded above. -/
theorem not_uniformlyBounded_iff_exists_unbounded
    {alpha : Type*} (excess : Real -> alpha -> Real) :
    (¬ (forall epsilon : Real, 0 < epsilon ->
      exists C : Real, forall x : alpha, excess epsilon x <= C)) <->
    exists epsilon : Real, 0 < epsilon /\
      forall C : Real, exists x : alpha, C < excess epsilon x := by
  constructor
  · intro h
    classical
    by_contra hn
    apply h
    intro epsilon hε
    by_contra hbound
    apply hn
    refine ⟨epsilon, hε, ?_⟩
    intro C
    by_contra hx
    apply hbound
    refine ⟨C, ?_⟩
    intro x
    exact le_of_not_gt (fun hlt => hx ⟨x, hlt⟩)
  · rintro ⟨epsilon, hε, hunbounded⟩ hbound
    obtain ⟨C, hC⟩ := hbound epsilon hε
    obtain ⟨x, hx⟩ := hunbounded C
    exact (not_lt_of_ge (hC x)) hx

/-- A finite search result is always absorbed by one additive constant. -/
theorem finite_excess_family_is_bounded
    {alpha : Type*}
    (s : Finset alpha) (excess : alpha -> Real) :
    exists C : Real, forall x, x ∈ s -> excess x <= C := by
  refine ⟨∑ x ∈ s, |excess x|, ?_⟩
  intro x hx
  calc
    excess x <= |excess x| := le_abs_self (excess x)
    _ <= ∑ y ∈ s, |excess y| := by
      exact Finset.single_le_sum (fun y hy => abs_nonneg (excess y)) hx

/-! ## The complete-search leaders -/

theorem witness4375_sum : (1 : Nat) + 4374 = 4375 := by
  norm_num

theorem witness4375_factor_b : (4374 : Nat) = 2 * 3 ^ 7 := by
  norm_num

theorem witness4375_factor_c : (4375 : Nat) = 5 ^ 4 * 7 := by
  norm_num

theorem witness4375_support_primes :
    Nat.Prime 2 /\ Nat.Prime 3 /\ Nat.Prime 5 /\ Nat.Prime 7 := by
  norm_num

theorem witness4375_radical_product : (2 : Nat) * 3 * 5 * 7 = 210 := by
  norm_num

/-- Exact power form of positive excess at epsilon `1/2`. -/
theorem witness4375_positive_half_excess :
    (210 : Nat) ^ 3 < 4375 ^ 2 := by
  norm_num

theorem witness59392_sum : (343 : Nat) + 59049 = 59392 := by
  norm_num

theorem witness59392_factor_a : (343 : Nat) = 7 ^ 3 := by
  norm_num

theorem witness59392_factor_b : (59049 : Nat) = 3 ^ 10 := by
  norm_num

theorem witness59392_factor_c : (59392 : Nat) = 2 ^ 11 * 29 := by
  norm_num

theorem witness59392_support_primes :
    Nat.Prime 2 /\ Nat.Prime 3 /\ Nat.Prime 7 /\ Nat.Prime 29 := by
  norm_num

theorem witness59392_radical_product : (2 : Nat) * 3 * 7 * 29 = 1218 := by
  norm_num

theorem witness59392_positive_half_excess :
    (1218 : Nat) ^ 3 < 59392 ^ 2 := by
  norm_num

/-! ## The structured benchmark beyond the complete height cutoff -/

theorem witness23_sum : (2 : Nat) + 3 ^ 10 * 109 = 23 ^ 5 := by
  norm_num

theorem witness23_support_primes :
    Nat.Prime 2 /\ Nat.Prime 3 /\ Nat.Prime 109 /\ Nat.Prime 23 := by
  norm_num

theorem witness23_radical_product : (2 : Nat) * 3 * 109 * 23 = 15042 := by
  norm_num

theorem witness23_pairwise_support_disjoint :
    Nat.Coprime 2 (3 ^ 10 * 109) /\
      Nat.Coprime (3 ^ 10 * 109) (23 ^ 5) /\
      Nat.Coprime (23 ^ 5) 2 := by
  norm_num

theorem witness23_positive_half_excess :
    (15042 : Nat) ^ 3 < (23 ^ 5) ^ 2 := by
  norm_num

end ABCDirectCountersearchBoundary20260904
end IUTThreeClosures
