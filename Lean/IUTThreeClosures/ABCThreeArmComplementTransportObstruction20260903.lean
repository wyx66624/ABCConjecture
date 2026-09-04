/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCThreeArmIncidenceSuccessor20260903

/-!
# Prime-square obstruction to ordered endpoint and three-arm transport

For every odd prime `p`, the primitive point `(1, p^2 - 1, p^2)` has an
excess token of weight `log p` at key `p`.  Every prime on the other endpoint
is strictly smaller than `p`.  In the endpoint flow this token therefore has
no legal sink.  In the three-arm construction every covering face is forced
to select the `p`-vertex, and the same obstruction remains.

Since the conductor is at most `3 * log p`, the family refutes both uniform
ordered small-unmatched-mass gates at `epsilon = 1/4`.  The module does not
make any assertion about `ABCConjecture` itself.
-/

namespace IUTThreeClosures
namespace ABCThreeArmComplementTransportObstruction20260903

open scoped BigOperators
open UniqueFactorizationMonoid
open SignedEndpointPrimeTokenTransport
open ABCThreeArmIncidenceSuccessor20260903

noncomputable section

/-- The primitive prime-square endpoint `(1, p^2 - 1, p^2)`. -/
def primeSquareEndpointPoint (p : ℕ) (hp : p.Prime) : ABCPoint where
  a := 1
  b := p ^ 2 - 1
  c := p ^ 2
  a_pos := by norm_num
  b_pos := by
    have hpow : 1 < p ^ 2 := one_lt_pow₀ hp.one_lt (by norm_num)
    omega
  c_pos := pow_pos hp.pos 2
  sum_eq := by
    have hpow : 1 ≤ p ^ 2 := (one_lt_pow₀ hp.one_lt (by norm_num)).le
    omega
  pairwise_coprime := by
    rw [PairwiseCoprimeABC]
    refine ⟨Nat.coprime_one_left _, ?_, Nat.coprime_one_right _⟩
    apply (Nat.coprime_self_sub_left (by have := hp.two_le; nlinarith :
      1 ≤ p ^ 2)).mpr
    exact Nat.coprime_one_left _

@[simp] theorem primeSquareEndpointPoint_a (p : ℕ) (hp : p.Prime) :
    (primeSquareEndpointPoint p hp).a = 1 := rfl

@[simp] theorem primeSquareEndpointPoint_b (p : ℕ) (hp : p.Prime) :
    (primeSquareEndpointPoint p hp).b = p ^ 2 - 1 := rfl

@[simp] theorem primeSquareEndpointPoint_c (p : ℕ) (hp : p.Prime) :
    (primeSquareEndpointPoint p hp).c = p ^ 2 := rfl

/-- Every prime divisor of `p^2 - 1` is smaller than the odd prime `p`. -/
theorem primeDivisor_sq_sub_one_lt
    {p q : ℕ} (hp : p.Prime) (hpOdd : p ≠ 2)
    (hq : q.Prime) (hqdiv : q ∣ p ^ 2 - 1) : q < p := by
  have hp2 : 2 ≤ p := hp.two_le
  have hone : 1 ≤ p ^ 2 := by nlinarith
  have hfactor : p ^ 2 - 1 = (p - 1) * (p + 1) := by
    calc
      p ^ 2 - 1 = p ^ 2 - 1 ^ 2 := by norm_num
      _ = (p + 1) * (p - 1) := Nat.sq_sub_sq p 1
      _ = (p - 1) * (p + 1) := by rw [Nat.mul_comm]
  rw [hfactor] at hqdiv
  rcases hq.dvd_mul.mp hqdiv with hminus | hplus
  · exact lt_of_le_of_lt (Nat.le_of_dvd (by omega) hminus) (by omega)
  · have hqle : q ≤ p + 1 := Nat.le_of_dvd (by omega) hplus
    by_contra hnot
    have hpq : p ≤ q := Nat.le_of_not_gt hnot
    have hcases : q = p ∨ q = p + 1 := by omega
    rcases hcases with hqp | hqp
    · have hpdvd : p ∣ p + 1 := by simpa [hqp] using hplus
      have honeDvd : p ∣ 1 := by
        simpa using Nat.dvd_sub hpdvd (dvd_refl p)
      exact hp.not_dvd_one honeDvd
    · have hEven : 2 ∣ p + 1 :=
        (hp.odd_of_ne_two hpOdd).add_one.two_dvd
      have hpSuccPrime : (p + 1).Prime := by simpa [hqp] using hq
      have htwoEq : 2 = p + 1 :=
        (Nat.dvd_prime hpSuccPrime).mp hEven |>.resolve_left (by norm_num)
      omega

