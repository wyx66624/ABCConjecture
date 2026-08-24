/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TemperedCycleSkeletonBridge

/-!
# A cyclic Tate-skeleton graph with its complete cusp orbit

The finite skeleton of an `ell`-sheeted punctured Tate cover consists of a
cyclic core together with one lifted cusp on each sheet.  The residual deck
group translates both the core labels and the cusp labels by `ZMod ell`.

This module constructs that combinatorial model explicitly.  It proves that

* the deck action preserves core edges and cusp spokes;
* the action on the lifted cusps is free and transitive;
* the quotient has exactly one core-vertex type and one cusp-vertex type;
* translation by one is the canonical graph-cusp deck generator;
* any quotient identified with the oriented cycle deck group inherits the
  same `ZMod ell` coordinate and canonical nonzero generator.

This closes the finite graph/cusp algebra.  A genuine tempered comparison must
still identify the Berkovich skeleton and its cuspidal ends with this model.
-/

namespace IUTThreeClosures

universe u

/-- Vertices of the compactified cyclic Tate skeleton: one core vertex and one
cusp vertex on every residual sheet. -/
inductive TateCycleCuspVertex (ell : ℕ) where
  | core : ZMod ell → TateCycleCuspVertex ell
  | cusp : ZMod ell → TateCycleCuspVertex ell
  deriving DecidableEq

/-- Oriented edges: cyclic core edges and the spokes to the compactified cusp
vertices. -/
inductive TateCycleCuspEdge (ell : ℕ) where
  | cycle : ZMod ell → TateCycleCuspEdge ell
  | spoke : ZMod ell → TateCycleCuspEdge ell
  deriving DecidableEq

namespace TateCycleCuspGraph

variable (ell : ℕ)

/-- Source of an oriented graph edge. -/
def source : TateCycleCuspEdge ell → TateCycleCuspVertex ell
  | .cycle i => .core i
  | .spoke i => .core i

/-- Target of an oriented graph edge. -/
def target : TateCycleCuspEdge ell → TateCycleCuspVertex ell
  | .cycle i => .core (i + 1)
  | .spoke i => .cusp i

/-- Translation by a residual deck label on vertices. -/
def vertexTranslate (k : ZMod ell) :
    TateCycleCuspVertex ell → TateCycleCuspVertex ell
  | .core i => .core (i + k)
  | .cusp i => .cusp (i + k)

/-- Translation by a residual deck label on edges. -/
def edgeTranslate (k : ZMod ell) :
    TateCycleCuspEdge ell → TateCycleCuspEdge ell
  | .cycle i => .cycle (i + k)
  | .spoke i => .spoke (i + k)

@[simp]
theorem vertexTranslate_zero (v : TateCycleCuspVertex ell) :
    vertexTranslate ell 0 v = v := by
  cases v <;> simp [vertexTranslate]

@[simp]
theorem edgeTranslate_zero (e : TateCycleCuspEdge ell) :
    edgeTranslate ell 0 e = e := by
  cases e <;> simp [edgeTranslate]

/-- Vertex translations compose additively. -/
theorem vertexTranslate_add
    (a b : ZMod ell) (v : TateCycleCuspVertex ell) :
    vertexTranslate ell a (vertexTranslate ell b v) =
      vertexTranslate ell (b + a) v := by
  cases v <;> simp [vertexTranslate, add_assoc]

/-- Edge translations compose additively. -/
theorem edgeTranslate_add
    (a b : ZMod ell) (e : TateCycleCuspEdge ell) :
    edgeTranslate ell a (edgeTranslate ell b e) =
      edgeTranslate ell (b + a) e := by
  cases e <;> simp [edgeTranslate, add_assoc]

/-- Translation commutes with the source map. -/
theorem source_edgeTranslate
    (k : ZMod ell) (e : TateCycleCuspEdge ell) :
    source ell (edgeTranslate ell k e) =
      vertexTranslate ell k (source ell e) := by
  cases e <;> simp [source, edgeTranslate, vertexTranslate]

/-- Translation commutes with the target map. -/
theorem target_edgeTranslate
    (k : ZMod ell) (e : TateCycleCuspEdge ell) :
    target ell (edgeTranslate ell k e) =
      vertexTranslate ell k (target ell e) := by
  cases e <;> simp [target, edgeTranslate, vertexTranslate,
    add_assoc, add_comm, add_left_comm]

