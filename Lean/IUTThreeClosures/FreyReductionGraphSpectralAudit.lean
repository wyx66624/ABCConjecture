/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreySelmerRegulatorAudit
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds

/-!
# Spectral and electrical audit of the Frey reduction cycle

At an odd multiplicative place with geometric Kodaira fibre `I_(2e)`, the
unit-edge dual graph is the cycle with `2e` edges.  The paper companion to
this file computes its Fourier spectrum, Green kernel, effective resistance,
matrix-tree determinant, and the component energies of rational two-torsion.

The useful positive statement is an exact three-pair selection lemma.  At
each bad place, two of the three unordered pairs of nonzero two-torsion
sections are separated by the antipodal resistance `e / 2`, while the
colliding pair has graph resistance zero.  Consequently one *fixed global
pair* captures at least one third of any nonnegative weighted excess mass.
This does not prove abc: that fixed pair is again two-torsion, so its global
canonical height is zero and Faltings--Hriljac forces the positive graph
energy to be cancelled by the remaining finite and archimedean terms.

Lean formalizes the exact scalar formulas, the finite cyclic difference
operator, the trigonometric eigenvalue identity, the three-pair selection
inequality, and fully quantified countermodels.  It does not identify an
actual regular-model dual graph, prove the Fourier basis complete, evaluate
a matrix determinant, construct admissible metrics or local heights, invoke
Faltings--Hriljac/arithmetic Hodge index, or construct a non-torsion global
selector.  Those interpretation steps remain explicit paper mathematics.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## The finite cyclic Laplacian and its Fourier eigenvalue formula -/

/-- The second-difference operator on a finite cyclic group.  For `n = 2`
the two neighbour terms coincide, correctly modeling the two parallel edges
of the Kodaira polygon `I_2`. -/
def cyclicDifferenceLaplacian (n : ℕ) [NeZero n]
    (f : ZMod n → ℝ) (j : ZMod n) : ℝ :=
  2 * f j - f (j + 1) - f (j - 1)

/-- Constants lie in the kernel of the cyclic difference Laplacian. -/
@[simp]
theorem cyclicDifferenceLaplacian_const
    (n : ℕ) [NeZero n] (c : ℝ) (j : ZMod n) :
    cyclicDifferenceLaplacian n (fun _ ↦ c) j = 0 := by
  simp only [cyclicDifferenceLaplacian]
  ring

/-- Scalar Fourier eigenvalue of the unit-edge cycle. -/
def cycleLaplacianEigenvalue (n k : ℝ) : ℝ :=
  2 - 2 * Real.cos (2 * Real.pi * k / n)

/-- The exact trigonometric form of the cycle eigenvalue.  On paper the
corresponding eigenvector is `j ↦ exp(2πikj/n)`. -/
theorem cycleLaplacianEigenvalue_eq_four_sin_sq
    (n k : ℝ) :
    cycleLaplacianEigenvalue n k =
      4 * Real.sin (Real.pi * k / n) ^ 2 := by
  unfold cycleLaplacianEigenvalue
  have harg : 2 * Real.pi * k / n =
      2 * (Real.pi * k / n) := by ring
  rw [harg, Real.cos_two_mul]
  have htrig := Real.sin_sq_add_cos_sq (Real.pi * k / n)
  nlinarith

/-- The first nonzero Fourier eigenvalue has the elementary quadratic upper
bound `4(π/n)^2`; hence the cycles have no uniform spectral gap. -/
theorem cycleSpectralGap_le_quadratic
    (n : ℝ) :
    cycleLaplacianEigenvalue n 1 ≤
      4 * (Real.pi / n) ^ 2 := by
  rw [cycleLaplacianEigenvalue_eq_four_sin_sq]
  simpa using
    (mul_le_mul_of_nonneg_left
      (Real.sin_sq_le_sq (x := Real.pi / n)) (by norm_num : (0 : ℝ) ≤ 4))

/-- Frey normalization of the spectral-gap estimate. -/
theorem freyCycleSpectralGap_le
    {e : ℝ} (he : e ≠ 0) :
    cycleLaplacianEigenvalue (2 * e) 1 ≤
      Real.pi ^ 2 / e ^ 2 := by
  calc
    cycleLaplacianEigenvalue (2 * e) 1 ≤
        4 * (Real.pi / (2 * e)) ^ 2 :=
      cycleSpectralGap_le_quadratic (2 * e)
    _ = Real.pi ^ 2 / e ^ 2 := by
      field_simp
      ring

