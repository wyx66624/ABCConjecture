import EisensteinDescent
import Mathlib.NumberTheory.Divisors
import Mathlib.Tactic

/-! Finite arithmetic from the independently reviewed MC proof.
This module proves the actual pair-product phase and its divisor injection.
The finite-field torsion bound, sieve, and exceptional-set assertions remain ordinary. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCDeepRootPhase20260907
open ABCEisenstein20260905

def phaseReal (a b : Int) : Int := a * b - 1
def phaseImag (a b : Int) : Int := a + b + 1
def phaseDet (a b c d : Int) : Int :=
  phaseReal a b * phaseImag c d - phaseReal c d * phaseImag a b
def phaseConstant (u v : Int) : Int := u ^ 2 + u * v + v ^ 2
def hasPhase (u v a b : Int) : Prop := v * phaseReal a b = u * phaseImag a b

theorem actual_pair_coordinates (a b : Int) :
    mul (a, 1) (b, 1) = (phaseReal a b, phaseImag a b) := by
  simp [mul, phaseReal, phaseImag]

theorem actual_cross_difference (a b c d : Int) :
    mul (mul (a, 1) (b, 1)) (conjugate (mul (c, 1) (d, 1))) -
      mul (conjugate (mul (a, 1) (b, 1))) (mul (c, 1) (d, 1)) =
        (phaseDet a b c d, -2 * phaseDet a b c d) := by
  apply Prod.ext <;> dsimp [mul, conjugate, phaseDet, phaseReal, phaseImag] <;> ring

theorem phase_defect_factorization (u v a b : Int) :
    (v * a - u) * (v * b - u) - phaseConstant u v =
      v * (v * phaseReal a b - u * phaseImag a b) := by
  dsimp [phaseConstant, phaseReal, phaseImag]
  ring

theorem phase_factorization (u v a b : Int) (h : hasPhase u v a b) :
    (v * a - u) * (v * b - u) = phaseConstant u v := by
  have hh := phase_defect_factorization u v a b
  dsimp [hasPhase] at h
  rw [h] at hh
  linarith

theorem phase_factors_positive (u v a b : Int) (hu : 0 < u) (hv : 0 < v)
    (ha : 0 < a) (hb : 0 < b) (h : hasPhase u v a b) :
    0 < v * a - u ∧ 0 < v * b - u := by
  dsimp [hasPhase, phaseReal, phaseImag] at h
  have h1 : 0 < b * (v * a - u) := by nlinarith [mul_pos hu ha]
  have h2 : 0 < a * (v * b - u) := by nlinarith [mul_pos hu hb]
  exact ⟨(mul_pos_iff.mp h1).resolve_right (by omega) |>.2,
    (mul_pos_iff.mp h2).resolve_right (by omega) |>.2⟩

theorem phase_constant_positive (u v : Int) (hu : 0 < u) (hv : 0 < v) :
    0 < phaseConstant u v := by
  dsimp [phaseConstant]
  positivity

theorem phase_factor_mem_divisors (u v a b : Int) (hu : 0 < u) (hv : 0 < v)
    (h : hasPhase u v a b) :
    (v * a - u).natAbs ∈ (phaseConstant u v).natAbs.divisors := by
  apply Nat.mem_divisors.mpr
  constructor
  · apply Int.natAbs_dvd_natAbs.mpr
    exact ⟨v * b - u, (phase_factorization u v a b h).symm⟩
  · exact Int.natAbs_ne_zero.mpr (ne_of_gt (phase_constant_positive u v hu hv))

theorem phase_first_factor_injective (u v a b c d : Int) (hu : 0 < u) (hv : 0 < v)
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (hd : 0 < d)
    (hab : hasPhase u v a b) (hcd : hasPhase u v c d)
    (heq : (v * a - u).natAbs = (v * c - u).natAbs) : (a, b) = (c, d) := by
  have hp := phase_factors_positive u v a b hu hv ha hb hab
  have hq := phase_factors_positive u v c d hu hv hc hd hcd
  have hi : v * a - u = v * c - u := by
    have hn := congrArg (fun x : Nat ↦ (x : Int)) heq
    simpa only [Int.natCast_natAbs, abs_of_pos hp.1, abs_of_pos hq.1] using hn
  have hac : a = c := by nlinarith
  subst c
  have hf := phase_factorization u v a b hab
  have hg := phase_factorization u v a d hcd
  have hi' : v * b - u = v * d - u :=
    mul_left_cancel₀ (ne_of_gt hp.1) (hf.trans hg.symm)
  have hbd : b = d := by nlinarith
  exact Prod.ext rfl hbd

