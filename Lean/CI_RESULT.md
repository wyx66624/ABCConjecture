# Lean CI result

- Tested commit: `5c7a5e5317b431282e3c28933e446e7c521fb423`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
434:✖ [8780/8799] Building IUTThreeClosures.PublicLogVolumeInconsistency (4.1s)
441:error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:122:4: omega could not prove the goal:
451:error: Lean exited with code 1
538:Some required targets logged failures:
540:error: build failed
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
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 19 KB/s], Decompressed: 0Downloaded: 157 file(s) [attempted 157/8639 = 1%, 3788 KB/s], Decompressed: 152Downloaded: 391 file(s) [attempted 391/8639 = 4%, 4656 KB/s], Decompressed: 387Downloaded: 626 file(s) [attempted 626/8639 = 7%, 2430 KB/s], Decompressed: 619Downloaded: 863 file(s) [attempted 863/8639 = 9%, 315 KB/s], Decompressed: 859Downloaded: 1102 file(s) [attempted 1102/8639 = 12%, 3782 KB/s], Decompressed: 1099Downloaded: 1329 file(s) [attempted 1329/8639 = 15%, 1250 KB/s], Decompressed: 1314Downloaded: 1562 file(s) [attempted 1562/8639 = 18%, 1788 KB/s], Decompressed: 1549Downloaded: 1795 file(s) [attempted 1795/8639 = 20%, 548 KB/s], Decompressed: 1787Downloaded: 2008 file(s) [attempted 2008/8639 = 23%, 4456 KB/s], Decompressed: 2001Downloaded: 2242 file(s) [attempted 2242/8639 = 25%, 747 KB/s], Decompressed: 2232Downloaded: 2467 file(s) [attempted 2467/8639 = 28%, 6464 KB/s], Decompressed: 2461Downloaded: 2699 file(s) [attempted 2699/8639 = 31%, 2089 KB/s], Decompressed: 2694Downloaded: 2929 file(s) [attempted 2929/8639 = 33%, 4087 KB/s], Decompressed: 2915Downloaded: 3159 file(s) [attempted 3159/8639 = 36%, 1724 KB/s], Decompressed: 3147Downloaded: 3374 file(s) [attempted 3374/8639 = 39%, 5637 KB/s], Decompressed: 3363Downloaded: 3600 file(s) [attempted 3600/8639 = 41%, 2030 KB/s], Decompressed: 3596Downloaded: 3816 file(s) [attempted 3816/8639 = 44%, 4920 KB/s], Decompressed: 3805Downloaded: 4038 file(s) [attempted 4038/8639 = 46%, 2459 KB/s], Decompressed: 4036Downloaded: 4268 file(s) [attempted 4268/8639 = 49%, 7798 KB/s], Decompressed: 4262Downloaded: 4496 file(s) [attempted 4496/8639 = 52%, 782 KB/s], Decompressed: 4484Downloaded: 4699 file(s) [attempted 4699/8639 = 54%, 3104 KB/s], Decompressed: 4679Downloaded: 4901 file(s) [attempted 4901/8639 = 56%, 2696 KB/s], Decompressed: 4898Downloaded: 5130 file(s) [attempted 5130/8639 = 59%, 1077 KB/s], Decompressed: 5125Downloaded: 5336 file(s) [attempted 5336/8639 = 61%, 2870 KB/s], Decompressed: 5323Downloaded: 5540 file(s) [attempted 5540/8639 = 64%, 1630 KB/s], Decompressed: 5532Downloaded: 5763 file(s) [attempted 5763/8639 = 66%, 1022 KB/s], Decompressed: 5758Downloaded: 5988 file(s) [attempted 5988/8639 = 69%, 2290 KB/s], Decompressed: 5977Downloaded: 6205 file(s) [attempted 6205/8639 = 71%, 2957 KB/s], Decompressed: 6197Downloaded: 6417 file(s) [attempted 6417/8639 = 74%, 2301 KB/s], Decompressed: 6408Downloaded: 6622 file(s) [attempted 6622/8639 = 76%, 1096 KB/s], Decompressed: 6610Downloaded: 6847 file(s) [attempted 6847/8639 = 79%, 3636 KB/s], Decompressed: 6835Downloaded: 7045 file(s) [attempted 7045/8639 = 81%, 973 KB/s], Decompressed: 7040Downloaded: 7290 file(s) [attempted 7290/8639 = 84%, 576 KB/s], Decompressed: 7277Downloaded: 7521 file(s) [attempted 7521/8639 = 87%, 2611 KB/s], Decompressed: 7510Downloaded: 7736 file(s) [attempted 7736/8639 = 89%, 847 KB/s], Decompressed: 7728Downloaded: 7971 file(s) [attempted 7971/8639 = 92%, 1524 KB/s], Decompressed: 7963Downloaded: 8193 file(s) [attempted 8193/8639 = 94%, 950 KB/s], Decompressed: 8182Downloaded: 8436 file(s) [attempted 8436/8639 = 97%, 8223 KB/s], Decompressed: 8425Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 2547 KB/s], Decompressed: 8630Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 2547 KB/s], Decompressed: 8630
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (456ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.1s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.5s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.8s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (9.2s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (9.0s)
✔ [8662/8673] Built Iut.Cor312.ThetaData.Places (7.6s)
✔ [8663/8675] Built TateCurvesTheta.Analysis.Strassmann (5.4s)
✔ [8664/8675] Built TateCurvesTheta.QParameter.BaseChange (3.5s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.0s)
✔ [8666/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (2.8s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (6.7s)
✔ [8668/8680] Built TateCurvesTheta.TateCurve.Discriminant (5.6s)
✔ [8669/8680] Built TateCurvesTheta.QParameter.NormalizedOrder (5.2s)
✔ [8670/8680] Built TateCurvesTheta.TateCurve.Parametrization (4.8s)
✔ [8671/8680] Built TateCurvesTheta.TateCurve.JInvariant (3.0s)
✔ [8672/8680] Built TateCurvesTheta.TateCurve.SplitReduction (5.3s)
✔ [8673/8684] Built Iut.Cor312.ThetaData.GlobalField (14s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.3s)
✔ [8675/8693] Built TateCurvesTheta.TateCurve.CoordinateExpansion (4.6s)
✔ [8676/8693] Built TateCurvesTheta.Theta.Basic (4.6s)
✔ [8677/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (7.1s)
✔ [8678/8696] Built TateCurvesTheta.QParameter.JParametrization (9.9s)
✔ [8679/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (10s)
✔ [8680/8696] Built TateCurvesTheta.Theta.Periodicity (5.6s)
✔ [8681/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (10s)
✔ [8682/8705] Built TateCurvesTheta.QParameter.Characterization (4.5s)
✔ [8683/8708] Built TateCurvesTheta.Theta.Product (7.5s)
✔ [8684/8708] Built TateCurvesTheta.Theta.QBinomial (7.2s)
✔ [8685/8708] Built TateCurvesTheta.TateCurve.EisensteinSeries (15s)
✔ [8686/8708] Built TateCurvesTheta.TateCurve.CoordinateInversion (6.5s)
✔ [8687/8708] Built TateCurvesTheta.Theta.Uniqueness (4.0s)
✔ [8688/8711] Built TateCurvesTheta.Theta.Divisor (4.8s)
✔ [8689/8712] Built TateCurvesTheta.Theta.FactorSeries (5.9s)
✔ [8690/8712] Built TateCurvesTheta.Theta.LaurentSphere (3.8s)
✔ [8691/8713] Built TateCurvesTheta.TateCurve.TatePointMem (3.8s)
✔ [8692/8714] Built TateCurvesTheta.TateCurve.Quotient (7.7s)
✔ [8693/8715] Built TateCurvesTheta.Theta.ThetaProdLaurent (6.3s)
✔ [8694/8716] Built TateCurvesTheta.TateCurve.IntegralModel (6.8s)
✔ [8695/8717] Built TateCurvesTheta.Theta.LaurentSphereReduce (5.2s)
✔ [8696/8717] Built TateCurvesTheta.TateCurve.SphereBounds (7.6s)
✔ [8697/8719] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.6s)
✔ [8698/8719] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.6s)
✔ [8699/8719] Built TateCurvesTheta.Theta.FactorReciprocal (4.1s)
✔ [8700/8721] Built TateCurvesTheta.TateCurve.PointMap (8.6s)
✔ [8701/8721] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (4.2s)
✔ [8702/8721] Built TateCurvesTheta.Theta.LaurentUnique (3.9s)
✔ [8703/8721] Built TateCurvesTheta.Theta.Normalization (5.8s)
✔ [8704/8722] Built TateCurvesTheta.Theta.SeriesZero (4.0s)
✔ [8705/8729] Built TateCurvesTheta.Theta.RatioAnnulus (5.9s)
✔ [8706/8729] Built TateCurvesTheta.Theta.TripleProduct (5.6s)
✔ [8707/8729] Built TateCurvesTheta.Theta.Durfee (7.3s)
✔ [8708/8729] Built TateCurvesTheta.Theta.StrictDominant (9.4s)
✔ [8709/8729] Built TateCurvesTheta.Theta.Inversion (3.9s)
✔ [8710/8731] Built TateCurvesTheta.Uniformization (9.0s)
✔ [8711/8733] Built Iut.Cor312.Procession (12s)
✔ [8712/8735] Built TateCurvesTheta.Theta.WeightSpace (18s)
✔ [8713/8765] Built Iut.Cor312.RationalPlace (9.2s)
✔ [8714/8765] Built Iut.Cor312.PacketPresentation (11s)
✔ [8715/8765] Built IUTThreeClosures.ABCStatement (3.2s)
⚠ [8716/8765] Built IUTThreeClosures.HonestFinitePositiveLogVolume (9.3s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8717/8784] Built IUTThreeClosures.FullPolyCore (9.3s)
⚠ [8719/8784] Built IUTThreeClosures.Cor312CoefficientAlgebra (8.3s)
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
✔ [8720/8784] Built Iut.Cor312.Container (9.7s)
✔ [8721/8784] Built Iut.Cor312.HolomorphicHull (7.8s)
✔ [8722/8784] Built TateCurvesTheta.Theta.PuncturedProduct (52s)
✔ [8723/8784] Built IUTThreeClosures.WeakCompatibilityCountermodel (6.0s)
⚠ [8724/8784] Built IUTThreeClosures.HonestPilotWitness (6.0s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8725/8784] Built Heights.WeilHeight (9.5s)
⚠ [8726/8784] Built IUTThreeClosures.ExplicitSemistableCurve (7.2s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8727/8784] Built IUTThreeClosures.SolvableRestrictionImage (7.6s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8784] Built IUTThreeClosures.QPilotNormalizationAudit (7.4s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8784] Built IUTThreeClosures.RootQPilotDivisor (6.9s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8730/8784] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.5s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8784] Built IUTThreeClosures.RamificationCorrectedQPilot (7.3s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8784] Built IUTThreeClosures.AdmissiblePrimeSelection (6.9s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8734/8784] Built IUTThreeClosures.ProductWeightMarginalization (8.3s)
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
⚠ [8735/8784] Built IUTThreeClosures.FiniteExceptionalSet (6.6s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8736/8784] Built IUTThreeClosures.GeneratedUnionCompactness (6.0s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8737/8784] Built Iut.Cor312.LogVolume (6.0s)
✔ [8738/8784] Built TateCurvesTheta.TateCurve.DefectVanishing (107s)
✔ [8739/8795] Built Iut.Cor312.ContainerHull (6.8s)
⚠ [8740/8795] Built IUTThreeClosures.HonestGeneratedSource (6.8s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8742/8799] Built IUTThreeClosures.ZModSL2Perfect (6.4s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8743/8799] Built IUTThreeClosures.QPilotNormalizationFork (6.4s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8744/8799] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.0s)
⚠ [8745/8799] Built IUTThreeClosures.PrimePowerQPilotRegion (8.2s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8746/8799] Built IUTThreeClosures.TateParameterUnitBallRegion (4.6s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8747/8799] Built TateCurvesTheta.TateCurve.TatePointOnCurve (7.5s)
⚠ [8748/8799] Built IUTThreeClosures.FiniteExponentHull (6.9s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8799] Built IUTThreeClosures.StandardZeroLabel (6.1s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8799] Built IUTThreeClosures.BarycentricPacketReading (6.3s)
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
⚠ [8751/8799] Built IUTThreeClosures.DiagonalPacketNoGo (6.2s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8752/8799] Built Genl.GeneralPosition.HeightTheory (1.9s)
⚠ [8753/8799] Built IUTThreeClosures.PublicNormalizationObstruction (6.0s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8754/8799] Built Iut4Sec1.Global.ArithmeticDivisor (6.8s)
⚠ [8755/8799] Built IUTThreeClosures.IUTIVAbsorption (9.7s)
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
⚠ [8756/8799] Built IUTThreeClosures.DistinguishedLabelQPilot (6.8s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8757/8799] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (10s)
✔ [8758/8799] Built TateCurvesTheta.TateCurve.AdditionLaw (12s)
⚠ [8759/8799] Built IUTThreeClosures.ZeroLabelBarycentric (10s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8760/8799] Built TateCurvesTheta.TateCurve.LargePointParametrization (15s)
⚠ [8761/8799] Built IUTThreeClosures.StatementIIOutsideFinite (6.3s)
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
✔ [8762/8799] Built TateCurvesTheta.TateCurve.AbelStep (7.6s)
✔ [8763/8799] Built TateCurvesTheta.TateCurve.GroupLaw (11s)
✔ [8764/8799] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (24s)
✔ [8765/8799] Built TateCurvesTheta.TateCurve.SurjectivitySphere (29s)
✔ [8766/8799] Built TateCurvesTheta.TateCurve.TateUniformization (4.5s)
✔ [8767/8799] Built TateCurvesTheta (3.6s)
✔ [8768/8799] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.8s)
✔ [8769/8799] Built Iut.Cor312.ThetaData.Orbicurve (4.6s)
✔ [8770/8799] Built Iut.Cor312.ThetaData.LocalConditions (7.8s)
✔ [8771/8799] Built Iut.Cor312.ThetaData.Basic (4.5s)
✔ [8772/8799] Built Iut.Cor312.LeftHandSide (4.1s)
✔ [8773/8799] Built Iut.Cor312.RightHandSide (4.3s)
⚠ [8774/8799] Built IUTThreeClosures.NativeQPilotCalibration (4.8s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8775/8799] Built Iut.Cor312.Statement (4.9s)
⚠ [8776/8799] Built IUTThreeClosures.CorrectedQPilotDivisor (5.7s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8777/8799] Built IUTThreeClosures.ActualPilotWitness (4.0s)
✔ [8778/8799] Built IUTThreeClosures.GeneratedSource (4.5s)
✔ [8779/8799] Built IUTThreeClosures.QuantifierCorrectClosure (3.0s)
✖ [8780/8799] Building IUTThreeClosures.PublicLogVolumeInconsistency (4.1s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/PublicLogVolumeInconsistency.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PublicLogVolumeInconsistency.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PublicLogVolumeInconsistency.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PublicLogVolumeInconsistency.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PublicLogVolumeInconsistency.setup.json --json
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:122:4: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  c ≥ 1
  b ≤ 0
  -2 ≤ 2*b - c ≤ -1
  a ≥ 5
where
 a := ↑Dθ.prime.ℓ
 b := ↑(Dθ.ℓ - 1) / 2
 c := ↑Dθ.ℓ
error: Lean exited with code 1
✔ [8781/8799] Built IUTThreeClosures.ABCClosure (4.2s)
✔ [8782/8799] Built IUTThreeClosures.ThreeClosureTheorems (3.9s)
✔ [8783/8799] Built IUTThreeClosures.InhabitationBoundary (4.1s)
✔ [8784/8799] Built IUTThreeClosures.CircularityAudit (4.1s)
✔ [8785/8799] Built IUTThreeClosures.NonCircularDownstream (5.1s)
✔ [8786/8799] Built IUTThreeClosures.FourOpenConstructions (4.2s)
⚠ [8788/8799] Built IUTThreeClosures.ABCPointLegendreCurve (4.6s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8789/8799] Built IUTThreeClosures.BridgeInhabitationAudit (4.0s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8790/8799] Built IUTThreeClosures.LegendreArithmetic (5.0s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8791/8799] Built IUTThreeClosures.ABCFreyCurve (5.2s)
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
✔ [8792/8799] Built IUTThreeClosures.BridgeInhabitationExact (5.8s)
⚠ [8793/8799] Built IUTThreeClosures.TripodWeilHeight (5.9s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8794/8799] Built IUTThreeClosures.CanonicalQPilotCorridor (4.4s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8795/8799] Built IUTThreeClosures.LegendreHeightCorridor (4.8s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8796/8799] Built IUTThreeClosures.CanonicalCorridorAudit (4.2s)
⚠ [8797/8799] Built IUTThreeClosures.SourceDerivedIUTIVBridge (5.2s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Some required targets logged failures:
- IUTThreeClosures.PublicLogVolumeInconsistency
error: build failed
```
