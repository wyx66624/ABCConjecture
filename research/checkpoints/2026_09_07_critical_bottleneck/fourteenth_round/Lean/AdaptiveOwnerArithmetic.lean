import UniformMomentArithmetic
import Mathlib.Data.Finset.Max
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Tactic

/-! Finite adaptive precision and the actual two largest depth indices.
The arithmetic construction of depths, torsion groups and norm density
is outside this module. -/
set_option autoImplicit false
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCAdaptiveOwner20260907
open ABCUniformMoment20260907
open scoped BigOperators

theorem cubic_count_bound (M n : Nat)
    (h : (M + 2).choose 3 ≤ 3 * n) : M ^ 3 ≤ 18 * n := by
  cases M with
  | zero => simp
  | succ m =>
    have hc := six_choose_three m
    change (m + 3).choose 3 ≤ 3 * n at h
    change (m + 1) ^ 3 ≤ 18 * n
    nlinarith

theorem count_le_two (M n r : Nat) (hr : 0 < r)
    (hn : 6 * n ≤ r ^ 2)
    (h : (M + r - 1).choose r ≤ 3 * n) : M ≤ 2 := by
  by_contra hm
  have hM : 3 ≤ M := by omega
  have hi : r + 2 ≤ M + r - 1 := by omega
  have hc : (r + 2).choose r ≤ 3 * n :=
    (Nat.choose_le_choose r hi).trans h
  have hs : (r + 2).choose r = (r + 2).choose 2 := by
    have he : r + 2 - r = 2 := by omega
    simpa only [he] using (Nat.choose_symm (by omega : r ≤ r + 2)).symm
  have hf := Nat.add_one_mul_choose_eq (r + 1) 1
  simp only [Nat.choose_one_right] at hf
  rw [hs] at hc
  nlinarith

theorem adaptive_ceiling_bounds (L w : Real) (r : Nat)
    (hL : 0 ≤ L) (hw : 0 < w) :
    let h := max 4 (Nat.ceil (2 * r * L / w))
    4 ≤ h ∧ 2 * r * L ≤ (h : Real) * w ∧
      ((h - 4 : Nat) : Real) * w ≤ 2 * r * L := by
  dsimp
  have hx : 0 ≤ 2 * (r : Real) * L / w := by positivity
  have hc := Nat.le_ceil (2 * (r : Real) * L / w)
  have hlt := Nat.ceil_lt_add_one hx
  have hm : Nat.ceil (2 * (r : Real) * L / w) ≤
      max 4 (Nat.ceil (2 * (r : Real) * L / w)) := Nat.le_max_right _ _
  have hmr : ((Nat.ceil (2 * (r : Real) * L / w) : Nat) : Real) ≤
      (max 4 (Nat.ceil (2 * (r : Real) * L / w)) : Nat) := by exact_mod_cast hm
  have hlow : 4 ≤ max 4 (Nat.ceil (2 * (r : Real) * L / w)) := Nat.le_max_left _ _
  refine ⟨hlow, ?_, ?_⟩
  · exact (div_le_iff₀ hw).mp (hc.trans hmr)
  · rw [Nat.cast_sub hlow]
    by_cases hh : Nat.ceil (2 * (r : Real) * L / w) ≤ 4
    · rw [max_eq_left hh]
      norm_num
      positivity
    · have heq : max 4 (Nat.ceil (2 * (r : Real) * L / w)) =
          Nat.ceil (2 * (r : Real) * L / w) := max_eq_right (by omega)
      rw [heq]
      have hmul := (mul_lt_mul_of_pos_right hlt hw)
      have hcancel : (2 * (r : Real) * L / w) * w = 2 * r * L := by field_simp
      nlinarith

theorem complete_middle_layers (e h0 h1 : Nat)
    (h4 : 4 ≤ h0) (h01 : h0 ≤ h1) (he : e < h1) :
    e - 3 ≤ (h0 - 4) * (if 4 ≤ e then 1 else 0) +
      (h1 - h0) * (if h0 ≤ e then 1 else 0) := by
  split_ifs <;> omega

