import IUTThreeClosures.FreyDiscriminantConductor
import IUTThreeClosures.IUTIVAbsorption

/-!
# Support bounds and epsilon absorption for a varying different

A different attached to a point-dependent auxiliary field need not be bounded
by an absolute constant. The correct target is a support-and-exponent bound.
If the natural norm of the different divides

`fixedFactor * rad(abc)^exponent`,

then its logarithm is bounded by

`log fixedFactor + exponent * conductor`.

After multiplication by a sufficiently small source coefficient, the
conductor part is epsilon-absorbable. This is the source-faithful form of the
"different correction is uniformly controlled" statement: the actual
arithmetic-geometry theorem still has to prove the divisibility/support bound
for the auxiliary field used by the IUT source.
-/

namespace IUTThreeClosures

/-- Arithmetic control of a point-dependent different norm by fixed exceptional
support and the abc radical. -/
structure DifferentSupportControl where
  differentNorm : ABCPoint → ℕ
  differentNorm_pos : ∀ P, 0 < differentNorm P
  fixedFactor : ℕ
  fixedFactor_pos : 0 < fixedFactor
  exponent : ℕ
  norm_dvd : ∀ P,
    differentNorm P ∣
      fixedFactor *
        (abcRadical (P.a * P.b * P.c)) ^ exponent

namespace DifferentSupportControl

/-- Logarithmic different correction. -/
noncomputable def logDifferent
    (D : DifferentSupportControl) (P : ABCPoint) : ℝ :=
  Real.log ((D.differentNorm P : ℕ) : ℝ)

