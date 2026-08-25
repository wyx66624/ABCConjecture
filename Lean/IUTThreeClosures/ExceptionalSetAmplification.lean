/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Exceptional-set amplification by incidence counting

Suppose every input exception produces at least `L` output exceptions, while
every output has at most `M` preimages.  Double counting the incidence relation
gives

`inputs.card * L ≤ outputs.card * M`.

This is the exact finite combinatorial core of the exceptional-set
amplification route toward the abc conjecture.  In applications, `inputs` is a
dyadic shell of putative abc exceptions and `outputs` is a bounded-height
exceptional set supplied by a power-saving counting theorem.

No construction of the amplification relation, and no abc conclusion, is
asserted in this module.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-- The number of outputs related to one input. -/
noncomputable def amplificationRowCount
    {α β : Type*}
    (outputs : Finset β) (R : α → β → Prop) (a : α) : ℕ := by
  classical
  exact (outputs.filter (R a)).card

/-- The number of inputs related to one output. -/
noncomputable def amplificationColumnCount
    {α β : Type*}
    (inputs : Finset α) (R : α → β → Prop) (b : β) : ℕ := by
  classical
  exact (inputs.filter (fun a => R a b)).card

/-- A filtered cardinality is the sum of its zero-one indicator. -/
theorem card_filter_eq_sum_indicator
    {α : Type*} [DecidableEq α]
    (s : Finset α) (p : α → Prop) [DecidablePred p] :
    (s.filter p).card = (∑ x in s, if p x then 1 else 0) := by
  induction s using Finset.induction_on with
  | empty => simp
  | @insert a s ha ih =>
      by_cases hpa : p a
      · simp [ha, hpa, ih]
      · simp [ha, hpa, ih]

/-- The sum of all row counts equals the sum of all column counts. -/
theorem sum_amplificationRowCount_eq_sum_amplificationColumnCount
    {α β : Type*} [DecidableEq α] [DecidableEq β]
    (inputs : Finset α) (outputs : Finset β)
    (R : α → β → Prop) :
    (∑ a in inputs, amplificationRowCount outputs R a) =
      (∑ b in outputs, amplificationColumnCount inputs R b) := by
  classical
  calc
    (∑ a in inputs, amplificationRowCount outputs R a) =
        (∑ a in inputs, ∑ b in outputs, if R a b then 1 else 0) := by
      apply Finset.sum_congr rfl
      intro a ha
      exact card_filter_eq_sum_indicator outputs (R a)
    _ = (∑ b in outputs, ∑ a in inputs, if R a b then 1 else 0) := by
      rw [Finset.sum_comm]
    _ = (∑ b in outputs, amplificationColumnCount inputs R b) := by
      apply Finset.sum_congr rfl
      intro b hb
      symm
      exact card_filter_eq_sum_indicator inputs (fun a => R a b)

/-- **Finite amplification theorem.**  If every input has at least `L`
outputs and every output has at most `M` input preimages, then

`inputs.card * L ≤ outputs.card * M`.
-/
theorem exceptionalSet_incidence_bound
    {α β : Type*} [DecidableEq α] [DecidableEq β]
    (inputs : Finset α) (outputs : Finset β)
    (R : α → β → Prop)
    (L M : ℕ)
    (hrow : ∀ a ∈ inputs, L ≤ amplificationRowCount outputs R a)
    (hcolumn : ∀ b ∈ outputs,
      amplificationColumnCount inputs R b ≤ M) :
    inputs.card * L ≤ outputs.card * M := by
  calc
    inputs.card * L = (∑ _a in inputs, L) := by simp
    _ ≤ (∑ a in inputs, amplificationRowCount outputs R a) := by
      exact Finset.sum_le_sum fun a ha => hrow a ha
    _ = (∑ b in outputs, amplificationColumnCount inputs R b) :=
      sum_amplificationRowCount_eq_sum_amplificationColumnCount inputs outputs R
    _ ≤ (∑ _b in outputs, M) := by
      exact Finset.sum_le_sum fun b hb => hcolumn b hb
    _ = outputs.card * M := by simp

/-- If the total output budget is at most `U`, the same double count gives the
uniform shell bound `inputs.card * L ≤ U * M`. -/
theorem exceptionalSet_shell_bound
    {α β : Type*} [DecidableEq α] [DecidableEq β]
    (inputs : Finset α) (outputs : Finset β)
    (R : α → β → Prop)
    (L M U : ℕ)
    (hrow : ∀ a ∈ inputs, L ≤ amplificationRowCount outputs R a)
    (hcolumn : ∀ b ∈ outputs,
      amplificationColumnCount inputs R b ≤ M)
    (houtputs : outputs.card ≤ U) :
    inputs.card * L ≤ U * M := by
  exact (exceptionalSet_incidence_bound inputs outputs R L M hrow hcolumn).trans
    (Nat.mul_le_mul_right M houtputs)

/-- If the available output budget times the overlap multiplicity is strictly
smaller than the number of outputs required from one input, no input exception
can exist. -/
theorem exceptionalSet_empty_of_budget_lt
    {α β : Type*} [DecidableEq α] [DecidableEq β]
    (inputs : Finset α) (outputs : Finset β)
    (R : α → β → Prop)
    (L M U : ℕ)
    (hL : 0 < L)
    (hrow : ∀ a ∈ inputs, L ≤ amplificationRowCount outputs R a)
    (hcolumn : ∀ b ∈ outputs,
      amplificationColumnCount inputs R b ≤ M)
    (houtputs : outputs.card ≤ U)
    (hbudget : U * M < L) :
    inputs = ∅ := by
  have hbound := exceptionalSet_shell_bound
    inputs outputs R L M U hrow hcolumn houtputs
  by_contra hne
  have hnonempty : inputs.Nonempty := Finset.nonempty_iff_ne_empty.mpr hne
  have hone : 1 ≤ inputs.card := Finset.card_pos.mpr hnonempty
  have hLle : L ≤ inputs.card * L := by
    have hmul := Nat.mul_le_mul_right L hone
    simpa using hmul
  omega

end IUTThreeClosures
