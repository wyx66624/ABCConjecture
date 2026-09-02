/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Genl.GeneralPosition.HeightTheory
import IUTThreeClosures.ABCStatement
import IUTThreeClosures.IUTCorrectedVolumeHolonomy20260901

/-!
# An admissible log-volume repair and a concrete `StatementI` bridge

The mathematical proofs precede this formalization in
`research/ABC_IUT_ADMISSIBLE_VOLUME_INTEGER_BRIDGE_2026_09_01.md`.

The first part gives an explicit proof-carrying replacement for the inconsistent
total real-valued set-volume law. Regions have actual, injectively represented,
nonempty carriers and are closed under the required preimage. The existing
`ℚ_[p]` valuation balls instantiate this interface.

The second part decomposes the missing implication from
`Genl.HeightTheory.StatementI` to this repository's integer `ABCConjecture`
into a degree-at-most-one tripod encoding and two uniform bounded-error
comparisons.
No term of this comparison package is asserted for the intended arithmetic
height theory.

This is a new audit interface. It is not identified with Mochizuki's IUT or
with Project LANA's `LocalTheory`.
-/

namespace IUTThreeClosures
namespace IUTAdmissibleVolumeIntegerBridge20260901

open IUTCorrectedVolumeHolonomy20260901

universe u v

/-! ## An extensional nonempty admissible-region interface -/

/-- A proof-carrying domain for a real log-volume preimage law.

`carrier_injective` makes the volume extensional in the represented set;
`carrier_nonempty` excludes the empty-set fixed point; and `preimage` together
with `carrier_preimage` supplies closure of the admissible domain. -/
structure AdmissiblePreimageLogVolume
    (α : Type u) (scale : α → α) (shift : ℝ) where
  Region : Type v
  region_nonempty : Nonempty Region
  carrier : Region → Set α
  carrier_injective : Function.Injective carrier
  carrier_nonempty : ∀ U, (carrier U).Nonempty
  preimage : Region → Region
  carrier_preimage : ∀ U, carrier (preimage U) = scale ⁻¹' carrier U
  logVolume : Region → ℝ
  logVolume_preimage : ∀ U,
    logVolume (preimage U) = logVolume U + shift

namespace AdmissiblePreimageLogVolume

variable {α : Type u} {scale : α → α} {shift : ℝ}
variable (V : AdmissiblePreimageLogVolume.{u, v} α scale shift)

/-- No represented admissible region has empty carrier. -/
theorem carrier_ne_empty (U : V.Region) : V.carrier U ≠ ∅ := by
  intro hempty
  apply Set.not_nonempty_empty
  rw [← hempty]
  exact V.carrier_nonempty U

/-- Equal represented carriers have equal log-volumes. This is the explicit
extensionality consequence of the injective carrier representation. -/
theorem logVolume_eq_of_carrier_eq {U W : V.Region}
    (hcarrier : V.carrier U = V.carrier W) :
    V.logVolume U = V.logVolume W := by
  exact congrArg V.logVolume (V.carrier_injective hcarrier)

/-- A nonzero log shift forbids a fixed admissible region. -/
theorem preimage_ne_of_shift_ne_zero (hshift : shift ≠ 0) (U : V.Region) :
    V.preimage U ≠ U := by
  intro hfixed
  have hvolume := V.logVolume_preimage U
  rw [hfixed] at hvolume
  apply hshift
  linarith

