/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Module.Submodule.Union
import Mathlib.Algebra.Field.ZMod
import Mathlib.LinearAlgebra.BilinearForm.Properties
import Mathlib.LinearAlgebra.Prod
import Mathlib.Tactic.Module
import Mathlib.Tactic.Ring

/-!
# Central correction and simultaneous finite-field avoidance

The mathematical proofs precede this module in
`research/IUT_THREE_LABEL_MINIMUM_LAYER_CROSS_REVIEW_2026_08_30.md`,
Sections 2--5, and
`research/IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md`, Sections 7--9.

This file proves the central composition law for the displayed linear
cross actions, their inverses, and a finite-family avoidance theorem.
It also proves that one alternating transvection makes all of a finite
family of initially zero projections nonzero.

These are statements about modules and linear actions. In particular the
central law is not asserted in a nonabelian Galois automorphism group.
The Jannsen--Wingberg lifts, local logarithmic lattices, the inertia orbit,
and the identification of these coordinates with local fields remain
mathematical source arguments; none are introduced as axioms here.
-/

namespace IUTThreeClosures.IUTThreeLabelMinimumLayer20260830

universe u v w z

section CentralLaw

variable {R : Type u} [CommRing R]
variable {W : Type v} [AddCommGroup W] [Module R W]

/-- Coordinates `A*a + B*b + x` in the distinguished pair and remaining handles. -/
abbrev Coordinates (R : Type u) (W : Type v) := R × R × W

/-- The cross action `N_w` on linear coordinates. -/
def crossMap (ω : LinearMap.BilinForm R W) (w : W) :
    Coordinates R W →ₗ[R] Coordinates R W where
  toFun z := (z.1 + ω w z.2.2, z.2.1, z.2.2 + z.2.1 • w)
  map_add' x y := by
    rcases x with ⟨A, B, x⟩
    rcases y with ⟨C, D, y⟩
    apply Prod.ext
    · simp only [Prod.fst_add, Prod.snd_add, map_add]
      ring
    · apply Prod.ext
      · rfl
      · dsimp
        module
  map_smul' c z := by
    rcases z with ⟨A, B, x⟩
    apply Prod.ext
    · simp only [Prod.smul_fst, Prod.smul_snd, map_smul, smul_eq_mul, RingHom.id_apply]
      ring
    · apply Prod.ext
      · rfl
      · dsimp
        module

/-- The central linear correction, fixing `a,W` and sending `b` to `b+c*a`. -/
def centralMap (c : R) : Coordinates R W →ₗ[R] Coordinates R W where
  toFun z := (z.1 + c * z.2.1, z.2.1, z.2.2)
  map_add' x y := by
    rcases x with ⟨A, B, x⟩
    rcases y with ⟨C, D, y⟩
    apply Prod.ext
    · dsimp
      ring
    · rfl
  map_smul' c' z := by
    rcases z with ⟨A, B, x⟩
    apply Prod.ext
    · dsimp
      ring
    · rfl

/-- The precise central law; composition acts rightmost first. -/
theorem cross_comp (ω : LinearMap.BilinForm R W) (w v : W) :
    (crossMap ω w).comp (crossMap ω v) =
      (centralMap (ω w v)).comp (crossMap ω (w + v)) := by
  apply LinearMap.ext
  rintro ⟨A, B, x⟩
  apply Prod.ext
  · simp [crossMap, centralMap, map_add, map_smul]
    ring
  · apply Prod.ext
    · rfl
    · dsimp [crossMap, centralMap]
      module

/-- Central parameters add. -/
theorem central_comp (c d : R) :
    (centralMap c (W := W)).comp (centralMap d) = centralMap (c + d) := by
  apply LinearMap.ext
  rintro ⟨A, B, x⟩
  apply Prod.ext
  · dsimp [centralMap]
    ring
  · rfl

/-- Central corrections commute with all cross actions. -/
theorem central_cross_comm (ω : LinearMap.BilinForm R W) (c : R) (w : W) :
    (centralMap c).comp (crossMap ω w) = (crossMap ω w).comp (centralMap c) := by
  apply LinearMap.ext
  rintro ⟨A, B, x⟩
  apply Prod.ext
  · dsimp [centralMap, crossMap]
    ring
  · rfl

@[simp]
theorem central_zero : centralMap (0 : R) (W := W) = LinearMap.id := by
  apply LinearMap.ext
  rintro ⟨A, B, x⟩
  simp [centralMap]