/-! ## Exact generic upper-tail arithmetic -/

/-- Selected excess-layer mass above a prime threshold, written directly as
an armwise valuation sum. -/
def selectedDefectTailLog {P : ABCPoint} (F : Face P) (t : ℕ) : ℝ :=
  ∑ r : Arm, ∑ p ∈ F.support r,
    if t < p then
      ((Face.valuation P r p - 1 : ℕ) : ℝ) * Real.log (p : ℝ)
    else 0

/-- Complementary radical mass above a prime threshold. -/
def complementRadicalTailLog {P : ABCPoint} (F : Face P) (t : ℕ) : ℝ :=
  ∑ r : Arm, ∑ q ∈ (coordinate P r).primeFactors \ F.support r,
    if t < q then Real.log (q : ℝ) else 0

/-- Selected radical mass above a prime threshold. -/
def selectedRadicalTailLog {P : ABCPoint} (F : Face P) (t : ℕ) : ℝ :=
  ∑ r : Arm, ∑ p ∈ F.support r,
    if t < p then Real.log (p : ℝ) else 0

/-- Selected full-modulus mass above a prime threshold. -/
def selectedFullModulusTailLog {P : ABCPoint} (F : Face P) (t : ℕ) : ℝ :=
  ∑ r : Arm, ∑ p ∈ F.support r,
    if t < p then
      (Face.valuation P r p : ℝ) * Real.log (p : ℝ)
    else 0

/-- Total arm-labelled radical mass above a prime threshold. -/
def totalRadicalTailLog (P : ABCPoint) (t : ℕ) : ℝ :=
  ∑ r : Arm, ∑ p ∈ (coordinate P r).primeFactors,
    if t < p then Real.log (p : ℝ) else 0

/-- The abstract source tail is exactly the selected defect tail. -/
theorem complementTransport_sourceTailMass_eq_selectedDefectTailLog
    {P : ABCPoint} (F : Face P) (T : ComplementTransport F) (t : ℕ) :
    T.sourceTailMass t = selectedDefectTailLog F t := by
  classical
  unfold MonotoneWeightedFlow.sourceTailMass selectedDefectTailLog
  rw [Finset.sum_filter, Fintype.sum_sigma]
  simp only [selectedExcessPrime, selectedExcessWeight]
  rw [Fintype.sum_sigma]
  apply Finset.sum_congr rfl
  intro r _
  simp only [Fin.sum_const, nsmul_eq_mul]
  rw [Finset.univ_eq_attach (F.support r)]
  calc
    (∑ x ∈ (F.support r).attach,
        ((Face.valuation P r x.1 - 1 : ℕ) : ℝ) *
          if t < x.1 then Real.log (x.1 : ℝ) else 0) =
      ∑ p ∈ F.support r,
        ((Face.valuation P r p - 1 : ℕ) : ℝ) *
          if t < p then Real.log (p : ℝ) else 0 := by
        exact Finset.sum_attach (F.support r)
          (fun p => ((Face.valuation P r p - 1 : ℕ) : ℝ) *
            if t < p then Real.log (p : ℝ) else 0)
    _ = ∑ p ∈ F.support r,
        if t < p then ((Face.valuation P r p - 1 : ℕ) : ℝ) *
          Real.log (p : ℝ) else 0 := by
      apply Finset.sum_congr rfl
      intro p _
      by_cases h : t < p <;> simp [h]

/-- The abstract sink tail is exactly the complementary radical tail. -/
theorem complementTransport_sinkTailMass_eq_complementRadicalTailLog
    {P : ABCPoint} (F : Face P) (T : ComplementTransport F) (t : ℕ) :
    T.sinkTailMass t = complementRadicalTailLog F t := by
  classical
  unfold MonotoneWeightedFlow.sinkTailMass complementRadicalTailLog
  rw [Finset.sum_filter, Fintype.sum_sigma]
  simp only [complementPrime, complementPrimeWeight]
  apply Finset.sum_congr rfl
  intro r _
  rw [Finset.univ_eq_attach ((coordinate P r).primeFactors \ F.support r)]
  calc
    (∑ x ∈ ((coordinate P r).primeFactors \ F.support r).attach,
        if t < x.1 then Real.log (x.1 : ℝ) else 0) =
      ∑ q ∈ (coordinate P r).primeFactors \ F.support r,
        if t < q then Real.log (q : ℝ) else 0 := by
      exact Finset.sum_attach ((coordinate P r).primeFactors \ F.support r)
        (fun q => if t < q then Real.log (q : ℝ) else 0)

