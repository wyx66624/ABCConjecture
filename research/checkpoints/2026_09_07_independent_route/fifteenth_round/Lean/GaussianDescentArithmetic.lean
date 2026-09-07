import Mathlib.Data.Int.GCD
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

/-! Actual integer and rational-function arithmetic for GD.
No curve group, UFD, isogeny degree or Mordell--Weil rank is formalized here. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000

namespace ABCGaussianDescent20260907

def fHom (a d : ℤ) : ℤ := a^3 - 9*a*d^4 - 9*d^6
def fPrimeHom (a d : ℤ) : ℤ := a^3 - 189*a*d^4 + 999*d^6

theorem actual_gaussian_norm (a b d : ℤ) (h : b^2 = fHom a d) :
    b^2 + 9*d^2*(a+2*d^2)^2 = (a+3*d^2)^3 := by
  rw [h]
  dsimp [fHom]
  ring

theorem actual_real_quadratic_norm (a b d : ℤ) (h : b^2 = fPrimeHom a d) :
    b^2 - 27*d^2*(a-8*d^2)^2 = (a-9*d^2)^3 := by
  rw [h]
  dsimp [fPrimeHom]
  ring

theorem fHom_mod (a d m : ℤ) :
    fHom a d % m = fHom (a % m) (d % m) % m := by
  simp [fHom, Int.pow_succ, Int.sub_emod, Int.mul_emod]

theorem mod_twenty_seven_table : ∀ a b d : Fin 27,
    (b.val : ℤ)^2 % 27 = fHom a.val d.val % 27 →
      b.val % 3 = 0 → a.val % 3 = 0 ∧ d.val % 3 = 0 := by decide

