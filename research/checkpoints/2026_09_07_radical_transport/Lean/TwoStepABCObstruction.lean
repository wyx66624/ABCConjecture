import RadicalTransport
import IUTThreeClosures.ABCStatement

/-!
# A conditional obstruction to the repository's standard ABC statement

The premise explicitly requires an unbounded family meeting a two-norm radical bound.
No theorem in this file supplies that family. The conclusion refers directly to the
`IUTThreeClosures.ABCConjecture` definition, not to a renamed substitute conjecture.
-/

namespace TwoStepABCObstruction

open RadicalTransport UniqueFactorizationMonoid IUTThreeClosures

/-- The repository radical is exactly Mathlib's radical on natural numbers. -/
theorem repository_radical_eq (n : ℕ) : abcRadical n = radical n := by
  rw [Nat.radical_eq_prod_primeFactors]
  rfl

/-- An actual fifth-power radical estimate has the stated logarithmic consequence. -/
theorem log_radical_gate {R c : ℕ} (hgate : R ^ 5 ≤ c ^ 16) (hR : 0 < R) :
    5 * Real.log (R : ℝ) ≤ 16 * Real.log (c : ℝ) := by
  have hr : 0 < (R : ℝ) ^ 5 := by positivity
  have hg : (R : ℝ) ^ 5 ≤ (c : ℝ) ^ 16 := by exact_mod_cast hgate
  have hl := Real.log_le_log hr hg
  simpa only [Real.log_pow, Nat.cast_ofNat] using hl

/-- A positive coprime pair gives pairwise coprimality for its additive triple. -/
theorem additive_pairwise {x y : ℕ} (hxy : x.Coprime y) :
    PairwiseCoprimeABC x y (x + y) := by
  exact ⟨hxy, Nat.coprime_add_self_right.mpr hxy.symm,
    (Nat.coprime_self_add_right.mpr hxy).symm⟩

/-- The integer gate on an unbounded family would disprove the actual standard ABC conjecture.
Existence of the family in this premise is an open arithmetic problem. -/
theorem not_abc_of_unbounded_two_norm_gate
    (hfamily : ∀ B : ℝ, ∃ a b : ℕ, 0 < a ∧ 0 < b ∧ a.Coprime b ∧
      B < Real.log ((a + b : ℕ) : ℝ) ∧
      (radical (normForm a b) * radical (normForm (a * b) (normForm a b))) ^ 5 ≤ a + b) :
    ¬ ABCConjecture := by
  intro habc
  obtain ⟨C, hC⟩ := habc (1 / 8) (by norm_num)
  obtain ⟨a, b, ha, hb, hcop, hlarge, hgate⟩ := hfamily ((5 / 2) * C)
  let x := a * b * normForm a b
  let y := normForm (a * b) (normForm a b)
  have hx : 0 < x := by dsimp [x, normForm]; positivity
  have hy : 0 < y := by dsimp [y, normForm]; positivity
  have hxy : x.Coprime y := transform_coprime (transform_coprime hcop)
  have hsum : x + y = (a + b) ^ 4 := two_step_addition a b
  have hc : 0 < (a + b) ^ 4 := by positivity
  have hp : PairwiseCoprimeABC x y ((a + b) ^ 4) := by
    rw [← hsum]
    exact additive_pairwise hxy
  have hbound := hC x y ((a + b) ^ 4) hx hy hc hsum hp
  have hm : max x (max y ((a + b) ^ 4)) = (a + b) ^ 4 := by
    rw [← hsum]
    omega
  rw [hm, repository_radical_eq] at hbound
  have hrad := two_step_radical_gate ha hb hcop hgate
  have hlog := log_radical_gate hrad (Nat.radical_pos _)
  dsimp only [x, y] at hbound
  rw [Nat.cast_pow, Real.log_pow] at hbound
  norm_num only [Nat.cast_ofNat] at hbound
  linarith

end TwoStepABCObstruction

#print axioms TwoStepABCObstruction.repository_radical_eq
#print axioms TwoStepABCObstruction.log_radical_gate
#print axioms TwoStepABCObstruction.additive_pairwise
#print axioms TwoStepABCObstruction.not_abc_of_unbounded_two_norm_gate
