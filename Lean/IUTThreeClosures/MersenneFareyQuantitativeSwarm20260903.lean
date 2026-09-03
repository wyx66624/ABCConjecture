/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneFareyDenominatorEntropy20260902
import Mathlib.NumberTheory.Harmonic.Bounds
import Mathlib.NumberTheory.Chebyshev

namespace IUTThreeClosures
namespace MersenneFareyQuantitativeSwarm20260903

/-!
# Quantitative Mersenne Farey swarm transfer

The mathematical proofs precede this module in
`research/ABC_MERSENNE_FAREY_QUANTITATIVE_SWARM_2026_09_03.md`.

This file identifies the denominator prefix with the classical harmonic
number, proves an explicit logarithmic prefix budget, turns a linear energy
lower bound into a cleared tail-count lower bound, and carries that theorem
through the exact `Frequently` quantifier forced by failure of little-oh.
It also supplies a full-premise counterexample to any universal strict
improvement of the prefix coefficient.

No distribution theorem for super-Wieferich primes and no abc consequence
is asserted.
-/

open Filter Asymptotics
open scoped BigOperators Topology

open MersenneFareyDenominatorEntropy20260902
open MersenneSigmaOneExactOrderCoupling20260902

/-- Elementary Chebyshev lower control for the logarithm of the common
index used by the saturation model. -/
theorem log_lcmUpto_lower (n : ℕ) :
    (n : ℝ) * Real.log 2 - Real.log ((n : ℝ) + 1) ≤
      Real.log (Nat.lcmUpto n : ℝ) := by
  rw [← Chebyshev.psi_eq_log_lcmUpto]
  simpa [Nat.cast_add, Nat.cast_one] using Chebyshev.psi_ge n

/-- Elementary Chebyshev upper control for the same logarithmic scale. -/
theorem log_lcmUpto_upper (n : ℕ) :
    Real.log (Nat.lcmUpto n : ℝ) ≤
      (Real.log 4 + 4) * (n : ℝ) := by
  rw [← Chebyshev.psi_eq_log_lcmUpto]
  exact Chebyshev.psi_le_const_mul_self (by positivity)

theorem harmonicPrefix_eq_harmonic (T : ℕ) :
    harmonicPrefix T = (harmonic T : ℝ) := by
  unfold harmonicPrefix
  rw [harmonic_eq_sum_Icc]
  simp

theorem harmonicPrefix_le_one_add_log (T : ℕ) :
    harmonicPrefix T ≤ 1 + Real.log (T : ℝ) := by
  rw [harmonicPrefix_eq_harmonic]
  exact harmonic_le_one_add_log T

theorem triangularCapacity_le_square (H : ℕ) :
    triangularCapacity H ≤ (H : ℝ) ^ 2 := by
  rw [triangularCapacity_eq]
  have hnat : H * (H - 1) / 2 ≤ H * H :=
    (Nat.div_le_self (H * (H - 1)) 2).trans
      (Nat.mul_le_mul_left H (Nat.sub_le H 1))
  rw [pow_two]
  exact_mod_cast hnat

theorem triangularCapacity_nonneg (H : ℕ) :
    0 ≤ triangularCapacity H := by
  rw [triangularCapacity_eq]
  positivity

theorem prefixFareyEnergy_le_square_mul_one_add_log
    (rows : ℕ → Finset ℕ) {T H : ℕ} (hT : 1 ≤ T)
    (hsub : ∀ q ∈ Finset.Icc 1 T, rows q ⊆ Finset.Ico 1 H) :
    prefixFareyEnergy rows T ≤
      (H : ℝ) ^ 2 * (1 + Real.log (T : ℝ)) := by
  have hbase := prefixFareyEnergy_le_triangular_mul_harmonic rows T H hsub
  have hlognonneg : 0 ≤ 1 + Real.log (T : ℝ) := by
    have hcast : (1 : ℝ) ≤ (T : ℝ) := by exact_mod_cast hT
    positivity
  calc
    prefixFareyEnergy rows T ≤ triangularCapacity H * harmonicPrefix T := hbase
    _ ≤ triangularCapacity H * (1 + Real.log (T : ℝ)) := by
      exact mul_le_mul_of_nonneg_left (harmonicPrefix_le_one_add_log T)
        (triangularCapacity_nonneg H)
    _ ≤ (H : ℝ) ^ 2 * (1 + Real.log (T : ℝ)) := by
      exact mul_le_mul_of_nonneg_right (triangularCapacity_le_square H) hlognonneg

