# Lean CI result

- Tested commit: `5cc2b641cc9ee900bea70668d25daa2a53fc8da0`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `success`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
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
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 56 KB/s], Decompressed: 0Downloaded: 15 file(s) [attempted 15/8639 = 0%, 9 KB/s], Decompressed: 12Downloaded: 138 file(s) [attempted 138/8639 = 1%, 1896 KB/s], Decompressed: 129Downloaded: 407 file(s) [attempted 407/8639 = 4%, 2173 KB/s], Decompressed: 391Downloaded: 678 file(s) [attempted 678/8639 = 7%, 9551 KB/s], Decompressed: 666Downloaded: 970 file(s) [attempted 970/8639 = 11%, 9866 KB/s], Decompressed: 960Downloaded: 1245 file(s) [attempted 1245/8639 = 14%, 2016 KB/s], Decompressed: 1232Downloaded: 1504 file(s) [attempted 1504/8639 = 17%, 3753 KB/s], Decompressed: 1496Downloaded: 1807 file(s) [attempted 1807/8639 = 20%, 13436 KB/s], Decompressed: 1790Downloaded: 2066 file(s) [attempted 2066/8639 = 23%, 1669 KB/s], Decompressed: 2050Downloaded: 2346 file(s) [attempted 2346/8639 = 27%, 2878 KB/s], Decompressed: 2326Downloaded: 2633 file(s) [attempted 2633/8639 = 30%, 9903 KB/s], Decompressed: 2616Downloaded: 2915 file(s) [attempted 2915/8639 = 33%, 1472 KB/s], Decompressed: 2903Downloaded: 3186 file(s) [attempted 3186/8639 = 36%, 1069 KB/s], Decompressed: 3164Downloaded: 3473 file(s) [attempted 3473/8639 = 40%, 4826 KB/s], Decompressed: 3457Downloaded: 3747 file(s) [attempted 3747/8639 = 43%, 4930 KB/s], Decompressed: 3737Downloaded: 4039 file(s) [attempted 4039/8639 = 46%, 2889 KB/s], Decompressed: 4023Downloaded: 4315 file(s) [attempted 4315/8639 = 49%, 14998 KB/s], Decompressed: 4303Downloaded: 4616 file(s) [attempted 4616/8639 = 53%, 1174 KB/s], Decompressed: 4601Downloaded: 4893 file(s) [attempted 4893/8639 = 56%, 848 KB/s], Decompressed: 4874Downloaded: 5201 file(s) [attempted 5201/8639 = 60%, 4683 KB/s], Decompressed: 5190Downloaded: 5480 file(s) [attempted 5480/8639 = 63%, 1443 KB/s], Decompressed: 5458Downloaded: 5746 file(s) [attempted 5746/8639 = 66%, 6359 KB/s], Decompressed: 5732Downloaded: 6012 file(s) [attempted 6012/8639 = 69%, 8718 KB/s], Decompressed: 6002Downloaded: 6297 file(s) [attempted 6297/8639 = 72%, 15725 KB/s], Decompressed: 6293Downloaded: 6554 file(s) [attempted 6554/8639 = 75%, 3524 KB/s], Decompressed: 6541Downloaded: 6840 file(s) [attempted 6840/8639 = 79%, 2666 KB/s], Decompressed: 6825Downloaded: 7110 file(s) [attempted 7110/8639 = 82%, 8288 KB/s], Decompressed: 7100Downloaded: 7396 file(s) [attempted 7396/8639 = 85%, 1048 KB/s], Decompressed: 7382Downloaded: 7677 file(s) [attempted 7677/8639 = 88%, 9093 KB/s], Decompressed: 7666Downloaded: 7969 file(s) [attempted 7969/8639 = 92%, 13777 KB/s], Decompressed: 7962Downloaded: 8244 file(s) [attempted 8244/8639 = 95%, 3050 KB/s], Decompressed: 8232Downloaded: 8527 file(s) [attempted 8527/8639 = 98%, 4366 KB/s], Decompressed: 8512Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 4366 KB/s], Decompressed: 8635
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (392ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.6s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.6s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (2.0s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (9.4s)
✔ [8661/8671] Built TateCurvesTheta.Analysis.Strassmann (5.9s)
✔ [8662/8673] Built Iut.Cor312.ThetaData.Places (7.8s)
✔ [8663/8675] Built TateCurvesTheta.AnalyticQuotient (8.6s)
✔ [8664/8675] Built TateCurvesTheta.QParameter.BaseChange (2.6s)
✔ [8665/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (3.0s)
✔ [8666/8684] Built TateCurvesTheta.Analysis.StrassmannSphere (5.8s)
✔ [8667/8685] Built TateCurvesTheta.TateCurve.Weierstrass (4.4s)
✔ [8668/8685] Built TateCurvesTheta.QParameter.NormalizedOrder (3.2s)
✔ [8669/8689] Built TateCurvesTheta.Theta.Basic (3.7s)
✔ [8670/8692] Built TateCurvesTheta.TateCurve.Parametrization (4.0s)
✔ [8671/8692] Built TateCurvesTheta.Theta.Periodicity (2.9s)
✔ [8672/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.4s)
✔ [8673/8693] Built TateCurvesTheta.TateCurve.Discriminant (5.0s)
✔ [8674/8693] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8675/8693] Built TateCurvesTheta.TateCurve.CoordinateExpansion (4.1s)
✔ [8676/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (4.3s)
✔ [8677/8696] Built TateCurvesTheta.Theta.Product (4.4s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.JInvariant (3.2s)
✔ [8679/8696] Built TateCurvesTheta.TateCurve.SplitReduction (4.7s)
✔ [8680/8696] Built TateCurvesTheta.Theta.Divisor (6.1s)
✔ [8681/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (9.0s)
✔ [8682/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (9.8s)
✔ [8683/8696] Built TateCurvesTheta.Theta.Uniqueness (6.4s)
✔ [8684/8699] Built TateCurvesTheta.Theta.FactorSeries (7.6s)
✔ [8685/8699] Built TateCurvesTheta.TateCurve.EisensteinSeries (15s)
✔ [8686/8704] Built TateCurvesTheta.QParameter.JParametrization (10s)
✔ [8687/8704] Built TateCurvesTheta.Theta.LaurentSphere (4.9s)
✔ [8688/8705] Built TateCurvesTheta.TateCurve.TatePointMem (4.2s)
✔ [8689/8705] Built TateCurvesTheta.QParameter.Characterization (2.5s)
✔ [8690/8708] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.9s)
✔ [8691/8708] Built TateCurvesTheta.Theta.QBinomial (4.6s)
✔ [8692/8711] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.9s)
✔ [8693/8712] Built TateCurvesTheta.TateCurve.CoordinateInversion (3.8s)
✔ [8694/8713] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.5s)
✔ [8695/8714] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.3s)
✔ [8696/8714] Built TateCurvesTheta.TateCurve.IntegralModel (6.4s)
✔ [8697/8715] Built TateCurvesTheta.TateCurve.Quotient (8.0s)
✔ [8698/8716] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (5.0s)
✔ [8699/8717] Built TateCurvesTheta.TateCurve.SphereBounds (6.6s)
✔ [8700/8719] Built TateCurvesTheta.Theta.Normalization (3.6s)
✔ [8701/8719] Built TateCurvesTheta.Theta.FactorReciprocal (4.4s)
✔ [8702/8720] Built TateCurvesTheta.TateCurve.PointMap (10s)
✔ [8703/8721] Built TateCurvesTheta.Theta.Durfee (7.6s)
✔ [8704/8722] Built TateCurvesTheta.Theta.LaurentUnique (6.5s)
✔ [8705/8722] Built TateCurvesTheta.Theta.SeriesZero (3.5s)
✔ [8706/8722] Built TateCurvesTheta.Theta.RatioAnnulus (3.8s)
✔ [8707/8729] Built TateCurvesTheta.Theta.Inversion (3.6s)
✔ [8708/8729] Built TateCurvesTheta.Theta.StrictDominant (10s)
✔ [8709/8729] Built TateCurvesTheta.Theta.WeightSpace (16s)
✔ [8710/8731] Built TateCurvesTheta.Theta.TripleProduct (5.7s)
✔ [8711/8733] Built TateCurvesTheta.Uniformization (10s)
✔ [8712/8735] Built Iut.Cor312.Procession (10s)
✔ [8713/8765] Built Iut.Cor312.RationalPlace (7.1s)
✔ [8714/8765] Built Iut.Cor312.PacketPresentation (8.7s)
✔ [8715/8765] Built IUTThreeClosures.ABCStatement (2.4s)
⚠ [8716/8765] Built IUTThreeClosures.HonestFinitePositiveLogVolume (7.5s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8717/8784] Built IUTThreeClosures.FullPolyCore (7.9s)
⚠ [8719/8784] Built IUTThreeClosures.Cor312CoefficientAlgebra (7.2s)
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
✔ [8720/8784] Built TateCurvesTheta.Theta.PuncturedProduct (50s)
✔ [8721/8784] Built Iut.Cor312.Container (6.3s)
✔ [8722/8784] Built Iut.Cor312.HolomorphicHull (6.1s)
⚠ [8723/8784] Built IUTThreeClosures.HonestPilotWitness (6.2s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8724/8784] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.5s)
⚠ [8725/8784] Built IUTThreeClosures.ExplicitSemistableCurve (6.4s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8726/8784] Built Heights.WeilHeight (8.6s)
⚠ [8727/8784] Built IUTThreeClosures.SolvableRestrictionImage (7.5s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8784] Built IUTThreeClosures.QPilotNormalizationAudit (6.2s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8784] Built IUTThreeClosures.RootQPilotDivisor (6.2s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8730/8784] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.4s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8784] Built IUTThreeClosures.RamificationCorrectedQPilot (6.9s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8784] Built IUTThreeClosures.ProductWeightMarginalization (7.4s)
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
⚠ [8734/8784] Built IUTThreeClosures.AdmissiblePrimeSelection (6.5s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8735/8784] Built IUTThreeClosures.FiniteExceptionalSet (5.9s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8736/8784] Built IUTThreeClosures.GeneratedUnionCompactness (5.6s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8737/8784] Built TateCurvesTheta.TateCurve.DefectVanishing (100s)
✔ [8738/8784] Built Iut.Cor312.LogVolume (6.4s)
✔ [8740/8799] Built Iut.Cor312.ContainerHull (6.1s)
⚠ [8741/8799] Built IUTThreeClosures.HonestGeneratedSource (5.9s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8742/8799] Built IUTThreeClosures.ZModSL2Perfect (5.9s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8743/8799] Built IUTThreeClosures.QPilotNormalizationFork (6.5s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8744/8799] Built Genl.Mathlib.Order.BoundedDiscrepancy (3.5s)
✔ [8745/8799] Built TateCurvesTheta.TateCurve.TatePointOnCurve (7.0s)
⚠ [8746/8799] Built IUTThreeClosures.TateParameterUnitBallRegion (3.5s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8747/8799] Built IUTThreeClosures.PrimePowerQPilotRegion (7.1s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8748/8799] Built IUTThreeClosures.FiniteExponentHull (5.7s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8799] Built IUTThreeClosures.StandardZeroLabel (5.6s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8799] Built IUTThreeClosures.BarycentricPacketReading (5.8s)
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
⚠ [8751/8799] Built IUTThreeClosures.DiagonalPacketNoGo (5.8s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8752/8799] Built Genl.GeneralPosition.HeightTheory (1.8s)
⚠ [8753/8799] Built IUTThreeClosures.PublicNormalizationObstruction (6.3s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8754/8799] Built Iut4Sec1.Global.ArithmeticDivisor (6.1s)
⚠ [8755/8799] Built IUTThreeClosures.IUTIVAbsorption (8.9s)
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
✔ [8756/8799] Built TateCurvesTheta.TateCurve.AdditionLaw (11s)
✔ [8757/8799] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (9.5s)
⚠ [8758/8799] Built IUTThreeClosures.DistinguishedLabelQPilot (9.9s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8759/8799] Built TateCurvesTheta.TateCurve.LargePointParametrization (14s)
⚠ [8760/8799] Built IUTThreeClosures.ZeroLabelBarycentric (6.6s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
⚠ [8761/8799] Built IUTThreeClosures.StatementIIOutsideFinite (6.4s)
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
✔ [8762/8799] Built TateCurvesTheta.TateCurve.AbelStep (6.0s)
✔ [8763/8799] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8764/8799] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (20s)
✔ [8765/8799] Built TateCurvesTheta.TateCurve.SurjectivitySphere (27s)
✔ [8766/8799] Built TateCurvesTheta.TateCurve.TateUniformization (4.0s)
✔ [8767/8799] Built TateCurvesTheta (3.3s)
✔ [8768/8799] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.5s)
✔ [8769/8799] Built Iut.Cor312.ThetaData.Orbicurve (4.3s)
✔ [8770/8799] Built Iut.Cor312.ThetaData.LocalConditions (7.4s)
✔ [8771/8799] Built Iut.Cor312.ThetaData.Basic (4.3s)
✔ [8772/8799] Built Iut.Cor312.LeftHandSide (3.9s)
✔ [8773/8799] Built Iut.Cor312.RightHandSide (4.1s)
✔ [8774/8799] Built Iut.Cor312.Statement (3.9s)
⚠ [8775/8799] Built IUTThreeClosures.NativeQPilotCalibration (5.5s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8776/8799] Built IUTThreeClosures.CorrectedQPilotDivisor (5.6s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8777/8799] Built IUTThreeClosures.ActualPilotWitness (4.0s)
✔ [8778/8799] Built IUTThreeClosures.GeneratedSource (4.2s)
✔ [8779/8799] Built IUTThreeClosures.QuantifierCorrectClosure (3.7s)
✔ [8780/8799] Built IUTThreeClosures.ABCClosure (3.9s)
⚠ [8781/8799] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.1s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8782/8799] Built IUTThreeClosures.ThreeClosureTheorems (3.7s)
✔ [8783/8799] Built IUTThreeClosures.InhabitationBoundary (3.8s)
✔ [8784/8799] Built IUTThreeClosures.CircularityAudit (3.9s)
✔ [8785/8799] Built IUTThreeClosures.NonCircularDownstream (4.9s)
✔ [8786/8799] Built IUTThreeClosures.FourOpenConstructions (3.0s)
⚠ [8787/8799] Built IUTThreeClosures.ABCPointLegendreCurve (4.4s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8788/8799] Built IUTThreeClosures.LegendreArithmetic (4.0s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8789/8799] Built IUTThreeClosures.PublicProgramUninhabited (5.5s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8790/8799] Built IUTThreeClosures.BridgeInhabitationAudit (6.3s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8791/8799] Built IUTThreeClosures.ABCFreyCurve (5.0s)
warning: IUTThreeClosures/ABCFreyCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCFreyCurve.lean:45:48: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/ABCFreyCurve.lean:45:48: 'ring' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/ABCFreyCurve.lean:49:44: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
warning: IUTThreeClosures/ABCFreyCurve.lean:57:44: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
warning: IUTThreeClosures/ABCFreyCurve.lean:78:47: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/ABCFreyCurve.lean:78:47: 'ring' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/ABCFreyCurve.lean:82:43: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
warning: IUTThreeClosures/ABCFreyCurve.lean:90:43: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
⚠ [8792/8799] Built IUTThreeClosures.TripodWeilHeight (5.4s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8793/8799] Built IUTThreeClosures.BridgeInhabitationExact (5.2s)
⚠ [8794/8799] Built IUTThreeClosures.LegendreHeightCorridor (4.2s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8795/8799] Built IUTThreeClosures.CanonicalQPilotCorridor (3.0s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8796/8799] Built IUTThreeClosures.CanonicalCorridorAudit (3.8s)
⚠ [8797/8799] Built IUTThreeClosures.SourceDerivedIUTIVBridge (4.7s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8798/8799] Built IUTThreeClosures (3.3s)
warning: IUTThreeClosures.lean:61:46: '' starts on column 46, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Build completed successfully (8799 jobs).
```
