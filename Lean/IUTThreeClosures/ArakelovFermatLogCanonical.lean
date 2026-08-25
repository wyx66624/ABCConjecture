/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TripodWeilHeight
import IUTThreeClosures.ExceptionalPrimeMassProduct
import IUTThreeClosures.ConcreteFermatBelyiRamification

/-!
# The log-canonical numerical profile of the Fermat cover

This file supplies the first unconditional Arakelov--Vojta/Fermat-cover
lemmas needed to compare the `abc` height with the punctured tripod.

## Mathematical proof

For a primitive positive triple `a+b=c`, the truncated finite counting
function of `0+1+infinity` at `lambda=a/c` is

`sum_{p | abc} log p = log rad(abc)`.

For a number-field point on `x^n+y^n=1`, the Fermat power map has coordinate
`t=x^n`, and `1-t=y^n`.  The product formula gives

`h(t)=n h(x)` and `h(1-t)=n h(y)`.

The degree-`n^2` Fermat cover has `n` points of ramification index `n` over
each of `0,1,infinity`.  Thus its total ramification degree is
`3n(n-1)`.  Riemann--Hurwitz and the reduced boundary degree `3n` give

`2g-2=-2n^2+3n(n-1)` and `deg(K+D)=n^2`.

The present file formalizes the exact height identities and the complete
integer arithmetic of this global profile.  It deliberately calls the latter
the *numerical* profile: Mathlib does not yet provide the divisor/genus API
needed here to identify these integers with the canonical divisor of the
constructed `Proj` scheme.  No Vojta inequality and no `abc` conclusion is
assumed.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-! ## The tripod's truncated counting function -/

/-- The finite truncated counting function of the tripod divisor at an
`ABCPoint`: every prime in the support is counted once. -/
noncomputable def tripodTruncatedCounting (P : ABCPoint) : ℝ :=
  primeLogMass (P.a * P.b * P.c).primeFactors

/-- The truncated tripod count is exactly the logarithmic radical used as
the elementary `abc` conductor. -/
theorem tripodTruncatedCounting_eq_conductor (P : ABCPoint) :
    tripodTruncatedCounting P = P.conductor := by
  have hprime :
      ∀ p ∈ (P.a * P.b * P.c).primeFactors, p.Prime := by
    intro p hp
    exact Nat.prime_of_mem_primeFactors hp
  calc
    tripodTruncatedCounting P =
        Real.log (primeProduct (P.a * P.b * P.c).primeFactors) := by
      exact primeLogMass_eq_log_primeProduct _ hprime
    _ = Real.log (abcRadical (P.a * P.b * P.c)) := by
      congr 1
    _ = P.conductor := rfl

/-- The log-cotangent height of the punctured tripod, in the normalization
used by this repository. -/
noncomputable def tripodLogCotangentHeight (P : ABCPoint) : ℝ :=
  Heights.normalizedLogHeight ℚ P.lambda

/-- On a primitive positive `abc` point, the log-cotangent height is the
elementary height `log c`. -/
theorem tripodLogCotangentHeight_eq_height (P : ABCPoint) :
    tripodLogCotangentHeight P = P.height :=
  P.normalizedLogHeight_lambda

/-! ## Exact height pullback under a power map -/

/-- Absolute normalized logarithmic height is multiplied by `n` under the
power map.  This is the element-level height pullback needed for the Fermat
cover. -/
theorem normalizedLogHeight_pow
    (K : Type*) [Field K] [NumberField K] (x : K) (n : ℕ) :
    Heights.normalizedLogHeight K (x ^ n) =
      (n : ℝ) * Heights.normalizedLogHeight K x := by
  unfold Heights.normalizedLogHeight
  rw [Height.logHeight₁_pow]
  ring

namespace ConcreteFermatBelyiRamification

/-- The height of the Fermat power-map coordinate `beta=x^n` is exactly
`n` times the height of `x`. -/
theorem normalizedLogHeight_affineBeta
    (K : Type*) [Field K] [NumberField K] (n : ℕ) (x : K) :
    Heights.normalizedLogHeight K (affineBeta n x) =
      (n : ℝ) * Heights.normalizedLogHeight K x := by
  exact normalizedLogHeight_pow K x n

/-- On `x^n+y^n=1`, the complementary target coordinate has height exactly
`n` times the height of `y`. -/
theorem normalizedLogHeight_one_sub_affineBeta
    (K : Type*) [Field K] [NumberField K]
    {n : ℕ} {x y : K} (hF : IsAffineFermatPoint n x y) :
    Heights.normalizedLogHeight K (1 - affineBeta n x) =
      (n : ℝ) * Heights.normalizedLogHeight K y := by
  rw [oneParameter_power_law hF]
  exact normalizedLogHeight_pow K y n

end ConcreteFermatBelyiRamification

/-! ## Global numerical Riemann--Hurwitz profile -/

/-- Degree of the Fermat power cover. -/
def fermatCoverDegree (n : ℤ) : ℤ := n ^ 2

/-- Number of geometric points in the reduced inverse image of the three
branch values. -/
def fermatReducedBoundaryDegree (n : ℤ) : ℤ := 3 * n

/-- Total tame ramification degree: three fibres, `n` points per fibre, and
ramification contribution `n-1` at each point. -/
def fermatTotalRamificationDegree (n : ℤ) : ℤ :=
  3 * n * (n - 1)

/-- The classical Fermat genus, represented integrally. -/
def fermatGenusNumerical (n : ℤ) : ℤ :=
  ((n - 1) * (n - 2)) / 2

/-- Degree of the numerical log-canonical divisor. -/
def fermatLogCanonicalDegree (n : ℤ) : ℤ :=
  (2 * fermatGenusNumerical n - 2) + fermatReducedBoundaryDegree n

