import QuarticSupportArithmetic

/-! Actual square-gap inequalities for primitive second norms. The ordinary
proof was independently reviewed before this formalization. No elliptic
descent, analytic theorem or ABC assertion is encoded here. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCSquareGapArithmetic20260907
open ABCLocalPowerArithmetic20260907 ABCQuarticSupportArithmetic20260907

def axisS (a b : Int) : Int := 8*a^2+12*a*b+11*b^2
def axisD (a b : Int) : Int := 72*a*b^3+57*b^4

theorem axis_identity (a b : Int) :
    (axisS a b)^2-64*second a b=axisD a b := by
  rw [second_quartic]
  dsimp [axisS,axisD]
  grind

theorem second_symmetric (a b : Int) : second a b=second b a := by
  rw [second_quartic,second_quartic]
  grind

theorem axis_mod (a b m : Int) : axisS a b%m=axisS (a%m) (b%m)%m := by
  simp [axisS,Int.pow_succ,Int.pow_zero,Int.add_emod,Int.mul_emod]

theorem axis_eight_table : ∀ a b : Fin 8,
    ¬ (a.val%2=0 ∧ b.val%2=0) →
      axisS a.val b.val%8=0 ∨ axisS a.val b.val%8≥3 := by decide

theorem primitive_axis_eight (a b : Int) (hg : Int.gcd a b=1) :
    axisS a b%8=0 ∨ axisS a b%8≥3 := by
  let fa : Fin 8 := ⟨(a%8).toNat,by omega⟩
  let fb : Fin 8 := ⟨(b%8).toNat,by omega⟩
  have ha : (fa.val : Int)=a%8 := by dsimp [fa]; omega
  have hb : (fb.val : Int)=b%8 := by dsimp [fb]; omega
  have hp := primitive_not_both_zero_mod a b 2 (by decide) hg
  have ht := axis_eight_table fa fb (by dsimp [fa,fb]; omega)
  rw [ha,hb] at ht
  rw [axis_mod]
  exact ht

theorem axis_positive (a b : Int) (ha : 0<a) (hb : 0<b) : 0<axisS a b := by
  have ha2 := Int.pow_nonneg (m:=2) (show 0≤a by omega)
  have hb2 := Int.pow_pos (m:=2) hb
  have hab := Int.mul_pos ha hb
  dsimp [axisS]
  grind

theorem axis_difference_positive (a b : Int) (ha : 0<a) (hb : 0<b) :
    0<axisD a b := by
  have hb3 := Int.pow_pos (m:=3) hb
  have hb4 := Int.pow_nonneg (m:=4) (show 0≤b by omega)
  have hab := Int.mul_pos ha hb3
  dsimp [axisD]
  grind

theorem actual_square_gap (a b q : Int) (ha : 0<a) (hb : 0<b)
    (hq : 0≤q) (hg : Int.gcd a b=1) (hs : second a b=q^2) :
    6*axisS a b-9≤axisD a b := by
  have hS := axis_positive a b ha hb
  have hD := axis_difference_positive a b ha hb
  have hid := axis_identity a b
  rw [hs] at hid
  have hlt : 8*q<axisS a b := by
    by_cases hh : 8*q<axisS a b
    · exact hh
    · have hp := Int.mul_nonneg (show 0≤8*q-axisS a b by omega)
        (show 0≤8*q+axisS a b by omega)
      grind
  have hmod := primitive_axis_eight a b hg
  have hgap : 8*q≤axisS a b-3 := by omega
  have hp := Int.mul_nonneg (show 0≤axisS a b-3-8*q by omega)
    (show 0≤axisS a b-3+8*q by omega)
  grind

theorem axis_gap_below_threshold (a b : Int) (ha : 0<a) (hb : 0<b)
    (hlarge : 3*b^3≤2*a) : axisD a b<6*axisS a b-9 := by
  have hp1 := Int.mul_nonneg (show 0≤2*a-3*b^3 by omega)
    (show 0≤24*a by omega)
  have hp2 := Int.mul_nonneg (show 0≤2*a-3*b^3 by omega)
    (show 0≤36*b by omega)
  have hb2 := Int.pow_pos (m:=2) hb
  have hb4 := Int.pow_nonneg (m:=4) (show 0≤b by omega)
  dsimp [axisD,axisS]
  grind

