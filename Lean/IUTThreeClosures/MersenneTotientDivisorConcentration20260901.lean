/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneWeightedOrderTail20260901
import Mathlib.RingTheory.Polynomial.Cyclotomic.Eval
import Mathlib.RingTheory.Polynomial.Cyclotomic.Roots

/-!
# Totient-weighted divisor concentration at the Mersenne endpoint

The mathematical proofs precede this file in
`research/ABC_MERSENNE_TOTIENT_DIVISOR_CONCENTRATION_2026_09_01.md`.

This module first formalizes the finite threshold inequalities and their
exact little-oh consequence.  It then proves the exact logarithmic-deficit
moment, its elementary `o(log m)` and `O(log log (3m))` bounds, and both fixed-
power and moving-window totient concentration.  The exact-order cyclotomic
divisibility is proved as well, giving the actual uniform canonical-block cap.
The final near-diagonal exceptional-mass estimate remains explicit; no
unproved distribution statement is inserted into the Lean kernel.
-/

namespace IUTThreeClosures
namespace MersenneTotientDivisorConcentration20260901

open Filter Asymptotics
open scoped BigOperators Topology
open MersenneOrderBlockAsymptotic20260901
open MersenneWeightedOrderTail20260901

/-- Totient weight of those divisors on which `mass` exceeds a fixed
multiple of Euler's totient. -/
noncomputable def totientExceptionalDivisorMass
    (mass : ℕ → ℝ) (threshold : ℝ) (m : ℕ) : ℝ :=
  ∑ d ∈ m.divisors with
    threshold * (Nat.totient d : ℝ) < mass d,
    (Nat.totient d : ℝ)

/-- The threshold times the exceptional totient weight is bounded by the
full divisor mass. -/
theorem threshold_mul_totientExceptionalDivisorMass_le
    (mass : ℕ → ℝ) (threshold : ℝ) (m : ℕ)
    (hmass : ∀ d, 0 ≤ mass d) :
    threshold * totientExceptionalDivisorMass mass threshold m ≤
      divisorOrderBlockMassSum mass m := by
  classical
  unfold totientExceptionalDivisorMass divisorOrderBlockMassSum
  calc
    threshold *
          (∑ d ∈ m.divisors with
            threshold * (Nat.totient d : ℝ) < mass d,
            (Nat.totient d : ℝ)) =
        ∑ d ∈ m.divisors with
          threshold * (Nat.totient d : ℝ) < mass d,
          threshold * (Nat.totient d : ℝ) := by
            rw [Finset.mul_sum]
    _ ≤ ∑ d ∈ m.divisors with
          threshold * (Nat.totient d : ℝ) < mass d,
          mass d := by
            apply Finset.sum_le_sum
            intro d hd
            exact (Finset.mem_filter.mp hd).2.le
    _ ≤ ∑ d ∈ m.divisors, mass d := by
            apply Finset.sum_le_sum_of_subset_of_nonneg
              (Finset.filter_subset _ _)
            intro d _ _
            exact hmass d

#print axioms threshold_mul_totientExceptionalDivisorMass_le

/-- Under a uniform `cap * phi(d)` bound, the full divisor mass is at most
the light threshold contribution plus the capped exceptional contribution.
-/
theorem divisorOrderBlockMassSum_le_threshold_add_exceptional
    (mass : ℕ → ℝ) (threshold cap : ℝ) (m : ℕ)
    (hthreshold : 0 ≤ threshold)
    (hcap : ∀ d, mass d ≤ cap * (Nat.totient d : ℝ)) :
    divisorOrderBlockMassSum mass m ≤
      threshold * (m : ℝ) +
        cap * totientExceptionalDivisorMass mass threshold m := by
  classical
  let bad : ℕ → Prop :=
    fun d => threshold * (Nat.totient d : ℝ) < mass d
  have hbad :
      (∑ d ∈ m.divisors with bad d, mass d) ≤
        cap * ∑ d ∈ m.divisors with bad d,
          (Nat.totient d : ℝ) := by
    calc
      (∑ d ∈ m.divisors with bad d, mass d) ≤
          ∑ d ∈ m.divisors with bad d,
            cap * (Nat.totient d : ℝ) := by
              apply Finset.sum_le_sum
              intro d _
              exact hcap d
      _ = cap * ∑ d ∈ m.divisors with bad d,
            (Nat.totient d : ℝ) := by
              rw [Finset.mul_sum]
  have hgood :
      (∑ d ∈ m.divisors with ¬ bad d, mass d) ≤
        threshold * ∑ d ∈ m.divisors with ¬ bad d,
          (Nat.totient d : ℝ) := by
    calc
      (∑ d ∈ m.divisors with ¬ bad d, mass d) ≤
          ∑ d ∈ m.divisors with ¬ bad d,
            threshold * (Nat.totient d : ℝ) := by
              apply Finset.sum_le_sum
              intro d hd
              exact le_of_not_gt (Finset.mem_filter.mp hd).2
      _ = threshold * ∑ d ∈ m.divisors with ¬ bad d,
            (Nat.totient d : ℝ) := by
              rw [Finset.mul_sum]
  have hgoodTotient :
      threshold *
          (∑ d ∈ m.divisors with ¬ bad d,
            (Nat.totient d : ℝ)) ≤ threshold * (m : ℝ) := by
    apply mul_le_mul_of_nonneg_left _ hthreshold
    calc
      (∑ d ∈ m.divisors with ¬ bad d,
          (Nat.totient d : ℝ)) ≤
          ∑ d ∈ m.divisors, (Nat.totient d : ℝ) := by
            apply Finset.sum_le_sum_of_subset_of_nonneg
              (Finset.filter_subset _ _)
            intro d _ _
            positivity
      _ = (m : ℝ) := by
            exact_mod_cast Nat.sum_totient m
  unfold divisorOrderBlockMassSum totientExceptionalDivisorMass
  change (∑ d ∈ m.divisors, mass d) ≤
    threshold * (m : ℝ) +
      cap * ∑ d ∈ m.divisors with bad d,
        (Nat.totient d : ℝ)
  rw [← Finset.sum_filter_add_sum_filter_not
    m.divisors bad mass]
  linarith

#print axioms divisorOrderBlockMassSum_le_threshold_add_exceptional

/-- Exceptional totient masses are nonnegative. -/
theorem totientExceptionalDivisorMass_nonneg
    (mass : ℕ → ℝ) (threshold : ℝ) (m : ℕ) :
    0 ≤ totientExceptionalDivisorMass mass threshold m := by
  classical
  unfold totientExceptionalDivisorMass
  exact Finset.sum_nonneg fun d _ => by positivity

#print axioms totientExceptionalDivisorMass_nonneg

/-- The total divisor mass is nonnegative when the point masses are. -/
theorem divisorOrderBlockMassSum_nonneg
    (mass : ℕ → ℝ) (hmass : ∀ d, 0 ≤ mass d) (m : ℕ) :
    0 ≤ divisorOrderBlockMassSum mass m := by
  classical
  unfold divisorOrderBlockMassSum
  exact Finset.sum_nonneg fun d _ => hmass d

#print axioms divisorOrderBlockMassSum_nonneg

/-! ## Exact asymptotic threshold criterion -/

