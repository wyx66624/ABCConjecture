import IUTThreeClosures.CanonicalProcessionAveraging

/-!
# Reduction of multiradial packet comparison to a componentwise formula

The global comparison between an actual multiradial output and a complete
weighted q-packet has two logically separate parts:

1. a geometric/local theorem computing the log-volume of each concrete packet
   component as a barycentric sum of its labelwise local q-contributions;
2. finite probability algebra, which marginalizes the product component
   weights and averages over the procession.

The second part is proved here. Once the componentwise formula holds, the
weighted capsule reading and the nonempty procession average are exactly the
ordinary local weighted sum. Thus no independent "multiradial packet error"
may be inserted after the componentwise calculation; the remaining seam is a
precise local log-volume identity.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v

variable {ι : Type u} {V : Type v}

/-- Data reducing one concrete multiradial packet calculation to a labelwise
barycentric local formula. -/
structure MultiradialComponentFormula
    (P : Iut.Procession ι) [Fintype V] where
  /-- Allocation of the q-reading among the labels of each capsule. -/
  coeff : ∀ i : Fin P.length, (P.capsule i).LabelType → ℝ
  /-- The allocation is barycentric. -/
  coeff_sum_one : ∀ i, ∑ j, coeff i j = 1
  /-- Normalized local-place weights. -/
  weight : V → ℝ
  weight_sum_one : ∑ v, weight v = 1
  /-- Labelwise local q-contribution. -/
  localContribution : V → ℝ
  /-- Actual component log-volume supplied by the geometric source. -/
  componentVolume :
    ∀ i : Fin P.length, ((P.capsule i).LabelType → V) → ℝ
  /-- The sole remaining geometric identity: on every concrete component, the
  actual log-volume is the barycentric labelwise q-reading. -/
  componentVolume_eq : ∀ i c,
    componentVolume i c =
      ∑ j, coeff i j * localContribution (c j)

namespace MultiradialComponentFormula

variable {P : Iut.Procession ι} [Fintype V]

/-- Product-weighted volume of one actual capsule. -/
noncomputable def capsuleVolume
    (M : MultiradialComponentFormula P (V := V))
    (i : Fin P.length) : ℝ :=
  ∑ c : (P.capsule i).LabelType → V,
    (∏ j, M.weight (c j)) * M.componentVolume i c

/-- The concrete capsule volume equals the canonical local weighted sum. -/
theorem capsuleVolume_eq_local
    (M : MultiradialComponentFormula P (V := V))
    (i : Fin P.length) :
    M.capsuleVolume i =
      ∑ v, M.weight v * M.localContribution v := by
  classical
  rw [capsuleVolume]
  simp_rw [M.componentVolume_eq]
  exact product_weight_barycentric_of_sum_one
    (M.coeff i) M.weight M.localContribution
    (M.coeff_sum_one i) M.weight_sum_one

/-- Actual procession volume obtained by averaging the concrete capsule
volumes. -/
noncomputable def processionVolume
    (M : MultiradialComponentFormula P (V := V)) : ℝ :=
  (∑ i : Fin P.length, M.capsuleVolume i) / (P.length : ℝ)

/-- Once the local component formula is proved, the full nonempty procession
volume is exactly the canonical local weighted sum. -/
theorem processionVolume_eq_local
    (M : MultiradialComponentFormula P (V := V))
    (hlen : 0 < P.length) :
    M.processionVolume =
      ∑ v, M.weight v * M.localContribution v := by
  classical
  rw [processionVolume]
  simp_rw [M.capsuleVolume_eq_local]
  have hne : (P.length : ℝ) ≠ 0 := by
    exact_mod_cast hlen.ne'
  simp [hne]

/-- The multiradial-to-local comparison error is therefore exactly zero. -/
noncomputable def comparisonError
    (M : MultiradialComponentFormula P (V := V)) : ℝ :=
  M.processionVolume -
    ∑ v, M.weight v * M.localContribution v

@[simp]
theorem comparisonError_eq_zero
    (M : MultiradialComponentFormula P (V := V))
    (hlen : 0 < P.length) :
    M.comparisonError = 0 := by
  rw [comparisonError, M.processionVolume_eq_local hlen]
  ring

end MultiradialComponentFormula

universe uR uS

/-- Canonical specialization where local places are primes over a fixed base
prime and weights are `e f / [S:R]`. -/
structure CanonicalMultiradialComponentFormula
    {R : Type uR} [CommRing R] [IsDomain R]
    {S : Type uS} [CommRing S] [Algebra R S]
    [Module.Finite R S] [Module.Flat R S]
    (p : Ideal R) [p.IsPrime] [Fintype (p.primesOver S)]
    (P : Iut.Procession ι) where
  coeff : ∀ i : Fin P.length, (P.capsule i).LabelType → ℝ
  coeff_sum_one : ∀ i, ∑ j, coeff i j = 1
  localContribution : p.primesOver S → ℝ
  componentVolume :
    ∀ i : Fin P.length,
      ((P.capsule i).LabelType → p.primesOver S) → ℝ
  componentVolume_eq : ∀ i c,
    componentVolume i c =
      ∑ j, coeff i j * localContribution (c j)

namespace CanonicalMultiradialComponentFormula

variable {R : Type uR} [CommRing R] [IsDomain R]
variable {S : Type uS} [CommRing S] [Algebra R S]
variable [Module.Finite R S] [Module.Flat R S]
variable {p : Ideal R} [p.IsPrime] [Fintype (p.primesOver S)]
variable {P : Iut.Procession ι}

/-- Forget to the abstract normalized-weight formula. -/
noncomputable def toFormula
    (M : CanonicalMultiradialComponentFormula p P)
    (hdeg : 0 < Module.finrank R S) :
    MultiradialComponentFormula P (V := p.primesOver S) where
  coeff := M.coeff
  coeff_sum_one := M.coeff_sum_one
  weight := canonicalLocalDegreeWeight p
  weight_sum_one := sum_canonicalLocalDegreeWeight_eq_one p hdeg
  localContribution := M.localContribution
  componentVolume := M.componentVolume
  componentVolume_eq := M.componentVolume_eq

/-- Exact multiradial packet comparison with canonical local-degree weights. -/
theorem processionVolume_eq_canonicalLocalSum
    (M : CanonicalMultiradialComponentFormula p P)
    (hdeg : 0 < Module.finrank R S)
    (hlen : 0 < P.length) :
    (M.toFormula hdeg).processionVolume =
      ∑ q : p.primesOver S,
        canonicalLocalDegreeWeight p q * M.localContribution q :=
  (M.toFormula hdeg).processionVolume_eq_local hlen

/-- Consequently its comparison error is exactly zero. -/
theorem comparisonError_eq_zero
    (M : CanonicalMultiradialComponentFormula p P)
    (hdeg : 0 < Module.finrank R S)
    (hlen : 0 < P.length) :
    (M.toFormula hdeg).comparisonError = 0 :=
  (M.toFormula hdeg).comparisonError_eq_zero hlen

end CanonicalMultiradialComponentFormula

end IUTThreeClosures
