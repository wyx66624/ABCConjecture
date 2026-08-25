import IUTThreeClosures.PolynomialGaussPointOrbit
import Mathlib.Algebra.Polynomial.Laurent

/-!
# Laurent extension of polynomial Gauss points

For a positive radius `r`, this file extends the polynomial Gauss absolute
value from `K[X]` to the localization `K[T,T⁻¹]`.  The construction uses an
actual shifted-polynomial presentation supplied by
`LaurentPolynomial.exists_T_pow`; independence of that presentation is
proved from polynomial Gauss multiplicativity.

This is the algebraic Laurent polynomial ring of finite sums.  It is not a
Tate-algebra or annulus completion, the full Berkovich multiplicative group,
or a rigid/adic analytic quotient.
-/

noncomputable section

open Polynomial
open scoped LaurentPolynomial

namespace IUTThreeClosures
namespace LaurentGaussPointOrbit

open PolynomialGaussPointOrbit LaurentPolynomial

variable {K : Type*} [NormedField K] [IsUltrametricDist K]

/-! ## Shifted polynomial representatives -/

/-- A chosen nonnegative exponent clearing all negative Laurent powers. -/
def shiftExponent (f : K[T;T⁻¹]) : ℕ :=
  (LaurentPolynomial.exists_T_pow f).choose

/-- The chosen polynomial numerator after clearing negative Laurent powers. -/
def shiftNumerator (f : K[T;T⁻¹]) : K[X] :=
  (LaurentPolynomial.exists_T_pow f).choose_spec.choose

omit [IsUltrametricDist K] in
/-- The chosen numerator really represents `f * T ^ shiftExponent f`. -/
theorem shiftNumerator_spec (f : K[T;T⁻¹]) :
    Polynomial.toLaurent (shiftNumerator f) =
      f * LaurentPolynomial.T (shiftExponent f) :=
  (LaurentPolynomial.exists_T_pow f).choose_spec.choose_spec

/-- The candidate Laurent Gauss norm obtained from a shifted polynomial
numerator. -/
def laurentGaussNorm (r : ℝ) (hr : 0 < r) (f : K[T;T⁻¹]) : ℝ :=
  gaussPoint r hr (shiftNumerator f) / r ^ shiftExponent f

/-- Any shifted-polynomial presentation computes the same Laurent Gauss
value.  This is the key well-definedness theorem. -/
theorem laurentGaussNorm_eq_of_toLaurent_eq_mul_T
    (r : ℝ) (hr : 0 < r) (f : K[T;T⁻¹]) (p : K[X]) (n : ℕ)
    (hp : Polynomial.toLaurent p = f * LaurentPolynomial.T n) :
    laurentGaussNorm r hr f = gaussPoint r hr p / r ^ n := by
  let N := shiftExponent f
  let P := shiftNumerator f
  have hP : Polynomial.toLaurent P = f * LaurentPolynomial.T N := by
    simpa [P, N] using shiftNumerator_spec f
  have hpoly : p * X ^ N = P * X ^ n := by
    apply Polynomial.toLaurent_injective
    simp only [map_mul, Polynomial.toLaurent_X_pow, hp, hP,
      LaurentPolynomial.mul_T_assoc]
    rw [add_comm (n : ℤ) (N : ℤ)]
  have hnorm := congrArg (gaussPoint r hr) hpoly
  simp only [map_mul, map_pow, gaussPoint_X] at hnorm
  unfold laurentGaussNorm
  change gaussPoint r hr P / r ^ N = gaussPoint r hr p / r ^ n
  apply (div_eq_div_iff (pow_ne_zero N hr.ne') (pow_ne_zero n hr.ne')).mpr
  exact hnorm.symm

@[simp]
theorem laurentGaussNorm_zero (r : ℝ) (hr : 0 < r) :
    laurentGaussNorm r hr (0 : K[T;T⁻¹]) = 0 := by
  rw [laurentGaussNorm_eq_of_toLaurent_eq_mul_T r hr 0 0 0 (by simp)]
  simp

@[simp]
theorem laurentGaussNorm_one (r : ℝ) (hr : 0 < r) :
    laurentGaussNorm r hr (1 : K[T;T⁻¹]) = 1 := by
  rw [laurentGaussNorm_eq_of_toLaurent_eq_mul_T r hr 1 1 0 (by simp)]
  simp [gaussPoint]

