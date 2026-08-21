import IUTThreeClosures.ABCFreyCurve
import IUTThreeClosures.LegendreHeightCorridor

/-!
# Reduced numerator/denominator control for the Frey `j`-invariant

For an abc point `P`, put

* `H = a² + ab + b²`,
* `N = 256 H³`,
* `D = (abc)²`,
* `g = gcd N D`.

The point-dependent part `H³` is coprime to `D`, hence every common
factor of `N` and `D` divides the fixed integer `256`. Consequently the
reduced numerator `N/g` still contains the whole factor `H³`. This is the
arithmetic input needed to compare the actual rational Weil height of the
Frey `j`-invariant with `6 log c` without inserting an arbitrary height
function into the downstream bridge.
-/

namespace IUTThreeClosures

namespace ABCPoint

/-- The unreduced numerator of the Frey `j`-invariant. -/
def freyJRawNum (P : ABCPoint) : ℕ :=
  256 * P.legendreCore ^ 3

/-- The unreduced denominator of the Frey `j`-invariant. -/
def freyJRawDen (P : ABCPoint) : ℕ :=
  (P.a * P.b * P.c) ^ 2

/-- The common factor removed when the Frey `j`-invariant is reduced. -/
def freyJContent (P : ABCPoint) : ℕ :=
  Nat.gcd P.freyJRawNum P.freyJRawDen

/-- The reduced natural numerator. -/
def freyJReducedNum (P : ABCPoint) : ℕ :=
  P.freyJRawNum / P.freyJContent

/-- The reduced natural denominator. -/
def freyJReducedDen (P : ABCPoint) : ℕ :=
  P.freyJRawDen / P.freyJContent

@[simp]
theorem freyJRawNum_pos (P : ABCPoint) : 0 < P.freyJRawNum := by
  unfold freyJRawNum
  exact mul_pos (by norm_num) (pow_pos P.legendreCore_pos 3)

@[simp]
theorem freyJRawDen_pos (P : ABCPoint) : 0 < P.freyJRawDen := by
  unfold freyJRawDen
  exact pow_pos (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos) 2

@[simp]
theorem freyJContent_pos (P : ABCPoint) : 0 < P.freyJContent := by
  unfold freyJContent
  exact Nat.gcd_pos_of_pos_right _ P.freyJRawDen_pos

@[simp]
theorem freyJReducedNum_pos (P : ABCPoint) : 0 < P.freyJReducedNum := by
  apply Nat.div_pos
  · exact Nat.le_of_dvd P.freyJRawNum_pos
      (Nat.gcd_dvd_left P.freyJRawNum P.freyJRawDen)
  · exact P.freyJContent_pos

@[simp]
theorem freyJReducedDen_pos (P : ABCPoint) : 0 < P.freyJReducedDen := by
  apply Nat.div_pos
  · exact Nat.le_of_dvd P.freyJRawDen_pos
      (Nat.gcd_dvd_right P.freyJRawNum P.freyJRawDen)
  · exact P.freyJContent_pos

/-- The reduced numerator and denominator are coprime. -/
theorem freyJReduced_coprime (P : ABCPoint) :
    Nat.Coprime P.freyJReducedNum P.freyJReducedDen := by
  simpa [freyJReducedNum, freyJReducedDen, freyJContent] using
    Nat.coprime_div_gcd_div_gcd
      (m := P.freyJRawNum) (n := P.freyJRawDen) P.freyJContent_pos

/-- Recover the unreduced numerator from the reduced numerator and the gcd
content. -/
theorem freyJReducedNum_mul_content (P : ABCPoint) :
    P.freyJReducedNum * P.freyJContent = P.freyJRawNum := by
  exact Nat.div_mul_cancel
    (Nat.gcd_dvd_left P.freyJRawNum P.freyJRawDen)

/-- Recover the unreduced denominator from the reduced denominator and the gcd
content. -/
theorem freyJReducedDen_mul_content (P : ABCPoint) :
    P.freyJReducedDen * P.freyJContent = P.freyJRawDen := by
  exact Nat.div_mul_cancel
    (Nat.gcd_dvd_right P.freyJRawNum P.freyJRawDen)

/-- Cancellation in the Frey `j`-invariant is confined to the fixed factor
`256`; no prime from `H` can cancel against `(abc)²`. -/
theorem freyJContent_dvd_256 (P : ABCPoint) :
    P.freyJContent ∣ 256 := by
  have hcop : Nat.Coprime (P.legendreCore ^ 3) P.freyJRawDen := by
    simpa [freyJRawDen] using
      (P.coprime_abc_legendreCore.symm.pow_left 3).pow_right 2
  have hcontent_coprime :
      Nat.Coprime P.freyJContent (P.legendreCore ^ 3) := by
    have hright : P.freyJContent ∣ P.freyJRawDen := by
      simpa [freyJContent] using
        Nat.gcd_dvd_right P.freyJRawNum P.freyJRawDen
    exact (hcop.of_dvd_right hright).symm
  apply hcontent_coprime.dvd_of_dvd_mul_right
  simpa [freyJContent, freyJRawNum] using
    Nat.gcd_dvd_left P.freyJRawNum P.freyJRawDen

