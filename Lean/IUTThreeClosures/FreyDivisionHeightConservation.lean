/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-!
# Division points on the Frey family: exact scalar conservation laws

The companion paper `FREY_DIVISION_HEIGHT_CONSERVATION.md` studies whether
halving the bounded-abscissa quadratic selector can improve the ratio between
the retained multiplicative Bernoulli component term and global canonical
height.

This file formalizes only unconditional polynomial and finite-sum identities:

* an explicit half-point construction when `alpha^2 - beta^2 = 1`;
* its specialization at `alpha = 5/4`, `beta = 3/4`;
* the growing square-pair alignment and its rational parametrization;
* the Bernoulli multiplication formula governing all `m`-division branches;
* exact preservation of every homogeneous linear local/global budget.

Elliptic-curve group laws, Tate uniformization, Neron models, Kodaira fibres,
Shioda's height pairing, and specialization of canonical heights are not
modeled here.  The polynomial duplication identities are therefore stated in
cross-multiplied form, without packaging their geometric interpretation as a
Lean hypothesis.
-/

namespace IUTThreeClosures

/-! ## A completely explicit half point -/

/-- The proposed half abscissa factors simultaneously relative to the three
roots `0`, `1`, and `-b`. -/
theorem freyHalfAbscissa_threeFactors
    {alpha beta gamma b : ℝ}
    (hab : alpha ^ 2 - beta ^ 2 = 1)
    (hgamma : gamma ^ 2 = b + alpha ^ 2) :
    let x := alpha ^ 2 + alpha * beta + (alpha + beta) * gamma
    x = (alpha + beta) * (alpha + gamma) ∧
      x - 1 = (alpha + beta) * (beta + gamma) ∧
      x + b = (alpha + gamma) * (beta + gamma) := by
  dsimp
  constructor
  · ring
  constructor
  · calc
      alpha ^ 2 + alpha * beta + (alpha + beta) * gamma - 1 =
          (alpha + beta) * (beta + gamma) +
            (alpha ^ 2 - beta ^ 2 - 1) := by ring
      _ = (alpha + beta) * (beta + gamma) := by rw [hab]; ring
  · calc
      alpha ^ 2 + alpha * beta + (alpha + beta) * gamma + b =
          (alpha + gamma) * (beta + gamma) +
            (b + alpha ^ 2 - gamma ^ 2) := by ring
      _ = (alpha + gamma) * (beta + gamma) := by rw [hgamma]; ring

/-- With the corresponding product ordinate, the proposed half point lies on
`y^2 = x(x-1)(x+b)`. -/
theorem freyHalfPoint_curveIdentity
    {alpha beta gamma b : ℝ}
    (hab : alpha ^ 2 - beta ^ 2 = 1)
    (hgamma : gamma ^ 2 = b + alpha ^ 2) :
    let x := alpha ^ 2 + alpha * beta + (alpha + beta) * gamma
    let y := -(alpha + beta) * (alpha + gamma) * (beta + gamma)
    y ^ 2 = x * (x - 1) * (x + b) := by
  dsimp
  obtain ⟨hx, hx1, hxb⟩ :=
    freyHalfAbscissa_threeFactors hab hgamma
  rw [hx1, hxb, hx]
  ring

/-- The numerator in the duplication formula factors exactly. -/
theorem freyHalfAbscissa_duplicationFactor
    {alpha beta gamma b : ℝ}
    (hab : alpha ^ 2 - beta ^ 2 = 1)
    (hgamma : gamma ^ 2 = b + alpha ^ 2) :
    let x := alpha ^ 2 + alpha * beta + (alpha + beta) * gamma
    x ^ 2 + b =
      2 * alpha * (alpha + beta) * (alpha + gamma) * (beta + gamma) := by
  dsimp
  calc
    (alpha ^ 2 + alpha * beta + (alpha + beta) * gamma) ^ 2 + b =
        2 * alpha * (alpha + beta) * (alpha + gamma) * (beta + gamma) +
          (alpha ^ 2 - gamma ^ 2) *
            (alpha ^ 2 - beta ^ 2 - 1) -
          (gamma ^ 2 - (b + alpha ^ 2)) := by ring
    _ = 2 * alpha * (alpha + beta) * (alpha + gamma) *
          (beta + gamma) := by rw [hab, hgamma]; ring

