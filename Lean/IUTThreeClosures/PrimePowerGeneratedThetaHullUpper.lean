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

Only the genuinely separate archimedean component estimate is supplied below.
Finite support of the all-place upper sum is proved from the common finite
support already carried by the generated output family: away from that support
the generated union and its holomorphic hull are the integral region, hence
the exact finite packet sum is zero.

The resulting public `ThetaHullComponentUpperEstimate` is therefore automatic
at every finite place.  Its explicit procession average is then connected to
the exact IUT IV, Theorem 1.10 coefficient and the complete Frey all-place
packet.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut
open scoped BigOperators

universe u v w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}
variable {G : GeneratedRHSData.{u, v, w} D}

/-- Outside the common finite support, the generated union is the public
integral region. -/
theorem generatedUnionRegion_eq_integral_of_not_mem_support
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

/-- Outside the common output support, the actual public holomorphic theta
hull is also the integral region. -/
theorem generatedThetaHull_eq_integral_of_not_mem_support
    (i : Fin G.container.proc.length) (vQ : RationalPlace)
    (hvQ : vQ ∉ G.outputs.support i) :
    ((G.toRHSData).thetaHull i).region vQ =
      (G.container.packet i vQ).integralRegion := by
  change
    (G.hull.system i vQ).hull
        ((G.outputs.unionRegion i).region vQ) =
      (G.container.packet i vQ).integralRegion
  rw [generatedUnionRegion_eq_integral_of_not_mem_support
    (G := G) i vQ hvQ]
  exact G.hull.hull_integralRegion (i := i) vQ

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

/-- The only extra component data not supplied by the finite prime-power
hull theorem: an actual archimedean component estimate. -/
structure GeneratedPrimePowerThetaHullUpperData
    (A : GeneratedPrimePowerThetaHullData G) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  archUpper : ∀ i : Fin G.container.proc.length,
    G.container.Components i .infinite → ℝ
  arch_component_le : ∀ i c,
    G.vol.componentVol i .infinite c
        (thetaHullComponentRegion (G.toRHSData) i .infinite c) ≤
      archUpper i c

namespace GeneratedPrimePowerThetaHullUpperData

variable {A : GeneratedPrimePowerThetaHullData G}

/-- The public component upper estimate whose finite part and finite support
are theorem-derived. -/
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
                (- (A.minimumExponent i p c : ℝ) * Real.log p)) = 0
          rw [← A.packetVol_thetaHull_finite_eq i p]
          rw [generatedThetaHull_eq_integral_of_not_mem_support
            (G := G) i (.finite p) hs]
          exact G.vol.packetVol_integral i (.finite p)

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

/-- The canonical finite-place upper sum vanishes away from the common output
support. -/
theorem finitePacketUpper_eq_zero_of_not_mem_support
    (H : GeneratedPrimePowerThetaHullUpperData A)
    (i : Fin G.container.proc.length) (p : Nat.Primes)
    (hp : RationalPlace.finite p ∉ G.outputs.support i) :
    H.finitePacketUpper i p = 0 := by
  rw [← A.packetVol_thetaHull_finite_eq i p]
  rw [generatedThetaHull_eq_integral_of_not_mem_support
    (G := G) i (.finite p) hp]
  exact G.vol.packetVol_integral i (.finite p)

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
