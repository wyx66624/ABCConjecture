/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTLanaSpecificationNoGo20260901
import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.NumberTheory.Padics.PadicNumbers

/-!
# Corrected log-volume models and the same-pilot holonomy gate

This module formalizes the elementary core proved first in
research/ABC_IUT_CORRECTED_VOLUME_HOLONOMY_2026_09_01.md.

* Integer-indexed valuation balls give an inhabited restricted log-volume
  model with the intended prime-preimage shift.
* Normalized finite packet aggregation and positive-length procession
  averaging preserve that shift.
* Logarithmic transports compose additively, and every closed pointed loop
  has zero total shift.

The valuation-ball type is an exact algebraic model of the compact-open balls
p^k Z_p; it is not an instantiation of Project LANA's full container.
The holonomy theorems are necessary checks on a future object-level
same-pilot construction. Nothing here constructs that object or proves IUT
or the abc conjecture.
-/

namespace IUTThreeClosures
namespace IUTCorrectedVolumeHolonomy20260901

open scoped BigOperators

/-! ## The actual compact-open p-adic ball identity -/

/-- The closed valuation ball with radius p^(-k) in Q_p. -/
def padicValuationBall (p : ℕ) [Fact p.Prime] (k : ℤ) : Set ℚ_[p] :=
  {x | ‖x‖ ≤ (p : ℝ) ^ (-k)}

/-- Every valuation ball in the restricted domain is nonempty. -/
theorem padicValuationBall_nonempty
    (p : ℕ) [Fact p.Prime] (k : ℤ) :
    (padicValuationBall p k).Nonempty := by
  refine ⟨0, ?_⟩
  simp only [padicValuationBall, Set.mem_setOf_eq, norm_zero]
  exact (zpow_pos (by
    exact_mod_cast (Fact.out : p.Prime).pos) _).le

/-- Multiplication by p has exactly the claimed preimage on actual p-adic
valuation balls. -/
theorem padicValuationBall_prime_preimage
    (p : ℕ) [Fact p.Prime] (k : ℤ) :
    (fun x : ℚ_[p] => (p : ℚ_[p]) * x) ⁻¹'
        padicValuationBall p k =
      padicValuationBall p (k - 1) := by
  ext x
  simp only [Set.mem_preimage, padicValuationBall, Set.mem_setOf_eq,
    norm_mul, Padic.norm_p]
  have hpR : 0 < (p : ℝ) := by
    exact_mod_cast (Fact.out : p.Prime).pos
  rw [inv_mul_eq_div, div_le_iff₀ hpR]
  have hpne : (p : ℝ) ≠ 0 := hpR.ne'
  rw [show -(k - 1) = -k + 1 by ring, zpow_add₀ hpne, zpow_one]

/-- Exact containment criterion for the actual p-adic valuation balls. -/
theorem padicValuationBall_subset_iff
    (p : ℕ) [Fact p.Prime] {k m : ℤ} :
    padicValuationBall p k ⊆ padicValuationBall p m ↔ m ≤ k := by
  have hpR : 1 < (p : ℝ) := by
    exact_mod_cast (Fact.out : p.Prime).one_lt
  constructor
  · intro hsubset
    have hx : (p : ℚ_[p]) ^ k ∈ padicValuationBall p k := by
      simp [padicValuationBall]
    have hy := hsubset hx
    simp only [padicValuationBall, Set.mem_setOf_eq,
      Padic.norm_p_zpow] at hy
    exact
      neg_le_neg_iff.mp ((zpow_le_zpow_iff_right₀ hpR).mp hy)
  · intro hmk x hx
    exact hx.trans (zpow_le_zpow_right₀ hpR.le (neg_le_neg hmk))

/-! ## An inhabited restricted valuation-ball model -/

/-- The exponent of the compact-open valuation ball p^k Z_p. -/
structure ValuationBall where
  exponent : ℤ
deriving DecidableEq

