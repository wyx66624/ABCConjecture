/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PrimePowerSmoothNeighbour

/-!
# Smooth low-omega neighbours of prime powers

Smoothness alone does not control the radical of an integer: a squarefree
`y`-smooth number can have radical equal to itself.  A bound for the number of
distinct prime factors supplies the missing deterministic input:

`rad(n) <= y ^ omega(n)`.

This file proves that inequality and connects a height-unbounded family of
short, smooth, low-omega neighbours of prime powers to the existing exact
`not ABCConjecture` gate.  It assumes no distribution theorem for smooth
numbers in short intervals.
-/

namespace IUTThreeClosures
namespace SmoothLowOmegaPrimePowerNeighbour

open PrimePowerSmoothNeighbour

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

/-- A prime-power neighbour together with an explicit smoothness and
prime-factor-count certificate.  The final logarithmic budget is stated using
`H * p * y^w`, which is the deterministic radical upper bound. -/
structure SmoothLowOmegaPrimePowerNeighbourLogBudget where
  H : ℕ
  y : ℕ
  w : ℕ
  data : PrimePowerNeighbourData
  hHpos : 0 < H
  hypos : 0 < y
  hgap : data.a ≤ H
  hsmooth : IsYSmooth y data.c
  homega : data.c.primeFactors.card ≤ w
  delta : ℝ
  K : ℝ
  hlogBudget :
    Real.log (((H * data.p * y ^ w : ℕ) : ℝ)) ≤
      delta * data.logHeight + K

namespace SmoothLowOmegaPrimePowerNeighbourLogBudget

/-- Forget the analytic certificates and retain the radical budget required by
the existing prime-power-neighbour theorem. -/
def toPrimePowerNeighbourLogBudget
    (D : SmoothLowOmegaPrimePowerNeighbourLogBudget) :
    PrimePowerNeighbourLogBudget where
  H := D.H
  data := D.data
  hHpos := D.hHpos
  hgap := D.hgap
  M := D.y ^ D.w
  hsmooth := by
    exact abcRadical_le_pow_of_smooth_card
      D.hypos D.hsmooth D.homega
  delta := D.delta
  K := D.K
  hlogBudget := D.hlogBudget

@[simp] theorem toPrimePowerNeighbourLogBudget_logHeight
    (D : SmoothLowOmegaPrimePowerNeighbourLogBudget) :
    D.toPrimePowerNeighbourLogBudget.data.logHeight = D.data.logHeight := rfl

end SmoothLowOmegaPrimePowerNeighbourLogBudget

/-- An unbounded family of short, `y`-smooth, low-omega prime-power neighbours
with subcritical logarithmic radical budget disproves `ABCConjecture`.

All unresolved analytic number theory is isolated in the construction of the
family `D`; the implication itself is unconditional. -/
theorem not_abc_of_unbounded_smoothLowOmegaPrimePowerNeighbours
    (D : ℕ → SmoothLowOmegaPrimePowerNeighbourLogBudget)
    (ε : ℝ)
    (hε : 0 < ε)
    (hsubcritical : ∀ n,
      (1 + ε) * (D n).delta < 1)
    (hunbounded : ∀ B : ℝ, ∃ n : ℕ,
      B < (D n).data.logHeight) :
    ¬ ABCConjecture := by
  let E : ℕ → PrimePowerNeighbourLogBudget :=
    fun n => (D n).toPrimePowerNeighbourLogBudget
  apply not_abc_of_unbounded_primePowerNeighbours E ε hε
  · intro n
    exact hsubcritical n
  · intro B
    obtain ⟨n, hn⟩ := hunbounded B
    exact ⟨n, hn⟩

#print axioms abcRadical_le_pow_primeFactorsCard_of_smooth
#print axioms abcRadical_le_pow_of_smooth_card
#print axioms not_abc_of_unbounded_smoothLowOmegaPrimePowerNeighbours

end SmoothLowOmegaPrimePowerNeighbour
end IUTThreeClosures