/-- Iterated preimage adds the corresponding natural multiple of the shift. -/
theorem logVolume_iterate (n : ℕ) (U : V.Region) :
    V.logVolume ((V.preimage^[n]) U) =
      V.logVolume U + (n : ℝ) * shift := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [Function.iterate_succ_apply', V.logVolume_preimage, ih]
      push_cast
      ring

/-- A positive iterate cannot return to its starting region when the shift is
nonzero. -/
theorem iterate_ne_of_pos_of_shift_ne_zero
    (hshift : shift ≠ 0) {n : ℕ} (hn : 0 < n) (U : V.Region) :
    (V.preimage^[n]) U ≠ U := by
  intro hperiodic
  have hvolume := congrArg V.logVolume hperiodic
  rw [V.logVolume_iterate, add_eq_left] at hvolume
  have hnreal : (n : ℝ) ≠ 0 := by exact_mod_cast hn.ne'
  exact (mul_ne_zero hnreal hshift) hvolume

/-- Every forward orbit is injectively indexed by `ℕ` when the shift is
nonzero. -/
theorem iterate_injective (hshift : shift ≠ 0) (U : V.Region) :
    Function.Injective (fun n : ℕ => (V.preimage^[n]) U) := by
  intro m n heq
  have hvolume := congrArg V.logVolume heq
  rw [V.logVolume_iterate, V.logVolume_iterate] at hvolume
  have hmul : (m : ℝ) * shift = (n : ℝ) * shift := by
    linarith
  have hcast : (m : ℝ) = (n : ℝ) := mul_right_cancel₀ hshift hmul
  exact_mod_cast hcast

/-- Consequently a nonzero-shift repaired interface cannot have only finitely
many admissible region states. -/
theorem not_finite_region (hshift : shift ≠ 0) :
    ¬ Finite V.Region := by
  intro hfinite
  letI : Finite V.Region := hfinite
  let U : V.Region := Classical.choice V.region_nonempty
  obtain ⟨m, n, hmn, heq⟩ :=
    Finite.exists_ne_map_eq_of_infinite
      (fun k : ℕ => (V.preimage^[k]) U)
  exact hmn (V.iterate_injective hshift U heq)

end AdmissiblePreimageLogVolume

/-! ## The actual `ℚ_[p]` valuation-ball model -/

/-- Distinct exponent-indexed `p`-adic valuation balls have distinct carriers. -/
theorem padicValuationBall_carrier_injective
    (p : ℕ) [Fact p.Prime] :
    Function.Injective
      (fun B : ValuationBall => padicValuationBall p B.exponent) := by
  intro B C hcarrier
  change padicValuationBall p B.exponent =
    padicValuationBall p C.exponent at hcarrier
  have hBC : B.exponent ≤ C.exponent := by
    exact (padicValuationBall_subset_iff p).mp hcarrier.ge
  have hCB : C.exponent ≤ B.exponent := by
    exact (padicValuationBall_subset_iff p).mp hcarrier.le
  cases B with
  | mk b =>
      cases C with
      | mk c =>
          have hbc : b = c := le_antisymm hBC hCB
          subst c
          rfl

/-- Compact-open valuation balls form an inhabited extensional repair of the
prime-preimage log-volume law. -/
noncomputable def padicValuationBallAdmissibleModel
    (p : ℕ) [Fact p.Prime] :
    AdmissiblePreimageLogVolume ℚ_[p]
      (fun x => (p : ℚ_[p]) * x) (Real.log p) where
  Region := ValuationBall
  region_nonempty := ⟨ValuationBall.integral⟩
  carrier B := padicValuationBall p B.exponent
  carrier_injective := padicValuationBall_carrier_injective p
  carrier_nonempty B := padicValuationBall_nonempty p B.exponent
  preimage := ValuationBall.primePreimage
  carrier_preimage B :=
    (padicValuationBall_prime_preimage p B.exponent).symm
  logVolume := ValuationBall.logVolume p
  logVolume_preimage := valuationBall_primePreimage_add p

/-- In particular, the new extensional repaired interface is consistent for
every rational prime. -/
theorem padicValuationBallAdmissibleModel_nonempty
    (p : ℕ) [Fact p.Prime] :
    Nonempty
      (AdmissiblePreimageLogVolume.{0, 0} ℚ_[p]
        (fun x => (p : ℚ_[p]) * x) (Real.log p)) :=
  ⟨padicValuationBallAdmissibleModel p⟩

/-- The shift of the valuation-ball model is genuinely nonzero at every
rational prime. -/
theorem log_prime_pos (p : ℕ) [Fact p.Prime] :
    0 < Real.log (p : ℝ) := by
  apply Real.log_pos
  exact_mod_cast (Fact.out : p.Prime).one_lt

/-- The concrete model realizes the required infinite-orbit condition. -/
theorem padicValuationBall_region_not_finite
    (p : ℕ) [Fact p.Prime] :
    ¬ Finite ValuationBall :=
  (padicValuationBallAdmissibleModel p).not_finite_region
    (log_prime_pos p).ne'

/-! ## Positive primitive triples and the uniform tripod comparison -/

/-- A positive pairwise-coprime integer abc triple. -/
structure PositivePrimitiveABCTriple where
  a : ℕ
  b : ℕ
  c : ℕ
  a_pos : 0 < a
  b_pos : 0 < b
  c_pos : 0 < c
  sum_eq : a + b = c
  pairwiseCoprime : PairwiseCoprimeABC a b c

namespace PositivePrimitiveABCTriple

/-- The logarithmic height used by this repository's `ABCConjecture`. -/
noncomputable def logHeight (t : PositivePrimitiveABCTriple) : ℝ :=
  Real.log (((max t.a (max t.b t.c) : ℕ) : ℝ))

/-- The logarithm of the radical used by this repository's
`ABCConjecture`. -/
noncomputable def logRadical (t : PositivePrimitiveABCTriple) : ℝ :=
  Real.log (((abcRadical (t.a * t.b * t.c) : ℕ) : ℝ))

end PositivePrimitiveABCTriple

/-- Concrete data sufficient to transfer `T.StatementI` on the degree-at-most-one
tripod locus to the repository's integer abc statement.

The two error terms are single real constants, uniform over all triples. -/
structure StatementIIntegerComparison (T : Genl.HeightTheory) where
  encode : PositivePrimitiveABCTriple → T.Pt T.tripod
  encode_mem_degreeAtMostOne : ∀ t, encode t ∈ T.ptLE T.tripod 1
  heightError : ℝ
  radicalError : ℝ
  logHeight_le : ∀ t,
    t.logHeight ≤ T.htCan T.tripod (encode t) + heightError
  logDiff_add_logCond_le : ∀ t,
    T.logDiff T.tripod (encode t) + T.logCond T.tripod (encode t) ≤
      t.logRadical + radicalError

/-- `StatementI` plus the explicit degree-at-most-one encoding and two uniform
comparisons proves the exact integer `ABCConjecture`. -/
theorem abcConjecture_of_statementI_comparison
    {T : Genl.HeightTheory}
    (hStatementI : T.StatementI)
    (B : StatementIIntegerComparison T) :
    ABCConjecture := by
  intro ε hε
  obtain ⟨Cε, hCε⟩ :=
    hStatementI T.tripod T.hyperbolic_tripod 1 ε hε
  refine ⟨Cε + B.heightError + (1 + ε) * B.radicalError, ?_⟩
  intro a b c ha hb hc habc hcoprime
  let t : PositivePrimitiveABCTriple :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := habc
      pairwiseCoprime := hcoprime }
  have hsource := hCε (B.encode t) (B.encode_mem_degreeAtMostOne t)
  simp only [Pi.smul_apply, Pi.add_apply, smul_eq_mul] at hsource
  have hcoefficient : 0 ≤ 1 + ε := by linarith
  calc
    Real.log (((max a (max b c) : ℕ) : ℝ)) = t.logHeight := by
      rfl
    _ ≤ T.htCan T.tripod (B.encode t) + B.heightError :=
      B.logHeight_le t
    _ ≤ (1 + ε) *
          (T.logDiff T.tripod (B.encode t) +
            T.logCond T.tripod (B.encode t)) +
          Cε + B.heightError := by
      linarith
    _ ≤ (1 + ε) * (t.logRadical + B.radicalError) +
          Cε + B.heightError := by
      have hscaled := mul_le_mul_of_nonneg_left
        (B.logDiff_add_logCond_le t) hcoefficient
      linarith
    _ = (1 + ε) *
          Real.log (((abcRadical (a * b * c) : ℕ) : ℝ)) +
          (Cε + B.heightError + (1 + ε) * B.radicalError) := by
      dsimp [PositivePrimitiveABCTriple.logRadical, t]
      ring

