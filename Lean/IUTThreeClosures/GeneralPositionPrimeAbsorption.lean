/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTIVAbsorption

/-!
# Exact absorption of the general-position prime conditions

The auxiliary prime in IUT IV, Corollary 2.2 is not selected merely by an
eventual open-image theorem.  It is required to satisfy two complementary
conditions.

* `(P1)` gives an upper bound for `2 * log ell` in terms of the q-height,
  different and moduli degree.
* `(P2)` makes `28 * dmod / ell` at most `epsilon / 5`.

Together with the final form of the public Theorem 1.10 inequality, these
conditions yield the advertised coefficient `1 + epsilon` after moving the
small q-term from the right-hand side to the left.  This file proves that
scalar calculation exactly.

Thus the remaining quantitative arithmetic theorem is the existence of a
prime satisfying the actual admissibility conditions together with `(P1)` and
`(P2)`—the role played in the printed argument by the general-position prime
theorem.  No such existence theorem, IUT source theorem, or abc conclusion is
assumed here.
-/

namespace IUTThreeClosures

/-- The two numerical conditions imposed on the general-position auxiliary
prime in the final IUT IV absorption argument. -/
structure GeneralPositionPrimeBounds
    (ε ell dmod q6 diff : ℝ) : Prop where
  /-- Printed condition `(P1)`. -/
  log_upper :
    2 * Real.log ell ≤
      (ε / 5) * (q6 + diff) + 2 * Real.log dmod
  /-- Printed condition `(P2)`. -/
  size_lower :
    5 * 28 * dmod / ε ≤ ell

/-- Condition `(P2)` makes the prime-dependent coefficient at most
`epsilon / 5`. -/
theorem generalPosition_correction_le
    {ε ell dmod : ℝ}
    (hε : 0 < ε)
    (hell : 0 < ell)
    (hP2 : 5 * 28 * dmod / ε ≤ ell) :
    28 * dmod / ell ≤ ε / 5 := by
  have hscale : 0 ≤ ε / 5 := by positivity
  have hmul := mul_le_mul_of_nonneg_left hP2 hscale
  have hεne : ε ≠ 0 := ne_of_gt hε
  have hnum : 28 * dmod ≤ (ε / 5) * ell := by
    calc
      28 * dmod =
          (ε / 5) * (5 * 28 * dmod / ε) := by
        field_simp [hεne]
        ring
      _ ≤ (ε / 5) * ell := hmul
  exact (div_le_iff₀ hell).2 <| by
    simpa [mul_comm] using hnum

/-- **Exact IUT IV general-position absorption.**

Assume the public Theorem 1.10 estimate with its `epsilon/5` and
`28*dmod/ell` coefficients, together with the printed prime conditions `(P1)`
and `(P2)`.  Then the q-height satisfies the final `1 + epsilon` estimate with
explicit constants. -/
theorem iutIV_generalPositionPrime_absorption
    {ε ell dmod q6 diff cond : ℝ}
    (hε : 0 < ε)
    (hε1 : ε ≤ 1)
    (hell : 0 < ell)
    (hdmod : 1 ≤ dmod)
    (hdiff : 0 ≤ diff)
    (hcond : 0 ≤ cond)
    (P : GeneralPositionPrimeBounds ε ell dmod q6 diff)
    (hIUT :
      q6 ≤
        (1 + ε / 5 + 28 * dmod / ell) * (diff + cond) +
          2 * Real.log ell + 14 * Real.log (5 / ε)) :
    q6 ≤
      (1 + ε) * (diff + cond) +
        28 * Real.log (5 / ε) + 4 * Real.log dmod := by
  have hcorrection : 28 * dmod / ell ≤ ε / 5 :=
    generalPosition_correction_le hε hell P.size_lower
  have hsum_nonneg : 0 ≤ diff + cond :=
    add_nonneg hdiff hcond
  have hcoefficient :
      1 + ε / 5 + 28 * dmod / ell ≤ 1 + 2 * ε / 5 := by
    linarith
  have hcoefficient_term :
      (1 + ε / 5 + 28 * dmod / ell) * (diff + cond) ≤
        (1 + 2 * ε / 5) * (diff + cond) :=
    mul_le_mul_of_nonneg_right hcoefficient hsum_nonneg
  let C : ℝ := 14 * Real.log (5 / ε) + 2 * Real.log dmod
  have hfive_div : 1 ≤ (5 : ℝ) / ε := by
    apply (le_div_iff₀ hε).2
    linarith
  have hC : 0 ≤ C := by
    dsimp [C]
    exact add_nonneg
      (mul_nonneg (by norm_num) (Real.log_nonneg hfive_div))
      (mul_nonneg (by norm_num) (Real.log_nonneg hdmod))
  have hmain :
      q6 ≤
        (1 + 2 * ε / 5) * (diff + cond) +
          (ε / 5) * (q6 + diff) + C := by
    calc
      q6 ≤
          (1 + ε / 5 + 28 * dmod / ell) * (diff + cond) +
            2 * Real.log ell + 14 * Real.log (5 / ε) := hIUT
      _ ≤
          (1 + 2 * ε / 5) * (diff + cond) +
            ((ε / 5) * (q6 + diff) + 2 * Real.log dmod) +
              14 * Real.log (5 / ε) := by
        linarith [hcoefficient_term, P.log_upper]
      _ =
          (1 + 2 * ε / 5) * (diff + cond) +
            (ε / 5) * (q6 + diff) + C := by
        dsimp [C]
        ring
  have habsorbed :=
    proposition21_absorption hε hε1 hdiff hcond hC hmain
  calc
    q6 ≤ (1 + ε) * (diff + cond) + 2 * C := habsorbed
    _ = (1 + ε) * (diff + cond) +
        28 * Real.log (5 / ε) + 4 * Real.log dmod := by
      dsimp [C]
      ring

end IUTThreeClosures
