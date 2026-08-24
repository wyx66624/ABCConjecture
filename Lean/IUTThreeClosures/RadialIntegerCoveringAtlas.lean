/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.RadialIntegerOrbitQuotient

/-!
# The local covering atlas of a radial integer quotient

For a canonical radial slice `U_x`, the integer translates

`U_{x,n} = n • U_x`

are pairwise disjoint. Their union is exactly the inverse image of the open
quotient neighborhood `q(U_x)`, and the quotient projection maps each sheet
bijectively onto that neighborhood.

This is the complete ordinary topological covering datum. It deliberately
stops before claiming a Berkovich analytic or finite-etale structure.
-/

namespace IUTThreeClosures

namespace RadialIntegerAction

variable {X : Type*} [TopologicalSpace X]
variable (A : RadialIntegerAction X)

def sheet (x : X) (n : ℤ) : Set X :=
  A.act n '' A.slice x

theorem isOpen_sheet (x : X) (n : ℤ) :
    IsOpen (A.sheet x n) :=
  (A.translateHomeomorph n).isOpenMap _ (A.isOpen_slice x)

theorem act_sub_eq_of_act_eq
    {m n : ℤ} {y z : X}
    (h : A.act m y = A.act n z) :
    A.act (m - n) y = z := by
  calc
    A.act (m - n) y = A.act (-n + m) y := by
      congr 1
      omega
    _ = A.act (-n) (A.act m y) := A.act_add (-n) m y
    _ = A.act (-n) (A.act n z) := by rw [h]
    _ = z := A.act_neg_cancel n z

theorem sheet_disjoint
    (x : X) {m n : ℤ} (hmn : m ≠ n) :
    A.sheet x m ∩ A.sheet x n = ∅ := by
  apply Set.eq_empty_iff_forall_not_mem.mpr
  intro w hw
  rcases hw.1 with ⟨y, hy, hmy⟩
  rcases hw.2 with ⟨z, hz, hnz⟩
  have hmnPoint : A.act (m - n) y = z :=
    A.act_sub_eq_of_act_eq (hmy.trans hnz.symm)
  have hsame : A.act (m - n) y = y :=
    A.act_eq_of_mem_slice x y (m - n) hy (by
      rw [hmnPoint]
      exact hz)
  have hzero : m - n = 0 := A.free hsame
  exact hmn (sub_eq_zero.mp hzero)

theorem quotientMap_image_sheet
    (x : X) (n : ℤ) :
    A.quotientMap '' A.sheet x n =
      A.quotientMap '' A.slice x := by
  ext q
  constructor
  · rintro ⟨w, ⟨y, hy, rfl⟩, rfl⟩
    refine ⟨y, hy, ?_⟩
    exact Quotient.sound ⟨n, rfl⟩
  · rintro ⟨y, hy, rfl⟩
    refine ⟨A.act n y, ⟨y, hy, rfl⟩, ?_⟩
    exact (Quotient.sound ⟨n, rfl⟩).symm

theorem quotientMap_injOn_sheet
    (x : X) (n : ℤ) :
    Set.InjOn A.quotientMap (A.sheet x n) := by
  intro y hy z hz hq
  rcases hy with ⟨y₀, hy₀, rfl⟩
  rcases hz with ⟨z₀, hz₀, rfl⟩
  have hq₀ : A.quotientMap y₀ = A.quotientMap z₀ := by
    calc
      A.quotientMap y₀ = A.quotientMap (A.act n y₀) :=
        Quotient.sound ⟨n, rfl⟩
      _ = A.quotientMap (A.act n z₀) := hq
      _ = A.quotientMap z₀ :=
        (Quotient.sound ⟨n, rfl⟩).symm
  have hyz : y₀ = z₀ :=
    A.quotientMap_injOn_slice x hy₀ hz₀ hq₀
  rw [hyz]

theorem quotientMap_surjOn_sheet
    (x : X) (n : ℤ) :
    Set.SurjOn A.quotientMap (A.sheet x n)
      (A.quotientMap '' A.slice x) := by
  intro q hq
  rcases hq with ⟨y, hy, rfl⟩
  refine ⟨A.act n y, ⟨y, hy, rfl⟩, ?_⟩
  exact (Quotient.sound ⟨n, rfl⟩).symm

theorem preimage_quotient_slice_eq_iUnion_sheet
    (x : X) :
    A.quotientMap ⁻¹' (A.quotientMap '' A.slice x) =
      ⋃ n : ℤ, A.sheet x n := by
  rw [A.preimage_image_quotientMap]
  rfl

structure LocalCoveringChart (x : X) where
  neighborhood : Set A.OrbitQuotient :=
    A.quotientMap '' A.slice x
  neighborhood_open : IsOpen neighborhood
  sheets : ℤ → Set X := A.sheet x
  sheets_open : ∀ n, IsOpen (sheets n)
  pairwise_disjoint :
    ∀ {m n}, m ≠ n → sheets m ∩ sheets n = ∅
  preimage_eq : A.quotientMap ⁻¹' neighborhood = ⋃ n, sheets n
  maps_onto : ∀ n,
    A.quotientMap '' sheets n = neighborhood
  injective_on : ∀ n,
    Set.InjOn A.quotientMap (sheets n)

noncomputable def localCoveringChart (x : X) :
    A.LocalCoveringChart x where
  neighborhood_open := A.isOpen_quotientMap_image_slice x
  sheets_open := A.isOpen_sheet x
  pairwise_disjoint := A.sheet_disjoint x
  preimage_eq := A.preimage_quotient_slice_eq_iUnion_sheet x
  maps_onto := A.quotientMap_image_sheet x
  injective_on := A.quotientMap_injOn_sheet x

theorem quotient_has_local_covering_chart
    (q : A.OrbitQuotient) :
    ∃ x : X,
      q ∈ (A.localCoveringChart x).neighborhood := by
  refine Quotient.inductionOn q ?_
  intro x
  exact ⟨x, ⟨x, A.mem_slice_self x, rfl⟩⟩

end RadialIntegerAction

end IUTThreeClosures
