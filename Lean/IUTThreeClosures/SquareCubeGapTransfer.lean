/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LowRadicalNeighbourTransfer

/-!
# Square--cube gap transfer for the abc conjecture

This file specializes the general low-radical-neighbour transfer to coprime
square--cube collisions

`y^2 < x^3`.

Writing `a = x^3-y^2`, the primitive abc point is

`(a, y^2, x^3)`.

The elementary radical estimate is

`rad(a*y^2*x^3) <= a * y * x`.

Consequently, a fixed logarithmic saving in the Hall gap below the exponent
`1/2` in the variable `x` (equivalently below `1/6` in the height `x^3`)
would yield an unbounded family of abc points of quality bounded away from one
and hence disprove `ABCConjecture`.

The file proves the deterministic transfer and the exact logarithmic exponent
ledger.  It does not assert the existence of a Hall-gap family beyond the
known threshold.
-/

namespace IUTThreeClosures

/-- Positive coprime bases whose square and cube form a nonzero ordered gap. -/
structure SquareCubeGapData where
  x : ℕ
  y : ℕ
  x_pos : 0 < x
  y_pos : 0 < y
  coprime_xy : Nat.Coprime x y
  square_lt_cube : y ^ 2 < x ^ 3

namespace SquareCubeGapData

/-- Regard the square and cube as a general coprime neighbouring pair. -/
def toNeighbour (D : SquareCubeGapData) : CoprimeNeighbourData where
  b := D.y ^ 2
  c := D.x ^ 3
  b_pos := pow_pos D.y_pos 2
  b_lt_c := D.square_lt_cube
  coprime_bc := by
    have hyx : Nat.Coprime D.y D.x := D.coprime_xy.symm
    have hy2x : Nat.Coprime (D.y ^ 2) D.x :=
      (Nat.coprime_pow_left_iff (by norm_num) D.y D.x).2 hyx
    exact (Nat.coprime_pow_right_iff (by norm_num) (D.y ^ 2) D.x).2 hy2x

/-- The positive Hall gap `x^3-y^2`. -/
def gap (D : SquareCubeGapData) : ℕ := D.x ^ 3 - D.y ^ 2

@[simp] theorem gap_eq_neighbour_a (D : SquareCubeGapData) :
    D.gap = D.toNeighbour.a := rfl

@[simp] theorem gap_pos (D : SquareCubeGapData) : 0 < D.gap :=
  D.toNeighbour.a_pos

/-- The primitive abc point attached to the collision. -/
def point (D : SquareCubeGapData) : ABCPoint := D.toNeighbour.point

@[simp] theorem point_a (D : SquareCubeGapData) : D.point.a = D.gap := rfl
@[simp] theorem point_b (D : SquareCubeGapData) : D.point.b = D.y ^ 2 := rfl
@[simp] theorem point_c (D : SquareCubeGapData) : D.point.c = D.x ^ 3 := rfl

/-- Its height is exactly the logarithm of the cube. -/
theorem point_height (D : SquareCubeGapData) :
    D.point.height = Real.log ((D.x ^ 3 : ℕ) : ℝ) := by
  exact D.toNeighbour.point_height

/-- The radical of the square contributes only the base radical. -/
theorem radical_square (D : SquareCubeGapData) :
    abcRadical (D.y ^ 2) = abcRadical D.y :=
  abcRadical_pow (by norm_num)

/-- The radical of the cube contributes only the base radical. -/
theorem radical_cube (D : SquareCubeGapData) :
    abcRadical (D.x ^ 3) = abcRadical D.x :=
  abcRadical_pow (by norm_num)

/-- Exact cube logarithm identity in the repository height normalization. -/
theorem log_cube_eq_three_log_x (D : SquareCubeGapData) :
    Real.log ((D.x ^ 3 : ℕ) : ℝ) =
      3 * Real.log (D.x : ℝ) := by
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using
    (Real.log_pow (D.x : ℝ) 3)

/-- The ordered square--cube relation gives the expected half-height upper
bound for `log y`. -/
theorem log_y_lt_half_log_cube (D : SquareCubeGapData) :
    Real.log (D.y : ℝ) <
      (1 / 2 : ℝ) * Real.log ((D.x ^ 3 : ℕ) : ℝ) := by
  have hy2pos : 0 < (((D.y ^ 2 : ℕ) : ℝ)) := by
    exact_mod_cast pow_pos D.y_pos 2
  have hcast : (((D.y ^ 2 : ℕ) : ℝ)) < (((D.x ^ 3 : ℕ) : ℝ)) := by
    exact_mod_cast D.square_lt_cube
  have hlog := Real.log_lt_log hy2pos hcast
  rw [D.log_cube_eq_three_log_x]
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Real.log_pow] at hlog ⊢
  linarith

