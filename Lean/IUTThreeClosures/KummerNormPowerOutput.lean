/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.KummerUnitPowerRegions

/-!
# Exact local norm formulas imply the Kummer unit-times-power decomposition

For a local field with integral subring `O = {x | ‖x‖ ≤ 1}`, two nonzero
scalars with the same norm differ by an integral unit.  Consequently, if an
actual theta/Kummer value `x` satisfies

`‖x‖ = ‖q‖^n`,

then `x = u q^n` for a unique-enough unit `u ∈ Oˣ`, and hence `x O = q^n O`.

This is the form naturally produced by nonarchimedean theta-function analysis:
one only has to prove the norm of the actual output.  The unit decomposition,
region equality, componentwise-minimum hull, and packet log-volume formula are
then formal consequences.
-/

set_option linter.checkUnivs false

namespace Iut

universe u

namespace ScalarPowerRegion

/-- An element of norm one determines a unit of any subring identified with
the norm unit ball. -/
noncomputable def normOneUnitOfIntegralEq
    {F : Type u} [NormedField F]
    (O : Subring F)
    (hO : (O : Set F) = TateCurvesTheta.normIntegralRegion (K := F))
    (x : F) (hx : ‖x‖ = 1) : Oˣ := by
  have hx0 : x ≠ 0 := by
    intro h
    rw [h, norm_zero] at hx
    norm_num at hx
  refine
    { val := ⟨x, ?_⟩
      inv := ⟨x⁻¹, ?_⟩
      val_inv := ?_
      inv_val := ?_ }
  · change x ∈ (O : Set F)
    rw [hO]
    change ‖x‖ ≤ 1
    exact hx.le
  · change x⁻¹ ∈ (O : Set F)
    rw [hO]
    change ‖x⁻¹‖ ≤ 1
    rw [norm_inv, hx]
    norm_num
  · apply Subtype.ext
    change x * x⁻¹ = 1
    exact mul_inv_cancel₀ hx0
  · apply Subtype.ext
    change x⁻¹ * x = 1
    exact inv_mul_cancel₀ hx0

@[simp]
theorem coe_normOneUnitOfIntegralEq
    {F : Type u} [NormedField F]
    (O : Subring F)
    (hO : (O : Set F) = TateCurvesTheta.normIntegralRegion (K := F))
    (x : F) (hx : ‖x‖ = 1) :
    (((normOneUnitOfIntegralEq O hO x hx : Oˣ) : O) : F) = x := rfl

/-- Equal local norms give a unit-times-power decomposition. -/
theorem exists_unit_mul_pow_of_norm_eq
    {F : Type u} [NormedField F]
    (O : Subring F)
    (hO : (O : Set F) = TateCurvesTheta.normIntegralRegion (K := F))
    {q value : F} {n : ℕ}
    (hq : q ≠ 0) (hvalue : value ≠ 0)
    (hnorm : ‖value‖ = ‖q‖ ^ n) :
    ∃ unit : Oˣ, value = ((unit : O) : F) * q ^ n := by
  have hqNorm : ‖q‖ ≠ 0 := (norm_ne_zero_iff.mpr hq)
  have hqPowNorm : ‖q‖ ^ n ≠ 0 := pow_ne_zero _ hqNorm
  have hqPow : q ^ n ≠ 0 := pow_ne_zero _ hq
  have hratioNorm : ‖value / q ^ n‖ = 1 := by
    rw [norm_div, norm_pow, hnorm]
    exact div_self hqPowNorm
  let unit : Oˣ :=
    normOneUnitOfIntegralEq O hO (value / q ^ n) hratioNorm
  refine ⟨unit, ?_⟩
  change value = (value / q ^ n) * q ^ n
  exact (div_mul_cancel₀ value hqPow).symm

