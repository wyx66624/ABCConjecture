import Mathlib.Data.Nat.Squarefree
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic

/-! Actual natural-number divisibility in the CP power-extraction obstruction.
The squarefree coprime profile is an explicit input. Its realization by
Eisenstein interval products and the prime-distribution asymptotics remain
ordinary proofs. No assumption is made that the residual and power base are coprime. -/
set_option autoImplicit false
set_option maxHeartbeats 4000000
namespace ABCSquarefreePowerExtraction20260907

theorem power_base_divides_remainder (R D V Q g : ℕ) (hR : Squarefree R)
    (hg : 2 ≤ g) (he : R * D = V * Q ^ g) : Q ∣ D := by
  apply hR.dvd_of_squarefree_of_mul_dvd_mul_right
  rw [he, ← pow_two]
  exact dvd_mul_of_dvd_right (pow_dvd_pow Q hg) V

theorem squarefree_coprime_power_base (R D V Q g : ℕ) (hR : Squarefree R)
    (hcop : R.Coprime D) (hg : 2 ≤ g) (he : R * D = V * Q ^ g) : R.Coprime Q :=
  hcop.of_dvd_right (power_base_divides_remainder R D V Q g hR hg he)

theorem squarefree_factor_divides_residual (R D V Q g : ℕ) (hR : Squarefree R)
    (hcop : R.Coprime D) (hg : 2 ≤ g) (he : R * D = V * Q ^ g) : R ∣ V := by
  apply (Nat.Coprime.pow_right g
    (squarefree_coprime_power_base R D V Q g hR hcop hg he)).dvd_mul_right.mp
  rw [← he]
  exact dvd_mul_right R D

theorem extracted_power_divides_remainder (R D V Q g : ℕ) (hR : Squarefree R)
    (hcop : R.Coprime D) (hg : 2 ≤ g) (he : R * D = V * Q ^ g) : Q ^ g ∣ D := by
  apply (Nat.Coprime.pow_right g
    (squarefree_coprime_power_base R D V Q g hR hcop hg he)).symm.dvd_mul_left.mp
  rw [he]
  exact dvd_mul_left (Q ^ g) V

theorem remainder_nontrivial (R D V Q g : ℕ) (hR : Squarefree R)
    (hg : 2 ≤ g) (he : R * D = V * Q ^ g)
    (hQ : 1 < Q) (hD : 0 < D) : 1 < D := by
  have hdiv := power_base_divides_remainder R D V Q g hR hg he
  have hle := Nat.le_of_dvd hD hdiv
  omega

theorem prime_depth_bounds_exponent (R D V Q g p : ℕ) (hR : Squarefree R)
    (hcop : R.Coprime D) (hg : 2 ≤ g) (he : R * D = V * Q ^ g)
    (hD : D ≠ 0) (hp : p.Prime) (hpQ : p ∣ Q) : g ≤ D.factorization p := by
  apply (hp.pow_dvd_iff_le_factorization hD).mp
  exact (pow_dvd_pow_of_dvd hpQ g).trans
    (extracted_power_divides_remainder R D V Q g hR hcop hg he)

theorem exists_actual_prime_depth (R D V Q g : ℕ) (hR : Squarefree R)
    (hcop : R.Coprime D) (hg : 2 ≤ g) (he : R * D = V * Q ^ g)
    (hD : D ≠ 0) (hQ : 1 < Q) :
    ∃ p, p.Prime ∧ p ∣ Q ∧ p ∣ D ∧ g ≤ D.factorization p := by
  obtain ⟨p, hp, hpQ⟩ := Nat.exists_prime_and_dvd (by omega : Q ≠ 1)
  exact ⟨p, hp, hpQ, hpQ.trans (power_base_divides_remainder R D V Q g hR hg he),
    prime_depth_bounds_exponent R D V Q g p hR hcop hg he hD hp hpQ⟩

theorem uniform_depth_ceiling (R D V Q g L : ℕ) (hR : Squarefree R)
    (hcop : R.Coprime D) (hg : 2 ≤ g) (he : R * D = V * Q ^ g)
    (hD : D ≠ 0) (hQ : 1 < Q)
    (hdepth : ∀ p, p.Prime → p ∣ D → D.factorization p ≤ L) : g ≤ L := by
  obtain ⟨p, hp, _, hpD, hgp⟩ := exists_actual_prime_depth R D V Q g hR hcop hg he hD hQ
  exact hgp.trans (hdepth p hp hpD)

