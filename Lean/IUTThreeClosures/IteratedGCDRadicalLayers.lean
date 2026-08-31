/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FirstLayerGCDRefinement
import Mathlib.Tactic

/-!
# Iterated gcd radical layers

The factorization-free construction from `FirstLayerGCDRefinement` iterates.
Starting from `(L₁,Q₁)`, put

`L_(j+1) = gcd(L_j,Q_j)` and `Q_(j+1) = Q_j/L_(j+1)`.

This file proves the exact recurrence, positivity, the telescoping logarithmic
identity

`log Q₁ = sum_{j=2}^{K+1} log L_j + log Q_(K+1)`,

and a finite-depth pigeonhole theorem.  Hence every abc violation forces, on
both large endpoints independently, either a quantitatively large support
layer among the first `K` refinements or a quantitatively large remainder
beyond depth `K`.

The construction uses no selected prime factorization and assumes no abc
estimate.
-/

namespace IUTThreeClosures

open scoped BigOperators

noncomputable section

namespace IteratedGCDRadicalLayers

open FirstLayerExcessQuotient FirstLayerGCDRefinement

/-- State `(support layer, remaining quotient)` after `k` refinements.  State
zero is `(L₁,Q₁)`. -/
def gcdLayerState (n : ℕ) : ℕ → ℕ × ℕ
  | 0 => (firstSupportLayer n, firstLayerExcessQuotient n)
  | k + 1 =>
      let previous := gcdLayerState n k
      let nextSupport := Nat.gcd previous.1 previous.2
      (nextSupport, previous.2 / nextSupport)

/-- Support layer at state `k`; this is `L_(k+1)`. -/
def supportLayer (n k : ℕ) : ℕ :=
  (gcdLayerState n k).1

/-- Remaining quotient at state `k`; this is `Q_(k+1)`. -/
def layerRemainder (n k : ℕ) : ℕ :=
  (gcdLayerState n k).2

@[simp] theorem supportLayer_zero (n : ℕ) :
    supportLayer n 0 = firstSupportLayer n := rfl

@[simp] theorem layerRemainder_zero (n : ℕ) :
    layerRemainder n 0 = firstLayerExcessQuotient n := rfl

/-- Exact recurrence at every depth. -/
theorem supportLayer_succ_mul_remainder_succ_eq_remainder
    (n k : ℕ) :
    supportLayer n (k + 1) * layerRemainder n (k + 1) =
      layerRemainder n k := by
  simpa [supportLayer, layerRemainder, gcdLayerState] using
    Nat.mul_div_cancel'
      (Nat.gcd_dvd_right (gcdLayerState n k).1
        (gcdLayerState n k).2)

/-- Each later support layer divides the preceding one. -/
theorem supportLayer_succ_dvd_supportLayer (n k : ℕ) :
    supportLayer n (k + 1) ∣ supportLayer n k := by
  simpa [supportLayer, gcdLayerState] using
    Nat.gcd_dvd_left (gcdLayerState n k).1
      (gcdLayerState n k).2

/-- Both coordinates of every state are positive on positive inputs. -/
theorem gcdLayerState_pos {n : ℕ} (hn : 0 < n) :
    ∀ k : ℕ,
      0 < (gcdLayerState n k).1 ∧
        0 < (gcdLayerState n k).2 := by
  intro k
  induction k with
  | zero =>
      exact ⟨firstSupportLayer_pos hn,
        firstLayerExcessQuotient_pos hn⟩
  | succ k ih =>
      have hs :
          0 < Nat.gcd (gcdLayerState n k).1
            (gcdLayerState n k).2 :=
        Nat.gcd_pos_of_pos_left _ ih.1
      have hq :
          0 < (gcdLayerState n k).2 /
            Nat.gcd (gcdLayerState n k).1
              (gcdLayerState n k).2 := by
        apply Nat.div_pos
        · exact Nat.gcd_le_right _ _
        · exact hs
      simpa [gcdLayerState] using And.intro hs hq

/-- Every support layer is positive. -/
theorem supportLayer_pos {n : ℕ} (hn : 0 < n) (k : ℕ) :
    0 < supportLayer n k :=
  (gcdLayerState_pos hn k).1