/-- Prime preimage sends the exponent k to k - 1. -/
def ValuationBall.primePreimage (B : ValuationBall) : ValuationBall :=
  ⟨B.exponent - 1⟩

/-- The normalized logarithmic volume -k * log p. -/
noncomputable def ValuationBall.logVolume (p : ℕ) (B : ValuationBall) : ℝ :=
  -(B.exponent : ℝ) * Real.log p

/-- The integral valuation ball. -/
def ValuationBall.integral : ValuationBall := ⟨0⟩

@[simp]
theorem valuationBall_integral_logVolume (p : ℕ) :
    ValuationBall.logVolume p ValuationBall.integral = 0 := by
  simp [ValuationBall.logVolume, ValuationBall.integral]

/-- On the restricted domain of valuation balls, prime preimage adds
log p, exactly as normalized p-adic Haar log-volume does. -/
theorem valuationBall_primePreimage_add (p : ℕ) (B : ValuationBall) :
    ValuationBall.logVolume p B.primePreimage =
      ValuationBall.logVolume p B + Real.log p := by
  simp only [ValuationBall.logVolume, ValuationBall.primePreimage, Int.cast_sub,
    Int.cast_one]
  ring

/-- Exponent order gives the expected log-volume monotonicity when p > 1. -/
theorem valuationBall_logVolume_antitone
    {p : ℕ} (hp : 1 < p) {B C : ValuationBall}
    (hBC : C.exponent ≤ B.exponent) :
    ValuationBall.logVolume p B ≤ ValuationBall.logVolume p C := by
  have hlog : 0 ≤ Real.log (p : ℝ) :=
    (Real.log_pos (by exact_mod_cast hp)).le
  have hBCR : (C.exponent : ℝ) ≤ (B.exponent : ℝ) := by
    exact_mod_cast hBC
  dsimp [ValuationBall.logVolume]
  exact mul_le_mul_of_nonneg_right (neg_le_neg hBCR) hlog

/-- A proof-carrying restricted shifted log-volume interface. -/
structure RestrictedShiftedLogVolume (Region : Type*) where
  preimage : Region → Region
  logVolume : Region → ℝ
  shift : ℝ
  preimage_add : ∀ U, logVolume (preimage U) = logVolume U + shift

/-- Valuation balls inhabit the corrected restricted interface for every
natural scale parameter. -/
noncomputable def valuationBallModel (p : ℕ) :
    RestrictedShiftedLogVolume ValuationBall where
  preimage := ValuationBall.primePreimage
  logVolume := ValuationBall.logVolume p
  shift := Real.log p
  preimage_add := valuationBall_primePreimage_add p

/-- In particular, the repaired restricted interface is inhabited even when
its shift is nonzero. -/
theorem restrictedShiftedLogVolume_nonempty (p : ℕ) :
    Nonempty (RestrictedShiftedLogVolume ValuationBall) :=
  ⟨valuationBallModel p⟩

/-! ## Normalized packets and processions -/

variable {ι : Type*} [Fintype ι]

/-- Weighted packet log-volume of a finite family of valuation balls. -/
noncomputable def packetLogVolume
    (weight : ι → ℝ) (p : ℕ) (packet : ι → ValuationBall) : ℝ :=
  ∑ i, weight i * ValuationBall.logVolume p (packet i)

/-- Simultaneous prime preimage of every component of a packet. -/
def packetPrimePreimage (packet : ι → ValuationBall) : ι → ValuationBall :=
  fun i => (packet i).primePreimage

/-- Weight normalization makes the componentwise prime shift survive packet
aggregation with coefficient exactly one. -/
theorem packetLogVolume_primePreimage_add
    (weight : ι → ℝ) (hsum : ∑ i, weight i = 1)
    (p : ℕ) (packet : ι → ValuationBall) :
    packetLogVolume weight p (packetPrimePreimage packet) =
      packetLogVolume weight p packet + Real.log p := by
  simp only [packetLogVolume, packetPrimePreimage]
  simp_rw [valuationBall_primePreimage_add, mul_add]
  rw [Finset.sum_add_distrib, ← Finset.sum_mul, hsum, one_mul]

