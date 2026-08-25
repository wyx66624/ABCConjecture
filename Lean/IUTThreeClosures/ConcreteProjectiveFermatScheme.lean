/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ConcreteAffineFermatJacobian
import Mathlib.AlgebraicGeometry.ProjectiveSpectrum.Basic

/-!
# The projective Fermat scheme and its coordinate charts

Let `K` be a field, let `P = K[X₀,X₁,X₂]` with its total-degree grading, and put

`Fₙ = X₀^n + X₁^n - X₂^n`.

Mathematically, `Fₙ` is homogeneous of degree `n`, so `(Fₙ)` is a homogeneous
ideal.  Consequently the quotient `P/(Fₙ)` inherits the grading whose degree
`d` part is the image of `P_d`.  This file constructs that quotient grading
directly (Mathlib currently has no packaged quotient-grading constructor),
defines the genuine scheme `Proj(P/(Fₙ))`, and constructs its three coordinate
standard opens.

The later chart comparison is made on coordinate rings: on the `X₂`-chart the
degree-zero fractions `X₀/X₂` and `X₁/X₂` satisfy the affine Fermat equation.
The analogous statements on the other two charts follow by permuting the
coordinates.

This is a scheme-level construction, but this file does not claim scheme
smoothness merely from pointwise nonsingularity.  A scheme-smoothness theorem
requires transporting the affine smooth presentations through the chart
comparison isomorphisms (or a scheme-level Jacobian criterion).
-/

namespace IUTThreeClosures
namespace ConcreteProjectiveFermatScheme

noncomputable section

open MvPolynomial

universe u

variable (K : Type u) [Field K]

attribute [local instance] MvPolynomial.gradedAlgebra

/-- The homogeneous three-variable Fermat relation. -/
def projectiveRelation (n : ℕ) : MvPolynomial (Fin 3) K :=
  X (0 : Fin 3) ^ n + X (1 : Fin 3) ^ n - X (2 : Fin 3) ^ n

/-- The projective Fermat relation is homogeneous of degree `n`. -/
theorem projectiveRelation_isHomogeneous (n : ℕ) :
    (projectiveRelation K n).IsHomogeneous n := by
  simpa [projectiveRelation] using
    (((isHomogeneous_X K (0 : Fin 3)).pow n).add
      ((isHomogeneous_X K (1 : Fin 3)).pow n) |>.sub
        ((isHomogeneous_X K (2 : Fin 3)).pow n))

/-- The principal homogeneous Fermat ideal. -/
def projectiveIdeal (n : ℕ) : Ideal (MvPolynomial (Fin 3) K) :=
  Ideal.span {projectiveRelation K n}

/-- The Fermat ideal is homogeneous for the total-degree grading. -/
theorem projectiveIdeal_isHomogeneous (n : ℕ) :
    (projectiveIdeal K n).IsHomogeneous
      (homogeneousSubmodule (Fin 3) K) := by
  apply Ideal.homogeneous_span
  rintro f (rfl : f = projectiveRelation K n)
  exact ⟨n, projectiveRelation_isHomogeneous K n⟩

/-- The homogeneous coordinate ring of the projective Fermat curve. -/
abbrev ProjectiveFermatRing (n : ℕ) :=
  MvPolynomial (Fin 3) K ⧸ projectiveIdeal K n

/-- The quotient map to the homogeneous coordinate ring. -/
abbrev projectiveQuotientMap (n : ℕ) :
    MvPolynomial (Fin 3) K →ₐ[K] ProjectiveFermatRing K n :=
  Ideal.Quotient.mkₐ K (projectiveIdeal K n)

/-- Degree `d` in the quotient is the image of degree `d` upstairs. -/
def quotientGrade (n d : ℕ) : Submodule K (ProjectiveFermatRing K n) :=
  (homogeneousSubmodule (Fin 3) K d).map
    (projectiveQuotientMap K n).toLinearMap

/-- A homogeneous polynomial maps to the corresponding quotient degree. -/
theorem mem_quotientGrade_of_isHomogeneous {n d : ℕ}
    {f : MvPolynomial (Fin 3) K} (hf : f.IsHomogeneous d) :
    projectiveQuotientMap K n f ∈ quotientGrade K n d := by
  exact ⟨f, hf, rfl⟩

