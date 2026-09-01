/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.NonCircularDownstream
import Mathlib.AlgebraicGeometry.EllipticCurve.Affine.Point
import Mathlib.Algebra.Field.ZMod
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Data.Fintype.Option
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.NormNum

/-!
# Concrete Frey models for the tame 139-adic calculation

Mathematical proofs precede this module in
`research/FREY_139_TATE_210_REALIZATION_2026_08_30.md`.

The module constructs actual Weierstrass curves, checks their invariants,
counts all points of the specified reduction over `ZMod 5` using the
library's elliptic-curve point type, and checks the mod-7 polynomial and
real logarithmic bounds. Tate uniformization, the representation on torsion,
the Frobenius comparison and the local absolute Galois interpretation are
not formalized here. They are not introduced as axioms or opaque inputs.
-/

namespace IUTThreeClosures.Frey139Tate210Realization20260830

universe u

local instance prime5 : Fact (Nat.Prime 5) := ⟨by decide⟩
local instance prime7 : Fact (Nat.Prime 7) := ⟨by decide⟩
local instance prime139 : Fact (Nat.Prime 139) := ⟨by decide⟩

/-- The actual Frey Weierstrass model, with equation `y² = x(x-a)(x+b)`. -/
def freyModel {R : Type u} [CommRing R] (a b : R) : WeierstrassCurve R :=
  ⟨0, b - a, 0, -(a * b), 0⟩

/-- The defining affine equation has the factored Frey form. -/
theorem freyModel_equation {R : Type u} [CommRing R] (a b x y : R) :
    (freyModel a b).toAffine.Equation x y ↔ y ^ 2 = x * (x - a) * (x + b) := by
  rw [WeierstrassCurve.Affine.equation_iff]
  simp only [freyModel, zero_mul, add_zero]
  have h : x ^ 3 + (b - a) * x ^ 2 + -(a * b) * x =
      x * (x - a) * (x + b) := by ring
  rw [h]

/-- Discriminant of the actual model, valid over every commutative ring. -/
theorem freyModel_discriminant {R : Type u} [CommRing R] (a b : R) :
    (freyModel a b).Δ = 16 * (a * b * (a + b)) ^ 2 := by
  simp only [WeierstrassCurve.Δ, WeierstrassCurve.b₂, WeierstrassCurve.b₄,
    WeierstrassCurve.b₆, WeierstrassCurve.b₈, freyModel]
  ring

/-- The `c₄` invariant of the same model. -/
theorem freyModel_c4 {R : Type u} [CommRing R] (a b : R) :
    (freyModel a b).c₄ = 16 * (a ^ 2 + a * b + b ^ 2) := by
  simp only [WeierstrassCurve.c₄, WeierstrassCurve.b₂, WeierstrassCurve.b₄, freyModel]
  ring

/-- The first rational primitive triple used in the mathematical report. -/
def firstTriple : ABCPoint where
  a := 139
  b := 279
  c := 418
  a_pos := by decide
  b_pos := by decide
  c_pos := by decide
  sum_eq := by decide
  pairwise_coprime := by
    change Nat.Coprime 139 279 ∧ Nat.Coprime 279 418 ∧ Nat.Coprime 418 139
    decide

/-- Its actual Weierstrass curve over the rationals. -/
def firstCurve : WeierstrassCurve ℚ := freyModel 139 279

instance firstCurve_isElliptic : firstCurve.IsElliptic := by
  refine ⟨isUnit_iff_ne_zero.mpr ?_⟩
  rw [firstCurve, freyModel_discriminant]
  norm_num

/-- The integral equation has the asserted nonzero discriminant. -/
theorem firstCurve_discriminant :
    firstCurve.Δ = 16 * ((139 : ℚ) * 279 * 418) ^ 2 := by
  rw [firstCurve, freyModel_discriminant]
  norm_num

/-- The actual `c₄` calculation, not a separately assigned parameter. -/
theorem firstCurve_c4 : firstCurve.c₄ = 16 * 135943 := by
  rw [firstCurve, freyModel_c4]
  norm_num

/-- The actual rational `j`-invariant obtained from the curve's discriminant. -/
theorem firstCurve_j :
    firstCurve.j = 256 * (135943 : ℚ) ^ 3 / (139 * 279 * 418) ^ 2 := by
  rw [WeierstrassCurve.j, Units.val_inv_eq_inv_val, WeierstrassCurve.coe_Δ',
    firstCurve_discriminant, firstCurve_c4]
  norm_num

