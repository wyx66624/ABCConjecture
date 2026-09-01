/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum

/-!
# Finite certificates for reachable tensor spans

The mathematical proofs precede this formalization in
`research/IUT_ROUTE_SESSION_2026_08_30.md`.

We prove a unit-determinant certificate for a set to span the ambient free
module, and distinguish independent from simultaneous tensor factors in
rank two. No actual IUT output, Haar-volume formula, eta-map calibration,
or ABC conclusion is postulated here.
-/

namespace IUTThreeClosures.ReachableTensorLatticeCriterion

open Matrix

section FiniteCertificate

variable {R : Type*} [CommRing R]
variable {n : Type*} [Fintype n] [DecidableEq n]

/-- A unit determinant certifies that the displayed columns span the free module. -/
theorem span_columns_eq_top_of_isUnit_det
    (A : Matrix n n R) (hdet : IsUnit A.det) :
    Submodule.span R (Set.range A.col) = ⊤ := by
  rw [← Matrix.range_mulVecLin]
  apply LinearMap.range_eq_top.mpr
  exact Matrix.mulVec_surjective_iff_isUnit.mpr
    (A.isUnit_iff_isUnit_det.mpr hdet)

/-- The certificate columns must be drawn from the original reachable set. -/
theorem span_eq_top_of_reachable_columns
    (S : Set (n → R)) (A : Matrix n n R)
    (hcol : ∀ j, A.col j ∈ S) (hdet : IsUnit A.det) :
    Submodule.span R S = ⊤ := by
  apply top_unique
  rw [← span_columns_eq_top_of_isUnit_det A hdet]
  apply Submodule.span_mono
  rintro x ⟨j, rfl⟩
  exact hcol j

/-- A target already known to be a submodule contains all integral linear
combinations of its certificate columns. Such closure is a hypothesis here. -/
theorem eq_top_of_columns_isUnit_det
    (Theta : Submodule R (n → R)) (A : Matrix n n R)
    (hcol : ∀ j, A.col j ∈ Theta) (hdet : IsUnit A.det) :
    Theta = ⊤ := by
  apply top_unique
  rw [← span_columns_eq_top_of_isUnit_det A hdet]
  apply Submodule.span_le.mpr
  rintro x ⟨j, rfl⟩
  exact hcol j

end FiniteCertificate

section TensorRankTwo

variable {R : Type*} [CommRing R]

/-- The standard matrix model of `(R^2) tensor_R (R^2)`. -/
abbrev Tensor22 (R : Type*) := Matrix (Fin 2) (Fin 2) R

/-- Coordinate matrix of a pure tensor. -/
def pureTensor (u v : Fin 2 → R) : Tensor22 R :=
  fun i j => u i * v j

/-- Integral span of all simultaneous squares. -/
def diagonalSpan (R : Type*) [CommRing R] : Submodule R (Tensor22 R) :=
  Submodule.span R (Set.range (fun v : Fin 2 → R => pureTensor v v))

/-- The rank-three symmetric submodule, defined without dividing by two. -/
def symmetricSubmodule (R : Type*) [CommRing R] : Submodule R (Tensor22 R) where
  carrier := {M | M 0 1 = M 1 0}
  zero_mem' := rfl
  add_mem' := by
    intro M N hM hN
    change M 0 1 + N 0 1 = M 1 0 + N 1 0
    rw [hM, hN]
  smul_mem' := by
    intro c M hM
    change c * M 0 1 = c * M 1 0
    rw [hM]

theorem pureTensor_self_mem_symmetric (v : Fin 2 → R) :
    pureTensor v v ∈ symmetricSubmodule R := by
  change v 0 * v 1 = v 1 * v 0
  exact mul_comm _ _