private theorem fermat_genus_numerator_even (n : ℤ) :
    Even ((n - 1) * (n - 2)) := by
  convert Int.even_mul_succ_self (n - 2) using 1
  ring

/-- Twice the numerical genus is the usual consecutive product. -/
theorem two_mul_fermatGenusNumerical (n : ℤ) :
    2 * fermatGenusNumerical n = (n - 1) * (n - 2) := by
  exact Int.two_mul_ediv_two_of_even (fermat_genus_numerator_even n)

/-- The exact Riemann--Hurwitz integer identity for the degree-`n^2` Fermat
cover with its three tame branch fibres. -/
theorem fermat_riemann_hurwitz_numerical (n : ℤ) :
    2 * fermatGenusNumerical n - 2 =
      -2 * fermatCoverDegree n + fermatTotalRamificationDegree n := by
  rw [two_mul_fermatGenusNumerical]
  simp only [fermatCoverDegree, fermatTotalRamificationDegree]
  ring

/-- The ramification divisor plus the reduced boundary is the pullback of
the three-point boundary at the level of degrees. -/
theorem fermat_log_ramification_degree (n : ℤ) :
    fermatTotalRamificationDegree n + fermatReducedBoundaryDegree n =
      3 * fermatCoverDegree n := by
  simp only [fermatTotalRamificationDegree, fermatReducedBoundaryDegree,
    fermatCoverDegree]
  ring

/-- The numerical log-canonical degree is exactly the degree of the Fermat
cover.  This is the degree shadow of
`K_C + D_C = beta^*(K_P1 + D)`. -/
theorem fermat_logCanonicalDegree_eq_coverDegree (n : ℤ) :
    fermatLogCanonicalDegree n = fermatCoverDegree n := by
  rw [fermatLogCanonicalDegree, two_mul_fermatGenusNumerical]
  simp only [fermatReducedBoundaryDegree, fermatCoverDegree]
  ring

/-- The already constructed finite-etale Fermat algebra on the punctured
tripod has rank equal to the numerical log-canonical degree.  This ties the
integer profile to the actual algebraic cover rather than to a freely chosen
degree parameter. -/
theorem fermat_open_finrank_eq_logCanonicalDegree
    (K : Type*) [Field K] [CharZero K]
    (n : ℕ) (hn : n ≠ 0) :
    letI := ConcreteGenEllTripodCover.fermatTripodAlgebra K n hn
    (Module.finrank
        (ConcreteGenEllTripodCover.TripodRing K)
        (ConcreteGenEllTripodCover.FermatAffineRing K n hn) : ℤ) =
      fermatLogCanonicalDegree (n : ℤ) := by
  letI := ConcreteGenEllTripodCover.fermatTripodAlgebra K n hn
  have hrank :
      Module.finrank
          (ConcreteGenEllTripodCover.TripodRing K)
          (ConcreteGenEllTripodCover.FermatAffineRing K n hn) = n ^ 2 :=
    ConcreteFermatBelyiRamification.TripodCertificate.beta_finrank_away_from_zero_one_infinity
      K n hn
  rw [hrank, fermat_logCanonicalDegree_eq_coverDegree]
  simp [fermatCoverDegree]

/-- Consequently degree normalization has ratio one for every nonzero cover
degree; increasing `n` cannot lower the main counting coefficient. -/
theorem fermat_logCanonicalDegree_ratio_one
    (n : ℤ) (hn : n ≠ 0) :
    (fermatLogCanonicalDegree n : ℚ) /
        (fermatCoverDegree n : ℚ) = 1 := by
  rw [fermat_logCanonicalDegree_eq_coverDegree]
  simp [fermatCoverDegree, hn]

/-! ## Coefficient bookkeeping -/

/-- The standard Vojta error coefficient
`eta=epsilon/(1+epsilon)` rearranges to the `abc` coefficient `1+epsilon`.
This is a pure algebraic implication, not an assumption that the Vojta-shaped
premise is available. -/
theorem vojta_eta_rearrangement
    {epsilon height count constant : ℝ}
    (hepsilon : 0 < epsilon)
    (hVojta :
      height ≤ count + epsilon / (1 + epsilon) * height + constant) :
    height ≤
      (1 + epsilon) * count + (1 + epsilon) * constant := by
  have hden : 0 < 1 + epsilon := by linarith
  have hcancel :
      (1 + epsilon) * (epsilon / (1 + epsilon)) = epsilon := by
    field_simp [hden.ne']
  have hscaled := mul_le_mul_of_nonneg_left hVojta hden.le
  rw [mul_add, mul_add, ← mul_assoc, hcancel] at hscaled
  nlinarith

/-- Normalizing an inequality by a positive covering degree divides only
the additive constant: the coefficient of the counting term stays `alpha`.
-/
theorem positive_degree_coefficient_rigidity
    {degree alpha height count constant : ℝ} (hdegree : 0 < degree) :
    degree * height ≤ alpha * degree * count + constant ↔
      height ≤ alpha * count + constant / degree := by
  have hrewrite :
      alpha * count + constant / degree =
        (alpha * degree * count + constant) / degree := by
    field_simp [hdegree.ne']
  rw [hrewrite, le_div_iff₀ hdegree]
  ring_nf

/-- A fixed coefficient `alpha` larger than `1+epsilon` cannot be improved
to `1+epsilon` by choosing a higher covering degree. -/
theorem fixed_coefficient_exceeds_target
    {alpha epsilon : ℝ} (hgap : epsilon < alpha - 1) :
    ¬ alpha ≤ 1 + epsilon := by
  linarith

end IUTThreeClosures