@[simp]
theorem cross_zero (ω : LinearMap.BilinForm R W) :
    crossMap ω 0 = LinearMap.id := by
  apply LinearMap.ext
  rintro ⟨A, B, x⟩
  simp [crossMap]

/-- The correction has the negative sign for the stated composition order. -/
theorem central_corrected_cross_comp (ω : LinearMap.BilinForm R W) (w v : W) :
    (centralMap (-ω w v)).comp ((crossMap ω w).comp (crossMap ω v)) =
      crossMap ω (w + v) := by
  rw [cross_comp, ← LinearMap.comp_assoc, central_comp]
  simp

/-- Alternation makes negating the cross parameter give a left inverse. -/
theorem cross_neg_comp (ω : LinearMap.BilinForm R W) (hω : ω.IsAlt) (w : W) :
    (crossMap ω (-w)).comp (crossMap ω w) = LinearMap.id := by
  rw [cross_comp]
  simp [hω.self_eq_zero]

/-- The other inverse identity also holds. -/
theorem cross_comp_neg (ω : LinearMap.BilinForm R W) (hω : ω.IsAlt) (w : W) :
    (crossMap ω w).comp (crossMap ω (-w)) = LinearMap.id := by
  rw [cross_comp]
  simp [hω.self_eq_zero]

/-- Each cross action is an actual linear equivalence under alternation. -/
def crossEquiv (ω : LinearMap.BilinForm R W) (hω : ω.IsAlt) (w : W) :
    Coordinates R W ≃ₗ[R] Coordinates R W where
  toLinearMap := crossMap ω w
  invFun := crossMap ω (-w)
  left_inv z := DFunLike.congr_fun (cross_neg_comp ω hω w) z
  right_inv z := DFunLike.congr_fun (cross_comp_neg ω hω w) z

/-- The rank-one alternating transvection on the remaining handles. -/
def transvectionMap (ω : LinearMap.BilinForm R W) (r : W) : W →ₗ[R] W :=
  LinearMap.id + (ω r).smulRight r

@[simp]
theorem transvectionMap_apply (ω : LinearMap.BilinForm R W) (r x : W) :
    transvectionMap ω r x = x + ω r x • r := rfl

/-- The transvection is invertible for an alternating form, even without a
primitivity assumption on `r`. -/
def transvectionEquiv (ω : LinearMap.BilinForm R W) (hω : ω.IsAlt) (r : W) :
    W ≃ₗ[R] W where
  toLinearMap := transvectionMap ω r
  invFun x := x - ω r x • r
  left_inv x := by
    simp [map_add, map_smul, hω.self_eq_zero, sub_eq_add_neg]
  right_inv x := by
    simp [map_sub, map_smul, hω.self_eq_zero]

/-- This is a symplectic transvection: the alternating pairing is preserved. -/
theorem transvection_preserves (ω : LinearMap.BilinForm R W) (hω : ω.IsAlt)
    (r x y : W) :
    ω (transvectionMap ω r x) (transvectionMap ω r y) = ω x y := by
  simp only [transvectionMap_apply, map_add, map_smul, LinearMap.add_apply,
    LinearMap.smul_apply, smul_eq_mul]
  rw [hω.self_eq_zero r, ← hω.neg_eq r x]
  ring

end CentralLaw

section FiniteAvoidance

variable {K : Type u} [Field K] [Fintype K]
variable {W : Type v} [AddCommGroup W] [Module K W]
variable {Q : Type w} [AddCommGroup Q] [Module K Q]
variable {ι : Type z} [Fintype ι]

/-- A family of fewer than `card K` proper subspaces has a common outside vector.
No dimension estimate or exceptional vector is hidden in the conclusion. -/
theorem exists_outside_subspaces (P : ι → Submodule K W)
    (hP : ∀ i, P i ≠ ⊤) (hcard : Fintype.card ι < Fintype.card K) :
    ∃ r : W, ∀ i, r ∉ P i := by
  have hcard' : (Finset.univ : Finset ι).card < ENat.card K := by
    simpa only [Finset.card_univ, ENat.card_eq_coe_fintype_card,
      ENat.coe_lt_coe] using hcard
  have h := Submodule.iUnion_ssubset_of_forall_ne_top_of_card_lt
    (Finset.univ : Finset ι) P hP hcard'
  simpa [Set.ssubset_univ_iff, Set.iUnion_eq_univ_iff] using h

