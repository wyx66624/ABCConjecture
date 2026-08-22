/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.LinearAlgebra.PiTensorProduct.DirectSum

/-!
# Tensor packets distribute over local direct sums

This is the first, purely multilinear, half of the local tensor-packet
coordinate theorem. For a finite label type `Label`, local modules `K j v`,
and the direct sum over places in every label, Mathlib's n-ary tensor product
gives canonically

`⨂ j, (⨁ v, K j v) ≃ₗ[k] ⨁ c, ⨂ j, K j (c j)`.

Thus tuple-of-places indexing is a theorem of multilinear algebra, not a field
supplied to the packet. The second half is algebraic: each tuple tensor
algebra must be split into its primitive field factors. That refinement is
implemented in `SemisimplePacketCoordinates`.
-/

namespace IUTThreeClosures

open PiTensorProduct DirectSum TensorProduct

universe u v w

variable (k : Type u) [Field k]
variable (Label : Type v) [Finite Label]
variable (Place : Label → Type w)
variable (K : ∀ j, Place j → Type w)
variable [∀ j v, AddCommGroup (K j v)]
variable [∀ j v, Module k (K j v)]

/-- The local direct sum in the `j`-th label. -/
abbrev TensorPacketLocalSum (j : Label) : Type (max v w) :=
  ⨁ v : Place j, K j v

/-- A choice of one local place in every label. -/
abbrev TensorPacketTuple : Type (max v w) :=
  ∀ j : Label, Place j

/-- The n-ary tensor packet before tuple expansion. -/
abbrev TensorPacketModule : Type (max u v w) :=
  ⨂[k] j, TensorPacketLocalSum Label Place K j

/-- The tensor module attached to one tuple of local places. -/
abbrev TensorPacketTupleModule
    (c : TensorPacketTuple Label Place) : Type (max u v w) :=
  ⨂[k] j, K j (c j)

/-- Canonical tuple expansion of a tensor packet. -/
noncomputable def tensorPacketTupleExpansion :
    TensorPacketModule k Label Place K ≃ₗ[k]
      ⨁ c : TensorPacketTuple Label Place,
        TensorPacketTupleModule k Label Place K c :=
  PiTensorProduct.ofDirectSumEquiv

/-- On a pure tensor supported in one place of every label, tuple expansion
lands in exactly that tuple component. -/
@[simp]
theorem tensorPacketTupleExpansion_tprod_lof
    [Fintype Label] [∀ j, DecidableEq (Place j)]
    (c : TensorPacketTuple Label Place)
    (x : ∀ j, K j (c j)) :
    tensorPacketTupleExpansion k Label Place K
        (⨂ₜ[k] j, DirectSum.lof k (Place j) (K j) (c j) (x j)) =
      DirectSum.lof k _ _ c (⨂ₜ[k] j, x j) := by
  simpa only [tensorPacketTupleExpansion, TensorPacketModule,
    TensorPacketLocalSum, TensorPacketTupleModule, TensorPacketTuple] using
      (PiTensorProduct.ofDirectSumEquiv_tprod_lof
        (R := k) (κ := Place) (M := K) c x)

end IUTThreeClosures
