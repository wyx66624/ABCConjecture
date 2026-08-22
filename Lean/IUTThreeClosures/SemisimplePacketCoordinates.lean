/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.RingTheory.Etale.Field
import Iut.Cor312.PacketPresentation

/-!
# Correct semisimple coordinates for tensor packets

A tensor product of finite separable local fields is a finite etale algebra over
the rational local base field. It need not itself be a field. Consequently a
packet presentation indexed only by a tuple of places is, in general, too
coarse: every tuple must be refined by a maximal ideal (equivalently, a
primitive field factor) of the corresponding finite etale tensor algebra.

For a finite etale `k`-algebra `A`, the canonical Artinian decomposition is

`A ≃ₐ[k] ∀ m : MaximalSpectrum A, A ⧸ m.asIdeal`.

This module packages that decomposition and the corrected sigma-type of packet
components. It also proves the elementary obstruction behind the correction:
a product of two nontrivial fields cannot be ring-equivalent to one field.
Thus a split tensor algebra cannot be represented by one field summand attached
only to its place tuple.

Topologies, valuation rings, local norms and Haar measures are deliberately not
invented here. They belong on the refined residue-field factors and must be
transported by the actual local-field decomposition.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

universe u v w

section FiniteEtale

variable (k : Type u) [Field k]
variable (A : Type v) [CommRing A] [Algebra k A]
variable [Module.Finite k A] [Algebra.Etale k A]

/-- A finite etale algebra over a field is canonically a finite product of its
field quotients at maximal ideals. -/
noncomputable def finiteEtaleSemisimpleEquiv :
    A ≃ₐ[k] ∀ m : MaximalSpectrum A, A ⧸ m.asIdeal := by
  letI : IsArtinianRing A := .of_finite k A
  letI : IsReduced A :=
    Algebra.FormallyUnramified.isReduced_of_field k A
  exact (IsArtinianRing.equivPi A).restrictScalars k

/-- The maximal-factor index of a finite etale algebra is finite. -/
noncomputable instance finiteMaximalSpectrum :
    Finite (MaximalSpectrum A) := by
  letI : IsArtinianRing A := .of_finite k A
  infer_instance

end FiniteEtale

section Obstruction

variable (K L : Type*) [Field K] [Field L]

/-- A product of two nontrivial fields is not ring-equivalent to one field.
The element `(1, 0)` is a nontrivial idempotent, whereas a field has no such
idempotent. -/
theorem no_ringEquiv_prod_field :
    IsEmpty ((K × K) ≃+* L) := by
  refine ⟨fun e => ?_⟩
  let a : K × K := (1, 0)
  have ha_mul : a * a = a := by
    ext <;> simp [a]
  have he_mul : e a * e a = e a := by
    simpa using congrArg e ha_mul
  have hfactor : e a * (e a - 1) = 0 := by
    rw [mul_sub, mul_one, he_mul, sub_self]
  rcases mul_eq_zero.mp hfactor with hzero | hone
  · have ha0 : a = 0 := e.injective (by simpa using hzero)
    have hfst := congrArg Prod.fst ha0
    simpa [a] using hfst
  · have hea1 : e a = 1 := sub_eq_zero.mp hone
    have ha1 : a = 1 := e.injective (by simpa using hea1)
    have hsnd := congrArg Prod.snd ha1
    simpa [a] using hsnd

end Obstruction

/-- Tuple-indexed finite etale tensor algebras before their primitive field
factors are separated. In the intended application, `Tuple` is the type of
place-tuples and `AlgebraAt c` is the iterated tensor product of the local
fields selected by `c`. -/
structure TupleFiniteEtalePacket
    (k : Type u) [Field k] (Tuple : Type v) : Type (max (u + 1) (v + 1) (w + 1)) where
  AlgebraAt : Tuple → Type w
  [commRing_algebraAt : ∀ c, CommRing (AlgebraAt c)]
  [algebra_algebraAt : ∀ c, Algebra k (AlgebraAt c)]
  [finite_algebraAt : ∀ c, Module.Finite k (AlgebraAt c)]
  [etale_algebraAt : ∀ c, Algebra.Etale k (AlgebraAt c)]

attribute [instance]
  TupleFiniteEtalePacket.commRing_algebraAt
  TupleFiniteEtalePacket.algebra_algebraAt
  TupleFiniteEtalePacket.finite_algebraAt
  TupleFiniteEtalePacket.etale_algebraAt

namespace TupleFiniteEtalePacket

variable {k : Type u} [Field k] {Tuple : Type v}
variable (P : TupleFiniteEtalePacket.{u, v, w} k Tuple)

/-- Correct packet-component index: a place tuple together with one primitive
field factor of its finite etale tensor algebra. -/
abbrev RefinedComponent : Type (max v w) :=
  Σ c : Tuple, MaximalSpectrum (P.AlgebraAt c)

/-- The field summand belonging to a refined component. -/
abbrev Summand (d : P.RefinedComponent) : Type w :=
  P.AlgebraAt d.1 ⧸ d.2.asIdeal

noncomputable instance summandField (d : P.RefinedComponent) :
    Field (P.Summand d) :=
  Ideal.Quotient.field d.2.asIdeal

noncomputable instance refinedComponentFinite [Finite Tuple] :
    Finite P.RefinedComponent := by
  letI (c : Tuple) : Finite (MaximalSpectrum (P.AlgebraAt c)) :=
    finiteMaximalSpectrum k (P.AlgebraAt c)
  infer_instance

/-- Canonical semisimple coordinates inside one place tuple. -/
noncomputable def tupleCoordinates (c : Tuple) :
    P.AlgebraAt c ≃ₐ[k]
      ∀ m : MaximalSpectrum (P.AlgebraAt c),
        P.AlgebraAt c ⧸ m.asIdeal :=
  finiteEtaleSemisimpleEquiv k (P.AlgebraAt c)

end TupleFiniteEtalePacket

end IUTThreeClosures
