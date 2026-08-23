import Mathlib
import IUTThreeClosures.CandidateKummerPossibleImageRelations

/-!
# Absorbing a finite exceptional set into a bounded-discrepancy constant

This is the elementary step used after a diophantine estimate has been proved
outside a finite exceptional set.  It does not prove that the Galois-finite set
in IUT IV has finite intersection with the relevant bounded-degree locus; that
is a separate Northcott/height input.
-/

namespace IUTThreeClosures

universe u

variable {α : Type u}

/-- Every real-valued function is bounded above on a finite set. -/
theorem exists_upper_bound_on_finset
    (s : Finset α) (f : α → ℝ) :
    ∃ C : ℝ, ∀ x ∈ s, f x ≤ C := by
  classical
  induction s using Finset.induction_on with
  | empty =>
      exact ⟨0, by simp⟩
  | @insert a s ha ih =>
      rcases ih with ⟨C, hC⟩
      refine ⟨max (f a) C, ?_⟩
      intro x hx
      simp only [Finset.mem_insert] at hx
      rcases hx with rfl | hx
      · exact le_max_left _ _
      · exact (hC x hx).trans (le_max_right _ _)

/-- An inequality valid outside a finite set extends to the whole space after
increasing its additive constant. -/
theorem extend_inequality_across_finset
    (s : Finset α) (lhs rhs : α → ℝ) (Cout : ℝ)
    (hout : ∀ x, x ∉ s → lhs x ≤ rhs x + Cout) :
    ∃ C : ℝ, ∀ x, lhs x ≤ rhs x + C := by
  classical
  rcases exists_upper_bound_on_finset s (fun x => lhs x - rhs x) with
    ⟨Cin, hCin⟩
  refine ⟨max Cout Cin, ?_⟩
  intro x
  by_cases hx : x ∈ s
  · have h := hCin x hx
    have hmax : Cin ≤ max Cout Cin := le_max_right _ _
    linarith
  · have h := hout x hx
    have hmax : Cout ≤ max Cout Cin := le_max_left _ _
    linarith

end IUTThreeClosures
