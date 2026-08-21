import IUTThreeClosures.CanonicalLocalDegreeWeights

/-!
# Tame different contribution under root normalization

For a finite flat extension and a prime `p` of the base, the tame different
exponent at `q | p` is `e(q/p) - 1`. With the canonical local-degree
normalization its weight is

`(e(q/p) - 1) f(q/p) / [S : R]`.

Since `e - 1 ≤ e` and `∑_{q|p} e f = [S:R]`, the total normalized tame
different contribution at `p` is at most `log p`. After the IUT `2ℓ`-th-root
normalization it is at most `log p / (2ℓ)`, and hence at most
`ε log p` whenever `1/(2ℓ) ≤ ε`.

This proves the tame part of the different correction with the exact
coefficient needed for epsilon absorption. Wild different exponents and the
geometric identification of the source correction with this arithmetic sum
remain separate tasks.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v

variable {R : Type u} [CommRing R] [IsDomain R]
variable {S : Type v} [CommRing S] [Algebra R S]
variable [Module.Finite R S] [Module.Flat R S]
variable (p : Ideal R) [p.IsPrime] [Fintype (p.primesOver S)]

/-- Canonically normalized tame different weight at `q | p`. -/
noncomputable def canonicalTameDifferentWeight
    (q : p.primesOver S) : ℝ :=
  (((q.1.ramificationIdx R - 1) * q.1.inertiaDeg R : ℕ) : ℝ) /
    (Module.finrank R S : ℝ)

/-- The tame different weight is nonnegative. -/
theorem canonicalTameDifferentWeight_nonneg
    (hdeg : 0 < Module.finrank R S)
    (q : p.primesOver S) :
    0 ≤ canonicalTameDifferentWeight p q := by
  unfold canonicalTameDifferentWeight
  have hdegR : 0 < (Module.finrank R S : ℝ) := by
    exact_mod_cast hdeg
  exact div_nonneg (by positivity) hdegR.le

/-- Pointwise, the tame different weight is bounded by the full local-degree
weight `e f / [S:R]`. -/
theorem canonicalTameDifferentWeight_le_localDegreeWeight
    (hdeg : 0 < Module.finrank R S)
    (q : p.primesOver S) :
    canonicalTameDifferentWeight p q ≤
      canonicalLocalDegreeWeight p q := by
  unfold canonicalTameDifferentWeight canonicalLocalDegreeWeight
  have hdegR : 0 < (Module.finrank R S : ℝ) := by
    exact_mod_cast hdeg
  apply (div_le_div_iff_of_pos_right hdegR).2
  have hsub : q.1.ramificationIdx R - 1 ≤ q.1.ramificationIdx R :=
    Nat.sub_le _ _
  have hmul :
      (q.1.ramificationIdx R - 1) * q.1.inertiaDeg R ≤
        q.1.ramificationIdx R * q.1.inertiaDeg R :=
    Nat.mul_le_mul_right _ hsub
  exact_mod_cast hmul

/-- The sum of the normalized tame different weights over `q | p` is at most
one. -/
theorem sum_canonicalTameDifferentWeight_le_one
    (hdeg : 0 < Module.finrank R S) :
    ∑ q : p.primesOver S, canonicalTameDifferentWeight p q ≤ 1 := by
  calc
    ∑ q : p.primesOver S, canonicalTameDifferentWeight p q ≤
        ∑ q : p.primesOver S, canonicalLocalDegreeWeight p q := by
      exact Finset.sum_le_sum fun q _ =>
        canonicalTameDifferentWeight_le_localDegreeWeight p hdeg q
    _ = 1 := sum_canonicalLocalDegreeWeight_eq_one p hdeg

/-- Tame different contribution at one base prime. -/
noncomputable def canonicalTameDifferentContribution
    (primeLog : ℝ) : ℝ :=
  ∑ q : p.primesOver S,
    canonicalTameDifferentWeight p q * primeLog

/-- At one base prime, the normalized tame different contribution is at most
the base-prime logarithm. -/
theorem canonicalTameDifferentContribution_le
    (hdeg : 0 < Module.finrank R S)
    {primeLog : ℝ} (hlog : 0 ≤ primeLog) :
    canonicalTameDifferentContribution (S := S) p primeLog ≤ primeLog := by
  unfold canonicalTameDifferentContribution
  calc
    ∑ q : p.primesOver S,
        canonicalTameDifferentWeight p q * primeLog ≤
      ∑ q : p.primesOver S,
        canonicalLocalDegreeWeight p q * primeLog := by
      exact Finset.sum_le_sum fun q _ =>
        mul_le_mul_of_nonneg_right
          (canonicalTameDifferentWeight_le_localDegreeWeight p hdeg q) hlog
    _ = (∑ q : p.primesOver S,
        canonicalLocalDegreeWeight p q) * primeLog := by
      rw [Finset.sum_mul]
    _ = primeLog := by
      rw [sum_canonicalLocalDegreeWeight_eq_one p hdeg, one_mul]

/-- `2ℓ`-root-normalized tame different contribution. -/
noncomputable def rootNormalizedTameDifferentContribution
    (ell : ℕ) (primeLog : ℝ) : ℝ :=
  canonicalTameDifferentContribution (S := S) p primeLog /
    (2 * (ell : ℝ))

/-- Root normalization gives the exact `1/(2ℓ)` upper coefficient. -/
theorem rootNormalizedTameDifferentContribution_le
    (hdeg : 0 < Module.finrank R S)
    {ell : ℕ} (hell : 0 < ell)
    {primeLog : ℝ} (hlog : 0 ≤ primeLog) :
    rootNormalizedTameDifferentContribution (S := S) (p := p) ell primeLog ≤
      primeLog / (2 * (ell : ℝ)) := by
  unfold rootNormalizedTameDifferentContribution
  have hden : 0 < (2 : ℝ) * (ell : ℝ) := by
    positivity
  exact (div_le_div_iff_of_pos_right hden).2
    (canonicalTameDifferentContribution_le (S := S) p hdeg hlog)

/-- If the root coefficient is below `ε`, the tame different contribution is
absorbed by `ε` times the base-prime conductor contribution. -/
theorem rootNormalizedTameDifferentContribution_le_epsilon
    (hdeg : 0 < Module.finrank R S)
    {ell : ℕ} (hell : 0 < ell)
    {primeLog ε : ℝ} (hlog : 0 ≤ primeLog)
    (hscale : 1 / (2 * (ell : ℝ)) ≤ ε) :
    rootNormalizedTameDifferentContribution (S := S) (p := p) ell primeLog ≤
      ε * primeLog := by
  calc
    rootNormalizedTameDifferentContribution (S := S) (p := p) ell primeLog ≤
        primeLog / (2 * (ell : ℝ)) :=
      rootNormalizedTameDifferentContribution_le
        (S := S) (p := p) hdeg hell hlog
    _ = (1 / (2 * (ell : ℝ))) * primeLog := by ring
    _ ≤ ε * primeLog :=
      mul_le_mul_of_nonneg_right hscale hlog

end IUTThreeClosures
