/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyRealPeriodAGMBarrier

/-!
# The critical Frey-period / Padé specialization barrier

For a positive primitive Frey triple, write

* `H = log c`,
* `R = log rad(abc)`,
* `Q = log (2 K(sqrt (b/c)))`, and
* `P = -log Ω = H/2-Q` for the primitive period of `dx/(2y)`.

The accompanying paper proves the analytic identities and the elementary
uniform sublinearity of `Q`.  This file isolates two non-circular arithmetic
consequences.

First, on any family on which `Q` is nonnegative and uniformly sublinear, the
all-epsilon critical period budget

`P <= (1/2+eta) R + O_eta(1)`

is equivalent to the all-epsilon abc budget

`H <= (1+epsilon) R + O_epsilon(1)`.

Second, a polynomial specialization at `T = 1/p^m`, written in descending
degree order, has cleared numerator

`u_0 + p^m (u_1 + p^m (...))`.

If `p` does not divide the leading coefficient `u_0`, it does not divide this
cleared numerator.  Thus the displayed `p^(mN)` denominator carrier cannot be
cancelled at `p`.  The interpretation for hypergeometric truncations and Padé
approximants is made in the paper; no theorem about special functions is
postulated here.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## Uniform all-epsilon budgets -/

/-- The abstract logarithmic abc budget on a family. -/
def UniformABCBudget {ι : Type*} (height radical : ι → ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ i : ι,
    height i ≤ (1 + ε) * radical i + C

/-- The abstract critical-exponent period budget on a family. -/
def UniformCriticalPeriodBudget {ι : Type*}
    (height kernel radical : ι → ℝ) : Prop :=
  ∀ η : ℝ, 0 < η → ∃ C : ℝ, ∀ i : ι,
    periodLogFromHeightKernel (height i) (kernel i) ≤
      (1 / 2 + η) * radical i + C

/-- The elliptic-integral kernel is uniformly absorbable into every positive
multiple of the height. -/
def UniformSublinearKernel {ι : Type*}
    (height kernel : ι → ℝ) : Prop :=
  ∀ δ : ℝ, 0 < δ → ∃ B : ℝ, ∀ i : ι,
    kernel i ≤ δ * height i + B

/-- An abc budget gives the critical period budget as soon as the analytic
kernel is nonnegative.  The epsilon loss is exactly divided by two. -/
theorem uniformCriticalPeriodBudget_of_uniformABCBudget
    {ι : Type*} {height kernel radical : ι → ℝ}
    (hkernel : ∀ i : ι, 0 ≤ kernel i)
    (habc : UniformABCBudget height radical) :
    UniformCriticalPeriodBudget height kernel radical := by
  intro η hη
  rcases habc (2 * η) (by positivity) with ⟨C, hC⟩
  refine ⟨C / 2, ?_⟩
  intro i
  have hi := hC i
  have hk := hkernel i
  unfold periodLogFromHeightKernel
  nlinarith

/-- Conversely, a critical period budget gives the abc budget when the kernel
is uniformly sublinear.  The radical is assumed nonnegative, as it is for
`log rad(abc)`.  All quantifiers, including the dependence of constants, are
visible in the statement. -/
theorem uniformABCBudget_of_uniformCriticalPeriodBudget
    {ι : Type*} {height kernel radical : ι → ℝ}
    (hradical : ∀ i : ι, 0 ≤ radical i)
    (hsublinear : UniformSublinearKernel height kernel)
    (hperiod : UniformCriticalPeriodBudget height kernel radical) :
    UniformABCBudget height radical := by
  intro ε hε
  let η : ℝ := ε / 8
  let δ : ℝ := ε / (8 * (1 + ε))
  have hone : 0 < 1 + ε := by nlinarith
  have heta : 0 < η := by
    dsimp [η]
    positivity
  have hδ : 0 < δ := by
    dsimp [δ]
    positivity
  have hδhalf : δ < 1 / 2 := by
    dsimp [δ]
    rw [div_lt_iff₀ (by positivity : (0 : ℝ) < 8 * (1 + ε))]
    nlinarith
  rcases hperiod η heta with ⟨C, hC⟩
  rcases hsublinear δ hδ with ⟨B, hB⟩
  let D : ℝ := 1 - 2 * δ
  have hD : 0 < D := by
    dsimp [D]
    nlinarith
  have hcoefficient :
      (1 + 2 * η) / D ≤ 1 + ε := by
    apply (div_le_iff₀ hD).2
    dsimp [D, η, δ]
    field_simp
    nlinarith
  refine ⟨2 * (C + B) / D, ?_⟩
  intro i
  have hheight := height_le_of_periodRadical_and_sublinearKernel
    hδhalf (hC i) (hB i)
  have hsplit :
      ((1 + 2 * η) * radical i + 2 * (C + B)) / D =
        ((1 + 2 * η) / D) * radical i + 2 * (C + B) / D := by
    field_simp
  rw [hsplit] at hheight
  exact hheight.trans (add_le_add
    (mul_le_mul_of_nonneg_right hcoefficient (hradical i)) le_rfl)

/-- On a family with a nonnegative uniformly sublinear kernel, the critical
period statement and the abc statement have exactly the same all-epsilon
logical strength. -/
theorem uniformCriticalPeriodBudget_iff_uniformABCBudget
    {ι : Type*} {height kernel radical : ι → ℝ}
    (hradical : ∀ i : ι, 0 ≤ radical i)
    (hkernel : ∀ i : ι, 0 ≤ kernel i)
    (hsublinear : UniformSublinearKernel height kernel) :
    UniformCriticalPeriodBudget height kernel radical ↔
      UniformABCBudget height radical := by
  constructor
  · exact uniformABCBudget_of_uniformCriticalPeriodBudget
      hradical hsublinear
  · exact uniformCriticalPeriodBudget_of_uniformABCBudget hkernel

/-! ## The sharp height-only coefficient -/

/-- No scalar lower-bound mechanism depending only on the height can replace
the coefficient `1/2` by a smaller uniform coefficient: for every proposed
coefficient and additive constant there is an explicit nonnegative height
model violating it, even with a fixed bounded kernel. -/
theorem heightOnlyPeriod_coefficient_oneHalf_sharp
    {α C B : ℝ} (hα : α < 1 / 2) :
    ∃ H : ℝ, 0 ≤ H ∧ H / 2 - B > α * H + C := by
  let d : ℝ := 1 / 2 - α
  let H : ℝ := (|C| + |B| + 1) / d
  have hd : 0 < d := by
    dsimp [d]
    linarith
  have hnum : 0 < |C| + |B| + 1 := by positivity
  have hH : 0 ≤ H := (div_pos hnum hd).le
  have hcancel : d * H = |C| + |B| + 1 := by
    dsimp [H]
    exact mul_div_cancel₀ (|C| + |B| + 1) hd.ne'
  refine ⟨H, hH, ?_⟩
  have hC : C ≤ |C| := le_abs_self C
  have hB : B ≤ |B| := le_abs_self B
  dsimp [d] at hcancel
  nlinarith

/-! ## Exact prime-depth carried by rational specialization -/

/-- Horner numerator after clearing powers of the specialization denominator.
The list starts with the leading coefficient. -/
def padeClearedNumerator (base : ℕ) : List ℕ → ℕ
  | [] => 0
  | u :: us => u + base * padeClearedNumerator base us

@[simp]
theorem padeClearedNumerator_nil (base : ℕ) :
    padeClearedNumerator base [] = 0 := rfl

@[simp]
theorem padeClearedNumerator_cons (base u : ℕ) (us : List ℕ) :
    padeClearedNumerator base (u :: us) =
      u + base * padeClearedNumerator base us := rfl

/-- If `m>0` and `p` does not divide the leading coefficient, clearing the
specialization `T=1/p^m` cannot create a numerator divisible by `p`. -/
theorem prime_not_dvd_padeClearedNumerator
    {p m u : ℕ} {us : List ℕ} (hm : 0 < m) (hu : ¬ p ∣ u) :
    ¬ p ∣ padeClearedNumerator (p ^ m) (u :: us) := by
  have hpow : p ∣ p ^ m := dvd_pow_self p hm.ne'
  have htail : p ∣ p ^ m * padeClearedNumerator (p ^ m) us :=
    dvd_mul_of_dvd_left hpow _
  intro htotal
  apply hu
  exact (Nat.dvd_add_iff_left htail).2 htotal

/-- The denominator carrier for a degree-`N` specialization at `1/p^m`. -/
def padeDenominatorCarrier (p m N : ℕ) : ℕ :=
  p ^ (m * N)

/-- Its exact `p`-adic depth is the product `m*N`. -/
theorem padeDenominatorCarrier_factorization
    {p : ℕ} (hp : p.Prime) (m N : ℕ) :
    (padeDenominatorCarrier p m N).factorization p = m * N := by
  unfold padeDenominatorCarrier
  exact Nat.factorization_pow_self hp

/-- Even at a fixed prime and fixed positive degree, the specialization depth
is unbounded. -/
theorem padeDenominatorCarrier_depth_unbounded
    {p : ℕ} (hp : p.Prime) (N B : ℕ) (hN : 0 < N) :
    B < (padeDenominatorCarrier p (B + 1) N).factorization p := by
  rw [padeDenominatorCarrier_factorization hp]
  calc
    B < B + 1 := Nat.lt_succ_self B
    _ = (B + 1) * 1 := by simp
    _ ≤ (B + 1) * N := Nat.mul_le_mul_left (B + 1) hN

end

end IUTThreeClosures
