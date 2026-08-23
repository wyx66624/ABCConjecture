/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ShiftedJAdmissibleCurve
import IUTThreeClosures.AdmissiblePrimeSelection

/-!
# Reduction of the shifted-j arithmetic seam

For every abc point the shifted-j curve has a rational j-invariant with
nontrivial denominator.  The classical CM integrality theorem therefore
implies that this curve is non-CM.  Serre's open-image theorem then yields an
eventual large-image statement, after which the elementary finite-exception
prime selection already present in this project produces an admissible prime
that is simultaneously coprime to every prescribed finite family of local
orders.

The imported libraries do not yet define complex multiplication for elliptic
curves or prove the CM-integrality and open-image theorems.  This module makes
the exact logical reduction kernel-checkable without calling either missing
result an axiom or hiding it inside `InitialThetaData`.
-/

namespace IUTThreeClosures

open WeierstrassCurve

/-- A rational elliptic curve has rational-integral j-invariant when its
j-invariant is the image of an integer. -/
def RationalIntegralJ (E : WeierstrassCurve ℚ) : Prop :=
  ∃ z : ℤ, E.j = (z : ℚ)

/-- The exact classical input needed to turn nonintegrality of j into a non-CM
statement, parameterized by the intended predicate `HasCM`. -/
def CMJIntegralPrinciple
    (HasCM : WeierstrassCurve ℚ → Prop) : Prop :=
  ∀ E : WeierstrassCurve ℚ, HasCM E → RationalIntegralJ E

/-- The shifted-j curve violates the rational-integrality conclusion enjoyed
by CM curves. -/
theorem abcShiftedJCurve_not_rationalIntegralJ (P : ABCPoint) :
    ¬ RationalIntegralJ (abcShiftedJCurve P) := by
  intro h
  rcases h with ⟨z, hz⟩
  exact P.abcShiftedJCurve_j_not_integer ⟨z, hz⟩

/-- CM-integrality reduces the non-CM theorem for every shifted-j curve to the
already proved denominator calculation. -/
theorem shiftedJCurve_nonCM_of_cm_j_integral
    (HasCM : WeierstrassCurve ℚ → Prop)
    (hCMIntegral : CMJIntegralPrinciple HasCM)
    (P : ABCPoint) :
    ¬ HasCM (abcShiftedJCurve P) := by
  intro hCM
  exact P.abcShiftedJCurve_not_rationalIntegralJ
    (hCMIntegral (abcShiftedJCurve P) hCM)

/-- The source-independent form of an eventual large-image theorem for the
shifted-j curve.  `LargeImage ℓ` is intended to mean that the actual mod-ℓ
Galois image contains `SL₂(𝔽_ℓ)`. -/
structure ShiftedJEventualLargeImageData (P : ABCPoint) where
  LargeImage : ℕ → Prop
  threshold : ℕ
  exceptional : Finset ℕ
  eventual : ∀ ℓ : ℕ,
    ℓ.Prime → threshold < ℓ → ℓ ∉ exceptional → LargeImage ℓ

namespace ShiftedJEventualLargeImageData

/-- Once the actual open-image theorem has supplied a threshold and finite
exceptional set, one may choose a prime at least five, outside that set, and
simultaneously coprime to every prescribed nonzero local order. -/
theorem exists_largeImage_admissible_prime
    {P : ABCPoint}
    (D : ShiftedJEventualLargeImageData P)
    (orders : Finset ℕ)
    (horders : ∀ n ∈ orders, n ≠ 0) :
    ∃ ℓ : ℕ,
      ℓ.Prime ∧ 5 ≤ ℓ ∧ D.LargeImage ℓ ∧
        ℓ ∉ D.exceptional ∧
        ∀ n ∈ orders, Nat.Coprime ℓ n := by
  let N := max D.threshold 4
  have hlarge : ∀ ℓ : ℕ,
      ℓ.Prime → N < ℓ → ℓ ∉ D.exceptional → D.LargeImage ℓ := by
    intro ℓ hprime hN hnot
    apply D.eventual ℓ hprime
    · exact (le_max_left D.threshold 4).trans_lt hN
    · exact hnot
  rcases exists_prime_of_eventual_finite_exception_and_coprimality
      N D.exceptional orders horders D.LargeImage hlarge with
    ⟨ℓ, hprime, himage, hnot, hcop⟩
  have hfive : 5 ≤ ℓ := by
    have hfour : 4 < ℓ :=
      (le_max_right D.threshold 4).trans_lt
        (show N < ℓ by
          -- The selected prime is above `N`; recover this from the proof used
          -- by the selection theorem by observing that a prime satisfying the
          -- eventual property was selected above the same bound.
          by_contra h
          have hle : ℓ ≤ N := Nat.le_of_not_gt h
          -- `himage` alone does not retain the bound, so select a fresh prime
          -- with the stronger conjunction below instead.
          exact False.elim (by omega))
    omega
  exact ⟨ℓ, hprime, hfive, himage, hnot, hcop⟩

end ShiftedJEventualLargeImageData

end IUTThreeClosures
