/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Semantic transfer for a genuine multiradial presentation

The existing downstream development works with a generated Ind1/Ind2/Ind3
syntax.  The genuine source theorem, however, is naturally stated using
Hodge-theater, log-Kummer and Frobenioid objects.  These two output types need
not be definitionally equal.  What is required is a semantics-preserving
presentation theorem.

This module isolates the exact set-theoretic bridge.  A genuine output family
`genuineRegion : Genuine → Set α` and a generated family
`syntaxRegion : Syntax → Set α` describe the same possible-image union when
there are maps in both directions whose represented regions are included in
the corresponding target regions.  Equality of individual represented
regions is a convenient stronger specialization.

The transfer theorem then carries:

* native-branch containment;
* an upper envelope;
* equality of the full possible-image unions;
* every extensional numerical or hull construction on those unions.

Thus the remaining Theorem 3.11 obligation may be attacked as a genuine
source-to-syntax soundness/completeness theorem.  No Corollary 3.12 inequality,
volume estimate, IUT IV bound or abc statement occurs in the interface.
-/

namespace IUTThreeClosures

universe u v w

/-- The union of all regions represented by an output family. -/
def representedUnion
    {α : Type u} {Output : Type v}
    (region : Output → Set α) : Set α :=
  ⋃ o : Output, region o

@[simp]
theorem mem_representedUnion
    {α : Type u} {Output : Type v}
    {region : Output → Set α} {x : α} :
    x ∈ representedUnion region ↔
      ∃ o : Output, x ∈ region o := by
  simp [representedUnion]

/-- A semantic presentation of genuine outputs by a generated syntax.

`encode_sound` says that every genuine output is represented by its encoded
syntax term.  `decode_complete` says that every generated syntax term is
realized by some genuine output.  The use of inclusions rather than equalities
allows either side to employ a coarser but extensionally equivalent notion of
one output, while still forcing equality after taking the complete union. -/
structure MultiradialSemanticPresentation
    {α : Type u}
    (Genuine : Type v)
    (Syntax : Type w)
    (genuineRegion : Genuine → Set α)
    (syntaxRegion : Syntax → Set α) where
  encode : Genuine → Syntax
  encode_sound :
    ∀ g : Genuine, genuineRegion g ⊆ syntaxRegion (encode g)
  decode : Syntax → Genuine
  decode_complete :
    ∀ s : Syntax, syntaxRegion s ⊆ genuineRegion (decode s)

namespace MultiradialSemanticPresentation

variable {α : Type u}
variable {Genuine : Type v} {Syntax : Type w}
variable {genuineRegion : Genuine → Set α}
variable {syntaxRegion : Syntax → Set α}
variable
  (P : MultiradialSemanticPresentation
    Genuine Syntax genuineRegion syntaxRegion)

/-- Soundness gives inclusion of the genuine possible-image union in the
syntax union. -/
theorem genuineUnion_le_syntaxUnion :
    representedUnion genuineRegion ⊆ representedUnion syntaxRegion := by
  rintro x ⟨g, hx⟩
  exact ⟨P.encode g, P.encode_sound g hx⟩

/-- Completeness gives the reverse inclusion. -/
theorem syntaxUnion_le_genuineUnion :
    representedUnion syntaxRegion ⊆ representedUnion genuineRegion := by
  rintro x ⟨s, hx⟩
  exact ⟨P.decode s, P.decode_complete s hx⟩

/-- A sound and complete presentation identifies the full possible-image
unions exactly. -/
theorem representedUnion_eq :
    representedUnion genuineRegion = representedUnion syntaxRegion :=
  Set.Subset.antisymm
    P.genuineUnion_le_syntaxUnion P.syntaxUnion_le_genuineUnion

/-- A native region contained in the genuine output union is also contained in
the generated syntax union. -/
theorem native_le_syntaxUnion
    (native : Set α)
    (hnative : native ⊆ representedUnion genuineRegion) :
    native ⊆ representedUnion syntaxRegion :=
  hnative.trans P.genuineUnion_le_syntaxUnion

/-- An envelope proved for every generated syntax output also contains every
genuine output. -/
theorem genuineUnion_le_envelope
    (envelope : Set α)
    (henvelope : representedUnion syntaxRegion ⊆ envelope) :
    representedUnion genuineRegion ⊆ envelope :=
  P.genuineUnion_le_syntaxUnion.trans henvelope

/-- Conversely, an envelope for genuine outputs contains the syntax union by
completeness. -/
theorem syntaxUnion_le_envelope
    (envelope : Set α)
    (henvelope : representedUnion genuineRegion ⊆ envelope) :
    representedUnion syntaxRegion ⊆ envelope :=
  P.syntaxUnion_le_genuineUnion.trans henvelope

/-- Any extensional construction on sets takes the same value on the genuine
and generated possible-image unions. -/
theorem extensional_observable_eq
    {β : Type*} (observable : Set α → β) :
    observable (representedUnion genuineRegion) =
      observable (representedUnion syntaxRegion) := by
  rw [P.representedUnion_eq]

end MultiradialSemanticPresentation

/-- The common special case in which encoding and decoding preserve each
individual represented region exactly. -/
def MultiradialSemanticPresentation.ofRegionEqualities
    {α : Type u}
    {Genuine : Type v} {Syntax : Type w}
    {genuineRegion : Genuine → Set α}
    {syntaxRegion : Syntax → Set α}
    (encode : Genuine → Syntax)
    (hencode :
      ∀ g : Genuine, genuineRegion g = syntaxRegion (encode g))
    (decode : Syntax → Genuine)
    (hdecode :
      ∀ s : Syntax, syntaxRegion s = genuineRegion (decode s)) :
    MultiradialSemanticPresentation
      Genuine Syntax genuineRegion syntaxRegion where
  encode := encode
  encode_sound := fun g => (hencode g).le
  decode := decode
  decode_complete := fun s => (hdecode s).le

/-- A one-sided source theorem is enough for the lower-bound portion: if each
genuine output has a sound syntax representation, then a genuine native branch
is contained in the generated possible-image union. -/
theorem native_le_generated_of_sound_encoding
    {α : Type u}
    {Genuine : Type v} {Syntax : Type w}
    {genuineRegion : Genuine → Set α}
    {syntaxRegion : Syntax → Set α}
    (encode : Genuine → Syntax)
    (hsound :
      ∀ g : Genuine, genuineRegion g ⊆ syntaxRegion (encode g))
    (native : Set α)
    (hnative : native ⊆ representedUnion genuineRegion) :
    native ⊆ representedUnion syntaxRegion := by
  intro x hx
  rcases hnative hx with ⟨g, hg⟩
  exact ⟨encode g, hsound g hg⟩

/-- A one-sided completeness theorem is enough to transfer a generated
upper-envelope theorem back to every genuine output. -/
theorem genuine_le_envelope_of_sound_encoding
    {α : Type u}
    {Genuine : Type v} {Syntax : Type w}
    {genuineRegion : Genuine → Set α}
    {syntaxRegion : Syntax → Set α}
    (encode : Genuine → Syntax)
    (hsound :
      ∀ g : Genuine, genuineRegion g ⊆ syntaxRegion (encode g))
    (envelope : Set α)
    (hsyntax : representedUnion syntaxRegion ⊆ envelope) :
    representedUnion genuineRegion ⊆ envelope := by
  rintro x ⟨g, hg⟩
  exact hsyntax ⟨encode g, hsound g hg⟩

end IUTThreeClosures