/-- Little-oh of the full nonnegative divisor mass forces little-oh of every
fixed positive-threshold exceptional totient mass. -/
theorem totientExceptionalDivisorMass_isLittleO_of_divisorMass
    (mass : ℕ → ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (threshold : ℝ) (hthreshold : 0 < threshold)
    (htotal : divisorOrderBlockMassSum mass =o[atTop]
      (fun m : ℕ => (m : ℝ))) :
    (fun m => totientExceptionalDivisorMass mass threshold m) =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  rw [isLittleO_iff]
  intro c hc
  have hcoefficient : 0 < c * threshold := mul_pos hc hthreshold
  filter_upwards [htotal.bound hcoefficient] with m hm
  have htotalNonneg : 0 ≤ divisorOrderBlockMassSum mass m :=
    divisorOrderBlockMassSum_nonneg mass hmass m
  have hexceptionalNonneg :
      0 ≤ totientExceptionalDivisorMass mass threshold m :=
    totientExceptionalDivisorMass_nonneg mass threshold m
  have hlower := threshold_mul_totientExceptionalDivisorMass_le
    mass threshold m hmass
  rw [Real.norm_eq_abs, abs_of_nonneg htotalNonneg,
    Real.norm_eq_abs, abs_of_nonneg (by positivity : (0 : ℝ) ≤ m)] at hm
  rw [Real.norm_eq_abs, abs_of_nonneg hexceptionalNonneg,
    Real.norm_eq_abs, abs_of_nonneg (by positivity : (0 : ℝ) ≤ m)]
  nlinarith

#print axioms totientExceptionalDivisorMass_isLittleO_of_divisorMass

/-- If every fixed positive threshold has negligible exceptional totient
weight, then a uniformly totient-bounded nonnegative mass has negligible
divisor average. -/
theorem divisorOrderBlockMassSum_isLittleO_of_exceptionalTotientMass
    (mass : ℕ → ℝ) (cap : ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (hcapNonneg : 0 ≤ cap)
    (hcap : ∀ d, mass d ≤ cap * (Nat.totient d : ℝ))
    (hexceptional : ∀ threshold : ℝ, 0 < threshold →
      (fun m => totientExceptionalDivisorMass mass threshold m) =o[atTop]
        (fun m : ℕ => (m : ℝ))) :
    divisorOrderBlockMassSum mass =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  rw [isLittleO_iff]
  intro c hc
  let threshold : ℝ := c / 2
  let coefficient : ℝ := c / (2 * (cap + 1))
  have hcapPlus : 0 < cap + 1 := by linarith
  have hthreshold : 0 < threshold := by
    dsimp [threshold]
    positivity
  have hcoefficient : 0 < coefficient := by
    dsimp [coefficient]
    positivity
  have hcapCoefficient : cap * coefficient ≤ c / 2 := by
    have hratio : cap / (cap + 1) ≤ 1 := by
      exact (div_le_one hcapPlus).2 (by linarith)
    calc
      cap * coefficient = (c / 2) * (cap / (cap + 1)) := by
        dsimp [coefficient]
        field_simp
      _ ≤ (c / 2) * 1 := by
        exact mul_le_mul_of_nonneg_left hratio (by positivity)
      _ = c / 2 := mul_one _
  filter_upwards [(hexceptional threshold hthreshold).bound hcoefficient]
      with m hm
  have htotalNonneg : 0 ≤ divisorOrderBlockMassSum mass m :=
    divisorOrderBlockMassSum_nonneg mass hmass m
  have hexceptionalNonneg :
      0 ≤ totientExceptionalDivisorMass mass threshold m :=
    totientExceptionalDivisorMass_nonneg mass threshold m
  have hexceptionalBound :
      totientExceptionalDivisorMass mass threshold m ≤
        coefficient * (m : ℝ) := by
    simpa [Real.norm_eq_abs, abs_of_nonneg hexceptionalNonneg,
      abs_of_nonneg (by positivity : (0 : ℝ) ≤ m)] using hm
  have hcapExceptional :
      cap * totientExceptionalDivisorMass mass threshold m ≤
        (c / 2) * (m : ℝ) := by
    calc
      cap * totientExceptionalDivisorMass mass threshold m ≤
          cap * (coefficient * (m : ℝ)) :=
        mul_le_mul_of_nonneg_left hexceptionalBound hcapNonneg
      _ = (cap * coefficient) * (m : ℝ) := by ring
      _ ≤ (c / 2) * (m : ℝ) :=
        mul_le_mul_of_nonneg_right hcapCoefficient (by positivity)
  have htotalBound := divisorOrderBlockMassSum_le_threshold_add_exceptional
    mass threshold cap m hthreshold.le hcap
  rw [Real.norm_eq_abs, abs_of_nonneg htotalNonneg,
    Real.norm_eq_abs, abs_of_nonneg (by positivity : (0 : ℝ) ≤ m)]
  dsimp [threshold] at htotalBound
  linarith

#print axioms divisorOrderBlockMassSum_isLittleO_of_exceptionalTotientMass

/-- Exact bounded-convergence criterion for divisor averages: a uniformly
totient-bounded nonnegative mass has total `o(m)` exactly when every fixed
positive normalized-excess set has totient weight `o(m)`. -/
theorem divisorOrderBlockMassSum_isLittleO_iff_exceptionalTotientMass
    (mass : ℕ → ℝ) (cap : ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (hcapNonneg : 0 ≤ cap)
    (hcap : ∀ d, mass d ≤ cap * (Nat.totient d : ℝ)) :
    (divisorOrderBlockMassSum mass =o[atTop]
        (fun m : ℕ => (m : ℝ))) ↔
      (∀ threshold : ℝ, 0 < threshold →
        (fun m => totientExceptionalDivisorMass mass threshold m) =o[atTop]
          (fun m : ℕ => (m : ℝ))) := by
  constructor
  · intro htotal threshold hthreshold
    exact totientExceptionalDivisorMass_isLittleO_of_divisorMass
      mass hmass threshold hthreshold htotal
  · intro hexceptional
    exact divisorOrderBlockMassSum_isLittleO_of_exceptionalTotientMass
      mass cap hmass hcapNonneg hcap hexceptional

#print axioms divisorOrderBlockMassSum_isLittleO_iff_exceptionalTotientMass

/-! ## Localization to a moving divisor region -/

/-- Divisor mass restricted by a predicate that may depend on the ambient
index and on the divisor. -/
noncomputable def restrictedDivisorMass
    (mass : ℕ → ℝ) (region : ℕ → ℕ → Prop) (m : ℕ) : ℝ :=
  by
    classical
    exact ∑ d ∈ m.divisors with region m d, mass d

/-- Totient weight restricted by a moving divisor predicate. -/
noncomputable def restrictedTotientDivisorMass
    (region : ℕ → ℕ → Prop) (m : ℕ) : ℝ :=
  restrictedDivisorMass (fun d => (Nat.totient d : ℝ)) region m

/-- Exceptional totient weight restricted by a moving divisor predicate. -/
noncomputable def restrictedExceptionalTotientDivisorMass
    (mass : ℕ → ℝ) (threshold : ℝ)
    (region : ℕ → ℕ → Prop) (m : ℕ) : ℝ :=
  by
    classical
    exact ∑ d ∈ m.divisors with
        region m d ∧ threshold * (Nat.totient d : ℝ) < mass d,
      (Nat.totient d : ℝ)

/-- Restricted divisor masses inherit a pointwise totient cap. -/
theorem restrictedDivisorMass_le_cap_totient
    (mass : ℕ → ℝ) (region : ℕ → ℕ → Prop) (cap : ℝ) (m : ℕ)
    (hcap : ∀ d, mass d ≤ cap * (Nat.totient d : ℝ)) :
    restrictedDivisorMass mass region m ≤
      cap * restrictedTotientDivisorMass region m := by
  classical
  simp only [restrictedTotientDivisorMass, restrictedDivisorMass]
  calc
    (∑ d ∈ m.divisors with region m d, mass d) ≤
        ∑ d ∈ m.divisors with region m d,
          cap * (Nat.totient d : ℝ) := by
            apply Finset.sum_le_sum
            intro d _
            exact hcap d
    _ = cap * ∑ d ∈ m.divisors with region m d,
          (Nat.totient d : ℝ) := by
            rw [Finset.mul_sum]

#print axioms restrictedDivisorMass_le_cap_totient

/-- A nonnegative function dominated pointwise by another nonnegative
little-oh function is little-oh at the same scale. -/
theorem isLittleO_natCast_of_nonneg_le
    (f g : ℕ → ℝ)
    (hf : ∀ m, 0 ≤ f m) (hg : ∀ m, 0 ≤ g m)
    (hfg : ∀ m, f m ≤ g m)
    (hgLittleO : g =o[atTop] (fun m : ℕ => (m : ℝ))) :
    f =o[atTop] (fun m : ℕ => (m : ℝ)) := by
  rw [isLittleO_iff]
  intro c hc
  filter_upwards [hgLittleO.bound hc] with m hm
  rw [Real.norm_eq_abs, abs_of_nonneg (hf m),
    Real.norm_eq_abs, abs_of_nonneg (by positivity : (0 : ℝ) ≤ m)]
  have hm' : g m ≤ c * (m : ℝ) := by
    simpa [Real.norm_eq_abs, abs_of_nonneg (hg m),
      abs_of_nonneg (by positivity : (0 : ℝ) ≤ m)] using hm
  exact (hfg m).trans hm'

#print axioms isLittleO_natCast_of_nonneg_le

/-- A restricted mass is `o(m)` whenever its restricted totient weight is
`o(m)` and it obeys one uniform totient cap. -/
theorem restrictedDivisorMass_isLittleO_of_totient
    (mass : ℕ → ℝ) (region : ℕ → ℕ → Prop) (cap : ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (hcapNonneg : 0 ≤ cap)
    (hcap : ∀ d, mass d ≤ cap * (Nat.totient d : ℝ))
    (htotient : restrictedTotientDivisorMass region =o[atTop]
      (fun m : ℕ => (m : ℝ))) :
    restrictedDivisorMass mass region =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  apply isLittleO_natCast_of_nonneg_le
      (restrictedDivisorMass mass region)
      (fun m => cap * restrictedTotientDivisorMass region m)
  · intro m
    classical
    unfold restrictedDivisorMass
    exact Finset.sum_nonneg fun d _ => hmass d
  · intro m
    apply mul_nonneg hcapNonneg
    classical
    unfold restrictedTotientDivisorMass restrictedDivisorMass
    exact Finset.sum_nonneg fun d _ => by positivity
  · intro m
    exact restrictedDivisorMass_le_cap_totient
      mass region cap m hcap
  · exact htotient.const_mul_left cap

#print axioms restrictedDivisorMass_isLittleO_of_totient

/-- The exceptional totient mass splits exactly into a chosen moving region
and its complement. -/
theorem totientExceptionalDivisorMass_eq_restricted_add_complement
    (mass : ℕ → ℝ) (threshold : ℝ)
    (region : ℕ → ℕ → Prop) (m : ℕ) :
    totientExceptionalDivisorMass mass threshold m =
      restrictedExceptionalTotientDivisorMass
        mass threshold region m +
      restrictedExceptionalTotientDivisorMass
        mass threshold (fun n d => ¬ region n d) m := by
  classical
  let exceptional : ℕ → Prop :=
    fun d => threshold * (Nat.totient d : ℝ) < mass d
  let weighted : ℕ → ℝ := fun d => (Nat.totient d : ℝ)
  simpa only [totientExceptionalDivisorMass,
      restrictedExceptionalTotientDivisorMass,
      Finset.filter_filter, exceptional, weighted, and_comm,
      and_left_comm, and_assoc] using
    (Finset.sum_filter_add_sum_filter_not
      (m.divisors.filter exceptional) (region m) weighted).symm

#print axioms totientExceptionalDivisorMass_eq_restricted_add_complement

/-- Restricted exceptional weight is bounded by the full totient weight of
the same region. -/
theorem restrictedExceptionalTotientDivisorMass_le_restrictedTotient
    (mass : ℕ → ℝ) (threshold : ℝ)
    (region : ℕ → ℕ → Prop) (m : ℕ) :
    restrictedExceptionalTotientDivisorMass mass threshold region m ≤
      restrictedTotientDivisorMass region m := by
  classical
  unfold restrictedExceptionalTotientDivisorMass
    restrictedTotientDivisorMass restrictedDivisorMass
  apply Finset.sum_le_sum_of_subset_of_nonneg
  · intro d hd
    have hd' := Finset.mem_filter.mp hd
    exact Finset.mem_filter.mpr ⟨hd'.1, hd'.2.1⟩
  · intro d _ _
    positivity

#print axioms restrictedExceptionalTotientDivisorMass_le_restrictedTotient

/-- Restricting an exceptional set by any moving region can only decrease
its totient weight. -/
theorem restrictedExceptionalTotientDivisorMass_le_total
    (mass : ℕ → ℝ) (threshold : ℝ)
    (region : ℕ → ℕ → Prop) (m : ℕ) :
    restrictedExceptionalTotientDivisorMass mass threshold region m ≤
      totientExceptionalDivisorMass mass threshold m := by
  classical
  unfold restrictedExceptionalTotientDivisorMass
    totientExceptionalDivisorMass
  apply Finset.sum_le_sum_of_subset_of_nonneg
  · intro d hd
    have hd' := Finset.mem_filter.mp hd
    exact Finset.mem_filter.mpr ⟨hd'.1, hd'.2.2⟩
  · intro d _ _
    positivity

#print axioms restrictedExceptionalTotientDivisorMass_le_total

/-- Localized sufficient criterion.  If one moving region has negligible total
totient weight, it may be discarded unconditionally; on the complement it
suffices to control only the normalized-large exceptional divisors. -/
theorem divisorOrderBlockMassSum_isLittleO_of_localizedExceptional
    (mass : ℕ → ℝ) (region : ℕ → ℕ → Prop) (cap : ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (hcapNonneg : 0 ≤ cap)
    (hcap : ∀ d, mass d ≤ cap * (Nat.totient d : ℝ))
    (hregion : restrictedTotientDivisorMass region =o[atTop]
      (fun m : ℕ => (m : ℝ)))
    (hcomplement : ∀ threshold : ℝ, 0 < threshold →
      (fun m => restrictedExceptionalTotientDivisorMass
        mass threshold (fun n d => ¬ region n d) m) =o[atTop]
          (fun m : ℕ => (m : ℝ))) :
    divisorOrderBlockMassSum mass =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  apply divisorOrderBlockMassSum_isLittleO_of_exceptionalTotientMass
    mass cap hmass hcapNonneg hcap
  intro threshold hthreshold
  have hrestricted :
      (fun m => restrictedExceptionalTotientDivisorMass
        mass threshold region m) =o[atTop]
          (fun m : ℕ => (m : ℝ)) := by
    apply isLittleO_natCast_of_nonneg_le
        (fun m => restrictedExceptionalTotientDivisorMass
          mass threshold region m)
        (restrictedTotientDivisorMass region)
    · intro m
      classical
      unfold restrictedExceptionalTotientDivisorMass
      exact Finset.sum_nonneg fun d _ => by positivity
    · intro m
      classical
      unfold restrictedTotientDivisorMass restrictedDivisorMass
      exact Finset.sum_nonneg fun d _ => by positivity
    · intro m
      exact restrictedExceptionalTotientDivisorMass_le_restrictedTotient
        mass threshold region m
    · exact hregion
  have hadd := hrestricted.add (hcomplement threshold hthreshold)
  apply hadd.congr
  · intro m
    exact (totientExceptionalDivisorMass_eq_restricted_add_complement
      mass threshold region m).symm
  · intro _
    rfl

#print axioms divisorOrderBlockMassSum_isLittleO_of_localizedExceptional

/-- Exact localized criterion once the discarded moving region has
negligible totient weight.  This supplies both the necessary and sufficient
directions of the paper's near-diagonal gate. -/
theorem divisorOrderBlockMassSum_isLittleO_iff_localizedExceptional
    (mass : ℕ → ℝ) (region : ℕ → ℕ → Prop) (cap : ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (hcapNonneg : 0 ≤ cap)
    (hcap : ∀ d, mass d ≤ cap * (Nat.totient d : ℝ))
    (hregion : restrictedTotientDivisorMass region =o[atTop]
      (fun m : ℕ => (m : ℝ))) :
    (divisorOrderBlockMassSum mass =o[atTop]
        (fun m : ℕ => (m : ℝ))) ↔
      (∀ threshold : ℝ, 0 < threshold →
        (fun m => restrictedExceptionalTotientDivisorMass
          mass threshold (fun n d => ¬ region n d) m) =o[atTop]
            (fun m : ℕ => (m : ℝ))) := by
  constructor
  · intro htotal threshold hthreshold
    have hglobal :=
      (divisorOrderBlockMassSum_isLittleO_iff_exceptionalTotientMass
        mass cap hmass hcapNonneg hcap).mp htotal threshold hthreshold
    apply isLittleO_natCast_of_nonneg_le
      (fun m => restrictedExceptionalTotientDivisorMass
        mass threshold (fun n d => ¬ region n d) m)
      (fun m => totientExceptionalDivisorMass mass threshold m)
    · intro m
      classical
      unfold restrictedExceptionalTotientDivisorMass
      exact Finset.sum_nonneg fun d _ => by positivity
    · intro m
      exact totientExceptionalDivisorMass_nonneg mass threshold m
    · intro m
      exact restrictedExceptionalTotientDivisorMass_le_total
        mass threshold (fun n d => ¬ region n d) m
    · exact hglobal
  · intro hcomplement
    exact divisorOrderBlockMassSum_isLittleO_of_localizedExceptional
      mass region cap hmass hcapNonneg hcap hregion hcomplement

#print axioms divisorOrderBlockMassSum_isLittleO_iff_localizedExceptional

/-! ## Unconditional cyclotomic cap for actual order blocks -/

open Polynomial
open MersenneOrderBlockAsymptotic20260901


/-- The positive natural value `Phi_d(2)`. -/
noncomputable def mersenneCyclotomicValue (d : ℕ) : ℕ :=
  ((cyclotomic d ℤ).eval (2 : ℤ)).natAbs

/-- Evaluation at two is positive already over the integers. -/
theorem cyclotomic_eval_two_int_pos (d : ℕ) :
    0 < (cyclotomic d ℤ).eval (2 : ℤ) := by
  exact cyclotomic_pos' d (by norm_num)

/-- The natural value casts to the real cyclotomic evaluation. -/
theorem coe_mersenneCyclotomicValue_eq_eval_real (d : ℕ) :
    (mersenneCyclotomicValue d : ℝ) =
      (cyclotomic d ℝ).eval (2 : ℝ) := by
  let z : ℤ := (cyclotomic d ℤ).eval (2 : ℤ)
  have hpos : 0 ≤ z := by
    dsimp [z]
    exact
    (cyclotomic_eval_two_int_pos d).le
  have habs : (z.natAbs : ℤ) = z := Int.natAbs_of_nonneg hpos
  have habsReal : (z.natAbs : ℝ) = (z : ℝ) := by
    simpa using congrArg (Int.castRingHom ℝ) habs
  unfold mersenneCyclotomicValue
  calc
    ((((cyclotomic d ℤ).eval (2 : ℤ)).natAbs : ℕ) : ℝ) = (z.natAbs : ℝ) := by
      rfl
    _ = (z : ℝ) := habsReal
    _ = (cyclotomic d ℝ).eval (2 : ℝ) := by
      dsimp [z]
      symm
      simpa using
        (Polynomial.cyclotomic.eval_apply (2 : ℤ) d (Int.castRingHom ℝ))

/-- The natural cyclotomic value is strictly positive. -/
theorem mersenneCyclotomicValue_pos (d : ℕ) :
    0 < mersenneCyclotomicValue d := by
  unfold mersenneCyclotomicValue
  exact Int.natAbs_pos.mpr (cyclotomic_eval_two_int_pos d).ne'

open MersenneOrderBlockDecomposition20260901

/-- A prime divisor of the integral cyclotomic value makes two a root of
the corresponding cyclotomic polynomial modulo that prime. -/
theorem isRoot_cyclotomic_two_of_prime_dvd_value
    {e p : ℕ} (_hp : p.Prime) (hdiv : p ∣ mersenneCyclotomicValue e) :
    (cyclotomic e (ZMod p)).IsRoot (2 : ZMod p) := by
  have hpInt : (p : ℤ) ∣ (cyclotomic e ℤ).eval (2 : ℤ) := by
    exact Int.natCast_dvd.mpr hdiv
  have hzero :
      (((cyclotomic e ℤ).eval (2 : ℤ) : ℤ) : ZMod p) = 0 :=
    (ZMod.intCast_zmod_eq_zero_iff_dvd _ _).2 hpInt
  rw [Polynomial.IsRoot.def]
  calc
    (cyclotomic e (ZMod p)).eval (2 : ZMod p) =
        (((cyclotomic e ℤ).eval (2 : ℤ) : ℤ) : ZMod p) := by
      simpa using
        (Polynomial.cyclotomic.eval_apply (2 : ℤ) e
          (Int.castRingHom (ZMod p)))
    _ = 0 := hzero

/-- Away from the characteristic, a prime divisor of `Phi_e(2)` has
exact multiplicative order `e`. -/
theorem mersenneExactOrder_eq_of_prime_dvd_cyclotomicValue
    {e p : ℕ} (hp : p.Prime) (hpe : ¬ p ∣ e)
    (hdiv : p ∣ mersenneCyclotomicValue e) :
    mersenneExactOrder p = e := by
  letI : Fact p.Prime := ⟨hp⟩
  have heCast : (e : ZMod p) ≠ 0 := by
    simpa [ZMod.natCast_eq_zero_iff] using hpe
  letI : NeZero (e : ZMod p) := ⟨heCast⟩
  have hprimitive : IsPrimitiveRoot (2 : ZMod p) e :=
    Polynomial.isRoot_cyclotomic_iff.mp
      (isRoot_cyclotomic_two_of_prime_dvd_value hp hdiv)
  unfold mersenneExactOrder
  exact hprimitive.eq_orderOf.symm

/-- Evaluating the standard cyclotomic product identity and taking absolute
values gives a natural factorization of the Mersenne value. -/
theorem prod_mersenneCyclotomicValue_divisors_eq
    {d : ℕ} (hd : 0 < d) :
    (∏ e ∈ d.divisors, mersenneCyclotomicValue e) = 2 ^ d - 1 := by
  have hpoly := Polynomial.prod_cyclotomic_eq_X_pow_sub_one hd ℤ
  have heval := congrArg (fun P : ℤ[X] => P.eval (2 : ℤ)) hpoly
  simp only [Polynomial.eval_prod, Polynomial.eval_sub, Polynomial.eval_pow,
    Polynomial.eval_X, Polynomial.eval_one] at heval
  have habs := congrArg Int.natAbs heval
  have hright : ((2 : ℤ) ^ d - 1).natAbs = 2 ^ d - 1 := by
    have hone : 1 ≤ 2 ^ d := one_le_pow₀ (by norm_num)
    have hcast : (2 : ℤ) ^ d - 1 = ((2 ^ d - 1 : ℕ) : ℤ) := by
      rw [Nat.cast_sub hone]
      norm_num
    rw [hcast, Int.natAbs_natCast]
  have hleft :
      (∏ j ∈ d.divisors, (cyclotomic j ℤ).eval (2 : ℤ)).natAbs =
        ∏ j ∈ d.divisors, ((cyclotomic j ℤ).eval (2 : ℤ)).natAbs := by
    exact
      (map_prod Int.natAbsHom
        (fun j => (cyclotomic j ℤ).eval (2 : ℤ)) d.divisors)
  rw [hleft, hright] at habs
  simpa [mersenneCyclotomicValue, hright] using habs

/-- For a prime in the exact-order `d` fibre, its full multiplicity in
`2^d-1` is already carried by `Phi_d(2)`.  The proof uses only the
cyclotomic product identity and the fact that, away from the characteristic,
a root of `Phi_e` has exact order `e`. -/
theorem exactOrder_prime_fullPower_dvd_cyclotomicValue
    {d p : ℕ} (hd : 0 < d)
    (hpFiber : p ∈ (2 ^ d - 1).primeFactors.filter
      (fun p => mersenneExactOrder p = d)) :
    p ^ ((2 ^ d - 1).factorization p) ∣ mersenneCyclotomicValue d := by
  classical
  have hpMem : p ∈ (2 ^ d - 1).primeFactors :=
    (Finset.mem_filter.mp hpFiber).1
  have hpOrder : mersenneExactOrder p = d :=
    (Finset.mem_filter.mp hpFiber).2
  have hp : p.Prime := Nat.prime_of_mem_primeFactors hpMem
  have hpDvd : p ∣ 2 ^ d - 1 := Nat.dvd_of_mem_primeFactors hpMem
  have hpNotDvdD : ¬ p ∣ d := by
    have h := prime_not_dvd_mersenneExactOrder hd hp hpDvd
    simpa [hpOrder] using h
  let other : ℕ :=
    ∏ e ∈ d.divisors.erase d, mersenneCyclotomicValue e
  have hcoprime : p.Coprime other := by
    dsimp [other]
    apply Nat.Coprime.prod_right
    intro e he
    apply hp.coprime_iff_not_dvd.mpr
    intro hpValue
    have heDivMem : e ∈ d.divisors := (Finset.mem_erase.mp he).2
    have heDvdD : e ∣ d := Nat.dvd_of_mem_divisors heDivMem
    have hpNotDvdE : ¬ p ∣ e := by
      intro hpE
      exact hpNotDvdD (hpE.trans heDvdD)
    have horderE : mersenneExactOrder p = e :=
      mersenneExactOrder_eq_of_prime_dvd_cyclotomicValue
        hp hpNotDvdE hpValue
    have heEq : e = d := horderE.symm.trans hpOrder
    exact (Finset.mem_erase.mp he).1 heEq
  have hdMem : d ∈ d.divisors :=
    Nat.mem_divisors.mpr ⟨dvd_rfl, hd.ne'⟩
  have hdecomp : other * mersenneCyclotomicValue d = 2 ^ d - 1 := by
    calc
      other * mersenneCyclotomicValue d =
          ∏ e ∈ d.divisors, mersenneCyclotomicValue e := by
        exact Finset.prod_erase_mul d.divisors mersenneCyclotomicValue hdMem
      _ = 2 ^ d - 1 := prod_mersenneCyclotomicValue_divisors_eq hd
  have hpowBase :
      p ^ ((2 ^ d - 1).factorization p) ∣ 2 ^ d - 1 :=
    (hp.pow_dvd_iff_le_factorization (mersenne_sub_one_pos hd).ne').2 le_rfl
  have hpowProduct :
      p ^ ((2 ^ d - 1).factorization p) ∣
        other * mersenneCyclotomicValue d := by
    rw [hdecomp]
    exact hpowBase
  exact (hcoprime.pow_left ((2 ^ d - 1).factorization p)).dvd_of_dvd_mul_left
    hpowProduct

/-- The repository's canonical exact-order block divides the positive
cyclotomic value at every positive index. -/
theorem mersenneCanonicalOrderBlock_dvd_cyclotomicValue
    {d : ℕ} (hd : 0 < d) :
    mersenneCanonicalOrderBlock d ∣ mersenneCyclotomicValue d := by
  classical
  unfold mersenneCanonicalOrderBlock
  rw [← Int.natCast_dvd_natCast]
  push_cast
  apply Finset.prod_dvd_of_coprime
  · rintro p hpMem q hqMem hpq
    have hpPrime : p.Prime := Nat.prime_of_mem_primeFactors
      (Finset.mem_filter.mp hpMem).1
    have hqPrime : q.Prime := Nat.prime_of_mem_primeFactors
      (Finset.mem_filter.mp hqMem).1
    have hpqCoprime : p.Coprime q :=
      (Nat.coprime_primes hpPrime hqPrime).mpr hpq
    exact (hpqCoprime.cast (R := ℤ)).pow
  · intro p hpMem
    have hfull := exactOrder_prime_fullPower_dvd_cyclotomicValue hd hpMem
    exact_mod_cast
      ((pow_dvd_pow p (Nat.sub_le ((2 ^ d - 1).factorization p) 1)).trans
        hfull)

/-- Mathlib's root-product estimate gives the exact natural cap
`Phi_d(2) <= 3^phi(d)`. -/
theorem mersenneCyclotomicValue_le_three_pow_totient (d : ℕ) :
    mersenneCyclotomicValue d ≤ 3 ^ Nat.totient d := by
  have hreal := Polynomial.cyclotomic_eval_le_add_one_pow_totient
    (n := d) (q := (2 : ℝ)) (by norm_num)
  rw [← coe_mersenneCyclotomicValue_eq_eval_real] at hreal
  exact_mod_cast hreal

/-- Any positive natural divisor of `Phi_d(2)` satisfies the desired
logarithmic cap. -/
theorem log_le_log_three_mul_totient_of_dvd_cyclotomicValue
    {E d : ℕ} (hE : 0 < E) (hdiv : E ∣ mersenneCyclotomicValue d) :
    Real.log (E : ℝ) ≤ Real.log 3 * (Nat.totient d : ℝ) := by
  have hEleNat : E ≤ 3 ^ Nat.totient d :=
    (Nat.le_of_dvd (mersenneCyclotomicValue_pos d) hdiv).trans
      (mersenneCyclotomicValue_le_three_pow_totient d)
  have hEle : (E : ℝ) ≤ ((3 ^ Nat.totient d : ℕ) : ℝ) := by
    exact_mod_cast hEleNat
  have hEreal : 0 < (E : ℝ) := by exact_mod_cast hE
  have hthreePow : 0 < (((3 ^ Nat.totient d : ℕ) : ℕ) : ℝ) := by
    positivity
  calc
    Real.log (E : ℝ) ≤ Real.log (((3 ^ Nat.totient d : ℕ) : ℕ) : ℝ) :=
      Real.strictMonoOn_log.monotoneOn hEreal hthreePow hEle
    _ = (Nat.totient d : ℝ) * Real.log 3 := by
      rw [Nat.cast_pow, Nat.cast_ofNat, Real.log_pow]
    _ = Real.log 3 * (Nat.totient d : ℝ) := by ring

/-- Generic bridge from cyclotomic divisibility to the canonical-block cap. -/
theorem mersenneCanonicalOrderBlockLogMass_le_of_dvd_cyclotomicValue
    {d : ℕ}
    (hdiv : mersenneCanonicalOrderBlock d ∣ mersenneCyclotomicValue d) :
    mersenneCanonicalOrderBlockLogMass d ≤
      Real.log 3 * (Nat.totient d : ℝ) := by
  exact log_le_log_three_mul_totient_of_dvd_cyclotomicValue
    (mersenneCanonicalOrderBlock_pos d) hdiv

/-- Unconditional uniform cap for the repository's actual canonical
Mersenne exact-order block, including the zero-index definitional edge case. -/
theorem mersenneCanonicalOrderBlockLogMass_le_cyclotomicCap (d : ℕ) :
    mersenneCanonicalOrderBlockLogMass d ≤
      Real.log 3 * (Nat.totient d : ℝ) := by
  by_cases hd : d = 0
  · subst d
    simp [mersenneCanonicalOrderBlockLogMass, mersenneCanonicalOrderBlock]
  · exact mersenneCanonicalOrderBlockLogMass_le_of_dvd_cyclotomicValue
      (mersenneCanonicalOrderBlock_dvd_cyclotomicValue (Nat.pos_of_ne_zero hd))

#print axioms cyclotomic_eval_two_int_pos
#print axioms coe_mersenneCyclotomicValue_eq_eval_real
#print axioms mersenneCyclotomicValue_pos
#print axioms isRoot_cyclotomic_two_of_prime_dvd_value
#print axioms mersenneExactOrder_eq_of_prime_dvd_cyclotomicValue
#print axioms prod_mersenneCyclotomicValue_divisors_eq
#print axioms exactOrder_prime_fullPower_dvd_cyclotomicValue
#print axioms mersenneCanonicalOrderBlock_dvd_cyclotomicValue
#print axioms mersenneCyclotomicValue_le_three_pow_totient
#print axioms log_le_log_three_mul_totient_of_dvd_cyclotomicValue
#print axioms mersenneCanonicalOrderBlockLogMass_le_of_dvd_cyclotomicValue
#print axioms mersenneCanonicalOrderBlockLogMass_le_cyclotomicCap


/-- Conditional bridge to the actual Mersenne endpoint.  The uniform
cyclotomic cap, the concentration of the discarded region, and the
near-complement exceptional estimate remain explicit premises. -/
theorem log_mersennePowerLoss_isLittleO_of_localizedExceptional
    (region : ℕ → ℕ → Prop) (cap : ℝ)
    (hcapNonneg : 0 ≤ cap)
    (hcap : ∀ d, mersenneCanonicalOrderBlockLogMass d ≤
      cap * (Nat.totient d : ℝ))
    (hregion : restrictedTotientDivisorMass region =o[atTop]
      (fun m : ℕ => (m : ℝ)))
    (hcomplement : ∀ threshold : ℝ, 0 < threshold →
      (fun m => restrictedExceptionalTotientDivisorMass
        mersenneCanonicalOrderBlockLogMass threshold
          (fun n d => ¬ region n d) m) =o[atTop]
            (fun m : ℕ => (m : ℝ))) :
    (fun m : ℕ => Real.log (mersennePowerLoss m : ℝ)) =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  apply log_mersennePowerLoss_isLittleO_iff_divisorAverage.mpr
  apply divisorOrderBlockMassSum_isLittleO_of_localizedExceptional
    mersenneCanonicalOrderBlockLogMass region cap
  · exact mersenneCanonicalOrderBlockLogMass_nonneg
  · exact hcapNonneg
  · exact hcap
  · exact hregion
  · exact hcomplement

#print axioms log_mersennePowerLoss_isLittleO_of_localizedExceptional

/-- Conditional exact localized gate for the actual Mersenne masses.  The
cap and the discarded-region concentration remain explicit premises. -/
theorem log_mersennePowerLoss_isLittleO_iff_localizedExceptional
    (region : ℕ → ℕ → Prop) (cap : ℝ)
    (hcapNonneg : 0 ≤ cap)
    (hcap : ∀ d, mersenneCanonicalOrderBlockLogMass d ≤
      cap * (Nat.totient d : ℝ))
    (hregion : restrictedTotientDivisorMass region =o[atTop]
      (fun m : ℕ => (m : ℝ))) :
    ((fun m : ℕ => Real.log (mersennePowerLoss m : ℝ)) =o[atTop]
        (fun m : ℕ => (m : ℝ))) ↔
      (∀ threshold : ℝ, 0 < threshold →
        (fun m => restrictedExceptionalTotientDivisorMass
          mersenneCanonicalOrderBlockLogMass threshold
            (fun n d => ¬ region n d) m) =o[atTop]
              (fun m : ℕ => (m : ℝ))) := by
  rw [log_mersennePowerLoss_isLittleO_iff_divisorAverage]
  exact divisorOrderBlockMassSum_isLittleO_iff_localizedExceptional
    mersenneCanonicalOrderBlockLogMass region cap
      mersenneCanonicalOrderBlockLogMass_nonneg hcapNonneg hcap hregion

#print axioms log_mersennePowerLoss_isLittleO_iff_localizedExceptional

/-! ## Finite logarithmic-deficit Markov engine -/

/-- Unnormalized totient-weighted logarithmic deficit of a random divisor. -/
noncomputable def totientLogDeficitSum (m : ℕ) : ℝ :=
  ∑ d ∈ m.divisors,
    (Nat.totient d : ℝ) * Real.log ((m : ℝ) / (d : ℝ))

/-- Every summand in the logarithmic-deficit moment is nonnegative at a
positive ambient index. -/
theorem totientLogDeficitSum_nonneg {m : ℕ} (hm : 0 < m) :
    0 ≤ totientLogDeficitSum m := by
  classical
  unfold totientLogDeficitSum
  apply Finset.sum_nonneg
  intro d hd
  have hdMem : d ∣ m := Nat.dvd_of_mem_divisors hd
  have hdPos : 0 < d := Nat.pos_of_dvd_of_pos hdMem hm
  have hdLe : d ≤ m := Nat.le_of_dvd hm hdMem
  have hratio : (1 : ℝ) ≤ (m : ℝ) / (d : ℝ) := by
    apply (le_div_iff₀ (by positivity : (0 : ℝ) < d)).2
    simpa only [one_mul] using (show (d : ℝ) ≤ (m : ℝ) by exact_mod_cast hdLe)
  exact mul_nonneg (by positivity) (Real.log_nonneg hratio)

#print axioms totientLogDeficitSum_nonneg

/-- Finite Markov inequality on the divisor probability space.  A moving
region whose logarithmic deficit is at least `barrier` has totient weight at
most the full deficit moment divided by that barrier. -/
theorem barrier_mul_restrictedTotient_le_logDeficit
    (region : ℕ → ℕ → Prop) {m : ℕ} (hm : 0 < m)
    (barrier : ℝ)
    (hregion : ∀ d ∈ m.divisors, region m d →
      barrier ≤ Real.log ((m : ℝ) / (d : ℝ))) :
    barrier * restrictedTotientDivisorMass region m ≤
      totientLogDeficitSum m := by
  classical
  have hrestricted :
      barrier * restrictedTotientDivisorMass region m ≤
        ∑ d ∈ m.divisors with region m d,
          (Nat.totient d : ℝ) *
            Real.log ((m : ℝ) / (d : ℝ)) := by
    simp only [restrictedTotientDivisorMass, restrictedDivisorMass]
    rw [Finset.mul_sum]
    apply Finset.sum_le_sum
    intro d hd
    simpa only [mul_comm] using
      (mul_le_mul_of_nonneg_left
        (hregion d (Finset.mem_filter.mp hd).1
          (Finset.mem_filter.mp hd).2)
        (show (0 : ℝ) ≤ (Nat.totient d : ℝ) by positivity))
  calc
    barrier * restrictedTotientDivisorMass region m ≤
        ∑ d ∈ m.divisors with region m d,
          (Nat.totient d : ℝ) *
            Real.log ((m : ℝ) / (d : ℝ)) := hrestricted
    _ ≤ ∑ d ∈ m.divisors,
          (Nat.totient d : ℝ) *
            Real.log ((m : ℝ) / (d : ℝ)) := by
      apply Finset.sum_le_sum_of_subset_of_nonneg
        (Finset.filter_subset _ _)
      intro d hd _
      have hdMem : d ∣ m := Nat.dvd_of_mem_divisors hd
      have hdPos : 0 < d := Nat.pos_of_dvd_of_pos hdMem hm
      have hdLe : d ≤ m := Nat.le_of_dvd hm hdMem
      have hratio : (1 : ℝ) ≤ (m : ℝ) / (d : ℝ) := by
        apply (le_div_iff₀ (by positivity : (0 : ℝ) < d)).2
        simpa only [one_mul] using
          (show (d : ℝ) ≤ (m : ℝ) by exact_mod_cast hdLe)
      exact mul_nonneg (by positivity) (Real.log_nonneg hratio)
    _ = totientLogDeficitSum m := rfl

#print axioms barrier_mul_restrictedTotient_le_logDeficit

/-- Asymptotic Markov passage with a moving positive barrier.  If the full
deficit moment is little-oh of `m * barrier(m)`, then every region lying
beyond that barrier has totient weight `o(m)`. -/
theorem restrictedTotient_isLittleO_of_logDeficitMoment
    (region : ℕ → ℕ → Prop) (barrier : ℕ → ℝ)
    (hbarrierPos : ∀ᶠ m in atTop, 0 < barrier m)
    (hregion : ∀ᶠ m in atTop, ∀ d ∈ m.divisors, region m d →
      barrier m ≤ Real.log ((m : ℝ) / (d : ℝ)))
    (hmoment : totientLogDeficitSum =o[atTop]
      (fun m : ℕ => (m : ℝ) * barrier m)) :
    restrictedTotientDivisorMass region =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  rw [isLittleO_iff]
  intro c hc
  filter_upwards [hbarrierPos, hregion, hmoment.bound hc,
      eventually_ge_atTop 1] with m hbarrier hmRegion hmMoment hmOne
  have hm : 0 < m := by omega
  have hrestrictedNonneg :
      0 ≤ restrictedTotientDivisorMass region m := by
    classical
    unfold restrictedTotientDivisorMass restrictedDivisorMass
    exact Finset.sum_nonneg fun d _ => by positivity
  have hmomentNonneg : 0 ≤ totientLogDeficitSum m :=
    totientLogDeficitSum_nonneg hm
  have hmarkov := barrier_mul_restrictedTotient_le_logDeficit
    region hm (barrier m) hmRegion
  have hmomentBound :
      totientLogDeficitSum m ≤ c * ((m : ℝ) * barrier m) := by
    simpa [Real.norm_eq_abs, abs_of_nonneg hmomentNonneg,
      abs_of_nonneg (show (0 : ℝ) ≤ (m : ℝ) by positivity),
      abs_of_pos hbarrier] using hmMoment
  rw [Real.norm_eq_abs, abs_of_nonneg hrestrictedNonneg,
    Real.norm_eq_abs, abs_of_nonneg (by positivity : (0 : ℝ) ≤ m)]
  nlinarith

#print axioms restrictedTotient_isLittleO_of_logDeficitMoment

namespace ExactMoment

noncomputable def primePowerDeficitMoment (p a : ℕ) : ℕ :=
  ∑ j ∈ Finset.range (a + 1), Nat.totient (p ^ j) * (a - j)

lemma sum_totient_prime_power_coordinates {p a : ℕ} (hp : p.Prime) :
    (∑ j ∈ Finset.range (a + 1), Nat.totient (p ^ j)) = p ^ a := by
  calc
    (∑ j ∈ Finset.range (a + 1), Nat.totient (p ^ j)) =
        ∑ d ∈ (p ^ a).divisors, Nat.totient d := by
          symm
          exact Nat.sum_divisors_prime_pow hp
    _ = p ^ a := Nat.sum_totient _

theorem primePowerDeficitMoment_eq_geomSum {p : ℕ} (hp : p.Prime) (a : ℕ) :
    primePowerDeficitMoment p a = ∑ r ∈ Finset.range a, p ^ r := by
  induction a with
  | zero => simp [primePowerDeficitMoment]
  | succ a ih =>
      unfold primePowerDeficitMoment at ih ⊢
      rw [show a.succ + 1 = (a + 1) + 1 by omega,
        Finset.sum_range_succ]
      simp only [Nat.sub_self, mul_zero, add_zero]
      calc
        (∑ j ∈ Finset.range (a + 1),
            Nat.totient (p ^ j) * (a.succ - j)) =
            ∑ j ∈ Finset.range (a + 1),
              (Nat.totient (p ^ j) * (a - j) + Nat.totient (p ^ j)) := by
                apply Finset.sum_congr rfl
                intro j hj
                have hja : j ≤ a := Nat.le_of_lt_succ (Finset.mem_range.mp hj)
                rw [Nat.succ_sub hja]
                simp [Nat.mul_succ]
        _ = (∑ j ∈ Finset.range (a + 1),
              Nat.totient (p ^ j) * (a - j)) +
            ∑ j ∈ Finset.range (a + 1), Nat.totient (p ^ j) := by
              rw [Finset.sum_add_distrib]
        _ = (∑ r ∈ Finset.range a, p ^ r) + p ^ a := by
              rw [ih, sum_totient_prime_power_coordinates hp]
        _ = ∑ r ∈ Finset.range a.succ, p ^ r := by
              rw [Finset.sum_range_succ]

theorem primePowerDeficitMoment_real_eq_geomSum {p : ℕ}
    (hp : p.Prime) (a : ℕ) :
    (∑ j ∈ Finset.range (a + 1),
        (Nat.totient (p ^ j) : ℝ) * (a - j : ℕ)) =
      ∑ r ∈ Finset.range a, (p : ℝ) ^ r := by
  exact_mod_cast primePowerDeficitMoment_eq_geomSum hp a

/-- The exact normalized first moment of the missing exponent in one
prime-power coordinate.  This is Proposition 4.1's local identity before
multiplication by `log p`. -/
theorem primePowerDeficitExpectation_exact {p : ℕ}
    (hp : p.Prime) (a : ℕ) :
    (∑ j ∈ Finset.range (a + 1),
        (Nat.totient (p ^ j) : ℝ) * (a - j : ℕ)) / (p : ℝ) ^ a =
      (1 - ((p : ℝ) ^ a)⁻¹) / ((p : ℝ) - 1) := by
  rw [primePowerDeficitMoment_real_eq_geomSum hp]
  have hp0 : (p : ℝ) ≠ 0 := by exact_mod_cast hp.ne_zero
  have hp1 : (p : ℝ) - 1 ≠ 0 := by
    exact sub_ne_zero.mpr (by exact_mod_cast hp.ne_one)
  have hpow : (p : ℝ) ^ a ≠ 0 := pow_ne_zero _ hp0
  have hgeom := geom_sum_mul (p : ℝ) a
  field_simp
  linarith

/-- Logarithmic version of the exact one-coordinate moment. -/
theorem primePowerLogDeficitExpectation_exact {p : ℕ}
    (hp : p.Prime) (a : ℕ) :
    (∑ j ∈ Finset.range (a + 1),
        (Nat.totient (p ^ j) : ℝ) *
          ((a - j : ℕ) * Real.log p)) / (p : ℝ) ^ a =
      ((1 - ((p : ℝ) ^ a)⁻¹) / ((p : ℝ) - 1)) * Real.log p := by
  rw [← primePowerDeficitExpectation_exact hp a]
  simp_rw [← mul_assoc]
  rw [← Finset.sum_mul]
  ring

/-! ## Global convolution factorization -/

open scoped ArithmeticFunction ArithmeticFunction.zeta

/-- Euler's totient, bundled as a real-valued arithmetic function. -/
noncomputable def totientArithmeticFunction : ArithmeticFunction ℝ :=
  ⟨fun n => (Nat.totient n : ℝ), by simp⟩

/-- The arithmetic identity function, bundled over the reals. -/
noncomputable def identityArithmeticFunction : ArithmeticFunction ℝ :=
  ⟨fun n => (n : ℝ), by simp⟩

@[simp] lemma totientArithmeticFunction_apply (n : ℕ) :
    totientArithmeticFunction n = (Nat.totient n : ℝ) := rfl

@[simp] lemma identityArithmeticFunction_apply (n : ℕ) :
    identityArithmeticFunction n = (n : ℝ) := rfl

/-- The divisor-sum identity `sum (phi d) = n`, as an arithmetic-function
factorization. -/
theorem totientArithmeticFunction_mul_zeta :
    totientArithmeticFunction *
        (ArithmeticFunction.zeta : ArithmeticFunction ℝ) =
      identityArithmeticFunction := by
  ext n
  rw [ArithmeticFunction.coe_mul_zeta_apply]
  simp only [totientArithmeticFunction_apply,
    identityArithmeticFunction_apply]
  exact_mod_cast Nat.sum_totient n

/-- Exact global factorization of the logarithmic-deficit moment.  It is
the Dirichlet-convolution form of coordinate independence. -/
theorem totientArithmeticFunction_mul_log :
    totientArithmeticFunction * ArithmeticFunction.log =
      identityArithmeticFunction * ArithmeticFunction.vonMangoldt := by
  rw [← ArithmeticFunction.vonMangoldt_mul_zeta]
  calc
    totientArithmeticFunction *
          (ArithmeticFunction.vonMangoldt *
            (ArithmeticFunction.zeta : ArithmeticFunction ℝ)) =
        (totientArithmeticFunction *
            (ArithmeticFunction.zeta : ArithmeticFunction ℝ)) *
          ArithmeticFunction.vonMangoldt := by ac_rfl
    _ = identityArithmeticFunction * ArithmeticFunction.vonMangoldt := by
          rw [totientArithmeticFunction_mul_zeta]

/-- Expanded finite-sum form of the global convolution identity. -/
theorem totientLogDeficitMoment_eq_vonMangoldtDivisorSum (m : ℕ) :
    (∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ)) =
      ∑ k ∈ m.divisors,
        (m / k : ℕ) * ArithmeticFunction.vonMangoldt k := by
  calc
    (∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ)) =
        (totientArithmeticFunction * ArithmeticFunction.log) m := by
          rw [ArithmeticFunction.mul_apply]
          change (∑ d ∈ m.divisors,
              (Nat.totient d : ℝ) * Real.log (m / d : ℕ)) =
            ∑ x ∈ m.divisorsAntidiagonal,
              (Nat.totient x.1 : ℝ) * Real.log x.2
          exact (Nat.sum_divisorsAntidiagonal
            (fun i j => (Nat.totient i : ℝ) * Real.log j) (n := m)).symm
    _ = (identityArithmeticFunction *
        ArithmeticFunction.vonMangoldt) m := by
          rw [totientArithmeticFunction_mul_log]
    _ = ∑ k ∈ m.divisors,
        (m / k : ℕ) * ArithmeticFunction.vonMangoldt k := by
          rw [ArithmeticFunction.mul_apply]
          change (∑ x ∈ m.divisorsAntidiagonal,
              (x.1 : ℝ) * ArithmeticFunction.vonMangoldt x.2) =
            ∑ k ∈ m.divisors,
              (m / k : ℕ) * ArithmeticFunction.vonMangoldt k
          exact Nat.sum_divisorsAntidiagonal'
            (fun i j => (i : ℝ) * ArithmeticFunction.vonMangoldt j)
            (n := m)

/-- After normalization, the exact global moment is the divisor sum
`sum_{k | m} Lambda(k) / k`.  This form is convenient for subsequent
prime-power grouping. -/
theorem normalizedTotientLogDeficitMoment_eq_vonMangoldtDivisorSum
    {m : ℕ} (hm : m ≠ 0) :
    (∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ)) / (m : ℝ) =
      ∑ k ∈ m.divisors,
        ArithmeticFunction.vonMangoldt k / (k : ℝ) := by
  rw [totientLogDeficitMoment_eq_vonMangoldtDivisorSum]
  have hmR : (m : ℝ) ≠ 0 := by exact_mod_cast hm
  rw [div_eq_iff hmR]
  calc
    (∑ k ∈ m.divisors,
        (m / k : ℕ) * ArithmeticFunction.vonMangoldt k) =
        ∑ k ∈ m.divisors,
          (m : ℝ) * (ArithmeticFunction.vonMangoldt k / (k : ℝ)) := by
            apply Finset.sum_congr rfl
            intro k hk
            have hkdata := Nat.mem_divisors.mp hk
            have hk0 : (k : ℝ) ≠ 0 := by
              norm_cast
              intro hkzero
              subst k
              simp at hkdata
            rw [Nat.cast_div hkdata.1 hk0]
            field_simp
    _ = (m : ℝ) *
        (∑ k ∈ m.divisors,
          ArithmeticFunction.vonMangoldt k / (k : ℝ)) := by
            rw [Finset.mul_sum]
    _ = (∑ k ∈ m.divisors,
          ArithmeticFunction.vonMangoldt k / (k : ℝ)) * (m : ℝ) :=
            mul_comm _ _

/-- The normalized von Mangoldt divisor sum occurring in the exact moment. -/
noncomputable def vonMangoldtDivisorRatioSum (m : ℕ) : ℝ :=
  ∑ k ∈ m.divisors, ArithmeticFunction.vonMangoldt k / (k : ℝ)

lemma vonMangoldtDivisorRatioSum_eq_filter_isPrimePow (m : ℕ) :
    vonMangoldtDivisorRatioSum m =
      ∑ k ∈ m.divisors with IsPrimePow k,
        ArithmeticFunction.vonMangoldt k / (k : ℝ) := by
  unfold vonMangoldtDivisorRatioSum
  symm
  apply Finset.sum_subset (Finset.filter_subset _ _)
  intro k hkdiv hknot
  have hk : ¬ IsPrimePow k := by
    intro hkpp
    exact hknot (Finset.mem_filter.mpr ⟨hkdiv, hkpp⟩)
  simp [ArithmeticFunction.vonMangoldt_apply, hk]

lemma vonMangoldtDivisorRatioSum_coprime_add {a b : ℕ}
    (hab : a.Coprime b) :
    vonMangoldtDivisorRatioSum (a * b) =
      vonMangoldtDivisorRatioSum a + vonMangoldtDivisorRatioSum b := by
  rw [vonMangoldtDivisorRatioSum_eq_filter_isPrimePow,
    vonMangoldtDivisorRatioSum_eq_filter_isPrimePow,
    vonMangoldtDivisorRatioSum_eq_filter_isPrimePow,
    Nat.mul_divisors_filter_prime_pow hab,
    Finset.filter_union,
    Finset.sum_union (Nat.disjoint_divisors_filter_isPrimePow hab)]

lemma sum_reciprocal_prime_powers_exact {p : ℕ} (hp : p.Prime) (a : ℕ) :
    (∑ r ∈ Finset.range a, 1 / (p : ℝ) ^ (r + 1)) =
      (1 - ((p : ℝ) ^ a)⁻¹) / ((p : ℝ) - 1) := by
  have hp0 : (p : ℝ) ≠ 0 := by exact_mod_cast hp.ne_zero
  have hp1 : (p : ℝ) - 1 ≠ 0 := by
    exact sub_ne_zero.mpr (by exact_mod_cast hp.ne_one)
  have hgeom := geom_sum_mul_neg ((p : ℝ)⁻¹) a
  simp_rw [pow_succ, one_div, mul_inv_rev]
  rw [← Finset.mul_sum]
  simp only [inv_pow] at hgeom
  field_simp [hp0] at hgeom ⊢
  nlinarith

lemma vonMangoldtDivisorRatioSum_primePower {p : ℕ}
    (hp : p.Prime) (a : ℕ) :
    vonMangoldtDivisorRatioSum (p ^ a) =
      ((1 - ((p : ℝ) ^ a)⁻¹) / ((p : ℝ) - 1)) * Real.log p := by
  unfold vonMangoldtDivisorRatioSum
  rw [Nat.sum_divisors_prime_pow hp, Finset.sum_range_succ']
  simp only [Nat.pow_zero, ArithmeticFunction.vonMangoldt_apply_one,
    Nat.cast_one, zero_div]
  simp_rw [ArithmeticFunction.vonMangoldt_apply_pow (Nat.succ_ne_zero _),
    ArithmeticFunction.vonMangoldt_apply_prime hp, Nat.cast_pow,
    div_eq_mul_inv, mul_comm (Real.log p) _]
  rw [← Finset.sum_mul]
  simp_rw [← one_div]
  rw [sum_reciprocal_prime_powers_exact hp]
  ring

/-- The closed prime-factor expression in Proposition 4.1. -/
noncomputable def primeFactorDeficitMoment (m : ℕ) : ℝ :=
  ∑ p ∈ m.primeFactors,
    ((1 - ((p : ℝ) ^ (m.factorization p))⁻¹) / ((p : ℝ) - 1)) *
      Real.log p

lemma primeFactorDeficitMoment_coprime_add {a b : ℕ}
    (hab : a.Coprime b) :
    primeFactorDeficitMoment (a * b) =
      primeFactorDeficitMoment a + primeFactorDeficitMoment b := by
  unfold primeFactorDeficitMoment
  rw [hab.primeFactors_mul,
    Finset.sum_union hab.disjoint_primeFactors]
  congr 1
  · apply Finset.sum_congr rfl
    intro p hp
    rw [Nat.factorization_eq_of_coprime_left hab
      (Nat.mem_primeFactors_iff_mem_primeFactorsList.mp hp)]
  · apply Finset.sum_congr rfl
    intro p hp
    rw [Nat.factorization_eq_of_coprime_right hab
      (Nat.mem_primeFactors_iff_mem_primeFactorsList.mp hp)]

/-- Full coordinate factorization of the normalized moment. -/
theorem vonMangoldtDivisorRatioSum_eq_primeFactorDeficitMoment (m : ℕ) :
    vonMangoldtDivisorRatioSum m = primeFactorDeficitMoment m := by
  induction m using Nat.recOnPrimeCoprime with
  | zero => simp [vonMangoldtDivisorRatioSum, primeFactorDeficitMoment]
  | prime_pow p a hp =>
      rw [vonMangoldtDivisorRatioSum_primePower hp]
      cases a with
      | zero => simp [primeFactorDeficitMoment]
      | succ a =>
          unfold primeFactorDeficitMoment
          rw [Nat.primeFactors_prime_pow (Nat.succ_ne_zero a) hp,
            Finset.sum_singleton, Nat.factorization_pow_self hp]
  | coprime a b ha hb hab hA hB =>
      rw [vonMangoldtDivisorRatioSum_coprime_add hab, hA, hB,
        primeFactorDeficitMoment_coprime_add hab]

/-- Proposition 4.1 in its exact global finite-sum form. -/
theorem normalizedTotientLogDeficitMoment_exact {m : ℕ} (hm : m ≠ 0) :
    (∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ)) / (m : ℝ) =
      ∑ p ∈ m.primeFactors,
        ((1 - ((p : ℝ) ^ (m.factorization p))⁻¹) / ((p : ℝ) - 1)) *
          Real.log p := by
  rw [normalizedTotientLogDeficitMoment_eq_vonMangoldtDivisorSum hm]
  change vonMangoldtDivisorRatioSum m = primeFactorDeficitMoment m
  exact vonMangoldtDivisorRatioSum_eq_primeFactorDeficitMoment m

/-! ## Elementary upper bounds -/

noncomputable def primeFactorHarmonicLogSum (m : ℕ) : ℝ :=
  ∑ p ∈ m.primeFactors, Real.log p / ((p : ℝ) - 1)

noncomputable def primeHarmonicLogCutoff (Y : ℕ) : ℝ :=
  ∑ p ∈ Y.primesLE, Real.log p / ((p : ℝ) - 1)

lemma prime_log_div_sub_one_nonneg {p : ℕ} (hp : p.Prime) :
    0 ≤ Real.log p / ((p : ℝ) - 1) := by
  have hpR : (1 : ℝ) < (p : ℝ) := by exact_mod_cast hp.one_lt
  have hpden : 0 < (p : ℝ) - 1 := by linarith
  have hpone : (1 : ℝ) ≤ (p : ℝ) := hpR.le
  exact div_nonneg (Real.log_nonneg hpone) hpden.le

theorem primeFactorDeficitMoment_le_harmonicLogSum (m : ℕ) :
    primeFactorDeficitMoment m ≤ primeFactorHarmonicLogSum m := by
  unfold primeFactorDeficitMoment primeFactorHarmonicLogSum
  apply Finset.sum_le_sum
  intro p hpMem
  have hp : p.Prime := Nat.prime_of_mem_primeFactors hpMem
  have hpR : (1 : ℝ) < (p : ℝ) := by exact_mod_cast hp.one_lt
  have hpden : 0 < (p : ℝ) - 1 := by linarith
  have hcoeff :
      (1 - ((p : ℝ) ^ (m.factorization p))⁻¹) / ((p : ℝ) - 1) ≤
        1 / ((p : ℝ) - 1) := by
    apply div_le_div_of_nonneg_right _ hpden.le
    have hinv : 0 ≤ ((p : ℝ) ^ (m.factorization p))⁻¹ := by positivity
    linarith
  calc
    ((1 - ((p : ℝ) ^ (m.factorization p))⁻¹) / ((p : ℝ) - 1)) *
        Real.log p ≤ (1 / ((p : ℝ) - 1)) * Real.log p :=
      mul_le_mul_of_nonneg_right hcoeff (Real.log_nonneg hpR.le)
    _ = Real.log p / ((p : ℝ) - 1) := by ring

lemma sum_log_primeFactors_le_log {m : ℕ} (hm : m ≠ 0) :
    (∑ p ∈ m.primeFactors, Real.log p) ≤ Real.log m := by
  have hmpos : 0 < m := Nat.pos_of_ne_zero hm
  have hprodpos : 0 < ∏ p ∈ m.primeFactors, p := by
    apply Finset.prod_pos
    intro p hp
    exact (Nat.prime_of_mem_primeFactors hp).pos
  have hprodle : (∏ p ∈ m.primeFactors, p) ≤ m :=
    Nat.le_of_dvd hmpos (Nat.prod_primeFactors_dvd m)
  calc
    (∑ p ∈ m.primeFactors, Real.log p) =
        Real.log (∏ p ∈ m.primeFactors, (p : ℝ)) := by
          symm
          exact Real.log_prod fun p hp => by
            exact_mod_cast (Nat.prime_of_mem_primeFactors hp).ne_zero
    _ = Real.log ((∏ p ∈ m.primeFactors, p : ℕ) : ℝ) := by
          rw [Nat.cast_prod]
    _ ≤ Real.log m :=
      Real.log_le_log (by exact_mod_cast hprodpos) (by exact_mod_cast hprodle)

/-- Fixed-cutoff bound used in the elementary proof that the moment is
`o(log m)`. -/
theorem primeFactorHarmonicLogSum_le_cutoff
    {m Y : ℕ} (hm : m ≠ 0) (hY : 0 < Y) :
    primeFactorHarmonicLogSum m ≤
      primeHarmonicLogCutoff Y + (1 / (Y : ℝ)) * Real.log m := by
  classical
  let term : ℕ → ℝ := fun p => Real.log p / ((p : ℝ) - 1)
  have hsplit :
      primeFactorHarmonicLogSum m =
        (∑ p ∈ m.primeFactors with p ≤ Y, term p) +
        ∑ p ∈ m.primeFactors with ¬ p ≤ Y, term p := by
    unfold primeFactorHarmonicLogSum
    exact (Finset.sum_filter_add_sum_filter_not
      m.primeFactors (fun p => p ≤ Y) term).symm
  have hsmall :
      (∑ p ∈ m.primeFactors with p ≤ Y, term p) ≤
        primeHarmonicLogCutoff Y := by
    unfold primeHarmonicLogCutoff
    apply Finset.sum_le_sum_of_subset_of_nonneg
    · intro p hp
      have hp' := Finset.mem_filter.mp hp
      exact Nat.mem_primesLE.mpr
        ⟨hp'.2, Nat.prime_of_mem_primeFactors hp'.1⟩
    · intro p hpY _
      exact prime_log_div_sub_one_nonneg (Nat.mem_primesLE.mp hpY).2
  have hlargePoint : ∀ p ∈ m.primeFactors, ¬ p ≤ Y →
      term p ≤ (1 / (Y : ℝ)) * Real.log p := by
    intro p hpMem hpLarge
    have hp : p.Prime := Nat.prime_of_mem_primeFactors hpMem
    have hpYnat : Y < p := lt_of_not_ge hpLarge
    have hpYR : (Y : ℝ) < (p : ℝ) := by exact_mod_cast hpYnat
    have hden : (Y : ℝ) ≤ (p : ℝ) - 1 := by
      have hpYsucc : Y + 1 ≤ p := by omega
      have hpYsuccR : (Y : ℝ) + 1 ≤ (p : ℝ) := by exact_mod_cast hpYsucc
      linarith
    have hYreal : 0 < (Y : ℝ) := by exact_mod_cast hY
    have hlog : 0 ≤ Real.log p :=
      Real.log_nonneg (by exact_mod_cast hp.one_le)
    dsimp [term]
    calc
      Real.log p / ((p : ℝ) - 1) ≤ Real.log p / (Y : ℝ) := by
        exact div_le_div_of_nonneg_left hlog hYreal hden
      _ = (1 / (Y : ℝ)) * Real.log p := by ring
  have hlarge :
      (∑ p ∈ m.primeFactors with ¬ p ≤ Y, term p) ≤
        (1 / (Y : ℝ)) * Real.log m := by
    calc
      (∑ p ∈ m.primeFactors with ¬ p ≤ Y, term p) ≤
          ∑ p ∈ m.primeFactors with ¬ p ≤ Y,
            (1 / (Y : ℝ)) * Real.log p := by
              apply Finset.sum_le_sum
              intro p hp
              exact hlargePoint p (Finset.mem_filter.mp hp).1
                (Finset.mem_filter.mp hp).2
      _ = (1 / (Y : ℝ)) *
          (∑ p ∈ m.primeFactors with ¬ p ≤ Y, Real.log p) := by
            rw [Finset.mul_sum]
      _ ≤ (1 / (Y : ℝ)) *
          (∑ p ∈ m.primeFactors, Real.log p) := by
            apply mul_le_mul_of_nonneg_left _ (by positivity)
            apply Finset.sum_le_sum_of_subset_of_nonneg
              (Finset.filter_subset _ _)
            intro p hp _
            exact Real.log_nonneg (by
              exact_mod_cast (Nat.prime_of_mem_primeFactors hp).one_le)
      _ ≤ (1 / (Y : ℝ)) * Real.log m := by
            exact mul_le_mul_of_nonneg_left
              (sum_log_primeFactors_le_log hm) (by positivity)
  rw [hsplit]
  linarith

/-- Dyadic Chebyshev bound for the fixed prime cutoff.  Each interval
`(2^k, 2^(k+1)]` contributes at most `2 * log 4`. -/
theorem primeHarmonicLogCutoff_two_pow_le (K : ℕ) :
    primeHarmonicLogCutoff (2 ^ K) ≤
      (2 * Real.log 4) * K := by
  induction K with
  | zero => simp [primeHarmonicLogCutoff, Nat.primesLE]
  | succ K ih =>
      let lower : ℕ := 2 ^ K
      let upper : ℕ := 2 ^ (K + 1)
      let term : ℕ → ℝ := fun p => Real.log p / ((p : ℝ) - 1)
      have hlower : 0 < lower := by positivity
      have hlowerR : (0 : ℝ) < (lower : ℝ) := by exact_mod_cast hlower
      have hlowerupper : lower ≤ upper := by
        dsimp [lower, upper]
        rw [pow_succ]
        omega
      have hsmallSet :
          upper.primesLE.filter (fun p => p ≤ lower) = lower.primesLE := by
        ext p
        simp only [Finset.mem_filter, Nat.mem_primesLE]
        constructor
        · rintro ⟨⟨_, hp⟩, hplower⟩
          exact ⟨hplower, hp⟩
        · rintro ⟨hplower, hp⟩
          exact ⟨⟨hplower.trans hlowerupper, hp⟩, hplower⟩
      have hsplit :
          primeHarmonicLogCutoff upper =
            primeHarmonicLogCutoff lower +
              ∑ p ∈ upper.primesLE with ¬ p ≤ lower, term p := by
        unfold primeHarmonicLogCutoff
        rw [← hsmallSet]
        exact (Finset.sum_filter_add_sum_filter_not
          upper.primesLE (fun p => p ≤ lower) term).symm
      have hlargePoint : ∀ p ∈ upper.primesLE, ¬ p ≤ lower →
          term p ≤ (1 / (lower : ℝ)) * Real.log p := by
        intro p hpUpper hpLarge
        have hp : p.Prime := (Nat.mem_primesLE.mp hpUpper).2
        have hpLower : lower < p := lt_of_not_ge hpLarge
        have hden : (lower : ℝ) ≤ (p : ℝ) - 1 := by
          have hs : lower + 1 ≤ p := by omega
          have hsR : (lower : ℝ) + 1 ≤ (p : ℝ) := by exact_mod_cast hs
          linarith
        have hlog : 0 ≤ Real.log p :=
          Real.log_nonneg (by exact_mod_cast hp.one_le)
        dsimp [term]
        calc
          Real.log p / ((p : ℝ) - 1) ≤
              Real.log p / (lower : ℝ) :=
            div_le_div_of_nonneg_left hlog hlowerR hden
          _ = (1 / (lower : ℝ)) * Real.log p := by ring
      have hlarge :
          (∑ p ∈ upper.primesLE with ¬ p ≤ lower, term p) ≤
            2 * Real.log 4 := by
        calc
          (∑ p ∈ upper.primesLE with ¬ p ≤ lower, term p) ≤
              ∑ p ∈ upper.primesLE with ¬ p ≤ lower,
                (1 / (lower : ℝ)) * Real.log p := by
                  apply Finset.sum_le_sum
                  intro p hp
                  exact hlargePoint p (Finset.mem_filter.mp hp).1
                    (Finset.mem_filter.mp hp).2
          _ = (1 / (lower : ℝ)) *
              (∑ p ∈ upper.primesLE with ¬ p ≤ lower, Real.log p) := by
                rw [Finset.mul_sum]
          _ ≤ (1 / (lower : ℝ)) *
              (∑ p ∈ upper.primesLE, Real.log p) := by
                apply mul_le_mul_of_nonneg_left _ (by positivity)
                apply Finset.sum_le_sum_of_subset_of_nonneg
                  (Finset.filter_subset _ _)
                intro p hp _
                exact Real.log_nonneg (by
                  exact_mod_cast (Nat.mem_primesLE.mp hp).2.one_le)
          _ = (1 / (lower : ℝ)) * Chebyshev.theta upper := by
                rw [Chebyshev.theta_eq_sum_primesLE_log]
          _ ≤ (1 / (lower : ℝ)) * (Real.log 4 * (upper : ℝ)) := by
                apply mul_le_mul_of_nonneg_left
                  (Chebyshev.theta_le_log4_mul_x (by positivity))
                  (by positivity)
          _ = 2 * Real.log 4 := by
                dsimp [lower, upper]
                rw [pow_succ, Nat.cast_mul, Nat.cast_pow]
                field_simp
                ring
      rw [hsplit]
      dsimp [lower, upper] at ih ⊢
      rw [Nat.cast_succ]
      linarith

/-- Global dyadic bound with a freely chosen scale `2^K`. -/
theorem primeFactorHarmonicLogSum_le_dyadic
    {m : ℕ} (hm : m ≠ 0) (K : ℕ) :
    primeFactorHarmonicLogSum m ≤
      (2 * Real.log 4) * K +
        (1 / ((2 ^ K : ℕ) : ℝ)) * Real.log m := by
  have hcutoff := primeFactorHarmonicLogSum_le_cutoff
    hm (show 0 < 2 ^ K by positivity)
  have hdyadic := primeHarmonicLogCutoff_two_pow_le K
  linarith

noncomputable def dyadicLogScale (m : ℕ) : ℕ :=
  Nat.log 2 ⌈Real.log (3 * (m : ℝ))⌉₊

lemma log_three_mul_nat_gt_one {m : ℕ} (hm : 1 ≤ m) :
    1 < Real.log (3 * (m : ℝ)) := by
  have hthree : Real.exp 1 < (3 : ℝ) := Real.exp_one_lt_three
  have hthreeLog : 1 < Real.log (3 : ℝ) :=
    (Real.lt_log_iff_exp_lt (by norm_num : (0 : ℝ) < 3)).2 hthree
  have hmR : (1 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  have harg : (3 : ℝ) ≤ 3 * (m : ℝ) := by nlinarith
  exact hthreeLog.trans_le (Real.log_le_log (by norm_num) harg)

lemma dyadicLogScale_tail_le_two {m : ℕ} (hm : 1 ≤ m) :
    (1 / ((2 ^ dyadicLogScale m : ℕ) : ℝ)) * Real.log m ≤ 2 := by
  let x : ℝ := Real.log (3 * (m : ℝ))
  let N : ℕ := ⌈x⌉₊
  let K : ℕ := Nat.log 2 N
  have hxOne : 1 < x := by
    dsimp [x]
    exact log_three_mul_nat_gt_one hm
  have hxPos : 0 < x := lt_trans (by norm_num) hxOne
  have hNOne : 1 ≤ N := by
    dsimp [N]
    exact (Nat.one_le_ceil_iff).2 hxPos
  have hN0 : N ≠ 0 := by omega
  have hxN : x ≤ (N : ℝ) := by
    dsimp [N]
    exact Nat.le_ceil x
  have hNpowNat : N < 2 ^ (Nat.log 2 N).succ :=
    Nat.lt_pow_succ_log_self Nat.one_lt_two N
  have hNpow : (N : ℝ) < 2 * (((2 ^ K : ℕ) : ℝ)) := by
    have hcast : (N : ℝ) < ((2 ^ (Nat.log 2 N).succ : ℕ) : ℝ) := by
      exact_mod_cast hNpowNat
    dsimp [K]
    rw [pow_succ, Nat.cast_mul, Nat.cast_ofNat] at hcast
    nlinarith
  have hxpow : x < 2 * (((2 ^ K : ℕ) : ℝ)) := hxN.trans_lt hNpow
  have hmPos : (0 : ℝ) < (m : ℝ) := by
    exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hm)
  have hlogmLe : Real.log m ≤ x := by
    dsimp [x]
    apply Real.log_le_log hmPos
    nlinarith
  have hpowPos : (0 : ℝ) < ((2 ^ K : ℕ) : ℝ) := by positivity
  change (1 / ((2 ^ K : ℕ) : ℝ)) * Real.log m ≤ 2
  calc
    (1 / ((2 ^ K : ℕ) : ℝ)) * Real.log m ≤
        (1 / ((2 ^ K : ℕ) : ℝ)) * x :=
      mul_le_mul_of_nonneg_left hlogmLe (by positivity)
    _ ≤ 2 := by
      have hstrict :
          (1 / ((2 ^ K : ℕ) : ℝ)) * x <
            (1 / ((2 ^ K : ℕ) : ℝ)) *
              (2 * (((2 ^ K : ℕ) : ℝ))) :=
        mul_lt_mul_of_pos_left hxpow (by positivity)
      have heq :
          (1 / ((2 ^ K : ℕ) : ℝ)) *
              (2 * (((2 ^ K : ℕ) : ℝ))) = 2 := by
        field_simp
      linarith

lemma dyadicLogScale_le_one_add_loglog_div_log_two
    {m : ℕ} (hm : 1 ≤ m) :
    (dyadicLogScale m : ℝ) ≤
      1 + Real.log (Real.log (3 * (m : ℝ))) / Real.log 2 := by
  let x : ℝ := Real.log (3 * (m : ℝ))
  let N : ℕ := ⌈x⌉₊
  let K : ℕ := Nat.log 2 N
  have hxOne : 1 < x := by
    dsimp [x]
    exact log_three_mul_nat_gt_one hm
  have hxPos : 0 < x := lt_trans (by norm_num) hxOne
  have hNOne : 1 ≤ N := by
    dsimp [N]
    exact (Nat.one_le_ceil_iff).2 hxPos
  have hN0 : N ≠ 0 := by omega
  have hpowN : 2 ^ K ≤ N := by
    dsimp [K]
    exact Nat.pow_log_le_self 2 hN0
  have hpowNReal : (((2 ^ K : ℕ) : ℝ)) ≤ (N : ℝ) := by
    exact_mod_cast hpowN
  have hKlog : (K : ℝ) * Real.log 2 ≤ Real.log (N : ℝ) := by
    have hlog := Real.log_le_log
      (show (0 : ℝ) < ((2 ^ K : ℕ) : ℝ) by positivity) hpowNReal
    rw [Nat.cast_pow, Real.log_pow] at hlog
    simpa using hlog
  have hNlt : (N : ℝ) < x + 1 := by
    dsimp [N]
    exact Nat.ceil_lt_add_one hxPos.le
  have hNleTwoX : (N : ℝ) ≤ 2 * x := by linarith
  have hNPos : (0 : ℝ) < (N : ℝ) := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hNOne)
  have hlogNle : Real.log (N : ℝ) ≤ Real.log 2 + Real.log x := by
    have h := Real.log_le_log hNPos hNleTwoX
    rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hxPos.ne'] at h
    exact h
  have hcombined :
      (K : ℝ) * Real.log 2 ≤ Real.log 2 + Real.log x :=
    hKlog.trans hlogNle
  have hlogTwo : 0 < Real.log 2 := Real.log_pos (by norm_num)
  change (K : ℝ) ≤ 1 + Real.log x / Real.log 2
  calc
    (K : ℝ) ≤ (Real.log 2 + Real.log x) / Real.log 2 :=
      (le_div_iff₀ hlogTwo).2 hcombined
    _ = 1 + Real.log x / Real.log 2 := by
      field_simp

/-- A fully explicit moving-cutoff estimate.  The only analytic input is
Chebyshev's elementary bound `theta x ≤ log 4 * x`. -/
theorem primeFactorHarmonicLogSum_le_loglog_explicit
    {m : ℕ} (hm : 1 ≤ m) :
    primeFactorHarmonicLogSum m ≤
      (2 * Real.log 4) *
          (1 + Real.log (Real.log (3 * (m : ℝ))) / Real.log 2) + 2 := by
  have hdyadic := primeFactorHarmonicLogSum_le_dyadic
    (show m ≠ 0 by omega) (dyadicLogScale m)
  have htail := dyadicLogScale_tail_le_two hm
  have hscale := dyadicLogScale_le_one_add_loglog_div_log_two hm
  have hscale' := mul_le_mul_of_nonneg_left hscale
    (show 0 ≤ 2 * Real.log 4 by positivity)
  linarith

/-- The moving cutoff gives the expected global `O(log log (3m))` bound,
without a prime number theorem. -/
theorem primeFactorHarmonicLogSum_isBigO_loglog :
    primeFactorHarmonicLogSum =O[atTop]
      (fun m : ℕ => Real.log (Real.log (3 * (m : ℝ)))) := by
  let A : ℝ := 2 * Real.log 4
  let C : ℝ := A + 2 + A / Real.log 2
  have hinner :
      Tendsto (fun m : ℕ => Real.log (3 * (m : ℝ))) atTop atTop :=
    Real.tendsto_log_atTop.comp
      (Tendsto.const_mul_atTop (by norm_num : (0 : ℝ) < 3)
        tendsto_natCast_atTop_atTop)
  have houter :
      Tendsto (fun m : ℕ => Real.log (Real.log (3 * (m : ℝ))))
        atTop atTop :=
    Real.tendsto_log_atTop.comp hinner
  rw [isBigO_iff]
  refine ⟨C, ?_⟩
  filter_upwards [eventually_ge_atTop 1, houter.eventually_ge_atTop 1]
      with m hm hloglog
  let L : ℝ := Real.log (Real.log (3 * (m : ℝ)))
  have hL : 1 ≤ L := by simpa [L] using hloglog
  have hL0 : 0 ≤ L := zero_le_one.trans hL
  have hA : 0 ≤ A := by dsimp [A]; positivity
  have hlogTwo : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hAdiv : 0 ≤ A / Real.log 2 := div_nonneg hA hlogTwo.le
  have hexplicit := primeFactorHarmonicLogSum_le_loglog_explicit hm
  have hbound :
      primeFactorHarmonicLogSum m ≤ A * (1 + L / Real.log 2) + 2 := by
    simpa [A, L] using hexplicit
  have hconstant : A + 2 ≤ (A + 2) * L := by nlinarith
  have hsum : 0 ≤ primeFactorHarmonicLogSum m := by
    unfold primeFactorHarmonicLogSum
    apply Finset.sum_nonneg
    intro p hp
    exact prime_log_div_sub_one_nonneg (Nat.prime_of_mem_primeFactors hp)
  rw [Real.norm_eq_abs,
    abs_of_nonneg hsum,
    Real.norm_eq_abs, abs_of_nonneg hL0]
  change primeFactorHarmonicLogSum m ≤ C * L
  calc
    primeFactorHarmonicLogSum m ≤ A * (1 + L / Real.log 2) + 2 := hbound
    _ = (A + 2) + (A / Real.log 2) * L := by ring
    _ ≤ (A + 2) * L + (A / Real.log 2) * L := by
      linarith
    _ = C * L := by
      dsimp [C]
      ring

lemma primeFactorHarmonicLogSum_nonneg (m : ℕ) :
    0 ≤ primeFactorHarmonicLogSum m := by
  unfold primeFactorHarmonicLogSum
  apply Finset.sum_nonneg
  intro p hp
  exact prime_log_div_sub_one_nonneg (Nat.prime_of_mem_primeFactors hp)

lemma primeHarmonicLogCutoff_nonneg (Y : ℕ) :
    0 ≤ primeHarmonicLogCutoff Y := by
  unfold primeHarmonicLogCutoff
  apply Finset.sum_nonneg
  intro p hp
  exact prime_log_div_sub_one_nonneg (Nat.mem_primesLE.mp hp).2

/-- The elementary fixed-cutoff argument: no prime number theorem is used. -/
theorem primeFactorHarmonicLogSum_isLittleO_log :
    primeFactorHarmonicLogSum =o[atTop]
      (fun m : ℕ => Real.log m) := by
  rw [isLittleO_iff]
  intro c hc
  obtain ⟨Y, hYchoice⟩ := exists_nat_gt (2 / c : ℝ)
  have htwoDiv : 0 < (2 / c : ℝ) := by positivity
  have hYreal : 0 < (Y : ℝ) := htwoDiv.trans hYchoice
  have hY : 0 < Y := by exact_mod_cast hYreal
  have hhalf : 0 < c / 2 := by positivity
  have hrecip : 1 / (Y : ℝ) ≤ c / 2 := by
    have hmul : 1 < (c / 2) * (Y : ℝ) := by
      calc
        (1 : ℝ) = (c / 2) * (2 / c) := by field_simp
        _ < (c / 2) * (Y : ℝ) :=
          mul_lt_mul_of_pos_left hYchoice hhalf
    exact (div_le_iff₀ hYreal).2 hmul.le
  let K := primeHarmonicLogCutoff Y
  have hlogTop : Tendsto (fun m : ℕ => Real.log m) atTop atTop :=
    Real.tendsto_log_atTop.comp
      (tendsto_natCast_atTop_atTop (R := ℝ))
  have hKevent : ∀ᶠ m : ℕ in atTop, 2 * K / c < Real.log m :=
    hlogTop.eventually_gt_atTop (2 * K / c)
  filter_upwards [eventually_ge_atTop 1, hKevent] with m hm1 hmK
  have hm0 : m ≠ 0 := by omega
  have hlog : 0 ≤ Real.log m :=
    Real.log_nonneg (by exact_mod_cast hm1)
  have hKsmall : K ≤ (c / 2) * Real.log m := by
    have hscaled := mul_le_mul_of_nonneg_left hmK.le hhalf.le
    calc
      K = (c / 2) * (2 * K / c) := by field_simp
      _ ≤ (c / 2) * Real.log m := hscaled
  have htail : (1 / (Y : ℝ)) * Real.log m ≤
      (c / 2) * Real.log m :=
    mul_le_mul_of_nonneg_right hrecip hlog
  have hbound := primeFactorHarmonicLogSum_le_cutoff hm0 hY
  dsimp [K] at hKsmall
  rw [Real.norm_eq_abs,
    abs_of_nonneg (primeFactorHarmonicLogSum_nonneg m),
    Real.norm_eq_abs, abs_of_nonneg hlog]
  dsimp [K] at hmK
  linarith

lemma primeFactorDeficitMoment_nonneg (m : ℕ) :
    0 ≤ primeFactorDeficitMoment m := by
  rw [← vonMangoldtDivisorRatioSum_eq_primeFactorDeficitMoment]
  unfold vonMangoldtDivisorRatioSum
  apply Finset.sum_nonneg
  intro k _
  exact div_nonneg ArithmeticFunction.vonMangoldt_nonneg (by positivity)

/-- The exact normalized first moment inherits the moving-window
`O(log log (3m))` bound. -/
theorem primeFactorDeficitMoment_isBigO_loglog :
    primeFactorDeficitMoment =O[atTop]
      (fun m : ℕ => Real.log (Real.log (3 * (m : ℝ)))) := by
  have hbig := primeFactorHarmonicLogSum_isBigO_loglog
  rw [isBigO_iff] at hbig ⊢
  obtain ⟨C, hC⟩ := hbig
  refine ⟨C, ?_⟩
  filter_upwards [hC] with m hm
  have hdeficit := primeFactorDeficitMoment_le_harmonicLogSum m
  rw [Real.norm_eq_abs,
    abs_of_nonneg (primeFactorHarmonicLogSum_nonneg m)] at hm
  rw [Real.norm_eq_abs,
    abs_of_nonneg (primeFactorDeficitMoment_nonneg m)]
  exact hdeficit.trans hm

/-- Proposition 4.2: the exact normalized deficit moment is `o(log m)`. -/
theorem primeFactorDeficitMoment_isLittleO_log :
    primeFactorDeficitMoment =o[atTop]
      (fun m : ℕ => Real.log m) := by
  rw [isLittleO_iff]
  intro c hc
  filter_upwards [primeFactorHarmonicLogSum_isLittleO_log.bound hc]
      with m hm
  have hdeficit := primeFactorDeficitMoment_le_harmonicLogSum m
  rw [Real.norm_eq_abs,
    abs_of_nonneg (primeFactorHarmonicLogSum_nonneg m)] at hm
  rw [Real.norm_eq_abs,
    abs_of_nonneg (primeFactorDeficitMoment_nonneg m)]
  exact hdeficit.trans hm

section FiniteMarkov

variable {ι : Type*}

/-- Finite weighted Markov inequality, stated directly for any event on
which the statistic is at least the threshold. -/
theorem threshold_mul_weightedEvent_le_moment
    (s : Finset ι) (weight statistic : ι → ℝ) (event : ι → Prop)
    [DecidablePred event]
    (threshold : ℝ)
    (hweight : ∀ x ∈ s, 0 ≤ weight x)
    (hstatistic : ∀ x ∈ s, 0 ≤ statistic x)
    (hevent : ∀ x ∈ s, event x → threshold ≤ statistic x) :
    threshold * (∑ x ∈ s with event x, weight x) ≤
      ∑ x ∈ s, weight x * statistic x := by
  classical
  calc
    threshold * (∑ x ∈ s with event x, weight x) =
        ∑ x ∈ s with event x, threshold * weight x := by
          rw [Finset.mul_sum]
    _ ≤ ∑ x ∈ s with event x, weight x * statistic x := by
          apply Finset.sum_le_sum
          intro x hx
          have hxs : x ∈ s := (Finset.mem_filter.mp hx).1
          have hxe : event x := (Finset.mem_filter.mp hx).2
          calc
            threshold * weight x = weight x * threshold := mul_comm _ _
            _ ≤ weight x * statistic x :=
              mul_le_mul_of_nonneg_left (hevent x hxs hxe) (hweight x hxs)
    _ ≤ ∑ x ∈ s, weight x * statistic x := by
          apply Finset.sum_le_sum_of_subset_of_nonneg (Finset.filter_subset _ _)
          intro x hxs _
          exact mul_nonneg (hweight x hxs) (hstatistic x hxs)

/-- The usual threshold-set form of finite weighted Markov. -/
theorem threshold_mul_weightedTail_le_moment
    (s : Finset ι) (weight statistic : ι → ℝ) (threshold : ℝ)
    (hweight : ∀ x ∈ s, 0 ≤ weight x)
    (hstatistic : ∀ x ∈ s, 0 ≤ statistic x) :
    threshold * (∑ x ∈ s with threshold ≤ statistic x, weight x) ≤
      ∑ x ∈ s, weight x * statistic x := by
  exact threshold_mul_weightedEvent_le_moment s weight statistic
    (fun x => threshold ≤ statistic x) threshold hweight hstatistic
    (fun _ _ hx => hx)

/-- Markov inequality for the actual totient-weighted logarithmic deficit on
the divisor set.  The event can be any region for which a pointwise deficit
lower bound has been proved. -/
theorem threshold_mul_totientDivisorEvent_le_logDeficitMoment
    (m : ℕ) (event : ℕ → Prop) [DecidablePred event]
    (threshold : ℝ)
    (hevent : ∀ d ∈ m.divisors, event d →
      threshold ≤ Real.log (m / d : ℕ)) :
    threshold *
        (∑ d ∈ m.divisors with event d, (Nat.totient d : ℝ)) ≤
      ∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ) := by
  apply threshold_mul_weightedEvent_le_moment
    m.divisors (fun d => (Nat.totient d : ℝ))
      (fun d => Real.log (m / d : ℕ)) event threshold
  · intro d _
    positivity
  · intro d hd
    have hddata := Nat.mem_divisors.mp hd
    have hmpos : 0 < m := Nat.pos_of_ne_zero hddata.2
    have hdpos : 0 < d := by
      by_contra h
      have hd0 : d = 0 := Nat.eq_zero_of_not_pos h
      subst d
      simp at hddata
    have hdle : d ≤ m := Nat.le_of_dvd hmpos hddata.1
    have hquot : 1 ≤ m / d := (Nat.one_le_div_iff hdpos).2 hdle
    exact Real.log_nonneg (by exact_mod_cast hquot)
  · exact hevent

/-! ## Totient-weighted concentration -/

noncomputable def totientLogDeficitTailWeight
    (delta : ℝ) (m : ℕ) : ℝ :=
  ∑ d ∈ m.divisors with
    delta * Real.log m ≤ Real.log (m / d : ℕ),
    (Nat.totient d : ℝ)

lemma totientLogDeficitTailWeight_nonneg (delta : ℝ) (m : ℕ) :
    0 ≤ totientLogDeficitTailWeight delta m := by
  unfold totientLogDeficitTailWeight
  exact Finset.sum_nonneg fun d _ => by positivity

theorem delta_log_mul_totientLogDeficitTailWeight_le
    (delta : ℝ) (m : ℕ) :
    (delta * Real.log m) * totientLogDeficitTailWeight delta m ≤
      ∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ) := by
  unfold totientLogDeficitTailWeight
  exact threshold_mul_totientDivisorEvent_le_logDeficitMoment
    m (fun d => delta * Real.log m ≤ Real.log (m / d : ℕ))
      (delta * Real.log m) (fun _ _ h => h)

lemma totientLogDeficitMoment_eq_mul_primeFactorDeficitMoment
    {m : ℕ} (hm : m ≠ 0) :
    (∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ)) =
      (m : ℝ) * primeFactorDeficitMoment m := by
  have h := normalizedTotientLogDeficitMoment_exact hm
  change
    (∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ)) / (m : ℝ) =
      primeFactorDeficitMoment m at h
  have hmR : (m : ℝ) ≠ 0 := by exact_mod_cast hm
  rw [div_eq_iff hmR] at h
  calc
    (∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ)) =
        primeFactorDeficitMoment m * (m : ℝ) := h
    _ = (m : ℝ) * primeFactorDeficitMoment m := mul_comm _ _

