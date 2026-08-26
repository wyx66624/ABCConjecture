import Mathlib

/-!
# Scalar ledger for the Pell order/cubeful-tail audit

This module checks only the elementary bookkeeping in
`FREY_PELL_ORDER_CUBEFUL_TAIL_AUDIT.md`:

* the exact decomposition of powerful excess into total, exponent-one, and
  super-square mass;
* the resulting critical coefficient equivalence;
* the correct two-component cube profile; and
* the final scalar absorption in the small-residual-order estimate.

It does not formalize or assume a theorem about residual orders, `p`-adic
logarithms, prime splitting, algebraic norms, prime sums, the Pell sequence,
or its radical.
-/

namespace IUTThreeClosures

/-! ## Exponent layers -/

/-- For a positive prime exponent `e`, twice its excess is its total
multiplicity plus the copies after the second, minus one copy exactly when
the exponent is one. -/
theorem pellOrder_exponentLayer_identity
    (e : ℕ) (weight : ℝ) (he : 1 ≤ e) :
    2 * ((e : ℝ) - 1) * weight =
      (e : ℝ) * weight + ((e - 2 : ℕ) : ℝ) * weight -
        (if e = 1 then weight else 0) := by
  by_cases h1 : e = 1
  · subst e
    norm_num
  · have h2 : 2 ≤ e := by omega
    rw [if_neg h1, Nat.cast_sub h2]
    ring

/-- Finite-profile form of the exponent-layer identity.  The three sums on
the right are respectively total logarithmic mass, super-square mass, and
exponent-one mass. -/
theorem pellOrder_finiteProfile_exponentLayer_identity
    {I : Type*} (S : Finset I) (exponent : I → ℕ) (weight : I → ℝ)
    (hexponent : ∀ i ∈ S, 1 ≤ exponent i) :
    2 * ∑ i ∈ S, (((exponent i : ℝ) - 1) * weight i) =
      (∑ i ∈ S, (exponent i : ℝ) * weight i) +
        (∑ i ∈ S, (((exponent i - 2 : ℕ) : ℝ) * weight i)) -
          ∑ i ∈ S, (if exponent i = 1 then weight i else 0) := by
  calc
    2 * ∑ i ∈ S, (((exponent i : ℝ) - 1) * weight i) =
        ∑ i ∈ S, (2 * (((exponent i : ℝ) - 1) * weight i)) := by
          rw [Finset.mul_sum]
    _ = ∑ i ∈ S,
        ((exponent i : ℝ) * weight i +
          ((exponent i - 2 : ℕ) : ℝ) * weight i -
            (if exponent i = 1 then weight i else 0)) := by
          apply Finset.sum_congr rfl
          intro i hi
          rw [← pellOrder_exponentLayer_identity
            (exponent i) (weight i) (hexponent i hi)]
          ring
    _ = (∑ i ∈ S, (exponent i : ℝ) * weight i) +
        (∑ i ∈ S, (((exponent i - 2 : ℕ) : ℝ) * weight i)) -
          ∑ i ∈ S, (if exponent i = 1 then weight i else 0) := by
          rw [Finset.sum_sub_distrib, Finset.sum_add_distrib]

/-! ## Critical coefficient -/

/-- If `total = 2 * source` and the exponent-layer identity holds, then the
critical excess allowance is exactly equivalent to bounding super-square
mass by exponent-one mass plus `2 * eta * source`. -/
theorem pellOrder_criticalExcess_iff_superSquareBalance
    (source total excess superSquare exponentOne eta : ℝ)
    (htotal : total = 2 * source)
    (hlayer : 2 * excess = total + superSquare - exponentOne) :
    excess ≤ (1 + eta) * source ↔
      superSquare ≤ exponentOne + 2 * eta * source := by
  constructor <;> intro h <;> linarith

/-- In particular, if there are no more super-square copies than
exponent-one copies, prime squares are harmless at the critical coefficient. -/
theorem pellOrder_squareLayer_isCriticalNeutral
    (source total excess superSquare exponentOne : ℝ)
    (htotal : total = 2 * source)
    (hlayer : 2 * excess = total + superSquare - exponentOne)
    (hbalance : superSquare ≤ exponentOne) :
    excess ≤ source := by
  have hiff := pellOrder_criticalExcess_iff_superSquareBalance
    source total excess superSquare exponentOne 0 htotal hlayer
  simpa using (hiff.mpr (by simpa using hbalance))

/-! ## Component-correct cube carrier -/

/-- If each of two disjoint cubes fills one component of logarithmic size
`source`, their combined excess is `4/3 * source`. -/
theorem pellOrder_twoComponentCube_excess
    (source leftPrimeLog rightPrimeLog : ℝ)
    (hleft : 3 * leftPrimeLog = source)
    (hright : 3 * rightPrimeLog = source) :
    2 * leftPrimeLog + 2 * rightPrimeLog =
      (4 / 3 : ℝ) * source := by
  nlinarith

/-- The component-correct two-cube profile exceeds the single source-height
allowance when the source height is positive. -/
theorem pellOrder_twoComponentCube_breaksCriticalCoefficient
    (source leftPrimeLog rightPrimeLog : ℝ)
    (hsource : 0 < source)
    (hleft : 3 * leftPrimeLog = source)
    (hright : 3 * rightPrimeLog = source) :
    source < 2 * leftPrimeLog + 2 * rightPrimeLog := by
  rw [pellOrder_twoComponentCube_excess
    source leftPrimeLog rightPrimeLog hleft hright]
  linarith

/-! ## Small-order scalar aggregation -/

/-- Addition of the low-prime-log and high-prime-log estimates at one fixed
residual order.  The number-theoretic estimates represented by the two
hypotheses are not asserted by this theorem. -/
theorem pellOrder_oneLayerSplit_scalar
    (low high lowBound highBound : ℝ)
    (hlow : low ≤ lowBound) (hhigh : high ≤ highBound) :
    low + high ≤ lowBound + highBound := by
  exact add_le_add hlow hhigh

/-- Final scalar absorption for the three terms obtained after summing the
residual-order layers.  Analytically they are
`logN*T^2`, `T^3`, and `logN*T^3/(logY)^3`; their separate smallness is kept
as hypotheses. -/
theorem pellOrder_smallOrderTailAbsorption_scalar
    (tail termOne termTwo termThree epsilon source : ℝ)
    (htail : tail ≤ termOne + termTwo + termThree)
    (hone : termOne ≤ epsilon * source)
    (htwo : termTwo ≤ epsilon * source)
    (hthree : termThree ≤ epsilon * source) :
    tail ≤ 3 * epsilon * source := by
  calc
    tail ≤ termOne + termTwo + termThree := htail
    _ ≤ epsilon * source + epsilon * source + epsilon * source := by
      exact add_le_add (add_le_add hone htwo) hthree
    _ = 3 * epsilon * source := by ring

end IUTThreeClosures
