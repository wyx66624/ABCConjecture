/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TemperedCycleSkeleton

/-!
# The cyclic skeleton with one graph cusp

The skeleton of a punctured Tate curve is combinatorially a cycle with an
infinite ray attached at every vertex of the cyclic cover.  Translation by
`ZMod ell` moves the cycle label and preserves the ray depth.  The quotient is
therefore one loop with one infinite ray: the standard rank-one graph cusp.

This file proves that statement entirely, including the orbit classification
of vertices and oriented edges and the source/target maps on the quotient.
It is the graph-theoretic target of the remaining Berkovich/tempered comparison
theorem; no actual Berkovich skeleton or tempered fundamental group is assumed.
-/

namespace IUTThreeClosures

namespace CycleCuspGraph

/-- Vertices of the `ell`-fold cyclic cusp cover.  The first coordinate is the
cyclic label and the second is the distance along the attached ray. -/
abbrev Vertex (ell : ℕ) := ZMod ell × ℕ

/-- Oriented edges: cycle edges at depth zero and radial ray edges. -/
inductive Edge (ell : ℕ) where
  | core (label : ZMod ell)
  | ray (label : ZMod ell) (depth : ℕ)
  deriving DecidableEq

/-- Source of an oriented cover edge. -/
def edgeSource {ell : ℕ} : Edge ell → Vertex ell
  | .core a => (a, 0)
  | .ray a n => (a, n)

/-- Target of an oriented cover edge. -/
def edgeTarget {ell : ℕ} : Edge ell → Vertex ell
  | .core a => (a + 1, 0)
  | .ray a n => (a, n + 1)

/-- Translation deck action on vertices. -/
def shiftVertex {ell : ℕ} (g : ZMod ell) (v : Vertex ell) :
    Vertex ell :=
  (v.1 + g, v.2)

/-- Translation deck action on edges. -/
def shiftEdge {ell : ℕ} (g : ZMod ell) : Edge ell → Edge ell
  | .core a => .core (a + g)
  | .ray a n => .ray (a + g) n

@[simp]
theorem shiftVertex_zero {ell : ℕ} (v : Vertex ell) :
    shiftVertex 0 v = v := by
  cases v
  simp [shiftVertex]

@[simp]
theorem shiftVertex_add {ell : ℕ}
    (g h : ZMod ell) (v : Vertex ell) :
    shiftVertex g (shiftVertex h v) = shiftVertex (h + g) v := by
  cases v
  simp [shiftVertex, add_assoc]

@[simp]
theorem shiftEdge_zero {ell : ℕ} (e : Edge ell) :
    shiftEdge 0 e = e := by
  cases e <;> simp [shiftEdge]

@[simp]
theorem shiftEdge_add {ell : ℕ}
    (g h : ZMod ell) (e : Edge ell) :
    shiftEdge g (shiftEdge h e) = shiftEdge (h + g) e := by
  cases e <;> simp [shiftEdge, add_assoc]

/-- Source is equivariant for cyclic translation. -/
theorem edgeSource_shiftEdge {ell : ℕ}
    (g : ZMod ell) (e : Edge ell) :
    edgeSource (shiftEdge g e) = shiftVertex g (edgeSource e) := by
  cases e <;> simp [edgeSource, shiftEdge, shiftVertex]

/-- Target is equivariant for cyclic translation. -/
theorem edgeTarget_shiftEdge {ell : ℕ}
    (g : ZMod ell) (e : Edge ell) :
    edgeTarget (shiftEdge g e) = shiftVertex g (edgeTarget e) := by
  cases e <;> simp [edgeTarget, shiftEdge, shiftVertex, add_assoc, add_comm]

/-- Two vertices are in the same deck orbit exactly when they have the same
ray depth. -/
def vertexSetoid (ell : ℕ) : Setoid (Vertex ell) where
  r v w := v.2 = w.2
  iseqv := {
    refl := fun _ => rfl
    symm := fun h => h.symm
    trans := fun h₁ h₂ => h₁.trans h₂
  }

/-- Edge invariant retained by the quotient: `none` is the core-cycle edge and
`some n` is the ray edge from depth `n` to `n+1`. -/
def edgeClass {ell : ℕ} : Edge ell → Option ℕ
  | .core _ => none
  | .ray _ n => some n

/-- Two edges are in the same deck orbit exactly when their quotient edge
classes agree. -/
def edgeSetoid (ell : ℕ) : Setoid (Edge ell) where
  r e f := edgeClass e = edgeClass f
  iseqv := {
    refl := fun _ => rfl
    symm := fun h => h.symm
    trans := fun h₁ h₂ => h₁.trans h₂
  }

/-- The depth relation is precisely the translation-orbit relation. -/
theorem vertex_related_iff_exists_shift {ell : ℕ}
    (v w : Vertex ell) :
    (vertexSetoid ell).r v w ↔
      ∃ g : ZMod ell, shiftVertex g v = w := by
  constructor
  · intro h
    refine ⟨w.1 - v.1, ?_⟩
    apply Prod.ext
    · simp [shiftVertex]
    · simpa [shiftVertex] using h
  · rintro ⟨g, rfl⟩
    rfl

