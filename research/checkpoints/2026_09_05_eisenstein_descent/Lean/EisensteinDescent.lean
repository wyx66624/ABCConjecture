import Std

/-!
Author: ChatGPT. September 5, 2026.
Scoped, standalone algebraic and recurrence certificates for Eisenstein descent.
The paper proves the general Euclidean coverage and boundary gcd theorem.
Those two theorems and the standard ABC conjecture are NOT asserted here.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCEisenstein20260905

abbrev Pair := Int × Int

def mul (z w : Pair) : Pair :=
  (z.1*w.1-z.2*w.2, z.1*w.2+z.2*w.1+z.2*w.2)
def norm (z : Pair) : Int := z.1*z.1+z.1*z.2+z.2*z.2
def boundary (z : Pair) : Int := z.1*z.2*(z.1+z.2)
def conjugate (z : Pair) : Pair := (z.1+z.2,-z.2)
def rotate (z : Pair) : Pair := (-z.2,z.1+z.2)
def step (z : Pair) : Pair := (2*z.1-z.2,z.1+3*z.2)
def orbit : Nat → Pair
  | 0 => (1,0)
  | n+1 => step (orbit n)
def lucas : Nat → Int
  | 0 => 0
  | 1 => 1
  | n+2 => 20*lucas (n+1)-343*lucas n

theorem mul_comm (z w : Pair) : mul z w = mul w z := by
  apply Prod.ext <;> dsimp [mul] <;> grind

theorem mul_assoc (z w t : Pair) : mul (mul z w) t = mul z (mul w t) := by
  apply Prod.ext <;> dsimp [mul] <;> grind

theorem mul_one (z : Pair) : mul z (1,0) = z := by
  apply Prod.ext <;> simp [mul]

theorem norm_mul (z w : Pair) : norm (mul z w) = norm z * norm w := by
  dsimp [norm,mul]
  grind

theorem conjugate_product (z : Pair) : mul z (conjugate z) = (norm z,0) := by
  apply Prod.ext <;> dsimp [mul,conjugate,norm] <;> grind

theorem rotate_boundary (z : Pair) : boundary (rotate z) = -boundary z := by
  dsimp [boundary,rotate]
  grind

theorem rotate_norm (z : Pair) : norm (rotate z) = norm z := by
  dsimp [norm,rotate]
  grind

theorem norm_height_identity (x y : Int) :
    4*norm (x,y)-3*(x+y)^2=(x-y)^2 := by
  dsimp [norm]
  grind

theorem inverse_numerators (u v x y : Int) :
    (u+v)*(u*x-v*y)+v*(v*x+(u+v)*y)=norm (u,v)*x ∧
    -v*(u*x-v*y)+u*(v*x+(u+v)*y)=norm (u,v)*y := by
  dsimp [norm]
  constructor <;> grind

-- Actual polynomial remainders used by the ordinary boundary gcd proof.
theorem boundary_remainder_x (u v x y : Int) :
    x ∣ boundary (mul (u,v) (x,y)) + boundary (u,v)*y^3 := by
  refine ⟨u^3*y^2-3*u*v^2*y^2-v^3*y^2+
    x^2*(u^2*v+u*v^2)+x*(u^3*y+3*u^2*v*y-v^3*y), ?_⟩
  dsimp [boundary,mul]
  grind

theorem boundary_remainder_y (u v x y : Int) :
    y ∣ boundary (mul (u,v) (x,y)) - boundary (u,v)*x^3 := by
  refine ⟨u^3*x^2+3*u^2*v*x^2-v^3*x^2+
    y^2*(-u^2*v-u*v^2)+y*(u^3*x-3*u*v^2*x-v^3*x), ?_⟩
  dsimp [boundary,mul]
  grind

theorem boundary_remainder_sum (u v x y : Int) :
    x+y ∣ boundary (mul (u,v) (x,y)) - boundary (u,v)*y^3 := by
  refine ⟨-2*u^2*v*y^2-2*u*v^2*y^2+
    x^2*(u^2*v+u*v^2)+x*(u^3*y+2*u^2*v*y-u*v^2*y-v^3*y), ?_⟩
  dsimp [boundary,mul]
  grind

theorem step_is_mul (z : Pair) : step z = mul (2,1) z := by
  apply Prod.ext <;> dsimp [step,mul] <;> grind

theorem step_norm (z : Pair) : norm (step z)=7*norm z := by
  rw [step_is_mul,norm_mul]
  rfl

theorem orbit_norm (n : Nat) : norm (orbit n)=(7:Int)^n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    change norm (step (orbit n))=(7:Int)^(n+1)
    rw [step_norm,ih,Int.pow_succ]
    exact Int.mul_comm _ _

theorem orbit_add (m n : Nat) : mul (orbit m) (orbit n)=orbit (m+n) := by
  induction n with
  | zero => simpa [orbit] using mul_one (orbit m)
  | succ n ih =>
    change mul (orbit m) (step (orbit n))=step (orbit (m+n))
    rw [step_is_mul,step_is_mul,←mul_assoc,mul_comm (orbit m) (2,1),mul_assoc,ih]