variable {I : Type*} [DecidableEq I]

theorem exists_two_maximal (s : Finset I) (e : I → Nat) :
    ∃ O : Finset I, O ⊆ s ∧ O.card = min 2 s.card ∧
      ∀ i ∈ s \ O, ∀ j ∈ O, e i ≤ e j := by
  classical
  by_cases hs : s.Nonempty
  · obtain ⟨a, ha, hmaxa⟩ := s.exists_max_image e hs
    by_cases he : (s.erase a).Nonempty
    · obtain ⟨b, hb, hmaxb⟩ := (s.erase a).exists_max_image e he
      have hba : b ≠ a := (Finset.mem_erase.mp hb).1
      have hbs : b ∈ s := (Finset.mem_erase.mp hb).2
      have hsub : ({a, b} : Finset I) ⊆ s := by
        intro j hj
        simp only [Finset.mem_insert, Finset.mem_singleton] at hj
        rcases hj with rfl | rfl <;> assumption
      have hcard : ({a, b} : Finset I).card = 2 := by simp [Ne.symm hba]
      have hsize : 2 ≤ s.card := hcard ▸ Finset.card_le_card hsub
      refine ⟨{a, b}, hsub, ?_, ?_⟩
      · rw [hcard, min_eq_left hsize]
      · intro i hi j hj
        have his := (Finset.mem_sdiff.mp hi).1
        have hio := (Finset.mem_sdiff.mp hi).2
        have hia : i ≠ a := by
          intro h
          apply hio
          simp [h]
        simp only [Finset.mem_insert, Finset.mem_singleton] at hj
        rcases hj with rfl | rfl
        · exact hmaxa i his
        · exact hmaxb i (Finset.mem_erase.mpr ⟨hia, his⟩)
    · have hsingle : s = {a} := by
        ext i
        simp only [Finset.mem_singleton]
        constructor
        · intro hi
          by_contra hia
          exact he ⟨i, Finset.mem_erase.mpr ⟨hia, hi⟩⟩
        · rintro rfl
          exact ha
      subst s
      exact ⟨{a}, by simp, by simp, by simp⟩
  · have hzero : s = ∅ := Finset.not_nonempty_iff_eq_empty.mp hs
    subst s
    exact ⟨∅, by simp, by simp, by simp⟩

theorem two_maximal_contains_deep (s O : Finset I) (e : I → Nat) (h : Nat)
    (hsub : O ⊆ s) (hcard : O.card = min 2 s.card)
    (hmax : ∀ i ∈ s \ O, ∀ j ∈ O, e i ≤ e j)
    (hdeep : (s.filter (fun i ↦ h ≤ e i)).card ≤ 2) :
    s.filter (fun i ↦ h ≤ e i) ⊆ O := by
  intro i hi
  by_contra hiO
  have his := (Finset.mem_filter.mp hi).1
  have hie := (Finset.mem_filter.mp hi).2
  by_cases hs : s.card ≤ 2
  · have hsame : O = s := Finset.eq_of_subset_of_card_le hsub (by omega)
    exact hiO (hsame ▸ his)
  · have hc : O.card = 2 := by omega
    have hins : insert i O ⊆ s.filter (fun j ↦ h ≤ e j) := by
      intro j hj
      rcases Finset.mem_insert.mp hj with rfl | hj
      · exact hi
      · exact Finset.mem_filter.mpr
          ⟨hsub hj, hie.trans (hmax i (Finset.mem_sdiff.mpr ⟨his, hiO⟩) j hj)⟩
    have hthree : (insert i O).card = 3 := by simp [hiO, hc]
    have hle := Finset.card_le_card hins
    omega