/-! ## Effective resistance and the two Green normalizations -/

/-- Effective resistance on a unit cycle of total length `n` between two
vertices separated by an oriented distance `d` in `[0,n]`. -/
def cycleEffectiveResistance (n d : ℝ) : ℝ :=
  d * (n - d) / n

/-- Antipodal resistance on the Frey cycle `C_(2e)`. -/
theorem freyCycle_antipodalResistance
    {e : ℝ} (he : e ≠ 0) :
    cycleEffectiveResistance (2 * e) e = e / 2 := by
  unfold cycleEffectiveResistance
  field_simp
  ring

/-- The second Bernoulli polynomial. -/
def bernoulliTwo (x : ℝ) : ℝ :=
  x ^ 2 - x + 1 / 6

/-- Mean-zero Green kernel on a metric circle of length `length`, evaluated
at oriented separation `t`.  The paper interpretation uses the uniform
admissible measure and the sign convention `Δg = δ - μ`. -/
def metricCircleGreen (length t : ℝ) : ℝ :=
  length / 2 * bernoulliTwo (t / length)

/-- Green value at the origin on the Frey circle. -/
theorem freyMetricCircleGreen_zero (e : ℝ) :
    metricCircleGreen (2 * e) 0 = e / 6 := by
  simp [metricCircleGreen, bernoulliTwo]
  ring

/-- Green value at the antipode on the Frey circle. -/
theorem freyMetricCircleGreen_antipode
    {e : ℝ} (he : e ≠ 0) :
    metricCircleGreen (2 * e) e = -e / 12 := by
  unfold metricCircleGreen bernoulliTwo
  field_simp
  ring

/-- The Tate two-torsion row of the metric Green kernel conserves exactly. -/
theorem freyMetricCircleGreen_twoTorsion_conservation
    {e : ℝ} (he : e ≠ 0) :
    metricCircleGreen (2 * e) 0 +
        2 * metricCircleGreen (2 * e) e = 0 := by
  rw [freyMetricCircleGreen_zero,
    freyMetricCircleGreen_antipode he]
  ring

/-- Energy of the degree-zero antipodal charge is the effective resistance.
Equivalently, it is `g(0,0)+g(e,e)-2g(0,e)`. -/
theorem freyMetricCircleGreen_antipodalChargeEnergy
    {e : ℝ} (he : e ≠ 0) :
    metricCircleGreen (2 * e) 0 +
        metricCircleGreen (2 * e) 0 -
        2 * metricCircleGreen (2 * e) e = e / 2 := by
  rw [freyMetricCircleGreen_zero,
    freyMetricCircleGreen_antipode he]
  ring

/-- The zero-mean Moore--Penrose Green entry for the discrete cycle. -/
def discreteCycleGreen (n d : ℝ) : ℝ :=
  (n ^ 2 - 1) / (12 * n) - d * (n - d) / (2 * n)

/-- Discrete and metric Green kernels differ only by the constant
`1/(12n)`.  Constant shifts disappear on degree-zero divisors. -/
theorem metricCircleGreen_eq_discreteCycleGreen_add_constant
    {n : ℝ} (hn : n ≠ 0) (d : ℝ) :
    metricCircleGreen n d =
      discreteCycleGreen n d + 1 / (12 * n) := by
  unfold metricCircleGreen bernoulliTwo discreteCycleGreen
  field_simp
  ring

/-- The discrete Moore--Penrose diagonal contains the finite-subdivision
correction `-1/(24e)` and therefore is not the Tate value `e/6`. -/
theorem freyDiscreteCycleGreen_zero
    {e : ℝ} (he : e ≠ 0) :
    discreteCycleGreen (2 * e) 0 =
      e / 6 - 1 / (24 * e) := by
  unfold discreteCycleGreen
  field_simp
  ring

/-- The same finite-subdivision correction at the antipode. -/
theorem freyDiscreteCycleGreen_antipode
    {e : ℝ} (he : e ≠ 0) :
    discreteCycleGreen (2 * e) e =
      -e / 12 - 1 / (24 * e) := by
  unfold discreteCycleGreen
  field_simp
  ring

