/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCValuationIncidenceComplex20260903
import IUTThreeClosures.SynchronizedPacketRadicalExcessObstruction20260903

/-!
# Fixed-budget obstruction for the valuation-incidence complex

The ordinary proof appears first in
`research/ABC_VALUATION_INCIDENCE_FIXED_BUDGET_OBSTRUCTION_2026_09_03.md`.

The dyadic family `(2^(k+4), 3, 2^(k+4)+3)` gives a complete-premise
infinite obstruction to the original absolute-budget selector VIC-ABS-1.  Once
`k+3` exceeds a fixed `A`-defect budget, a budgeted face cannot select the
only `A`-prime `2`; its `A` modulus is therefore one.  Its `B` modulus divides
three, so the product of the two moduli cannot reconstruct `c`.

Only the absolute fixed-budget selector is refuted.  The labelled complex and
scale-sensitive, weighted, multi-face, or three-arm replacements remain open.
-/

namespace IUTThreeClosures
namespace ABCValuationIncidenceFixedBudgetObstruction20260903

open ABCValuationIncidenceComplex20260903

abbrev PrimitiveABC :=
  ABCValuationIncidenceComplex20260903.PrimitiveABC
abbrev Face (P : PrimitiveABC) :=
  ABCValuationIncidenceComplex20260903.Face P

/-- The strongest necessary condition used in the ordinary obstruction:
only the A budget and AB reconstruction are required. -/
def HasFixedAABReconstructingFace (P : PrimitiveABC) (t : ℕ) : Prop :=
  ∃ F : Face P, F.defectDegree .A ≤ t ∧ F.ABReconstructing

/-- The minimal fixed-budget reconstruction requirement used by VIC-ABS-1. -/
def HasFixedABReconstructingFace (P : PrimitiveABC) (t : ℕ) : Prop :=
  ∃ F : Face P,
    F.defectDegree .A ≤ t ∧ F.defectDegree .B ≤ t ∧ F.ABReconstructing

/-- The full pointwise selector proposed in the original VIC-ABS-1. -/
def HasVICABS1Face (P : PrimitiveABC) (m n t : ℕ) : Prop :=
  ∃ F : Face P,
    F.defectDegree .A ≤ t ∧
    F.defectDegree .B ≤ t ∧
    F.ABReconstructing ∧
    (ABCValuationIncidenceComplex20260903.Face.full P).armDefect .C ^ m ≤
      (F.armRadical .A * F.armRadical .B) ^ (m + n) *
        (ABCValuationIncidenceComplex20260903.Face.full P).armRadical .C ^ n

/-- All-but-finitely-many, absolute-budget form of VIC-ABS-1. -/
def AbsoluteBudgetVICABS1 (m n : ℕ) : Prop :=
  ∃ t : ℕ, {P : PrimitiveABC | ¬ HasVICABS1Face P m n t}.Finite

/-- Exact `A`-arm valuation in the dyadic family. -/
theorem dyadic_A_valuation_two (k : ℕ) :
    ABCValuationIncidenceComplex20260903.Face.valuation
      (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k)
      .A 2 = k + 4 := by
  simp only [ABCValuationIncidenceComplex20260903.Face.valuation,
    ABCValuationIncidenceComplex20260903.coordinate,
    SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum]
  rw [(by norm_num : Nat.Prime 2).factorization_pow]
  simp

/-- The dyadic `A` arm has only the prime `2`. -/
theorem dyadic_A_primeFactors (k : ℕ) :
    (ABCValuationIncidenceComplex20260903.coordinate
      (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k)
      .A).primeFactors =
      {2} := by
  simp only [ABCValuationIncidenceComplex20260903.coordinate,
    SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum]
  rw [Nat.primeFactors_prime_pow (by omega : k + 4 ≠ 0) Nat.prime_two]

/-- A face below a budget smaller than `k+3` must omit the only dyadic
`A`-prime. -/
theorem two_not_mem_A_of_defectDegree_le
    {k t : ℕ} (F : Face
      (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k))
    (hkt : t < k + 3) (hbudget : F.defectDegree .A ≤ t) :
    2 ∉ F.support .A := by
  intro htwo
  have hterm :
      ABCValuationIncidenceComplex20260903.Face.valuation
        (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k)
        .A 2 - 1 ≤
        F.defectDegree .A := by
    simp only [ABCValuationIncidenceComplex20260903.Face.defectDegree]
    exact Finset.single_le_sum
      (f := fun q =>
        ABCValuationIncidenceComplex20260903.Face.valuation
          (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k)
          .A q - 1)
      (fun q hq => Nat.zero_le _) htwo
  rw [dyadic_A_valuation_two] at hterm
  omega

/-- Consequently the selected dyadic `A` support is empty. -/
theorem A_support_eq_empty_of_defectDegree_le
    {k t : ℕ} (F : Face
      (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k))
    (hkt : t < k + 3) (hbudget : F.defectDegree .A ≤ t) :
    F.support .A = ∅ := by
  apply Finset.eq_empty_iff_forall_notMem.mpr
  intro p hp
  have hsubset : F.support .A ⊆ {2} := by
    simpa [dyadic_A_primeFactors k] using F.support_subset .A
  have hp2 : p = 2 := by simpa using hsubset hp
  subst p
  exact two_not_mem_A_of_defectDegree_le F hkt hbudget hp