theorem orbit_six : orbit 6=(-323,360) := by decide

theorem orbit_six_shift (n : Nat) :
    orbit (n+6)=(-323*(orbit n).1-360*(orbit n).2,
      360*(orbit n).1+37*(orbit n).2) := by
  rw [←orbit_add,orbit_six]
  apply Prod.ext <;> dsimp [mul] <;> grind

theorem orbit_mod_four (n : Nat) :
    (orbit (6*n+1)).1 % 4=2 ∧ (orbit (6*n+1)).2 % 4=1 := by
  induction n with
  | zero => decide
  | succ n ih =>
    have he : 6*(n+1)+1=(6*n+1)+6 := by omega
    rw [he,orbit_six_shift]
    dsimp
    omega

theorem orbit_mod_seven (n : Nat) :
    ((orbit (n+1)).1-2*(orbit (n+1)).2)%7=0 ∧
    (orbit (n+1)).2%7≠0 := by
  induction n with
  | zero => decide
  | succ n ih =>
    change ((step (orbit (n+1))).1-2*(step (orbit (n+1))).2)%7=0 ∧
      (step (orbit (n+1))).2%7≠0
    dsimp [step]
    omega

theorem cubic_coordinate (z : Pair) :
    (mul (mul z z) z).2=3*boundary z := by
  dsimp [mul,boundary]
  grind

theorem boundary_step_recurrence (z : Pair) :
    boundary (step (step z))=20*boundary (step z)-343*boundary z := by
  dsimp [boundary,step]
  grind

theorem orbit_boundary_recurrence (n : Nat) :
    boundary (orbit (n+2))=20*boundary (orbit (n+1))-343*boundary (orbit n) :=
  boundary_step_recurrence (orbit n)

theorem orbit_boundary_lucas (n : Nat) : boundary (orbit n)=6*lucas n := by
  have h : ∀ k, boundary (orbit k)=6*lucas k ∧
      boundary (orbit (k+1))=6*lucas (k+1) := by
    intro k
    induction k with
    | zero => decide
    | succ k ih =>
      constructor
      · exact ih.2
      · rw [orbit_boundary_recurrence,ih.1,ih.2]
        change 20*(6*lucas (k+1))-343*(6*lucas k)=
          6*(20*lucas (k+1)-343*lucas k)
        grind
  exact (h n).1

theorem cubic_difference (x y : Int) : x^3-y^3=(x-y)*norm (x,y) := by
  dsimp [norm]
  grind

theorem orbit_cubic_difference (n : Nat) :
    (orbit n).1^3-(orbit n).2^3=
      ((orbit n).1-(orbit n).2)*(7:Int)^n := by
  rw [cubic_difference,orbit_norm]

theorem exact_small_orbits : orbit 5=(-87,149) ∧ orbit 6=(-323,360) := by decide

theorem boundary_factor_certificates :
    (803706:Nat)=2*3*29*31*149 ∧
    (4302360:Nat)=2^3*3^2*5*17*19*37 ∧
    (358530:Nat)=2*3*5*17*19*37 ∧
    Nat.gcd 803706 4302360=6 ∧
    (803706:Nat)>358530 := by decide

-- The no-loss counterexample after clearing the exponent denominator.
-- The factors below are the separately certified heights and radicals.
theorem defect_ratio_increases (m : Nat) :
    149^m * 358530^(m+1) < 360^m * 803706^(m+1) := by
  have h1 : 149^m ≤ 360^m := Nat.pow_le_pow_left (by decide) m
  have h2 : 358530^(m+1) < 803706^(m+1) := by
    exact Nat.pow_lt_pow_left (by decide) (by omega)
  have hpos : 0 < 149^m := Nat.pow_pos (by decide)
  exact Nat.lt_of_lt_of_le
    (Nat.mul_lt_mul_of_pos_left h2 hpos)
    (Nat.mul_le_mul_right _ h1)

#print axioms mul_comm
#print axioms mul_assoc
#print axioms mul_one
#print axioms norm_mul
#print axioms conjugate_product
#print axioms rotate_boundary
#print axioms rotate_norm
#print axioms norm_height_identity
#print axioms inverse_numerators
#print axioms boundary_remainder_x
#print axioms boundary_remainder_y
#print axioms boundary_remainder_sum
#print axioms step_is_mul
#print axioms step_norm
#print axioms orbit_norm
#print axioms orbit_add
#print axioms orbit_six
#print axioms orbit_six_shift
#print axioms orbit_mod_four
#print axioms orbit_mod_seven
#print axioms cubic_coordinate
#print axioms boundary_step_recurrence
#print axioms orbit_boundary_recurrence
#print axioms orbit_boundary_lucas
#print axioms cubic_difference
#print axioms orbit_cubic_difference
#print axioms exact_small_orbits
#print axioms boundary_factor_certificates
#print axioms defect_ratio_increases
end ABCEisenstein20260905