/-- The edge-class relation is precisely the translation-orbit relation. -/
theorem edge_related_iff_exists_shift {ell : ℕ}
    (e f : Edge ell) :
    (edgeSetoid ell).r e f ↔
      ∃ g : ZMod ell, shiftEdge g e = f := by
  constructor
  · intro h
    cases e with
    | core a =>
        cases f with
        | core b =>
            refine ⟨b - a, ?_⟩
            simp [shiftEdge]
        | ray b n =>
            simp [edgeClass] at h
    | ray a n =>
        cases f with
        | core b =>
            simp [edgeClass] at h
        | ray b m =>
            simp [edgeClass] at h
            subst m
            refine ⟨b - a, ?_⟩
            simp [shiftEdge]
  · rintro ⟨g, rfl⟩
    cases e <;> rfl

/-- Vertex orbits of the cyclic cusp cover. -/
abbrev VertexClasses (ell : ℕ) := Quotient (vertexSetoid ell)

/-- Edge orbits of the cyclic cusp cover. -/
abbrev EdgeClasses (ell : ℕ) := Quotient (edgeSetoid ell)

/-- A vertex orbit remembers exactly its ray depth. -/
def vertexClassesToDepth {ell : ℕ} : VertexClasses ell → ℕ :=
  Quotient.lift Prod.snd (fun _ _ h => h)

/-- Canonical vertex at a given quotient depth. -/
def depthToVertexClasses (ell : ℕ) (n : ℕ) : VertexClasses ell :=
  Quotient.mk (vertexSetoid ell) ((0 : ZMod ell), n)

@[simp]
theorem vertexClassesToDepth_depthToVertexClasses
    (ell n : ℕ) :
    vertexClassesToDepth (depthToVertexClasses ell n) = n :=
  rfl

/-- The quotient vertices are canonically the natural-number ray. -/
def vertexClassesEquivDepth (ell : ℕ) : VertexClasses ell ≃ ℕ where
  toFun := vertexClassesToDepth
  invFun := depthToVertexClasses ell
  left_inv := by
    intro q
    refine Quotient.inductionOn q ?_
    intro v
    apply Quotient.sound
    rfl
  right_inv := vertexClassesToDepth_depthToVertexClasses ell

/-- An edge orbit remembers exactly whether it is the core loop or a ray edge
and, in the latter case, its depth. -/
def edgeClassesToClass {ell : ℕ} : EdgeClasses ell → Option ℕ :=
  Quotient.lift edgeClass (fun _ _ h => h)

/-- Canonical representative of a quotient edge. -/
def classToEdgeClasses (ell : ℕ) : Option ℕ → EdgeClasses ell
  | none => Quotient.mk (edgeSetoid ell) (.core 0)
  | some n => Quotient.mk (edgeSetoid ell) (.ray 0 n)

@[simp]
theorem edgeClassesToClass_classToEdgeClasses
    (ell : ℕ) (c : Option ℕ) :
    edgeClassesToClass (classToEdgeClasses ell c) = c := by
  cases c <;> rfl

/-- Quotient edges are one distinguished loop together with one ray edge at
each natural depth. -/
def edgeClassesEquivClass (ell : ℕ) : EdgeClasses ell ≃ Option ℕ where
  toFun := edgeClassesToClass
  invFun := classToEdgeClasses ell
  left_inv := by
    intro q
    refine Quotient.inductionOn q ?_
    intro e
    apply Quotient.sound
    cases e <;> rfl
  right_inv := edgeClassesToClass_classToEdgeClasses ell

/-- Source depth in the quotient graph. -/
def quotientSource : Option ℕ → ℕ
  | none => 0
  | some n => n

/-- Target depth in the quotient graph.  The core class is a loop. -/
def quotientTarget : Option ℕ → ℕ
  | none => 0
  | some n => n + 1

/-- The source map descends to the advertised quotient graph. -/
theorem quotient_source_formula {ell : ℕ} (e : Edge ell) :
    vertexClassesEquivDepth ell
        (Quotient.mk (vertexSetoid ell) (edgeSource e)) =
      quotientSource
        (edgeClassesEquivClass ell
          (Quotient.mk (edgeSetoid ell) e)) := by
  cases e <;> rfl

/-- The target map descends to the advertised quotient graph. -/
theorem quotient_target_formula {ell : ℕ} (e : Edge ell) :
    vertexClassesEquivDepth ell
        (Quotient.mk (vertexSetoid ell) (edgeTarget e)) =
      quotientTarget
        (edgeClassesEquivClass ell
          (Quotient.mk (edgeSetoid ell) e)) := by
  cases e <;> simp [edgeTarget, vertexClassesEquivDepth,
    vertexClassesToDepth, edgeClassesEquivClass,
    edgeClassesToClass, quotientTarget]

/-- The distinguished quotient edge is a loop at the core vertex. -/
theorem core_loop_formula :
    quotientSource none = 0 ∧ quotientTarget none = 0 := by
  constructor <;> rfl

/-- Every other quotient edge is the next edge of the infinite cusp ray. -/
theorem cusp_ray_formula (n : ℕ) :
    quotientSource (some n) = n ∧
      quotientTarget (some n) = n + 1 := by
  constructor <;> rfl

/-- The canonical deck generator translates the cycle label by one and fixes
ray depth. -/
def generatorVertex {ell : ℕ} : Vertex ell → Vertex ell :=
  shiftVertex 1

/-- The canonical deck generator on oriented edges. -/
def generatorEdge {ell : ℕ} : Edge ell → Edge ell :=
  shiftEdge 1

@[simp]
theorem generatorVertex_depth {ell : ℕ} (v : Vertex ell) :
    (generatorVertex v).2 = v.2 :=
  rfl

@[simp]
theorem generatorEdge_class {ell : ℕ} (e : Edge ell) :
    edgeClass (generatorEdge e) = edgeClass e := by
  cases e <;> rfl

end CycleCuspGraph

end IUTThreeClosures
