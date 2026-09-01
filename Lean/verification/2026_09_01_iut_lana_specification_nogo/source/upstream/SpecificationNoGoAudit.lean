/-
Copyright (c) 2026. Released for independent specification auditing.
-/
import Iut.Cor312.Statement

/-!
# Audit of the low-resolution Corollary 3.12 record specification

This file is deliberately separate from the Project LANA source modules.  It proves
that the fields of the `RHSData` record at commit
`ddaddc274281adb5674d647e24fa478745ac6d40` cannot be simultaneously inhabited.
The obstruction is the unrestricted quantifier in
`LogVolumeData.componentVol_prime_preimage`: applying it to the empty set and the
prime `2` forces `Real.log 2 = 0`.

These theorems concern only this low-resolution record specification.  They do not
prove or disprove the published IUT III, Corollary 3.12, IUT, or the abc conjecture.
-/

namespace Iut

universe u v

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- The fields of the current low-resolution `RHSData` record are contradictory. -/
theorem rhsData_false (R : RHSData.{u, v} D) : False := by
  classical
  have hlength : R.container.proc.length = (D.ℓ - 1) / 2 := by
    rw [R.proc_standard]
    rfl
  have hfive : 5 ≤ D.ℓ := D.prime.five_le
  have hlength_pos : 0 < R.container.proc.length := by
    rw [hlength]
    omega
  let i : Fin R.container.proc.length := ⟨0, hlength_pos⟩
  let p : Nat.Primes := ⟨2, Nat.prime_two⟩
  have hweight := R.vol.weight_sum_one (RationalPlace.finite p)
  have hfiber : Nonempty (R.container.Fiber (RationalPlace.finite p)) := by
    by_contra h
    have hzero :
        (∑ w : R.container.Fiber (RationalPlace.finite p),
          R.vol.weight (RationalPlace.finite p) w) = 0 := by
      apply Finset.sum_eq_zero
      intro w _
      exact (h ⟨w⟩).elim
    linarith
  let w : R.container.Fiber (RationalPlace.finite p) := Classical.choice hfiber
  let c : R.container.Components i (RationalPlace.finite p) := fun _ => w
  have hscale :=
    R.vol.componentVol_prime_preimage i p c
      (∅ : Set ((R.container.packet i (RationalPlace.finite p)).Summand c))
  have hlog_zero : Real.log (2 : ℝ) = 0 := by
    simp only [Set.preimage_empty] at hscale
    dsimp [p] at hscale
    linarith
  have hlog_pos : 0 < Real.log (2 : ℝ) := Real.log_pos (by norm_num)
  linarith

/-- The current low-resolution `RHSData D` type has no inhabitants. -/
theorem rhsData_isEmpty : IsEmpty (RHSData.{u, v} D) :=
  ⟨rhsData_false⟩

/-- The assembled Corollary 3.12 variant data type has no inhabitants. -/
theorem corollary312VariantData_false
    (X : Corollary312VariantData.{u, v} AG TG) : False :=
  rhsData_false X.rhsData

/-- The assembled Corollary 3.12 variant data type is empty. -/
theorem corollary312VariantData_isEmpty :
    IsEmpty (Corollary312VariantData.{u, v} AG TG) :=
  ⟨corollary312VariantData_false⟩

/-- The universal target is true only by elimination from the empty input type. -/
theorem corollary312Variant_universal_vacuous :
    ∀ X : Corollary312VariantData.{u, v} AG TG, Corollary312Variant X :=
  fun X => (corollary312VariantData_false X).elim

#print axioms rhsData_false
#print axioms rhsData_isEmpty
#print axioms corollary312VariantData_false
#print axioms corollary312VariantData_isEmpty
#print axioms corollary312Variant_universal_vacuous

end Iut
