/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.KummerUnitPowerRegions
import IUTThreeClosures.PublicFreyTheorem110Bridge

/-!
# Actual Tate--Kummer component volumes and the Theorem 1.10 coefficient

The finite-place part of the public theta-hull estimate is now completely
source-derived under the local Tate/Kummer hypotheses:

1. every concrete Kummer value is an integral unit times `q_v^n`;
2. integral units do not change the principal fractional-ideal region;
3. the public holomorphic hull is the product of the componentwise minimum
   Tate powers;
4. the local Haar theorem gives the literal component volume
   `n * log ‖q_v‖`;
5. packet and procession sums use the public positive weights.

Only the genuinely independent archimedean component calculation is supplied
below.  Finite support is proved from the common support already carried by the
generated output family.  An arithmetic upper bound for the resulting explicit
procession average then gives the public theta-coefficient upper bound and the
exact Frey specialization of IUT IV, Theorem 1.10.

No finite-place component value, theta coefficient, main-term estimate, height
inequality, or `ABCConjecture` is a field of these structures.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut TateCurvesTheta
open scoped BigOperators

universe u v w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}
variable {G : GeneratedRHSData.{u, v, w} D}

section NormedSummands

variable [∀ (i : Fin G.container.proc.length) (p : Nat.Primes)
  (c : G.container.Components i (.finite p)),
    NormedField ((G.container.packet i (.finite p)).Summand c)]

/-- Outside the common finite support, the generated union is the public
integral region. -/
theorem tateGeneratedUnionRegion_eq_integral_of_not_mem_support
    (i : Fin G.container.proc.length) (vQ : RationalPlace)
    (hvQ : vQ ∉ G.outputs.support i) :
    (G.outputs.unionRegion i).region vQ =
      (G.container.packet i vQ).integralRegion := by
  classical
  ext x
  constructor
  · intro hx
    rcases Set.mem_iUnion.mp hx with ⟨o, hx⟩
    have h := G.outputs.realize_eq_integral_outside o i vQ hvQ
    rw [h] at hx
    exact hx
  · intro hx
    let o : G.outputs.Output := Classical.choice G.outputs.outputNonempty
    apply Set.mem_iUnion.mpr
    refine ⟨o, ?_⟩
    have h := G.outputs.realize_eq_integral_outside o i vQ hvQ
    rw [h]
    exact hx

/-- Outside the common support, the public holomorphic theta hull is also the
integral region. -/
theorem tateGeneratedThetaHull_eq_integral_of_not_mem_support
    (i : Fin G.container.proc.length) (vQ : RationalPlace)
    (hvQ : vQ ∉ G.outputs.support i) :
    ((G.toRHSData).thetaHull i).region vQ =
      (G.container.packet i vQ).integralRegion := by
  change
    (G.hull.system i vQ).hull
        ((G.outputs.unionRegion i).region vQ) =
      (G.container.packet i vQ).integralRegion
  rw [tateGeneratedUnionRegion_eq_integral_of_not_mem_support
    (G := G) i vQ hvQ]
  exact G.hull.hull_integralRegion (i := i) vQ

/-- Exact finite-place upper value obtained from the componentwise minimum
actual Tate power. -/
noncomputable def generatedTateComponentUpper
    (K : GeneratedTateKummerOutputData G)
    (archUpper : ∀ i : Fin G.container.proc.length,
      G.container.Components i .infinite → ℝ)
    (i : Fin G.container.proc.length) :
    (vQ : RationalPlace) → G.container.Components i vQ → ℝ
  | .finite p, c =>
      (K.toTatePower.toScalarPower.minimumPower i p c : ℝ) *
        Real.log ‖((K.tate i p c).q :
          (G.container.packet i (.finite p)).Summand c)‖
  | .infinite, c => archUpper i c

/-- The only component estimate not supplied by the finite Tate/Kummer/Haar
calculation is the actual archimedean component estimate. -/
structure GeneratedTateKummerThetaHullUpperData
    (K : GeneratedTateKummerOutputData G)
    (V : GeneratedTatePowerLogVolumeData K.toTatePower) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  archUpper : ∀ i : Fin G.container.proc.length,
    G.container.Components i .infinite → ℝ
  arch_component_le : ∀ i c,
    G.vol.componentVol i .infinite c
        (thetaHullComponentRegion (G.toRHSData) i .infinite c) ≤
      archUpper i c

namespace GeneratedTateKummerThetaHullUpperData

variable {K : GeneratedTateKummerOutputData G}
variable {V : GeneratedTatePowerLogVolumeData K.toTatePower}

/-- The public component upper estimate whose entire finite part and finite
support are derived from the actual generated Tate/Kummer outputs. -/
noncomputable def toEstimate
    (H : GeneratedTateKummerThetaHullUpperData K V) :
    ThetaHullComponentUpperEstimate (G.toRHSData) where
  upper := generatedTateComponentUpper K H.archUpper
  component_le := by
    intro i vQ c
    cases vQ with
    | finite p =>
        simpa [generatedTateComponentUpper] using
          (V.componentVol_thetaHull_finite_eq i p c).le
    | infinite =>
        simpa [generatedTateComponentUpper] using
          H.arch_component_le i c
  upper_finiteSupport := by
    intro i
    have hfinite :
        ((G.outputs.support i : Set RationalPlace) ∪
          ({RationalPlace.infinite} : Set RationalPlace)).Finite :=
      (G.outputs.support i).finite_toSet.union (Set.finite_singleton _)
    refine hfinite.subset ?_
    intro vQ hv
    by_cases hs : vQ ∈ G.outputs.support i
    · exact Or.inl (by simpa using hs)
    · cases vQ with
      | infinite =>
          exact Or.inr (by simp)
      | finite p =>
          exfalso
          apply hv
          change
            (∑ c : G.container.Components i (.finite p),
              G.vol.packetWeight i (.finite p) c *
                ((K.toTatePower.toScalarPower.minimumPower i p c : ℝ) *
                  Real.log ‖((K.tate i p c).q :
                    (G.container.packet i (.finite p)).Summand c)‖)) = 0
          rw [← V.packetVol_thetaHull_finite_eq i p]
          rw [tateGeneratedThetaHull_eq_integral_of_not_mem_support
            (G := G) i (.finite p) hs]
          exact G.vol.packetVol_integral i (.finite p)

