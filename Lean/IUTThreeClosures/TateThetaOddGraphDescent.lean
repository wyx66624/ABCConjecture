/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaKummerFiber
import TateCurvesTheta.Theta.Product

/-!
# Odd graph-period descent of the Tate theta-root locus

For the product normalization used by `TateCurvesTheta`, one has

`thetaProd (q * u) = (q * u)⁻¹ * thetaProd u`.

Iterating this identity through `n` graph steps gives the triangular exponent

`thetaProd (q^n * u) = (q^(1 + ... + n) * u^n)⁻¹ * thetaProd u`.

When `ell = 2 * k + 1` is odd, the multiplier for the `ell`-step graph period
is an exact `ell`-th power.  Consequently the unpulled-back Kummer locus

`y^ell = thetaProd u`

carries an explicit self-equivalence over `u ↦ q^ell * u`.  This is the
algebraic descent appropriate to the graph-direction cover with period
`q^ell`.  It is distinct from the power-pullback construction `u = v^ell`,
`r^ell = q`, which belongs to the cyclotomic direction.

This module proves only the algebraic automorphy and explicit equivalence.  It
does not assert the existence of an analytic quotient, an orbicurve, or a
tempered fundamental group.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

/-! ## Iterated automorphy -/

/-- The triangular exponent `1 + ... + n`, defined recursively so that its
successor identity is available without natural-number division. -/
def thetaTriangular : ℕ → ℕ
  | 0 => 0
  | n + 1 => thetaTriangular n + (n + 1)

@[simp]
theorem thetaTriangular_zero : thetaTriangular 0 = 0 :=
  rfl

@[simp]
theorem thetaTriangular_succ (n : ℕ) :
    thetaTriangular (n + 1) = thetaTriangular n + (n + 1) :=
  rfl

/-- The exact `n`-step automorphy formula for the Tate theta product. -/
theorem thetaProd_qpow_smul_nat
    (t : TateParameter K) (n : ℕ) (v : Kˣ) :
    t.thetaProd (t.q ^ n * v) =
      (((t.q : K) ^ thetaTriangular n * (v : K) ^ n)⁻¹ *
        t.thetaProd v) := by
  induction n with
  | zero => simp
  | succ n ih =>
      calc
        t.thetaProd (t.q ^ (n + 1) * v) =
            t.thetaProd (t.q * (t.q ^ n * v)) := by
              congr 1
              rw [pow_succ]
              ac_rfl
        _ = ((↑(t.q * (t.q ^ n * v)) : K)⁻¹ *
              t.thetaProd (t.q ^ n * v)) :=
            t.thetaProd_q_smul (t.q ^ n * v)
        _ = ((↑(t.q * (t.q ^ n * v)) : K)⁻¹ *
              (((t.q : K) ^ thetaTriangular n * (v : K) ^ n)⁻¹ *
                t.thetaProd v)) := by
              rw [ih]
        _ = (((t.q : K) ^ thetaTriangular (n + 1) *
                (v : K) ^ (n + 1))⁻¹ * t.thetaProd v) := by
              simp only [Units.val_mul, thetaTriangular_succ]
              push_cast
              rw [pow_add, pow_succ]
              field_simp [t.q.ne_zero, v.ne_zero]
              ring

/-- At an odd index, the triangular exponent factors by that index. -/
theorem thetaTriangular_odd (k : ℕ) :
    thetaTriangular (2 * k + 1) = (2 * k + 1) * (k + 1) := by
  induction k with
  | zero => simp [thetaTriangular]
  | succ k ih =>
      rw [show 2 * (k + 1) + 1 = (2 * k + 1) + 1 + 1 by omega]
      rw [thetaTriangular_succ, thetaTriangular_succ, ih]
      ring

/-- For the odd graph period `ell = 2*k+1`, the theta automorphy
multiplier is an exact `ell`-th power. -/
theorem thetaProd_qpow_smul_odd
    (t : TateParameter K) (k : ℕ) (v : Kˣ) :
    t.thetaProd (t.q ^ (2 * k + 1) * v) =
      (((↑(t.q ^ (k + 1) * v) : K)⁻¹) ^ (2 * k + 1) *
        t.thetaProd v) := by
  rw [thetaProd_qpow_smul_nat, thetaTriangular_odd]
  congr 1
  rw [inv_pow, Units.val_mul]
  push_cast
  rw [mul_pow, ← pow_mul,
    Nat.mul_comm (2 * k + 1) (k + 1)]

