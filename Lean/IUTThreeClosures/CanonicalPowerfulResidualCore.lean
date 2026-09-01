/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineResidualTrivialSlice
import IUTThreeClosures.ArithmeticLeibnizWronskian
import Mathlib.Data.Nat.Squarefree
import Mathlib.Tactic

/-!
# Canonical powerful-part residual core of an abc point

For a positive primitive abc point write

`m = min(a,b)`, `M = max(a,b)`,
`R = M / rad(M)`, `S = c / rad(c)`,
`A = rad(M)`, `B = rad(c)`.

Then the original equation is exactly

`S*B - R*A = m`.

The residual coefficients `A,B` are squarefree and pairwise coprime with the
gap; the powerful moduli `R,S` are coprime; and the radical of each modulus is
supported on its corresponding residual.  This specializes the affine
residual parametrization to the actual canonical arithmetic data of an abc
point.  It does not assume a radical estimate or the abc conjecture.
-/

namespace IUTThreeClosures
namespace CanonicalPowerfulResidualCore

open UniqueFactorizationMonoid

noncomputable section

namespace ABCPoint

/-- The smaller of the two summands. -/
def endpointMin (P : ABCPoint) : ℕ := min P.a P.b

/-- The larger of the two summands. -/
def largeEndpoint (P : ABCPoint) : ℕ := max P.a P.b

/-- The smaller summand is positive. -/
theorem endpointMin_pos (P : ABCPoint) : 0 < P.endpointMin := by
  by_cases hab : P.a ≤ P.b
  · simpa [endpointMin, hab] using P.a_pos
  · have hba : P.b ≤ P.a := Nat.le_of_not_ge hab
    simpa [endpointMin, hab, hba] using P.b_pos

/-- The larger summand is positive. -/
theorem largeEndpoint_pos (P : ABCPoint) : 0 < P.largeEndpoint := by
  by_cases hab : P.a ≤ P.b
  · simpa [largeEndpoint, hab] using P.b_pos
  · have hba : P.b ≤ P.a := Nat.le_of_not_ge hab
    simpa [largeEndpoint, hab, hba] using P.a_pos

/-- The small and large summands recover the sum. -/
theorem endpointMin_add_largeEndpoint_eq_c (P : ABCPoint) :
    P.endpointMin + P.largeEndpoint = P.c := by
  by_cases hab : P.a ≤ P.b
  · simpa [endpointMin, largeEndpoint, hab] using P.sum_eq
  · have hba : P.b ≤ P.a := Nat.le_of_not_ge hab
    simpa [endpointMin, largeEndpoint, hab, hba, Nat.add_comm] using P.sum_eq

/-- The larger summand is coprime to the sum. -/
theorem largeEndpoint_coprime_c (P : ABCPoint) :
    Nat.Coprime P.largeEndpoint P.c := by
  by_cases hab : P.a ≤ P.b
  · simpa [largeEndpoint, hab] using P.pairwise_coprime.2.1
  · have hba : P.b ≤ P.a := Nat.le_of_not_ge hab
    simpa [largeEndpoint, hab, hba] using P.pairwise_coprime.2.2.symm

/-- Canonical powerful modulus on the larger summand. -/
def canonicalLargePowerfulModulus (P : ABCPoint) : ℕ :=
  abcPowerfulPart P.largeEndpoint

/-- Canonical powerful modulus on the sum. -/
def canonicalSumPowerfulModulus (P : ABCPoint) : ℕ :=
  abcPowerfulPart P.c

/-- Canonical radical residual on the larger summand. -/
def canonicalLargeRadicalResidual (P : ABCPoint) : ℕ :=
  abcRadical P.largeEndpoint

/-- Canonical radical residual on the sum. -/
def canonicalSumRadicalResidual (P : ABCPoint) : ℕ :=
  abcRadical P.c

/-- The larger endpoint is its radical residual times its powerful modulus. -/
theorem canonicalLarge_factorization (P : ABCPoint) :
    P.canonicalLargePowerfulModulus * P.canonicalLargeRadicalResidual =
      P.largeEndpoint := by
  unfold canonicalLargePowerfulModulus canonicalLargeRadicalResidual
  rw [Nat.mul_comm, abcRadical_mul_abcPowerfulPart]

/-- The sum endpoint is its radical residual times its powerful modulus. -/
theorem canonicalSum_factorization (P : ABCPoint) :
    P.canonicalSumPowerfulModulus * P.canonicalSumRadicalResidual = P.c := by
  unfold canonicalSumPowerfulModulus canonicalSumRadicalResidual
  rw [Nat.mul_comm, abcRadical_mul_abcPowerfulPart]

/-- Canonical natural-number residual equation. -/
theorem canonical_residual_gap_nat (P : ABCPoint) :
    P.endpointMin +
        P.canonicalLargePowerfulModulus *
          P.canonicalLargeRadicalResidual =
      P.canonicalSumPowerfulModulus *
        P.canonicalSumRadicalResidual := by
  rw [P.canonicalLarge_factorization, P.canonicalSum_factorization]
  exact P.endpointMin_add_largeEndpoint_eq_c

/-- Canonical residual equation in the signed form used by the affine
parametrization. -/
theorem canonical_residual_gap_int (P : ABCPoint) :
    (P.canonicalSumPowerfulModulus : ℤ) *
          P.canonicalSumRadicalResidual -
        (P.canonicalLargePowerfulModulus : ℤ) *
          P.canonicalLargeRadicalResidual =
      (P.endpointMin : ℤ) := by
  have h := P.canonical_residual_gap_nat
  exact_mod_cast (show
    P.canonicalSumPowerfulModulus * P.canonicalSumRadicalResidual =
      P.endpointMin +
        P.canonicalLargePowerfulModulus *
          P.canonicalLargeRadicalResidual by omega)