/-- Exact Kirchhoff-index formula for a cycle, recorded as the scalar output
of the paper calculation. -/
def cycleKirchhoffIndexFormula (n : ℝ) : ℝ :=
  (n ^ 3 - n) / 12

theorem freyCycleKirchhoffIndexFormula (e : ℝ) :
    cycleKirchhoffIndexFormula (2 * e) =
      (4 * e ^ 3 - e) / 6 := by
  unfold cycleKirchhoffIndexFormula
  ring

/-! ## Matrix-tree bookkeeping -/

/-- Deleting one of the `n` cycle edges gives a spanning path.  This type
records the deletion choices.  Identifying it with actual spanning trees of
the graph is paper mathematics, not a graph-theory construction in Lean. -/
abbrev CycleSpanningTreeDeletionChoice (n : ℕ) := Fin n

theorem cycleSpanningTreeDeletionChoice_card (n : ℕ) :
    Nat.card (CycleSpanningTreeDeletionChoice n) = n := by
  simp [CycleSpanningTreeDeletionChoice]

/-- Matrix-tree cofactor formula for the cycle, represented through the
edge-deletion count. -/
def cycleMatrixTreeCofactorFormula (n : ℕ) : ℕ :=
  Nat.card (CycleSpanningTreeDeletionChoice n)

theorem cycleMatrixTreeCofactorFormula_eq (n : ℕ) :
    cycleMatrixTreeCofactorFormula n = n := by
  simp [cycleMatrixTreeCofactorFormula]

/-- Since the product of the nonzero Laplacian eigenvalues is `n` times a
cofactor, its cycle formula is `n^2`.  The spectral determinant
identification itself is retained in the paper boundary. -/
def cycleLaplacianPseudoDetFormula (n : ℕ) : ℕ :=
  n * cycleMatrixTreeCofactorFormula n

theorem cycleLaplacianPseudoDetFormula_eq (n : ℕ) :
    cycleLaplacianPseudoDetFormula n = n ^ 2 := by
  simp [cycleLaplacianPseudoDetFormula,
    cycleMatrixTreeCofactorFormula_eq, pow_two]

/-! ## The three rational two-torsion components -/

/-- At one local fibre, exactly one unordered branch pair collides.  That
pair has graph energy zero; each of the other two has antipodal energy
`weight/2`. -/
theorem localThreePairResistanceLedger (weight : ℝ) :
    0 + weight / 2 + weight / 2 = weight := by
  ring

/-- Energy assigned to the first fixed pair when the collision masses of
the three branch pairs are `w₀,w₁,w₂`. -/
def firstFixedPairEnergy (_w₀ w₁ w₂ : ℝ) : ℝ :=
  (w₁ + w₂) / 2

def secondFixedPairEnergy (w₀ _w₁ w₂ : ℝ) : ℝ :=
  (w₀ + w₂) / 2

def thirdFixedPairEnergy (w₀ w₁ _w₂ : ℝ) : ℝ :=
  (w₀ + w₁) / 2

/-- Summing over the three fixed global pairs recovers all local weighted
mass exactly. -/
theorem threeFixedPairEnergy_conservation (w₀ w₁ w₂ : ℝ) :
    firstFixedPairEnergy w₀ w₁ w₂ +
        secondFixedPairEnergy w₀ w₁ w₂ +
        thirdFixedPairEnergy w₀ w₁ w₂ =
      w₀ + w₁ + w₂ := by
  unfold firstFixedPairEnergy secondFixedPairEnergy thirdFixedPairEnergy
  ring

/-- A genuinely positive, non-circular selection theorem: one fixed global
pair of two-torsion sections captures at least one third of the total
weighted mass.  The same statement applies to the excess weights
`(e_p-1) log p` after grouping primes by their colliding branch pair. -/
theorem threeFixedPairEnergy_selection (w₀ w₁ w₂ : ℝ) :
    (w₀ + w₁ + w₂) / 3 ≤
      max (firstFixedPairEnergy w₀ w₁ w₂)
        (max (secondFixedPairEnergy w₀ w₁ w₂)
          (thirdFixedPairEnergy w₀ w₁ w₂)) := by
  let M := max (firstFixedPairEnergy w₀ w₁ w₂)
    (max (secondFixedPairEnergy w₀ w₁ w₂)
      (thirdFixedPairEnergy w₀ w₁ w₂))
  have h₀ : firstFixedPairEnergy w₀ w₁ w₂ ≤ M :=
    le_max_left _ _
  have h₁ : secondFixedPairEnergy w₀ w₁ w₂ ≤ M :=
    (le_max_left _ _).trans (le_max_right _ _)
  have h₂ : thirdFixedPairEnergy w₀ w₁ w₂ ≤ M :=
    (le_max_right _ _).trans (le_max_right _ _)
  have hsum := threeFixedPairEnergy_conservation w₀ w₁ w₂
  change (w₀ + w₁ + w₂) / 3 ≤ M
  linarith

