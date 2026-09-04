/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.DyadicPlusCompanionExcess
import Mathlib.Tactic

/-!
# Height normalization of the dyadic companion excess

For `N=2^k+1`, the repeated-prime excess

`E(N)=log N-log(rad N)`

is nonnegative. A uniform `o(log rad N)` bound is equivalent to a uniform
`o(log N)` bound. This permits the index-lifting contribution, which is only
logarithmic in `k`, to be compared with the natural height scale `k log 2`.
-/

namespace IUTThreeClosures
namespace DyadicPlusHeightNormalization

open DyadicPlusCompanionExcess
open UniqueFactorizationMonoid

noncomputable section

/-- Repeated-prime excess is nonnegative on positive integers. -/
theorem repeatedPrimeExcess_nonneg {n : ℕ} (hn : 0 < n) :
    0 ≤ repeatedPrimeExcess n := by
  have hradpos : 0 < (abcRadical n : ℝ) := by
    exact_mod_cast abcRadical_pos n
  have hdiv : abcRadical n ∣ n := by
    rw [abcRadical_eq_natRadical]
    exact radical_dvd n
  have hleNat : abcRadical n ≤ n := Nat.le_of_dvd hn hdiv
  have hleR : (abcRadical n : ℝ) ≤ (n : ℝ) := by
    exact_mod_cast hleNat
  have hlog := Real.log_le_log hradpos hleR
  unfold repeatedPrimeExcess
  linarith

/-- Uniform sublinear repeated-prime mass measured against the full companion
height. -/
def UniformDyadicPlusHeightNormalizedExcessBound : Prop :=
  ∀ delta : ℝ, 0 < delta →
    ∃ K : ℝ, ∀ k : ℕ, 0 < k →
      repeatedPrimeExcess (2 ^ k + 1) ≤
        delta * Real.log ((2 ^ k + 1 : ℕ) : ℝ) + K

/-- Radical-normalized sublinearity implies full-height sublinearity. -/
theorem heightNormalized_of_radicalNormalized
    (hbound : UniformDyadicPlusRepeatedExcessBound) :
    UniformDyadicPlusHeightNormalizedExcessBound := by
  intro delta hdelta
  obtain ⟨K, hK⟩ := hbound delta hdelta
  refine ⟨K, ?_⟩
  intro k hk
  have hE := hK k hk
  have hNpos : 0 < 2 ^ k + 1 := by positivity
  have hradpos : 0 < (abcRadical (2 ^ k + 1) : ℝ) := by
    exact_mod_cast abcRadical_pos (2 ^ k + 1)
  have hdiv : abcRadical (2 ^ k + 1) ∣ 2 ^ k + 1 := by
    rw [abcRadical_eq_natRadical]
    exact radical_dvd (2 ^ k + 1)
  have hleNat : abcRadical (2 ^ k + 1) ≤ 2 ^ k + 1 :=
    Nat.le_of_dvd hNpos hdiv
  have hleR :
      (abcRadical (2 ^ k + 1) : ℝ) ≤
        ((2 ^ k + 1 : ℕ) : ℝ) := by
    exact_mod_cast hleNat
  have hlog := Real.log_le_log hradpos hleR
  have hscaled := mul_le_mul_of_nonneg_left hlog hdelta.le
  linarith

/-- Full-height sublinearity implies the exact radical-normalized condition
required by dyadic abc. -/
theorem radicalNormalized_of_heightNormalized
    (hbound : UniformDyadicPlusHeightNormalizedExcessBound) :
    UniformDyadicPlusRepeatedExcessBound := by
  intro epsilon hepsilon
  let delta : ℝ := epsilon / (1 + epsilon)
  have hone : 0 < 1 + epsilon := by linarith
  have hdelta : 0 < delta := div_pos hepsilon hone
  obtain ⟨K, hK⟩ := hbound delta hdelta
  refine ⟨(1 + epsilon) * K, ?_⟩
  intro k hk
  have hE := hK k hk
  have hdecomp :
      Real.log ((2 ^ k + 1 : ℕ) : ℝ) =
        repeatedPrimeExcess (2 ^ k + 1) +
          Real.log (abcRadical (2 ^ k + 1) : ℝ) := by
    unfold repeatedPrimeExcess
    ring
  rw [hdecomp] at hE
  have hmul := mul_le_mul_of_nonneg_left hE hone.le
  have hdeltaIdentity : (1 + epsilon) * delta = epsilon := by
    dsimp [delta]
    field_simp [hone.ne']
  rw [mul_add, mul_add, ← mul_assoc, hdeltaIdentity] at hmul
  nlinarith

/-- Radical and full-height normalizations are equivalent for the dyadic
repeated-prime problem. -/
theorem heightNormalized_iff_radicalNormalized :
    UniformDyadicPlusHeightNormalizedExcessBound ↔
      UniformDyadicPlusRepeatedExcessBound :=
  ⟨radicalNormalized_of_heightNormalized,
   heightNormalized_of_radicalNormalized⟩

/-- Therefore full-height sublinearity is exactly sufficient for dyadic abc. -/
theorem dyadicPlusABC_of_heightNormalizedExcess
    (hbound : UniformDyadicPlusHeightNormalizedExcessBound) :
    DyadicPlusABC :=
  dyadicPlusABC_of_uniformRepeatedExcess
    (radicalNormalized_of_heightNormalized hbound)

#print axioms repeatedPrimeExcess_nonneg
#print axioms heightNormalized_of_radicalNormalized
#print axioms radicalNormalized_of_heightNormalized
#print axioms heightNormalized_iff_radicalNormalized
#print axioms dyadicPlusABC_of_heightNormalizedExcess

end
end DyadicPlusHeightNormalization
end IUTThreeClosures
