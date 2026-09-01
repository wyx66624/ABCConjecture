/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.Frey139Tate210Realization20260830
import IUTThreeClosures.FreyFullTwoIsogenyGraph

/-!
# Arithmetic underlying an entire rational isogeny class obstruction

The mathematical proofs were written and independently reviewed first in
research/ARITHMETIC_GEOMETRY_UNIFORM_GATE_2026_08_31.md.

This file constructs the actual primitive triples and four Weierstrass
models, computes their invariants, and counts the actual point type over
ZMod 7. It does not identify a rational isogeny class, import the cyclic
isogeny classification as an axiom, identify Frobenius on Galois torsion,
or define a minimal discriminant. Those are separate paper arguments.
-/

namespace IUTThreeClosures.FreyEntireIsogenyArithmetic20260831

open Frey139Tate210Realization20260830

universe u v

local instance prime3 : Fact (Nat.Prime 3) := ⟨by decide⟩
local instance prime7 : Fact (Nat.Prime 7) := ⟨by decide⟩

/-- The unbounded endpoint in the arithmetic progression used in the proof. -/
def endpointC (n : ℕ) : ℕ := 1792 * n + 2

/-- An actual element of the unchanged canonical primitive abc type. -/
def familyTriple (n : ℕ) : ABCPoint where
  a := 1
  b := 1792 * n + 1
  c := endpointC n
  a_pos := by decide
  b_pos := by omega
  c_pos := by simp [endpointC]
  sum_eq := by simp [endpointC]; omega
  pairwise_coprime := by
    change Nat.Coprime 1 (1792 * n + 1) ∧
      Nat.Coprime (1792 * n + 1) (1792 * n + 2) ∧
      Nat.Coprime (1792 * n + 2) 1
    simp [show 1792 * n + 2 = (1792 * n + 1) + 1 by omega]

theorem endpointC_strictMono : StrictMono endpointC := by
  intro m n h
  simp only [endpointC]
  omega

theorem endpointC_ge_two (n : ℕ) : 2 ≤ endpointC n := by
  simp [endpointC]

theorem endpointC_ge_1794 (n : ℕ) (hn : 1 ≤ n) : 1794 ≤ endpointC n := by
  simp only [endpointC]
  omega

theorem endpointC_mod_eight (n : ℕ) : endpointC n % 8 = 2 := by
  simp [endpointC, Nat.add_mod, Nat.mul_mod]

theorem endpointC_cast_mod_seven (n : ℕ) : (endpointC n : ZMod 7) = 2 := by
  have h1792 : (1792 : ZMod 7) = 0 := by decide
  norm_num [endpointC, Nat.cast_add, Nat.cast_mul, h1792]
  exact Or.inl h1792

/-- Four model labels, without asserting that they constitute an isogeny class in Lean. -/
inductive ModelLabel
  | original
  | zeroKernel
  | aKernel
  | negBKernel
  deriving DecidableEq

/-- The four actual integral-form Weierstrass equations, over any commutative ring. -/
def model {R : Type u} [CommRing R] (c : R) : ModelLabel → WeierstrassCurve R
  | .original => freyModel 1 (c - 1)
  | .zeroKernel => ⟨0, 4 - 2 * c, 0, c ^ 2, 0⟩
  | .aKernel => ⟨0, -2 * (c + 1), 0, (c - 1) ^ 2, 0⟩
  | .negBKernel => ⟨0, 4 * c - 2, 0, 1, 0⟩

/-- These equations commute with genuine coefficient base change. -/
theorem model_map {R : Type u} {S : Type v} [CommRing R] [CommRing S]
    (f : R →+* S) (c : R) (i : ModelLabel) :
    (model c i).map f = model (f c) i := by
  cases i <;> ext <;> simp [model, freyModel, WeierstrassCurve.map, map_ofNat]

/-- The computed c4 invariants of the actual four models. -/
theorem model_c4 {R : Type u} [CommRing R] (c : R) (i : ModelLabel) :
    (model c i).c₄ = 16 * (match i with
      | .original => c ^ 2 - c + 1
      | .zeroKernel => c ^ 2 - 16 * c + 16
      | .aKernel => c ^ 2 + 14 * c + 1
      | .negBKernel => 16 * c ^ 2 - 16 * c + 1) := by
  cases i <;>
    simp only [model, freyModel, WeierstrassCurve.c₄,
      WeierstrassCurve.b₂, WeierstrassCurve.b₄] <;> ring

