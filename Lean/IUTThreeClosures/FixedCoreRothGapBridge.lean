/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Ring.GeomSum
import Mathlib.NumberTheory.DiophantineApproximation.Basic

/-!
# Fixed-core power gaps from rational-approximation lower bounds

Let `s,t > 0`, let `alpha > 0` satisfy `t * alpha^k = s`, and compare

`b = s*x^k`, `c = t*y^k`, `b <= c`.

The elementary factorization in this file proves

`c - b >= t*(alpha*x)^(k-1)*(y-alpha*x)`.

A denominator-free Roth input at exponent `2 + 1/N` is recorded by
`RothPowerApproximation alpha N C`:

`C <= |alpha*x-y|^N * x^(N+1)`.

Combining the two gives a powered lower bound for the fixed-core gap.  The
separate accepted-theorem interface supplies this approximation predicate from
the classical Thue--Siegel--Roth theorem.  No abc statement or abc-equivalent
hypothesis occurs here.
-/

namespace IUTThreeClosures
namespace FixedCoreRothGapBridge

/-- A denominator-free pointwise form of the Roth lower bound corresponding to
approximation exponent `2 + 1/N`. -/
def RothPowerApproximation (alpha : ℝ) (N : ℕ) (C : ℝ) : Prop :=
  0 < C ∧
    ∀ x y : ℕ, 0 < x →
      C ≤ |alpha * (x : ℝ) - (y : ℝ)| ^ N * (x : ℝ) ^ (N + 1)

/-- The last nonnegative term in the difference-of-powers factorization already
controls the power gap. -/
theorem base_pow_mul_sub_le_pow_sub_pow
    {z y : ℝ} {k : ℕ}
    (hz : 0 ≤ z) (hzy : z ≤ y) (hk : 0 < k) :
    z ^ (k - 1) * (y - z) ≤ y ^ k - z ^ k := by
  have hy : 0 ≤ y := hz.trans hzy
  have hsum :
      z ^ (k - 1) ≤
        ∑ i ∈ Finset.range k, y ^ i * z ^ (k - 1 - i) := by
    have hzero : 0 ∈ Finset.range k := Finset.mem_range.mpr hk
    have hsingle :
        y ^ 0 * z ^ (k - 1 - 0) ≤
          ∑ i ∈ Finset.range k, y ^ i * z ^ (k - 1 - i) := by
      exact Finset.single_le_sum
        (s := Finset.range k)
        (f := fun i => y ^ i * z ^ (k - 1 - i))
        (fun i hi => mul_nonneg (pow_nonneg hy _) (pow_nonneg hz _))
        hzero
    simpa using hsingle
  rw [← geom_sum₂_mul_of_ge (x := y) (y := z) hzy k]
  exact mul_le_mul_of_nonneg_right hsum (sub_nonneg.mpr hzy)

/-- Transfer from approximation of the fixed algebraic slope `alpha` to the
actual difference of the two fixed-core powers. -/
theorem fixedCore_gap_factor_lower_bound
    {alpha s t x y : ℝ} {k : ℕ}
    (hk : 0 < k)
    (halpha : 0 ≤ alpha) (ht : 0 ≤ t) (hx : 0 ≤ x)
    (hxy : alpha * x ≤ y)
    (hcore : t * alpha ^ k = s) :
    t * (alpha * x) ^ (k - 1) * (y - alpha * x) ≤
      t * y ^ k - s * x ^ k := by
  have hz : 0 ≤ alpha * x := mul_nonneg halpha hx
  have hpow :=
    base_pow_mul_sub_le_pow_sub_pow hz hxy hk
  calc
    t * (alpha * x) ^ (k - 1) * (y - alpha * x) =
        t * ((alpha * x) ^ (k - 1) * (y - alpha * x)) := by ring
    _ ≤ t * (y ^ k - (alpha * x) ^ k) :=
      mul_le_mul_of_nonneg_left hpow ht
    _ = t * y ^ k - s * x ^ k := by
      rw [mul_sub, mul_pow, ← mul_assoc, hcore]

