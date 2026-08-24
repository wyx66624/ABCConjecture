/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MultiradialPresentationTransfer

/-!
# The distinguished genuine branch needed for the Corollary 3.12 lower bound

A complete classification of every genuine Theorem 3.11 output is stronger
than what the lower-bound portion of Corollary 3.12 needs.  Step (xi) of the
printed proof identifies the q-pilot with one distinguished Θ-pilot branch
through the `Θ^{×μ}_{LGP}` gluing isomorphism.  Therefore the source-facing
lower theorem only needs:

* one genuine output index;
* equality of its represented region with the native q-pilot region.

The native region is then automatically contained in the full union of
possible genuine outputs.  Sound encoding transfers this inclusion to any
generated Ind1/Ind2/Ind3 presentation.  Completeness of the presentation is
not needed for this direction.

This separates two independent source obligations:

1. **distinguished-branch realization**, sufficient for the Corollary 3.12
   lower bound;
2. **all-output upper control**, needed later for the IUT IV component formula.
-/

namespace IUTThreeClosures

universe u v w

/-- One genuine multiradial output is exactly the native q-pilot region. -/
structure DistinguishedGenuineBranch
    {α : Type u}
    (Genuine : Type v)
    (genuineRegion : Genuine → Set α)
    (native : Set α) where
  output : Genuine
  output_region : genuineRegion output = native

namespace DistinguishedGenuineBranch

variable {α : Type u}
variable {Genuine : Type v}
variable {genuineRegion : Genuine → Set α}
variable {native : Set α}
variable
  (D : DistinguishedGenuineBranch Genuine genuineRegion native)

/-- The native q-pilot region lies in the complete genuine possible-image
union. -/
theorem native_le_genuineUnion :
    native ⊆ representedUnion genuineRegion := by
  intro x hx
  exact ⟨D.output, D.output_region.symm ▸ hx⟩

/-- A sound source-to-syntax encoding carries the distinguished native branch
into the generated possible-image union. -/
theorem native_le_syntaxUnion
    {Syntax : Type w}
    {syntaxRegion : Syntax → Set α}
    (encode : Genuine → Syntax)
    (hsound :
      ∀ g : Genuine,
        genuineRegion g ⊆ syntaxRegion (encode g)) :
    native ⊆ representedUnion syntaxRegion :=
  native_le_generated_of_sound_encoding
    encode hsound native D.native_le_genuineUnion

/-- The distinguished branch also identifies every extensional observable of
that branch with the corresponding native observable. -/
theorem observable_output_eq_native
    {β : Type*}
    (observable : Set α → β) :
    observable (genuineRegion D.output) = observable native := by
  rw [D.output_region]

/-- Numerical specialization of the preceding equality. -/
theorem volume_output_eq_native
    (volume : Set α → ℝ) :
    volume (genuineRegion D.output) = volume native :=
  D.observable_output_eq_native volume

end DistinguishedGenuineBranch

/-- The upper-envelope theorem is logically independent of the distinguished
branch: it asks for every genuine output to lie in one common envelope. -/
structure GenuineAllOutputEnvelope
    {α : Type u}
    (Genuine : Type v)
    (genuineRegion : Genuine → Set α)
    (envelope : Set α) where
  output_le : ∀ g : Genuine, genuineRegion g ⊆ envelope

namespace GenuineAllOutputEnvelope

variable {α : Type u}
variable {Genuine : Type v}
variable {genuineRegion : Genuine → Set α}
variable {envelope : Set α}
variable
  (E : GenuineAllOutputEnvelope Genuine genuineRegion envelope)

/-- Componentwise output control is equivalent to control of the complete
possible-image union. -/
theorem genuineUnion_le :
    representedUnion genuineRegion ⊆ envelope := by
  rintro x ⟨g, hx⟩
  exact E.output_le g hx

end GenuineAllOutputEnvelope

end IUTThreeClosures
