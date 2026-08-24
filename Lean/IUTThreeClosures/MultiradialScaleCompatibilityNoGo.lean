/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualHodgeTheaterOutput
import Mathlib.Analysis.SpecialFunctions.Log.Basic

/-!
# A fixed-place common-scale obstruction for the multiradial bridge

The concrete local theta labels in `ActualHodgeTheaterOutput` are represented
by `q^(j^2)`.  This file proves the exact logarithmic power law and then shows
that one common real rescaling cannot send both the labels `1` and `2` back to
the same q-pilot logarithmic degree.

This is a diagnostic theorem.  It does not rule out a construction using
genuinely different untilts or arithmetic holomorphic structures.  It says
that such a construction cannot reduce to a single fixed valued field with a
single common scale while retaining the ordinary power law.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

/-- In any field-valued model, the logarithmic norm of the concrete
`j`-theta point retains the full square exponent. -/
theorem KummerTorsor.log_norm_thetaPoint
    {K : Type u} [NormedField K]
    (t : TateParameter K) (j : ℕ) :
    Real.log ‖((KummerTorsor.thetaPoint t j : Kˣ) : K)‖ =
      (j ^ 2 : ℝ) * Real.log ‖(t.q : K)‖ := by
  rw [KummerTorsor.thetaPoint_coe, norm_pow, Real.log_pow]
  norm_num

/-- Pure algebraic form of the obstruction: two distinct exponents cannot
both be calibrated to one nonzero degree by the same scale. -/
theorem no_common_scale_of_distinct_exponents
    {L s e₁ e₂ : ℝ}
    (hL : L ≠ 0) (he : e₁ ≠ e₂)
    (h₁ : s * (e₁ * L) = L)
    (h₂ : s * (e₂ * L) = L) : False := by
  have h₁' : s * e₁ = 1 := by
    apply mul_right_cancel₀ hL
    simpa [mul_assoc] using h₁
  have h₂' : s * e₂ = 1 := by
    apply mul_right_cancel₀ hL
    simpa [mul_assoc] using h₂
  have hs : s ≠ 0 := by
    intro hs
    simp [hs] at h₁'
  apply he
  apply mul_left_cancel₀ hs
  exact h₁'.trans h₂'.symm

/-- The labels `1` and `2` give the concrete contradiction `s*L=L` and
`s*(4*L)=L`, where `L=log ‖q‖` is nonzero for a Tate parameter. -/
theorem KummerTorsor.no_common_scale_thetaPoint_one_two
    {K : Type u} [NormedField K]
    (t : TateParameter K) (s : ℝ)
    (h₁ : s * Real.log ‖((KummerTorsor.thetaPoint t 1 : Kˣ) : K)‖ =
      Real.log ‖(t.q : K)‖)
    (h₂ : s * Real.log ‖((KummerTorsor.thetaPoint t 2 : Kˣ) : K)‖ =
      Real.log ‖(t.q : K)‖) : False := by
  have hlog : Real.log ‖(t.q : K)‖ ≠ 0 :=
    (Real.log_neg t.norm_q_pos t.norm_lt_one).ne
  rw [KummerTorsor.log_norm_thetaPoint] at h₁ h₂
  norm_num at h₁ h₂
  exact no_common_scale_of_distinct_exponents hlog (by norm_num)
    (e₁ := 1) (e₂ := 4) (by simpa using h₁) (by simpa using h₂)

end IUTThreeClosures