/-- Markov plus the exact `o(log m)` moment gives concentration for the
logarithmic-deficit event. -/
theorem totientLogDeficitTailWeight_isLittleO
    {delta : ℝ} (hdelta : 0 < delta) :
    (totientLogDeficitTailWeight delta) =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  rw [isLittleO_iff]
  intro c hc
  have hcoefficient : 0 < c * delta := mul_pos hc hdelta
  filter_upwards [eventually_ge_atTop 2,
      primeFactorDeficitMoment_isLittleO_log.bound hcoefficient]
      with m hm2 hmoment
  have hm0 : m ≠ 0 := by omega
  have hlogpos : 0 < Real.log m :=
    Real.log_pos (by exact_mod_cast hm2)
  have hmomentNonneg := primeFactorDeficitMoment_nonneg m
  rw [Real.norm_eq_abs, abs_of_nonneg hmomentNonneg,
    Real.norm_eq_abs, abs_of_nonneg hlogpos.le] at hmoment
  have hmarkov := delta_log_mul_totientLogDeficitTailWeight_le delta m
  rw [totientLogDeficitMoment_eq_mul_primeFactorDeficitMoment hm0] at hmarkov
  have hscaled :
      (m : ℝ) * primeFactorDeficitMoment m ≤
        (m : ℝ) * ((c * delta) * Real.log m) :=
    mul_le_mul_of_nonneg_left hmoment (by positivity)
  have hpositive : 0 < delta * Real.log m :=
    mul_pos hdelta hlogpos
  have htail : totientLogDeficitTailWeight delta m ≤ c * (m : ℝ) := by
    have hprod :
        (delta * Real.log m) * totientLogDeficitTailWeight delta m ≤
          (delta * Real.log m) * (c * (m : ℝ)) := by
      calc
      (delta * Real.log m) * totientLogDeficitTailWeight delta m ≤
          (m : ℝ) * primeFactorDeficitMoment m := hmarkov
      _ ≤ (m : ℝ) * ((c * delta) * Real.log m) := hscaled
      _ = (delta * Real.log m) * (c * (m : ℝ)) := by ring
    nlinarith
  rw [Real.norm_eq_abs,
    abs_of_nonneg (totientLogDeficitTailWeight_nonneg delta m),
    Real.norm_eq_abs, abs_of_nonneg (by positivity : (0 : ℝ) ≤ m)]
  exact htail

