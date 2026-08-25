/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.RingTheory.DiscreteValuationRing.TFAE
import Mathlib.RingTheory.RamificationInertia.Ramification

/-!
# A local power law determines the ramification index

This module isolates the local algebra implication needed after one has
constructed honest DVR local rings at the boundary of a cover.

## Mathematical proof

Let `R -> S` be a local homomorphism of discrete valuation rings.  Choose
uniformizers `t` of `R` and `x` of `S`, and suppose

`algebraMap R S t = u * x ^ n`

for a unit `u` of `S`.  In Mathlib's DVR API, uniformizers are represented by
irreducible elements.  Hence the maximal ideals are `(t)` and `(x)`.  Extending
the first ideal to `S` gives

`m_R S = (algebraMap R S t) = (u * x^n) = (x^n) = m_S^n`.

The normalized additive DVR valuation vanishes on `u` and sends `x` to one,
so it sends the image of `t` to `n`.  Moreover the powers of `m_S` are
strictly decreasing: equality of the `n`-th and `(n+1)`-st powers would force
their DVR colengths `n` and `n+1` to be equal.  Thus the ideal-factorization
ramification exponent is exactly `n`.  A local homomorphism makes `m_S` lie
over `m_R`; the standard comparison theorem for the ideal-factorization and
localized-length definitions then gives Mathlib's current
`Ideal.ramificationIdx` equal to `n`.

This is a generic local theorem.  It does not construct the projective Fermat
curve, its boundary local rings, or the required uniformizer hypotheses at
the fibres over `0`, `1`, and `infinity`.
-/

namespace IUTThreeClosures
namespace LocalPowerRamificationIndex

noncomputable section

open Ideal IsLocalRing

universe u v

/-! ## Exact normalized order -/

variable {A : Type u} {S : Type v}
variable [CommRing A]
variable [CommRing S] [IsDomain S] [IsDiscreteValuationRing S]

/-- If an element is a unit times the `n`-th power of a DVR uniformizer, its
normalized additive order is exactly `n`. -/
theorem addVal_eq_of_eq_unit_mul_uniformizer_pow
    (f : A →+* S) {t : A} {x : S} (hx : Irreducible x)
    (unit : Sˣ) (n : ℕ) (hpower : f t = unit * x ^ n) :
    IsDiscreteValuationRing.addVal S (f t) = n := by
  rw [hpower]
  exact IsDiscreteValuationRing.addVal_def' unit hx n

/-! ## Exact ideal power and ramification index -/

variable {R : Type u}
variable [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
variable [Algebra R S]

/-- The local power identity identifies the extended base maximal ideal with
the exact corresponding power of the upper maximal ideal. -/
theorem map_maximalIdeal_eq_pow
    {t : R} {x : S} (ht : Irreducible t) (hx : Irreducible x)
    (unit : Sˣ) (n : ℕ)
    (hpower : algebraMap R S t = unit * x ^ n) :
    (maximalIdeal R).map (algebraMap R S) = maximalIdeal S ^ n := by
  rw [ht.maximalIdeal_eq, Ideal.map_span, Set.image_singleton, hpower,
    Ideal.span_singleton_mul_left_unit unit.isUnit, hx.maximalIdeal_eq,
    Ideal.span_singleton_pow]

/-- Distinct consecutive powers of the maximal ideal of a DVR are never
equal.  This is the strictness needed by the exponent definition of
ramification. -/
theorem not_maximalIdeal_pow_le_succ (n : ℕ) :
    ¬ maximalIdeal S ^ n ≤ maximalIdeal S ^ (n + 1) := by
  intro hle
  have heq : maximalIdeal S ^ n = maximalIdeal S ^ (n + 1) :=
    le_antisymm hle (Ideal.pow_le_pow_right (Nat.le_succ n))
  have hheight := congrArg Order.coheight heq
  rw [IsDiscreteValuationRing.coheight_pow_maximalIdeal,
    IsDiscreteValuationRing.coheight_pow_maximalIdeal] at hheight
  have hnat : n = n + 1 := by
    simpa only [ENat.coe_inj] using hheight
  omega

/-- The ideal-factorization definition of the local ramification exponent is
exactly the exponent in the uniformizer power law. -/
theorem ramificationIdx'_eq_of_uniformizer_power
    {t : R} {x : S} (ht : Irreducible t) (hx : Irreducible x)
    (unit : Sˣ) (n : ℕ)
    (hpower : algebraMap R S t = unit * x ^ n) :
    (maximalIdeal R).ramificationIdx' (maximalIdeal S) = n := by
  apply Ideal.ramificationIdx'_spec
  · rw [map_maximalIdeal_eq_pow ht hx unit n hpower]
  · rw [map_maximalIdeal_eq_pow ht hx unit n hpower]
    exact not_maximalIdeal_pow_le_succ n

/-- For a local map of DVRs, a uniformizer power identity computes Mathlib's
localized-length ramification index itself, not merely an auxiliary order. -/
theorem ramificationIdx_eq_of_uniformizer_power
    [IsLocalHom (algebraMap R S)]
    {t : R} {x : S} (ht : Irreducible t) (hx : Irreducible x)
    (unit : Sˣ) (n : ℕ)
    (hpower : algebraMap R S t = unit * x ^ n) :
    (maximalIdeal S).ramificationIdx R = n := by
  letI : IsDedekindDomain S :=
    ((IsDiscreteValuationRing.TFAE S
      (IsDiscreteValuationRing.not_isField S)).out 0 2).mp
        (inferInstance : IsDiscreteValuationRing S)
  have hmap : (maximalIdeal R).map (algebraMap R S) ≠ ⊥ := by
    rw [map_maximalIdeal_eq_pow ht hx unit n hpower,
      hx.maximalIdeal_eq, Ideal.span_singleton_pow,
      ne_eq, Ideal.span_singleton_eq_bot]
    exact pow_ne_zero n hx.ne_zero
  calc
    (maximalIdeal S).ramificationIdx R =
        (maximalIdeal R).ramificationIdx' (maximalIdeal S) := by
      symm
      exact Ideal.ramificationIdx'_eq_ramificationIdx'
        (maximalIdeal R) (maximalIdeal S) hmap
    _ = n := ramificationIdx'_eq_of_uniformizer_power ht hx unit n hpower

/-- The three exact conclusions—valuation, extended ideal, and ramification
index—packaged together for direct use by a future boundary-local-ring
construction. -/
theorem local_power_law_exact_conclusions
    [IsLocalHom (algebraMap R S)]
    {t : R} {x : S} (ht : Irreducible t) (hx : Irreducible x)
    (unit : Sˣ) (n : ℕ)
    (hpower : algebraMap R S t = unit * x ^ n) :
    IsDiscreteValuationRing.addVal S (algebraMap R S t) = n ∧
      (maximalIdeal R).map (algebraMap R S) = maximalIdeal S ^ n ∧
      (maximalIdeal S).ramificationIdx R = n := by
  exact ⟨addVal_eq_of_eq_unit_mul_uniformizer_pow
      (algebraMap R S) hx unit n hpower,
    map_maximalIdeal_eq_pow ht hx unit n hpower,
    ramificationIdx_eq_of_uniformizer_power ht hx unit n hpower⟩

end

end LocalPowerRamificationIndex
end IUTThreeClosures