theorem laurentGaussNorm_nonneg (r : ℝ) (hr : 0 < r) (f : K[T;T⁻¹]) :
    0 ≤ laurentGaussNorm r hr f := by
  exact div_nonneg ((gaussPoint r hr).nonneg _) (pow_nonneg hr.le _)

theorem laurentGaussNorm_eq_zero_iff (r : ℝ) (hr : 0 < r) (f : K[T;T⁻¹]) :
    laurentGaussNorm r hr f = 0 ↔ f = 0 := by
  constructor
  · intro hf
    have hnum : gaussPoint r hr (shiftNumerator f) = 0 := by
      have hden : r ^ shiftExponent f ≠ 0 := pow_ne_zero _ hr.ne'
      exact (div_eq_zero_iff).mp hf |>.resolve_right hden
    have hp : shiftNumerator f = 0 := (gaussPoint r hr).eq_zero.mp hnum
    apply (mul_right_inj_of_invertible
      (LaurentPolynomial.T (shiftExponent f) : K[T;T⁻¹])).mp
    simpa [hp] using (shiftNumerator_spec f).symm
  · rintro rfl
    exact laurentGaussNorm_zero r hr

theorem laurentGaussNorm_mul (r : ℝ) (hr : 0 < r) (f g : K[T;T⁻¹]) :
    laurentGaussNorm r hr (f * g) =
      laurentGaussNorm r hr f * laurentGaussNorm r hr g := by
  let N := shiftExponent f
  let M := shiftExponent g
  let P := shiftNumerator f
  let Q := shiftNumerator g
  have hP : Polynomial.toLaurent P = f * LaurentPolynomial.T N := by
    simpa [P, N] using shiftNumerator_spec f
  have hQ : Polynomial.toLaurent Q = g * LaurentPolynomial.T M := by
    simpa [Q, M] using shiftNumerator_spec g
  have hPQ : Polynomial.toLaurent (P * Q) =
      (f * g) * LaurentPolynomial.T (N + M) := by
    simp only [map_mul, hP, hQ, LaurentPolynomial.T_add]
    ring
  rw [laurentGaussNorm_eq_of_toLaurent_eq_mul_T r hr (f * g) (P * Q) (N + M) hPQ,
    laurentGaussNorm_eq_of_toLaurent_eq_mul_T r hr f P N hP,
    laurentGaussNorm_eq_of_toLaurent_eq_mul_T r hr g Q M hQ,
    map_mul, pow_add]
  field_simp [pow_ne_zero N hr.ne', pow_ne_zero M hr.ne']

theorem laurentGaussNorm_add_le (r : ℝ) (hr : 0 < r) (f g : K[T;T⁻¹]) :
    laurentGaussNorm r hr (f + g) ≤
      laurentGaussNorm r hr f + laurentGaussNorm r hr g := by
  let N := shiftExponent f
  let M := shiftExponent g
  let P := shiftNumerator f
  let Q := shiftNumerator g
  have hP : Polynomial.toLaurent P = f * LaurentPolynomial.T N := by
    simpa [P, N] using shiftNumerator_spec f
  have hQ : Polynomial.toLaurent Q = g * LaurentPolynomial.T M := by
    simpa [Q, M] using shiftNumerator_spec g
  have hsum : Polynomial.toLaurent (P * X ^ M + Q * X ^ N) =
      (f + g) * LaurentPolynomial.T (N + M) := by
    simp only [map_add, map_mul, Polynomial.toLaurent_X_pow, hP, hQ,
      LaurentPolynomial.mul_T_assoc]
    rw [add_comm (M : ℤ) (N : ℤ)]
    ring
  rw [laurentGaussNorm_eq_of_toLaurent_eq_mul_T r hr (f + g)
      (P * X ^ M + Q * X ^ N) (N + M) hsum,
    laurentGaussNorm_eq_of_toLaurent_eq_mul_T r hr f P N hP,
    laurentGaussNorm_eq_of_toLaurent_eq_mul_T r hr g Q M hQ,
    pow_add]
  calc
    gaussPoint r hr (P * X ^ M + Q * X ^ N) / (r ^ N * r ^ M)
        ≤ (gaussPoint r hr (P * X ^ M) + gaussPoint r hr (Q * X ^ N)) /
            (r ^ N * r ^ M) := by
          exact div_le_div_of_nonneg_right ((gaussPoint r hr).add_le _ _)
            (mul_nonneg (pow_nonneg hr.le _) (pow_nonneg hr.le _))
    _ = gaussPoint r hr P / r ^ N + gaussPoint r hr Q / r ^ M := by
      simp only [map_mul, map_pow, gaussPoint_X]
      field_simp [pow_ne_zero N hr.ne', pow_ne_zero M hr.ne']