/-- The computed discriminants of the actual four models. -/
theorem model_discriminant {R : Type u} [CommRing R] (c : R) (i : ModelLabel) :
    (model c i).Δ = (match i with
      | .original => 16 * (c - 1) ^ 2 * c ^ 2
      | .zeroKernel => -256 * (c - 1) * c ^ 4
      | .aKernel => 256 * c * (c - 1) ^ 4
      | .negBKernel => 256 * c * (c - 1)) := by
  cases i <;>
    simp only [model, freyModel, WeierstrassCurve.Δ, WeierstrassCurve.b₂,
      WeierstrassCurve.b₄, WeierstrassCurve.b₆, WeierstrassCurve.b₈] <;> ring

/-- The rational curves attached to the concrete primitive triple. -/
def familyCurve (n : ℕ) (i : ModelLabel) : WeierstrassCurve ℚ :=
  model (endpointC n : ℚ) i

/-- Each family model is exactly the corresponding pre-existing canonical equation. -/
theorem familyCurve_eq_canonical (n : ℕ) (i : ModelLabel) :
    familyCurve n i = (match i with
      | .original => abcFreyCurve (familyTriple n)
      | .zeroKernel => abcFreyTwoIsogenousCurve (familyTriple n)
      | .aKernel => abcFreyAtAQuotientCurve (familyTriple n)
      | .negBKernel => abcFreyAtNegBQuotientCurve (familyTriple n)) := by
  cases i <;> ext <;>
    simp [familyCurve, model, freyModel, familyTriple, endpointC, abcFreyCurve,
      abcFreyTwoIsogenousCurve, abcFreyAtAQuotientCurve,
      abcFreyAtNegBQuotientCurve] <;> ring

/-- The actual good reduction used to test the possible degree-three exit. -/
def residueCurve : WeierstrassCurve (ZMod 7) := model 2 .original

theorem residueCurve_discriminant : residueCurve.Δ = 1 := by
  rw [residueCurve, model_discriminant]
  decide

instance residueCurve_isElliptic : residueCurve.IsElliptic := by
  refine ⟨?_⟩
  rw [residueCurve_discriminant]
  exact isUnit_one

/-- The integral canonical Frey curve really reduces to the counted curve for every n. -/
theorem canonical_reduction_seven (n : ℕ) :
    (abcFreyCurveZ (familyTriple n)).map (Int.castRingHom (ZMod 7)) =
      residueCurve := by
  have h1792 : (1792 : ZMod 7) = 0 := by decide
  ext <;> norm_num [abcFreyCurveZ, familyTriple, endpointC,
    residueCurve, model, freyModel, WeierstrassCurve.map, h1792]
  all_goals exact Or.inl h1792

theorem residueCurve_equation (x y : ZMod 7) :
    residueCurve.toAffine.Equation x y ↔ y ^ 2 = x ^ 3 - x := by
  change (freyModel 1 (2 - 1 : ZMod 7)).toAffine.Equation x y ↔ _
  rw [freyModel_equation]
  have h : x * (x - 1) * (x + (2 - 1)) = x ^ 3 - x := by ring
  rw [h]

