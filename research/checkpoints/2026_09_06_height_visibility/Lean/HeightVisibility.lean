import Std

/-!
Author: ChatGPT. Ordinary proofs precede this scoped formalization.
No analytic height theorem, ray-class theorem, Tate theorem, or ABC statement
is an axiom or conclusion here. The checked statements are integer identities,
a universal primitive family and its exact small-prime congruences, plus the
finite matrix obstruction. Elliptic and Galois interpretations remain paper proofs.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCHeightVisibility20260906

def armA (v : Int) : Int := 2*v+1
def armB (v : Int) : Int := (v+1)^3*(v-1)
def armC (v : Int) : Int := v^3*(v+2)
def pointX (v : Int) : Int := (v+1)^2
def pointY (v : Int) : Int := v^2*(v+1)^2
def tangentSlope (v : Int) : Int := v^2+v+1
def bezPoly (v : Int) : Int := 8*v^3+12*v^2-6*v+3

theorem family_sum (v : Int) : armA v + armB v = armC v := by
  dsimp [armA,armB,armC]
  grind

theorem point_on_curve (v : Int) :
    pointY v ^ 2 = pointX v * (pointX v-armA v) * (pointX v+armB v) := by
  dsimp [pointX,pointY,armA,armB]
  grind

theorem triple_tangent_identity (v x : Int) :
    x*(x-armA v)*(x+armB v) -
      (tangentSlope v*x-(v+1)^3)^2 = (x-pointX v)^3 := by
  dsimp [armA,armB,pointX,tangentSlope]
  grind

theorem tangent_contains_point (v : Int) :
    tangentSlope v * pointX v - (v+1)^3 = pointY v := by
  dsimp [tangentSlope,pointX,pointY]
  grind

theorem tangent_derivative (v : Int) :
    3*pointX v^2 + 2*(armB v-armA v)*pointX v - armA v*armB v =
      2*pointY v*tangentSlope v := by
  dsimp [pointX,pointY,armA,armB,tangentSlope]
  grind

theorem doubling_x_identity (v : Int) :
    tangentSlope v^2-(armB v-armA v)-2*pointX v = pointX v := by
  dsimp [tangentSlope,armA,armB,pointX]
  grind

theorem cubic_bezout (v : Int) :
    armA v * bezPoly v - 16*armC v = 3 := by
  dsimp [armA,armC,bezPoly]
  grind

theorem family_bezout (w : Int) :
    (1-2*w*bezPoly (3*w)+32*w)*armA (3*w) +
      (32*w)*armB (3*w) = 1 := by
  dsimp [bezPoly,armA,armB]
  grind

theorem int_coprime_of_bezout (a b s t : Int) (h : s*a+t*b=1) :
    Int.gcd a b=1 := by
  let d := Int.gcd a b
  have ha : (d:Int) ∣ a := Int.gcd_dvd_left a b
  have hb : (d:Int) ∣ b := Int.gcd_dvd_right a b
  obtain ⟨x,hx⟩ := ha
  obtain ⟨y,hy⟩ := hb
  have hd : (d:Int) ∣ 1 := by
    refine ⟨s*x+t*y,?_⟩
    calc
      1 = s*a+t*b := h.symm
      _ = (d:Int)*(s*x+t*y) := by rw [hx,hy]; grind
  have hn : d ∣ 1 := by
    have hh := Int.natAbs_dvd_natAbs.mpr hd
    simpa using hh
  exact Nat.dvd_one.mp hn

theorem family_coprime (w : Int) : Int.gcd (armA (3*w)) (armB (3*w))=1 := by
  exact int_coprime_of_bezout _ _ _ _ (family_bezout w)

def parameter (n : Nat) : Int := 3+3675*(n:Int)

theorem parameter_multiple_three (n : Nat) :
    parameter n = 3*(1+1225*(n:Int)) := by
  dsimp [parameter]
  grind

