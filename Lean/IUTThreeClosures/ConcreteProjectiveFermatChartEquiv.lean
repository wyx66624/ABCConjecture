/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ConcreteProjectiveFermatScheme

/-!
# The affine Fermat presentation of the `X₂` projective chart

Let `A = K[X₀,X₁,X₂]/(X₀^n+X₁^n-X₂^n)` with its quotient
grading, and let `B=A_(x₂)` be the degree-zero homogeneous localization.
This file constructs the explicit equivalence

`K[u,v]/(u^n+v^n-1) ≃ₐ[K] B`.

The forward map sends `u,v` to `x₀/x₂,x₁/x₂`.  For the reverse map,
we evaluate the homogeneous coordinates at `(u,v,1)`, descend through the
projective relation, extend to the ordinary localization at `x₂`, and then
restrict to its degree-zero subring.  The inverse law on the chart uses the
homogeneous-Away generation theorem, not an assumed field or a pointwise
Jacobian statement.

In characteristic zero and positive exponent, the already established
smoothness of the affine Fermat quotient is transported across this explicit
equivalence.  No claim about normality, properness, boundary DVRs, or
scheme-level smoothness is made here.
-/

namespace IUTThreeClosures
namespace ConcreteProjectiveFermatChartEquiv

noncomputable section

open MvPolynomial

universe u

variable (K : Type u) [Field K]

namespace P

abbrev Ring := ConcreteProjectiveFermatScheme.ProjectiveFermatRing
abbrev Grade := ConcreteProjectiveFermatScheme.quotientGrade
abbrev coordinate := ConcreteProjectiveFermatScheme.coordinate
abbrev Chart := ConcreteProjectiveFermatScheme.CoordinateChartRing
abbrev ratio := ConcreteProjectiveFermatScheme.chartRatio

end P

namespace J

abbrev Ideal := ConcreteAffineFermatJacobian.fermatRelationIdeal
abbrev Ring := ConcreteAffineFermatJacobian.FermatJacobianRing

abbrev quotientAlgHom (n : ℕ) :
    MvPolynomial (Fin 2) K →ₐ[K] Ring K n :=
  Ideal.Quotient.mkₐ K (Ideal K n)

def x (n : ℕ) : Ring K n := quotientAlgHom K n (X 0)
def y (n : ℕ) : Ring K n := quotientAlgHom K n (X 1)

end J

/-! ## The canonical `K`-algebra structure on a homogeneous chart -/

/-- The scalar map to a chart factors through the degree-zero quotient piece
and then through the homogeneous localization. -/
noncomputable instance coordinateChartAlgebra (n : ℕ) (den : Fin 3) :
    Algebra K (P.Chart K n den) :=
  ((HomogeneousLocalization.fromZeroRingHom
      (P.Grade K n) (Submonoid.powers (P.coordinate K n den))).comp
    (algebraMap K (P.Grade K n 0))).toAlgebra

/-! ## From the affine quotient to the homogeneous chart -/

/-- The two chart ratios used to evaluate the affine variables. -/
def chartTwoCoordinates (n : ℕ) : Fin 2 → P.Chart K n 2 :=
  ![P.ratio K n 0 2, P.ratio K n 1 2]

/-- Evaluate the affine polynomial variables at the two projective ratios. -/
def affinePolynomialToChart (n : ℕ) :
    MvPolynomial (Fin 2) K →ₐ[K] P.Chart K n 2 :=
  MvPolynomial.aeval (chartTwoCoordinates K n)

@[simp]
theorem affinePolynomialToChart_X_zero (n : ℕ) :
    affinePolynomialToChart K n (X 0) = P.ratio K n 0 2 := by
  simp [affinePolynomialToChart, chartTwoCoordinates]

@[simp]
theorem affinePolynomialToChart_X_one (n : ℕ) :
    affinePolynomialToChart K n (X 1) = P.ratio K n 1 2 := by
  simp [affinePolynomialToChart, chartTwoCoordinates]

