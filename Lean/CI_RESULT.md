# Lean CI result

- Tested commit: `40e99f72235c469b20e8764355c93eefa0c6803b`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
452:✖ [8787/8797] Building IUTThreeClosures.LegendreArithmetic (3.2s)
465:error: IUTThreeClosures/LegendreArithmetic.lean:52:46: unsolved goals
470:error: IUTThreeClosures/LegendreArithmetic.lean:143:6: No goals to be solved
474:error: Lean exited with code 1
475:✖ [8790/8797] Building IUTThreeClosures.PublicProgramUninhabited (3.7s)
482:error: IUTThreeClosures/PublicProgramUninhabited.lean:40:8: Unknown identifier `not_nonempty_pointwiseIUTIIIFamily`
483:error: IUTThreeClosures/PublicProgramUninhabited.lean:50:26: Invalid argument name `v` for function `not_nonempty_upstreamCertificate`
487:error: IUTThreeClosures/PublicProgramUninhabited.lean:57:26: Invalid argument name `v` for function `not_nonempty_fourStageProgram`
494:error: Lean exited with code 1
515:Some required targets logged failures:
518:error: build failed
```

## Dependency log tail

```text
info: heights: cloning https://github.com/lana-agents/heights.git
info: heights: checking out revision '3539e2a12dd3470c057a4eb531dc3fd627d4c97b'
info: toolchain not updated; already up-to-date
info: mathlib: running post-update hooks
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 40 KB/s], Decompressed: 0Downloaded: 276 file(s) [attempted 276/8639 = 3%, 13034 KB/s], Decompressed: 0Downloaded: 770 file(s) [attempted 770/8639 = 8%, 3949 KB/s], Decompressed: 759Downloaded: 1067 file(s) [attempted 1067/8639 = 12%, 9542 KB/s], Decompressed: 1064Downloaded: 1074 file(s) [attempted 1074/8639 = 12%, 31688 KB/s], Decompressed: 1071Downloaded: 1585 file(s) [attempted 1585/8639 = 18%, 9805 KB/s], Decompressed: 1571Downloaded: 2114 file(s) [attempted 2114/8639 = 24%, 5809 KB/s], Decompressed: 2105Downloaded: 2627 file(s) [attempted 2627/8639 = 30%, 8134 KB/s], Decompressed: 2608Downloaded: 3159 file(s) [attempted 3159/8639 = 36%, 11196 KB/s], Decompressed: 3140Downloaded: 3681 file(s) [attempted 3681/8639 = 42%, 11344 KB/s], Decompressed: 3669Downloaded: 4208 file(s) [attempted 4208/8639 = 48%, 3113 KB/s], Decompressed: 4203Downloaded: 4741 file(s) [attempted 4741/8639 = 54%, 20184 KB/s], Decompressed: 4736Downloaded: 5359 file(s) [attempted 5359/8639 = 62%, 2381 KB/s], Decompressed: 5353Downloaded: 5885 file(s) [attempted 5885/8639 = 68%, 3318 KB/s], Decompressed: 5877Downloaded: 6405 file(s) [attempted 6405/8639 = 74%, 2159 KB/s], Decompressed: 6390Downloaded: 6890 file(s) [attempted 6890/8639 = 79%, 6466 KB/s], Decompressed: 6878Downloaded: 7423 file(s) [attempted 7423/8639 = 85%, 11413 KB/s], Decompressed: 7412Downloaded: 7961 file(s) [attempted 7961/8639 = 92%, 11774 KB/s], Decompressed: 7949Downloaded: 8502 file(s) [attempted 8502/8639 = 98%, 18304 KB/s], Decompressed: 8498Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 18304 KB/s], Decompressed: 8634
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (262ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.UltrametricSum (2.2s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.MaxTerm (2.3s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (2.2s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (5.2s)
✔ [8661/8667] Built Iut.Cor312.ThetaData.Places (4.7s)
✔ [8662/8673] Built TateCurvesTheta.AnalyticQuotient (6.8s)
✔ [8663/8673] Built TateCurvesTheta.Analysis.Strassmann (3.6s)
✔ [8664/8675] Built TateCurvesTheta.QParameter.BaseChange (2.9s)
✔ [8665/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (1.9s)
✔ [8666/8675] Built TateCurvesTheta.TateCurve.Weierstrass (2.3s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (3.5s)
✔ [8668/8684] Built TateCurvesTheta.QParameter.NormalizedOrder (2.7s)
✔ [8669/8689] Built TateCurvesTheta.TateCurve.Discriminant (3.2s)
✔ [8670/8689] Built TateCurvesTheta.TateCurve.Parametrization (2.8s)
✔ [8671/8691] Built TateCurvesTheta.Theta.Basic (2.5s)
✔ [8672/8691] Built Iut.Cor312.ThetaData.GlobalField (8.6s)
✔ [8673/8691] Built TateCurvesTheta.TateCurve.SplitReduction (3.1s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.JInvariant (2.4s)
✔ [8675/8693] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (2.0s)
✔ [8676/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (2.5s)
✔ [8677/8696] Built TateCurvesTheta.Theta.Periodicity (2.3s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (2.6s)
✔ [8679/8696] Built TateCurvesTheta.QParameter.JParametrization (6.6s)
✔ [8680/8696] Built TateCurvesTheta.Theta.Product (4.6s)
✔ [8681/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (6.1s)
✔ [8682/8699] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (5.6s)
✔ [8683/8699] Built TateCurvesTheta.QParameter.Characterization (1.7s)
✔ [8684/8704] Built TateCurvesTheta.Theta.Uniqueness (2.9s)
✔ [8685/8704] Built TateCurvesTheta.Theta.Divisor (3.7s)
✔ [8686/8704] Built TateCurvesTheta.Theta.FactorSeries (4.5s)
✔ [8687/8705] Built TateCurvesTheta.Theta.LaurentSphere (4.1s)
✔ [8688/8705] Built TateCurvesTheta.TateCurve.TatePointMem (3.8s)
✔ [8689/8705] Built TateCurvesTheta.TateCurve.EisensteinSeries (8.2s)
✔ [8690/8708] Built TateCurvesTheta.Theta.QBinomial (3.2s)
✔ [8691/8711] Built TateCurvesTheta.Theta.LaurentSphereReduce (2.6s)
✔ [8692/8712] Built TateCurvesTheta.TateCurve.CoordinateInversion (2.4s)
✔ [8693/8713] Built TateCurvesTheta.Theta.ThetaProdLaurent (3.5s)
✔ [8694/8714] Built TateCurvesTheta.Theta.LaurentUnitSphere (2.3s)
✔ [8695/8714] Built TateCurvesTheta.TateCurve.IntegralModel (3.6s)
✔ [8696/8718] Built TateCurvesTheta.TateCurve.Quotient (5.7s)
✔ [8697/8719] Built TateCurvesTheta.TateCurve.SphereBounds (4.6s)
✔ [8698/8721] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (3.2s)
✔ [8699/8721] Built TateCurvesTheta.Theta.FactorReciprocal (2.5s)
✔ [8700/8721] Built TateCurvesTheta.Theta.LaurentUnique (2.3s)
✔ [8701/8721] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (2.5s)
✔ [8702/8729] Built TateCurvesTheta.Theta.Normalization (2.6s)
✔ [8703/8729] Built TateCurvesTheta.Theta.SeriesZero (2.2s)
✔ [8704/8729] Built TateCurvesTheta.TateCurve.PointMap (5.8s)
✔ [8705/8729] Built TateCurvesTheta.Theta.RatioAnnulus (2.8s)
✔ [8706/8729] Built TateCurvesTheta.Theta.Durfee (4.3s)
✔ [8707/8729] Built TateCurvesTheta.Theta.TripleProduct (4.0s)
✔ [8708/8729] Built TateCurvesTheta.Theta.StrictDominant (6.1s)
✔ [8709/8729] Built TateCurvesTheta.Theta.Inversion (2.7s)
✔ [8710/8731] Built TateCurvesTheta.Uniformization (6.1s)
✔ [8711/8733] Built TateCurvesTheta.Theta.WeightSpace (9.2s)
✔ [8712/8735] Built Iut.Cor312.Procession (7.1s)
✔ [8713/8764] Built Iut.Cor312.RationalPlace (6.6s)
✔ [8714/8764] Built Iut.Cor312.PacketPresentation (7.0s)
⚠ [8715/8764] Built IUTThreeClosures.HonestFinitePositiveLogVolume (4.9s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8716/8764] Built IUTThreeClosures.ABCStatement (2.3s)
✔ [8717/8782] Built IUTThreeClosures.FullPolyCore (5.9s)
⚠ [8719/8782] Built IUTThreeClosures.Cor312CoefficientAlgebra (6.1s)
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `namespace IUTThreeClosures`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `/-- The scalar last step of IUT IV Theorem 1.10. -/
theorem q_bound_of_coefficient_expression {factor A q CTheta : ℝ} (hfactor : 0 < factor) (hCTheta : -1 ≤ CTheta)
    (hformula : CTheta = factor * (A - q / 6) - 1) : q / 6 ≤ A :=
  by
  rw [hformula] at hCTheta
  nlinarith`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `end IUTThreeClosures`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before ``.

Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8720/8782] Built TateCurvesTheta.Theta.PuncturedProduct (28s)
✔ [8721/8782] Built Iut.Cor312.Container (4.6s)
✔ [8722/8782] Built Iut.Cor312.HolomorphicHull (4.6s)
⚠ [8723/8782] Built IUTThreeClosures.HonestPilotWitness (4.4s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8724/8782] Built IUTThreeClosures.WeakCompatibilityCountermodel (4.2s)
✔ [8725/8782] Built Heights.WeilHeight (5.8s)
⚠ [8726/8782] Built IUTThreeClosures.ExplicitSemistableCurve (4.7s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8727/8782] Built IUTThreeClosures.SolvableRestrictionImage (4.6s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8782] Built IUTThreeClosures.QPilotNormalizationAudit (4.8s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8782] Built IUTThreeClosures.RootQPilotDivisor (4.4s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8730/8782] Built TateCurvesTheta.TateCurve.DefectVanishing (53s)
⚠ [8731/8782] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (4.7s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8782] Built IUTThreeClosures.RamificationCorrectedQPilot (4.8s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8734/8782] Built IUTThreeClosures.AdmissiblePrimeSelection (4.5s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8735/8782] Built IUTThreeClosures.ProductWeightMarginalization (5.1s)
warning: IUTThreeClosures/ProductWeightMarginalization.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ProductWeightMarginalization.lean:41:0: `sum_product_weights_eq_one` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
warning: IUTThreeClosures/ProductWeightMarginalization.lean:50:0: `product_weight_marginal` does not use the following hypotheses in its type:
  • [DecidableEq L] (#4)
  • [DecidableEq V] (#6)

Consider removing these hypotheses and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
warning: IUTThreeClosures/ProductWeightMarginalization.lean:105:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8736/8782] Built IUTThreeClosures.FiniteExceptionalSet (4.4s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8737/8782] Built IUTThreeClosures.GeneratedUnionCompactness (4.1s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8738/8782] Built Iut.Cor312.LogVolume (4.5s)
⚠ [8739/8793] Built IUTThreeClosures.ZModSL2Perfect (4.4s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8741/8797] Built Iut.Cor312.ContainerHull (4.4s)
✔ [8742/8797] Built Genl.Mathlib.Order.BoundedDiscrepancy (1.7s)
⚠ [8743/8797] Built IUTThreeClosures.QPilotNormalizationFork (4.0s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8744/8797] Built IUTThreeClosures.TateParameterUnitBallRegion (2.2s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8745/8797] Built TateCurvesTheta.TateCurve.TatePointOnCurve (4.3s)
⚠ [8746/8797] Built IUTThreeClosures.PrimePowerQPilotRegion (5.1s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8747/8797] Built IUTThreeClosures.FiniteExponentHull (4.5s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8748/8797] Built IUTThreeClosures.StandardZeroLabel (4.2s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8797] Built IUTThreeClosures.BarycentricPacketReading (4.2s)
warning: IUTThreeClosures/BarycentricPacketReading.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/BarycentricPacketReading.lean:21:0: `product_weight_barycentric` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
warning: IUTThreeClosures/BarycentricPacketReading.lean:57:0: `product_weight_barycentric_of_sum_one` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
warning: IUTThreeClosures/BarycentricPacketReading.lean:70:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8750/8797] Built IUTThreeClosures.DiagonalPacketNoGo (4.2s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8751/8797] Built Genl.GeneralPosition.HeightTheory (1.1s)
✔ [8752/8797] Built Iut4Sec1.Global.ArithmeticDivisor (4.4s)
⚠ [8753/8797] Built IUTThreeClosures.PublicNormalizationObstruction (4.7s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8754/8797] Built IUTThreeClosures.IUTIVAbsorption (5.0s)
warning: IUTThreeClosures/IUTIVAbsorption.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `namespace IUTThreeClosures`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `/-- Elementary epsilon absorption in the general-position calculation. -/
theorem proposition21_absorption {ε q6 diff cond C : ℝ} (hε : 0 < ε) (hε1 : ε ≤ 1) (hdiff : 0 ≤ diff) (hcond : 0 ≤ cond)
    (hC : 0 ≤ C) (hmain : q6 ≤ (1 + 2 * ε / 5) * (diff + cond) + (ε / 5) * (q6 + diff) + C) :
    q6 ≤ (1 + ε) * (diff + cond) + 2 * C :=
  by
  have hden : 0 < 1 - ε / 5 := by nlinarith
  have hfirst : (1 - ε / 5) * q6 ≤ (1 + 3 * ε / 5) * (diff + cond) + C := by nlinarith
  have hcoef : 1 + 3 * ε / 5 ≤ (1 - ε / 5) * (1 + ε) := by nlinarith [mul_nonneg hε.le (sub_nonneg.mpr hε1)]
  have hconst : C ≤ (1 - ε / 5) * (2 * C) := by nlinarith
  have htarget : (1 + 3 * ε / 5) * (diff + cond) + C ≤ (1 - ε / 5) * ((1 + ε) * (diff + cond) + 2 * C) :=
    by
    have hs : 0 ≤ diff + cond := add_nonneg hdiff hcond
    calc
      (1 + 3 * ε / 5) * (diff + cond) + C ≤ ((1 - ε / 5) * (1 + ε)) * (diff + cond) + (1 - ε / 5) * (2 * C) := by gcongr
      _ = (1 - ε / 5) * ((1 + ε) * (diff + cond) + 2 * C) := by ring
  nlinarith`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `end IUTThreeClosures`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before ``.

Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8755/8797] Built TateCurvesTheta.TateCurve.AdditionLaw (7.2s)
✔ [8756/8797] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (5.3s)
⚠ [8757/8797] Built IUTThreeClosures.DistinguishedLabelQPilot (6.0s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8758/8797] Built TateCurvesTheta.TateCurve.LargePointParametrization (9.3s)
⚠ [8759/8797] Built IUTThreeClosures.ZeroLabelBarycentric (4.5s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
⚠ [8760/8797] Built IUTThreeClosures.StatementIIOutsideFinite (5.0s)
warning: IUTThreeClosures/StatementIIOutsideFinite.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/StatementIIOutsideFinite.lean:18:19: Variable name `d` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: IUTThreeClosures/StatementIIOutsideFinite.lean:18:27: Variable name `ε` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: IUTThreeClosures/StatementIIOutsideFinite.lean:18:35: Variable name `K` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
✔ [8761/8797] Built TateCurvesTheta.TateCurve.AbelStep (4.6s)
✔ [8762/8797] Built TateCurvesTheta.TateCurve.GroupLaw (6.9s)
✔ [8763/8797] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (13s)
✔ [8764/8797] Built TateCurvesTheta.TateCurve.SurjectivitySphere (14s)
✔ [8765/8797] Built TateCurvesTheta.TateCurve.TateUniformization (3.1s)
✔ [8766/8797] Built TateCurvesTheta (2.7s)
✔ [8767/8797] Built Iut.Cor312.ThetaData.AdmissiblePrime (3.6s)
✔ [8768/8797] Built Iut.Cor312.ThetaData.Orbicurve (3.5s)
✔ [8769/8797] Built Iut.Cor312.ThetaData.LocalConditions (5.4s)
✔ [8770/8797] Built Iut.Cor312.ThetaData.Basic (3.3s)
✔ [8771/8797] Built Iut.Cor312.LeftHandSide (3.2s)
✔ [8772/8797] Built Iut.Cor312.RightHandSide (3.3s)
✔ [8773/8797] Built Iut.Cor312.Statement (3.0s)
⚠ [8774/8797] Built IUTThreeClosures.NativeQPilotCalibration (4.2s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8775/8797] Built IUTThreeClosures.CorrectedQPilotDivisor (4.3s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8776/8797] Built IUTThreeClosures.ActualPilotWitness (3.3s)
✔ [8777/8797] Built IUTThreeClosures.GeneratedSource (3.4s)
✔ [8778/8797] Built IUTThreeClosures.QuantifierCorrectClosure (3.1s)
⚠ [8779/8797] Built IUTThreeClosures.PublicLogVolumeInconsistency (3.2s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:72:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8780/8797] Built IUTThreeClosures.ABCClosure (2.8s)
✔ [8781/8797] Built IUTThreeClosures.ThreeClosureTheorems (2.8s)
✔ [8782/8797] Built IUTThreeClosures.InhabitationBoundary (3.1s)
✔ [8783/8797] Built IUTThreeClosures.CircularityAudit (3.1s)
✔ [8784/8797] Built IUTThreeClosures.NonCircularDownstream (3.7s)
✔ [8785/8797] Built IUTThreeClosures.FourOpenConstructions (3.1s)
⚠ [8786/8797] Built IUTThreeClosures.ABCPointLegendreCurve (3.4s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✖ [8787/8797] Building IUTThreeClosures.LegendreArithmetic (3.2s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/LegendreArithmetic.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/LegendreArithmetic.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/LegendreArithmetic.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/LegendreArithmetic.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/LegendreArithmetic.setup.json --json
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
info: IUTThreeClosures/LegendreArithmetic.lean:60:2: Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
error: IUTThreeClosures/LegendreArithmetic.lean:52:46: unsolved goals
P : ABCPoint
hc : ↑P.c ≠ 0
hsum : ↑P.a + ↑P.b = ↑P.c
⊢ ↑P.a * ↑P.b + ↑P.a ^ 2 + ↑P.b ^ 2 = ↑(P.a * P.b + P.a ^ 2 + P.b ^ 2)
error: IUTThreeClosures/LegendreArithmetic.lean:143:6: No goals to be solved
warning: IUTThreeClosures/LegendreArithmetic.lean:145:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
✖ [8790/8797] Building IUTThreeClosures.PublicProgramUninhabited (3.7s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/PublicProgramUninhabited.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PublicProgramUninhabited.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PublicProgramUninhabited.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PublicProgramUninhabited.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PublicProgramUninhabited.setup.json --json
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/PublicProgramUninhabited.lean:40:8: Unknown identifier `not_nonempty_pointwiseIUTIIIFamily`
error: IUTThreeClosures/PublicProgramUninhabited.lean:50:26: Invalid argument name `v` for function `not_nonempty_upstreamCertificate`

Hint: Perhaps you meant one of the following parameter names:
  • `Input`: v̵I̲n̲p̲u̲t̲
error: IUTThreeClosures/PublicProgramUninhabited.lean:57:26: Invalid argument name `v` for function `not_nonempty_fourStageProgram`

Hint: Perhaps you meant one of the following parameter names:
  • `Input`: v̵I̲n̲p̲u̲t̲
warning: IUTThreeClosures/PublicProgramUninhabited.lean:59:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
⚠ [8791/8797] Built IUTThreeClosures.BridgeInhabitationAudit (4.2s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8792/8797] Built IUTThreeClosures.BridgeInhabitationExact (2.8s)
⚠ [8793/8797] Built IUTThreeClosures.CanonicalQPilotCorridor (3.0s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8794/8797] Built IUTThreeClosures.CanonicalCorridorAudit (3.2s)
⚠ [8795/8797] Built IUTThreeClosures.SourceDerivedIUTIVBridge (3.7s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Some required targets logged failures:
- IUTThreeClosures.LegendreArithmetic
- IUTThreeClosures.PublicProgramUninhabited
error: build failed
```
