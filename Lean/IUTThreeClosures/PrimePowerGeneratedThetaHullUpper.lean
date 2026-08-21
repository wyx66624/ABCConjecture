/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PrimePowerGeneratedThetaHullComponents
import IUTThreeClosures.PublicFreyTheorem110Bridge

/-!
# Prime-power generated theta hulls and the exact Theorem 1.10 coefficient

The finite-place component formula is now a theorem of the generated output
family: the actual public holomorphic theta hull is the componentwise-minimum
prime-power product, and its component volume is exactly `-m log p`.

This file packages only the genuinely separate archimedean estimates and the
finite-support condition.  It then constructs the public
`ThetaHullComponentUpperEstimate` automatically and connects the resulting
explicit procession average to the exact IUT IV, Theorem 1.10 coefficient.

Thus no finite-place component upper value is supplied by the caller.  The
remaining source calculation is an arithmetic inequality for the canonical
minimum exponents together with the actual archimedean contribution.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut
open scoped BigOperators

universe u v w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}
variable {G : GeneratedRHSData.{u, v, w} D}

/-- Canonical component upper value: the exact minimum-exponent value at a
finite rational place and the separately calculated archimedean value at the
unique infinite rational place. -/
noncomputable def generatedPrimePowerComponentUpper
    (A : GeneratedPrimePowerThetaHullData G)
    (archUpper : ∀ i : Fin G.container.proc.length,
      G.container.Components i .infinite → ℝ)
    (i : Fin G.container.proc.length) :
    (vQ : RationalPlace) → G.container.Components i vQ → ℝ
  | .finite p, c =>
      - (A.minimumExponent i p c : ℝ) * Real.log p
  | .infinite, c => archUpper i c

/-- The extra data not supplied by the finite prime-power theorem: an actual
archimedean component estimate and finite support of the resulting all-place
arithmetic upper sum. -/
structure GeneratedPrimePowerThetaHullUpperData
    (A : GeneratedPrimePowerThetaHullData G) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  archUpper : ∀ i : Fin G.container.proc.length,
    G.container.Components i .infinite → ℝ
  arch_component_le : ∀ i c,
    G.vol.componentVol i .infinite c
        (thetaHullComponentRegion (G.toRHSData) i .infinite c) ≤
      archUpper i c
  upper_finiteSupport : ∀ i,
    (Function.support fun vQ : RationalPlace =>
      ∑ c : G.container.Components i vQ,
        G.vol.packetWeight i vQ c *
          generatedPrimePowerComponentUpper A archUpper i vQ c).Finite

namespace GeneratedPrimePowerThetaHullUpperData

variable {A : GeneratedPrimePowerThetaHullData G}

/-- The public component upper estimate whose finite part is theorem-derived. -/
noncomputable def toEstimate
    (H : GeneratedPrimePowerThetaHullUpperData A) :
    ThetaHullComponentUpperEstimate (G.toRHSData) where
  upper := generatedPrimePowerComponentUpper A H.archUpper
  component_le := by
    intro i vQ c
    cases vQ with
    | finite p =>
        simpa [generatedPrimePowerComponentUpper] using
          (A.componentVol_thetaHull_finite_eq i p c).le
    | infinite =>
        simpa [generatedPrimePowerComponentUpper] using
          H.arch_component_le i c
  upper_finiteSupport := by
    intro i
    simpa [generatedPrimePowerComponentUpper] using
      H.upper_finiteSupport i

/-- Explicit finite-place weighted upper sum. -/
noncomputable def finitePacketUpper
    (H : GeneratedPrimePowerThetaHullUpperData A)
    (i : Fin G.container.proc.length) (p : Nat.Primes) : ℝ :=
  ∑ c : G.container.Components i (.finite p),
    G.vol.packetWeight i (.finite p) c *
      (- (A.minimumExponent i p c : ℝ) * Real.log p)

/-- The generated public estimate is definitionally the canonical
minimum-exponent sum at every finite rational place. -/
theorem packetUpperSum_finite_eq
    (H : GeneratedPrimePowerThetaHullUpperData A)
    (i : Fin G.container.proc.length) (p : Nat.Primes) :
    H.toEstimate.packetUpperSum i (.finite p) =
      H.finitePacketUpper i p := by
  rfl

/-- Explicit archimedean weighted upper sum. -/
noncomputable def archPacketUpper
    (H : GeneratedPrimePowerThetaHullUpperData A)
    (i : Fin G.container.proc.length) : ℝ :=
  ∑ c : G.container.Components i .infinite,
    G.vol.packetWeight i .infinite c * H.archUpper i c

/-- The infinite-place packet upper sum is exactly the supplied actual
archimedean component calculation. -/
theorem packetUpperSum_infinite_eq
    (H : GeneratedPrimePowerThetaHullUpperData A)
    (i : Fin G.container.proc.length) :
    H.toEstimate.packetUpperSum i .infinite =
      H.archPacketUpper i := by
  rfl

/-- The actual generated public theta coefficient is bounded by any arithmetic
expression that bounds the explicit minimum-exponent/archimedean procession
average. -/
theorem publicThetaCoefficient_le
    {Q : QPilotData D}
    (S : GeneratedNativeSource.{u, v, w} D Q)
    (A : GeneratedPrimePowerThetaHullData S.rhs)
    (H : GeneratedPrimePowerThetaHullUpperData A)
    (hq : 0 < Q.absLogQ)
    {B : ℝ}
    (hupper : H.toEstimate.processionUpperAverage ≤ Q.absLogQ * B) :
    publicThetaCoefficient S.toVariantData ≤ B := by
  exact H.toEstimate.publicThetaCoefficient_le_of_processionUpper hq hupper

/-- Exact Frey specialization: the generated minimum-exponent component
calculation, together with the printed Theorem 1.10 upper expression, gives the
canonical complete-packet q-bound. -/
theorem completeFreyJPacket_div_six_le
    {Q : QPilotData D}
    (S : GeneratedNativeSource.{u, v, w} D Q)
    (A : GeneratedPrimePowerThetaHullData S.rhs)
    (H : GeneratedPrimePowerThetaHullUpperData A)
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
    H.publicThetaCoefficient_le S A hq hcomponent
  exact theorem110_q_bound_of_publicTheta_upper
    S.toVariantData hq S.corollary312Variant
    hell (initialThetaModuliDegree_ge_one D)
    hdifferent (freyDiscriminantConductor_nonneg P) herror hcoeff

end GeneratedPrimePowerThetaHullUpperData

end IUTThreeClosures
