import Std

/-! The actual integer sextic and its complete mod-27 obstruction.
This module does not formalize Q_3, projective curves, or the curve maps.
The finite table uses kernel `decide`, not native_decide. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCCubicUnitLocal20260907

def cubicC (s t : Int) : Int := s^3+3*s^2*t-t^3
def cubicE (s t : Int) : Int := s^3-s^2*t-4*s*t^2-t^3
def sextic (s t : Int) : Int := -3*cubicC s t*cubicE s t

theorem shifted_cubic_identity (t k : Int) :
    cubicC (t+3*k) t = 3*(t^3+9*k*t^2+18*k^2*t+9*k^3) := by
  dsimp [cubicC]
  grind

theorem sextic_mod (s t m : Int) :
    sextic s t % m = sextic (s%m) (t%m) % m := by
  simp [sextic,cubicC,cubicE,Int.pow_succ,Int.pow_zero,
    Int.add_emod,Int.sub_emod,Int.mul_emod]

theorem mod_twenty_seven_table : ∀ s t y : Fin 27,
    sextic s.val t.val % 27 = (y.val : Int)^2 % 27 →
      s.val % 3 = 0 ∧ t.val % 3 = 0 := by decide

theorem actual_congruence_forces_three (s t y : Int)
    (h : sextic s t % 27 = y^2 % 27) :
    s%3=0 ∧ t%3=0 := by
  let fs : Fin 27 := ⟨(s%27).toNat,by omega⟩
  let ft : Fin 27 := ⟨(t%27).toNat,by omega⟩
  let fy : Fin 27 := ⟨(y%27).toNat,by omega⟩
  have hs : (fs.val : Int)=s%27 := by dsimp [fs]; omega
  have ht : (ft.val : Int)=t%27 := by dsimp [ft]; omega
  have hy : (fy.val : Int)=y%27 := by dsimp [fy]; omega
  have hp : (y%27)^2%27=y^2%27 := by
    simp [Int.pow_succ,Int.pow_zero,Int.mul_emod]
  have hf : sextic fs.val ft.val % 27 = (fy.val : Int)^2%27 := by
    rw [hs,ht,hy,hp,←sextic_mod]
    exact h
  have hz := mod_twenty_seven_table fs ft fy hf
  dsimp [fs,ft] at hz
  omega

theorem actual_square_forces_three (s t y : Int)
    (h : y^2=sextic s t) : 3 ∣ s ∧ 3 ∣ t := by
  have hm := actual_congruence_forces_three s t y (by rw [h])
  exact ⟨Int.dvd_of_emod_eq_zero hm.1,Int.dvd_of_emod_eq_zero hm.2⟩

theorem primitive_sextic_not_square (s t y : Int)
    (hg : Int.gcd s t=1) : y^2 ≠ sextic s t := by
  intro h
  have hd := actual_square_forces_three s t y h
  have hbad : (3 : Int) ∣ 1 := Int.gcd_eq_one_iff.mp hg 3 hd.1 hd.2
  exact (by decide : ¬ (3 : Int) ∣ 1) hbad

#print axioms shifted_cubic_identity
#print axioms sextic_mod
#print axioms mod_twenty_seven_table
#print axioms actual_congruence_forces_three
#print axioms actual_square_forces_three
#print axioms primitive_sextic_not_square
end ABCCubicUnitLocal20260907