/-- Selected defect plus selected radical equals the selected full-modulus
tail, threshold by threshold. -/
theorem selectedDefectTailLog_add_selectedRadicalTailLog
    {P : ABCPoint} (F : Face P) (t : ℕ) :
    selectedDefectTailLog F t + selectedRadicalTailLog F t =
      selectedFullModulusTailLog F t := by
  classical
  unfold selectedDefectTailLog selectedRadicalTailLog selectedFullModulusTailLog
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro r _
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro p hpMem
  by_cases h : t < p
  · simp only [h, if_true]
    have hval := F.valuation_pos_of_mem_support hpMem
    have hcast : ((Face.valuation P r p - 1 : ℕ) : ℝ) + 1 =
        (Face.valuation P r p : ℝ) := by
      exact_mod_cast (by omega : Face.valuation P r p - 1 + 1 =
        Face.valuation P r p)
    calc
      ((Face.valuation P r p - 1 : ℕ) : ℝ) * Real.log (p : ℝ) +
          Real.log (p : ℝ) =
        (((Face.valuation P r p - 1 : ℕ) : ℝ) + 1) *
          Real.log (p : ℝ) := by ring
      _ = (Face.valuation P r p : ℝ) * Real.log (p : ℝ) := by rw [hcast]
  · simp [h]

/-- Selected and complementary radical tails partition the total radical
tail exactly. -/
theorem selectedRadicalTailLog_add_complementRadicalTailLog
    {P : ABCPoint} (F : Face P) (t : ℕ) :
    selectedRadicalTailLog F t + complementRadicalTailLog F t =
      totalRadicalTailLog P t := by
  classical
  unfold selectedRadicalTailLog complementRadicalTailLog totalRadicalTailLog
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro r _
  have h := Finset.sum_sdiff (f := fun p =>
      if t < p then Real.log (p : ℝ) else 0) (F.support_subset r)
  linarith

/-- Exact requested form of every Hall tail: selected full-modulus tail minus
the total radical tail. -/
theorem complementTransport_tailDeficit_eq_fullModulus_sub_totalRadical
    {P : ABCPoint} (F : Face P) (T : ComplementTransport F) (t : ℕ) :
    T.sourceTailMass t - T.sinkTailMass t =
      selectedFullModulusTailLog F t - totalRadicalTailLog P t := by
  rw [complementTransport_sourceTailMass_eq_selectedDefectTailLog F T t,
    complementTransport_sinkTailMass_eq_complementRadicalTailLog F T t]
  have h1 := selectedDefectTailLog_add_selectedRadicalTailLog F t
  have h2 := selectedRadicalTailLog_add_complementRadicalTailLog F t
  linarith

/-- The endpoint has the singleton prime support `{p}`. -/
theorem primeSquareEndpoint_c_primeFactors (p : ℕ) (hp : p.Prime) :
    (primeSquareEndpointPoint p hp).c.primeFactors = {p} := by
  change (p ^ 2).primeFactors = {p}
  exact Nat.primeFactors_prime_pow (by norm_num) hp

/-- The endpoint valuation at `p` is exactly two. -/
theorem primeSquareEndpoint_c_factorization (p : ℕ) (hp : p.Prime) :
    (primeSquareEndpointPoint p hp).c.factorization p = 2 := by
  change (p ^ 2).factorization p = 2
  exact Nat.factorization_pow_self hp

/-- The unique excess layer at the endpoint prime `p`. -/
def primeSquareEndpointExcessToken (p : ℕ) (hp : p.Prime) :
    PrimeExcessToken (primeSquareEndpointPoint p hp).c :=
  ⟨⟨p, by rw [primeSquareEndpoint_c_primeFactors p hp]; simp⟩,
    ⟨0, by rw [primeSquareEndpoint_c_factorization p hp]; omega⟩⟩

