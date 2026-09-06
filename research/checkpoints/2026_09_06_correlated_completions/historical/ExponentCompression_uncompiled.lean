import Mathlib

/-!
Author: ChatGPT.
UNCOMPILED DRAFT. No Lean process has checked this file in the current run.
The companion English paper precedes this formalization. These are only
polynomial, divisibility and finite example cores; they do not formalize
logarithmic forms, ray-class primes, uniform analytic estimates, or ABC.
No axiom or placeholder proof is declared below.
-/
set_option autoImplicit false
namespace ABCExponentCompression20260906

def pairMul (z w : ℤ × ℤ) : ℤ × ℤ :=
  (z.1*w.1-z.2*w.2, z.1*w.2+z.2*w.1+z.2*w.2)
def pairNorm (z : ℤ × ℤ) : ℤ := z.1^2+z.1*z.2+z.2^2
def pairBoundary (z : ℤ × ℤ) : ℤ := z.1*z.2*(z.1+z.2)
def pairConj (z : ℤ × ℤ) : ℤ × ℤ := (z.1+z.2,-z.2)
def pairCube (z : ℤ × ℤ) : ℤ × ℤ := pairMul (pairMul z z) z

theorem norm_product (z w : ℤ × ℤ) :
    pairNorm (pairMul z w) = pairNorm z * pairNorm w := by
  dsimp [pairNorm, pairMul]
  ring

theorem conjugate_norm (z : ℤ × ℤ) :
    pairNorm (pairConj z) = pairNorm z := by
  dsimp [pairNorm, pairConj]
  ring

theorem trace_cube (x y : ℤ) :
    2 * (pairCube (x,y)).1 + (pairCube (x,y)).2 =
      (x-y)*(2*x+y)*(x+2*y) := by
  dsimp [pairCube, pairMul]
  ring

theorem cube_boundary_coefficient (z : ℤ × ℤ) :
    (pairCube z).2 = 3 * pairBoundary z := by
  dsimp [pairCube, pairMul, pairBoundary]
  ring

theorem ramified_twist_norm (z : ℤ × ℤ) :
    pairNorm (pairMul (1,1) z) = 3 * pairNorm z := by
  rw [norm_product]
  norm_num [pairNorm]

theorem boundary_cubic_cap (x y : ℤ) (h : 0 ≤ x+y) :
    4 * pairBoundary (x,y) ≤ (x+y)^3 := by
  have hs := sq_nonneg (x-y)
  have hm : 0 ≤ (x+y)*(x-y)^2 := mul_nonneg h hs
  dsimp [pairBoundary]
  nlinarith [hm]

/-- A polynomial congruence core used by the prescribed-valuation construction. -/
theorem boundary_residue (m a b r : ℤ) :
    m ∣ pairBoundary (1+m*a, r+m*b) - r*(r+1) := by
  refine ⟨a*r*(r+2) + b*(2*r+1) +
    m*(a^2*r + a*b*(2*r+2) + b^2) +
    m^2*a*b*(a+b), ?_⟩
  dsimp [pairBoundary]
  ring

/-- The order-LTE argument supplies these exponents; this is its integer output. -/
theorem valuation_power_bound (p Q e j s : ℕ)
    (he : e = s+j) (hs : p^(2*s) ≤ Q^(p+1)) :
    p^(2*(e-j)) ≤ Q^(p+1) := by
  have h : e-j=s := by omega
  simpa [h] using hs

/-- A high prime power must divide one arm, not just the product. -/
theorem prime_power_arm_bound (a b c p k : ℕ)
    (ha : 0<a) (hb : 0<b) (hc : a+b=c)
    (h : p^k ∣ a ∨ p^k ∣ b ∨ p^k ∣ c) : p^k ≤ c := by
  have hcpos : 0<c := by omega
  rcases h with h | h | h
  · have hh := Nat.le_of_dvd ha h
    omega
  · have hh := Nat.le_of_dvd hb h
    omega
  · exact Nat.le_of_dvd hcpos h

theorem adjacent_exponents_coprime (m : ℕ) : Nat.Coprime m (m+1) := by
  simp

theorem smallest_prime_norm_example :
    pairNorm (1,624) = 390001 ∧
    pairBoundary (1,624) = 390000 ∧
    5^4 ∣ pairBoundary (1,624) ∧
    ¬5^5 ∣ pairBoundary (1,624) := by
  norm_num [pairNorm, pairBoundary]

#print axioms norm_product
#print axioms conjugate_norm
#print axioms trace_cube
#print axioms cube_boundary_coefficient
#print axioms ramified_twist_norm
#print axioms boundary_cubic_cap
#print axioms boundary_residue
#print axioms valuation_power_bound
#print axioms prime_power_arm_bound
#print axioms adjacent_exponents_coprime
#print axioms smallest_prime_norm_example
end ABCExponentCompression20260906