/-- The image of `1` has quotient degree zero. -/
theorem one_mem_quotientGrade (n : ℕ) :
    (1 : ProjectiveFermatRing K n) ∈ quotientGrade K n 0 := by
  simpa using mem_quotientGrade_of_isHomogeneous (K := K) (n := n)
    (isHomogeneous_one (σ := Fin 3) (R := K))

/-- Products of quotient-homogeneous elements have the sum degree. -/
theorem mul_mem_quotientGrade {n i j : ℕ}
    {x y : ProjectiveFermatRing K n}
    (hx : x ∈ quotientGrade K n i) (hy : y ∈ quotientGrade K n j) :
    x * y ∈ quotientGrade K n (i + j) := by
  rcases hx with ⟨a, ha, rfl⟩
  rcases hy with ⟨b, hb, rfl⟩
  exact ⟨a * b, ha.mul hb, by simp⟩

/-- The quotient degree pieces respect multiplication. -/
instance quotientGrade_gradedMonoid (n : ℕ) :
    SetLike.GradedMonoid (quotientGrade K n) where
  one_mem := one_mem_quotientGrade K n
  mul_mem := by
    intro i j x y hx hy
    exact mul_mem_quotientGrade K hx hy

/-- The quotient degree pieces span the whole quotient. -/
theorem iSup_quotientGrade_eq_top (n : ℕ) :
    iSup (quotientGrade K n) = ⊤ := by
  apply top_unique
  rintro x -
  obtain ⟨p, rfl⟩ := Ideal.Quotient.mkₐ_surjective K (projectiveIdeal K n) x
  rw [← sum_homogeneousComponent p]
  simp only [map_sum]
  exact Submodule.sum_mem _ fun d _ =>
    Submodule.mem_iSup_of_mem d
      (mem_quotientGrade_of_isHomogeneous
        (K := K) (n := n) (homogeneousComponent_isHomogeneous d _))

/-- Homogeneous relations introduce no cancellation between distinct quotient
degrees. -/
theorem quotientGrade_iSupIndep (n : ℕ) :
    iSupIndep (quotientGrade K n) := by
  classical
  rw [iSupIndep_iff_finsetSum_eq_zero_imp_eq_zero]
  intro s v hv hsum i hi
  let p : ℕ → MvPolynomial (Fin 3) K := fun d =>
    if hd : d ∈ s then Classical.choose (hv d hd) else 0
  have hp_deg (d : ℕ) (hd : d ∈ s) :
      (p d).IsHomogeneous d := by
    dsimp [p]
    rw [dif_pos hd]
    exact (Classical.choose_spec (hv d hd)).1
  have hp_map (d : ℕ) (hd : d ∈ s) :
      projectiveQuotientMap K n (p d) = v d := by
    dsimp [p]
    rw [dif_pos hd]
    exact (Classical.choose_spec (hv d hd)).2
  have hqsum :
      projectiveQuotientMap K n (∑ d ∈ s, p d) = 0 := by
    calc
      projectiveQuotientMap K n (∑ d ∈ s, p d) =
          ∑ d ∈ s, projectiveQuotientMap K n (p d) := by simp
      _ = ∑ d ∈ s, v d := by
        apply Finset.sum_congr rfl
        intro d hd
        exact hp_map d hd
      _ = 0 := hsum
  have hIdeal : (∑ d ∈ s, p d) ∈ projectiveIdeal K n := by
    rw [← Ideal.Quotient.eq_zero_iff_mem]
    exact hqsum
  have hcomponent :
      homogeneousComponent i (∑ d ∈ s, p d) ∈ projectiveIdeal K n :=
    homogeneousComponent_mem_of_mem
      (projectiveIdeal_isHomogeneous K n) hIdeal i
  have hcomponent_eq :
      homogeneousComponent i (∑ d ∈ s, p d) = p i := by
    simp only [map_sum]
    refine (Finset.sum_eq_single i ?_ ?_).trans ?_
    · intro j hj hji
      rw [homogeneousComponent_of_mem (hp_deg j hj), if_neg (Ne.symm hji)]
    · intro hnot
      exact (hnot hi).elim
    · exact homogeneousComponent_eq_self (hp_deg i hi)
  have hpi : p i ∈ projectiveIdeal K n := hcomponent_eq ▸ hcomponent
  rw [← hp_map i hi]
  change Ideal.Quotient.mk (projectiveIdeal K n) (p i) = 0
  rw [Ideal.Quotient.eq_zero_iff_mem]
  exact hpi