theorem complete_finite_middle_budget (s O : Finset I) (e : I → Nat)
    (h0 h1 : Nat) (h4 : 4 ≤ h0) (h01 : h0 ≤ h1)
    (hdeep : s.filter (fun i ↦ h1 ≤ e i) ⊆ O) :
    (∑ i ∈ s \ O, (e i - 3)) ≤
      (h0 - 4) * (s.filter (fun i ↦ 4 ≤ e i)).card +
      (h1 - h0) * (s.filter (fun i ↦ h0 ≤ e i)).card := by
  have hid (t : Finset I) (h : Nat) :
      (∑ i ∈ t, if h ≤ e i then 1 else 0) =
        (t.filter (fun i ↦ h ≤ e i)).card := by simp
  have hcount (h : Nat) :
      ((s \ O).filter (fun i ↦ h ≤ e i)).card ≤
        (s.filter (fun i ↦ h ≤ e i)).card := by
    apply Finset.card_le_card
    intro i hi
    exact Finset.mem_filter.mpr
      ⟨(Finset.mem_sdiff.mp (Finset.mem_filter.mp hi).1).1,
        (Finset.mem_filter.mp hi).2⟩
  calc
    (∑ i ∈ s \ O, (e i - 3)) ≤
        ∑ i ∈ s \ O, ((h0 - 4) * (if 4 ≤ e i then 1 else 0) +
          (h1 - h0) * (if h0 ≤ e i then 1 else 0)) := by
      apply Finset.sum_le_sum
      intro i hi
      apply complete_middle_layers (e i) h0 h1 h4 h01
      by_contra h
      have hmember : i ∈ s.filter (fun i ↦ h1 ≤ e i) :=
        Finset.mem_filter.mpr ⟨(Finset.mem_sdiff.mp hi).1, by omega⟩
      exact (Finset.mem_sdiff.mp hi).2 (hdeep hmember)
    _ = (h0 - 4) * ((s \ O).filter (fun i ↦ 4 ≤ e i)).card +
        (h1 - h0) * ((s \ O).filter (fun i ↦ h0 ≤ e i)).card := by
      rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum, hid, hid]
    _ ≤ _ := Nat.add_le_add
      (Nat.mul_le_mul_left _ (hcount 4)) (Nat.mul_le_mul_left _ (hcount h0))

theorem weighted_finite_middle_budget (s O : Finset I) (e : I → Nat)
    (h0 h1 r : Nat) (L w : Real) (hw : 0 ≤ w)
    (h4 : 4 ≤ h0) (h01 : h0 ≤ h1)
    (hdeep : s.filter (fun i ↦ h1 ≤ e i) ⊆ O)
    (hlow : ((h0 - 4 : Nat) : Real) * w ≤ 6 * L)
    (hhigh : ((h1 - h0 : Nat) : Real) * w ≤ 2 * r * L) :
    (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) * w ≤
      (6 * ((s.filter (fun i ↦ 4 ≤ e i)).card : Real) +
        2 * r * ((s.filter (fun i ↦ h0 ≤ e i)).card : Real)) * L := by
  have hnat := complete_finite_middle_budget s O e h0 h1 h4 h01 hdeep
  have hreal :
      (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) ≤
        ((h0 - 4 : Nat) : Real) * (s.filter (fun i ↦ 4 ≤ e i)).card +
        ((h1 - h0 : Nat) : Real) * (s.filter (fun i ↦ h0 ≤ e i)).card := by
    exact_mod_cast hnat
  have hfirst := mul_le_mul_of_nonneg_right hlow
    (Nat.cast_nonneg (α := Real) (s.filter (fun i ↦ 4 ≤ e i)).card)
  have hsecond := mul_le_mul_of_nonneg_right hhigh
    (Nat.cast_nonneg (α := Real) (s.filter (fun i ↦ h0 ≤ e i)).card)
  have hweighted := mul_le_mul_of_nonneg_right hreal hw
  nlinarith

