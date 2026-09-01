/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Descent ledger for the exact square-collapse branch

In the zero right-contact branch the canonical equation collapses to
`1 + (S^2-1) = S^2` with `S` squarefree.  Factoring `S^2-1` produces a
strictly smaller neighboring abc triple whose radical is the radical of the
old left endpoint, up to a fixed factor two.

The scalar theorem below records the exact logarithmic transfer: if the
smaller triple controls the left-endpoint radical with only an additive loss
`kappa`, and `kappa` is absorbed by `epsilon*log S`, then the square endpoint
already satisfies the desired abc slope.  This is intended for a minimal-
height descent; it does not assume a global abc theorem.
-/

namespace IUTThreeClosures
namespace SquareCollapseDescentLedger

/-- Transfer a smaller-neighbor radical estimate to a square endpoint. -/
theorem square_endpoint_bound_of_smaller_neighbor
    {epsilon C logS logRadLeft kappa : ℝ}
    (hsmall :
      logS - kappa ≤ (1 + epsilon) * logRadLeft + C)
    (habsorb : kappa ≤ epsilon * logS) :
    2 * logS ≤
      (1 + epsilon) * (logS + logRadLeft) + C := by
  nlinarith

/-- Version with one additional fixed radical factor in the smaller triple. -/
theorem square_endpoint_bound_of_smaller_neighbor_with_fixed_factor
    {epsilon C logS logRadLeft kappa fixedLoss : ℝ}
    (hsmall :
      logS - kappa ≤
        (1 + epsilon) * (logRadLeft + fixedLoss) + C)
    (habsorb :
      kappa + (1 + epsilon) * fixedLoss ≤ epsilon * logS) :
    2 * logS ≤
      (1 + epsilon) * (logS + logRadLeft) + C := by
  nlinarith

#print axioms square_endpoint_bound_of_smaller_neighbor
#print axioms square_endpoint_bound_of_smaller_neighbor_with_fixed_factor

end SquareCollapseDescentLedger
end IUTThreeClosures
