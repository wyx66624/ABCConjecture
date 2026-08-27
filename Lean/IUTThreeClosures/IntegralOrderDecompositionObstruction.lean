/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Semisimple coordinates do not automatically split integral structures

After a field-level semisimple decomposition, an arithmetic order need not be
the product of the integral rings of the factors.  The elementary congruence
order

`O_n = {(a,b) : ℤ × ℤ | a ≡ b mod n}`

is a proper subring of the product ring.  It is the toy model for what happens
to tensor-product orders at ramified places: the ambient algebra splits, while
the integral lattice can satisfy congruence conditions across the factors.
The finite index/discrepancy is precisely the kind of term measured by a
different or discriminant correction.

Consequently an algebra equivalence

`A ≃ ∏ c, L_c`

does not by itself prove that a selected integral subring of `A` is
`∏ c, O_{L_c}`.  A packet-coordinate theorem must carry a separate theorem
identifying the actual IUT integral structures, or a controlled inclusion and
index estimate.  Treating integral compatibility as definitional would erase
the arithmetic correction that IUT IV is supposed to estimate.
-/

namespace IUTThreeClosures

/-- The congruence order in `ℤ × ℤ`. -/
def congruenceOrder (n : ℤ) : Subring (ℤ × ℤ) where
  carrier := {x | n ∣ x.1 - x.2}
  zero_mem' := by simp
  one_mem' := by simp
  add_mem' := by
    intro a b ha hb
    rcases ha with ⟨r, hr⟩
    rcases hb with ⟨s, hs⟩
    refine ⟨r + s, ?_⟩
    change a.1 + b.1 - (a.2 + b.2) = n * (r + s)
    calc
      a.1 + b.1 - (a.2 + b.2) =
          (a.1 - a.2) + (b.1 - b.2) := by ring
      _ = n * r + n * s := by rw [hr, hs]
      _ = n * (r + s) := by ring
  neg_mem' := by
    intro a ha
    rcases ha with ⟨r, hr⟩
    refine ⟨-r, ?_⟩
    change -a.1 - -a.2 = n * -r
    calc
      -a.1 - -a.2 = -(a.1 - a.2) := by ring
      _ = -(n * r) := by rw [hr]
      _ = n * -r := by ring
  mul_mem' := by
    intro a b ha hb
    rcases ha with ⟨r, hr⟩
    rcases hb with ⟨s, hs⟩
    refine ⟨a.1 * s + b.2 * r, ?_⟩
    change a.1 * b.1 - a.2 * b.2 =
      n * (a.1 * s + b.2 * r)
    calc
      a.1 * b.1 - a.2 * b.2 =
          a.1 * (b.1 - b.2) + b.2 * (a.1 - a.2) := by ring
      _ = a.1 * (n * s) + b.2 * (n * r) := by rw [hr, hs]
      _ = n * (a.1 * s + b.2 * r) := by ring

@[simp]
theorem mem_congruenceOrder_iff (n : ℤ) (x : ℤ × ℤ) :
    x ∈ congruenceOrder n ↔ n ∣ x.1 - x.2 :=
  Iff.rfl

/-- The two coordinates cannot be chosen independently in the congruence-two
order. -/
theorem zero_one_not_mem_congruenceOrder_two :
    (0, 1) ∉ congruenceOrder 2 := by
  change ¬ (2 : ℤ) ∣ (0 : ℤ) - 1
  norm_num

/-- Even though the ambient ring is already a product, its chosen integral
order can be a proper subring. -/
theorem congruenceOrder_two_ne_top :
    congruenceOrder 2 ≠ (⊤ : Subring (ℤ × ℤ)) := by
  intro h
  have hm : (0, 1) ∈ congruenceOrder 2 := by
    rw [h]
    exact Subring.mem_top _
  exact zero_one_not_mem_congruenceOrder_two hm

/-- A field/product coordinate decomposition alone cannot logically force the
chosen integral structure to be the product integral structure. -/
theorem exists_proper_integral_order_in_product :
    ∃ O : Subring (ℤ × ℤ), O ≠ ⊤ :=
  ⟨congruenceOrder 2, congruenceOrder_two_ne_top⟩

end IUTThreeClosures
