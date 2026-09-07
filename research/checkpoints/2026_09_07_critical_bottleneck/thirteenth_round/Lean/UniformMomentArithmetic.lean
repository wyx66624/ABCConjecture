import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Data.Nat.Sqrt
import Mathlib.Tactic

/-! Numeric and complete finite-depth interfaces for the reviewed UM proof.
No prime-group, independence, or unbounded-tail hypothesis is discharged
by these bounded arithmetic statements. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 2000000
noncomputable section
namespace ABCUniformMoment20260907

theorem six_choose_three (r : Nat) :
    6 * (r + 3).choose 3 = (r + 1) * (r + 2) * (r + 3) := by
  have htwo := Nat.add_one_mul_choose_eq (r + 1) 1
  simp only [Nat.choose_one_right] at htwo
  have hthree := Nat.add_one_mul_choose_eq (r + 2) 2
  have hmul := congrArg (fun x : Nat => x * (r + 3)) htwo
  nlinarith

theorem choose_three_exceeds_three_n (n r : Nat) (hn : 324 < n)
    (hr : n ≤ r ^ 2) : 3 * n < (r + 3).choose 3 := by
  have hrbig : 18 < r := by
    by_contra h
    have hs := Nat.pow_le_pow_left (by omega : r ≤ 18) 2
    norm_num at hs
    omega
  have hprod : 18 * r ^ 2 < r ^ 3 := by
    have hp : 0 < r ^ 2 := by positivity
    have hm := Nat.mul_lt_mul_of_pos_right hrbig hp
    nlinarith
  have hc := six_choose_three r
  nlinarith

theorem count_le_three_of_multiset_bound (M n r : Nat) (hn : 324 < n)
    (hr : n ≤ r ^ 2) (hcount : (M + r - 1).choose r ≤ 3 * n) :
    M ≤ 3 := by
  by_contra h
  have hM : 4 ≤ M := by omega
  have hmono := Nat.choose_le_choose r (show r + 3 ≤ M + r - 1 by omega)
  have hsymm : (r + 3).choose r = (r + 3).choose 3 :=
    Nat.choose_symm_add
  have hlarge := choose_three_exceeds_three_n n r hn hr
  omega

theorem explicit_root_threshold (n : Nat) (hn : 0 < n) :
    n ≤ (Nat.sqrt n + 1) ^ 2 ∧ (Nat.sqrt n + 1) ^ 2 ≤ 4 * n := by
  have hlow := Nat.lt_succ_sqrt' n
  have hsq := Nat.sqrt_le' n
  have hpos := Nat.sqrt_pos.mpr hn
  constructor
  · simpa only [Nat.succ_eq_add_one] using Nat.le_of_lt hlow
  · nlinarith

theorem count_le_three_at_explicit_threshold (M n : Nat) (hn : 324 < n)
    (hcount : (M + Nat.sqrt n).choose (Nat.sqrt n + 1) ≤ 3 * n) :
    M ≤ 3 := by
  have hr := (explicit_root_threshold n (by omega)).1
  apply count_le_three_of_multiset_bound M n (Nat.sqrt n + 1) hn hr
  have heq : M + (Nat.sqrt n + 1) - 1 = M + Nat.sqrt n := by omega
  rw [heq]
  exact hcount

theorem low_layer_count_bound (n r M : Nat) (hr : r ^ 2 ≤ 4 * n)
    (hM : M ^ 2 ≤ 6 * n) : 2 * r * M ≤ 10 * n := by
  have hm := Nat.mul_le_mul hr hM
  nlinarith [sq_nonneg (2 * (r : Int) * M - 10 * n)]

def countAbove : List Nat → Nat → Nat
  | [], _ => 0
  | e :: ds, h => (if h ≤ e then 1 else 0) + countAbove ds h

def excessSum (ds : List Nat) : Nat :=
  (ds.map fun e => e - 3).sum

theorem countAbove_eq_filter_length (ds : List Nat) (h : Nat) :
    countAbove ds h = (ds.filter fun e => decide (h ≤ e)).length := by
  induction ds with
  | nil => simp [countAbove]
  | cons e ds ih =>
    by_cases he : h ≤ e <;> simp [countAbove, he, ih, Nat.add_comm]

theorem pointwise_complete_excess (e h H : Nat) (hh : 4 ≤ h) (he : e ≤ H) :
    e - 3 ≤ h * (if 4 ≤ e then 1 else 0) +
      H * (if h ≤ e then 1 else 0) := by
  split_ifs <;> omega

theorem finite_complete_excess (ds : List Nat) (h H : Nat) (hh : 4 ≤ h)
    (hcap : ∀ e ∈ ds, e ≤ H) :
    excessSum ds ≤ h * countAbove ds 4 + H * countAbove ds h := by
  induction ds with
  | nil => simp [excessSum, countAbove]
  | cons e ds ih =>
    have he := hcap e (by simp)
    have ht : ∀ e ∈ ds, e ≤ H := by
      intro x hx
      exact hcap x (by simp [hx])
    have hi := ih ht
    have hp := pointwise_complete_excess e h H hh he
    simp only [excessSum, List.map_cons, List.sum_cons] at *
    simp only [countAbove]
    nlinarith

