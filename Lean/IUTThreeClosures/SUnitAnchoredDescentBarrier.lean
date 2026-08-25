/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SUnitUniformTripod

/-!
# The anchored-descent barrier for the rational S-unit tripod

This file audits the most immediate way in which a count of rational
`S`-unit solutions might be converted into a height bound: start from one
high solution and generate many further solutions with controlled support.

The two elementary obstructions formalized here are:

* the two standard generators `x ↦ 1-x` and `x ↦ x⁻¹` generate only the six
  points in the tripod orbit, even after arbitrarily many iterations;
* a genuine Euclidean descent can leave that orbit, but already the family
  `(q+1)+1=q+2` shows that its first step introduces the arbitrarily large
  new prime `q`.

We also record the exact numerical implication which a future anchored
proliferation theorem would have to exploit: an exponential lower bound in
the excess, combined with an exponential upper bound in support rank, gives
a linear excess bound.  No such proliferation statement, S-unit count,
height estimate, or abc inequality is assumed as data in this module.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## The finite orbit of the two tripod generators -/

/-- The six rational coordinates obtained by permuting the marked points
`0,1,∞`.  Division by zero is harmless for the definition; the orbit-closure
theorems below impose `x ≠ 0,1`. -/
def rationalTripodOrbit (x : ℚ) : Finset ℚ :=
  [x, 1 - x, x⁻¹, (1 - x)⁻¹,
    x / (x - 1), (x - 1) / x].toFinset

/-- The tripod orbit contains at most six rational numbers. -/
theorem rationalTripodOrbit_card_le_six (x : ℚ) :
    (rationalTripodOrbit x).card ≤ 6 := by
  classical
  simpa [rationalTripodOrbit] using
    (List.toFinset_card_le
      [x, 1 - x, x⁻¹, (1 - x)⁻¹,
        x / (x - 1), (x - 1) / x])

/-- Complementation permutes the six-point tripod orbit. -/
theorem one_sub_mem_rationalTripodOrbit
    {x z : ℚ} (hx0 : x ≠ 0) (hx1 : x ≠ 1)
    (hz : z ∈ rationalTripodOrbit x) :
    1 - z ∈ rationalTripodOrbit x := by
  classical
  simp only [rationalTripodOrbit, List.mem_toFinset, List.mem_cons,
    List.not_mem_nil, or_false] at hz ⊢
  rcases hz with rfl | rfl | rfl | rfl | rfl | rfl
  · aesop
  · aesop
  · right; right; right; right; right
    field_simp
  · right; right; right; right; left
    field_simp
    ring
  · right; right; right; left
    field_simp
    ring
  · right; right; left
    field_simp
    ring

/-- Inversion permutes the six-point tripod orbit. -/
theorem inv_mem_rationalTripodOrbit
    {x z : ℚ} (hx0 : x ≠ 0) (hx1 : x ≠ 1)
    (hz : z ∈ rationalTripodOrbit x) :
    z⁻¹ ∈ rationalTripodOrbit x := by
  classical
  simp only [rationalTripodOrbit, List.mem_toFinset, List.mem_cons,
    List.not_mem_nil, or_false] at hz ⊢
  rcases hz with rfl | rfl | rfl | rfl | rfl | rfl
  · aesop
  · aesop
  · left
    field_simp
  · right; left
    field_simp
  · right; right; right; right; right
    field_simp
  · right; right; right; right; left
    field_simp

/-- Words in the two natural tripod generators. -/
inductive RationalTripodGenerator where
  | oneSub
  | inv
  deriving DecidableEq

/-- Evaluation of a word in complementation and inversion. -/
def evalRationalTripodWord : List RationalTripodGenerator → ℚ → ℚ
  | [], x => x
  | RationalTripodGenerator.oneSub :: word, x =>
      1 - evalRationalTripodWord word x
  | RationalTripodGenerator.inv :: word, x =>
      (evalRationalTripodWord word x)⁻¹

