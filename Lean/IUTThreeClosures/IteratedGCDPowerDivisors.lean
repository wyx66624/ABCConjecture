/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IteratedGCDRadicalLayers
import Mathlib.Tactic

/-!
# Actual power divisors from iterated gcd layers

The support layer at state `k` occurs in every one of the first `k+1` support
factors.  Consequently

`supportLayer(n,k)^(k+1) | n`.

This file proves that divisibility without selecting prime factors, and
upgrades the finite-depth logarithmic selector to an actual perfect-power
divisor/remainder dichotomy on both large abc endpoints.
-/

namespace IUTThreeClosures

noncomputable section

namespace IteratedGCDPowerDivisors

open FirstLayerGCDRefinement IteratedGCDRadicalLayers

/-- Product of all support layers through state `k`. -/
def supportPrefixProduct (n : ℕ) : ℕ → ℕ
  | 0 => supportLayer n 0
  | k + 1 => supportPrefixProduct n k * supportLayer n (k + 1)

/-- Prefix product times the current remainder is the original integer. -/
theorem supportPrefixProduct_mul_remainder_eq (n : ℕ) :
    ∀ k : ℕ,
      supportPrefixProduct n k * layerRemainder n k = n := by
  intro k
  induction k with
  | zero =>
      simpa [supportPrefixProduct] using
        firstSupport_mul_firstExcess_eq n
  | succ k ih =>
      rw [supportPrefixProduct, mul_assoc,
        supportLayer_succ_mul_remainder_succ_eq_remainder,
        ih]

/-- The current support layer to the number of accumulated support layers
divides the support prefix product. -/
theorem supportLayer_pow_succ_dvd_prefix (n : ℕ) :
    ∀ k : ℕ,
      supportLayer n k ^ (k + 1) ∣ supportPrefixProduct n k := by
  intro k
  induction k with
  | zero =>
      simp [supportPrefixProduct]
  | succ k ih =>
      have hstep :
          supportLayer n (k + 1) ∣ supportLayer n k :=
        supportLayer_succ_dvd_supportLayer n k
      obtain ⟨u, hu⟩ := hstep
      have hpow :
          supportLayer n (k + 1) ^ (k + 1) ∣
            supportLayer n k ^ (k + 1) := by
        refine ⟨u ^ (k + 1), ?_⟩
        rw [hu]
        ring
      have hprefix :
          supportLayer n (k + 1) ^ (k + 1) ∣
            supportPrefixProduct n k :=
        hpow.trans ih
      have hmul :=
        Nat.mul_dvd_mul hprefix
          (dvd_refl (supportLayer n (k + 1)))
      simpa [supportPrefixProduct, pow_succ, Nat.add_assoc,
        Nat.add_comm, Nat.add_left_comm, mul_assoc] using hmul

/-- Every gcd support layer gives an actual perfect-power divisor. -/
theorem supportLayer_pow_succ_dvd (n k : ℕ) :
    supportLayer n k ^ (k + 1) ∣ n := by
  have hprefix := supportLayer_pow_succ_dvd_prefix n k
  have hprefix_dvd : supportPrefixProduct n k ∣ n :=
    ⟨layerRemainder n k,
      supportPrefixProduct_mul_remainder_eq n k⟩
  exact hprefix.trans hprefix_dvd

/-- Finite-depth selection upgraded with the associated perfect-power
divisibility certificate. -/
theorem exists_large_powerLayer_or_large_remainder
    {n : ℕ} (hn : 0 < n) (K : ℕ) {scale T : ℝ}
    (hlower :
      T < scale * Real.log (layerRemainder n 0 : ℝ)) :
    (∃ i ∈ Finset.range K,
        T / ((K : ℝ) + 1) <
            scale * Real.log (supportLayer n (i + 1) : ℝ) ∧
          supportLayer n (i + 1) ^ (i + 2) ∣ n) ∨
      T / ((K : ℝ) + 1) <
        scale * Real.log (layerRemainder n K : ℝ) := by
  rcases exists_large_supportLayer_or_large_remainder
      hn K hlower with hlayer | hrem
  · left
    obtain ⟨i, hi, hlarge⟩ := hlayer
    refine ⟨i, hi, hlarge, ?_⟩
    simpa [Nat.add_assoc] using supportLayer_pow_succ_dvd n (i + 1)
  · exact Or.inr hrem

end IteratedGCDPowerDivisors

open IteratedGCDPowerDivisors IteratedGCDRadicalLayers

namespace ABCPoint

/-- Every abc violation gives, independently on both large endpoints, either
an explicit large perfect-power divisor at some selected depth or a large
multiplicity remainder beyond that depth. -/
theorem both_endpoint_iteratedPower_dichotomy_of_height_violation
    (P : ABCPoint) (K : ℕ) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    ((∃ i ∈ Finset.range K,
        (epsilon * P.height + C) / ((K : ℝ) + 1) <
            (1 + epsilon) *
              Real.log (supportLayer P.c (i + 1) : ℝ) ∧
          supportLayer P.c (i + 1) ^ (i + 2) ∣ P.c) ∨
      (epsilon * P.height + C) / ((K : ℝ) + 1) <
        (1 + epsilon) * Real.log (layerRemainder P.c K : ℝ)) ∧
    ((∃ i ∈ Finset.range K,
        (epsilon * P.height + C -
            (1 + epsilon) * Real.log 2) / ((K : ℝ) + 1) <
            (1 + epsilon) *
              Real.log
                (supportLayer P.largeEndpoint (i + 1) : ℝ) ∧
          supportLayer P.largeEndpoint (i + 1) ^ (i + 2) ∣
            P.largeEndpoint) ∨
      (epsilon * P.height + C -
          (1 + epsilon) * Real.log 2) / ((K : ℝ) + 1) <
        (1 + epsilon) *
          Real.log (layerRemainder P.largeEndpoint K : ℝ)) := by
  have hfirst :=
    P.both_firstLayerExcessQuotient_scaled_of_height_violation
      hepsilon hviolation
  constructor
  · exact exists_large_powerLayer_or_large_remainder
      P.c_pos K hfirst.1
  · exact exists_large_powerLayer_or_large_remainder
      P.largeEndpoint_pos K hfirst.2

#print axioms supportPrefixProduct_mul_remainder_eq
#print axioms supportLayer_pow_succ_dvd_prefix
#print axioms supportLayer_pow_succ_dvd
#print axioms exists_large_powerLayer_or_large_remainder
#print axioms ABCPoint.both_endpoint_iteratedPower_dichotomy_of_height_violation

end ABCPoint
end
end IUTThreeClosures
