import MovingSupport

/-!
Exact cross-residual cancellation and the Eisenstein determinant certificate.
Ordinary proofs: critical_bottleneck/next_global_tail.md, independently reviewed
by adversarial_audit/third_round/collision_review.md and the root researcher.
No private-depth estimate, probability transfer, or ABC assertion is assumed.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCResidualCollisions20260907
open ABCEisenstein20260905 ABCMovingSupport20260906

theorem boundary_scalar (m : Int) (z : Pair) :
    boundary (mul (m,0) z) = boundary z * m^3 := by
  dsimp [boundary, mul]
  grind

theorem cross_product (v₁ v₂ H : Pair) :
    mul (mul v₂ (conjugate v₁)) (mul v₁ H) =
      mul (norm v₁,0) (mul v₂ H) := by
  apply Prod.ext <;> dsimp [mul, conjugate, norm] <;> grind

theorem residual_norm_boundary_coprime (v H : Pair)
    (hp : Int.gcd (mul v H).1 (mul v H).2 = 1) :
    Int.gcd (boundary (mul v H)) (norm v) = 1 := by
  have h := norm_boundary_coprime (mul v H).1 (mul v H).2 hp
  change Int.gcd (norm (mul v H)) (boundary (mul v H)) = 1 at h
  have hd : norm v ∣ norm (mul v H) := by
    rw [norm_mul]
    exact ⟨norm H, rfl⟩
  have hh := Int.gcd_dvd_gcd_of_dvd_left (boundary (mul v H)) hd
  rw [h] at hh
  simpa [Int.gcd_comm] using Nat.dvd_one.mp hh

theorem cross_residual_boundary_gcd (v₁ v₂ H : Pair)
    (hp : Int.gcd (mul v₁ H).1 (mul v₁ H).2 = 1) :
    Int.gcd (boundary (mul v₁ H)) (boundary (mul v₂ H)) =
      Int.gcd (boundary (mul v₁ H)) (boundary (mul v₂ (conjugate v₁))) := by
  have h := boundary_gcd (mul v₂ (conjugate v₁)).1
    (mul v₂ (conjugate v₁)).2 (mul v₁ H).1 (mul v₁ H).2 hp
  change Int.gcd (boundary (mul v₁ H))
    (boundary (mul (mul v₂ (conjugate v₁)) (mul v₁ H))) = _ at h
  rw [cross_product, boundary_scalar,
    int_gcd_cancel_cube _ _ _ (residual_norm_boundary_coprime v₁ H hp)] at h
  exact h

def determinant (v w : Pair) : Int := v.1*w.2-v.2*w.1

def pairing (v w : Pair) : Int :=
  2*v.1*w.1+v.1*w.2+v.2*w.1+2*v.2*w.2

theorem gram_identity (v w : Pair) :
    4*norm v*norm w-(pairing v w)^2 = 3*(determinant v w)^2 := by
  dsimp [norm, pairing, determinant]
  grind

theorem determinant_mul (v w H : Pair) :
    determinant (mul v H) (mul w H) = norm H * determinant v w := by
  dsimp [determinant, mul, norm]
  grind

theorem norm_linear_factor_identities (a b : Int) :
    4*norm (a,b)-3*a^2=(a+2*b)^2 ∧
    4*norm (a,b)-3*b^2=(2*a+b)^2 ∧
    4*norm (a,b)-3*(a+b)^2=(a-b)^2 := by
  dsimp [norm]
  grind

theorem integer_square_nonnegative (x : Int) : 0 ≤ x^2 := by
  by_cases hx : 0 ≤ x
  · have h := Int.mul_nonneg hx hx
    grind
  · have hx' : 0 ≤ -x := by omega
    have h := Int.mul_nonneg hx' hx'
    grind

theorem norm_linear_factor_bounds (a b : Int) :
    3*a^2 ≤ 4*norm (a,b) ∧ 3*b^2 ≤ 4*norm (a,b) ∧
    3*(a+b)^2 ≤ 4*norm (a,b) := by
  have h := norm_linear_factor_identities a b
  have h₁ := integer_square_nonnegative (a+2*b)
  have h₂ := integer_square_nonnegative (2*a+b)
  have h₃ := integer_square_nonnegative (a-b)
  omega

theorem gram_bound (v w : Pair) :
    3*(determinant v w)^2 ≤ 4*norm v*norm w := by
  have h := gram_identity v w
  have hs := integer_square_nonnegative (pairing v w)
  omega

