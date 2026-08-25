/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ConcreteProjectiveFermatChartEquiv
import IUTThreeClosures.ConcreteFermatPresentationEquiv
import Mathlib.AlgebraicGeometry.Morphisms.Smooth

/-!
# Scheme-level smoothness of the odd projective Fermat curve

For odd positive `n`, all three standard coordinate charts of
`X₀^n + X₁^n = X₂^n` are explicitly identified with the affine Fermat
hypersurface `u^n+v^n=1`.  The identifications use

* `(X₀/X₂,X₁/X₂)` on `D₊(X₂)`;
* `(X₂/X₀,-X₁/X₀)` on `D₊(X₀)`;
* `(X₂/X₁,-X₀/X₁)` on `D₊(X₁)`.

The affine Jacobian certificate therefore makes each coordinate chart
smooth over the coefficient field.  The final theorem glues these
certificates with the genuine three-open Proj cover and proves that the
structural morphism of the projective Fermat scheme is smooth.

No boundary DVR, ramification-index, properness, or height theorem is
asserted here.
-/

namespace IUTThreeClosures
namespace ConcreteProjectiveFermatSchemeSmooth

noncomputable section

open CategoryTheory MvPolynomial

universe u

variable (K : Type u) [Field K]

namespace P

abbrev Ring := ConcreteProjectiveFermatScheme.ProjectiveFermatRing
abbrev Grade := ConcreteProjectiveFermatScheme.quotientGrade
abbrev Scheme := ConcreteProjectiveFermatScheme.projectiveFermatScheme
abbrev coordinate := ConcreteProjectiveFermatScheme.coordinate
abbrev Chart := ConcreteProjectiveFermatScheme.CoordinateChartRing
abbrev ratio := ConcreteProjectiveFermatScheme.chartRatio

end P

namespace J

abbrev Ring := ConcreteAffineFermatJacobian.FermatJacobianRing
abbrev Ideal := ConcreteAffineFermatJacobian.fermatRelationIdeal
abbrev Relation := ConcreteAffineFermatJacobian.fermatRelation
abbrev quotientAlgHom := ConcreteProjectiveFermatChartEquiv.J.quotientAlgHom
abbrev x := ConcreteProjectiveFermatChartEquiv.J.x
abbrev y := ConcreteProjectiveFermatChartEquiv.J.y

end J

/-- The homogeneous Fermat equation divided by the same coordinate power on
an arbitrary standard chart. -/
theorem chart_fermat_equation (n : ℕ) (den : Fin 3) :
    P.ratio K n 0 den ^ n + P.ratio K n 1 den ^ n =
      P.ratio K n 2 den ^ n := by
  apply HomogeneousLocalization.val_injective
  simp only [P.ratio, ConcreteProjectiveFermatScheme.chartRatio,
    HomogeneousLocalization.val_add, HomogeneousLocalization.val_pow,
    HomogeneousLocalization.Away.val_mk, Localization.mk_pow]
  rw [Localization.add_mk_self,
    ConcreteProjectiveFermatScheme.coordinate_fermat_equation]

