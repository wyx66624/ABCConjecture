import Mathlib.Tactic
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise

/-! Finite algebra and actual mass cuts for the separately proved density gain.
This does not formalize the sieve, prime distribution or the Euler weights. -/
set_option autoImplicit false
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCPrivateDensityMass20260907
open scoped BigOperators

def normPolynomial (k : Int) : Int := 9 * k ^ 2 + 3 * k + 1
def cofactorPolynomial (m b c t : Int) : Int :=
  9 * m * t ^ 2 + (18 * b + 3) * t + c

theorem actual_cofactor_identity (m b c t : Int)
    (hc : normPolynomial b = m * c) :
    m * cofactorPolynomial m b c t = normPolynomial (b + m * t) := by
  dsimp [normPolynomial] at hc
  dsimp [cofactorPolynomial, normPolynomial]
  nlinarith [hc]

theorem actual_cofactor_discriminant (m b c : Int)
    (hc : normPolynomial b = m * c) :
    (18 * b + 3) ^ 2 - 4 * (9 * m) * c = -27 := by
  dsimp [normPolynomial] at hc
  nlinarith [hc]

variable {I : Type*} [DecidableEq I]

theorem actual_exception_indicator (s e : Finset I) (hes : e ⊆ s) :
    (∑ i ∈ s, if i ∈ e then (1 : Real) else 0) = (e.card : Real) := by
  have heq : s.filter (fun i ↦ i ∈ e) = e := by
    ext i
    simp only [Finset.mem_filter]
    exact ⟨fun h ↦ h.2, fun h ↦ ⟨hes h, h⟩⟩
  rw [← Finset.sum_filter]
  simp [heq]

theorem actual_finite_mass_cut (s e : Finset I) (w : I → Real)
    (U eps : Real) (hes : e ⊆ s)
    (hupper : ∀ i ∈ s, w i ≤ U)
    (hlower : ∀ i ∈ s, i ∉ e → w i ≤ U - eps) :
    (∑ i ∈ s, w i) ≤ (U - eps) * s.card + eps * e.card := by
  have hp : ∀ i ∈ s, w i ≤ U - eps + eps * (if i ∈ e then 1 else 0) := by
    intro i hi
    by_cases he : i ∈ e
    · simp only [if_pos he, mul_one]
      linarith [hupper i hi]
    · simpa only [if_neg he, mul_zero, add_zero] using hlower i hi he
  have hs := Finset.sum_le_sum hp
  simp only [Finset.sum_add_distrib, Finset.sum_const, nsmul_eq_mul,
    ← Finset.mul_sum, actual_exception_indicator s e hes] at hs
  nlinarith

theorem actual_private_mass_budget (s e : Finset I) (w : I → Real)
    (eps ell c : Real) (hc : 0 ≤ c) (hes : e ⊆ s)
    (hupper : ∀ i ∈ s, w i ≤ 2 * ell + c)
    (hlower : ∀ i ∈ s, i ∉ e → w i ≤ (2 - eps) * ell) :
    (∑ i ∈ s, w i) ≤ (2 - eps) * s.card * ell +
      eps * e.card * ell + c * s.card := by
  have hf := actual_finite_mass_cut s e w (2 * ell + c) (eps * ell) hes hupper
    (by intro i hi hei; linarith [hlower i hi hei])
  nlinarith

theorem strict_density_numerical_gain (eps C : Real)
    (heps : 0 < eps) (hepsupper : eps ≤ 1 / 10)
    (hC : C * eps ≤ 1 / 4) :
    (1 - C * eps ^ 2) / (2 - eps) ≥ 1 / 2 + eps / (4 * (2 - eps)) := by
  have hd : 0 < 2 - eps := by linarith
  have hm := mul_le_mul_of_nonneg_right hC (le_of_lt heps)
  apply (le_div_iff₀ hd).2
  field_simp
  nlinarith

theorem positive_half_density_gap (eps : Real)
    (heps : 0 < eps) (hepsupper : eps < 2) :
    (1 : Real) / 2 < 1 / 2 + eps / (8 * (2 - eps)) := by
  have hgap : 0 < eps / (8 * (2 - eps)) := by positivity
  linarith

theorem finite_error_density_gain (eps C loss : Real)
    (heps : 0 < eps) (hepsupper : eps ≤ 1 / 10)
    (hC : C * eps ≤ 1 / 4) (hloss : loss ≤ eps / 8) :
    1 / 2 + eps / (8 * (2 - eps)) ≤ (1 - C * eps ^ 2 - loss) / (2 - eps) := by
  have hd : 0 < 2 - eps := by linarith
  have hm := mul_le_mul_of_nonneg_right hC (le_of_lt heps)
  apply (le_div_iff₀ hd).2
  field_simp
  nlinarith

