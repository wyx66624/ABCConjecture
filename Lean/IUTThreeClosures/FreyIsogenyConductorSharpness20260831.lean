/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyIsogenyWeilHeight20260831
import Mathlib.Algebra.Ring.GeomSum
import Mathlib.RingTheory.Radical.NatInt

/-!
# Radical support and a coefficient-below-six obstruction for four Frey models

The complete mathematical proof precedes this module in
`research/FREY_ENTIRE_ISOGENY_CONDUCTOR_SHARPNESS_2026_08_31.md`.

This file uses the actual four Weierstrass curves, their actual rational
`j`-invariants and Mathlib's actual Weil-height and radical APIs. The integer
`conductorProxy` is proved in the paper to be the Neron conductor, but that
interpretation is deliberately not asserted here: Mathlib currently has no
elliptic Neron-conductor, Tate-algorithm, Kodaira-symbol or rational-isogeny
classification API.
-/

namespace IUTThreeClosures.FreyIsogenyConductorSharpness20260831

open UniqueFactorizationMonoid
open FreyEntireIsogenyArithmetic20260831
open FreyIsogenyWeilHeight20260831

noncomputable section

/-- The natural-number half endpoint `896n+1`. -/
def halfEndpointNat (n : ℕ) : ℕ := 896 * n + 1

/-- The odd endpoint `c-1=1792n+1`. -/
def oddEndpoint (n : ℕ) : ℕ := 1792 * n + 1

/-- The positive reduced denominator of the actual zero-kernel `j` value. -/
def minimumJDenominator (n : ℕ) : ℕ :=
  oddEndpoint n * halfEndpointNat n ^ 4

/-- The exact elementary radical integer proved on paper to be the conductor. -/
def conductorProxy (n : ℕ) : ℕ :=
  16 * radical (endpointC n * oddEndpoint n)

theorem endpointC_eq_two_halfEndpointNat (n : ℕ) :
    endpointC n = 2 * halfEndpointNat n := by
  simp [endpointC, halfEndpointNat]
  omega

theorem oddEndpoint_eq_two_half_sub_one (n : ℕ) :
    oddEndpoint n = 2 * halfEndpointNat n - 1 := by
  simp [oddEndpoint, halfEndpointNat]
  omega

theorem endpointC_sub_one_eq_oddEndpoint (n : ℕ) :
    endpointC n - 1 = oddEndpoint n := by
  simp [endpointC, oddEndpoint]

theorem halfEndpointNat_pos (n : ℕ) : 0 < halfEndpointNat n := by
  simp [halfEndpointNat]

theorem oddEndpoint_pos (n : ℕ) : 0 < oddEndpoint n := by
  simp [oddEndpoint]

theorem two_coprime_halfEndpointNat (n : ℕ) :
    Nat.Coprime 2 (halfEndpointNat n) := by
  simpa [halfEndpointNat, Nat.mul_comm, Nat.mul_left_comm] using
    (Nat.coprime_mul_left_add_right 2 1 (448 * n))

theorem two_half_coprime_oddEndpoint (n : ℕ) :
    Nat.Coprime (2 * halfEndpointNat n) (oddEndpoint n) := by
  rw [oddEndpoint_eq_two_half_sub_one]
  simpa using
    (Nat.coprime_self_sub_right (show 1 ≤ 2 * halfEndpointNat n by
      have := halfEndpointNat_pos n
      omega) : Nat.Coprime (2 * halfEndpointNat n)
        (2 * halfEndpointNat n - 1) ↔ _).2 (by simp)

theorem half_coprime_oddEndpoint (n : ℕ) :
    Nat.Coprime (halfEndpointNat n) (oddEndpoint n) := by
  exact (two_half_coprime_oddEndpoint n).of_dvd_left ⟨2, by omega⟩

theorem oddEndpoint_coprime_half (n : ℕ) :
    Nat.Coprime (oddEndpoint n) (halfEndpointNat n) :=
  (half_coprime_oddEndpoint n).symm

theorem radical_two : radical (2 : ℕ) = 2 := by
  rw [radical_of_prime Nat.prime_two.prime]
  rfl

