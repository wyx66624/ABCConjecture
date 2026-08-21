import Mathlib

/-!
# Quadratic-label q-pilot normalization

Kirti Joshi's arithmetic-Teichmüller ansatz uses the labels

`q, q^(2^2), ..., q^(n^2)`

rather than the linear power family `q, q^2, ..., q^n`.  This file isolates
the elementary normalization forced by those quadratic labels.  It does not
postulate an untilt, a Fargues--Fontaine lift, a theta-locus bound, or any abc
inequality.

The main identities are:

* `-log ‖q^(j+1)^2‖ = (j+1)^2 (-log ‖q‖)`;
* six times the sum of the first `n` square weights is
  `n(n+1)(2n+1)`;
* consequently the whole quadratic packet has a completely determined
  normalization coefficient.

These identities are the first Lean-checkable part of the Joshi route and
provide a precise coefficient audit for any future common-`B` theta-locus
construction.
-/

namespace IUTThreeClosures
namespace Joshi

open scoped BigOperators

/-- The real square weight attached to the label `j+1`. -/
def quadraticWeight (j : ℕ) : ℝ :=
  (((j + 1) ^ 2 : ℕ) : ℝ)

/-- Sum of the first `n` positive square weights. -/
noncomputable def quadraticWeightSum (n : ℕ) : ℝ :=
  ∑ j in Finset.range n, quadraticWeight j

/-- Division-free form of the sum-of-squares formula. -/
theorem six_mul_quadraticWeightSum (n : ℕ) :
    6 * quadraticWeightSum n =
      (n : ℝ) * (n + 1) * (2 * n + 1) := by
  induction n with
  | zero => simp [quadraticWeightSum]
  | succ n ih =>
      rw [quadraticWeightSum, Finset.sum_range_succ]
      rw [quadraticWeightSum] at ih
      simp only [quadraticWeight]
      push_cast
      nlinarith

/-- The logarithmic q-size of a quadratic power scales by the square label. -/
theorem neg_log_norm_quadratic_pow
    {K : Type*} [NormedField K]
    (q : K) (j : ℕ) :
    -Real.log ‖q ^ ((j + 1) ^ 2)‖ =
      quadraticWeight j * (-Real.log ‖q‖) := by
  rw [norm_pow, Real.log_pow]
  simp only [quadraticWeight]
  push_cast
  ring

/-- Total logarithmic size of the first `n` quadratic q-pilot labels. -/
noncomputable def quadraticPacketAbsLogQ
    {K : Type*} [NormedField K]
    (n : ℕ) (q : K) : ℝ :=
  ∑ j in Finset.range n, -Real.log ‖q ^ ((j + 1) ^ 2)‖

/-- The entire packet is the square-weight sum times the native q-size. -/
theorem quadraticPacketAbsLogQ_eq
    {K : Type*} [NormedField K]
    (n : ℕ) (q : K) :
    quadraticPacketAbsLogQ n q =
      quadraticWeightSum n * (-Real.log ‖q‖) := by
  simp_rw [quadraticPacketAbsLogQ, neg_log_norm_quadratic_pow]
  rw [← Finset.sum_mul]
  rfl

/-- Exact division-free normalization for the quadratic packet. -/
theorem six_mul_quadraticPacketAbsLogQ
    {K : Type*} [NormedField K]
    (n : ℕ) (q : K) :
    6 * quadraticPacketAbsLogQ n q =
      ((n : ℝ) * (n + 1) * (2 * n + 1)) *
        (-Real.log ‖q‖) := by
  rw [quadraticPacketAbsLogQ_eq, mul_assoc,
    six_mul_quadraticWeightSum]

/-- The average square-weight coefficient, defined only by the finite packet. -/
noncomputable def quadraticAverageFactor (n : ℕ) : ℝ :=
  quadraticWeightSum n / n

/-- Closed formula for the average square-weight coefficient. -/
theorem quadraticAverageFactor_eq
    {n : ℕ} (hn : 0 < n) :
    quadraticAverageFactor n =
      ((n + 1 : ℝ) * (2 * n + 1)) / 6 := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  have hsum := six_mul_quadraticWeightSum n
  unfold quadraticAverageFactor
  field_simp
  nlinarith

end Joshi
end IUTThreeClosures
