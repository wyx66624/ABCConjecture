/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Symmetry-reduced scalar semantics for multiradial outputs

A literal union of all Ind2-permuted packet regions is not the same object as
the permutation quotient used by procession-normalized log-volume: even in a
finite counting model, each orbit member can have the same volume while their
union has larger volume.  This motivates a second formal semantics in which
Ind1/Ind2 are removed at the scalar-volume level and Ind3 is represented by a
one-sided inequality.

For a state type `State`, a `MultiradialScalarSystem` consists of

* three source relations `ind1`, `ind2`, `ind3`;
* a native state;
* a real procession-normalized volume;
* exact volume invariance for Ind1 and Ind2;
* monotonicity for Ind3.

The generated relation is the reflexive-transitive closure of these three
steps.  We prove that every generated state has volume at least the native
volume.  The canonical scalar possible-image volume is then the supremum of
all generated volumes.  Whenever this set is bounded above, it lies between
the native volume and every uniform source upper bound.

This gives the exact abstract shape needed by Corollary 3.12 and IUT IV without
forming a destructive set-level orbit union.  A genuine Theorem 3.11
formalization must still construct the state system, prove the three step
laws, prove boundedness, identify the native volume with `-|log q|`, and derive
the componentwise source upper bound.
-/

namespace IUTThreeClosures

universe u

/-- Source relations and their scalar procession-volume behavior. -/
structure MultiradialScalarSystem (State : Type u) where
  ind1 : State → State → Prop
  ind2 : State → State → Prop
  ind3 : State → State → Prop
  native : State
  volume : State → ℝ
  ind1_volume : ∀ {A B}, ind1 A B → volume A = volume B
  ind2_volume : ∀ {A B}, ind2 A B → volume A = volume B
  ind3_volume : ∀ {A B}, ind3 A B → volume A ≤ volume B

namespace MultiradialScalarSystem

variable {State : Type u}
variable (M : MultiradialScalarSystem State)

/-- One permitted multiradial operation. -/
inductive Step : State → State → Prop
  | ind1 {A B} : M.ind1 A B → Step A B
  | ind2 {A B} : M.ind2 A B → Step A B
  | ind3 {A B} : M.ind3 A B → Step A B

/-- Reflexive-transitive generation by Ind1, Ind2 and Ind3. -/
inductive Reachable : State → State → Prop
  | refl (A : State) : Reachable A A
  | tail {A B C : State} :
      Reachable A B →
      M.Step B C →
      Reachable A C

/-- Every individual source operation is nondecreasing at the scalar-volume
level; Ind1 and Ind2 are equality cases. -/
theorem volume_le_of_step
    {A B : State}
    (h : M.Step A B) :
    M.volume A ≤ M.volume B := by
  cases h with
  | ind1 h1 => exact (M.ind1_volume h1).le
  | ind2 h2 => exact (M.ind2_volume h2).le
  | ind3 h3 => exact M.ind3_volume h3

/-- Scalar volume is nondecreasing along every generated multiradial path. -/
theorem volume_le_of_reachable
    {A B : State}
    (h : M.Reachable A B) :
    M.volume A ≤ M.volume B := by
  induction h with
  | refl A => exact le_rfl
  | tail hreach hstep ih =>
      exact ih.trans (M.volume_le_of_step hstep)

/-- The set of all scalar volumes generated from the native state. -/
def reachableVolumes : Set ℝ :=
  {r | ∃ A : State, M.Reachable M.native A ∧ r = M.volume A}

/-- The native volume belongs to the generated volume set. -/
theorem nativeVolume_mem_reachableVolumes :
    M.volume M.native ∈ M.reachableVolumes :=
  ⟨M.native, M.Reachable.refl M.native, rfl⟩

/-- The generated volume set is nonempty. -/
theorem reachableVolumes_nonempty :
    M.reachableVolumes.Nonempty :=
  ⟨M.volume M.native, M.nativeVolume_mem_reachableVolumes⟩

/-- Every generated volume is at least the native volume. -/
theorem nativeVolume_le_of_mem_reachableVolumes
    {r : ℝ}
    (hr : r ∈ M.reachableVolumes) :
    M.volume M.native ≤ r := by
  rcases hr with ⟨A, hA, rfl⟩
  exact M.volume_le_of_reachable hA

/-- The symmetry-reduced possible-image volume: the supremum of all generated
scalar volumes. -/
noncomputable def thetaVolume : ℝ :=
  sSup M.reachableVolumes

/-- The native q-pilot volume is below the scalar theta volume whenever the
reachable volumes are bounded above. -/
theorem nativeVolume_le_thetaVolume
    (hbounded : BddAbove M.reachableVolumes) :
    M.volume M.native ≤ M.thetaVolume := by
  unfold thetaVolume
  exact le_csSup hbounded M.nativeVolume_mem_reachableVolumes

/-- Every uniform source upper bound controls the scalar theta volume. -/
theorem thetaVolume_le_of_uniform_bound
    {U : ℝ}
    (hU : ∀ {r : ℝ}, r ∈ M.reachableVolumes → r ≤ U) :
    M.thetaVolume ≤ U := by
  unfold thetaVolume
  exact csSup_le M.reachableVolumes_nonempty fun r hr => hU hr

/-- A source envelope predicate preserved by all three operations yields a
uniform upper bound on every reachable state. -/
theorem reachable_volume_le_of_invariant
    (Envelope : State → Prop)
    (U : ℝ)
    (hnative : Envelope M.native)
    (hind1 : ∀ {A B}, Envelope A → M.ind1 A B → Envelope B)
    (hind2 : ∀ {A B}, Envelope A → M.ind2 A B → Envelope B)
    (hind3 : ∀ {A B}, Envelope A → M.ind3 A B → Envelope B)
    (hvolume : ∀ {A}, Envelope A → M.volume A ≤ U)
    {A : State}
    (hA : M.Reachable M.native A) :
    M.volume A ≤ U := by
  have hEnvelope : Envelope A := by
    induction hA with
    | refl _ => exact hnative
    | tail hreach hstep ih =>
        cases hstep with
        | ind1 h1 => exact hind1 ih h1
        | ind2 h2 => exact hind2 ih h2
        | ind3 h3 => exact hind3 ih h3
  exact hvolume hEnvelope

/-- Complete scalar sandwich from a preserved source envelope. -/
theorem thetaVolume_sandwich_of_invariant
    (Envelope : State → Prop)
    (U : ℝ)
    (hnative : Envelope M.native)
    (hind1 : ∀ {A B}, Envelope A → M.ind1 A B → Envelope B)
    (hind2 : ∀ {A B}, Envelope A → M.ind2 A B → Envelope B)
    (hind3 : ∀ {A B}, Envelope A → M.ind3 A B → Envelope B)
    (hvolume : ∀ {A}, Envelope A → M.volume A ≤ U) :
    M.volume M.native ≤ M.thetaVolume ∧ M.thetaVolume ≤ U := by
  have hall : ∀ {r : ℝ}, r ∈ M.reachableVolumes → r ≤ U := by
    intro r hr
    rcases hr with ⟨A, hA, rfl⟩
    exact M.reachable_volume_le_of_invariant
      Envelope U hnative hind1 hind2 hind3 hvolume hA
  have hbounded : BddAbove M.reachableVolumes :=
    ⟨U, fun r hr => hall hr⟩
  exact ⟨M.nativeVolume_le_thetaVolume hbounded,
    M.thetaVolume_le_of_uniform_bound hall⟩

end MultiradialScalarSystem

end IUTThreeClosures
