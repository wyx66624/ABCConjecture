import AdaptiveOwnerArithmetic
import Mathlib.Tactic

/-! Finite signed-count arithmetic and complete single-owner depth budgets.
Arithmetic residue groups and their rigidity maps are separate inputs. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCSignedMoment20260907
open ABCAdaptiveOwner20260907 ABCUniformMoment20260907
open scoped BigOperators

def ballCount (M r : Nat) : Nat :=
  ∑ j ∈ Finset.range (r + 1), 2 ^ j * M.choose j * r.choose j

theorem ballCount_radius_two (M : Nat) :
    ballCount M 2 = 2 * M ^ 2 + 2 * M + 1 := by
  cases M with
  | zero => norm_num [ballCount, Finset.sum_range_succ]
  | succ m =>
    have hc := Nat.add_one_mul_choose_eq m 1
    simp only [Nat.choose_one_right] at hc
    simp only [ballCount, Finset.sum_range_succ, Finset.sum_range_zero]
    norm_num
    nlinarith

theorem ballCount_radius_three (M : Nat) :
    3 * ballCount M 3 = 4 * M ^ 3 + 6 * M ^ 2 + 8 * M + 3 := by
  rcases M with _ | _ | _ | m
  · norm_num [ballCount, Finset.sum_range_succ, Nat.choose]
  · norm_num [ballCount, Finset.sum_range_succ, Nat.choose]
  · norm_num [ballCount, Finset.sum_range_succ, Nat.choose]
  · have htwo := Nat.add_one_mul_choose_eq (m + 2) 1
    simp only [Nat.choose_one_right] at htwo
    have hthree := six_choose_three m
    simp only [ballCount, Finset.sum_range_succ, Finset.sum_range_zero]
    norm_num
    nlinarith

theorem ballCount_two_coordinates (r : Nat) :
    ballCount 2 r = 2 * r ^ 2 + 2 * r + 1 := by
  have heq : ballCount 2 r = ballCount r 2 := by
    by_cases hr : r < 2
    · interval_cases r <;> norm_num [ballCount, Finset.sum_range_succ]
    · have hsub : Finset.range 3 ⊆ Finset.range (r + 1) :=
        Finset.range_mono (by omega)
      have hsum : (∑ j ∈ Finset.range 3, 2 ^ j * (2 : Nat).choose j * r.choose j) =
          ∑ j ∈ Finset.range (r + 1), 2 ^ j * (2 : Nat).choose j * r.choose j :=
        Finset.sum_subset hsub (fun j _hj hjout ↦ by
        have hlarge : 2 < j := by
          simp only [Finset.mem_range, not_lt] at hjout
          omega
        simp [Nat.choose_eq_zero_of_lt hlarge])
      unfold ballCount
      rw [← hsum]
      apply Finset.sum_congr rfl
      intro j hj
      ring
  rw [heq, ballCount_radius_two]

theorem ballCount_mono (M N r : Nat) (h : M ≤ N) :
    ballCount M r ≤ ballCount N r := by
  apply Finset.sum_le_sum
  intro j hj
  exact Nat.mul_le_mul_right _ (Nat.mul_le_mul_left _ (Nat.choose_le_choose j h))

theorem signed_low_count (M n : Nat) (h : ballCount M 2 ≤ n) :
    2 * M ^ 2 ≤ n := by
  rw [ballCount_radius_two] at h
  omega

theorem signed_cubic_count (M n : Nat) (h : ballCount M 3 ≤ n) :
    4 * M ^ 3 ≤ 3 * n := by
  have hc := ballCount_radius_three M
  omega

theorem signed_count_le_one (M n r : Nat) (hn : n ≤ 2 * r ^ 2)
    (h : ballCount M r ≤ n) : M ≤ 1 := by
  by_contra hm
  have hc := (ballCount_mono 2 M r (by omega)).trans h
  rw [ballCount_two_coordinates] at hc
  omega

theorem count_le_one_of_actual_diamond (M n r : Nat) (hn : n ≤ 2 * r ^ 2)
    (hdiamond : 2 ≤ M → 2 * r ^ 2 + 2 * r + 1 ≤ n) : M ≤ 1 := by
  by_contra h
  have hc := hdiamond (by omega)
  omega