/-- Exact count of the affine solutions, evaluated by the Lean kernel. -/
theorem residueCurve_affine_card :
    Fintype.card {xy : ZMod 7 × ZMod 7 // xy.2 ^ 2 = xy.1 ^ 3 - xy.1} = 7 := by
  decide

/-- Exact count of the library's actual elliptic-curve point type, including infinity. -/
theorem residueCurve_point_card : Nat.card residueCurve.toAffine.Point = 8 := by
  let e : residueCurve.toAffine.Point ≃
      WithZero {xy : ZMod 7 × ZMod 7 // xy.2 ^ 2 = xy.1 ^ 3 - xy.1} :=
    residueCurve.toAffine.pointEquiv.trans
      (Equiv.subtypeEquivProp (by
        funext xy
        exact propext (residueCurve_equation xy.1 xy.2))).optionCongr
  rw [Nat.card_congr e]
  change Nat.card (Option {xy : ZMod 7 × ZMod 7 //
    xy.2 ^ 2 = xy.1 ^ 3 - xy.1}) = 8
  rw [Nat.card_eq_fintype_card, Fintype.card_option, residueCurve_affine_card]

/-- Point-count trace only: the Galois/Frobenius interpretation is not asserted in Lean. -/
theorem residueCurve_count_trace :
    (7 : ℤ) + 1 - (Nat.card residueCurve.toAffine.Point : ℤ) = 0 := by
  rw [residueCurve_point_card]
  norm_num

/-- The polynomial supplied by the paper's external Frobenius theorem has no root. -/
theorem degree_three_polynomial_no_root :
    ∀ z : ZMod 3, z ^ 2 + 1 ≠ 0 := by decide

/-! ## Uniform bounds for the actual models and their rational j-invariants -/

theorem model_discriminant_abs (c : ℚ) (hc : 1 ≤ c) (i : ModelLabel) :
    |(model c i).Δ| = (match i with
      | .original => 16 * (c - 1) ^ 2 * c ^ 2
      | .zeroKernel => 256 * (c - 1) * c ^ 4
      | .aKernel => 256 * c * (c - 1) ^ 4
      | .negBKernel => 256 * c * (c - 1)) := by
  have hc0 : 0 ≤ c := by linarith
  have hc1 : 0 ≤ c - 1 := by linarith
  cases i <;> rw [model_discriminant] <;>
    simp [abs_mul, abs_of_nonneg hc0, abs_of_nonneg hc1]

/-- A fifth-power upper bound for every actual displayed discriminant. -/
theorem model_discriminant_upper (c : ℚ) (hc : 1 ≤ c) (i : ModelLabel) :
    |(model c i).Δ| ≤ 256 * c ^ 5 := by
  have hc0 : 0 ≤ c := by linarith
  have hc1 : 0 ≤ c - 1 := by linarith
  have hsub : c - 1 ≤ c := by linarith
  have hp2 := pow_le_pow_left₀ hc1 hsub 2
  have hp4 := pow_le_pow_left₀ hc1 hsub 4
  cases i with
  | original =>
      rw [model_discriminant_abs c hc]
      calc
        16 * (c - 1) ^ 2 * c ^ 2 ≤ 16 * c ^ 2 * c ^ 2 :=
          mul_le_mul_of_nonneg_right
            (mul_le_mul_of_nonneg_left hp2 (by norm_num)) (sq_nonneg c)
        _ = 16 * c ^ 4 := by ring
        _ ≤ 256 * c ^ 5 := by
          have h := mul_nonneg (pow_nonneg hc0 4)
            (show 0 ≤ 256 * c - 16 by linarith)
          nlinarith
  | zeroKernel =>
      rw [model_discriminant_abs c hc]
      calc
        256 * (c - 1) * c ^ 4 ≤ 256 * c * c ^ 4 :=
          mul_le_mul_of_nonneg_right
            (mul_le_mul_of_nonneg_left hsub (by norm_num)) (pow_nonneg hc0 4)
        _ = 256 * c ^ 5 := by ring
  | aKernel =>
      rw [model_discriminant_abs c hc]
      calc
        256 * c * (c - 1) ^ 4 ≤ 256 * c * c ^ 4 :=
          mul_le_mul_of_nonneg_left hp4 (by positivity)
        _ = 256 * c ^ 5 := by ring
  | negBKernel =>
      rw [model_discriminant_abs c hc]
      have hp14 : c ≤ c ^ 4 := by
        simpa using pow_le_pow_right₀ hc (show 1 ≤ 4 by decide)
      calc
        256 * c * (c - 1) ≤ 256 * c * c ^ 4 :=
          mul_le_mul_of_nonneg_left (hsub.trans hp14) (by positivity)
        _ = 256 * c ^ 5 := by ring

/-- All four actual c4 invariants retain a quadratic archimedean lower bound. -/
theorem model_c4_lower (c : ℚ) (hc : 32 ≤ c) (i : ModelLabel) :
    8 * c ^ 2 ≤ (model c i).c₄ := by
  have hc0 : 0 ≤ c := by linarith
  have hquad : 32 * c ≤ c ^ 2 := by
    nlinarith [mul_nonneg hc0 (show 0 ≤ c - 32 by linarith)]
  cases i <;> rw [model_c4] <;> dsimp <;> nlinarith [sq_nonneg (c - 1)]

theorem model_discriminant_ne_zero (c : ℚ) (hc : 1 < c) (i : ModelLabel) :
    (model c i).Δ ≠ 0 := by
  have hc0 : c ≠ 0 := ne_of_gt (lt_trans (by norm_num) hc)
  have hc1 : c - 1 ≠ 0 := sub_ne_zero.mpr hc.ne'
  cases i <;> rw [model_discriminant] <;> simp [hc0, hc1]

instance familyCurve_isElliptic (n : ℕ) (i : ModelLabel) :
    (familyCurve n i).IsElliptic := by
  refine ⟨isUnit_iff_ne_zero.mpr ?_⟩
  apply model_discriminant_ne_zero
  have h : (2 : ℚ) ≤ endpointC n := by exact_mod_cast endpointC_ge_two n
  linarith

/-- This is the library j-invariant, expanded through the actual discriminant unit. -/
theorem familyCurve_abs_j (n : ℕ) (i : ModelLabel) :
    |(familyCurve n i).j| =
      |(familyCurve n i).c₄| ^ 3 / |(familyCurve n i).Δ| := by
  rw [WeierstrassCurve.j, Units.val_inv_eq_inv_val, WeierstrassCurve.coe_Δ',
    abs_mul, abs_inv, abs_pow]
  ring

/-- Every displayed curve in the actual family has archimedean absolute j at least 2c. -/
theorem familyCurve_j_lower (n : ℕ) (hn : 1 ≤ n) (i : ModelLabel) :
    2 * (endpointC n : ℚ) ≤ |(familyCurve n i).j| := by
  let c : ℚ := endpointC n
  have hc32 : 32 ≤ c := by
    have h : (1794 : ℚ) ≤ c := by
      change (1794 : ℚ) ≤ (endpointC n : ℚ)
      exact_mod_cast endpointC_ge_1794 n hn
    linarith
  have hc1 : 1 < c := by linarith
  have hc0 : 0 ≤ c := by linarith
  have h4 : 8 * c ^ 2 ≤ |(model c i).c₄| :=
    (model_c4_lower c hc32 i).trans (le_abs_self _)
  have hnum : 512 * c ^ 6 ≤ |(model c i).c₄| ^ 3 := by
    calc
      512 * c ^ 6 = (8 * c ^ 2) ^ 3 := by ring
      _ ≤ |(model c i).c₄| ^ 3 :=
        pow_le_pow_left₀ (show 0 ≤ 8 * c ^ 2 by positivity) h4 3
  have hden : 0 < |(model c i).Δ| :=
    abs_pos.mpr (model_discriminant_ne_zero c hc1 i)
  rw [familyCurve_abs_j]
  change 2 * c ≤ |(model c i).c₄| ^ 3 / |(model c i).Δ|
  apply (le_div_iff₀ hden).mpr
  calc
    2 * c * |(model c i).Δ| ≤ 2 * c * (256 * c ^ 5) :=
      mul_le_mul_of_nonneg_left (model_discriminant_upper c hc1.le i) (by positivity)
    _ = 512 * c ^ 6 := by ring
    _ ≤ |(model c i).c₄| ^ 3 := hnum

/-- The zero-kernel model witnesses the matching upper bound 32c for actual j. -/
theorem zeroKernel_j_upper (n : ℕ) (hn : 1 ≤ n) :
    |(familyCurve n .zeroKernel).j| ≤ 32 * (endpointC n : ℚ) := by
  let c : ℚ := endpointC n
  have hc32 : 32 ≤ c := by
    have h : (1794 : ℚ) ≤ c := by
      change (1794 : ℚ) ≤ (endpointC n : ℚ)
      exact_mod_cast endpointC_ge_1794 n hn
    linarith
  have hc1 : 1 < c := by linarith
  have hc0 : 0 ≤ c := by linarith
  have h4nonneg : 0 ≤ (model c .zeroKernel).c₄ :=
    (show 0 ≤ 8 * c ^ 2 by positivity).trans (model_c4_lower c hc32 .zeroKernel)
  have h4upper : |(model c .zeroKernel).c₄| ≤ 16 * c ^ 2 := by
    rw [abs_of_nonneg h4nonneg, model_c4]
    dsimp
    nlinarith
  have hnum : |(model c .zeroKernel).c₄| ^ 3 ≤ 4096 * c ^ 6 := by
    calc
      |(model c .zeroKernel).c₄| ^ 3 ≤ (16 * c ^ 2) ^ 3 :=
        pow_le_pow_left₀ (abs_nonneg _) h4upper 3
      _ = 4096 * c ^ 6 := by ring
  have hden : 0 < |(model c .zeroKernel).Δ| :=
    abs_pos.mpr (model_discriminant_ne_zero c hc1 .zeroKernel)
  rw [familyCurve_abs_j]
  change |(model c .zeroKernel).c₄| ^ 3 / |(model c .zeroKernel).Δ| ≤ 32 * c
  apply (div_le_iff₀ hden).mpr
  calc
    |(model c .zeroKernel).c₄| ^ 3 ≤ 4096 * c ^ 6 := hnum
    _ ≤ 32 * c * |(model c .zeroKernel).Δ| := by
      rw [model_discriminant_abs c hc1.le]
      have h := mul_nonneg (show 0 ≤ 4096 * c ^ 5 by positivity)
        (show 0 ≤ c - 2 by linarith)
      nlinarith

#print axioms familyCurve_eq_canonical
#print axioms residueCurve_point_card
#print axioms degree_three_polynomial_no_root
#print axioms model_discriminant_upper
#print axioms familyCurve_j_lower
#print axioms zeroKernel_j_upper

end IUTThreeClosures.FreyEntireIsogenyArithmetic20260831
