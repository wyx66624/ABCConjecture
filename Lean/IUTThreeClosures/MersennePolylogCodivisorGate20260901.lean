/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneTotientDivisorConcentration20260901

/-!
# The fixed-polylogarithmic co-divisor gate

The mathematical proofs precede this file in
`research/ABC_MERSENNE_POLYLOG_CODIVISOR_GATE_2026_09_01.md`.

For a positive integer `k`, this module localizes the normalized-large
Mersenne order blocks to co-divisors `q = m / d` satisfying

`log q < k * log (log (3m))`.

The finite Markov bound leaves an error at most `C / k` after normalization
by `m`.  Consequently, requiring little-oh for every fixed positive integer
`k` is equivalent to the full exceptional-mass endpoint: for a requested
error one first chooses one sufficiently large fixed `k`, and only then lets
`m` tend to infinity.  No unproved distribution statement, axiom, or
`sorry` is introduced.
-/

namespace IUTThreeClosures
namespace MersennePolylogCodivisorGate20260901

open Filter Asymptotics
open scoped BigOperators Topology
open MersenneOrderBlockAsymptotic20260901
open MersenneWeightedOrderTail20260901
open MersenneTotientDivisorConcentration20260901
open MersenneTotientDivisorConcentration20260901.ExactMoment

/-! ## Fixed polylogarithmic windows -/

/-- The positive logarithmic scale `log (log (3m))` used by the exact
totient-deficit moment estimate. -/
noncomputable def logLogScale (m : ℕ) : ℝ :=
  Real.log (Real.log (3 * (m : ℝ)))

/-- The deficit cutoff corresponding to a fixed positive integer
polylogarithmic co-divisor exponent. -/
noncomputable def fixedPolylogScale (k m : ℕ) : ℝ :=
  (k : ℝ) * logLogScale m

/-- Totient weight of the far co-divisor tail
`k * log (log (3m)) <= log (m / d)`. -/
noncomputable def polylogFarTotientMass (k m : ℕ) : ℝ :=
  totientMovingLogDeficitTailWeight (fixedPolylogScale k) m

/-- Exceptional totient weight in the strict fixed-polylogarithmic window
`log (m / d) < k * log (log (3m))`.  The negated non-strict inequality is
used so that this window and `polylogFarTotientMass` partition the divisor
set exactly, including the boundary. -/
noncomputable def polylogLocalizedExceptionalMass
    (mass : ℕ → ℝ) (threshold : ℝ) (k m : ℕ) : ℝ :=
  restrictedExceptionalTotientDivisorMass mass threshold
    (fun n d => ¬ fixedPolylogScale k n ≤ Real.log (n / d : ℕ)) m

lemma logLogScale_pos {m : ℕ} (hm : 1 ≤ m) :
    0 < logLogScale m := by
  unfold logLogScale
  exact Real.log_pos (log_three_mul_nat_gt_one hm)

lemma fixedPolylogScale_pos {k m : ℕ} (hk : 0 < k) (hm : 1 ≤ m) :
    0 < fixedPolylogScale k m := by
  unfold fixedPolylogScale
  exact mul_pos (by exact_mod_cast hk) (logLogScale_pos hm)

lemma polylogFarTotientMass_nonneg (k m : ℕ) :
    0 ≤ polylogFarTotientMass k m := by
  exact totientMovingLogDeficitTailWeight_nonneg
    (fixedPolylogScale k) m

lemma polylogLocalizedExceptionalMass_nonneg
    (mass : ℕ → ℝ) (threshold : ℝ) (k m : ℕ) :
    0 ≤ polylogLocalizedExceptionalMass mass threshold k m := by
  classical
  unfold polylogLocalizedExceptionalMass
    restrictedExceptionalTotientDivisorMass
  exact Finset.sum_nonneg fun _ _ => by positivity

/-! ## Exact finite decomposition and Markov bound -/

/-- The full exceptional mass splits exactly into its far part and its
strict fixed-polylogarithmic localization. -/
theorem totientExceptionalDivisorMass_eq_far_add_polylogLocalized
    (mass : ℕ → ℝ) (threshold : ℝ) (k m : ℕ) :
    totientExceptionalDivisorMass mass threshold m =
      restrictedExceptionalTotientDivisorMass mass threshold
        (fun n d => fixedPolylogScale k n ≤ Real.log (n / d : ℕ)) m +
      polylogLocalizedExceptionalMass mass threshold k m := by
  simpa only [polylogLocalizedExceptionalMass] using
    (totientExceptionalDivisorMass_eq_restricted_add_complement
      mass threshold
        (fun n d => fixedPolylogScale k n ≤ Real.log (n / d : ℕ)) m)

