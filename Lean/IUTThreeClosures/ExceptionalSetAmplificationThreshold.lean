/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Quantitative threshold for an exceptional-set amplification route

An upper bound of order `X^beta` does not by itself make an exceptional set
finite: a very sparse infinite set remains compatible with such an envelope.
A genuine amplification argument must instead turn one bad object at source
height `H` into sufficiently many distinct bad objects below a controlled
target height.

On logarithmic scales, suppose a construction has height-dilation exponent
`d`, produces at least `H^gamma` distinct bad outputs, and the global
exceptional-set bound is `O(X^beta)`.  Substitution `X = H^d` gives the exact
necessary inequality

`gamma <= d * beta`.

Thus any construction with `gamma > d * beta` contradicts the exceptional-set
envelope on an unbounded sequence.  This file proves that scalar principle and
records the currently relevant exponents `33/50` and `56/85`.

No analytic exceptional-set theorem is assumed here; applications must supply
its logarithmic envelope as an explicit hypothesis.
-/

namespace IUTThreeClosures
namespace ExceptionalSetAmplificationThreshold

/-- A real-valued source-height scale is unbounded above. -/
def UnboundedLogScale (scale : ℕ → ℝ) : Prop :=
  ∀ B : ℝ, ∃ n : ℕ, B < scale n

/-- A logarithmic exceptional-count envelope of slope `q`, with a uniform
additive constant. -/
def LogCountEnvelope
    (scale outputLog : ℕ → ℝ) (q K : ℝ) : Prop :=
  ∀ n : ℕ, outputLog n ≤ q * scale n + K

/-- A logarithmic lower bound of slope `p` supplied by an amplification
construction. -/
def LogAmplificationLower
    (scale outputLog : ℕ → ℝ) (p : ℝ) : Prop :=
  ∀ n : ℕ, p * scale n ≤ outputLog n

/-- On an unbounded source scale, a lower logarithmic slope cannot exceed a
uniform upper logarithmic slope. -/
theorem no_unbounded_log_amplification_above_envelope
    (scale outputLog : ℕ → ℝ) (p q K : ℝ)
    (hgap : q < p)
    (hunbounded : UnboundedLogScale scale)
    (hlower : LogAmplificationLower scale outputLog p)
    (hupper : LogCountEnvelope scale outputLog q K) :
    False := by
  let gap : ℝ := p - q
  have hgapPos : 0 < gap := by
    dsimp [gap]
    linarith
  obtain ⟨n, hn⟩ := hunbounded (K / gap)
  have hchain : p * scale n ≤ q * scale n + K :=
    (hlower n).trans (hupper n)
  have hlarge : K < gap * scale n := by
    have hmul : K < scale n * gap :=
      (div_lt_iff₀ hgapPos).mp hn
    nlinarith
  dsimp [gap] at hlarge
  linarith

/-- Browning--Lichtman--Teräväinen's `33/50` exponent. -/
def bltExponent : ℝ := (33 : ℝ) / 50

/-- Li's `56/85` exponent. -/
def liExponent : ℝ := (56 : ℝ) / 85

/-- The later exponent improves `33/50` by exactly `1/850`. -/
theorem li_improves_blt_by_exact_one_over_850 :
    bltExponent - liExponent = (1 : ℝ) / 850 := by
  norm_num [bltExponent, liExponent]

/-- Despite that improvement, `56/85` is still strictly above the
half-dimensional capacity exponent. -/
theorem half_lt_liExponent :
    (1 : ℝ) / 2 < liExponent := by
  norm_num [liExponent]

/-- The exact remaining gap above the half-dimensional threshold. -/
theorem liExponent_minus_half :
    liExponent - (1 : ℝ) / 2 = (27 : ℝ) / 170 := by
  norm_num [liExponent]

/-- Quantitative closure criterion for an amplification route using the
`56/85` exceptional-set exponent.  If target height is at most a `d`-th power
of source height, the construction must create more than
`H^(d * 56/85)` distinct bad outputs. -/
theorem no_li_envelope_with_supercritical_amplification
    (scale outputLog : ℕ → ℝ) (d gamma K : ℝ)
    (hgamma : d * liExponent < gamma)
    (hunbounded : UnboundedLogScale scale)
    (hlower : LogAmplificationLower scale outputLog gamma)
    (hupper : LogCountEnvelope scale outputLog (d * liExponent) K) :
    False := by
  exact no_unbounded_log_amplification_above_envelope
    scale outputLog gamma (d * liExponent) K
    hgamma hunbounded hlower hupper

/-- For a quadratic height dilation (`d = 2`), the required output exponent is
strictly greater than `112/85`. -/
theorem quadratic_li_threshold :
    2 * liExponent = (112 : ℝ) / 85 := by
  norm_num [liExponent]

/-- For a quartic height dilation (`d = 4`), the required output exponent is
strictly greater than `224/85`. -/
theorem quartic_li_threshold :
    4 * liExponent = (224 : ℝ) / 85 := by
  norm_num [liExponent]

#print axioms no_unbounded_log_amplification_above_envelope
#print axioms li_improves_blt_by_exact_one_over_850
#print axioms half_lt_liExponent
#print axioms liExponent_minus_half
#print axioms no_li_envelope_with_supercritical_amplification
#print axioms quadratic_li_threshold
#print axioms quartic_li_threshold

end ExceptionalSetAmplificationThreshold
end IUTThreeClosures
