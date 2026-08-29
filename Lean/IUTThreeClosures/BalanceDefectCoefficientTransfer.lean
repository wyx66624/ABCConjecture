/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SymmetricProductCoefficientBarrier
import Mathlib.Tactic

/-!
# Balance defect and the coefficient-three endpoint reduction

For a positive primitive triple `a + b = c`, put

`product = log(a*b*c)` and `h = log c`.

The coefficient loss in passing from a bound for `product` to the ordinary
abc height is measured exactly by

`balanceDefect = 3*h - product`.

If `m = min(a,b)`, this file proves the sharp bounded corridor

`h - log m <= balanceDefect <= h - log m + log 2`.

Thus the missing loss is, up to the absolute constant `log 2`, precisely the
endpoint defect `log(c/m)`.  A coefficient-three product estimate already
has the correct abc coefficient on logarithmically balanced triples; only the
regime in which one summand is a fixed power smaller than `c` remains.

All statements are pointwise algebraic consequences of `a+b=c`.  No abc,
Szpiro, Vojta, IUT, or S-unit estimate is stored as data.
-/

namespace IUTThreeClosures

noncomputable section

namespace ABCPoint

/-- Logarithmic size of the smaller summand. -/
def logMinSummand (P : ABCPoint) : ℝ :=
  Real.log (((min P.a P.b : ℕ) : ℝ))

/-- Exact coefficient-three loss of the symmetric product relative to the
ordinary height. -/
def balanceDefect (P : ABCPoint) : ℝ :=
  3 * P.height - P.symmetricProductLog

/-- Endpoint imbalance `log c - log(min(a,b))`. -/
def endpointDefect (P : ABCPoint) : ℝ :=
  P.height - P.logMinSummand

/-- The abc product is at most `min(a,b) * c^2`. -/
theorem abcProduct_le_min_mul_c_sq (P : ABCPoint) :
    P.a * P.b * P.c ≤ min P.a P.b * P.c ^ 2 := by
  by_cases hab : P.a ≤ P.b
  · rw [min_eq_left hab]
    have hb : P.b ≤ P.c := Nat.le_of_lt P.b_lt_c
    calc
      P.a * P.b * P.c ≤ P.a * P.c * P.c := by
        gcongr
      _ = P.a * P.c ^ 2 := by ring
  · have hba : P.b ≤ P.a := Nat.le_of_lt (Nat.lt_of_not_ge hab)
    rw [min_eq_right hba]
    have ha : P.a ≤ P.c := Nat.le_of_lt P.a_lt_c
    calc
      P.a * P.b * P.c ≤ P.c * P.b * P.c := by
        gcongr
      _ = P.b * P.c ^ 2 := by ring

/-- Conversely, `min(a,b) * c^2` is at most twice the abc product. -/
theorem min_mul_c_sq_le_two_abcProduct (P : ABCPoint) :
    min P.a P.b * P.c ^ 2 ≤ 2 * (P.a * P.b * P.c) := by
  by_cases hab : P.a ≤ P.b
  · rw [min_eq_left hab]
    have hc : P.c ≤ 2 * P.b := by
      rw [← P.sum_eq]
      omega
    calc
      P.a * P.c ^ 2 = (P.a * P.c) * P.c := by ring
      _ ≤ (P.a * P.c) * (2 * P.b) :=
        Nat.mul_le_mul_left (P.a * P.c) hc
      _ = 2 * (P.a * P.b * P.c) := by ring
  · have hba : P.b ≤ P.a := Nat.le_of_lt (Nat.lt_of_not_ge hab)
    rw [min_eq_right hba]
    have hc : P.c ≤ 2 * P.a := by
      rw [← P.sum_eq]
      omega
    calc
      P.b * P.c ^ 2 = (P.b * P.c) * P.c := by ring
      _ ≤ (P.b * P.c) * (2 * P.a) :=
        Nat.mul_le_mul_left (P.b * P.c) hc
      _ = 2 * (P.a * P.b * P.c) := by ring

/-- Upper product corridor: `log(abc) <= log min(a,b) + 2 log c`. -/
theorem symmetricProductLog_le_logMin_add_two_height (P : ABCPoint) :
    P.symmetricProductLog ≤ P.logMinSummand + 2 * P.height := by
  have hmNat : 0 < min P.a P.b := by omega
  have hm : 0 < ((min P.a P.b : ℕ) : ℝ) := by exact_mod_cast hmNat
  have hc : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have habcNat : 0 < P.a * P.b * P.c :=
    mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos
  have habc : 0 < ((P.a * P.b * P.c : ℕ) : ℝ) := by
    exact_mod_cast habcNat
  have hreal :
      ((P.a * P.b * P.c : ℕ) : ℝ) ≤
        ((min P.a P.b : ℕ) : ℝ) * (P.c : ℝ) ^ 2 := by
    exact_mod_cast P.abcProduct_le_min_mul_c_sq
  have hlog := Real.log_le_log habc hreal
  rw [Real.log_mul hm.ne' (pow_pos hc 2).ne', Real.log_pow] at hlog
  rw [P.height_eq_log_c]
  unfold symmetricProductLog logMinSummand
  linarith

