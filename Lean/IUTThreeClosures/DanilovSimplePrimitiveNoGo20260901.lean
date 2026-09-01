/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.DanilovRecursiveLift20260901

/-!
# A simple-primitive-divisor no-go for general real Lucas sequences

The mathematical proof precedes this file in
`research/ABC_DANILOV_SIMPLE_PRIMITIVE_DIVISOR_2026_09_01.md`.

This module gives a complete object-level counterexample to the tempting
sequence-uniform shortcut: standard real, nondegenerate Lucas hypotheses do
not force a simple primitive prime divisor at every index of the form `10*q`.
For `P = 2`, `Q = -3`, the term at index ten is

`U_10 = 14762 = 2 * 11^2 * 61`.

The prime `11` is its unique primitive prime divisor and occurs to exact
exponent two.  This does not refute the Fibonacci-specific assertion needed
by the Danilov route.

A second exact calculation at the odd Fibonacci index `15` shows that the
half-Lucas residue modulo the primitive prime `61` squares to `-1`, rather
than being a sign.  It refutes only the parity-free auxiliary formulation;
the Danilov indices `10*q` are even.

The final section records only elementary abstract consequences of a failure
of simplicity: a multiplicity-preserving primitive part is two-full, all
exponent-one factors lie in a stated finite correction support, and a split
prime outside the first forty progressions is at least `41*n+1`.  No theorem
of Carmichael, Yabuta, Sanna, Hong, or Bilu--Hanrot--Voutier is assumed.
-/

namespace IUTThreeClosures
namespace DanilovSimplePrimitiveNoGo20260901

open KFullRadicalCompression

/-! ## Lucas sequences and the standard real hypotheses -/

/-- The first Lucas sequence with integral parameters `P,Q`:
`U_0=0`, `U_1=1`, and `U_(n+2)=P*U_(n+1)-Q*U_n`. -/
def lucasU (P Q : ℤ) : ℕ → ℤ
  | 0 => 0
  | 1 => 1
  | n + 2 => P * lucasU P Q (n + 1) - Q * lucasU P Q n

@[simp] theorem lucasU_zero (P Q : ℤ) : lucasU P Q 0 = 0 := rfl

@[simp] theorem lucasU_one (P Q : ℤ) : lucasU P Q 1 = 1 := rfl

@[simp] theorem lucasU_succ_succ (P Q : ℤ) (n : ℕ) :
    lucasU P Q (n + 2) =
      P * lucasU P Q (n + 1) - Q * lucasU P Q n := rfl

/-- A concrete formulation of the standard hypotheses used by the
sequence-uniform statement.  The displayed real roots have sum `P`, product
`Q`, are distinct, and their ratio is not a root of unity. -/
structure StandardRealLucasParameters where
  P : ℤ
  Q : ℤ
  alpha : ℝ
  beta : ℝ
  parameter_coprime : P.natAbs.Coprime Q.natAbs
  P_ne_zero : P ≠ 0
  Q_ne_zero : Q ≠ 0
  roots_sum : alpha + beta = (P : ℝ)
  roots_product : alpha * beta = (Q : ℝ)
  roots_distinct : alpha ≠ beta
  discriminant_pos : 0 < (P : ℝ) ^ 2 - 4 * (Q : ℝ)
  beta_ne_zero : beta ≠ 0
  root_ratio_non_torsion :
    ∀ k : ℕ, 0 < k → (alpha / beta) ^ k ≠ 1

/-- The concrete counterexample sequence. -/
def counterLucasU (n : ℕ) : ℤ := lucasU 2 (-3) n

