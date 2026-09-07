import Mathlib.Data.Int.GCD
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.Field.ZMod
import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-! Actual polynomial and integer-square arithmetic for the ordinary SS gate.
This module does not formalize rational-point completeness, projective curves,
Jacobians, or the geometric isogeny degree. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000

namespace ABCSimultaneousElliptic20260907

def f (x : ℤ) : ℤ := x^3 - 9*x - 9
def h (x : ℤ) : ℤ := x+2
def largeH (x : ℤ) : ℤ := f x + 18*(h x)^2
def largeR (x : ℤ) : ℤ := f x - 108*(h x)^2
def largeJ (x : ℤ) : ℤ := 6*x*h x
def fHom (a d : ℤ) : ℤ := a^3 - 9*a*d^4 - 9*d^6
def hHom (a d : ℤ) : ℤ := a^3 + 18*a^2*d^2 + 63*a*d^4 + 63*d^6
def rHom (a d : ℤ) : ℤ := a^3 - 108*a^2*d^2 - 441*a*d^4 - 441*d^6

theorem discriminant_identity (x : ℤ) :
    (largeH x)^2 - f x * largeR x = (largeJ x)^2 * (4*x+9) := by
  dsimp [largeH, largeR, largeJ, f, h]
  ring

theorem quartic_conic_identity (x z : ℤ) :
    z^4 - 2*largeH x*z^2 + f x*largeR x =
      (f x-z^2)^2 - 36*(h x)^2*(3*f x+z^2) := by
  dsimp [largeH, largeR]
  ring

theorem homogeneous_quartic_conic (a b c d : ℤ) (hcurve : b^2 = fHom a d) :
    c^4 - 2*hHom a d*c^2 + b^2*rHom a d =
      (b^2-c^2)^2 - 36*d^2*(a+2*d^2)^2*(3*b^2+c^2) := by
  rw [hcurve]
  dsimp [hHom, rHom, fHom]
  ring

theorem actual_homogeneous_conic (a b c d : ℤ) (hcurve : b^2 = fHom a d)
    (hquartic : c^4 - 2*hHom a d*c^2 + b^2*rHom a d = 0) :
    (b^2-c^2)^2 = 36*d^2*(a+2*d^2)^2*(3*b^2+c^2) := by
  rw [homogeneous_quartic_conic a b c d hcurve] at hquartic
  exact sub_eq_zero.mp hquartic

theorem square_factor_divides (a m r : ℤ) (heq : a^2 = m^2*r) : m ∣ a := by
  apply (Int.pow_dvd_pow_iff (by decide : (2 : ℕ) ≠ 0)).mp
  exact ⟨r, heq⟩

theorem square_factor_quotient (a m r : ℤ) (hm : m ≠ 0) (heq : a^2 = m^2*r) :
    ∃ l : ℤ, a = m*l ∧ l^2 = r := by
  obtain ⟨l, hl⟩ := square_factor_divides a m r heq
  refine ⟨l, hl, ?_⟩
  have hh : m^2*l^2 = m^2*r := by rw [← heq, hl]; ring
  exact mul_left_cancel₀ (pow_ne_zero 2 hm) hh

theorem actual_integer_conic_lift (a b c d : ℤ) (hcurve : b^2 = fHom a d)
    (hquartic : c^4 - 2*hHom a d*c^2 + b^2*rHom a d = 0)
    (hd : d ≠ 0) (hk : a+2*d^2 ≠ 0) :
    ∃ l : ℤ, b^2-c^2 = (6*d*(a+2*d^2))*l ∧ l^2 = 3*b^2+c^2 := by
  apply square_factor_quotient
  · exact mul_ne_zero (mul_ne_zero (by norm_num) hd) hk
  · have ht := actual_homogeneous_conic a b c d hcurve hquartic
    convert ht using 1
    ring

theorem actual_curve_boundary_unit (p : ℕ) [Fact p.Prime] (a b d : ℤ)
    (hcop : Int.gcd a d = 1) (hcurve : b^2 = fHom a d)
    (hdiv : (p : ℤ) ∣ d*(a+2*d^2)) : ¬(p : ℤ) ∣ b := by
  intro hb
  have hb0 := (ZMod.intCast_zmod_eq_zero_iff_dvd b p).mpr hb
  have hc := congrArg (fun z : ℤ ↦ (z : ZMod p)) hcurve
  dsimp [fHom] at hc
  push_cast at hc
  have hbez : a*Int.gcdA a d+d*Int.gcdB a d=1 := by
    simpa [hcop] using (Int.gcd_eq_gcd_ab a d).symm
  have hz := congrArg (fun z : ℤ ↦ (z : ZMod p)) hbez
  push_cast at hz
  have hp0 := (ZMod.intCast_zmod_eq_zero_iff_dvd (d*(a+2*d^2)) p).mpr hdiv
  push_cast at hp0
  rcases mul_eq_zero.mp hp0 with hd0 | hk0
  · have ha3 : (a : ZMod p)^3=0 := by simpa [hb0, hd0] using hc.symm
    have ha0 := eq_zero_of_pow_eq_zero ha3
    simp [ha0, hd0] at hz
  · have ha : (a : ZMod p) = -2*(d : ZMod p)^2 := by linear_combination hk0
    have hd6 : (d : ZMod p)^6=0 := by
      rw [hb0, ha] at hc
      linear_combination -hc
    have hd0 := eq_zero_of_pow_eq_zero hd6
    have ha0 : (a : ZMod p)=0 := by simpa [hd0] using ha
    simp [ha0, hd0] at hz