/-- Cross-multiplied duplication sends the explicit point back to abscissa
`alpha^2`.  On a nonsingular fibre with nonzero denominator this says that
the displayed point doubles to one of the two points above `x = alpha^2`. -/
theorem freyHalfPoint_doubleAbscissa
    {alpha beta gamma b : ℝ}
    (hab : alpha ^ 2 - beta ^ 2 = 1)
    (hgamma : gamma ^ 2 = b + alpha ^ 2) :
    let x := alpha ^ 2 + alpha * beta + (alpha + beta) * gamma
    (x ^ 2 + b) ^ 2 =
      4 * alpha ^ 2 * x * (x - 1) * (x + b) := by
  dsimp
  have hfactor := freyHalfAbscissa_duplicationFactor hab hgamma
  obtain ⟨hx, hx1, hxb⟩ :=
    freyHalfAbscissa_threeFactors hab hgamma
  dsimp at hfactor hx hx1 hxb
  rw [hfactor, hx1, hxb, hx]
  ring

/-! ## The numerical `25/16` family -/

/-- For `alpha = 5/4`, `beta = 3/4`, and `d = 4 gamma`, the half
abscissa is `(5+d)/2`. -/
theorem twentyFiveSixteen_halfAbscissa (d : ℝ) :
    (5 / 4 : ℝ) ^ 2 + (5 / 4 : ℝ) * (3 / 4 : ℝ) +
        ((5 / 4 : ℝ) + 3 / 4) * (d / 4) =
      (5 + d) / 2 := by
  ring

/-- The completely explicit point above `(5+d)/2` lies on the Frey curve
whenever `d^2 = 16b+25`. -/
theorem twentyFiveSixteen_halfPoint_curveIdentity
    {b d : ℝ} (hd : d ^ 2 = 16 * b + 25) :
    (-(5 + d) * (3 + d) / 8) ^ 2 =
      ((5 + d) / 2) * (((5 + d) / 2) - 1) *
        (((5 + d) / 2) + b) := by
  have hab : (5 / 4 : ℝ) ^ 2 - (3 / 4 : ℝ) ^ 2 = 1 := by
    norm_num
  have hgamma : (d / 4) ^ 2 = b + (5 / 4 : ℝ) ^ 2 := by
    nlinarith
  have h := freyHalfPoint_curveIdentity hab hgamma
  dsimp at h
  convert h using 1 <;> ring

/-- The same point has doubled abscissa `25/16`, in cross-multiplied form. -/
theorem twentyFiveSixteen_halfPoint_doubleAbscissa
    {b d : ℝ} (hd : d ^ 2 = 16 * b + 25) :
    ((((5 + d) / 2) ^ 2 + b) ^ 2) =
      4 * (25 / 16 : ℝ) * ((5 + d) / 2) *
        (((5 + d) / 2) - 1) * (((5 + d) / 2) + b) := by
  have hab : (5 / 4 : ℝ) ^ 2 - (3 / 4 : ℝ) ^ 2 = 1 := by
    norm_num
  have hgamma : (d / 4) ^ 2 = b + (5 / 4 : ℝ) ^ 2 := by
    nlinarith
  have h := freyHalfPoint_doubleAbscissa hab hgamma
  dsimp at h
  convert h using 1 <;> ring

/-- At a prime dividing `b`, the two square-root residues `d = ±5` give
the smooth abscissa `5` and the singular abscissa `0`. -/
theorem twentyFiveSixteen_bFiber_conjugateAbscissas :
    ((5 + 5 : ℝ) / 2 = 5) ∧ ((5 + (-5) : ℝ) / 2 = 0) := by
  norm_num

/-- At a prime dividing `b+1`, the two residues `d = ±3` give the smooth
abscissa `4` and the singular abscissa `1`. -/
theorem twentyFiveSixteen_cFiber_conjugateAbscissas :
    ((5 + 3 : ℝ) / 2 = 4) ∧ ((5 + (-3) : ℝ) / 2 = 1) := by
  norm_num

