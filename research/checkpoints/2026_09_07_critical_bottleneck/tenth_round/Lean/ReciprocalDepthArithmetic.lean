import SignedArmArithmetic

/-! Integer-weight kernels for the reviewed reciprocal depth budgets.
Common positive denominators can be cleared before applying this module.
Actual prime valuations and real logarithms are not defined here. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCReciprocalDepthArithmetic20260907
open ABCSignedArmArithmetic20260907

def weightedExcessAt (h : Nat) : List (Nat × Int) → Int
  | [] => 0
  | (e,w)::xs => ((e-h:Nat):Int)*w+weightedExcessAt h xs

theorem local_cap_budget (e h : Nat) (w : Int) (hw : 0 ≤ w) :
    (e:Int)*w-((e-h:Nat):Int)*w ≤ (h:Int)*(if e=0 then 0 else w) := by
  by_cases he : e=0
  · simp [he]
  · have hn : 0 ≤ (h:Int)-(e:Int)+((e-h:Nat):Int) := by omega
    have hm := Int.mul_nonneg hn hw
    simp only [if_neg he]
    grind

theorem finite_cap_budget (h : Nat) (xs : List (Nat × Int))
    (hw : ∀ ew ∈ xs, 0 ≤ ew.2) :
    weightedDepth xs-weightedExcessAt h xs ≤ (h:Int)*weightedRadical xs := by
  induction xs with
  | nil => simp [weightedDepth,weightedRadical,weightedExcessAt]
  | cons ew xs ih =>
    rcases ew with ⟨e,w⟩
    have hh := local_cap_budget e h w (hw (e,w) (by simp))
    have ht := ih (by intro ew hew; exact hw ew (by simp [hew]))
    simp only [weightedDepth,weightedRadical,weightedExcessAt]
    grind

theorem cleared_finite_cap_bridge (h : Nat) (b d : Int) (xs : List (Nat × Int))
    (hb : 0 ≤ b) (hw : ∀ ew ∈ xs, 0 ≤ ew.2) (hc : b*(h:Int)=3*d) :
    b*(weightedDepth xs-weightedExcessAt h xs) ≤ 3*d*weightedRadical xs := by
  have hcap := finite_cap_budget h xs hw
  have hm := Int.mul_nonneg hb
    (show 0 ≤ (h:Int)*weightedRadical xs-
      (weightedDepth xs-weightedExcessAt h xs) by omega)
  rw [Int.mul_sub,← Int.mul_assoc,hc] at hm
  omega

theorem unrestricted_cap_identity (d : Int) (xs : List (Nat × Int)) :
    0*(weightedDepth xs-0)=3*d*(weightedRadical xs-weightedRadical xs) := by
  grind

def positiveCoefficient (b d : Int) : Int := if b ≤ d then 0 else b-d

theorem positive_coefficient_nonnegative (b d : Int) :
    0 ≤ positiveCoefficient b d := by
  unfold positiveCoefficient
  split <;> omega

theorem positive_coefficient_dominates (b d : Int) :
    b-d ≤ positiveCoefficient b d := by
  unfold positiveCoefficient
  split <;> omega

theorem signed_coefficient_height_bound (b d s t delta l a : Int)
    (ha : 0 ≤ a) (hab : b-d ≤ a)
    (hlo : t-delta-l ≤ s) (hhi : s ≤ t) :
    (d-b)*s ≤ (d-b)*t+a*(delta+l) := by
  have h₁ := Int.mul_nonneg (show 0 ≤ a-(b-d) by omega) (show 0 ≤ t-s by omega)
  have h₂ := Int.mul_nonneg ha (show 0 ≤ delta+l-(t-s) by omega)
  grind

theorem canonical_coefficient_height_bound (b d s t delta l : Int)
    (hlo : t-delta-l ≤ s) (hhi : s ≤ t) :
    (d-b)*s ≤ (d-b)*t+positiveCoefficient b d*(delta+l) := by
  exact signed_coefficient_height_bound b d s t delta l _
    (positive_coefficient_nonnegative b d) (positive_coefficient_dominates b d) hlo hhi

theorem three_low_mass_budget (a₁ a₂ a₃ B l₁ l₂ l₃ L : Int)
    (hB : 0 ≤ B) (h₁ : a₁ ≤ B) (h₂ : a₂ ≤ B) (h₃ : a₃ ≤ B)
    (hl₁ : 0 ≤ l₁) (hl₂ : 0 ≤ l₂) (hl₃ : 0 ≤ l₃)
    (hsum : l₁+l₂+l₃ ≤ L) : a₁*l₁+a₂*l₂+a₃*l₃ ≤ B*L := by
  have h₁' := Int.mul_nonneg (show 0 ≤ B-a₁ by omega) hl₁
  have h₂' := Int.mul_nonneg (show 0 ≤ B-a₂ by omega) hl₂
  have h₃' := Int.mul_nonneg (show 0 ≤ B-a₃ by omega) hl₃
  have hL := Int.mul_nonneg hB (show 0 ≤ L-(l₁+l₂+l₃) by omega)
  grind

