import Mathlib

/-!
# Least region in a nested exponent chain
-/

namespace IUTThreeClosures

universe u v
variable {Output : Type u} {α : Type v}

def familyUnion (region : ℤ → Set α) (exponent : Output → ℤ) : Set α :=
  ⋃ o : Output, region (exponent o)

/-- A possibly infinite output family has an explicit least containing member
of an antitone lattice chain whenever its exponent set has an attained lower
bound. -/
theorem attainedLowerBound_isLeastHull
    (region : ℤ → Set α) (hanti : Antitone region)
    (exponent : Output → ℤ) (m : ℤ)
    (hlower : ∀ o, m ≤ exponent o)
    (hattained : ∃ o, exponent o = m) :
    familyUnion region exponent ⊆ region m ∧
      ∀ k, familyUnion region exponent ⊆ region k → region m ⊆ region k := by
  constructor
  · intro x hx
    rcases Set.mem_iUnion.mp hx with ⟨o, hx⟩
    exact hanti (hlower o) hx
  · intro k hk
    rcases hattained with ⟨o, ho⟩
    have hmember : region m ⊆ familyUnion region exponent := by
      rw [← ho]
      intro x hx
      exact Set.mem_iUnion.mpr ⟨o, hx⟩
    exact hmember.trans hk

end IUTThreeClosures