/-- The cube base contributes exactly one third of the cube height. -/
theorem log_x_eq_oneThird_log_cube (D : SquareCubeGapData) :
    Real.log (D.x : ℝ) =
      (1 / 3 : ℝ) * Real.log ((D.x ^ 3 : ℕ) : ℝ) := by
  rw [D.log_cube_eq_three_log_x]
  ring

end SquareCubeGapData

/-- A concrete upper bound for the Hall gap. -/
structure SquareCubeGapBudget (D : SquareCubeGapData) where
  H : ℕ
  gap_le : D.gap ≤ H

namespace SquareCubeGapBudget

variable {D : SquareCubeGapData}

@[simp] theorem H_pos (B : SquareCubeGapBudget D) : 0 < B.H :=
  D.gap_pos.trans_le B.gap_le

/-- Convert the Hall data to the general low-radical budget, using only
`rad(y)<=y` and `rad(x)<=x`. -/
def toLowRadicalBudget (B : SquareCubeGapBudget D) :
    LowRadicalNeighbourBudget D.toNeighbour where
  H := B.H
  B := D.y
  R := D.x
  gap_le := by simpa using B.gap_le
  radical_b_le := by
    rw [D.radical_square]
    exact abcRadical_le_self D.y_pos.ne'
  radical_c_le := by
    rw [D.radical_cube]
    exact abcRadical_le_self D.x_pos.ne'

/-- Deterministic Hall radical transfer:

`rad((x^3-y^2) * y^2 * x^3) <= H*y*x`.
-/
theorem point_radical_le (B : SquareCubeGapBudget D) :
    abcRadical (D.point.a * D.point.b * D.point.c) ≤
      B.H * D.y * D.x :=
  B.toLowRadicalBudget.point_radical_le

/-- Logarithmic conductor form of the same estimate. -/
theorem point_conductor_le (B : SquareCubeGapBudget D) :
    D.point.conductor ≤
      Real.log ((B.H * D.y * D.x : ℕ) : ℝ) :=
  B.toLowRadicalBudget.point_conductor_le

end SquareCubeGapBudget

/-- A Hall gap budget already normalized to a fixed logarithmic exponent of
`x^3`. -/
structure SquareCubeGapLogBudget
    (D : SquareCubeGapData) (δ : ℝ) where
  H : ℕ
  gap_le : D.gap ≤ H
  log_budget_le :
    Real.log ((H * D.y * D.x : ℕ) : ℝ) ≤
      δ * Real.log ((D.x ^ 3 : ℕ) : ℝ)

namespace SquareCubeGapLogBudget

variable {D : SquareCubeGapData} {δ : ℝ}

/-- Forget the logarithmic normalization. -/
def toBudget (L : SquareCubeGapLogBudget D δ) : SquareCubeGapBudget D where
  H := L.H
  gap_le := L.gap_le

/-- Convert the Hall budget to the common logarithmic-gap certificate. -/
def toLogRadicalGapCertificate
    (L : SquareCubeGapLogBudget D δ) :
    LogRadicalGapCertificate D.point ((D.x ^ 3 : ℕ) : ℝ) δ where
  X_pos := by exact_mod_cast pow_pos D.x_pos 3
  height_lower := by
    rw [D.point_height]
  conductor_upper :=
    (L.toBudget.point_conductor_le).trans L.log_budget_le

end SquareCubeGapLogBudget

/-- Any unbounded fixed-gap-exponent square--cube family disproves abc. -/
theorem not_abc_of_unbounded_squareCubeGaps
    {ε δ : ℝ}
    (hε : 0 < ε)
    (D : ℕ → SquareCubeGapData)
    (L : ∀ n, SquareCubeGapLogBudget (D n) δ)
    (hunbounded :
      ∀ C : ℝ, ∃ n : ℕ,
        C < (1 - (1 + ε) * δ) *
          Real.log (((D n).x ^ 3 : ℕ) : ℝ)) :
    ¬ ABCConjecture := by
  exact not_abc_of_unbounded_logRadicalGaps
    hε
    (fun n => (D n).point)
    (fun n => (((D n).x ^ 3 : ℕ) : ℝ))
    (fun n => (L n).toLogRadicalGapCertificate)
    hunbounded