/-- The ratio of a coordinate by itself is one. -/
@[simp]
theorem chartRatio_self (n : ℕ) (den : Fin 3) :
    P.ratio K n den den = 1 := by
  apply HomogeneousLocalization.val_injective
  simp only [P.ratio, ConcreteProjectiveFermatScheme.chartRatio,
    HomogeneousLocalization.Away.val_mk, HomogeneousLocalization.val_one,
    pow_one]
  rw [Localization.mk_eq_mk']
  exact IsLocalization.mk'_self'
    (S := Localization.Away (P.coordinate K n den))

/-! ## Uniform affine coordinates on the three odd-degree charts -/

/-- The numerator used for the first standard affine coordinate on each
denominator chart: `X₂/X₀`, `X₂/X₁`, and `X₀/X₂`. -/
def firstNumerator : Fin 3 → Fin 3 := ![2, 2, 0]

/-- The numerator used for the second standard affine coordinate before the
sign correction: `X₁/X₀`, `X₀/X₁`, and `X₁/X₂`. -/
def secondNumerator : Fin 3 → Fin 3 := ![1, 0, 1]

/-- The first affine coordinate on a standard projective chart. -/
def oddChartU (n : ℕ) (den : Fin 3) : P.Chart K n den :=
  P.ratio K n (firstNumerator den) den

/-- The second affine coordinate.  On the first two charts the minus sign
uses oddness to put the equation into the common form `u^n+v^n=1`. -/
def oddChartV (n : ℕ) (den : Fin 3) : P.Chart K n den :=
  if den = 2 then
    P.ratio K n (secondNumerator den) den
  else
    -P.ratio K n (secondNumerator den) den

/-- The pair of affine coordinates used to identify every odd-degree chart
with the standard affine Fermat quotient. -/
def oddChartCoordinates (n : ℕ) (den : Fin 3) : Fin 2 → P.Chart K n den :=
  ![oddChartU K n den, oddChartV K n den]

/-- On every coordinate chart, the sign-corrected coordinates satisfy the
same affine Fermat equation. -/
theorem oddChart_fermat_equation {n : ℕ} (hn : Odd n) (den : Fin 3) :
    oddChartU K n den ^ n + oddChartV K n den ^ n = 1 := by
  have hden : den = 0 ∨ den = 1 ∨ den = 2 := by
    fin_cases den <;> simp
  rcases hden with rfl | rfl | rfl
  · rw [show oddChartU K n 0 = P.ratio K n 2 0 by
          rfl,
        show oddChartV K n 0 = -P.ratio K n 1 0 by
          simp [oddChartV, secondNumerator]]
    rw [Odd.neg_pow hn (P.ratio K n 1 0), ← sub_eq_add_neg]
    have h := chart_fermat_equation K n (0 : Fin 3)
    rw [chartRatio_self, one_pow] at h
    linear_combination -h
  · rw [show oddChartU K n 1 = P.ratio K n 2 1 by
          rfl,
        show oddChartV K n 1 = -P.ratio K n 0 1 by
          simp [oddChartV, secondNumerator]]
    rw [Odd.neg_pow hn (P.ratio K n 0 1), ← sub_eq_add_neg]
    have h := chart_fermat_equation K n (1 : Fin 3)
    rw [chartRatio_self, one_pow] at h
    linear_combination -h
  · rw [show oddChartU K n 2 = P.ratio K n 0 2 by
          rfl,
        show oddChartV K n 2 = P.ratio K n 1 2 by
          simp [oddChartV, secondNumerator]]
    exact ConcreteProjectiveFermatScheme.chartTwo_fermat_equation K n

/-- Evaluate the two affine polynomial variables in the selected projective
chart. -/
def affinePolynomialToOddChart (n : ℕ) (den : Fin 3) :
    MvPolynomial (Fin 2) K →ₐ[K] P.Chart K n den :=
  MvPolynomial.aeval (oddChartCoordinates K n den)

@[simp]
theorem affinePolynomialToOddChart_X_zero (n : ℕ) (den : Fin 3) :
    affinePolynomialToOddChart K n den (X 0) = oddChartU K n den := by
  simp [affinePolynomialToOddChart, oddChartCoordinates]

@[simp]
theorem affinePolynomialToOddChart_X_one (n : ℕ) (den : Fin 3) :
    affinePolynomialToOddChart K n den (X 1) = oddChartV K n den := by
  simp [affinePolynomialToOddChart, oddChartCoordinates]

/-- The affine Fermat relation vanishes after evaluation in any odd-degree
coordinate chart. -/
theorem affinePolynomialToOddChart_relation_eq_zero
    {n : ℕ} (hn : Odd n) (den : Fin 3) :
    affinePolynomialToOddChart K n den (J.Relation K n) = 0 := by
  rw [J.Relation, ConcreteAffineFermatJacobian.fermatRelation,
    ConcreteAffineFermatJacobian.fermatX,
    ConcreteAffineFermatJacobian.fermatY,
    map_sub, map_add, map_pow, map_pow,
    affinePolynomialToOddChart_X_zero,
    affinePolynomialToOddChart_X_one, map_one]
  exact sub_eq_zero.mpr (oddChart_fermat_equation K hn den)

/-- The principal affine relation ideal lies in the evaluation kernel. -/
theorem affineIdeal_le_ker_affinePolynomialToOddChart
    {n : ℕ} (hn : Odd n) (den : Fin 3) :
    J.Ideal K n ≤
      RingHom.ker (affinePolynomialToOddChart K n den).toRingHom := by
  rw [J.Ideal, ConcreteAffineFermatJacobian.fermatRelationIdeal]
  apply Ideal.span_le.mpr
  rintro _ ⟨_i, rfl⟩
  change affinePolynomialToOddChart K n den
    (ConcreteAffineFermatJacobian.fermatRelationFamily K n _i) = 0
  simpa [ConcreteAffineFermatJacobian.fermatRelationFamily] using
    affinePolynomialToOddChart_relation_eq_zero K hn den

/-- The forward map from the standard affine Fermat quotient to any
odd-degree projective coordinate chart. -/
def affineToOddChart {n : ℕ} (hn : Odd n) (den : Fin 3) :
    J.Ring K n →ₐ[K] P.Chart K n den :=
  Ideal.Quotient.liftₐ (J.Ideal K n)
    (affinePolynomialToOddChart K n den)
    (fun _p hp => affineIdeal_le_ker_affinePolynomialToOddChart K hn den hp)

@[simp]
theorem affineToOddChart_x {n : ℕ} (hn : Odd n) (den : Fin 3) :
    affineToOddChart K hn den (J.x K n) = oddChartU K n den := by
  simp [affineToOddChart, ConcreteProjectiveFermatChartEquiv.J.x,
    ConcreteProjectiveFermatChartEquiv.J.quotientAlgHom]

@[simp]
theorem affineToOddChart_y {n : ℕ} (hn : Odd n) (den : Fin 3) :
    affineToOddChart K hn den (J.y K n) = oddChartV K n den := by
  simp [affineToOddChart, ConcreteProjectiveFermatChartEquiv.J.y,
    ConcreteProjectiveFermatChartEquiv.J.quotientAlgHom]

/-! ## Dehomogenization back to the affine Fermat quotient -/

/-- The three homogeneous coordinates evaluated in the standard affine
Fermat quotient on each denominator chart. -/
def projectiveEvaluationCoordinates (n : ℕ) (den : Fin 3) :
    Fin 3 → J.Ring K n :=
  if den = 0 then
    ![1, -J.y K n, J.x K n]
  else if den = 1 then
    ![-J.y K n, 1, J.x K n]
  else
    ![J.x K n, J.y K n, 1]

/-- Evaluate the homogeneous polynomial variables at the selected affine
coordinates. -/
def projectivePolynomialToOddAffine (n : ℕ) (den : Fin 3) :
    MvPolynomial (Fin 3) K →ₐ[K] J.Ring K n :=
  MvPolynomial.aeval (projectiveEvaluationCoordinates K n den)

@[simp]
theorem projectivePolynomialToOddAffine_X
    (n : ℕ) (den i : Fin 3) :
    projectivePolynomialToOddAffine K n den (X i) =
      projectiveEvaluationCoordinates K n den i := by
  simp [projectivePolynomialToOddAffine]

/-- The projective Fermat relation vanishes under each odd-chart
dehomogenization. -/
theorem projectivePolynomialToOddAffine_relation_eq_zero
    {n : ℕ} (hn : Odd n) (den : Fin 3) :
    projectivePolynomialToOddAffine K n den
        (ConcreteProjectiveFermatScheme.projectiveRelation K n) = 0 := by
  have hden : den = 0 ∨ den = 1 ∨ den = 2 := by
    fin_cases den <;> simp
  have hF := ConcreteFermatPresentationEquiv.jacobian_fermat_equation K n
  change J.x K n ^ n + J.y K n ^ n = 1 at hF
  rcases hden with rfl | rfl | rfl
  · simp only [ConcreteProjectiveFermatScheme.projectiveRelation,
      map_sub, map_add, map_pow,
      projectivePolynomialToOddAffine_X]
    change 1 ^ n + (-J.y K n) ^ n - J.x K n ^ n = 0
    rw [Odd.neg_pow hn (J.y K n)]
    linear_combination -hF
  · simp only [ConcreteProjectiveFermatScheme.projectiveRelation,
      map_sub, map_add, map_pow,
      projectivePolynomialToOddAffine_X]
    change (-J.y K n) ^ n + 1 ^ n - J.x K n ^ n = 0
    rw [Odd.neg_pow hn (J.y K n)]
    linear_combination -hF
  · simp only [ConcreteProjectiveFermatScheme.projectiveRelation,
      map_sub, map_add, map_pow,
      projectivePolynomialToOddAffine_X]
    change J.x K n ^ n + J.y K n ^ n - 1 ^ n = 0
    simpa only [one_pow] using (sub_eq_zero.mpr hF)

/-- The homogeneous relation ideal lies in the dehomogenization kernel. -/
theorem projectiveIdeal_le_ker_projectivePolynomialToOddAffine
    {n : ℕ} (hn : Odd n) (den : Fin 3) :
    ConcreteProjectiveFermatScheme.projectiveIdeal K n ≤
      RingHom.ker (projectivePolynomialToOddAffine K n den).toRingHom := by
  rw [ConcreteProjectiveFermatScheme.projectiveIdeal]
  apply Ideal.span_le.mpr
  intro p hp
  rcases hp with ⟨_i, rfl⟩
  exact projectivePolynomialToOddAffine_relation_eq_zero K hn den

/-- Dehomogenization descends to the homogeneous coordinate quotient. -/
def projectiveToOddAffine {n : ℕ} (hn : Odd n) (den : Fin 3) :
    P.Ring K n →ₐ[K] J.Ring K n :=
  Ideal.Quotient.liftₐ
    (ConcreteProjectiveFermatScheme.projectiveIdeal K n)
    (projectivePolynomialToOddAffine K n den)
    (fun _p hp =>
      projectiveIdeal_le_ker_projectivePolynomialToOddAffine K hn den hp)

@[simp]
theorem projectiveToOddAffine_coordinate
    {n : ℕ} (hn : Odd n) (den i : Fin 3) :
    projectiveToOddAffine K hn den (P.coordinate K n i) =
      projectiveEvaluationCoordinates K n den i := by
  simp [projectiveToOddAffine, P.coordinate,
    ConcreteProjectiveFermatScheme.coordinate,
    ConcreteProjectiveFermatScheme.projectiveQuotientMap]

/-- The denominator coordinate evaluates to one. -/
@[simp]
theorem projectiveToOddAffine_denominator
    {n : ℕ} (hn : Odd n) (den : Fin 3) :
    projectiveToOddAffine K hn den (P.coordinate K n den) = 1 := by
  rw [projectiveToOddAffine_coordinate]
  have hden : den = 0 ∨ den = 1 ∨ den = 2 := by
    fin_cases den <;> simp
  rcases hden with rfl | rfl | rfl <;>
    simp [projectiveEvaluationCoordinates]

/-- The selected evaluation coordinate itself is one. -/
@[simp]
theorem projectiveEvaluationCoordinates_denominator
    (n : ℕ) (den : Fin 3) :
    projectiveEvaluationCoordinates K n den den = 1 := by
  have hden : den = 0 ∨ den = 1 ∨ den = 2 := by
    fin_cases den <;> simp
  rcases hden with rfl | rfl | rfl <;>
    simp [projectiveEvaluationCoordinates]

/-- Dehomogenization extends over the ordinary localization because the
chosen denominator maps to one. -/
def projectiveAwayToOddAffine {n : ℕ} (hn : Odd n) (den : Fin 3) :
    Localization.Away (P.coordinate K n den) →ₐ[K] J.Ring K n :=
  IsLocalization.Away.liftAlgHom (P.coordinate K n den)
    (show IsUnit
        (projectiveToOddAffine K hn den (P.coordinate K n den)) by
      rw [projectiveToOddAffine_denominator]
      exact isUnit_one)

@[simp]
theorem projectiveAwayToOddAffine_algebraMap
    {n : ℕ} (hn : Odd n) (den : Fin 3) (a : P.Ring K n) :
    projectiveAwayToOddAffine K hn den
        (algebraMap (P.Ring K n)
          (Localization.Away (P.coordinate K n den)) a) =
      projectiveToOddAffine K hn den a := by
  simp [projectiveAwayToOddAffine]

/-- Inclusion of the degree-zero homogeneous localization in the ordinary
Away localization. -/
def oddChartValAlgHom (n : ℕ) (den : Fin 3) :
    P.Chart K n den →ₐ[K] Localization.Away (P.coordinate K n den) where
  __ := algebraMap (P.Chart K n den)
    (Localization.Away (P.coordinate K n den))
  commutes' _ := rfl

@[simp]
theorem oddChartValAlgHom_apply
    (n : ℕ) (den : Fin 3) (a : P.Chart K n den) :
    oddChartValAlgHom K n den a = a.val := rfl

/-- The reverse affine map from an arbitrary odd-degree chart. -/
def oddChartToAffine {n : ℕ} (hn : Odd n) (den : Fin 3) :
    P.Chart K n den →ₐ[K] J.Ring K n :=
  (projectiveAwayToOddAffine K hn den).comp (oddChartValAlgHom K n den)

/-- A homogeneous coordinate ratio dehomogenizes to the corresponding
evaluation coordinate. -/
theorem oddChartToAffine_ratio
    {n : ℕ} (hn : Odd n) (den num : Fin 3) :
    oddChartToAffine K hn den (P.ratio K n num den) =
      projectiveEvaluationCoordinates K n den num := by
  simp only [oddChartToAffine, AlgHom.comp_apply, oddChartValAlgHom_apply,
    P.ratio, ConcreteProjectiveFermatScheme.chartRatio,
    HomogeneousLocalization.Away.val_mk, projectiveAwayToOddAffine,
    IsLocalization.Away.liftAlgHom_apply]
  rw [Localization.mk_eq_mk']
  apply (IsLocalization.lift_mk'_spec _ _ _ _).2
  change projectiveToOddAffine K hn den (P.coordinate K n num) =
    projectiveToOddAffine K hn den (P.coordinate K n den ^ 1) *
      projectiveEvaluationCoordinates K n den num
  rw [map_pow, projectiveToOddAffine_coordinate,
    projectiveToOddAffine_coordinate,
    projectiveEvaluationCoordinates_denominator, one_pow, one_mul]

@[simp]
theorem oddChartToAffine_u
    {n : ℕ} (hn : Odd n) (den : Fin 3) :
    oddChartToAffine K hn den (oddChartU K n den) = J.x K n := by
  rw [oddChartU, oddChartToAffine_ratio]
  have hden : den = 0 ∨ den = 1 ∨ den = 2 := by
    fin_cases den <;> simp
  rcases hden with rfl | rfl | rfl <;>
    simp [firstNumerator, projectiveEvaluationCoordinates]

@[simp]
theorem oddChartToAffine_v
    {n : ℕ} (hn : Odd n) (den : Fin 3) :
    oddChartToAffine K hn den (oddChartV K n den) = J.y K n := by
  have hden : den = 0 ∨ den = 1 ∨ den = 2 := by
    fin_cases den <;> simp
  rcases hden with rfl | rfl | rfl
  · simp [oddChartV, secondNumerator, oddChartToAffine_ratio,
      projectiveEvaluationCoordinates]
  · simp [oddChartV, secondNumerator, oddChartToAffine_ratio,
      projectiveEvaluationCoordinates]
  · simp [oddChartV, secondNumerator, oddChartToAffine_ratio,
      projectiveEvaluationCoordinates]

/-! ## The two inverse laws -/

/-- Dehomogenization after inserting the two odd-chart coordinates is the
identity on the affine Fermat quotient. -/
theorem oddChartToAffine_comp_affineToOddChart
    {n : ℕ} (hn : Odd n) (den : Fin 3) :
    (oddChartToAffine K hn den).comp (affineToOddChart K hn den) =
      AlgHom.id K (J.Ring K n) := by
  apply Ideal.Quotient.algHom_ext K
  apply MvPolynomial.algHom_ext
  intro i
  fin_cases i
  · change oddChartToAffine K hn den
      (affineToOddChart K hn den (J.x K n)) = J.x K n
    rw [affineToOddChart_x, oddChartToAffine_u]
  · change oddChartToAffine K hn den
      (affineToOddChart K hn den (J.y K n)) = J.y K n
    rw [affineToOddChart_y, oddChartToAffine_v]

/-- A product of powers of all three coordinate ratios is the corresponding
homogeneous numerator divided by the matching denominator power. -/
theorem prod_chartRatio_pow_at
    (n : ℕ) (den : Fin 3) (ai : Fin 3 → ℕ) :
    ∏ i, P.ratio K n i den ^ ai i =
      HomogeneousLocalization.Away.mk
        (P.Grade K n)
        (ConcreteProjectiveFermatScheme.coordinate_mem_degree_one K n den)
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
  change algebraMap (P.Chart K n den)
      (Localization.Away (P.coordinate K n den))
      (∏ i, P.ratio K n i den ^ ai i) =
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

/-- The bounded homogeneous monomial fractions in the general coordinate
chart generation theorem. -/
def chartHomogeneousGeneratorsAt (n : ℕ) (den : Fin 3) :
    Set (P.Chart K n den) :=
  { HomogeneousLocalization.Away.mk
      (P.Grade K n)
      (ConcreteProjectiveFermatScheme.coordinate_mem_degree_one K n den)
      a (∏ i, P.coordinate K n i ^ ai i)
      (hai ▸ SetLike.prod_pow_mem_graded
        (P.Grade K n) (fun _ : Fin 3 => 1) (P.coordinate K n) ai
        (F := Finset.univ)
        (fun i _ =>
          ConcreteProjectiveFermatScheme.coordinate_mem_degree_one K n i)) |
      (a : ℕ) (ai : Fin 3 → ℕ)
      (hai : ∑ i, ai i • (1 : ℕ) = a • (1 : ℕ))
      (_hle : ∀ i, ai i ≤ 1) }

/-- The homogeneous-Away generators span the whole arbitrary denominator
chart over its degree-zero piece. -/
theorem chartHomogeneousGeneratorsAt_adjoin_eq_top
    (n : ℕ) (den : Fin 3) :
    Algebra.adjoin (P.Grade K n 0)
      (chartHomogeneousGeneratorsAt K n den) = ⊤ := by
  simpa [chartHomogeneousGeneratorsAt] using
    (HomogeneousLocalization.Away.adjoin_mk_prod_pow_eq_top
      (ConcreteProjectiveFermatScheme.coordinate_mem_degree_one K n den)
      (Fin 3) (P.coordinate K n)
      (ConcreteProjectiveFermatScheme.coordinate_adjoin_eq_top K n)
      (fun _ : Fin 3 => 1)
      (fun i =>
        ConcreteProjectiveFermatScheme.coordinate_mem_degree_one K n i))

/-- Every coordinate ratio lies in the `K`-algebra generated by the two
sign-corrected odd-chart coordinates. -/
theorem chartRatio_mem_oddPair_adjoin
    (n : ℕ) (den i : Fin 3) :
    P.ratio K n i den ∈
      Algebra.adjoin K {oddChartU K n den, oddChartV K n den} := by
  let T := Algebra.adjoin K {oddChartU K n den, oddChartV K n den}
  have hu : oddChartU K n den ∈ T :=
    Algebra.subset_adjoin (by simp)
  have hv : oddChartV K n den ∈ T :=
    Algebra.subset_adjoin (by simp)
  have hden : den = 0 ∨ den = 1 ∨ den = 2 := by
    fin_cases den <;> simp
  rcases hden with rfl | rfl | rfl
  · fin_cases i
    · simp
    · have h := T.neg_mem hv
      simpa [T, oddChartV, secondNumerator] using h
    · simpa [T, oddChartU, firstNumerator] using hu
  · fin_cases i
    · have h := T.neg_mem hv
      simpa [T, oddChartV, secondNumerator] using h
    · simp
    · simpa [T, oddChartU, firstNumerator] using hu
  · fin_cases i
    · simpa [T, oddChartU, firstNumerator] using hu
    · simpa [T, oddChartV, secondNumerator] using hv
    · simp

/-- Every bounded homogeneous generator is a product of powers of ratios and
hence belongs to the algebra generated by the odd-chart coordinate pair. -/
theorem chartHomogeneousGeneratorsAt_subset_oddPair_adjoin
    (n : ℕ) (den : Fin 3) :
    chartHomogeneousGeneratorsAt K n den ⊆
      Algebra.adjoin K {oddChartU K n den, oddChartV K n den} := by
  intro g hg
  rcases hg with ⟨a, ai, hai, hle, rfl⟩
  let T := Algebra.adjoin K {oddChartU K n den, oddChartV K n den}
  have hprod : ∏ i, P.ratio K n i den ^ ai i ∈ T := by
    exact Subalgebra.prod_mem T fun i _ =>
      Subalgebra.pow_mem T (chartRatio_mem_oddPair_adjoin K n den i) (ai i)
  have hai' : ∑ i, ai i = a := by simpa using hai
  have heq := (prod_chartRatio_pow_at K n den ai).symm
  simp only [hai'] at heq
  rw [heq]
  exact hprod

/-- The two sign-corrected affine coordinates generate the whole homogeneous
chart as a `K`-algebra. -/
theorem oddChart_pair_adjoin_eq_top (n : ℕ) (den : Fin 3) :
    Algebra.adjoin K {oddChartU K n den, oddChartV K n den} = ⊤ := by
  let T := Algebra.adjoin K {oddChartU K n den, oddChartV K n den}
  apply top_unique
  intro z _hz
  have hz : z ∈ Algebra.adjoin (P.Grade K n 0)
      (chartHomogeneousGeneratorsAt K n den) := by
    rw [chartHomogeneousGeneratorsAt_adjoin_eq_top K n den]
    trivial
  exact Algebra.adjoin_induction
    (p := fun z _ => z ∈ T)
    (fun z hz =>
      chartHomogeneousGeneratorsAt_subset_oddPair_adjoin K n den hz)
    (fun r => by
      obtain ⟨c, rfl⟩ :=
        ConcreteProjectiveFermatChartEquiv.quotientGrade_zero_eq_algebraMap
          K n r
      change algebraMap K (P.Chart K n den) c ∈ T
      exact Subalgebra.algebraMap_mem T c)
    (fun _ _ _ _ hx hy => Subalgebra.add_mem T hx hy)
    (fun _ _ _ _ hx hy => Subalgebra.mul_mem T hx hy)
    hz

/-- Inserting dehomogenized coordinates is the identity on every odd-degree
homogeneous chart. -/
theorem affineToOddChart_comp_oddChartToAffine
    {n : ℕ} (hn : Odd n) (den : Fin 3) :
    (affineToOddChart K hn den).comp (oddChartToAffine K hn den) =
      AlgHom.id K (P.Chart K n den) := by
  apply AlgHom.ext_of_adjoin_eq_top (oddChart_pair_adjoin_eq_top K n den)
  intro z hz
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hz
  rcases hz with rfl | rfl
  · change affineToOddChart K hn den
      (oddChartToAffine K hn den (oddChartU K n den)) =
        oddChartU K n den
    rw [oddChartToAffine_u, affineToOddChart_x]
  · change affineToOddChart K hn den
      (oddChartToAffine K hn den (oddChartV K n den)) =
        oddChartV K n den
    rw [oddChartToAffine_v, affineToOddChart_y]

/-- The explicit `K`-algebra equivalence between the standard affine Fermat
quotient and any odd-degree projective coordinate chart. -/
def fermatAffineOddChartEquiv
    {n : ℕ} (hn : Odd n) (den : Fin 3) :
    J.Ring K n ≃ₐ[K] P.Chart K n den :=
  AlgEquiv.ofAlgHom (affineToOddChart K hn den) (oddChartToAffine K hn den)
    (affineToOddChart_comp_oddChartToAffine K hn den)
    (oddChartToAffine_comp_affineToOddChart K hn den)

/-- Every odd positive coordinate chart is smooth over the coefficient
field. -/
theorem coordinateChartRing_smooth
    [CharZero K] {n : ℕ} (hn : Odd n) (hnpos : 0 < n) (den : Fin 3) :
    Algebra.Smooth K (P.Chart K n den) := by
  letI : Algebra.Smooth K (J.Ring K n) :=
    ConcreteAffineFermatJacobian.fermatJacobianRing_smooth K hnpos
  exact Algebra.Smooth.of_equiv (fermatAffineOddChartEquiv K hn den)

/-! ## The global projective structural morphism -/

/-- The structural morphism from the projective Fermat scheme to the
coefficient-field spectrum. -/
def projectiveFermatToSpec (n : ℕ) :
    P.Scheme K n ⟶ AlgebraicGeometry.Spec (.of K) :=
  AlgebraicGeometry.Proj.toSpecZero (P.Grade K n) ≫
    AlgebraicGeometry.Spec.map
      (CommRingCat.ofHom (algebraMap K (P.Grade K n 0)))

/-- On a coordinate chart, the projective structural morphism is exactly the
affine spectrum map induced by the chart's `K`-algebra structure. -/
theorem coordinateAwayι_comp_projectiveFermatToSpec
    (n : ℕ) (den : Fin 3) :
    ConcreteProjectiveFermatScheme.coordinateAwayι K n den ≫
        projectiveFermatToSpec K n =
      AlgebraicGeometry.Spec.map
        (CommRingCat.ofHom (algebraMap K (P.Chart K n den))) := by
  change
    AlgebraicGeometry.Proj.awayι (P.Grade K n) (P.coordinate K n den)
        (ConcreteProjectiveFermatScheme.coordinate_mem_degree_one K n den)
        Nat.zero_lt_one ≫
      (AlgebraicGeometry.Proj.toSpecZero (P.Grade K n) ≫
        AlgebraicGeometry.Spec.map
          (CommRingCat.ofHom (algebraMap K (P.Grade K n 0)))) = _
  rw [← Category.assoc,
    AlgebraicGeometry.Proj.awayι_toSpecZero]
  simp only [← AlgebraicGeometry.Spec.map_comp]
  rfl

/-- Every coordinate-away presentation of the structural morphism is a
smooth affine morphism. -/
theorem coordinateAwayι_comp_projectiveFermatToSpec_smooth
    [CharZero K] {n : ℕ} (hn : Odd n) (hnpos : 0 < n) (den : Fin 3) :
    AlgebraicGeometry.Smooth
      (ConcreteProjectiveFermatScheme.coordinateAwayι K n den ≫
        projectiveFermatToSpec K n) := by
  rw [coordinateAwayι_comp_projectiveFermatToSpec]
  rw [AlgebraicGeometry.HasRingHomProperty.Spec_iff
    (P := @AlgebraicGeometry.Smooth)]
  change (algebraMap K (P.Chart K n den)).Smooth
  exact RingHom.smooth_algebraMap.mpr
    (coordinateChartRing_smooth K hn hnpos den)

/-- The restriction of the structural morphism to each coordinate standard
open is smooth. -/
theorem coordinateOpen_comp_projectiveFermatToSpec_smooth
    [CharZero K] {n : ℕ} (hn : Odd n) (hnpos : 0 < n) (den : Fin 3) :
    AlgebraicGeometry.Smooth
      ((ConcreteProjectiveFermatScheme.coordinateOpen K n den).ι ≫
        projectiveFermatToSpec K n) := by
  let e := ConcreteProjectiveFermatScheme.coordinateOpenIsoSpec K n den
  letI : AlgebraicGeometry.Smooth
      (ConcreteProjectiveFermatScheme.coordinateAwayι K n den ≫
        projectiveFermatToSpec K n) :=
    coordinateAwayι_comp_projectiveFermatToSpec_smooth K hn hnpos den
  have h : AlgebraicGeometry.Smooth
      (e.hom ≫
        (ConcreteProjectiveFermatScheme.coordinateAwayι K n den ≫
          projectiveFermatToSpec K n)) := by infer_instance
  simpa [e, ConcreteProjectiveFermatScheme.coordinateOpenIsoSpec,
    ConcreteProjectiveFermatScheme.coordinateOpen,
    ConcreteProjectiveFermatScheme.projectiveFermatScheme,
    ConcreteProjectiveFermatScheme.coordinateAwayι,
    AlgebraicGeometry.Proj.awayι, ← Category.assoc] using h

/-- For odd positive degree in characteristic zero, the genuine projective
Fermat scheme is smooth over the coefficient field. -/
theorem projectiveFermatScheme_smooth
    [CharZero K] {n : ℕ} (hn : Odd n) (hnpos : 0 < n) :
    AlgebraicGeometry.Smooth (projectiveFermatToSpec K n) := by
  apply AlgebraicGeometry.IsZariskiLocalAtSource.of_iSup_eq_top
    (fun den : Fin 3 =>
      ConcreteProjectiveFermatScheme.coordinateOpen K n den)
    (ConcreteProjectiveFermatScheme.iSup_coordinateOpen_eq_top K n)
  intro den
  exact coordinateOpen_comp_projectiveFermatToSpec_smooth K hn hnpos den

end
end ConcreteProjectiveFermatSchemeSmooth
end IUTThreeClosures
