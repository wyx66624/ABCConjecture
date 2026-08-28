import IUTThreeClosures.FreyPellChebyshevPrimeIndexLocalPermutationBarrier

/-!
# Chebyshev target-five local simple-root core

This file closes the finite algebraic seam in the fixed-prime local
permutation barrier.  It proves the Chebyshev square identity and derivative
identity at an arbitrary field point, and then shows that a preimage of `5`
is non-endpoint and a simple root in every characteristic not dividing `24`
or the index.

Dickson's permutation theorem and Hensel's lemma remain external accepted
theorems.  They are not introduced as Lean axioms: the relevant permutation
and lifting statements occur only as explicit hypotheses or in the companion
trust ledger.
-/

namespace IUTThreeClosures

open Polynomial

namespace PellChebyshevLocalSimpleRoot

variable (K : Type*) [Field K]

/-- The first-kind Chebyshev value over an arbitrary field. -/
noncomputable def tValue (n : ℕ) (x : K) : K :=
  (Polynomial.Chebyshev.T K (n : ℤ)).eval x

/-- The second-kind factor occurring in the derivative of `T_n`.  At
`n = 0` this is `U_{-1}=0`, as required by the uniform identity. -/
noncomputable def uPreviousValue (n : ℕ) (x : K) : K :=
  (Polynomial.Chebyshev.U K ((n : ℤ) - 1)).eval x

/-- The polynomial whose root is selected by the Dickson permutation
argument. -/
noncomputable def targetFivePolynomial (n : ℕ) : K[X] :=
  Polynomial.Chebyshev.T K (n : ℤ) - C 5

@[simp]
theorem eval_targetFivePolynomial (n : ℕ) (x : K) :
    (targetFivePolynomial K n).eval x = tValue K n x - 5 := by
  simp [targetFivePolynomial, tValue]

/-- The classical identity
`T_n(x)^2 - 1 = (x^2 - 1) U_{n-1}(x)^2`, proved in the kernel from the
Mathlib Chebyshev recurrences. -/
theorem t_sq_sub_one (n : ℕ) (x : K) :
    tValue K n x ^ 2 - 1 =
      (x ^ 2 - 1) * uPreviousValue K n x ^ 2 := by
  induction n with
  | zero =>
      simp [tValue, uPreviousValue]
  | succ n ih =>
      have htPoly :
          Polynomial.Chebyshev.T K ((n + 1 : ℕ) : ℤ) =
            X * Polynomial.Chebyshev.T K (n : ℤ) -
              (1 - X ^ 2) * Polynomial.Chebyshev.U K ((n : ℤ) - 1) := by
        have hi1 : (n : ℤ) - 1 + 2 = ((n + 1 : ℕ) : ℤ) := by omega
        have hi2 : (n : ℤ) - 1 + 1 = (n : ℤ) := by omega
        simpa only [hi1, hi2] using
          (Polynomial.Chebyshev.T_eq_X_mul_T_sub_pol_U
            K ((n : ℤ) - 1))
      have huPoly :
          Polynomial.Chebyshev.U K (n : ℤ) =
            X * Polynomial.Chebyshev.U K ((n : ℤ) - 1) +
              Polynomial.Chebyshev.T K (n : ℤ) := by
        have hi : (n : ℤ) - 1 + 1 = (n : ℤ) := by omega
        simpa only [hi] using
          (Polynomial.Chebyshev.U_eq_X_mul_U_add_T
            K ((n : ℤ) - 1))
      have ht := congrArg (fun f : K[X] => f.eval x) htPoly
      have hu := congrArg (fun f : K[X] => f.eval x) huPoly
      have ht' :
          tValue K (n + 1) x =
            x * tValue K n x -
              (1 - x ^ 2) * uPreviousValue K n x := by
        simpa [tValue, uPreviousValue] using ht
      have hu' :
          uPreviousValue K (n + 1) x =
            x * uPreviousValue K n x + tValue K n x := by
        simpa [tValue, uPreviousValue] using hu
      change
        tValue K (n + 1) x ^ 2 - 1 =
          (x ^ 2 - 1) * uPreviousValue K (n + 1) x ^ 2
      change
        tValue K n x ^ 2 - 1 =
          (x ^ 2 - 1) * uPreviousValue K n x ^ 2 at ih
      rw [ht', hu']
      calc
        (x * tValue K n x - (1 - x ^ 2) * uPreviousValue K n x) ^ 2 - 1 =
            (x ^ 2 - 1) *
                (x * uPreviousValue K n x + tValue K n x) ^ 2 +
              (tValue K n x ^ 2 - 1 -
                (x ^ 2 - 1) * uPreviousValue K n x ^ 2) := by ring
        _ = (x ^ 2 - 1) *
              (x * uPreviousValue K n x + tValue K n x) ^ 2 := by
                rw [ih]
                ring

