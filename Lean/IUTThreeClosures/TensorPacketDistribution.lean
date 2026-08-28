/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.LinearAlgebra.PiTensorProduct.DirectSum
import IUTThreeClosures.RepeatedLabelProcessionOvercount

/-!
# Tensor packets distribute over local direct sums

For a finite label type `Label`, local modules `K j v`, and the direct sum over
places in every label, the n-ary tensor product distributes canonically:

`⨂ j, (⨁ v, K j v) ≃ₗ[k] ⨁ c, ⨂ j, K j (c j)`.

This is the purely multilinear half of the local tensor-packet coordinate
theorem.  The finite-etale splitting of each tuple tensor algebra into its
primitive field factors is treated in `SemisimplePacketCoordinates`.
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

/-- Canonical tuple expansion of the local tensor packet. -/
noncomputable def tensorPacketTupleExpansion :
    (⨂[k] j : Label, (⨁ v : Place j, K j v)) ≃ₗ[k]
      (⨁ c : (∀ j : Label, Place j),
        (⨂[k] j : Label, K j (c j))) :=
  PiTensorProduct.ofDirectSumEquiv

/-- On a pure tensor supported in one place of every label, tuple expansion
lands in exactly that tuple component. -/
@[simp]
theorem tensorPacketTupleExpansion_tprod_lof
    [Fintype Label] [∀ j, DecidableEq (Place j)]
    (c : ∀ j : Label, Place j)
    (x : ∀ j : Label, K j (c j)) :
    tensorPacketTupleExpansion k Label Place K
        (⨂ₜ[k] j : Label,
          DirectSum.lof k (Place j) (K j) (c j) (x j)) =
      DirectSum.lof k _ _ c (⨂ₜ[k] j : Label, x j) := by
  exact PiTensorProduct.ofDirectSumEquiv_tprod_lof c x

end IUTThreeClosures
