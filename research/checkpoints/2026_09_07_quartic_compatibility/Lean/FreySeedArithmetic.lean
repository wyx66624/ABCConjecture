import QuarticSupportArithmetic

/-! Actual polynomial arithmetic underlying the independently reviewed Frey
construction FM1--FM4 and boundary shadows BS2. This module does not assert
Tate reduction, Galois representations, modularity, or an ABC conclusion. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCFreySeedArithmetic20260907
open ABCEisenstein20260905 ABCLocalPowerArithmetic20260907
open ABCQuarticSupportArithmetic20260907

def x (a b : Int) : Int := a^2+b^2
def y (a b : Int) : Int := a+b
def scale (k : Int) (z : Pair) : Pair := (k*z.1,k*z.2)
def sub (z w : Pair) : Pair := (z.1-w.1,z.2-w.2)
def alphaPlus (a b : Int) : Pair := (3*(y a b)^2-x a b,2*x a b)
def alphaMinus (a b : Int) : Pair := (3*(y a b)^2+x a b,-2*x a b)
def curveA (a b : Int) : Pair := (12*y a b,0)
def curveB (a b : Int) : Pair := scale 6 (alphaPlus a b)
def c4 (A B : Pair) : Pair := scale 16 (sub (mul A A) (scale 3 B))
def c6 (A B : Pair) : Pair :=
  sub (scale 288 (mul A B)) (scale 64 (mul A (mul A A)))
def disc (A B : Pair) : Pair :=
  scale 16 (mul (mul B B) (sub (mul A A) (scale 4 B)))

theorem actual_fermat_identity (a b : Int) :
    (x a b)^2+3*(y a b)^4=4*second a b := by
  rw [second_quartic]
  dsimp [x,y]
  grind

theorem actual_inverse_square_gate (a b : Int) :
    2*x a b-(y a b)^2=(a-b)^2 := by
  dsimp [x,y]
  grind

theorem actual_odd_chart (Y D : Int) :
    second (Y+D) (Y-D)=(Y^2+D^2)^2+12*Y^4 := by
  rw [second_quartic]
  grind

theorem actual_odd_chart_gate (Y D : Int) :
    x (Y+D) (Y-D)=2*(Y^2+D^2) ∧ y (Y+D) (Y-D)=2*Y := by
  dsimp [x,y]
  constructor <;> grind

theorem actual_alpha_conjugate (a b : Int) :
    conjugate (alphaPlus a b)=alphaMinus a b := by
  apply Prod.ext <;> dsimp [conjugate,alphaPlus,alphaMinus] <;> grind

theorem actual_alpha_norm (a b : Int) :
    norm (alphaPlus a b)=12*second a b := by
  rw [second_quartic]
  dsimp [alphaPlus,norm,x,y]
  grind

theorem actual_alpha_product (a b : Int) :
    mul (alphaPlus a b) (alphaMinus a b)=(12*second a b,0) := by
  rw [← actual_alpha_conjugate,conjugate_product,actual_alpha_norm]

theorem actual_two_isogeny_coefficient (a b : Int) :
    sub (mul (curveA a b) (curveA a b)) (scale 4 (curveB a b))=
      scale 24 (alphaMinus a b) := by
  apply Prod.ext <;> dsimp [sub,mul,curveA,curveB,scale,alphaPlus,alphaMinus] <;> grind

theorem actual_twisted_conjugate_coefficient (a b : Int) :
    sub (mul (curveA a b) (curveA a b)) (scale 4 (curveB a b))=
      scale 4 (conjugate (curveB a b)) := by
  apply Prod.ext <;> dsimp [sub,mul,curveA,curveB,scale,alphaPlus,conjugate] <;> grind

theorem actual_c4 (a b : Int) :
    c4 (curveA a b) (curveB a b)=
      scale 288 (5*(y a b)^2+x a b,-2*x a b) := by
  apply Prod.ext <;> dsimp [c4,sub,mul,curveA,curveB,scale,alphaPlus] <;> grind

theorem actual_c6 (a b : Int) :
    c6 (curveA a b) (curveB a b)=
      scale (6912*y a b) (-3*x a b-7*(y a b)^2,6*x a b) := by
  apply Prod.ext <;> dsimp [c6,sub,mul,curveA,curveB,scale,alphaPlus] <;> grind

