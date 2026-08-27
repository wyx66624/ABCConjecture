/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCStatement
import Mathlib.Data.Nat.Squarefree
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.NormNum.Parity
import Mathlib.Tactic.Ring

/-!
# The moving-squarefree generalized-Pythagorean abc interface

This file records the algebraic and scalar parts of the exact reduction
audited in `GLOBAL_ABC_MOVING_D_PYTHAGOREAN_EQUIVALENCE_AUDIT.md`.

It deliberately does **not** assert the conjectural critical estimate.  The
definition `UniformGeneralizedPythagoreanCriticalBound` is an interface for
which no inhabitant is supplied or assumed here, and the accompanying paper
audit proves that uniformly inhabiting it is equivalent to proving
`ABCConjecture`.
-/

namespace IUTThreeClosures

section MovingDPythagorean

/-- The abc-ready notion of primitivity for `X^2 + D*Y^2 = Z^2`.

The condition is placed on `X` and `D*Y`, rather than merely on the three
coordinates, because it is exactly what is needed to make
`(X^2, D*Y^2, Z^2)` a primitive abc triple. -/
def PrimitiveGeneralizedPythagorean
    (D X Y Z : ℕ) : Prop :=
  X ^ 2 + D * Y ^ 2 = Z ^ 2 ∧ Nat.Coprime X (D * Y)

/-- The conjectural coefficient-one estimate on all positive primitive
generalized Pythagorean triples with moving squarefree coefficient. -/
def UniformGeneralizedPythagoreanCriticalBound : Prop :=
  ∀ ε : ℝ, 0 < ε →
    ∃ C : ℝ, ∀ D X Y Z : ℕ,
      0 < D → 0 < X → 0 < Y → 0 < Z →
      Squarefree D → PrimitiveGeneralizedPythagorean D X Y Z →
      2 * Real.log (Z : ℝ) ≤
        (1 + ε) * Real.log (abcRadical (D * X * Y * Z) : ℝ) + C

/-- The moving-squarebase identity before parity normalization. -/
theorem movingDPythagorean_identity (A B u v : ℤ) :
    (A * u ^ 2 - B * v ^ 2) ^ 2 +
        (A * B) * (2 * u * v) ^ 2 =
      (A * u ^ 2 + B * v ^ 2) ^ 2 := by
  ring

/-- Division by either admissible parity factor (`delta = 1` or `2`) does
not change the generalized-Pythagorean identity.  This rational statement
isolates the algebra from the separate integrality and parity ledger. -/
theorem movingDPythagorean_scaled_identity
    (A B u v δ : ℚ) (hδ : δ ≠ 0) :
    ((A * u ^ 2 - B * v ^ 2) / δ) ^ 2 +
        (A * B) * ((2 * u * v) / δ) ^ 2 =
      ((A * u ^ 2 + B * v ^ 2) / δ) ^ 2 := by
  field_simp [hδ]
  ring

/-- A primitive generalized-Pythagorean equation in the abc-ready sense
produces a pairwise-coprime abc triple.  Squarefreeness of `D` is not needed
for this implication because it has already been built into the strong
primitivity condition `Coprime X (D*Y)`. -/
theorem generalizedPythagorean_target_pairwise
    {D X Y Z : ℕ}
    (h : PrimitiveGeneralizedPythagorean D X Y Z) :
    PairwiseCoprimeABC (X ^ 2) (D * Y ^ 2) (Z ^ 2) := by
  rcases h with ⟨heq, hcop⟩
  have hpow : Nat.Coprime (X ^ 2) ((D * Y) ^ 2) :=
    hcop.pow 2 2
  have hdvd : D * Y ^ 2 ∣ (D * Y) ^ 2 := by
    refine ⟨D, ?_⟩
    ring
  have hab : Nat.Coprime (X ^ 2) (D * Y ^ 2) :=
    hpow.coprime_dvd_right hdvd
  have hbc : Nat.Coprime (D * Y ^ 2) (Z ^ 2) := by
    rw [← heq]
    exact Nat.coprime_add_self_right.mpr hab.symm
  have hca : Nat.Coprime (Z ^ 2) (X ^ 2) := by
    rw [← heq]
    exact Nat.coprime_self_add_left.mpr hab.symm
  exact ⟨hab, hbc, hca⟩

/-- The common prime-support factor `A*B*u*v` divides `a*b` whenever
`a=A*u^2` and `b=B*v^2`. -/
theorem squarebaseSupportFactor_dvd_product
    {a b A B u v : ℕ}
    (ha : a = A * u ^ 2) (hb : b = B * v ^ 2) :
    (A * B) * (u * v) ∣ a * b := by
  refine ⟨u * v, ?_⟩
  rw [ha, hb]
  ring