theorem half_root_threshold (n : Nat) :
    0 < Nat.sqrt (n / 2) + 1 ∧ n ≤ 2 * (Nat.sqrt (n / 2) + 1) ^ 2 := by
  have hlo := Nat.lt_succ_sqrt' (n / 2)
  have hrem := Nat.mod_lt n (by decide : 0 < 2)
  have heq := Nat.mod_add_div n 2
  simp only [Nat.succ_eq_add_one] at hlo
  constructor
  · omega
  · omega

theorem half_root_threshold_upper (n : Nat) (hn : 18 ≤ n) :
    (Nat.sqrt (n / 2) + 1) ^ 2 ≤ n := by
  have hlo := Nat.lt_succ_sqrt' (n / 2)
  have hsq := Nat.sqrt_le' (n / 2)
  have hdiv : 9 ≤ n / 2 := by omega
  have hroot : 3 ≤ Nat.sqrt (n / 2) := by
    by_contra h
    have hb := Nat.pow_le_pow_left (show Nat.sqrt (n / 2) + 1 ≤ 3 by omega) 2
    norm_num at hb
    simp only [Nat.succ_eq_add_one] at hlo
    omega
  have hprod := Nat.mul_le_mul_left (Nat.sqrt (n / 2) - 1) hroot
  have hdiv2 : 2 * (n / 2) ≤ n := Nat.mul_div_le n 2
  nlinarith

theorem signed_low_layer_coefficient (n r M : Nat)
    (hr : r ^ 2 ≤ n) (hM : 2 * M ^ 2 ≤ n) : 4 * r * M ≤ 3 * n := by
  have hsq := sq_nonneg ((r : Int) - 2 * M)
  have hrr : (r : Int) ^ 2 ≤ n := by exact_mod_cast hr
  have hmm : 2 * (M : Int) ^ 2 ≤ n := by exact_mod_cast hM
  have hres : 4 * (r : Int) * M ≤ 3 * n := by nlinarith
  exact_mod_cast hres

variable {I : Type*} [DecidableEq I]

theorem exists_one_maximal (s : Finset I) (e : I → Nat) :
    ∃ O : Finset I, O ⊆ s ∧ O.card = min 1 s.card ∧
      ∀ i ∈ s \ O, ∀ j ∈ O, e i ≤ e j := by
  classical
  by_cases hs : s.Nonempty
  · obtain ⟨a, ha, hmax⟩ := s.exists_max_image e hs
    have hc : 1 ≤ s.card := Finset.card_pos.mpr hs
    refine ⟨{a}, by simpa, by simp [min_eq_left hc], ?_⟩
    intro i hi j hj
    have hja : j = a := Finset.mem_singleton.mp hj
    subst j
    exact hmax i (Finset.mem_sdiff.mp hi).1
  · have he : s = ∅ := Finset.not_nonempty_iff_eq_empty.mp hs
    subst s
    exact ⟨∅, by simp, by simp, by simp⟩

theorem one_maximal_contains_deep (s O : Finset I) (e : I → Nat) (h : Nat)
    (hsub : O ⊆ s) (hcard : O.card = min 1 s.card)
    (hmax : ∀ i ∈ s \ O, ∀ j ∈ O, e i ≤ e j)
    (hdeep : (s.filter (fun i ↦ h ≤ e i)).card ≤ 1) :
    s.filter (fun i ↦ h ≤ e i) ⊆ O := by
  intro i hi
  by_contra hiO
  have his := (Finset.mem_filter.mp hi).1
  have hie := (Finset.mem_filter.mp hi).2
  by_cases hs : s.card ≤ 1
  · have hsame : O = s := Finset.eq_of_subset_of_card_le hsub (by omega)
    exact hiO (hsame ▸ his)
  · have hc : O.card = 1 := by omega
    have hins : insert i O ⊆ s.filter (fun j ↦ h ≤ e j) := by
      intro j hj
      rcases Finset.mem_insert.mp hj with rfl | hj
      · exact hi
      · exact Finset.mem_filter.mpr
          ⟨hsub hj, hie.trans (hmax i (Finset.mem_sdiff.mpr ⟨his, hiO⟩) j hj)⟩
    have htwo : (insert i O).card = 2 := by simp [hiO, hc]
    have hle := Finset.card_le_card hins
    omega

