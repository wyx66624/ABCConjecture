/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.Frey139Tate210Realization20260830
import Mathlib.Data.Nat.Factorization.PrimePow
import Mathlib.NumberTheory.Primorial

/-!
# Exact arithmetic for the balanced level-43 Legendre example

The mathematical proofs precede this module in
`research/FREY_43_1289_BALANCED_LEGENDRE_REALIZATION_2026_08_30.md`.
The exact integer-to-real height argument is also proved beforehand in
`research/FREY_43_FORMAL_ARITHMETIC_PROOFS_2026_08_30.md`.
The primorial certificate uses the library's product of all primes up to
511, and the final exponent bound quantifies over every prime. No large
endpoint factorization, probabilistic primality test or external certificate
is trusted. The local-field, Tate, Frobenius and Galois interpretations
remain separate mathematical arguments, not new Lean axioms.
-/

namespace IUTThreeClosures.Frey43BalancedRealization20260830

open Frey139Tate210Realization20260830

-- The closed integer certificates below contain exponents larger than 256.
set_option exponentiation.threshold 2048

local instance prime5 : Fact (Nat.Prime 5) := ⟨by decide⟩
local instance prime43 : Fact (Nat.Prime 43) := ⟨by decide⟩

/-- The fixed positive integer in the balanced construction. -/
def balancedA : ℕ := 1289 * (1289 ^ 16 + 428)

/-- The actual three integer endpoints. -/
def endpointA : ℕ := balancedA ^ 2
def endpointB : ℕ := balancedA ^ 2 + 1
def endpointC : ℕ := 2 * balancedA ^ 2 + 1

/-- The product used for the arithmetic radical and Tate-order checks. -/
def endpointProduct : ℕ := endpointA * endpointB * endpointC

theorem balancedA_pos : 0 < balancedA := by norm_num [balancedA]

theorem endpoints_pos : 0 < endpointA ∧ 0 < endpointB ∧ 0 < endpointC := by
  norm_num [endpointA, endpointB, endpointC, balancedA]

theorem endpoints_sum : endpointA + endpointB = endpointC := by
  simp only [endpointA, endpointB, endpointC]
  omega

theorem endpoints_pairwise_coprime : PairwiseCoprimeABC endpointA endpointB endpointC := by
  norm_num [PairwiseCoprimeABC, endpointA, endpointB, endpointC, balancedA]

/-- This is an actual point of the repository's unchanged primitive abc type. -/
def balancedTriple : ABCPoint where
  a := endpointA
  b := endpointB
  c := endpointC
  a_pos := endpoints_pos.1
  b_pos := endpoints_pos.2.1
  c_pos := endpoints_pos.2.2
  sum_eq := endpoints_sum
  pairwise_coprime := endpoints_pairwise_coprime

theorem chosen_primes : Nat.Prime 1289 ∧ Nat.Prime 43 := by norm_num

theorem balancedA_residues :
    balancedA % 8 = 5 ∧ balancedA % 5 = 1 ∧ balancedA % 43 = 1 := by
  norm_num [balancedA]

theorem balancedA_at_1289 : 1289 ∣ balancedA ∧ ¬1289 ^ 2 ∣ balancedA := by
  norm_num [balancedA]

theorem balancedA_sandwich : 1289 ^ 17 < balancedA ∧ balancedA < 2 * 1289 ^ 17 := by
  norm_num [balancedA]

/-- These bounds apply to every endpoint, irrespective of its unknown large prime factors. -/
theorem endpoints_lt_two_pow :
    endpointA < 2 ^ 377 ∧ endpointB < 2 ^ 377 ∧ endpointC < 2 ^ 377 := by
  decide

set_option maxRecDepth 4000 in
set_option maxHeartbeats 800000 in
-- Evaluating the genuine primorial and this large product exceeds the default limit.
/-- The exact small-prime support certificate uses the actual primorial, not an assigned list. -/
theorem endpointProduct_gcd_primorial : Nat.gcd endpointProduct (primorial 511) = 102 := by
  decide

/-- Every prime below 512 in the product is one of the three explicitly small primes. -/
theorem small_prime_support {q : ℕ} (hq : Nat.Prime q) (hsmall : q < 512)
    (hdiv : q ∣ endpointProduct) : q = 2 ∨ q = 3 ∨ q = 17 := by
  have hP : q ∣ primorial 511 := hq.dvd_primorial_iff.mpr (by omega)
  have hg := Nat.dvd_gcd hdiv hP
  rw [endpointProduct_gcd_primorial] at hg
  change q ∣ 2 * 3 * 17 at hg
  rcases hq.dvd_mul.mp hg with h23 | h17
  · rcases hq.dvd_mul.mp h23 with h2 | h3
    · exact Or.inl ((Nat.prime_dvd_prime_iff_eq hq Nat.prime_two).mp h2)
    · exact Or.inr (Or.inl ((Nat.prime_dvd_prime_iff_eq hq Nat.prime_three).mp h3))
  · exact Or.inr (Or.inr ((Nat.prime_dvd_prime_iff_eq hq (by norm_num)).mp h17))

