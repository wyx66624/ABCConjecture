/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MultiDerivationExteriorEnergy
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

/-!
# The straight second-jet linear--quadratic system

This file diagonalizes the straight prime-monomial Hessian compatibility
condition.  On the first-order compatible hyperplane, second compatibility is
equivalent to an energy equation whose transverse term is the square of the
ordinary Wronskian direction.  Thus the second local powerful-part divisor is
real, but globally it does not create a second independent normal direction.

No small integral zero, abc estimate, local--global principle, or target
energy bound is assumed.
-/

namespace IUTThreeClosures

/-! ## Block moments -/

/-- Normalized Hessian of one prime block in terms of its logarithmic first
moment `L` and quadratic energy `E`.  For prime-monomial differentiation this
is exactly `H(n)/n = L^2-E`. -/
def normalizedPrimeBlockHessian (L E : ℚ) : ℚ :=
  L ^ 2 - E

/-- The elementary two-coordinate weighted variance identity. -/
theorem twoCoordinateWeightedVariance
    (e f u v : ℚ) :
    (e + f) * (e * u ^ 2 + f * v ^ 2) -
        (e * u + f * v) ^ 2 =
      e * f * (u - v) ^ 2 := by
  ring

/-- The standard two-coordinate internal direction has zero first moment and
an explicit positive quadratic energy (when the parameters are positive). -/
theorem twoCoordinateInternalDirection
    (e f t : ℚ) :
    e * (f * t) + f * (-e * t) = 0 ∧
      e * (f * t) ^ 2 + f * (-e * t) ^ 2 =
        e * f * (e + f) * t ^ 2 := by
  constructor <;> ring

/-! ## Exact diagonalization on the compatible hyperplane -/

/-- Weighted variance for the longitudinal values of an additive triple.
After first-order compatibility, the only transverse quadratic term is
`(La-Lb)^2`. -/
theorem compatibleLongitudinalVariance
    (a b c La Lb Lc : ℚ)
    (hsum : a + b = c)
    (hfirst : a * La + b * Lb = c * Lc) :
    c * (a * La ^ 2 + b * Lb ^ 2 - c * Lc ^ 2) =
      a * b * (La - Lb) ^ 2 := by
  calc
    c * (a * La ^ 2 + b * Lb ^ 2 - c * Lc ^ 2) =
        c * a * La ^ 2 + c * b * Lb ^ 2 -
          (c * Lc) ^ 2 := by ring
    _ = c * a * La ^ 2 + c * b * Lb ^ 2 -
          (a * La + b * Lb) ^ 2 := by rw [hfirst]
    _ = a * b * (La - Lb) ^ 2 := by
      rw [← hsum]
      ring

/-- First- and second-order compatibility force the exact energy balance.
This is the normalized form of the second-jet Wronskian-square identity. -/
theorem secondHessianCompatibility_energyBalance
    (a b c La Lb Lc Ea Eb Ec : ℚ)
    (hsum : a + b = c)
    (hfirst : a * La + b * Lb = c * Lc)
    (hsecond :
      a * normalizedPrimeBlockHessian La Ea +
          b * normalizedPrimeBlockHessian Lb Eb =
        c * normalizedPrimeBlockHessian Lc Ec) :
    c * (a * Ea + b * Eb - c * Ec) =
      a * b * (La - Lb) ^ 2 := by
  have heq :
      a * La ^ 2 + b * Lb ^ 2 - c * Lc ^ 2 =
        a * Ea + b * Eb - c * Ec := by
    unfold normalizedPrimeBlockHessian at hsecond
    linear_combination hsecond
  calc
    c * (a * Ea + b * Eb - c * Ec) =
        c * (a * La ^ 2 + b * Lb ^ 2 - c * Lc ^ 2) := by
      rw [heq]
    _ = a * b * (La - Lb) ^ 2 :=
      compatibleLongitudinalVariance a b c La Lb Lc hsum hfirst

/-- For nonzero `c`, the energy balance is not merely a consequence but is
equivalent to second Hessian compatibility. -/
theorem secondHessianCompatibility_iff_energyBalance
    (a b c La Lb Lc Ea Eb Ec : ℚ)
    (hc : c ≠ 0)
    (hsum : a + b = c)
    (hfirst : a * La + b * Lb = c * Lc) :
    (a * normalizedPrimeBlockHessian La Ea +
          b * normalizedPrimeBlockHessian Lb Eb =
        c * normalizedPrimeBlockHessian Lc Ec) ↔
      c * (a * Ea + b * Eb - c * Ec) =
        a * b * (La - Lb) ^ 2 := by
  constructor
  · exact secondHessianCompatibility_energyBalance
      a b c La Lb Lc Ea Eb Ec hsum hfirst
  · intro henergy
    have hvariance := compatibleLongitudinalVariance
      a b c La Lb Lc hsum hfirst
    have hcancelled :
        a * La ^ 2 + b * Lb ^ 2 - c * Lc ^ 2 =
          a * Ea + b * Eb - c * Ec := by
      apply mul_left_cancel₀ hc
      exact hvariance.trans henergy.symm
    unfold normalizedPrimeBlockHessian
    linear_combination hcancelled