/-- Arbitrarily long words in the two generators never escape the same
six-point orbit.  Thus iteration of the universal tripod symmetries cannot
provide exponential descendant proliferation. -/
theorem evalRationalTripodWord_mem_orbit
    (word : List RationalTripodGenerator) {x : ℚ}
    (hx0 : x ≠ 0) (hx1 : x ≠ 1) :
    evalRationalTripodWord word x ∈ rationalTripodOrbit x := by
  induction word with
  | nil => simp [evalRationalTripodWord, rationalTripodOrbit]
  | cons generator word ih =>
      cases generator with
      | oneSub =>
          exact one_sub_mem_rationalTripodOrbit hx0 hx1 ih
      | inv =>
          exact inv_mem_rationalTripodOrbit hx0 hx1 ih

/-! ## Euclidean descent does not preserve the old support -/

/-- A simple first Euclidean step on the chamber `a>b`, written directly in
the rational coordinate: `(a/(a+b)) ↦ (a-b)/a`. -/
def rationalEuclideanStep (x : ℚ) : ℚ := 2 - x⁻¹

/-- On the actual family `(q+1)+1=q+2`, the first Euclidean step is the
coordinate `q/(q+1)` of the descended triple `(q,1,q+1)`. -/
theorem rationalEuclideanStep_prime_family (q : ℕ) :
    rationalEuclideanStep (((q + 1 : ℕ) : ℚ) / (q + 2 : ℕ)) =
      (q : ℚ) / (q + 1 : ℕ) := by
  unfold rationalEuclideanStep
  by_cases hq : q + 1 = 0
  · omega
  field_simp
  norm_num
  ring

/-- The new prime `q` divides the descended product `q(q+1)`. -/
theorem prime_dvd_euclidean_descendant_product {q : ℕ} (_hq : q.Prime) :
    q ∣ q * (q + 1) := by
  exact dvd_mul_right q (q + 1)

/-- For odd prime `q`, the same prime does not divide the ancestor product
`(q+1)(q+2)`. -/
theorem odd_prime_not_dvd_euclidean_ancestor_product
    {q : ℕ} (hq : q.Prime) (hqodd : q ≠ 2) :
    ¬ q ∣ (q + 1) * (q + 2) := by
  rw [hq.dvd_mul]
  push Not
  constructor
  · simp [hq.ne_one]
  · intro hq2
    have hqTwo : q ∣ 2 := by
      simpa [Nat.add_comm] using hq2
    rcases (Nat.dvd_prime Nat.prime_two).mp hqTwo with hq1 | hq2eq
    · exact hq.ne_one hq1
    · exact hqodd hq2eq

/-- In prime-support language, the Euclidean descendant contains `q` while
the ancestor does not.  These are the actual products of the triples
`(q,1,q+1)` and `(q+1,1,q+2)`. -/
theorem odd_prime_enters_euclidean_descendant_support
    {q : ℕ} (hq : q.Prime) (hqodd : q ≠ 2) :
    q ∈ (q * (q + 1)).primeFactors ∧
      q ∉ ((q + 1) * (q + 2)).primeFactors := by
  constructor
  · rw [Nat.mem_primeFactors]
    exact ⟨hq, prime_dvd_euclidean_descendant_product hq,
      mul_ne_zero hq.ne_zero (by omega)⟩
  · intro hmem
    exact odd_prime_not_dvd_euclidean_ancestor_product hq hqodd
      (Nat.dvd_of_mem_primeFactors hmem)

/-! ## The numerical target for a genuine proliferation theorem -/

/-- If a descendant construction supplies exponentially many points in the
excess and a counting theorem supplies only exponentially many points in the
support rank, then the excess is linear in the rank.  This theorem records
only that real inequality; neither arithmetic premise is asserted here. -/
theorem excess_le_linear_of_exponential_proliferation
    {excess rank kappa countSlope countConstant : ℝ}
    (hkappa : 0 < kappa)
    (hcompare :
      Real.exp (kappa * excess) ≤
        Real.exp (countSlope * rank + countConstant)) :
    excess ≤
      (countSlope / kappa) * rank + countConstant / kappa := by
  have hlinear :
      kappa * excess ≤ countSlope * rank + countConstant :=
    (Real.exp_le_exp).mp hcompare
  rw [show (countSlope / kappa) * rank + countConstant / kappa =
      (countSlope * rank + countConstant) / kappa by
        field_simp]
  apply (le_div_iff₀ hkappa).mpr
  simpa [mul_comm] using hlinear

end

end IUTThreeClosures
