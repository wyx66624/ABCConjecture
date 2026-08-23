/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ValuationSectionNormalization
import Mathlib.Analysis.AbsoluteValue.Equivalence
import Mathlib.NumberTheory.RamificationInertia.Valuation

/-!
# Place-theoretic valuation sections

A finite place is an equivalence class of nontrivial absolute values, not a single
global normalization.  If `w` lies over `v` in the ideal-theoretic sense, the
restriction of the normalized absolute value at `w` is generally a positive power
of the normalized absolute value at `v`.  It is nevertheless equivalent to `v`.

This file proves that statement from Mathlib's ramification formula and packages an
always-inhabited section using `AbsoluteValue.IsEquiv`.  It is the place-theoretic
version of the ideal-contraction repair in `ValuationSectionNormalization`.
-/

namespace IUTThreeClosures

open NumberField

universe u v

variable {k : Type u} {K : Type v}
variable [Field k] [NumberField k] [Field K] [NumberField K] [Algebra k K]

/-- A finite place of `K` lies over a finite place of `k` as a *place* when the
restricted absolute value is equivalent to the base absolute value. -/
def FinitePlaceEquivalentLiesOver
    (w : FinitePlace K) (v : FinitePlace k) : Prop :=
  (w.1.comp (algebraMap k K).injective).IsEquiv v.1

/-- Ideal-theoretic lying-over implies equivalence of the restricted finite
absolute value with the base absolute value.

The proof uses

`valuation_w(x) = valuation_v(x) ^ e(w/v)`

and positivity of the ramification index.  Passing from the discrete valuations
to Mathlib's normalized real absolute values preserves the `< 1` relation, which
characterizes equivalence of nonarchimedean absolute values. -/
theorem finitePlaceEquivalentLiesOver_of_ideal
    (v : FinitePlace k) (w : FinitePlace K)
    (h : FiniteIdealLiesOver w v) :
    FinitePlaceEquivalentLiesOver w v := by
  letI : w.maximalIdeal.asIdeal.LiesOver v.maximalIdeal.asIdeal :=
    ⟨h.symm⟩
  rw [FinitePlaceEquivalentLiesOver,
    AbsoluteValue.isEquiv_iff_lt_one_iff]
  intro x
  change w (algebraMap k K x) < 1 ↔ v x < 1
  rw [← FinitePlace.norm_embedding_eq w,
    ← FinitePlace.norm_embedding_eq v,
    FinitePlace.norm_embedding,
    FinitePlace.norm_embedding,
    NumberField.HeightOneSpectrum.adicAbv_def,
    NumberField.HeightOneSpectrum.adicAbv_def]
  norm_cast
  rw [WithZeroMulInt.toNNReal_lt_one_iff
      (NumberField.HeightOneSpectrum.one_lt_absNorm_nnreal w.maximalIdeal),
    WithZeroMulInt.toNNReal_lt_one_iff
      (NumberField.HeightOneSpectrum.one_lt_absNorm_nnreal v.maximalIdeal),
    ← IsDedekindDomain.HeightOneSpectrum.valuation_liesOver
      K v.maximalIdeal w.maximalIdeal x,
    pow_lt_one_iff
      (Ideal.IsDedekindDomain.ramificationIdx'_ne_zero_of_liesOver
        w.maximalIdeal.asIdeal v.maximalIdeal.ne_bot)]

/-- Literal equality after restriction is a special case of equivalence after
restriction. -/
theorem finitePlaceEquivalentLiesOver_of_absoluteValueLiesOver
    (v : FinitePlace k) (w : FinitePlace K)
    (h : w.1.LiesOver v.1) :
    FinitePlaceEquivalentLiesOver w v :=
  finitePlaceEquivalentLiesOver_of_ideal v w
    (finiteIdealLiesOver_of_absoluteValueLiesOver v w h)

/-- A section of places in the mathematically invariant sense: finite absolute
values need only be equivalent after restriction, while infinite places retain
exact restriction. -/
structure EquivalentValuationSection (k : Type u) (K : Type v)
    [Field k] [NumberField k] [Field K] [NumberField K] [Algebra k K] :
    Type (max u v) where
  sectFin : FinitePlace k → FinitePlace K
  sectInf : InfinitePlace k → InfinitePlace K
  sectFin_liesOver : ∀ v, FinitePlaceEquivalentLiesOver (sectFin v) v
  sectInf_liesOver : ∀ v, (sectInf v).1.LiesOver v.1

/-- An ideal-theoretic section canonically determines a place-theoretic section. -/
noncomputable def IdealValuationSection.toEquivalent
    (S : IdealValuationSection k K) : EquivalentValuationSection k K where
  sectFin := S.sectFin
  sectInf := S.sectInf
  sectFin_liesOver v :=
    finitePlaceEquivalentLiesOver_of_ideal v (S.sectFin v)
      (S.sectFin_liesOver v)
  sectInf_liesOver := S.sectInf_liesOver

/-- Every extension of number fields admits a section of places when finite
places are compared up to equivalence rather than an incompatible global
normalization. -/
theorem nonempty_equivalentValuationSection :
    Nonempty (EquivalentValuationSection k K) := by
  obtain ⟨S⟩ := nonempty_idealValuationSection (k := k) (K := K)
  exact ⟨S.toEquivalent⟩

end IUTThreeClosures