theorem minimumJDenominator_radical (n : ℕ) :
    radical (minimumJDenominator n) =
      radical (oddEndpoint n) * radical (halfEndpointNat n) := by
  rw [minimumJDenominator,
    radical_mul (Nat.coprime_iff_isRelPrime.mp
      ((oddEndpoint_coprime_half n).pow_right 4)),
    radical_pow (halfEndpointNat n) (by norm_num : (4 : ℕ) ≠ 0)]

/-- The endpoint radical is exactly twice the radical of the actual reduced
denominator of the height-minimizing model. -/
theorem endpoint_radical_eq_two_minimum_denominator_radical (n : ℕ) :
    radical (endpointC n * oddEndpoint n) =
      2 * radical (minimumJDenominator n) := by
  rw [endpointC_eq_two_halfEndpointNat,
    radical_mul (Nat.coprime_iff_isRelPrime.mp
      (two_half_coprime_oddEndpoint n)),
    radical_mul (Nat.coprime_iff_isRelPrime.mp
      (two_coprime_halfEndpointNat n)),
    radical_two, minimumJDenominator_radical]
  ac_rfl

theorem reducedDenominator_zeroKernel_eq_minimumJDenominator (n : ℕ) :
    reducedDenominator n .zeroKernel = (minimumJDenominator n : ℤ) := by
  simp only [reducedDenominator, minimumJDenominator, oddEndpoint,
    halfEndpointNat, halfEndpoint, endpointC]
  push_cast
  ring

/-- The natural denominator stored by the actual rational `j` invariant is
the elementary denominator used above. -/
theorem familyCurve_zeroKernel_den (n : ℕ) :
    (familyCurve n .zeroKernel).j.den = minimumJDenominator n := by
  have h := familyCurve_j_den n .zeroKernel
  rw [reducedDenominator_zeroKernel_eq_minimumJDenominator] at h
  exact_mod_cast h

/-- Radical support identity for the actual reduced rational denominator. -/
theorem endpoint_radical_eq_two_actual_j_den_radical (n : ℕ) :
    radical (endpointC n * oddEndpoint n) =
      2 * radical (familyCurve n .zeroKernel).j.den := by
  rw [familyCurve_zeroKernel_den]
  exact endpoint_radical_eq_two_minimum_denominator_radical n

/-- The geometric-series index for the explicit power subfamily. -/
def powerIndex (k : ℕ) : ℕ := ∑ i ∈ Finset.range k, 897 ^ i

theorem powerIndex_mul_896 (k : ℕ) :
    powerIndex k * 896 = 897 ^ k - 1 := by
  simpa [powerIndex] using
    (geom_sum_mul_of_one_le (by norm_num : 1 ≤ (897 : ℕ)) k)

theorem endpointC_powerIndex (k : ℕ) :
    endpointC (powerIndex k) = 2 * 897 ^ k := by
  have h := powerIndex_mul_896 k
  have hpow : 0 < 897 ^ k := pow_pos (by norm_num) k
  simp only [endpointC]
  omega

theorem powerIndex_pos {k : ℕ} (hk : 1 ≤ k) : 0 < powerIndex k := by
  have hmem : 0 ∈ Finset.range k := Finset.mem_range.mpr hk
  have hle : 897 ^ 0 ≤ ∑ i ∈ Finset.range k, 897 ^ i :=
    Finset.single_le_sum (fun i _ => Nat.zero_le (897 ^ i)) hmem
  have : 0 < ∑ i ∈ Finset.range k, 897 ^ i :=
    lt_of_lt_of_le (by norm_num : 0 < 897 ^ 0) hle
  simpa [powerIndex] using this