omit [DecidableEq I] in
theorem removed_two_cost (s O : Finset I) (e : I → Nat)
    (w cap : Real) (hsub : O ⊆ s) (hcard : O.card ≤ 2)
    (hw : 0 ≤ w) (hcap : 0 ≤ cap)
    (he : ∀ i ∈ s, (e i : Real) * w ≤ cap) :
    (((∑ i ∈ O, (e i - 3)) : Nat) : Real) * w ≤ 2 * cap := by
  have hone : ∀ i ∈ O, ((e i - 3 : Nat) : Real) * w ≤ cap := by
    intro i hi
    have hnat : e i - 3 ≤ e i := Nat.sub_le _ _
    have hreal : ((e i - 3 : Nat) : Real) ≤ (e i : Real) := by exact_mod_cast hnat
    exact (mul_le_mul_of_nonneg_right hreal hw).trans (he i (hsub hi))
  have hsum := Finset.sum_le_sum hone
  have hc : (O.card : Real) ≤ 2 := by exact_mod_cast hcard
  have hc' := mul_le_mul_of_nonneg_right hc hcap
  rw [Nat.cast_sum, Finset.sum_mul]
  calc
    ∑ i ∈ O, ((e i - 3 : Nat) : Real) * w ≤ ∑ _i ∈ O, cap := hsum
    _ = (O.card : Real) * cap := by simp
    _ ≤ 2 * cap := hc'

theorem finite_global_from_two_cost (s O : Finset I) (e : I → Nat)
    (w cap budget : Real) (hsub : O ⊆ s) (hcard : O.card ≤ 2)
    (hw : 0 ≤ w) (hcap : 0 ≤ cap)
    (he : ∀ i ∈ s, (e i : Real) * w ≤ cap)
    (hremaining : (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) * w ≤ budget) :
    (((∑ i ∈ s, (e i - 3)) : Nat) : Real) * w ≤ 2 * cap + budget := by
  have hremoved := removed_two_cost s O e w cap hsub hcard hw hcap he
  have hsum : (∑ i ∈ s \ O, (e i - 3)) +
      (∑ i ∈ O, (e i - 3)) = ∑ i ∈ s, (e i - 3) :=
    Finset.sum_sdiff hsub
  have hr : (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) +
      (((∑ i ∈ O, (e i - 3)) : Nat) : Real) =
      (((∑ i ∈ s, (e i - 3)) : Nat) : Real) := by exact_mod_cast hsum
  nlinarith

theorem two_stage_ceiling_bounds (L w : Real) (r : Nat)
    (hL : 0 ≤ L) (hw : 0 < w) :
    let h0 := max 4 (Nat.ceil (6 * L / w))
    let h1 := max h0 (Nat.ceil (2 * r * L / w))
    4 ≤ h0 ∧ h0 ≤ h1 ∧ 6 * L ≤ (h0 : Real) * w ∧
      2 * r * L ≤ (h1 : Real) * w ∧
      ((h0 - 4 : Nat) : Real) * w ≤ 6 * L ∧
      ((h1 - h0 : Nat) : Real) * w ≤ 2 * r * L := by
  dsimp
  let h0 := max 4 (Nat.ceil (6 * L / w))
  let h1 := max h0 (Nat.ceil (2 * r * L / w))
  have hb := adaptive_ceiling_bounds L w 3 hL hw
  norm_num only [Nat.cast_ofNat, show (2 : Real) * 3 = 6 by norm_num] at hb
  change 4 ≤ h0 ∧ 6 * L ≤ (h0 : Real) * w ∧
    ((h0 - 4 : Nat) : Real) * w ≤ 6 * L at hb
  change 4 ≤ h0 ∧ h0 ≤ h1 ∧ 6 * L ≤ (h0 : Real) * w ∧
    2 * r * L ≤ (h1 : Real) * w ∧
    ((h0 - 4 : Nat) : Real) * w ≤ 6 * L ∧
    ((h1 - h0 : Nat) : Real) * w ≤ 2 * r * L
  have h01 : h0 ≤ h1 := Nat.le_max_left _ _
  have hceil : Nat.ceil (2 * (r : Real) * L / w) ≤ h1 := Nat.le_max_right _ _
  have hceilr : ((Nat.ceil (2 * (r : Real) * L / w) : Nat) : Real) ≤ h1 := by
    exact_mod_cast hceil
  have hprec : 2 * r * L ≤ (h1 : Real) * w :=
    (div_le_iff₀ hw).mp ((Nat.le_ceil _).trans hceilr)
  refine ⟨hb.1, h01, hb.2.1, hprec, hb.2.2, ?_⟩
  by_cases hh : Nat.ceil (2 * (r : Real) * L / w) ≤ h0
  · have heq : h1 = h0 := max_eq_left hh
    rw [heq, Nat.sub_self]
    simp
    positivity
  · have heq : h1 = Nat.ceil (2 * (r : Real) * L / w) :=
      max_eq_right (by omega)
    have hx : 0 ≤ 2 * (r : Real) * L / w := by positivity
    have hlt := mul_lt_mul_of_pos_right (Nat.ceil_lt_add_one hx) hw
    have hc : (2 * (r : Real) * L / w) * w = 2 * r * L := by field_simp
    have hbase : (4 : Real) ≤ h0 := by exact_mod_cast hb.1
    rw [Nat.cast_sub h01, heq]
    nlinarith