/-- A divisor of the difference of a coprime pair is coprime to every
factor supported on their product.  This is the prime-support core of both
parity cases in the moving-`D` construction. -/
theorem divisorOfDifference_coprime_supportFactor
    {a b X M : ℕ}
    (hba : b ≤ a) (hab : Nat.Coprime a b)
    (hX : X ∣ a - b) (hM : M ∣ a * b) :
    Nat.Coprime X M := by
  have hda : Nat.Coprime (a - b) a :=
    (Nat.coprime_self_sub_left hba).mpr hab.symm
  have hdb : Nat.Coprime (a - b) b :=
    (Nat.coprime_sub_self_left hba).mpr hab
  have hdab : Nat.Coprime (a - b) (a * b) :=
    hda.mul_right hdb
  exact (hdab.coprime_dvd_left hX).coprime_dvd_right hM

/-- Odd--odd normalization: if `a-b=2*X`, then the normalized coordinate
`X` is coprime to `D*Y=(A*B)*(u*v)`. -/
theorem movingDPythagorean_oddOdd_primitive
    {a b A B u v X : ℕ}
    (hba : b ≤ a) (hab : Nat.Coprime a b)
    (ha : a = A * u ^ 2) (hb : b = B * v ^ 2)
    (hX : a - b = 2 * X) :
    Nat.Coprime X ((A * B) * (u * v)) := by
  have hXdvd : X ∣ a - b := by
    refine ⟨2, ?_⟩
    simpa [mul_comm] using hX
  exact divisorOfDifference_coprime_supportFactor hba hab hXdvd
    (squarebaseSupportFactor_dvd_product ha hb)

/-- Opposite-parity normalization: the difference is odd, so adjoining the
fixed factor `2` to `D*Y` preserves primitivity. -/
theorem movingDPythagorean_oppositeParity_primitive
    {a b A B u v X : ℕ}
    (hba : b ≤ a) (hab : Nat.Coprime a b)
    (ha : a = A * u ^ 2) (hb : b = B * v ^ 2)
    (hX : a - b = X) (hXtwo : Nat.Coprime X 2) :
    Nat.Coprime X ((A * B) * (2 * u * v)) := by
  have hXM : Nat.Coprime X ((A * B) * (u * v)) := by
    apply divisorOfDifference_coprime_supportFactor hba hab
    · exact hX ▸ dvd_refl X
    · exact squarebaseSupportFactor_dvd_product ha hb
  have htwoM : Nat.Coprime X (2 * ((A * B) * (u * v))) :=
    hXtwo.mul_right hXM
  simpa [mul_assoc, mul_comm, mul_left_comm] using htwoM

/-- Without the squarefree restriction on `D`, coordinate primitivity is
not an abc-ready replacement for `Coprime X (D*Y)`: `2^2+12*1^2=4^2`,
yet `(4,12,16)` is not primitive. -/
theorem weakCoordinatePrimitive_not_sufficient_without_squarefree :
    2 ^ 2 + 12 * 1 ^ 2 = 4 ^ 2 ∧
      Nat.gcd 2 (Nat.gcd 1 4) = 1 ∧
      ¬ Nat.Coprime 2 (12 * 1) := by
  norm_num [Nat.Coprime]

/-- The scalar heart of the converse moving-`D` transfer.  The hypotheses
encode `2H-kZ <= 2L`, `N <= R+H+kR`, and the target critical estimate.
The conclusion displays the exact surviving coefficient `1-eta`. -/
theorem generalizedPythagoreanCritical_scalar_transfer
    (H R N L η C kZ kR : ℝ)
    (hη : 0 ≤ η)
    (hZlower : 2 * H - kZ ≤ 2 * L)
    (hNupper : N ≤ R + H + kR)
    (hcritical : 2 * L ≤ (1 + η) * N + C) :
    (1 - η) * H ≤
      (1 + η) * R + C + kZ + (1 + η) * kR := by
  have hone : 0 ≤ 1 + η := by linarith
  have hscaled := mul_le_mul_of_nonneg_left hNupper hone
  nlinarith

/-- The exact parameter substitution for the moving-`D` converse. -/
theorem generalizedPythagorean_eta_rescaling (ε : ℝ) (hε : 0 < ε) :
    let η := ε / (2 + ε)
    0 < η ∧ η < 1 ∧ 0 < 1 - η ∧
      (1 + η) / (1 - η) = 1 + ε := by
  dsimp only
  have hden : 0 < 2 + ε := by linarith
  have hηpos : 0 < ε / (2 + ε) := div_pos hε hden
  have hηlt : ε / (2 + ε) < (1 : ℝ) := by
    rw [div_lt_iff₀ hden]
    linarith
  have hgap : 0 < 1 - ε / (2 + ε) := by
    linarith
  refine ⟨hηpos, hηlt, hgap, ?_⟩
  field_simp [ne_of_gt hden, ne_of_gt hgap]
  ring

end MovingDPythagorean

end IUTThreeClosures
