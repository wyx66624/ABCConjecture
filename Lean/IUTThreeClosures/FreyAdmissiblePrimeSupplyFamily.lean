/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyInitialThetaAssembly
import IUTThreeClosures.PointwiseRealizationPrimeSupply

/-!
# The calibrated Frey admissible-prime supply family

Outside the explicit finite possible-CM locus, the existing arithmetic
selection theorem constructs a `FreyAdmissiblePrimeInput` above every natural
bound.  This module upgrades that result to the stronger `PrimeSupply`
interface: the prime may simultaneously avoid an arbitrary finite forbidden
set.

The supplied `PrimeSupply` then chooses a strictly increasing sequence of
actual Frey admissible-prime inputs.  Given a genuine
`FreyInitialThetaAssembly`, applying the assembler to this sequence gives a
strictly prime-indexed family of public `InitialThetaData` objects.  The stored
prime and source j-invariant are proved to remain calibrated at every index.

Thus no additional global family theorem is needed after the pointwise
assembler has been constructed.  The unresolved mathematics is precisely the
inhabitation of `FreyInitialThetaAssembly`, not a separate choice/coherence
problem for an infinite family.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u

private theorem finset_mem_le_sum
    (s : Finset ℕ) {n : ℕ} (hn : n ∈ s) :
    n ≤ s.sum id := by
  classical
  induction s using Finset.induction_on with
  | empty => simp at hn
  | @insert a s ha ih =>
      rw [Finset.sum_insert ha]
      simp only [Finset.mem_insert] at hn
      rcases hn with rfl | hn
      · exact Nat.le_add_right _ _
      · exact (ih hn).trans (Nat.le_add_left _ _)