theorem nonzero_divisor_square (q d : Int) (hd : d ≠ 0) (hq : q ∣ d) :
    q^2 ≤ d^2 := by
  obtain ⟨k, hk⟩ := hq
  have hk0 : k ≠ 0 := by intro h; simp [h] at hk; omega
  have hk1 : 1 ≤ k^2 := by
    by_cases h : 0 ≤ k
    · have h1 : 1 ≤ k := by omega
      have h2 : 0 ≤ k-1 := by omega
      have h3 := Int.mul_nonneg h2 h
      grind
    · have h1 : 1 ≤ -k := by omega
      have h2 : 0 ≤ -k-1 := by omega
      have h3 : 0 ≤ -k := by omega
      have h4 := Int.mul_nonneg h2 h3
      grind
  have hs := integer_square_nonnegative q
  have hn : 0 ≤ k^2-1 := by omega
  have hmul := Int.mul_nonneg hs hn
  have he : q^2*(k^2-1) = d^2-q^2 := by
    rw [hk]
    simp only [Int.pow_succ, Int.pow_zero]
    grind
  rw [he] at hmul
  omega

theorem independent_lattice_norm_bound (v w : Pair) (q : Int)
    (hdet : determinant v w ≠ 0) (hq : q ∣ determinant v w) :
    3*q^2 ≤ 4*norm v*norm w := by
  have h₁ := nonzero_divisor_square q (determinant v w) hdet hq
  have h₂ := gram_bound v w
  omega

def arm (i : Fin 3) (v : Pair) : Int :=
  if i = 0 then v.1 else if i = 1 then v.2 else v.1+v.2

theorem same_arm_determinant_dvd (v w : Pair) (q : Int) (i : Fin 3)
    (hv : q ∣ arm i v) (hw : q ∣ arm i w) : q ∣ determinant v w := by
  have hi : i = 0 ∨ i = 1 ∨ i = 2 := by omega
  rcases hi with hi | hi | hi
  · subst i
    simp [arm] at hv hw
    obtain ⟨r, hr⟩ := hv
    obtain ⟨s, hs⟩ := hw
    refine ⟨r*w.2-v.2*s, ?_⟩
    dsimp [determinant]
    rw [hr, hs]
    grind
  · subst i
    simp [arm] at hv hw
    obtain ⟨r, hr⟩ := hv
    obtain ⟨s, hs⟩ := hw
    refine ⟨v.1*s-r*w.1, ?_⟩
    dsimp [determinant]
    rw [hr, hs]
    grind
  · subst i
    simp [arm] at hv hw
    obtain ⟨r, hr⟩ := hv
    obtain ⟨s, hs⟩ := hw
    refine ⟨r*w.2-v.2*s, ?_⟩
    dsimp [determinant]
    grind

theorem multiplied_same_arm_determinant_dvd (v w H : Pair) (q : Int) (i : Fin 3)
    (hn : Int.gcd q (norm H) = 1)
    (hv : q ∣ arm i (mul v H)) (hw : q ∣ arm i (mul w H)) :
    q ∣ determinant v w := by
  have h := same_arm_determinant_dvd (mul v H) (mul w H) q i hv hw
  rw [determinant_mul] at h
  have hg := Int.gcd_eq_natAbs_left h
  rw [int_gcd_cancel q (norm H) (determinant v w) hn] at hg
  exact Int.gcd_eq_natAbs_left_iff_dvd.mp hg

theorem annotated_prime_power_norm_bound (v w H : Pair) (q : Int) (i : Fin 3)
    (hn : Int.gcd q (norm H) = 1) (hdet : determinant v w ≠ 0)
    (hv : q ∣ arm i (mul v H)) (hw : q ∣ arm i (mul w H)) :
    3*q^2 ≤ 4*norm v*norm w := by
  exact independent_lattice_norm_bound v w q hdet
    (multiplied_same_arm_determinant_dvd v w H q i hn hv hw)

#print axioms boundary_scalar
#print axioms cross_product
#print axioms residual_norm_boundary_coprime
#print axioms cross_residual_boundary_gcd
#print axioms gram_identity
#print axioms determinant_mul
#print axioms norm_linear_factor_identities
#print axioms integer_square_nonnegative
#print axioms norm_linear_factor_bounds
#print axioms gram_bound
#print axioms nonzero_divisor_square
#print axioms independent_lattice_norm_bound
#print axioms same_arm_determinant_dvd
#print axioms multiplied_same_arm_determinant_dvd
#print axioms annotated_prime_power_norm_bound
end ABCResidualCollisions20260907