/-! ## Killing the splitting character forces a growing parameter -/

/-- The natural adaptive choice makes the coalescing pair a pair of rational
squares. -/
theorem growingSquarePair_factorization (a : ℝ) :
    ((a + 1) ^ 2 / 4) - a = (a - 1) ^ 2 / 4 := by
  ring

/-- The conic used by the adaptive construction is rationally parametrized by
`a = z - z^{-1} - 1`. -/
theorem growingSquarePair_parameterEquation
    {a z : ℝ} (hz : z ≠ 0)
    (ha : a = z - z⁻¹ - 1) :
    z ^ 2 - (a + 1) * z - 1 = 0 := by
  rw [ha]
  field_simp
  ring

/-- On the parametrized family with `b=1`, the aligned half is the elementary
section `(z,z+1)`. -/
theorem growingSquarePair_section_curveIdentity
    {a z : ℝ} (hz : z ≠ 0)
    (ha : a = z - z⁻¹ - 1) :
    (z + 1) ^ 2 = z * (z - a) * (z + 1) := by
  rw [ha]
  field_simp
  ring

/-- Its doubled abscissa is the growing square `(a+1)^2/4`. -/
theorem growingSquarePair_section_doubleAbscissa
    {a z : ℝ} (hz : z ≠ 0)
    (ha : a = z - z⁻¹ - 1) :
    (z ^ 2 + a) ^ 2 =
      (a + 1) ^ 2 * z * (z - a) * (z + 1) := by
  rw [ha]
  field_simp [hz]
  ring

/-! ## Bernoulli distribution under arbitrary division -/

/-- The second Bernoulli polynomial in the component term of the Tate
local-height formula. -/
noncomputable def freyDivisionBernoulliTwo (x : ℝ) : ℝ :=
  x ^ 2 - x + 1 / 6

private theorem sum_range_cast_id_real (m : ℕ) :
    ∑ k ∈ Finset.range m, (k : ℝ) =
      (m : ℝ) * ((m : ℝ) - 1) / 2 := by
  induction m with
  | zero => simp
  | succ m ih =>
      rw [Finset.sum_range_succ, ih]
      simp only [Nat.cast_succ]
      ring

private theorem sum_range_cast_sq_real (m : ℕ) :
    ∑ k ∈ Finset.range m, (k : ℝ) ^ 2 =
      (m : ℝ) * ((m : ℝ) - 1) * (2 * (m : ℝ) - 1) / 6 := by
  induction m with
  | zero => simp
  | succ m ih =>
      rw [Finset.sum_range_succ, ih]
      simp only [Nat.cast_succ]
      ring

/-- The multiplication formula for the second Bernoulli polynomial. -/
theorem freyDivisionBernoulliTwo_divisionDistribution
    (m : ℕ) (hm : 0 < m) (x : ℝ) :
    ∑ k ∈ Finset.range m,
        freyDivisionBernoulliTwo ((x + (k : ℝ)) / (m : ℝ)) =
      freyDivisionBernoulliTwo x / (m : ℝ) := by
  have hmR : (m : ℝ) ≠ 0 := by positivity
  let A : ℝ := x ^ 2 / (m : ℝ) ^ 2 - x / (m : ℝ) + 1 / 6
  let B : ℝ := 2 * x / (m : ℝ) ^ 2 - 1 / (m : ℝ)
  let C : ℝ := 1 / (m : ℝ) ^ 2
  have hterm (k : ℕ) :
      freyDivisionBernoulliTwo ((x + (k : ℝ)) / (m : ℝ)) =
        A + B * (k : ℝ) + C * (k : ℝ) ^ 2 := by
    dsimp [A, B, C, freyDivisionBernoulliTwo]
    field_simp [hmR]
    ring
  calc
    (∑ k ∈ Finset.range m,
        freyDivisionBernoulliTwo ((x + (k : ℝ)) / (m : ℝ))) =
      ∑ k ∈ Finset.range m,
        (A + B * (k : ℝ) + C * (k : ℝ) ^ 2) := by
          apply Finset.sum_congr rfl
          intro k _
          exact hterm k
    _ = (m : ℝ) * A +
        B * ((m : ℝ) * ((m : ℝ) - 1) / 2) +
        C * ((m : ℝ) * ((m : ℝ) - 1) *
          (2 * (m : ℝ) - 1) / 6) := by
          rw [Finset.sum_add_distrib, Finset.sum_add_distrib]
          rw [← Finset.mul_sum, ← Finset.mul_sum]
          rw [sum_range_cast_id_real, sum_range_cast_sq_real]
          simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul]
    _ = freyDivisionBernoulliTwo x / (m : ℝ) := by
          dsimp [A, B, C, freyDivisionBernoulliTwo]
          field_simp [hmR]
          ring