theorem actual_congruence_three (a b d : ℤ)
    (h : b^2 % 27 = fHom a d % 27) (hb : b % 3 = 0) :
    a % 3 = 0 ∧ d % 3 = 0 := by
  let fa : Fin 27 := ⟨(a % 27).toNat, by omega⟩
  let fb : Fin 27 := ⟨(b % 27).toNat, by omega⟩
  let fd : Fin 27 := ⟨(d % 27).toNat, by omega⟩
  have ha : (fa.val : ℤ) = a % 27 := by dsimp [fa]; omega
  have hb' : (fb.val : ℤ) = b % 27 := by dsimp [fb]; omega
  have hd : (fd.val : ℤ) = d % 27 := by dsimp [fd]; omega
  have hp : (b % 27)^2 % 27 = b^2 % 27 := by
    simp [Int.pow_succ, Int.mul_emod]
  have heq : (fb.val : ℤ)^2 % 27 = fHom fa.val fd.val % 27 := by
    rw [ha, hb', hd, hp, ← fHom_mod]
    exact h
  have hbf : fb.val % 3 = 0 := by dsimp [fb]; omega
  have ht := mod_twenty_seven_table fa fb fd heq hbf
  dsimp [fa, fd] at ht
  omega

theorem primitive_curve_three_unit (a b d : ℤ) (hg : Int.gcd a d = 1)
    (h : b^2 = fHom a d) : ¬ (3 : ℤ) ∣ b := by
  intro hb
  have hc := actual_congruence_three a b d (by rw [h]) (Int.emod_eq_zero_of_dvd hb)
  have hbad : (3 : ℤ) ∣ 1 :=
    Int.gcd_eq_one_iff.mp hg 3 (Int.dvd_of_emod_eq_zero hc.1)
      (Int.dvd_of_emod_eq_zero hc.2)
  exact (by decide : ¬ (3 : ℤ) ∣ 1) hbad

def f (x : ℚ) : ℚ := x^3 - 9*x - 9
def fPrime (t : ℚ) : ℚ := t^3 - 189*t + 999
def phiX (x : ℚ) : ℚ := x + 36/(x+3) - 36/(x+3)^2
def phiFactor (x : ℚ) : ℚ := 1 - 36/(x+3)^2 + 72/(x+3)^3
def psiX (t : ℚ) : ℚ := (t + 108/(t-9) + 108/(t-9)^2)/9
def psiFactor (t : ℚ) : ℚ := (1 - 108/(t-9)^2 - 216/(t-9)^3)/27

theorem opposite_isogeny_identity (t : ℚ) (ht : t-9 ≠ 0) :
    fPrime t * psiFactor t ^ 2 = f (psiX t) := by
  dsimp [fPrime, psiFactor, f, psiX]
  field_simp
  ring

theorem gaussian_inverse_norm (t : ℚ) (ht : t-9 ≠ 0) :
    fPrime t / (9*(t-9)^2) + (1+3/(t-9))^2 = psiX t + 3 := by
  dsimp [fPrime, psiX]
  field_simp
  ring

theorem gaussian_inverse_imaginary (t : ℚ) (ht : t-9 ≠ 0) :
    (1+3/(t-9)) * (3*(fPrime t/(9*(t-9)^2)) - (1+3/(t-9))^2) =
      3*(psiX t+2) := by
  dsimp [fPrime, psiX]
  field_simp
  ring

theorem gaussian_inverse_real_factor (t : ℚ) (ht : t-9 ≠ 0) :
    (fPrime t/(9*(t-9)^2) - 3*(1+3/(t-9))^2)/(3*(t-9)) =
      psiFactor t := by
  dsimp [fPrime, psiFactor]
  field_simp
  ring

theorem real_quadratic_inverse_norm (x : ℚ) (hx : x+3 ≠ 0) :
    f x/(x+3)^2 - 3*(1-3/(x+3))^2 = phiX x-9 := by
  dsimp [f, phiX]
  field_simp
  ring

theorem real_quadratic_inverse_imaginary (x : ℚ) (hx : x+3 ≠ 0) :
    (1-3/(x+3))*(f x/(x+3)^2 + (1-3/(x+3))^2) = phiX x-8 := by
  dsimp [f, phiX]
  field_simp
  ring

theorem real_quadratic_inverse_real_factor (x : ℚ) (hx : x+3 ≠ 0) :
    (f x/(x+3)^2 + 9*(1-3/(x+3))^2)/(x+3) = phiFactor x := by
  dsimp [f, phiFactor]
  field_simp
  ring

def twiceX (x : ℚ) : ℚ := (3*x^2-9)^2/(4*f x)-2*x
def twiceFactor (x : ℚ) : ℚ := (3*x^2-9)*(x-twiceX x)/(2*f x)-1
def thirdSlope (x : ℚ) : ℚ := (twiceFactor x-1)/(twiceX x-x)
def threeX (x : ℚ) : ℚ := f x * thirdSlope x ^ 2 - x - twiceX x
def threeFactor (x : ℚ) : ℚ := thirdSlope x * (x-threeX x)-1

theorem psi_phi_tripling_x (x : ℚ) (hx : x+3 ≠ 0) (hf : f x ≠ 0)
    (_hd : twiceX x-x ≠ 0) (hphi : phiX x-9 ≠ 0) :
    psiX (phiX x) = threeX x := by
  let z : ℚ := x+3
  let d : ℚ := x^3-3*x^2-9*x-9
  let k : ℚ := 16*(f x)^2-9*(x^2-3)*z*d
  let b : ℚ := x^4+18*x^2+72*x+81
  have hz : z ≠ 0 := hx
  have hp : phiX x-9 = d/z^2 := by
    dsimp [phiX, z, d]
    field_simp
    ring
  have hdn : d ≠ 0 := by
    intro hh
    apply hphi
    rw [hp, hh]
    simp
  have h2 : twiceX x = b/(4*f x) := by
    unfold twiceX
    field_simp [hf]
    dsimp [b, f]
    ring
  have hg : twiceX x-x = -3*z*d/(4*f x) := by
    unfold twiceX
    field_simp [hf]
    dsimp [z, d, f]
    ring
  have hs : thirdSlope x = k/(6*f x*z*d) := by
    unfold thirdSlope twiceFactor
    rw [hg, h2]
    field_simp [hf, hz, hdn]
    dsimp [k, b, z, d, f]
    ring
  have hpx : phiX x = (x^3+6*x^2+45*x+72)/z^2 := by
    dsimp [phiX, z]
    field_simp
    ring
  unfold psiX threeX
  rw [hp, hs, h2, hpx]
  field_simp [hf, hz, hdn]
  dsimp [k, b, z, d, f]
  ring

theorem psi_phi_tripling_factor (x : ℚ) (hx : x+3 ≠ 0) (hf : f x ≠ 0)
    (_hd : twiceX x-x ≠ 0) (hphi : phiX x-9 ≠ 0) :
    phiFactor x * psiFactor (phiX x) = threeFactor x := by
  let z : ℚ := x+3
  let d : ℚ := x^3-3*x^2-9*x-9
  let k : ℚ := 16*(f x)^2-9*(x^2-3)*z*d
  let b : ℚ := x^4+18*x^2+72*x+81
  have hz : z ≠ 0 := hx
  have hp : phiX x-9 = d/z^2 := by
    dsimp [phiX, z, d]
    field_simp
    ring
  have hdn : d ≠ 0 := by
    intro hh
    apply hphi
    rw [hp, hh]
    simp
  have h2 : twiceX x = b/(4*f x) := by
    unfold twiceX
    field_simp [hf]
    dsimp [b, f]
    ring
  have hg : twiceX x-x = -3*z*d/(4*f x) := by
    unfold twiceX
    field_simp [hf]
    dsimp [z, d, f]
    ring
  have hs : thirdSlope x = k/(6*f x*z*d) := by
    unfold thirdSlope twiceFactor
    rw [hg, h2]
    field_simp [hf, hz, hdn]
    dsimp [k, b, z, d, f]
    ring
  have hpf : phiFactor x = (x^3+9*x^2-9*x-9)/z^3 := by
    dsimp [phiFactor, z]
    field_simp
    ring
  unfold psiFactor threeFactor threeX
  rw [hp, hs, h2, hpf]
  field_simp [hf, hz, hdn]
  dsimp [k, b, z, d, f]
  ring

#print axioms psi_phi_tripling_x
#print axioms psi_phi_tripling_factor
#print axioms actual_gaussian_norm
#print axioms actual_real_quadratic_norm
#print axioms fHom_mod
#print axioms mod_twenty_seven_table
#print axioms actual_congruence_three
#print axioms primitive_curve_three_unit
#print axioms opposite_isogeny_identity
#print axioms gaussian_inverse_norm
#print axioms gaussian_inverse_imaginary
#print axioms gaussian_inverse_real_factor
#print axioms real_quadratic_inverse_norm
#print axioms real_quadratic_inverse_imaginary
#print axioms real_quadratic_inverse_real_factor

end ABCGaussianDescent20260907