/-- Explicit finite-place packet upper sum. -/
noncomputable def finitePacketUpper
    (H : GeneratedTateKummerThetaHullUpperData K V)
    (i : Fin G.container.proc.length) (p : Nat.Primes) : ℝ :=
  ∑ c : G.container.Components i (.finite p),
    G.vol.packetWeight i (.finite p) c *
      ((K.toTatePower.toScalarPower.minimumPower i p c : ℝ) *
        Real.log ‖((K.tate i p c).q :
          (G.container.packet i (.finite p)).Summand c)‖)

/-- The public finite packet upper sum is definitionally the actual
minimum-Tate-power expression. -/
theorem packetUpperSum_finite_eq
    (H : GeneratedTateKummerThetaHullUpperData K V)
    (i : Fin G.container.proc.length) (p : Nat.Primes) :
    H.toEstimate.packetUpperSum i (.finite p) =
      H.finitePacketUpper i p := by
  rfl

/-- The exact finite Tate packet sum vanishes away from the common generated
output support. -/
theorem finitePacketUpper_eq_zero_of_not_mem_support
    (H : GeneratedTateKummerThetaHullUpperData K V)
    (i : Fin G.container.proc.length) (p : Nat.Primes)
    (hp : RationalPlace.finite p ∉ G.outputs.support i) :
    H.finitePacketUpper i p = 0 := by
  rw [← V.packetVol_thetaHull_finite_eq i p]
  rw [tateGeneratedThetaHull_eq_integral_of_not_mem_support
    (G := G) i (.finite p) hp]
  exact G.vol.packetVol_integral i (.finite p)

/-- The actual generated public theta coefficient is bounded by every
arithmetic expression that bounds the explicit Tate/archimedean procession
average. -/
theorem publicThetaCoefficient_le
    {Q : QPilotData D}
    (S : GeneratedNativeSource.{u, v, w} D Q)
    (K : GeneratedTateKummerOutputData S.rhs)
    (V : GeneratedTatePowerLogVolumeData K.toTatePower)
    (H : GeneratedTateKummerThetaHullUpperData K V)
    (hq : 0 < Q.absLogQ)
    {B : ℝ}
    (hupper : H.toEstimate.processionUpperAverage ≤ Q.absLogQ * B) :
    publicThetaCoefficient S.toVariantData ≤ B := by
  exact H.toEstimate.publicThetaCoefficient_le_of_processionUpper hq hupper

/-- Frey specialization: an arithmetic bound on the explicit actual
Tate/Kummer/archimedean procession average gives the exact Theorem 1.10
complete-packet q-bound. -/
theorem completeFreyJPacket_div_six_le
    {Q : QPilotData D}
    (S : GeneratedNativeSource.{u, v, w} D Q)
    (K : GeneratedTateKummerOutputData S.rhs)
    (V : GeneratedTatePowerLogVolumeData K.toTatePower)
    (H : GeneratedTateKummerThetaHullUpperData K V)
    (P : ABCPoint)
    (hq : 0 < Q.absLogQ)
    (hell : 7 ≤ initialThetaEllReal D)
    {different error : ℝ}
    (hdifferent : 0 ≤ different)
    (herror : 0 ≤ error)
    (hcomponent :
      H.toEstimate.processionUpperAverage ≤
        Q.absLogQ *
          theorem110ThetaUpper
            (initialThetaEllReal D)
            (initialThetaModuliDegree D)
            Q.absLogQ
            different
            P.freyDiscriminantConductor
            error
            (completeGlobalJPacket ℚ (abcFreyCurve P).j)) :
    completeGlobalJPacket ℚ (abcFreyCurve P).j / 6 ≤
      (1 + 20 * initialThetaModuliDegree D /
          initialThetaEllReal D) *
        (different + P.freyDiscriminantConductor) +
      20 * error := by
  have hcoeff :
      publicThetaCoefficient S.toVariantData ≤
        theorem110ThetaUpper
          (initialThetaEllReal D)
          (initialThetaModuliDegree D)
          Q.absLogQ
          different
          P.freyDiscriminantConductor
          error
          (completeGlobalJPacket ℚ (abcFreyCurve P).j) :=
    H.publicThetaCoefficient_le S K V hq hcomponent
  exact theorem110_q_bound_of_publicTheta_upper
    S.toVariantData hq S.corollary312Variant
    hell (initialThetaModuliDegree_ge_one D)
    hdifferent (freyDiscriminantConductor_nonneg P) herror hcoeff

end GeneratedTateKummerThetaHullUpperData

end NormedSummands

end IUTThreeClosures
