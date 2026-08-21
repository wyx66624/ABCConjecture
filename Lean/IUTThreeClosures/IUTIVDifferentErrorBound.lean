import Iut4Sec1.Real.LogError
import IUTThreeClosures.IUTIVAbsorption

/-!
# The explicit IUT IV nonarchimedean different/error bound

The formalized numerical core of IUT IV, Proposition 1.4(iii), bounds each
nonarchimedean ceiling error by `4 / ℓ`; it vanishes outside a finite
exceptional index set. Summing gives

`sum error ≤ 4 * #Istar / ℓ`.

The global coefficient used in the IUT IV calculation is seven times this
sum, hence

`7 * sum error ≤ 28 * #Istar / ℓ`.

If the exceptional set has cardinality at most `d_mod`, this is bounded by
`28 d_mod / ℓ`, exactly the `η` term consumed by the prime-choice condition
(P2). Thus the numerical different/ceiling correction is epsilon-absorbable
once the source supplies the actual exceptional set, ramification indices and
the prime-choice inequality. No arbitrary real error function is introduced.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u

/-- Replace the actual exceptional-cardinality term by any proved upper bound
`d`. -/
theorem nonarchimedean_logError_sum_le_of_card_le
    {ι : Type u} [DecidableEq ι]
    (ell : ℕ) (I Istar : Finset ι) (e : ι → ℕ)
    (hell : ell.Prime) (hell2 : 2 < ell) (hIstar : Istar ⊆ I)
    (he : ∀ i ∈ I, 0 < e i)
    (hsmall : ∀ i ∈ I, i ∉ Istar → e i ≤ ell - 2)
    {d : ℕ} (hcard : Istar.card ≤ d) :
    ∑ i ∈ I, Iut4Sec1.nonarchimedeanLogError ell (e i) ≤
      4 * (d : ℝ) / ell := by
  have hbase := Iut4Sec1.nonarchimedean_logError_sum_le
    ell I Istar e hell hell2 hIstar he hsmall
  have hcardR : (Istar.card : ℝ) ≤ (d : ℝ) := by
    exact_mod_cast hcard
  have hellR : (0 : ℝ) < ell := by
    exact_mod_cast hell.pos
  calc
    ∑ i ∈ I, Iut4Sec1.nonarchimedeanLogError ell (e i) ≤
        4 * (Istar.card : ℝ) / ell := hbase
    _ ≤ 4 * (d : ℝ) / ell := by
      apply (div_le_div_iff_of_pos_right hellR).2
      nlinarith

/-- The sevenfold global contribution is bounded by `28 d / ell`. -/
theorem seven_mul_nonarchimedean_logError_sum_le
    {ι : Type u} [DecidableEq ι]
    (ell : ℕ) (I Istar : Finset ι) (e : ι → ℕ)
    (hell : ell.Prime) (hell2 : 2 < ell) (hIstar : Istar ⊆ I)
    (he : ∀ i ∈ I, 0 < e i)
    (hsmall : ∀ i ∈ I, i ∉ Istar → e i ≤ ell - 2)
    {d : ℕ} (hcard : Istar.card ≤ d) :
    7 * (∑ i ∈ I, Iut4Sec1.nonarchimedeanLogError ell (e i)) ≤
      28 * (d : ℝ) / ell := by
  have h := nonarchimedean_logError_sum_le_of_card_le
    ell I Istar e hell hell2 hIstar he hsmall hcard
  nlinarith

/-- Prime-choice condition (P2) absorbs the complete sevenfold
nonarchimedean error into the allocated `ε / 5` budget. -/
theorem seven_mul_nonarchimedean_logError_sum_le_epsilon
    {ι : Type u} [DecidableEq ι]
    (ell : ℕ) (I Istar : Finset ι) (e : ι → ℕ)
    (hell : ell.Prime) (hell2 : 2 < ell) (hIstar : Istar ⊆ I)
    (he : ∀ i ∈ I, 0 < e i)
    (hsmall : ∀ i ∈ I, i ∉ Istar → e i ≤ ell - 2)
    {d : ℕ} (hcard : Istar.card ≤ d)
    {ε : ℝ} (hP2 : 28 * (d : ℝ) / ell ≤ ε / 5) :
    7 * (∑ i ∈ I, Iut4Sec1.nonarchimedeanLogError ell (e i)) ≤
      ε / 5 :=
  (seven_mul_nonarchimedean_logError_sum_le
    ell I Istar e hell hell2 hIstar he hsmall hcard).trans hP2

/-- Direct substitution into the scalar IUT IV absorption pattern. -/
theorem absorb_iutIV_nonarchimedean_error
    {ι : Type u} [DecidableEq ι]
    (ell : ℕ) (I Istar : Finset ι) (e : ι → ℕ)
    (hell : ell.Prime) (hell2 : 2 < ell) (hIstar : Istar ⊆ I)
    (he : ∀ i ∈ I, 0 < e i)
    (hsmall : ∀ i ∈ I, i ∉ Istar → e i ≤ ell - 2)
    {d : ℕ} (hcard : Istar.card ≤ d)
    {ε q6 diff cond twoLogEll C Cell : ℝ}
    (hε : 0 < ε) (hε1 : ε ≤ 1)
    (hdiff : 0 ≤ diff) (hcond : 0 ≤ cond)
    (hC : 0 ≤ C) (hCell : 0 ≤ Cell)
    (hTheorem110 :
      q6 ≤
        (1 + ε / 5 +
          7 * (∑ i ∈ I,
            Iut4Sec1.nonarchimedeanLogError ell (e i))) *
            (diff + cond) + twoLogEll + C)
    (hP2 : 28 * (d : ℝ) / ell ≤ ε / 5)
    (hP1 : twoLogEll ≤
      (ε / 5) * (q6 + diff) + Cell) :
    q6 ≤ (1 + ε) * (diff + cond) + 2 * (C + Cell) := by
  exact iutIV_primeChoice_different_absorption
    hε hε1 hdiff hcond hC hCell hTheorem110
    (seven_mul_nonarchimedean_logError_sum_le_epsilon
      ell I Istar e hell hell2 hIstar he hsmall hcard hP2)
    hP1

end IUTThreeClosures