/-- The decomposition uses the square of `(1,1)` minus the two coordinate
squares; it works in characteristic two as well. -/
theorem symmetric_decomposition (M : Tensor22 R)
    (hM : M 0 1 = M 1 0) :
    M = (M 0 0) • pureTensor ![1, 0] ![1, 0] +
        (M 1 1) • pureTensor ![0, 1] ![0, 1] +
        (M 0 1) • (pureTensor ![1, 1] ![1, 1] -
          pureTensor ![1, 0] ![1, 0] -
          pureTensor ![0, 1] ![0, 1]) := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [pureTensor, hM]

/-- Simultaneous pure tensors generate precisely the symmetric submodule. -/
theorem diagonalSpan_eq_symmetric :
    diagonalSpan R = symmetricSubmodule R := by
  apply le_antisymm
  · apply Submodule.span_le.mpr
    rintro M ⟨v, rfl⟩
    exact pureTensor_self_mem_symmetric v
  · intro M hM
    change M 0 1 = M 1 0 at hM
    have h0 : pureTensor ![1, 0] ![1, 0] ∈ diagonalSpan R :=
      Submodule.subset_span ⟨![1, 0], rfl⟩
    have h1 : pureTensor ![0, 1] ![0, 1] ∈ diagonalSpan R :=
      Submodule.subset_span ⟨![0, 1], rfl⟩
    have h2 : pureTensor ![1, 1] ![1, 1] ∈ diagonalSpan R :=
      Submodule.subset_span ⟨![1, 1], rfl⟩
    rw [symmetric_decomposition M hM]
    exact (diagonalSpan R).add_mem
      ((diagonalSpan R).add_mem
        ((diagonalSpan R).smul_mem _ h0)
        ((diagonalSpan R).smul_mem _ h1))
      ((diagonalSpan R).smul_mem _
        ((diagonalSpan R).sub_mem ((diagonalSpan R).sub_mem h2 h0) h1))

/-- An explicit missing tensor, valid over every nontrivial commutative ring. -/
theorem offDiagonal_not_mem_diagonalSpan [Nontrivial R] :
    pureTensor (![1, 0] : Fin 2 → R) ![0, 1] ∉ diagonalSpan R := by
  rw [diagonalSpan_eq_symmetric]
  intro h
  change pureTensor (![1, 0] : Fin 2 → R) ![0, 1] 0 1 =
    pureTensor (![1, 0] : Fin 2 → R) ![0, 1] 1 0 at h
  norm_num [pureTensor] at h

theorem diagonalSpan_ne_top [Nontrivial R] :
    diagonalSpan R ≠ ⊤ := by
  intro h
  apply offDiagonal_not_mem_diagonalSpan (R := R)
  rw [h]
  trivial

/-- By contrast, independent pure tensors generate the whole tensor module. -/
theorem independent_pureTensor_span_eq_top :
    Submodule.span R
      (Set.range (fun uv : (Fin 2 → R) × (Fin 2 → R) =>
        pureTensor uv.1 uv.2)) = ⊤ := by
  let P : Submodule R (Tensor22 R) := Submodule.span R
    (Set.range (fun uv : (Fin 2 → R) × (Fin 2 → R) =>
      pureTensor uv.1 uv.2))
  have hp (u v : Fin 2 → R) : pureTensor u v ∈ P :=
    Submodule.subset_span ⟨(u, v), rfl⟩
  apply top_unique
  intro M _
  have hm : M = (M 0 0) • pureTensor ![1, 0] ![1, 0] +
      (M 0 1) • pureTensor ![1, 0] ![0, 1] +
      (M 1 0) • pureTensor ![0, 1] ![1, 0] +
      (M 1 1) • pureTensor ![0, 1] ![0, 1] := by
    ext i j
    fin_cases i <;> fin_cases j <;> simp [pureTensor]
  rw [hm]
  exact P.add_mem (P.add_mem (P.add_mem
    (P.smul_mem _ (hp _ _)) (P.smul_mem _ (hp _ _)))
    (P.smul_mem _ (hp _ _))) (P.smul_mem _ (hp _ _))

end TensorRankTwo

end IUTThreeClosures.ReachableTensorLatticeCriterion