/-! ## Strict no-go statements -/

/-- The reduced profile keeps only whether the fibre is present and the
first Betti number of its subdivision-free topological circle. -/
def reducedCycleSupportProfile (e : ℕ) : ℕ × ℕ :=
  (if e = 0 then 0 else 1, if e = 0 then 0 else 1)

theorem reducedCycleSupportProfile_of_pos
    {e : ℕ} (he : 0 < e) :
    reducedCycleSupportProfile e = (1, 1) := by
  simp [reducedCycleSupportProfile, he.ne']

/-- Fully quantified obstruction on an actual primitive Frey family: no
function of the reduced support/topological-circle profile bounds the local
exponent excess at `3`. -/
theorem no_cycleExponentExcess_bound_from_reducedProfile
    (F : (ℕ × ℕ) → ℕ) :
    ∃ n : ℕ,
      F (reducedCycleSupportProfile
          (((evenDepthThreeFreyPoint n).a *
            (evenDepthThreeFreyPoint n).b *
            (evenDepthThreeFreyPoint n).c).factorization 3)) <
        ((evenDepthThreeFreyPoint n).a *
          (evenDepthThreeFreyPoint n).b *
          (evenDepthThreeFreyPoint n).c).factorization 3 - 1 := by
  refine ⟨F (1, 1), ?_⟩
  rw [evenDepthThreeFreyPoint_abc_factorization_three]
  have hpos : 0 < 2 * (F (1, 1) + 1) := by omega
  rw [reducedCycleSupportProfile_of_pos hpos]
  omega

/-- A zero global ledger is compatible with arbitrarily large positive
local cycle energy once an unrestricted compensating term is allowed.  This
is the scalar quantifier obstruction behind the torsion-height audit. -/
theorem zeroGlobalLedger_allows_unbounded_positiveCycleEnergy (B : ℕ) :
    let e : ℝ := 2 * (B + 1 : ℕ)
    (B : ℝ) < cycleEffectiveResistance (2 * e) e ∧
      cycleEffectiveResistance (2 * e) e +
        (-cycleEffectiveResistance (2 * e) e) = 0 := by
  dsimp
  constructor
  · rw [freyCycle_antipodalResistance]
    · push_cast
      norm_num
    · positivity
  · ring

/-- Under a global zero-height identity, every positive selected graph term
is cancelled by a strictly negative complementary term.  In the paper this
is the Faltings--Hriljac identity for a nonzero two-torsion divisor. -/
theorem positiveGraphEnergy_forces_exact_negativeComplement
    {graphEnergy complement : ℝ}
    (hzero : graphEnergy + complement = 0)
    (henergy : 0 < graphEnergy) :
    complement = -graphEnergy ∧ complement < 0 := by
  constructor <;> linarith

/-! ## The minimum open quantitative bridge -/

/-- Scalar transfer supplied by a hypothetical non-torsion spectral
selector.  It deliberately exposes all three missing estimates: positive
capture, Faltings--Hriljac comparison with the adverse terms retained, and
a conductor upper budget for the resulting global quantity. -/
theorem spectralSelector_to_exponentMassBudget
    {exponentMass selectedEnergy globalHeight adverse conductorLog
      kappa A C : ℝ}
    (hkappa : 0 < kappa)
    (hcapture : kappa * exponentMass ≤ selectedEnergy)
    (hFH : selectedEnergy ≤ globalHeight + adverse)
    (hglobal : globalHeight + adverse ≤ A * conductorLog + C) :
    exponentMass ≤ (A * conductorLog + C) / kappa := by
  apply (le_div_iff₀ hkappa).2
  simpa [mul_comm] using hcapture.trans (hFH.trans hglobal)

end

end IUTThreeClosures