theorem primitive_specialization (n : Nat) :
    armA (parameter n)+armB (parameter n)=armC (parameter n) ∧
    Int.gcd (armA (parameter n)) (armB (parameter n))=1 := by
  constructor
  · exact family_sum _
  · rw [parameter_multiple_three]
    exact family_coprime _

theorem positive_specialization (n : Nat) :
    0 < armA (parameter n) ∧ 0 < armB (parameter n) := by
  have hv : 3 ≤ parameter n := by dsimp [parameter]; omega
  have hp : 0 < parameter n+1 := by omega
  have hm : 0 < parameter n-1 := by omega
  have h2 := Int.mul_pos hp hp
  have h3 := Int.mul_pos h2 hp
  have hb := Int.mul_pos h3 hm
  constructor
  · dsimp [armA]; omega
  · dsimp [armB]
    grind

theorem exact_residues (n : Nat) :
    armA (parameter n)%49=7 ∧ armB (parameter n)%5=3 ∧
    armC (parameter n)%25=10 ∧ armB (parameter n)%7=2 ∧
    armC (parameter n)%7=2 := by
  simp [armA,armB,armC,parameter,Int.pow_succ,Int.add_emod,Int.sub_emod,Int.mul_emod]

theorem first_example :
    armA (parameter 0)=7 ∧ armB (parameter 0)=128 ∧
    armC (parameter 0)=135 ∧ pointX (parameter 0)=16 ∧
    pointY (parameter 0)=144 := by decide

/-- Any linear action fixing a nonzero first-basis vector cannot contain this matrix. -/
theorem lower_transvection_moves_fixed_vector :
    ((1:Nat)*1+0*0)%3=1 ∧ ((1:Nat)*1+1*0)%3=1 ∧ (1:Nat)≠0 := by decide

theorem fixed_vector_forces_first_column (a b c d : Nat)
    (ha : a<3) (hc : c<3)
    (h : ((a*1+b*0)%3,(c*1+d*0)%3)=(1,0)) : a=1 ∧ c=0 := by
  simp only [Nat.mul_one,Nat.mul_zero,Nat.add_zero] at h
  have h1 := congrArg Prod.fst h
  have h2 := congrArg Prod.snd h
  simp only at h1 h2
  omega

theorem split_multiplier_identity (u : Int) :
    (u^6+1)^2-u^6 = u^12+u^6+1 := by grind

theorem split_other_factor_at_D (u : Int) :
    u^12+u^6+1=u^6*(u^6+1)+1 ∧ u^6-1=(u^6+1)-2 := by
  constructor <;> grind

theorem split_derivative_square (u : Int) :
    (2*u^6+1)^2+3 = 4*(u^12+u^6+1) := by grind

theorem height_credit_integer_identity (T R E C : Nat) (h : T*C=R^3*E) :
    4*T*C=4*R^3*E := by
  calc
    4*T*C = 4*(T*C) := Nat.mul_assoc 4 T C
    _ = 4*(R^3*E) := congrArg (fun x : Nat => 4*x) h
    _ = 4*R^3*E := (Nat.mul_assoc 4 (R^3) E).symm

#print axioms family_sum
#print axioms point_on_curve
#print axioms triple_tangent_identity
#print axioms tangent_contains_point
#print axioms tangent_derivative
#print axioms doubling_x_identity
#print axioms cubic_bezout
#print axioms family_bezout
#print axioms int_coprime_of_bezout
#print axioms family_coprime
#print axioms parameter_multiple_three
#print axioms primitive_specialization
#print axioms positive_specialization
#print axioms exact_residues
#print axioms first_example
#print axioms lower_transvection_moves_fixed_vector
#print axioms fixed_vector_forces_first_column
#print axioms split_multiplier_identity
#print axioms split_other_factor_at_D
#print axioms split_derivative_square
#print axioms height_credit_integer_identity
end ABCHeightVisibility20260906