/-- Evaluation of the formal derivative of `T_n`. -/
theorem derivative_t_eval (n : ℕ) (x : K) :
    (derivative (Polynomial.Chebyshev.T K (n : ℤ))).eval x =
      (n : K) * uPreviousValue K n x := by
  rw [Polynomial.Chebyshev.T_derivative_eq_U]
  simp [uPreviousValue]

/-- Subtracting the constant target does not change the derivative. -/
theorem derivative_targetFive_eval (n : ℕ) (x : K) :
    (derivative (targetFivePolynomial K n)).eval x =
      (n : K) * uPreviousValue K n x := by
  rw [targetFivePolynomial, derivative_sub, derivative_C, sub_zero]
  exact derivative_t_eval K n x

/-- The selected value `T_n(x)=5` is exactly the affine curve point with
ordinate `5`. -/
theorem targetFive_curveEquation
    (n : ℕ) (x : K)
    (hfive : tValue K n x = 5) :
    (5 : K) ^ 2 = 4 * tValue K n x + 5 := by
  rw [hfive]
  ring

/-- A target-five preimage is neither endpoint and its `U` factor is
nonzero.  The sole characteristic exclusion needed for this implication is
`24 != 0`. -/
theorem targetFive_nondegenerate
    (n : ℕ) (x : K)
    (h24 : (24 : K) ≠ 0)
    (hfive : tValue K n x = 5) :
    x ≠ 1 ∧ x ≠ -1 ∧ uPreviousValue K n x ≠ 0 := by
  have hid := t_sq_sub_one K n x
  rw [hfive] at hid
  norm_num at hid
  have hproduct : (x ^ 2 - 1) * uPreviousValue K n x ^ 2 = 24 :=
    hid.symm
  have hleft : x ^ 2 - 1 ≠ 0 := by
    intro hzero
    rw [hzero, zero_mul] at hproduct
    exact h24 hproduct.symm
  have hu : uPreviousValue K n x ≠ 0 := by
    intro hzero
    rw [hzero, zero_pow (by norm_num), mul_zero] at hproduct
    exact h24 hproduct.symm
  refine ⟨?_, ?_, hu⟩
  · intro hx
    apply hleft
    rw [hx]
    ring
  · intro hx
    apply hleft
    rw [hx]
    ring

/-- A target-five preimage is a simple root whenever the index is nonzero in
the residue field.  This is exactly the finite algebraic input to Hensel's
lemma. -/
theorem targetFive_derivative_isUnit
    (n : ℕ) (x : K)
    (h24 : (24 : K) ≠ 0)
    (hn : (n : K) ≠ 0)
    (hfive : tValue K n x = 5) :
    IsUnit ((derivative (targetFivePolynomial K n)).eval x) := by
  rw [derivative_targetFive_eval]
  exact (isUnit_iff_ne_zero.mpr
    (mul_ne_zero hn (targetFive_nondegenerate K n x h24 hfive).2.2))

/-- A bijective Chebyshev map has a unique target-five preimage.  Dickson's
theorem supplies the bijectivity hypothesis in the finite-field application;
it is deliberately not hidden here. -/
theorem existsUnique_targetFive_of_bijective
    (n : ℕ)
    (hperm : Function.Bijective (tValue K n)) :
    ∃! x : K, tValue K n x = 5 := by
  obtain ⟨x, hx⟩ := hperm.2 5
  refine ⟨x, hx, ?_⟩
  intro y hy
  exact hperm.1 (hy.trans hx.symm)

/-- If `T_n` is bijective and `4` is nonzero, every ordinate has a unique
abscissa on `y^2 = 4*T_n(x)+5`.  Over a finite field this is the exact
point-count mechanism behind the failure of quadratic-character covers. -/
theorem existsUnique_curveAbscissa_of_bijective
    (n : ℕ)
    (hfour : (4 : K) ≠ 0)
    (hperm : Function.Bijective (tValue K n))
    (y : K) :
    ∃! x : K, y ^ 2 = 4 * tValue K n x + 5 := by
  obtain ⟨x, hx⟩ := hperm.2 ((y ^ 2 - 5) / 4)
  refine ⟨x, ?_, ?_⟩
  · change y ^ 2 = 4 * tValue K n x + 5
    rw [hx]
    field_simp [hfour]
    ring
  · intro z hz
    apply hperm.1
    apply (mul_left_cancel₀ hfour)
    have hxcurve : y ^ 2 = 4 * tValue K n x + 5 := by
      rw [hx]
      field_simp [hfour]
      ring
    linear_combination hxcurve - hz

