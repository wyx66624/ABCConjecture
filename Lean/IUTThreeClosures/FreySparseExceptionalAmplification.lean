/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SparseExceptionalTransfer

/-!
# Sparse exceptional amplification on Frey fibres

An almost-all Szpiro theorem is an ambient statistical statement.  To derive a
uniform claim for every abc source point, one needs a source-dependent family
of auxiliary curves whose intersection with the exceptional set is strictly
smaller than the family itself.

This module formalizes that exact amplification step.  It does not assume any
Szpiro estimate, modularity theorem, or construction of the auxiliary fibres.
-/

namespace IUTThreeClosures
namespace FreySparseExceptionalAmplification

open SparseExceptionalTransfer

/-- Abstract finite amplification data above each arithmetic source.  A good
target in the fibre proves the desired source claim. -/
structure FreyAmplificationData (Source Target : Type*)
    [DecidableEq Target] where
  fiber : Source → Finset Target
  exceptional : Finset Target
  GoodTarget : Target → Prop
  SourceClaim : Source → Prop
  failure_mem_exceptional :
    ∀ t : Target, ¬ GoodTarget t → t ∈ exceptional
  good_target_implies_source_claim :
    ∀ s : Source, ∀ t ∈ fiber s, GoodTarget t → SourceClaim s

namespace FreyAmplificationData

variable {Source Target : Type*} [DecidableEq Target]

/-- A strict relative exceptional-fibre bound upgrades an almost-all target
claim to a uniform source claim. -/
theorem sourceClaim_of_relative_exceptional_fiber_bound
    (A : FreyAmplificationData Source Target)
    (s : Source)
    (hcard :
      (A.exceptional ∩ A.fiber s).card < (A.fiber s).card) :
    A.SourceClaim s := by
  classical
  obtain ⟨t, htmem, htgood⟩ :=
    exists_good_center_of_exceptional_cover
      (A.fiber s) A.exceptional A.GoodTarget
      (by
        intro t _ htbad
        exact A.failure_mem_exceptional t htbad)
      hcard
  exact A.good_target_implies_source_claim s t htmem htgood

/-- Uniform relative bounds on all fibres give the universally quantified
source theorem. -/
theorem uniform_sourceClaim_of_relative_exceptional_fiber_bounds
    (A : FreyAmplificationData Source Target)
    (hcard : ∀ s : Source,
      (A.exceptional ∩ A.fiber s).card < (A.fiber s).card) :
    ∀ s : Source, A.SourceClaim s := by
  intro s
  exact A.sourceClaim_of_relative_exceptional_fiber_bound s (hcard s)

/-- A numerical upper bound on exceptional points in each fibre is enough once
it is strictly below the fibre cardinality. -/
theorem uniform_sourceClaim_of_exceptional_count_bound
    (A : FreyAmplificationData Source Target)
    (M : Source → ℕ)
    (hexceptional : ∀ s : Source,
      (A.exceptional ∩ A.fiber s).card ≤ M s)
    (hfiber : ∀ s : Source, M s < (A.fiber s).card) :
    ∀ s : Source, A.SourceClaim s := by
  apply A.uniform_sourceClaim_of_relative_exceptional_fiber_bounds
  intro s
  exact lt_of_le_of_lt (hexceptional s) (hfiber s)

end FreyAmplificationData

/-- Ambient sparsity alone does not imply a good Frey target: any proper thin
candidate family can itself be chosen as the whole exceptional set. -/
theorem ambient_exceptional_saving_can_miss_entire_frey_family
    {Target : Type*} [DecidableEq Target]
    (freyFamily ambient : Finset Target)
    (hsubset : freyFamily ⊆ ambient)
    (hproper : freyFamily.card < ambient.card) :
    ∃ exceptional : Finset Target,
      exceptional ⊆ ambient ∧
      exceptional.card < ambient.card ∧
      freyFamily ⊆ exceptional :=
  sparse_centers_can_be_entirely_exceptional
    freyFamily ambient hsubset hproper

#print axioms FreyAmplificationData.sourceClaim_of_relative_exceptional_fiber_bound
#print axioms FreyAmplificationData.uniform_sourceClaim_of_relative_exceptional_fiber_bounds
#print axioms FreyAmplificationData.uniform_sourceClaim_of_exceptional_count_bound
#print axioms ambient_exceptional_saving_can_miss_entire_frey_family

end FreySparseExceptionalAmplification
end IUTThreeClosures