@[simp] theorem primeSquareEndpointExcessToken_prime (p : ℕ) (hp : p.Prime) :
    primeExcessTokenPrime (primeSquareEndpointExcessToken p hp) = p := rfl

@[simp] theorem primeSquareEndpointExcessToken_weight (p : ℕ) (hp : p.Prime) :
    primeExcessTokenWeight (primeSquareEndpointExcessToken p hp) =
      Real.log (p : ℝ) := rfl

/-- Every external sink prime of the prime-square family is below `p`. -/
theorem primeSquareEndpoint_sinkPrime_lt
    {p : ℕ} (hp : p.Prime) (hpOdd : p ≠ 2)
    (q : PrimeSupportToken
      ((primeSquareEndpointPoint p hp).a * (primeSquareEndpointPoint p hp).b)) :
    primeSupportTokenPrime q < p := by
  have hmem : q.1 ∈ (p ^ 2 - 1).primeFactors := by
    simpa [primeSquareEndpointPoint] using q.2
  exact primeDivisor_sq_sub_one_lt hp hpOdd
    (Nat.prime_of_mem_primeFactors hmem)
    (Nat.mem_primeFactors.mp hmem).2.1

/-- The external sink tail above `p-1` is empty. -/
theorem primeSquareEndpoint_endpointSinkTail_eq_zero
    {p : ℕ} (hp : p.Prime) (hpOdd : p ≠ 2)
    (T : EndpointPrimeFlow (primeSquareEndpointPoint p hp)) :
    T.sinkTailMass (p - 1) = 0 := by
  classical
  unfold MonotoneWeightedFlow.sinkTailMass
  apply Finset.sum_eq_zero
  intro q hq
  have htail := (Finset.mem_filter.mp hq).2
  have hlt := primeSquareEndpoint_sinkPrime_lt hp hpOdd q
  change p - 1 < q.1 at htail
  change q.1 < p at hlt
  have hpPos := hp.pos
  omega

/-- The endpoint source tail above `p-1` contains a full `log p` token. -/
theorem primeSquareEndpoint_log_p_le_endpointSourceTail
    {p : ℕ} (hp : p.Prime)
    (T : EndpointPrimeFlow (primeSquareEndpointPoint p hp)) :
    Real.log (p : ℝ) ≤ T.sourceTailMass (p - 1) := by
  classical
  unfold MonotoneWeightedFlow.sourceTailMass
  have hmem : primeSquareEndpointExcessToken p hp ∈
      Finset.univ.filter (fun i => p - 1 < primeExcessTokenPrime i) := by
    apply Finset.mem_filter.mpr
    constructor
    · exact Finset.mem_univ _
    · change p - 1 < p
      exact Nat.sub_lt hp.pos (by norm_num)
  have hsingle := Finset.single_le_sum
    (s := Finset.univ.filter (fun i => p - 1 < primeExcessTokenPrime i))
    (f := fun i => primeExcessTokenWeight i)
    (fun i _ => Real.log_nonneg (by
      exact_mod_cast (Nat.prime_of_mem_primeFactors i.1.2).one_le)) hmem
  rw [primeSquareEndpointExcessToken_weight] at hsingle
  exact hsingle

/-- Every ordered endpoint flow leaves at least `log p` unmatched. -/
theorem primeSquareEndpoint_log_p_le_endpointUnmatched
    {p : ℕ} (hp : p.Prime) (hpOdd : p ≠ 2)
    (T : EndpointPrimeFlow (primeSquareEndpointPoint p hp)) :
    Real.log (p : ℝ) ≤ T.unmatchedMass := by
  have hHall := endpointPrimeFlow_threshold_obstruction
    (primeSquareEndpointPoint p hp) T (p - 1)
  rw [primeSquareEndpoint_endpointSinkTail_eq_zero hp hpOdd T, sub_zero] at hHall
  exact (primeSquareEndpoint_log_p_le_endpointSourceTail hp T).trans hHall

