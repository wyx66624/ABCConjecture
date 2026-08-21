import IUTThreeClosures.CanonicalLocalDegreeWeights
import IUTThreeClosures.RamificationCorrectedQPilot

/-!
# Exact cancellation of ramification in canonical local-degree weights

At a prime `q` above a base prime `p`, a uniformizer-normalized local q-order
has response `-(n/e) log p`, where `e` is the ramification index. The canonical
local-degree weight is `e f / [S:R]`. Their product is therefore exactly

`-(n f / [S:R]) log p`.

Thus ramification does not create a residual error once the correct local
weights are used: the factor `e` cancels term by term, before summing over the
places above `p`. This is the precise arithmetic correction needed by the
all-place packet comparison.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v

variable {R : Type u} [CommRing R] [IsDomain R]
variable {S : Type v} [CommRing S] [Algebra R S]
variable [Module.Finite R S] [Module.Flat R S]
variable (p : Ideal R) [p.IsPrime] [Fintype (p.primesOver S)]

/-- Ramification-corrected local q-response at a prime above `p`. -/
noncomputable def ramificationCorrectedLocalQResponse
    (order : p.primesOver S → ℝ) (logp : ℝ)
    (q : p.primesOver S) : ℝ :=
  -(order q / (q.1.ramificationIdx R : ℝ)) * logp

/-- The same contribution after the ramification index has canceled against
the canonical local-degree weight. -/
noncomputable def inertiaWeightedLocalQContribution
    (order : p.primesOver S → ℝ) (logp : ℝ)
    (q : p.primesOver S) : ℝ :=
  -((order q * (q.1.inertiaDeg R : ℝ)) /
      (Module.finrank R S : ℝ)) * logp

/-- Termwise cancellation of the ramification index. -/
theorem canonicalWeight_mul_ramificationCorrected_eq
    (order : p.primesOver S → ℝ) (logp : ℝ)
    (hdeg : 0 < Module.finrank R S)
    (q : p.primesOver S) :
    canonicalLocalDegreeWeight p q *
        ramificationCorrectedLocalQResponse p order logp q =
      inertiaWeightedLocalQContribution p order logp q := by
  have heNat : 0 < q.1.ramificationIdx R :=
    q.1.ramificationIdx_pos R
  have he : (q.1.ramificationIdx R : ℝ) ≠ 0 := by
    exact_mod_cast heNat.ne'
  have hd : (Module.finrank R S : ℝ) ≠ 0 := by
    exact_mod_cast hdeg.ne'
  unfold canonicalLocalDegreeWeight
    ramificationCorrectedLocalQResponse
    inertiaWeightedLocalQContribution
  have h := normalized_local_degree_contribution
    (e := (q.1.ramificationIdx R : ℝ))
    (f := (q.1.inertiaDeg R : ℝ))
    (d := (Module.finrank R S : ℝ))
    (n := order q) (logp := logp) he hd
  simpa [Nat.cast_mul] using h

/-- The entire weighted local packet has no ramification discrepancy. -/
theorem sum_canonicalWeight_mul_ramificationCorrected_eq
    (order : p.primesOver S → ℝ) (logp : ℝ)
    (hdeg : 0 < Module.finrank R S) :
    ∑ q : p.primesOver S,
        canonicalLocalDegreeWeight p q *
          ramificationCorrectedLocalQResponse p order logp q =
      ∑ q : p.primesOver S,
        inertiaWeightedLocalQContribution p order logp q := by
  classical
  apply Finset.sum_congr rfl
  intro q hq
  exact canonicalWeight_mul_ramificationCorrected_eq p order logp hdeg q

/-- Canonical ramification correction error. -/
noncomputable def ramificationWeightError
    (order : p.primesOver S → ℝ) (logp : ℝ) : ℝ :=
  (∑ q : p.primesOver S,
      canonicalLocalDegreeWeight p q *
        ramificationCorrectedLocalQResponse p order logp q) -
    ∑ q : p.primesOver S,
      inertiaWeightedLocalQContribution p order logp q

/-- With canonical local-degree weights the ramification correction is exactly
zero, hence uniformly bounded by zero. -/
@[simp]
theorem ramificationWeightError_eq_zero
    (order : p.primesOver S → ℝ) (logp : ℝ)
    (hdeg : 0 < Module.finrank R S) :
    ramificationWeightError p order logp = 0 := by
  rw [ramificationWeightError,
    sum_canonicalWeight_mul_ramificationCorrected_eq p order logp hdeg]
  ring

end IUTThreeClosures