theorem actual_density_gain_from_mass (s e : Finset I) (w : I → Real)
    (B ell eps C loss : Real) (hB : 0 < B) (hell : 0 < ell)
    (heps : 0 < eps) (hepsupper : eps ≤ 1 / 10)
    (hC : C * eps ≤ 1 / 4) (hloss : loss ≤ eps / 8)
    (hes : e ⊆ s) (hcard : (e.card : Real) ≤ C * eps * B)
    (hmass : (1 - loss) * B * ell ≤ ∑ i ∈ s, w i)
    (hupper : ∀ i ∈ s, w i ≤ 2 * ell)
    (hlower : ∀ i ∈ s, i ∉ e → w i ≤ (2 - eps) * ell) :
    1 / 2 + eps / (8 * (2 - eps)) ≤ (s.card : Real) / B := by
  have hf := actual_private_mass_budget s e w eps ell 0 (by norm_num) hes
    (by simpa using hupper) hlower
  have hm := mul_le_mul_of_nonneg_left hcard (show 0 ≤ eps * ell by positivity)
  have hcore : (1 - C * eps ^ 2 - loss) * B ≤ (2 - eps) * s.card := by
    apply (mul_le_mul_iff_of_pos_right hell).mp
    nlinarith
  have hd : 0 < 2 - eps := by linarith
  have hquot : (1 - C * eps ^ 2 - loss) / (2 - eps) ≤ (s.card : Real) / B := by
    apply (le_div_iff₀ hB).2
    rw [div_mul_eq_mul_div]
    apply (div_le_iff₀ hd).2
    nlinarith
  exact (finite_error_density_gain eps C loss heps hepsupper hC hloss).trans hquot

theorem actual_density_gain_with_remainders (s e : Finset I) (w : I → Real)
    (B ell eps C loss R c : Real) (hB : 0 < B) (hell : 0 < ell)
    (heps : 0 < eps) (hepsupper : eps ≤ 1 / 10)
    (hC : C * eps ≤ 1 / 4) (hc : 0 ≤ c)
    (herror : loss + eps * R / B + c / ell ≤ eps / 8)
    (hes : e ⊆ s) (hsize : (s.card : Real) ≤ B)
    (hcard : (e.card : Real) ≤ C * eps * B + R)
    (hmass : (1 - loss) * B * ell ≤ ∑ i ∈ s, w i)
    (hupper : ∀ i ∈ s, w i ≤ 2 * ell + c)
    (hlower : ∀ i ∈ s, i ∉ e → w i ≤ (2 - eps) * ell) :
    1 / 2 + eps / (8 * (2 - eps)) ≤ (s.card : Real) / B := by
  let totalLoss := loss + eps * R / B + c / ell
  have hloss : totalLoss * B * ell = loss * B * ell + eps * R * ell + c * B := by
    dsimp [totalLoss]
    field_simp
  have hf := actual_private_mass_budget s e w eps ell c hc hes hupper hlower
  have hm := mul_le_mul_of_nonneg_left hcard (show 0 ≤ eps * ell by positivity)
  have hs := mul_le_mul_of_nonneg_left hsize hc
  have hcore : (1 - C * eps ^ 2 - totalLoss) * B ≤ (2 - eps) * s.card := by
    apply (mul_le_mul_iff_of_pos_right hell).mp
    nlinarith
  have hd : 0 < 2 - eps := by linarith
  have hquot : (1 - C * eps ^ 2 - totalLoss) / (2 - eps) ≤ (s.card : Real) / B := by
    apply (le_div_iff₀ hB).2
    rw [div_mul_eq_mul_div]
    apply (div_le_iff₀ hd).2
    nlinarith
  exact (finite_error_density_gain eps C totalLoss heps hepsupper hC herror).trans hquot

omit [DecidableEq I] in
theorem actual_natural_weighted_cutoff (s : Finset Nat) (w : Nat → Real) (z : Real)
    (hz : 1 < z) (hpos : ∀ i ∈ s, 1 ≤ i) (hw : ∀ i ∈ s, 0 ≤ w i)
    (hmoment : (∑ i ∈ s, w i * Real.log i) ≤
      Real.log z * (∑ i ∈ s, w i) / 2) :
    (∑ i ∈ s, w i) / 2 ≤ ∑ i ∈ s.filter (fun i : Nat ↦ (i : Real) ≤ z), w i := by
  have hp : ∀ i ∈ s, Real.log z *
      (w i - (if (i : Real) ≤ z then w i else 0)) ≤ w i * Real.log i := by
    intro i hi
    by_cases hiz : (i : Real) ≤ z
    · simp only [if_pos hiz, sub_self, mul_zero]
      apply mul_nonneg (hw i hi)
      exact Real.log_nonneg (by exact_mod_cast hpos i hi)
    · simp only [if_neg hiz, sub_zero]
      have hl := Real.log_le_log (show 0 < z by linarith) (le_of_not_ge hiz)
      nlinarith [mul_le_mul_of_nonneg_left hl (hw i hi)]
  have hs := Finset.sum_le_sum hp
  simp only [mul_sub, Finset.sum_sub_distrib, ← Finset.mul_sum] at hs
  rw [← Finset.sum_filter] at hs
  have hlog : 0 < Real.log z := Real.log_pos hz
  nlinarith

#print axioms actual_cofactor_identity
#print axioms actual_cofactor_discriminant
#print axioms actual_exception_indicator
#print axioms actual_finite_mass_cut
#print axioms actual_private_mass_budget
#print axioms strict_density_numerical_gain
#print axioms positive_half_density_gap
#print axioms finite_error_density_gain
#print axioms actual_density_gain_from_mass
#print axioms actual_density_gain_with_remainders
#print axioms actual_natural_weighted_cutoff
end ABCPrivateDensityMass20260907
