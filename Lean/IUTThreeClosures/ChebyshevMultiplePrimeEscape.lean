/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ChebyshevPrimeEscape

/-!
# A multiple-prime Chebyshev escape criterion

GenEll Lemma 4.1 requires several distinct primes in one bounded interval,
all outside a finite forbidden set. The one-prime Chebyshev escape theorem
extends to this setting by a counting argument.

Let `B(A,h,X)` be the finite set of primes `p` with

`h < p <= X` and `p ∉ A`.

Every prime up to `X` lies either below `h`, in `A`, or in `B`. Hence

`theta X <= theta h + x_A + sum_{p in B} log p`.

Since every `p in B` is at most `X`, the final sum is bounded by

`card(B) * log X`.

Consequently, if

`theta h + x_A + M * log X < theta X`,

then `B` contains more than `M` elements. The shifted form with
`(M - 1) * log X` gives at least `M` distinct escaping primes. Combining
this with explicit upper/lower Chebyshev estimates reduces the remaining
analytic part of GenEll Lemma 4.1 to one real inequality.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- The finite set of primes in `(h, X]` outside `A`. -/
noncomputable def escapingPrimes
    (A : Finset ℕ) (h X : ℕ) : Finset ℕ :=
  (primesLE X).filter fun p => h < p ∧ p ∉ A

@[simp]
theorem mem_escapingPrimes_iff
    (A : Finset ℕ) (h X p : ℕ) :
    p ∈ escapingPrimes A h X ↔
      p.Prime ∧ h < p ∧ p ≤ X ∧ p ∉ A := by
  classical
  rw [escapingPrimes, Finset.mem_filter]
  constructor
  · rintro ⟨hpLE, hhp, hpA⟩
    exact ⟨prime_of_mem_primesLE hpLE, hhp,
      le_of_mem_primesLE hpLE, hpA⟩
  · rintro ⟨hp, hhp, hpX, hpA⟩
    exact ⟨mem_primesLE.mpr ⟨hpX, hp⟩, hhp, hpA⟩

/-- Every escaping element is prime. -/
theorem prime_of_mem_escapingPrimes
    {A : Finset ℕ} {h X p : ℕ}
    (hp : p ∈ escapingPrimes A h X) :
    p.Prime :=
  (mem_escapingPrimes_iff A h X p).mp hp |>.1

/-- Every prime in `(h,X]` is either forbidden or an escaping prime. -/
theorem interval_prime_mem_forbidden_or_escaping
    (A : Finset ℕ) (h X : ℕ)
    {p : ℕ} (hp : p.Prime) (hpX : p ≤ X) (hhp : h < p) :
    p ∈ A ∪ escapingPrimes A h X := by
  classical
  by_cases hpA : p ∈ A
  · exact Finset.mem_union_left _ hpA
  · exact Finset.mem_union_right _ <|
      (mem_escapingPrimes_iff A h X p).2
        ⟨hp, hhp, hpX, hpA⟩