/-- A fixed-polylogarithmic localized exceptional mass is bounded by the
full exceptional mass. -/
theorem polylogLocalizedExceptionalMass_le_total
    (mass : ℕ → ℝ) (threshold : ℝ) (k m : ℕ) :
    polylogLocalizedExceptionalMass mass threshold k m ≤
      totientExceptionalDivisorMass mass threshold m := by
  exact restrictedExceptionalTotientDivisorMass_le_total
    mass threshold
      (fun n d => ¬ fixedPolylogScale k n ≤ Real.log (n / d : ℕ)) m

/-- The exceptional part of the far region is bounded by the full far
totient weight. -/
theorem farExceptionalMass_le_polylogFarTotientMass
    (mass : ℕ → ℝ) (threshold : ℝ) (k m : ℕ) :
    restrictedExceptionalTotientDivisorMass mass threshold
        (fun n d => fixedPolylogScale k n ≤ Real.log (n / d : ℕ)) m ≤
      polylogFarTotientMass k m := by
  simpa only [polylogFarTotientMass,
      totientMovingLogDeficitTailWeight_eq_restrictedTotientDivisorMass]
    using
      (restrictedExceptionalTotientDivisorMass_le_restrictedTotient
        mass threshold
          (fun n d => fixedPolylogScale k n ≤ Real.log (n / d : ℕ)) m)

/-- Finite approximation: the full exceptional mass is at most its strict
fixed-polylogarithmic localization plus the full far totient tail. -/
theorem totientExceptionalDivisorMass_le_polylogLocalized_add_far
    (mass : ℕ → ℝ) (threshold : ℝ) (k m : ℕ) :
    totientExceptionalDivisorMass mass threshold m ≤
      polylogLocalizedExceptionalMass mass threshold k m +
        polylogFarTotientMass k m := by
  have hfar := farExceptionalMass_le_polylogFarTotientMass
    mass threshold k m
  calc
    totientExceptionalDivisorMass mass threshold m =
        restrictedExceptionalTotientDivisorMass mass threshold
            (fun n d => fixedPolylogScale k n ≤ Real.log (n / d : ℕ)) m +
          polylogLocalizedExceptionalMass mass threshold k m :=
      totientExceptionalDivisorMass_eq_far_add_polylogLocalized
        mass threshold k m
    _ ≤ polylogFarTotientMass k m +
          polylogLocalizedExceptionalMass mass threshold k m :=
      add_le_add hfar (le_refl _)
    _ = polylogLocalizedExceptionalMass mass threshold k m +
        polylogFarTotientMass k m := add_comm _ _

/-- Finite weighted Markov inequality at a fixed-polylogarithmic cutoff. -/
theorem fixedPolylogScale_mul_polylogFarTotientMass_le_moment
    (k m : ℕ) :
    fixedPolylogScale k m * polylogFarTotientMass k m ≤
      ∑ d ∈ m.divisors,
        (Nat.totient d : ℝ) * Real.log (m / d : ℕ) := by
  exact movingThreshold_mul_totientMovingLogDeficitTailWeight_le
    (fixedPolylogScale k) m