/-- Three coefficient and cap interfaces are explicit. The variables k_i
retain all radical credit on unrestricted arms when b_i=0. -/
theorem cleared_three_arm_compensation
    (d b₁ b₂ b₃ s₁ s₂ s₃ r₁ r₂ r₃ e₁ e₂ e₃ k₁ k₂ k₃
      a₁ a₂ a₃ t delta l₁ l₂ l₃ B L : Int)
    (hcap₁ : b₁*(s₁-e₁) ≤ 3*d*(r₁-k₁))
    (hcap₂ : b₂*(s₂-e₂) ≤ 3*d*(r₂-k₂))
    (hcap₃ : b₃*(s₃-e₃) ≤ 3*d*(r₃-k₃))
    (hcoef₁ : (d-b₁)*s₁ ≤ (d-b₁)*t+a₁*(delta+l₁))
    (hcoef₂ : (d-b₂)*s₂ ≤ (d-b₂)*t+a₂*(delta+l₂))
    (hcoef₃ : (d-b₃)*s₃ ≤ (d-b₃)*t+a₃*(delta+l₃))
    (hlow : a₁*l₁+a₂*l₂+a₃*l₃ ≤ B*L) :
    d*(s₁+s₂+s₃-3*(r₁+r₂+r₃)) ≤
      (3*d-b₁-b₂-b₃)*t+(a₁+a₂+a₃)*delta+B*L+
        b₁*e₁+b₂*e₂+b₃*e₃-3*d*(k₁+k₂+k₃) := by
  grind

theorem reciprocal_margin_nonpositive (d b₁ b₂ b₃ t : Int)
    (ht : 0 ≤ t) (hcapacity : 3*d ≤ b₁+b₂+b₃) :
    (3*d-b₁-b₂-b₃)*t ≤ 0 := by
  have hm := Int.mul_nonneg (show 0 ≤ b₁+b₂+b₃-3*d by omega) ht
  grind

theorem positive_coefficient_upper (b d : Int) (hd : 0 ≤ d) (hb : b ≤ 3*d) :
    positiveCoefficient b d ≤ 2*d := by
  unfold positiveCoefficient
  split <;> omega

theorem three_positive_coefficients_upper (b₁ b₂ b₃ d : Int) (hd : 0 ≤ d)
    (h₁ : b₁ ≤ 3*d) (h₂ : b₂ ≤ 3*d) (h₃ : b₃ ≤ 3*d) :
    positiveCoefficient b₁ d+positiveCoefficient b₂ d+positiveCoefficient b₃ d ≤ 6*d := by
  have h₁' := positive_coefficient_upper b₁ d hd h₁
  have h₂' := positive_coefficient_upper b₂ d hd h₂
  have h₃' := positive_coefficient_upper b₃ d hd h₃
  omega

/-- The signed-coefficient and small-mass interfaces above are discharged
from their actual interval bounds and nonnegative finite low masses. -/
theorem canonical_three_arm_compensation
    (d b₁ b₂ b₃ s₁ s₂ s₃ r₁ r₂ r₃ e₁ e₂ e₃ k₁ k₂ k₃
      t delta l₁ l₂ l₃ B L : Int)
    (hcap₁ : b₁*(s₁-e₁) ≤ 3*d*(r₁-k₁))
    (hcap₂ : b₂*(s₂-e₂) ≤ 3*d*(r₂-k₂))
    (hcap₃ : b₃*(s₃-e₃) ≤ 3*d*(r₃-k₃))
    (hlo₁ : t-delta-l₁ ≤ s₁) (hhi₁ : s₁ ≤ t)
    (hlo₂ : t-delta-l₂ ≤ s₂) (hhi₂ : s₂ ≤ t)
    (hlo₃ : t-delta-l₃ ≤ s₃) (hhi₃ : s₃ ≤ t)
    (hB : 0 ≤ B) (hB₁ : positiveCoefficient b₁ d ≤ B)
    (hB₂ : positiveCoefficient b₂ d ≤ B) (hB₃ : positiveCoefficient b₃ d ≤ B)
    (hl₁ : 0 ≤ l₁) (hl₂ : 0 ≤ l₂) (hl₃ : 0 ≤ l₃)
    (hsum : l₁+l₂+l₃ ≤ L) :
    d*(s₁+s₂+s₃-3*(r₁+r₂+r₃)) ≤
      (3*d-b₁-b₂-b₃)*t+
        (positiveCoefficient b₁ d+positiveCoefficient b₂ d+positiveCoefficient b₃ d)*delta+
        B*L+b₁*e₁+b₂*e₂+b₃*e₃-3*d*(k₁+k₂+k₃) := by
  exact cleared_three_arm_compensation _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _ _ _ hcap₁ hcap₂ hcap₃
    (canonical_coefficient_height_bound b₁ d s₁ t delta l₁ hlo₁ hhi₁)
    (canonical_coefficient_height_bound b₂ d s₂ t delta l₂ hlo₂ hhi₂)
    (canonical_coefficient_height_bound b₃ d s₃ t delta l₃ hlo₃ hhi₃)
    (three_low_mass_budget _ _ _ B l₁ l₂ l₃ L hB hB₁ hB₂ hB₃ hl₁ hl₂ hl₃ hsum)