theorem actual_discriminant (a b : Int) :
    disc (curveA a b) (curveB a b)=
      scale (165888*second a b) (alphaPlus a b) := by
  rw [second_quartic]
  apply Prod.ext <;> dsimp [disc,sub,mul,curveA,curveB,scale,alphaPlus,x,y] <;> grind

theorem second_two_table : ∀ a b : Fin 2,
    ¬ (a.val=0 ∧ b.val=0) → second a.val b.val % 2=1 := by decide

theorem primitive_second_odd (a b : Int) (hg : Int.gcd a b=1) :
    second a b % 2=1 := by
  let fa : Fin 2 := ⟨(a%2).toNat,by omega⟩
  let fb : Fin 2 := ⟨(b%2).toNat,by omega⟩
  have ha : (fa.val : Int)=a%2 := by dsimp [fa]; omega
  have hb : (fb.val : Int)=b%2 := by dsimp [fb]; omega
  have hp := primitive_not_both_zero_mod a b 2 (by decide) hg
  have h := second_two_table fa fb (by dsimp [fa,fb]; omega)
  rw [ha,hb] at h
  rw [second_mod]
  exact h

theorem x_three_table : ∀ a b : Fin 3,
    ¬ (a.val=0 ∧ b.val=0) → x a.val b.val % 3 ≠ 0 := by decide

theorem primitive_x_three_unit (a b : Int) (hg : Int.gcd a b=1) :
    x a b % 3 ≠ 0 := by
  let fa : Fin 3 := ⟨(a%3).toNat,by omega⟩
  let fb : Fin 3 := ⟨(b%3).toNat,by omega⟩
  have ha : (fa.val : Int)=a%3 := by dsimp [fa]; omega
  have hb : (fb.val : Int)=b%3 := by dsimp [fb]; omega
  have hp := primitive_not_both_zero_mod a b 3 (by decide) hg
  have h := x_three_table fa fb (by dsimp [fa,fb]; omega)
  rw [ha,hb] at h
  have he : x (a%3) (b%3)%3=x a b%3 := by
    simp [x,Int.pow_succ,Int.pow_zero,Int.add_emod,Int.mul_emod]
  rw [he] at h
  exact h

theorem actual_discriminant_nonzero (a b : Int) (hg : Int.gcd a b=1) :
    disc (curveA a b) (curveB a b) ≠ (0,0) := by
  intro hd
  rw [actual_discriminant] at hd
  have hz : second a b ≠ 0 := by
    have ho := primitive_second_odd a b hg
    omega
  have hp : alphaPlus a b ≠ (0,0) := by
    intro he
    have hn := actual_alpha_norm a b
    rw [he] at hn
    dsimp [norm] at hn
    omega
  have h1 := congrArg Prod.fst hd
  have h2 := congrArg Prod.snd hd
  dsimp [scale] at h1 h2
  have hs : 165888*second a b ≠ 0 := Int.mul_ne_zero (by decide) hz
  have hz1 : (alphaPlus a b).1=0 := (Int.mul_eq_zero.mp h1).resolve_left hs
  have hz2 : (alphaPlus a b).2=0 := (Int.mul_eq_zero.mp h2).resolve_left hs
  exact hp (Prod.ext hz1 hz2)

theorem consecutive_frey_residues (L k : Int) :
    L ∣ x (L*k) (L*k+1)-1 ∧ L ∣ y (L*k) (L*k+1)-1 ∧
    L ∣ second (L*k) (L*k+1)-1 := by
  refine ⟨⟨2*L*k^2+2*k,?_⟩,⟨2*k,?_⟩,?_⟩
  · dsimp [x]; grind
  · dsimp [y]; grind
  · refine ⟨13*L^3*k^4+26*L^2*k^3+20*L*k^2+7*k,?_⟩
    rw [second_quartic]
    grind

#print axioms actual_fermat_identity
#print axioms actual_inverse_square_gate
#print axioms actual_odd_chart
#print axioms actual_odd_chart_gate
#print axioms actual_alpha_conjugate
#print axioms actual_alpha_norm
#print axioms actual_alpha_product
#print axioms actual_two_isogeny_coefficient
#print axioms actual_twisted_conjugate_coefficient
#print axioms actual_c4
#print axioms actual_c6
#print axioms actual_discriminant
#print axioms second_two_table
#print axioms primitive_second_odd
#print axioms x_three_table
#print axioms primitive_x_three_unit
#print axioms actual_discriminant_nonzero
#print axioms consecutive_frey_residues
end ABCFreySeedArithmetic20260907