/-- The roots `3,-1` certify all standard real, coprime-parameter and
nondegeneracy hypotheses for `P=2,Q=-3`. -/
def counterParameters : StandardRealLucasParameters where
  P := 2
  Q := -3
  alpha := 3
  beta := -1
  parameter_coprime := by norm_num
  P_ne_zero := by norm_num
  Q_ne_zero := by norm_num
  roots_sum := by norm_num
  roots_product := by norm_num
  roots_distinct := by norm_num
  discriminant_pos := by norm_num
  beta_ne_zero := by norm_num
  root_ratio_non_torsion := by
    intro k hk
    rw [show (3 : ℝ) / (-1) = -3 by norm_num]
    intro heq
    have habs := congrArg abs heq
    have hlarge : (1 : ℝ) < 3 ^ k :=
      one_lt_pow₀ (by norm_num) (Nat.ne_of_gt hk)
    rw [abs_pow] at habs
    norm_num at habs
    linarith

/-! ## Exact index-ten computation -/

/-- Direct recurrence evaluation through index ten. -/
theorem counterLucas_values_through_ten :
    counterLucasU 0 = 0 ∧
    counterLucasU 1 = 1 ∧
    counterLucasU 2 = 2 ∧
    counterLucasU 3 = 7 ∧
    counterLucasU 4 = 20 ∧
    counterLucasU 5 = 61 ∧
    counterLucasU 6 = 182 ∧
    counterLucasU 7 = 547 ∧
    counterLucasU 8 = 1640 ∧
    counterLucasU 9 = 4921 ∧
    counterLucasU 10 = 14762 := by
  norm_num [counterLucasU, lucasU]

theorem counterLucas_ten_factorization :
    (counterLucasU 10).natAbs = 2 * 11 ^ 2 * 61 := by
  norm_num [counterLucasU, lucasU]

/-- The homogeneous tenth cyclotomic factor at the roots `3,-1` is the
repeated primitive factor `11^2`. -/
theorem counter_homogeneousCyclotomic_ten :
    (3 : ℤ) ^ 4 - 3 ^ 3 * (-1) + 3 ^ 2 * (-1) ^ 2 -
        3 * (-1) ^ 3 + (-1) ^ 4 = 11 ^ 2 := by
  norm_num

/-- The factor `11` occurs to exact exponent two at index ten. -/
theorem eleven_exact_square_at_ten :
    11 ^ 2 ∣ (counterLucasU 10).natAbs ∧
      ¬ 11 ^ 3 ∣ (counterLucasU 10).natAbs := by
  norm_num [counterLucasU, lucasU]

/-! ## Primitive and simple primitive prime divisors -/

/-- A prime divisor at index `n` which divides no positive earlier term. -/
def IsPrimitivePrimeDivisor (u : ℕ → ℤ) (n p : ℕ) : Prop :=
  p.Prime ∧ p ∣ (u n).natAbs ∧
    ∀ m : ℕ, 0 < m → m < n → ¬ p ∣ (u m).natAbs

/-- A primitive prime divisor of exact exponent one. -/
def IsSimplePrimitivePrimeDivisor (u : ℕ → ℤ) (n p : ℕ) : Prop :=
  IsPrimitivePrimeDivisor u n p ∧ ¬ p ^ 2 ∣ (u n).natAbs

theorem eleven_isPrimitive_at_ten :
    IsPrimitivePrimeDivisor counterLucasU 10 11 := by
  refine ⟨by norm_num, by norm_num [counterLucasU, lucasU], ?_⟩
  intro m hm hm10
  interval_cases m <;> norm_num [counterLucasU, lucasU]

theorem two_not_primitive_at_ten :
    ¬ IsPrimitivePrimeDivisor counterLucasU 10 2 := by
  intro h
  exact h.2.2 2 (by norm_num) (by norm_num)
    (by norm_num [counterLucasU, lucasU])

theorem sixtyOne_not_primitive_at_ten :
    ¬ IsPrimitivePrimeDivisor counterLucasU 10 61 := by
  intro h
  exact h.2.2 5 (by norm_num) (by norm_num)
    (by norm_num [counterLucasU, lucasU])

