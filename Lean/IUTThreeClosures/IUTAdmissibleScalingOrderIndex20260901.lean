/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IntegralOrderDecompositionObstruction

/-!
# Admissible scaling and an exact integral-order index

The mathematical proofs precede this formalization in
`research/ABC_IUT_ADMISSIBLE_SCALING_ORDER_INDEX_2026_09_02.md`.

This module proves that an all-set real-valued scaling law is inconsistent,
that merely restricting it to nonempty sets does not repair it, and that the
congruence order used as the integral-order seam has exact additive index
`n`.  It does not assert a same-pilot comparison, IUT, or abc.
-/

namespace IUTThreeClosures
namespace IUTAdmissibleScalingOrderIndex20260901

/-! ## Total scaling no-go theorems -/

/-- A translation law on preimages of every set forces the translation to be
zero.  The empty set is a full-premise counterexample to every nonzero shift. -/
theorem shift_eq_zero_of_all_sets
    {X : Type*} (scale : X → X) (volume : Set X → ℝ) (shift : ℝ)
    (hshift : ∀ U : Set X,
      volume (scale ⁻¹' U) = volume U + shift) :
    shift = 0 := by
  have h := hshift (∅ : Set X)
  simp only [Set.preimage_empty] at h
  linarith

/-- Nonemptiness alone is not a sufficient domain restriction.  On an
inhabited space the whole set is nonempty and fixed by every preimage. -/
theorem shift_eq_zero_of_all_nonempty_sets
    {X : Type*} [Nonempty X]
    (scale : X → X) (volume : Set X → ℝ) (shift : ℝ)
    (hshift : ∀ U : Set X, U.Nonempty →
      volume (scale ⁻¹' U) = volume U + shift) :
    shift = 0 := by
  have h := hshift (Set.univ : Set X) Set.univ_nonempty
  simp only [Set.preimage_univ] at h
  linarith

/-! ## The exact congruence-order quotient -/

/-- Difference of the two coordinates modulo `n`. -/
def differenceMod (n : ℕ) : (ℤ × ℤ) →+ ZMod n where
  toFun x := (x.1 : ZMod n) - (x.2 : ZMod n)
  map_zero' := by simp
  map_add' x y := by
    simp only [Prod.fst_add, Prod.snd_add, Int.cast_add]
    abel

@[simp]
theorem differenceMod_apply (n : ℕ) (x : ℤ × ℤ) :
    differenceMod n x = (x.1 : ZMod n) - (x.2 : ZMod n) :=
  rfl

/-- Every residue class is represented by the first coordinate of `(a, 0)`. -/
theorem differenceMod_surjective (n : ℕ) :
    Function.Surjective (differenceMod n) := by
  intro z
  obtain ⟨a, rfl⟩ := ZMod.intCast_surjective z
  exact ⟨(a, 0), by simp [differenceMod]⟩

/-- The kernel of the difference map is exactly the additive group underlying
the congruence order. -/
theorem differenceMod_ker (n : ℕ) :
    (differenceMod n).ker =
      (congruenceOrder (n : ℤ)).toAddSubgroup := by
  ext x
  simp only [AddMonoidHom.mem_ker, differenceMod_apply,
    Subring.mem_toAddSubgroup, mem_congruenceOrder_iff]
  rw [sub_eq_zero, ZMod.intCast_eq_intCast_iff_dvd_sub]
  constructor
  · intro h
    simpa only [neg_sub] using (dvd_neg.mpr h)
  · intro h
    simpa only [neg_sub] using (dvd_neg.mpr h)

/-- The additive quotient by the congruence order is canonically `ZMod n`. -/
noncomputable def congruenceOrderQuotientEquiv (n : ℕ) :
    (ℤ × ℤ) ⧸ (congruenceOrder (n : ℤ)).toAddSubgroup ≃+ ZMod n := by
  rw [← differenceMod_ker n]
  exact QuotientAddGroup.quotientKerEquivOfSurjective
    (differenceMod n) (differenceMod_surjective n)

/-- The congruence order has exact additive index `n`.  With the library's
`Nat.card` convention this includes `n = 0`, when the quotient is infinite. -/
theorem congruenceOrder_index (n : ℕ) :
    (congruenceOrder (n : ℤ)).toAddSubgroup.index = n := by
  rw [← differenceMod_ker n, AddSubgroup.index_ker]
  have hrange : (differenceMod n).range = ⊤ :=
    AddMonoidHom.range_eq_top.mpr (differenceMod_surjective n)
  rw [hrange]
  exact (Nat.card_congr AddSubgroup.topEquiv.toEquiv).trans (Nat.card_zmod n)

/-- If `n > 1`, the congruence order is a proper subring even though both of
its coordinate projections are surjective. -/
theorem congruenceOrder_ne_top_of_one_lt {n : ℕ} (hn : 1 < n) :
    congruenceOrder (n : ℤ) ≠ (⊤ : Subring (ℤ × ℤ)) := by
  intro htop
  have hmem : (1, 0) ∈ congruenceOrder (n : ℤ) := by
    rw [htop]
    exact Subring.mem_top _
  have hdvd : (n : ℤ) ∣ (1 : ℤ) := by
    simpa using hmem
  have hdvdNat : n ∣ 1 := Int.natCast_dvd_natCast.mp hdvd
  have hnOne : n = 1 := Nat.dvd_one.mp hdvdNat
  omega

/-- The first coordinate projection of every congruence order is surjective. -/
theorem congruenceOrder_fst_surjective (n : ℕ) :
    ∀ z : ℤ, ∃ x : congruenceOrder (n : ℤ), x.1.1 = z := by
  intro z
  refine ⟨⟨(z, z), ?_⟩, rfl⟩
  simp [congruenceOrder]

/-- The second coordinate projection of every congruence order is surjective. -/
theorem congruenceOrder_snd_surjective (n : ℕ) :
    ∀ z : ℤ, ∃ x : congruenceOrder (n : ℤ), x.1.2 = z := by
  intro z
  refine ⟨⟨(z, z), ?_⟩, rfl⟩
  simp [congruenceOrder]

/-- Exact indices multiply when the congruence modulus is multiplied. -/
theorem congruenceOrder_index_mul (m n : ℕ) :
    (congruenceOrder ((m * n : ℕ) : ℤ)).toAddSubgroup.index =
      (congruenceOrder (m : ℤ)).toAddSubgroup.index *
        (congruenceOrder (n : ℤ)).toAddSubgroup.index := by
  simp only [congruenceOrder_index]

/-- The real logarithm of the exact index is additive for positive moduli. -/
theorem congruenceOrder_log_index_mul
    {m n : ℕ} (hm : 0 < m) (hn : 0 < n) :
    Real.log
        ((congruenceOrder ((m * n : ℕ) : ℤ)).toAddSubgroup.index : ℝ) =
      Real.log ((congruenceOrder (m : ℤ)).toAddSubgroup.index : ℝ) +
        Real.log ((congruenceOrder (n : ℤ)).toAddSubgroup.index : ℝ) := by
  rw [congruenceOrder_index (m * n), congruenceOrder_index m,
    congruenceOrder_index n]
  have hmR : (m : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hm)
  have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hn)
  simpa only [Nat.cast_mul] using Real.log_mul hmR hnR

end IUTAdmissibleScalingOrderIndex20260901
end IUTThreeClosures

namespace IUTThreeClosures.IUTAdmissibleScalingOrderIndex20260901

#print axioms shift_eq_zero_of_all_sets
#print axioms shift_eq_zero_of_all_nonempty_sets
#print axioms differenceMod_ker
#print axioms congruenceOrderQuotientEquiv
#print axioms congruenceOrder_index
#print axioms congruenceOrder_ne_top_of_one_lt
#print axioms congruenceOrder_index_mul
#print axioms congruenceOrder_log_index_mul

end IUTThreeClosures.IUTAdmissibleScalingOrderIndex20260901