theorem quantitativeSwarm_cleared
    (rows : ℕ → Finset ℕ) {T Q H : ℕ}
    {total A epsilon kappa : ℝ}
    (hT : 0 < T)
    (hsub : ∀ q ∈ Finset.Icc 1 T, rows q ⊆ Finset.Ico 1 H)
    (hr : ∀ q ∈ Finset.Icc (T + 1) Q, ∀ r ∈ rows q, r ≤ H)
    (htotal : epsilon * A ≤ total)
    (hsplit : total ≤ prefixFareyEnergy rows T + tailFareyEnergy rows T Q)
    (hbudget : (H : ℝ) ^ 2 * (1 + Real.log (T : ℝ)) ≤ kappa * A) :
    (T : ℝ) * ((epsilon - kappa) * A) ≤
      (tailRowCount rows T Q : ℝ) * H := by
  have hprefix : prefixFareyEnergy rows T ≤ kappa * A :=
    (prefixFareyEnergy_le_square_mul_one_add_log rows hT hsub).trans hbudget
  have h := cutoff_mul_energyDefect_le_count_mul_height rows hT hr htotal hsplit hprefix
  calc
    (T : ℝ) * ((epsilon - kappa) * A) =
        (T : ℝ) * (epsilon * A - kappa * A) := by ring
    _ ≤ (tailRowCount rows T Q : ℝ) * H := h

/-- The explicit row-count lower bound obtained by dividing the cleared
swarm inequality by a positive height cutoff. -/
theorem quantitativeSwarm_count_lower
    (rows : ℕ → Finset ℕ) {T Q H : ℕ}
    {total A epsilon kappa : ℝ}
    (hT : 0 < T) (hH : 0 < H)
    (hsub : ∀ q ∈ Finset.Icc 1 T, rows q ⊆ Finset.Ico 1 H)
    (hr : ∀ q ∈ Finset.Icc (T + 1) Q, ∀ r ∈ rows q, r ≤ H)
    (htotal : epsilon * A ≤ total)
    (hsplit : total ≤ prefixFareyEnergy rows T + tailFareyEnergy rows T Q)
    (hbudget : (H : ℝ) ^ 2 * (1 + Real.log (T : ℝ)) ≤ kappa * A) :
    ((T : ℝ) * ((epsilon - kappa) * A)) / H ≤
      (tailRowCount rows T Q : ℝ) := by
  have h := quantitativeSwarm_cleared rows hT hsub hr htotal hsplit hbudget
  apply (div_le_iff₀ (by exact_mod_cast hH)).2
  simpa using h

/-- The finite set of base-two depth-three primes up to `X`.  This is a
literal finite target for the exact-order endpoint rows, with no asymptotic
counting hypothesis. -/
def superWieferichPrimesUpTo (X : ℕ) : Finset ℕ :=
  (Finset.range (X + 1)).filter fun p =>
    p.Prime ∧ p ^ 3 ∣ 2 ^ (p - 1) - 1

theorem mem_superWieferichPrimesUpTo {p X : ℕ} :
    p ∈ superWieferichPrimesUpTo X ↔
      p ≤ X ∧ p.Prime ∧ p ^ 3 ∣ 2 ^ (p - 1) - 1 := by
  simp [superWieferichPrimesUpTo]

/-- An actual exact-order endpoint row with prime coordinate and depth
three lands in the finite super-Wieferich target. -/
theorem endpointPrime_mem_superWieferichPrimesUpTo
    {m X : ℕ} (x : EndpointExactOrderRow m)
    (hp : x.p.Prime) (hdepth : x.p ^ 3 ∣ 2 ^ x.d - 1)
    (hbound : x.p ≤ X) :
    x.p ∈ superWieferichPrimesUpTo X := by
  rw [mem_superWieferichPrimesUpTo]
  exact ⟨hbound, hp,
    endpointRow_depthThree_implies_superWieferich x hdepth⟩

/-- Finite arithmetic packet bridge: distinct exact-order endpoint rows
inject into the actual base-two depth-three prime set. -/
theorem endpointRows_card_le_superWieferichPrimesUpTo
    {m X : ℕ} (s : Finset (EndpointExactOrderRow m))
    (hp : ∀ x ∈ s, x.p.Prime)
    (hdepth : ∀ x ∈ s, x.p ^ 3 ∣ 2 ^ x.d - 1)
    (hbound : ∀ x ∈ s, x.p ≤ X) :
    s.card ≤ (superWieferichPrimesUpTo X).card := by
  classical
  rw [← Finset.card_image_of_injective s endpointPrime_injective]
  apply Finset.card_le_card
  intro p hpImage
  rcases Finset.mem_image.mp hpImage with ⟨x, hxs, rfl⟩
  exact endpointPrime_mem_superWieferichPrimesUpTo x
    (hp x hxs) (hdepth x hxs) (hbound x hxs)

