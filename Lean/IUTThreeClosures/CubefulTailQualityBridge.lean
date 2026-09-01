/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CrossSupportExponentDepth
import Mathlib.Tactic

/-!
# Cubeful-tail quality bridge

Suppose the two neighboring large endpoints have canonical layer
factorizations

`M = A*R`, `c = B*S`,
`A = D*A₀`, `R = D*U`,
`B = E*B₀`, `S = E*V`.

Here `D,E` are the repeated-prime layers, `A₀,B₀` are the radical primes used
only once, and `U,V` are the exponent tails beyond the square layer.  Then

`M*c*A₀*B₀*C^2 = (A*B*C)^2*U*V`.

When `M ≤ c ≤ 2M`, the square of the abc quality is, up to the sharp factor
`2`, the cubeful-tail ratio `U*V/(A₀*B₀*C^2)`.

This file proves the exact identity and both directions of the corresponding
inequality.  No abc estimate is assumed.
-/

namespace IUTThreeClosures
namespace CubefulTailQualityBridge

noncomputable section

/-- Exact multiplicative identity behind the cubeful-tail reformulation. -/
theorem endpointProduct_tailIdentity
    {M c A B C R S D E A₀ B₀ U V : ℝ}
    (hM : M = A * R)
    (hc : c = B * S)
    (hA : A = D * A₀)
    (hR : R = D * U)
    (hB : B = E * B₀)
    (hS : S = E * V) :
    M * c * A₀ * B₀ * C ^ 2 =
      (A * B * C) ^ 2 * U * V := by
  rw [hM, hc, hA, hR, hB, hS]
  ring

/-- Endpoint balance sandwiches the squared abc quality numerator between one
and two copies of the cubeful-tail numerator. -/
theorem qualitySquare_tailSandwich
    {M c A B C R S D E A₀ B₀ U V : ℝ}
    (hM : M = A * R)
    (hc : c = B * S)
    (hA : A = D * A₀)
    (hR : R = D * U)
    (hB : B = E * B₀)
    (hS : S = E * V)
    (hM_le_c : M ≤ c)
    (hc_le_twoM : c ≤ 2 * M)
    (hc_nonneg : 0 ≤ c)
    (hcore_nonneg : 0 ≤ A₀ * B₀ * C ^ 2) :
    (A * B * C) ^ 2 * U * V ≤
        c ^ 2 * A₀ * B₀ * C ^ 2 ∧
      c ^ 2 * A₀ * B₀ * C ^ 2 ≤
        2 * (A * B * C) ^ 2 * U * V := by
  have hid := endpointProduct_tailIdentity (C := C) hM hc hA hR hB hS
  have hMc : M * c ≤ c * c :=
    mul_le_mul_of_nonneg_right hM_le_c hc_nonneg
  have hcc : c * c ≤ (2 * M) * c :=
    mul_le_mul_of_nonneg_right hc_le_twoM hc_nonneg
  have hMcCore := mul_le_mul_of_nonneg_right hMc hcore_nonneg
  have hccCore := mul_le_mul_of_nonneg_right hcc hcore_nonneg
  constructor
  · calc
      (A * B * C) ^ 2 * U * V =
          M * c * A₀ * B₀ * C ^ 2 := hid.symm
      _ = (M * c) * (A₀ * B₀ * C ^ 2) := by ring
      _ ≤ (c * c) * (A₀ * B₀ * C ^ 2) := hMcCore
      _ = c ^ 2 * A₀ * B₀ * C ^ 2 := by ring
  · calc
      c ^ 2 * A₀ * B₀ * C ^ 2 =
          (c * c) * (A₀ * B₀ * C ^ 2) := by ring
      _ ≤ ((2 * M) * c) * (A₀ * B₀ * C ^ 2) := hccCore
      _ = 2 * (M * c * A₀ * B₀ * C ^ 2) := by ring
      _ = 2 * ((A * B * C) ^ 2 * U * V) := by rw [hid]
      _ = 2 * (A * B * C) ^ 2 * U * V := by ring