/-- The honest bundled Laurent Gauss absolute value. -/
def laurentGaussPoint (r : ℝ) (hr : 0 < r) : AbsoluteValue K[T;T⁻¹] ℝ where
  toFun := laurentGaussNorm r hr
  map_mul' := laurentGaussNorm_mul r hr
  nonneg' := laurentGaussNorm_nonneg r hr
  eq_zero' := laurentGaussNorm_eq_zero_iff r hr
  add_le' := laurentGaussNorm_add_le r hr

@[simp]
theorem laurentGaussPoint_apply (r : ℝ) (hr : 0 < r) (f : K[T;T⁻¹]) :
    laurentGaussPoint r hr f = laurentGaussNorm r hr f :=
  rfl

/-! ## Exact extension and radius recovery -/

/-- The Laurent Gauss point strictly extends the polynomial Gauss point. -/
@[simp]
theorem laurentGaussPoint_toLaurent (r : ℝ) (hr : 0 < r) (p : K[X]) :
    laurentGaussPoint r hr (Polynomial.toLaurent p) = gaussPoint r hr p := by
  rw [laurentGaussPoint_apply,
    laurentGaussNorm_eq_of_toLaurent_eq_mul_T r hr (Polynomial.toLaurent p) p 0 (by simp)]
  simp

/-- The Laurent variable has value exactly `r`. -/
@[simp]
theorem laurentGaussPoint_T_one (r : ℝ) (hr : 0 < r) :
    laurentGaussPoint r hr (LaurentPolynomial.T 1 : K[T;T⁻¹]) = r := by
  rw [← Polynomial.toLaurent_X, laurentGaussPoint_toLaurent, gaussPoint_X]

/-- The inverse Laurent variable has value exactly `r⁻¹`. -/
@[simp]
theorem laurentGaussPoint_T_neg_one (r : ℝ) (hr : 0 < r) :
    laurentGaussPoint r hr (LaurentPolynomial.T (-1) : K[T;T⁻¹]) = r⁻¹ := by
  rw [laurentGaussPoint_apply,
    laurentGaussNorm_eq_of_toLaurent_eq_mul_T r hr
      (LaurentPolynomial.T (-1)) 1 1]
  · simp [gaussPoint, div_eq_mul_inv]
  · rw [Polynomial.toLaurent_one, ← LaurentPolynomial.T_add]
    norm_num

/-- Evaluation at `T` recovers the radius. -/
theorem laurentGaussPoint_injective :
    Function.Injective
      (fun r : Set.Ioi (0 : ℝ) => laurentGaussPoint (K := K) r.1 r.2) := by
  intro r s hrs
  have hT := congrArg
    (fun v : AbsoluteValue K[T;T⁻¹] ℝ => v (LaurentPolynomial.T 1)) hrs
  apply Subtype.ext
  exact (laurentGaussPoint_T_one r.1 r.2).symm.trans
    (hT.trans (laurentGaussPoint_T_one s.1 s.2))

/-! ## Laurent variable scaling -/

/-- The unit `qT` in the Laurent polynomial ring, for `q ≠ 0`. -/
def scaledTUnit (q : K) (hq : q ≠ 0) : (K[T;T⁻¹])ˣ where
  val := LaurentPolynomial.C q * LaurentPolynomial.T 1
  inv := LaurentPolynomial.C q⁻¹ * LaurentPolynomial.T (-1)
  val_inv := by
    rw [mul_mul_mul_comm, ← map_mul, ← LaurentPolynomial.T_add]
    simp [hq]
  inv_val := by
    rw [mul_mul_mul_comm, ← map_mul, ← LaurentPolynomial.T_add]
    simp [hq]

