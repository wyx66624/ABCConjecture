/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointCubefulExcess
import Mathlib.Tactic

/-!
# Signed exponent-two excess on the large abc endpoints

The positive cubeful excess alone discards the negative contribution of primes
which occur to exponent one.  The exact quantity relevant to abc is instead

`log n - 2 * log (rad n)`.

For `n = max(a,b) * c`, this signed excess differs from
`2 * height - 2 * conductor` by at most `log 2`.  Consequently a uniform
sublinear upper bound for it is equivalent to the logarithmic abc conjecture.

The file also defines the squarefree deficit

`rad(n)^2 / gcd(n,rad(n)^2)`

and proves the exact multiplicative decomposition relating it to the positive
cubeful excess.
-/

namespace IUTThreeClosures
namespace LargeEndpointSignedExcess

open LargeEndpointCubefulExcess

noncomputable section

/-- The exponent-one factor which compensates the positive cubeful excess. -/
def squarefreeDeficit (n : ℕ) : ℕ :=
  abcRadical n ^ 2 / Nat.gcd n (abcRadical n ^ 2)

/-- The squarefree deficit is positive for every positive integer. -/
theorem squarefreeDeficit_pos {n : ℕ} (hn : 0 < n) :
    0 < squarefreeDeficit n := by
  unfold squarefreeDeficit
  apply Nat.div_pos
  · exact Nat.gcd_le_right n (abcRadical n ^ 2)
  · exact Nat.gcd_pos_of_pos_left _ hn

/-- Exact integral decomposition of the signed exponent-two excess. -/
theorem mul_squarefreeDeficit_eq_radical_sq_mul_cubefulExcess
    (n : ℕ) :
    n * squarefreeDeficit n =
      abcRadical n ^ 2 * cubefulExcess n := by
  let g := Nat.gcd n (abcRadical n ^ 2)
  have hgn : g ∣ n := by
    dsimp [g]
    exact Nat.gcd_dvd_left _ _
  have hgr : g ∣ abcRadical n ^ 2 := by
    dsimp [g]
    exact Nat.gcd_dvd_right _ _
  have hn : g * (n / g) = n := Nat.mul_div_cancel' hgn
  have hr : g * (abcRadical n ^ 2 / g) = abcRadical n ^ 2 :=
    Nat.mul_div_cancel' hgr
  unfold squarefreeDeficit cubefulExcess
  change n * (abcRadical n ^ 2 / g) =
    abcRadical n ^ 2 * (n / g)
  calc
    n * (abcRadical n ^ 2 / g) =
        (g * (n / g)) * (abcRadical n ^ 2 / g) := by rw [hn]
    _ = (g * (abcRadical n ^ 2 / g)) * (n / g) := by ring
    _ = abcRadical n ^ 2 * (n / g) := by rw [hr]

/-- Logarithmic form of the exact positive-minus-negative decomposition. -/
theorem log_add_log_squarefreeDeficit_eq_two_log_radical_add_log_cubefulExcess
    {n : ℕ} (hn : 0 < n) :
    Real.log (n : ℝ) + Real.log (squarefreeDeficit n : ℝ) =
      2 * Real.log (abcRadical n : ℝ) +
        Real.log (cubefulExcess n : ℝ) := by
  have hnR : 0 < (n : ℝ) := by exact_mod_cast hn
  have hradR : 0 < (abcRadical n : ℝ) := by
    exact_mod_cast abcRadical_pos n
  have hdefR : 0 < (squarefreeDeficit n : ℝ) := by
    exact_mod_cast squarefreeDeficit_pos hn
  have hexcR : 0 < (cubefulExcess n : ℝ) := by
    exact_mod_cast cubefulExcess_pos hn
  have hnat := mul_squarefreeDeficit_eq_radical_sq_mul_cubefulExcess n
  have hreal :
      (n : ℝ) * (squarefreeDeficit n : ℝ) =
        (abcRadical n : ℝ) ^ 2 * (cubefulExcess n : ℝ) := by
    exact_mod_cast hnat
  have hlog := congrArg Real.log hreal
  rw [Real.log_mul hnR.ne' hdefR.ne',
      Real.log_mul (pow_pos hradR 2).ne' hexcR.ne',
      Real.log_pow] at hlog
  nlinarith

end
end LargeEndpointSignedExcess

open LargeEndpointSignedExcess

noncomputable section

namespace ABCPoint

/-- Signed exponent-two excess of the two large adjacent endpoints. -/
def largeEndpointSignedExcess (P : ABCPoint) : ℝ :=
  Real.log (((P.largeEndpoint * P.c : ℕ) : ℝ)) -
    2 * P.conductor

/-- The larger summand is no larger than the total. -/
theorem largeEndpoint_le_c (P : ABCPoint) :
    P.largeEndpoint ≤ P.c := by
  unfold largeEndpoint
  apply max_le
  · exact Nat.le_of_lt P.a_lt_c
  · exact Nat.le_of_lt P.b_lt_c

/-- The product of the two large endpoints is at most `c^2`. -/
theorem largeEndpoint_mul_c_le_c_sq (P : ABCPoint) :
    P.largeEndpoint * P.c ≤ P.c ^ 2 := by
  have h := Nat.mul_le_mul_right P.c P.largeEndpoint_le_c
  simpa [pow_two, mul_comm] using h