theorem phase_fiber_card_le_divisors (S : Finset (Int × Int)) (u v : Int)
    (hu : 0 < u) (hv : 0 < v)
    (hS : ∀ p ∈ S, 0 < p.1 ∧ 0 < p.2 ∧ hasPhase u v p.1 p.2) :
    S.card ≤ (phaseConstant u v).natAbs.divisors.card := by
  let f : Int × Int → Nat := fun p ↦ (v * p.1 - u).natAbs
  have hinj : Set.InjOn f (S : Set (Int × Int)) := by
    intro p hp q hq heq
    exact phase_first_factor_injective u v p.1 p.2 q.1 q.2 hu hv
      (hS p hp).1 (hS p hp).2.1 (hS q hq).1 (hS q hq).2.1
      (hS p hp).2.2 (hS q hq).2.2 heq
  calc
    S.card = (S.image f).card := (Finset.card_image_of_injOn hinj).symm
    _ ≤ (phaseConstant u v).natAbs.divisors.card := by
      apply Finset.card_le_card
      intro x hx
      obtain ⟨p, hp, rfl⟩ := Finset.mem_image.mp hx
      exact phase_factor_mem_divisors u v p.1 p.2 hu hv (hS p hp).2.2

theorem actual_pair_height_bounds (B a b : Int) (hB : 0 < B)
    (ha : 3 * B ≤ a) (ha' : a < 6 * B) (hb : 3 * B ≤ b) (hb' : b < 6 * B) :
    0 < phaseReal a b ∧ phaseReal a b ≤ 36 * B ^ 2 ∧
      0 < phaseImag a b ∧ phaseImag a b ≤ 12 * B := by
  have ha0 : 0 ≤ a := by omega
  have hb0 : 0 ≤ b := by omega
  have hmin : 9 ≤ a * b := by
    have ha3 : 3 ≤ a := by omega
    have hb3 : 3 ≤ b := by omega
    nlinarith [mul_nonneg (sub_nonneg.mpr ha3) (sub_nonneg.mpr hb3)]
  have hmax : a * b ≤ 36 * B ^ 2 := by
    nlinarith [mul_nonneg (show 0 ≤ 6 * B - a by omega) hb0,
      mul_nonneg (show 0 ≤ 6 * B - b by omega) (show 0 ≤ 6 * B by omega)]
  dsimp [phaseReal, phaseImag]
  omega

theorem coordinate_cross_bound (B r s r' s' : Int) (hB : 0 ≤ B)
    (hr : 0 ≤ r ∧ r ≤ 36 * B ^ 2) (hs : 0 ≤ s ∧ s ≤ 12 * B)
    (hr' : 0 ≤ r' ∧ r' ≤ 36 * B ^ 2) (hs' : 0 ≤ s' ∧ s' ≤ 12 * B) :
    |r * s' - r' * s| ≤ 864 * B ^ 3 := by
  have hb3 : 0 ≤ B ^ 3 := pow_nonneg hB 3
  have h1 : r * s' ≤ 432 * B ^ 3 := by
    calc
      r * s' ≤ (36 * B ^ 2) * (12 * B) :=
        mul_le_mul hr.2 hs'.2 hs'.1 (by positivity)
      _ = 432 * B ^ 3 := by ring
  have h2 : r' * s ≤ 432 * B ^ 3 := by
    calc
      r' * s ≤ (36 * B ^ 2) * (12 * B) :=
        mul_le_mul hr'.2 hs.2 hs.1 (by positivity)
      _ = 432 * B ^ 3 := by ring
  apply abs_le.mpr
  constructor <;> nlinarith [mul_nonneg hr.1 hs'.1, mul_nonneg hr'.1 hs.1, hb3]

