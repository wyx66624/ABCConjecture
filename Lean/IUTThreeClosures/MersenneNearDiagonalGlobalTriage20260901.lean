/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneWieferichTailReduction20260901

/-!
# Global near-diagonal triage for the Mersenne powerful part

The mathematical argument precedes this file in
`research/ABC_MERSENNE_NEAR_DIAGONAL_GLOBAL_TRIAGE_2026_09_01.md`.

Earlier modules prove the actual cyclotomic cap, totient concentration, and
the blockwise Wieferich decomposition.  This file formalizes the finite
ordered-ring step used after those arithmetic and analytic estimates have
been supplied: two controlled arms leave half of a target mass, so one of
three unresolved arms carries one sixth of the target.  It also proves the
transition-cardinality consequence, a finite five-arm closure inequality,
and exact full-premise counterexamples to deleting any one disjunct.

No asymptotic distribution assertion is introduced as an axiom here.
-/

namespace IUTThreeClosures
namespace MersenneNearDiagonalGlobalTriage20260901

open scoped BigOperators
open MersenneWieferichTailReduction20260901

/-! ## The aggregate subtraction argument -/

/-- If the far-diagonal and near-small arms each cost at most one quarter of
a nonnegative target, then one of the three remaining aggregate arms costs at
least one sixth of the target. -/
theorem deep_or_transition_or_extreme_of_two_controlled_arms
    {target far small deep transition extreme : ℝ}
    (_htarget : 0 ≤ target)
    (htotal : target ≤ far + small + deep + transition + extreme)
    (hfar : far ≤ target / 4)
    (hsmall : small ≤ target / 4) :
    target / 6 ≤ deep ∨
      target / 6 ≤ transition ∨
      target / 6 ≤ extreme := by
  by_contra h
  push Not at h
  rcases h with ⟨hdeep, htransition, hextreme⟩
  linarith

#print axioms deep_or_transition_or_extreme_of_two_controlled_arms

/-- Finite near-diagonal version of the global obstruction.  `total` is the
canonical excess mass of one exact-order block.  The pointwise inequality is
summed only over the near set; the complement has already been compressed
into `far`. -/
theorem aggregate_near_diagonal_trichotomy
    {ι : Type*} (near : Finset ι)
    (total small deep transition extreme : ι → ℝ)
    {target far : ℝ}
    (htarget : 0 ≤ target)
    (htotal : target ≤ far + ∑ i ∈ near, total i)
    (hdecomp : ∀ i ∈ near,
      total i ≤ small i + deep i + transition i + extreme i)
    (hfar : far ≤ target / 4)
    (hsmall : (∑ i ∈ near, small i) ≤ target / 4) :
    target / 6 ≤ ∑ i ∈ near, deep i ∨
      target / 6 ≤ ∑ i ∈ near, transition i ∨
      target / 6 ≤ ∑ i ∈ near, extreme i := by
  have hsum :
      (∑ i ∈ near, total i) ≤
        (∑ i ∈ near, small i) +
          (∑ i ∈ near, deep i) +
          (∑ i ∈ near, transition i) +
          (∑ i ∈ near, extreme i) := by
    calc
      (∑ i ∈ near, total i) ≤
          ∑ i ∈ near,
            (small i + deep i + transition i + extreme i) := by
              exact Finset.sum_le_sum fun i hi => hdecomp i hi
      _ = (∑ i ∈ near, small i) +
          (∑ i ∈ near, deep i) +
          (∑ i ∈ near, transition i) +
          (∑ i ∈ near, extreme i) := by
            simp only [Finset.sum_add_distrib]
  have hbudget :
      target ≤ far +
        (∑ i ∈ near, small i) +
        (∑ i ∈ near, deep i) +
        (∑ i ∈ near, transition i) +
        (∑ i ∈ near, extreme i) := by
    linarith
  exact deep_or_transition_or_extreme_of_two_controlled_arms
    htarget hbudget hfar hsmall

#print axioms aggregate_near_diagonal_trichotomy

/-! ## The transition-prime cardinality consequence -/

/-- A global transition mass of at least `target / 6`, together with a
positive pointwise logarithmic cap, gives the cardinality lower bound used
in the transition alternative. -/
theorem aggregate_transition_card_lowerBound
    {ι : Type*} (s : Finset ι) (weight : ι → ℝ)
    {target cap : ℝ}
    (hweight : ∀ x ∈ s, 0 ≤ weight x)
    (hcapPos : 0 < cap)
    (hcap : ∀ x ∈ s, weight x ≤ cap)
    (hmass : target / 6 ≤ ∑ x ∈ s, weight x) :
    (target / 6) / cap ≤ (s.card : ℝ) := by
  exact transitionCard_lowerBound_of_mass
    s weight hweight hcapPos hcap hmass

