/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointPowerFreeClosure
import Mathlib.Data.Nat.Factorization.Root
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Tactic

/-!
# Canonical floor roots and the radical-layer budget

For `k>0`, Mathlib's `Nat.floorRoot k n` extracts the canonical `k`-th-power
root whose prime exponent at `p` is `floor(v_p(n)/k)`.  The complementary
kernel therefore has exponent `v_p(n) mod k`, hence at most `k-1`.

This file turns that observation into the actual natural-number inequality

`n <= rad(n)^(k-1) * floorRoot(k,n)^k`

and its logarithmic form.  The square and cube specializations say that the
ordinary multiplicity excess and the signed square-radical defect force large
actual square and cube divisors, respectively.

No abc estimate, distribution theorem, or Diophantine gap theorem is assumed.
-/

namespace IUTThreeClosures
namespace CanonicalFloorRootRadicalBudget

open UniqueFactorizationMonoid
open LargeEndpointPowerFreeClosure

noncomputable section

/-- The canonical `k`-power-free residue after extracting the Mathlib floor
root. -/
def canonicalPowerKernel (k n : ℕ) : ℕ :=
  n / Nat.floorRoot k n ^ k

/-- Exact canonical power decomposition. -/
theorem canonicalPowerKernel_mul_floorRoot_pow_eq
    (k n : ℕ) :
    canonicalPowerKernel k n * Nat.floorRoot k n ^ k = n := by
  unfold canonicalPowerKernel
  exact Nat.div_mul_cancel (Nat.floorRoot_pow_dvd (n := k) (a := n))

/-- The canonical residue is nonzero on a nonzero input. -/
theorem canonicalPowerKernel_ne_zero
    {k n : ℕ} (hn : n ≠ 0) :
    canonicalPowerKernel k n ≠ 0 := by
  intro hzero
  have hdecomp := canonicalPowerKernel_mul_floorRoot_pow_eq k n
  rw [hzero, zero_mul] at hdecomp
  exact hn hdecomp.symm

/-- Primewise, the canonical residue exponent is exactly `v_p(n) mod k`. -/
theorem factorization_canonicalPowerKernel
    {k n : ℕ} (hk : 0 < k) (hn : n ≠ 0) (p : ℕ) :
    (canonicalPowerKernel k n).factorization p =
      n.factorization p % k := by
  unfold canonicalPowerKernel
  rw [Nat.factorization_div (Nat.floorRoot_pow_dvd (n := k) (a := n)),
    Nat.factorization_pow, Nat.factorization_floorRoot]
  change n.factorization p - k * (n.factorization p / k) =
    n.factorization p % k
  have hsplit := Nat.mod_add_div (n.factorization p) k
  omega

/-- The canonical residue has every prime exponent at most `k-1`. -/
theorem canonicalPowerKernel_isExponentAtMost
    {k n : ℕ} (hk : 0 < k) (hn : n ≠ 0) :
    IsExponentAtMost (k - 1) (canonicalPowerKernel k n) := by
  refine ⟨canonicalPowerKernel_ne_zero hn, ?_⟩
  intro p hp
  rw [factorization_canonicalPowerKernel hk hn p]
  have hlt := Nat.mod_lt (n.factorization p) hk
  omega

/-- The canonical residue divides the original integer. -/
theorem canonicalPowerKernel_dvd
    (k n : ℕ) : canonicalPowerKernel k n ∣ n := by
  refine ⟨Nat.floorRoot k n ^ k, ?_⟩
  exact (canonicalPowerKernel_mul_floorRoot_pow_eq k n).symm

/-- Radical monotonicity for the canonical residue. -/
theorem radical_canonicalPowerKernel_le
    {k n : ℕ} (hn : n ≠ 0) :
    abcRadical (canonicalPowerKernel k n) ≤ abcRadical n := by
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical]
  have hdiv :
      radical (canonicalPowerKernel k n) ∣ radical n :=
    radical_dvd_radical (canonicalPowerKernel_dvd k n) hn
  exact Nat.le_of_dvd (Nat.radical_pos n) hdiv

/-- The power-free kernel is bounded by `rad(n)^(k-1)`. -/
theorem canonicalPowerKernel_le_radical_pow
    {k n : ℕ} (hk : 0 < k) (hn : n ≠ 0) :
    canonicalPowerKernel k n ≤ abcRadical n ^ (k - 1) := by
  calc
    canonicalPowerKernel k n ≤
        abcRadical (canonicalPowerKernel k n) ^ (k - 1) :=
      (canonicalPowerKernel_isExponentAtMost hk hn).le_radical_pow
    _ ≤ abcRadical n ^ (k - 1) :=
      Nat.pow_le_pow_left (radical_canonicalPowerKernel_le hn) (k - 1)