/-- `11` is the unique primitive prime divisor at index ten. -/
theorem primitivePrimeDivisor_at_ten_iff (p : ℕ) :
    IsPrimitivePrimeDivisor counterLucasU 10 p ↔ p = 11 := by
  constructor
  · intro h
    have hdiv : p ∣ 2 * 11 ^ 2 * 61 := by
      simpa [counterLucas_ten_factorization] using h.2.1
    rcases h.1.dvd_mul.mp hdiv with hleft | h61
    · rcases h.1.dvd_mul.mp hleft with h2 | h121
      · have hp2 : p = 2 :=
          (Nat.prime_dvd_prime_iff_eq h.1 (by norm_num)).mp h2
        exact (two_not_primitive_at_ten (hp2 ▸ h)).elim
      · have h11 : p ∣ 11 := h.1.dvd_of_dvd_pow h121
        exact (Nat.prime_dvd_prime_iff_eq h.1 (by norm_num)).mp h11
    · have hp61 : p = 61 :=
        (Nat.prime_dvd_prime_iff_eq h.1 (by norm_num)).mp h61
      exact (sixtyOne_not_primitive_at_ten (hp61 ▸ h)).elim
  · rintro rfl
    exact eleven_isPrimitive_at_ten

theorem eleven_not_simple_at_ten :
    ¬ IsSimplePrimitivePrimeDivisor counterLucasU 10 11 := by
  intro h
  exact h.2 eleven_exact_square_at_ten.1

/-- The exact sequence-uniform shortcut refuted below. -/
def SequenceUniformSimplePrimitiveAtTenMultiples : Prop :=
  ∀ D : StandardRealLucasParameters, ∀ q : ℕ, 0 < q →
    ∃ p : ℕ,
      IsSimplePrimitivePrimeDivisor (lucasU D.P D.Q) (10 * q) p