/-- A powered form that avoids real exponents.  This is the precise algebraic
bridge used with the denominator-free Roth predicate. -/
theorem fixedCore_poweredGap_lower_bound
    {alpha s t x y C : ℝ} {k N : ℕ}
    (hk : 0 < k)
    (halpha : 0 ≤ alpha) (ht : 0 ≤ t) (hx : 0 ≤ x)
    (hxy : alpha * x ≤ y)
    (hcore : t * alpha ^ k = s)
    (happrox :
      C ≤ (y - alpha * x) ^ N * x ^ (N + 1)) :
    (t * (alpha * x) ^ (k - 1)) ^ N * C ≤
      (t * y ^ k - s * x ^ k) ^ N * x ^ (N + 1) := by
  let A : ℝ := t * (alpha * x) ^ (k - 1)
  let d : ℝ := y - alpha * x
  let g : ℝ := t * y ^ k - s * x ^ k
  have hz : 0 ≤ alpha * x := mul_nonneg halpha hx
  have hA : 0 ≤ A := by
    dsimp [A]
    exact mul_nonneg ht (pow_nonneg hz _)
  have hd : 0 ≤ d := by
    dsimp [d]
    exact sub_nonneg.mpr hxy
  have hfactor : A * d ≤ g := by
    dsimp [A, d, g]
    simpa [mul_assoc] using
      fixedCore_gap_factor_lower_bound hk halpha ht hx hxy hcore
  have hAd : 0 ≤ A * d := mul_nonneg hA hd
  have hpow : (A * d) ^ N ≤ g ^ N :=
    pow_le_pow_left₀ hAd hfactor N
  have hxpow : 0 ≤ x ^ (N + 1) := pow_nonneg hx _
  have hpowx :
      (A * d) ^ N * x ^ (N + 1) ≤
        g ^ N * x ^ (N + 1) :=
    mul_le_mul_of_nonneg_right hpow hxpow
  have hscaled :
      A ^ N * C ≤ A ^ N * (d ^ N * x ^ (N + 1)) :=
    mul_le_mul_of_nonneg_left happrox (pow_nonneg hA _)
  calc
    (t * (alpha * x) ^ (k - 1)) ^ N * C = A ^ N * C := by
      rfl
    _ ≤ A ^ N * (d ^ N * x ^ (N + 1)) := hscaled
    _ = (A * d) ^ N * x ^ (N + 1) := by
      have hmul_pow : (A * d) ^ N = A ^ N * d ^ N :=
        mul_pow A d N
      rw [hmul_pow]
      ring
    _ ≤ g ^ N * x ^ (N + 1) := hpowx
    _ = (t * y ^ k - s * x ^ k) ^ N * x ^ (N + 1) := by
      rfl

/-- Specialization of the powered bridge to an actual rational approximation
`y/x` supplied by `RothPowerApproximation`. -/
theorem fixedCore_poweredGap_of_rothPoint
    {alpha s t C : ℝ} {k N x y : ℕ}
    (hk : 0 < k)
    (halpha : 0 ≤ alpha) (ht : 0 ≤ t)
    (hcore : t * alpha ^ k = s)
    (hRoth : RothPowerApproximation alpha N C)
    (hx : 0 < x)
    (hxy : alpha * (x : ℝ) ≤ (y : ℝ)) :
    (t * (alpha * (x : ℝ)) ^ (k - 1)) ^ N * C ≤
      (t * (y : ℝ) ^ k - s * (x : ℝ) ^ k) ^ N *
        (x : ℝ) ^ (N + 1) := by
  have hraw := hRoth.2 x y hx
  have habs :
      |alpha * (x : ℝ) - (y : ℝ)| =
        (y : ℝ) - alpha * (x : ℝ) := by
    rw [abs_of_nonpos (sub_nonpos.mpr hxy)]
    ring
  have happrox :
      C ≤ ((y : ℝ) - alpha * (x : ℝ)) ^ N *
        (x : ℝ) ^ (N + 1) := by
    simpa [habs] using hraw
  exact fixedCore_poweredGap_lower_bound hk halpha ht
    (Nat.cast_nonneg x) hxy hcore happrox

end FixedCoreRothGapBridge
end IUTThreeClosures
