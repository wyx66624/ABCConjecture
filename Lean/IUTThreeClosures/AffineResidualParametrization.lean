/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CoprimeModuliAdjacentNoGo
import Mathlib.Tactic

/-!
# Exact affine parametrization of the residual coefficients

Fix integers `R,S,x,y` with the Bezout identity

`R*x + S*y = 1`.

For a prescribed additive gap `m` and an integer parameter `t`, put

`A_t = -m*x + t*S`,
`B_t =  m*y + t*R`.

Then

`S*B_t - R*A_t = m`,
`y*A_t + x*B_t = t`.

The change of variables `(m,t) ↔ (A_t,B_t)` is therefore unimodular.  In
particular, the common divisors of the two residual coefficients are exactly
the common divisors of `m` and `t`, and every integral solution of
`S*B-R*A=m` occurs uniquely in this affine family.

After multiplying by the prescribed endpoint moduli, the endpoints

`M_t = R*A_t`, `C_t = S*B_t`

have gap `m`.  Thus the unresolved arithmetic in power-divisor approaches to
abc is precisely the radical of the two affine residual coefficients; neither
the power moduli nor primitivity of the residual pair removes this freedom.

No abc estimate, radical estimate, or distribution theorem is assumed.
-/

namespace IUTThreeClosures
namespace AffineResidualParametrization

/-- Left residual coefficient in the gap-`m` Bezout family. -/
def residualA (m S x t : ℤ) : ℤ :=
  -m * x + t * S

/-- Right residual coefficient in the gap-`m` Bezout family. -/
def residualB (m R y t : ℤ) : ℤ :=
  m * y + t * R

/-- The residual coefficients solve the prescribed-gap equation. -/
theorem residual_gap_identity
    {R S x y : ℤ}
    (hbezout : R * x + S * y = 1) (m t : ℤ) :
    S * residualB m R y t - R * residualA m S x t = m := by
  unfold residualA residualB
  calc
    S * (m * y + t * R) - R * (-m * x + t * S) =
        m * (R * x + S * y) := by ring
    _ = m := by rw [hbezout]; ring

/-- The parameter is recovered by the inverse integral linear form. -/
theorem residual_parameter_identity
    {R S x y : ℤ}
    (hbezout : R * x + S * y = 1) (m t : ℤ) :
    y * residualA m S x t + x * residualB m R y t = t := by
  unfold residualA residualB
  calc
    y * (-m * x + t * S) + x * (m * y + t * R) =
        t * (R * x + S * y) := by ring
    _ = t := by rw [hbezout]; ring

/-- The two residual coefficients and the pair `(m,t)` have exactly the same
common divisors.  This is the divisibility form of
`gcd(A_t,B_t)=gcd(m,t)`, avoiding any normalization convention for integer
gcds. -/
theorem common_divisor_iff
    {R S x y d : ℤ}
    (hbezout : R * x + S * y = 1) (m t : ℤ) :
    (d ∣ residualA m S x t ∧ d ∣ residualB m R y t) ↔
      (d ∣ m ∧ d ∣ t) := by
  constructor
  · rintro ⟨hA, hB⟩
    rcases hA with ⟨a, ha⟩
    rcases hB with ⟨b, hb⟩
    constructor
    · refine ⟨S * b - R * a, ?_⟩
      have hgap := residual_gap_identity hbezout m t
      rw [ha, hb] at hgap
      calc
        m = S * (d * b) - R * (d * a) := hgap.symm
        _ = d * (S * b - R * a) := by ring
    · refine ⟨y * a + x * b, ?_⟩
      have hparameter := residual_parameter_identity hbezout m t
      rw [ha, hb] at hparameter
      calc
        t = y * (d * a) + x * (d * b) := hparameter.symm
        _ = d * (y * a + x * b) := by ring
  · rintro ⟨hm, ht⟩
    rcases hm with ⟨u, hu⟩
    rcases ht with ⟨v, hv⟩
    constructor
    · refine ⟨-u * x + v * S, ?_⟩
      unfold residualA
      rw [hu, hv]
      ring
    · refine ⟨u * y + v * R, ?_⟩
      unfold residualB
      rw [hu, hv]
      ring

/-- Recover the left residual coefficient from an arbitrary solution of the
gap equation. -/
theorem residualA_recover
    {R S x y A B m : ℤ}
    (hbezout : R * x + S * y = 1)
    (hgap : S * B - R * A = m) :
    A = residualA m S x (y * A + x * B) := by
  unfold residualA
  calc
    A = A * (R * x + S * y) := by rw [hbezout]; ring
    _ = -(S * B - R * A) * x + (y * A + x * B) * S := by ring
    _ = -m * x + (y * A + x * B) * S := by rw [hgap]

/-- Recover the right residual coefficient from an arbitrary solution of the
gap equation. -/
theorem residualB_recover
    {R S x y A B m : ℤ}
    (hbezout : R * x + S * y = 1)
    (hgap : S * B - R * A = m) :
    B = residualB m R y (y * A + x * B) := by
  unfold residualB
  calc
    B = B * (R * x + S * y) := by rw [hbezout]; ring
    _ = (S * B - R * A) * y + (y * A + x * B) * R := by ring
    _ = m * y + (y * A + x * B) * R := by rw [hgap]

/-- Every integral solution of `S*B-R*A=m` is in the affine family. -/
theorem residual_parametrization
    {R S x y A B m : ℤ}
    (hbezout : R * x + S * y = 1)
    (hgap : S * B - R * A = m) :
    A = residualA m S x (y * A + x * B) ∧
      B = residualB m R y (y * A + x * B) := by
  exact ⟨residualA_recover hbezout hgap,
    residualB_recover hbezout hgap⟩

