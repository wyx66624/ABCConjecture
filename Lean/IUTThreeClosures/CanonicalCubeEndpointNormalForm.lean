/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.NatExponentProfileBridge
import Mathlib.Tactic

/-!
# Canonical cube normal form for the endpoint obstruction

For every positive integer `n`, its prime exponents give the exact canonical
factorization

`n = kappa₃(n) * rho₃(n)^3`,

where the exponents of `kappa₃(n)` are the residues modulo three and those of
`rho₃(n)` are the quotient exponents.  The cube of `rho₃(n)` therefore divides
`n`, and the logarithm of `rho₃(n)` is exactly the cube-root weight used in the
signed-defect reduction.

Combining this identity with the endpoint localization proves an actual
integer-divisor theorem: every hypothetical abc-height violation forces one
of the two large coprime endpoints to contain a canonical cube divisor whose
logarithmic size is larger than the complete localized defect threshold.

No bound excluding that cube divisor is assumed.
-/

namespace IUTThreeClosures
namespace CanonicalCubeEndpointNormalForm

open scoped BigOperators
open NatExponentProfileBridge

noncomputable section

/-- Canonical cube-free residue coefficient of `n`. -/
def naturalCubeKernel (n : ℕ) : ℕ :=
  exponentResidueKernel 3 n.primeFactors (fun p => p) n.factorization

/-- Canonical integral cube root extracted from `n`. -/
def naturalCubeRoot (n : ℕ) : ℕ :=
  exponentQuotientRoot 3 n.primeFactors (fun p => p) n.factorization

/-- Exact natural-number cube decomposition. -/
theorem natural_eq_cubeKernel_mul_cubeRoot_cube
    (n : ℕ) (hn : n ≠ 0) :
    n = naturalCubeKernel n * naturalCubeRoot n ^ 3 := by
  calc
    n = exponentProfileProduct n.primeFactors
        (fun p => p) n.factorization := by
      symm
      simpa [exponentProfileProduct] using
        (NatExponentProfileBridge.prod_primeFactorPowers_eq_self n hn)
    _ = naturalCubeKernel n * naturalCubeRoot n ^ 3 := by
      simpa [naturalCubeKernel, naturalCubeRoot] using
        (exponentProfileProduct_eq_kernel_mul_root_pow
          3 n.primeFactors (fun p => p) n.factorization)

/-- The canonical extracted cube actually divides the original integer. -/
theorem naturalCubeRoot_cube_dvd
    (n : ℕ) (hn : n ≠ 0) :
    naturalCubeRoot n ^ 3 ∣ n := by
  refine ⟨naturalCubeKernel n, ?_⟩
  simpa [mul_comm] using
    natural_eq_cubeKernel_mul_cubeRoot_cube n hn

/-- The canonical cube root is positive on positive integers. -/
theorem naturalCubeRoot_pos
    (n : ℕ) (hn : 0 < n) :
    0 < naturalCubeRoot n := by
  have hdecomp := natural_eq_cubeKernel_mul_cubeRoot_cube n hn.ne'
  by_contra hnot
  have hzero : naturalCubeRoot n = 0 := Nat.eq_zero_of_not_pos hnot
  rw [hzero] at hdecomp
  norm_num at hdecomp
  omega

/-- The logarithm of the integral canonical cube root is exactly the finite
prime-exponent cube-root weight. -/
theorem log_naturalCubeRoot_eq_weight
    (n : ℕ) (_hn : 0 < n) :
    Real.log (naturalCubeRoot n : ℝ) =
      NatExponentProfileBridge.naturalCubeRootWeight n := by
  unfold naturalCubeRoot
    NatExponentProfileBridge.naturalCubeRootWeight
    CubePartSignedDefect.cubeRootWeight
    exponentQuotientRoot exponentQuotientWeight
  push_cast
  rw [Real.log_prod]
  · apply Finset.sum_congr rfl
    intro p hp
    rw [Real.log_pow]
  · intro p hp
    exact pow_ne_zero _ (by
      exact_mod_cast (Nat.prime_of_mem_primeFactors hp).ne_zero)

/-- Logarithmic size of the actual cube divisor. -/
theorem log_naturalCubeRoot_cube_eq_three_weight
    (n : ℕ) (hn : 0 < n) :
    Real.log ((naturalCubeRoot n ^ 3 : ℕ) : ℝ) =
      3 * NatExponentProfileBridge.naturalCubeRootWeight n := by
  have hrootpos : 0 < (naturalCubeRoot n : ℝ) := by
    exact_mod_cast naturalCubeRoot_pos n hn
  push_cast
  rw [Real.log_pow, log_naturalCubeRoot_eq_weight n hn]
  norm_num

end
end CanonicalCubeEndpointNormalForm

namespace ABCPoint

/-- Every abc-height violation produces an explicit cube divisor of one of the
two large coprime endpoints, with logarithmic size exceeding the full localized
signed-defect threshold. -/
theorem exists_large_canonical_cube_divisor_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    let T :=
      Real.log (abcRadical P.endpointMin : ℝ) +
        epsilon * P.conductor + C - Real.log 2 / 2
    ∃ n : ℕ,
      (n = P.largeEndpoint ∨ n = P.c) ∧
      CanonicalCubeEndpointNormalForm.naturalCubeRoot n ^ 3 ∣ n ∧
      T < Real.log
        ((CanonicalCubeEndpointNormalForm.naturalCubeRoot n ^ 3 : ℕ) : ℝ) := by
  dsimp
  have hroot := P.endpoint_cubeRoot_large_of_height_violation hviolation
  rcases hroot with hM | hc
  · refine ⟨P.largeEndpoint, Or.inl rfl,
      CanonicalCubeEndpointNormalForm.naturalCubeRoot_cube_dvd
        P.largeEndpoint P.largeEndpoint_pos.ne', ?_⟩
    rw [CanonicalCubeEndpointNormalForm.log_naturalCubeRoot_cube_eq_three_weight
      P.largeEndpoint P.largeEndpoint_pos]
    nlinarith
  · refine ⟨P.c, Or.inr rfl,
      CanonicalCubeEndpointNormalForm.naturalCubeRoot_cube_dvd
        P.c P.c_pos.ne', ?_⟩
    rw [CanonicalCubeEndpointNormalForm.log_naturalCubeRoot_cube_eq_three_weight
      P.c P.c_pos]
    nlinarith

end ABCPoint

namespace CanonicalCubeEndpointNormalForm

#print axioms natural_eq_cubeKernel_mul_cubeRoot_cube
#print axioms naturalCubeRoot_cube_dvd
#print axioms naturalCubeRoot_pos
#print axioms log_naturalCubeRoot_eq_weight
#print axioms log_naturalCubeRoot_cube_eq_three_weight
#print axioms ABCPoint.exists_large_canonical_cube_divisor_of_height_violation

end CanonicalCubeEndpointNormalForm
end IUTThreeClosures