theorem radical_897 : radical (897 : ℕ) = 897 := by
  have h3 : Prime (3 : ℕ) := (by norm_num : Nat.Prime 3).prime
  have h13 : Prime (13 : ℕ) := (by norm_num : Nat.Prime 13).prime
  have h23 : Prime (23 : ℕ) := (by norm_num : Nat.Prime 23).prime
  rw [show (897 : ℕ) = 3 * (13 * 23) by norm_num,
    radical_mul (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    radical_mul (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    radical_of_prime h3, radical_of_prime h13, radical_of_prime h23]
  norm_num

theorem radical_897_pow {k : ℕ} (hk : k ≠ 0) :
    radical (897 ^ k) = 897 := by
  rw [radical_pow 897 hk, radical_897]

theorem powerEndpoint_coprime_odd (k : ℕ) :
    Nat.Coprime (2 * 897 ^ k) (2 * 897 ^ k - 1) := by
  simpa using
    (Nat.coprime_self_sub_right (show 1 ≤ 2 * 897 ^ k by
      have hpow : 0 < 897 ^ k := pow_pos (by norm_num) k
      omega) :
      Nat.Coprime (2 * 897 ^ k) (2 * 897 ^ k - 1) ↔ _).2 (by simp)

theorem two_coprime_897_pow (k : ℕ) :
    Nat.Coprime 2 (897 ^ k) := by
  exact (by norm_num : Nat.Coprime 2 897).pow_right k

/-- Exact radical factorization on the power subfamily. -/
theorem powerEndpoint_radical {k : ℕ} (hk : k ≠ 0) :
    radical (endpointC (powerIndex k) * oddEndpoint (powerIndex k)) =
      1794 * radical (endpointC (powerIndex k) - 1) := by
  rw [← endpointC_sub_one_eq_oddEndpoint, endpointC_powerIndex]
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp
      (powerEndpoint_coprime_odd k)),
    radical_mul (Nat.coprime_iff_isRelPrime.mp
      (two_coprime_897_pow k)),
    radical_two, radical_897_pow hk]
  norm_num

/-- The exact elementary conductor proxy on the power subfamily. -/
theorem power_conductorProxy {k : ℕ} (hk : k ≠ 0) :
    conductorProxy (powerIndex k) =
      28704 * radical (endpointC (powerIndex k) - 1) := by
  unfold conductorProxy
  rw [powerEndpoint_radical hk]
  ring

/-- The conductor proxy is at most a fixed constant times the endpoint. -/
theorem power_conductorProxy_lt {k : ℕ} (hk : k ≠ 0) :
    conductorProxy (powerIndex k) < 28704 * endpointC (powerIndex k) := by
  rw [power_conductorProxy hk]
  have hpos : 0 < endpointC (powerIndex k) - 1 := by
    have := endpointC_ge_two (powerIndex k)
    omega
  have hrad : radical (endpointC (powerIndex k) - 1) ≤
      endpointC (powerIndex k) - 1 :=
    (Nat.radical_le_self_iff).2 hpos.ne'
  have hsub : endpointC (powerIndex k) - 1 < endpointC (powerIndex k) := by
    exact Nat.sub_lt (lt_of_lt_of_le (by norm_num) (endpointC_ge_two _)) (by norm_num)
  exact Nat.mul_lt_mul_of_pos_left (hrad.trans_lt hsub) (by norm_num)

theorem powerEndpoint_log (k : ℕ) :
    Real.log (endpointC (powerIndex k) : ℝ) =
      Real.log 2 + (k : ℝ) * Real.log 897 := by
  rw [endpointC_powerIndex]
  push_cast
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0)
      (pow_ne_zero k (by norm_num : (897 : ℝ) ≠ 0)), Real.log_pow]