/-- The unweighted procession average. -/
noncomputable def processionAverage
    {n : ℕ} (volume : Fin n → ℝ) : ℝ :=
  (∑ i, volume i) / n

/-- Adding one common shift to every capsule adds the same shift to the
positive-length procession average. -/
theorem processionAverage_add_common
    {n : ℕ} (hn : 0 < n) (volume : Fin n → ℝ) (shift : ℝ) :
    processionAverage (fun i => volume i + shift) =
      processionAverage volume + shift := by
  unfold processionAverage
  rw [Finset.sum_add_distrib]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin]
  have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast hn.ne'
  field_simp
  ring

/-! ## Logarithmic transport and zero holonomy -/

/-- A transport certificate whose normalized coordinate changes by shift. -/
structure LogTransport (X : Type*) (coordinate : X → ℝ)
    (source target : X) (shift : ℝ) : Prop where
  coordinate_shift : coordinate target = coordinate source + shift

/-- Identity transport has zero shift. -/
theorem LogTransport.identity
    {X : Type*} {coordinate : X → ℝ} (x : X) :
    LogTransport X coordinate x x 0 :=
  ⟨by simp⟩

/-- Shifts add under transport composition. -/
theorem LogTransport.comp
    {X : Type*} {coordinate : X → ℝ}
    {x y z : X} {δ ε : ℝ}
    (P : LogTransport X coordinate x y δ)
    (Q : LogTransport X coordinate y z ε) :
    LogTransport X coordinate x z (δ + ε) := by
  constructor
  rw [Q.coordinate_shift, P.coordinate_shift]
  ring

/-- Reversing a transport negates its shift. -/
theorem LogTransport.reverse
    {X : Type*} {coordinate : X → ℝ}
    {x y : X} {δ : ℝ}
    (P : LogTransport X coordinate x y δ) :
    LogTransport X coordinate y x (-δ) := by
  constructor
  rw [P.coordinate_shift]
  ring

/-- Every closed pointed transport has zero logarithmic holonomy. -/
theorem LogTransport.shift_eq_zero_of_closed
    {X : Type*} {coordinate : X → ℝ}
    {x y : X} {δ : ℝ}
    (P : LogTransport X coordinate x y δ)
    (hclosed : y = x) :
    δ = 0 := by
  subst y
  linarith [P.coordinate_shift]

/-- A nonzero shift prevents a transport from returning to the same object. -/
theorem LogTransport.not_closed_of_shift_ne_zero
    {X : Type*} {coordinate : X → ℝ}
    {x y : X} {δ : ℝ}
    (P : LogTransport X coordinate x y δ)
    (hδ : δ ≠ 0) :
    y ≠ x := by
  intro hclosed
  exact hδ (P.shift_eq_zero_of_closed hclosed)

/-- A prime shift followed by a correction can close only if the correction
is the negative prime shift. -/
theorem correction_eq_neg_log_of_closed
    {X : Type*} {coordinate : X → ℝ}
    {x y : X} {p : ℕ} {κ : ℝ}
    (primeStep : LogTransport X coordinate x y (Real.log p))
    (correction : LogTransport X coordinate y x κ) :
    κ = -Real.log p := by
  have hzero := (primeStep.comp correction).shift_eq_zero_of_closed rfl
  linarith

/-- More generally, a closing correction is the negative of the accumulated
shift of the preceding transport. -/
theorem correction_eq_neg_of_closed
    {X : Type*} {coordinate : X → ℝ}
    {x y : X} {δ κ : ℝ}
    (forward : LogTransport X coordinate x y δ)
    (correction : LogTransport X coordinate y x κ) :
    κ = -δ := by
  have hzero := (forward.comp correction).shift_eq_zero_of_closed rfl
  linarith