/-- The finite `C / k` far-tail estimate.  It consumes a pointwise bound on
the normalized deficit moment and has no asymptotic premise. -/
theorem polylogFarTotientMass_le_constant_div
    {m k : ℕ} (hm : 1 ≤ m) (hk : 0 < k) {C : ℝ}
    (hmoment : primeFactorDeficitMoment m ≤ C * logLogScale m) :
    polylogFarTotientMass k m ≤ (C / (k : ℝ)) * (m : ℝ) := by
  have hm0 : m ≠ 0 := by omega
  have hkR : (0 : ℝ) < (k : ℝ) := by exact_mod_cast hk
  have hL : 0 < logLogScale m := logLogScale_pos hm
  have hmarkov :=
    fixedPolylogScale_mul_polylogFarTotientMass_le_moment k m
  rw [totientLogDeficitMoment_eq_mul_primeFactorDeficitMoment hm0]
      at hmarkov
  have hmomentScaled :
      (m : ℝ) * primeFactorDeficitMoment m ≤
        (m : ℝ) * (C * logLogScale m) :=
    mul_le_mul_of_nonneg_left hmoment (by positivity)
  have hprod :
      fixedPolylogScale k m * polylogFarTotientMass k m ≤
        fixedPolylogScale k m * ((C / (k : ℝ)) * (m : ℝ)) := by
    calc
      fixedPolylogScale k m * polylogFarTotientMass k m ≤
          (m : ℝ) * primeFactorDeficitMoment m := hmarkov
      _ ≤ (m : ℝ) * (C * logLogScale m) := hmomentScaled
      _ = fixedPolylogScale k m * ((C / (k : ℝ)) * (m : ℝ)) := by
        unfold fixedPolylogScale
        field_simp [hkR.ne']
  exact le_of_mul_le_mul_left hprod (fixedPolylogScale_pos hk hm)

#print axioms totientExceptionalDivisorMass_eq_far_add_polylogLocalized
#print axioms totientExceptionalDivisorMass_le_polylogLocalized_add_far
#print axioms fixedPolylogScale_mul_polylogFarTotientMass_le_moment
#print axioms polylogFarTotientMass_le_constant_div

/-! ## A general uniform-in-fixed-index transfer -/

/-- If every fixed positive-integer approximant is `o(m)` and the uniform
remainder is at most `C m / k`, then the nonnegative target is `o(m)`.
The proof records the indispensable quantifier order: choose `k` from the
requested error, then invoke the fixed-`k` little-oh statement. -/
theorem isLittleO_natCast_of_all_fixed_approximants
    (target : ℕ → ℝ) (approximant : ℕ → ℕ → ℝ) (C : ℝ)
    (htargetNonneg : ∀ m, 0 ≤ target m)
    (happroximantNonneg : ∀ k m, 0 ≤ approximant k m)
    (hC : 0 ≤ C)
    (hfixed : ∀ k : ℕ, 0 < k →
      approximant k =o[atTop] (fun m : ℕ => (m : ℝ)))
    (hcomparison : ∀ k : ℕ, 0 < k →
      ∀ᶠ m in atTop,
        target m ≤ approximant k m + (C / (k : ℝ)) * (m : ℝ)) :
    target =o[atTop] (fun m : ℕ => (m : ℝ)) := by
  rw [isLittleO_iff]
  intro c hc
  obtain ⟨k, hk⟩ := exists_nat_gt (2 * C / c : ℝ)
  have hcutoffNonneg : 0 ≤ 2 * C / c := by positivity
  have hkPosR : (0 : ℝ) < (k : ℝ) :=
    hcutoffNonneg.trans_lt hk
  have hkPos : 0 < k := by exact_mod_cast hkPosR
  have hCdiv : C / (k : ℝ) < c / 2 := by
    apply (div_lt_iff₀ hkPosR).2
    have hscaled := mul_lt_mul_of_pos_left hk (show 0 < c / 2 by positivity)
    have hleft : (c / 2) * (2 * C / c) = C := by
      field_simp
    rw [hleft] at hscaled
    simpa only [mul_comm] using hscaled
  have hhalf : 0 < c / 2 := by positivity
  filter_upwards [(hfixed k hkPos).bound hhalf,
      hcomparison k hkPos] with m happrox hcompare
  have happroxBound : approximant k m ≤ (c / 2) * (m : ℝ) := by
    simpa only [Real.norm_eq_abs,
      abs_of_nonneg (happroximantNonneg k m),
      abs_of_nonneg (show (0 : ℝ) ≤ (m : ℝ) by positivity)] using happrox
  have htailBound :
      (C / (k : ℝ)) * (m : ℝ) ≤ (c / 2) * (m : ℝ) :=
    mul_le_mul_of_nonneg_right hCdiv.le (by positivity)
  rw [Real.norm_eq_abs, abs_of_nonneg (htargetNonneg m),
    Real.norm_eq_abs,
      abs_of_nonneg (show (0 : ℝ) ≤ (m : ℝ) by positivity)]
  linarith

#print axioms isLittleO_natCast_of_all_fixed_approximants

/-! ## Uniform far-tail constant from the exact moment -/

/-- There is one positive constant that supplies the finite `C / k` bound
simultaneously for every positive integer `k`, eventually in `m`. -/
theorem exists_uniform_polylogFarTotientMass_bound :
    ∃ C : ℝ, 0 < C ∧
      ∀ᶠ m in atTop, ∀ k : ℕ, 0 < k →
        polylogFarTotientMass k m ≤
          (C / (k : ℝ)) * (m : ℝ) := by
  obtain ⟨C, hC⟩ := primeFactorDeficitMoment_isBigO_loglog.bound
  let B : ℝ := max C 1
  have hCB : C ≤ B := le_max_left C 1
  have hBpos : 0 < B :=
    lt_of_lt_of_le zero_lt_one (le_max_right C 1)
  refine ⟨B, hBpos, ?_⟩
  filter_upwards [eventually_ge_atTop 1, hC] with m hm hmoment
  intro k hk
  apply polylogFarTotientMass_le_constant_div hm hk
  have hL : 0 < logLogScale m := logLogScale_pos hm
  have hmomentC :
      primeFactorDeficitMoment m ≤ C * logLogScale m := by
    change ‖primeFactorDeficitMoment m‖ ≤ C * ‖logLogScale m‖ at hmoment
    simpa only [Real.norm_eq_abs,
      abs_of_nonneg (primeFactorDeficitMoment_nonneg m),
      abs_of_nonneg hL.le] using hmoment
  exact hmomentC.trans (mul_le_mul_of_nonneg_right hCB hL.le)

#print axioms exists_uniform_polylogFarTotientMass_bound

/-! ## Exceptional-mass and actual Mersenne equivalences -/

/-- For any fixed mass function and threshold, the full exceptional
totient mass is `o(m)` exactly when all positive-integer fixed-polylogarithmic
localizations are `o(m)`.  No pointwise cap on `mass` is needed for this
probabilistic localization statement. -/
theorem totientExceptionalDivisorMass_isLittleO_iff_all_fixedPolylogLocalized
    (mass : ℕ → ℝ) (threshold : ℝ) :
    ((fun m => totientExceptionalDivisorMass mass threshold m) =o[atTop]
        (fun m : ℕ => (m : ℝ))) ↔
      (∀ k : ℕ, 0 < k →
        (polylogLocalizedExceptionalMass mass threshold k) =o[atTop]
          (fun m : ℕ => (m : ℝ))) := by
  constructor
  · intro htotal k hk
    apply isLittleO_natCast_of_nonneg_le
      (polylogLocalizedExceptionalMass mass threshold k)
      (fun m => totientExceptionalDivisorMass mass threshold m)
    · exact polylogLocalizedExceptionalMass_nonneg mass threshold k
    · exact totientExceptionalDivisorMass_nonneg mass threshold
    · exact polylogLocalizedExceptionalMass_le_total mass threshold k
    · exact htotal
  · intro hfixed
    obtain ⟨C, hCpos, hfar⟩ :=
      exists_uniform_polylogFarTotientMass_bound
    apply isLittleO_natCast_of_all_fixed_approximants
      (fun m => totientExceptionalDivisorMass mass threshold m)
      (fun k m => polylogLocalizedExceptionalMass mass threshold k m) C
    · exact totientExceptionalDivisorMass_nonneg mass threshold
    · exact polylogLocalizedExceptionalMass_nonneg mass threshold
    · exact hCpos.le
    · exact hfixed
    · intro k hk
      filter_upwards [hfar] with m hfarM
      have hsplit :=
        totientExceptionalDivisorMass_le_polylogLocalized_add_far
          mass threshold k m
      have htail := hfarM k hk
      linarith

#print axioms totientExceptionalDivisorMass_isLittleO_iff_all_fixedPolylogLocalized

/-- The actual fixed-polylogarithmic co-divisor gate.  The logarithmic
Mersenne power loss is `o(m)` exactly when, for every positive normalized
threshold and every fixed positive integer `k`, the exceptional totient
mass with `log (m / d) < k * log (log (3m))` is `o(m)`. -/
theorem log_mersennePowerLoss_isLittleO_iff_all_fixedPolylogLocalized :
    ((fun m : ℕ => Real.log (mersennePowerLoss m : ℝ)) =o[atTop]
        (fun m : ℕ => (m : ℝ))) ↔
      (∀ threshold : ℝ, 0 < threshold →
        ∀ k : ℕ, 0 < k →
          (polylogLocalizedExceptionalMass
            mersenneCanonicalOrderBlockLogMass threshold k) =o[atTop]
              (fun m : ℕ => (m : ℝ))) := by
  rw [log_mersennePowerLoss_isLittleO_iff_divisorAverage]
  constructor
  · intro htotal threshold hthreshold
    have hglobal :=
      (divisorOrderBlockMassSum_isLittleO_iff_exceptionalTotientMass
        mersenneCanonicalOrderBlockLogMass (Real.log 3)
          mersenneCanonicalOrderBlockLogMass_nonneg
          (Real.log_nonneg (by norm_num))
          mersenneCanonicalOrderBlockLogMass_le_cyclotomicCap).mp
        htotal threshold hthreshold
    exact
      (totientExceptionalDivisorMass_isLittleO_iff_all_fixedPolylogLocalized
        mersenneCanonicalOrderBlockLogMass threshold).mp hglobal
  · intro hlocalized
    apply
      (divisorOrderBlockMassSum_isLittleO_iff_exceptionalTotientMass
        mersenneCanonicalOrderBlockLogMass (Real.log 3)
          mersenneCanonicalOrderBlockLogMass_nonneg
          (Real.log_nonneg (by norm_num))
          mersenneCanonicalOrderBlockLogMass_le_cyclotomicCap).mpr
    intro threshold hthreshold
    apply
      (totientExceptionalDivisorMass_isLittleO_iff_all_fixedPolylogLocalized
        mersenneCanonicalOrderBlockLogMass threshold).mpr
    exact hlocalized threshold hthreshold

#print axioms log_mersennePowerLoss_isLittleO_iff_all_fixedPolylogLocalized

end MersennePolylogCodivisorGate20260901
end IUTThreeClosures