/-- The exact powers at the three small support primes are far below 43. -/
theorem small_prime_43_powers_not_dvd :
    ¬2 ^ 43 ∣ endpointProduct ∧ ¬3 ^ 43 ∣ endpointProduct ∧ ¬17 ^ 43 ∣ endpointProduct := by
  norm_num [endpointProduct, endpointA, endpointB, endpointC, balancedA]

/-- A 43rd prime power dividing the product must divide one endpoint. -/
theorem prime_power_dvd_endpoint {q : ℕ} (hq : Nat.Prime q)
    (hdiv : q ^ 43 ∣ endpointProduct) :
    q ^ 43 ∣ endpointA ∨ q ^ 43 ∣ endpointB ∨ q ^ 43 ∣ endpointC := by
  have hpp : IsPrimePow (q ^ 43) :=
    (isPrimePow_nat_iff _).mpr ⟨q, 43, hq, by norm_num, rfl⟩
  have hab : Nat.Coprime endpointA endpointB := endpoints_pairwise_coprime.1
  have habc : Nat.Coprime (endpointA * endpointB) endpointC := by
    norm_num [endpointA, endpointB, endpointC, balancedA]
  rcases habc.isPrimePow_dvd_mul hpp |>.mp hdiv with habdiv | hcdiv
  · rcases hab.isPrimePow_dvd_mul hpp |>.mp habdiv with hadiv | hbdiv
    · exact Or.inl hadiv
    · exact Or.inr (Or.inl hbdiv)
  · exact Or.inr (Or.inr hcdiv)

/-- Every prime, including all unknown large factors, has exponent less than 43. -/
theorem prime_43_power_not_dvd (q : ℕ) (hq : Nat.Prime q) :
    ¬q ^ 43 ∣ endpointProduct := by
  intro hdiv
  by_cases hsmall : q < 512
  · have hqdiv : q ∣ endpointProduct :=
      (dvd_pow_self q (by decide : 43 ≠ 0)).trans hdiv
    rcases small_prime_support hq hsmall hqdiv with rfl | rfl | rfl
    · exact small_prime_43_powers_not_dvd.1 hdiv
    · exact small_prime_43_powers_not_dvd.2.1 hdiv
    · exact small_prime_43_powers_not_dvd.2.2 hdiv
  · have hqbound : 512 ≤ q := by omega
    have hpow : (2 : ℕ) ^ 377 < q ^ 43 := by
      calc
        (2 : ℕ) ^ 377 < 512 ^ 43 := by decide
        _ ≤ q ^ 43 := by gcongr
    rcases prime_power_dvd_endpoint hq hdiv with ha | hb | hc
    · exact (not_le_of_gt (endpoints_lt_two_pow.1.trans hpow))
        (Nat.le_of_dvd endpoints_pos.1 ha)
    · exact (not_le_of_gt (endpoints_lt_two_pow.2.1.trans hpow))
        (Nat.le_of_dvd endpoints_pos.2.1 hb)
    · exact (not_le_of_gt (endpoints_lt_two_pow.2.2.trans hpow))
        (Nat.le_of_dvd endpoints_pos.2.2 hc)

/-- The statement uses the actual natural-number prime factorization. -/
theorem endpointProduct_factorization_lt (q : ℕ) (hq : Nat.Prime q) :
    endpointProduct.factorization q < 43 := by
  have hprod : endpointProduct ≠ 0 := by
    unfold endpointProduct
    exact mul_ne_zero (mul_ne_zero endpoints_pos.1.ne' endpoints_pos.2.1.ne')
      endpoints_pos.2.2.ne'
  apply lt_of_not_ge
  intro hle
  exact prime_43_power_not_dvd q hq
    ((hq.pow_dvd_iff_le_factorization hprod).mpr hle)

theorem level_degree_bound_prime_to_43 : Nat.Coprime (2 * 6 * 48 * 480) 43 := by decide

/-- The cyclotomic degree, tame inequality and projective inertia count are numerical facts. -/
theorem local_1290_numerics :
    1289 % 1290 = 1289 ∧ 1289 ^ 2 % 1290 = 1 ∧
      645 ≤ 1289 - 2 ∧ Nat.Coprime 645 1288 ∧ 2 * 645 = 1290 ∧
      21 * 15 + 43 + 20 < 645 ∧ 42 + 1 < 1289 := by
  decide

/-- The actual rational Weierstrass model underlying this construction. -/
def balancedCurve : WeierstrassCurve ℚ :=
  freyModel (endpointA : ℚ) (endpointB : ℚ)

instance balancedCurve_isElliptic : balancedCurve.IsElliptic := by
  refine ⟨isUnit_iff_ne_zero.mpr ?_⟩
  rw [balancedCurve, freyModel_discriminant]
  norm_num [endpointA, endpointB, balancedA]

/-- Its discriminant is calculated from the curve, with the true endpoint product. -/
theorem balancedCurve_discriminant :
    balancedCurve.Δ = 16 * (endpointProduct : ℚ) ^ 2 := by
  rw [balancedCurve, freyModel_discriminant]
  simp only [endpointProduct, Nat.cast_mul, ← Nat.cast_add, endpoints_sum]