#print axioms aggregate_transition_card_lowerBound

/-- The intended logarithmic specialization.  Taking
`cap = (2 + delta) * log m` gives the exact lower bound in the mathematical
global-triage theorem. -/
theorem aggregate_transition_card_lowerBound_of_log_bound
    (s : Finset ℕ) {target delta m : ℝ}
    (hweight : ∀ q ∈ s, 0 ≤ Real.log (q : ℝ))
    (hcapPos : 0 < (2 + delta) * Real.log m)
    (hcap : ∀ q ∈ s,
      Real.log (q : ℝ) ≤ (2 + delta) * Real.log m)
    (hmass : target / 6 ≤ ∑ q ∈ s, Real.log (q : ℝ)) :
    (target / 6) / ((2 + delta) * Real.log m) ≤
      (s.card : ℝ) := by
  exact aggregate_transition_card_lowerBound
    s (fun q : ℕ => Real.log (q : ℝ))
      hweight hcapPos hcap hmass

#print axioms aggregate_transition_card_lowerBound_of_log_bound

/-! ## Finite closure -/

/-- Five separate upper bounds close the corresponding finite mass ledger.
In the Mersenne application the five terms are the far, near-small, deep,
transition, and extreme contributions. -/
theorem finite_five_arm_closure
    {total far small deep transition extreme
      farCap smallCap deepCap transitionCap extremeCap : ℝ}
    (hdecomp : total ≤ far + small + deep + transition + extreme)
    (hfar : far ≤ farCap)
    (hsmall : small ≤ smallCap)
    (hdeep : deep ≤ deepCap)
    (htransition : transition ≤ transitionCap)
    (hextreme : extreme ≤ extremeCap) :
    total ≤ farCap + smallCap + deepCap + transitionCap + extremeCap := by
  linarith

#print axioms finite_five_arm_closure

/-! ## Exact counterexamples to deleting a disjunct -/

/-- The aggregate numerical premises used by the triage theorem.  The
equality records an exact one-point decomposition, and nonnegativity records
the full mass interpretation. -/
def TriagePremises
    (target far small deep transition extreme : ℝ) : Prop :=
  0 ≤ target ∧
  0 ≤ far ∧ 0 ≤ small ∧ 0 ≤ deep ∧
  0 ≤ transition ∧ 0 ≤ extreme ∧
  target = far + small + deep + transition + extreme ∧
  far ≤ target / 4 ∧ small ≤ target / 4

/-- A full-premise one-point example supported entirely on the deep arm.
Consequently the deep disjunct cannot be deleted by ordered-ring reasoning. -/
theorem deep_disjunct_has_full_premise_counterexample :
    ∃ target far small deep transition extreme : ℝ,
      TriagePremises target far small deep transition extreme ∧
      target / 6 ≤ deep ∧
      ¬ (target / 6 ≤ transition ∨ target / 6 ≤ extreme) := by
  refine ⟨1, 0, 0, 1, 0, 0, ?_⟩
  norm_num [TriagePremises]

#print axioms deep_disjunct_has_full_premise_counterexample

/-- A full-premise one-point example supported entirely on the transition
arm.  Consequently the transition disjunct cannot be deleted by ordered-ring
reasoning. -/
theorem transition_disjunct_has_full_premise_counterexample :
    ∃ target far small deep transition extreme : ℝ,
      TriagePremises target far small deep transition extreme ∧
      target / 6 ≤ transition ∧
      ¬ (target / 6 ≤ deep ∨ target / 6 ≤ extreme) := by
  refine ⟨1, 0, 0, 0, 1, 0, ?_⟩
  norm_num [TriagePremises]

#print axioms transition_disjunct_has_full_premise_counterexample

/-- A full-premise one-point example supported entirely on the extreme arm.
Consequently the extreme disjunct cannot be deleted by ordered-ring
reasoning. -/
theorem extreme_disjunct_has_full_premise_counterexample :
    ∃ target far small deep transition extreme : ℝ,
      TriagePremises target far small deep transition extreme ∧
      target / 6 ≤ extreme ∧
      ¬ (target / 6 ≤ deep ∨ target / 6 ≤ transition) := by
  refine ⟨1, 0, 0, 0, 0, 1, ?_⟩
  norm_num [TriagePremises]

#print axioms extreme_disjunct_has_full_premise_counterexample

end MersenneNearDiagonalGlobalTriage20260901
end IUTThreeClosures
