import IUTThreeClosures.FreyPellRadicalRecurrenceBarrier
import Mathlib.RingTheory.Polynomial.Chebyshev

/-!
# Scalar kernel for the Pell squarefree-part fundamental-unit audit

For the Pell companion `c = s^2 - 2`, write `c = A*y^2`.  The paper
companion uses the theorem of Bennett--Walsh on

`9*r^4 - A*(y*s)^2 = 1`

to identify the displayed norm-one unit with the fundamental Pell solution.
This file proves only the elementary algebraic identities and the Chebyshev
modulo-three observation used in that argument.  It does not formalize the
Bennett--Walsh theorem, quadratic reciprocity, genus theory, the analytic
class-number formula, a radical estimate, or the abc conjecture.
-/

namespace IUTThreeClosures

/-- The three consecutive values attached to a Pell solution. -/
theorem pellSquarefree_threeConsecutive
    (r s c : ℤ) (hPell : s ^ 2 - 3 * r ^ 2 = 1)
    (hc : c = s ^ 2 - 2) :
    c + 1 = 3 * r ^ 2 ∧ c + 2 = s ^ 2 := by
  constructor <;> nlinarith

/-- If `c = A*y^2` and `c + 2 = s^2`, then the middle neighboring value
is a norm-one Pell coordinate:

`(c+1)^2 - A*(y*s)^2 = 1`.
-/
theorem pellSquarefree_normOneIdentity
    (A y s c : ℤ) (hc : c = A * y ^ 2) (hs : c + 2 = s ^ 2) :
    (c + 1) ^ 2 - A * (y * s) ^ 2 = 1 := by
  calc
    (c + 1) ^ 2 - A * (y * s) ^ 2
        = (c + 1) ^ 2 - c * s ^ 2 := by rw [hc]; ring
    _ = (c + 1) ^ 2 - c * (c + 2) := by rw [← hs]
    _ = 1 := by ring

/-- Combining the Pell equation with the squarefree-part decomposition gives
the quartic equation to which Bennett--Walsh applies. -/
theorem pellSquarefree_bennettWalshEquation
    (A y r s c : ℤ) (hPell : s ^ 2 - 3 * r ^ 2 = 1)
    (hc : c = s ^ 2 - 2) (hA : c = A * y ^ 2) :
    9 * r ^ 4 - A * (y * s) ^ 2 = 1 := by
  have hthree := (pellSquarefree_threeConsecutive r s c hPell hc).1
  have hnorm := pellSquarefree_normOneIdentity A y s c hA
    (pellSquarefree_threeConsecutive r s c hPell hc).2
  calc
    9 * r ^ 4 - A * (y * s) ^ 2
        = (c + 1) ^ 2 - A * (y * s) ^ 2 := by rw [hthree]; ring
    _ = 1 := hnorm

/-- In the actual integral orbit, the auxiliary norm-one identity specializes
without any additional Pell hypothesis. -/
theorem pellRadicalC_squarefree_normOne
    (n : ℕ) (A y : ℤ) (hA : pellRadicalC n = A * y ^ 2) :
    (pellRadicalC n + 1) ^ 2 -
        A * (y * pellDoubleS n) ^ 2 = 1 := by
  apply pellSquarefree_normOneIdentity A y (pellDoubleS n) (pellRadicalC n) hA
  simp only [pellRadicalC]
  ring

/-- The corresponding quartic equation in the actual Pell orbit. -/
theorem pellRadicalC_bennettWalshEquation
    (n : ℕ) (A y : ℤ) (hA : pellRadicalC n = A * y ^ 2) :
    9 * pellDoubleR n ^ 4 -
        A * (y * pellDoubleS n) ^ 2 = 1 := by
  have hthree : pellRadicalC n + 1 = 3 * pellDoubleR n ^ 2 := by
    rw [pellRadicalC_eq_three_r_sq_sub_one]
    ring
  have hnorm := pellRadicalC_squarefree_normOne n A y hA
  calc
    9 * pellDoubleR n ^ 4 - A * (y * pellDoubleS n) ^ 2
        = (pellRadicalC n + 1) ^ 2 -
            A * (y * pellDoubleS n) ^ 2 := by rw [hthree]; ring
    _ = 1 := hnorm

/-- Over `ZMod 3`, a Chebyshev first-coordinate can vanish only when its
base first-coordinate already vanishes.  This is the elementary observation
which turns the Bennett--Walsh divisibility index `alpha(3)` into `1`. -/
theorem pellSquarefree_chebyshev_zero_mod_three_forces_base
    (t : ZMod 3) (k : ℤ)
    (hk : (Polynomial.Chebyshev.T (ZMod 3) k).eval t = 0) :
    t = 0 := by
  have hcases : ∀ x : ZMod 3, x = 0 ∨ x = 1 ∨ x = -1 := by decide
  rcases hcases t with rfl | rfl | rfl
  · rfl
  · rw [Polynomial.Chebyshev.T_eval_one] at hk
    norm_num at hk
  · rw [Polynomial.Chebyshev.T_eval_neg_one] at hk
    have hne : (k.negOnePow : ZMod 3) ≠ 0 := by
      rw [Int.coe_negOnePow]
      exact pow_ne_zero _ (by norm_num)
    exact (hne hk).elim

/-- Abstract injectivity ledger: uniqueness of the positive quartic solution
at a fixed squarefree parameter, together with injectivity of the Pell
coordinate `r`, makes the parameter map injective.  The companion note obtains
the uniqueness premise from Bennett--Walsh. -/
theorem pellSquarefree_parameter_injective
    {Index Param R Y : Type*}
    (parameter : Index → Param) (r : Index → R) (_y : Index → Y)
    (hr : Function.Injective r)
    (hunique : ∀ i j, parameter i = parameter j → r i = r j) :
    Function.Injective parameter := by
  intro i j hij
  exact hr (hunique i j hij)

end IUTThreeClosures