/-! ## The global second-jet identity is a Wronskian square -/

/-- Without assuming second compatibility, its defect occurs with the exact
factor `abc`.  Setting the defect to zero recovers
`bc Γa + ac Γb - ab Γc = W^2`; hence the global second-order expression is
the old transverse scalar squared, not an independent exterior direction. -/
theorem secondJetDefectIdentity
    (P : ABCPoint) (Da Db Dc Ha Hb Hc : ℤ)
    (hD : Da + Db = Dc) :
    (P.b : ℤ) * P.c * arithmeticJetEnergy P.a Da Ha +
        (P.a : ℤ) * P.c * arithmeticJetEnergy P.b Db Hb -
        (P.a : ℤ) * P.b * arithmeticJetEnergy P.c Dc Hc +
        (P.a : ℤ) * P.b * P.c * (Ha + Hb - Hc) =
      arithmeticWronskian P Da Db ^ 2 := by
  have hsum : (P.a : ℤ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  unfold arithmeticJetEnergy arithmeticWronskian
  rw [← hsum, ← hD]
  ring

/-! ## Quantitative energy obstruction -/

/-- Finite weighted Cauchy--Schwarz in the exact moment form used by a prime
block.  In the application `e i` is a prime multiplicity, the first sum is
`L_n`, and the second weighted square sum is `E_n`. -/
theorem finiteWeightedMomentCauchy
    {ι : Type*} (s : Finset ι) (e x : ι → ℝ)
    (he : ∀ i ∈ s, 0 ≤ e i) :
    (∑ i ∈ s, e i * x i) ^ 2 ≤
      (∑ i ∈ s, e i) * ∑ i ∈ s, e i * x i ^ 2 := by
  apply Finset.sum_sq_le_sum_mul_sum_of_sq_le_mul s
  · exact he
  · intro i hi
    exact mul_nonneg (he i hi) (sq_nonneg _)
  · intro i hi
    ring_nf
    rfl

/-- Weighted Cauchy inequality for two prime blocks.  If `Ea,Eb` dominate
the squared first moments divided by their total multiplicities, then the
energy must dominate the square of the transverse gap. -/
theorem twoBlockMomentEnergyGap
    (oa ob Ea Eb La Lb : ℝ)
    (hoa : 0 < oa) (hob : 0 < ob)
    (ha : La ^ 2 ≤ oa * Ea)
    (hb : Lb ^ 2 ≤ ob * Eb) :
    (Lb - La) ^ 2 ≤ (oa + ob) * (Ea + Eb) := by
  have hoa0 : 0 ≤ oa := hoa.le
  have hob0 : 0 ≤ ob := hob.le
  have hoab0 : 0 ≤ oa + ob := add_nonneg hoa0 hob0
  have hscalea :
      ob * (oa + ob) * La ^ 2 ≤
        ob * (oa + ob) * (oa * Ea) :=
    mul_le_mul_of_nonneg_left ha (mul_nonneg hob0 hoab0)
  have hscaleb :
      oa * (oa + ob) * Lb ^ 2 ≤
        oa * (oa + ob) * (ob * Eb) :=
    mul_le_mul_of_nonneg_left hb (mul_nonneg hoa0 hoab0)
  have hmul :
      (oa * ob) * (Lb - La) ^ 2 ≤
        (oa * ob) * ((oa + ob) * (Ea + Eb)) := by
    nlinarith [sq_nonneg (ob * La + oa * Lb)]
  exact le_of_mul_le_mul_left hmul (mul_pos hoa hob)

/-- Endpoint-inclusive form of `twoBlockMomentEnergyGap`.  The extra energy
nonnegativity assumptions are automatic for genuine prime-block energies and
allow one or both blocks to be empty (`oa = 0` or `ob = 0`). -/
theorem twoBlockMomentEnergyGap_nonneg
    (oa ob Ea Eb La Lb : ℝ)
    (hoa : 0 ≤ oa) (hob : 0 ≤ ob)
    (hEa : 0 ≤ Ea) (hEb : 0 ≤ Eb)
    (ha : La ^ 2 ≤ oa * Ea)
    (hb : Lb ^ 2 ≤ ob * Eb) :
    (Lb - La) ^ 2 ≤ (oa + ob) * (Ea + Eb) := by
  rcases eq_or_lt_of_le hoa with hoa0 | hoa'
  · have hoa_eq : oa = 0 := hoa0.symm
    subst oa
    have ha0 : La ^ 2 ≤ 0 := by simpa using ha
    have hLaSq : La ^ 2 = 0 := le_antisymm ha0 (sq_nonneg La)
    have hLa : La = 0 := (sq_eq_zero_iff).mp hLaSq
    have hprod : ob * Eb ≤ ob * (Ea + Eb) := by
      exact mul_le_mul_of_nonneg_left (le_add_of_nonneg_left hEa) hob
    simpa [hLa] using hb.trans hprod
  · rcases eq_or_lt_of_le hob with hob0 | hob'
    · have hob_eq : ob = 0 := hob0.symm
      subst ob
      have hb0 : Lb ^ 2 ≤ 0 := by simpa using hb
      have hLbSq : Lb ^ 2 = 0 := le_antisymm hb0 (sq_nonneg Lb)
      have hLb : Lb = 0 := (sq_eq_zero_iff).mp hLbSq
      have hprod : oa * Ea ≤ oa * (Ea + Eb) := by
        exact mul_le_mul_of_nonneg_left (le_add_of_nonneg_right hEb) hoa
      simpa [hLb] using ha.trans hprod
    · exact twoBlockMomentEnergyGap oa ob Ea Eb La Lb hoa' hob' ha hb

/-- Any independently established square lower bound for the transverse gap
passes directly to the moment energy.  In the abc application the lower
bound is `(c / rad(abc))^2`, up to the nonzero integral quotient. -/
theorem transverseGapSquare_le_momentEnergy
    (oa ob Ea Eb La Lb q : ℝ)
    (hoa : 0 < oa) (hob : 0 < ob)
    (ha : La ^ 2 ≤ oa * Ea)
    (hb : Lb ^ 2 ≤ ob * Eb)
    (hgap : q ^ 2 ≤ (Lb - La) ^ 2) :
    q ^ 2 ≤ (oa + ob) * (Ea + Eb) :=
  hgap.trans (twoBlockMomentEnergyGap oa ob Ea Eb La Lb hoa hob ha hb)

/-- The abstract moment bound combined with the exact projected powerful-part
lattice.  A nonzero integral quotient forces the literal squared
`c / rad(abc)` gap into the energy; it is not an optional analytic loss. -/
theorem normalizedPowerfulGapSquare_le_momentEnergy
    (C ra rb : ℕ) (x y k : ℤ)
    (oa ob Ea Eb : ℝ)
    (hra : 0 < ra) (hrb : 0 < rb)
    (hk : (ra : ℤ) * y - (rb : ℤ) * x = (C : ℤ) * k)
    (hk0 : k ≠ 0)
    (hoa : 0 < oa) (hob : 0 < ob)
    (ha : ((x : ℝ) / (ra : ℝ)) ^ 2 ≤ oa * Ea)
    (hb : ((y : ℝ) / (rb : ℝ)) ^ 2 ≤ ob * Eb) :
    ((C : ℝ) / ((ra : ℝ) * (rb : ℝ))) ^ 2 ≤
      (oa + ob) * (Ea + Eb) := by
  let q : ℝ := (C : ℝ) / ((ra : ℝ) * (rb : ℝ))
  let La : ℝ := (x : ℝ) / (ra : ℝ)
  let Lb : ℝ := (y : ℝ) / (rb : ℝ)
  have hnormalized := normalizedPowerfulLatticeGap
    C ra rb x y k hra hrb hk
  have hdelta : Lb - La = q * (k : ℝ) := by
    dsimp [La, Lb, q]
    rw [hnormalized]
    ring
  have hkAbs : (1 : ℝ) ≤ |(k : ℝ)| := by
    exact_mod_cast Int.one_le_abs hk0
  have hkSq : (1 : ℝ) ≤ (k : ℝ) ^ 2 := by
    have hs := (sq_le_sq₀ (by norm_num : (0 : ℝ) ≤ 1)
      (abs_nonneg (k : ℝ))).2 hkAbs
    simpa only [one_pow, sq_abs] using hs
  have hgap : q ^ 2 ≤ (Lb - La) ^ 2 := by
    calc
      q ^ 2 = q ^ 2 * 1 := by ring
      _ ≤ q ^ 2 * (k : ℝ) ^ 2 :=
        mul_le_mul_of_nonneg_left hkSq (sq_nonneg q)
      _ = (Lb - La) ^ 2 := by rw [hdelta]; ring
  change q ^ 2 ≤ (oa + ob) * (Ea + Eb)
  exact transverseGapSquare_le_momentEnergy
    oa ob Ea Eb La Lb q hoa hob ha hb hgap

end IUTThreeClosures
