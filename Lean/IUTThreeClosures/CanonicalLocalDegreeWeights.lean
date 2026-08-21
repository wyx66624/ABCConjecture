import IUTThreeClosures.ProductWeightMarginalization
import Mathlib.RingTheory.RamificationInertia.Basic

/-!
# Canonical local-degree weights and packet marginalization

For a finite flat extension of domains and a prime `p` of the base, the
canonical weight of a prime `q` above `p` is

`e(q/p) f(q/p) / [S : R]`.

The fundamental ramification-inertia identity says that these weights sum to
one.  Consequently the product weight on a capsule of labels has the expected
one-label marginal.  This is the exact arithmetic statement needed to match
actual capsule/component weights with the local-degree weights occurring in a
number-field height decomposition; no arbitrary real weight field is used.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v w

variable {R : Type u} [CommRing R] [IsDomain R]
variable {S : Type v} [CommRing S] [Algebra R S]
variable [Module.Finite R S] [Module.Flat R S]
variable (p : Ideal R) [p.IsPrime] [Fintype (p.primesOver S)]

/-- The canonical normalized local degree of a prime above `p`. -/
noncomputable def canonicalLocalDegreeWeight
    (q : p.primesOver S) : ℝ :=
  ((q.1.ramificationIdx R * q.1.inertiaDeg R : ℕ) : ℝ) /
    (Module.finrank R S : ℝ)

/-- Canonical local-degree weights sum to one. -/
theorem sum_canonicalLocalDegreeWeight_eq_one
    (hdeg : 0 < Module.finrank R S) :
    ∑ q : p.primesOver S, canonicalLocalDegreeWeight p q = 1 := by
  classical
  have hsum := Ideal.sum_ramification_inertia_eq_finrank p S
  have hdegR : (Module.finrank R S : ℝ) ≠ 0 := by
    exact_mod_cast hdeg.ne'
  calc
    ∑ q : p.primesOver S, canonicalLocalDegreeWeight p q =
        (∑ q : p.primesOver S,
          ((q.1.ramificationIdx R * q.1.inertiaDeg R : ℕ) : ℝ)) /
          (Module.finrank R S : ℝ) := by
      simp [canonicalLocalDegreeWeight, Finset.sum_div]
    _ = ((∑ q : p.primesOver S,
          q.1.ramificationIdx R * q.1.inertiaDeg R : ℕ) : ℝ) /
          (Module.finrank R S : ℝ) := by
      norm_cast
    _ = (Module.finrank R S : ℝ) / (Module.finrank R S : ℝ) := by
      rw [hsum]
    _ = 1 := div_self hdegR

/-- For a finite label set, the product of canonical local-degree weights has
canonical local-degree marginal at every distinguished label. -/
theorem canonical_product_weight_marginal
    {L : Type w} [Fintype L]
    [Fintype (L → p.primesOver S)]
    (j₀ : L) (f : p.primesOver S → ℝ)
    (hdeg : 0 < Module.finrank R S) :
    (∑ c : L → p.primesOver S,
      (∏ j, canonicalLocalDegreeWeight p (c j)) * f (c j₀)) =
      ∑ q : p.primesOver S, canonicalLocalDegreeWeight p q * f q := by
  classical
  exact product_weight_marginal j₀
    (canonicalLocalDegreeWeight p) f
    (sum_canonicalLocalDegreeWeight_eq_one p hdeg)

/-- The marginal identity for the local logarithmic contribution itself. -/
theorem canonical_product_weighted_local_sum
    {L : Type w} [Fintype L]
    [Fintype (L → p.primesOver S)]
    (j₀ : L) (localContribution : p.primesOver S → ℝ)
    (hdeg : 0 < Module.finrank R S) :
    (∑ c : L → p.primesOver S,
      (∏ j, canonicalLocalDegreeWeight p (c j)) *
        localContribution (c j₀)) =
      ∑ q : p.primesOver S,
        canonicalLocalDegreeWeight p q * localContribution q :=
  canonical_product_weight_marginal p j₀ localContribution hdeg

end IUTThreeClosures
