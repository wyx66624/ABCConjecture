/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Scalar orthogonality for irreducible symmetric theta kernels

For a symmetric matrix

`T(u,v,w) = [[u+v,w],[w,u-v]]`,

the characteristic discriminant is `4 * (v^2 + w^2)`, while its quadratic
form at `(x,y)` is

`u * (x^2+y^2) + v * (x^2-y^2) + 2*w*x*y`.

When the binary form `x^2+y^2` is anisotropic, every nonzero vector gives a
nonzero coefficient of `u`.  Thus any finite additive phase satisfying the
standard one-dimensional orthogonality relation has zero sum over `u`, even
after `(v,w)` is restricted to an arbitrary packet.  In particular it applies
to the packet where `v^2+w^2` is nonsquare, i.e. to the irreducible symmetric
matrices over a finite field in which `-1` is nonsquare.

The counting theorem for this packet and the absolutely convergent analytic
theta-series interchange are separate later layers.  No arithmetic source or
abc conclusion is assumed here.
-/

namespace IUTThreeClosures

/-- The discriminant of the characteristic polynomial of
`[[u+v,w],[w,u-v]]`. -/
theorem symmetricCharacteristicDiscriminant
    {R : Type*} [CommRing R]
    (u v w : R) :
    (2 * u) ^ 2 -
        4 * ((u + v) * (u - v) - w ^ 2) =
      4 * (v ^ 2 + w ^ 2) := by
  ring

/-- Evaluation of the symmetric quadratic form in scalar coordinates. -/
theorem symmetricQuadraticForm_expansion
    {R : Type*} [CommRing R]
    (u v w x y : R) :
    (u + v) * x ^ 2 + 2 * w * x * y +
        (u - v) * y ^ 2 =
      u * (x ^ 2 + y ^ 2) +
        (v * (x ^ 2 - y ^ 2) + 2 * w * x * y) := by
  ring

/-- Anisotropy of the binary sum-of-two-squares form.  Over a field this is
implied by nonsquareness of `-1`. -/
def SumSquaresAnisotropic
    (F : Type*) [Field F] : Prop :=
  ∀ x y : F, x ^ 2 + y ^ 2 = 0 → x = 0 ∧ y = 0

/-- A nonzero vector has nonzero sum-of-squares coefficient under the
anisotropy hypothesis. -/
theorem sumSquares_ne_zero_of_anisotropic
    {F : Type*} [Field F]
    (hA : SumSquaresAnisotropic F)
    {x y : F}
    (hxy : x ≠ 0 ∨ y ≠ 0) :
    x ^ 2 + y ^ 2 ≠ 0 := by
  intro hzero
  rcases hA x y hzero with ⟨hx, hy⟩
  exact hxy.elim (fun hxn => hxn hx) (fun hyn => hyn hy)

/-- Scalar phase argument attached to one symmetric matrix parameter triple. -/
def symmetricPhaseArgument
    {F : Type*} [Field F]
    (u v w x y : F) : F :=
  u * (x ^ 2 + y ^ 2) +
    (v * (x ^ 2 - y ^ 2) + 2 * w * x * y)

/-- One-dimensional additive-character orthogonality kills the sum over the
trace parameter `u` at every nonzero vector. -/
theorem sum_symmetricPhaseArgument_over_u_eq_zero
    {F A : Type*}
    [Fintype F] [Field F]
    [CommRing A]
    (phase : F → A)
    (hphase :
      ∀ a b : F, a ≠ 0 →
        ∑ u : F, phase (u * a + b) = 0)
    (hA : SumSquaresAnisotropic F)
    {x y : F}
    (hxy : x ≠ 0 ∨ y ≠ 0)
    (v w : F) :
    ∑ u : F,
      phase (symmetricPhaseArgument u v w x y) = 0 := by
  simpa [symmetricPhaseArgument] using
    hphase
      (x ^ 2 + y ^ 2)
      (v * (x ^ 2 - y ^ 2) + 2 * w * x * y)
      (sumSquares_ne_zero_of_anisotropic hA hxy)

/-- The same cancellation remains true after restricting `(v,w)` to any finite
packet.  This is the abstract finite core of the irreducible-symmetric theta
average. -/
theorem sum_symmetricPhaseArgument_over_packet_eq_zero
    {F A : Type*}
    [Fintype F] [Field F]
    [CommRing A]
    (phase : F → A)
    (hphase :
      ∀ a b : F, a ≠ 0 →
        ∑ u : F, phase (u * a + b) = 0)
    (hA : SumSquaresAnisotropic F)
    {x y : F}
    (hxy : x ≠ 0 ∨ y ≠ 0)
    (packet : Finset (F × F)) :
    ∑ vw ∈ packet,
      ∑ u : F,
        phase
          (symmetricPhaseArgument
            u vw.1 vw.2 x y) = 0 := by
  apply Finset.sum_eq_zero
  intro vw hvw
  exact sum_symmetricPhaseArgument_over_u_eq_zero
    phase hphase hA hxy vw.1 vw.2

/-- The finite packet of parameter pairs for which `v^2+w^2` is nonsquare. -/
noncomputable def irreducibleSymmetricPairPacket
    (F : Type*) [Fintype F] [Field F] :
    Finset (F × F) := by
  classical
  exact Finset.univ.filter fun vw : F × F =>
    ¬ IsSquare (vw.1 ^ 2 + vw.2 ^ 2)

/-- Orthogonality specialized to the irreducible-symmetric packet. -/
theorem sum_irreducibleSymmetricPhase_eq_zero
    {F A : Type*}
    [Fintype F] [Field F]
    [CommRing A]
    (phase : F → A)
    (hphase :
      ∀ a b : F, a ≠ 0 →
        ∑ u : F, phase (u * a + b) = 0)
    (hA : SumSquaresAnisotropic F)
    {x y : F}
    (hxy : x ≠ 0 ∨ y ≠ 0) :
    ∑ vw ∈ irreducibleSymmetricPairPacket F,
      ∑ u : F,
        phase
          (symmetricPhaseArgument
            u vw.1 vw.2 x y) = 0 :=
  sum_symmetricPhaseArgument_over_packet_eq_zero
    phase hphase hA hxy (irreducibleSymmetricPairPacket F)

end IUTThreeClosures
