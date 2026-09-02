/-
Copyright (c) 2026. Released for independent specification auditing.
-/
import Iut.Concrete.LocalTheory

/-!
# Empty-set audit of `LocalTheory` at LANA commit `6e963070`

This detached audit applies the unrestricted real-valued scaling field to
the empty set.  It rejects only the exact `LocalTheory` interface at commit
`6e963070c73c5defd1012320deccc777e2555d22`; it does not reject a corrected
positive finite-volume interface, IUT, or the abc conjecture.
-/

namespace Iut

universe u v

theorem localTheory_false_latest
    (K : Type u) [Field K] [NumberField K]
    (LT : LocalTheory.{u, v} K) : False := by
  let p : Nat.Primes := ⟨2, Nat.prime_two⟩
  let c : Empty → Place K := fun x => nomatch x
  have h := LT.componentVol_prime_preimage p c
    (∅ : Set (LT.Tensor (.finite p) c))
  simp only [Set.preimage_empty] at h
  dsimp [p] at h
  have hlog : 0 < Real.log (2 : ℝ) := Real.log_pos (by norm_num)
  linarith

theorem localTheory_isEmpty_latest
    (K : Type u) [Field K] [NumberField K] :
    IsEmpty (LocalTheory.{u, v} K) :=
  ⟨localTheory_false_latest K⟩

#print axioms localTheory_false_latest
#print axioms localTheory_isEmpty_latest

end Iut