/-- The elementary abc conductor is nonnegative. -/
theorem abcConductor_nonneg (P : ABCPoint) : 0 ≤ P.conductor := by
  unfold ABCPoint.conductor
  apply Real.log_nonneg
  exact_mod_cast
    (Nat.one_le_iff_ne_zero.mpr
      (abcRadical_pos (P.a * P.b * P.c)).ne')

/-- A support-and-exponent bound gives a logarithmic conductor bound for the
different. -/
theorem logDifferent_le
    (D : DifferentSupportControl) (P : ABCPoint) :
    D.logDifferent P ≤
      Real.log (D.fixedFactor : ℝ) +
        (D.exponent : ℝ) * P.conductor := by
  have hrad : 0 < abcRadical (P.a * P.b * P.c) :=
    abcRadical_pos _
  have hupperPos :
      0 < D.fixedFactor *
        (abcRadical (P.a * P.b * P.c)) ^ D.exponent :=
    mul_pos D.fixedFactor_pos (pow_pos hrad D.exponent)
  have hnat :
      D.differentNorm P ≤
        D.fixedFactor *
          (abcRadical (P.a * P.b * P.c)) ^ D.exponent :=
    Nat.le_of_dvd hupperPos (D.norm_dvd P)
  have hdiffR : 0 < (D.differentNorm P : ℝ) := by
    exact_mod_cast D.differentNorm_pos P
  have hfixedR : (D.fixedFactor : ℝ) ≠ 0 := by
    exact_mod_cast D.fixedFactor_pos.ne'
  have hradR :
      (abcRadical (P.a * P.b * P.c) : ℝ) ≠ 0 := by
    exact_mod_cast hrad.ne'
  have hnatR :
      (D.differentNorm P : ℝ) ≤
        (D.fixedFactor : ℝ) *
          (abcRadical (P.a * P.b * P.c) : ℝ) ^ D.exponent := by
    exact_mod_cast hnat
  have hlog := Real.log_le_log hdiffR hnatR
  rw [Real.log_mul hfixedR (pow_ne_zero _ hradR), Real.log_pow] at hlog
  simpa [logDifferent, ABCPoint.conductor] using hlog

/-- Scaling by a nonnegative source coefficient preserves the support bound. -/
theorem scaled_logDifferent_le
    (D : DifferentSupportControl) (P : ABCPoint)
    {δ : ℝ} (hδ : 0 ≤ δ) :
    δ * D.logDifferent P ≤
      (δ * (D.exponent : ℝ)) * P.conductor +
        δ * Real.log (D.fixedFactor : ℝ) := by
  have h := mul_le_mul_of_nonneg_left (D.logDifferent_le P) hδ
  nlinarith

/-- If the scaled exponent is at most `η`, the entire point-dependent part is
bounded by `η * conductor`; only the fixed exceptional factor remains. -/
theorem scaled_logDifferent_le_of_scaledExponent
    (D : DifferentSupportControl) (P : ABCPoint)
    {δ η : ℝ} (hδ : 0 ≤ δ)
    (hscaled : δ * (D.exponent : ℝ) ≤ η) :
    δ * D.logDifferent P ≤
      η * P.conductor + δ * Real.log (D.fixedFactor : ℝ) := by
  have hmain := D.scaled_logDifferent_le P hδ
  have hcoef := mul_le_mul_of_nonneg_right hscaled (abcConductor_nonneg P)
  linarith

/-- A direct epsilon-absorption form. The premise is the form produced after
isolating the different term in a source q-pilot estimate. -/
theorem absorb_scaledDifferent
    (D : DifferentSupportControl) (P : ABCPoint)
    {q6 C ε δ : ℝ}
    (hε : 0 < ε) (hδ : 0 ≤ δ)
    (hscaled : δ * (D.exponent : ℝ) ≤ ε / 5)
    (hmain :
      q6 ≤ (1 + 4 * ε / 5) * P.conductor +
        δ * D.logDifferent P + C) :
    q6 ≤ (1 + ε) * P.conductor +
      (C + δ * Real.log (D.fixedFactor : ℝ)) := by
  have hdiff := D.scaled_logDifferent_le_of_scaledExponent P hδ hscaled
  have hcond := abcConductor_nonneg P
  calc
    q6 ≤ (1 + 4 * ε / 5) * P.conductor +
        δ * D.logDifferent P + C := hmain
    _ ≤ (1 + 4 * ε / 5) * P.conductor +
        (ε / 5 * P.conductor +
          δ * Real.log (D.fixedFactor : ℝ)) + C := by
      linarith
    _ = (1 + ε) * P.conductor +
        (C + δ * Real.log (D.fixedFactor : ℝ)) := by ring

end DifferentSupportControl

/-- Scalar form of the prime-choice/different absorption used in IUT IV,
Corollary 2.2. `η` is the `28 d_mod / ell` term; `twoLogEll` is the prime
choice term. The two hypotheses corresponding to (P2) and (P1) convert the
Theorem 1.10 estimate into exactly the input of `proposition21_absorption`. -/
theorem iutIV_primeChoice_different_absorption
    {ε q6 diff cond η twoLogEll C Cell : ℝ}
    (hε : 0 < ε) (hε1 : ε ≤ 1)
    (hdiff : 0 ≤ diff) (hcond : 0 ≤ cond)
    (hC : 0 ≤ C) (hCell : 0 ≤ Cell)
    (hTheorem110 :
      q6 ≤ (1 + ε / 5 + η) * (diff + cond) +
        twoLogEll + C)
    (hP2 : η ≤ ε / 5)
    (hP1 : twoLogEll ≤
      (ε / 5) * (q6 + diff) + Cell) :
    q6 ≤ (1 + ε) * (diff + cond) + 2 * (C + Cell) := by
  have hsum : 0 ≤ diff + cond := add_nonneg hdiff hcond
  have heta :
      (1 + ε / 5 + η) * (diff + cond) ≤
        (1 + 2 * ε / 5) * (diff + cond) := by
    apply mul_le_mul_of_nonneg_right _ hsum
    linarith
  have hmain :
      q6 ≤ (1 + 2 * ε / 5) * (diff + cond) +
        (ε / 5) * (q6 + diff) + (C + Cell) := by
    linarith
  exact proposition21_absorption hε hε1 hdiff hcond
    (add_nonneg hC hCell) hmain

/-- The explicit constant pattern of Corollary 2.2: `C = 14 L` and
`Cell = 2 M` become `28 L + 4 M` after absorption. -/
theorem iutIV_corollary22_scalar
    {ε q6 diff cond η twoLogEll L M : ℝ}
    (hε : 0 < ε) (hε1 : ε ≤ 1)
    (hdiff : 0 ≤ diff) (hcond : 0 ≤ cond)
    (hL : 0 ≤ L) (hM : 0 ≤ M)
    (hTheorem110 :
      q6 ≤ (1 + ε / 5 + η) * (diff + cond) +
        twoLogEll + 14 * L)
    (hP2 : η ≤ ε / 5)
    (hP1 : twoLogEll ≤
      (ε / 5) * (q6 + diff) + 2 * M) :
    q6 ≤ (1 + ε) * (diff + cond) + 28 * L + 4 * M := by
  have h := iutIV_primeChoice_different_absorption
    hε hε1 hdiff hcond
    (mul_nonneg (by norm_num) hL)
    (mul_nonneg (by norm_num) hM)
    hTheorem110 hP2 hP1
  linarith

end IUTThreeClosures
