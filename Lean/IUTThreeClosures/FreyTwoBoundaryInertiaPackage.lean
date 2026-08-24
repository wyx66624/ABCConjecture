/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyCandidateInertiaParameters

/-!
# A unified two-boundary Frey inertia package

A local boundary datum records

* one Legendre inertia direction;
* its residue prime `p`;
* a positive prime-power exponent `m`;
* the bound `p^m ≤ c`;
* in the special case `p=2`, the depth condition `5 ≤ m`.

Its candidate Picard--Lefschetz parameter is `2*m` at odd primes and
`2*m-8` at the unit-leg two-adic boundary.  We prove uniformly that the
parameter is positive and is at most

`(2/log 2) * log c`.

Two distinct such directions therefore produce a positive pair of parameters,
an explicit Euclidean auxiliary prime, and a sublinear logarithmic prime
bound.  Only the actual local Galois matrix realization remains outside this
package.
-/

namespace IUTThreeClosures

/-- One local Frey boundary together with the arithmetic information needed by
the two-inertia selector. -/
structure FreyBoundaryInertiaDatum (c : ℕ) where
  direction : LegendreInertiaDirection
  residuePrime : ℕ
  exponent : ℕ
  residuePrime_prime : residuePrime.Prime
  exponent_pos : 0 < exponent
  primePower_le : residuePrime ^ exponent ≤ c
  twoAdic_deep : residuePrime = 2 → 5 ≤ exponent

namespace FreyBoundaryInertiaDatum

/-- The candidate parameter, with the residual `2`-adic correction in the
special residue characteristic two case. -/
def parameter {c : ℕ} (D : FreyBoundaryInertiaDatum c) : ℕ :=
  if D.residuePrime = 2 then
    twoAdicFreyInertiaExponent D.exponent
  else
    oddFreyInertiaExponent D.exponent

/-- The boundary prime power bound implies the universal `2^m ≤ c` bound. -/
theorem two_pow_exponent_le
    {c : ℕ} (D : FreyBoundaryInertiaDatum c) :
    2 ^ D.exponent ≤ c := by
  have hp2 : 2 ≤ D.residuePrime := D.residuePrime_prime.two_le
  have hpow : 2 ^ D.exponent ≤ D.residuePrime ^ D.exponent :=
    Nat.pow_le_pow_left hp2 D.exponent
  exact hpow.trans D.primePower_le

/-- The unified candidate parameter is positive. -/
theorem parameter_pos
    {c : ℕ} (D : FreyBoundaryInertiaDatum c) :
    0 < D.parameter := by
  unfold parameter
  split_ifs with htwo
  · exact twoAdicFreyInertiaExponent_pos (D.twoAdic_deep htwo)
  · exact oddFreyInertiaExponent_pos D.exponent_pos

/-- The unified candidate parameter is linearly bounded by the logarithmic
height. -/
theorem parameter_le_log_height
    {c : ℕ} (D : FreyBoundaryInertiaDatum c)
    (hc : 0 < c) :
    (D.parameter : ℝ) ≤
      freyInertiaHeightCoefficient * Real.log c := by
  unfold parameter
  split_ifs with htwo
  · exact twoAdicFreyInertiaExponent_le_log_height
      hc D.two_pow_exponent_le
  · exact oddFreyInertiaExponent_le_log_height
      hc D.two_pow_exponent_le

end FreyBoundaryInertiaDatum

/-- Two distinct local boundary directions. -/
structure FreyTwoBoundaryInertiaData (c : ℕ) where
  first : FreyBoundaryInertiaDatum c
  second : FreyBoundaryInertiaDatum c
  directions_ne : first.direction ≠ second.direction

namespace FreyTwoBoundaryInertiaData

/-- Both unified parameters are positive. -/
theorem parameters_pos
    {c : ℕ} (D : FreyTwoBoundaryInertiaData c) :
    0 < D.first.parameter ∧ 0 < D.second.parameter :=
  ⟨D.first.parameter_pos, D.second.parameter_pos⟩

/-- Select an explicit auxiliary prime from the two unified local parameters. -/
noncomputable def selectPrime
    {c : ℕ} (D : FreyTwoBoundaryInertiaData c)
    (B : ℕ) :
    TwoInertiaPrimeData B D.first.parameter D.second.parameter :=
  Classical.choice
    (exists_twoInertiaPrimeData B
      D.first.parameter D.second.parameter
      D.parameters_pos.1 D.parameters_pos.2)

/-- The selected prime is above the requested threshold. -/
theorem threshold_lt_selectedPrime
    {c : ℕ} (D : FreyTwoBoundaryInertiaData c)
    (B : ℕ) :
    B < (D.selectPrime B).ell :=
  (D.selectPrime B).threshold_lt

/-- The selected prime avoids both actual candidate parameters. -/
theorem selectedPrime_avoids_parameters
    {c : ℕ} (D : FreyTwoBoundaryInertiaData c)
    (B : ℕ) :
    ¬ (D.selectPrime B).ell ∣
      D.first.parameter * D.second.parameter :=
  (D.selectPrime B).avoids_product

/-- The selected prime has arbitrarily small logarithmic height slope. -/
theorem selectedPrime_log_sublinear
    {c : ℕ} (D : FreyTwoBoundaryInertiaData c)
    (hc : 0 < c)
    (B : ℕ)
    {η : ℝ} (hη : 0 < η) :
    ∃ C : ℝ,
      Real.log (D.selectPrime B).ell ≤
        η * Real.log c + C := by
  apply twoInertiaPrime_log_sublinear_of_linear_height
    (D.selectPrime B)
    freyInertiaHeightCoefficient_pos.le
    (Real.log_nonneg (by
      exact_mod_cast
        (Nat.one_le_iff_ne_zero.mpr (Nat.ne_of_gt hc))))
  · exact D.first.parameter_le_log_height hc
  · exact D.second.parameter_le_log_height hc
  · exact hη

/-- The exact actual local-image package still required at the selected prime. -/
def SelectedImageObligation
    {c : ℕ} (D : FreyTwoBoundaryInertiaData c)
    (B : ℕ) : Type := by
  let P := D.selectPrime B
  letI : Fact P.ell.Prime := ⟨P.ell_prime⟩
  exact TwoDirectionImageData
    P.ell D.first.parameter D.second.parameter
    D.first.direction D.second.direction

/-- Once the two selected local matrices are constructed, the selected prime
has full determinant-one image. -/
theorem full_image_of_selected_obligation
    {c : ℕ} (D : FreyTwoBoundaryInertiaData c)
    (B : ℕ)
    (I : D.SelectedImageObligation B) :
    let P := D.selectPrime B
    letI : Fact P.ell.Prime := ⟨P.ell_prime⟩
    ∀ A : TransvectionLargeImage.Matrix2 (ZMod P.ell),
      TransvectionLargeImage.Matrix2.det A = 1 →
      A ∈ I.carrier.carrier := by
  let P := D.selectPrime B
  letI : Fact P.ell.Prime := ⟨P.ell_prime⟩
  exact I.full_image_of_avoids P.avoids_first P.avoids_second

end FreyTwoBoundaryInertiaData

end IUTThreeClosures
