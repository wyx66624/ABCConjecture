/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EuclidAuxiliaryPrimeHeightLogBound

/-!
# Logarithmic source terms after Euclidean prime selection

Suppose the genuine IUT different/error contribution for the selected source is
bounded by

`C_ell * log ell + C_N * log(N+1) + E`,

where `N` is the chosen local Tate/discriminant order and the two coefficients
are nonnegative.  If `N` is linearly bounded by the abc height, then the
Euclidean selector turns this into an affine bound in `log(1+height)`.

This is the exact source-facing estimate needed before applying the elementary
sublinear logarithm lemma.
-/

namespace IUTThreeClosures

/-- Combined logarithmic source terms are affine logarithmic in height after
the Euclidean selector. -/
theorem euclid_logarithmic_source_le_log_height
    {B N p : ℕ}
    {H A D C_ell C_N E source : ℝ}
    (hN : 0 < N)
    (hH : 0 ≤ H)
    (hA : 0 ≤ A)
    (hD : 0 ≤ D)
    (hCell : 0 ≤ C_ell)
    (hCN : 0 ≤ C_N)
    (horder : (N : ℝ) ≤ A * H + D)
    (hsource :
      source ≤
        C_ell * Real.log (euclidAuxiliaryPrimeAvoidOne B N p) +
          C_N * Real.log (N + 1) + E) :
    source ≤
      (2 * C_ell + C_N) * Real.log (1 + H) +
        (2 * C_ell *
            (Real.log (B.factorial + 1) +
              Real.log (A + D + 1)) +
          C_N * Real.log (A + D + 1) + E) := by
  have hell :=
    log_euclidAuxiliaryPrimeAvoidOne_le_height
      (B := B) (N := N) (p := p)
      hN hH hA hD horder
  have hNnonneg : 0 ≤ (N : ℝ) := by positivity
  have hleft : 0 < 1 + (N : ℝ) := by positivity
  have hconstant : 0 < A + D + 1 := by linarith
  have hheight : 0 < 1 + H := by linarith
  have hprod : 0 < (A + D + 1) * (1 + H) :=
    mul_pos hconstant hheight
  have honeN :
      1 + (N : ℝ) ≤ (A + D + 1) * (1 + H) := by
    have hAH : 0 ≤ A * H := mul_nonneg hA hH
    nlinarith
  have hlogN :
      Real.log (N + 1) ≤
        Real.log (A + D + 1) + Real.log (1 + H) := by
    have hmono :
        Real.log (1 + (N : ℝ)) ≤
          Real.log ((A + D + 1) * (1 + H)) :=
      Real.strictMonoOn_log.monotoneOn hleft hprod honeN
    rw [Real.log_mul (ne_of_gt hconstant) (ne_of_gt hheight)] at hmono
    simpa [Nat.cast_add, Nat.cast_one, add_comm] using hmono
  have hellMul := mul_le_mul_of_nonneg_left hell hCell
  have hNmul := mul_le_mul_of_nonneg_left hlogN hCN
  nlinarith

end IUTThreeClosures
