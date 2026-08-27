/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Explicit local slices for radial integer actions

Let `ℤ` act continuously on a topological space `X`, and suppose a continuous
radial coordinate satisfies

`rho(n • x) = rho(x) + n`.

Then the open strip

`|rho(y) - rho(x)| < 1/3`

is disjoint from every nontrivial integer translate of itself.  In particular,
the action is free and properly discontinuous in the usual local-slice sense.

This theorem is independent of compactness and local compactness.  It is the
exact topological mechanism behind the corrected Tate theta-root deck action:
once the actual integer action and radial continuity are supplied, no separate
proper-discontinuity theorem is required.
-/

namespace IUTThreeClosures

/-- A continuous integer action equipped with an equivariant real radial
coordinate. -/
structure RadialIntegerAction (X : Type*) [TopologicalSpace X] where
  act : ℤ → X → X
  act_zero : ∀ x, act 0 x = x
  act_add : ∀ m n x, act (m + n) x = act m (act n x)
  continuous_act : ∀ n, Continuous (act n)
  radial : X → ℝ
  continuous_radial : Continuous radial
  radial_act : ∀ n x, radial (act n x) = radial x + (n : ℝ)

namespace RadialIntegerAction

variable {X : Type*} [TopologicalSpace X]
variable (A : RadialIntegerAction X)

/-- The inverse integer translate cancels a given translate. -/
theorem act_neg_cancel (n : ℤ) (x : X) :
    A.act (-n) (A.act n x) = x := by
  rw [← A.act_add, neg_add_cancel, A.act_zero]

/-- The action is free, solely because the radial coordinate changes by the
integer translation parameter. -/
theorem free {n : ℤ} {x : X}
    (hfix : A.act n x = x) :
    n = 0 := by
  have hcoord := A.radial_act n x
  rw [hfix] at hcoord
  have hcast : (n : ℝ) = 0 := by linarith
  exact_mod_cast hcast

/-- The canonical radius-`1/3` local slice centered at `x`. -/
def slice (x : X) : Set X :=
  {y | |A.radial y - A.radial x| < (1 / 3 : ℝ)}

/-- The center belongs to its radial slice. -/
theorem mem_slice_self (x : X) : x ∈ A.slice x := by
  simp [slice]
  norm_num

/-- Radial slices are open. -/
theorem isOpen_slice (x : X) : IsOpen (A.slice x) := by
  have hcontinuous :
      Continuous (fun y : X => |A.radial y - A.radial x|) :=
    (A.continuous_radial.sub continuous_const).abs
  change IsOpen
    ((fun y : X => |A.radial y - A.radial x|) ⁻¹'
      Set.Iio (1 / 3 : ℝ))
  exact Set.isOpen_Iio.preimage hcontinuous

private theorem int_eq_zero_of_abs_cast_lt_one
    {n : ℤ} (hn : |(n : ℝ)| < 1) :
    n = 0 := by
  by_cases hnonneg : 0 ≤ n
  · have hle : n ≤ 0 := by
      by_contra hnot
      have hone : (1 : ℤ) ≤ n := by omega
      have honeReal : (1 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hone
      have hnleabs : (n : ℝ) ≤ |(n : ℝ)| := le_abs_self _
      linarith
    omega
  · have hle : n ≤ -1 := by omega
    have hreal : (n : ℝ) ≤ -1 := by exact_mod_cast hle
    have habs : |(n : ℝ)| = -(n : ℝ) :=
      abs_of_nonpos (by linarith)
    rw [habs] at hn
    linarith

/-- Two points of the same radius-`1/3` slice cannot differ by a nonzero
integer translate. -/
theorem act_eq_of_mem_slice
    (x y : X) (n : ℤ)
    (hy : y ∈ A.slice x)
    (hny : A.act n y ∈ A.slice x) :
    A.act n y = y := by
  have hy' : |A.radial y - A.radial x| < (1 / 3 : ℝ) := hy
  have hny' :
      |A.radial (A.act n y) - A.radial x| < (1 / 3 : ℝ) := hny
  have htriangle :
      |A.radial (A.act n y) - A.radial y| < (2 / 3 : ℝ) := by
    calc
      |A.radial (A.act n y) - A.radial y| =
          |(A.radial (A.act n y) - A.radial x) -
            (A.radial y - A.radial x)| := by ring_nf
      _ ≤ |A.radial (A.act n y) - A.radial x| +
            |A.radial y - A.radial x| := abs_sub _ _
      _ < (2 / 3 : ℝ) := by linarith
  have hdiff :
      A.radial (A.act n y) - A.radial y = (n : ℝ) := by
    rw [A.radial_act]
    ring
  rw [hdiff] at htriangle
  have hnlt : |(n : ℝ)| < 1 := by
    linarith
  have hnzero := int_eq_zero_of_abs_cast_lt_one hnlt
  rw [hnzero, A.act_zero]

/-- Every nonzero integer translate of a radial slice is disjoint from that
slice. -/
theorem translate_slice_disjoint
    (x : X) {n : ℤ} (hn : n ≠ 0) :
    A.act n '' A.slice x ∩ A.slice x = ∅ := by
  apply Set.eq_empty_iff_forall_not_mem.mpr
  intro z hz
  rcases hz.1 with ⟨y, hy, rfl⟩
  have hfixed : A.act n y = y :=
    A.act_eq_of_mem_slice x y n hy hz.2
  exact hn (A.free hfixed)

/-- **Local proper-discontinuity theorem.** Every point has an explicit open
neighborhood disjoint from all of its nontrivial integer translates. -/
theorem exists_open_local_slice (x : X) :
    ∃ U : Set X,
      IsOpen U ∧ x ∈ U ∧
        ∀ n : ℤ, n ≠ 0 → A.act n '' U ∩ U = ∅ := by
  exact ⟨A.slice x, A.isOpen_slice x, A.mem_slice_self x,
    fun n hn => A.translate_slice_disjoint x hn⟩

end RadialIntegerAction

end IUTThreeClosures
