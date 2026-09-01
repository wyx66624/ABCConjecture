/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CanonicalPowerfulResidualCore
import Mathlib.Tactic

/-!
# Two-sided height ledger for the canonical exponent vectors

For a canonical powerful--residual decomposition write, logarithmically,

* `r` for the radical of the small gap,
* `a,b` for the two squarefree residuals,
* `u,v` for the two powerful moduli,
* `h` for the height of the large sum endpoint.

Thus `h = v+b`, while the opposite large endpoint gives
`h-L <= u+a` with `L = log 2`.  If

`(1+epsilon) * (r+a+b) + C < h`,

then both exponent vectors are individually height-scale.  More precisely,

`(1+epsilon)(r+a) + epsilon*b + C < v`,
`epsilon*a + (1+epsilon)(r+b) + C - L < u`.

The file contains only exact real-algebra consequences.  It does not assume an
abc estimate or an exponent-height bound.
-/

namespace IUTThreeClosures
namespace CanonicalExponentHeightLedger

noncomputable section

/-- The modulus on the sum endpoint must dominate the gap radical, the
opposite residual, and an epsilon fraction of its own residual. -/
theorem rightModulus_crossSupport_lower
    {epsilon C r a b v h : ℝ}
    (hheight : h = v + b)
    (hviolation : (1 + epsilon) * (r + a + b) + C < h) :
    (1 + epsilon) * (r + a) + epsilon * b + C < v := by
  rw [hheight] at hviolation
  nlinarith

/-- The modulus on the opposite large endpoint satisfies the symmetric
cross-support estimate, up to the explicit endpoint loss `L`. -/
theorem leftModulus_crossSupport_lower
    {epsilon C r a b u h L : ℝ}
    (hleftEndpoint : h - L ≤ u + a)
    (hviolation : (1 + epsilon) * (r + a + b) + C < h) :
    epsilon * a + (1 + epsilon) * (r + b) + C - L < u := by
  nlinarith

/-- Summing the two one-sided estimates gives a lower bound for the total
weighted exponent height. -/
theorem totalModulus_crossSupport_lower
    {epsilon C r a b u v h L : ℝ}
    (hheight : h = v + b)
    (hleftEndpoint : h - L ≤ u + a)
    (hviolation : (1 + epsilon) * (r + a + b) + C < h) :
    (1 + 2 * epsilon) * (a + b) +
        2 * (1 + epsilon) * r + 2 * C - L < u + v := by
  have hv := rightModulus_crossSupport_lower hheight hviolation
  have hu := leftModulus_crossSupport_lower hleftEndpoint hviolation
  nlinarith

/-- A violation forces the sum-endpoint exponent vector to carry a fixed
positive fraction of the total height.  This formulation uses only that its
squarefree residual is part of the full conductor. -/
theorem rightModulus_heightScale
    {epsilon C conductor b v h : ℝ}
    (hepsilon : 0 < epsilon)
    (hresidual : b ≤ conductor)
    (hheight : h = v + b)
    (hviolation : (1 + epsilon) * conductor + C < h) :
    epsilon * h + C < (1 + epsilon) * v := by
  nlinarith

/-- The opposite large-endpoint exponent vector is also height-scale, with the
explicit endpoint loss `L`. -/
theorem leftModulus_heightScale
    {epsilon C conductor a u h L : ℝ}
    (hepsilon : 0 < epsilon)
    (hresidual : a ≤ conductor)
    (hleftEndpoint : h - L ≤ u + a)
    (hviolation : (1 + epsilon) * conductor + C < h) :
    epsilon * h + C - (1 + epsilon) * L <
      (1 + epsilon) * u := by
  nlinarith

/-- Both canonical exponent vectors are simultaneously height-scale under any
putative abc violation. -/
theorem bothModuli_heightScale
    {epsilon C conductor a b u v h L : ℝ}
    (hepsilon : 0 < epsilon)
    (ha : a ≤ conductor)
    (hb : b ≤ conductor)
    (hheight : h = v + b)
    (hleftEndpoint : h - L ≤ u + a)
    (hviolation : (1 + epsilon) * conductor + C < h) :
    (epsilon * h + C < (1 + epsilon) * v) ∧
      (epsilon * h + C - (1 + epsilon) * L <
        (1 + epsilon) * u) := by
  exact ⟨rightModulus_heightScale hepsilon hb hheight hviolation,
    leftModulus_heightScale hepsilon ha hleftEndpoint hviolation⟩

/-- Contrapositive closure on the sum side: if the exponent height `v` does
not reach the forced threshold, the abc violation is impossible. -/
theorem height_le_of_rightModulus_not_heightScale
    {epsilon C conductor b v h : ℝ}
    (hepsilon : 0 < epsilon)
    (hresidual : b ≤ conductor)
    (hheight : h = v + b)
    (hmodulus : (1 + epsilon) * v ≤ epsilon * h + C) :
    h ≤ (1 + epsilon) * conductor + C := by
  nlinarith

/-- Contrapositive closure on the opposite large endpoint. -/
theorem height_le_of_leftModulus_not_heightScale
    {epsilon C conductor a u h L : ℝ}
    (hepsilon : 0 < epsilon)
    (hresidual : a ≤ conductor)
    (hleftEndpoint : h - L ≤ u + a)
    (hmodulus :
      (1 + epsilon) * u ≤
        epsilon * h + C - (1 + epsilon) * L) :
    h ≤ (1 + epsilon) * conductor + C := by
  nlinarith

#print axioms rightModulus_crossSupport_lower
#print axioms leftModulus_crossSupport_lower
#print axioms totalModulus_crossSupport_lower
#print axioms rightModulus_heightScale
#print axioms leftModulus_heightScale
#print axioms bothModuli_heightScale
#print axioms height_le_of_rightModulus_not_heightScale
#print axioms height_le_of_leftModulus_not_heightScale

end
end CanonicalExponentHeightLedger
end IUTThreeClosures