/-- The norm equality constructs the region-level Kummer witness used by the
actual Tate-power source. -/
noncomputable def UnitTimesPowerData.ofNormEq
    {F : Type u} [NormedField F]
    (O : Subring F)
    (hO : (O : Set F) = TateCurvesTheta.normIntegralRegion (K := F))
    {q value : F} (n : ℕ)
    (hq : q ≠ 0) (hvalue : value ≠ 0)
    (hnorm : ‖value‖ = ‖q‖ ^ n) :
    UnitTimesPowerData O q value := by
  rcases exists_unit_mul_pow_of_norm_eq O hO hq hvalue hnorm with
    ⟨unit, hunit⟩
  exact
    { unit := unit
      power := n
      value_eq := hunit }

end ScalarPowerRegion

end Iut

namespace IUTThreeClosures

open Iut TateCurvesTheta

universe u v w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}
variable {G : GeneratedRHSData.{u, v, w} D}

section NormedSummands

variable [∀ (i : Fin G.container.proc.length) (p : Nat.Primes)
  (c : G.container.Components i (.finite p)),
    NormedField ((G.container.packet i (.finite p)).Summand c)]

/-- Actual generated Kummer outputs specified by their exact local norms. -/
structure GeneratedTateKummerNormOutputData
    (G : GeneratedRHSData.{u, v, w} D) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  tate :
    (i : Fin G.container.proc.length) →
    (p : Nat.Primes) →
    (c : G.container.Components i (.finite p)) →
      TateParameter ((G.container.packet i (.finite p)).Summand c)
  integral_eq_normIntegral : ∀ i p c,
    ((G.container.packet i (.finite p)).integral c :
      Set ((G.container.packet i (.finite p)).Summand c)) =
        normIntegralRegion
          (K := (G.container.packet i (.finite p)).Summand c)
  value :
    (o : G.outputs.Output) →
    (i : Fin G.container.proc.length) →
    (p : Nat.Primes) →
    (c : G.container.Components i (.finite p)) →
      (G.container.packet i (.finite p)).Summand c
  value_ne_zero : ∀ o i p c, value o i p c ≠ 0
  power :
    (o : G.outputs.Output) →
    (i : Fin G.container.proc.length) →
    (p : Nat.Primes) →
      G.container.Components i (.finite p) → ℕ
  /-- The actual local theta/Kummer norm theorem. -/
  value_norm : ∀ o i p c,
    ‖value o i p c‖ =
      ‖((tate i p c).q :
        (G.container.packet i (.finite p)).Summand c)‖ ^
        power o i p c
  realize_finite : ∀ o i p,
    (G.outputs.realize o i).region (.finite p) =
      (G.container.packet i (.finite p)).productRegion fun c =>
        ScalarPowerRegion.principalRegion
          (value o i p c)
          ((G.container.packet i (.finite p)).integral c)

namespace GeneratedTateKummerNormOutputData

/-- Exact local norm formulas construct the unit-times-power Kummer source. -/
noncomputable def toKummerOutput
    (N : GeneratedTateKummerNormOutputData G) :
    GeneratedTateKummerOutputData G where
  tate := N.tate
  integral_eq_normIntegral := N.integral_eq_normIntegral
  value := N.value
  value_decomposition o i p c :=
    ScalarPowerRegion.UnitTimesPowerData.ofNormEq
      ((G.container.packet i (.finite p)).integral c)
      (N.integral_eq_normIntegral i p c)
      (N.power o i p c)
      (N.tate i p c).q.ne_zero
      (N.value_ne_zero o i p c)
      (N.value_norm o i p c)
  realize_finite := N.realize_finite

/-- Hence the generated theta hull is the product of the componentwise minimum
powers appearing in the exact local norm formulas. -/
theorem thetaHull_finite_eq_minimumNormPowers
    (N : GeneratedTateKummerNormOutputData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    ((G.toRHSData).thetaHull i).region (.finite p) =
      ScalarPowerRegion.packetScalarPowerRegion i p
        (fun c => ((N.tate i p c).q :
          (G.container.packet i (.finite p)).Summand c))
        (N.toKummerOutput.toTatePower.toScalarPower.minimumPower i p) :=
  N.toKummerOutput.thetaHull_finite_eq_minimumKummerPowers i p

end GeneratedTateKummerNormOutputData

end NormedSummands

end IUTThreeClosures