theorem primitive_square_axis_bound_nonnegative (a b q : Int)
    (ha : 0<a) (hb : 0<b) (hq : 0≤q) (hg : Int.gcd a b=1)
    (hs : second a b=q^2) : 2*a<3*b^3 := by
  have hlow := actual_square_gap a b q ha hb hq hg hs
  by_cases h : 2*a<3*b^3
  · exact h
  · have hupp := axis_gap_below_threshold a b ha hb (by omega)
    omega

theorem primitive_square_axis_bound (a b q : Int)
    (ha : 0<a) (hb : 0<b) (hg : Int.gcd a b=1)
    (hs : second a b=q^2) : 2*a<3*b^3 := by
  by_cases hq : 0≤q
  · exact primitive_square_axis_bound_nonnegative a b q ha hb hq hg hs
  · have hn : second a b=(-q)^2 := by grind
    exact primitive_square_axis_bound_nonnegative a b (-q) ha hb (by omega) hg hn

theorem primitive_square_axis_bounds (a b q : Int)
    (ha : 0<a) (hb : 0<b) (hg : Int.gcd a b=1) (hs : second a b=q^2) :
    2*a<3*b^3 ∧ 2*b<3*a^3 := by
  have hg' : Int.gcd b a=1 := by rw [Int.gcd_comm]; exact hg
  have hs' : second b a=q^2 := by rw [second_symmetric]; exact hs
  exact ⟨primitive_square_axis_bound a b q ha hb hg hs,
    primitive_square_axis_bound b a q hb ha hg' hs'⟩

theorem thirteen_square_table : ∀ q : Fin 8, (q.val : Int)^2%8≠5 := by decide

theorem thirteen_not_square (q : Int) : q^2≠13 := by
  intro h
  let fq : Fin 8 := ⟨(q%8).toNat,by omega⟩
  have hq : (fq.val : Int)=q%8 := by dsimp [fq]; omega
  have hh := thirteen_square_table fq
  rw [hq] at hh
  have he : (q%8)^2%8=q^2%8 := by
    simp [Int.pow_succ,Int.pow_zero,Int.mul_emod]
  rw [he,h] at hh
  exact hh (by decide)

theorem primitive_square_coordinates_gt_one (a b q : Int)
    (ha : 0<a) (hb : 0<b) (hg : Int.gcd a b=1) (hs : second a b=q^2) :
    1<a ∧ 1<b := by
  have hh := primitive_square_axis_bounds a b q ha hb hg hs
  have hnot : ¬ (a=1 ∧ b=1) := by
    rintro ⟨rfl,rfl⟩
    have hf : second 1 1=13 := by decide
    have hn := thirteen_not_square q
    omega
  constructor
  · by_cases h : 1<a
    · exact h
    · have he : a=1 := by omega
      rw [he] at hh
      have hb1 : b=1 := by grind
      exact False.elim (hnot ⟨he,hb1⟩)
  · by_cases h : 1<b
    · exact h
    · have he : b=1 := by omega
      rw [he] at hh
      have ha1 : a=1 := by grind
      exact False.elim (hnot ⟨ha1,he⟩)

theorem no_square_with_coordinate_one (a b q : Int)
    (ha : 0<a) (hb : 0<b) (hg : Int.gcd a b=1) (hone : a=1 ∨ b=1) :
    second a b≠q^2 := by
  intro hs
  have hh := primitive_square_coordinates_gt_one a b q ha hb hg hs
  omega

#print axioms axis_identity
#print axioms second_symmetric
#print axioms axis_mod
#print axioms axis_eight_table
#print axioms primitive_axis_eight
#print axioms axis_positive
#print axioms axis_difference_positive
#print axioms actual_square_gap
#print axioms axis_gap_below_threshold
#print axioms primitive_square_axis_bound_nonnegative
#print axioms primitive_square_axis_bound
#print axioms primitive_square_axis_bounds
#print axioms thirteen_square_table
#print axioms thirteen_not_square
#print axioms primitive_square_coordinates_gt_one
#print axioms no_square_with_coordinate_one
end ABCSquareGapArithmetic20260907