/-- Its `c₄` invariant has the displayed balanced polynomial. -/
theorem balancedCurve_c4 :
    balancedCurve.c₄ = 16 * (3 * (balancedA : ℚ) ^ 4 + 3 * (balancedA : ℚ) ^ 2 + 1) := by
  rw [balancedCurve, freyModel_c4]
  simp only [endpointA, endpointB, Nat.cast_add, Nat.cast_one, Nat.cast_pow]
  ring

/-- The actual reduced model at five. -/
def balancedCurve5 : WeierstrassCurve (ZMod 5) :=
  freyModel (endpointA : ZMod 5) (endpointB : ZMod 5)

theorem balancedCurve5_eq_directCurve5 : balancedCurve5 = directCurve5 := by
  have ha : (endpointA : ZMod 5) = 1 := by decide
  have hb : (endpointB : ZMod 5) = 2 := by decide
  have h2362 : (2362 : ZMod 5) = 2 := by decide
  rw [balancedCurve5, directCurve5, ha, hb, h2362]

instance balancedCurve5_isElliptic : balancedCurve5.IsElliptic := by
  rw [balancedCurve5_eq_directCurve5]
  infer_instance

/-- The library's actual point type has four points, including infinity. -/
theorem balancedCurve5_point_card : Nat.card balancedCurve5.toAffine.Point = 4 := by
  rw [balancedCurve5_eq_directCurve5]
  exact directCurve5_point_card

theorem balancedCurve_discriminant_mod43_ne_zero :
    (freyModel (endpointA : ZMod 43) (endpointB : ZMod 43)).Δ ≠ 0 := by
  rw [freyModel_discriminant]
  decide

theorem frobenius_polynomial_mod43_no_root :
    ∀ z : ZMod 43, z ^ 2 - 2 * z + 5 ≠ 0 := by decide

/-- The integer in the mathematically computed normalized Tate sum. -/
def normalizedTateBase : ℕ := endpointProduct / 2

theorem normalizedTateBase_pos : 0 < normalizedTateBase := by decide

set_option maxRecDepth 8000 in
/-- Exact integer inequalities underlying the real height interval. -/
theorem height_integer_certificates :
    (3 : ℕ) ^ 1224 < normalizedTateBase ^ 2 ∧
      3 ^ 1648 * normalizedTateBase ^ 2 < 8 ^ 1648 := by
  decide

/-- The interval is about the actual real logarithm of the concrete integer. -/
theorem normalized_tate_height_window :
    1224 < 2 * Real.log (normalizedTateBase : ℝ) ∧
      2 * Real.log (normalizedTateBase : ℝ) < 1648 := by
  have hpos : 0 < (normalizedTateBase : ℝ) := by exact_mod_cast normalizedTateBase_pos
  have hpos2 : 0 < (normalizedTateBase : ℝ) ^ 2 := pow_pos hpos 2
  have hlo : (3 : ℝ) ^ 1224 < (normalizedTateBase : ℝ) ^ 2 := by
    exact_mod_cast height_integer_certificates.1
  have hhi : (normalizedTateBase : ℝ) ^ 2 < ((8 : ℝ) / 3) ^ 1648 := by
    rw [div_pow]
    apply (lt_div_iff₀ (by positivity : (0 : ℝ) < 3 ^ 1648)).mpr
    have hc : (3 : ℝ) ^ 1648 * (normalizedTateBase : ℝ) ^ 2 < 8 ^ 1648 := by
      exact_mod_cast height_integer_certificates.2
    simpa only [mul_comm] using hc
  have h83 : (8 : ℝ) / 3 < Real.exp 1 :=
    lt_trans (by norm_num : (8 : ℝ) / 3 < 2.7182818283) Real.exp_one_gt_d9
  have helow : Real.exp 1224 < (normalizedTateBase : ℝ) ^ 2 := by
    calc
      Real.exp 1224 = Real.exp 1 ^ 1224 := by
        simpa only [Nat.cast_ofNat, mul_one] using Real.exp_nat_mul 1 1224
      _ < (3 : ℝ) ^ 1224 := pow_lt_pow_left₀ Real.exp_one_lt_three
        (Real.exp_pos 1).le (by decide)
      _ < (normalizedTateBase : ℝ) ^ 2 := hlo
  have hehigh : (normalizedTateBase : ℝ) ^ 2 < Real.exp 1648 := by
    calc
      (normalizedTateBase : ℝ) ^ 2 < ((8 : ℝ) / 3) ^ 1648 := hhi
      _ < Real.exp 1 ^ 1648 := pow_lt_pow_left₀ h83 (by positivity) (by decide)
      _ = Real.exp 1648 := by
        simpa only [Nat.cast_ofNat, mul_one] using (Real.exp_nat_mul 1 1648).symm
  have hlo' := (Real.lt_log_iff_exp_lt hpos2).mpr helow
  have hhi' := (Real.log_lt_iff_lt_exp hpos2).mpr hehigh
  simpa only [Real.log_pow, Nat.cast_ofNat] using And.intro hlo' hhi'

end IUTThreeClosures.Frey43BalancedRealization20260830
