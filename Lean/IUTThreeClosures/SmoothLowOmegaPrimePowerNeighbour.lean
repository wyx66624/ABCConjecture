/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PrimePowerSmoothNeighbour

/-!
# Smooth low-omega neighbours of prime powers

Smoothness alone does not control the radical of an integer: a squarefree
`y`-smooth number can have radical equal to itself. A bound for the number of
distinct prime factors supplies the missing deterministic input:

`rad(n) <= y ^ omega(n)`.

This file proves that inequality and connects a height-unbounded family of
short, smooth, low-omega neighbours of prime powers to the existing exact
`not ABCConjecture` gate. It assumes no distribution theorem for smooth
numbers in short intervals.
-/

namespace IUTThreeClosures
namespace SmoothLowOmegaPrimePowerNeighbour

/-- Every prime divisor of `n` is at most `y`. -/
def IsYSmooth (y n : ℕ) : Prop :=
  ∀ q ∈ n.primeFactors, q ≤ y

/-- The radical of a `y`-smooth integer is bounded by `y` to the number of its
distinct prime divisors. -/
theorem abcRadical_le_pow_primeFactorsCard_of_smooth
    {y n : ℕ} (hsmooth : IsYSmooth y n) :
    abcRadical n ≤ y ^ n.primeFactors.card := by
  unfold abcRadical
  exact Finset.prod_le_pow_card n.primeFactors id y hsmooth

/-- If the number of distinct prime factors is at most `w`, the radical is at
most `y^w`. -/
theorem abcRadical_le_pow_of_smooth_card
    {y n w : ℕ}
    (hy : 0 < y)
    (hsmooth : IsYSmooth y n)
    (hcard : n.primeFactors.card ≤ w) :
    abcRadical n ≤ y ^ w := by
  calc
    abcRadical n ≤ y ^ n.primeFactors.card :=
      abcRadical_le_pow_primeFactorsCard_of_smooth hsmooth
    _ ≤ y ^ w := Nat.pow_le_pow_right hy hcard

/-- A prime-power neighbour with an explicit smoothness and distinct-prime
certificate, normalized at a fixed logarithmic exponent `delta`. -/
structure SmoothLowOmegaPrimePowerNeighbourLogBudget
    (D : PrimePowerNeighbourData) (delta : ℝ) where
  H : ℕ
  y : ℕ
  w : ℕ
  hypos : 0 < y
  a_le_H : D.a ≤ H
  smooth_c : IsYSmooth y D.c
  omega_c_le : D.c.primeFactors.card ≤ w
  log_budget_le :
    Real.log ((H * D.p * y ^ w : ℕ) : ℝ) ≤
      delta * Real.log (D.b : ℝ)

namespace SmoothLowOmegaPrimePowerNeighbourLogBudget

variable {D : PrimePowerNeighbourData} {delta : ℝ}

/-- Forget the analytic certificates and retain the exact radical budget
required by `PrimePowerNeighbourLogBudget`. -/
def toPrimePowerNeighbourLogBudget
    (L : SmoothLowOmegaPrimePowerNeighbourLogBudget D delta) :
    PrimePowerNeighbourLogBudget D delta where
  H := L.H
  R := L.y ^ L.w
  a_le_H := L.a_le_H
  radical_c_le_R := by
    exact abcRadical_le_pow_of_smooth_card
      L.hypos L.smooth_c L.omega_c_le
  log_budget_le := L.log_budget_le

end SmoothLowOmegaPrimePowerNeighbourLogBudget

/-- An unbounded family of short, `y`-smooth, low-omega prime-power neighbours
with a fixed subcritical logarithmic radical exponent disproves
`ABCConjecture`.

All unresolved analytic number theory is isolated in the construction of the
family `L`; the implication itself is unconditional. -/
theorem not_abc_of_unbounded_smoothLowOmegaPrimePowerNeighbours
    {epsilon delta : ℝ}
    (hepsilon : 0 < epsilon)
    (hsubcritical : (1 + epsilon) * delta < 1)
    (D : ℕ → PrimePowerNeighbourData)
    (L : ∀ n,
      SmoothLowOmegaPrimePowerNeighbourLogBudget (D n) delta)
    (hlogUnbounded :
      ∀ B : ℝ, ∃ n : ℕ,
        B < Real.log ((D n).b : ℝ)) :
    ¬ ABCConjecture := by
  apply not_abc_of_unbounded_primePowerNeighbours
    hepsilon D
    (fun n => (L n).toPrimePowerNeighbourLogBudget)
  let gap : ℝ := 1 - (1 + epsilon) * delta
  have hgap : 0 < gap := by
    dsimp [gap]
    linarith
  intro C
  obtain ⟨n, hn⟩ := hlogUnbounded (C / gap)
  refine ⟨n, ?_⟩
  have hmul :
      C < Real.log ((D n).b : ℝ) * gap :=
    (div_lt_iff₀ hgap).mp hn
  simpa [gap, mul_comm] using hmul

#print axioms abcRadical_le_pow_primeFactorsCard_of_smooth
#print axioms abcRadical_le_pow_of_smooth_card
#print axioms not_abc_of_unbounded_smoothLowOmegaPrimePowerNeighbours

end SmoothLowOmegaPrimePowerNeighbour
end IUTThreeClosures