/-- The affine Fermat relation vanishes after evaluation at the chart
ratios. -/
theorem affinePolynomialToChart_relation_eq_zero (n : ℕ) :
    affinePolynomialToChart K n
      (ConcreteAffineFermatJacobian.fermatRelation K n) = 0 := by
  rw [ConcreteAffineFermatJacobian.fermatRelation,
    ConcreteAffineFermatJacobian.fermatX,
    ConcreteAffineFermatJacobian.fermatY,
    map_sub, map_add, map_pow, map_pow,
    affinePolynomialToChart_X_zero, affinePolynomialToChart_X_one, map_one]
  exact sub_eq_zero.mpr
    (ConcreteProjectiveFermatScheme.chartTwo_fermat_equation K n)

/-- Evaluation at the ratios kills the whole affine Fermat ideal. -/
theorem affineIdeal_le_ker_affinePolynomialToChart (n : ℕ) :
    J.Ideal K n ≤ RingHom.ker (affinePolynomialToChart K n).toRingHom := by
  rw [J.Ideal, ConcreteAffineFermatJacobian.fermatRelationIdeal]
  apply Ideal.span_le.mpr
  rintro _ ⟨_i, rfl⟩
  simpa [ConcreteAffineFermatJacobian.fermatRelationFamily] using
    affinePolynomialToChart_relation_eq_zero K n

/-- The forward map `Q_n → B_n`, sending the two affine coordinates to the
two homogeneous ratios. -/
def affineToChart (n : ℕ) : J.Ring K n →ₐ[K] P.Chart K n 2 :=
  Ideal.Quotient.liftₐ (J.Ideal K n) (affinePolynomialToChart K n)
    (fun _p hp => affineIdeal_le_ker_affinePolynomialToChart K n hp)

@[simp]
theorem affineToChart_x (n : ℕ) :
    affineToChart K n (J.x K n) = P.ratio K n 0 2 := by
  simp [affineToChart, J.x, J.quotientAlgHom]

@[simp]
theorem affineToChart_y (n : ℕ) :
    affineToChart K n (J.y K n) = P.ratio K n 1 2 := by
  simp [affineToChart, J.y, J.quotientAlgHom]

/-! ## Evaluation of the projective ring at `(u,v,1)` -/

/-- The target coordinates for dehomogenization at `X₂=1`. -/
def projectiveEvaluationCoordinates (n : ℕ) : Fin 3 → J.Ring K n :=
  ![J.x K n, J.y K n, 1]

/-- Evaluate a homogeneous polynomial at `(u,v,1)`. -/
def projectivePolynomialToAffine (n : ℕ) :
    MvPolynomial (Fin 3) K →ₐ[K] J.Ring K n :=
  MvPolynomial.aeval (projectiveEvaluationCoordinates K n)

@[simp]
theorem projectivePolynomialToAffine_X_zero (n : ℕ) :
    projectivePolynomialToAffine K n (X 0) = J.x K n := by
  simp [projectivePolynomialToAffine, projectiveEvaluationCoordinates]

@[simp]
theorem projectivePolynomialToAffine_X_one (n : ℕ) :
    projectivePolynomialToAffine K n (X 1) = J.y K n := by
  simp [projectivePolynomialToAffine, projectiveEvaluationCoordinates]

@[simp]
theorem projectivePolynomialToAffine_X_two (n : ℕ) :
    projectivePolynomialToAffine K n (X 2) = 1 := by
  simp [projectivePolynomialToAffine, projectiveEvaluationCoordinates]

/-- The homogeneous Fermat relation vanishes under dehomogenization. -/
theorem projectivePolynomialToAffine_relation_eq_zero (n : ℕ) :
    projectivePolynomialToAffine K n
      (ConcreteProjectiveFermatScheme.projectiveRelation K n) = 0 := by
  rw [ConcreteProjectiveFermatScheme.projectiveRelation,
    map_sub, map_add, map_pow, map_pow, map_pow,
    projectivePolynomialToAffine_X_zero,
    projectivePolynomialToAffine_X_one,
    projectivePolynomialToAffine_X_two]
  have h :=
    ConcreteAffineFermatJacobian.fermatRelation_quotient_eq_zero K n
  change J.quotientAlgHom K n
    (ConcreteAffineFermatJacobian.fermatRelation K n) = 0 at h
  simpa [ConcreteAffineFermatJacobian.fermatRelation,
    ConcreteAffineFermatJacobian.fermatX,
    ConcreteAffineFermatJacobian.fermatY, J.x, J.y,
    map_add, map_sub, map_pow] using h