omit [IsUltrametricDist K] in
@[simp]
theorem scaledTUnit_val (q : K) (hq : q ≠ 0) :
    ((scaledTUnit q hq : (K[T;T⁻¹])ˣ) : K[T;T⁻¹]) =
      LaurentPolynomial.C q * LaurentPolynomial.T 1 :=
  rfl

/-- The Laurent-ring homomorphism which substitutes `T ↦ qT`. -/
def laurentVariableScaleHom (q : K) (hq : q ≠ 0) :
    K[T;T⁻¹] →+* K[T;T⁻¹] :=
  LaurentPolynomial.eval₂ LaurentPolynomial.C (scaledTUnit q hq)

omit [IsUltrametricDist K] in
@[simp]
theorem laurentVariableScaleHom_C (q : K) (hq : q ≠ 0) (a : K) :
    laurentVariableScaleHom q hq (LaurentPolynomial.C a) = LaurentPolynomial.C a := by
  simp [laurentVariableScaleHom]

omit [IsUltrametricDist K] in
@[simp]
theorem laurentVariableScaleHom_T (q : K) (hq : q ≠ 0) (n : ℤ) :
    laurentVariableScaleHom q hq (LaurentPolynomial.T n) =
      LaurentPolynomial.C (q ^ n) * LaurentPolynomial.T n := by
  by_cases! hn : 0 ≤ n
  · lift n to ℕ using hn
    rw [laurentVariableScaleHom, LaurentPolynomial.eval₂_T_n]
    change (((scaledTUnit q hq) ^ n : (K[T;T⁻¹])ˣ) : K[T;T⁻¹]) = _
    rw [Units.val_pow_eq_pow_val]
    change (LaurentPolynomial.C q * LaurentPolynomial.T 1) ^ n = _
    rw [mul_pow, ← map_pow]
    simp
  · obtain ⟨m, rfl⟩ := Int.exists_eq_neg_ofNat hn.le
    rw [laurentVariableScaleHom, LaurentPolynomial.eval₂_T_neg_n]
    change ((((scaledTUnit q hq)⁻¹) ^ m : (K[T;T⁻¹])ˣ) : K[T;T⁻¹]) = _
    rw [Units.val_pow_eq_pow_val]
    change (LaurentPolynomial.C q⁻¹ * LaurentPolynomial.T (-1)) ^ m = _
    rw [mul_pow, ← map_pow]
    simp

/-- The `K`-algebra homomorphism `f(T) ↦ f(qT)`. -/
def laurentVariableScaleAlgHom (q : K) (hq : q ≠ 0) :
    K[T;T⁻¹] →ₐ[K] K[T;T⁻¹] where
  toRingHom := laurentVariableScaleHom q hq
  commutes' a := by
    change laurentVariableScaleHom q hq (LaurentPolynomial.C a) =
      LaurentPolynomial.C a
    exact laurentVariableScaleHom_C q hq a

omit [IsUltrametricDist K] in
@[simp]
theorem laurentVariableScaleAlgHom_C (q : K) (hq : q ≠ 0) (a : K) :
    laurentVariableScaleAlgHom q hq (LaurentPolynomial.C a) = LaurentPolynomial.C a := by
  exact laurentVariableScaleHom_C q hq a

omit [IsUltrametricDist K] in
@[simp]
theorem laurentVariableScaleAlgHom_T (q : K) (hq : q ≠ 0) (n : ℤ) :
    laurentVariableScaleAlgHom q hq (LaurentPolynomial.T n) =
      LaurentPolynomial.C (q ^ n) * LaurentPolynomial.T n := by
  exact laurentVariableScaleHom_T q hq n

omit [IsUltrametricDist K] in
/-- Laurent scaling restricts exactly to polynomial variable scaling. -/
@[simp]
theorem laurentVariableScaleAlgHom_toLaurent
    (q : K) (hq : q ≠ 0) (p : K[X]) :
    laurentVariableScaleAlgHom q hq (Polynomial.toLaurent p) =
      Polynomial.toLaurent (variableScale q hq p) := by
  have hcomp :
      (laurentVariableScaleAlgHom q hq).comp Polynomial.toLaurentAlg =
        Polynomial.toLaurentAlg.comp (variableScale q hq).toAlgHom := by
    apply Polynomial.algHom_ext
    simp
  exact DFunLike.congr_fun hcomp p

