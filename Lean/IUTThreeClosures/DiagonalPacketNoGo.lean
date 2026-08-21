import Mathlib

/-!
# No-go theorem for a naive diagonal packet action
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u
variable {L : Type u}

/-- Applying one nonzero response independently at every label multiplies it
by the capsule cardinality. -/
theorem diagonal_response_eq_card_mul
    [Fintype L] (a : ℝ) :
    (∑ _j : L, a) = (Fintype.card L : ℝ) * a := by
  simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]

/-- Different capsule sizes cannot have one common nonzero diagonal reading. -/
theorem diagonal_readings_ne_of_card_ne
    {m n : ℕ} {a : ℝ} (hmn : m ≠ n) (ha : a ≠ 0) :
    (m : ℝ) * a ≠ (n : ℝ) * a := by
  intro h
  have hcast : (m : ℝ) = (n : ℝ) := mul_right_cancel₀ ha h
  exact hmn (by exact_mod_cast hcast)

end IUTThreeClosures
