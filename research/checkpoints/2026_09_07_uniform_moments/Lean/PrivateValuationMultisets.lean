import Mathlib.Data.Sym.Card
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Group.TypeTags.Basic
import Mathlib.Tactic

/-! Actual multiset products from private integer-valued monoid homomorphisms.
The construction of arithmetic valuations and modular rigidity stay explicit. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCPrivateValuationMultisets20260907
open scoped BigOperators

variable {I G H : Type*} [Fintype I] [DecidableEq I] [CommMonoid G]

def actualProduct (a : I → G) (s : Multiset I) : G := (s.map a).prod

theorem actual_product_eq_counts (a : I → G) (s : Multiset I) :
    actualProduct a s = ∏ i : I, a i ^ s.count i := by
  rw [actualProduct, Finset.prod_multiset_map_count]
  apply Finset.prod_subset (Finset.subset_univ _)
  intro i hi hnot
  have hz : s.count i = 0 := Multiset.count_eq_zero.mpr (by simpa using hnot)
  simp [hz]

theorem private_valuation_product (a : I → G)
    (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1) (i : I) (s : Multiset I) :
    v i (actualProduct a s) = v i (a i) ^ s.count i := by
  rw [actual_product_eq_counts, map_prod]
  simp_rw [map_pow]
  apply Finset.prod_eq_single i
  · intro j hj hji
    rw [hoff i j hji, one_pow]
  · simp

theorem private_valuation_counts_equal (a : I → G)
    (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0)
    (s t : Multiset I) (heq : actualProduct a s = actualProduct a t) (i : I) :
    s.count i = t.count i := by
  have h := congrArg (v i) heq
  rw [private_valuation_product a v hoff i s,
    private_valuation_product a v hoff i t] at h
  have hh := congrArg Multiplicative.toAdd h
  simp only [toAdd_pow, nsmul_eq_mul] at hh
  have hc : (s.count i : Int) = (t.count i : Int) := mul_right_cancel₀ (hdiag i) hh
  exact_mod_cast hc

theorem private_actual_product_injective (a : I → G)
    (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0) :
    Function.Injective (actualProduct a) := by
  intro s t h
  apply Multiset.ext.mpr
  intro i
  exact private_valuation_counts_equal a v hoff hdiag s t h i

theorem private_symmetric_product_injective (a : I → G)
    (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0) (nu : Nat) :
    Function.Injective (fun s : Sym I nu ↦ actualProduct a s.val) := by
  intro s t h
  apply Sym.ext
  exact private_actual_product_injective a v hoff hdiag h

theorem rigid_symmetric_product_injective [CommMonoid H] (a : I → G) (phi : I → H)
    (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0) (nu : Nat)
    (hrigid : ∀ s t : Sym I nu, actualProduct phi s.val = actualProduct phi t.val →
      actualProduct a s.val = actualProduct a t.val) :
    Function.Injective (fun s : Sym I nu ↦ actualProduct phi s.val) := by
  intro s t h
  exact private_symmetric_product_injective a v hoff hdiag nu (hrigid s t h)

theorem actual_symmetric_count_bound [CommMonoid H] [Fintype H]
    (a : I → G) (phi : I → H) (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0) (nu : Nat)
    (hrigid : ∀ s t : Sym I nu, actualProduct phi s.val = actualProduct phi t.val →
      actualProduct a s.val = actualProduct a t.val) :
    (Fintype.card I + nu - 1).choose nu ≤ Fintype.card H := by
  rw [← Sym.card_sym_eq_choose]
  exact Fintype.card_le_of_injective _
    (rigid_symmetric_product_injective a phi v hoff hdiag nu hrigid)

theorem actual_symmetric_three_n_bound [CommMonoid H] [Fintype H]
    (a : I → G) (phi : I → H) (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0) (nu n : Nat)
    (hrigid : ∀ s t : Sym I nu, actualProduct phi s.val = actualProduct phi t.val →
      actualProduct a s.val = actualProduct a t.val)
    (hcard : Fintype.card H ≤ 3 * n) :
    (Fintype.card I + nu - 1).choose nu ≤ 3 * n :=
  (actual_symmetric_count_bound a phi v hoff hdiag nu hrigid).trans hcard

#print axioms actual_product_eq_counts
#print axioms private_valuation_product
#print axioms private_valuation_counts_equal
#print axioms private_actual_product_injective
#print axioms private_symmetric_product_injective
#print axioms rigid_symmetric_product_injective
#print axioms actual_symmetric_count_bound
#print axioms actual_symmetric_three_n_bound
end ABCPrivateValuationMultisets20260907
