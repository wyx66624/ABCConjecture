/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCPointSquarefreePellWitness
import Mathlib.RingTheory.Radical.NatInt
import Mathlib.Tactic

/-!
# Radical support of the squarefree moving-Pell coefficients

For the concrete decomposition

`min(a,b)=w*z^2`, `max(a,b)=u*x^2`, `c=v*y^2`,

the squarefree coefficients `w,u,v` are pairwise coprime and their product
divides the full abc radical.  In particular the moving Pell discriminant
coefficient `u*v` is squarefree and has no prime support outside the original
abc conductor.
-/

namespace IUTThreeClosures

open UniqueFactorizationMonoid

noncomputable section

namespace ABCPoint

/-- The three squarefree coefficients inherit pairwise coprimality. -/
theorem SquarefreePellWitness.w_coprime_u
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Nat.Coprime W.w W.u := by
  exact Nat.Coprime.of_dvd
    (show W.w ∣ W.w * W.z by exact dvd_mul_right _ _)
    (show W.u ∣ W.u * W.x by exact dvd_mul_right _ _)
    W.small_large_coprime

/-- The small and output coefficients are coprime. -/
theorem SquarefreePellWitness.w_coprime_v
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Nat.Coprime W.w W.v := by
  exact Nat.Coprime.of_dvd
    (show W.w ∣ W.w * W.z by exact dvd_mul_right _ _)
    (show W.v ∣ W.v * W.y by exact dvd_mul_right _ _)
    W.small_c_coprime

/-- The two large-endpoint coefficients are coprime. -/
theorem SquarefreePellWitness.u_coprime_v
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Nat.Coprime W.u W.v := by
  exact Nat.Coprime.of_dvd
    (show W.u ∣ W.u * W.x by exact dvd_mul_right _ _)
    (show W.v ∣ W.v * W.y by exact dvd_mul_right _ _)
    W.large_c_coprime

/-- The moving Pell discriminant coefficient is squarefree. -/
theorem SquarefreePellWitness.u_mul_v_squarefree
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Squarefree (W.u * W.v) := by
  rw [Nat.squarefree_mul_iff]
  exact ⟨W.u_coprime_v, W.u_squarefree, W.v_squarefree⟩

/-- The product of all three coefficient kernels is squarefree. -/
theorem SquarefreePellWitness.w_mul_u_mul_v_squarefree
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    Squarefree (W.w * (W.u * W.v)) := by
  rw [Nat.squarefree_mul_iff]
  refine ⟨W.w_coprime_u.mul_right W.w_coprime_v,
    W.w_squarefree, W.u_mul_v_squarefree⟩

/-- The small coefficient is supported on the radical of the small endpoint. -/
theorem SquarefreePellWitness.w_dvd_smallRadical
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    W.w ∣ abcRadical P.endpointMin := by
  rw [abcRadical_eq_natRadical]
  have hwRadical : IsRadical W.w :=
    (isRadical_iff_squarefree_of_ne_zero W.w_pos.ne').2 W.w_squarefree
  apply (UniqueFactorizationMonoid.dvd_radical_iff
    hwRadical P.endpointMin_pos.ne').2
  exact ⟨W.z ^ 2, W.small_eq⟩

/-- The large-summand coefficient is supported on its endpoint radical. -/
theorem SquarefreePellWitness.u_dvd_largeRadical
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    W.u ∣ abcRadical P.largeEndpoint := by
  rw [abcRadical_eq_natRadical]
  have huRadical : IsRadical W.u :=
    (isRadical_iff_squarefree_of_ne_zero W.u_pos.ne').2 W.u_squarefree
  apply (UniqueFactorizationMonoid.dvd_radical_iff
    huRadical P.largeEndpoint_pos.ne').2
  exact ⟨W.x ^ 2, W.large_eq⟩

/-- The output coefficient is supported on the radical of `c`. -/
theorem SquarefreePellWitness.v_dvd_cRadical
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    W.v ∣ abcRadical P.c := by
  rw [abcRadical_eq_natRadical]
  have hvRadical : IsRadical W.v :=
    (isRadical_iff_squarefree_of_ne_zero W.v_pos.ne').2 W.v_squarefree
  apply (UniqueFactorizationMonoid.dvd_radical_iff
    hvRadical P.c_pos.ne').2
  exact ⟨W.y ^ 2, W.c_eq⟩

/-- All moving-Pell coefficient support lies in the original abc radical. -/
theorem SquarefreePellWitness.coefficientProduct_dvd_abcRadical
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    W.w * W.u * W.v ∣ abcRadical (P.a * P.b * P.c) := by
  rw [P.abcRadical_eq_signedLayer_threeFactors]
  have hprod :
      W.w * (W.u * W.v) ∣
        abcRadical P.endpointMin *
          (abcRadical P.largeEndpoint * abcRadical P.c) :=
    mul_dvd_mul W.w_dvd_smallRadical
      (mul_dvd_mul W.u_dvd_largeRadical W.v_dvd_cRadical)
  simpa [mul_assoc] using hprod

/-- In particular, the squarefree Pell discriminant `u*v` divides the abc
radical. -/
theorem SquarefreePellWitness.discriminantCoefficient_dvd_abcRadical
    {P : ABCPoint} (W : P.SquarefreePellWitness) :
    W.u * W.v ∣ abcRadical (P.a * P.b * P.c) := by
  have huvCoeff : W.u * W.v ∣ W.w * W.u * W.v := by
    refine ⟨W.w, ?_⟩
    ring
  exact huvCoeff.trans W.coefficientProduct_dvd_abcRadical

#print axioms SquarefreePellWitness.w_coprime_u
#print axioms SquarefreePellWitness.w_coprime_v
#print axioms SquarefreePellWitness.u_coprime_v
#print axioms SquarefreePellWitness.u_mul_v_squarefree
#print axioms SquarefreePellWitness.w_mul_u_mul_v_squarefree
#print axioms SquarefreePellWitness.w_dvd_smallRadical
#print axioms SquarefreePellWitness.u_dvd_largeRadical
#print axioms SquarefreePellWitness.v_dvd_cRadical
#print axioms SquarefreePellWitness.coefficientProduct_dvd_abcRadical
#print axioms SquarefreePellWitness.discriminantCoefficient_dvd_abcRadical

end ABCPoint
end
end IUTThreeClosures