theorem complete_one_range_budget (s O : Finset I) (e : I → Nat)
    (h r : Nat) (L w : Real) (hw : 0 ≤ w) (h4 : 4 ≤ h)
    (hdeep : s.filter (fun i ↦ h ≤ e i) ⊆ O)
    (hceil : ((h - 4 : Nat) : Real) * w ≤ 2 * r * L) :
    (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) * w ≤
      2 * r * ((s.filter (fun i ↦ 4 ≤ e i)).card : Real) * L := by
  have hnat := complete_finite_middle_budget s O e 4 h (by omega) h4 hdeep
  simp only [Nat.sub_self, zero_mul, zero_add] at hnat
  have hreal : (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) ≤
      ((h - 4 : Nat) : Real) * (s.filter (fun i ↦ 4 ≤ e i)).card := by
    exact_mod_cast hnat
  have hwgt := mul_le_mul_of_nonneg_right hreal hw
  have hcnt := mul_le_mul_of_nonneg_right hceil
    (Nat.cast_nonneg (α := Real) (s.filter (fun i ↦ 4 ≤ e i)).card)
  nlinarith

omit [DecidableEq I] in
theorem removed_one_cost (s O : Finset I) (e : I → Nat)
    (w cap : Real) (hsub : O ⊆ s) (hcard : O.card ≤ 1)
    (hw : 0 ≤ w) (hcap : 0 ≤ cap)
    (he : ∀ i ∈ s, (e i : Real) * w ≤ cap) :
    (((∑ i ∈ O, (e i - 3)) : Nat) : Real) * w ≤ cap := by
  have hone : ∀ i ∈ O, ((e i - 3 : Nat) : Real) * w ≤ cap := by
    intro i hi
    have hn : e i - 3 ≤ e i := Nat.sub_le _ _
    have hr : ((e i - 3 : Nat) : Real) ≤ (e i : Real) := by exact_mod_cast hn
    exact (mul_le_mul_of_nonneg_right hr hw).trans (he i (hsub hi))
  have hsum := Finset.sum_le_sum hone
  have hc : (O.card : Real) ≤ 1 := by exact_mod_cast hcard
  have hc' := mul_le_mul_of_nonneg_right hc hcap
  rw [Nat.cast_sum, Finset.sum_mul]
  calc
    ∑ i ∈ O, ((e i - 3 : Nat) : Real) * w ≤ ∑ _i ∈ O, cap := hsum
    _ = (O.card : Real) * cap := by simp
    _ ≤ cap := by simpa using hc'

theorem finite_global_from_one_cost (s O : Finset I) (e : I → Nat)
    (w cap budget : Real) (hsub : O ⊆ s) (hcard : O.card ≤ 1)
    (hw : 0 ≤ w) (hcap : 0 ≤ cap)
    (he : ∀ i ∈ s, (e i : Real) * w ≤ cap)
    (hremaining : (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) * w ≤ budget) :
    (((∑ i ∈ s, (e i - 3)) : Nat) : Real) * w ≤ cap + budget := by
  have hremoved := removed_one_cost s O e w cap hsub hcard hw hcap he
  have hsum : (∑ i ∈ s \ O, (e i - 3)) +
      (∑ i ∈ O, (e i - 3)) = ∑ i ∈ s, (e i - 3) := Finset.sum_sdiff hsub
  have hr : (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) +
      (((∑ i ∈ O, (e i - 3)) : Nat) : Real) =
      (((∑ i ∈ s, (e i - 3)) : Nat) : Real) := by exact_mod_cast hsum
  nlinarith

theorem actual_single_owner_budget (s : Finset I) (e : I → Nat)
    (n r : Nat) (L w : Real) (hr : r ^ 2 ≤ n)
    (hL : 0 ≤ L) (hw : 0 < w)
    (he : ∀ i ∈ s, (e i : Real) * w ≤ n * L)
    (hlow : 2 * (s.filter (fun i ↦ 4 ≤ e i)).card ^ 2 ≤ n)
    (hhigh :
      (s.filter (fun i ↦ max 4 (Nat.ceil (2 * r * L / w)) ≤ e i)).card ≤ 1) :
    ∃ O : Finset I, O ⊆ s ∧ O.card = min 1 s.card ∧
      (∀ i ∈ s \ O, ∀ j ∈ O, e i ≤ e j) ∧
      (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) * w ≤
        2 * r * ((s.filter (fun i ↦ 4 ≤ e i)).card : Real) * L ∧
      2 * (((∑ i ∈ s, (e i - 3)) : Nat) : Real) * w ≤ 5 * n * L := by
  let h := max 4 (Nat.ceil (2 * r * L / w))
  obtain ⟨h4, _hprec, hceil⟩ := adaptive_ceiling_bounds L w r hL hw
  obtain ⟨O, hsub, hcard, hmax⟩ := exists_one_maximal s e
  have hdeep := one_maximal_contains_deep s O e h hsub hcard hmax hhigh
  have hbudget := complete_one_range_budget s O e h r L w hw.le h4 hdeep hceil
  have hc : O.card ≤ 1 := by omega
  have ht := finite_global_from_one_cost s O e w (n * L) _ hsub hc hw.le
    (by positivity) he hbudget
  have hcoef := signed_low_layer_coefficient n r _ hr hlow
  have hcoefr : 4 * (r : Real) * (s.filter (fun i ↦ 4 ≤ e i)).card ≤ 3 * n := by
    exact_mod_cast hcoef
  have hmul := mul_le_mul_of_nonneg_right hcoefr hL
  exact ⟨O, hsub, hcard, hmax, hbudget, by nlinarith⟩