/-- The projective Fermat ideal lies in the kernel of evaluation at
`(u,v,1)`. -/
theorem projectiveIdeal_le_ker_projectivePolynomialToAffine (n : ℕ) :
    ConcreteProjectiveFermatScheme.projectiveIdeal K n ≤
      RingHom.ker (projectivePolynomialToAffine K n).toRingHom := by
  rw [ConcreteProjectiveFermatScheme.projectiveIdeal]
  apply Ideal.span_le.mpr
  rintro _ ⟨rfl⟩
  exact projectivePolynomialToAffine_relation_eq_zero K n

/-- Dehomogenization descends to the homogeneous coordinate quotient. -/
def projectiveToAffine (n : ℕ) : P.Ring K n →ₐ[K] J.Ring K n :=
  Ideal.Quotient.liftₐ
    (ConcreteProjectiveFermatScheme.projectiveIdeal K n)
    (projectivePolynomialToAffine K n)
    (fun _p hp => projectiveIdeal_le_ker_projectivePolynomialToAffine K n hp)

@[simp]
theorem projectiveToAffine_coordinate_zero (n : ℕ) :
    projectiveToAffine K n (P.coordinate K n 0) = J.x K n := by
  simp [projectiveToAffine, P.coordinate,
    ConcreteProjectiveFermatScheme.coordinate,
    ConcreteProjectiveFermatScheme.projectiveQuotientMap]

@[simp]
theorem projectiveToAffine_coordinate_one (n : ℕ) :
    projectiveToAffine K n (P.coordinate K n 1) = J.y K n := by
  simp [projectiveToAffine, P.coordinate,
    ConcreteProjectiveFermatScheme.coordinate,
    ConcreteProjectiveFermatScheme.projectiveQuotientMap]

@[simp]
theorem projectiveToAffine_coordinate_two (n : ℕ) :
    projectiveToAffine K n (P.coordinate K n 2) = 1 := by
  simp [projectiveToAffine, P.coordinate,
    ConcreteProjectiveFermatScheme.coordinate,
    ConcreteProjectiveFermatScheme.projectiveQuotientMap]

/-! ## From the homogeneous chart back to the affine quotient -/

/-- Evaluation at `(u,v,1)` extends over the ordinary localization because
the denominator coordinate maps to `1`. -/
def projectiveAwayToAffine (n : ℕ) :
    Localization.Away (P.coordinate K n 2) →ₐ[K] J.Ring K n :=
  IsLocalization.Away.liftAlgHom (P.coordinate K n 2)
    (show IsUnit (projectiveToAffine K n (P.coordinate K n 2)) by simp)

@[simp]
theorem projectiveAwayToAffine_algebraMap (n : ℕ) (a : P.Ring K n) :
    projectiveAwayToAffine K n
        (algebraMap (P.Ring K n)
          (Localization.Away (P.coordinate K n 2)) a) =
      projectiveToAffine K n a := by
  simp [projectiveAwayToAffine]

/-- The inclusion of the degree-zero homogeneous localization into the
ordinary localization, regarded as a `K`-algebra map. -/
def chartValAlgHom (n : ℕ) :
    P.Chart K n 2 →ₐ[K] Localization.Away (P.coordinate K n 2) where
  __ := algebraMap (P.Chart K n 2)
    (Localization.Away (P.coordinate K n 2))
  commutes' r := by
    rfl

@[simp]
theorem chartValAlgHom_apply (n : ℕ) (a : P.Chart K n 2) :
    chartValAlgHom K n a = a.val := rfl

