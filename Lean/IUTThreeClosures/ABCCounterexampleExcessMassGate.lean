/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCStatement

/-!
# A uniform excess-mass gate for disproving abc

For the primitive adjacent triples `(1,b,b+1)`, this file packages the exact
uniform estimate which would contradict `ABCConjecture`.  It proves only the
implication from that estimate; it does not assert that a Pell sequence, or
any other concrete sequence, satisfies the required excess-mass hypothesis.
-/

namespace IUTThreeClosures

noncomputable section

/-- Logarithmic height of the adjacent triple `(1,b,b+1)`. -/
def adjacentABCHeight (b : ℕ) : ℝ :=
  Real.log ((b + 1 : ℕ) : ℝ)

/-- Logarithmic radical mass of the adjacent triple `(1,b,b+1)`. -/
def adjacentABCRadicalLog (b : ℕ) : ℝ :=
  Real.log ((abcRadical (b * (b + 1)) : ℕ) : ℝ)

/-- Logarithmic mass in the product which is lost when passing to its
radical.  This is the sum of `(v_p-1)*log p` over its prime support, but the
exact difference form is more convenient for the formal criterion. -/
def adjacentABCExcessMass (b : ℕ) : ℝ :=
  Real.log ((b * (b + 1) : ℕ) : ℝ) - adjacentABCRadicalLog b

/-- The product of two adjacent positive integers has logarithm at most twice
the logarithmic height of the corresponding abc triple. -/
theorem adjacentABC_log_product_le_two_height
    (b : ℕ) (hb : 0 < b) :
    Real.log ((b * (b + 1) : ℕ) : ℝ) ≤ 2 * adjacentABCHeight b := by
  have hbR : 0 < (b : ℝ) := by exact_mod_cast hb
  have hbpR : 0 < ((b + 1 : ℕ) : ℝ) := by positivity
  have hleR : (b : ℝ) ≤ ((b + 1 : ℕ) : ℝ) := by
    exact_mod_cast (Nat.le_succ b)
  have hlog : Real.log (b : ℝ) ≤ Real.log ((b + 1 : ℕ) : ℝ) :=
    Real.log_le_log hbR hleR
  rw [adjacentABCHeight, Nat.cast_mul, Real.log_mul hbR.ne' hbpR.ne']
  linarith

/-- The adjacent triple is primitive. -/
theorem one_adjacent_pairwiseCoprimeABC (b : ℕ) :
    PairwiseCoprimeABC 1 b (b + 1) := by
  simp [PairwiseCoprimeABC]

/-- A fixed positive linear excess of repeated-prime mass along an unbounded
adjacent family disproves abc.

The arithmetic work in any concrete counterexample program is precisely the
`hexcess` hypothesis.  The remaining assumptions are elementary positivity
and unboundedness ledgers. -/
theorem not_abcConjecture_of_adjacent_excessMass
    (b : ℕ → ℕ) (δ K : ℝ)
    (hδpos : 0 < δ) (hδlt : δ < 1)
    (hbpos : ∀ n, 0 < b n)
    (hunbounded : ∀ B : ℝ, ∃ n : ℕ, B < adjacentABCHeight (b n))
    (hexcess : ∀ n : ℕ,
      (1 + δ) * adjacentABCHeight (b n) - K ≤
        adjacentABCExcessMass (b n)) :
    ¬ ABCConjecture := by
  intro habc
  let ε : ℝ := δ / (2 * (1 - δ))
  have hden : 0 < 2 * (1 - δ) := by nlinarith
  have hεpos : 0 < ε := div_pos hδpos hden
  have hcoef : (1 + ε) * (1 - δ) = 1 - δ / 2 := by
    dsimp [ε]
    (field_simp [show 1 - δ ≠ 0 by linarith]; ring)
  obtain ⟨C, hC⟩ := habc ε hεpos
  let D : ℝ := (1 + ε) * K + C
  obtain ⟨n, hn⟩ := hunbounded (2 * D / δ)
  have hR : adjacentABCRadicalLog (b n) ≤
      (1 - δ) * adjacentABCHeight (b n) + K := by
    have hsize := adjacentABC_log_product_le_two_height (b n) (hbpos n)
    have hmass := hexcess n
    dsimp [adjacentABCExcessMass] at hmass
    linarith
  have habcN : adjacentABCHeight (b n) ≤
      (1 + ε) * adjacentABCRadicalLog (b n) + C := by
    have h := hC 1 (b n) (b n + 1)
      (by norm_num) (hbpos n) (by omega)
      (by omega) (one_adjacent_pairwiseCoprimeABC (b n))
    have hmax : max 1 (max (b n) (b n + 1)) = b n + 1 := by omega
    simpa [adjacentABCHeight, adjacentABCRadicalLog, hmax] using h
  have honeε : 0 ≤ 1 + ε := by linarith
  have hscaled := mul_le_mul_of_nonneg_left hR honeε
  have hfixed : (δ / 2) * adjacentABCHeight (b n) ≤ D := by
    have hchain : adjacentABCHeight (b n) ≤
        (1 + ε) * ((1 - δ) * adjacentABCHeight (b n)) +
          (1 + ε) * K + C :=
      by nlinarith [habcN, hscaled]
    have hmul :
        (1 + ε) * ((1 - δ) * adjacentABCHeight (b n)) =
          (1 - δ / 2) * adjacentABCHeight (b n) := by
      rw [← mul_assoc, hcoef]
    rw [hmul] at hchain
    dsimp [D]
    linarith
  have hlarge : D < (δ / 2) * adjacentABCHeight (b n) := by
    have hn' : 2 * D < adjacentABCHeight (b n) * δ := by
      rwa [div_lt_iff₀ hδpos] at hn
    nlinarith
  linarith

#print axioms adjacentABC_log_product_le_two_height
#print axioms one_adjacent_pairwiseCoprimeABC
#print axioms not_abcConjecture_of_adjacent_excessMass

end

end IUTThreeClosures