/-- Pure logarithmic exponent ledger for the Hall transfer.

If the gap costs at most exponent `theta`, while `x` and `y` cost at most
`1/3` and `1/2` of the cube height, then the radical budget costs at most
`theta+5/6`. -/
theorem squareCube_logExponentLedger
    {H x y X θ : ℝ}
    (hH : 0 < H) (hx : 0 < x) (hy : 0 < y)
    (hgap : Real.log H ≤ θ * Real.log X)
    (hxscale : Real.log x ≤ (1 / 3 : ℝ) * Real.log X)
    (hyscale : Real.log y ≤ (1 / 2 : ℝ) * Real.log X) :
    Real.log (H * x * y) ≤
      (θ + 5 / 6) * Real.log X := by
  rw [Real.log_mul (mul_ne_zero hH.ne' hx.ne') hy.ne',
    Real.log_mul hH.ne' hx.ne']
  linarith

/-- The Hall critical threshold is exactly `theta=1/6`: every fixed saving
below it makes the total exponent strictly smaller than one. -/
theorem squareCube_totalExponent_lt_one
    {θ : ℝ} (hθ : θ < 1 / 6) :
    θ + 5 / 6 < 1 := by
  linarith

/-- A gap-only exponent budget.  The square and cube base costs are supplied
automatically by the ordered collision. -/
structure SquareCubeGapExponentBudget
    (D : SquareCubeGapData) (θ : ℝ) where
  H : ℕ
  gap_le : D.gap ≤ H
  log_gap_le :
    Real.log (H : ℝ) ≤
      θ * Real.log ((D.x ^ 3 : ℕ) : ℝ)

namespace SquareCubeGapExponentBudget

variable {D : SquareCubeGapData} {θ : ℝ}

@[simp] theorem H_pos (E : SquareCubeGapExponentBudget D θ) : 0 < E.H :=
  D.gap_pos.trans_le E.gap_le

/-- Add the automatic `1/2+1/3` base contribution to obtain the full radical
budget. -/
def toLogBudget (E : SquareCubeGapExponentBudget D θ) :
    SquareCubeGapLogBudget D (θ + 5 / 6) where
  H := E.H
  gap_le := E.gap_le
  log_budget_le := by
    have hledger := squareCube_logExponentLedger
      (H := (E.H : ℝ)) (x := (D.x : ℝ)) (y := (D.y : ℝ))
      (X := ((D.x ^ 3 : ℕ) : ℝ)) (θ := θ)
      (by exact_mod_cast E.H_pos)
      (by exact_mod_cast D.x_pos)
      (by exact_mod_cast D.y_pos)
      E.log_gap_le
      D.log_x_eq_oneThird_log_cube.le
      D.log_y_lt_half_log_cube.le
    simpa only [Nat.cast_mul] using hledger

end SquareCubeGapExponentBudget

/-- Final Hall-form disproof criterion.  A fixed exponent `theta<1/6`, together
with a compatible positive abc epsilon and an unbounded family of such gaps,
contradicts `ABCConjecture`. -/
theorem not_abc_of_unbounded_subcritical_squareCubeGaps
    {ε θ : ℝ}
    (hε : 0 < ε)
    (hcompat : (1 + ε) * (θ + 5 / 6) < 1)
    (D : ℕ → SquareCubeGapData)
    (E : ∀ n, SquareCubeGapExponentBudget (D n) θ)
    (hunboundedCube :
      ∀ C : ℝ, ∃ n : ℕ,
        C < Real.log (((D n).x ^ 3 : ℕ) : ℝ)) :
    ¬ ABCConjecture := by
  have hcoef : 0 < 1 - (1 + ε) * (θ + 5 / 6) := sub_pos.mpr hcompat
  apply not_abc_of_unbounded_squareCubeGaps
    hε D (fun n => (E n).toLogBudget)
  intro C
  obtain ⟨n, hn⟩ := hunboundedCube (C / (1 - (1 + ε) * (θ + 5 / 6)))
  refine ⟨n, ?_⟩
  have hmul := mul_lt_mul_of_pos_left hn hcoef
  field_simp [hcoef.ne'] at hmul
  simpa [mul_comm] using hmul

end IUTThreeClosures