theorem actual_determinant_height_bound (B a b c d : Int) (hB : 0 < B)
    (ha : 3 * B ≤ a) (ha' : a < 6 * B) (hb : 3 * B ≤ b) (hb' : b < 6 * B)
    (hc : 3 * B ≤ c) (hc' : c < 6 * B) (hd : 3 * B ≤ d) (hd' : d < 6 * B) :
    |phaseDet a b c d| ≤ 864 * B ^ 3 := by
  obtain ⟨hr, hr', hs, hs'⟩ := actual_pair_height_bounds B a b hB ha ha' hb hb'
  obtain ⟨hR, hR', hS, hS'⟩ := actual_pair_height_bounds B c d hB hc hc' hd hd'
  exact coordinate_cross_bound B _ _ _ _ hB.le ⟨hr.le, hr'⟩ ⟨hs.le, hs'⟩
    ⟨hR.le, hR'⟩ ⟨hS.le, hS'⟩

theorem actual_large_modulus_phase_rigidity (B a b c d m : Int) (hB : 0 < B)
    (ha : 3 * B ≤ a) (ha' : a < 6 * B) (hb : 3 * B ≤ b) (hb' : b < 6 * B)
    (hc : 3 * B ≤ c) (hc' : c < 6 * B) (hd : 3 * B ≤ d) (hd' : d < 6 * B)
    (hm : 864 * B ^ 3 < m) (hdiv : m ∣ phaseDet a b c d) :
    phaseReal a b * phaseImag c d = phaseReal c d * phaseImag a b := by
  have hm0 : 0 < m := lt_trans (by positivity : 0 < 864 * B ^ 3) hm
  have hbound : |phaseDet a b c d| < m :=
    lt_of_le_of_lt (actual_determinant_height_bound B a b c d hB ha ha' hb hb'
      hc hc' hd hd') hm
  have habs : (phaseDet a b c d).natAbs < m.natAbs := by
    have hh : ((phaseDet a b c d).natAbs : Int) < (m.natAbs : Int) := by
      simpa only [Int.natCast_natAbs, abs_of_pos hm0] using hbound
    exact_mod_cast hh
  have hz := Int.eq_zero_of_dvd_of_natAbs_lt_natAbs hdiv habs
  exact sub_eq_zero.mp hz

theorem reduced_phase_constant_bound (B u v : Int) (hB : 0 < B)
    (hu : 0 < u) (hv : 0 < v) (huB : u ≤ 36 * B ^ 2) (hvB : v ≤ 12 * B) :
    phaseConstant u v ≤ 2500 * B ^ 4 := by
  have hb1 : 1 ≤ B := by omega
  have hsum : u + v ≤ 48 * B ^ 2 := by
    nlinarith [mul_nonneg hB.le (show 0 ≤ B - 1 by omega)]
  have hsq : (u + v) ^ 2 ≤ (48 * B ^ 2) ^ 2 :=
    pow_le_pow_left₀ (by omega) hsum 2
  dsimp [phaseConstant]
  nlinarith [mul_nonneg hu.le hv.le, sq_nonneg (B ^ 2)]

theorem actual_nontrivial_phase_collision :
    hasPhase 4526 1 7809 10767 ∧ hasPhase 4526 1 8397 9819 ∧
      (7809, 10767) ≠ (8397, 9819) ∧
      phaseConstant 4526 1 = 20489203 ∧
      3283 * 6241 = (20489203 : Int) ∧ 3871 * 5293 = (20489203 : Int) := by
  norm_num [hasPhase, phaseReal, phaseImag, phaseConstant]

#print axioms actual_pair_coordinates
#print axioms actual_cross_difference
#print axioms phase_defect_factorization
#print axioms phase_factorization
#print axioms phase_factors_positive
#print axioms phase_constant_positive
#print axioms phase_factor_mem_divisors
#print axioms phase_first_factor_injective
#print axioms phase_fiber_card_le_divisors
#print axioms actual_pair_height_bounds
#print axioms coordinate_cross_bound
#print axioms actual_determinant_height_bound
#print axioms actual_large_modulus_phase_rigidity
#print axioms reduced_phase_constant_bound
#print axioms actual_nontrivial_phase_collision
end ABCDeepRootPhase20260907