/-- Full counterexample: the standard hypotheses alone do not imply a simple
primitive prime divisor at every index `10*q`. -/
theorem not_sequenceUniformSimplePrimitiveAtTenMultiples :
    ¬ SequenceUniformSimplePrimitiveAtTenMultiples := by
  intro hUniform
  obtain ⟨p, hp⟩ := hUniform counterParameters 1 (by norm_num)
  have hp' : IsSimplePrimitivePrimeDivisor counterLucasU 10 p := by
    change IsSimplePrimitivePrimeDivisor (lucasU 2 (-3)) 10 p
    simpa [counterParameters] using hp
  have hp11 : p = 11 := (primitivePrimeDivisor_at_ten_iff p).mp hp'.1
  exact eleven_not_simple_at_ten (hp11 ▸ hp')

/-! ## The parity-free Lucas-unit assertion is false

The corrected paper assumes that the Fibonacci index is even before
concluding that the half-Lucas residue is a sign.  The following finite
calculation records why that parity hypothesis is necessary.  It uses no
rank-of-apparition or valuation theorem: primitiveness of `61` at index
fifteen is checked against every earlier positive term.
-/

/-- The Fibonacci sequence as the Lucas sequence with parameters `1,-1`. -/
def fibonacciU (n : ℕ) : ℤ := lucasU 1 (-1) n

/-- The companion Fibonacci--Lucas sequence: `L_0=2`, `L_1=1`, and
`L_(n+2)=L_(n+1)+L_n`. -/
def fibonacciL : ℕ → ℤ
  | 0 => 2
  | 1 => 1
  | n + 2 => fibonacciL (n + 1) + fibonacciL n

/-- The residue called `s=L_n/2` in the Lucas-unit formulation.  The prime
hypothesis supplies the field structure on `ZMod p`. -/
def halfLucasResidue (n p : ℕ) (hp : p.Prime) : ZMod p :=
  letI : Fact p.Prime := ⟨hp⟩
  (fibonacciL n : ZMod p) / (2 : ZMod p)

theorem fibonacciU_fifteen : fibonacciU 15 = 610 := by
  norm_num [fibonacciU, lucasU]

theorem fibonacciU_fifteen_factorization :
    (fibonacciU 15).natAbs = 2 * 5 * 61 := by
  norm_num [fibonacciU, lucasU]

theorem fibonacciL_fifteen : fibonacciL 15 = 1364 := by
  norm_num [fibonacciL]

theorem sixtyOne_prime : (61 : ℕ).Prime := by
  norm_num

/-- Direct finite proof that `z(61)=15`: `61` divides `F_15` and divides no
positive earlier Fibonacci term. -/
theorem sixtyOne_isPrimitive_at_fifteen :
    IsPrimitivePrimeDivisor fibonacciU 15 61 := by
  refine ⟨sixtyOne_prime, by norm_num [fibonacciU, lucasU], ?_⟩
  intro m hm hm15
  interval_cases m <;> norm_num [fibonacciU, lucasU]

theorem halfLucasResidue_fifteen_sixtyOne_eq_eleven :
    halfLucasResidue 15 61 sixtyOne_prime = 11 := by
  letI : Fact (Nat.Prime 61) := ⟨sixtyOne_prime⟩
  change (1364 : ZMod 61) / 2 = 11
  apply (div_eq_iff (by decide : (2 : ZMod 61) ≠ 0)).2
  decide

/-- At the odd index fifteen the half-Lucas residue squares to `-1`, rather
than to `1`. -/
theorem halfLucasResidue_fifteen_sixtyOne_sq_eq_neg_one :
    halfLucasResidue 15 61 sixtyOne_prime ^ 2 = -1 := by
  rw [halfLucasResidue_fifteen_sixtyOne_eq_eleven]
  decide

theorem halfLucasResidue_fifteen_sixtyOne_ne_sign :
    halfLucasResidue 15 61 sixtyOne_prime ≠ 1 ∧
      halfLucasResidue 15 61 sixtyOne_prime ≠ -1 := by
  rw [halfLucasResidue_fifteen_sixtyOne_eq_eleven]
  decide

/-- The formerly claimed parity-free sign conclusion, isolated with exactly
the numerical hypotheses used in Proposition 3.2 before its correction. -/
def HalfLucasSignWithoutEvenness : Prop :=
  ∀ n p : ℕ, 5 < n → 5 ∣ n →
    ∀ hprimitive : IsPrimitivePrimeDivisor fibonacciU n p,
      halfLucasResidue n p hprimitive.1 = 1 ∨
        halfLucasResidue n p hprimitive.1 = -1

/-- The exact odd-index counterexample `n=15,p=61` refutes the parity-free
formulation. -/
theorem not_halfLucasSignWithoutEvenness :
    ¬ HalfLucasSignWithoutEvenness := by
  intro h
  have hs := h 15 61 (by norm_num) (by norm_num)
    sixtyOne_isPrimitive_at_fifteen
  exact hs.elim
    halfLucasResidue_fifteen_sixtyOne_ne_sign.1
    halfLucasResidue_fifteen_sixtyOne_ne_sign.2

/-- The counterexample index is not a Danilov index of the form `10*Q`. -/
theorem fifteen_not_DanilovIndex : ¬ ∃ Q : ℕ, 15 = 10 * Q := by
  rintro ⟨Q, hQ⟩
  omega

/-- Every index used by the Danilov route is even, so the finite odd-index
counterexample does not refute the corrected even-index assertion. -/
theorem danilovIndex_even (Q : ℕ) : Even (10 * Q) := by
  refine ⟨5 * Q, ?_⟩
  ring

/-! ## Elementary consequences for a surviving Fibonacci-specific failure -/

/-- A factor containing exactly the multiplicities of every primitive prime
of the displayed term. -/
def CarriesPrimitiveMultiplicities
    (u : ℕ → ℤ) (n M : ℕ) : Prop :=
  ∀ p : ℕ, IsPrimitivePrimeDivisor u n p →
    M.factorization p = (u n).natAbs.factorization p

/-- If every prime of a multiplicity-preserving primitive part is primitive
and every primitive divisor is repeated in the sequence term, that primitive
part is two-full (powerful). -/
theorem primitivePart_twoFull_of_all_primitive_repeated
    {u : ℕ → ℤ} {n M : ℕ}
    (hM : M ≠ 0) (hterm : (u n).natAbs ≠ 0)
    (hallPrimitive :
      ∀ p : ℕ, p.Prime → p ∣ M → IsPrimitivePrimeDivisor u n p)
    (hcarry : CarriesPrimitiveMultiplicities u n M)
    (hrepeated :
      ∀ p : ℕ, IsPrimitivePrimeDivisor u n p →
        p ^ 2 ∣ (u n).natAbs) :
    IsKFull 2 M := by
  refine ⟨hM, ?_⟩
  intro p hp hpM
  have hprimitive := hallPrimitive p hp hpM
  have hleTerm : 2 ≤ (u n).natAbs.factorization p :=
    (hp.pow_dvd_iff_le_factorization hterm).mp
      (hrepeated p hprimitive)
  rw [hcarry p hprimitive]
  exact hleTerm

/-- The exponent-one support of an integer.  In a cyclotomic application
this is precisely the support which cannot belong to a powerful primitive
part. -/
def exponentOneSupport (C : ℕ) : Finset ℕ :=
  C.primeFactors.filter (fun p => ¬ p ^ 2 ∣ C)

/-- If every prime outside a stated finite correction set occurs at least
twice, every exponent-one factor lies in that correction support. -/
theorem exponentOneSupport_subset_finiteCorrection
    {C : ℕ} {S : Finset ℕ}
    (hrepeatedOutside :
      ∀ p : ℕ, p.Prime → p ∣ C → p ∉ S → p ^ 2 ∣ C) :
    exponentOneSupport C ⊆ S := by
  intro p hp
  rw [exponentOneSupport, Finset.mem_filter] at hp
  have hpPrime : p.Prime := Nat.prime_of_mem_primeFactors hp.1
  have hpDiv : p ∣ C := Nat.dvd_of_mem_primeFactors hp.1
  by_contra hpNotS
  exact hp.2 (hrepeatedOutside p hpPrime hpDiv hpNotS)

/-- Multiplicity preservation transfers repeatedness from the sequence term
to every primitive factor of the chosen cyclotomic-type factor. -/
theorem square_dvd_outside_correction_of_all_primitive_repeated
    {u : ℕ → ℤ} {n C : ℕ} {S : Finset ℕ}
    (hC : C ≠ 0) (hterm : (u n).natAbs ≠ 0)
    (houtsidePrimitive :
      ∀ p : ℕ, p.Prime → p ∣ C → p ∉ S →
        IsPrimitivePrimeDivisor u n p)
    (hcarry : CarriesPrimitiveMultiplicities u n C)
    (hrepeated :
      ∀ p : ℕ, IsPrimitivePrimeDivisor u n p →
        p ^ 2 ∣ (u n).natAbs) :
    ∀ p : ℕ, p.Prime → p ∣ C → p ∉ S → p ^ 2 ∣ C := by
  intro p hp hpC hpNotS
  have hprimitive := houtsidePrimitive p hp hpC hpNotS
  have hleTerm : 2 ≤ (u n).natAbs.factorization p :=
    (hp.pow_dvd_iff_le_factorization hterm).mp
      (hrepeated p hprimitive)
  apply (hp.pow_dvd_iff_le_factorization hC).mpr
  rw [hcarry p hprimitive]
  exact hleTerm

/-- Hence, under the same primitive-multiplicity hypotheses, every
exponent-one prime lies in the finite correction support. -/
theorem exponentOneSupport_subset_correction_of_all_primitive_repeated
    {u : ℕ → ℤ} {n C : ℕ} {S : Finset ℕ}
    (hC : C ≠ 0) (hterm : (u n).natAbs ≠ 0)
    (houtsidePrimitive :
      ∀ p : ℕ, p.Prime → p ∣ C → p ∉ S →
        IsPrimitivePrimeDivisor u n p)
    (hcarry : CarriesPrimitiveMultiplicities u n C)
    (hrepeated :
      ∀ p : ℕ, IsPrimitivePrimeDivisor u n p →
        p ^ 2 ∣ (u n).natAbs) :
    exponentOneSupport C ⊆ S :=
  exponentOneSupport_subset_finiteCorrection
    (square_dvd_outside_correction_of_all_primitive_repeated
      hC hterm houtsidePrimitive hcarry hrepeated)

theorem exponentOneSupport_card_le_finiteCorrection
    {C : ℕ} {S : Finset ℕ}
    (hrepeatedOutside :
      ∀ p : ℕ, p.Prime → p ∣ C → p ∉ S → p ^ 2 ∣ C) :
    (exponentOneSupport C).card ≤ S.card :=
  Finset.card_le_card
    (exponentOneSupport_subset_finiteCorrection hrepeatedOutside)

/-- Convert the split congruence `n ∣ p-1` into its progression
coefficient, retaining the elementary positivity needed below. -/
theorem exists_positive_splitCoefficient
    {n p : ℕ} (hn : 0 < n) (hnp : n < p) (hsplit : n ∣ p - 1) :
    ∃ k : ℕ, 0 < k ∧ p = k * n + 1 := by
  obtain ⟨k, hk⟩ := hsplit
  have hp : 0 < p := hn.trans hnp
  have hpEq : p = k * n + 1 := by
    calc
      p = (p - 1) + 1 := by omega
      _ = n * k + 1 := by rw [hk]
      _ = k * n + 1 := by rw [Nat.mul_comm]
  have hkPos : 0 < k := by
    by_contra hkNot
    have hkZero : k = 0 := by omega
    rw [hkZero] at hpEq
    omega
  exact ⟨k, hkPos, hpEq⟩

/-- Pure arithmetic tail of the `41*n+1` argument: a split prime which is
not one of `j*n+1`, `1 ≤ j ≤ 40`, begins at `41*n+1`. -/
theorem fortyOne_mul_add_one_le_of_split_and_avoid
    {n p : ℕ} (hn : 0 < n) (hnp : n < p)
    (hsplit : n ∣ p - 1)
    (havoid : ∀ j : ℕ, 1 ≤ j → j ≤ 40 → p ≠ j * n + 1) :
    41 * n + 1 ≤ p := by
  obtain ⟨k, hkPos, rfl⟩ :=
    exists_positive_splitCoefficient hn hnp hsplit
  have hk : 41 ≤ k := by
    by_contra hnot
    have hk40 : k ≤ 40 := by omega
    exact (havoid k (by omega) hk40) rfl
  exact Nat.add_le_add_right (Nat.mul_le_mul_right n hk) 1

#print axioms counterLucas_values_through_ten
#print axioms counterLucas_ten_factorization
#print axioms counter_homogeneousCyclotomic_ten
#print axioms eleven_exact_square_at_ten
#print axioms eleven_isPrimitive_at_ten
#print axioms primitivePrimeDivisor_at_ten_iff
#print axioms not_sequenceUniformSimplePrimitiveAtTenMultiples
#print axioms fibonacciU_fifteen
#print axioms fibonacciU_fifteen_factorization
#print axioms fibonacciL_fifteen
#print axioms sixtyOne_prime
#print axioms sixtyOne_isPrimitive_at_fifteen
#print axioms halfLucasResidue_fifteen_sixtyOne_eq_eleven
#print axioms halfLucasResidue_fifteen_sixtyOne_sq_eq_neg_one
#print axioms halfLucasResidue_fifteen_sixtyOne_ne_sign
#print axioms not_halfLucasSignWithoutEvenness
#print axioms fifteen_not_DanilovIndex
#print axioms danilovIndex_even
#print axioms primitivePart_twoFull_of_all_primitive_repeated
#print axioms exponentOneSupport_subset_finiteCorrection
#print axioms exponentOneSupport_subset_correction_of_all_primitive_repeated
#print axioms fortyOne_mul_add_one_le_of_split_and_avoid

end DanilovSimplePrimitiveNoGo20260901
end IUTThreeClosures
