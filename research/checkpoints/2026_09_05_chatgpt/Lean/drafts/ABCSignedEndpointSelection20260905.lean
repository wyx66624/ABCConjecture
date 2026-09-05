import Mathlib

/-!
Partial algebraic companion to the signed-endpoint supplement, 2026-09-05.
STATUS: UNCOMPILED. No Lean compiler was available in this execution.
These declarations do not define or prove ABCConjecture. The full arithmetic
configuration type, factorization adapter, prime certificates, and universal
analytic estimate are NOT formalized here. Mathematical proofs are in the
accompanying paper and preceded this draft. No build import is modified.
-/
namespace ABCSignedEndpointSelection20260905

/-- Exact deficit/overfill identity, before any arithmetic specialization. -/
theorem positivePart_balance (d k : ℝ) :
    max (d - k) 0 = d - k + max (k - d) 0 := by
  by_cases h : d ≤ k
  · rw [max_eq_right (by linarith : d - k ≤ 0),
        max_eq_left (by linarith : 0 ≤ k - d)]
    ring
  · have h' : k ≤ d := le_of_lt (lt_of_not_ge h)
    rw [max_eq_left (by linarith : 0 ≤ d - k),
        max_eq_right (by linarith : k - d ≤ 0)]
    ring

theorem sum_positivePart_balance {ι : Type*} (s : Finset ι) (d k : ι → ℝ) :
    (∑ i ∈ s, max (d i - k i) 0) =
      (∑ i ∈ s, d i) - (∑ i ∈ s, k i) +
      (∑ i ∈ s, max (k i - d i) 0) := by
  simp_rw [positivePart_balance]
  simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib]

/-- Bookkeeping identity only: the arithmetic construction is supplied on paper,
not smuggled into a field that assumes an abc-strength upper bound. -/
theorem exact_log_loss
    (X Y blockSource blockSink issued owned unused B O : ℝ)
    (hres : B = (X - blockSource) - (owned + issued) + O)
    (hsinks : Y = blockSink + owned + unused) :
    B = (X - Y) + unused + (blockSink - blockSource - issued) + O := by
  linarith

def adaptiveFactor (c b Fplus Fminus : ℝ) : ℝ :=
  min Fplus ((c / b) * Fminus)

theorem adaptive_height
    (c b R Fplus Fminus : ℝ) (hc : 0 < c) (hb : 0 < b)
    (hplus : c ≤ R * Fplus) (hminus : b ≤ R * Fminus) :
    c ≤ R * adaptiveFactor c b Fplus Fminus := by
  have hscaled : c ≤ R * ((c / b) * Fminus) := by
    have h := mul_le_mul_of_nonneg_left hminus (le_of_lt (div_pos hc hb))
    have hcb : (c / b) * b = c := div_mul_cancel₀ c (ne_of_gt hb)
    rw [hcb] at h
    calc
      c ≤ (c / b) * (R * Fminus) := h
      _ = R * ((c / b) * Fminus) := by ring
  unfold adaptiveFactor
  rcases le_total Fplus ((c / b) * Fminus) with h | h
  · rw [min_eq_left h]
    exact hplus
  · rw [min_eq_right h]
    exact hscaled

theorem adaptive_exact_of_minus
    (c b R Fplus : ℝ) (hb : b ≠ 0) (hR : R ≠ 0)
    (hplus : c / R ≤ Fplus) :
    adaptiveFactor c b Fplus (b / R) = c / R := by
  have heq : (c / b) * (b / R) = c / R := by
    field_simp
  unfold adaptiveFactor
  rw [heq, min_eq_right hplus]

/-- Algebraic core of the ordinary signed unitary-factor threshold. -/
theorem ordered_bilinear_gap (M s t : ℕ) (hs : 1 ≤ s) (hst : s < t) :
    2 * M + 3 ≤ M * s * t + s + t := by
  have ht : 2 ≤ t := by omega
  have hst2 : 2 ≤ s * t := by nlinarith
  have hmul := Nat.mul_le_mul_left M hst2
  nlinarith

/-- The two excluded ordered pairs arise from exact 3-adic valuation and
coprimality, respectively. That number-theoretic adapter remains unformalized. -/
theorem exceptional_ordered_gap (M s t : ℕ)
    (hs : 1 ≤ s) (hst : s < t)
    (h12 : ¬ (s = 1 ∧ t = 2)) (h13 : ¬ (s = 1 ∧ t = 3)) :
    4 * M + 5 ≤ M * s * t + s + t := by
  have hprod : 4 ≤ s * t := by
    by_cases h : s = 1
    · have ht : 4 ≤ t := by omega
      simpa [h] using ht
    · have hs2 : 2 ≤ s := by omega
      have ht3 : 3 ≤ t := by omega
      nlinarith
  have hsum : 5 ≤ s + t := by omega
  have hmul := Nat.mul_le_mul_left M hprod
  nlinarith

theorem sharp_regular_identity (M : ℕ) :
    (M + 1) * (2 * M + 1) = M * (2 * M + 3) + 1 := by ring

theorem sharp_exceptional_identity (M : ℕ) :
    (M + 1) * (4 * M + 1) = M * (4 * M + 5) + 1 := by ring

/-- Rational arithmetic for the ordinary, exhaustively classified witness.
This is NOT a formalization of the optimizer classification itself. -/
theorem counterexample_selection :
    min (11 / 7 : ℚ) ((3025 / 3024 : ℚ) * (8 / 5)) = 11 / 7 := by norm_num

theorem counterexample_extra_loss :
    (11 / 7 : ℚ) / (55 / 42) = 6 / 5 := by norm_num

theorem counterexample_not_scalar : (55 / 42 : ℚ) < 11 / 7 := by norm_num

#print axioms positivePart_balance
#print axioms sum_positivePart_balance
#print axioms exact_log_loss
#print axioms adaptive_height
#print axioms adaptive_exact_of_minus
#print axioms ordered_bilinear_gap
#print axioms exceptional_ordered_gap
#print axioms sharp_regular_identity
#print axioms sharp_exceptional_identity
#print axioms counterexample_selection
#print axioms counterexample_extra_loss
#print axioms counterexample_not_scalar

end ABCSignedEndpointSelection20260905