noncomputable def totientPowerSmallDivisorWeight
    (delta : ℝ) (m : ℕ) : ℝ :=
  ∑ d ∈ m.divisors with
    (fun d : ℕ => (d : ℝ) ≤ (m : ℝ) ^ (1 - delta)) d,
    (Nat.totient d : ℝ)

lemma totientPowerSmallDivisorWeight_nonneg (delta : ℝ) (m : ℕ) :
    0 ≤ totientPowerSmallDivisorWeight delta m := by
  unfold totientPowerSmallDivisorWeight
  exact Finset.sum_nonneg fun d _ => by positivity

/-- Every power-small divisor has logarithmic deficit at least
`delta * log m`. -/
theorem totientPowerSmallDivisorWeight_le_logTail
    {delta : ℝ} {m : ℕ} (hm : m ≠ 0) :
    totientPowerSmallDivisorWeight delta m ≤
      totientLogDeficitTailWeight delta m := by
  classical
  unfold totientPowerSmallDivisorWeight totientLogDeficitTailWeight
  apply Finset.sum_le_sum_of_subset_of_nonneg
  · intro d hd
    have hd' := Finset.mem_filter.mp hd
    have hddata := Nat.mem_divisors.mp hd'.1
    have hmpos : 0 < m := Nat.pos_of_ne_zero hm
    have hdpos : 0 < d := by
      by_contra h
      have hd0 : d = 0 := Nat.eq_zero_of_not_pos h
      subst d
      simp at hddata
    have hmR : (0 : ℝ) < (m : ℝ) := by exact_mod_cast hmpos
    have hdR : (0 : ℝ) < (d : ℝ) := by exact_mod_cast hdpos
    have hpowlog :
        Real.log d ≤ (1 - delta) * Real.log m := by
      calc
        Real.log d ≤ Real.log ((m : ℝ) ^ (1 - delta)) :=
          Real.log_le_log hdR hd'.2
        _ = (1 - delta) * Real.log m :=
          Real.log_rpow hmR (1 - delta)
    have hdR0 : (d : ℝ) ≠ 0 := hdR.ne'
    have hmR0 : (m : ℝ) ≠ 0 := hmR.ne'
    have hcastDiv : ((m / d : ℕ) : ℝ) = (m : ℝ) / (d : ℝ) :=
      Nat.cast_div hddata.1 hdR0
    apply Finset.mem_filter.mpr
    refine ⟨hd'.1, ?_⟩
    calc
      delta * Real.log m ≤ Real.log m - Real.log d := by linarith
      _ = Real.log ((m : ℝ) / (d : ℝ)) :=
        (Real.log_div hmR0 hdR0).symm
      _ = Real.log (m / d : ℕ) := by rw [← hcastDiv]
  · intro d _ _
    positivity