/-- The logarithmic mass of a union of finite prime sets is at most the sum
of their separate masses. -/
theorem primeLogMass_union_le
    (A B : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (hB : ∀ p ∈ B, p.Prime) :
    primeLogMass (A ∪ B) ≤ primeLogMass A + primeLogMass B := by
  classical
  unfold primeLogMass
  have hinter_nonneg :
      0 ≤ ∑ p ∈ A ∩ B, Real.log p := by
    apply Finset.sum_nonneg
    intro p hp
    have hpPrime : p.Prime := hA p (Finset.mem_inter.mp hp).1
    exact Real.log_nonneg (by exact_mod_cast hpPrime.one_le)
  have hidentity :
      (∑ p ∈ A ∪ B, Real.log p) +
          (∑ p ∈ A ∩ B, Real.log p) =
        (∑ p ∈ A, Real.log p) +
          ∑ p ∈ B, Real.log p := by
    exact Finset.sum_union_inter
  linarith

/-- The escaping-prime logarithmic mass is bounded by its cardinality times
`log X`. -/
theorem primeLogMass_escapingPrimes_le
    (A : Finset ℕ) (h X : ℕ) :
    primeLogMass (escapingPrimes A h X) ≤
      ((escapingPrimes A h X).card : ℝ) * Real.log X := by
  classical
  unfold primeLogMass
  calc
    (∑ p ∈ escapingPrimes A h X, Real.log p) ≤
        ∑ _p ∈ escapingPrimes A h X, Real.log X := by
      apply Finset.sum_le_sum
      intro p hp
      have hspec := (mem_escapingPrimes_iff A h X p).mp hp
      have hpPos : (0 : ℝ) < p := by
        exact_mod_cast hspec.1.pos
      have hXPos : (0 : ℝ) < X := by
        exact_mod_cast hspec.1.pos.trans_le hspec.2.2.1
      have hpX : (p : ℝ) ≤ X := by
        exact_mod_cast hspec.2.2.1
      exact Real.strictMonoOn_log.monotoneOn hpPos hXPos hpX
    _ = ((escapingPrimes A h X).card : ℝ) * Real.log X := by
      simp

/-- All primes up to `X` are accounted for by primes up to `h`, the forbidden
set, and the escaping set. -/
theorem theta_le_theta_add_forbidden_add_escaping
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    (h X : ℕ) :
    Chebyshev.theta X ≤
      Chebyshev.theta h + primeLogMass A +
        primeLogMass (escapingPrimes A h X) := by
  have hEscPrime :
      ∀ p ∈ escapingPrimes A h X, p.Prime := by
    intro p hp
    exact prime_of_mem_escapingPrimes hp
  have hcovered :
      ∀ p : ℕ, p.Prime → p ≤ X → h < p →
        p ∈ A ∪ escapingPrimes A h X := by
    intro p hp hpX hhp
    exact interval_prime_mem_forbidden_or_escaping A h X hp hpX hhp
  have htheta :=
    theta_le_theta_add_primeLogMass_of_interval_covered
      (A ∪ escapingPrimes A h X)
      (by
        intro p hp
        rcases Finset.mem_union.mp hp with hpA | hpB
        · exact hA p hpA
        · exact hEscPrime p hpB)
      hcovered
  have hunion :=
    primeLogMass_union_le A (escapingPrimes A h X) hA hEscPrime
  linarith

/-- **Multiple-prime escape theorem.** If the Chebyshev excess is larger
than the logarithmic mass of `M` possible escaping primes, then there are in
fact more than `M` distinct escaping primes. -/
theorem card_escapingPrimes_gt_of_theta_gt
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    (h X M : ℕ)
    (hX : 1 ≤ X)
    (hTheta :
      Chebyshev.theta h + primeLogMass A +
          (M : ℝ) * Real.log X <
        Chebyshev.theta X) :
    M < (escapingPrimes A h X).card := by
  by_contra hnot
  have hcard : (escapingPrimes A h X).card ≤ M :=
    Nat.le_of_not_gt hnot
  have hlogX : 0 ≤ Real.log X :=
    Real.log_nonneg (by exact_mod_cast hX)
  have hmassCard := primeLogMass_escapingPrimes_le A h X
  have hcardReal :
      ((escapingPrimes A h X).card : ℝ) ≤ M := by
    exact_mod_cast hcard
  have hmassM :
      primeLogMass (escapingPrimes A h X) ≤
        (M : ℝ) * Real.log X :=
    hmassCard.trans <|
      mul_le_mul_of_nonneg_right hcardReal hlogX
  have htheta :=
    theta_le_theta_add_forbidden_add_escaping A hA h X
  linarith

/-- Shifted form matching the usual statement: the displayed Chebyshev
margin guarantees at least `M` distinct primes in `(h,X]` outside `A`. -/
theorem card_escapingPrimes_ge_of_theta_gt
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    (h X M : ℕ)
    (hX : 1 ≤ X)
    (hTheta :
      Chebyshev.theta h + primeLogMass A +
          ((M - 1 : ℕ) : ℝ) * Real.log X <
        Chebyshev.theta X) :
    M ≤ (escapingPrimes A h X).card := by
  by_cases hM : M = 0
  · simp [hM]
  · have hlt :=
      card_escapingPrimes_gt_of_theta_gt
        A hA h X (M - 1) hX hTheta
    omega

/-- Explicit Chebyshev-estimate version of the multiple-prime theorem. -/
theorem card_escapingPrimes_ge_of_explicit_chebyshev_bound
    (A : Finset ℕ) (hA : ∀ p ∈ A, p.Prime)
    (h X M : ℕ)
    (hX : 1 ≤ X)
    (hbound :
      Real.log 4 * (h : ℝ) + primeLogMass A +
          ((M - 1 : ℕ) : ℝ) * Real.log X <
        (X : ℝ) * Real.log 2 - Real.log ((X : ℝ) + 1) -
          2 * Real.sqrt X * Real.log X) :
    M ≤ (escapingPrimes A h X).card := by
  apply card_escapingPrimes_ge_of_theta_gt A hA h X M hX
  have hupper :
      Chebyshev.theta h ≤ Real.log 4 * (h : ℝ) :=
    Chebyshev.theta_le_log4_mul_x (by positivity)
  have hlower :
      (X : ℝ) * Real.log 2 - Real.log ((X : ℝ) + 1) -
          2 * Real.sqrt X * Real.log X ≤ Chebyshev.theta X := by
    simpa using Chebyshev.theta_ge X
  linarith

end IUTThreeClosures
