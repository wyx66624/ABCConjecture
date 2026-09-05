import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.NumberTheory.LSeries.PrimesInAP
import Mathlib.Tactic

/-!
# Constant-residue endpoint packets

Ordinary proofs precede this file in
`research/ABC_UNBOUNDED_ENDPOINT_RESIDUE_OBSTRUCTION_2026_09_05.md`.

Scope: finite algebra and the established Dirichlet prime-existence interface.
The exact order hypothesis is explicit. This file does not formalize the whole
CRT/valuation realization, Sperner's theorem, or an abc/FCRT uniform estimate.
-/

namespace IUTThreeClosures.EndpointConstantResidueObstruction

open scoped BigOperators

/-- Two exponents in the initial half of a finite cyclic orbit are distinct. -/
theorem pow_ne_half_order {G : Type*} [Monoid G] (g : G) {m k : ℕ}
    (hm : 0 < m) (horder : orderOf g = 2 * m) (hk : k < m) :
    g ^ k ≠ g ^ m := by
  intro h
  have hkorder : k < orderOf g := by omega
  have hmorder : m < orderOf g := by omega
  have hkm : k = m := pow_injOn_Iio_orderOf hkorder hmorder h
  omega

/-- No nonempty initial-half packet has identity label. -/
theorem pow_ne_one_in_half {G : Type*} [Monoid G] (g : G) {m k : ℕ}
    (hm : 0 < m) (horder : orderOf g = 2 * m)
    (hkpos : 0 < k) (hkle : k ≤ m) : g ^ k ≠ 1 := by
  intro h
  have hkorder : k < orderOf g := by omega
  have hzero : 0 < orderOf g := by omega
  have hpow : g ^ k = g ^ (0 : ℕ) := by simpa using h
  have hkzero : k = 0 := pow_injOn_Iio_orderOf hkorder hzero hpow
  omega

/-- Products of constant labels depend exactly on packet cardinality. -/
theorem packet_product_eq_pow {ι G : Type*} [CommMonoid G]
    (T U : Finset ι) (label : ι → G) (g : G)
    (hUT : U ⊆ T) (hlabel : ∀ i ∈ T, label i = g) :
    (∏ i ∈ U, label i) = g ^ U.card := by
  calc
    (∏ i ∈ U, label i) = ∏ _i ∈ U, g := by
      apply Finset.prod_congr rfl
      intro i hi
      exact hlabel i (hUT hi)
    _ = g ^ U.card := by simp

/-- A proper packet misses the full half-order target, including the empty one. -/
theorem proper_packet_ne_target {ι G : Type*} [CommMonoid G]
    (T U : Finset ι) (label : ι → G) (g : G)
    (hT : 0 < T.card) (horder : orderOf g = 2 * T.card)
    (hproper : U ⊂ T) (hlabel : ∀ i ∈ T, label i = g) :
    (∏ i ∈ U, label i) ≠ g ^ T.card := by
  have hUT : U ⊆ T := (Finset.ssubset_iff_subset_ne.mp hproper).1
  rw [packet_product_eq_pow T U label g hUT hlabel]
  exact pow_ne_half_order g hT horder (Finset.card_lt_card hproper)

/-- The positive zero-sum deletion required by a proper flag does not exist. -/
theorem nonempty_packet_ne_one {ι G : Type*} [CommMonoid G]
    (T U : Finset ι) (label : ι → G) (g : G)
    (hT : 0 < T.card) (horder : orderOf g = 2 * T.card)
    (hUT : U ⊆ T) (hU : U.Nonempty) (hlabel : ∀ i ∈ T, label i = g) :
    (∏ i ∈ U, label i) ≠ 1 := by
  rw [packet_product_eq_pow T U label g hUT hlabel]
  exact pow_ne_one_in_half g hT horder
    (Finset.card_pos.mpr hU) (Finset.card_le_card hUT)

/-- The full packet still has its prescribed endpoint label. -/
theorem full_packet_eq_target {ι G : Type*} [CommMonoid G]
    (T : Finset ι) (label : ι → G) (g : G)
    (hlabel : ∀ i ∈ T, label i = g) :
    (∏ i ∈ T, label i) = g ^ T.card :=
  packet_product_eq_pow T T label g (Finset.Subset.refl T) hlabel

/-- A target expressed separately, for example `-1` in a unit group. -/
theorem proper_packet_ne_prescribed {ι G : Type*} [CommMonoid G]
    (T U : Finset ι) (label : ι → G) (g target : G)
    (hT : 0 < T.card) (horder : orderOf g = 2 * T.card)
    (hproper : U ⊂ T) (hlabel : ∀ i ∈ T, label i = g)
    (htarget : g ^ T.card = target) :
    (∏ i ∈ U, label i) ≠ target := by
  rw [← htarget]
  exact proper_packet_ne_target T U label g hT horder hproper hlabel

/-- A collision between two incomparable packets only needs equal rank. -/
theorem equal_card_packets_equal_label {ι G : Type*} [CommMonoid G]
    (T U V : Finset ι) (label : ι → G) (g : G)
    (hUT : U ⊆ T) (hVT : V ⊆ T)
    (hlabel : ∀ i ∈ T, label i = g) (hcard : U.card = V.card) :
    (∏ i ∈ U, label i) = ∏ i ∈ V, label i := by
  rw [packet_product_eq_pow T U label g hUT hlabel,
    packet_product_eq_pow T V label g hVT hlabel, hcard]

/-- Established Dirichlet input; no conjectural arithmetic assumption is added. -/
theorem arbitrarily_large_prime_in_progression (n : ℕ) {q a : ℕ}
    (hq : q ≠ 0) (ha : a.Coprime q) :
    ∃ p > n, p.Prime ∧ p ≡ a [MOD q] :=
  Nat.forall_exists_prime_gt_and_modEq n hq ha

#print axioms pow_ne_half_order
#print axioms pow_ne_one_in_half
#print axioms packet_product_eq_pow
#print axioms proper_packet_ne_target
#print axioms nonempty_packet_ne_one
#print axioms full_packet_eq_target
#print axioms proper_packet_ne_prescribed
#print axioms equal_card_packets_equal_label
#print axioms arbitrarily_large_prime_in_progression

end IUTThreeClosures.EndpointConstantResidueObstruction
