import Mathlib

/-!
# Scalar ledger for the Pell repeated-hit depth reduction

This module verifies only the elementary layer bookkeeping and index geometry
used in `FREY_PELL_REPEATED_HIT_DEPTH_REDUCTION.md`.

For a prime with current exponent `e` and base order-lifting depth `h`, the
copies after the second split into:

* copies already present at the base depth;
* at most one first lifted super-square copy; and
* all deeper lifted copies.

The paper audit proves, using local fields and LTE, that in the medium-order
Pell range the middle class is the only lifted super-square layer that can
have an earlier positive hit once the support prime is above the prescribed
large-prime cutoff.  Those local-field and prime-sum statements are not
formalized or assumed here.
-/

namespace IUTThreeClosures

/-! ## Per-prime layer decomposition -/

/-- The number of copies of a prime after its second copy. -/
def pellRepeatedSuperSquareCopies (e : ℕ) : ℕ :=
  e - 2

/-- Super-square copies already contained in the common base depth `h`. -/
def pellRepeatedBaseCopies (e h : ℕ) : ℕ :=
  min e h - 2

/-- The single candidate super-square layer immediately above the base
depth.  It exists exactly when `h ≥ 2` and the current exponent exceeds
`h`. -/
def pellRepeatedFirstLiftCopy (e h : ℕ) : ℕ :=
  if 2 ≤ h ∧ h < e then 1 else 0

/-- Lifted super-square copies strictly above the first lifted layer.  When
`h = 1`, the first lifted layer is the neutral square layer, so every
super-square copy correctly remains in this term. -/
def pellRepeatedDeepLiftCopies (e h : ℕ) : ℕ :=
  e - max (h + 1) 2