/-- The homogeneous quotient really is the direct sum of its quotient degree
pieces. -/
theorem quotientGrade_isInternal (n : ℕ) :
    DirectSum.IsInternal (quotientGrade K n) :=
  DirectSum.isInternal_submodule_of_iSupIndep_of_iSup_eq_top
    (quotientGrade_iSupIndep K n) (iSup_quotientGrade_eq_top K n)

/-- The direct-sum decomposition on the homogeneous coordinate ring. -/
noncomputable instance quotientGrade_decomposition (n : ℕ) :
    DirectSum.Decomposition (quotientGrade K n) :=
  (quotientGrade_isInternal K n).chooseDecomposition

/-- The homogeneous coordinate ring with its genuine quotient grading. -/
noncomputable instance quotientGrade_gradedAlgebra (n : ℕ) :
    GradedAlgebra (quotientGrade K n) where
  toDecomposition := quotientGrade_decomposition K n
  toGradedMonoid := quotientGrade_gradedMonoid K n

/-- The image of the `i`th projective coordinate in the homogeneous quotient. -/
def coordinate (n : ℕ) (i : Fin 3) : ProjectiveFermatRing K n :=
  projectiveQuotientMap K n (X i)

/-- Each projective coordinate has degree one in the quotient grading. -/
theorem coordinate_mem_degree_one (n : ℕ) (i : Fin 3) :
    coordinate K n i ∈ quotientGrade K n 1 := by
  exact mem_quotientGrade_of_isHomogeneous (K := K) (n := n)
    (isHomogeneous_X K i)

/-- The three homogeneous quotient coordinates satisfy the Fermat equation. -/
theorem coordinate_fermat_equation (n : ℕ) :
    coordinate K n 0 ^ n + coordinate K n 1 ^ n =
      coordinate K n 2 ^ n := by
  have hzero :
      projectiveQuotientMap K n (projectiveRelation K n) = 0 := by
    change Ideal.Quotient.mk (projectiveIdeal K n)
      (projectiveRelation K n) = 0
    rw [Ideal.Quotient.eq_zero_iff_mem]
    exact Ideal.subset_span (Set.mem_singleton _)
  simpa only [projectiveRelation, coordinate, map_sub, map_add, map_pow,
    sub_eq_zero] using hzero

/-- The three coordinate images generate the homogeneous quotient as an
algebra over its degree-zero part. -/
theorem coordinate_adjoin_eq_top (n : ℕ) :
    Algebra.adjoin (quotientGrade K n 0) (Set.range (coordinate K n)) = ⊤ := by
  let S := Algebra.adjoin (quotientGrade K n 0) (Set.range (coordinate K n))
  apply top_unique
  rintro x -
  obtain ⟨p, rfl⟩ := Ideal.Quotient.mkₐ_surjective K (projectiveIdeal K n) x
  induction p using MvPolynomial.induction_on with
  | C r =>
      let r0 : quotientGrade K n 0 :=
        ⟨projectiveQuotientMap K n (C r),
          mem_quotientGrade_of_isHomogeneous (K := K) (n := n)
            (isHomogeneous_C (σ := Fin 3) r)⟩
      simpa [S, r0] using
        (S.algebraMap_mem r0)
  | add p q hp hq =>
      simpa only [map_add] using S.add_mem hp hq
  | mul_X p i hp =>
      simpa only [map_mul, coordinate] using
        S.mul_mem hp (Algebra.subset_adjoin (Set.mem_range_self i))

/-- The genuine projective Fermat scheme `Proj K[X₀,X₁,X₂]/(Fₙ)`. -/
def projectiveFermatScheme (n : ℕ) : AlgebraicGeometry.Scheme :=
  AlgebraicGeometry.Proj (quotientGrade K n)

