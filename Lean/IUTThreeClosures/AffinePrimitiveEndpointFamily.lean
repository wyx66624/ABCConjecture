/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineResidualParametrization
import Mathlib.Tactic

/-!
# Primitive endpoint certificates inside the affine residual family

The affine residual parametrization can be made primitive without sacrificing
the prescribed endpoint moduli or the prescribed additive gap.  If

`alpha*m + beta*(R*S*t) = 1`,

then explicit integral linear combinations certify that `m`, the left
endpoint, and the right endpoint are pairwise coprime.  When `m` is coprime to
`R*S`, the parameters `t = 1+k*m` satisfy such a certificate for every `k`.

Consequently there are infinite affine families with prescribed coprime power
moduli, prescribed gap, primitive residual coefficients, and primitive
endpoint triples.  The only uncontrolled datum is the radical of the affine
residual coefficients.

No abc estimate or radical estimate is assumed.
-/

namespace IUTThreeClosures
namespace AffinePrimitiveEndpointFamily

open AffineResidualParametrization

/-- A Bezout certificate between the gap and the left endpoint. -/
theorem gap_leftEndpoint_bezout
    {R S m x t alpha beta : ℤ}
    (hcoprime : alpha * m + beta * (R * S * t) = 1) :
    (alpha + beta * R * x) * m +
        beta * leftEndpoint R m S x t = 1 := by
  unfold leftEndpoint residualA
  calc
    (alpha + beta * R * x) * m +
        beta * (R * (-m * x + t * S)) =
      alpha * m + beta * (R * S * t) := by ring
    _ = 1 := hcoprime

/-- A Bezout certificate between the gap and the right endpoint. -/
theorem gap_rightEndpoint_bezout
    {R S m y t alpha beta : ℤ}
    (hcoprime : alpha * m + beta * (R * S * t) = 1) :
    (alpha - beta * S * y) * m +
        beta * rightEndpoint S m R y t = 1 := by
  unfold rightEndpoint residualB
  calc
    (alpha - beta * S * y) * m +
        beta * (S * (m * y + t * R)) =
      alpha * m + beta * (R * S * t) := by ring
    _ = 1 := hcoprime

/-- A Bezout certificate between the two endpoints. -/
theorem endpoint_pair_bezout
    {R S m x y t alpha beta : ℤ}
    (hbezout : R * x + S * y = 1)
    (hcoprime : alpha * m + beta * (R * S * t) = 1) :
    (beta - (alpha + beta * R * x)) *
          leftEndpoint R m S x t +
        (alpha + beta * R * x) *
          rightEndpoint S m R y t = 1 := by
  have hleft := gap_leftEndpoint_bezout hcoprime
  have hgap := endpoint_gap_identity hbezout m t
  calc
    (beta - (alpha + beta * R * x)) *
          leftEndpoint R m S x t +
        (alpha + beta * R * x) *
          rightEndpoint S m R y t =
      (alpha + beta * R * x) *
          (rightEndpoint S m R y t - leftEndpoint R m S x t) +
        beta * leftEndpoint R m S x t := by ring
    _ = (alpha + beta * R * x) * m +
        beta * leftEndpoint R m S x t := by rw [hgap]
    _ = 1 := hleft

/-- All three pairwise Bezout certificates, with explicit coefficients. -/
theorem primitive_endpoint_bezout_certificates
    {R S m x y t alpha beta : ℤ}
    (hbezout : R * x + S * y = 1)
    (hcoprime : alpha * m + beta * (R * S * t) = 1) :
    ((alpha + beta * R * x) * m +
          beta * leftEndpoint R m S x t = 1) ∧
      ((alpha - beta * S * y) * m +
          beta * rightEndpoint S m R y t = 1) ∧
      ((beta - (alpha + beta * R * x)) *
            leftEndpoint R m S x t +
          (alpha + beta * R * x) *
            rightEndpoint S m R y t = 1) := by
  exact ⟨gap_leftEndpoint_bezout hcoprime,
    gap_rightEndpoint_bezout hcoprime,
    endpoint_pair_bezout hbezout hcoprime⟩