/-- The radical always divides the original integer. -/
theorem abcRadical_dvd_self (n : ℕ) : abcRadical n ∣ n := by
  refine ⟨abcPowerfulPart n, ?_⟩
  exact abcRadical_mul_abcPowerfulPart n

/-- The powerful part always divides the original integer. -/
theorem abcPowerfulPart_dvd_self (n : ℕ) : abcPowerfulPart n ∣ n := by
  refine ⟨abcRadical n, ?_⟩
  simpa [Nat.mul_comm] using abcRadical_mul_abcPowerfulPart n

/-- The two canonical powerful moduli are coprime. -/
theorem canonicalPowerfulModuli_coprime (P : ABCPoint) :
    Nat.Coprime P.canonicalLargePowerfulModulus
      P.canonicalSumPowerfulModulus := by
  exact Nat.Coprime.of_dvd
    (abcPowerfulPart_dvd_self P.largeEndpoint)
    (abcPowerfulPart_dvd_self P.c)
    P.largeEndpoint_coprime_c

/-- The two canonical radical residuals are coprime. -/
theorem canonicalRadicalResiduals_coprime (P : ABCPoint) :
    Nat.Coprime P.canonicalLargeRadicalResidual
      P.canonicalSumRadicalResidual := by
  exact Nat.Coprime.of_dvd
    (abcRadical_dvd_self P.largeEndpoint)
    (abcRadical_dvd_self P.c)
    P.largeEndpoint_coprime_c

/-- The small summand is coprime to the larger summand. -/
theorem endpointMin_coprime_largeEndpoint (P : ABCPoint) :
    Nat.Coprime P.endpointMin P.largeEndpoint := by
  by_cases hab : P.a ≤ P.b
  · simpa [endpointMin, largeEndpoint, hab] using P.pairwise_coprime.1
  · have hba : P.b ≤ P.a := Nat.le_of_not_ge hab
    simpa [endpointMin, largeEndpoint, hab, hba] using
      P.pairwise_coprime.1.symm

/-- The small summand is coprime to the sum. -/
theorem endpointMin_coprime_c (P : ABCPoint) :
    Nat.Coprime P.endpointMin P.c := by
  by_cases hab : P.a ≤ P.b
  · simpa [endpointMin, hab] using P.pairwise_coprime.2.2.symm
  · have hba : P.b ≤ P.a := Nat.le_of_not_ge hab
    simpa [endpointMin, hab, hba] using P.pairwise_coprime.2.1

/-- The gap is coprime to the large radical residual. -/
theorem endpointMin_coprime_canonicalLargeResidual (P : ABCPoint) :
    Nat.Coprime P.endpointMin P.canonicalLargeRadicalResidual := by
  exact Nat.Coprime.of_dvd
    (dvd_refl P.endpointMin)
    (abcRadical_dvd_self P.largeEndpoint)
    P.endpointMin_coprime_largeEndpoint

/-- The gap is coprime to the sum radical residual. -/
theorem endpointMin_coprime_canonicalSumResidual (P : ABCPoint) :
    Nat.Coprime P.endpointMin P.canonicalSumRadicalResidual := by
  exact Nat.Coprime.of_dvd
    (dvd_refl P.endpointMin)
    (abcRadical_dvd_self P.c)
    P.endpointMin_coprime_c

/-- The large residual is squarefree. -/
theorem canonicalLargeResidual_squarefree (P : ABCPoint) :
    Squarefree P.canonicalLargeRadicalResidual := by
  unfold canonicalLargeRadicalResidual abcRadical
  exact UniqueFactorizationMonoid.squarefree_radical

/-- The sum residual is squarefree. -/
theorem canonicalSumResidual_squarefree (P : ABCPoint) :
    Squarefree P.canonicalSumRadicalResidual := by
  unfold canonicalSumRadicalResidual abcRadical
  exact UniqueFactorizationMonoid.squarefree_radical

/-- The prime support of the large powerful modulus is contained in the large
radical residual. -/
theorem radical_canonicalLargeModulus_dvd_residual (P : ABCPoint) :
    abcRadical P.canonicalLargePowerfulModulus ∣
      P.canonicalLargeRadicalResidual := by
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical]
  exact radical_dvd_radical
    (abcPowerfulPart_dvd_self P.largeEndpoint)
    P.largeEndpoint_pos.ne'

/-- The prime support of the sum powerful modulus is contained in the sum
radical residual. -/
theorem radical_canonicalSumModulus_dvd_residual (P : ABCPoint) :
    abcRadical P.canonicalSumPowerfulModulus ∣
      P.canonicalSumRadicalResidual := by
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical]
  exact radical_dvd_radical
    (abcPowerfulPart_dvd_self P.c)
    P.c_pos.ne'

end ABCPoint

#print axioms ABCPoint.endpointMin_add_largeEndpoint_eq_c
#print axioms ABCPoint.canonical_residual_gap_nat
#print axioms ABCPoint.canonical_residual_gap_int
#print axioms ABCPoint.canonicalPowerfulModuli_coprime
#print axioms ABCPoint.canonicalRadicalResiduals_coprime
#print axioms ABCPoint.endpointMin_coprime_canonicalLargeResidual
#print axioms ABCPoint.endpointMin_coprime_canonicalSumResidual
#print axioms ABCPoint.canonicalLargeResidual_squarefree
#print axioms ABCPoint.canonicalSumResidual_squarefree
#print axioms ABCPoint.radical_canonicalLargeModulus_dvd_residual
#print axioms ABCPoint.radical_canonicalSumModulus_dvd_residual

end
end CanonicalPowerfulResidualCore
end IUTThreeClosures