/-- Reduction of the cubic at 139, whose tangent cone is split. -/
theorem firstCurve_cubic_mod139 (x : ZMod 139) :
    x * (x - 139) * (x + 279) = x ^ 2 * (x + 1) := by
  have h139 : (139 : ZMod 139) = 0 := by decide
  have h279 : (279 : ZMod 139) = 1 := by decide
  rw [h139, h279]
  ring

/-- The displayed node has two distinct rational tangent factors in characteristic 139. -/
theorem firstCurve_tangent_cone (x y : ZMod 139) :
    y ^ 2 - x ^ 2 * (x + 1) = (y - x) * (y + x) - x ^ 3 := by
  ring

/-- The two tangent slopes in the preceding identity are distinct. -/
theorem tangent_slopes_distinct : (1 : ZMod 139) ≠ -1 := by decide

/-- The actual model over the good residue field. -/
def firstCurve5 : WeierstrassCurve (ZMod 5) := freyModel 139 279

instance firstCurve5_isElliptic : firstCurve5.IsElliptic := by
  refine ⟨isUnit_iff_ne_zero.mpr ?_⟩
  rw [firstCurve5, freyModel_discriminant]
  decide

/-- Exact equation of its reduction over `ZMod 5`. -/
theorem firstCurve5_equation (x y : ZMod 5) :
    firstCurve5.toAffine.Equation x y ↔ y ^ 2 = x ^ 3 - x := by
  rw [firstCurve5, freyModel_equation]
  have h139 : (139 : ZMod 5) = -1 := by decide
  have h279 : (279 : ZMod 5) = -1 := by decide
  rw [h139, h279]
  have h : x * (x - -1) * (x + -1) = x ^ 3 - x := by ring
  rw [h]