/-- Lower product corridor:
`log min(a,b) + 2 log c - log 2 <= log(abc)`. -/
theorem logMin_add_two_height_sub_log_two_le_symmetricProductLog
    (P : ABCPoint) :
    P.logMinSummand + 2 * P.height - Real.log 2 ≤
      P.symmetricProductLog := by
  have hmNat : 0 < min P.a P.b := by omega
  have hm : 0 < ((min P.a P.b : ℕ) : ℝ) := by exact_mod_cast hmNat
  have hc : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have habcNat : 0 < P.a * P.b * P.c :=
    mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos
  have habc : 0 < ((P.a * P.b * P.c : ℕ) : ℝ) := by
    exact_mod_cast habcNat
  have hleft :
      0 < ((min P.a P.b : ℕ) : ℝ) * (P.c : ℝ) ^ 2 :=
    mul_pos hm (pow_pos hc 2)
  have hreal :
      ((min P.a P.b : ℕ) : ℝ) * (P.c : ℝ) ^ 2 ≤
        2 * ((P.a * P.b * P.c : ℕ) : ℝ) := by
    exact_mod_cast P.min_mul_c_sq_le_two_abcProduct
  have hlog := Real.log_le_log hleft hreal
  rw [Real.log_mul hm.ne' (pow_pos hc 2).ne', Real.log_pow,
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) habc.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold symmetricProductLog logMinSummand
  linarith

/-- The endpoint defect is the lower endpoint of the balance-defect corridor. -/
theorem endpointDefect_le_balanceDefect (P : ABCPoint) :
    P.endpointDefect ≤ P.balanceDefect := by
  have hproduct := P.symmetricProductLog_le_logMin_add_two_height
  dsimp [endpointDefect, balanceDefect]
  linarith

/-- The two defects differ by at most the absolute constant `log 2`. -/
theorem balanceDefect_le_endpointDefect_add_log_two (P : ABCPoint) :
    P.balanceDefect ≤ P.endpointDefect + Real.log 2 := by
  have hproduct :=
    P.logMin_add_two_height_sub_log_two_le_symmetricProductLog
  dsimp [endpointDefect, balanceDefect]
  linarith

/-- Exact transfer when both the symmetric-product term and its balance defect
are controlled. -/
theorem height_le_of_symmetricProduct_and_balanceDefect
    (P : ABCPoint)
    {lambda error delta K : ℝ}
    (hdelta : delta < 3)
    (hproduct :
      P.symmetricProductLog ≤ lambda * P.conductor + error)
    (hdefect :
      P.balanceDefect ≤ delta * P.height + K) :
    P.height ≤
      (lambda * P.conductor + error + K) / (3 - delta) := by
  have hraw :
      (3 - delta) * P.height ≤
        lambda * P.conductor + error + K := by
    dsimp [balanceDefect] at hdefect
    nlinarith
  have hden : 0 < 3 - delta := sub_pos.mpr hdelta
  apply (le_div_iff₀ hden).2
  simpa [mul_comm] using hraw

/-- Equivalent endpoint formulation.  The only extra loss is the fixed
`log 2` from the exact defect corridor. -/
theorem height_le_of_symmetricProduct_and_endpointDefect
    (P : ABCPoint)
    {lambda error delta K : ℝ}
    (hdelta : delta < 3)
    (hproduct :
      P.symmetricProductLog ≤ lambda * P.conductor + error)
    (hendpoint :
      P.endpointDefect ≤ delta * P.height + K) :
    P.height ≤
      (lambda * P.conductor + error + K + Real.log 2) /
        (3 - delta) := by
  have hdefect :
      P.balanceDefect ≤ delta * P.height + (K + Real.log 2) := by
    calc
      P.balanceDefect ≤ P.endpointDefect + Real.log 2 :=
        P.balanceDefect_le_endpointDefect_add_log_two
      _ ≤ delta * P.height + (K + Real.log 2) := by
        linarith
  simpa [add_assoc] using
    (P.height_le_of_symmetricProduct_and_balanceDefect
      hdelta hproduct hdefect)