/-- The coordinate standard open `D₊(Xᵢ)` in the projective Fermat scheme. -/
def coordinateOpen (n : ℕ) (i : Fin 3) :
    (projectiveFermatScheme K n).Opens :=
  AlgebraicGeometry.Proj.basicOpen (quotientGrade K n) (coordinate K n i)

/-- The three coordinate standard opens cover the projective Fermat scheme. -/
theorem iSup_coordinateOpen_eq_top (n : ℕ) :
    ⨆ i : Fin 3, coordinateOpen K n i = ⊤ := by
  apply AlgebraicGeometry.Proj.iSup_basicOpen_eq_top'
  · intro i
    exact ⟨1, coordinate_mem_degree_one K n i⟩
  · exact coordinate_adjoin_eq_top K n

/-- Each coordinate standard open is canonically affine: its restriction is
the spectrum of the degree-zero homogeneous localization at that coordinate. -/
noncomputable def coordinateOpenIsoSpec (n : ℕ) (i : Fin 3) :=
  AlgebraicGeometry.Proj.basicOpenIsoSpec
    (quotientGrade K n) (coordinate K n i)
    (coordinate_mem_degree_one K n i) Nat.zero_lt_one

/-- The canonical affine chart morphism is an open immersion with range the
corresponding coordinate standard open. -/
noncomputable def coordinateAwayι (n : ℕ) (i : Fin 3) :=
  AlgebraicGeometry.Proj.awayι
    (quotientGrade K n) (coordinate K n i)
    (coordinate_mem_degree_one K n i) Nat.zero_lt_one

instance coordinateAwayι_isOpenImmersion (n : ℕ) (i : Fin 3) :
    AlgebraicGeometry.IsOpenImmersion (coordinateAwayι K n i) := by
  dsimp [coordinateAwayι]
  infer_instance

theorem coordinateAwayι_opensRange (n : ℕ) (i : Fin 3) :
    (coordinateAwayι K n i).opensRange = coordinateOpen K n i := by
  exact AlgebraicGeometry.Proj.opensRange_awayι
    (quotientGrade K n) (coordinate K n i)
      (coordinate_mem_degree_one K n i) Nat.zero_lt_one

/-- The coordinate ring of the standard chart `D₊(X_den)`. -/
abbrev CoordinateChartRing (n : ℕ) (den : Fin 3) :=
  HomogeneousLocalization.Away (quotientGrade K n) (coordinate K n den)

/-- The degree-zero ratio `X_num / X_den` on a coordinate chart. -/
def chartRatio (n : ℕ) (num den : Fin 3) :
    CoordinateChartRing K n den :=
  HomogeneousLocalization.Away.mk
    (quotientGrade K n) (coordinate_mem_degree_one K n den) 1
      (coordinate K n num) (by simpa using coordinate_mem_degree_one K n num)

/-- On the `X₂ ≠ 0` chart, the two affine coordinate ratios satisfy the
inhomogeneous Fermat equation. -/
theorem chartTwo_fermat_equation (n : ℕ) :
    chartRatio K n 0 2 ^ n + chartRatio K n 1 2 ^ n = 1 := by
  apply HomogeneousLocalization.val_injective
  simp only [chartRatio, HomogeneousLocalization.val_add,
    HomogeneousLocalization.val_pow, HomogeneousLocalization.Away.val_mk,
    HomogeneousLocalization.val_one, Localization.mk_pow]
  rw [Localization.add_mk_self, coordinate_fermat_equation]
  rw [Localization.mk_eq_mk']
  simpa only [SubmonoidClass.coe_pow, pow_one] using
    (IsLocalization.mk'_self'
      (R := ProjectiveFermatRing K n)
      (M := Submonoid.powers (coordinate K n 2))
      (S := Localization (Submonoid.powers (coordinate K n 2)))
      (x := (⟨coordinate K n 2 ^ 1, ⟨1, rfl⟩⟩ :
        Submonoid.powers (coordinate K n 2)) ^ n))

end
end ConcreteProjectiveFermatScheme
end IUTThreeClosures
