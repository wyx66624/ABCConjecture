import Std

/-! Author: ChatGPT. Scoped integral certificates only.
No moment estimate, external number-field theorem or ABC assertion is assumed
as an axiom or proved by this file. -/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCSparsePackets20260906

theorem determinant_basis (da db dc r u v up vp : Int) :
    (da*u)*((da+db*r)*up+db*dc*vp) -
      (da*up)*((da+db*r)*u+db*dc*v) =
    da*db*dc*(u*vp-up*v) := by grind

theorem basis_boundary (da db dc r s u v : Int)
    (h : da+db*r=dc*s) :
    (da+db*r)*u+db*dc*v = dc*(s*u+db*v) := by
  rw [h]
  grind

theorem basis_middle_arm (da db dc r u v : Int) :
    ((da+db*r)*u+db*dc*v)-da*u = db*(r*u+dc*v) := by grind

theorem determinant_divides (da db dc r u v up vp : Int) :
    da*db*dc ∣ (da*u)*((da+db*r)*up+db*dc*vp) -
      (da*up)*((da+db*r)*u+db*dc*v) := by
  refine ⟨u*vp-up*v, ?_⟩
  exact determinant_basis da db dc r u v up vp

theorem small_multiple_zero (D k : Int) (hD : 0 < D)
    (hlo : -D < D*k) (hhi : D*k < D) : k=0 := by
  have hneg : k<0 → False := by
    intro h
    have hk : k ≤ -1 := by omega
    have hs := Int.mul_le_mul_of_nonneg_left hk (Int.le_of_lt hD)
    have ht : D*k ≤ -D := by simpa using hs
    omega
  have hpos : 0<k → False := by
    intro h
    have hk : 1 ≤ k := by omega
    have hs := Int.mul_le_mul_of_nonneg_left hk (Int.le_of_lt hD)
    have ht : D ≤ D*k := by simpa using hs
    omega
  omega

theorem small_divisible_zero (D x : Int) (hD : 0<D)
    (hd : D ∣ x) (hlo : -D<x) (hhi : x<D) : x=0 := by
  obtain ⟨k,hk⟩ := hd
  have hz : k=0 := small_multiple_zero D k hD (by simpa [hk] using hlo)
    (by simpa [hk] using hhi)
  simp [hk,hz]

theorem equal_ray_of_small_determinant (a c b d D : Int) (hD : 0<D)
    (hd : D ∣ a*d-b*c) (hlo : -D<a*d-b*c) (hhi : a*d-b*c<D) :
    a*d=b*c := by
  have hz := small_divisible_zero D (a*d-b*c) hD hd hlo hhi
  omega

theorem cube_plus_one (x : Int) :
    x^3+1=(x+1)*(x^2-x+1) := by grind

theorem exact_three_lift (u : Int) :
    (3*u-1)^2-(3*u-1)+1=3*(1-3*u+3*u^2) := by grind

theorem lift_unit_mod_three (u : Int) :
    (1-3*u+3*u^2)%3=1 := by
  simp [Int.add_emod,Int.sub_emod]

theorem cubic_carry (u : Int) :
    (3*u-1)^3+1=9*u*(1-3*u+3*u^2) := by grind

theorem additive_family_primitive (b : Int) : Int.gcd 1 b=1 := by simp

theorem first_singleton_certificate :
    (8:Nat)+1=9 ∧ (9:Nat)%27=9 ∧ (1:Nat)*8*9>4*1*8 ∧
    (1:Nat)*9-(1:Nat)*9=0 := by decide

#print axioms determinant_basis
#print axioms basis_boundary
#print axioms basis_middle_arm
#print axioms determinant_divides
#print axioms small_multiple_zero
#print axioms small_divisible_zero
#print axioms equal_ray_of_small_determinant
#print axioms cube_plus_one
#print axioms exact_three_lift
#print axioms lift_unit_mod_three
#print axioms cubic_carry
#print axioms additive_family_primitive
#print axioms first_singleton_certificate
end ABCSparsePackets20260906