/-- All nonzero linear forms in a sufficiently small finite family can be
made nonzero by the same vector. -/
theorem exists_common_nonzero (f : ι → W →ₗ[K] K)
    (hf : ∀ i, f i ≠ 0) (hcard : Fintype.card ι < Fintype.card K) :
    ∃ r : W, ∀ i, f i r ≠ 0 := by
  obtain ⟨r, hr⟩ := exists_outside_subspaces (fun i => (f i).ker)
    (fun i => by simpa only [ne_eq, LinearMap.ker_eq_top] using hf i) hcard
  exact ⟨r, fun i => by simpa only [LinearMap.mem_ker] using hr i⟩

/-- In addition to the scalar forms, avoid the kernel of one nonzero map
to an arbitrary vector-space quotient. Only one extra forbidden subspace is used. -/
theorem exists_common_nonzero_with_projection (f : ι → W →ₗ[K] K)
    (hf : ∀ i, f i ≠ 0) (proj : W →ₗ[K] Q) (hproj : proj ≠ 0)
    (hcard : Fintype.card ι + 1 < Fintype.card K) :
    ∃ r : W, proj r ≠ 0 ∧ ∀ i, f i r ≠ 0 := by
  let P : Option ι → Submodule K W
    | none => proj.ker
    | some i => (f i).ker
  have hP : ∀ i, P i ≠ ⊤ := by
    intro i
    cases i with
    | none => simpa only [P, ne_eq, LinearMap.ker_eq_top] using hproj
    | some i => simpa only [P, ne_eq, LinearMap.ker_eq_top] using hf i
  obtain ⟨r, hr⟩ := exists_outside_subspaces P hP (by simpa using hcard)
  refine ⟨r, ?_, ?_⟩
  · simpa only [P, LinearMap.mem_ker] using hr none
  · intro i
    simpa only [P, LinearMap.mem_ker] using hr (some i)

/-- For a family whose original quotient projections vanish, one transvection
parameter and one direction suffice for every vector simultaneously.
The hypothesis on the flipped forms is the precise nondegeneracy input. -/
theorem exists_common_transvection_projection
    (ω : LinearMap.BilinForm K W) (hω : ω.IsAlt)
    (v : ι → W) (hv : ∀ i, ω.flip (v i) ≠ 0)
    (proj : W →ₗ[K] Q) (hproj : proj ≠ 0) (hzero : ∀ i, proj (v i) = 0)
    (hcard : Fintype.card ι + 1 < Fintype.card K) :
    ∃ r : W, proj r ≠ 0 ∧
      ∀ i, proj (transvectionEquiv ω hω r (v i)) ≠ 0 := by
  obtain ⟨r, hr, hfr⟩ := exists_common_nonzero_with_projection
    (fun i => ω.flip (v i)) hv proj hproj hcard
  refine ⟨r, hr, ?_⟩
  intro i
  change proj (v i + ω r (v i) • r) ≠ 0
  rw [map_add, map_smul, hzero i, zero_add]
  exact smul_ne_zero (hfr i) hr

end FiniteAvoidance

section ThreeLabels

local instance prime139 : Fact (Nat.Prime 139) := ⟨by decide⟩

variable {W : Type v} [AddCommGroup W] [Module (ZMod 139) W]
variable {Q : Type w} [AddCommGroup Q] [Module (ZMod 139) Q]

/-- The finite-field conclusion for exactly three labels over `F_139`.
The four forbidden kernels are fewer than 139, with no numerical hypothesis left open. -/
theorem three_labels_common_transvection
    (ω : LinearMap.BilinForm (ZMod 139) W) (hω : ω.IsAlt)
    (v : Fin 3 → W) (hv : ∀ i, ω.flip (v i) ≠ 0)
    (proj : W →ₗ[ZMod 139] Q) (hproj : proj ≠ 0)
    (hzero : ∀ i, proj (v i) = 0) :
    ∃ r : W, proj r ≠ 0 ∧
      ∀ i, proj (transvectionEquiv ω hω r (v i)) ≠ 0 := by
  apply exists_common_transvection_projection (K := ZMod 139) ω hω v hv proj hproj hzero
  norm_num [ZMod.card]

end ThreeLabels

end IUTThreeClosures.IUTThreeLabelMinimumLayer20260830