/-- A certificate for `m` and `R*S` lifts to every parameter
`t = 1+k*m`. -/
theorem lift_coprimality_certificate_one_mod_gap
    {R S m alpha beta : ℤ}
    (hbase : alpha * m + beta * (R * S) = 1)
    (k : ℤ) :
    (alpha * (1 + k * m) - k) * m +
        beta * (R * S * (1 + k * m)) = 1 := by
  calc
    (alpha * (1 + k * m) - k) * m +
        beta * (R * S * (1 + k * m)) =
      (1 + k * m) * (alpha * m + beta * (R * S)) - k * m := by ring
    _ = (1 + k * m) * 1 - k * m := by rw [hbase]
    _ = 1 := by ring

/-- Every parameter `1+k*m` gives an explicit pairwise-primitive endpoint
triple whenever `m` and `R*S` have a Bezout certificate. -/
theorem exists_pairwise_bezout_certificates_one_mod_gap
    {R S m x y alpha beta : ℤ}
    (hbezout : R * x + S * y = 1)
    (hbase : alpha * m + beta * (R * S) = 1)
    (k : ℤ) :
    ∃ um vm uc vc uMC vMC : ℤ,
      um * m + vm * leftEndpoint R m S x (1 + k * m) = 1 ∧
      uc * m + vc * rightEndpoint S m R y (1 + k * m) = 1 ∧
      uMC * leftEndpoint R m S x (1 + k * m) +
        vMC * rightEndpoint S m R y (1 + k * m) = 1 := by
  let alphaK : ℤ := alpha * (1 + k * m) - k
  have hcoprime :
      alphaK * m + beta * (R * S * (1 + k * m)) = 1 := by
    dsimp [alphaK]
    exact lift_coprimality_certificate_one_mod_gap hbase k
  refine ⟨alphaK + beta * R * x, beta,
    alphaK - beta * S * y, beta,
    beta - (alphaK + beta * R * x),
    alphaK + beta * R * x, ?_⟩
  exact primitive_endpoint_bezout_certificates hbezout hcoprime

/-- The residual pair at `t=1+k*m` is primitive in the universal-divisor
sense: every common divisor divides one. -/
theorem residual_common_divisor_dvd_one_one_mod_gap
    {R S x y m k d : ℤ}
    (hbezout : R * x + S * y = 1)
    (hA : d ∣ residualA m S x (1 + k * m))
    (hB : d ∣ residualB m R y (1 + k * m)) :
    d ∣ 1 := by
  have hcommon :=
    (common_divisor_iff (d := d) hbezout m (1 + k * m)).1 ⟨hA, hB⟩
  rcases hcommon.1 with ⟨a, ha⟩
  rcases hcommon.2 with ⟨b, hb⟩
  refine ⟨b - k * a, ?_⟩
  calc
    1 = (1 + k * m) - k * m := by ring
    _ = d * b - k * (d * a) := by rw [hb, ha]
    _ = d * (b - k * a) := by ring

/-- The arithmetic progression `1+k*m` is injective when the gap is nonzero. -/
theorem one_mod_gap_parameter_injective
    {m : ℤ} (hm : m ≠ 0) :
    Function.Injective (fun k : ℤ => 1 + k * m) := by
  intro k l hkl
  have hmul : (k - l) * m = 0 := by
    calc
      (k - l) * m = (1 + k * m) - (1 + l * m) := by ring
      _ = 0 := by rw [hkl]; ring
  have hsub : k - l = 0 := (mul_eq_zero.mp hmul).resolve_right hm
  linarith

/-- Hence the primitive residual pairs in the progression are all distinct. -/
theorem one_mod_gap_residual_pair_injective
    {R S x y m : ℤ}
    (hbezout : R * x + S * y = 1)
    (hm : m ≠ 0) :
    Function.Injective
      (fun k : ℤ =>
        (residualA m S x (1 + k * m),
          residualB m R y (1 + k * m))) := by
  intro k l hpair
  apply one_mod_gap_parameter_injective hm
  apply parameter_unique hbezout
  · exact congrArg Prod.fst hpair
  · exact congrArg Prod.snd hpair

#print axioms gap_leftEndpoint_bezout
#print axioms gap_rightEndpoint_bezout
#print axioms endpoint_pair_bezout
#print axioms primitive_endpoint_bezout_certificates
#print axioms lift_coprimality_certificate_one_mod_gap
#print axioms exists_pairwise_bezout_certificates_one_mod_gap
#print axioms residual_common_divisor_dvd_one_one_mod_gap
#print axioms one_mod_gap_parameter_injective
#print axioms one_mod_gap_residual_pair_injective

end AffinePrimitiveEndpointFamily
end IUTThreeClosures
