/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Output-identification audit for a multivalued IUT construction

A multiradial or indeterminacy-closed construction may produce several
possible outputs from one input.  The statement

`for every input, some possible output satisfies the desired estimate`

does not imply that the particular output determined by the input satisfies
that estimate.  One needs an additional theorem, such as uniqueness of the
possible output or transport/invariance of the estimate across all possible
outputs.

This file isolates that logical issue, gives a two-output countermodel, and
proves two sufficient repair principles.  It contains no arithmetic-geometric
axiom and makes no claim that either repair principle has been established for
the actual IUT multiradial algorithm.
-/

namespace IUTThreeClosures
namespace IUTOutputIdentificationAudit

universe u v

/-- Weak existential conclusion: at least one possible output is good. -/
def ExistentialGoodOutput
    {Input : Type u} {Output : Type v}
    (possible : Input → Output → Prop)
    (good : Input → Output → Prop) : Prop :=
  ∀ x : Input, ∃ y : Output, possible x y ∧ good x y

/-- Pointwise conclusion actually needed for a distinguished, input-determined
output. -/
def SelectedGoodOutput
    {Input : Type u} {Output : Type v}
    (possible : Input → Output → Prop)
    (good : Input → Output → Prop)
    (selected : Input → Output) : Prop :=
  ∀ x : Input,
    possible x (selected x) ∧ good x (selected x)

/-- In the countermodel every Boolean is a possible output. -/
def boolPossible (_x : Unit) (_y : Bool) : Prop := True

/-- Only `true` is a good output. -/
def boolGood (_x : Unit) (y : Bool) : Prop := y = true

/-- The input-determined output is `false`. -/
def boolSelected (_x : Unit) : Bool := false

/-- There is a good possible output for the unique input. -/
theorem bool_existentialGoodOutput :
    ExistentialGoodOutput boolPossible boolGood := by
  intro x
  exact ⟨true, trivial, rfl⟩

/-- The selected output in the same model is not good. -/
theorem bool_not_selectedGoodOutput :
    ¬ SelectedGoodOutput boolPossible boolGood boolSelected := by
  intro h
  have hfalse := (h ()).2
  simpa [boolGood, boolSelected] using hfalse

/-- Exact logical countermodel: existentially obtaining a good possible output
does not identify the distinguished output. -/
theorem existential_output_does_not_identify_selected_output :
    ExistentialGoodOutput boolPossible boolGood ∧
      ¬ SelectedGoodOutput boolPossible boolGood boolSelected :=
  ⟨bool_existentialGoodOutput, bool_not_selectedGoodOutput⟩

/-- **Uniqueness repair.** If all possible outputs for an input are equal, an
existentially good output agrees with the selected possible output. -/
theorem selectedGood_of_uniquePossible
    {Input : Type u} {Output : Type v}
    (possible : Input → Output → Prop)
    (good : Input → Output → Prop)
    (selected : Input → Output)
    (hexists : ExistentialGoodOutput possible good)
    (hselected : ∀ x, possible x (selected x))
    (hunique : ∀ x y z,
      possible x y → possible x z → y = z) :
    SelectedGoodOutput possible good selected := by
  intro x
  obtain ⟨y, hyPossible, hyGood⟩ := hexists x
  have hy : y = selected x :=
    hunique x y (selected x) hyPossible (hselected x)
  subst y
  exact ⟨hselected x, hyGood⟩

/-- **Invariance repair.** It also suffices to prove that goodness transports
between any two possible outputs for the same input. -/
theorem selectedGood_of_possibleOutputTransport
    {Input : Type u} {Output : Type v}
    (possible : Input → Output → Prop)
    (good : Input → Output → Prop)
    (selected : Input → Output)
    (hexists : ExistentialGoodOutput possible good)
    (hselected : ∀ x, possible x (selected x))
    (htransport : ∀ x y z,
      possible x y → possible x z → good x y → good x z) :
    SelectedGoodOutput possible good selected := by
  intro x
  obtain ⟨y, hyPossible, hyGood⟩ := hexists x
  exact ⟨hselected x,
    htransport x y (selected x) hyPossible (hselected x) hyGood⟩

/-- The transport repair is equivalent to saying that, for each input, the
predicate `good` is constant on the fibre of possible outputs, in the forward
direction needed by an existential proof. -/
def GoodInvariantOnPossibleFibres
    {Input : Type u} {Output : Type v}
    (possible : Input → Output → Prop)
    (good : Input → Output → Prop) : Prop :=
  ∀ x y z,
    possible x y → possible x z → good x y → good x z

/-- Packaged form of the invariance repair. -/
theorem selectedGood_of_fibreInvariant
    {Input : Type u} {Output : Type v}
    (possible : Input → Output → Prop)
    (good : Input → Output → Prop)
    (selected : Input → Output)
    (hexists : ExistentialGoodOutput possible good)
    (hselected : ∀ x, possible x (selected x))
    (hinvariant : GoodInvariantOnPossibleFibres possible good) :
    SelectedGoodOutput possible good selected := by
  exact selectedGood_of_possibleOutputTransport
    possible good selected hexists hselected hinvariant

/-- The Boolean countermodel also shows that fibre invariance is not automatic
from mere possibility and existential goodness. -/
theorem bool_not_goodInvariantOnPossibleFibres :
    ¬ GoodInvariantOnPossibleFibres boolPossible boolGood := by
  intro h
  have hbad := h () true false trivial trivial rfl
  simpa [boolGood] using hbad

#print axioms bool_existentialGoodOutput
#print axioms bool_not_selectedGoodOutput
#print axioms existential_output_does_not_identify_selected_output
#print axioms selectedGood_of_uniquePossible
#print axioms selectedGood_of_possibleOutputTransport
#print axioms selectedGood_of_fibreInvariant
#print axioms bool_not_goodInvariantOnPossibleFibres

end IUTOutputIdentificationAudit
end IUTThreeClosures