/-- Substitution `T ↦ qT` is a Laurent `K`-algebra automorphism. -/
def laurentVariableScale (q : K) (hq : q ≠ 0) :
    K[T;T⁻¹] ≃ₐ[K] K[T;T⁻¹] := by
  let hqi : q⁻¹ ≠ 0 := inv_ne_zero hq
  refine AlgEquiv.ofAlgHom
    (laurentVariableScaleAlgHom q hq)
    (laurentVariableScaleAlgHom q⁻¹ hqi) ?_ ?_
  · apply AlgHom.ext
    intro f
    induction f using LaurentPolynomial.induction_on' with
    | add p s hp hs => simp only [map_add, hp, hs]
    | C_mul_T n a =>
        change laurentVariableScaleAlgHom q hq
          (laurentVariableScaleAlgHom q⁻¹ hqi
            (LaurentPolynomial.C a * LaurentPolynomial.T n)) =
              LaurentPolynomial.C a * LaurentPolynomial.T n
        simp only [map_mul, laurentVariableScaleAlgHom_C,
          laurentVariableScaleAlgHom_T]
        congr 1
        rw [inv_zpow, ← mul_assoc, ← map_mul]
        simp [zpow_ne_zero n hq]
  · apply AlgHom.ext
    intro f
    induction f using LaurentPolynomial.induction_on' with
    | add p s hp hs => simp only [map_add, hp, hs]
    | C_mul_T n a =>
        change laurentVariableScaleAlgHom q⁻¹ hqi
          (laurentVariableScaleAlgHom q hq
            (LaurentPolynomial.C a * LaurentPolynomial.T n)) =
              LaurentPolynomial.C a * LaurentPolynomial.T n
        simp only [map_mul, laurentVariableScaleAlgHom_C,
          laurentVariableScaleAlgHom_T]
        congr 1
        rw [inv_zpow, ← mul_assoc, ← map_mul]
        simp [zpow_ne_zero n hq]

omit [IsUltrametricDist K] in
@[simp]
theorem laurentVariableScale_apply (q : K) (hq : q ≠ 0) (f : K[T;T⁻¹]) :
    laurentVariableScale q hq f = laurentVariableScaleAlgHom q hq f :=
  rfl

omit [IsUltrametricDist K] in
@[simp]
theorem laurentVariableScale_C (q : K) (hq : q ≠ 0) (a : K) :
    laurentVariableScale q hq (LaurentPolynomial.C a) = LaurentPolynomial.C a := by
  exact laurentVariableScaleAlgHom_C q hq a

omit [IsUltrametricDist K] in
@[simp]
theorem laurentVariableScale_T (q : K) (hq : q ≠ 0) (n : ℤ) :
    laurentVariableScale q hq (LaurentPolynomial.T n) =
      LaurentPolynomial.C (q ^ n) * LaurentPolynomial.T n := by
  exact laurentVariableScaleAlgHom_T q hq n

omit [IsUltrametricDist K] in
@[simp]
theorem laurentVariableScale_toLaurent
    (q : K) (hq : q ≠ 0) (p : K[X]) :
    laurentVariableScale q hq (Polynomial.toLaurent p) =
      Polynomial.toLaurent (variableScale q hq p) := by
  exact laurentVariableScaleAlgHom_toLaurent q hq p

/-! ## Exact Laurent covariance -/

/-- On constants, the Laurent Gauss point is the original field norm. -/
@[simp]
theorem laurentGaussPoint_C (r : ℝ) (hr : 0 < r) (a : K) :
    laurentGaussPoint r hr (LaurentPolynomial.C a) = ‖a‖ := by
  rw [← Polynomial.toLaurent_C, laurentGaussPoint_toLaurent, gaussPoint_C]

/-- Every integral Laurent power has the expected value `r^n`. -/
@[simp]
theorem laurentGaussPoint_T (r : ℝ) (hr : 0 < r) (n : ℤ) :
    laurentGaussPoint r hr (LaurentPolynomial.T n : K[T;T⁻¹]) = r ^ n := by
  by_cases! hn : 0 ≤ n
  · lift n to ℕ using hn
    have hT : (LaurentPolynomial.T (n : ℤ) : K[T;T⁻¹]) =
        LaurentPolynomial.T 1 ^ n := by
      rw [LaurentPolynomial.T_pow]
      simp
    rw [hT, map_pow, laurentGaussPoint_T_one]
    simp
  · obtain ⟨m, rfl⟩ := Int.exists_eq_neg_ofNat hn.le
    have hT : (LaurentPolynomial.T (-(m : ℤ)) : K[T;T⁻¹]) =
        LaurentPolynomial.T (-1) ^ m := by
      rw [LaurentPolynomial.T_pow]
      simp
    rw [hT, map_pow, laurentGaussPoint_T_neg_one]
    simp