theorem conic_cofactor_unit (p : ℕ) [Fact p.Prime] (hp : 3 < p) (b c m : ℤ)
    (hb : ¬(p : ℤ) ∣ b) (hm : (p : ℤ) ∣ m)
    (heq : (b^2-c^2)^2 = m^2*(3*b^2+c^2)) : ¬(p : ℤ) ∣ 3*b^2+c^2 := by
  intro hu
  have hm0 := (ZMod.intCast_zmod_eq_zero_iff_dvd m p).mpr hm
  have hu0 := (ZMod.intCast_zmod_eq_zero_iff_dvd (3*b^2+c^2) p).mpr hu
  push_cast at hu0
  have he := congrArg (fun z : ℤ ↦ (z : ZMod p)) heq
  push_cast at he
  have hbc2 : ((b : ZMod p)^2-(c : ZMod p)^2)^2=0 := by simpa [hm0] using he
  have hbc := eq_zero_of_pow_eq_zero hbc2
  have hfour : (4 : ZMod p)*(b : ZMod p)^2=0 := by linear_combination hu0+hbc
  have ht : (2 : ZMod p) ≠ 0 := by
    intro hh
    have hd := (ZMod.natCast_eq_zero_iff 2 p).mp hh
    exact Nat.not_dvd_of_pos_of_lt (by decide) (by omega) hd
  have hf : (4 : ZMod p) ≠ 0 := by
    have : (2 : ZMod p)*(2 : ZMod p) ≠ 0 := mul_ne_zero ht ht
    norm_num at this ⊢
    exact this
  have hb0 : (b : ZMod p)=0 := eq_zero_of_pow_eq_zero ((mul_eq_zero.mp hfour).resolve_left hf)
  exact hb ((ZMod.intCast_zmod_eq_zero_iff_dvd b p).mp hb0)

theorem square_factor_exact_depth (p : ℕ) [Fact p.Prime] (a m r : ℤ)
    (hm : m ≠ 0) (hr : ¬(p : ℤ) ∣ r) (heq : a^2=m^2*r) :
    padicValInt p a=padicValInt p m := by
  have hr0 : r ≠ 0 := by intro hh; exact hr (hh ▸ dvd_zero _)
  have ha0 : a ≠ 0 := by
    intro hh
    have hnon := mul_ne_zero (pow_ne_zero 2 hm) hr0
    apply hnon
    simpa [hh] using heq.symm
  have hv := congrArg (padicValInt p) heq
  simp only [pow_two] at hv
  rw [padicValInt.mul ha0 ha0,
    padicValInt.mul (mul_ne_zero hm hm) hr0, padicValInt.mul hm hm,
    padicValInt.eq_zero_of_not_dvd hr] at hv
  omega

theorem actual_boundary_exact_depth (p : ℕ) [Fact p.Prime] (hp : 3 < p)
    (a b c d : ℤ) (hcop : Int.gcd a d=1) (hcurve : b^2=fHom a d)
    (hquartic : c^4-2*hHom a d*c^2+b^2*rHom a d=0)
    (hd : d ≠ 0) (hk : a+2*d^2 ≠ 0)
    (hdiv : (p : ℤ) ∣ d*(a+2*d^2)) :
    padicValInt p (b^2-c^2)=padicValInt p (d*(a+2*d^2)) := by
  let m : ℤ := 6*(d*(a+2*d^2))
  have hm0 : m ≠ 0 := mul_ne_zero (by norm_num) (mul_ne_zero hd hk)
  have hm : (p : ℤ) ∣ m := dvd_mul_of_dvd_right hdiv 6
  have hb := actual_curve_boundary_unit p a b d hcop hcurve hdiv
  have he : (b^2-c^2)^2=m^2*(3*b^2+c^2) := by
    have ht := actual_homogeneous_conic a b c d hcurve hquartic
    dsimp [m]
    convert ht using 1
    ring
  have hu := conic_cofactor_unit p hp b c m hb hm he
  have hv := square_factor_exact_depth p (b^2-c^2) m (3*b^2+c^2) hm0 hu he
  have h6 : ¬(p : ℤ) ∣ (6 : ℤ) := by
    intro hh
    have hn : p ∣ 6 := by exact_mod_cast hh
    have hf := (Fact.out : p.Prime).dvd_mul.mp (show p ∣ 2*3 by omega)
    rcases hf with hp2 | hp3
    · exact Nat.not_dvd_of_pos_of_lt (by decide) (by omega) hp2
    · exact Nat.not_dvd_of_pos_of_lt (by decide) hp hp3
  dsimp [m] at hv
  rw [padicValInt.mul (by norm_num) (mul_ne_zero hd hk),
    padicValInt.eq_zero_of_not_dvd h6, zero_add] at hv
  exact hv

theorem three_isogeny_rational_identity (x : ℚ) (hx : x+3 ≠ 0) :
    (x^3-9*x-9) * (1-36/(x+3)^2+72/(x+3)^3)^2 =
      (x+36/(x+3)-36/(x+3)^2)^3 -
        189*(x+36/(x+3)-36/(x+3)^2) + 999 := by
  field_simp
  ring

#print axioms discriminant_identity
#print axioms quartic_conic_identity
#print axioms homogeneous_quartic_conic
#print axioms actual_homogeneous_conic
#print axioms square_factor_divides
#print axioms square_factor_quotient
#print axioms actual_integer_conic_lift
#print axioms actual_curve_boundary_unit
#print axioms conic_cofactor_unit
#print axioms square_factor_exact_depth
#print axioms actual_boundary_exact_depth
#print axioms three_isogeny_rational_identity

end ABCSimultaneousElliptic20260907
