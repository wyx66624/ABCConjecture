import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Fintype.Prod
import Mathlib.Tactic

/-! Exact homogeneous identities, finite square-fibre counts and trace obstructions
for QS. The quadratic pair model has its displayed multiplication. Good reduction,
the Frobenius trace formula, Jacobian simplicity, torsion and ranks are ordinary
mathematical inputs outside this formal module. -/
set_option autoImplicit false
set_option maxRecDepth 100000
set_option maxHeartbeats 8000000
namespace ABCQuotientCurveArithmetic20260907

def cubicHom (t x z : ℤ) : ℤ :=
  x ^ 3 + 3 * t * x ^ 2 * z + (3 * t - 3) * x * z ^ 2 - z ^ 3

def mobius (v : ℤ × ℤ) : ℤ × ℤ := (-v.2, v.1 + v.2)

theorem actual_cubic_symmetry (t x z : ℤ) :
    cubicHom t (-z) (x + z) = -cubicHom t x z := by
  unfold cubicHom
  ring

theorem actual_mobius_cube (v : ℤ × ℤ) :
    mobius (mobius (mobius v)) = (-v.1, -v.2) := by
  ext <;> simp [mobius]

theorem actual_cubic_difference (t u x z : ℤ) :
    cubicHom t x z - cubicHom u x z = 3 * (t - u) * x * z * (x + z) := by
  unfold cubicHom
  ring

abbrev QElem (p : ℕ) := ZMod p × ZMod p

def qadd {p : ℕ} (x y : QElem p) : QElem p := (x.1 + y.1, x.2 + y.2)
def qmul {p : ℕ} (d : ZMod p) (x y : QElem p) : QElem p :=
  (x.1 * y.1 + d * x.2 * y.2, x.1 * y.2 + x.2 * y.1)
def qscale {p : ℕ} (a : ZMod p) (x : QElem p) : QElem p := (a * x.1, a * x.2)
def qcubic {p : ℕ} (d t : ZMod p) (x : QElem p) : QElem p :=
  qadd (qadd (qmul d (qmul d x x) x) (qscale (3 * t) (qmul d x x)))
    (qadd (qscale (3 * t - 3) x) (-1, 0))
def cubic {p : ℕ} (t x : ZMod p) : ZMod p :=
  x ^ 3 + 3 * t * x ^ 2 + (3 * t - 3) * x - 1

def baseAffineCount (p : ℕ) [NeZero p] (t u : ZMod p) : ℕ :=
  ((Finset.univ : Finset (ZMod p × ZMod p)).filter
    (fun xy ↦ xy.2 ^ 2 = cubic t xy.1 * cubic u xy.1)).card

def quadraticAffineCount (p : ℕ) [NeZero p] (d t u : ZMod p) : ℕ :=
  ((Finset.univ : Finset (QElem p × QElem p)).filter
    (fun xy ↦ qmul d xy.2 xy.2 = qmul d (qcubic d t xy.1) (qcubic d u xy.1))).card

theorem h2_five_base : baseAffineCount 5 1 4 + 2 = 6 := by decide
theorem h3_five_base : baseAffineCount 5 0 4 + 2 = 6 := by decide
theorem h2_five_quadratic : quadraticAffineCount 5 2 1 4 + 2 = 36 := by decide
theorem h3_five_quadratic : quadraticAffineCount 5 2 0 4 + 2 = 12 := by decide
theorem h2_seven_base : baseAffineCount 7 1 4 + 2 = 11 := by decide
theorem h3_seven_base : baseAffineCount 7 0 4 + 2 = 11 := by decide
theorem h2_seven_quadratic : quadraticAffineCount 7 3 1 4 + 2 = 61 := by decide
theorem h3_seven_quadratic : quadraticAffineCount 7 3 0 4 + 2 = 61 := by decide

theorem five_not_integer_square (a : ℤ) : a ^ 2 ≠ 5 := by
  intro h
  have ha : -3 < a ∧ a < 3 := by
    constructor <;> nlinarith [sq_nonneg (a - 3), sq_nonneg (a + 3)]
  obtain ⟨hal, hau⟩ := ha
  interval_cases a <;> norm_num at h

theorem seventeen_not_integer_square (a : ℤ) : a ^ 2 ≠ 17 := by
  intro h
  have ha : -5 < a ∧ a < 5 := by
    constructor <;> nlinarith [sq_nonneg (a - 5), sq_nonneg (a + 5)]
  obtain ⟨hal, hau⟩ := ha
  interval_cases a <;> norm_num at h

theorem h2_trace_factor_obstruction (a b : ℤ) (h1 : a + b = 0)
    (h2 : a * b + 10 = 5) : False := by
  apply five_not_integer_square a
  have hb : b = -a := by omega
  rw [hb] at h2
  nlinarith

theorem h3_trace_factor_obstruction (a b : ℤ) (h1 : a + b = 0)
    (h2 : a * b + 10 = -7) : False := by
  apply seventeen_not_integer_square a
  have hb : b = -a := by omega
  rw [hb] at h2
  nlinarith

theorem actual_frobenius_arithmetic :
    (5 + 1 - 6 : ℤ) = 0 ∧ (25 + 1 - 36 : ℤ) = -10 ∧
    (25 + 1 - 12 : ℤ) = 14 ∧ (7 + 1 - 11 : ℤ) = -3 ∧
    (49 + 1 - 61 : ℤ) = -11 ∧
    (0 ^ 2 - (-10) : ℤ) = 2 * 5 ∧ (0 ^ 2 - 14 : ℤ) = 2 * (-7) ∧
    ((-3) ^ 2 - (-11) : ℤ) = 2 * 10 ∧
    (1 + 5 + 25 : ℤ) = 31 ∧ (1 - 7 + 25 : ℤ) = 19 ∧
    (1 + 3 + 10 + 21 + 49 : ℤ) = 84 := by norm_num

theorem actual_torsion_divisor_obstructions :
    Nat.Coprime 31 84 ∧ Nat.Coprime 19 84 ∧ ¬ 5 ∣ 84 ∧ ¬ 7 ∣ 31 ∧ ¬ 7 ∣ 19 := by
  decide

#print axioms actual_cubic_symmetry
#print axioms actual_mobius_cube
#print axioms actual_cubic_difference
#print axioms h2_five_base
#print axioms h3_five_base
#print axioms h2_five_quadratic
#print axioms h3_five_quadratic
#print axioms h2_seven_base
#print axioms h3_seven_base
#print axioms h2_seven_quadratic
#print axioms h3_seven_quadratic
#print axioms five_not_integer_square
#print axioms seventeen_not_integer_square
#print axioms h2_trace_factor_obstruction
#print axioms h3_trace_factor_obstruction
#print axioms actual_frobenius_arithmetic
#print axioms actual_torsion_divisor_obstructions
end ABCQuotientCurveArithmetic20260907