/-- Exact classification of all integral residual pairs. -/
theorem gap_equation_iff_exists_parameter
    {R S x y A B m : ℤ}
    (hbezout : R * x + S * y = 1) :
    S * B - R * A = m ↔
      ∃ t : ℤ,
        A = residualA m S x t ∧
          B = residualB m R y t := by
  constructor
  · intro hgap
    exact ⟨y * A + x * B, residual_parametrization hbezout hgap⟩
  · rintro ⟨t, hA, hB⟩
    rw [hA, hB]
    exact residual_gap_identity hbezout m t

/-- The affine parameter is unique. -/
theorem parameter_unique
    {R S x y m t u : ℤ}
    (hbezout : R * x + S * y = 1)
    (hA : residualA m S x t = residualA m S x u)
    (hB : residualB m R y t = residualB m R y u) :
    t = u := by
  have ht := residual_parameter_identity hbezout m t
  have hu := residual_parameter_identity hbezout m u
  calc
    t = y * residualA m S x t + x * residualB m R y t := ht.symm
    _ = y * residualA m S x u + x * residualB m R y u := by rw [hA, hB]
    _ = u := hu

/-- Cross-determinant identity for two parameters in the same family. -/
theorem residual_cross_determinant
    {R S x y : ℤ}
    (hbezout : R * x + S * y = 1) (m t u : ℤ) :
    residualA m S x t * residualB m R y u -
        residualA m S x u * residualB m R y t =
      m * (t - u) := by
  unfold residualA residualB
  calc
    (-m * x + t * S) * (m * y + u * R) -
        (-m * x + u * S) * (m * y + t * R) =
      m * (t - u) * (R * x + S * y) := by ring
    _ = m * (t - u) := by rw [hbezout]; ring

/-- Left endpoint with prescribed modulus `R`. -/
def leftEndpoint (R m S x t : ℤ) : ℤ :=
  R * residualA m S x t

/-- Right endpoint with prescribed modulus `S`. -/
def rightEndpoint (S m R y t : ℤ) : ℤ :=
  S * residualB m R y t

/-- The endpoint family has exactly the prescribed additive gap. -/
theorem endpoint_gap_identity
    {R S x y : ℤ}
    (hbezout : R * x + S * y = 1) (m t : ℤ) :
    rightEndpoint S m R y t - leftEndpoint R m S x t = m := by
  unfold rightEndpoint leftEndpoint
  exact residual_gap_identity hbezout m t

/-- Both endpoints have their prescribed divisibility moduli. -/
theorem endpoint_divisibility
    (R S m x y t : ℤ) :
    R ∣ leftEndpoint R m S x t ∧
      S ∣ rightEndpoint S m R y t := by
  unfold leftEndpoint rightEndpoint
  exact ⟨dvd_mul_right R _, dvd_mul_right S _⟩

/-- Cross-determinant identity after inserting the endpoint moduli. -/
theorem endpoint_cross_determinant
    {R S x y : ℤ}
    (hbezout : R * x + S * y = 1) (m t u : ℤ) :
    leftEndpoint R m S x t * rightEndpoint S m R y u -
        leftEndpoint R m S x u * rightEndpoint S m R y t =
      R * S * m * (t - u) := by
  unfold leftEndpoint rightEndpoint
  calc
    (R * residualA m S x t) * (S * residualB m R y u) -
        (R * residualA m S x u) * (S * residualB m R y t) =
      R * S *
        (residualA m S x t * residualB m R y u -
          residualA m S x u * residualB m R y t) := by ring
    _ = R * S * (m * (t - u)) := by
      rw [residual_cross_determinant hbezout m t u]
    _ = R * S * m * (t - u) := by ring

/-- Elementary conditions making both endpoints strictly positive. -/
theorem endpoint_positive
    {R S m x y t : ℤ}
    (hR : 0 < R) (hS : 0 < S)
    (hA : m * x < t * S) (hB : -m * y < t * R) :
    0 < leftEndpoint R m S x t ∧
      0 < rightEndpoint S m R y t := by
  constructor
  · unfold leftEndpoint residualA
    exact mul_pos hR (by linarith)
  · unfold rightEndpoint residualB
    exact mul_pos hS (by linarith)

/-- At gap one, the displayed gap identity is already an explicit Bezout
certificate for the two residual coefficients. -/
theorem gap_one_residual_bezout
    {R S x y : ℤ}
    (hbezout : R * x + S * y = 1) (t : ℤ) :
    (-R) * residualA 1 S x t +
        S * residualB 1 R y t = 1 := by
  have hgap := residual_gap_identity hbezout 1 t
  linarith

/-- Every common divisor of the gap-one residual pair divides one. -/
theorem common_divisor_dvd_one_of_gap_one
    {R S x y d : ℤ}
    (hbezout : R * x + S * y = 1) (t : ℤ)
    (hA : d ∣ residualA 1 S x t)
    (hB : d ∣ residualB 1 R y t) :
    d ∣ 1 := by
  exact ((common_divisor_iff (d := d) hbezout 1 t).1 ⟨hA, hB⟩).1

#print axioms residual_gap_identity
#print axioms residual_parameter_identity
#print axioms common_divisor_iff
#print axioms residual_parametrization
#print axioms gap_equation_iff_exists_parameter
#print axioms parameter_unique
#print axioms residual_cross_determinant
#print axioms endpoint_gap_identity
#print axioms endpoint_cross_determinant
#print axioms endpoint_positive
#print axioms gap_one_residual_bezout
#print axioms common_divisor_dvd_one_of_gap_one

end AffineResidualParametrization
end IUTThreeClosures