theorem single_owner_budget_from_signed_counts (s : Finset I) (e : I → Nat)
    (n r : Nat) (L w : Real) (hrlo : n ≤ 2 * r ^ 2) (hrhi : r ^ 2 ≤ n)
    (hL : 0 ≤ L) (hw : 0 < w)
    (he : ∀ i ∈ s, (e i : Real) * w ≤ n * L)
    (hlow : ballCount (s.filter (fun i ↦ 4 ≤ e i)).card 2 ≤ n)
    (hhigh : ballCount
      (s.filter (fun i ↦ max 4 (Nat.ceil (2 * r * L / w)) ≤ e i)).card r ≤ n) :
    ∃ O : Finset I, O ⊆ s ∧ O.card = min 1 s.card ∧
      (∀ i ∈ s \ O, ∀ j ∈ O, e i ≤ e j) ∧
      (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) * w ≤
        2 * r * ((s.filter (fun i ↦ 4 ≤ e i)).card : Real) * L ∧
      2 * (((∑ i ∈ s, (e i - 3)) : Nat) : Real) * w ≤ 5 * n * L := by
  exact actual_single_owner_budget s e n r L w hrhi hL hw he
    (signed_low_count _ n hlow) (signed_count_le_one _ n r hrlo hhigh)

theorem actual_one_owner_two_range (s : Finset I) (e : I → Nat)
    (r : Nat) (L w cap : Real) (hL : 0 ≤ L) (hw : 0 < w) (hcap : 0 ≤ cap)
    (he : ∀ i ∈ s, (e i : Real) * w ≤ cap)
    (hhigh :
      let h0 := max 4 (Nat.ceil (6 * L / w))
      let h1 := max h0 (Nat.ceil (2 * r * L / w))
      (s.filter (fun i ↦ h1 ≤ e i)).card ≤ 1) :
    let h0 := max 4 (Nat.ceil (6 * L / w))
    let budget := (6 * ((s.filter (fun i ↦ 4 ≤ e i)).card : Real) +
      2 * r * ((s.filter (fun i ↦ h0 ≤ e i)).card : Real)) * L
    ∃ O : Finset I, O ⊆ s ∧ O.card = min 1 s.card ∧
      (∀ i ∈ s \ O, ∀ j ∈ O, e i ≤ e j) ∧
      (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) * w ≤ budget ∧
      (((∑ i ∈ s, (e i - 3)) : Nat) : Real) * w ≤ cap + budget := by
  dsimp only at hhigh ⊢
  let h0 := max 4 (Nat.ceil (6 * L / w))
  let h1 := max h0 (Nat.ceil (2 * r * L / w))
  obtain ⟨h4, h01, _hp0, _hp1, hlow, hceil⟩ := two_stage_ceiling_bounds L w r hL hw
  obtain ⟨O, hsub, hcard, hmax⟩ := exists_one_maximal s e
  have hdeep := one_maximal_contains_deep s O e h1 hsub hcard hmax hhigh
  have hbudget := weighted_finite_middle_budget s O e h0 h1 r L w hw.le
    h4 h01 hdeep hlow hceil
  have hc : O.card ≤ 1 := by omega
  exact ⟨O, hsub, hcard, hmax, hbudget,
    finite_global_from_one_cost s O e w cap _ hsub hc hw.le hcap he hbudget⟩