/-- An uncorrected positive shift cannot be a same-pilot loop. -/
theorem no_closed_transport_of_positive_shift
    {X : Type*} {coordinate : X → ℝ}
    {x y : X} {δ : ℝ}
    (P : LogTransport X coordinate x y δ)
    (hδ : 0 < δ) :
    y ≠ x :=
  P.not_closed_of_shift_ne_zero hδ.ne'

/-! ## Prime logarithms -/

/-- The p-adic valuation of a distinct rational prime is zero, while the
valuation of p itself is one. -/
theorem padicValRat_natPrime
    {p q : ℕ} (hp : p.Prime) (hq : q.Prime) :
    padicValRat p (q : ℚ) = if p = q then 1 else 0 := by
  by_cases h : p = q
  · subst q
    simp [padicValRat.self hp.one_lt]
  · letI : Fact p.Prime := ⟨hp⟩
    letI : Fact q.Prime := ⟨hq⟩
    simp [h, padicValRat.of_nat, padicValNat_primes h]

/-- The p-adic valuation of a finite product of rational prime powers is the
sum of the corresponding valuations. -/
theorem padicValRat_finset_prod_zpow
    {α : Type*} (q : ℕ) (s : Finset α)
    (prime : α → ℕ) (exponent : α → ℤ)
    (hq : q.Prime)
    (hprime : ∀ i, (prime i).Prime) :
    padicValRat q (∏ i ∈ s, ((prime i : ℕ) : ℚ) ^ exponent i) =
      ∑ i ∈ s, exponent i * padicValRat q ((prime i : ℕ) : ℚ) := by
  classical
  letI : Fact q.Prime := ⟨hq⟩
  induction s using Finset.induction_on with
  | empty =>
      simp [padicValRat.one]
  | @insert a s ha ih =>
      have hfactor :
          (((prime a : ℕ) : ℚ) ^ exponent a) ≠ 0 := by
        exact zpow_ne_zero _ (by exact_mod_cast (hprime a).ne_zero)
      have hproduct :
          (∏ i ∈ s, ((prime i : ℕ) : ℚ) ^ exponent i) ≠ 0 := by
        apply Finset.prod_ne_zero_iff.mpr
        intro i hi
        exact zpow_ne_zero _ (by exact_mod_cast (hprime i).ne_zero)
      rw [Finset.prod_insert ha, Finset.sum_insert ha,
        padicValRat.mul hfactor hproduct, padicValRat.zpow, ih]

/-- Integer linear independence of logarithms of distinct rational primes. -/
theorem integer_prime_log_independence
    {α : Type*} [Fintype α]
    (prime : α → ℕ)
    (hprime : ∀ i, (prime i).Prime)
    (hinjective : Function.Injective prime)
    (coefficient : α → ℤ)
    (hlog :
      ∑ i, (coefficient i : ℝ) * Real.log (prime i : ℝ) = 0) :
    ∀ i, coefficient i = 0 := by
  classical
  have hlogProduct :
      Real.log (∏ i, ((prime i : ℕ) : ℝ) ^ coefficient i) = 0 := by
    calc
      Real.log (∏ i, ((prime i : ℕ) : ℝ) ^ coefficient i) =
          ∑ i, Real.log (((prime i : ℕ) : ℝ) ^ coefficient i) := by
            apply Real.log_prod
            intro i hi
            exact zpow_ne_zero _ (by exact_mod_cast (hprime i).ne_zero)
      _ = ∑ i, (coefficient i : ℝ) * Real.log (prime i : ℝ) := by
            apply Finset.sum_congr rfl
            intro i hi
            exact Real.log_zpow _ _
      _ = 0 := hlog
  have hrealProduct :
      (∏ i, ((prime i : ℕ) : ℝ) ^ coefficient i) = 1 := by
    apply Real.eq_one_of_pos_of_log_eq_zero
    · apply Finset.prod_pos
      intro i hi
      exact zpow_pos (by exact_mod_cast (hprime i).pos) _
    · exact hlogProduct
  have hratProduct :
      (∏ i, ((prime i : ℕ) : ℚ) ^ coefficient i) = 1 := by
    apply Rat.cast_injective (α := ℝ)
    push_cast
    exact hrealProduct
  intro j
  have hvaluation :=
    congrArg (padicValRat (prime j)) hratProduct
  rw [padicValRat_finset_prod_zpow (prime j) Finset.univ
      prime coefficient (hprime j) hprime, padicValRat.one] at hvaluation
  have hcomponent : ∀ i,
      padicValRat (prime j) ((prime i : ℕ) : ℚ) =
        if j = i then 1 else 0 := by
    intro i
    by_cases hji : j = i
    · subst i
      simp [padicValRat_natPrime (hprime j) (hprime j)]
    · have hpne : prime j ≠ prime i := fun h => hji (hinjective h)
      simp [padicValRat_natPrime (hprime j) (hprime i), hji, hpne]
  simp_rw [hcomponent] at hvaluation
  simpa using hvaluation

