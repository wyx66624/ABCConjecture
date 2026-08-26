import Mathlib

/-!
# Chebyshev index-three audit for the four-consecutive Pell unit

This file checks the exact scalar algebra used in
`FREY_PELL_CHEBYSHEV_INDEX_THREE_AUDIT.md`.

The complete list of integral points on the elliptic curve `216a1` is an
external Magma/LMFDB computation.  It enters below only through the explicit
proposition `MagmaIntegralXCertificate216a1`, which every theorem using that
computation takes as a hypothesis.  Thus the file does not pretend that Lean
has proved the completeness of that list.
-/

namespace IUTThreeClosures

open Polynomial

/-! ## Integer evaluations of first-kind Chebyshev polynomials -/

/-- The first-kind Chebyshev polynomial evaluated at an integer. -/
noncomputable def pellChebyshev (n : ℕ) (x : ℤ) : ℤ :=
  (Polynomial.Chebyshev.T ℤ (n : ℤ)).eval x

@[simp]
theorem pellChebyshev_zero (x : ℤ) : pellChebyshev 0 x = 1 := by
  simp [pellChebyshev]

@[simp]
theorem pellChebyshev_one (x : ℤ) : pellChebyshev 1 x = x := by
  simp [pellChebyshev]

/-- The scalar Chebyshev recurrence. -/
theorem pellChebyshev_add_two (n : ℕ) (x : ℤ) :
    pellChebyshev (n + 2) x =
      2 * x * pellChebyshev (n + 1) x - pellChebyshev n x := by
  unfold pellChebyshev
  have h := congrArg (fun p : ℤ[X] => p.eval x)
    (Polynomial.Chebyshev.T_add_two ℤ (n : ℤ))
  simpa using h

/-- The cubic formula used for index three. -/
theorem pellChebyshev_three (x : ℤ) :
    pellChebyshev 3 x = 4 * x ^ 3 - 3 * x := by
  rw [show 3 = 1 + 2 by norm_num, pellChebyshev_add_two]
  rw [show 2 = 0 + 2 by norm_num, pellChebyshev_add_two]
  simp
  ring

