/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CubePartExponentWeight
import Mathlib.Tactic

/-!
# Every abc-height violation has a large cube part on one large endpoint

The two large coprime endpoints have radical weights whose sum is at most the
full abc conductor.  Hence one of them carries at most half of the conductor.
The cubic residue budget then forces a height-scale canonical cube root on
that endpoint.

Together with the simultaneous square-root theorem, this replaces the conic
frontier by a mixed `(2,3)` generalized-Fermat/Mordell frontier.  The result is
only a structural consequence of a hypothetical violation; it does not assume
or prove a uniform Mordell height estimate.
-/

namespace IUTThreeClosures
namespace LargeEndpointCubeRootSelector

noncomputable section

/-- Product form of the cube-root estimate for one endpoint whose radical
weight is at most half of the full conductor. -/
theorem endpoint_cubeRootScale_with_loss_product
    {epsilon C h R r q L : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hdouble : 2 * r ≤ R)
    (hroot : h - L - 2 * r ≤ 3 * q) :
    epsilon * h + C <
      3 * (1 + epsilon) * (q + L / 3) := by
  have hden : 0 < 1 + epsilon := by linarith
  have hscaled :=
    mul_le_mul_of_nonneg_left hdouble (le_of_lt hden)
  have hrviol : (1 + epsilon) * (2 * r) + C < h := by
    nlinarith
  have hroot' : h - 2 * r ≤ 3 * q + L := by linarith
  have hrootScaled :=
    mul_le_mul_of_nonneg_left hroot' (le_of_lt hden)
  nlinarith

/-- Normalized one-endpoint cube-root estimate. -/
theorem endpoint_cubeRootScale_with_loss
    {epsilon C h R r q L : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hdouble : 2 * r ≤ R)
    (hroot : h - L - 2 * r ≤ 3 * q) :
    (epsilon * h + C) / (3 * (1 + epsilon)) - L / 3 < q := by
  have hprod := endpoint_cubeRootScale_with_loss_product
    hepsilon hviolation hdouble hroot
  have hden : 0 < 3 * (1 + epsilon) := by positivity
  have hnorm :
      (epsilon * h + C) / (3 * (1 + epsilon)) < q + L / 3 := by
    apply (div_lt_iff₀ hden).2
    nlinarith
  linarith

/-- Pigeonhole selector for the two large endpoints.  The first endpoint may
incur an additive logarithmic loss `L`; the second has the full source height. -/
theorem one_large_endpoint_has_cubeRootScale
    {epsilon C h R r₁ r₂ q₁ q₂ L : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradicalSum : r₁ + r₂ ≤ R)
    (hroot₁ : h - L - 2 * r₁ ≤ 3 * q₁)
    (hroot₂ : h - 2 * r₂ ≤ 3 * q₂) :
    (epsilon * h + C) / (3 * (1 + epsilon)) - L / 3 < q₁ ∨
      (epsilon * h + C) / (3 * (1 + epsilon)) < q₂ := by
  by_cases hhalf : 2 * r₁ ≤ R
  · left
    exact endpoint_cubeRootScale_with_loss
      hepsilon hviolation hhalf hroot₁
  · right
    have hhalf₂ : 2 * r₂ ≤ R := by
      have hgt : R < 2 * r₁ := lt_of_not_ge hhalf
      linarith
    simpa using endpoint_cubeRootScale_with_loss
      (epsilon := epsilon) (C := C) (h := h) (R := R)
      (r := r₂) (q := q₂) (L := 0)
      hepsilon hviolation hhalf₂ (by simpa using hroot₂)

/-- Symmetric loss form, useful when both endpoint logarithms are known only
up to explicit additive constants. -/
theorem one_endpoint_has_cubeRootScale_with_two_losses
    {epsilon C h R r₁ r₂ q₁ q₂ L₁ L₂ : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradicalSum : r₁ + r₂ ≤ R)
    (hroot₁ : h - L₁ - 2 * r₁ ≤ 3 * q₁)
    (hroot₂ : h - L₂ - 2 * r₂ ≤ 3 * q₂) :
    (epsilon * h + C) / (3 * (1 + epsilon)) - L₁ / 3 < q₁ ∨
      (epsilon * h + C) / (3 * (1 + epsilon)) - L₂ / 3 < q₂ := by
  by_cases hhalf : 2 * r₁ ≤ R
  · left
    exact endpoint_cubeRootScale_with_loss
      hepsilon hviolation hhalf hroot₁
  · right
    have hhalf₂ : 2 * r₂ ≤ R := by
      have hgt : R < 2 * r₁ := lt_of_not_ge hhalf
      linarith
    exact endpoint_cubeRootScale_with_loss
      hepsilon hviolation hhalf₂ hroot₂

#print axioms endpoint_cubeRootScale_with_loss_product
#print axioms endpoint_cubeRootScale_with_loss
#print axioms one_large_endpoint_has_cubeRootScale
#print axioms one_endpoint_has_cubeRootScale_with_two_losses

end
end LargeEndpointCubeRootSelector
end IUTThreeClosures