/-- A bound for the cubeful tail gives the corresponding squared abc-quality
bound, with only the endpoint-balance factor `2`. -/
theorem tailBound_implies_qualitySquareBound
    {M c A B C R S D E A₀ B₀ U V H : ℝ}
    (hM : M = A * R)
    (hc : c = B * S)
    (hA : A = D * A₀)
    (hR : R = D * U)
    (hB : B = E * B₀)
    (hS : S = E * V)
    (hM_le_c : M ≤ c)
    (hc_le_twoM : c ≤ 2 * M)
    (hc_nonneg : 0 ≤ c)
    (hcore_pos : 0 < A₀ * B₀ * C ^ 2)
    (htail : U * V ≤ H * (A₀ * B₀ * C ^ 2)) :
    c ^ 2 ≤ 2 * H * (A * B * C) ^ 2 := by
  have hsandwich := qualitySquare_tailSandwich
    hM hc hA hR hB hS hM_le_c hc_le_twoM hc_nonneg hcore_pos.le
  have hmul :
      c ^ 2 * (A₀ * B₀ * C ^ 2) ≤
        (2 * H * (A * B * C) ^ 2) *
          (A₀ * B₀ * C ^ 2) := by
    calc
      c ^ 2 * (A₀ * B₀ * C ^ 2) ≤
          2 * (A * B * C) ^ 2 * U * V := by
            simpa [mul_assoc] using hsandwich.2
      _ ≤ (2 * H * (A * B * C) ^ 2) *
          (A₀ * B₀ * C ^ 2) := by
        nlinarith
  nlinarith [hmul]

/-- Conversely, a squared abc-quality bound controls the cubeful tail with no
factor loss. -/
theorem qualitySquareBound_implies_tailBound
    {M c A B C R S D E A₀ B₀ U V H : ℝ}
    (hM : M = A * R)
    (hc : c = B * S)
    (hA : A = D * A₀)
    (hR : R = D * U)
    (hB : B = E * B₀)
    (hS : S = E * V)
    (hM_le_c : M ≤ c)
    (hc_le_twoM : c ≤ 2 * M)
    (hc_nonneg : 0 ≤ c)
    (hcore_nonneg : 0 ≤ A₀ * B₀ * C ^ 2)
    (hrad_pos : 0 < (A * B * C) ^ 2)
    (hquality : c ^ 2 ≤ H * (A * B * C) ^ 2) :
    U * V ≤ H * (A₀ * B₀ * C ^ 2) := by
  have hsandwich := qualitySquare_tailSandwich
    hM hc hA hR hB hS hM_le_c hc_le_twoM hc_nonneg hcore_nonneg
  have hmul :
      (A * B * C) ^ 2 * (U * V) ≤
        (A * B * C) ^ 2 *
          (H * (A₀ * B₀ * C ^ 2)) := by
    calc
      (A * B * C) ^ 2 * (U * V) =
          (A * B * C) ^ 2 * U * V := by ring
      _ ≤ c ^ 2 * A₀ * B₀ * C ^ 2 := by
        simpa [mul_assoc] using hsandwich.1
      _ ≤ (A * B * C) ^ 2 *
          (H * (A₀ * B₀ * C ^ 2)) := by
        nlinarith
  nlinarith [hmul]

/-- In particular, the critical tail inequality `U*V ≤ A₀*B₀*C^2` yields a
uniform quality bound with constant `sqrt 2` after taking square roots.  The
squared form avoids introducing analytic square-root machinery. -/
theorem criticalTailBound_implies_qualitySquareBound
    {M c A B C R S D E A₀ B₀ U V : ℝ}
    (hM : M = A * R)
    (hc : c = B * S)
    (hA : A = D * A₀)
    (hR : R = D * U)
    (hB : B = E * B₀)
    (hS : S = E * V)
    (hM_le_c : M ≤ c)
    (hc_le_twoM : c ≤ 2 * M)
    (hc_nonneg : 0 ≤ c)
    (hcore_pos : 0 < A₀ * B₀ * C ^ 2)
    (htail : U * V ≤ A₀ * B₀ * C ^ 2) :
    c ^ 2 ≤ 2 * (A * B * C) ^ 2 := by
  simpa using tailBound_implies_qualitySquareBound
    hM hc hA hR hB hS hM_le_c hc_le_twoM hc_nonneg
      hcore_pos (H := 1) (by simpa using htail)

#print axioms endpointProduct_tailIdentity
#print axioms qualitySquare_tailSandwich
#print axioms tailBound_implies_qualitySquareBound
#print axioms qualitySquareBound_implies_tailBound
#print axioms criticalTailBound_implies_qualitySquareBound

end
end CubefulTailQualityBridge
end IUTThreeClosures