def fullNumeratorRows (H : ℕ) : ℕ → Finset ℕ := fun _ => Finset.Ico 1 H

theorem fullNumeratorRows_prefix_eq (T H : ℕ) :
    prefixFareyEnergy (fullNumeratorRows H) T =
      triangularCapacity H * harmonicPrefix T := by
  unfold prefixFareyEnergy
  simp_rw [fibreSlopeMass_eq_numeratorMass_div]
  have hmass : ∀ q, numeratorMass (fullNumeratorRows H) q = triangularCapacity H := by
    intro q
    rfl
  simp_rw [hmass]
  unfold harmonicPrefix
  simp_rw [div_eq_mul_inv]
  rw [Finset.mul_sum]
  simp

def UniformStrictPrefixImprovement : Prop :=
  ∃ c : ℝ, c < 1 ∧
    ∀ (rows : ℕ → Finset ℕ) (T H : ℕ),
      (∀ q ∈ Finset.Icc 1 T, rows q ⊆ Finset.Ico 1 H) →
      prefixFareyEnergy rows T ≤
        c * (triangularCapacity H * harmonicPrefix T)

theorem not_uniformStrictPrefixImprovement :
    ¬ UniformStrictPrefixImprovement := by
  rintro ⟨c, hc, hall⟩
  have hsub : ∀ q ∈ Finset.Icc 1 1,
      fullNumeratorRows 2 q ⊆ Finset.Ico 1 2 := by
    intro q hq
    exact Finset.Subset.rfl
  have h := hall (fullNumeratorRows 2) 1 2 hsub
  norm_num [fullNumeratorRows, prefixFareyEnergy, fibreSlopeMass,
    triangularCapacity, harmonicPrefix] at h
  linarith

