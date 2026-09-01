/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.LinearAlgebra.Pi
import Mathlib.LinearAlgebra.Span.Basic

/-!
# Changing the target of a coherent all-isomorphism collation

The mathematical proof precedes this file in
`research/IUT_MIXED_WEIGHT_CONTINUATION_2026_08_30.md`, Theorem 4.1 and
Corollary 4.2.

A configuration has a source label at each slot, and a class in the module
belonging to that label. One family of isomorphisms is used for the whole
configuration: repeated source labels necessarily use the same map.

Postcomposition with a target equivalence is a bijection on such families.
The resulting equality is about the entire collated set, not merely one
chosen point. A source reindexing is separately proved harmless when its
label and class data are both pulled back.

The scope is the linear algebra of this construction. This module does not
assert that an arbitrary Frobenius operation preserves the source classes,
does not identify convex and holomorphic hulls, and does not formalize Haar
normalizations, the local Frey example, any IUT conclusion, or ABC.
-/

namespace IUTThreeClosures.IUTTargetReset20260830

universe uR uY uM uG uA uU uV

variable {R : Type uR} [Semiring R]
variable {Y : Type uY} {M : Y → Type uM}
variable [∀ y, AddCommMonoid (M y)] [∀ y, Module R (M y)]
variable {G : Type uG} {A : Type uA}

/-- The same map is used at every occurrence of a source label. All source
configurations and all such isomorphism families are included. -/
def coherentCollation (label : G → A → Y)
    (classes : ∀ g a, M (label g a)) (U : Type uU)
    [AddCommMonoid U] [Module R U] : Set (A → U) :=
  {v | ∃ g, ∃ f : ∀ y, M y ≃ₗ[R] U,
    v = fun a => f (label g a) (classes g a)}

variable {U : Type uU} [AddCommMonoid U] [Module R U]
variable {V : Type uV} [AddCommMonoid V] [Module R V]

/-- Postcomposition transports the full collated set to the new target. -/
theorem image_coherentCollation (label : G → A → Y)
    (classes : ∀ g a, M (label g a)) (c : U ≃ₗ[R] V) :
    (fun v : A → U => fun a => c (v a)) ''
        coherentCollation (R := R) label classes U =
      coherentCollation (R := R) label classes V := by
  ext v
  constructor
  · rintro ⟨u, ⟨g, f, rfl⟩, rfl⟩
    exact ⟨g, fun y => (f y).trans c, rfl⟩
  · rintro ⟨g, f, rfl⟩
    refine ⟨fun a => c.symm (f (label g a) (classes g a)), ?_, ?_⟩
    · exact ⟨g, fun y => (f y).trans c.symm, rfl⟩
    · funext a
      exact c.apply_symm_apply _

/-- Transport also commutes with the ordinary module span of the output.
This does not equate that span with any analytic or holomorphic hull. -/
theorem map_span_coherentCollation (label : G → A → Y)
    (classes : ∀ g a, M (label g a)) (c : U ≃ₗ[R] V) :
    (Submodule.span R (coherentCollation (R := R) label classes U)).map
        (LinearEquiv.piCongrRight (fun _ : A => c)).toLinearMap =
      Submodule.span R (coherentCollation (R := R) label classes V) := by
  rw [Submodule.map_span]
  congr 1
  exact image_coherentCollation label classes c

/-- Relabelling configurations does not change the output when both the
source-label map and the classes are pulled back along the bijection. -/
theorem coherentCollation_reindex {G' : Type*} (e : G' ≃ G)
    (label : G → A → Y) (classes : ∀ g a, M (label g a)) :
    coherentCollation (R := R) (fun g' a => label (e g') a)
        (fun g' a => classes (e g') a) U =
      coherentCollation (R := R) label classes U := by
  ext v
  constructor
  · rintro ⟨g', f, h⟩
    exact ⟨e g', f, h⟩
  · rintro ⟨g, f, h⟩
    obtain ⟨g', rfl⟩ := e.surjective g
    exact ⟨g', f, h⟩

end IUTThreeClosures.IUTTargetReset20260830
