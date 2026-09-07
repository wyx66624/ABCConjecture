import LocalPowerArithmetic

/-! The actual bad-prime conclusions used in the independently reviewed
QC2 proof. Finite residue tables are transferred to all primitive integer
seeds. These results do not formalize the number field or its covers. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCQuarticSupportArithmetic20260907
open ABCLocalPowerArithmetic20260907

theorem second_mod (a b m : Int) :
    second a b % m = second (a%m) (b%m) % m := by
  simp [second_quartic,Int.pow_succ,Int.pow_zero,Int.add_emod,Int.mul_emod]

theorem primitive_not_both_zero_mod (a b p : Int) (hp : ¬ p ∣ 1)
    (hg : Int.gcd a b = 1) : ¬ (a%p=0 ∧ b%p=0) := by
  rintro ⟨ha,hb⟩
  exact hp (Int.gcd_eq_one_iff.mp hg p
    (Int.dvd_of_emod_eq_zero ha) (Int.dvd_of_emod_eq_zero hb))

theorem second_three_table : ∀ a b : Fin 3,
    ¬ (a.val=0 ∧ b.val=0) → second a.val b.val % 3 = 1 := by decide

theorem primitive_second_mod_three (a b : Int) (hg : Int.gcd a b = 1) :
    second a b % 3 = 1 := by
  let fa : Fin 3 := ⟨(a%3).toNat,by omega⟩
  let fb : Fin 3 := ⟨(b%3).toNat,by omega⟩
  have ha : (fa.val : Int)=a%3 := by dsimp [fa]; omega
  have hb : (fb.val : Int)=b%3 := by dsimp [fb]; omega
  have hp := primitive_not_both_zero_mod a b 3 (by decide) hg
  have h := second_three_table fa fb (by dsimp [fa,fb]; omega)
  rw [ha,hb] at h
  rw [second_mod]
  exact h

theorem second_thirteen_table : ∀ a b : Fin 13,
    second a.val b.val % 13 = 0 → a.val=b.val := by decide

theorem thirteen_remainder_diagonal (a b : Int) (h : 13 ∣ second a b) :
    a%13=b%13 := by
  let fa : Fin 13 := ⟨(a%13).toNat,by omega⟩
  let fb : Fin 13 := ⟨(b%13).toNat,by omega⟩
  have ha : (fa.val : Int)=a%13 := by dsimp [fa]; omega
  have hb : (fb.val : Int)=b%13 := by dsimp [fb]; omega
  have hh : second fa.val fb.val % 13=0 := by
    rw [ha,hb,← second_mod]
    exact Int.emod_eq_zero_of_dvd h
  have he := second_thirteen_table fa fb hh
  omega

theorem thirteen_shift_identity (b t : Int) :
    second (b+13*t) b = 13*b^4+
      169*(2*b^3*t+20*b^2*t^2+91*b*t^3+169*t^4) := by
  rw [second_quartic]
  grind

theorem fourth_power_zero_thirteen_table : ∀ b : Fin 13,
    (b.val : Int)^4%13=0 → b.val=0 := by decide

theorem thirteen_divides_of_divides_fourth_power (b : Int) (h : 13 ∣ b^4) :
    b%13=0 := by
  let fb : Fin 13 := ⟨(b%13).toNat,by omega⟩
  have hb : (fb.val : Int)=b%13 := by dsimp [fb]; omega
  have he : (b%13)^4%13=b^4%13 := by
    simp [Int.pow_succ,Int.pow_zero,Int.mul_emod]
  have hz : (fb.val : Int)^4%13=0 := by
    rw [hb,he]
    exact Int.emod_eq_zero_of_dvd h
  have hzero := fourth_power_zero_thirteen_table fb hz
  omega

/-- For every primitive integer seed, a thirteen factor occurs to depth exactly one. -/
theorem primitive_second_thirteen_exact_depth (a b : Int)
    (hg : Int.gcd a b = 1) (h13 : 13 ∣ second a b) :
    ¬ 169 ∣ second a b := by
  intro h169
  have hdiag := thirteen_remainder_diagonal a b h13
  have hd : 13 ∣ a-b := Int.dvd_of_emod_eq_zero (by omega)
  rcases hd with ⟨t,ht⟩
  have ha : a=b+13*t := by omega
  have hf := thirteen_shift_identity b t
  rw [← ha] at hf
  rcases h169 with ⟨u,hu⟩
  have hb4 : 13 ∣ b^4 := by
    refine ⟨u-(2*b^3*t+20*b^2*t^2+91*b*t^3+169*t^4),?_⟩
    grind
  have hb := thirteen_divides_of_divides_fourth_power b hb4
  exact primitive_not_both_zero_mod a b 13 (by decide) hg ⟨by omega,hb⟩

/-- Thirteen cannot be absorbed by any actual extraction root of exponent at least two. -/
theorem thirteen_cannot_divide_extraction_root (a b V Q : Int) (g : Nat)
    (hg : Int.gcd a b = 1) (he : 2 ≤ g) (hf : second a b = V*Q^g) :
    ¬ 13 ∣ Q := by
  intro hQ
  rcases hQ with ⟨r,hr⟩
  have hp : Q^g=169*(r^2*Q^(g-2)) := by
    calc
      Q^g = Q^2*Q^(g-2) := by rw [← Int.pow_add]; congr 1; omega
      _ = 169*(r^2*Q^(g-2)) := by rw [hr]; grind
  have hd : 169 ∣ second a b := by
    refine ⟨V*r^2*Q^(g-2),?_⟩
    rw [hf,hp]
    grind
  have h13 : 13 ∣ second a b := Int.dvd_trans (by decide : (13:Int) ∣ 169) hd
  exact primitive_second_thirteen_exact_depth a b hg h13 hd

#print axioms second_mod
#print axioms primitive_not_both_zero_mod
#print axioms second_three_table
#print axioms primitive_second_mod_three
#print axioms second_thirteen_table
#print axioms thirteen_remainder_diagonal
#print axioms thirteen_shift_identity
#print axioms fourth_power_zero_thirteen_table
#print axioms thirteen_divides_of_divides_fourth_power
#print axioms primitive_second_thirteen_exact_depth
#print axioms thirteen_cannot_divide_extraction_root
end ABCQuarticSupportArithmetic20260907