theorem not_isLittleO_iff_exists_frequently_gt
    (f g : ℕ → ℝ) (hf : ∀ n, 0 ≤ f n) (hg : ∀ n, 0 ≤ g n) :
    (¬ f =o[atTop] g) ↔
      ∃ epsilon : ℝ, 0 < epsilon ∧
        ∃ᶠ n in atTop, epsilon * g n < f n := by
  constructor
  · intro hnot
    rw [isLittleO_iff] at hnot
    push Not at hnot
    rcases hnot with ⟨epsilon, hepsilon, hfail⟩
    refine ⟨epsilon, hepsilon, ?_⟩
    simpa [Real.norm_eq_abs, abs_of_nonneg (hf _), abs_of_nonneg (hg _),
      not_le] using hfail
  · rintro ⟨epsilon, hepsilon, hfrequent⟩ hlittle
    have heventual := hlittle.bound hepsilon
    have heventual' : ∀ᶠ n in atTop, f n ≤ epsilon * g n := by
      simpa [Real.norm_eq_abs, abs_of_nonneg (hf _), abs_of_nonneg (hg _)]
        using heventual
    apply hfrequent
    filter_upwards [heventual'] with n hn
    exact not_lt_of_ge hn

theorem frequent_quantitativeSwarm_cleared
    (rows : ℕ → ℕ → Finset ℕ) (T Q H : ℕ → ℕ)
    (total A : ℕ → ℝ) (epsilon kappa : ℝ)
    (hlinear : ∃ᶠ m in atTop, epsilon * A m < total m)
    (hT : ∀ᶠ m in atTop, 0 < T m)
    (hsub : ∀ᶠ m in atTop,
      ∀ q ∈ Finset.Icc 1 (T m), rows m q ⊆ Finset.Ico 1 (H m))
    (hr : ∀ᶠ m in atTop,
      ∀ q ∈ Finset.Icc (T m + 1) (Q m), ∀ r ∈ rows m q, r ≤ H m)
    (hsplit : ∀ᶠ m in atTop,
      total m ≤ prefixFareyEnergy (rows m) (T m) +
        tailFareyEnergy (rows m) (T m) (Q m))
    (hbudget : ∀ᶠ m in atTop,
      (H m : ℝ) ^ 2 * (1 + Real.log (T m : ℝ)) ≤ kappa * A m) :
    ∃ᶠ m in atTop,
      (T m : ℝ) * ((epsilon - kappa) * A m) ≤
        (tailRowCount (rows m) (T m) (Q m) : ℝ) * H m := by
  have hstruct : ∀ᶠ m in atTop,
      0 < T m ∧
      (∀ q ∈ Finset.Icc 1 (T m), rows m q ⊆ Finset.Ico 1 (H m)) ∧
      (∀ q ∈ Finset.Icc (T m + 1) (Q m), ∀ r ∈ rows m q, r ≤ H m) ∧
      total m ≤ prefixFareyEnergy (rows m) (T m) +
        tailFareyEnergy (rows m) (T m) (Q m) ∧
      (H m : ℝ) ^ 2 * (1 + Real.log (T m : ℝ)) ≤ kappa * A m := by
    filter_upwards [hT, hsub, hr, hsplit, hbudget] with m hTm hsubm hrm hsplitm hbudgetm
    exact ⟨hTm, hsubm, hrm, hsplitm, hbudgetm⟩
  exact (hlinear.and_eventually hstruct).mono fun m hm =>
    quantitativeSwarm_cleared (rows m) hm.2.1 hm.2.2.1 hm.2.2.2.1
      (le_of_lt hm.1) hm.2.2.2.2.1 hm.2.2.2.2.2

theorem notLittleO_forces_frequentSwarm_of_negligiblePrefix
    (rows : ℕ → ℕ → Finset ℕ) (T Q H : ℕ → ℕ)
    (total A : ℕ → ℝ)
    (htotalNonneg : ∀ m, 0 ≤ total m) (hANonneg : ∀ m, 0 ≤ A m)
    (hnot : ¬ total =o[atTop] A)
    (hT : ∀ᶠ m in atTop, 0 < T m)
    (hsub : ∀ᶠ m in atTop,
      ∀ q ∈ Finset.Icc 1 (T m), rows m q ⊆ Finset.Ico 1 (H m))
    (hr : ∀ᶠ m in atTop,
      ∀ q ∈ Finset.Icc (T m + 1) (Q m), ∀ r ∈ rows m q, r ≤ H m)
    (hsplit : ∀ᶠ m in atTop,
      total m ≤ prefixFareyEnergy (rows m) (T m) +
        tailFareyEnergy (rows m) (T m) (Q m))
    (hprefixLittleO : ∀ epsilon : ℝ, 0 < epsilon →
      ∀ᶠ m in atTop,
        (H m : ℝ) ^ 2 * (1 + Real.log (T m : ℝ)) ≤
          (epsilon / 2) * A m) :
    ∃ epsilon : ℝ, 0 < epsilon ∧
      ∃ᶠ m in atTop,
        (T m : ℝ) * ((epsilon / 2) * A m) ≤
          (tailRowCount (rows m) (T m) (Q m) : ℝ) * H m := by
  rcases (not_isLittleO_iff_exists_frequently_gt total A
    htotalNonneg hANonneg).1 hnot with ⟨epsilon, hepsilon, hlinear⟩
  refine ⟨epsilon, hepsilon, ?_⟩
  have hfrequent := frequent_quantitativeSwarm_cleared rows T Q H total A
    epsilon (epsilon / 2) hlinear hT hsub hr hsplit
      (hprefixLittleO epsilon hepsilon)
  exact hfrequent.mono fun m hm => by
    convert hm using 1
    ring

#print axioms harmonicPrefix_eq_harmonic
#print axioms log_lcmUpto_lower
#print axioms log_lcmUpto_upper
#print axioms harmonicPrefix_le_one_add_log
#print axioms triangularCapacity_le_square
#print axioms triangularCapacity_nonneg
#print axioms prefixFareyEnergy_le_square_mul_one_add_log
#print axioms quantitativeSwarm_cleared
#print axioms quantitativeSwarm_count_lower
#print axioms mem_superWieferichPrimesUpTo
#print axioms endpointPrime_mem_superWieferichPrimesUpTo
#print axioms endpointRows_card_le_superWieferichPrimesUpTo
#print axioms fullNumeratorRows_prefix_eq
#print axioms not_uniformStrictPrefixImprovement
#print axioms not_isLittleO_iff_exists_frequently_gt
#print axioms frequent_quantitativeSwarm_cleared
#print axioms notLittleO_forces_frequentSwarm_of_negligiblePrefix

end MersenneFareyQuantitativeSwarm20260903
end IUTThreeClosures
