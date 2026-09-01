/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Determinant
import Mathlib.LinearAlgebra.FreeModule.Finite.Quotient
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.Ideal.Norm.AbsNorm
import Mathlib.Topology.Algebra.Ring.Basic
import IUTThreeClosures.FiniteIndexHaarCorrection

/-!
# Actual reachable determinants over a discrete valuation ring

The mathematical proofs precede this file in
`research/DVR_REACHABLE_HAAR_CONTINUATION_2026_08_30.md`.

We use actual matrix images, submodule spans, quotient cardinalities and
translation invariant measures. No IUT reachability assertion or ABC
conclusion is assumed or introduced as an axiom.
-/

namespace IUTThreeClosures.DVRReachableHaar20260830

open Matrix Module Submodule IsDiscreteValuationRing
open scoped BigOperators ENNReal

section Cramer

variable {R : Type*} [CommRing R] [IsDomain R]
variable {n : Type*} [Fintype n] [DecidableEq n]

/-- Integral solvability follows when every Cramer numerator is divisible
by the nonzero determinant. -/
theorem mem_range_of_det_dvd_cramer
    (A : Matrix n n R) (hA : A.det ≠ 0) (s : n → R)
    (hdiv : ∀ j, A.det ∣ (A.updateCol j s).det) :
    s ∈ LinearMap.range A.mulVecLin := by
  classical
  choose x hx using hdiv
  have hcr : A.cramer s = A.det • x := by
    ext j
    exact hx j
  have heq := Matrix.mulVec_cramer A s
  rw [hcr, Matrix.mulVec_smul] at heq
  refine ⟨x, ?_⟩
  ext j
  exact mul_left_cancel₀ hA (congrFun heq j)

/-- A determinant that divides all determinants of reachable columns
generates their entire integral span; it need not be a unit. -/
theorem span_eq_range_of_reachable_det_dvd
    (S : Set (n → R)) (A : Matrix n n R)
    (hcol : ∀ j, A.col j ∈ S) (hA : A.det ≠ 0)
    (hdiv : ∀ B : Matrix n n R, (∀ j, B.col j ∈ S) → A.det ∣ B.det) :
    Submodule.span R S = LinearMap.range A.mulVecLin := by
  apply le_antisymm
  · apply Submodule.span_le.mpr
    intro s hs
    apply mem_range_of_det_dvd_cramer A hA s
    intro j
    apply hdiv
    intro k
    by_cases hkj : k = j
    · subst k
      have heq : (A.updateCol j s).col j = s := by
        ext i
        exact Matrix.updateCol_self
      simpa only [heq] using hs
    · have heq : (A.updateCol j s).col k = A.col k := by
        ext i
        exact Matrix.updateCol_ne hkj
      simpa only [heq] using hcol k
  · rw [Matrix.range_mulVecLin]
    apply Submodule.span_mono
    rintro s ⟨j, rfl⟩
    exact hcol j

end Cramer

section Minimum