/-- Actual natural-number radical/root budget. -/
theorem le_radical_pow_mul_floorRoot_pow
    {k n : ℕ} (hk : 0 < k) (hn : n ≠ 0) :
    n ≤ abcRadical n ^ (k - 1) * Nat.floorRoot k n ^ k := by
  calc
    n = canonicalPowerKernel k n * Nat.floorRoot k n ^ k :=
      (canonicalPowerKernel_mul_floorRoot_pow_eq k n).symm
    _ ≤ abcRadical n ^ (k - 1) * Nat.floorRoot k n ^ k :=
      Nat.mul_le_mul_right _ (canonicalPowerKernel_le_radical_pow hk hn)

/-- Logarithmic form of the canonical radical/root budget. -/
theorem log_le_radicalLayers_add_floorRoot
    {k n : ℕ} (hk : 0 < k) (hn : n ≠ 0) :
    Real.log (n : ℝ) ≤
      ((k - 1 : ℕ) : ℝ) * Real.log (abcRadical n : ℝ) +
        (k : ℝ) * Real.log (Nat.floorRoot k n : ℝ) := by
  have hnpos : 0 < (n : ℝ) := by
    exact_mod_cast Nat.pos_of_ne_zero hn
  have hradpos : 0 < (abcRadical n : ℝ) := by
    exact_mod_cast abcRadical_pos n
  have hrootne : Nat.floorRoot k n ≠ 0 :=
    Nat.floorRoot_ne_zero.2 ⟨ne_of_gt hk, hn⟩
  have hrootpos : 0 < (Nat.floorRoot k n : ℝ) := by
    exact_mod_cast Nat.pos_of_ne_zero hrootne
  have hreal :
      (n : ℝ) ≤
        (abcRadical n : ℝ) ^ (k - 1) *
          (Nat.floorRoot k n : ℝ) ^ k := by
    exact_mod_cast le_radical_pow_mul_floorRoot_pow hk hn
  have hlog := Real.log_le_log hnpos hreal
  rw [Real.log_mul (pow_pos hradpos (k - 1)).ne'
      (pow_pos hrootpos k).ne',
    Real.log_pow, Real.log_pow] at hlog
  exact hlog

/-- The normalized exponent mass above `k-1` radical layers is bounded by the
logarithm of the actual extracted floor root. -/
theorem normalizedDefect_div_k_le_log_floorRoot
    {k n : ℕ} (hk : 0 < k) (hn : n ≠ 0) :
    (Real.log (n : ℝ) -
        ((k - 1 : ℕ) : ℝ) * Real.log (abcRadical n : ℝ)) /
        (k : ℝ) ≤
      Real.log (Nat.floorRoot k n : ℝ) := by
  have hbudget := log_le_radicalLayers_add_floorRoot hk hn
  have hkreal : 0 < (k : ℝ) := by exact_mod_cast hk
  apply (div_le_iff₀ hkreal).2
  linarith

/-- Square specialization: half the ordinary multiplicity excess is carried
by the canonical square root. -/
theorem half_multiplicityExcess_le_log_floorRoot_two
    {n : ℕ} (hn : n ≠ 0) :
    (Real.log (n : ℝ) - Real.log (abcRadical n : ℝ)) / 2 ≤
      Real.log (Nat.floorRoot 2 n : ℝ) := by
  simpa using
    (normalizedDefect_div_k_le_log_floorRoot
      (k := 2) (n := n) (by norm_num) hn)

/-- Cube specialization: one third of the signed square-radical defect is
carried by the canonical cube root. -/
theorem one_third_signedDefect_le_log_floorRoot_three
    {n : ℕ} (hn : n ≠ 0) :
    (Real.log (n : ℝ) - 2 * Real.log (abcRadical n : ℝ)) / 3 ≤
      Real.log (Nat.floorRoot 3 n : ℝ) := by
  simpa using
    (normalizedDefect_div_k_le_log_floorRoot
      (k := 3) (n := n) (by norm_num) hn)

#print axioms canonicalPowerKernel_mul_floorRoot_pow_eq
#print axioms factorization_canonicalPowerKernel
#print axioms canonicalPowerKernel_isExponentAtMost
#print axioms canonicalPowerKernel_le_radical_pow
#print axioms le_radical_pow_mul_floorRoot_pow
#print axioms log_le_radicalLayers_add_floorRoot
#print axioms normalizedDefect_div_k_le_log_floorRoot
#print axioms half_multiplicityExcess_le_log_floorRoot_two
#print axioms one_third_signedDefect_le_log_floorRoot_three

end
end CanonicalFloorRootRadicalBudget
end IUTThreeClosures