theorem actual_depth_list_budget (ds : List Nat) (n r H : Nat)
    (hrlow : 4 ≤ 2 * r) (hrhigh : r ^ 2 ≤ 4 * n)
    (hcap : ∀ e ∈ ds, e ≤ H)
    (hlow : (countAbove ds 4) ^ 2 ≤ 6 * n)
    (hhigh : countAbove ds (2 * r) ≤ 3) :
    excessSum ds ≤ 10 * n + 3 * H := by
  have hf := finite_complete_excess ds (2 * r) H hrlow hcap
  have hl := low_layer_count_bound n r (countAbove ds 4) hrhigh hlow
  have hh := Nat.mul_le_mul_left H hhigh
  nlinarith

theorem weighted_complete_prime_budget (ds : List Nat) (n r H : Nat)
    (w L : Real) (hw : 0 ≤ w)
    (hrlow : 4 ≤ 2 * r) (hrhigh : r ^ 2 ≤ 4 * n)
    (hcap : ∀ e ∈ ds, e ≤ H)
    (hlow : (countAbove ds 4) ^ 2 ≤ 6 * n)
    (hhigh : countAbove ds (2 * r) ≤ 3)
    (hheight : (H : Real) * w ≤ 3 * n * L) :
    (excessSum ds : Real) * w ≤ 10 * n * w + 9 * n * L := by
  have hf := actual_depth_list_budget ds n r H hrlow hrhigh hcap hlow hhigh
  have hfr : (excessSum ds : Real) ≤ 10 * n + 3 * H := by exact_mod_cast hf
  have hm := mul_le_mul_of_nonneg_right hfr hw
  nlinarith

theorem actual_depth_budget_from_multisets (ds : List Nat) (n H : Nat)
    (hn : 324 < n) (hcap : ∀ e ∈ ds, e ≤ H)
    (hlow : (countAbove ds 4) ^ 2 ≤ 6 * n)
    (hmultisets :
      (countAbove ds (2 * (Nat.sqrt n + 1)) + Nat.sqrt n).choose
        (Nat.sqrt n + 1) ≤ 3 * n) :
    excessSum ds ≤ 10 * n + 3 * H := by
  have hr := explicit_root_threshold n (by omega)
  have hrlow : 4 ≤ 2 * (Nat.sqrt n + 1) := by
    have hs := Nat.sqrt_pos.mpr (show 0 < n by omega)
    omega
  have hh := count_le_three_at_explicit_threshold _ n hn hmultisets
  exact actual_depth_list_budget ds n (Nat.sqrt n + 1) H
    hrlow hr.2 hcap hlow hh

theorem weighted_prime_budget_from_multisets (ds : List Nat) (n H : Nat)
    (w L : Real) (hw : 0 ≤ w) (hn : 324 < n)
    (hcap : ∀ e ∈ ds, e ≤ H) (hlow : (countAbove ds 4) ^ 2 ≤ 6 * n)
    (hmultisets :
      (countAbove ds (2 * (Nat.sqrt n + 1)) + Nat.sqrt n).choose
        (Nat.sqrt n + 1) ≤ 3 * n)
    (hheight : (H : Real) * w ≤ 3 * n * L) :
    (excessSum ds : Real) * w ≤ 10 * n * w + 9 * n * L := by
  have hf := actual_depth_budget_from_multisets ds n H hn hcap hlow hmultisets
  have hfr : (excessSum ds : Real) ≤ 10 * n + 3 * H := by exact_mod_cast hf
  have hm := mul_le_mul_of_nonneg_right hfr hw
  nlinarith

theorem normalized_prime_budget (E B n w L s : Real) (hB : 0 < B)
    (hn : 0 < n) (hs : 0 < s)
    (hE : E ≤ 10 * n * w + 9 * n * L) (hw : w ≤ 2 * s)
    (hL : L ≤ 2 * s) :
    E / (B * n * s) ≤ 38 / B := by
  have hmulw := mul_le_mul_of_nonneg_left hw (show 0 ≤ 10 * n by positivity)
  have hmulL := mul_le_mul_of_nonneg_left hL (show 0 ≤ 9 * n by positivity)
  have hnum : E ≤ 38 * n * s := by nlinarith
  apply (div_le_iff₀ (by positivity : 0 < B * n * s)).2
  have hb : B ≠ 0 := ne_of_gt hB
  field_simp
  nlinarith

theorem normalized_progression_budget (E B n Z ell : Real)
    (hB : 0 < B) (hn : 324 < n) (hZ : 0 ≤ Z) (hell : 0 < ell)
    (hE : E ≤ 76 * Z / (B * (n - 1) * ell)) :
    E ≤ 80 * Z / (B * n * ell) := by
  have hbn : 0 < B * n * ell := by positivity
  have hprev : 0 < n - 1 := by linarith
  have hbprev : 0 < B * (n - 1) * ell := by positivity
  apply hE.trans
  apply (div_le_div_iff₀ hbprev hbn).2
  have hzmul : 0 ≤ Z * B * ell := by positivity
  have hnmult := mul_nonneg (show 0 ≤ 4 * n - 80 by linarith) hzmul
  nlinarith

#print axioms six_choose_three
#print axioms choose_three_exceeds_three_n
#print axioms count_le_three_of_multiset_bound
#print axioms explicit_root_threshold
#print axioms count_le_three_at_explicit_threshold
#print axioms low_layer_count_bound
#print axioms countAbove_eq_filter_length
#print axioms pointwise_complete_excess
#print axioms finite_complete_excess
#print axioms actual_depth_list_budget
#print axioms weighted_complete_prime_budget
#print axioms actual_depth_budget_from_multisets
#print axioms weighted_prime_budget_from_multisets
#print axioms normalized_prime_budget
#print axioms normalized_progression_budget
end ABCUniformMoment20260907
