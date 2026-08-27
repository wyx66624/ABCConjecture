/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Group.Subgroup.Lattice
import Mathlib.Data.Fintype.Card
import Mathlib.Tactic.Abel

/-!
# Finite-group core for the p=29 BDF factor-base route

This file contains only the elementary algebraic implication needed after an
external BDF factor-base certificate has supplied a generating set. It does
not formalize, or assume as an axiom, the analytic BDF criterion.
-/

namespace IUTThreeClosures

variable {G : Type*} [AddCommGroup G]

/-- If `S` generates an additive commutative group and every generator is a
double, then doubling is surjective. No finiteness assumption is needed. -/
theorem doubling_surjective_of_closure_eq_top
    (S : Set G) (hgen : AddSubgroup.closure S = ⊤)
    (hdouble : ∀ s ∈ S, ∃ x : G, x + x = s) :
    Function.Surjective (fun x : G => x + x) := by
  intro g
  have hg : g ∈ AddSubgroup.closure S := by
    rw [hgen]
    exact AddSubgroup.mem_top g
  exact AddSubgroup.closure_induction (p := fun y _ => ∃ x : G, x + x = y)
    (fun s hs => hdouble s hs)
    ⟨0, by simp⟩
    (fun x y _ _ hx hy => by
      obtain ⟨a, rfl⟩ := hx
      obtain ⟨b, rfl⟩ := hy
      exact ⟨a + b, by abel⟩)
    (fun x _ hx => by
      obtain ⟨a, rfl⟩ := hx
      exact ⟨-a, by simp⟩)
    hg

/-- In a finite additive commutative group, the preceding surjectivity makes
doubling injective. Hence the only element killed by doubling is zero. -/
theorem two_torsion_eq_zero_of_generators_are_doubles
    [Finite G] (S : Set G) (hgen : AddSubgroup.closure S = ⊤)
    (hdouble : ∀ s ∈ S, ∃ x : G, x + x = s)
    {g : G} (hg : g + g = 0) : g = 0 := by
  let d : G → G := fun x => x + x
  have hsurj : Function.Surjective d :=
    doubling_surjective_of_closure_eq_top S hgen hdouble
  have hinj : Function.Injective d :=
    Finite.injective_iff_surjective.mpr hsurj
  apply hinj
  simpa [d] using hg

/-- If a generating set consists only of zero, the whole group is trivial.
This stronger conclusion also does not require finiteness. -/
theorem subsingleton_of_closure_eq_top_of_generators_eq_zero
    (S : Set G) (hgen : AddSubgroup.closure S = ⊤)
    (hzero : ∀ s ∈ S, s = 0) : Subsingleton G := by
  have all_zero : ∀ g : G, g = 0 := by
    intro g
    have hg : g ∈ AddSubgroup.closure S := by
      rw [hgen]
      exact AddSubgroup.mem_top g
    exact AddSubgroup.closure_induction (p := fun y _ => y = 0)
      (fun s hs => hzero s hs)
      rfl
      (fun x y _ _ hx hy => by simp [hx, hy])
      (fun x _ hx => by simp [hx])
      hg
  exact ⟨fun a b => (all_zero a).trans (all_zero b).symm⟩

/-- Elementwise form of the preceding triviality statement. -/
theorem eq_zero_of_closure_eq_top_of_generators_eq_zero
    (S : Set G) (hgen : AddSubgroup.closure S = ⊤)
    (hzero : ∀ s ∈ S, s = 0) (g : G) : g = 0 := by
  letI := subsingleton_of_closure_eq_top_of_generators_eq_zero S hgen hzero
  exact Subsingleton.elim g 0

#print axioms doubling_surjective_of_closure_eq_top
#print axioms two_torsion_eq_zero_of_generators_are_doubles
#print axioms subsingleton_of_closure_eq_top_of_generators_eq_zero
#print axioms eq_zero_of_closure_eq_top_of_generators_eq_zero

end IUTThreeClosures
