/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootDeckFreeness
import Mathlib.Analysis.SpecialFunctions.Log.Basic

/-!
# The radial skeleton coordinate of the corrected theta-root cover

For the corrected pulled-back theta-root cover, choose `r` with `r^ell=q`.
The real logarithmic radius

`rho(v) = log ‖v‖ / log ‖r‖`

is well-defined because `0 < ‖r‖ < 1`. Multiplication by `r` translates this
coordinate by one. More generally, the `n`-th positive deck iterate translates
it by `n`.

This gives an explicit bridge from the analytic Tate/Kummer deck action to the
oriented cyclic-skeleton model: after quotienting the radial coordinate by
integer translation, the deck generator is literally successor/translation by
one. The theorem does not construct the topological or Berkovich quotient; it
identifies the exact invariant that such a quotient must carry.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootRadialSkeleton

/-- The logarithmic radial coordinate normalized so that multiplication by
`r` has translation length one. -/
noncomputable def coordinate
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (z : TateThetaRootPullbackPoint t ell) : ℝ :=
  Real.log ‖(z.base : K)‖ / Real.log ‖(r : K)‖

/-- The chosen root has positive norm. -/
theorem root_norm_pos (r : Kˣ) : 0 < ‖(r : K)‖ :=
  norm_pos_iff.mpr (Units.ne_zero r)

/-- Taking norms in `r^ell=q`. -/
theorem root_norm_pow_eq_q_norm
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ‖(r : K)‖ ^ ell = ‖(t.q : K)‖ := by
  have h := congrArg (fun a : Kˣ => ‖(a : K)‖) hr
  simpa only [Units.val_pow_eq_pow_val, norm_pow] using h

/-- Every chosen root of a strict Tate parameter has norm strictly below one. -/
theorem root_norm_lt_one
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ‖(r : K)‖ < 1 := by
  by_contra hnot
  have hge : 1 ≤ ‖(r : K)‖ := le_of_not_gt hnot
  have hpow : 1 ≤ ‖(r : K)‖ ^ ell := by
    induction ell with
    | zero => simp
    | succ n ih =>
        rw [pow_succ]
        simpa only [one_mul] using
          (mul_le_mul ih hge
            (by norm_num : (0 : ℝ) ≤ 1)
            (pow_nonneg (norm_nonneg (r : K)) n))
  rw [root_norm_pow_eq_q_norm t ell r hr] at hpow
  exact (not_le_of_gt t.norm_lt_one) hpow

/-- If `r^ell=q`, the normalizing logarithm is strictly negative. -/
theorem log_root_norm_neg
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    Real.log ‖(r : K)‖ < 0 := by
  calc
    Real.log ‖(r : K)‖ < Real.log 1 :=
      Real.log_lt_log (root_norm_pos r)
        (root_norm_lt_one t ell r hr)
    _ = 0 := Real.log_one

/-- Hence the normalizing logarithm is nonzero. -/
theorem log_root_norm_ne_zero
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    Real.log ‖(r : K)‖ ≠ 0 :=
  (log_root_norm_neg t ell r hr).ne

/-- Every base coordinate is nonzero, hence has positive norm. -/
theorem base_norm_pos
    {t : TateParameter K} {ell : ℕ}
    (z : TateThetaRootPullbackPoint t ell) :
    0 < ‖(z.base : K)‖ :=
  norm_pos_iff.mpr (Units.ne_zero z.base)

/-- One corrected Tate translation is exactly translation by one on the
normalized radial coordinate. -/
theorem coordinate_shift
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r
        (TateThetaRootPullbackPoint.shift t ell r hr z) =
      coordinate t ell r z + 1 := by
  have hr0 : ‖(r : K)‖ ≠ 0 := ne_of_gt (root_norm_pos r)
  have hz0 : ‖(z.base : K)‖ ≠ 0 := ne_of_gt (base_norm_pos z)
  have hlog : Real.log ‖(r : K)‖ ≠ 0 :=
    log_root_norm_ne_zero t ell r hr
  change
    Real.log ‖((r * z.base : Kˣ) : K)‖ /
        Real.log ‖(r : K)‖ =
      Real.log ‖(z.base : K)‖ / Real.log ‖(r : K)‖ + 1
  rw [Units.val_mul, norm_mul, Real.log_mul hr0 hz0]
  field_simp [hlog]
  ring

/-- The self-equivalence generator acts by the same unit translation. -/
theorem coordinate_shiftEquiv
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r
        (TateThetaRootPullbackPoint.shiftEquiv t ell r hr z) =
      coordinate t ell r z + 1 :=
  coordinate_shift t ell r hr z

/-- The `n`-th positive deck iterate translates the radial coordinate by the
integer `n`. -/
theorem coordinate_shiftNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r
        (TateThetaRootPullbackPoint.shiftNat t ell r hr n z) =
      coordinate t ell r z + n := by
  induction n with
  | zero => simp [coordinate]
  | succ n ih =>
      rw [TateThetaRootPullbackPoint.shiftNat_succ,
        coordinate_shift, ih]
      push_cast
      ring

/-- Two positive iterates have the same radial coordinate only when their
indices agree. -/
theorem coordinate_shiftNat_injective_index
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    {m n : ℕ}
    (hcoord :
      coordinate t ell r
          (TateThetaRootPullbackPoint.shiftNat t ell r hr m z) =
        coordinate t ell r
          (TateThetaRootPullbackPoint.shiftNat t ell r hr n z)) :
    m = n := by
  rw [coordinate_shiftNat, coordinate_shiftNat] at hcoord
  have hreal : (m : ℝ) = n := by linarith
  exact_mod_cast hreal

/-- The radial coordinate separates all positive points of one deck orbit. -/
theorem shiftNat_ne_of_ne_index
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    {m n : ℕ} (hmn : m ≠ n) :
    TateThetaRootPullbackPoint.shiftNat t ell r hr m z ≠
      TateThetaRootPullbackPoint.shiftNat t ell r hr n z := by
  intro h
  apply hmn
  apply coordinate_shiftNat_injective_index t ell r hr z
  exact congrArg (coordinate t ell r) h

end TateThetaRootRadialSkeleton

end IUTThreeClosures