/-- Exact decomposition of the copies after the second into base, first-lift,
and deeper-lift layers. -/
theorem pellRepeated_layer_decomposition (e h : ℕ) :
    pellRepeatedSuperSquareCopies e =
      pellRepeatedBaseCopies e h +
        pellRepeatedFirstLiftCopy e h +
          pellRepeatedDeepLiftCopies e h := by
  simp only [pellRepeatedSuperSquareCopies, pellRepeatedBaseCopies,
    pellRepeatedFirstLiftCopy, pellRepeatedDeepLiftCopies]
  by_cases hh : 2 ≤ h
  · by_cases heh : h < e
    · simp [hh, heh]
      omega
    · simp [hh, heh]
      omega
  · have hh' : h ≤ 1 := by omega
    simp [hh, hh']
    omega

/-- The candidate first lifted super-square class contains at most one
copy. -/
theorem pellRepeated_firstLiftCopy_le_one (e h : ℕ) :
    pellRepeatedFirstLiftCopy e h ≤ 1 := by
  simp only [pellRepeatedFirstLiftCopy]
  split <;> omega

/-- If `repeats` records whether the first lifted super-square layer has an
earlier positive hit, this is the part assigned to that repeated transition
layer. -/
def pellRepeatedTransitionCopies (e h : ℕ) (repeats : Bool) : ℕ :=
  if repeats then pellRepeatedFirstLiftCopy e h else 0

/-- All lifted super-square copies assigned to first-depth mass: every deep
lifted copy, together with the first lifted copy when it does not repeat. -/
def pellRepeatedFirstDepthCopies (e h : ℕ) (repeats : Bool) : ℕ :=
  pellRepeatedDeepLiftCopies e h +
    if repeats then 0 else pellRepeatedFirstLiftCopy e h

/-- Exact base/transition/first-depth form of the layer decomposition. -/
theorem pellRepeated_base_transition_firstDepth_decomposition
    (e h : ℕ) (repeats : Bool) :
    pellRepeatedSuperSquareCopies e =
      pellRepeatedBaseCopies e h +
        pellRepeatedTransitionCopies e h repeats +
          pellRepeatedFirstDepthCopies e h repeats := by
  have hsplit := pellRepeated_layer_decomposition e h
  cases repeats <;>
    simp [pellRepeatedTransitionCopies, pellRepeatedFirstDepthCopies] at * <;>
      omega

/-- The repeated transition contribution is at most one copy. -/
theorem pellRepeated_transitionCopies_le_one
    (e h : ℕ) (repeats : Bool) :
    pellRepeatedTransitionCopies e h repeats ≤ 1 := by
  cases repeats
  · simp [pellRepeatedTransitionCopies]
  · simpa [pellRepeatedTransitionCopies] using
      pellRepeated_firstLiftCopy_le_one e h

/-! ## Finite weighted profiles -/

/-- Finite weighted form of the exact base/transition/first-depth
decomposition. -/
theorem pellRepeated_finiteProfile_layer_decomposition
    {I : Type*} (S : Finset I) (exponent baseDepth : I → ℕ)
    (weight : I → ℝ) (repeats : I → Bool) :
    (∑ i ∈ S,
        (pellRepeatedSuperSquareCopies (exponent i) : ℝ) * weight i) =
      (∑ i ∈ S,
        (pellRepeatedBaseCopies (exponent i) (baseDepth i) : ℝ) * weight i) +
      (∑ i ∈ S,
        (pellRepeatedTransitionCopies (exponent i) (baseDepth i)
          (repeats i) : ℝ) * weight i) +
      ∑ i ∈ S,
        (pellRepeatedFirstDepthCopies (exponent i) (baseDepth i)
          (repeats i) : ℝ) * weight i := by
  calc
    (∑ i ∈ S,
        (pellRepeatedSuperSquareCopies (exponent i) : ℝ) * weight i) =
        ∑ i ∈ S,
          (((pellRepeatedBaseCopies (exponent i) (baseDepth i) : ℕ) : ℝ) +
            ((pellRepeatedTransitionCopies (exponent i) (baseDepth i)
              (repeats i) : ℕ) : ℝ) +
            ((pellRepeatedFirstDepthCopies (exponent i) (baseDepth i)
              (repeats i) : ℕ) : ℝ)) * weight i := by
          apply Finset.sum_congr rfl
          intro i hi
          rw [← Nat.cast_add, ← Nat.cast_add,
            ← pellRepeated_base_transition_firstDepth_decomposition]
    _ =
      (∑ i ∈ S,
        (pellRepeatedBaseCopies (exponent i) (baseDepth i) : ℝ) * weight i) +
      (∑ i ∈ S,
        (pellRepeatedTransitionCopies (exponent i) (baseDepth i)
          (repeats i) : ℝ) * weight i) +
      ∑ i ∈ S,
        (pellRepeatedFirstDepthCopies (exponent i) (baseDepth i)
          (repeats i) : ℝ) * weight i := by
        simp only [add_mul, Finset.sum_add_distrib]

/-- A transition layer contributes at most the one-copy support weight. -/
theorem pellRepeated_transitionMass_le_supportMass
    {I : Type*} (S : Finset I) (exponent baseDepth : I → ℕ)
    (weight : I → ℝ) (repeats : I → Bool)
    (hweight : ∀ i ∈ S, 0 ≤ weight i) :
    ∑ i ∈ S,
        (pellRepeatedTransitionCopies (exponent i) (baseDepth i)
          (repeats i) : ℝ) * weight i ≤
      ∑ i ∈ S, weight i := by
  apply Finset.sum_le_sum
  intro i hi
  have hcopy :
      (pellRepeatedTransitionCopies (exponent i) (baseDepth i)
        (repeats i) : ℝ) ≤ 1 := by
    exact_mod_cast pellRepeated_transitionCopies_le_one
      (exponent i) (baseDepth i) (repeats i)
  calc
    (pellRepeatedTransitionCopies (exponent i) (baseDepth i)
        (repeats i) : ℝ) * weight i ≤ 1 * weight i := by
      exact mul_le_mul_of_nonneg_right hcopy (hweight i hi)
    _ = weight i := one_mul _

/-- Abstract absorption of the repeated transition mass once the paper-only
prime-sum estimate has supplied a small support budget. -/
theorem pellRepeated_transitionMass_absorption
    {I : Type*} (S : Finset I) (exponent baseDepth : I → ℕ)
    (weight : I → ℝ) (repeats : I → Bool)
    (small epsilon source : ℝ)
    (hweight : ∀ i ∈ S, 0 ≤ weight i)
    (hsupport : ∑ i ∈ S, weight i ≤ small)
    (hsmall : small ≤ epsilon * source) :
    ∑ i ∈ S,
        (pellRepeatedTransitionCopies (exponent i) (baseDepth i)
          (repeats i) : ℝ) * weight i ≤ epsilon * source := by
  exact (pellRepeated_transitionMass_le_supportMass
    S exponent baseDepth weight repeats hweight).trans
      (hsupport.trans hsmall)

/-! ## Index and cutoff geometry -/

/-- If `t` is above `T` and the first lifted period `p*t` is below `2*n`,
then the prime lies below the reciprocal cutoff `2*n/T`, written without
division. -/
theorem pellRepeated_transition_cutoff
    (p t T n : ℕ) (hp : 0 < p) (hT : T < t)
    (hperiod : p * t < 2 * n) :
    p * T < 2 * n := by
  exact ((Nat.mul_lt_mul_left hp).2 hT).trans hperiod

/-- The moving resonance `rho = m`, `n = 3*m + 1`, `t = 4*m + 1` lies in
the repeated medium-order range and makes `n` the inverse-class mirror of
`rho`.  The harmless `+1` is arithmetically important: it makes `rho` and
`t` coprime, so the target order is allowed to grow with `m`. -/
theorem pellRepeated_exceptionalMirror_indexProfile
    (m : ℕ) :
    2 * m < 4 * m + 1 ∧
      4 * m + 1 ≤ 2 * (3 * m + 1) ∧
      (4 * m + 1) - m = 3 * m + 1 ∧
      Nat.Coprime (4 * m + 1) m := by
  constructor
  · omega
  constructor
  · omega
  constructor
  · omega
  · have hcop : Nat.Coprime (1 + m * 4) m := by
      rw [Nat.coprime_add_mul_left_left]
      simp
    convert hcop using 1
    all_goals omega

/-- A second moving resonance used for the base-depth method model:
`rho = m`, `n = 2*m + 1`, and `t = 3*m + 1 = n + rho`.  Both the target
order and the index gap grow, while `rho` and `t` remain coprime. -/
theorem pellRepeated_baseMirror_indexProfile
    (m : ℕ) :
    2 * m < 3 * m + 1 ∧
      3 * m + 1 ≤ 2 * (2 * m + 1) ∧
      (3 * m + 1) - m = 2 * m + 1 ∧
      Nat.Coprime (3 * m + 1) m := by
  constructor
  · omega
  constructor
  · omega
  constructor
  · omega
  · have hcop : Nat.Coprime (1 + m * 3) m := by
      rw [Nat.coprime_add_mul_left_left]
      simp
    convert hcop using 1
    all_goals omega

/-! ## Component-correct conditional method profiles -/

/-- In the exceptional-lift profile, one exponent-one prime fills a component
at the earlier index and its cube fills the current component up to a bounded
height gap. -/
theorem pellRepeated_exceptionalCube_componentHeights
    (earlierSource primeLog currentSource gap : ℝ)
    (hprime : primeLog = earlierSource)
    (hcurrent : currentSource = 3 * earlierSource + gap) :
    3 * primeLog = currentSource - gap := by
  linarith

/-- Two exceptional cubes have twice the earlier component height as their
combined super-square mass. -/
theorem pellRepeated_twoExceptionalCubes_superSquare
    (earlierSource primeLog : ℝ)
    (hprime : primeLog = earlierSource) :
    2 * primeLog = 2 * earlierSource := by
  rw [hprime]

/-- Even if the bounded gap left in each current component is assigned
entirely to exponent-one support, the two-exceptional-cube conditional
profile violates the desired super-square balance under the displayed
small-gap hypotheses.  This is only a scalar method boundary, not an
existence theorem for Pell primes. -/
theorem pellRepeated_twoExceptionalCubes_breakBalance
    (earlierSource currentSource gap eta : ℝ)
    (hearlier : 0 < earlierSource)
    (hgap_nonneg : 0 ≤ gap)
    (hgap : gap ≤ earlierSource / 12)
    (hcurrent : currentSource = 3 * earlierSource + gap)
    (heta_nonneg : 0 ≤ eta)
    (heta : eta < 1 / 4) :
    2 * gap + 2 * eta * currentSource < 2 * earlierSource := by
  nlinarith

/-- In the base-depth resonance, a cube fills the earlier component.  In the
current component it fills the same portion; the remaining comparable portion
may consist of neutral square layers. -/
theorem pellRepeated_baseCube_previousComponentHeight
    (earlierSource primeLog : ℝ)
    (hprime : 3 * primeLog = earlierSource) :
    3 * primeLog = earlierSource := hprime

/-- After the remaining current height has been assigned to neutral square
layers, even assigning the bounded gap in each component to exponent-one
support does not restore the desired balance.  The exact slack hypothesis is
eventually automatic for a bounded gap whenever `eta < 1 / 6`.  Again this is
a conditional scalar method model, not an assertion that the required Pell
primes exist. -/
theorem pellRepeated_twoBaseCubes_breakBalance
    (earlierSource primeLog currentSource gap eta : ℝ)
    (hearlier : 0 < earlierSource)
    (hgap_nonneg : 0 ≤ gap)
    (hgap : gap ≤ (1 / 6 - eta) * earlierSource)
    (hprime : 3 * primeLog = earlierSource)
    (hcurrent : currentSource = 2 * earlierSource + gap)
    (heta_nonneg : 0 ≤ eta)
    (heta : eta < 1 / 6) :
    2 * gap + 2 * eta * currentSource < 2 * primeLog := by
  have hdelta : 0 < (1 / 6 - eta) * earlierSource := by
    exact mul_pos (sub_pos.mpr heta) hearlier
  have hone : 1 + eta < 2 := by linarith
  have hone_nonneg : 0 ≤ 1 + eta := by linarith
  have hgap_term_nonneg : 0 ≤ (1 + eta) * gap := by
    exact mul_nonneg hone_nonneg hgap_nonneg
  have hscaled :
      (1 + eta) * gap ≤
        (1 + eta) * ((1 / 6 - eta) * earlierSource) := by
    exact mul_le_mul_of_nonneg_left hgap hone_nonneg
  have hstrict :
      (1 + eta) * ((1 / 6 - eta) * earlierSource) <
        2 * ((1 / 6 - eta) * earlierSource) := by
    exact mul_lt_mul_of_pos_right hone hdelta
  nlinarith [hgap_term_nonneg]

end IUTThreeClosures
