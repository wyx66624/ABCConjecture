import Mathlib.NumberTheory.LSeries.PrimesInAP
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Tactic

/-!
# An unbounded family of actual endpoints with no proper target packet

This specializes the ordinary Dirichlet/CRT proof to e = 2, with two fixed
primes 83 and 947 and a variable prime p congruent to 83 modulo 216.
It formalizes exact divisibility and all proper packets, not the global abc
conjecture, the e-uniform counting ratio, or the optimized FCRT boundary.
-/

namespace IUTThreeClosures.EndpointResidueArithmeticFamily

open scoped BigOperators

/-- Constant residues determine the residue of every packet product. -/
theorem packet_product_mod_nine (U : Finset ℕ)
    (h : ∀ q ∈ U, q % 9 = 2) :
    (∏ q ∈ U, q) % 9 = 2 ^ U.card % 9 := by
  classical
  revert h
  induction U using Finset.induction_on with
  | empty =>
      intro h
      simp
  | @insert a s ha ih =>
      intro h
      have ha2 : a % 9 = 2 := h a (by simp)
      have hs2 : (∏ q ∈ s, q) % 9 = 2 ^ s.card % 9 := by
        apply ih
        intro q hq
        exact h q (by simp [hq])
      simp [Finset.prod_insert ha, Finset.card_insert_of_notMem ha,
        pow_succ, Nat.mul_mod, ha2, hs2, Nat.mul_comm]

/-- No proper subpacket of the three distinct prime factors is 3-compatible. -/
theorem proper_packet_not_divisible (p : ℕ) (hp : 947 < p)
    (hmod : p % 9 = 2) (U : Finset ℕ)
    (hproper : U ⊂ ({83, 947, p} : Finset ℕ)) :
    ¬9 ∣ (∏ q ∈ U, q) + 1 := by
  have hcard : ({83, 947, p} : Finset ℕ).card = 3 := by
    apply Finset.card_triple_eq_three_iff.mpr
    constructor
    · norm_num
    constructor <;> omega
  have hsmall : U.card < 3 := by
    simpa [hcard] using Finset.card_lt_card hproper
  have hsubset : U ⊆ ({83, 947, p} : Finset ℕ) :=
    (Finset.ssubset_iff_subset_ne.mp hproper).1
  have hprod : (∏ q ∈ U, q) % 9 = 2 ^ U.card % 9 := by
    apply packet_product_mod_nine
    intro q hq
    have hq' := hsubset hq
    simp only [Finset.mem_insert, Finset.mem_singleton] at hq'
    rcases hq' with rfl | rfl | rfl
    · norm_num
    · norm_num
    · exact hmod
  intro hdiv
  have hzero : ((∏ q ∈ U, q) + 1) % 9 = 0 := Nat.mod_eq_zero_of_dvd hdiv
  have hcases : U.card = 0 ∨ U.card = 1 ∨ U.card = 2 := by omega
  rcases hcases with h0 | h1 | h2
  · norm_num [h0] at hprod
    omega
  · norm_num [h1] at hprod
    omega
  · norm_num [h2] at hprod
    omega

/-- Divisibility and nondivisibility specify exact exponents two at 2 and 3. -/
theorem progression_endpoint_valuations (p : ℕ) (hmod : p % 216 = 83) :
    4 ∣ 78601 * p + 1 ∧ ¬8 ∣ 78601 * p + 1 ∧
    9 ∣ 78601 * p + 1 ∧ ¬27 ∣ 78601 * p + 1 := by
  have hp4 : p % 4 = 3 := by omega
  have hp8 : p % 8 = 3 := by omega
  have hp9 : p % 9 = 2 := by omega
  have hp27 : p % 27 = 2 := by omega
  norm_num [Nat.dvd_iff_mod_eq_zero, Nat.add_mod, Nat.mul_mod,
    hp4, hp8, hp9, hp27]

/-- Genuine unbounded primitive endpoints, with no abstract order assumption. -/
theorem arbitrarily_large_primitive_endpoints (N : ℕ) :
    ∃ p : ℕ, N < p ∧ 947 < p ∧ p.Prime ∧ Nat.Prime 83 ∧ Nat.Prime 947 ∧
      0 < 78601 * p ∧ Nat.Coprime 1 (78601 * p) ∧
      83 * 947 * p = 78601 * p ∧
      4 ∣ 78601 * p + 1 ∧ ¬8 ∣ 78601 * p + 1 ∧
      9 ∣ 78601 * p + 1 ∧ ¬27 ∣ 78601 * p + 1 ∧
      ∀ U : Finset ℕ, U ⊂ ({83, 947, p} : Finset ℕ) →
        ¬9 ∣ (∏ q ∈ U, q) + 1 := by
  obtain ⟨p, hlarge, hprime, hmod⟩ :=
    Nat.forall_exists_prime_gt_and_modEq (max N 947)
      (q := 216) (a := 83) (by norm_num) (by norm_num)
  have hN : N < p := lt_of_le_of_lt (le_max_left N 947) hlarge
  have hp : 947 < p := lt_of_le_of_lt (le_max_right N 947) hlarge
  have hp216 : p % 216 = 83 := by
    simpa [Nat.ModEq] using hmod
  have hp9 : p % 9 = 2 := by omega
  obtain ⟨h4, h8, h9, h27⟩ := progression_endpoint_valuations p hp216
  refine ⟨p, hN, hp, hprime, by norm_num, by norm_num, ?_, ?_, ?_, h4, h8, h9, h27, ?_⟩
  · omega
  · simp
  · norm_num
  · intro U hU
    exact proper_packet_not_divisible p hp hp9 U hU

#print axioms packet_product_mod_nine
#print axioms proper_packet_not_divisible
#print axioms progression_endpoint_valuations
#print axioms arbitrarily_large_primitive_endpoints

end IUTThreeClosures.EndpointResidueArithmeticFamily