variable {R : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
variable {n : Type*} [Fintype n] [DecidableEq n]

/-- If reachable columns have full rank, an actual matrix attains the
minimum finite determinant valuation and generates the whole span. -/
theorem exists_reachable_min_det_span
    (S : Set (n → R))
    (hfull : ∃ A : Matrix n n R, (∀ j, A.col j ∈ S) ∧ A.det ≠ 0) :
    ∃ (d : ℕ) (A : Matrix n n R),
      (∀ j, A.col j ∈ S) ∧ A.det ≠ 0 ∧ addVal R A.det = d ∧
      (∀ B : Matrix n n R, (∀ j, B.col j ∈ S) → A.det ∣ B.det) ∧
      Submodule.span R S = LinearMap.range A.mulVecLin := by
  classical
  let P : ℕ → Prop := fun d =>
    ∃ A : Matrix n n R, (∀ j, A.col j ∈ S) ∧ A.det ≠ 0 ∧ addVal R A.det = d
  have hex : ∃ d, P d := by
    obtain ⟨A, hcol, hA⟩ := hfull
    obtain ⟨d, hd⟩ := ENat.ne_top_iff_exists.mp (mt addVal_eq_top_iff.mp hA)
    exact ⟨d, A, hcol, hA, hd.symm⟩
  obtain ⟨A, hcol, hA, hd⟩ := Nat.find_spec hex
  have hdiv : ∀ B : Matrix n n R, (∀ j, B.col j ∈ S) → A.det ∣ B.det := by
    intro B hB
    by_cases hB0 : B.det = 0
    · rw [hB0]
      exact dvd_zero _
    obtain ⟨e, he⟩ := ENat.ne_top_iff_exists.mp (mt addVal_eq_top_iff.mp hB0)
    have hle : Nat.find hex ≤ e := Nat.find_min' hex ⟨B, hB, hB0, he.symm⟩
    apply addVal_le_iff_dvd.mp
    rw [hd, ← he]
    exact_mod_cast hle
  exact ⟨Nat.find hex, A, hcol, hA, hd, hdiv,
    span_eq_range_of_reachable_det_dvd S A hcol hA hdiv⟩

end Minimum

section Index

variable {R : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]

/-- The finite residue cardinality is kept as an actual quotient cardinality. -/
noncomputable def residueCard (R : Type*) [CommRing R] [IsLocalRing R] : ℕ :=
  Submodule.cardQuot (IsLocalRing.maximalIdeal R)

/-- A nonzero principal ideal has the expected residue-power index. -/
theorem cardQuot_span_eq_pow_addVal (a : R) (ha : a ≠ 0) :
    Submodule.cardQuot (Ideal.span ({a} : Set R)) =
      residueCard R ^ (addVal R a).toNat := by
  obtain ⟨π, hπ⟩ := exists_irreducible R
  obtain ⟨e, u, hu⟩ := eq_unit_mul_pow_irreducible ha hπ
  have hm : IsLocalRing.maximalIdeal R ≠ ⊥ := by
    rw [hπ.maximalIdeal_eq]
    exact mt Ideal.span_singleton_eq_bot.mp hπ.ne_zero
  rw [hu, addVal_def' u hπ, ENat.toNat_coe,
    Ideal.span_singleton_mul_left_unit u.isUnit,
    ← Ideal.span_singleton_pow, ← hπ.maximalIdeal_eq]
  exact cardQuot_pow_of_prime hm

/-- Valuations of a finite nonzero product add, including after conversion
from extended natural values to natural numbers. -/
theorem addVal_prod_toNat {ι : Type*} (s : Finset ι) (a : ι → R)
    (ha : ∀ i ∈ s, a i ≠ 0) :
    (addVal R (∏ i ∈ s, a i)).toNat = ∑ i ∈ s, (addVal R (a i)).toNat := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | @insert i s hi ih =>
    have hai := ha i (Finset.mem_insert_self i s)
    have has : ∀ j ∈ s, a j ≠ 0 := fun j hj => ha j (Finset.mem_insert_of_mem hj)
    have hp : (∏ j ∈ s, a j) ≠ 0 := Finset.prod_ne_zero_iff.mpr has
    rw [Finset.prod_insert hi, addVal_mul,
      ENat.toNat_add (mt addVal_eq_top_iff.mp hai) (mt addVal_eq_top_iff.mp hp),
      Finset.sum_insert hi, ih has]

/-- Smith normal form turns an actual full-rank quotient into the valuation
of the determinant of any integral parametrization of that submodule. -/
theorem cardQuot_eq_pow_det_of_equiv
    {M : Type*} [AddCommGroup M] [Module R M]
    [Module.Free R M] [Module.Finite R M]
    (N : Submodule R M) (e : M ≃ₗ[R] N) :
    Submodule.cardQuot N = residueCard R ^
      (addVal R (LinearMap.det (N.subtype ∘ₗ (e : M →ₗ[R] N)))).toNat := by
  classical
  let b := Module.Free.chooseBasis R M
  have h : Module.finrank R N = Module.finrank R M := e.symm.finrank_eq
  let a := smithNormalFormCoeffs b h
  let b' := smithNormalFormTopBasis b h
  let ab := smithNormalFormBotBasis b h
  let e' : M ≃ₗ[R] N := b'.equiv ab (Equiv.refl _)
  let f : M →ₗ[R] M := N.subtype.comp (e' : M →ₗ[R] N)
  have ha : ∀ i, f (b' i) = a i • b' i := by
    intro i
    change (b'.equiv ab (Equiv.refl _) (b' i) : M) = _
    rw [b'.equiv_apply, Equiv.refl_apply]
    exact smithNormalFormBotBasis_def b h i
  have hf : LinearMap.toMatrix b' b' f = Matrix.diagonal a := by
    ext i j
    rw [LinearMap.toMatrix_apply, ha, map_smul, Basis.repr_self,
      Finsupp.smul_single, smul_eq_mul, mul_one]
    by_cases hij : i = j
    · rw [hij, Matrix.diagonal_apply_eq, Finsupp.single_eq_same]
    · rw [Matrix.diagonal_apply_ne _ hij, Finsupp.single_eq_of_ne hij]
  have hdetf : LinearMap.det f = ∏ i, a i := by
    rw [← LinearMap.det_toMatrix b', hf, Matrix.det_diagonal]
  have hv : addVal R (LinearMap.det (N.subtype ∘ₗ (e : M →ₗ[R] N))) =
      addVal R (∏ i, a i) := by
    rw [← hdetf]
    exact (addVal_eq_iff_associated _ _).mpr
      (LinearMap.associated_det_comp_equiv N.subtype e e')
  have hnz : ∀ i, a i ≠ 0 := smithNormalFormCoeffs_ne_zero b h
  rw [hv, addVal_prod_toNat _ a (fun i _ => hnz i),
    Submodule.cardQuot_apply,
    Nat.card_congr (N.quotientEquivPiSpan b h).toEquiv, Nat.card_pi]
  calc
    _ = ∏ i, residueCard R ^ (addVal R (a i)).toNat := by
      apply Finset.prod_congr rfl
      intro i _
      exact cardQuot_span_eq_pow_addVal (a i) (hnz i)
    _ = _ := Finset.prod_pow_eq_pow_sum _ _ _

/-- The index formula for the image of a nonsingular integral matrix. -/
theorem cardQuot_matrix_range
    {n : Type*} [Fintype n] [DecidableEq n]
    (A : Matrix n n R) (hA : A.det ≠ 0) :
    Submodule.cardQuot (LinearMap.range A.mulVecLin) =
      residueCard R ^ (addVal R A.det).toNat := by
  let e := LinearEquiv.ofInjective A.mulVecLin
    (Matrix.mulVec_injective_iff.mpr (Matrix.linearIndependent_cols_of_det_ne_zero hA))
  have h := cardQuot_eq_pow_det_of_equiv (LinearMap.range A.mulVecLin) e
  change Submodule.cardQuot (LinearMap.range A.mulVecLin) =
    residueCard R ^ (addVal R (LinearMap.det (Matrix.toLin' A))).toNat at h
  simpa only [LinearMap.det_toLin'] using h

end Index

section TopologyAndMeasure

open MeasureTheory Set

variable {R : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
variable {n : Type*} [Fintype n] [DecidableEq n]
variable [TopologicalSpace R] [IsTopologicalRing R] [CompactSpace R] [T2Space R]

omit [IsDomain R] [IsDiscreteValuationRing R] [DecidableEq n] in
/-- The integral matrix image is already closed, by compactness. -/
theorem matrix_range_isClosed (A : Matrix n n R) :
    IsClosed (LinearMap.range A.mulVecLin : Set (n → R)) := by
  have hc : Continuous A.mulVecLin := by
    apply continuous_pi
    intro i
    change Continuous (fun x : n → R => ∑ j, A i j * x j)
    exact continuous_finsetSum _ (fun j _ => continuous_const.mul (continuous_apply j))
  change IsClosed (Set.range A.mulVecLin)
  exact (isCompact_range hc).isClosed

variable [MeasurableSpace (n → R)] [BorelSpace (n → R)] [MeasurableAdd (n → R)]
variable [Finite (IsLocalRing.ResidueField R)]

omit [TopologicalSpace R] [IsTopologicalRing R] [CompactSpace R] [T2Space R] in
theorem residueCard_pos : 0 < residueCard R := by
  change 0 < Nat.card (IsLocalRing.ResidueField R)
  exact Nat.card_pos

/-- Actual normalized Haar measure of a nonsingular integral matrix image. -/
theorem measure_matrix_range
    (μ : Measure (n → R)) [Measure.IsAddLeftInvariant μ]
    (hnorm : μ Set.univ = 1) (A : Matrix n n R) (hA : A.det ≠ 0) :
    μ (LinearMap.range A.mulVecLin : Set (n → R)) =
      ((residueCard R : ℝ≥0∞) ^ (addVal R A.det).toNat)⁻¹ := by
  let H := (LinearMap.range A.mulVecLin).toAddSubgroup
  have hindex : H.index = residueCard R ^ (addVal R A.det).toNat :=
    cardQuot_matrix_range A hA
  letI : H.FiniteIndex := ⟨by rw [hindex]; exact pow_ne_zero _ (residueCard_pos.ne')⟩
  have heq := finiteIndex_index_mul_measure_eq_one μ H
    (matrix_range_isClosed A).measurableSet hnorm
  have hinv := ENNReal.eq_inv_of_mul_eq_one_left (mul_comm _ _ |>.trans heq)
  simpa only [hindex, Nat.cast_pow, H, Submodule.coe_toAddSubgroup] using hinv

/-- The determinant valuation gives the logarithmic volume, with no
unproved measure-change constant. -/
theorem log_measure_matrix_range
    (μ : Measure (n → R)) [Measure.IsAddLeftInvariant μ]
    (hnorm : μ Set.univ = 1) (A : Matrix n n R) (hA : A.det ≠ 0) :
    Real.log (μ (LinearMap.range A.mulVecLin : Set (n → R))).toReal =
      -((addVal R A.det).toNat : ℝ) * Real.log (residueCard R : ℝ) := by
  let H := (LinearMap.range A.mulVecLin).toAddSubgroup
  have hindex : H.index = residueCard R ^ (addVal R A.det).toNat :=
    cardQuot_matrix_range A hA
  letI : H.FiniteIndex := ⟨by rw [hindex]; exact pow_ne_zero _ (residueCard_pos.ne')⟩
  have heq := finiteIndex_log_measure_eq_neg_log_index μ H
    (matrix_range_isClosed A).measurableSet hnorm
  simpa only [hindex, Nat.cast_pow, Real.log_pow, neg_mul, H,
    Submodule.coe_toAddSubgroup] using heq

/-- Full-rank reachable columns attain the exact closed-span Haar volume.
The matrix is selected from the original set, not an enlarged orbit. -/
theorem exists_reachable_closed_span_volume
    (μ : Measure (n → R)) [Measure.IsAddLeftInvariant μ]
    (hnorm : μ Set.univ = 1) (S : Set (n → R))
    (hfull : ∃ A : Matrix n n R, (∀ j, A.col j ∈ S) ∧ A.det ≠ 0) :
    ∃ (d : ℕ) (A : Matrix n n R),
      (∀ j, A.col j ∈ S) ∧ A.det ≠ 0 ∧ addVal R A.det = d ∧
      (∀ B : Matrix n n R, (∀ j, B.col j ∈ S) → A.det ∣ B.det) ∧
      Submodule.span R S = LinearMap.range A.mulVecLin ∧
      IsClosed (Submodule.span R S : Set (n → R)) ∧
      μ (closure (Submodule.span R S : Set (n → R))) =
        ((residueCard R : ℝ≥0∞) ^ d)⁻¹ ∧
      Real.log (μ (closure (Submodule.span R S : Set (n → R)))).toReal =
        -(d : ℝ) * Real.log (residueCard R : ℝ) := by
  obtain ⟨d, A, hcol, hA, hd, hdiv, hspan⟩ := exists_reachable_min_det_span S hfull
  have hc : IsClosed (Submodule.span R S : Set (n → R)) := by
    rw [hspan]
    exact matrix_range_isClosed A
  refine ⟨d, A, hcol, hA, hd, hdiv, hspan, hc, ?_, ?_⟩
  · rw [hc.closure_eq, hspan, measure_matrix_range μ hnorm A hA, hd, ENat.toNat_coe]
  · rw [hc.closure_eq, hspan, log_measure_matrix_range μ hnorm A hA, hd, ENat.toNat_coe]

end TopologyAndMeasure

end IUTThreeClosures.DVRReachableHaar20260830