/-- Theorem 5.1: for fixed positive `delta`, totient weight on
`d <= m^(1-delta)` is `o(m)`. -/
theorem totientPowerSmallDivisorWeight_isLittleO
    {delta : ℝ} (hdelta : 0 < delta) :
    (totientPowerSmallDivisorWeight delta) =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  rw [isLittleO_iff]
  intro c hc
  filter_upwards [eventually_ge_atTop 1,
      (totientLogDeficitTailWeight_isLittleO hdelta).bound hc]
      with m hm1 htail
  have hm0 : m ≠ 0 := by omega
  have hle := totientPowerSmallDivisorWeight_le_logTail
    (delta := delta) hm0
  rw [Real.norm_eq_abs,
    abs_of_nonneg (totientLogDeficitTailWeight_nonneg delta m)] at htail
  rw [Real.norm_eq_abs,
    abs_of_nonneg (totientPowerSmallDivisorWeight_nonneg delta m)]
  exact hle.trans htail

/-- Totient weight of divisors whose logarithmic deficit crosses a
moving threshold `H m`. -/
noncomputable def totientMovingLogDeficitTailWeight
    (H : ℕ → ℝ) (m : ℕ) : ℝ :=
  ∑ d ∈ m.divisors with
    H m ≤ Real.log (m / d : ℕ),
    (Nat.totient d : ℝ)

