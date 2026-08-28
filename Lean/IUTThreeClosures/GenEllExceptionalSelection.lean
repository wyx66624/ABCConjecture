/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GenEllLemma41Closed

/-!
# Selecting a prescribed-size prime outside secondary exceptional sets

GenEll Lemma 4.1 produces many distinct primes outside a primary finite set
whose logarithmic mass is controlled.  The Galois applications then discard a
bounded number of additional candidates for representation-theoretic or local
reasons.

This file formalizes that last pigeonhole step.  If the prescribed-size theorem
produces at least `M` candidates and fewer than `M` of them lie in a secondary
exceptional set, one candidate avoids both sets.  The same theorem carries any
affine upper bound for the primary logarithmic mass into an explicit upper
bound for the selected prime.

No Galois-image assertion or height estimate is introduced here; those remain
source-facing arithmetic theorems.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- A finite set strictly smaller than `S` cannot contain all of `S`. -/
theorem exists_mem_not_mem_of_card_lt
    {α : Type*} [DecidableEq α]
    (S B : Finset α)
    (hcard : B.card < S.card) :
    ∃ x ∈ S, x ∉ B := by
  by_contra hnone
  push_neg at hnone
  have hsub : S ⊆ B := by
    intro x hx
    exact hnone x hx
  exact (not_lt_of_ge (Finset.card_le_card hsub)) hcard

/-- If `S` has at least `M` elements and a secondary exceptional set has fewer
than `M`, some element of `S` avoids it. -/
theorem exists_mem_not_mem_of_secondary_capacity
    {α : Type*} [DecidableEq α]
    (S B : Finset α) (M : ℕ)
    (hS : M ≤ S.card)
    (hB : B.card < M) :
    ∃ x ∈ S, x ∉ B := by
  exact exists_mem_not_mem_of_card_lt S B (hB.trans_le hS)

/-- **Two-stage prescribed-prime selection.**  The constants depend only on
`M` and `epsilon`, while the secondary exceptional set may vary pointwise as
long as its cardinality is uniformly below `M`. -/
theorem genEllLemma41_avoid_secondary
    (M : ℕ) {ε : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4) :
    ∃ xε Cε : ℝ,
      0 < xε ∧
      Cε < ε * xε ∧
      ∀ (A B : Finset ℕ),
        (∀ p ∈ A, p.Prime) →
        B.card < M →
        ∀ hBase : ℕ,
          xε < primeLogMass A →
          ∃ p : ℕ,
            p.Prime ∧
            hBase < p ∧
            (p : ℝ) ≤
              genEllLemma41Radius ε (primeLogMass A) hBase ∧
            p ∉ A ∧
            p ∉ B := by
  obtain ⟨xε, Cε, hxε, hCε, hprime⟩ :=
    genEllLemma41_closed M hεpos hεlt
  refine ⟨xε, Cε, hxε, hCε, ?_⟩
  intro A B hA hB hBase hxA
  obtain ⟨S, hScard, hS⟩ := hprime A hA hBase hxA
  obtain ⟨p, hpS, hpB⟩ :=
    exists_mem_not_mem_of_secondary_capacity S B M hScard hB
  rcases hS p hpS with ⟨hpp, hhp, hpY, hpA⟩
  exact ⟨p, hpp, hhp, hpY, hpA, hpB⟩

/-- A bound on the logarithmic mass of the primary forbidden set propagates
linearly to the selected-prime radius. -/
theorem genEllRadius_le_of_primeLogMass_le
    {ε xA H α β : ℝ} {hBase : ℕ}
    (hε : 0 ≤ ε)
    (hxA : xA ≤ α * H + β) :
    genEllLemma41Radius ε xA hBase ≤
      (1 + 6 * ε) * (α * H + β) + 8 * hBase := by
  unfold genEllLemma41Radius
  have hcoef : 0 ≤ 1 + 6 * ε := by positivity
  exact add_le_add_right
    (mul_le_mul_of_nonneg_left hxA hcoef) _

/-- Pointwise version: a prescribed prime inherits any affine mass estimate. -/
theorem selectedPrime_le_of_primeLogMass_le
    {ε H α β : ℝ} {A : Finset ℕ} {hBase p : ℕ}
    (hε : 0 ≤ ε)
    (hp : (p : ℝ) ≤
      genEllLemma41Radius ε (primeLogMass A) hBase)
    (hmass : primeLogMass A ≤ α * H + β) :
    (p : ℝ) ≤
      (1 + 6 * ε) * (α * H + β) + 8 * hBase :=
  hp.trans (genEllRadius_le_of_primeLogMass_le hε hmass)

/-- A finite union of secondary exceptional sets may be supplied after proving
a single cardinality bound for that union. -/
theorem genEllLemma41_avoid_secondary_union
    (M : ℕ) {ε : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (I : Type*) [Fintype I] [DecidableEq I] :
    ∃ xε Cε : ℝ,
      0 < xε ∧
      Cε < ε * xε ∧
      ∀ (A : Finset ℕ) (B : I → Finset ℕ),
        (∀ p ∈ A, p.Prime) →
        (Finset.univ.biUnion B).card < M →
        ∀ hBase : ℕ,
          xε < primeLogMass A →
          ∃ p : ℕ,
            p.Prime ∧
            hBase < p ∧
            (p : ℝ) ≤
              genEllLemma41Radius ε (primeLogMass A) hBase ∧
            p ∉ A ∧
            ∀ i : I, p ∉ B i := by
  obtain ⟨xε, Cε, hxε, hCε, hselect⟩ :=
    genEllLemma41_avoid_secondary M hεpos hεlt
  refine ⟨xε, Cε, hxε, hCε, ?_⟩
  intro A B hA hB hBase hxA
  obtain ⟨p, hpp, hhp, hpY, hpA, hpB⟩ :=
    hselect A (Finset.univ.biUnion B) hA hB hBase hxA
  refine ⟨p, hpp, hhp, hpY, hpA, ?_⟩
  intro i hpi
  apply hpB
  exact Finset.mem_biUnion.mpr ⟨i, Finset.mem_univ i, hpi⟩

end IUTThreeClosures