/-- A logarithmic lower bound on the smaller summand is exactly an upper bound
on the endpoint defect. -/
theorem endpointDefect_le_of_logMin_lower
    (P : ABCPoint)
    {delta K : ℝ}
    (hlogMin :
      (1 - delta) * P.height - K ≤ P.logMinSummand) :
    P.endpointDefect ≤ delta * P.height + K := by
  dsimp [endpointDefect]
  linarith

/-- Concrete coefficient-three closure on a logarithmically balanced point.
The parameter choices are exact:

`delta = 3*epsilon / (2*(1+epsilon))`

and

`lambda = 3*(1+epsilon/2)`

satisfy `lambda / (3-delta) = 1+epsilon`. -/
theorem height_le_of_coefficient_three_and_endpoint_balance
    (P : ABCPoint)
    {epsilon error K : ℝ}
    (hepsilon : 0 < epsilon)
    (hproduct :
      P.symmetricProductLog ≤
        (3 * (1 + epsilon / 2)) * P.conductor + error)
    (hendpoint :
      P.endpointDefect ≤
        (3 * epsilon / (2 * (1 + epsilon))) * P.height + K) :
    P.height ≤
      (1 + epsilon) * P.conductor +
        (error + K + Real.log 2) /
          (3 - 3 * epsilon / (2 * (1 + epsilon))) := by
  let delta : ℝ := 3 * epsilon / (2 * (1 + epsilon))
  have hone : 0 < 1 + epsilon := by linarith
  have hdenominator : 0 < 2 * (1 + epsilon) :=
    mul_pos (by norm_num) hone
  have hdelta : delta < 3 := by
    dsimp [delta]
    apply (div_lt_iff₀ hdenominator).2
    nlinarith
  have hgeneral :=
    P.height_le_of_symmetricProduct_and_endpointDefect
      (lambda := 3 * (1 + epsilon / 2))
      (error := error) (delta := delta) (K := K)
      hdelta hproduct (by simpa [delta] using hendpoint)
  have hden : 0 < 3 - delta := sub_pos.mpr hdelta
  have hscale :
      3 * (1 + epsilon / 2) =
        (3 - delta) * (1 + epsilon) := by
    dsimp [delta]
    field_simp [hone.ne']
    ring
  have hsplit :
      ((3 * (1 + epsilon / 2)) * P.conductor +
          error + K + Real.log 2) / (3 - delta) =
        (1 + epsilon) * P.conductor +
          (error + K + Real.log 2) / (3 - delta) := by
    rw [hscale]
    field_simp [hden.ne']
    ring
  have hfinal := hgeneral.trans_eq hsplit
  simpa [delta] using hfinal

/-- Same closure stated directly with a lower bound for `min(a,b)`. -/
theorem height_le_of_coefficient_three_and_logMin_balance
    (P : ABCPoint)
    {epsilon error K : ℝ}
    (hepsilon : 0 < epsilon)
    (hproduct :
      P.symmetricProductLog ≤
        (3 * (1 + epsilon / 2)) * P.conductor + error)
    (hlogMin :
      (1 - 3 * epsilon / (2 * (1 + epsilon))) * P.height - K ≤
        P.logMinSummand) :
    P.height ≤
      (1 + epsilon) * P.conductor +
        (error + K + Real.log 2) /
          (3 - 3 * epsilon / (2 * (1 + epsilon))) := by
  apply P.height_le_of_coefficient_three_and_endpoint_balance
    hepsilon hproduct
  exact P.endpointDefect_le_of_logMin_lower hlogMin

#print axioms ABCPoint.abcProduct_le_min_mul_c_sq
#print axioms ABCPoint.min_mul_c_sq_le_two_abcProduct
#print axioms ABCPoint.symmetricProductLog_le_logMin_add_two_height
#print axioms ABCPoint.logMin_add_two_height_sub_log_two_le_symmetricProductLog
#print axioms ABCPoint.endpointDefect_le_balanceDefect
#print axioms ABCPoint.balanceDefect_le_endpointDefect_add_log_two
#print axioms ABCPoint.height_le_of_symmetricProduct_and_balanceDefect
#print axioms ABCPoint.height_le_of_symmetricProduct_and_endpointDefect
#print axioms ABCPoint.endpointDefect_le_of_logMin_lower
#print axioms ABCPoint.height_le_of_coefficient_three_and_endpoint_balance
#print axioms ABCPoint.height_le_of_coefficient_three_and_logMin_balance

end ABCPoint
end
end IUTThreeClosures