theorem one_cap_classification (a : Int) (ha : 1 ≤ a) :
    (a ≤ 1 ↔ a=1) := by omega

theorem two_cap_classification (a b : Int) (ha : 1 ≤ a) (hab : a ≤ b) :
    a*b ≤ a+b ↔ a=1 ∨ (a=2 ∧ b=2) := by
  constructor
  · intro h
    have ha2 : a ≤ 2 := by
      by_cases hn : a ≤ 2
      · exact hn
      · have hp := Int.mul_pos (show 0 < a-2 by omega) (show 0 < b by omega)
        have hba : 0 ≤ b-a := by omega
        grind
    by_cases h1 : a=1
    · exact Or.inl h1
    · have h2 : a=2 := by omega
      exact Or.inr ⟨h2,by rw [h2] at h hab; omega⟩
  · intro h
    rcases h with h | ⟨h,hb⟩ <;> grind

theorem three_cap_classification (a b c : Int)
    (ha : 1 ≤ a) (hab : a ≤ b) (hbc : b ≤ c) :
    a*b*c ≤ a*b+a*c+b*c ↔
      a=1 ∨ (a=2 ∧ (b=2 ∨ (b=3 ∧ c ≤ 6) ∨ (b=4 ∧ c=4))) ∨
        (a=3 ∧ b=3 ∧ c=3) := by
  constructor
  · intro h
    have ha3 : a ≤ 3 := by
      by_cases hn : a ≤ 3
      · exact hn
      · have h₁ := Int.mul_nonneg (show 0 ≤ b-a by omega) (show 0 ≤ c by omega)
        have h₂ := Int.mul_nonneg (show 0 ≤ c-a by omega) (show 0 ≤ b by omega)
        have hp := Int.mul_pos (show 0 < a-3 by omega)
          (Int.mul_pos (show 0 < b by omega) (show 0 < c by omega))
        grind
    by_cases h1 : a=1
    · exact Or.inl h1
    by_cases h2 : a=2
    · have hb4 : b ≤ 4 := by
        by_cases hn : b ≤ 4
        · exact hn
        · have hp := Int.mul_pos (show 0 < b-4 by omega) (show 0 < c by omega)
          have hcb : 0 ≤ c-b := by omega
          rw [h2] at h
          grind
      refine Or.inr (Or.inl ⟨h2,?_⟩)
      by_cases hb2 : b=2
      · exact Or.inl hb2
      by_cases hb3 : b=3
      · exact Or.inr (Or.inl ⟨hb3,by rw [h2,hb3] at h; omega⟩)
      · have hb4' : b=4 := by omega
        exact Or.inr (Or.inr ⟨hb4',by rw [h2,hb4'] at h; omega⟩)
    · have ha3' : a=3 := by omega
      have hb3 : b=3 := by
        by_cases hn : b=3
        · exact hn
        · have hp := Int.mul_pos (show 0 < 2*b-6 by omega) (show 0 < c by omega)
          have hcb : 0 ≤ c-b := by omega
          rw [ha3'] at h
          grind
      exact Or.inr (Or.inr ⟨ha3',hb3,by rw [ha3',hb3] at h; omega⟩)
  · intro h
    rcases h with h | ⟨h,hb⟩ | ⟨h,hb,hc⟩
    · grind
    · rcases hb with hb | ⟨hb,hc⟩ | ⟨hb,hc⟩ <;> grind
    · grind

#print axioms local_cap_budget
#print axioms finite_cap_budget
#print axioms cleared_finite_cap_bridge
#print axioms unrestricted_cap_identity
#print axioms positive_coefficient_nonnegative
#print axioms positive_coefficient_dominates
#print axioms signed_coefficient_height_bound
#print axioms canonical_coefficient_height_bound
#print axioms three_low_mass_budget
#print axioms cleared_three_arm_compensation
#print axioms reciprocal_margin_nonpositive
#print axioms positive_coefficient_upper
#print axioms three_positive_coefficients_upper
#print axioms canonical_three_arm_compensation
#print axioms one_cap_classification
#print axioms two_cap_classification
#print axioms three_cap_classification

end ABCReciprocalDepthArithmetic20260907
