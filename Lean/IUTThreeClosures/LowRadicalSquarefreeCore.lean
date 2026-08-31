/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PrimePowerSmoothNeighbour

/-!
# Squarefree-square core forced by a low radical

Every positive integer has a unique classical decomposition

`n = s * t^2`

with `s` squarefree.  The counting argument in the accompanying research note
uses this decomposition.  This file formalizes the exact arithmetic inequality
that drives that argument, independently of a choice of decomposition
algorithm.

If `s ∣ rad(n)`, `n = s*t^2`, and

`rad(n)^d ≤ n^e` with `e ≤ d`,

then

`s^(d-e) ≤ t^(2e)`.

For a rational radical exponent `sigma=e/d<1`, this is the integral form of

`s ≤ t^(2 sigma/(1-sigma))`.
-/

namespace IUTThreeClosures

/-- Data carried by the squarefree-square decomposition of a positive integer.
The divisibility `s ∣ abcRadical n` is the only squarefree-core property needed
by the power-budget theorem below. -/
structure SquarefreeSquareCore (n : ℕ) where
  s : ℕ
  t : ℕ
  s_pos : 0 < s
  squarefree_s : Squarefree s
  factorization : n = s * t ^ 2
  s_dvd_radical : s ∣ abcRadical n

namespace SquarefreeSquareCore

variable {n : ℕ}

/-- The squarefree core is bounded by the radical. -/
theorem s_le_radical (C : SquarefreeSquareCore n) :
    C.s ≤ abcRadical n :=
  Nat.le_of_dvd (abcRadical_pos n) C.s_dvd_radical

/-- Exact rational-exponent budget forced on the squarefree core.

This theorem is deliberately stated with natural powers.  It avoids all
rounding and real-power issues and is the form suitable for subsequent finite
counting formalization. -/
theorem power_budget
    (C : SquarefreeSquareCore n)
    {d e : ℕ}
    (hed : e ≤ d)
    (hrad : abcRadical n ^ d ≤ n ^ e) :
    C.s ^ (d - e) ≤ C.t ^ (2 * e) := by
  have hsd : C.s ^ d ≤ abcRadical n ^ d :=
    Nat.pow_le_pow_left C.s_le_radical d
  have hsn : C.s ^ d ≤ n ^ e := hsd.trans hrad
  have hrewrite :
      C.s ^ (d - e) * C.s ^ e ≤
        C.s ^ e * C.t ^ (2 * e) := by
    calc
      C.s ^ (d - e) * C.s ^ e = C.s ^ d := by
        rw [← pow_add, Nat.sub_add_cancel hed]
      _ ≤ n ^ e := hsn
      _ = (C.s * C.t ^ 2) ^ e := by rw [C.factorization]
      _ = C.s ^ e * (C.t ^ 2) ^ e := by rw [mul_pow]
      _ = C.s ^ e * C.t ^ (2 * e) := by rw [pow_mul]
  have hcommon :
      C.s ^ e * C.s ^ (d - e) ≤
        C.s ^ e * C.t ^ (2 * e) := by
    simpa [mul_comm] using hrewrite
  exact (Nat.mul_le_mul_left (C.s ^ e)).mp hcommon

/-- The half-radical specialization.  If `rad(n)^2 ≤ n`, then the
squarefree core is at most the square part. -/
theorem half_exponent_budget
    (C : SquarefreeSquareCore n)
    (hrad : abcRadical n ^ 2 ≤ n) :
    C.s ≤ C.t ^ 2 := by
  simpa using C.power_budget (d := 2) (e := 1) (by norm_num) (by simpa using hrad)

/-- More generally, a `1/k` radical exponent forces
`s^(k-1) ≤ t^2`. -/
theorem reciprocal_exponent_budget
    (C : SquarefreeSquareCore n)
    {k : ℕ} (hk : 1 ≤ k)
    (hrad : abcRadical n ^ k ≤ n) :
    C.s ^ (k - 1) ≤ C.t ^ 2 := by
  simpa using C.power_budget (d := k) (e := 1) hk (by simpa using hrad)

end SquarefreeSquareCore

end IUTThreeClosures
