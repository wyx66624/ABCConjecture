/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SmoothCounterexampleProgram

/-!
# A tilted candidate-packet gate for smooth prime-power neighbours

The preceding modules isolate two separate deterministic steps:

* a sufficiently large decreasing tilted sum extracts a low-statistic element;
* an unbounded family of smooth low-omega prime-power neighbours with a fixed
  subcritical radical budget disproves `ABCConjecture`.

This file composes those steps.  The remaining analytic input is a single
short-interval tilted-sum lower bound for every packet in an unbounded family.
No such distribution theorem is asserted here.
-/

namespace IUTThreeClosures
namespace TiltedSmoothNeighbourPacketGate

open scoped BigOperators
open SmoothLowOmegaPrimePowerNeighbour
open TiltedStatisticExtraction

/-- A finite packet of prime-power-neighbour candidates equipped with the
uniform arithmetic data needed by the smooth low-omega disproof gate.

The strict tilted lower bound at threshold `w + 1` forces a candidate whose
number of distinct prime divisors is at most `w`. -/
structure SmoothPrimePowerCandidatePacket (delta : ℝ) where
  candidates : Finset PrimePowerNeighbourData
  t : ℝ
  ht : 0 ≤ t
  H : ℕ
  y : ℕ
  w : ℕ
  hypos : 0 < y
  smooth_c : ∀ D ∈ candidates, IsYSmooth y D.c
  a_le_H : ∀ D ∈ candidates, D.a ≤ H
  log_budget_le : ∀ D ∈ candidates,
    Real.log ((H * D.p * y ^ w : ℕ) : ℝ) ≤
      delta * Real.log (D.b : ℝ)
  tilted_lower :
    (candidates.card : ℝ) *
        Real.exp (-t * ((w + 1 : ℕ) : ℝ)) <
      ∑ D ∈ candidates,
        Real.exp (-t * (D.c.primeFactors.card : ℝ))

namespace SmoothPrimePowerCandidatePacket

variable {delta : ℝ}

/-- The tilted packet contains a candidate with at most `w` distinct prime
divisors. -/
theorem exists_lowOmega_candidate
    (P : SmoothPrimePowerCandidatePacket delta) :
    ∃ D ∈ P.candidates, D.c.primeFactors.card ≤ P.w := by
  classical
  obtain ⟨D, hD, hlt⟩ :=
    exists_stat_lt_of_exponential_tilt
      P.candidates
      (fun E : PrimePowerNeighbourData => E.c.primeFactors.card)
      P.t P.ht (P.w + 1) P.tilted_lower
  exact ⟨D, hD, by omega⟩

end SmoothPrimePowerCandidatePacket

/-- A height-unbounded sequence of tilted smooth-neighbour packets with a
fixed subcritical logarithmic radical exponent disproves `ABCConjecture`.

Thus a prospective analytic disproof may target exactly the `tilted_lower`
hypotheses and the packet-unboundedness statement below. -/
theorem not_abc_of_unbounded_tiltedSmoothNeighbourPackets
    {epsilon delta : ℝ}
    (hepsilon : 0 < epsilon)
    (hsubcritical : (1 + epsilon) * delta < 1)
    (P : ℕ → SmoothPrimePowerCandidatePacket delta)
    (hlogUnbounded :
      ∀ B : ℝ, ∃ n : ℕ, ∀ D ∈ (P n).candidates,
        B < Real.log (D.b : ℝ)) :
    ¬ ABCConjecture := by
  classical
  have hexists :
      ∀ n : ℕ, ∃ D ∈ (P n).candidates,
        D.c.primeFactors.card ≤ (P n).w := by
    intro n
    exact (P n).exists_lowOmega_candidate
  choose D hDmem hDomega using hexists
  apply not_abc_of_unbounded_smoothLowOmegaPrimePowerNeighbours
    hepsilon hsubcritical D
    (fun n =>
      { H := (P n).H
        y := (P n).y
        w := (P n).w
        hypos := (P n).hypos
        a_le_H := (P n).a_le_H (D n) (hDmem n)
        smooth_c := (P n).smooth_c (D n) (hDmem n)
        omega_c_le := hDomega n
        log_budget_le := (P n).log_budget_le (D n) (hDmem n) })
  intro B
  obtain ⟨n, hn⟩ := hlogUnbounded B
  exact ⟨n, hn (D n) (hDmem n)⟩

#print axioms SmoothPrimePowerCandidatePacket.exists_lowOmega_candidate
#print axioms not_abc_of_unbounded_tiltedSmoothNeighbourPackets

end TiltedSmoothNeighbourPacketGate
end IUTThreeClosures