/-- Rational linear independence of logarithms of distinct rational primes.
This is the prime-by-prime balance theorem used by the holonomy ledger. -/
theorem rational_prime_log_independence
    {α : Type*} [Fintype α]
    (prime : α → ℕ)
    (hprime : ∀ i, (prime i).Prime)
    (hinjective : Function.Injective prime)
    (coefficient : α → ℚ)
    (hlog :
      ∑ i, (coefficient i : ℝ) * Real.log (prime i : ℝ) = 0) :
    ∀ i, coefficient i = 0 := by
  classical
  let commonDenominator : ℕ := ∏ i, (coefficient i).den
  have hdenominator_pos : 0 < commonDenominator := by
    dsimp [commonDenominator]
    apply Finset.prod_pos
    intro i hi
    exact (coefficient i).den_pos
  have hdenominator_dvd : ∀ i,
      (coefficient i).den ∣ commonDenominator := by
    intro i
    dsimp [commonDenominator]
    exact Finset.dvd_prod_of_mem
      (fun j => (coefficient j).den) (Finset.mem_univ i)
  let integerCoefficient : α → ℤ := fun i =>
    (coefficient i).num *
      (commonDenominator / (coefficient i).den : ℕ)
  have hscaleQ : ∀ i,
      (integerCoefficient i : ℚ) =
        (commonDenominator : ℚ) * coefficient i := by
    intro i
    have hdenQ : ((coefficient i).den : ℚ) ≠ 0 := by
      exact_mod_cast (coefficient i).den_ne_zero
    dsimp [integerCoefficient]
    calc
      (((coefficient i).num *
          (commonDenominator / (coefficient i).den : ℕ) : ℤ) : ℚ) =
          ((coefficient i).num : ℚ) *
            (commonDenominator / (coefficient i).den : ℕ) := by
              push_cast
              rfl
      _ = ((coefficient i).num : ℚ) *
            ((commonDenominator : ℚ) / (coefficient i).den) := by
              rw [Nat.cast_div (hdenominator_dvd i) hdenQ]
      _ = (commonDenominator : ℚ) * coefficient i := by
              conv_rhs => rw [← (coefficient i).num_div_den]
              field_simp
  have hscaleR : ∀ i,
      (integerCoefficient i : ℝ) =
        (commonDenominator : ℝ) * (coefficient i : ℝ) := by
    intro i
    exact_mod_cast hscaleQ i
  have hintegerLog :
      ∑ i, (integerCoefficient i : ℝ) * Real.log (prime i : ℝ) = 0 := by
    calc
      ∑ i, (integerCoefficient i : ℝ) * Real.log (prime i : ℝ) =
          (commonDenominator : ℝ) *
            ∑ i, (coefficient i : ℝ) * Real.log (prime i : ℝ) := by
              rw [Finset.mul_sum]
              apply Finset.sum_congr rfl
              intro i hi
              rw [hscaleR]
              ring
      _ = 0 := by rw [hlog, mul_zero]
  have hintegerZero := integer_prime_log_independence
    prime hprime hinjective integerCoefficient hintegerLog
  intro i
  have hscaled := hscaleQ i
  rw [hintegerZero i] at hscaled
  simp only [Int.cast_zero] at hscaled
  have hdenominatorQ : (commonDenominator : ℚ) ≠ 0 := by
    exact_mod_cast hdenominator_pos.ne'
  exact (mul_eq_zero.mp hscaled.symm).resolve_left hdenominatorQ