/-- Lower half of the exact signed-excess corridor. -/
theorem largeEndpointSignedExcess_le_two_height_sub_two_conductor
    (P : ABCPoint) :
    P.largeEndpointSignedExcess ≤
      2 * P.height - 2 * P.conductor := by
  have hMpos : 0 < (P.largeEndpoint : ℝ) := by
    exact_mod_cast P.largeEndpoint_pos
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hprodpos : 0 < ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast mul_pos P.largeEndpoint_pos P.c_pos
  have hreal :
      ((P.largeEndpoint * P.c : ℕ) : ℝ) ≤ (P.c : ℝ) ^ 2 := by
    exact_mod_cast P.largeEndpoint_mul_c_le_c_sq
  have hlog := Real.log_le_log hprodpos hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold largeEndpointSignedExcess
  linarith

/-- Upper half of the exact signed-excess corridor. -/
theorem two_height_sub_two_conductor_le_largeEndpointSignedExcess_add_log_two
    (P : ABCPoint) :
    2 * P.height - 2 * P.conductor ≤
      P.largeEndpointSignedExcess + Real.log 2 := by
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hprodpos : 0 < ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast mul_pos P.largeEndpoint_pos P.c_pos
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast P.c_sq_le_two_largeEndpoint_mul_c
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hprodpos.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold largeEndpointSignedExcess
  linarith

/-- The signed excess and the abc quality differ by an interval of width
`log 2`. -/
theorem largeEndpointSignedExcess_corridor (P : ABCPoint) :
    P.largeEndpointSignedExcess ≤
        2 * P.height - 2 * P.conductor ∧
      2 * P.height - 2 * P.conductor ≤
        P.largeEndpointSignedExcess + Real.log 2 :=
  ⟨P.largeEndpointSignedExcess_le_two_height_sub_two_conductor,
   P.two_height_sub_two_conductor_le_largeEndpointSignedExcess_add_log_two⟩

end ABCPoint

namespace LargeEndpointSignedExcess

/-- A uniform sublinear upper bound for the signed exponent-two excess.  This
statement contains no hidden source object and no abc conclusion. -/
def UniformLargeEndpointSignedExcessBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ K : ℝ, ∀ P : ABCPoint,
      P.largeEndpointSignedExcess ≤
        2 * epsilon * P.conductor + K

/-- The signed-excess estimate proves the logarithmic abc conjecture. -/
theorem abc_of_uniformLargeEndpointSignedExcessBound
    (hbound : UniformLargeEndpointSignedExcessBound) :
    ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨K, hK⟩ := hbound epsilon hepsilon
  refine ⟨(K + Real.log 2) / 2, ?_⟩
  intro a b c ha hb hc hsum hcoprime
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hsum
      pairwise_coprime := hcoprime }
  have hcorridor :=
    P.two_height_sub_two_conductor_le_largeEndpointSignedExcess_add_log_two
  have hsigned := hK P
  have hheight :
      P.height ≤
        (1 + epsilon) * P.conductor +
          (K + Real.log 2) / 2 := by
    nlinarith
  simpa [P, ABCPoint.height, ABCPoint.conductor] using hheight

/-- Conversely, abc gives the signed-excess estimate with twice the abc
constant. -/
theorem uniformLargeEndpointSignedExcessBound_of_abc
    (habc : ABCConjecture) :
    UniformLargeEndpointSignedExcessBound := by
  intro epsilon hepsilon
  obtain ⟨C, hC⟩ := habc epsilon hepsilon
  refine ⟨2 * C, ?_⟩
  intro P
  have habcP :
      P.height ≤ (1 + epsilon) * P.conductor + C := by
    simpa [ABCPoint.height, ABCPoint.conductor] using
      hC P.a P.b P.c P.a_pos P.b_pos P.c_pos P.sum_eq P.pairwise_coprime
  have hlower :=
    P.largeEndpointSignedExcess_le_two_height_sub_two_conductor
  nlinarith

/-- Exact equivalence between abc and sublinear signed excess on the two large
endpoints. -/
theorem uniformLargeEndpointSignedExcessBound_iff_abc :
    UniformLargeEndpointSignedExcessBound ↔ ABCConjecture :=
  ⟨abc_of_uniformLargeEndpointSignedExcessBound,
   uniformLargeEndpointSignedExcessBound_of_abc⟩

#print axioms squarefreeDeficit_pos
#print axioms mul_squarefreeDeficit_eq_radical_sq_mul_cubefulExcess
#print axioms log_add_log_squarefreeDeficit_eq_two_log_radical_add_log_cubefulExcess
#print axioms ABCPoint.largeEndpoint_mul_c_le_c_sq
#print axioms ABCPoint.largeEndpointSignedExcess_le_two_height_sub_two_conductor
#print axioms ABCPoint.two_height_sub_two_conductor_le_largeEndpointSignedExcess_add_log_two
#print axioms abc_of_uniformLargeEndpointSignedExcessBound
#print axioms uniformLargeEndpointSignedExcessBound_of_abc
#print axioms uniformLargeEndpointSignedExcessBound_iff_abc

end LargeEndpointSignedExcess
end
end IUTThreeClosures
