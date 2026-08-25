/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCStatement
import Mathlib.Algebra.Ring.GeomSum
import Mathlib.Data.Nat.GCD.Basic

/-!
# Power-difference lifts of primitive abc triples

For a primitive positive relation `a + b = c` and an integer `m ≥ 2`, put

`Sₘ(a,c) = ∑ i < m, a^i * c^(m-1-i)`.

The elementary factorization

`(c-a) * Sₘ(a,c) = c^m-a^m`

produces the lifted relation

`a^m + b*Sₘ(a,c) = c^m`.

This file proves that the lift remains pairwise coprime.  It also formalizes
the bounded-degree obstruction used in the exceptional-set amplification
audit: on a dyadic shell `X ≤ c`, a lift of height at most `X^κ` must have
`m ≤ κ`.

The real-logarithmic quality-transfer estimate is kept in the accompanying
mathematical paper until its analytic inequalities are formalized.  No abc
conclusion is assumed here.
-/

namespace IUTThreeClosures

open Finset
open scoped BigOperators

/-- The homogeneous geometric factor `(c^m-a^m)/(c-a)`, defined without
subtraction or division. -/
def powerDifferenceFactor (a c m : ℕ) : ℕ :=
  ∑ i in Finset.range m, a ^ i * c ^ (m - 1 - i)

/-- Symmetry of the homogeneous geometric factor. -/
theorem powerDifferenceFactor_comm (a c m : ℕ) :
    powerDifferenceFactor a c m = powerDifferenceFactor c a m := by
  unfold powerDifferenceFactor
  exact geom_sum₂_comm a c m

/-- The geometric factor multiplied by `c-a` is the corresponding difference
of powers. -/
theorem powerDifferenceFactor_mul_sub
    {a c m : ℕ} (hac : a ≤ c) :
    powerDifferenceFactor a c m * (c - a) = c ^ m - a ^ m := by
  simpa [powerDifferenceFactor] using geom_sum₂_mul_of_le hac m

/-- One-step recursion, useful for reducing the factor modulo either endpoint. -/
theorem powerDifferenceFactor_succ (a c m : ℕ) :
    powerDifferenceFactor a c (m + 1) =
      c * powerDifferenceFactor a c m + a ^ m := by
  unfold powerDifferenceFactor
  rw [Finset.sum_range_succ]
  simp only [Nat.add_sub_cancel, Nat.sub_self, pow_zero, mul_one]
  congr 1
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i hi
  have him : i < m := Finset.mem_range.mp hi
  calc
    a ^ i * c ^ (m - i) =
        a ^ i * c ^ ((m - 1 - i) + 1) := by
          congr 2
          omega
    _ = a ^ i * (c ^ (m - 1 - i) * c) := by
          rw [pow_succ]
    _ = c * (a ^ i * c ^ (m - 1 - i)) := by
          ac_rfl

/-- The lifted power relation. -/
theorem powerDifferenceLift_sum
    {a b c m : ℕ} (habc : a + b = c) :
    a ^ m + b * powerDifferenceFactor a c m = c ^ m := by
  have hac : a ≤ c := by omega
  have hfactor := powerDifferenceFactor_mul_sub (a := a) (c := c) (m := m) hac
  have hsub : c - a = b := by omega
  rw [hsub] at hfactor
  have hpow : a ^ m ≤ c ^ m := Nat.pow_le_pow_left hac
  calc
    a ^ m + b * powerDifferenceFactor a c m =
        a ^ m + powerDifferenceFactor a c m * b := by ac_rfl
    _ = a ^ m + (c ^ m - a ^ m) := by rw [hfactor]
    _ = c ^ m := by omega

/-- The right endpoint is coprime to the geometric factor whenever the two
endpoints are coprime and the exponent is at least two. -/
theorem coprime_right_powerDifferenceFactor
    {a c m : ℕ} (hm : 2 ≤ m) (hca : Nat.Coprime c a) :
    Nat.Coprime c (powerDifferenceFactor a c m) := by
  have hmpos : 0 < m - 1 := by omega
  have hmone : (m - 1) + 1 = m := by omega
  have hrec := powerDifferenceFactor_succ a c (m - 1)
  rw [hmone] at hrec
  rw [hrec, Nat.coprime_mul_left_add_right]
  exact (Nat.coprime_pow_right_iff hmpos c a).2 hca

/-- The left endpoint is coprime to the geometric factor. -/
theorem coprime_left_powerDifferenceFactor
    {a c m : ℕ} (hm : 2 ≤ m) (hac : Nat.Coprime a c) :
    Nat.Coprime a (powerDifferenceFactor a c m) := by
  have h := coprime_right_powerDifferenceFactor
    (a := c) (c := a) (m := m) hm hac
  simpa [powerDifferenceFactor_comm] using h

/-- The power-difference lift of a primitive abc triple is primitive. -/
theorem pairwiseCoprime_powerDifferenceLift
    {a b c m : ℕ}
    (hm : 2 ≤ m)
    (hpair : PairwiseCoprimeABC a b c) :
    PairwiseCoprimeABC
      (a ^ m)
      (b * powerDifferenceFactor a c m)
      (c ^ m) := by
  rcases hpair with ⟨hab, hbc, hca⟩
  have hmpos : 0 < m := by omega
  have haf : Nat.Coprime a (powerDifferenceFactor a c m) :=
    coprime_left_powerDifferenceFactor hm hca.symm
  have hcf : Nat.Coprime c (powerDifferenceFactor a c m) :=
    coprime_right_powerDifferenceFactor hm hca
  constructor
  · rw [Nat.coprime_mul_iff_right]
    constructor
    · exact (Nat.coprime_pow_left_iff hmpos a b).2 hab
    · exact (Nat.coprime_pow_left_iff hmpos a
        (powerDifferenceFactor a c m)).2 haf
  · constructor
    · rw [Nat.coprime_mul_iff_left]
      constructor
      · exact (Nat.coprime_pow_right_iff hmpos b c).2 hbc
      · exact (Nat.coprime_pow_right_iff hmpos
          (powerDifferenceFactor a c m) c).2 hcf.symm
    · have hcaPowLeft : Nat.Coprime (c ^ m) a :=
        (Nat.coprime_pow_left_iff hmpos c a).2 hca
      exact (Nat.coprime_pow_right_iff hmpos (c ^ m) a).2 hcaPowLeft

/-- On a dyadic input shell, a power-difference lift lying below one fixed
polynomial height scale has bounded degree. -/
theorem powerDifference_degree_le_of_shell_height
    {X c m κ : ℕ}
    (hX : 2 ≤ X)
    (hXc : X ≤ c)
    (hout : c ^ m ≤ X ^ κ) :
    m ≤ κ := by
  apply (Nat.pow_le_pow_iff_right hX).mp
  exact (Nat.pow_le_pow_left hXc).trans hout

end IUTThreeClosures
