/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCCounterexampleExcessMassGate
import Mathlib.Tactic

/-!
# An explicit no-go family for bare power-part gap arguments

For every natural `X>=2`,

`1 + X*(X-2) = (X-1)^2`.

Taking `X=x^k` gives a primitive adjacent abc triple in which the `b`
coordinate is divisible by the arbitrarily high power `x^k`, while `c` is an
exact square.  Thus no route can close abc from the bare assertion

*one large endpoint has a large `k`-th-power divisor and the other has a large
square divisor*.

A successful argument must also control the residual factor `x^k-2` and the
radicals of the power roots.  The identity is an actual infinite algebraic
counterfamily to the weaker structural claim; it is not an abc counterexample.
-/

namespace IUTThreeClosures
namespace PowerSquareAdjacentIdentityNoGo

/-- The adjacent lower coordinate in the identity. -/
def adjacentPowerPart (X : ℕ) : ℕ :=
  X * (X - 2)

/-- The square upper coordinate in the identity. -/
def adjacentSquare (X : ℕ) : ℕ :=
  (X - 1) ^ 2

/-- Exact identity `1 + X(X-2) = (X-1)^2`. -/
theorem one_add_adjacentPowerPart_eq_adjacentSquare
    {X : ℕ} (hX : 2 ≤ X) :
    1 + adjacentPowerPart X = adjacentSquare X := by
  have hXeq : X = (X - 2) + 2 := by omega
  have hXm1 : X - 1 = (X - 2) + 1 := by omega
  have hprod :
      X * (X - 2) = ((X - 2) + 2) * (X - 2) :=
    congrArg (fun t : ℕ => t * (X - 2)) hXeq
  unfold adjacentPowerPart adjacentSquare
  calc
    1 + X * (X - 2) =
        1 + ((X - 2) + 2) * (X - 2) := by rw [hprod]
    _ = ((X - 2) + 1) ^ 2 := by ring
    _ = (X - 1) ^ 2 := by rw [← hXm1]

/-- The identity gives a primitive adjacent abc triple. -/
theorem pairwiseCoprimeABC_one_adjacentPowerPart_adjacentSquare
    {X : ℕ} (hX : 2 ≤ X) :
    PairwiseCoprimeABC 1 (adjacentPowerPart X) (adjacentSquare X) := by
  have hsum := one_add_adjacentPowerPart_eq_adjacentSquare hX
  have hsucc : adjacentSquare X = adjacentPowerPart X + 1 := by
    omega
  rw [hsucc]
  exact one_adjacent_pairwiseCoprimeABC (adjacentPowerPart X)

/-- Substituting an arbitrary perfect power preserves it as a divisor of the
lower endpoint. -/
theorem power_dvd_adjacentPowerPart
    (x k : ℕ) :
    x ^ k ∣ adjacentPowerPart (x ^ k) := by
  unfold adjacentPowerPart
  exact dvd_mul_right (x ^ k) ((x ^ k) - 2)

/-- The upper endpoint is literally the square of `x^k-1`. -/
theorem adjacentSquare_power_eq
    (x k : ℕ) :
    adjacentSquare (x ^ k) = ((x ^ k) - 1) ^ 2 := rfl

/-- For every admissible power `x^k`, there is a positive primitive abc point
with that power dividing one large endpoint and an exact square as the other. -/
def powerSquareABCPoint
    (x k : ℕ) (hX : 2 ≤ x ^ k) : ABCPoint :=
  { a := 1
    b := adjacentPowerPart (x ^ k)
    c := adjacentSquare (x ^ k)
    a_pos := by norm_num
    b_pos := by
      unfold adjacentPowerPart
      have hsub : 0 < x ^ k - 2 := by
        have : 2 < x ^ k := by
          by_cases heq : x ^ k = 2
          · subst heq
            norm_num
          · omega
        omega
      exact mul_pos (lt_of_lt_of_le (by norm_num) hX) hsub
    c_pos := by
      unfold adjacentSquare
      have hsub : 0 < x ^ k - 1 := by omega
      positivity
    sum_eq := one_add_adjacentPowerPart_eq_adjacentSquare hX
    pairwise_coprime :=
      pairwiseCoprimeABC_one_adjacentPowerPart_adjacentSquare hX }

/-- The constructed point retains the prescribed perfect-power divisor. -/
theorem power_dvd_powerSquareABCPoint_b
    (x k : ℕ) (hX : 2 ≤ x ^ k) :
    x ^ k ∣ (powerSquareABCPoint x k hX).b := by
  exact power_dvd_adjacentPowerPart x k

/-- The constructed point has an exact square as its `c` coordinate. -/
theorem powerSquareABCPoint_c_eq_square
    (x k : ℕ) (hX : 2 ≤ x ^ k) :
    (powerSquareABCPoint x k hX).c = ((x ^ k) - 1) ^ 2 := rfl

#print axioms one_add_adjacentPowerPart_eq_adjacentSquare
#print axioms pairwiseCoprimeABC_one_adjacentPowerPart_adjacentSquare
#print axioms power_dvd_adjacentPowerPart
#print axioms powerSquareABCPoint
#print axioms power_dvd_powerSquareABCPoint_b
#print axioms powerSquareABCPoint_c_eq_square

end PowerSquareAdjacentIdentityNoGo
end IUTThreeClosures