/-- The numerical characteristic hypotheses used in the fixed-prime
application imply all finite algebraic nondegeneracy conclusions. -/
theorem zmod_targetFive_simple
    {q p : ℕ} [Fact q.Prime]
    (hq : 5 ≤ q)
    (hp : p.Prime)
    (hpq : q + 1 < p)
    (x : ZMod q)
    (hfive : tValue (ZMod q) p x = 5) :
    x ≠ 1 ∧ x ≠ -1 ∧
      IsUnit ((derivative (targetFivePolynomial (ZMod q) p)).eval x) := by
  have hqPrime : q.Prime := Fact.out
  have hqNotDvd24 : ¬q ∣ 24 := by
    intro hdvd
    have hqle : q ≤ 24 := Nat.le_of_dvd (by norm_num) hdvd
    interval_cases q <;> norm_num at hqPrime <;> norm_num at hdvd
  have h24 : (24 : ZMod q) ≠ 0 :=
    (ZMod.natCast_eq_zero_iff 24 q).not.mpr hqNotDvd24
  have hqNotDvdP : ¬q ∣ p := by
    intro hdvd
    rcases (Nat.dvd_prime hp).mp hdvd with hqOne | hqp
    · exact hqPrime.ne_one hqOne
    · omega
  have hpNe : (p : ZMod q) ≠ 0 :=
    (ZMod.natCast_eq_zero_iff p q).not.mpr hqNotDvdP
  have hnondeg := targetFive_nondegenerate (ZMod q) p x h24 hfive
  exact ⟨hnondeg.1, hnondeg.2.1,
    targetFive_derivative_isUnit (ZMod q) p x h24 hpNe hfive⟩

/-- Under the explicit finite-field permutation interface, the target `5`
has a unique non-endpoint preimage and that preimage is simple. -/
theorem zmod_existsUnique_targetFive_simple_of_bijective
    {q p : ℕ} [Fact q.Prime]
    (hq : 5 ≤ q)
    (hp : p.Prime)
    (hpq : q + 1 < p)
    (hperm : Function.Bijective (tValue (ZMod q) p)) :
    ∃! x : ZMod q,
      tValue (ZMod q) p x = 5 ∧
        x ≠ 1 ∧ x ≠ -1 ∧
          IsUnit ((derivative
            (targetFivePolynomial (ZMod q) p)).eval x) := by
  obtain ⟨x, hx, hxu⟩ :=
    existsUnique_targetFive_of_bijective (ZMod q) p hperm
  have hs := zmod_targetFive_simple hq hp hpq x hx
  refine ⟨x, ⟨hx, hs⟩, ?_⟩
  intro y hy
  exact hxu y hy.1

/-- Pairwise scalar CRT.  Iteration gives the finite-set CRT used in the
local-barrier ledger. -/
theorem crt_pair
    {m n : ℕ} (hcop : m.Coprime n) (a : ZMod m) (b : ZMod n) :
    ∃ x : ZMod (m * n), ZMod.chineseRemainder hcop x = (a, b) := by
  exact ⟨(ZMod.chineseRemainder hcop).symm (a, b), by simp⟩

end PellChebyshevLocalSimpleRoot

#print axioms PellChebyshevLocalSimpleRoot.t_sq_sub_one
#print axioms PellChebyshevLocalSimpleRoot.derivative_t_eval
#print axioms PellChebyshevLocalSimpleRoot.derivative_targetFive_eval
#print axioms PellChebyshevLocalSimpleRoot.targetFive_curveEquation
#print axioms PellChebyshevLocalSimpleRoot.targetFive_nondegenerate
#print axioms PellChebyshevLocalSimpleRoot.targetFive_derivative_isUnit
#print axioms PellChebyshevLocalSimpleRoot.existsUnique_targetFive_of_bijective
#print axioms
  PellChebyshevLocalSimpleRoot.existsUnique_curveAbscissa_of_bijective
#print axioms PellChebyshevLocalSimpleRoot.zmod_targetFive_simple
#print axioms
  PellChebyshevLocalSimpleRoot.zmod_existsUnique_targetFive_simple_of_bijective
#print axioms PellChebyshevLocalSimpleRoot.crt_pair

end IUTThreeClosures