/-! ## The unpulled-back odd theta-root locus -/

/-- A point of the unpulled-back Kummer locus `y^ell = thetaProd u`. -/
structure TateThetaRootPoint (t : TateParameter K) (ell : ℕ) where
  base : Kˣ
  root : K
  root_pow : root ^ ell = t.thetaProd base

namespace TateThetaRootPoint

omit [CompleteSpace K] in
@[ext]
theorem ext
    {t : TateParameter K} {ell : ℕ}
    {x y : TateThetaRootPoint t ell}
    (hbase : x.base = y.base)
    (hroot : x.root = y.root) :
    x = y := by
  cases x
  cases y
  simp_all

/-- The lift of the odd graph-period translation `u ↦ q^ell*u` to the
theta-root locus, where `ell = 2*k+1`. -/
noncomputable def oddPeriodShift
    (t : TateParameter K) (k : ℕ)
    (z : TateThetaRootPoint t (2 * k + 1)) :
    TateThetaRootPoint t (2 * k + 1) where
  base := t.q ^ (2 * k + 1) * z.base
  root := (↑(t.q ^ (k + 1) * z.base) : K)⁻¹ * z.root
  root_pow := by
    rw [mul_pow, z.root_pow]
    exact (thetaProd_qpow_smul_odd t k z.base).symm

/-- The explicit inverse lift.  Its root multiplier is `q^(-k)*U`. -/
noncomputable def oddPeriodShiftInv
    (t : TateParameter K) (k : ℕ)
    (z : TateThetaRootPoint t (2 * k + 1)) :
    TateThetaRootPoint t (2 * k + 1) where
  base := (t.q ^ (2 * k + 1))⁻¹ * z.base
  root := (↑((t.q ^ k)⁻¹ * z.base) : K) * z.root
  root_pow := by
    let v : Kˣ := (t.q ^ (2 * k + 1))⁻¹ * z.base
    let a : Kˣ := (t.q ^ k)⁻¹ * z.base
    let m : Kˣ := (t.q ^ (k + 1) * v)⁻¹
    have hbase : t.q ^ (2 * k + 1) * v = z.base := by
      simp [v]
    have htheta := thetaProd_qpow_smul_odd t k v
    rw [hbase] at htheta
    have ham : a * m = 1 := by
      dsimp [a, m, v]
      group
    change ((a : K) * z.root) ^ (2 * k + 1) = t.thetaProd v
    rw [mul_pow, z.root_pow, htheta, ← mul_assoc]
    have hamK : (a : K) * (m : K) = 1 := by
      simpa using congrArg (fun w : Kˣ => (w : K)) ham
    have hmK : (m : K) = (↑(t.q ^ (k + 1) * v) : K)⁻¹ := by
      simp [m]
    rw [← hmK, ← mul_pow, hamK, one_pow, one_mul]

/-- The odd graph-period lift is a genuine self-equivalence of the complete
unpulled-back theta-root locus. -/
noncomputable def oddPeriodShiftEquiv
    (t : TateParameter K) (k : ℕ) :
    TateThetaRootPoint t (2 * k + 1) ≃
      TateThetaRootPoint t (2 * k + 1) where
  toFun := oddPeriodShift t k
  invFun := oddPeriodShiftInv t k
  left_inv := by
    intro z
    apply ext
    · simp [oddPeriodShift, oddPeriodShiftInv]
    · simp [oddPeriodShift, oddPeriodShiftInv]
      field_simp [t.q.ne_zero, z.base.ne_zero]
      ring
  right_inv := by
    intro z
    apply ext
    · simp [oddPeriodShift, oddPeriodShiftInv]
    · simp [oddPeriodShift, oddPeriodShiftInv]
      field_simp [t.q.ne_zero, z.base.ne_zero]
      ring

@[simp]
theorem oddPeriodShiftEquiv_base
    (t : TateParameter K) (k : ℕ)
    (z : TateThetaRootPoint t (2 * k + 1)) :
    (oddPeriodShiftEquiv t k z).base =
      t.q ^ (2 * k + 1) * z.base :=
  rfl

@[simp]
theorem oddPeriodShiftEquiv_root
    (t : TateParameter K) (k : ℕ)
    (z : TateThetaRootPoint t (2 * k + 1)) :
    (oddPeriodShiftEquiv t k z).root =
      (↑(t.q ^ (k + 1) * z.base) : K)⁻¹ * z.root :=
  rfl

end TateThetaRootPoint

end IUTThreeClosures
