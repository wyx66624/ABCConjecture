import ActualSignedProducts
import SignedMomentArithmetic

/-! Actual two-element product maps supply the high-depth cardinality input.
The lower-layer count, target size and residue rigidity stay explicit. -/
set_option autoImplicit false
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCActualSingleOwner20260907
open ABCActualSignedProducts20260907 ABCSignedMoment20260907
open scoped BigOperators

variable {I G H : Type*} [DecidableEq I] [CommGroup G] [CommGroup H] [Fintype H]

def PairRigid (a : I → G) (phi : I → H) (r : Nat) (i j : I) : Prop :=
  ∀ x y : Diamond r,
    signedProduct ![phi i, phi j] (pairVector (diamondCoordinates r x)) =
      signedProduct ![phi i, phi j] (pairVector (diamondCoordinates r y)) →
    signedProduct ![a i, a j] (pairVector (diamondCoordinates r x)) =
      signedProduct ![a i, a j] (pairVector (diamondCoordinates r y))

theorem actual_pair_rigidity_card_le_one (s : Finset I)
    (a : I → G) (phi : I → H) (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0) (r n : Nat)
    (hn : n ≤ 2 * r ^ 2) (hcard : Fintype.card H ≤ n)
    (hrigid : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → PairRigid a phi r i j) :
    s.card ≤ 1 := by
  apply Finset.card_le_one.mpr
  intro i hi j hj
  by_contra hij
  have hoff' : ∀ k l : Fin 2, l ≠ k →
      (![v i, v j] k) (![a i, a j] l) = 1 := by
    intro k l hkl
    fin_cases k <;> fin_cases l
    · exact False.elim (hkl rfl)
    · simpa using hoff i j (Ne.symm hij)
    · simpa using hoff j i hij
    · exact False.elim (hkl rfl)
  have hdiag' : ∀ k : Fin 2, ((![v i, v j] k) (![a i, a j] k)).toAdd ≠ 0 := by
    intro k
    fin_cases k
    · simpa using hdiag i
    · simpa using hdiag j
  have hc := actual_diamond_target_capacity ![a i, a j] ![phi i, phi j]
    ![v i, v j] hoff' hdiag' r n (hrigid i hi j hj hij) hcard
  omega

theorem actual_product_single_prime_budget (s : Finset I) (e : I → Nat)
    (a : I → G) (phi : I → H) (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0)
    (n r : Nat) (L w : Real) (hrlo : n ≤ 2 * r ^ 2) (hrhi : r ^ 2 ≤ n)
    (hcard : Fintype.card H ≤ n) (hL : 0 ≤ L) (hw : 0 < w)
    (he : ∀ i ∈ s, (e i : Real) * w ≤ n * L)
    (hlow : 2 * (s.filter (fun i ↦ 4 ≤ e i)).card ^ 2 ≤ n)
    (hrigid : ∀ i ∈ s, max 4 (Nat.ceil (2 * r * L / w)) ≤ e i →
      ∀ j ∈ s, max 4 (Nat.ceil (2 * r * L / w)) ≤ e j →
      i ≠ j → PairRigid a phi r i j) :
    2 * (((∑ i ∈ s, (e i - 3)) : Nat) : Real) * w ≤ 5 * n * L := by
  have hhigh : (s.filter (fun i ↦
      max 4 (Nat.ceil (2 * r * L / w)) ≤ e i)).card ≤ 1 := by
    apply actual_pair_rigidity_card_le_one _ a phi v hoff hdiag r n hrlo hcard
    intro i hi j hj hij
    exact hrigid i (Finset.mem_filter.mp hi).1 (Finset.mem_filter.mp hi).2
      j (Finset.mem_filter.mp hj).1 (Finset.mem_filter.mp hj).2 hij
  obtain ⟨_O, _hsub, _hcard, _hmax, _hrem, htotal⟩ :=
    actual_single_owner_budget s e n r L w hrhi hL hw he hlow hhigh
  exact htotal

#print axioms actual_pair_rigidity_card_le_one
#print axioms actual_product_single_prime_budget
end ABCActualSingleOwner20260907
