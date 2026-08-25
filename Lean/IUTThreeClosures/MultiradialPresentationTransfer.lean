/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Semantic transfer for a genuine multiradial presentation

The existing downstream development works with a generated Ind1/Ind2/Ind3
syntax. The genuine source theorem, however, is naturally stated using
Hodge-theater, log-Kummer and Frobenioid objects. These two output types need
not be definitionally equal. What is required is a semantics-preserving
presentation theorem.

This module isolates the exact set-theoretic bridge. A genuine output family
`genuineRegion : Genuine → Set α` and a generated family
`syntaxRegion : Syntax → Set α` describe the same possible-image union when
there are maps in both directions whose represented regions are included in
the corresponding target regions. Equality of individual represented regions
is a convenient stronger specialization.
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

/-- A semantic presentation of genuine outputs by a generated syntax. -/
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

/-- Soundness gives inclusion of the genuine possible-image union in the
syntax union. -/
theorem genuineUnion_le_syntaxUnion
    (P : MultiradialSemanticPresentation
      Genuine Syntax genuineRegion syntaxRegion) :
    representedUnion genuineRegion ⊆ representedUnion syntaxRegion := by
  intro x hx
  rcases mem_representedUnion.mp hx with ⟨g, hg⟩
  exact mem_representedUnion.mpr
    ⟨P.encode g, P.encode_sound g hg⟩

/-- Completeness gives the reverse inclusion. -/
theorem syntaxUnion_le_genuineUnion
    (P : MultiradialSemanticPresentation
      Genuine Syntax genuineRegion syntaxRegion) :
    representedUnion syntaxRegion ⊆ representedUnion genuineRegion := by
  intro x hx
  rcases mem_representedUnion.mp hx with ⟨s, hs⟩
  exact mem_representedUnion.mpr
    ⟨P.decode s, P.decode_complete s hs⟩

/-- A sound and complete presentation identifies the full possible-image
unions exactly. -/
theorem representedUnion_eq
    (P : MultiradialSemanticPresentation
      Genuine Syntax genuineRegion syntaxRegion) :
    representedUnion genuineRegion = representedUnion syntaxRegion :=
  Set.Subset.antisymm
    (genuineUnion_le_syntaxUnion P)
    (syntaxUnion_le_genuineUnion P)

/-- A native region contained in the genuine output union is also contained in
the generated syntax union. -/
theorem native_le_syntaxUnion
    (P : MultiradialSemanticPresentation
      Genuine Syntax genuineRegion syntaxRegion)
    (native : Set α)
    (hnative : native ⊆ representedUnion genuineRegion) :
    native ⊆ representedUnion syntaxRegion :=
  hnative.trans (genuineUnion_le_syntaxUnion P)

/-- An envelope proved for every generated syntax output also contains every
genuine output. -/
theorem genuineUnion_le_envelope
    (P : MultiradialSemanticPresentation
      Genuine Syntax genuineRegion syntaxRegion)
    (envelope : Set α)
    (henvelope : representedUnion syntaxRegion ⊆ envelope) :
    representedUnion genuineRegion ⊆ envelope :=
  (genuineUnion_le_syntaxUnion P).trans henvelope

/-- Conversely, an envelope for genuine outputs contains the syntax union by
completeness. -/
theorem syntaxUnion_le_envelope
    (P : MultiradialSemanticPresentation
      Genuine Syntax genuineRegion syntaxRegion)
    (envelope : Set α)
    (henvelope : representedUnion genuineRegion ⊆ envelope) :
    representedUnion syntaxRegion ⊆ envelope :=
  (syntaxUnion_le_genuineUnion P).trans henvelope

/-- Any extensional construction on sets takes the same value on the genuine
and generated possible-image unions. -/
theorem extensional_observable_eq
    (P : MultiradialSemanticPresentation
      Genuine Syntax genuineRegion syntaxRegion)
    {β : Type*} (observable : Set α → β) :
    observable (representedUnion genuineRegion) =
      observable (representedUnion syntaxRegion) := by
  rw [representedUnion_eq P]

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
  encode_sound := by
    intro g x hx
    rw [← hencode g]
    exact hx
  decode := decode
  decode_complete := by
    intro s x hx
    rw [← hdecode s]
    exact hx

/-- A one-sided source theorem is enough for the lower-bound portion. -/
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
  rcases mem_representedUnion.mp (hnative hx) with ⟨g, hg⟩
  exact mem_representedUnion.mpr ⟨encode g, hsound g hg⟩

/-- A one-sided soundness theorem transfers a syntax upper envelope back to
all genuine outputs. -/
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
  intro x hx
  rcases mem_representedUnion.mp hx with ⟨g, hg⟩
  exact hsyntax (mem_representedUnion.mpr
    ⟨encode g, hsound g hg⟩)

end IUTThreeClosures