/-- Every remainder is positive. -/
theorem layerRemainder_pos {n : ℕ} (hn : 0 < n) (k : ℕ) :
    0 < layerRemainder n k :=
  (gcdLayerState_pos hn k).2

/-- Logarithmic recurrence at one depth. -/
theorem log_remainder_eq_log_succSupport_add_log_succRemainder
    {n : ℕ} (hn : 0 < n) (k : ℕ) :
    Real.log (layerRemainder n k : ℝ) =
      Real.log (supportLayer n (k + 1) : ℝ) +
        Real.log (layerRemainder n (k + 1) : ℝ) := by
  have hs : 0 < (supportLayer n (k + 1) : ℝ) := by
    exact_mod_cast supportLayer_pos hn (k + 1)
  have hq : 0 < (layerRemainder n (k + 1) : ℝ) := by
    exact_mod_cast layerRemainder_pos hn (k + 1)
  have hprod :
      (layerRemainder n k : ℝ) =
        (supportLayer n (k + 1) : ℝ) *
          (layerRemainder n (k + 1) : ℝ) := by
    exact_mod_cast
      (supportLayer_succ_mul_remainder_succ_eq_remainder n k).symm
  rw [hprod, Real.log_mul hs.ne' hq.ne']

/-- Telescoping identity through an arbitrary finite depth. -/
theorem log_initialRemainder_eq_sum_supportLayers_add_log_remainder
    {n : ℕ} (hn : 0 < n) :
    ∀ K : ℕ,
      Real.log (layerRemainder n 0 : ℝ) =
        (∑ i ∈ Finset.range K,
          Real.log (supportLayer n (i + 1) : ℝ)) +
          Real.log (layerRemainder n K : ℝ) := by
  intro K
  induction K with
  | zero => simp
  | succ K ih =>
      have hrec :=
        log_remainder_eq_log_succSupport_add_log_succRemainder
          hn K
      calc
        Real.log (layerRemainder n 0 : ℝ) =
            (∑ i ∈ Finset.range K,
              Real.log (supportLayer n (i + 1) : ℝ)) +
              Real.log (layerRemainder n K : ℝ) := ih
        _ = (∑ i ∈ Finset.range K,
              Real.log (supportLayer n (i + 1) : ℝ)) +
              (Real.log (supportLayer n (K + 1) : ℝ) +
                Real.log (layerRemainder n (K + 1) : ℝ)) := by
              rw [hrec]
        _ = (∑ i ∈ Finset.range (K + 1),
              Real.log (supportLayer n (i + 1) : ℝ)) +
              Real.log (layerRemainder n (K + 1) : ℝ) := by
              rw [Finset.sum_range_succ]
              ring

/-- Scaled telescoping identity. -/
theorem scaled_log_initialRemainder_eq_sum_supportLayers_add_remainder
    {n : ℕ} (hn : 0 < n) (K : ℕ) (scale : ℝ) :
    scale * Real.log (layerRemainder n 0 : ℝ) =
      (∑ i ∈ Finset.range K,
        scale * Real.log (supportLayer n (i + 1) : ℝ)) +
        scale * Real.log (layerRemainder n K : ℝ) := by
  have htel :=
    log_initialRemainder_eq_sum_supportLayers_add_log_remainder
      hn K
  calc
    scale * Real.log (layerRemainder n 0 : ℝ) =
        scale * ((∑ i ∈ Finset.range K,
          Real.log (supportLayer n (i + 1) : ℝ)) +
          Real.log (layerRemainder n K : ℝ)) := by rw [htel]
    _ = scale * (∑ i ∈ Finset.range K,
          Real.log (supportLayer n (i + 1) : ℝ)) +
          scale * Real.log (layerRemainder n K : ℝ) := by ring
    _ = (∑ i ∈ Finset.range K,
          scale * Real.log (supportLayer n (i + 1) : ℝ)) +
          scale * Real.log (layerRemainder n K : ℝ) := by
          rw [Finset.mul_sum]