/-- All seven affine solutions of the actual reduced equation are counted. -/
theorem firstCurve5_affine_card :
    Fintype.card {xy : ZMod 5 × ZMod 5 // xy.2 ^ 2 = xy.1 ^ 3 - xy.1} = 7 := by
  decide

/-- The library's elliptic-curve point type has exactly eight points, including infinity. -/
theorem firstCurve5_point_card : Nat.card firstCurve5.toAffine.Point = 8 := by
  let e : firstCurve5.toAffine.Point ≃
      WithZero {xy : ZMod 5 × ZMod 5 // xy.2 ^ 2 = xy.1 ^ 3 - xy.1} :=
    firstCurve5.toAffine.pointEquiv.trans
      (Equiv.subtypeEquivProp (by
        funext xy
        exact propext (firstCurve5_equation xy.1 xy.2))).optionCongr
  rw [Nat.card_congr e]
  change Nat.card (Option {xy : ZMod 5 × ZMod 5 //
    xy.2 ^ 2 = xy.1 ^ 3 - xy.1}) = 8
  rw [Nat.card_eq_fintype_card, Fintype.card_option, firstCurve5_affine_card]

/-- Its finite-field point-count trace is minus two; the Galois comparison is external. -/
theorem firstCurve5_count_trace :
    (5 : ℤ) + 1 - (Nat.card firstCurve5.toAffine.Point : ℤ) = -2 := by
  rw [firstCurve5_point_card]
  norm_num

/-- The concrete Frobenius-polynomial candidate has no root over `ZMod 7`. -/
theorem first_frobenius_polynomial_no_root :
    ∀ z : ZMod 7, z ^ 2 + 2 * z + 5 ≠ 0 := by
  decide

/-- The degree bound for adjoining `i` and the 30-torsion is prime to seven. -/
theorem level_degree_bound_prime_to_seven : Nat.Coprime (2 * 6 * 48 * 480) 7 := by
  decide

/-- Arithmetic of the unramified cyclotomic degree and the tame denominator. -/
theorem local_210_numerics :
    139 % 210 ≠ 1 ∧ 139 ^ 2 % 210 = 1 ∧ 105 ≤ 139 - 2 ∧
      Nat.Coprime 105 139 ∧ 105 * 2 = 210 := by
  decide

/-- Integer certificates for the first model's logarithmic Tate window. -/
theorem first_height_integer_certificate :
    (3 : ℕ) ^ 25 < 8105229 ^ 2 ∧ 8105229 ^ 2 < 2 ^ 49 := by
  norm_num

/-- The elementary real argument behind both explicit Tate-height intervals. -/
theorem log_window_of_integer_certificate (N : ℕ) (hN : 0 < N)
    (hlow : (3 : ℕ) ^ 25 < N ^ 2) (hupp : N ^ 2 < (2 : ℕ) ^ 49) :
    25 < 2 * Real.log (N : ℝ) ∧ 2 * Real.log (N : ℝ) < 49 := by
  have hNreal : 0 < (N : ℝ) := by exact_mod_cast hN
  have hN2 : 0 < (N : ℝ) ^ 2 := pow_pos hNreal 2
  have hlowreal : (3 : ℝ) ^ 25 < (N : ℝ) ^ 2 := by exact_mod_cast hlow
  have huppreal : (N : ℝ) ^ 2 < (2 : ℝ) ^ 49 := by exact_mod_cast hupp
  have h3 : Real.exp 25 < (N : ℝ) ^ 2 := by
    calc
      Real.exp 25 = Real.exp 1 ^ 25 := by
        simpa only [Nat.cast_ofNat, mul_one] using Real.exp_nat_mul 1 25
      _ < (3 : ℝ) ^ 25 := pow_lt_pow_left₀ Real.exp_one_lt_three
        (Real.exp_pos 1).le (by decide)
      _ < (N : ℝ) ^ 2 := hlowreal
  have h2 : (N : ℝ) ^ 2 < Real.exp 49 := by
    calc
      (N : ℝ) ^ 2 < (2 : ℝ) ^ 49 := huppreal
      _ < Real.exp 1 ^ 49 := pow_lt_pow_left₀ Real.exp_one_gt_two (by norm_num) (by decide)
      _ = Real.exp 49 := by
        simpa only [Nat.cast_ofNat, mul_one] using (Real.exp_nat_mul 1 49).symm
  have hlo := (Real.lt_log_iff_exp_lt hN2).mpr h3
  have hhi := (Real.log_lt_iff_lt_exp hN2).mpr h2
  simpa only [Real.log_pow, Nat.cast_ofNat] using And.intro hlo hhi

/-- The real interval follows from proved integers and the actual logarithm. -/
theorem first_tate_height_window :
    25 < 2 * Real.log (8105229 : ℝ) ∧ 2 * Real.log (8105229 : ℝ) < 49 :=
  log_window_of_integer_certificate 8105229 (by decide)
    first_height_integer_certificate.1 first_height_integer_certificate.2

/-- A primitive triple whose displayed Frey curve is already a Legendre model over `ℚ`. -/
def directTriple : ABCPoint where
  a := 1
  b := 2362
  c := 2363
  a_pos := by decide
  b_pos := by decide
  c_pos := by decide
  sum_eq := by decide
  pairwise_coprime := by
    change Nat.Coprime 1 2362 ∧ Nat.Coprime 2362 2363 ∧ Nat.Coprime 2363 1
    decide

/-- The direct Legendre curve used in Section 8 of the mathematical report. -/
def directCurve : WeierstrassCurve ℚ := freyModel 1 2362

instance directCurve_isElliptic : directCurve.IsElliptic := by
  refine ⟨isUnit_iff_ne_zero.mpr ?_⟩
  rw [directCurve, freyModel_discriminant]
  norm_num

/-- The asserted parameter `-2362` occurs in the actual affine equation. -/
theorem directCurve_equation (x y : ℚ) :
    directCurve.toAffine.Equation x y ↔
      y ^ 2 = x * (x - 1) * (x - (-2362)) := by
  rw [directCurve, freyModel_equation]
  norm_num

/-- The direct model's discriminant. -/
theorem directCurve_discriminant : directCurve.Δ = 16 * (5581406 : ℚ) ^ 2 := by
  rw [directCurve, freyModel_discriminant]
  norm_num

/-- The direct model's `c₄` invariant. -/
theorem directCurve_c4 : directCurve.c₄ = 16 * 5581407 := by
  rw [directCurve, freyModel_c4]
  norm_num

/-- The direct model's `j` invariant, computed from its library definition. -/
theorem directCurve_j :
    directCurve.j = 256 * (5581407 : ℚ) ^ 3 / 5581406 ^ 2 := by
  rw [WeierstrassCurve.j, Units.val_inv_eq_inv_val, WeierstrassCurve.coe_Δ',
    directCurve_discriminant, directCurve_c4]
  norm_num

/-- Exact factorization of the two nontrivial entries; primality is also proved. -/
theorem directTriple_factorization :
    2362 = 2 * 1181 ∧ 2363 = 17 * 139 ∧
      Nat.Prime 1181 ∧ Nat.Prime 17 ∧ Nat.Prime 139 := by
  norm_num

/-- At 139 the node is at `x=1`. -/
theorem directCurve_cubic_mod139 (x : ZMod 139) :
    x * (x - 1) * (x + 2362) = x * (x - 1) ^ 2 := by
  have h2362 : (2362 : ZMod 139) = -1 := by decide
  rw [h2362]
  ring

/-- Translating the node gives the two already proved distinct tangent slopes. -/
theorem directCurve_translated_tangent_cone (x y : ZMod 139) :
    y ^ 2 - (x + 1) * x ^ 2 = (y - x) * (y + x) - x ^ 3 := by
  ring

/-- The direct model has nonzero discriminant after reduction at seven. -/
theorem directCurve_discriminant_mod7_ne_zero :
    (freyModel (1 : ZMod 7) 2362).Δ ≠ 0 := by
  rw [freyModel_discriminant]
  decide

/-- Its actual reduction over the good residue field at five. -/
def directCurve5 : WeierstrassCurve (ZMod 5) := freyModel 1 2362

instance directCurve5_isElliptic : directCurve5.IsElliptic := by
  refine ⟨isUnit_iff_ne_zero.mpr ?_⟩
  rw [directCurve5, freyModel_discriminant]
  decide

/-- The reduced equation whose finite solutions will be counted. -/
theorem directCurve5_equation (x y : ZMod 5) :
    directCurve5.toAffine.Equation x y ↔
      y ^ 2 = x * (x - 1) * (x + 2) := by
  rw [directCurve5, freyModel_equation]
  have h2362 : (2362 : ZMod 5) = 2 := by decide
  rw [h2362]

/-- All three affine solutions of the reduced direct model are counted. -/
theorem directCurve5_affine_card :
    Fintype.card {xy : ZMod 5 × ZMod 5 //
      xy.2 ^ 2 = xy.1 * (xy.1 - 1) * (xy.1 + 2)} = 3 := by
  decide

/-- The actual elliptic-curve point type contains four points, including infinity. -/
theorem directCurve5_point_card : Nat.card directCurve5.toAffine.Point = 4 := by
  let e : directCurve5.toAffine.Point ≃
      WithZero {xy : ZMod 5 × ZMod 5 //
        xy.2 ^ 2 = xy.1 * (xy.1 - 1) * (xy.1 + 2)} :=
    directCurve5.toAffine.pointEquiv.trans
      (Equiv.subtypeEquivProp (by
        funext xy
        exact propext (directCurve5_equation xy.1 xy.2))).optionCongr
  rw [Nat.card_congr e]
  change Nat.card (Option {xy : ZMod 5 × ZMod 5 //
    xy.2 ^ 2 = xy.1 * (xy.1 - 1) * (xy.1 + 2)}) = 4
  rw [Nat.card_eq_fintype_card, Fintype.card_option, directCurve5_affine_card]

/-- The trace computed from the direct model's point count equals two. -/
theorem directCurve5_count_trace :
    (5 : ℤ) + 1 - (Nat.card directCurve5.toAffine.Point : ℤ) = 2 := by
  rw [directCurve5_point_card]
  norm_num

/-- Its concrete Frobenius-polynomial candidate has no root in the seven-element field. -/
theorem direct_frobenius_polynomial_no_root :
    ∀ z : ZMod 7, z ^ 2 - 2 * z + 5 ≠ 0 := by
  decide

/-- Exact integer certificates for the second logarithmic interval. -/
theorem direct_height_integer_certificate :
    (3 : ℕ) ^ 25 < 2790703 ^ 2 ∧ 2790703 ^ 2 < 2 ^ 49 := by
  norm_num

/-- The second actual logarithmic interval, without using a numerical approximation. -/
theorem direct_tate_height_window :
    25 < 2 * Real.log (2790703 : ℝ) ∧ 2 * Real.log (2790703 : ℝ) < 49 :=
  log_window_of_integer_certificate 2790703 (by decide)
    direct_height_integer_certificate.1 direct_height_integer_certificate.2

end IUTThreeClosures.Frey139Tate210Realization20260830