/-- A finite place-by-place ledger for logarithmic transport shifts. -/
structure PrimeLogHolonomyLedger (α : Type*) [Fintype α] where
  prime : α → ℕ
  prime_isPrime : ∀ i, (prime i).Prime
  prime_injective : Function.Injective prime
  coefficient : α → ℚ

/-- The total real logarithmic shift recorded by a prime ledger. -/
noncomputable def PrimeLogHolonomyLedger.totalShift
    {α : Type*} [Fintype α] (L : PrimeLogHolonomyLedger α) : ℝ :=
  ∑ i, (L.coefficient i : ℝ) * Real.log (L.prime i : ℝ)

/-- A zero global shift forces every rational-prime coefficient to vanish. -/
theorem PrimeLogHolonomyLedger.coefficients_eq_zero
    {α : Type*} [Fintype α] (L : PrimeLogHolonomyLedger α)
    (hzero : L.totalShift = 0) :
    ∀ i, L.coefficient i = 0 :=
  rational_prime_log_independence
    L.prime L.prime_isPrime L.prime_injective L.coefficient hzero

/-- If a transport with a rational-prime ledger returns to the same pointed
object, then its shift cancels separately at every prime. -/
theorem PrimeLogHolonomyLedger.coefficients_eq_zero_of_closed
    {α : Type*} [Fintype α] (L : PrimeLogHolonomyLedger α)
    {X : Type*} {coordinate : X → ℝ} {x y : X}
    (P : LogTransport X coordinate x y L.totalShift)
    (hclosed : y = x) :
    ∀ i, L.coefficient i = 0 :=
  L.coefficients_eq_zero (P.shift_eq_zero_of_closed hclosed)

/-! ## A full counterexample to scalar reconstruction of positive weights -/

/-- Three strictly positive real weights normalized to have total mass one. -/
structure PositiveNormalizedTriple where
  left : ℝ
  middle : ℝ
  right : ℝ
  left_pos : 0 < left
  middle_pos : 0 < middle
  right_pos : 0 < right
  normalized : left + middle + right = 1

/-- The scalar obtained by weighting three labelled real coordinates. -/
def PositiveNormalizedTriple.scalar
    (W : PositiveNormalizedTriple) (a b c : ℝ) : ℝ :=
  W.left * a + W.middle * b + W.right * c