/-- The moving logarithmic tail is exactly the generic localized totient
mass for its deficit predicate. -/
theorem totientMovingLogDeficitTailWeight_eq_restrictedTotientDivisorMass
    (H : ℕ → ℝ) :
    totientMovingLogDeficitTailWeight H =
      restrictedTotientDivisorMass
        (fun m d => H m ≤ Real.log (m / d : ℕ)) := by
  funext m
  rfl

lemma totientMovingLogDeficitTailWeight_nonneg
    (H : ℕ → ℝ) (m : ℕ) :
    0 ≤ totientMovingLogDeficitTailWeight H m := by
  unfold totientMovingLogDeficitTailWeight
  exact Finset.sum_nonneg fun d _ => by positivity

/-- Finite weighted Markov at an arbitrary moving threshold. -/
theorem movingThreshold_mul_totientMovingLogDeficitTailWeight_le
    (H : ℕ → ℝ) (m : ℕ) :
    H m * totientMovingLogDeficitTailWeight H m ≤
      ∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ) := by
  unfold totientMovingLogDeficitTailWeight
  exact threshold_mul_totientDivisorEvent_le_logDeficitMoment
    m (fun d => H m ≤ Real.log (m / d : ℕ)) (H m)
      (fun _ _ h => h)

/-- If the moving threshold is eventually positive and dominates
`log log (3m)`, then the totient weight beyond that threshold is `o(m)`.
The domination hypothesis is expressed as the Lean-friendly ratio
`log log (3m) / H(m) = o(1)`. -/
theorem totientMovingLogDeficitTailWeight_isLittleO
    (H : ℕ → ℝ)
    (hHpos : ∀ᶠ m in atTop, 0 < H m)
    (hratio :
      (fun m : ℕ =>
        Real.log (Real.log (3 * (m : ℝ))) / H m) =o[atTop]
          (fun _ : ℕ => (1 : ℝ))) :
    (totientMovingLogDeficitTailWeight H) =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  rw [isLittleO_iff]
  intro c hc
  obtain ⟨C, hC⟩ := (primeFactorDeficitMoment_isBigO_loglog).bound
  let B : ℝ := max C 1
  have hCB : C ≤ B := by exact le_max_left C 1
  have hBpos : 0 < B :=
    lt_of_lt_of_le zero_lt_one (le_max_right C 1)
  have hratioBound := hratio.bound (div_pos hc hBpos)
  filter_upwards [eventually_ge_atTop 1, hHpos, hC, hratioBound]
      with m hm hHm hmoment hratioM
  let L : ℝ := Real.log (Real.log (3 * (m : ℝ)))
  have hLpos : 0 < L := by
    dsimp [L]
    exact Real.log_pos (log_three_mul_nat_gt_one hm)
  have hmoment' :
      primeFactorDeficitMoment m ≤ C * L := by
    change ‖primeFactorDeficitMoment m‖ ≤ C * ‖L‖ at hmoment
    simpa only [Real.norm_eq_abs,
      abs_of_nonneg (primeFactorDeficitMoment_nonneg m),
      abs_of_nonneg hLpos.le] using hmoment
  have hmomentB :
      primeFactorDeficitMoment m ≤ B * L := by
    exact hmoment'.trans (mul_le_mul_of_nonneg_right hCB hLpos.le)
  have hratioNonneg : 0 ≤ L / H m :=
    div_nonneg hLpos.le hHm.le
  have hratioLe : L / H m ≤ c / B := by
    change ‖L / H m‖ ≤ (c / B) * ‖(1 : ℝ)‖ at hratioM
    simpa only [Real.norm_eq_abs, abs_of_nonneg hratioNonneg,
      norm_one, mul_one] using hratioM
  have hLle : L ≤ (c / B) * H m :=
    (div_le_iff₀ hHm).mp hratioLe
  have hBL : B * L ≤ c * H m := by
    calc
      B * L ≤ B * ((c / B) * H m) :=
        mul_le_mul_of_nonneg_left hLle hBpos.le
      _ = c * H m := by
        field_simp [hBpos.ne']
  have hmomentC : primeFactorDeficitMoment m ≤ c * H m :=
    hmomentB.trans hBL
  have hm0 : m ≠ 0 := by omega
  have hmarkov :=
    movingThreshold_mul_totientMovingLogDeficitTailWeight_le H m
  rw [totientLogDeficitMoment_eq_mul_primeFactorDeficitMoment hm0] at hmarkov
  have hprod :
      H m * totientMovingLogDeficitTailWeight H m ≤
        H m * (c * (m : ℝ)) := by
    calc
      H m * totientMovingLogDeficitTailWeight H m ≤
          (m : ℝ) * primeFactorDeficitMoment m := hmarkov
      _ ≤ (m : ℝ) * (c * H m) :=
        mul_le_mul_of_nonneg_left hmomentC (by positivity)
      _ = H m * (c * (m : ℝ)) := by ring
  have htail :
      totientMovingLogDeficitTailWeight H m ≤ c * (m : ℝ) :=
    le_of_mul_le_mul_left hprod hHm
  rw [Real.norm_eq_abs,
    abs_of_nonneg (totientMovingLogDeficitTailWeight_nonneg H m),
    Real.norm_eq_abs, abs_of_nonneg (by positivity : (0 : ℝ) ≤ m)]
  exact htail

/-- The concrete moving window `H(m) = (log log (3m))^2` satisfies the
ratio hypothesis automatically, so its totient-weighted tail is `o(m)`. -/
theorem totientMovingLogDeficitTailWeight_loglog_sq_isLittleO :
    (totientMovingLogDeficitTailWeight
      (fun m : ℕ => (Real.log (Real.log (3 * (m : ℝ)))) ^ 2)) =o[atTop]
        (fun m : ℕ => (m : ℝ)) := by
  apply totientMovingLogDeficitTailWeight_isLittleO
  · filter_upwards [eventually_ge_atTop 1] with m hm
    have hloglog :
        0 < Real.log (Real.log (3 * (m : ℝ))) :=
      Real.log_pos (log_three_mul_nat_gt_one hm)
    positivity
  · apply (isLittleO_one_iff ℝ).2
    have hinner :
        Tendsto (fun m : ℕ => Real.log (3 * (m : ℝ))) atTop atTop :=
      Real.tendsto_log_atTop.comp
        (Tendsto.const_mul_atTop (by norm_num : (0 : ℝ) < 3)
          tendsto_natCast_atTop_atTop)
    have houter :
        Tendsto (fun m : ℕ => Real.log (Real.log (3 * (m : ℝ))))
          atTop atTop :=
      Real.tendsto_log_atTop.comp hinner
    have hinv :
        Tendsto
          (fun m : ℕ => (Real.log (Real.log (3 * (m : ℝ))))⁻¹)
          atTop (𝓝 0) :=
      tendsto_inv_atTop_zero.comp houter
    apply Tendsto.congr' _ hinv
    filter_upwards [eventually_ge_atTop 1] with m hm
    have hloglog :
        0 < Real.log (Real.log (3 * (m : ℝ))) :=
      Real.log_pos (log_three_mul_nat_gt_one hm)
    field_simp [hloglog.ne']

#print axioms totientMovingLogDeficitTailWeight_eq_restrictedTotientDivisorMass
#print axioms totientMovingLogDeficitTailWeight_nonneg
#print axioms movingThreshold_mul_totientMovingLogDeficitTailWeight_le
#print axioms totientMovingLogDeficitTailWeight_isLittleO
#print axioms totientMovingLogDeficitTailWeight_loglog_sq_isLittleO
end FiniteMarkov
#print axioms primePowerDeficitMoment_eq_geomSum
#print axioms normalizedTotientLogDeficitMoment_exact
#print axioms primeFactorHarmonicLogSum_isBigO_loglog
#print axioms primeFactorHarmonicLogSum_isLittleO_log
#print axioms primeFactorDeficitMoment_isBigO_loglog
#print axioms primeFactorDeficitMoment_isLittleO_log
#print axioms threshold_mul_weightedEvent_le_moment
#print axioms totientLogDeficitTailWeight_isLittleO
#print axioms totientPowerSmallDivisorWeight_isLittleO
end ExactMoment

/-! ## Actual moving near-diagonal Mersenne gates -/

/-- The actual Mersenne endpoint is equivalent to exceptional totient mass
on the complement of any logarithmic-deficit window that grows faster than
`log log (3m)`.  The cyclotomic cap and the discarded-region estimate are
theorems here; only the displayed near-diagonal exceptional mass remains. -/
theorem log_mersennePowerLoss_isLittleO_iff_movingLogDeficitExceptional
    (H : ℕ → ℝ)
    (hHpos : ∀ᶠ m in atTop, 0 < H m)
    (hratio :
      (fun m : ℕ =>
        Real.log (Real.log (3 * (m : ℝ))) / H m) =o[atTop]
          (fun _ : ℕ => (1 : ℝ))) :
    ((fun m : ℕ => Real.log (mersennePowerLoss m : ℝ)) =o[atTop]
        (fun m : ℕ => (m : ℝ))) ↔
      (∀ threshold : ℝ, 0 < threshold →
        (fun m => restrictedExceptionalTotientDivisorMass
          mersenneCanonicalOrderBlockLogMass threshold
            (fun n d => ¬ H n ≤ Real.log (n / d : ℕ)) m) =o[atTop]
              (fun m : ℕ => (m : ℝ))) := by
  apply log_mersennePowerLoss_isLittleO_iff_localizedExceptional
    (fun n d => H n ≤ Real.log (n / d : ℕ)) (Real.log 3)
  · exact Real.log_nonneg (by norm_num)
  · exact mersenneCanonicalOrderBlockLogMass_le_cyclotomicCap
  · rw [← ExactMoment.totientMovingLogDeficitTailWeight_eq_restrictedTotientDivisorMass]
    exact ExactMoment.totientMovingLogDeficitTailWeight_isLittleO
      H hHpos hratio

#print axioms log_mersennePowerLoss_isLittleO_iff_movingLogDeficitExceptional

/-- Concrete unconditional localization at
`H(m) = (log log (3m))^2`. -/
theorem log_mersennePowerLoss_isLittleO_iff_loglogSquaredExceptional :
    ((fun m : ℕ => Real.log (mersennePowerLoss m : ℝ)) =o[atTop]
        (fun m : ℕ => (m : ℝ))) ↔
      (∀ threshold : ℝ, 0 < threshold →
        (fun m => restrictedExceptionalTotientDivisorMass
          mersenneCanonicalOrderBlockLogMass threshold
            (fun n d => ¬
              (Real.log (Real.log (3 * (n : ℝ)))) ^ 2 ≤
                Real.log (n / d : ℕ)) m) =o[atTop]
              (fun m : ℕ => (m : ℝ))) := by
  apply log_mersennePowerLoss_isLittleO_iff_localizedExceptional
    (fun n d =>
      (Real.log (Real.log (3 * (n : ℝ)))) ^ 2 ≤
        Real.log (n / d : ℕ)) (Real.log 3)
  · exact Real.log_nonneg (by norm_num)
  · exact mersenneCanonicalOrderBlockLogMass_le_cyclotomicCap
  · rw [← ExactMoment.totientMovingLogDeficitTailWeight_eq_restrictedTotientDivisorMass]
    exact ExactMoment.totientMovingLogDeficitTailWeight_loglog_sq_isLittleO

#print axioms log_mersennePowerLoss_isLittleO_iff_loglogSquaredExceptional

/-- The real-quotient deficit used by the localized bridge is exactly the
integer-quotient moment used by the arithmetic-function factorization. -/
theorem totientLogDeficitSum_eq_exactMoment {m : ℕ} (hm : m ≠ 0) :
    totientLogDeficitSum m =
      ∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ) := by
  classical
  unfold totientLogDeficitSum
  apply Finset.sum_congr rfl
  intro d hd
  have hddata := Nat.mem_divisors.mp hd
  have hmpos : 0 < m := Nat.pos_of_ne_zero hm
  have hdpos : 0 < d := Nat.pos_of_dvd_of_pos hddata.1 hmpos
  have hdR0 : (d : ℝ) ≠ 0 := by positivity
  have hcast : ((m / d : ℕ) : ℝ) = (m : ℝ) / (d : ℝ) :=
    Nat.cast_div hddata.1 hdR0
  rw [hcast]

#print axioms totientLogDeficitSum_eq_exactMoment

/-- Exact prime-factor factorization of the moment used by the localized
Markov bridge. -/
theorem totientLogDeficitSum_eq_mul_primeFactorDeficitMoment
    {m : ℕ} (hm : m ≠ 0) :
    totientLogDeficitSum m =
      (m : ℝ) * ExactMoment.primeFactorDeficitMoment m := by
  rw [totientLogDeficitSum_eq_exactMoment hm]
  exact ExactMoment.totientLogDeficitMoment_eq_mul_primeFactorDeficitMoment hm

#print axioms totientLogDeficitSum_eq_mul_primeFactorDeficitMoment

/-! ## Exact finite witness against unweighted divisor density -/

/-- A power of two has exactly `a+1` divisors. -/
theorem card_divisors_two_pow (a : ℕ) :
    (2 ^ a).divisors.card = a + 1 := by
  rw [Nat.divisors_prime_pow Nat.prime_two]
  simp

#print axioms card_divisors_two_pow

/-- The top singleton among the divisors of `2^(a+1)` has totient weight
exactly one half of the ambient index. -/
theorem totient_two_pow_succ_ratio (a : ℕ) :
    (Nat.totient (2 ^ (a + 1)) : ℝ) /
        (2 ^ (a + 1) : ℝ) = 1 / 2 := by
  rw [Nat.totient_prime_pow_succ Nat.prime_two]
  norm_num [pow_succ]
  have hp : (2 ^ a : ℝ) ≠ 0 := by positivity
  field_simp

#print axioms totient_two_pow_succ_ratio

end MersenneTotientDivisorConcentration20260901
end IUTThreeClosures
