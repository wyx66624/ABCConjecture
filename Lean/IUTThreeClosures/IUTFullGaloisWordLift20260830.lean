/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.GroupTheory.FreeGroup.Basic
import Mathlib.Tactic.Group

/-!
# The cross-handle word automorphism

The mathematical proofs precede this file in
`research/JW_CROSS_HANDLE_AUTOMORPHISM_CROSS_REVIEW_2026_08_30.md`,
Sections 2--5, and
`research/IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md`, Sections 3--4.

This file proves the two-sided substitution identities in every group,
exact preservation of the ordered product `[a,b] * [c,d]`, and the action
on every commutative group image. It then constructs an actual
automorphism of the discrete free group on four generators.

The passage through the relative profinite presentation of
Jannsen--Wingberg, the maximal-pro-p condition on its wild normal subgroup,
local class field theory, logarithmic lattices, and the absolute Galois
group interpretation remain mathematical source arguments in the reports.
No such interpretation is declared as an axiom or as a Lean conclusion.
-/

namespace IUTThreeClosures.IUTFullGaloisWordLift20260830

universe u v

/-- Four group elements on which the word substitutions are evaluated. -/
@[ext]
structure Frame (G : Type u) where
  a : G
  b : G
  c : G
  d : G

variable {G : Type u} [Group G]

/-- The convention in the original Jannsen--Wingberg presentation. -/
def wordCommutator (a b : G) : G := a * b * a⁻¹ * b⁻¹

/-- The ordered boundary word, not just its conjugacy class. -/
def boundary (q : Frame G) : G :=
  wordCommutator q.a q.b * wordCommutator q.c q.d

/-- The auxiliary word `r = b a b⁻¹`. -/
def innerWord (q : Frame G) : G := q.b * q.a * q.b⁻¹

/-- The auxiliary word `z = d r d⁻¹`. -/
def outerWord (q : Frame G) : G := q.d * innerWord q * q.d⁻¹

/-- The final cross-handle substitution, with no commutativity assumption. -/
def forward (q : Frame G) : Frame G where
  a := q.a
  b := q.d * q.b
  c := outerWord q * (innerWord q)⁻¹ * q.c * (outerWord q)⁻¹
  d := outerWord q * q.d * (outerWord q)⁻¹

/-- The inverse word substitution. -/
def backward (q : Frame G) : Frame G where
  a := q.a
  b := (innerWord q)⁻¹ * q.d⁻¹ * innerWord q * q.b
  c := (innerWord q)⁻¹ * q.d⁻¹ * innerWord q * q.d * q.c * innerWord q
  d := (innerWord q)⁻¹ * q.d * innerWord q

/-- The special generator is fixed literally. -/
@[simp]
theorem forward_a (q : Frame G) : (forward q).a = q.a := rfl

/-- The inverse also fixes the special generator literally. -/
@[simp]
theorem backward_a (q : Frame G) : (backward q).a = q.a := rfl

/-- One order of the two substitutions is the identity in every group. -/
theorem forward_backward (q : Frame G) : forward (backward q) = q := by
  ext <;> dsimp [forward, backward, innerWord, outerWord] <;> group

/-- The opposite order is also the identity in every group. -/
theorem backward_forward (q : Frame G) : backward (forward q) = q := by
  ext <;> dsimp [forward, backward, innerWord, outerWord] <;> group

/-- The ordered surface word is fixed exactly in every group. -/
theorem forward_boundary (q : Frame G) : boundary (forward q) = boundary q := by
  dsimp [boundary, wordCommutator, forward, innerWord, outerWord]
  group

/-- The inverse fixes the same ordered word exactly. -/
theorem backward_boundary (q : Frame G) : boundary (backward q) = boundary q := by
  have h := forward_boundary (backward q)
  rw [forward_backward] at h
  exact h.symm

/-- The two substitutions give a bijection on four-tuples.
This is not a claim that the map is a homomorphism for coordinatewise multiplication. -/
def frameEquiv : Frame G ≃ Frame G where
  toFun := forward
  invFun := backward
  left_inv := backward_forward
  right_inv := forward_backward

variable {H : Type v} [Group H]

/-- Apply a group homomorphism to each coordinate. -/
def mapFrame (φ : G →* H) (q : Frame G) : Frame H where
  a := φ q.a
  b := φ q.b
  c := φ q.c
  d := φ q.d

/-- Evaluation of the forward words commutes with every group homomorphism. -/
theorem map_forward (φ : G →* H) (q : Frame G) :
    mapFrame φ (forward q) = forward (mapFrame φ q) := by
  ext <;> simp [mapFrame, forward, innerWord, outerWord]

/-- Evaluation of the inverse words also commutes with every group homomorphism. -/
theorem map_backward (φ : G →* H) (q : Frame G) :
    mapFrame φ (backward q) = backward (mapFrame φ q) := by
  ext <;> simp [mapFrame, backward, innerWord]

/-- The boundary word is natural under group homomorphisms. -/
theorem map_boundary (φ : G →* H) (q : Frame G) :
    φ (boundary q) = boundary (mapFrame φ q) := by
  simp [boundary, wordCommutator, mapFrame]

section CommutativeImage

variable {A : Type v} [CommGroup A]