/-- The comparison package therefore constructs the formerly black-box bridge
as an ordinary function; its only remaining input is `T.StatementI`. -/
theorem StatementIIntegerComparison.toBridge
    {T : Genl.HeightTheory} (B : StatementIIntegerComparison T) :
    T.StatementI → ABCConjecture :=
  fun hStatementI => abcConjecture_of_statementI_comparison hStatementI B

/-! ## Full-premise counterexamples in the isolated sequence schema -/

/-- The common bounded-discrepancy shape, isolated on sequences for exact
countermodel tests. -/
def UniformEpsilonBound (height radical : ℕ → ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε →
    ∃ C : ℝ, ∀ n : ℕ,
      height n ≤ (1 + ε) * radical n + C

/-- The same epsilon-uniform discrepancy shape restricted to a stated source
domain. This makes the retained domain premise explicit in the
degree-membership countermodel. -/
def UniformEpsilonBoundOn
    (height radical : ℕ → ℝ) (domain : Set ℕ) : Prop :=
  ∀ ε : ℝ, 0 < ε →
    ∃ C : ℝ, ∀ n : ℕ, n ∈ domain →
      height n ≤ (1 + ε) * radical n + C

/-- Every pair of source functions satisfies the epsilon-uniform bound on the
empty source domain. -/
theorem uniformEpsilonBoundOn_empty (height radical : ℕ → ℝ) :
    UniformEpsilonBoundOn height radical ∅ := by
  intro ε hε
  exact ⟨0, by simp⟩

/-- The zero source satisfies the uniform epsilon bound. -/
theorem uniformEpsilonBound_zero :
    UniformEpsilonBound (fun _ => 0) (fun _ => 0) := by
  intro ε hε
  exact ⟨0, by simp⟩

/-- The identity nonnegative sequence is bounded by `(1+ε)` times itself. -/
theorem uniformEpsilonBound_nat_self :
    UniformEpsilonBound (fun n => (n : ℝ)) (fun n => (n : ℝ)) := by
  intro ε hε
  refine ⟨0, ?_⟩
  intro n
  have hn : 0 ≤ (n : ℝ) := by positivity
  nlinarith

/-- Natural-number height is not uniformly bounded over the zero radical
sequence. -/
theorem not_uniformEpsilonBound_nat_zero :
    ¬ UniformEpsilonBound (fun n => (n : ℝ)) (fun _ => 0) := by
  intro hbound
  obtain ⟨C, hC⟩ := hbound 1 (by norm_num)
  obtain ⟨n, hn⟩ := exists_nat_gt C
  have hle := hC n
  simp only [mul_zero, zero_add] at hle
  linarith

/-- Without a height comparison, a valid source bound and an exact
conductor/radical comparison do not imply the target bound. -/
theorem counterexample_without_height_comparison :
    ∃ (sourceHeight sourceRadical targetHeight targetRadical : ℕ → ℝ),
      UniformEpsilonBound sourceHeight sourceRadical ∧
      (∀ n, sourceRadical n ≤ targetRadical n) ∧
      ¬ UniformEpsilonBound targetHeight targetRadical := by
  refine ⟨(fun _ => 0), (fun _ => 0), (fun n => (n : ℝ)),
    (fun _ => 0), uniformEpsilonBound_zero, ?_,
    not_uniformEpsilonBound_nat_zero⟩
  simp

/-- Without a conductor/radical comparison, a valid source bound and an exact
height comparison do not imply the target bound. -/
theorem counterexample_without_radical_comparison :
    ∃ (sourceHeight sourceRadical targetHeight targetRadical : ℕ → ℝ),
      UniformEpsilonBound sourceHeight sourceRadical ∧
      (∀ n, targetHeight n ≤ sourceHeight n) ∧
      ¬ UniformEpsilonBound targetHeight targetRadical := by
  refine ⟨(fun n => (n : ℝ)), (fun n => (n : ℝ)),
    (fun n => (n : ℝ)), (fun _ => 0),
    uniformEpsilonBound_nat_self, ?_, not_uniformEpsilonBound_nat_zero⟩
  simp

/-- A discrepancy bound on an empty source domain gives no control of an
unbounded encoded target sequence; this is the degree-membership obstruction. -/
theorem counterexample_without_domain_membership :
    UniformEpsilonBoundOn (fun n : ℕ => (n : ℝ)) (fun _ => 0) ∅ ∧
      (∀ n : ℕ, (n : ℝ) ≤ (n : ℝ)) ∧
      (∀ _ : ℕ, (0 : ℝ) ≤ 0) ∧
      ¬ UniformEpsilonBound (fun n => (n : ℝ)) (fun _ => 0) :=
  ⟨uniformEpsilonBoundOn_empty _ _, fun _ => le_rfl, fun _ => le_rfl,
    not_uniformEpsilonBound_nat_zero⟩

/-- Allowing a height error to depend on the input makes the comparison
vacuous and does not produce a uniform target constant. -/
theorem counterexample_with_nonuniform_height_error :
    ∃ (error : ℕ → ℝ),
      UniformEpsilonBound (fun _ => 0) (fun _ => 0) ∧
      (∀ _ : ℕ, (0 : ℝ) ≤ 0) ∧
      (∀ n : ℕ, (n : ℝ) ≤ 0 + error n) ∧
      ¬ UniformEpsilonBound (fun n => (n : ℝ)) (fun _ => 0) := by
  refine ⟨(fun n => (n : ℝ)), uniformEpsilonBound_zero, fun _ => le_rfl, ?_,
    not_uniformEpsilonBound_nat_zero⟩
  simp

/-- A radical-comparison error depending on the input is equally vacuous. -/
theorem counterexample_with_nonuniform_radical_error :
    ∃ (error : ℕ → ℝ),
      UniformEpsilonBound (fun n => (n : ℝ)) (fun n => (n : ℝ)) ∧
      (∀ n : ℕ, (n : ℝ) ≤ (n : ℝ)) ∧
      (∀ n : ℕ, (n : ℝ) ≤ 0 + error n) ∧
      ¬ UniformEpsilonBound (fun n => (n : ℝ)) (fun _ => 0) := by
  refine ⟨(fun n => (n : ℝ)), uniformEpsilonBound_nat_self,
    fun _ => le_rfl, ?_,
    not_uniformEpsilonBound_nat_zero⟩
  simp

#print axioms AdmissiblePreimageLogVolume.carrier_ne_empty
#print axioms AdmissiblePreimageLogVolume.logVolume_eq_of_carrier_eq
#print axioms AdmissiblePreimageLogVolume.preimage_ne_of_shift_ne_zero
#print axioms AdmissiblePreimageLogVolume.logVolume_iterate
#print axioms AdmissiblePreimageLogVolume.iterate_ne_of_pos_of_shift_ne_zero
#print axioms AdmissiblePreimageLogVolume.iterate_injective
#print axioms AdmissiblePreimageLogVolume.not_finite_region
#print axioms padicValuationBall_carrier_injective
#print axioms padicValuationBallAdmissibleModel_nonempty
#print axioms padicValuationBall_region_not_finite
#print axioms abcConjecture_of_statementI_comparison
#print axioms StatementIIntegerComparison.toBridge
#print axioms counterexample_without_height_comparison
#print axioms counterexample_without_radical_comparison
#print axioms uniformEpsilonBoundOn_empty
#print axioms counterexample_without_domain_membership
#print axioms counterexample_with_nonuniform_height_error
#print axioms counterexample_with_nonuniform_radical_error

end IUTAdmissibleVolumeIntegerBridge20260901
end IUTThreeClosures