theorem exists_actual_two_owner_budget (s : Finset I) (e : I → Nat)
    (n r : Nat) (L w cap : Real) (hr : 0 < r) (hn : 6 * n ≤ r ^ 2)
    (hL : 0 ≤ L) (hw : 0 < w) (hcap : 0 ≤ cap)
    (he : ∀ i ∈ s, (e i : Real) * w ≤ cap)
    (hchoose :
      let h0 := max 4 (Nat.ceil (6 * L / w))
      let h1 := max h0 (Nat.ceil (2 * r * L / w))
      ((s.filter (fun i ↦ h1 ≤ e i)).card + r - 1).choose r ≤ 3 * n) :
    let h0 := max 4 (Nat.ceil (6 * L / w))
    let budget := (6 * ((s.filter (fun i ↦ 4 ≤ e i)).card : Real) +
      2 * r * ((s.filter (fun i ↦ h0 ≤ e i)).card : Real)) * L
    ∃ O : Finset I, O ⊆ s ∧ O.card = min 2 s.card ∧
      (∀ i ∈ s \ O, ∀ j ∈ O, e i ≤ e j) ∧
      (((∑ i ∈ s \ O, (e i - 3)) : Nat) : Real) * w ≤ budget ∧
      (((∑ i ∈ s, (e i - 3)) : Nat) : Real) * w ≤ 2 * cap + budget := by
  dsimp only at hchoose ⊢
  let h0 := max 4 (Nat.ceil (6 * L / w))
  let h1 := max h0 (Nat.ceil (2 * r * L / w))
  obtain ⟨h4, h01, _hp0, _hp1, hlow, hhigh⟩ := two_stage_ceiling_bounds L w r hL hw
  have hc : (s.filter (fun i ↦ h1 ≤ e i)).card ≤ 2 :=
    count_le_two _ n r hr hn hchoose
  obtain ⟨O, hsub, hcard, hmax⟩ := exists_two_maximal s e
  have hdeep := two_maximal_contains_deep s O e h1 hsub hcard hmax hc
  have hbudget := weighted_finite_middle_budget s O e h0 h1 r L w hw.le
    h4 h01 hdeep hlow hhigh
  have hO : O.card ≤ 2 := by omega
  exact ⟨O, hsub, hcard, hmax, hbudget,
    finite_global_from_two_cost s O e w cap _ hsub hO hw.le hcap he hbudget⟩

#print axioms cubic_count_bound
#print axioms count_le_two
#print axioms adaptive_ceiling_bounds
#print axioms complete_middle_layers
#print axioms exists_two_maximal
#print axioms two_maximal_contains_deep
#print axioms complete_finite_middle_budget
#print axioms weighted_finite_middle_budget
#print axioms removed_two_cost
#print axioms finite_global_from_two_cost
#print axioms two_stage_ceiling_bounds
#print axioms exists_actual_two_owner_budget
end ABCAdaptiveOwner20260907