/-- The quintic formula recorded for the first unresolved prime index. -/
theorem pellChebyshev_five (x : ℤ) :
    pellChebyshev 5 x = 16 * x ^ 5 - 20 * x ^ 3 + 5 * x := by
  rw [show 5 = 3 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [show 4 = 2 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [show 3 = 1 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [show 2 = 0 + 2 by norm_num, pellChebyshev_add_two]
  simp
  ring

/-- Chebyshev composition, specialized to nonnegative indices and integer
evaluation. -/
theorem pellChebyshev_mul (m n : ℕ) (x : ℤ) :
    pellChebyshev (m * n) x =
      pellChebyshev m (pellChebyshev n x) := by
  unfold pellChebyshev
  rw [show ((m * n : ℕ) : ℤ) = (m : ℤ) * (n : ℤ) by norm_num]
  rw [Polynomial.Chebyshev.T_mul]
  simp

/-- At an integer `x > 1`, consecutive nonnegative Chebyshev evaluations are
positive and strictly increasing. -/
theorem pellChebyshev_one_le_and_lt_next (x : ℤ) (hx : 1 < x) :
    ∀ n : ℕ, 1 ≤ pellChebyshev n x ∧
      pellChebyshev n x < pellChebyshev (n + 1) x := by
  intro n
  induction n with
  | zero =>
      simp
      exact hx
  | succ n ih =>
      constructor
      · simpa [Nat.succ_eq_add_one] using
          (le_trans ih.1 (le_of_lt ih.2))
      · change pellChebyshev (n + 1) x < pellChebyshev (n + 2) x
        rw [pellChebyshev_add_two]
        have hx' : 0 ≤ x - 2 := by omega
        have hnonneg : 0 ≤ pellChebyshev (n + 1) x := by omega
        have hprod : 0 ≤ (x - 2) * pellChebyshev (n + 1) x :=
          mul_nonneg hx' hnonneg
        nlinarith

/-- A positive-index Chebyshev evaluation at `x > 1` is itself greater than
one. -/
theorem one_lt_pellChebyshev (n : ℕ) (x : ℤ)
    (hn : 0 < n) (hx : 1 < x) :
    1 < pellChebyshev n x := by
  obtain ⟨m, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : n ≠ 0)
  have h := pellChebyshev_one_le_and_lt_next x hx m
  have h' : 1 < pellChebyshev (m + 1) x :=
    lt_of_le_of_lt h.1 h.2
  simpa [Nat.succ_eq_add_one] using h'

/-! ## The external integral-point certificate and its kernel-checked filter -/

/-- The complete integral `X`-coordinate list reported by Magma V2.29-9 and
the LMFDB page for the curve `216a1`.

This finite set is merely data.  Completeness is represented by the separate
proposition below and is not asserted by this definition. -/
def magma216a1XCoordinates : Finset ℤ :=
  {-4, -2, 1, 2, 4, 10, 22, 89}

/-- External-computation interface: every integral point on
`Y^2 = X^3 - 12X + 20` has its `X`-coordinate in the reported finite set.

Lean does not prove this proposition in this file.  The Magma transcript and
LMFDB record supporting it are reproduced in the accompanying audit note. -/
def MagmaIntegralXCertificate216a1 : Prop :=
  ∀ X Y : ℤ, Y ^ 2 = X ^ 3 - 12 * X + 20 →
    X ∈ magma216a1XCoordinates

/-- Kernel verification of the positive, divisible-by-four filter on the
external finite list. -/
theorem magma216a1_positive_fourMultiple_filter
    (X : ℤ)
    (hmem : X ∈ magma216a1XCoordinates)
    (hpos : 0 < X)
    (hmod : X % 4 = 0) :
    X = 4 := by
  simp [magma216a1XCoordinates] at hmem
  rcases hmem with h | h | h | h | h | h | h | h <;> omega

/-! ## Exact index-three transformation -/

/-- The index-three shifted-square equation transforms to the integral-point
equation for `216a1` under `X=4T`, `Y=2y`. -/
theorem indexThree_to_216a1 (T y : ℤ)
    (h : y ^ 2 = 4 * pellChebyshev 3 T + 5) :
    (2 * y) ^ 2 = (4 * T) ^ 3 - 12 * (4 * T) + 20 := by
  rw [pellChebyshev_three] at h
  calc
    (2 * y) ^ 2 = 4 * y ^ 2 := by ring
    _ = 4 * (4 * (4 * T ^ 3 - 3 * T) + 5) := by rw [h]
    _ = (4 * T) ^ 3 - 12 * (4 * T) + 20 := by ring

/-- Conditional only on the transparent external certificate, the
index-three shifted-square equation at positive `T` forces `T=1`. -/
theorem indexThree_eq_one_of_external_certificate
    (hcert : MagmaIntegralXCertificate216a1)
    (T y : ℤ)
    (hT : 0 < T)
    (h : y ^ 2 = 4 * pellChebyshev 3 T + 5) :
    T = 1 := by
  have hcurve := indexThree_to_216a1 T y h
  have hmem : 4 * T ∈ magma216a1XCoordinates :=
    hcert (4 * T) (2 * y) hcurve
  have hX : 4 * T = 4 := by
    apply magma216a1_positive_fourMultiple_filter (4 * T) hmem
    · omega
    · omega
  omega

/-- Hence there is no index-three shifted square at `T > 1`, conditional on
the same external certificate. -/
theorem no_indexThree_of_external_certificate
    (hcert : MagmaIntegralXCertificate216a1)
    (T : ℤ)
    (hT : 1 < T) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev 3 T + 5 := by
  rintro ⟨y, hy⟩
  have h := indexThree_eq_one_of_external_certificate hcert T y (by omega) hy
  omega

/-! ## Prime-composition consequence -/

/-- If the shifted-square equation holds at a positive index and `T > 1`,
then index three cannot divide that index.  The only non-elementary input is
the explicit external integral-point certificate supplied as a hypothesis. -/
theorem three_not_dvd_chebyshev_shiftSquare_index
    (hcert : MagmaIntegralXCertificate216a1)
    (k : ℕ)
    (T y : ℤ)
    (hk : 0 < k)
    (hT : 1 < T)
    (hsquare : y ^ 2 = 4 * pellChebyshev k T + 5) :
    ¬ 3 ∣ k := by
  intro hdiv
  obtain ⟨m, rfl⟩ := hdiv
  have hm : 0 < m := by omega
  have hbase : 1 < pellChebyshev m T :=
    one_lt_pellChebyshev m T hm hT
  have hcomp : pellChebyshev (3 * m) T =
      pellChebyshev 3 (pellChebyshev m T) :=
    pellChebyshev_mul 3 m T
  have hshift : y ^ 2 =
      4 * pellChebyshev 3 (pellChebyshev m T) + 5 := by
    rw [← hcomp]
    exact hsquare
  exact no_indexThree_of_external_certificate hcert
    (pellChebyshev m T) hbase ⟨y, hshift⟩

/-! ## The explicitly unresolved prime-five curve -/

/-- The prime-five shifted-square equation has the stated genus-two affine
model.  No completeness claim about its rational points is made here. -/
theorem indexFive_genusTwo_model (T y : ℤ)
    (h : y ^ 2 = 4 * pellChebyshev 5 T + 5) :
    y ^ 2 = 64 * T ^ 5 - 80 * T ^ 3 + 20 * T + 5 := by
  rw [pellChebyshev_five] at h
  nlinarith

end IUTThreeClosures

#print axioms IUTThreeClosures.indexThree_to_216a1
#print axioms IUTThreeClosures.magma216a1_positive_fourMultiple_filter
#print axioms IUTThreeClosures.three_not_dvd_chebyshev_shiftSquare_index
