import Mathlib

/-!
# Algebraic core for square-endpoint packet partitions

Author: ChatGPT. Ordinary proofs are in the accompanying September 5 supplement.
This module does NOT assert ABCConjecture or inhabit an open uniformity gate.
The FCRT arithmetic specialization and LTE proof have separate formal scope.
-/

namespace ABCSquareEndpointPartition

/-- Demand/overflow reciprocity for one positive packet. -/
theorem max_ratio_reciprocity {a h : ℝ} (ha : 0 < a) (hh : 0 < h) :
    max (a / h) 1 = (a / h) * max (h / a) 1 := by
  by_cases hha : h ≤ a
  · have h₁ : 1 ≤ a / h := (le_div_iff₀ hh).2 (by simpa using hha)
    have h₂ : h / a ≤ 1 := (div_le_iff₀ ha).2 (by simpa using hha)
    rw [max_eq_left h₁, max_eq_right h₂, mul_one]
  · have hah : a ≤ h := le_of_lt (lt_of_not_ge hha)
    have h₁ : a / h ≤ 1 := (div_le_iff₀ hh).2 (by simpa using hah)
    have h₂ : 1 ≤ h / a := (le_div_iff₀ ha).2 (by simpa using hah)
    rw [max_eq_right h₁, max_eq_left h₂]
    field_simp [ne_of_gt ha, ne_of_gt hh]

/-- Sorted packets cannot overflow by more than three under these exact bounds. -/
theorem sorted_overflow_le_three {a b h k : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hh : 0 < h) (hk : 0 < k)
    (hhk : h ≤ k) (hprod : h * k ≤ a * b)
    (hba : b ≤ 3 * a) (hkb : k ≤ 3 * b) :
    max (h / a) 1 * max (k / b) 1 ≤ 3 := by
  by_cases hle : k ≤ b
  · have hkdiv : k / b ≤ 1 := (div_le_iff₀ hb).2 (by simpa using hle)
    have hbound : h ≤ 3 * a := by
      by_contra hn
      have hgt : 3 * a < h := lt_of_not_ge hn
      have hp₁ : 0 ≤ h * (k - h) := mul_nonneg (le_of_lt hh) (sub_nonneg.mpr hhk)
      have hp₂ : 0 ≤ a * (3 * a - b) := mul_nonneg (le_of_lt ha) (sub_nonneg.mpr hba)
      have hp₃ : 0 < (h - 3 * a) * (h + 3 * a) :=
        mul_pos (sub_pos.mpr hgt) (by linarith)
      nlinarith [sq_nonneg a]
    have hhdiv : h / a ≤ 3 := (div_le_iff₀ ha).2 (by nlinarith)
    rw [max_eq_right hkdiv, mul_one]
    exact max_le hhdiv (by norm_num)
  · have hgt : b < k := lt_of_not_ge hle
    have hle' : h ≤ a := by
      by_contra hn
      have hgt' : a < h := lt_of_not_ge hn
      have hp₁ : 0 < (h - a) * k := mul_pos (sub_pos.mpr hgt') hk
      have hp₂ : 0 < a * (k - b) := mul_pos ha (sub_pos.mpr hgt)
      nlinarith
    have hhdiv : h / a ≤ 1 := (div_le_iff₀ ha).2 (by simpa using hle')
    have hkdiv : k / b ≤ 3 := (div_le_iff₀ hb).2 (by nlinarith)
    rw [max_eq_right hhdiv, one_mul]
    exact max_le hkdiv (by norm_num)

/-- Exact multiplicative defect plus overflow decomposition. -/
theorem cost_eq_defect_mul_overflow {a b h k : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hh : 0 < h) (hk : 0 < k) :
    max (a / h) 1 * max (b / k) 1 =
      (a * b / (h * k)) * (max (h / a) 1 * max (k / b) 1) := by
  rw [max_ratio_reciprocity ha hh, max_ratio_reciprocity hb hk]
  ring

/-- Sorted ownership reaches at most three times the scalar multiplicative defect. -/
theorem sorted_cost_le_three_defect {a b h k : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hh : 0 < h) (hk : 0 < k)
    (hhk : h ≤ k) (hprod : h * k ≤ a * b)
    (hba : b ≤ 3 * a) (hkb : k ≤ 3 * b) :
    max (a / h) 1 * max (b / k) 1 ≤ 3 * (a * b / (h * k)) := by
  rw [cost_eq_defect_mul_overflow ha hb hh hk]
  have ho := sorted_overflow_le_three ha hb hh hk hhk hprod hba hkb
  have hr : 0 ≤ a * b / (h * k) := by positivity
  nlinarith [mul_le_mul_of_nonneg_left ho hr]

/-- The two natural factors of x^2-1 are small enough for the larger demand. -/
theorem square_factor_size_bound {x A B : ℝ}
    (hx : 6 ≤ x) (hA : 0 < A) (hB : 0 < B)
    (heq : x * x = 6 * (A * B)) :
    x + 1 ≤ 3 * max A B := by
  let m := max A B
  have hm : 0 ≤ m := le_trans (le_of_lt hA) (le_max_left A B)
  have hAm : A ≤ m := le_max_left A B
  have hBm : B ≤ m := le_max_right A B
  have hAB : A * B ≤ m * m :=
    mul_le_mul hAm hBm (le_of_lt hB) hm
  change x + 1 ≤ 3 * m
  by_contra hn
  have hlt : 3 * m < x + 1 := lt_of_not_ge hn
  have hp : 0 < (x + 1 - 3 * m) * (x + 1 + 3 * m) :=
    mul_pos (sub_pos.mpr hlt) (by linarith)
  have hxpoly : 0 ≤ (x - 6) * (x + 2) :=
    mul_nonneg (sub_nonneg.mpr hx) (by linarith)
  nlinarith

/-- Source balance gives the sorted demand-ratio bound. -/
theorem balanced_demands {M N A B : ℝ}
    (hM : 0 < M) (hN : 0 < N)
    (hMN : M ≤ 2 * N) (hNM : N ≤ 2 * M)
    (hA : 2 * A = M) (hB : 3 * B = N) :
    max A B ≤ 3 * min A B := by
  by_cases h : A ≤ B
  · rw [max_eq_right h, min_eq_left h]
    nlinarith
  · have h' : B ≤ A := le_of_lt (lt_of_not_ge h)
    rw [max_eq_left h', min_eq_right h']
    nlinarith

/-- An exact elementary prototype of genuine first-occurrence multiplicity. -/
theorem base_eight_first_order_square :
    8 % 3 ≠ 1 ∧ (8 ^ 2 - 1) % 9 = 0 ∧ (8 ^ 2 - 1) % 27 ≠ 0 := by
  norm_num

/-- Inherited mass bounded by n has logarithmic mass at most log n. -/
theorem inherited_log_bound {J n : ℕ} (hJ : 0 < J) (hn : 0 < n) (hdiv : J ∣ n) :
    Real.log (J : ℝ) ≤ Real.log (n : ℝ) := by
  have hle : J ≤ n := Nat.le_of_dvd hn hdiv
  apply Real.log_le_log (by exact_mod_cast hJ)
  exact_mod_cast hle

#print axioms max_ratio_reciprocity
#print axioms sorted_overflow_le_three
#print axioms cost_eq_defect_mul_overflow
#print axioms sorted_cost_le_three_defect
#print axioms square_factor_size_bound
#print axioms balanced_demands
#print axioms base_eight_first_order_square
#print axioms inherited_log_bound

end ABCSquareEndpointPartition