theorem residual_log_lower_bound (R D V Q g : ℕ) (hR : Squarefree R)
    (hcop : R.Coprime D) (hg : 2 ≤ g) (he : R * D = V * Q ^ g)
    (hV : 0 < V) : Real.log (R : ℝ) ≤ Real.log (V : ℝ) := by
  have hRpos : 0 < (R : ℝ) := by exact_mod_cast Nat.pos_of_ne_zero hR.ne_zero
  apply Real.log_le_log hRpos
  exact_mod_cast Nat.le_of_dvd hV
    (squarefree_factor_divides_residual R D V Q g hR hcop hg he)

theorem log_power_bound (Q D g : ℕ) (hQ : 1 < Q) (hD : 0 < D) (hdiv : Q ^ g ∣ D) :
    (g : ℝ) * Real.log 2 ≤ Real.log (D : ℝ) := by
  have hQreal : (2 : ℝ) ≤ Q := by exact_mod_cast hQ
  have hlog : Real.log 2 ≤ Real.log (Q : ℝ) :=
    Real.log_le_log (by norm_num) hQreal
  have hpowpos : (0 : ℝ) < (Q : ℝ) ^ g := by positivity
  have hpowle : (Q : ℝ) ^ g ≤ D := by exact_mod_cast Nat.le_of_dvd hD hdiv
  have hheight := Real.log_le_log hpowpos hpowle
  rw [Real.log_pow] at hheight
  have hgpos : (0 : ℝ) ≤ g := by positivity
  nlinarith

theorem compression_log_bound (R D V Q g : ℕ) (hR : Squarefree R)
    (hcop : R.Coprime D) (hg : 2 ≤ g) (he : R * D = V * Q ^ g)
    (hQ : 1 < Q) (hD : 0 < D) (hV : 0 < V) :
    Real.log 2 * Real.log (R : ℝ) / Real.log (D : ℝ) ≤
      Real.log (V : ℝ) / (g : ℝ) := by
  have hgt : (0 : ℝ) < g := by exact_mod_cast (by omega : 0 < g)
  have hDgt : (1 : ℝ) < D := by
    exact_mod_cast remainder_nontrivial R D V Q g hR hg he hQ hD
  have hlogD : 0 < Real.log (D : ℝ) := Real.log_pos hDgt
  have hRV := residual_log_lower_bound R D V Q g hR hcop hg he hV
  have hQD := log_power_bound Q D g hQ hD
    (extracted_power_divides_remainder R D V Q g hR hcop hg he)
  have hRlog := Real.log_natCast_nonneg R
  have hfirst : (g : ℝ) * Real.log 2 * Real.log (R : ℝ) ≤
      Real.log (D : ℝ) * Real.log (R : ℝ) :=
    mul_le_mul_of_nonneg_right hQD hRlog
  have hsecond := mul_le_mul_of_nonneg_left hRV (le_of_lt hlogD)
  apply (div_le_div_iff₀ hlogD hgt).mpr
  nlinarith

theorem actual_prime_power_height (R D V Q g H : ℕ) (hR : Squarefree R)
    (hcop : R.Coprime D) (hg : 2 ≤ g) (he : R * D = V * Q ^ g)
    (hD : D ≠ 0) (hQ : 1 < Q)
    (hprofile : ∀ p, p.Prime → p ∣ D → 7 ≤ p ∧ p ^ D.factorization p ≤ H) :
    7 ^ g ≤ H := by
  obtain ⟨p, hp, _, hpD, hdepth⟩ := exists_actual_prime_depth R D V Q g hR hcop hg he hD hQ
  obtain ⟨hp7, hpheight⟩ := hprofile p hp hpD
  calc
    7 ^ g ≤ p ^ g := Nat.pow_le_pow_left hp7 g
    _ ≤ p ^ D.factorization p := Nat.pow_le_pow_right hp.pos hdepth
    _ ≤ H := hpheight

theorem actual_prime_log_ceiling (R D V Q g H : ℕ) (hR : Squarefree R)
    (hcop : R.Coprime D) (hg : 2 ≤ g) (he : R * D = V * Q ^ g)
    (hD : D ≠ 0) (hQ : 1 < Q)
    (hprofile : ∀ p, p.Prime → p ∣ D → 7 ≤ p ∧ p ^ D.factorization p ≤ H) :
    (g : ℝ) * Real.log 7 ≤ Real.log (H : ℝ) := by
  have hheight := actual_prime_power_height R D V Q g H hR hcop hg he hD hQ hprofile
  have hreal : (7 : ℝ) ^ g ≤ H := by exact_mod_cast hheight
  have hlog := Real.log_le_log (by positivity : (0 : ℝ) < 7 ^ g) hreal
  simpa only [Real.log_pow] using hlog

