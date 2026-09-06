import EisensteinDescent

/-!
Author: ChatGPT. September 6, 2026.
Scope: actual integer-pair power and boundary recurrences, all-index boundary
factorization, integral conductor-accounting identities, and numerical
wild-discriminant coefficients. General number-field classification and the
height-discriminant inequality are NOT assumed or proved in this module.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCExactFermat20260906
open ABCEisenstein20260905

def powPair (w : Pair) : Nat → Pair
  | 0 => (1,0)
  | n+1 => mul w (powPair w n)

def cubicTrace (w : Pair) : Int :=
  (w.1-w.2)*(2*w.1+w.2)*(w.1+2*w.2)

def seq (s q : Int) : Nat → Int
  | 0 => 0
  | 1 => 1
  | n+2 => s*seq s q (n+1)-q*seq s q n

theorem power_one (w : Pair) : powPair w 1 = w := by
  exact mul_one w

theorem power_norm (w : Pair) (n : Nat) :
    norm (powPair w n) = (norm w)^n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    change norm (mul w (powPair w n)) = (norm w)^(n+1)
    rw [norm_mul, ih, Int.pow_succ]
    exact Int.mul_comm _ _

theorem power_add (w : Pair) (m n : Nat) :
    mul (powPair w m) (powPair w n) = powPair w (m+n) := by
  induction m with
  | zero => simpa [powPair, mul_comm] using mul_one (powPair w n)
  | succ m ih =>
    rw [Nat.succ_add]
    change mul (mul w (powPair w m)) (powPair w n) =
      mul w (powPair w (m+n))
    rw [mul_assoc, ih]

theorem cubic_trace_coordinates (w : Pair) :
    cubicTrace w = 2*(powPair w 3).1+(powPair w 3).2 := by
  dsimp [cubicTrace,powPair,mul]
  grind

theorem frey_identity (w : Pair) :
    cubicTrace w ^ 2 + 27 * boundary w ^ 2 = 4 * norm w ^ 3 := by
  dsimp [cubicTrace,boundary,norm]
  grind

theorem doubling_boundary (w : Pair) :
    boundary (mul w w) = boundary w * cubicTrace w := by
  dsimp [boundary,mul,cubicTrace]
  grind

theorem boundary_step (w v : Pair) :
    boundary (mul w (mul w v)) =
      cubicTrace w * boundary (mul w v) - norm w ^ 3 * boundary v := by
  dsimp [boundary,mul,cubicTrace,norm]
  grind

theorem power_boundary_recurrence (w : Pair) (n : Nat) :
    boundary (powPair w (n+2)) =
      cubicTrace w * boundary (powPair w (n+1)) -
      norm w ^ 3 * boundary (powPair w n) := by
  exact boundary_step w (powPair w n)

theorem power_boundary_pair (w : Pair) (n : Nat) :
    boundary (powPair w n) = boundary w * seq (cubicTrace w) (norm w ^ 3) n ∧
    boundary (powPair w (n+1)) =
      boundary w * seq (cubicTrace w) (norm w ^ 3) (n+1) := by
  induction n with
  | zero =>
    constructor
    · rfl
    · rw [power_one]
      simp [seq]
  | succ n ih =>
    constructor
    · exact ih.2
    · rw [power_boundary_recurrence, ih.1, ih.2]
      simp only [seq]
      grind

theorem power_boundary_factorization (w : Pair) (n : Nat) :
    boundary (powPair w n) =
      boundary w * seq (cubicTrace w) (norm w ^ 3) n :=
  (power_boundary_pair w n).1

theorem boundary_divides_power (w : Pair) (n : Nat) :
    boundary w ∣ boundary (powPair w n) := by
  rw [power_boundary_factorization]
  exact ⟨seq (cubicTrace w) (norm w ^ 3) n, rfl⟩

theorem doubling_power_boundary (w : Pair) (n : Nat) :
    boundary (powPair w (n+n)) =
      boundary (powPair w n) * cubicTrace (powPair w n) := by
  rw [←power_add]
  exact doubling_boundary (powPair w n)

theorem unit_line_tower (p : Int) :
    ((p-1)*p + (p-2)) - p*(p-2) = 2*(p-1) := by grind

theorem valuation_line_tower (p : Int) :
    ((p-1)*(2*p-1)+(p-2))-p*(p-2) = (p-1)*(p+1) := by grind

theorem mixed_character_sum (p : Int) :
    (p-1)*2 + p*(p-1)*(p+1) = (p-1)*(p*p+p+2) := by grind

theorem affine_degree_accounting (u p t : Int) :
    u + t*(p-1)*u = u*(1+t*(p-1)) := by grind

theorem mixed_point_wild_exponent (p : Int) :
    (p-2)*(p+1)+(p*p+p+2) = 2*p*p := by grind

theorem ramified_frey_normalization (s u n : Int)
    (h : (18*s)^2+27*(2*u)^2=4*(3*n)^3) :
    3*s^2+u^2=n^3 := by grind

-- The following coefficients are exact finite integer arithmetic. They do not
-- by themselves identify a number field or its discriminant.
theorem coefficient_table_three :
    9*2=18 ∧ 18*2+1=37 ∧
    3*1=3 ∧ 2*3+1=7 ∧ 2*5+1=11 ∧
    2*16+1=33 ∧ 2*10+1=21 ∧ 2*4+1=9 := by decide

theorem coefficient_table_five :
    4*5+3=23 ∧ 4*9+3=39 ∧ 4*3+3=15 := by decide

#print axioms power_one
#print axioms power_norm
#print axioms power_add
#print axioms cubic_trace_coordinates
#print axioms frey_identity
#print axioms doubling_boundary
#print axioms boundary_step
#print axioms power_boundary_recurrence
#print axioms power_boundary_pair
#print axioms power_boundary_factorization
#print axioms boundary_divides_power
#print axioms doubling_power_boundary
#print axioms unit_line_tower
#print axioms valuation_line_tower
#print axioms mixed_character_sum
#print axioms affine_degree_accounting
#print axioms mixed_point_wild_exponent
#print axioms ramified_frey_normalization
#print axioms coefficient_table_three
#print axioms coefficient_table_five
end ABCExactFermat20260906
