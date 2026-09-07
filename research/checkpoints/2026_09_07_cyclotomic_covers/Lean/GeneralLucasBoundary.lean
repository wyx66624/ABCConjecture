import EisensteinDescent

/-! The general actual Lucas bridge, ordinarily proved and independently
reviewed before this formalization. No cyclotomic or global saving theorem
is assumed in these identities. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCGeneralLucasBoundary20260907
open ABCEisenstein20260905

def cubicTrace (w : Pair) : Int :=
  2*w.1^3+3*w.1^2*w.2-3*w.1*w.2^2-2*w.2^3

def power (w : Pair) : Nat → Pair
  | 0 => (1,0)
  | n+1 => mul w (power w n)

def boundaryOrbit (w z : Pair) (n : Nat) : Int :=
  boundary (mul (power w n) z)

def lucas (t r : Int) : Nat → Int
  | 0 => 0
  | 1 => 1
  | n+2 => t*lucas t r (n+1)-r*lucas t r n

theorem cubic_trace_identity (w : Pair) :
    cubicTrace w = (mul w (mul w w)).1*2+(mul w (mul w w)).2 := by
  dsimp [cubicTrace,mul]
  grind

theorem trace_discriminant_identity (w : Pair) :
    (cubicTrace w)^2+27*(boundary w)^2 = 4*(norm w)^3 := by
  dsimp [cubicTrace,boundary,norm]
  grind

theorem general_shifted_boundary_recurrence (w z : Pair) :
    boundary (mul w (mul w z))+(norm w)^3*boundary z =
      cubicTrace w*boundary (mul w z) := by
  dsimp [boundary,mul,norm,cubicTrace]
  grind

theorem norm_power (w : Pair) (n : Nat) : norm (power w n) = (norm w)^n := by
  induction n with
  | zero => simp [power,norm]
  | succ n ih =>
    rw [power,norm_mul,ih,Int.pow_succ]
    exact Int.mul_comm _ _

theorem boundary_orbit_recurrence (w z : Pair) (n : Nat) :
    boundaryOrbit w z (n+2) = cubicTrace w*boundaryOrbit w z (n+1)-
      (norm w)^3*boundaryOrbit w z n := by
  have h := general_shifted_boundary_recurrence w (mul (power w n) z)
  have he₁ : boundaryOrbit w z (n+1) = boundary (mul w (mul (power w n) z)) := by
    simp [boundaryOrbit,power,mul_assoc]
  have he₂ : boundaryOrbit w z (n+2) =
      boundary (mul w (mul w (mul (power w n) z))) := by
    simp [boundaryOrbit,power,mul_assoc]
  rw [he₁,he₂]
  dsimp [boundaryOrbit]
  omega

theorem lucas_recurrence (t r : Int) (n : Nat) :
    lucas t r (n+2) = t*lucas t r (n+1)-r*lucas t r n := rfl

/-- Exact solution of every integer recurrence with the specified two initial values. -/
theorem linear_recurrence_solution (f : Nat → Int) (t r : Int)
    (hf : ∀ n, f (n+2) = t*f (n+1)-r*f n) (n : Nat) :
    f (n+1) = lucas t r (n+1)*f 1-r*lucas t r n*f 0 := by
  have both : ∀ k,
      f (k+1) = lucas t r (k+1)*f 1-r*lucas t r k*f 0 ∧
      f (k+2) = lucas t r (k+2)*f 1-r*lucas t r (k+1)*f 0 := by
    intro k
    induction k with
    | zero =>
      constructor
      · simp [lucas]
      · simpa [lucas] using hf 0
    | succ k ih =>
      constructor
      · exact ih.2
      · have hnext := hf (k+1)
        have hu := lucas_recurrence t r k
        have hu' := lucas_recurrence t r (k+1)
        grind
  exact (both n).1

theorem actual_shifted_lucas_solution (w z : Pair) (n : Nat) :
    boundaryOrbit w z (n+1) =
      lucas (cubicTrace w) ((norm w)^3) (n+1)*boundary (mul w z)-
      (norm w)^3*lucas (cubicTrace w) ((norm w)^3) n*boundary z := by
  have h := linear_recurrence_solution (boundaryOrbit w z) (cubicTrace w)
    ((norm w)^3) (boundary_orbit_recurrence w z) n
  simpa [boundaryOrbit,power,mul_one,mul_comm] using h

theorem actual_power_boundary_lucas (w : Pair) (n : Nat) :
    boundary (power w n) = boundary w*lucas (cubicTrace w) ((norm w)^3) n := by
  cases n with
  | zero => simp [power,lucas,boundary]
  | succ n =>
    have h := actual_shifted_lucas_solution w (1,0) n
    simpa [boundaryOrbit,mul_one,boundary,Int.mul_comm] using h

theorem actual_boundary_divides_powers (w : Pair) (n : Nat) :
    boundary w ∣ boundary (power w n) :=
  ⟨lucas (cubicTrace w) ((norm w)^3) n,actual_power_boundary_lucas w n⟩

#print axioms cubic_trace_identity
#print axioms trace_discriminant_identity
#print axioms general_shifted_boundary_recurrence
#print axioms norm_power
#print axioms boundary_orbit_recurrence
#print axioms lucas_recurrence
#print axioms linear_recurrence_solution
#print axioms actual_shifted_lucas_solution
#print axioms actual_power_boundary_lucas
#print axioms actual_boundary_divides_powers
end ABCGeneralLucasBoundary20260907
