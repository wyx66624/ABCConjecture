/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SignedPrimeExponentLayer
import IUTThreeClosures.PowerSquareGapPellBridge
import Mathlib.Data.Nat.Squarefree
import Mathlib.Tactic

/-!
# A concrete squarefree moving-Pell witness for every abc point

The previous moving-Pell module works with arbitrary finite exponent profiles.
This file instantiates that bookkeeping on the actual three integers of an
`ABCPoint`.

Every positive integer is a square times a squarefree integer.  Therefore,
writing

`m = min(a,b)`, `M = max(a,b)`,

we obtain positive squarefree coefficients `w,u,v` and positive roots `z,x,y`
with

`m = w*z^2`, `M = u*x^2`, `c = v*y^2`.

The abc equation becomes the genuine primitive moving conic

`w*z^2 + u*x^2 = v*y^2`

and, after multiplying by `v`, the norm equation

`(v*y)^2 = (u*v)*x^2 + v*(w*z^2)`.

The products `w*z`, `u*x`, and `v*y` inherit the pairwise coprimality of the
three abc endpoints.  Thus no hidden common factor is introduced by the
square extraction.  No estimate for the moving Pell equation is assumed.
-/

namespace IUTThreeClosures

noncomputable section

namespace ABCPoint

/-- The smaller and larger summands recover the original sum. -/
theorem endpointMin_add_largeEndpoint (P : ABCPoint) :
    P.endpointMin + P.largeEndpoint = P.c := by
  by_cases hab : P.a ≤ P.b
  · simp [endpointMin, largeEndpoint, hab, P.sum_eq]
  · have hba : P.b ≤ P.a := by omega
    simp [endpointMin, largeEndpoint, hba, Nat.add_comm, P.sum_eq]

/-- Concrete squarefree data attached to the three ordered abc endpoints. -/
structure SquarefreePellWitness (P : ABCPoint) where
  w : ℕ
  z : ℕ
  u : ℕ
  x : ℕ
  v : ℕ
  y : ℕ

  w_pos : 0 < w
  z_pos : 0 < z
  u_pos : 0 < u
  x_pos : 0 < x
  v_pos : 0 < v
  y_pos : 0 < y

  w_squarefree : Squarefree w
  u_squarefree : Squarefree u
  v_squarefree : Squarefree v

  small_eq : P.endpointMin = w * z ^ 2
  large_eq : P.largeEndpoint = u * x ^ 2
  c_eq : P.c = v * y ^ 2

  conic_eq : w * z ^ 2 + u * x ^ 2 = v * y ^ 2
  pell_norm_eq : (v * y) ^ 2 = (u * v) * x ^ 2 + v * (w * z ^ 2)

  small_large_coprime : Nat.Coprime (w * z) (u * x)
  small_c_coprime : Nat.Coprime (w * z) (v * y)
  large_c_coprime : Nat.Coprime (u * x) (v * y)

/-- Every positive primitive abc point has concrete squarefree moving-Pell
witness data. -/
theorem exists_squarefreePellWitness (P : ABCPoint) :
    Nonempty P.SquarefreePellWitness := by
  obtain ⟨w, z, hw, hz, hsmall0, hwsq⟩ :=
    Nat.sq_mul_squarefree_of_pos P.endpointMin_pos
  obtain ⟨u, x, hu, hx, hlarge0, husq⟩ :=
    Nat.sq_mul_squarefree_of_pos P.largeEndpoint_pos
  obtain ⟨v, y, hv, hy, hc0, hvsq⟩ :=
    Nat.sq_mul_squarefree_of_pos P.c_pos

  have hsmall : P.endpointMin = w * z ^ 2 := by
    calc
      P.endpointMin = z ^ 2 * w := hsmall0.symm
      _ = w * z ^ 2 := by ring
  have hlarge : P.largeEndpoint = u * x ^ 2 := by
    calc
      P.largeEndpoint = x ^ 2 * u := hlarge0.symm
      _ = u * x ^ 2 := by ring
  have hc : P.c = v * y ^ 2 := by
    calc
      P.c = y ^ 2 * v := hc0.symm
      _ = v * y ^ 2 := by ring

  have hconic : w * z ^ 2 + u * x ^ 2 = v * y ^ 2 := by
    calc
      w * z ^ 2 + u * x ^ 2 = P.endpointMin + P.largeEndpoint := by
        rw [hsmall, hlarge]
      _ = P.c := P.endpointMin_add_largeEndpoint
      _ = v * y ^ 2 := hc

  have hpell :
      (v * y) ^ 2 = (u * v) * x ^ 2 + v * (w * z ^ 2) :=
    PowerSquareGapPellBridge.square_gap_to_pell_norm_equation hconic

  have hsmallDiv : w * z ∣ P.endpointMin := by
    refine ⟨z, ?_⟩
    rw [hsmall]
    ring
  have hlargeDiv : u * x ∣ P.largeEndpoint := by
    refine ⟨x, ?_⟩
    rw [hlarge]
    ring
  have hcDiv : v * y ∣ P.c := by
    refine ⟨y, ?_⟩
    rw [hc]
    ring

  refine ⟨{
    w := w
    z := z
    u := u
    x := x
    v := v
    y := y
    w_pos := hw
    z_pos := hz
    u_pos := hu
    x_pos := hx
    v_pos := hv
    y_pos := hy
    w_squarefree := hwsq
    u_squarefree := husq
    v_squarefree := hvsq
    small_eq := hsmall
    large_eq := hlarge
    c_eq := hc
    conic_eq := hconic
    pell_norm_eq := hpell
    small_large_coprime :=
      Nat.Coprime.of_dvd hsmallDiv hlargeDiv
        P.signedLayer_endpointMin_coprime_largeEndpoint
    small_c_coprime :=
      Nat.Coprime.of_dvd hsmallDiv hcDiv
        P.signedLayer_endpointMin_coprime_c
    large_c_coprime :=
      Nat.Coprime.of_dvd hlargeDiv hcDiv P.largeEndpoint_coprime_c
  }⟩

/-- In particular, the two square roots on the large endpoints are coprime. -/
theorem SquarefreePellWitness.x_coprime_y
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Nat.Coprime W.x W.y := by
  apply Nat.Coprime.of_dvd
      (show W.x ∣ W.u * W.x by exact dvd_mul_left _ _)
      (show W.y ∣ W.v * W.y by exact dvd_mul_left _ _)
  exact W.large_c_coprime

/-- The small square root is coprime to the large-endpoint square root. -/
theorem SquarefreePellWitness.z_coprime_x
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Nat.Coprime W.z W.x := by
  apply Nat.Coprime.of_dvd
      (show W.z ∣ W.w * W.z by exact dvd_mul_left _ _)
      (show W.x ∣ W.u * W.x by exact dvd_mul_left _ _)
  exact W.small_large_coprime

/-- The small square root is coprime to the square root on `c`. -/
theorem SquarefreePellWitness.z_coprime_y
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Nat.Coprime W.z W.y := by
  apply Nat.Coprime.of_dvd
      (show W.z ∣ W.w * W.z by exact dvd_mul_left _ _)
      (show W.y ∣ W.v * W.y by exact dvd_mul_left _ _)
  exact W.small_c_coprime

#print axioms endpointMin_add_largeEndpoint
#print axioms exists_squarefreePellWitness
#print axioms SquarefreePellWitness.x_coprime_y
#print axioms SquarefreePellWitness.z_coprime_x
#print axioms SquarefreePellWitness.z_coprime_y

end ABCPoint
end
end IUTThreeClosures
