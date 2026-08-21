import IUTThreeClosures.FreyJHeightCorridor

/-!
# The exact global q-pilot reconstruction target

The currently formalized bad-place q-size is a sub-sum of the global
`j`-height and therefore gives the inequality in the wrong direction for the
final abc bridge.  The missing theorem must reconstruct the entire global
Frey `j`-height from a canonical weighted packet q-pilot, together with
uniformly bounded complementary contributions.

This file isolates that implication without placing `ABCConjecture`, an abc
height inequality, or a freely chosen height function in a structure field.
It proves that any source theorem of the form

`h(j(E_P)) = qPacket(P) + finiteComplement(P) + arch(P)
              + different(P) + procession(P) + rootNormalization(P)`

with all terms except `qPacket` uniformly bounded above gives the required
reverse height inequality.  Thus the remaining source work is reduced to an
explicit local-global decomposition theorem rather than an opaque bridge
field.
-/

namespace IUTThreeClosures

/-- The actual absolute logarithmic Weil height of the Frey `j`-invariant. -/
noncomputable def freyGlobalJHeight (P : ABCPoint) : ℝ :=
  Heights.normalizedLogHeight ℚ (abcFreyCurve P).j

/-- A bounded complement to a packet q-pilot reconstructs the global Frey
`j`-height in the direction needed by the final bridge. -/
theorem globalJHeight_le_packet_add
    (packet remainder : ABCPoint → ℝ)
    (hreconstruct : ∀ P : ABCPoint,
      freyGlobalJHeight P = packet P + remainder P)
    {C : ℝ}
    (hremainder : ∀ P : ABCPoint, remainder P ≤ C)
    (P : ABCPoint) :
    freyGlobalJHeight P ≤ packet P + C := by
  rw [hreconstruct P]
  linarith [hremainder P]

/-- The preceding reconstruction, combined with the verified Frey-height
corridor, gives the desired reverse q-pilot bound for the abc height. -/
theorem abcHeight_le_packet_div_six_add
    (packet remainder : ABCPoint → ℝ)
    (hreconstruct : ∀ P : ABCPoint,
      freyGlobalJHeight P = packet P + remainder P)
    {C : ℝ}
    (hremainder : ∀ P : ABCPoint, remainder P ≤ C)
    (P : ABCPoint) :
    P.height ≤ packet P / 6 + (C + Real.log 8) / 6 := by
  have hheight := P.height_le_normalizedLogHeight_abcFrey_j
  have hglobal : freyGlobalJHeight P ≤ packet P + C :=
    globalJHeight_le_packet_add packet remainder hreconstruct hremainder P
  unfold freyGlobalJHeight at hglobal
  linarith

/-- Expanded form of the precise source theorem that remains to be proved.
The six complementary terms correspond respectively to:

1. finite places omitted by the selected packet support;
2. local-degree and packet-weight discrepancy;
3. the archimedean contribution;
4. ramification/different correction;
5. procession/capsule averaging error;
6. corrected root-exponent normalization error.

If each term has a point-independent upper bound, the actual global
`j`-height and hence the abc height are controlled by the canonical packet
q-pilot. -/
theorem abcHeight_le_of_weighted_packet_reconstruction
    (packet finiteComplement weightError archimedean different
      procession rootNormalization : ABCPoint → ℝ)
    (hreconstruct : ∀ P : ABCPoint,
      freyGlobalJHeight P =
        packet P + finiteComplement P + weightError P + archimedean P +
          different P + procession P + rootNormalization P)
    {Cfinite Cweight Carch Cdiff Cproc Croot : ℝ}
    (hfinite : ∀ P : ABCPoint, finiteComplement P ≤ Cfinite)
    (hweight : ∀ P : ABCPoint, weightError P ≤ Cweight)
    (harch : ∀ P : ABCPoint, archimedean P ≤ Carch)
    (hdiff : ∀ P : ABCPoint, different P ≤ Cdiff)
    (hproc : ∀ P : ABCPoint, procession P ≤ Cproc)
    (hroot : ∀ P : ABCPoint, rootNormalization P ≤ Croot)
    (P : ABCPoint) :
    P.height ≤ packet P / 6 +
      (Cfinite + Cweight + Carch + Cdiff + Cproc + Croot +
        Real.log 8) / 6 := by
  let remainder : ABCPoint → ℝ := fun Q =>
    finiteComplement Q + weightError Q + archimedean Q + different Q +
      procession Q + rootNormalization Q
  have hremainder : ∀ Q : ABCPoint,
      remainder Q ≤ Cfinite + Cweight + Carch + Cdiff + Cproc + Croot := by
    intro Q
    dsimp [remainder]
    linarith [hfinite Q, hweight Q, harch Q, hdiff Q, hproc Q, hroot Q]
  have hreconstruct' : ∀ Q : ABCPoint,
      freyGlobalJHeight Q = packet Q + remainder Q := by
    intro Q
    dsimp [remainder]
    simpa only [add_assoc] using hreconstruct Q
  simpa only [add_assoc] using
    abcHeight_le_packet_div_six_add packet remainder hreconstruct'
      hremainder P

/-- Uniform form: a single point-independent constant follows from the
componentwise reconstruction theorem. -/
theorem exists_uniform_packet_height_constant
    (packet finiteComplement weightError archimedean different
      procession rootNormalization : ABCPoint → ℝ)
    (hreconstruct : ∀ P : ABCPoint,
      freyGlobalJHeight P =
        packet P + finiteComplement P + weightError P + archimedean P +
          different P + procession P + rootNormalization P)
    {Cfinite Cweight Carch Cdiff Cproc Croot : ℝ}
    (hfinite : ∀ P : ABCPoint, finiteComplement P ≤ Cfinite)
    (hweight : ∀ P : ABCPoint, weightError P ≤ Cweight)
    (harch : ∀ P : ABCPoint, archimedean P ≤ Carch)
    (hdiff : ∀ P : ABCPoint, different P ≤ Cdiff)
    (hproc : ∀ P : ABCPoint, procession P ≤ Cproc)
    (hroot : ∀ P : ABCPoint, rootNormalization P ≤ Croot) :
    ∃ C : ℝ, ∀ P : ABCPoint,
      P.height ≤ packet P / 6 + C := by
  refine ⟨(Cfinite + Cweight + Carch + Cdiff + Cproc + Croot +
    Real.log 8) / 6, ?_⟩
  intro P
  exact abcHeight_le_of_weighted_packet_reconstruction
    packet finiteComplement weightError archimedean different procession
      rootNormalization hreconstruct hfinite hweight harch hdiff hproc hroot P

end IUTThreeClosures