/-- The fiber of arithmetic Frey prime inputs whose selected prime is exactly
`ell`. -/
def FreyAdmissiblePrimeFiber
    (S : RationalCMOpenImagePackage)
    (P : ABCPoint)
    (orders : Finset ℕ)
    (ell : ℕ) :=
  {I : FreyAdmissiblePrimeInput S P orders // I.ell = ell}

/-- The arithmetic Frey input theorem gives full prime supply: one can choose
arbitrarily large large-image primes while avoiding every additional finite
set. -/
theorem freyAdmissiblePrimeSupply
    (S : RationalCMOpenImagePackage)
    (P : ABCPoint)
    (hP : P ∉ freyCMExceptional)
    (orders : Finset ℕ)
    (horders : ∀ n ∈ orders, n ≠ 0) :
    PrimeSupply
      (fun ell => Nonempty (FreyAdmissiblePrimeFiber S P orders ell)) := by
  constructor
  intro B forbidden
  let M : ℕ := B + forbidden.sum id + 1
  obtain ⟨I, hMI⟩ :=
    FreyAdmissiblePrimeInput.exists_above
      S P hP M orders horders
  have hB : B < I.ell := by
    dsimp [M] at hMI
    omega
  have hAvoid : I.ell ∉ forbidden := by
    intro hmem
    have hle := finset_mem_le_sum forbidden hmem
    dsimp [M] at hMI
    omega
  exact ⟨I.ell, I.ell_prime, hB, hAvoid, ⟨⟨I, rfl⟩⟩⟩

namespace FreyAdmissiblePrimeSupply

variable (S : RationalCMOpenImagePackage)
variable (P : ABCPoint)
variable (hP : P ∉ freyCMExceptional)
variable (orders : Finset ℕ)
variable (horders : ∀ n ∈ orders, n ≠ 0)

/-- The canonical-by-choice strictly increasing prime sequence. -/
noncomputable def ellSequence : ℕ → ℕ :=
  (freyAdmissiblePrimeSupply S P hP orders horders).sequence

/-- Every selected index is prime. -/
theorem ellSequence_prime (n : ℕ) :
    Nat.Prime (ellSequence S P hP orders horders n) :=
  ((freyAdmissiblePrimeSupply S P hP orders horders).sequence_spec n).1

/-- Every selected prime has an actual calibrated Frey arithmetic input. -/
theorem ellSequence_fiber_nonempty (n : ℕ) :
    Nonempty
      (FreyAdmissiblePrimeFiber S P orders
        (ellSequence S P hP orders horders n)) :=
  ((freyAdmissiblePrimeSupply S P hP orders horders).sequence_spec n).2

/-- The selected prime sequence is strictly increasing. -/
theorem ellSequence_strictMono :
    StrictMono (ellSequence S P hP orders horders) :=
  (freyAdmissiblePrimeSupply S P hP orders horders).sequence_strictMono

/-- Choose the actual arithmetic input above one sequence index. -/
noncomputable def inputSequence
    (n : ℕ) : FreyAdmissiblePrimeInput S P orders :=
  (Classical.choice
    (ellSequence_fiber_nonempty S P hP orders horders n)).1

/-- The chosen input stores exactly the corresponding sequence prime. -/
theorem inputSequence_ell (n : ℕ) :
    (inputSequence S P hP orders horders n).ell =
      ellSequence S P hP orders horders n :=
  (Classical.choice
    (ellSequence_fiber_nonempty S P hP orders horders n)).2

end FreyAdmissiblePrimeSupply

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {S : RationalCMOpenImagePackage}

namespace FreyInitialThetaAssembly

variable (A : FreyInitialThetaAssembly S AG TG)
variable (P : ABCPoint)
variable (hP : P ∉ freyCMExceptional)

/-- The strictly increasing source-prime sequence attached to the actual
assembler. -/
noncomputable def sourceEllSequence : ℕ → ℕ :=
  FreyAdmissiblePrimeSupply.ellSequence
    S P hP (A.localOrders P) (A.localOrders_ne_zero P)

/-- The corresponding arithmetic inputs. -/
noncomputable def sourceInputSequence
    (n : ℕ) :
    FreyAdmissiblePrimeInput S P (A.localOrders P) :=
  FreyAdmissiblePrimeSupply.inputSequence
    S P hP (A.localOrders P) (A.localOrders_ne_zero P) n

/-- The public initial-theta family produced by the pointwise assembler. -/
noncomputable def initialThetaSequence
    (n : ℕ) : InitialThetaData AG TG :=
  A.assemble P hP (A.sourceInputSequence P hP n)

/-- The source-prime sequence is strictly increasing. -/
theorem sourceEllSequence_strictMono :
    StrictMono (A.sourceEllSequence P hP) :=
  FreyAdmissiblePrimeSupply.ellSequence_strictMono
    S P hP (A.localOrders P) (A.localOrders_ne_zero P)

/-- Each assembled initial-theta datum stores exactly its sequence prime. -/
theorem initialThetaSequence_ell (n : ℕ) :
    (A.initialThetaSequence P hP n).ℓ =
      A.sourceEllSequence P hP n := by
  calc
    (A.initialThetaSequence P hP n).ℓ =
        (A.sourceInputSequence P hP n).ell :=
      A.ell_calibration P hP (A.sourceInputSequence P hP n)
    _ = A.sourceEllSequence P hP n :=
      FreyAdmissiblePrimeSupply.inputSequence_ell
        S P hP (A.localOrders P) (A.localOrders_ne_zero P) n

/-- Every assembled source curve remains calibrated to the actual Frey
j-invariant. -/
theorem initialThetaSequence_j (n : ℕ) :
    (A.initialThetaSequence P hP n).E.j =
      algebraMap ℚ (A.initialThetaSequence P hP n).F
        (abcFreyCurve P).j :=
  A.j_calibration P hP (A.sourceInputSequence P hP n)

/-- Each assembled source prime is prime. -/
theorem initialThetaSequence_prime (n : ℕ) :
    Nat.Prime (A.initialThetaSequence P hP n).ℓ := by
  rw [A.initialThetaSequence_ell P hP n]
  exact FreyAdmissiblePrimeSupply.ellSequence_prime
    S P hP (A.localOrders P) (A.localOrders_ne_zero P) n

end FreyInitialThetaAssembly

end IUTThreeClosures
