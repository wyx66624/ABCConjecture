/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Iut.Cor312.ThetaData.LocalConditions

/-!
# The normalization seam in valuation sections

`Iut.ValuationSection` asks a finite place of an extension field to lie over a
finite place of the base field through `AbsoluteValue.LiesOver`.  That relation
means literal equality of the two normalized absolute values after restriction.
For number fields this is stronger than the usual arithmetic lying-over
relation: if a prime has ramification index `e` and residue degree `f`, the
normalized absolute value upstairs restricts to the `e * f`-th power of the
normalized absolute value downstairs.

This file isolates the source-independent repair.

* `FiniteIdealLiesOver` uses contraction of maximal ideals, the usual finite-place
  relation.
* strict `AbsoluteValue.LiesOver` implies `FiniteIdealLiesOver`;
* every finite place has an ideal-theoretic extension by going-up;
* every infinite place has an extension by extension of complex embeddings;
* consequently the corrected mixed finite/infinite valuation section is always
  inhabited for an extension of number fields.

No anabelian, theta, Hodge-theater, or abc statement is assumed.
-/

namespace IUTThreeClosures

open NumberField

universe u v

variable {k : Type u} {K : Type v}
variable [Field k] [NumberField k] [Field K] [NumberField K] [Algebra k K]

/-- The usual arithmetic lying-over relation for finite places: the maximal
ideal upstairs contracts to the maximal ideal downstairs. -/
def FiniteIdealLiesOver (w : FinitePlace K) (v : FinitePlace k) : Prop :=
  w.maximalIdeal.asIdeal.comap (algebraMap (𝓞 k) (𝓞 K)) =
    v.maximalIdeal.asIdeal

/-- Literal equality of the normalized absolute values after restriction implies
ideal-theoretic lying over.  The converse is generally false when the local
degree is greater than one. -/
theorem finiteIdealLiesOver_of_absoluteValueLiesOver
    (v : FinitePlace k) (w : FinitePlace K)
    (h : w.1.LiesOver v.1) : FiniteIdealLiesOver w v := by
  letI : w.1.LiesOver v.1 := h
  apply Ideal.ext
  intro x
  change algebraMap (𝓞 k) (𝓞 K) x ∈ w.maximalIdeal.asIdeal ↔
    x ∈ v.maximalIdeal.asIdeal
  rw [← FinitePlace.norm_lt_one_iff_mem K w.maximalIdeal,
    ← FinitePlace.norm_lt_one_iff_mem k v.maximalIdeal]
  rw [FinitePlace.norm_embedding_eq, FinitePlace.norm_embedding_eq]
  have hx :
      w (algebraMap (𝓞 K) K (algebraMap (𝓞 k) (𝓞 K) x)) =
        v (algebraMap (𝓞 k) k x) := by
    change w (algebraMap k K (x : k)) = v (x : k)
    have hcomp : w.1.comp (algebraMap k K).injective = v.1 :=
      AbsoluteValue.LiesOver.comp_eq w.1 v.1
    simpa using congrArg (fun a : AbsoluteValue k ℝ => a (x : k)) hcomp
  rw [hx]

/-- Every finite place of the base number field has an extension in the usual
ideal-theoretic sense. -/
theorem exists_finiteIdealLiesOver (v : FinitePlace k) :
    ∃ w : FinitePlace K, FiniteIdealLiesOver w v := by
  classical
  let p : Ideal (𝓞 k) := v.maximalIdeal.asIdeal
  letI : p.IsPrime := by
    dsimp [p]
    exact v.maximalIdeal.isPrime
  have hker : RingHom.ker (algebraMap (𝓞 k) (𝓞 K)) ≤ p := by
    rw [NumberField.RingOfIntegers.ker_algebraMap_eq_bot k K]
    exact bot_le
  obtain ⟨q, hqPrime, hqComap⟩ :=
    Ideal.exists_ideal_over_prime_of_isIntegral_of_isDomain p hker
  have hqNeBot : q ≠ ⊥ := by
    intro hqBot
    have hpBot : p = ⊥ := by
      calc
        p = q.comap (algebraMap (𝓞 k) (𝓞 K)) := hqComap.symm
        _ = (⊥ : Ideal (𝓞 K)).comap (algebraMap (𝓞 k) (𝓞 K)) := by rw [hqBot]
        _ = RingHom.ker (algebraMap (𝓞 k) (𝓞 K)) :=
          (RingHom.ker_eq_comap_bot (algebraMap (𝓞 k) (𝓞 K))).symm
        _ = ⊥ := NumberField.RingOfIntegers.ker_algebraMap_eq_bot k K
    exact v.maximalIdeal.ne_bot (by simpa [p] using hpBot)
  let qHeight : IsDedekindDomain.HeightOneSpectrum (𝓞 K) :=
    ⟨q, hqPrime, hqNeBot⟩
  refine ⟨FinitePlace.mk qHeight, ?_⟩
  simpa [FiniteIdealLiesOver, p, qHeight] using hqComap

/-- A corrected section of all places of a number-field extension.  Finite
places use contraction of prime ideals; infinite places retain literal
restriction of absolute values, which agrees with extension of embeddings. -/
structure IdealValuationSection (k : Type u) (K : Type v)
    [Field k] [NumberField k] [Field K] [NumberField K] [Algebra k K] :
    Type (max u v) where
  sectFin : FinitePlace k → FinitePlace K
  sectInf : InfinitePlace k → InfinitePlace K
  sectFin_liesOver : ∀ v, FiniteIdealLiesOver (sectFin v) v
  sectInf_liesOver : ∀ v, (sectInf v).1.LiesOver v.1

/-- The corrected valuation section is always inhabited for an extension of
number fields. -/
theorem nonempty_idealValuationSection :
    Nonempty (IdealValuationSection k K) := by
  classical
  let sf : FinitePlace k → FinitePlace K := fun v =>
    Classical.choose (exists_finiteIdealLiesOver (K := K) v)
  let si : InfinitePlace k → InfinitePlace K := fun v =>
    Classical.choose (InfinitePlace.comap_surjective (K := K) v)
  refine ⟨{
    sectFin := sf
    sectInf := si
    sectFin_liesOver := ?_
    sectInf_liesOver := ?_ }⟩
  · intro v
    exact Classical.choose_spec (exists_finiteIdealLiesOver (K := K) v)
  · intro v
    have hv : (si v).comap (algebraMap k K) = v :=
      Classical.choose_spec (InfinitePlace.comap_surjective (K := K) v)
    refine ⟨?_⟩
    simpa [si] using congrArg Subtype.val hv

end IUTThreeClosures
