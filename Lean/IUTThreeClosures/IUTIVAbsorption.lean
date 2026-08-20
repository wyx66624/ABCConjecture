import Mathlib

namespace IUTThreeClosures

/-- Elementary epsilon absorption in the general-position calculation. -/
theorem proposition21_absorption
    {ε q6 diff cond C : ℝ}
    (hε : 0 < ε) (hε1 : ε ≤ 1)
    (hdiff : 0 ≤ diff) (hcond : 0 ≤ cond) (hC : 0 ≤ C)
    (hmain : q6 ≤
      (1 + 2 * ε / 5) * (diff + cond) +
        (ε / 5) * (q6 + diff) + C) :
    q6 ≤ (1 + ε) * (diff + cond) + 2 * C := by
  have hden : 0 < 1 - ε / 5 := by nlinarith
  have hfirst :
      (1 - ε / 5) * q6 ≤
        (1 + 3 * ε / 5) * (diff + cond) + C := by
    nlinarith
  have hcoef :
      1 + 3 * ε / 5 ≤ (1 - ε / 5) * (1 + ε) := by
    nlinarith [mul_nonneg hε.le (sub_nonneg.mpr hε1)]
  have hconst : C ≤ (1 - ε / 5) * (2 * C) := by
    nlinarith
  have htarget :
      (1 + 3 * ε / 5) * (diff + cond) + C ≤
        (1 - ε / 5) * ((1 + ε) * (diff + cond) + 2 * C) := by
    have hs : 0 ≤ diff + cond := add_nonneg hdiff hcond
    calc
      (1 + 3 * ε / 5) * (diff + cond) + C ≤
          ((1 - ε / 5) * (1 + ε)) * (diff + cond) +
            (1 - ε / 5) * (2 * C) := by gcongr
      _ = (1 - ε / 5) *
          ((1 + ε) * (diff + cond) + 2 * C) := by ring
  nlinarith

end IUTThreeClosures