/-- In a commutative group the action is the stated cross-handle shear. -/
theorem commutative_forward (q : Frame A) :
    forward q = ⟨q.a, q.b * q.d, q.c * q.a⁻¹, q.d⟩ := by
  ext <;> simp [forward, innerWord, outerWord, mul_comm, mul_assoc]

/-- Every abelian image sends `b` to `b*d` and `c` to `c*a⁻¹`, fixing `a,d`.
In additive notation these are `b ↦ b + d` and `c ↦ c - a`. -/
theorem abelian_image (φ : G →* A) (q : Frame G) :
    mapFrame φ (forward q) =
      ⟨φ q.a, φ q.b * φ q.d, φ q.c * (φ q.a)⁻¹, φ q.d⟩ := by
  rw [map_forward, commutative_forward]
  rfl

end CommutativeImage

/-- The four free generators. -/
inductive Letter
  | a
  | b
  | c
  | d
  deriving DecidableEq

/-- Read the coordinate of a frame indicated by a free generator. -/
def evaluate (q : Frame G) : Letter → G
  | .a => q.a
  | .b => q.b
  | .c => q.c
  | .d => q.d

/-- Coordinate evaluation commutes with a group homomorphism. -/
theorem evaluate_map (φ : G →* H) (q : Frame G) (i : Letter) :
    evaluate (mapFrame φ q) i = φ (evaluate q i) := by
  cases i <;> rfl

/-- The frame of canonical generators in the discrete free group. -/
def generators : Frame (FreeGroup Letter) :=
  ⟨FreeGroup.of .a, FreeGroup.of .b, FreeGroup.of .c, FreeGroup.of .d⟩

/-- Evaluating this frame gives the canonical generator injection. -/
@[simp]
theorem evaluate_generators (i : Letter) :
    evaluate generators i = FreeGroup.of i := by
  cases i <;> rfl

/-- The homomorphism defined by the forward words on free generators. -/
def forwardHom : FreeGroup Letter →* FreeGroup Letter :=
  FreeGroup.lift (evaluate (forward generators))

/-- The homomorphism defined by the inverse words on free generators. -/
def backwardHom : FreeGroup Letter →* FreeGroup Letter :=
  FreeGroup.lift (evaluate (backward generators))

/-- The universal forward homomorphism takes the generator frame to the forward frame. -/
theorem forwardHom_generators : mapFrame forwardHom generators = forward generators := by
  ext <;> simp [mapFrame, generators, forwardHom, evaluate]

/-- The universal inverse homomorphism takes the generator frame to the inverse frame. -/
theorem backwardHom_generators : mapFrame backwardHom generators = backward generators := by
  ext <;> simp [mapFrame, generators, backwardHom, evaluate]

/-- The two homomorphisms are inverse on the entire free group, in one order. -/
theorem backwardHom_comp_forwardHom :
    backwardHom.comp forwardHom = MonoidHom.id (FreeGroup Letter) := by
  have h : mapFrame backwardHom (forward generators) = generators := by
    rw [map_forward, backwardHom_generators, forward_backward]
  apply FreeGroup.ext_hom
  intro i
  have hi := congrArg (fun q => evaluate q i) h
  simpa [evaluate_map, forwardHom] using hi

/-- The opposite composition is the identity on the entire free group. -/
theorem forwardHom_comp_backwardHom :
    forwardHom.comp backwardHom = MonoidHom.id (FreeGroup Letter) := by
  have h : mapFrame forwardHom (backward generators) = generators := by
    rw [map_backward, forwardHom_generators, backward_forward]
  apply FreeGroup.ext_hom
  intro i
  have hi := congrArg (fun q => evaluate q i) h
  simpa [evaluate_map, backwardHom] using hi

/-- An actual group automorphism, constructed from the two proved homomorphisms. -/
def crossHandleAut : FreeGroup Letter ≃* FreeGroup Letter where
  toFun := forwardHom
  invFun := backwardHom
  left_inv x := DFunLike.congr_fun backwardHom_comp_forwardHom x
  right_inv x := DFunLike.congr_fun forwardHom_comp_backwardHom x
  map_mul' := forwardHom.map_mul

/-- The actual free-group automorphism fixes its distinguished generator exactly. -/
theorem crossHandleAut_fixes_first :
    crossHandleAut (FreeGroup.of .a) = FreeGroup.of .a := by
  simp [crossHandleAut, forwardHom, evaluate, forward, generators]

/-- The actual free-group automorphism fixes the full ordered boundary word exactly. -/
theorem crossHandleAut_fixes_boundary :
    crossHandleAut (boundary generators) = boundary generators := by
  change forwardHom (boundary generators) = boundary generators
  rw [map_boundary, forwardHom_generators, forward_boundary]

/-- The full free-group automorphism has the specified image under every abelian character. -/
theorem crossHandleAut_abelian_image {A : Type v} [CommGroup A]
    (φ : FreeGroup Letter →* A) :
    mapFrame φ (mapFrame crossHandleAut.toMonoidHom generators) =
      ⟨φ (FreeGroup.of .a), φ (FreeGroup.of .b) * φ (FreeGroup.of .d),
        φ (FreeGroup.of .c) * (φ (FreeGroup.of .a))⁻¹, φ (FreeGroup.of .d)⟩ := by
  change mapFrame φ (mapFrame forwardHom generators) = _
  rw [forwardHom_generators]
  exact abelian_image φ generators

end IUTThreeClosures.IUTFullGaloisWordLift20260830