/-- The full radical of the prime-square family is at most `p^3`. -/
theorem primeSquareEndpoint_totalRadical_le_cube
    (p : ℕ) (hp : p.Prime) :
    totalRadical (primeSquareEndpointPoint p hp) ≤ p ^ 3 := by
  let P := primeSquareEndpointPoint p hp
  have hbpos : 0 < p ^ 2 - 1 := by
    have hpow : 1 < p ^ 2 := one_lt_pow₀ hp.one_lt (by norm_num)
    omega
  have hb : abcRadical (p ^ 2 - 1) ≤ p ^ 2 - 1 := by
    rw [abcRadical_eq_natRadical]
    exact Nat.radical_le_self_iff.mpr hbpos.ne'
  have hc : abcRadical (p ^ 2) ≤ p :=
    abcRadical_square_le_base p hp.pos
  have hprod := P.abcRadical_abcProduct
  unfold totalRadical
  rw [hprod]
  change abcRadical 1 * abcRadical (p ^ 2 - 1) * abcRadical (p ^ 2) ≤ p ^ 3
  have hmul : abcRadical 1 * abcRadical (p ^ 2 - 1) *
      abcRadical (p ^ 2) ≤ 1 * (p ^ 2 - 1) * p := by
    exact Nat.mul_le_mul (Nat.mul_le_mul (by norm_num [abcRadical]) hb) hc
  calc
    abcRadical 1 * abcRadical (p ^ 2 - 1) * abcRadical (p ^ 2) ≤
        1 * (p ^ 2 - 1) * p := hmul
    _ ≤ p ^ 2 * p := by
      simpa using Nat.mul_le_mul_right p (Nat.sub_le (p ^ 2) 1)
    _ = p ^ 3 := by ring

/-- Consequently the logarithmic conductor is at most `3 log p`. -/
theorem primeSquareEndpoint_conductor_le_three_log
    (p : ℕ) (hp : p.Prime) :
    (primeSquareEndpointPoint p hp).conductor ≤ 3 * Real.log (p : ℝ) := by
  let P := primeSquareEndpointPoint p hp
  have hrad := primeSquareEndpoint_totalRadical_le_cube p hp
  have hreal : (totalRadical P : ℝ) ≤ (p : ℝ) ^ 3 := by
    exact_mod_cast hrad
  have hlog := Real.log_le_log (by exact_mod_cast totalRadical_pos P) hreal
  change Real.log (totalRadical P : ℝ) ≤ 3 * Real.log (p : ℝ)
  simpa [Real.log_pow] using hlog

/-- The ordered endpoint-prime-flow gate is false on the infinite
prime-square endpoint family. -/
theorem not_uniformEndpointPrimeFlowBound :
    ¬ UniformEndpointPrimeFlowBound := by
  intro hgate
  obtain ⟨C, hC⟩ := hgate (1 / 4 : ℝ) (by norm_num)
  obtain ⟨n, hnLarge⟩ := exists_nat_gt (Real.exp (4 * C))
  obtain ⟨p, hpBound, hp⟩ := Nat.exists_infinite_primes (n + 3)
  have hpOdd : p ≠ 2 := by omega
  have hnle : n ≤ p := by omega
  have hExp : Real.exp (4 * C) < (p : ℝ) := by
    exact hnLarge.trans_le (by exact_mod_cast hnle)
  have hlogLarge : 4 * C < Real.log (p : ℝ) :=
    (Real.lt_log_iff_exp_lt (by exact_mod_cast hp.pos)).2 hExp
  let P := primeSquareEndpointPoint p hp
  obtain ⟨T, hT⟩ := hC P
  have hunmatched := primeSquareEndpoint_log_p_le_endpointUnmatched hp hpOdd T
  have hcond := primeSquareEndpoint_conductor_le_three_log p hp
  norm_num at hT
  nlinarith

/-! ## The same obstruction for every covering three-arm face -/