/-- The reverse map `B_n → Q_n`, obtained by restricting localized
dehomogenization to the degree-zero homogeneous subring. -/
def chartToAffine (n : ℕ) : P.Chart K n 2 →ₐ[K] J.Ring K n :=
  (projectiveAwayToAffine K n).comp (chartValAlgHom K n)

@[simp]
theorem chartToAffine_ratio_zero (n : ℕ) :
    chartToAffine K n (P.ratio K n 0 2) = J.x K n := by
  simp only [chartToAffine, AlgHom.comp_apply, chartValAlgHom_apply,
    P.ratio, ConcreteProjectiveFermatScheme.chartRatio,
    HomogeneousLocalization.Away.val_mk, projectiveAwayToAffine,
    IsLocalization.Away.liftAlgHom_apply]
  rw [Localization.mk_eq_mk']
  apply (IsLocalization.lift_mk'_spec _ _ _ _).2
  simp

@[simp]
theorem chartToAffine_ratio_one (n : ℕ) :
    chartToAffine K n (P.ratio K n 1 2) = J.y K n := by
  simp only [chartToAffine, AlgHom.comp_apply, chartValAlgHom_apply,
    P.ratio, ConcreteProjectiveFermatScheme.chartRatio,
    HomogeneousLocalization.Away.val_mk, projectiveAwayToAffine,
    IsLocalization.Away.liftAlgHom_apply]
  rw [Localization.mk_eq_mk']
  apply (IsLocalization.lift_mk'_spec _ _ _ _).2
  simp

/-! ## The first inverse law -/

/-- Dehomogenizing after inserting the two chart ratios is the identity on
the affine Fermat quotient. -/
theorem chartToAffine_comp_affineToChart (n : ℕ) :
    (chartToAffine K n).comp (affineToChart K n) =
      AlgHom.id K (J.Ring K n) := by
  apply Ideal.Quotient.algHom_ext K
  apply MvPolynomial.algHom_ext
  intro i
  fin_cases i
  · change chartToAffine K n (affineToChart K n (J.x K n)) = J.x K n
    rw [affineToChart_x, chartToAffine_ratio_zero]
  · change chartToAffine K n (affineToChart K n (J.y K n)) = J.y K n
    rw [affineToChart_y, chartToAffine_ratio_one]

/-! ## Generation of the homogeneous chart by its two affine ratios -/

/-- Every element of the degree-zero piece of the homogeneous quotient is a
scalar.  This is proved upstairs from the fact that a total-degree-zero
multivariate polynomial is constant. -/
theorem quotientGrade_zero_eq_algebraMap (n : ℕ) (r : P.Grade K n 0) :
    ∃ c : K, r = algebraMap K (P.Grade K n 0) c := by
  rcases r with ⟨r, hr⟩
  rcases hr with ⟨p, hp, hpr⟩
  have hpDegree : p.totalDegree = 0 :=
    (MvPolynomial.totalDegree_zero_iff_isHomogeneous (Fin 3)).2 hp
  have hpC : p = C (p.coeff 0) :=
    MvPolynomial.totalDegree_eq_zero_iff_eq_C.mp hpDegree
  refine ⟨p.coeff 0, Subtype.ext ?_⟩
  change r = _
  rw [← hpr, hpC]
  rw [SetLike.GradeZero.coe_algebraMap]
  simp

/-- The denominator ratio `x₂/x₂` is one in the homogeneous chart. -/
@[simp]
theorem chartRatio_two_two (n : ℕ) : P.ratio K n 2 2 = 1 := by
  apply HomogeneousLocalization.val_injective
  simp only [P.ratio, ConcreteProjectiveFermatScheme.chartRatio,
    HomogeneousLocalization.Away.val_mk, HomogeneousLocalization.val_one,
    pow_one]
  rw [Localization.mk_eq_mk']
  exact IsLocalization.mk'_self'
    (S := Localization.Away (P.coordinate K n 2))

/-- A product of powers of the three degree-one chart ratios is represented
by the product numerator over the matching power of `x₂`. -/
theorem prod_chartRatio_pow (n : ℕ) (ai : Fin 3 → ℕ) :
    ∏ i, P.ratio K n i 2 ^ ai i =
      HomogeneousLocalization.Away.mk
        (P.Grade K n)
        (ConcreteProjectiveFermatScheme.coordinate_mem_degree_one K n 2)
        (∑ i, ai i) (∏ i, P.coordinate K n i ^ ai i)
        (by
          simpa using
            (SetLike.prod_pow_mem_graded (P.Grade K n)
              (fun _ : Fin 3 => 1) (P.coordinate K n) ai
              (F := Finset.univ)
              (fun i _ =>
                ConcreteProjectiveFermatScheme.coordinate_mem_degree_one
                  K n i))) := by
  apply HomogeneousLocalization.val_injective
  change algebraMap (P.Chart K n 2)
      (Localization.Away (P.coordinate K n 2))
      (∏ i, P.ratio K n i 2 ^ ai i) =
    Localization.mk (∏ i, P.coordinate K n i ^ ai i) _
  rw [map_prod]
  simp only [map_pow, HomogeneousLocalization.algebraMap_apply,
    P.ratio, ConcreteProjectiveFermatScheme.chartRatio,
    HomogeneousLocalization.Away.val_mk, Localization.mk_pow,
    Localization.mk_prod]
  congr 1
  apply Subtype.ext
  simp only [Submonoid.coe_finsetProd, SubmonoidClass.coe_pow,
    pow_one, ← Finset.prod_pow_eq_pow_sum]

/-- The bounded homogeneous monomial fractions occurring in Mathlib's
generation theorem for an Away chart.  All projective coordinates have
degree one here. -/
def chartHomogeneousGenerators (n : ℕ) : Set (P.Chart K n 2) :=
  { HomogeneousLocalization.Away.mk
      (P.Grade K n)
      (ConcreteProjectiveFermatScheme.coordinate_mem_degree_one K n 2)
      a (∏ i, P.coordinate K n i ^ ai i)
      (hai ▸ SetLike.prod_pow_mem_graded
        (P.Grade K n) (fun _ : Fin 3 => 1) (P.coordinate K n) ai
        (F := Finset.univ)
        (fun i _ =>
          ConcreteProjectiveFermatScheme.coordinate_mem_degree_one K n i)) |
      (a : ℕ) (ai : Fin 3 → ℕ)
      (hai : ∑ i, ai i • (1 : ℕ) = a • (1 : ℕ))
      (_hle : ∀ i, ai i ≤ 1) }

/-- Mathlib's homogeneous-Away theorem says that the bounded homogeneous
fractions generate the whole chart over its degree-zero piece. -/
theorem chartHomogeneousGenerators_adjoin_eq_top (n : ℕ) :
    Algebra.adjoin (P.Grade K n 0) (chartHomogeneousGenerators K n) = ⊤ := by
  simpa [chartHomogeneousGenerators] using
    (HomogeneousLocalization.Away.adjoin_mk_prod_pow_eq_top
      (ConcreteProjectiveFermatScheme.coordinate_mem_degree_one K n 2)
      (Fin 3) (P.coordinate K n)
      (ConcreteProjectiveFermatScheme.coordinate_adjoin_eq_top K n)
      (fun _ : Fin 3 => 1)
      (fun i =>
        ConcreteProjectiveFermatScheme.coordinate_mem_degree_one K n i))

/-- Each of the three projective ratios belongs to the `K`-algebra generated
by the first two; the third ratio is one. -/
theorem chartRatio_mem_pair_adjoin (n : ℕ) (i : Fin 3) :
    P.ratio K n i 2 ∈
      Algebra.adjoin K {P.ratio K n 0 2, P.ratio K n 1 2} := by
  fin_cases i
  · exact Algebra.subset_adjoin (by simp)
  · exact Algebra.subset_adjoin (by simp)
  · simp

/-- Every bounded homogeneous monomial generator is a product of powers of
the two affine ratios. -/
theorem chartHomogeneousGenerators_subset_pair_adjoin (n : ℕ) :
    chartHomogeneousGenerators K n ⊆
      Algebra.adjoin K {P.ratio K n 0 2, P.ratio K n 1 2} := by
  intro g hg
  rcases hg with ⟨a, ai, hai, hle, rfl⟩
  let T := Algebra.adjoin K {P.ratio K n 0 2, P.ratio K n 1 2}
  have hprod : ∏ i, P.ratio K n i 2 ^ ai i ∈ T := by
    exact Subalgebra.prod_mem T fun i _ =>
      Subalgebra.pow_mem T (chartRatio_mem_pair_adjoin K n i) (ai i)
  have hai' : ∑ i, ai i = a := by simpa using hai
  have heq := (prod_chartRatio_pow K n ai).symm
  simp only [hai'] at heq
  rw [heq]
  exact hprod

/-- The two affine coordinate ratios generate the entire `X₂` chart over
`K`; the proof includes the nontrivial reduction of the degree-zero base to
scalars. -/
theorem chartRatio_pair_adjoin_eq_top (n : ℕ) :
    Algebra.adjoin K {P.ratio K n 0 2, P.ratio K n 1 2} = ⊤ := by
  let T := Algebra.adjoin K {P.ratio K n 0 2, P.ratio K n 1 2}
  apply top_unique
  intro z _hz
  have hz : z ∈ Algebra.adjoin (P.Grade K n 0)
      (chartHomogeneousGenerators K n) := by
    rw [chartHomogeneousGenerators_adjoin_eq_top K n]
    trivial
  exact Algebra.adjoin_induction
    (p := fun z _ => z ∈ T)
    (fun z hz => chartHomogeneousGenerators_subset_pair_adjoin K n hz)
    (fun r => by
      obtain ⟨c, rfl⟩ := quotientGrade_zero_eq_algebraMap K n r
      change algebraMap K (P.Chart K n 2) c ∈ T
      exact Subalgebra.algebraMap_mem T c)
    (fun _ _ _ _ hx hy => Subalgebra.add_mem T hx hy)
    (fun _ _ _ _ hx hy => Subalgebra.mul_mem T hx hy)
    hz

/-! ## The second inverse law and the equivalence -/

/-- Inserting the result of dehomogenization is the identity on the
homogeneous chart. -/
theorem affineToChart_comp_chartToAffine (n : ℕ) :
    (affineToChart K n).comp (chartToAffine K n) =
      AlgHom.id K (P.Chart K n 2) := by
  apply AlgHom.ext_of_adjoin_eq_top (chartRatio_pair_adjoin_eq_top K n)
  intro z hz
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hz
  rcases hz with rfl | rfl
  · change affineToChart K n
      (chartToAffine K n (P.ratio K n 0 2)) = P.ratio K n 0 2
    rw [chartToAffine_ratio_zero, affineToChart_x]
  · change affineToChart K n
      (chartToAffine K n (P.ratio K n 1 2)) = P.ratio K n 1 2
    rw [chartToAffine_ratio_one, affineToChart_y]

/-- The explicit `K`-algebra equivalence between the affine Fermat quotient
and the genuine degree-zero homogeneous `X₂` chart ring. -/
def fermatAffineChartEquiv (n : ℕ) :
    J.Ring K n ≃ₐ[K] P.Chart K n 2 :=
  AlgEquiv.ofAlgHom (affineToChart K n) (chartToAffine K n)
    (affineToChart_comp_chartToAffine K n)
    (chartToAffine_comp_affineToChart K n)

/-! ## Transport of affine algebra smoothness -/

/-- In characteristic zero and for positive exponent, the genuine
homogeneous `X₂` chart ring is smooth over `K`.  This transports the global
affine Jacobian certificate across the explicit chart equivalence. -/
theorem coordinateChartRing_smooth [CharZero K] {n : ℕ} (hn : 0 < n) :
    Algebra.Smooth K (P.Chart K n 2) := by
  letI : Algebra.Smooth K (J.Ring K n) :=
    ConcreteAffineFermatJacobian.fermatJacobianRing_smooth K hn
  exact Algebra.Smooth.of_equiv (fermatAffineChartEquiv K n)

end
end ConcreteProjectiveFermatChartEquiv
end IUTThreeClosures
