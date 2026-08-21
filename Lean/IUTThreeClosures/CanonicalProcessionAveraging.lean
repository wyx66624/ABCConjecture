import IUTThreeClosures.CanonicalLocalDegreeWeights
import IUTThreeClosures.BarycentricPacketReading
import Iut.Cor312.Procession

/-!
# Exact capsule and procession averaging with canonical weights

Let every capsule carry the product distribution induced by a normalized
local-place weight. If the q-reading in that capsule is a barycentric linear
allocation among its labels, with coefficients summing to one, then the
capsule reading is exactly the ordinary local weighted sum. Consequently the
average over any nonempty procession is again that same local weighted sum.

This proves that neither tensor-product component weights nor procession
averaging create an error term. The remaining geometric obligation is to show
that the actual multiradial output log-volume is the barycentric labelwise
reading formalized here.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v

variable {ι : Type u} {V : Type v}

section AbstractWeights

variable (P : Iut.Procession ι)
variable [Fintype V]

/-- Product-weighted q-reading of one capsule. -/
noncomputable def capsuleBarycentricReading
    (coeff : ∀ i : Fin P.length, (P.capsule i).LabelType → ℝ)
    (weight value : V → ℝ)
    (i : Fin P.length) : ℝ :=
  ∑ c : (P.capsule i).LabelType → V,
    (∏ j, weight (c j)) *
      (∑ j, coeff i j * value (c j))

/-- Every normalized barycentric capsule reading is exactly the ordinary local
weighted sum. -/
theorem capsuleBarycentricReading_eq_local
    (coeff : ∀ i : Fin P.length, (P.capsule i).LabelType → ℝ)
    (weight value : V → ℝ)
    (hcoeff : ∀ i, ∑ j, coeff i j = 1)
    (hweight : ∑ v, weight v = 1)
    (i : Fin P.length) :
    capsuleBarycentricReading P coeff weight value i =
      ∑ v, weight v * value v := by
  classical
  exact product_weight_barycentric_of_sum_one
    (coeff i) weight value (hcoeff i) hweight

/-- Average of the capsule readings over the procession. -/
noncomputable def processionBarycentricReading
    (coeff : ∀ i : Fin P.length, (P.capsule i).LabelType → ℝ)
    (weight value : V → ℝ) : ℝ :=
  (∑ i : Fin P.length,
      capsuleBarycentricReading P coeff weight value i) /
    (P.length : ℝ)

/-- Procession averaging introduces no discrepancy: when the procession is
nonempty, the average remains the same local weighted sum. -/
theorem processionBarycentricReading_eq_local
    (coeff : ∀ i : Fin P.length, (P.capsule i).LabelType → ℝ)
    (weight value : V → ℝ)
    (hcoeff : ∀ i, ∑ j, coeff i j = 1)
    (hweight : ∑ v, weight v = 1)
    (hlen : 0 < P.length) :
    processionBarycentricReading P coeff weight value =
      ∑ v, weight v * value v := by
  classical
  have hcapsule : ∀ i : Fin P.length,
      capsuleBarycentricReading P coeff weight value i =
        ∑ v, weight v * value v :=
    capsuleBarycentricReading_eq_local P coeff weight value hcoeff hweight
  rw [processionBarycentricReading]
  simp_rw [hcapsule]
  have hne : (P.length : ℝ) ≠ 0 := by
    exact_mod_cast hlen.ne'
  simp [hne]

/-- Therefore the procession discrepancy from the ordinary local weighted
sum is identically zero. -/
noncomputable def processionAveragingError
    (coeff : ∀ i : Fin P.length, (P.capsule i).LabelType → ℝ)
    (weight value : V → ℝ) : ℝ :=
  processionBarycentricReading P coeff weight value -
    ∑ v, weight v * value v

@[simp]
theorem processionAveragingError_eq_zero
    (coeff : ∀ i : Fin P.length, (P.capsule i).LabelType → ℝ)
    (weight value : V → ℝ)
    (hcoeff : ∀ i, ∑ j, coeff i j = 1)
    (hweight : ∑ v, weight v = 1)
    (hlen : 0 < P.length) :
    processionAveragingError P coeff weight value = 0 := by
  rw [processionAveragingError,
    processionBarycentricReading_eq_local P coeff weight value
      hcoeff hweight hlen]
  ring

end AbstractWeights

section CanonicalLocalDegrees

universe w

variable {R : Type u} [CommRing R] [IsDomain R]
variable {S : Type v} [CommRing S] [Algebra R S]
variable [Module.Finite R S] [Module.Flat R S]
variable (p : Ideal R) [p.IsPrime] [Fintype (p.primesOver S)]
variable {ι : Type w}

/-- Specialization to the canonical `e f / [S:R]` local-degree weights. -/
theorem canonical_procession_reading_eq_local
    (P : Iut.Procession ι)
    (coeff : ∀ i : Fin P.length, (P.capsule i).LabelType → ℝ)
    (localContribution : p.primesOver S → ℝ)
    (hcoeff : ∀ i, ∑ j, coeff i j = 1)
    (hdeg : 0 < Module.finrank R S)
    (hlen : 0 < P.length) :
    processionBarycentricReading P coeff
        (canonicalLocalDegreeWeight p) localContribution =
      ∑ q : p.primesOver S,
        canonicalLocalDegreeWeight p q * localContribution q := by
  classical
  exact processionBarycentricReading_eq_local P coeff
    (canonicalLocalDegreeWeight p) localContribution hcoeff
    (sum_canonicalLocalDegreeWeight_eq_one p hdeg) hlen

/-- With canonical local-degree weights, both the component-product error and
the procession-averaging error vanish exactly. -/
theorem canonical_procession_averaging_error_eq_zero
    (P : Iut.Procession ι)
    (coeff : ∀ i : Fin P.length, (P.capsule i).LabelType → ℝ)
    (localContribution : p.primesOver S → ℝ)
    (hcoeff : ∀ i, ∑ j, coeff i j = 1)
    (hdeg : 0 < Module.finrank R S)
    (hlen : 0 < P.length) :
    processionAveragingError P coeff
        (canonicalLocalDegreeWeight p) localContribution = 0 := by
  classical
  exact processionAveragingError_eq_zero P coeff
    (canonicalLocalDegreeWeight p) localContribution hcoeff
    (sum_canonicalLocalDegreeWeight_eq_one p hdeg) hlen

end CanonicalLocalDegrees

end IUTThreeClosures