/-- Quantitative lower gap for every one of the four actual models. The
`conductorProxy` interpretation as an elliptic conductor remains the preceding
paper theorem, not a Lean declaration. -/
theorem powerFamily_subcritical_gap
    {k : ℕ} (hk : 1 ≤ k) {θ : ℝ} (hθ0 : 0 ≤ θ)
    (i : ModelLabel) :
    (6 - θ) * Real.log (endpointC (powerIndex k) : ℝ) -
        3 * Real.log 2 - θ * Real.log 28704 <
      Height.logHeight₁ (familyCurve (powerIndex k) i).j -
        θ * Real.log (conductorProxy (powerIndex k) : ℝ) := by
  have hn : 1 ≤ powerIndex k := powerIndex_pos hk
  have hzero := (zeroKernel_logHeight_bounds (powerIndex k) hn).1
  have hmodel :
      Height.logHeight₁ (familyCurve (powerIndex k) .zeroKernel).j ≤
        Height.logHeight₁ (familyCurve (powerIndex k) i).j := by
    by_cases hi : i = .zeroKernel
    · subst i
      rfl
    · exact (zeroKernel_logHeight_lt (powerIndex k) hn i hi).le
  have hcpos : 0 < (endpointC (powerIndex k) : ℝ) := by
    exact_mod_cast (lt_of_lt_of_le (by norm_num : 0 < (2 : ℕ))
      (endpointC_ge_two (powerIndex k)))
  have hproxyNat := power_conductorProxy_lt (Nat.ne_of_gt hk)
  have hproxyPosNat : 0 < conductorProxy (powerIndex k) := by
    unfold conductorProxy
    exact Nat.mul_pos (by norm_num) (Nat.radical_pos _)
  have hproxyPos : 0 < (conductorProxy (powerIndex k) : ℝ) := by
    exact_mod_cast hproxyPosNat
  have hproxyReal :
      (conductorProxy (powerIndex k) : ℝ) <
        28704 * endpointC (powerIndex k) := by exact_mod_cast hproxyNat
  have hlog := Real.log_lt_log hproxyPos hproxyReal
  rw [Real.log_mul (by norm_num : (28704 : ℝ) ≠ 0) hcpos.ne'] at hlog
  have hmul := mul_le_mul_of_nonneg_left hlog.le hθ0
  nlinarith

/-- For every coefficient below six and every constant, the gap is eventually
larger than that constant simultaneously for all four actual models. -/
theorem exists_powerFamily_gap_gt
    {θ C : ℝ} (hθ0 : 0 ≤ θ) (hθ6 : θ < 6) :
    ∃ k : ℕ, 1 ≤ k ∧ ∀ i : ModelLabel,
      C < Height.logHeight₁ (familyCurve (powerIndex k) i).j -
        θ * Real.log (conductorProxy (powerIndex k) : ℝ) := by
  have hL : 0 < (6 - θ) * Real.log 897 :=
    mul_pos (sub_pos.mpr hθ6) (Real.log_pos (by norm_num))
  let K : ℝ := (6 - θ) * Real.log 2 - 3 * Real.log 2 - θ * Real.log 28704
  obtain ⟨m : ℕ, hm⟩ := exists_nat_gt ((C - K) / ((6 - θ) * Real.log 897))
  refine ⟨m + 1, by omega, ?_⟩
  intro i
  have hmk : (C - K) / ((6 - θ) * Real.log 897) < (m + 1 : ℝ) := by
    exact hm.trans (by exact_mod_cast Nat.lt_succ_self m)
  have hscaled := (div_lt_iff₀ hL).mp hmk
  have hgap := powerFamily_subcritical_gap (k := m + 1) (by omega)
    hθ0 i
  rw [powerEndpoint_log] at hgap
  have halg :
      (6 - θ) * (Real.log 2 + ((m + 1 : ℕ) : ℝ) * Real.log 897) -
          3 * Real.log 2 - θ * Real.log 28704 =
        ((m + 1 : ℕ) : ℝ) * ((6 - θ) * Real.log 897) + K := by
    dsimp [K]
    ring
  rw [halg] at hgap
  have hCK :
      C < ((m + 1 : ℕ) : ℝ) * ((6 - θ) * Real.log 897) + K := by
    have := add_lt_add_right hscaled K
    calc
      C = K + (C - K) := by ring
      _ < K + ((m + 1 : ℕ) : ℝ) * ((6 - θ) * Real.log 897) := by
        simpa [Nat.cast_add, Nat.cast_one] using this
      _ = ((m + 1 : ℕ) : ℝ) * ((6 - θ) * Real.log 897) + K := by ring
  exact hCK.trans hgap

#print axioms endpoint_radical_eq_two_actual_j_den_radical
#print axioms endpointC_powerIndex
#print axioms powerEndpoint_radical
#print axioms power_conductorProxy_lt
#print axioms powerFamily_subcritical_gap
#print axioms exists_powerFamily_gap_gt

end

end IUTThreeClosures.FreyIsogenyConductorSharpness20260831