/-- The lifted cusp labelled by `i`. -/
def cuspVertex (i : ZMod ell) : TateCycleCuspVertex ell :=
  .cusp i

/-- Deck translation acts on the complete cusp orbit by addition. -/
@[simp]
theorem vertexTranslate_cuspVertex
    (k i : ZMod ell) :
    vertexTranslate ell k (cuspVertex ell i) =
      cuspVertex ell (i + k) :=
  rfl

/-- The deck action on lifted cusps is transitive. -/
theorem cusp_action_transitive
    (i j : ZMod ell) :
    ∃ k : ZMod ell,
      vertexTranslate ell k (cuspVertex ell i) =
        cuspVertex ell j := by
  refine ⟨j - i, ?_⟩
  simp [sub_eq_add_neg, add_assoc, add_comm, add_left_comm]

/-- The deck action on lifted cusps is free. -/
theorem cusp_action_free
    (i k : ZMod ell)
    (h : vertexTranslate ell k (cuspVertex ell i) =
      cuspVertex ell i) :
    k = 0 := by
  injection h with hlabel
  exact add_left_cancel hlabel

/-- Core/cusp vertex type in the quotient graph. -/
def vertexType : TateCycleCuspVertex ell → Bool
  | .core _ => false
  | .cusp _ => true

/-- Core/spoke edge type in the quotient graph. -/
def edgeType : TateCycleCuspEdge ell → Bool
  | .cycle _ => false
  | .spoke _ => true

/-- Vertex type is invariant under every deck translation. -/
theorem vertexType_translate
    (k : ZMod ell) (v : TateCycleCuspVertex ell) :
    vertexType ell (vertexTranslate ell k v) = vertexType ell v := by
  cases v <;> rfl

/-- Edge type is invariant under every deck translation. -/
theorem edgeType_translate
    (k : ZMod ell) (e : TateCycleCuspEdge ell) :
    edgeType ell (edgeTranslate ell k e) = edgeType ell e := by
  cases e <;> rfl

/-- Any two core vertices lie in the same deck orbit. -/
theorem core_vertices_same_orbit
    (i j : ZMod ell) :
    ∃ k : ZMod ell,
      vertexTranslate ell k (.core i) = .core j := by
  refine ⟨j - i, ?_⟩
  simp [vertexTranslate, sub_eq_add_neg,
    add_assoc, add_comm, add_left_comm]

/-- Any two cusp vertices lie in the same deck orbit. -/
theorem cusp_vertices_same_orbit
    (i j : ZMod ell) :
    ∃ k : ZMod ell,
      vertexTranslate ell k (.cusp i) = .cusp j :=
  cusp_action_transitive ell i j

/-- A core vertex can never lie in a cusp orbit. -/
theorem core_ne_cusp
    (i j : ZMod ell) :
    (TateCycleCuspVertex.core i : TateCycleCuspVertex ell) ≠ .cusp j := by
  intro h
  cases h

/-- The canonical one-step graph deck transformation on vertices. -/
def canonicalVertexDeck :
    TateCycleCuspVertex ell → TateCycleCuspVertex ell :=
  vertexTranslate ell 1

/-- The canonical one-step graph deck transformation on edges. -/
def canonicalEdgeDeck :
    TateCycleCuspEdge ell → TateCycleCuspEdge ell :=
  edgeTranslate ell 1

/-- For prime `ell`, the canonical deck transformation moves every cusp. -/
theorem canonicalVertexDeck_moves_cusp
    (hell : ell.Prime) (i : ZMod ell) :
    canonicalVertexDeck ell (cuspVertex ell i) ≠
      cuspVertex ell i := by
  intro h
  have hk := cusp_action_free ell i 1 h
  letI : NeZero ell := ⟨hell.ne_zero⟩
  exact one_ne_zero hk

/-- A source-facing bridge from an actual tempered quotient to the graph
model.  Once the quotient is identified with oriented cycle deck
transformations, the canonical graph-cusp generator has coordinate one. -/
theorem actualQuotient_canonicalGraphCusp_coordinate
    {Q : Type u}
    (skeletonEquiv : Q ≃ OrientedCycleDeck ell) :
    rankOneQuotientEquivZMod skeletonEquiv
        (canonicalSkeletonQuotientElement skeletonEquiv) = 1 :=
  canonicalSkeletonQuotientElement_coordinate skeletonEquiv

end TateCycleCuspGraph

end IUTThreeClosures
