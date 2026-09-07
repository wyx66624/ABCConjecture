import Mathlib.Algebra.Group.TypeTags.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic

/-! Actual signed products, private homomorphisms and a concrete finite diamond.
The finite residue group and modular rigidity remain explicit inputs. -/
set_option autoImplicit false
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCActualSignedProducts20260907
open scoped BigOperators

variable {I G H : Type*} [Fintype I] [CommGroup G]

def signedProduct (a : I → G) (x : I → Int) : G := ∏ i : I, a i ^ x i

theorem private_signed_valuation (a : I → G) (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1) (i : I) (x : I → Int) :
    v i (signedProduct a x) = v i (a i) ^ x i := by
  rw [signedProduct, map_prod]
  simp_rw [map_zpow]
  apply Finset.prod_eq_single i
  · intro j hj hji
    rw [hoff i j hji, one_zpow]
  · simp

theorem private_signed_coordinates_equal (a : I → G)
    (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0)
    (x y : I → Int) (heq : signedProduct a x = signedProduct a y) (i : I) :
    x i = y i := by
  have h := congrArg (v i) heq
  rw [private_signed_valuation a v hoff i x, private_signed_valuation a v hoff i y] at h
  have hh := congrArg Multiplicative.toAdd h
  simp only [toAdd_zpow, zsmul_eq_mul] at hh
  exact mul_right_cancel₀ (hdiag i) hh

theorem private_signed_product_injective (a : I → G)
    (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0) :
    Function.Injective (signedProduct a) := by
  intro x y h
  funext i
  exact private_signed_coordinates_equal a v hoff hdiag x y h i

theorem actual_unit_normalized_injective (a u : I → G)
    (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0)
    (hunit : ∀ i j : I, v i (u j) = 1) :
    Function.Injective (signedProduct (fun i ↦ u i * a i)) := by
  apply private_signed_product_injective _ v
  · intro i j hji
    simp only [map_mul, hunit, hoff i j hji, one_mul]
  · intro i
    simpa only [map_mul, hunit, one_mul] using hdiag i

theorem actual_finite_signed_capacity [CommGroup H] [Fintype H]
    (a : I → G) (phi : I → H) (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0) (A : Finset (I → Int))
    (hrigid : ∀ x ∈ A, ∀ y ∈ A, signedProduct phi x = signedProduct phi y →
      signedProduct a x = signedProduct a y) : A.card ≤ Fintype.card H := by
  have hinj : Function.Injective (fun x : A ↦ signedProduct phi x.val) := by
    intro x y h
    apply Subtype.ext
    exact private_signed_product_injective a v hoff hdiag
      (hrigid x.val x.property y.val y.property h)
  simpa only [Fintype.card_coe] using Fintype.card_le_of_injective _ hinj

abbrev Diamond (r : Nat) := (Fin (r + 1) × Fin (r + 1)) ⊕ (Fin r × Fin r)

def diamondCoordinates (r : Nat) : Diamond r → Int × Int
  | .inl (i, j) => (-(r : Int) + i.val + j.val, (i.val : Int) - j.val)
  | .inr (i, j) => (-(r : Int) + 1 + i.val + j.val, (i.val : Int) - j.val)

theorem actual_diamond_card (r : Nat) :
    Fintype.card (Diamond r) = 2 * r ^ 2 + 2 * r + 1 := by
  simp only [Diamond, Fintype.card_sum, Fintype.card_prod, Fintype.card_fin]
  ring

theorem actual_diamond_coordinates_injective (r : Nat) :
    Function.Injective (diamondCoordinates r) := by
  intro x y h
  have h1 := congrArg Prod.fst h
  have h2 := congrArg Prod.snd h
  rcases x with ⟨i, j⟩ | ⟨i, j⟩ <;> rcases y with ⟨k, l⟩ | ⟨k, l⟩
  all_goals simp only [diamondCoordinates] at h1 h2
  · have hi : i = k := Fin.ext (by omega)
    have hj : j = l := Fin.ext (by omega)
    subst k
    subst l
    rfl
  · omega
  · omega
  · have hi : i = k := Fin.ext (by omega)
    have hj : j = l := Fin.ext (by omega)
    subst k
    subst l
    rfl