theorem compression_prime_height_bound (R D V Q g H : ℕ) (hR : Squarefree R)
    (hcop : R.Coprime D) (hg : 2 ≤ g) (he : R * D = V * Q ^ g)
    (hD : D ≠ 0) (hQ : 1 < Q) (hV : 0 < V) (hH : 1 < H)
    (hprofile : ∀ p, p.Prime → p ∣ D → 7 ≤ p ∧ p ^ D.factorization p ≤ H) :
    Real.log 7 * Real.log (R : ℝ) / Real.log (H : ℝ) ≤
      Real.log (V : ℝ) / (g : ℝ) := by
  have hgt : (0 : ℝ) < g := by exact_mod_cast (by omega : 0 < g)
  have hHreal : (1 : ℝ) < H := by exact_mod_cast hH
  have hlogH := Real.log_pos hHreal
  have hRV := residual_log_lower_bound R D V Q g hR hcop hg he hV
  have hdepth := actual_prime_log_ceiling R D V Q g H hR hcop hg he hD hQ hprofile
  have hfirst := mul_le_mul_of_nonneg_right hdepth (Real.log_natCast_nonneg R)
  have hsecond := mul_le_mul_of_nonneg_left hRV (le_of_lt hlogH)
  apply (div_le_div_iff₀ hlogH hgt).mpr
  nlinarith

theorem quadratic_height_log_ceiling (B : ℕ) (hB : 36 ≤ B) :
    Real.log ((36 * B ^ 2 : ℕ) : ℝ) ≤ 3 * Real.log (B : ℝ) := by
  have hBpos : (0 : ℝ) < B := by exact_mod_cast (by omega : 0 < B)
  have h36 : Real.log 36 ≤ Real.log (B : ℝ) :=
    Real.log_le_log (by norm_num) (by exact_mod_cast hB)
  push_cast
  rw [Real.log_mul (by norm_num) (ne_of_gt (pow_pos hBpos 2)), Real.log_pow]
  norm_num only [Nat.cast_ofNat]
  nlinarith

theorem macroscopic_compression_obstruction (R D V Q g B : ℕ) (δ : ℝ)
    (hR : Squarefree R) (hcop : R.Coprime D) (hg : 2 ≤ g)
    (he : R * D = V * Q ^ g) (hD : D ≠ 0) (hQ : 1 < Q) (hV : 0 < V)
    (hB : 36 ≤ B) (hδ : 0 ≤ δ)
    (hmass : δ / 2 * B * Real.log (B : ℝ) ≤ Real.log (R : ℝ))
    (hprofile : ∀ p, p.Prime → p ∣ D → 7 ≤ p ∧ p ^ D.factorization p ≤ 36 * B ^ 2) :
    δ * Real.log 7 / 6 * B ≤ Real.log (V : ℝ) / (g : ℝ) := by
  have hgt : (0 : ℝ) < g := by exact_mod_cast (by omega : 0 < g)
  have hBlog : 0 < Real.log (B : ℝ) := by
    apply Real.log_pos
    exact_mod_cast (by omega : 1 < B)
  have h7log : 0 < Real.log 7 := Real.log_pos (by norm_num)
  have hdepth := (actual_prime_log_ceiling R D V Q g (36 * B ^ 2)
    hR hcop hg he hD hQ hprofile).trans (quadratic_height_log_ceiling B hB)
  have hRV := residual_log_lower_bound R D V Q g hR hcop hg he hV
  have hmassV := hmass.trans hRV
  have hBnonneg : (0 : ℝ) ≤ B := by positivity
  have hfactor : 0 ≤ δ / 6 * B := by positivity
  have hprod := mul_le_mul_of_nonneg_right hdepth hfactor
  apply (le_div_iff₀ hgt).mpr
  nlinarith

#print axioms power_base_divides_remainder
#print axioms squarefree_coprime_power_base
#print axioms squarefree_factor_divides_residual
#print axioms extracted_power_divides_remainder
#print axioms remainder_nontrivial
#print axioms prime_depth_bounds_exponent
#print axioms exists_actual_prime_depth
#print axioms uniform_depth_ceiling
#print axioms residual_log_lower_bound
#print axioms log_power_bound
#print axioms compression_log_bound
#print axioms actual_prime_power_height
#print axioms actual_prime_log_ceiling
#print axioms compression_prime_height_bound
#print axioms quadratic_height_log_ceiling
#print axioms macroscopic_compression_obstruction
end ABCSquarefreePowerExtraction20260907