/-- A covering three-arm face must select the endpoint prime `p`. -/
theorem primeSquareEndpoint_p_mem_C_of_cover
    {p : ℕ} (hp : p.Prime)
    (F : Face (primeSquareEndpointPoint p hp))
    (hcover : F.CoversEndpoint) :
    p ∈ F.support .C := by
  by_contra hpNotMem
  have hCsubset : F.support .C ⊆ {p} := by
    have h := F.support_subset (.C : Arm)
    change F.support .C ⊆ (p ^ 2).primeFactors at h
    rw [Nat.primeFactors_prime_pow (by norm_num) hp] at h
    exact h
  have hCsupport : F.support .C = ∅ := by
    apply Finset.eq_empty_iff_forall_notMem.mpr
    intro q hq
    have hqp : q = p := by simpa using hCsubset hq
    subst q
    exact hpNotMem hq
  have hMA : F.armModulus .A = 1 := by
    have hdvd : F.armModulus .A ∣ 1 := by
      simpa [coordinate, primeSquareEndpointPoint] using
        F.armModulus_dvd_coordinate (.A : Arm)
    exact Nat.dvd_one.mp hdvd
  have hMB : F.armModulus .B ≤ p ^ 2 - 1 := by
    have hdvd : F.armModulus .B ∣ p ^ 2 - 1 := by
      simpa [coordinate, primeSquareEndpointPoint] using
        F.armModulus_dvd_coordinate (.B : Arm)
    have hbpos : 0 < p ^ 2 - 1 := by
      have hpow : 1 < p ^ 2 := one_lt_pow₀ hp.one_lt (by norm_num)
      omega
    exact Nat.le_of_dvd hbpos hdvd
  have hMC : F.armModulus .C = 1 := by
    rw [Face.armModulus, hCsupport]
    simp
  have hselected : F.selectedModulus =
      F.armModulus .A * F.armModulus .B * F.armModulus .C := by
    unfold Face.selectedModulus
    rw [show (Finset.univ : Finset Arm) = {.A, .B, .C} by
      ext r
      fin_cases r <;> simp]
    simp [mul_assoc]
  unfold Face.CoversEndpoint at hcover
  rw [hselected, hMA, hMC, one_mul, mul_one] at hcover
  change p ^ 2 ≤ F.armModulus .B at hcover
  have hpowPos : 0 < p ^ 2 := pow_pos hp.pos 2
  omega

/-- The selected endpoint vertex has valuation two in every face. -/
theorem primeSquareEndpoint_face_C_valuation
    {p : ℕ} (hp : p.Prime) :
    Face.valuation (primeSquareEndpointPoint p hp) .C p = 2 := by
  simp only [Face.valuation, coordinate, primeSquareEndpointPoint_c]
  exact Nat.factorization_pow_self hp

/-- The unique excess layer attached to a selected endpoint prime. -/
def primeSquareFaceExcessToken
    {p : ℕ} (hp : p.Prime)
    (F : Face (primeSquareEndpointPoint p hp))
    (hpMem : p ∈ F.support .C) : SelectedExcessToken F :=
  ⟨⟨.C, ⟨p, hpMem⟩⟩,
    ⟨0, by rw [primeSquareEndpoint_face_C_valuation hp]; omega⟩⟩

@[simp] theorem primeSquareFaceExcessToken_prime
    {p : ℕ} (hp : p.Prime)
    (F : Face (primeSquareEndpointPoint p hp))
    (hpMem : p ∈ F.support .C) :
    selectedExcessPrime (primeSquareFaceExcessToken hp F hpMem) = p := rfl

@[simp] theorem primeSquareFaceExcessToken_weight
    {p : ℕ} (hp : p.Prime)
    (F : Face (primeSquareEndpointPoint p hp))
    (hpMem : p ∈ F.support .C) :
    selectedExcessWeight (primeSquareFaceExcessToken hp F hpMem) =
      Real.log (p : ℝ) := rfl

/-- Once the endpoint prime is selected, every complementary prime is below
it. -/
theorem primeSquareFace_complementPrime_lt
    {p : ℕ} (hp : p.Prime) (hpOdd : p ≠ 2)
    (F : Face (primeSquareEndpointPoint p hp))
    (hpMem : p ∈ F.support .C) (q : ComplementPrimeToken F) :
    complementPrime q < p := by
  rcases q with ⟨r, q⟩
  rcases Finset.mem_sdiff.mp q.2 with ⟨hqAmbient, hqNotSelected⟩
  cases r with
  | A =>
      simp [coordinate, primeSquareEndpointPoint] at hqAmbient
  | B =>
      have hmem : q.1 ∈ (p ^ 2 - 1).primeFactors := by
        simpa [coordinate, primeSquareEndpointPoint] using hqAmbient
      exact primeDivisor_sq_sub_one_lt hp hpOdd
        (Nat.prime_of_mem_primeFactors hmem)
        (Nat.mem_primeFactors.mp hmem).2.1
  | C =>
      have hsingleton : (p ^ 2).primeFactors = {p} :=
        Nat.primeFactors_prime_pow (by norm_num) hp
      change q.1 ∈ (p ^ 2).primeFactors at hqAmbient
      rw [hsingleton] at hqAmbient
      have hqp : q.1 = p := by simpa using hqAmbient
      have hqSelected : q.1 ∈ F.support .C := by simpa [hqp] using hpMem
      exact False.elim (hqNotSelected hqSelected)