theorem absolute_sum_le_of_four_corners (x y r : Int)
    (hpp : x + y ≤ r) (hpm : x - y ≤ r)
    (hmp : -x + y ≤ r) (hmm : -x - y ≤ r) : |x| + |y| ≤ r := by
  rcases le_total 0 x with hx | hx <;> rcases le_total 0 y with hy | hy
  · simpa only [abs_of_nonneg hx, abs_of_nonneg hy] using hpp
  · simpa only [abs_of_nonneg hx, abs_of_nonpos hy, sub_eq_add_neg] using hpm
  · simpa only [abs_of_nonpos hx, abs_of_nonneg hy] using hmp
  · simpa only [abs_of_nonpos hx, abs_of_nonpos hy, sub_eq_add_neg] using hmm

theorem actual_diamond_radius (r : Nat) (x : Diamond r) :
    |(diamondCoordinates r x).1| + |(diamondCoordinates r x).2| ≤ (r : Int) := by
  rcases x with ⟨i, j⟩ | ⟨i, j⟩
  · have hi := i.isLt
    have hj := j.isLt
    simp only [diamondCoordinates]
    apply absolute_sum_le_of_four_corners <;> omega
  · have hi := i.isLt
    have hj := j.isLt
    simp only [diamondCoordinates]
    apply absolute_sum_le_of_four_corners <;> omega

def pairVector (p : Int × Int) : Fin 2 → Int := ![p.1, p.2]

theorem actual_pair_vector_injective : Function.Injective pairVector := by
  intro p q h
  have h0 := congrFun h 0
  have h1 := congrFun h 1
  apply Prod.ext
  · simpa [pairVector] using h0
  · simpa [pairVector] using h1

theorem actual_private_diamond_injective (a : Fin 2 → G)
    (v : Fin 2 → G →* Multiplicative Int)
    (hoff : ∀ i j : Fin 2, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : Fin 2, (v i (a i)).toAdd ≠ 0) (r : Nat) :
    Function.Injective
      (fun x : Diamond r ↦ signedProduct a (pairVector (diamondCoordinates r x))) :=
  (private_signed_product_injective a v hoff hdiag).comp
    (actual_pair_vector_injective.comp (actual_diamond_coordinates_injective r))

theorem actual_diamond_target_capacity [CommGroup H] [Fintype H]
    (a : Fin 2 → G) (phi : Fin 2 → H)
    (v : Fin 2 → G →* Multiplicative Int)
    (hoff : ∀ i j : Fin 2, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : Fin 2, (v i (a i)).toAdd ≠ 0) (r n : Nat)
    (hrigid : ∀ x y : Diamond r,
      signedProduct phi (pairVector (diamondCoordinates r x)) =
        signedProduct phi (pairVector (diamondCoordinates r y)) →
      signedProduct a (pairVector (diamondCoordinates r x)) =
        signedProduct a (pairVector (diamondCoordinates r y)))
    (hcard : Fintype.card H ≤ n) : 2 * r ^ 2 + 2 * r + 1 ≤ n := by
  have hinj : Function.Injective
      (fun x : Diamond r ↦ signedProduct phi (pairVector (diamondCoordinates r x))) := by
    intro x y h
    exact actual_private_diamond_injective a v hoff hdiag r (hrigid x y h)
  calc
    2 * r ^ 2 + 2 * r + 1 = Fintype.card (Diamond r) := (actual_diamond_card r).symm
    _ ≤ Fintype.card H := Fintype.card_le_of_injective _ hinj
    _ ≤ n := hcard

#print axioms private_signed_valuation
#print axioms private_signed_coordinates_equal
#print axioms private_signed_product_injective
#print axioms actual_unit_normalized_injective
#print axioms actual_finite_signed_capacity
#print axioms actual_diamond_card
#print axioms actual_diamond_coordinates_injective
#print axioms absolute_sum_le_of_four_corners
#print axioms actual_diamond_radius
#print axioms actual_pair_vector_injective
#print axioms actual_private_diamond_injective
#print axioms actual_diamond_target_capacity
end ABCActualSignedProducts20260907