/-- Finite-depth quantitative layer selection. -/
theorem exists_large_supportLayer_or_large_remainder
    {n : ℕ} (hn : 0 < n) (K : ℕ) {scale T : ℝ}
    (hlower :
      T < scale * Real.log (layerRemainder n 0 : ℝ)) :
    (∃ i ∈ Finset.range K,
        T / ((K : ℝ) + 1) <
          scale * Real.log (supportLayer n (i + 1) : ℝ)) ∨
      T / ((K : ℝ) + 1) <
        scale * Real.log (layerRemainder n K : ℝ) := by
  let threshold : ℝ := T / ((K : ℝ) + 1)
  by_cases hlayer :
      ∃ i ∈ Finset.range K,
        threshold <
          scale * Real.log (supportLayer n (i + 1) : ℝ)
  · simpa [threshold] using Or.inl hlayer
  · by_cases hrem :
        threshold < scale * Real.log (layerRemainder n K : ℝ)
    · simpa [threshold] using Or.inr hrem
    · exfalso
      have hterm :
          ∀ i ∈ Finset.range K,
            scale * Real.log (supportLayer n (i + 1) : ℝ) ≤
              threshold := by
        intro i hi
        exact le_of_not_gt (fun hgt => hlayer ⟨i, hi, hgt⟩)
      have hsum :
          (∑ i ∈ Finset.range K,
            scale * Real.log (supportLayer n (i + 1) : ℝ)) ≤
              (K : ℝ) * threshold := by
        calc
          (∑ i ∈ Finset.range K,
            scale * Real.log (supportLayer n (i + 1) : ℝ)) ≤
              ∑ _i ∈ Finset.range K, threshold :=
                Finset.sum_le_sum hterm
          _ = (K : ℝ) * threshold := by simp
      have hremle :
          scale * Real.log (layerRemainder n K : ℝ) ≤
            threshold := le_of_not_gt hrem
      have htel :=
        scaled_log_initialRemainder_eq_sum_supportLayers_add_remainder
          hn K scale
      have hupper :
          scale * Real.log (layerRemainder n 0 : ℝ) ≤
            (K : ℝ) * threshold + threshold := by
        rw [htel]
        exact add_le_add hsum hremle
      have hden : (0 : ℝ) < (K : ℝ) + 1 := by positivity
      have hid : (K : ℝ) * threshold + threshold = T := by
        dsimp [threshold]
        field_simp [hden.ne']
        ring
      rw [hid] at hupper
      linarith

end IteratedGCDRadicalLayers

open IteratedGCDRadicalLayers

namespace ABCPoint

/-- Arbitrary-depth simultaneous gcd-layer selection for both large endpoints
of every abc violation. -/
theorem both_endpoint_iteratedLayer_dichotomy_of_height_violation
    (P : ABCPoint) (K : ℕ) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    ((∃ i ∈ Finset.range K,
        (epsilon * P.height + C) / ((K : ℝ) + 1) <
          (1 + epsilon) *
            Real.log (supportLayer P.c (i + 1) : ℝ)) ∨
      (epsilon * P.height + C) / ((K : ℝ) + 1) <
        (1 + epsilon) * Real.log (layerRemainder P.c K : ℝ)) ∧
    ((∃ i ∈ Finset.range K,
        (epsilon * P.height + C -
            (1 + epsilon) * Real.log 2) / ((K : ℝ) + 1) <
          (1 + epsilon) *
            Real.log (supportLayer P.largeEndpoint (i + 1) : ℝ)) ∨
      (epsilon * P.height + C -
          (1 + epsilon) * Real.log 2) / ((K : ℝ) + 1) <
        (1 + epsilon) *
          Real.log (layerRemainder P.largeEndpoint K : ℝ)) := by
  have hfirst :=
    P.both_firstLayerExcessQuotient_scaled_of_height_violation
      hepsilon hviolation
  constructor
  · exact exists_large_supportLayer_or_large_remainder
      P.c_pos K hfirst.1
  · exact exists_large_supportLayer_or_large_remainder
      P.largeEndpoint_pos K hfirst.2

#print axioms supportLayer_succ_mul_remainder_succ_eq_remainder
#print axioms supportLayer_succ_dvd_supportLayer
#print axioms gcdLayerState_pos
#print axioms log_remainder_eq_log_succSupport_add_log_succRemainder
#print axioms log_initialRemainder_eq_sum_supportLayers_add_log_remainder
#print axioms exists_large_supportLayer_or_large_remainder
#print axioms ABCPoint.both_endpoint_iteratedLayer_dichotomy_of_height_violation

end ABCPoint
end
end IUTThreeClosures
