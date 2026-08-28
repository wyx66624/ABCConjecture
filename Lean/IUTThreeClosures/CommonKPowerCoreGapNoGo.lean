/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LowRadicalNeighbourTransfer

/-!
# A common k-power core cannot produce subcritical abc gaps

Suppose two positive endpoints have the same multiplicative core and the same
power exponent:

`b = s * x^k`, `c = s * y^k`, with `x < y` and `k > 0`.

Their gap is much too large for the two-endpoint k-full counterexample route.
The exact integer inequality proved here is

` s * b^(k-1) ≤ (c-b)^k `.

For `k ≥ 2`, this excludes the strict subcritical condition

`(c-b)^k < b^(k-2)`,

which is the denominator-free form of the gap exponent
`theta < 1 - 2/k` required after charging two k-full endpoint radicals.
Consequently any successful close-k-full-neighbour construction must vary the
residual k-power core; a fixed common core is a proved no-go route.

No abc statement, distribution theorem, Diophantine finiteness theorem, or
existence assumption is used.
-/

namespace IUTThreeClosures
namespace CommonKPowerCoreGapNoGo

/-- Distinct positive bases with a common scale have a gap at least the scale
times the `(k-1)`st power of the smaller base. -/
theorem commonCore_power_gap_lower
    {s x y k : ℕ}
    (hk : 0 < k) (hxy : x < y) :
    s * x ^ (k - 1) ≤ s * y ^ k - s * x ^ k := by
  have hxy_le : x ≤ y := Nat.le_of_lt hxy
  have hsucc : x + 1 ≤ y := Nat.succ_le_iff.mpr hxy
  have hpow : x ^ (k - 1) ≤ y ^ (k - 1) :=
    Nat.pow_le_pow_left hxy_le (k - 1)
  have hkpred : k - 1 + 1 = k :=
    Nat.sub_add_cancel (Nat.succ_le_iff.mp hk)
  have hbase : x ^ k + x ^ (k - 1) ≤ y ^ k := by
    calc
      x ^ k + x ^ (k - 1) = x ^ (k - 1) * (x + 1) := by
        rw [mul_add, mul_one, ← pow_succ, hkpred]
      _ ≤ y ^ (k - 1) * y := Nat.mul_le_mul hpow hsucc
      _ = y ^ k := by
        rw [← pow_succ, hkpred]
  have hscaled :
      s * x ^ k + s * x ^ (k - 1) ≤ s * y ^ k := by
    rw [← Nat.mul_add]
    exact Nat.mul_le_mul_left s hbase
  exact Nat.le_sub_of_add_le (by
    simpa [Nat.add_comm] using hscaled)

/-- Algebraic identity converting the elementary gap lower bound into the
endpoint-height form used by the abc exponent budget. -/
theorem commonCore_scaled_power_identity
    {s x k : ℕ} (hk : 0 < k) :
    s * (s * x ^ k) ^ (k - 1) =
      (s * x ^ (k - 1)) ^ k := by
  have hkpred : k - 1 + 1 = k :=
    Nat.sub_add_cancel (Nat.succ_le_iff.mp hk)
  calc
    s * (s * x ^ k) ^ (k - 1) =
        (s ^ (k - 1) * s) * (x ^ k) ^ (k - 1) := by
      rw [mul_pow]
      ac_rfl
    _ = s ^ k * x ^ (k * (k - 1)) := by
      rw [← pow_succ, hkpred, ← pow_mul]
    _ = s ^ k * x ^ ((k - 1) * k) := by
      rw [Nat.mul_comm k (k - 1)]
    _ = s ^ k * (x ^ (k - 1)) ^ k := by
      rw [pow_mul]
    _ = (s * x ^ (k - 1)) ^ k := by
      rw [mul_pow]

/-- Exact common-core gap obstruction:

` s * b^(k-1) ≤ gap^k ` for `b=s*x^k` and `gap=s*y^k-s*x^k`. -/
theorem commonCore_gap_pow_lower
    {s x y k : ℕ}
    (hk : 0 < k) (hxy : x < y) :
    s * (s * x ^ k) ^ (k - 1) ≤
      (s * y ^ k - s * x ^ k) ^ k := by
  rw [commonCore_scaled_power_identity hk]
  exact Nat.pow_le_pow_left
    (commonCore_power_gap_lower (s := s) hk hxy) k

/-- For a positive common core and positive smaller base, the strict
subcritical two-endpoint k-full gap inequality is impossible. -/
theorem no_subcritical_commonCore_gap
    {s x y k : ℕ}
    (hs : 0 < s) (hx : 0 < x)
    (hk : 2 ≤ k) (hxy : x < y) :
    ¬((s * y ^ k - s * x ^ k) ^ k <
      (s * x ^ k) ^ (k - 2)) := by
  intro hstrict
  have hkpos : 0 < k := lt_of_lt_of_le Nat.zero_lt_two hk
  have hlower := commonCore_gap_pow_lower
    (s := s) (x := x) (y := y) hkpos hxy
  have hbpos : 0 < s * x ^ k :=
    Nat.mul_pos hs (Nat.pow_pos hx)
  have hexp : k - 2 ≤ k - 1 := by omega
  have hpow :
      (s * x ^ k) ^ (k - 2) ≤
        (s * x ^ k) ^ (k - 1) :=
    Nat.pow_le_pow_right hbpos hexp
  have hsone : 1 ≤ s := Nat.succ_le_iff.mpr hs
  have hscale :
      (s * x ^ k) ^ (k - 1) ≤
        s * (s * x ^ k) ^ (k - 1) := by
    simpa using Nat.mul_le_mul_right
      ((s * x ^ k) ^ (k - 1)) hsone
  omega

/-- Cubefull specialization: a common cube-free core cannot yield the strict
`gap^3 < b` inequality corresponding to a gap exponent below `1/3`. -/
theorem no_common_cube_core_subcritical_gap
    {s x y : ℕ}
    (hs : 0 < s) (hx : 0 < x) (hxy : x < y) :
    ¬((s * y ^ 3 - s * x ^ 3) ^ 3 < s * x ^ 3) := by
  simpa using
    no_subcritical_commonCore_gap
      (s := s) (x := x) (y := y) (k := 3)
      hs hx (by norm_num) hxy

/-- Fourth-power specialization: a common fourth-power core cannot yield the
strict `gap^4 < b^2` inequality corresponding to a gap exponent below `1/2`. -/
theorem no_common_fourthPower_core_subcritical_gap
    {s x y : ℕ}
    (hs : 0 < s) (hx : 0 < x) (hxy : x < y) :
    ¬((s * y ^ 4 - s * x ^ 4) ^ 4 < (s * x ^ 4) ^ 2) := by
  simpa using
    no_subcritical_commonCore_gap
      (s := s) (x := x) (y := y) (k := 4)
      hs hx (by norm_num) hxy

end CommonKPowerCoreGapNoGo
end IUTThreeClosures