/-- The complementary sink tail above `p-1` is empty for a covering face. -/
theorem primeSquareFace_sinkTail_eq_zero
    {p : ℕ} (hp : p.Prime) (hpOdd : p ≠ 2)
    (F : Face (primeSquareEndpointPoint p hp))
    (hpMem : p ∈ F.support .C) (T : ComplementTransport F) :
    T.sinkTailMass (p - 1) = 0 := by
  classical
  unfold MonotoneWeightedFlow.sinkTailMass
  apply Finset.sum_eq_zero
  intro q hq
  have htail := (Finset.mem_filter.mp hq).2
  have hlt := primeSquareFace_complementPrime_lt hp hpOdd F hpMem q
  change p - 1 < complementPrime q at htail
  have hpPos := hp.pos
  omega

/-- The selected source tail above `p-1` contains the endpoint token. -/
theorem primeSquareFace_log_p_le_sourceTail
    {p : ℕ} (hp : p.Prime)
    (F : Face (primeSquareEndpointPoint p hp))
    (hpMem : p ∈ F.support .C) (T : ComplementTransport F) :
    Real.log (p : ℝ) ≤ T.sourceTailMass (p - 1) := by
  classical
  unfold MonotoneWeightedFlow.sourceTailMass
  have hmem : primeSquareFaceExcessToken hp F hpMem ∈
      Finset.univ.filter (fun i => p - 1 < selectedExcessPrime i) := by
    apply Finset.mem_filter.mpr
    constructor
    · exact Finset.mem_univ _
    · change p - 1 < p
      exact Nat.sub_lt hp.pos (by norm_num)
  have hsingle := Finset.single_le_sum
    (s := Finset.univ.filter (fun i => p - 1 < selectedExcessPrime i))
    (f := fun i => selectedExcessWeight i)
    (fun i _ => Real.log_nonneg (by
      exact_mod_cast (selectedExcessPrime_prime i).one_le)) hmem
  rw [primeSquareFaceExcessToken_weight] at hsingle
  exact hsingle

/-- Every complement transport on a covering face leaves `log p` unmatched. -/
theorem primeSquareFace_log_p_le_unmatched
    {p : ℕ} (hp : p.Prime) (hpOdd : p ≠ 2)
    (F : Face (primeSquareEndpointPoint p hp))
    (hcover : F.CoversEndpoint) (T : ComplementTransport F) :
    Real.log (p : ℝ) ≤ T.unmatchedMass := by
  have hpMem := primeSquareEndpoint_p_mem_C_of_cover hp F hcover
  have hHall := F.complementTransport_threshold_obstruction T (p - 1)
  rw [primeSquareFace_sinkTail_eq_zero hp hpOdd F hpMem T, sub_zero] at hHall
  exact (primeSquareFace_log_p_le_sourceTail hp F hpMem T).trans hHall

/-- The ordered three-arm complement-transport gate is false on the same
infinite complete-premise family. -/
theorem not_uniformThreeArmComplementTransportBound :
    ¬ UniformThreeArmComplementTransportBound := by
  intro hgate
  obtain ⟨C, hC⟩ := hgate (1 / 4 : ℝ) (by norm_num)
  obtain ⟨n, hnLarge⟩ := exists_nat_gt (Real.exp (4 * C))
  obtain ⟨p, hpBound, hp⟩ := Nat.exists_infinite_primes (n + 3)
  have hpOdd : p ≠ 2 := by omega
  have hnle : n ≤ p := by omega
  have hExp : Real.exp (4 * C) < (p : ℝ) := by
    exact hnLarge.trans_le (by exact_mod_cast hnle)
  have hlogLarge : 4 * C < Real.log (p : ℝ) :=
    (Real.lt_log_iff_exp_lt (by exact_mod_cast hp.pos)).2 hExp
  let P := primeSquareEndpointPoint p hp
  obtain ⟨F, T, hcover, hT⟩ := hC P
  have hunmatched := primeSquareFace_log_p_le_unmatched hp hpOdd F hcover T
  have hcond := primeSquareEndpoint_conductor_le_three_log p hp
  norm_num at hT
  nlinarith

end
end ABCThreeArmComplementTransportObstruction20260903
end IUTThreeClosures
