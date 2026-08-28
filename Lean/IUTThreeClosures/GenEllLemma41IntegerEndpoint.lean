/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GenEllLemma41CountingBridge
import Mathlib.Algebra.Order.Floor.Ring

/-!
# Integer endpoints in GenEll Lemma 4.1

The printed radius in GenEll Lemma 4.1 is real:

`Y = (1 + 6*epsilon) * x_A + 8*h`.

The Chebyshev function in Mathlib is indexed by natural numbers.  We choose

`X = ceil(Y)`.

For `Y >= 0`, this satisfies

`Y <= X < Y + 1`.

Thus every selected prime is bounded by `Y+1`, and the only analytic change
is that the logarithmic candidate-prime term is estimated using
`log(Y+1)` rather than `log Y`.  This file proves that the exact one-unit
rounding error feeds into the already verified scalar/counting bridge without
any hidden asymptotic assumption.

A later PNT module may absorb the difference between `Y` and `Y+1` into the
large-height threshold; no endpoint convention is left implicit here.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- The canonical natural-number endpoint above a real radius. -/
noncomputable def genEllCeilEndpoint (Y : ℝ) : ℕ :=
  ⌈Y⌉₊

/-- Exact ceiling bounds, including the strict one-unit rounding error. -/
theorem genEllCeilEndpoint_bounds
    {Y : ℝ} (hY : 0 ≤ Y) :
    Y ≤ (genEllCeilEndpoint Y : ℝ) ∧
      (genEllCeilEndpoint Y : ℝ) < Y + 1 := by
  constructor
  · exact Nat.le_ceil Y
  · exact Nat.ceil_lt_add_one hY

/-- A radius at least one produces a valid positive Chebyshev endpoint. -/
theorem one_le_genEllCeilEndpoint
    {Y : ℝ} (hY : 1 ≤ Y) :
    1 ≤ genEllCeilEndpoint Y := by
  have h := (genEllCeilEndpoint_bounds (zero_le_one.trans hY)).1
  exact_mod_cast hY.trans h

/-- The endpoint logarithm is bounded by the logarithm of the radius plus one. -/
theorem log_genEllCeilEndpoint_le
    {Y : ℝ} (hY : 1 ≤ Y) :
    Real.log (genEllCeilEndpoint Y) ≤ Real.log (Y + 1) := by
  have hbounds := genEllCeilEndpoint_bounds (zero_le_one.trans hY)
  have hXpos : 0 < (genEllCeilEndpoint Y : ℝ) := by
    exact_mod_cast (one_le_genEllCeilEndpoint hY :
      1 ≤ genEllCeilEndpoint Y)
  exact Real.log_le_log hXpos hbounds.2.le

/-- Multiplying by the nonnegative number of candidate primes preserves the
endpoint logarithm bound. -/
theorem candidateLogMass_ceiling_le
    (M : ℕ) {Y : ℝ} (hY : 1 ≤ Y) :
    (((M - 1 : ℕ) : ℝ) * Real.log (genEllCeilEndpoint Y)) ≤
      ((M - 1 : ℕ) : ℝ) * Real.log (Y + 1) := by
  exact mul_le_mul_of_nonneg_left
    (log_genEllCeilEndpoint_le hY) (by positivity)

/-- **Integer-endpoint counting form of GenEll Lemma 4.1.**

The real radius is replaced by its ceiling.  The hypotheses use the exact
rounding-safe logarithmic term `log(Y+1)`.  The resulting primes satisfy the
integer interval bound and hence the printed real bound with an explicit
additive error smaller than one. -/
theorem genEllLemma41_many_primes_at_ceiling
    (A : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (hBase H M : ℕ)
    {ε xε Cε xA : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hCε : Cε < ε * xε)
    (hxA : xε < xA)
    (hxA_mass : xA = primeLogMass A)
    (hYone :
      1 ≤ genEllLemma41Radius ε xA hBase)
    (hMlogRounded :
      (((M - 1 : ℕ) : ℝ) *
          Real.log (genEllLemma41Radius ε xA hBase + 1)) ≤
        ε * genEllLemma41Radius ε xA hBase)
    (hthetaH :
      Chebyshev.theta H <
        (5 / 4 : ℝ) * ((1 + 6 * ε) * (hBase : ℝ)) + Cε)
    (hthetaX :
      (1 - ε) * genEllLemma41Radius ε xA hBase <
        Chebyshev.theta
          (genEllCeilEndpoint
            (genEllLemma41Radius ε xA hBase))) :
    ∃ S : Finset ℕ,
      M ≤ S.card ∧
      ∀ p ∈ S,
        p.Prime ∧
        H < p ∧
        p ≤ genEllCeilEndpoint
          (genEllLemma41Radius ε xA hBase) ∧
        p ∉ A ∧
        (p : ℝ) < genEllLemma41Radius ε xA hBase + 1 := by
  let Y : ℝ := genEllLemma41Radius ε xA hBase
  let X : ℕ := genEllCeilEndpoint Y
  have hX : 1 ≤ X := by
    simpa [X, Y] using one_le_genEllCeilEndpoint hYone
  have hMlog :
      (((M - 1 : ℕ) : ℝ) * Real.log X) ≤ ε * Y := by
    have hround := candidateLogMass_ceiling_le M hYone
    dsimp [X, Y]
    exact hround.trans hMlogRounded
  obtain ⟨S, hcard, hS⟩ :=
    genEllLemma41_many_primes
      A hA hBase H X M hX
      hεpos hεlt hxεpos hCε hxA hxA_mass
      (by simpa [X, Y] using hMlog)
      hthetaH
      (by simpa [X, Y] using hthetaX)
  refine ⟨S, hcard, ?_⟩
  intro p hp
  rcases hS p hp with ⟨hpp, hHp, hpX, hpA⟩
  refine ⟨hpp, hHp, hpX, hpA, ?_⟩
  have hceil :=
    (genEllCeilEndpoint_bounds (zero_le_one.trans hYone)).2
  have hpXreal : (p : ℝ) ≤ X := by exact_mod_cast hpX
  simpa [X, Y] using hpXreal.trans_lt hceil

end IUTThreeClosures
