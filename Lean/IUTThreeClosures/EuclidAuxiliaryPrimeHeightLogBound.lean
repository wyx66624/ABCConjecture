/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EuclidAuxiliaryPrimeLogBound

/-!
# Logarithmic height bound for the Euclidean auxiliary prime

If the local avoidance order `N` is linearly bounded by a nonnegative height
`H`, then the two-stage Euclidean selected prime has logarithm affine in
`log(1+H)`.

For fixed `B`, `A`, and `D`, the hypotheses

`(N : R) <= A*H + D`, `A,D,H >= 0`

give

`log ell <= 2*log(1+H)
  + 2*(log(B!+1) + log(A+D+1))`.

This is the exact quantitative bridge from the Frey local-order estimate to
the sublinear-height source route.
-/

namespace IUTThreeClosures

/-- A linearly height-bounded avoidance order gives a logarithmic height bound
for the selected auxiliary prime. -/
theorem log_euclidAuxiliaryPrimeAvoidOne_le_height
    {B N p : ℕ}
    {H A D : ℝ}
    (hN : 0 < N)
    (hH : 0 ≤ H)
    (hA : 0 ≤ A)
    (hD : 0 ≤ D)
    (hbound : (N : ℝ) ≤ A * H + D) :
    Real.log (euclidAuxiliaryPrimeAvoidOne B N p) ≤
      2 * Real.log (1 + H) +
        2 *
          (Real.log (B.factorial + 1) +
            Real.log (A + D + 1)) := by
  have hselected :=
    log_euclidAuxiliaryPrimeAvoidOne_le
      (B := B) (N := N) (p := p) hN
  have hNnonneg : 0 ≤ (N : ℝ) := by positivity
  have hleft : 0 < (1 + (N : ℝ)) := by positivity
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
  linarith

end IUTThreeClosures
