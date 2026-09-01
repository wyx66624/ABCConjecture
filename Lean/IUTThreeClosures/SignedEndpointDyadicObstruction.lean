/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SignedPrimeSupport
import IUTThreeClosures.PrimePowerSmoothNeighbour

/-!
# Unbounded dyadic obstruction to separate endpoint control

The proof was written in `research/SIGNED_LAYER_ARITHMETIC_SESSION_2026_08_30.md`
before this formalization. The witnesses are the actual primitive triples
`(1, 2^N, 2^N+1)`. No assumption about the radical of the odd neighbour is made.
This refutes a separate-endpoint estimate, not abc or the coupled estimate.
-/

namespace IUTThreeClosures
namespace SignedEndpointDyadicObstruction

noncomputable section

/-- A genuine primitive adjacent triple at every dyadic exponent. -/
def dyadicPoint (N : ℕ) : ABCPoint where
  a := 1
  b := 2 ^ N
  c := 2 ^ N + 1
  a_pos := by norm_num
  b_pos := by positivity
  c_pos := by positivity
  sum_eq := by omega
  pairwise_coprime := by simp [PairwiseCoprimeABC]

@[simp] theorem dyadic_small_endpoint (N : ℕ) :
    (dyadicPoint N).endpointMin = 1 := by
  have h : 1 ≤ 2 ^ N := Nat.one_le_pow N 2 (by norm_num)
  simp [dyadicPoint, ABCPoint.endpointMin, min_eq_left h]

@[simp] theorem dyadic_large_endpoint (N : ℕ) :
    (dyadicPoint N).largeEndpoint = 2 ^ N := by
  have h : 1 ≤ 2 ^ N := Nat.one_le_pow N 2 (by norm_num)
  simp [dyadicPoint, ABCPoint.largeEndpoint, max_eq_right h]

/-- Exact signed defect of the dyadic endpoint. -/
theorem dyadic_single_defect (N : ℕ) (hN : 0 < N) :
    ABCPoint.singleEndpointSquareRadicalDefect (dyadicPoint N).largeEndpoint =
      ((N : ℝ) - 2) * Real.log 2 := by
  rw [dyadic_large_endpoint]
  unfold ABCPoint.singleEndpointSquareRadicalDefect
  rw [abcRadical_prime_pow Nat.prime_two hN, Nat.cast_pow, Real.log_pow]
  norm_num
  ring

/-- An unconditional upper bound for the full radical of the dyadic triple. -/
theorem dyadic_radical_le (N : ℕ) (hN : 0 < N) :
    abcRadical ((dyadicPoint N).a * (dyadicPoint N).b * (dyadicPoint N).c) ≤
      2 ^ (N + 2) := by
  change abcRadical (1 * 2 ^ N * (2 ^ N + 1)) ≤ _
  rw [one_mul]
  have hrad : abcRadical (2 ^ N + 1) ≤ 2 ^ N + 1 :=
    abcRadical_le_self (by positivity)
  have hpow : 1 ≤ 2 ^ N := Nat.one_le_pow N 2 (by norm_num)
  calc
    abcRadical (2 ^ N * (2 ^ N + 1)) ≤
        abcRadical (2 ^ N) * abcRadical (2 ^ N + 1) :=
      abcRadical_mul_le_mul _ _
    _ = 2 * abcRadical (2 ^ N + 1) := by
      rw [abcRadical_prime_pow Nat.prime_two hN]
    _ ≤ 2 * (2 ^ N + 1) := Nat.mul_le_mul_left 2 hrad
    _ ≤ 2 ^ (N + 2) := by
      rw [pow_add]
      norm_num
      omega

/-- The full conductor needs no factorization information about `2^N+1`. -/
theorem dyadic_conductor_le (N : ℕ) (hN : 0 < N) :
    (dyadicPoint N).conductor ≤ ((N : ℝ) + 2) * Real.log 2 := by
  have hradpos : 0 <
      (abcRadical ((dyadicPoint N).a * (dyadicPoint N).b * (dyadicPoint N).c) : ℝ) := by
    exact_mod_cast abcRadical_pos _
  have hbound := dyadic_radical_le N hN
  have hreal :
      (abcRadical ((dyadicPoint N).a * (dyadicPoint N).b * (dyadicPoint N).c) : ℝ) ≤
        (2 : ℝ) ^ (N + 2) := by exact_mod_cast hbound
  have hlog := Real.log_le_log hradpos hreal
  rw [Real.log_pow] at hlog
  simpa [ABCPoint.conductor, Nat.cast_add, Nat.cast_ofNat] using hlog

/-- Every coefficient below one fails as a separate-endpoint conductor slope. -/
theorem unbounded_separate_endpoint_defect
    {ρ : ℝ} (hρ0 : 0 ≤ ρ) (hρ1 : ρ < 1) (K : ℝ) :
    ∃ P : ABCPoint,
      P.endpointMin = 1 ∧
      Real.log (abcRadical P.endpointMin : ℝ) + ρ * P.conductor + K <
        ABCPoint.singleEndpointSquareRadicalDefect P.largeEndpoint := by
  have hlog : 0 < Real.log (2 : ℝ) := Real.log_pos (by norm_num)
  have hcoef : 0 < (1 - ρ) * Real.log (2 : ℝ) := mul_pos (by linarith) hlog
  obtain ⟨n, hn⟩ := exists_nat_gt ((K + (2 + 2 * ρ) * Real.log 2) /
    ((1 - ρ) * Real.log 2))
  let N : ℕ := n + 1
  have hN : 0 < N := by dsimp [N]; omega
  have hNlarge : (K + (2 + 2 * ρ) * Real.log 2) /
      ((1 - ρ) * Real.log 2) < (N : ℝ) := by
    dsimp [N]
    push_cast
    linarith
  have hgap : K + (2 + 2 * ρ) * Real.log 2 <
      (N : ℝ) * ((1 - ρ) * Real.log 2) :=
    (div_lt_iff₀ hcoef).mp hNlarge
  refine ⟨dyadicPoint N, dyadic_small_endpoint N, ?_⟩
  rw [dyadic_single_defect N hN, dyadic_small_endpoint]
  have hradone : abcRadical 1 = 1 := by simp [abcRadical]
  rw [hradone]
  norm_num
  have hscaled := mul_le_mul_of_nonneg_left (dyadic_conductor_le N hN) hρ0
  nlinarith

/-- The false stronger target cannot be used to close the coupled abc route. -/
theorem not_uniform_separate_endpoint_bound
    {ρ : ℝ} (hρ0 : 0 ≤ ρ) (hρ1 : ρ < 1) :
    ¬ ∃ K : ℝ, ∀ P : ABCPoint,
      ABCPoint.singleEndpointSquareRadicalDefect P.largeEndpoint ≤
        Real.log (abcRadical P.endpointMin : ℝ) + ρ * P.conductor + K := by
  rintro ⟨K, hK⟩
  obtain ⟨P, _, hP⟩ := unbounded_separate_endpoint_defect hρ0 hρ1 K
  exact (not_lt_of_ge (hK P)) hP

#print axioms dyadic_single_defect
#print axioms dyadic_conductor_le
#print axioms unbounded_separate_endpoint_defect
#print axioms not_uniform_separate_endpoint_bound

end
end SignedEndpointDyadicObstruction
end IUTThreeClosures
