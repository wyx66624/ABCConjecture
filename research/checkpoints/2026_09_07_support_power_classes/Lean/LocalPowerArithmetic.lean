import EisensteinDescent

/-!
Arithmetic pieces of the independently reviewed fourth-round LP and PL proofs.
The unbounded family below satisfies direct residue tests; it is not asserted
to have globally perfect-power norms. No Hensel, Kummer or Faltings theorem
is assumed or formalized in this module.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCLocalPowerArithmetic20260907
open ABCEisenstein20260905

def second (a b : Int) : Int := norm (a*b, norm (a,b))

theorem second_quartic (a b : Int) :
    second a b = a^4+3*a^3*b+5*a^2*b^2+3*a*b^3+b^4 := by
  dsimp [second, norm]
  grind

theorem consecutive_primitive (a : Int) : Int.gcd a (a+1) = 1 := by
  simp

theorem consecutive_norm (a : Int) :
    norm (a,a+1) = 1+3*a+3*a^2 := by
  dsimp [norm]
  grind

theorem consecutive_second (a : Int) :
    second a (a+1) = 1+7*a+20*a^2+26*a^3+13*a^4 := by
  rw [second_quartic]
  grind

theorem consecutive_mixed_primitive (a : Int) :
    Int.gcd (a*(a+1)) (norm (a,a+1)) = 1 := by
  apply Int.gcd_eq_one_iff.mpr
  intro d hprod hnorm
  have he : norm (a,a+1)-3*(a*(a+1)) = 1 := by
    rw [consecutive_norm]
    grind
  rw [← he]
  apply Int.dvd_sub hnorm
  rcases hprod with ⟨r,hr⟩
  exact ⟨3*r,by grind⟩

theorem consecutive_norm_power_residue (L k m : Int) (n : Nat) :
    m ∣ L → m ∣ norm (L*k,L*k+1)-(1:Int)^n := by
  intro h
  rcases h with ⟨r,hr⟩
  refine ⟨r*k*(3+3*L*k), ?_⟩
  rw [consecutive_norm]
  simp only [Int.one_pow]
  grind

theorem consecutive_second_power_residue (L k m : Int) (n : Nat) :
    m ∣ L → m ∣ second (L*k) (L*k+1)-(1:Int)^n := by
  intro h
  rcases h with ⟨r,hr⟩
  refine ⟨r*k*(7+20*L*k+26*(L*k)^2+13*(L*k)^3), ?_⟩
  rw [consecutive_second]
  simp only [Int.one_pow]
  grind

/-- A single actual primitive positive seed beyond any bound passes all
direct tests whose moduli divide L, for every pair of natural exponents. -/
theorem unbounded_simultaneous_residue_family (L T : Nat) (hL : 0 < L) :
    ∃ a b : Int, 0 < a ∧ 0 < b ∧ (T:Int) < a+b ∧
      Int.gcd a b = 1 ∧ Int.gcd (a*b) (norm (a,b)) = 1 ∧
      ∀ m : Int, m ∣ (L:Int) → ∀ e f : Nat,
        m ∣ norm (a,b)-(1:Int)^e ∧ m ∣ second a b-(1:Int)^f := by
  let a : Int := (L:Int)*((T:Int)+1)
  have hLi : 1 ≤ (L:Int) := by omega
  have hTi : 0 ≤ (T:Int) := by omega
  have hnon := Int.mul_nonneg (a:=(L:Int)-1) (b:=(T:Int)+1)
    (by omega) (by omega)
  have ha : (T:Int)+1 ≤ a := by dsimp [a]; grind
  refine ⟨a,a+1,by omega,by omega,by omega,
    consecutive_primitive a,consecutive_mixed_primitive a,?_⟩
  intro m hm e f
  exact ⟨consecutive_norm_power_residue L ((T:Int)+1) m e hm,
    consecutive_second_power_residue L ((T:Int)+1) m f hm⟩

theorem norm_simple_root_linearization (x : Int) :
    norm (1+x,2+x) = 7+9*x+3*x^2 := by
  dsimp [norm]
  grind

theorem second_simple_root_linearization (x : Int) :
    second (1+x) (2+x) = 67+177*x+176*x^2+78*x^3+13*x^4 := by
  rw [second_quartic]
  grind

theorem extraction_root_data :
    norm (1,2) = 7 ∧ norm (2,7) = 67 ∧
    Int.gcd 9 7 = 1 ∧ Int.gcd 177 67 = 1 := by decide

theorem residual_depth_one_data :
    norm (5,6) = 7*13 ∧ ¬ 13 ∣ (7:Int) ∧
    second 14 15 = 31*18541 ∧ ¬ 31 ∣ (18541:Int) := by decide

/-- The integer valuation step behind the h-free integrality lemma. -/
theorem hfree_valuation_nonnegative (h d v : Int)
    (hh : 0 < h) (_hd : 0 ≤ d) (hdh : d < h) (hint : 0 ≤ d+h*v) :
    0 ≤ v := by
  by_cases hv : 0 ≤ v
  · exact hv
  · have hm := Int.mul_nonneg (a:=h) (b:=-v-1) (by omega) (by omega)
    grind

/-- Exact minimal denominator exponent, at the nonnegative valuation level. -/
theorem minimal_denominator_exponent (h z : Nat) :
    h ∣ 4*z ↔ h / Nat.gcd h 4 ∣ z := by
  have hg : 0 < Nat.gcd h 4 := Nat.gcd_pos_of_pos_right h (by decide)
  rw [Nat.div_dvd_iff_dvd_mul (Nat.gcd_dvd_left h 4) hg]
  simpa [Nat.mul_comm] using (Nat.dvd_gcd_mul_iff_dvd_mul (k:=h) (n:=4) (m:=z)).symm

/-- The denominator clearing exponent is integral and has the required degree. -/
theorem denominator_clearing_degree (h : Nat) :
    4*(h / Nat.gcd h 4) = h*(4 / Nat.gcd h 4) := by
  have h₁ := Nat.mul_div_cancel' (Nat.gcd_dvd_left h 4)
  have h₂ := Nat.mul_div_cancel' (Nat.gcd_dvd_right h 4)
  have hg : 0 < Nat.gcd h 4 := Nat.gcd_pos_of_pos_right h (by decide)
  have he : Nat.gcd h 4*(4*(h / Nat.gcd h 4)) =
      Nat.gcd h 4*(h*(4 / Nat.gcd h 4)) := by grind
  exact Nat.eq_of_mul_eq_mul_left hg he

#print axioms second_quartic
#print axioms consecutive_primitive
#print axioms consecutive_norm
#print axioms consecutive_second
#print axioms consecutive_mixed_primitive
#print axioms consecutive_norm_power_residue
#print axioms consecutive_second_power_residue
#print axioms unbounded_simultaneous_residue_family
#print axioms norm_simple_root_linearization
#print axioms second_simple_root_linearization
#print axioms extraction_root_data
#print axioms residual_depth_one_data
#print axioms hfree_valuation_nonnegative
#print axioms minimal_denominator_exponent
#print axioms denominator_clearing_degree
end ABCLocalPowerArithmetic20260907