/-- The fixed-budget face has trivial `A` modulus. -/
theorem A_armModulus_eq_one_of_defectDegree_le
    {k t : ℕ} (F : Face
      (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k))
    (hkt : t < k + 3) (hbudget : F.defectDegree .A ≤ t) :
    F.armModulus .A = 1 := by
  rw [ABCValuationIncidenceComplex20260903.Face.armModulus,
    A_support_eq_empty_of_defectDegree_le F hkt hbudget]
  simp

/-- Every selected `B` modulus in the fixed arm divides and hence is at most
three. -/
theorem B_armModulus_le_three
    {k : ℕ} (F : Face
      (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k)) :
    F.armModulus .B ≤ 3 := by
  have hdvd : F.armModulus .B ∣ 3 := by
    simpa [ABCValuationIncidenceComplex20260903.coordinate,
      SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum] using
      F.armModulus_dvd_coordinate
        ABCValuationIncidenceComplex20260903.Arm.B
  exact Nat.le_of_dvd (by norm_num) hdvd

/-- No face in the dyadic tail can combine even the single fixed A-defect
budget with the AB reconstruction window. -/
theorem dyadic_no_fixedA_ABReconstructing
    {k t : ℕ} (hkt : t < k + 3) :
    ¬ HasFixedAABReconstructingFace
      (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k)
      t := by
  rintro ⟨F, hA, hrec⟩
  have hMA := A_armModulus_eq_one_of_defectDegree_le F hkt hA
  have hMB := B_armModulus_le_three F
  have hcgt : 3 <
      (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k).c := by
    simp only [SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum]
    have hpow : 0 < 2 ^ (k + 4) := pow_pos (by norm_num) _
    omega
  unfold ABCValuationIncidenceComplex20260903.Face.ABReconstructing at hrec
  rw [hMA, one_mul] at hrec
  omega

/-- The original two-arm fixed-budget condition fails as an immediate
consequence of the stronger single-budget obstruction. -/
theorem dyadic_no_fixedBudget_ABReconstructing
    {k t : ℕ} (hkt : t < k + 3) :
    ¬ HasFixedABReconstructingFace
      (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k)
      t := by
  intro h
  apply dyadic_no_fixedA_ABReconstructing hkt
  rcases h with ⟨F, hA, _hB, hrec⟩
  exact ⟨F, hA, hrec⟩

/-- The stronger pointwise VIC-ABS-1 selector fails on the same tail, independently
of its rational-power parameters. -/
theorem dyadic_no_VICABS1Face (m n : ℕ) {k t : ℕ} (hkt : t < k + 3) :
    ¬ HasVICABS1Face
      (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum k)
      m n t := by
  intro h
  apply dyadic_no_fixedBudget_ABReconstructing hkt
  rcases h with ⟨F, hA, hB, hrec, _⟩
  exact ⟨F, hA, hB, hrec⟩

/-- The stronger single-A-budget reconstruction failure set is infinite for
every fixed budget. -/
theorem fixedA_reconstruction_failureSet_infinite (t : ℕ) :
    {P : PrimitiveABC | ¬ HasFixedAABReconstructingFace P t}.Infinite := by
  let f : ℕ → PrimitiveABC := fun j =>
    SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum (j + t)
  have hfinj : Function.Injective f := by
    intro j l h
    have hindex :=
      SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum_injective h
    omega
  have hrange : (Set.range f).Infinite :=
    Set.infinite_range_of_injective hfinj
  apply hrange.mono
  intro P hP
  rcases hP with ⟨j, rfl⟩
  change ¬ HasFixedAABReconstructingFace
    (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum
      (j + t)) t
  apply dyadic_no_fixedA_ABReconstructing
  omega

/-- For every absolute budget, the complete-premise failure set is infinite. -/
theorem fixedBudget_failureSet_infinite (m n t : ℕ) :
    {P : PrimitiveABC | ¬ HasVICABS1Face P m n t}.Infinite := by
  let f : ℕ → PrimitiveABC := fun j =>
    SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum (j + t)
  have hfinj : Function.Injective f := by
    intro j l h
    have hindex :=
      SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum_injective h
    omega
  have hrange : (Set.range f).Infinite :=
    Set.infinite_range_of_injective hfinj
  apply hrange.mono
  intro P hP
  rcases hP with ⟨j, rfl⟩
  change ¬ HasVICABS1Face
    (SynchronizedPacketRadicalExcessObstruction20260903.dyadicThreeDatum (j + t))
    m n t
  apply dyadic_no_VICABS1Face
  omega

/-- The original all-but-finitely-many selector VIC-ABS-1 is false at every pair
of rational-power parameters. -/
theorem not_absoluteBudgetVICABS1 (m n : ℕ) : ¬ AbsoluteBudgetVICABS1 m n := by
  rintro ⟨t, hfinite⟩
  exact (fixedBudget_failureSet_infinite m n t).not_finite hfinite

end ABCValuationIncidenceFixedBudgetObstruction20260903
end IUTThreeClosures