theorem single_prime_budget_at_natural_threshold (s : Finset I) (e : I → Nat)
    (n : Nat) (L w : Real) (hn : 18 ≤ n) (hL : 0 ≤ L) (hw : 0 < w)
    (he : ∀ i ∈ s, (e i : Real) * w ≤ n * L)
    (hlow : ballCount (s.filter (fun i ↦ 4 ≤ e i)).card 2 ≤ n)
    (hhigh : ballCount
      (s.filter (fun i ↦ max 4
        (Nat.ceil (2 * ((Nat.sqrt (n / 2) + 1 : Nat) : Real) * L / w)) ≤ e i)).card
      (Nat.sqrt (n / 2) + 1) ≤ n) :
    2 * (((∑ i ∈ s, (e i - 3)) : Nat) : Real) * w ≤ 5 * n * L := by
  obtain ⟨_O, _hsub, _hcard, _hmax, _hrem, htotal⟩ :=
    single_owner_budget_from_signed_counts s e n (Nat.sqrt (n / 2) + 1) L w
      (half_root_threshold n).2 (half_root_threshold_upper n hn) hL hw he hlow hhigh
  exact htotal

omit [DecidableEq I] in
theorem normalized_actual_prime_budget (s : Finset I) (e : I → Nat)
    (t : I → Real) (n : Nat) (L w B t0 : Real)
    (hB : 0 < B) (ht0 : 0 < t0) (hw : 0 ≤ w)
    (ht : ∀ i ∈ s, t0 ≤ t i) (hheight : n * L ≤ 2 * t0)
    (hcost : 2 * (((∑ i ∈ s, (e i - 3)) : Nat) : Real) * w ≤ 5 * n * L) :
    (∑ i ∈ s, ((e i - 3 : Nat) : Real) * w / t i) / B ≤ 5 / B := by
  have hper : ∀ i ∈ s,
      ((e i - 3 : Nat) : Real) * w / t i ≤
      ((e i - 3 : Nat) : Real) * w / t0 := by
    intro i hi
    apply div_le_div_of_nonneg_left (by positivity) ht0 (ht i hi)
  have hsum := Finset.sum_le_sum hper
  have htotal : (∑ i ∈ s, ((e i - 3 : Nat) : Real) * w / t0) =
      (((∑ i ∈ s, (e i - 3)) : Nat) : Real) * w / t0 := by
    rw [← Finset.sum_div, ← Finset.sum_mul, ← Nat.cast_sum]
  have htop : (((∑ i ∈ s, (e i - 3)) : Nat) : Real) * w ≤ 5 * t0 := by
    nlinarith
  have hbound : (∑ i ∈ s, ((e i - 3 : Nat) : Real) * w / t i) ≤ 5 := by
    rw [htotal] at hsum
    exact hsum.trans ((div_le_iff₀ ht0).2 htop)
  exact (div_le_div_iff_of_pos_right hB).2 hbound

theorem signed_progression_normalization (E B n Z ell : Real)
    (hB : 0 < B) (hn : 11 ≤ n) (hZ : 0 ≤ Z) (hell : 0 < ell)
    (hE : E ≤ 10 * Z / (B * (n - 1) * ell)) :
    E ≤ 11 * Z / (B * n * ell) := by
  have hbn : 0 < B * n * ell := by positivity
  have hn1 : 0 < n - 1 := by linarith
  have hbprev : 0 < B * (n - 1) * ell := by positivity
  apply hE.trans
  apply (div_le_div_iff₀ hbprev hbn).2
  have hz : 0 ≤ Z * B * ell := by positivity
  have hh := mul_nonneg (show 0 ≤ n - 11 by linarith) hz
  nlinarith

#print axioms ballCount_radius_two
#print axioms ballCount_radius_three
#print axioms ballCount_two_coordinates
#print axioms ballCount_mono
#print axioms signed_low_count
#print axioms signed_cubic_count
#print axioms signed_count_le_one
#print axioms count_le_one_of_actual_diamond
#print axioms half_root_threshold
#print axioms half_root_threshold_upper
#print axioms signed_low_layer_coefficient
#print axioms exists_one_maximal
#print axioms one_maximal_contains_deep
#print axioms complete_one_range_budget
#print axioms removed_one_cost
#print axioms finite_global_from_one_cost
#print axioms actual_single_owner_budget
#print axioms single_owner_budget_from_signed_counts
#print axioms actual_one_owner_two_range
#print axioms single_prime_budget_at_natural_threshold
#print axioms normalized_actual_prime_budget
#print axioms signed_progression_normalization
end ABCSignedMoment20260907