omit [IsUltrametricDist K] in
/-- If `p = f T^n`, then `q^{-n} p(qX)` is the polynomial numerator of
the scaled Laurent polynomial with the same denominator `T^n`. -/
theorem laurentVariableScale_presentation
    (q : K) (hq : q ≠ 0) (f : K[T;T⁻¹]) (p : K[X]) (n : ℕ)
    (hp : Polynomial.toLaurent p = f * LaurentPolynomial.T n) :
    Polynomial.toLaurent
        (Polynomial.C (q⁻¹ ^ n) * variableScale q hq p) =
      laurentVariableScale q hq f * LaurentPolynomial.T n := by
  have hscaled := congrArg (laurentVariableScale q hq) hp
  simp only [map_mul, laurentVariableScale_toLaurent,
    laurentVariableScale_T, zpow_natCast] at hscaled
  rw [map_mul, Polynomial.toLaurent_C, hscaled]
  calc
    LaurentPolynomial.C (q⁻¹ ^ n) *
          (laurentVariableScale q hq f *
            (LaurentPolynomial.C (q ^ n) * LaurentPolynomial.T n)) =
        laurentVariableScale q hq f *
          (LaurentPolynomial.C (q⁻¹ ^ n) * LaurentPolynomial.C (q ^ n)) *
            LaurentPolynomial.T n := by ring
    _ = laurentVariableScale q hq f * LaurentPolynomial.T n := by
      rw [← map_mul, ← mul_pow, inv_mul_cancel₀ hq, one_pow, map_one,
        mul_one]

/-- Exact covariance of Laurent Gauss points under the automorphism
`T ↦ qT`: the radius is multiplied by `‖q‖`. -/
theorem laurentGaussPoint_variableScale
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) (f : K[T;T⁻¹]) :
    laurentGaussPoint r hr (laurentVariableScale q hq f) =
      laurentGaussPoint (‖q‖ * r)
        (mul_pos (norm_pos_iff.mpr hq) hr) f := by
  let n := shiftExponent f
  let p := shiftNumerator f
  have hp : Polynomial.toLaurent p = f * LaurentPolynomial.T n := by
    simpa [p, n] using shiftNumerator_spec f
  have hscaled : Polynomial.toLaurent
        (Polynomial.C (q⁻¹ ^ n) * variableScale q hq p) =
      laurentVariableScale q hq f * LaurentPolynomial.T n :=
    laurentVariableScale_presentation q hq f p n hp
  rw [laurentGaussPoint_apply,
    laurentGaussNorm_eq_of_toLaurent_eq_mul_T r hr
      (laurentVariableScale q hq f)
      (Polynomial.C (q⁻¹ ^ n) * variableScale q hq p) n hscaled,
    laurentGaussPoint_apply,
    laurentGaussNorm_eq_of_toLaurent_eq_mul_T (‖q‖ * r)
      (mul_pos (norm_pos_iff.mpr hq) hr) f p n hp,
    map_mul, gaussPoint_C,
    gaussPoint_variableScale q hq r hr p,
    norm_pow, norm_inv, inv_pow, mul_pow]
  field_simp [pow_ne_zero n (norm_ne_zero_iff.mpr hq), pow_ne_zero n hr.ne']

/-- Pullback of a Laurent Gauss point along `T ↦ qT`. -/
def pullbackLaurentGaussPoint
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    AbsoluteValue K[T;T⁻¹] ℝ :=
  (laurentGaussPoint r hr).comp (laurentVariableScale q hq).injective

/-- Bundled form of exact Laurent covariance. -/
theorem pullbackLaurentGaussPoint_eq
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    pullbackLaurentGaussPoint q hq r hr =
      laurentGaussPoint (‖q‖ * r)
        (mul_pos (norm_pos_iff.mpr hq) hr) := by
  ext f
  exact laurentGaussPoint_variableScale q hq r hr f

end LaurentGaussPointOrbit
end IUTThreeClosures
