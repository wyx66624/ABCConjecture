import ActualPrimeLogCompensation

/-! The finite real-log height premises follow from actual positive integer
input/output arms. No analytic estimate or asymptotic membership is used. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCActualPrimeLogHeight20260907
open ABCActualPrimeLogCompensation20260907

theorem nat_log_mul (U V : Nat) (hU : U ≠ 0) (hV : V ≠ 0) :
    Real.log (U*V : Nat) = Real.log U + Real.log V := by
  rw [Nat.cast_mul, Real.log_mul (by exact_mod_cast hU) (by exact_mod_cast hV)]

theorem small_mass_mul (Y U V : Nat) (hU : U ≠ 0) (hV : V ≠ 0) :
    smallMass Y (U*V) = smallMass Y U + smallMass Y V := by
  have h₁ := mass_partition Y U
  have h₂ := mass_partition Y V
  have h₃ := mass_partition Y (U*V)
  have hm := mass_mul Y U V hU hV
  have hl := nat_log_mul U V hU hV
  linarith

theorem nat_log_monotone (U V : Nat) (hU : U ≠ 0) (hUV : U ≤ V) :
    Real.log U ≤ Real.log V := by
  apply Real.log_le_log
  · exact_mod_cast Nat.pos_of_ne_zero hU
  · exact_mod_cast hUV

theorem output_log_lower (X Z W H : Nat)
    (hX : X ≠ 0) (hZ : Z ≠ 0) (hW : W ≠ 0)
    (hZH : Z ≤ H) (hWH : W ≤ H) :
    Real.log H-(3*Real.log H-Real.log (X*Z*W : Nat)) ≤ Real.log X := by
  have h₁ := nat_log_monotone Z H hZ hZH
  have h₂ := nat_log_monotone W H hW hWH
  have hp : Real.log (X*Z*W : Nat)=Real.log X+Real.log Z+Real.log W := by
    rw [nat_log_mul (X*Z) W (Nat.mul_ne_zero hX hZ) hW, nat_log_mul X Z hX hZ]
  linarith

theorem actual_arm_mass_bounds (Y a A H H1 : Nat)
    (ha : a ≠ 0) (hA : A ≠ 0) (hin : a ≤ H1) (hout : a*A ≤ H)
    (delta : Real) (hlo : Real.log H-delta ≤ Real.log (a*A : Nat)) :
    Real.log H-delta-Real.log H1-smallMass Y A ≤ mass Y A ∧
    mass Y A ≤ Real.log H := by
  have hinlog := nat_log_monotone a H1 ha hin
  have hp := nat_log_mul a A ha hA
  have hs := mass_partition Y A
  have ha1 : 1 ≤ a := by omega
  have hAA : A ≤ a*A := by nlinarith
  have hAH : A ≤ H := le_trans hAA hout
  have hupper := le_trans (mass_le_log Y A) (nat_log_monotone A H hA hAH)
  constructor
  · linarith
  · exact hupper

theorem two_small_parts_le_product (Y U A B C : Nat)
    (hU : U ≠ 0) (hA : A ≠ 0) (hB : B ≠ 0) (hC : C ≠ 0) :
    smallMass Y A + smallMass Y B ≤ smallMass Y (U*(A*B*C)) := by
  rw [small_mass_mul Y U (A*B*C) hU (Nat.mul_ne_zero (Nat.mul_ne_zero hA hB) hC),
    small_mass_mul Y (A*B) C (Nat.mul_ne_zero hA hB) hC,
    small_mass_mul Y A B hA hB]
  have hu := small_mass_nonnegative Y U
  have hc := small_mass_nonnegative Y C
  linarith

/-- Complete finite SA prime-log inequality from positive natural arm data.
The actual Eisenstein orbit supplies these multiplication, coprimality
and maximum-height premises; none is encoded as an added axiom. -/
theorem finite_actual_arm_compensation (Y a b d A B C H H1 : Nat)
    (ha : a ≠ 0) (hb : b ≠ 0) (hd : d ≠ 0)
    (hA : A ≠ 0) (hB : B ≠ 0) (hC : C ≠ 0)
    (hAB : A.Coprime B) (hAC : A.Coprime C) (hBC : B.Coprime C)
    (haH1 : a ≤ H1) (hbH1 : b ≤ H1)
    (haH : a*A ≤ H) (hbH : b*B ≤ H) (hdH : d*C ≤ H) :
    signedCost Y ((a*A)*(b*B)*(d*C)) ≤
      (3*Real.log H-Real.log ((a*A)*(b*B)*(d*C) : Nat))+
      Real.log H1+Real.log (a*b*d : Nat)+smallMass Y ((a*A)*(b*B)*(d*C))/2+
      3*(excess 2 Y A+excess 2 Y B)/2-3*radical Y C := by
  let T := (a*A)*(b*B)*(d*C)
  let delta := 3*Real.log H-Real.log T
  have he : T=(a*b*d)*(A*B*C) := by dsimp [T]; ring
  have hau := Nat.mul_ne_zero ha hA
  have hbu := Nat.mul_ne_zero hb hB
  have hdu := Nat.mul_ne_zero hd hC
  have hU := Nat.mul_ne_zero (Nat.mul_ne_zero ha hb) hd
  have hlowA : Real.log H-delta ≤ Real.log (a*A : Nat) :=
    output_log_lower (a*A) (b*B) (d*C) H hau hbu hdu hbH hdH
  have heB : (b*B)*(a*A)*(d*C)=T := by dsimp [T]; ring
  have hlowB : Real.log H-delta ≤ Real.log (b*B : Nat) := by
    have hx := output_log_lower (b*B) (a*A) (d*C) H hbu hau hdu haH hdH
    rw [heB] at hx
    exact hx
  have hba := actual_arm_mass_bounds Y a A H H1 ha hA haH1 haH delta hlowA
  have hbb := actual_arm_mass_bounds Y b B H H1 hb hB hbH1 hbH delta hlowB
  have hd1 : 1 ≤ d := by omega
  have hCH : C ≤ H := by nlinarith
  have hc := le_trans (mass_le_log Y C) (nat_log_monotone C H hC hCH)
  have hcost := actual_two_arm_with_old_factor Y (a*b*d) A B C hU hA hB hC hAB hAC hBC
    (Real.log H) (delta+Real.log H1) (smallMass Y A) (smallMass Y B) hc
    (by linarith [hba.1]) (by linarith [hbb.1])
  have hsmall := two_small_parts_le_product Y (a*b*d) A B C hU hA hB hC
  rw [← he] at hcost hsmall
  change signedCost Y T ≤ delta+Real.log H1+Real.log (a*b*d : Nat)+smallMass Y T/2+
    3*(excess 2 Y A+excess 2 Y B)/2-3*radical Y C
  linarith

#print axioms nat_log_mul
#print axioms small_mass_mul
#print axioms nat_log_monotone
#print axioms output_log_lower
#print axioms actual_arm_mass_bounds
#print axioms two_small_parts_le_product
#print axioms finite_actual_arm_compensation
end ABCActualPrimeLogHeight20260907