/-- Any three strictly ordered real coordinates admit two different positive
normalized weight systems with the same scalar aggregate. -/
theorem positive_normalized_three_point_scalar_collision
    {a b c : ℝ} (hab : a < b) (hbc : b < c) :
    ∃ W V : PositiveNormalizedTriple,
      W ≠ V ∧ W.scalar a b c = V.scalar a b c := by
  have hac : 0 < c - a := sub_pos.mpr (hab.trans hbc)
  let W : PositiveNormalizedTriple :=
    { left := (c - b) / (2 * (c - a))
      middle := (1 : ℝ) / 2
      right := (b - a) / (2 * (c - a))
      left_pos := div_pos (sub_pos.mpr hbc) (mul_pos (by norm_num) hac)
      middle_pos := by norm_num
      right_pos := div_pos (sub_pos.mpr hab) (mul_pos (by norm_num) hac)
      normalized := by
        field_simp [hac.ne']
        ring }
  let V : PositiveNormalizedTriple :=
    { left := (c - b) / (3 * (c - a))
      middle := (2 : ℝ) / 3
      right := (b - a) / (3 * (c - a))
      left_pos := div_pos (sub_pos.mpr hbc) (mul_pos (by norm_num) hac)
      middle_pos := by norm_num
      right_pos := div_pos (sub_pos.mpr hab) (mul_pos (by norm_num) hac)
      normalized := by
        field_simp [hac.ne']
        ring }
  have hWscalar : W.scalar a b c = b := by
    dsimp [W, PositiveNormalizedTriple.scalar]
    field_simp [hac.ne']
    ring
  have hVscalar : V.scalar a b c = b := by
    dsimp [V, PositiveNormalizedTriple.scalar]
    field_simp [hac.ne']
    ring
  have hdistinct : W ≠ V := by
    intro hWV
    have hmiddle := congrArg PositiveNormalizedTriple.middle hWV
    dsimp [W, V] at hmiddle
    norm_num at hmiddle
  exact ⟨W, V, hdistinct, hWscalar.trans hVscalar.symm⟩

/-- Full counterexample for the labelled prime coordinates log 2, log 3,
and log 5. Equality of one scalar log-volume does not reconstruct even
strictly positive normalized real place weights. -/
theorem positive_normalized_prime_log_scalar_collision :
    ∃ W V : PositiveNormalizedTriple,
      W ≠ V ∧
        W.scalar (Real.log 2) (Real.log 3) (Real.log 5) =
          V.scalar (Real.log 2) (Real.log 3) (Real.log 5) := by
  exact positive_normalized_three_point_scalar_collision
    (Real.log_lt_log (by norm_num) (by norm_num))
    (Real.log_lt_log (by norm_num) (by norm_num))

/-- Full counterexample to linear independence over arbitrary real
coefficients: log 2 and log 3 cancel with nonzero real coefficients. -/
theorem real_prime_log_dependence :
    ∃ c₂ c₃ : ℝ,
      c₂ ≠ 0 ∧ c₃ ≠ 0 ∧
        c₂ * Real.log 2 + c₃ * Real.log 3 = 0 := by
  refine ⟨Real.log 3, -Real.log 2, ?_, ?_, ?_⟩
  · exact (Real.log_pos (by norm_num)).ne'
  · exact neg_ne_zero.mpr (Real.log_pos (by norm_num)).ne'
  · ring

#print axioms valuationBall_primePreimage_add
#print axioms padicValuationBall_nonempty
#print axioms padicValuationBall_prime_preimage
#print axioms padicValuationBall_subset_iff
#print axioms valuationBall_logVolume_antitone
#print axioms restrictedShiftedLogVolume_nonempty
#print axioms packetLogVolume_primePreimage_add
#print axioms processionAverage_add_common
#print axioms LogTransport.comp
#print axioms LogTransport.reverse
#print axioms LogTransport.shift_eq_zero_of_closed
#print axioms LogTransport.not_closed_of_shift_ne_zero
#print axioms correction_eq_neg_log_of_closed
#print axioms correction_eq_neg_of_closed
#print axioms no_closed_transport_of_positive_shift
#print axioms padicValRat_natPrime
#print axioms padicValRat_finset_prod_zpow
#print axioms integer_prime_log_independence
#print axioms rational_prime_log_independence
#print axioms PrimeLogHolonomyLedger.coefficients_eq_zero
#print axioms PrimeLogHolonomyLedger.coefficients_eq_zero_of_closed
#print axioms positive_normalized_three_point_scalar_collision
#print axioms positive_normalized_prime_log_scalar_collision
#print axioms real_prime_log_dependence

end IUTCorrectedVolumeHolonomy20260901
end IUTThreeClosures