/-- Uniform numerical bound for the cancellation content. -/
theorem freyJContent_le_256 (P : ABCPoint) :
    P.freyJContent ≤ 256 :=
  Nat.le_of_dvd (by norm_num) P.freyJContent_dvd_256

/-- The complete point-dependent factor `H³` survives in the reduced
numerator. -/
theorem legendreCore_cube_dvd_freyJReducedNum (P : ABCPoint) :
    P.legendreCore ^ 3 ∣ P.freyJReducedNum := by
  rcases P.freyJContent_dvd_256 with ⟨k, hk⟩
  refine ⟨k, ?_⟩
  unfold freyJReducedNum freyJRawNum
  rw [hk]
  calc
    (P.freyJContent * k * P.legendreCore ^ 3) / P.freyJContent =
        P.freyJContent * (k * P.legendreCore ^ 3) / P.freyJContent := by
      congr 1
      ring
    _ = k * P.legendreCore ^ 3 :=
      Nat.mul_div_right _ P.freyJContent_pos
    _ = P.legendreCore ^ 3 * k := Nat.mul_comm _ _

/-- Lower bound for the reduced numerator. -/
theorem legendreCore_cube_le_freyJReducedNum (P : ABCPoint) :
    P.legendreCore ^ 3 ≤ P.freyJReducedNum :=
  Nat.le_of_dvd P.freyJReducedNum_pos
    P.legendreCore_cube_dvd_freyJReducedNum

/-- The reduced numerator already controls `c⁶`, with an absolute factor `8`. -/
theorem c_pow_six_le_eight_freyJReducedNum (P : ABCPoint) :
    P.c ^ 6 ≤ 8 * P.freyJReducedNum := by
  calc
    P.c ^ 6 = (P.c ^ 2) ^ 3 := by ring
    _ ≤ (2 * P.legendreCore) ^ 3 := by
      gcongr
      exact P.c_sq_le_two_legendreCore
    _ = 8 * P.legendreCore ^ 3 := by ring
    _ ≤ 8 * P.freyJReducedNum :=
      Nat.mul_le_mul_left 8 P.legendreCore_cube_le_freyJReducedNum

/-- The reduced numerator has the expected `O(c⁶)` upper bound. -/
theorem freyJReducedNum_le (P : ABCPoint) :
    P.freyJReducedNum ≤ 256 * P.c ^ 6 := by
  have hcube : P.legendreCore ^ 3 ≤ (P.c ^ 2) ^ 3 := by
    gcongr
    exact P.legendreCore_le_c_sq
  calc
    P.freyJReducedNum ≤ P.freyJRawNum := Nat.div_le_self _ _
    _ = 256 * P.legendreCore ^ 3 := rfl
    _ ≤ 256 * (P.c ^ 2) ^ 3 := Nat.mul_le_mul_left 256 hcube
    _ = 256 * P.c ^ 6 := by ring

/-- The reduced denominator is at most `c⁶`. -/
theorem freyJReducedDen_le (P : ABCPoint) :
    P.freyJReducedDen ≤ P.c ^ 6 := by
  have ha : P.a ≤ P.c := Nat.le_of_lt P.a_lt_c
  have hb : P.b ≤ P.c := Nat.le_of_lt P.b_lt_c
  calc
    P.freyJReducedDen ≤ P.freyJRawDen := Nat.div_le_self _ _
    _ = (P.a * P.b * P.c) ^ 2 := rfl
    _ ≤ (P.c * P.c * P.c) ^ 2 := by gcongr
    _ = P.c ^ 6 := by ring

/-- Both coordinates of the reduced rational `j`-invariant are uniformly
bounded by `256 c⁶`. -/
theorem freyJReducedMax_le (P : ABCPoint) :
    max P.freyJReducedNum P.freyJReducedDen ≤ 256 * P.c ^ 6 := by
  apply max_le P.freyJReducedNum_le
  calc
    P.freyJReducedDen ≤ P.c ^ 6 := P.freyJReducedDen_le
    _ = 1 * P.c ^ 6 := by ring
    _ ≤ 256 * P.c ^ 6 := Nat.mul_le_mul_right _ (by norm_num)

/-- Conversely, the maximum of the reduced coordinates controls `c⁶` with
absolute factor `8`. -/
theorem c_pow_six_le_eight_freyJReducedMax (P : ABCPoint) :
    P.c ^ 6 ≤ 8 * max P.freyJReducedNum P.freyJReducedDen := by
  exact P.c_pow_six_le_eight_freyJReducedNum.trans
    (Nat.mul_le_mul_left 8 (le_max_left _ _))

end ABCPoint

end IUTThreeClosures