/-- At the identity component, the Bernoulli sum over the `m` possible
component parameters is exactly `1/(6m)`. -/
theorem freyDivisionBernoulliTwo_identityDivisionSum
    (m : ℕ) (hm : 0 < m) :
    ∑ k ∈ Finset.range m,
        freyDivisionBernoulliTwo ((k : ℝ) / (m : ℝ)) =
      (1 / 6 : ℝ) / (m : ℝ) := by
  simpa [freyDivisionBernoulliTwo] using
    freyDivisionBernoulliTwo_divisionDistribution m hm 0

/-- On a Tate fibre the `m` component parameters each occur with
multiplicity `m` among the `m^2` division branches. Their total Bernoulli
component term equals the original identity-component Bernoulli term. -/
theorem tateDivisionBranches_totalComponentTerm
    (m : ℕ) (hm : 0 < m) (scale : ℝ) :
    (m : ℝ) *
        (∑ k ∈ Finset.range m,
          (scale / 2) *
            freyDivisionBernoulliTwo ((k : ℝ) / (m : ℝ))) =
      scale / 12 := by
  calc
    (m : ℝ) *
        (∑ k ∈ Finset.range m,
          (scale / 2) *
            freyDivisionBernoulliTwo ((k : ℝ) / (m : ℝ))) =
      (m : ℝ) * ((scale / 2) *
        (∑ k ∈ Finset.range m,
          freyDivisionBernoulliTwo ((k : ℝ) / (m : ℝ)))) := by
        congr 1
        rw [Finset.mul_sum]
    _ = scale / 12 := by
      rw [freyDivisionBernoulliTwo_identityDivisionSum m hm]
      have hmR : (m : ℝ) ≠ 0 := by positivity
      field_simp
      ring

/-- Averaging the preceding total over all `m^2` branches scales the original
Bernoulli component term by exactly `m^{-2}`. -/
theorem tateDivisionBranches_averageComponentTerm
    (m : ℕ) (hm : 0 < m) (scale : ℝ) :
    ((m : ℝ) *
        (∑ k ∈ Finset.range m,
          (scale / 2) *
            freyDivisionBernoulliTwo ((k : ℝ) / (m : ℝ)))) /
          (m : ℝ) ^ 2 =
      (scale / 12) / (m : ℝ) ^ 2 := by
  rw [tateDivisionBranches_totalComponentTerm m hm scale]

/-- For halving an identity-component point of an `I_(2e)` fibre, two
branches contribute `e/6` and two contribute `-e/12`; their normalized
average is `e/24`. -/
theorem freyHalfBranches_componentLedger (weightedDepth : ℝ) :
    (2 * (weightedDepth / 6) +
        2 * (-weightedDepth / 12)) / 4 =
      weightedDepth / 24 := by
  ring

/-- Simultaneous division by `m^2` cannot improve any homogeneous linear
component-depth versus canonical-height budget. -/
theorem divisionScaling_preservesLinearBudget
    {localHeight globalHeight coefficient : ℝ}
    (m : ℕ) (hm : 0 < m) :
    localHeight ≤ coefficient * globalHeight ↔
      localHeight / (m : ℝ) ^ 2 ≤
        coefficient * (globalHeight / (m : ℝ) ^ 2) := by
  have hmSq : 0 < (m : ℝ) ^ 2 := by positivity
  rw [show coefficient * (globalHeight / (m : ℝ) ^ 2) =
      (coefficient * globalHeight) / (m : ℝ) ^ 2 by ring]
  exact (div_le_div_iff_of_pos_right hmSq).symm

end IUTThreeClosures
