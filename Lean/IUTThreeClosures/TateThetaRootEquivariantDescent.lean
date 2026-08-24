/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaKummerFiber
import TateCurvesTheta.Theta.Product

/-!
# Equivariant descent of the pulled-back Tate theta-root locus

The pointwise Kummer equation

`y ^ ell = thetaProd(u)`

does not carry a naive Laurent-monomial lift of the Tate translation
`u ↦ q * u` when `ell ≥ 2`: the automorphy factor has `u`-exponent `-1`,
which is not divisible by `ell`.

There is, however, a canonical corrected construction.  After adjoining an
`ell`-th root `r` of `q` and pulling the base coordinate back by

`u = v ^ ell`,

the theta-root locus is

`y ^ ell = thetaProd(v ^ ell)`.

The translation `v ↦ r * v` then lifts by

`(v, y) ↦ (r * v, (r * v)⁻¹ * y)`.

Indeed, the `ell`-th power of the multiplier is exactly the automorphy factor
for `thetaProd(q * v ^ ell)`.  This module proves the resulting self-equivalence
of the complete pulled-back root locus.  It is a genuine algebraic descent
ingredient for the local theta-root model; constructing the analytic quotient,
its orbicurve compactification, tempered fundamental group and graph-cusp
identification remains separate.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

/-- A strict exponent obstruction to a naive Laurent-monomial lift on the
unpulled-back coordinate.  If `ell ≥ 2`, no integral Laurent exponent has
`ell`-fold power equal to exponent `-1`. -/
theorem no_integral_laurent_exponent_for_theta_root_shift
    {ell : ℕ} (hell : 2 ≤ ell) :
    ¬ ∃ m : ℤ, (ell : ℤ) * m = -1 := by
  rintro ⟨m, hm⟩
  have hellZ : (2 : ℤ) ≤ (ell : ℤ) := by
    exact_mod_cast hell
  by_cases hm_nonneg : 0 ≤ m
  · have hprod_nonneg : 0 ≤ (ell : ℤ) * m :=
      mul_nonneg (by omega) hm_nonneg
    omega
  · have hm_le : m ≤ -1 := by omega
    have hell_nonneg : 0 ≤ (ell : ℤ) := by omega
    have hprod_le : (ell : ℤ) * m ≤ -(ell : ℤ) := by
      simpa using
        (mul_le_mul_of_nonneg_left hm_le hell_nonneg)
    omega

/-- A point of the theta-root locus after the power pullback `u = v^ell`. -/
structure TateThetaRootPullbackPoint
    (t : TateParameter K) (ell : ℕ) where
  base : Kˣ
  root : K
  root_pow : root ^ ell = t.thetaProd (base ^ ell)

namespace TateThetaRootPullbackPoint

@[ext]
theorem ext
    {t : TateParameter K} {ell : ℕ}
    {x y : TateThetaRootPullbackPoint t ell}
    (hbase : x.base = y.base)
    (hroot : x.root = y.root) :
    x = y := by
  cases x
  cases y
  simp_all

/-- The theta-product automorphy factor becomes an `ell`-th power after the
base pullback and the choice `r^ell = q`. -/
theorem thetaProd_pullback_shift
    (t : TateParameter K) (ell : ℕ)
    (r v : Kˣ) (hr : r ^ ell = t.q) :
    t.thetaProd ((r * v) ^ ell) =
      (((r * v : Kˣ) : K)⁻¹) ^ ell *
        t.thetaProd (v ^ ell) := by
  have hbase : t.q * v ^ ell = (r * v) ^ ell := by
    rw [mul_pow, hr]
  have hbaseK :
      (t.q : K) * ((v ^ ell : Kˣ) : K) =
        (((r * v) ^ ell : Kˣ) : K) :=
    congrArg (fun x : Kˣ => (x : K)) hbase
  calc
    t.thetaProd ((r * v) ^ ell) =
        t.thetaProd (t.q * v ^ ell) :=
      congrArg t.thetaProd hbase.symm
    _ = ((t.q : K) * ((v ^ ell : Kˣ) : K))⁻¹ *
        t.thetaProd (v ^ ell) :=
      t.thetaProd_q_smul (v ^ ell)
    _ = (((r * v : Kˣ) : K)⁻¹) ^ ell *
        t.thetaProd (v ^ ell) := by
      rw [hbaseK]
      change
        ((((r * v : Kˣ) : K) ^ ell)⁻¹) *
            t.thetaProd (v ^ ell) =
          (((r * v : Kˣ) : K)⁻¹) ^ ell *
            t.thetaProd (v ^ ell)
      rw [← inv_pow]

/-- The forward lift of the Tate translation to the pulled-back theta-root
locus. -/
noncomputable def shift
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    TateThetaRootPullbackPoint t ell where
  base := r * z.base
  root := (((r * z.base : Kˣ) : K)⁻¹) * z.root
  root_pow := by
    rw [mul_pow, z.root_pow]
    exact (thetaProd_pullback_shift t ell r z.base hr).symm

/-- The inverse formula for the lifted Tate translation. -/
noncomputable def shiftInv
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    TateThetaRootPullbackPoint t ell where
  base := r⁻¹ * z.base
  root := (z.base : K) * z.root
  root_pow := by
    have hshift :=
      thetaProd_pullback_shift t ell r (r⁻¹ * z.base) hr
    have hshift' :
        t.thetaProd (z.base ^ ell) =
          ((z.base : K)⁻¹) ^ ell *
            t.thetaProd ((r⁻¹ * z.base) ^ ell) := by
      simpa [mul_assoc] using hshift
    calc
      ((z.base : K) * z.root) ^ ell =
          (z.base : K) ^ ell * z.root ^ ell := by
        rw [mul_pow]
      _ = (z.base : K) ^ ell *
          t.thetaProd (z.base ^ ell) := by
        rw [z.root_pow]
      _ = (z.base : K) ^ ell *
          (((z.base : K)⁻¹) ^ ell *
            t.thetaProd ((r⁻¹ * z.base) ^ ell)) := by
        rw [hshift']
      _ = t.thetaProd ((r⁻¹ * z.base) ^ ell) := by
        rw [← mul_assoc, ← mul_pow]
        simp

/-- The corrected Tate translation is a genuine self-equivalence of the
pulled-back theta-root locus. -/
noncomputable def shiftEquiv
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    TateThetaRootPullbackPoint t ell ≃
      TateThetaRootPullbackPoint t ell where
  toFun := shift t ell r hr
  invFun := shiftInv t ell r hr
  left_inv := by
    intro z
    apply ext
    · simp [shift, shiftInv, mul_assoc]
    · simp [shift, shiftInv, mul_assoc]
  right_inv := by
    intro z
    apply ext
    · simp [shift, shiftInv, mul_assoc]
    · simp [shift, shiftInv, mul_assoc]

@[simp]
theorem shiftEquiv_base
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    (shiftEquiv t ell r hr z).base = r * z.base :=
  rfl

@[simp]
theorem shiftEquiv_root
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    (shiftEquiv t ell r hr z).root =
      (((r * z.base : Kˣ) : K)⁻¹) * z.root :=
  rfl

/-- Iterating the corrected generator gives the canonical integer deck-action
candidate on the pulled-back root locus. -/
noncomputable def deckTransform
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ) :
    Equiv.Perm (TateThetaRootPullbackPoint t ell) :=
  (shiftEquiv t ell r hr) ^ n

@[simp]
theorem deckTransform_zero
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    deckTransform t ell r hr 0 = 1 := by
  simp [deckTransform]

end TateThetaRootPullbackPoint

end IUTThreeClosures
