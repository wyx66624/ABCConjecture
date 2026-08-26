import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# Scalar companion to the 2020--2026 Pell square-base theorem audit

For the arithmetic application the variables below stand for

* `total = log c_n`,
* `core = log A_n`,
* `squareBase = log y_n`, and
* `height = H_n`.

The exact factorization `c_n = A_n * y_n^2` gives the scalar ledger

`total = core + 2 * squareBase`.

This file checks only the directions and quantifiers used to pass between a
greatest-square-divisor bound and coefficient-one parity-core growth.  It
does not formalize or assume any theorem about radicals, recurrences,
Wieferich primes, the Subspace Theorem, modularity, asymptotics, or `abc`.
-/

namespace IUTThreeClosures

/-- A bound for the logarithmic square divisor, together with the lower side
of `total = height + O(1)`, gives the desired parity-core lower bound. -/
theorem squarebase_core_lower_of_squareWeight_upper
    (total core squareBase height epsilon heightError squareError : ℝ)
    (hledger : total = core + 2 * squareBase)
    (hheightLower : height - heightError ≤ total)
    (hsquare : 2 * squareBase ≤ epsilon * height + squareError) :
    (1 - epsilon) * height - (heightError + squareError) ≤ core := by
  linarith

/-- Conversely, coefficient-one parity-core growth and the upper side of
`total = height + O(1)` bound the logarithmic square divisor. -/
theorem squarebase_squareWeight_upper_of_core_lower
    (total core squareBase height epsilon heightError coreError : ℝ)
    (hledger : total = core + 2 * squareBase)
    (hheightUpper : total ≤ height + heightError)
    (hcore : (1 - epsilon) * height - coreError ≤ core) :
    2 * squareBase ≤ epsilon * height + (heightError + coreError) := by
  linarith

/-- With exact source height, the two scalar inequalities are literally
equivalent with the same epsilon and additive constant. -/
theorem squarebase_exactHeight_equiv
    (total core squareBase height epsilon error : ℝ)
    (hledger : total = core + 2 * squareBase)
    (hheight : total = height) :
    (2 * squareBase ≤ epsilon * height + error) ↔
      ((1 - epsilon) * height - error ≤ core) := by
  constructor <;> intro h <;> linarith

/-- The full `forall epsilon, exists constant, forall index` direction from
greatest-square-divisor control to parity-core control.  The constant is
chosen after epsilon and before the index, as required. -/
theorem squarebase_pointwise_core_of_squareWeight
    (total core squareBase height : ℕ → ℝ) (heightError : ℝ)
    (hledger : ∀ n, total n = core n + 2 * squareBase n)
    (hheightLower : ∀ n, height n - heightError ≤ total n)
    (hsquare : ∀ epsilon > 0, ∃ squareError, ∀ n,
      2 * squareBase n ≤ epsilon * height n + squareError) :
    ∀ epsilon > 0, ∃ coreError, ∀ n,
      (1 - epsilon) * height n - coreError ≤ core n := by
  intro epsilon hepsilon
  obtain ⟨squareError, hsquareError⟩ := hsquare epsilon hepsilon
  refine ⟨heightError + squareError, ?_⟩
  intro n
  exact squarebase_core_lower_of_squareWeight_upper
    (total n) (core n) (squareBase n) (height n)
    epsilon heightError squareError (hledger n) (hheightLower n)
    (hsquareError n)

/-- The converse pointwise quantified direction. -/
theorem squarebase_pointwise_squareWeight_of_core
    (total core squareBase height : ℕ → ℝ) (heightError : ℝ)
    (hledger : ∀ n, total n = core n + 2 * squareBase n)
    (hheightUpper : ∀ n, total n ≤ height n + heightError)
    (hcore : ∀ epsilon > 0, ∃ coreError, ∀ n,
      (1 - epsilon) * height n - coreError ≤ core n) :
    ∀ epsilon > 0, ∃ squareError, ∀ n,
      2 * squareBase n ≤ epsilon * height n + squareError := by
  intro epsilon hepsilon
  obtain ⟨coreError, hcoreError⟩ := hcore epsilon hepsilon
  refine ⟨heightError + coreError, ?_⟩
  intro n
  exact squarebase_squareWeight_upper_of_core_lower
    (total n) (core n) (squareBase n) (height n)
    epsilon heightError coreError (hledger n) (hheightUpper n)
    (hcoreError n)

/-- Under a two-sided bounded height comparison, the exact pointwise
epsilon-constant formulations of the two targets are equivalent. -/
theorem squarebase_pointwise_targets_equiv
    (total core squareBase height : ℕ → ℝ) (heightError : ℝ)
    (hledger : ∀ n, total n = core n + 2 * squareBase n)
    (hheightLower : ∀ n, height n - heightError ≤ total n)
    (hheightUpper : ∀ n, total n ≤ height n + heightError) :
    (∀ epsilon > 0, ∃ squareError, ∀ n,
      2 * squareBase n ≤ epsilon * height n + squareError) ↔
    (∀ epsilon > 0, ∃ coreError, ∀ n,
      (1 - epsilon) * height n - coreError ≤ core n) := by
  constructor
  · exact squarebase_pointwise_core_of_squareWeight
      total core squareBase height heightError hledger hheightLower
  · exact squarebase_pointwise_squareWeight_of_core
      total core squareBase height heightError hledger hheightUpper

/-- A genuinely coefficient-one radical lower bound is a sufficient (but
strictly stronger) route.  Arithmetically, `radical ≤ core + squareBase`
comes from `rad (A * y^2) ≤ A * y`. -/
theorem squarebase_of_coefficientOne_radical
    (total core squareBase radical height epsilon heightError radicalError : ℝ)
    (hledger : total = core + 2 * squareBase)
    (hradicalUpper : radical ≤ core + squareBase)
    (hheightUpper : total ≤ height + heightError)
    (hradicalLower : (1 - epsilon) * height - radicalError ≤ radical) :
    squareBase ≤ epsilon * height + (heightError + radicalError) := by
  linarith

/-- Scalar profile of a square of a squarefree integer: the ordinary radical
can carry half the logarithmic height while the normalized parity core is
zero and the square divisor carries the full height.  This records why a
radical estimate cannot be substituted into the parity ledger. -/
theorem squarebase_halfRadical_zeroCore_profile (height : ℝ) :
    let total := height
    let core := 0
    let squareBase := height / 2
    let radical := height / 2
    total = core + 2 * squareBase ∧
      2 * radical = total ∧
      core = 0 ∧
      2 * squareBase = total := by
  dsimp
  constructor
  · ring
  constructor
  · ring
  constructor
  · rfl
  · ring

/-- A nonnegative term inherits a prefix estimate only after one supplies
the pointwise domination by that prefix.  Average estimates on a larger
scale do not provide the second hypothesis at the required scale. -/
theorem squarebase_pointwise_of_prefix_bound
    (weight prefixSum epsilon height error : ℝ)
    (hterm : weight ≤ prefixSum)
    (hprefix : prefixSum ≤ epsilon * height + error) :
    weight ≤ epsilon * height + error := by
  exact hterm.trans hprefix

#print axioms squarebase_core_lower_of_squareWeight_upper
#print axioms squarebase_pointwise_targets_equiv
#print axioms squarebase_of_coefficientOne_radical
#print axioms squarebase_halfRadical_zeroCore_profile
#print axioms squarebase_pointwise_of_prefix_bound

end IUTThreeClosures
