# Lean CI result

- Tested commit: `0f0a45c75ec7e5f0c30dde4f3219c5451cdaa7af`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
427:✖ [8778/8797] Building IUTThreeClosures.PublicLogVolumeInconsistency (3.9s)
434:error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:82:8: typeclass instance problem is stuck
440:error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:95:4: omega could not prove the goal:
450:error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:134:7: Unknown identifier `PointwiseIUTIIIFamily`
453:error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:135:40: unsolved goals
464:error: Lean exited with code 1
481:✖ [8788/8797] Building IUTThreeClosures.LegendreArithmetic (4.2s)
494:error: IUTThreeClosures/LegendreArithmetic.lean:52:46: unsolved goals
499:error: IUTThreeClosures/LegendreArithmetic.lean:143:6: No goals to be solved
503:error: Lean exited with code 1
524:Some required targets logged failures:
527:error: build failed
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
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 14 KB/s], Decompressed: 0Downloaded: 66 file(s) [attempted 66/8639 = 0%, 16 KB/s], Decompressed: 63Downloaded: 152 file(s) [attempted 152/8639 = 1%, 621 KB/s], Decompressed: 148Downloaded: 244 file(s) [attempted 244/8639 = 2%, 838 KB/s], Decompressed: 239Downloaded: 346 file(s) [attempted 346/8639 = 4%, 1672 KB/s], Decompressed: 344Downloaded: 448 file(s) [attempted 448/8639 = 5%, 1911 KB/s], Decompressed: 442Downloaded: 542 file(s) [attempted 542/8639 = 6%, 1465 KB/s], Decompressed: 538Downloaded: 644 file(s) [attempted 644/8639 = 7%, 462 KB/s], Decompressed: 638Downloaded: 751 file(s) [attempted 751/8639 = 8%, 176 KB/s], Decompressed: 746Downloaded: 842 file(s) [attempted 842/8639 = 9%, 1182 KB/s], Decompressed: 839Downloaded: 946 file(s) [attempted 946/8639 = 10%, 468 KB/s], Decompressed: 942Downloaded: 1056 file(s) [attempted 1056/8639 = 12%, 65 KB/s], Decompressed: 1055Downloaded: 1168 file(s) [attempted 1168/8639 = 13%, 370 KB/s], Decompressed: 1163Downloaded: 1271 file(s) [attempted 1271/8639 = 14%, 343 KB/s], Decompressed: 1268Downloaded: 1377 file(s) [attempted 1377/8639 = 15%, 152 KB/s], Decompressed: 1373Downloaded: 1485 file(s) [attempted 1485/8639 = 17%, 321 KB/s], Decompressed: 1483Downloaded: 1598 file(s) [attempted 1598/8639 = 18%, 423 KB/s], Decompressed: 1595Downloaded: 1707 file(s) [attempted 1707/8639 = 19%, 430 KB/s], Decompressed: 1702Downloaded: 1812 file(s) [attempted 1812/8639 = 20%, 810 KB/s], Decompressed: 1807Downloaded: 1915 file(s) [attempted 1915/8639 = 22%, 367 KB/s], Decompressed: 1913Downloaded: 2019 file(s) [attempted 2019/8639 = 23%, 222 KB/s], Decompressed: 2017Downloaded: 2129 file(s) [attempted 2129/8639 = 24%, 1949 KB/s], Decompressed: 2124Downloaded: 2239 file(s) [attempted 2239/8639 = 25%, 1503 KB/s], Decompressed: 2232Downloaded: 2346 file(s) [attempted 2346/8639 = 27%, 365 KB/s], Decompressed: 2343Downloaded: 2451 file(s) [attempted 2451/8639 = 28%, 903 KB/s], Decompressed: 2446Downloaded: 2557 file(s) [attempted 2557/8639 = 29%, 1868 KB/s], Decompressed: 2551Downloaded: 2668 file(s) [attempted 2668/8639 = 30%, 224 KB/s], Decompressed: 2665Downloaded: 2777 file(s) [attempted 2777/8639 = 32%, 489 KB/s], Decompressed: 2770Downloaded: 2887 file(s) [attempted 2887/8639 = 33%, 199 KB/s], Decompressed: 2885Downloaded: 2994 file(s) [attempted 2994/8639 = 34%, 713 KB/s], Decompressed: 2992Downloaded: 3099 file(s) [attempted 3099/8639 = 35%, 921 KB/s], Decompressed: 3097Downloaded: 3211 file(s) [attempted 3211/8639 = 37%, 1518 KB/s], Decompressed: 3204Downloaded: 3316 file(s) [attempted 3316/8639 = 38%, 2987 KB/s], Decompressed: 3314Downloaded: 3430 file(s) [attempted 3430/8639 = 39%, 399 KB/s], Decompressed: 3427Downloaded: 3542 file(s) [attempted 3542/8639 = 41%, 572 KB/s], Decompressed: 3538Downloaded: 3652 file(s) [attempted 3652/8639 = 42%, 220 KB/s], Decompressed: 3647Downloaded: 3758 file(s) [attempted 3758/8639 = 43%, 973 KB/s], Decompressed: 3755Downloaded: 3867 file(s) [attempted 3867/8639 = 44%, 1312 KB/s], Decompressed: 3862Downloaded: 3976 file(s) [attempted 3976/8639 = 46%, 1588 KB/s], Decompressed: 3967Downloaded: 4087 file(s) [attempted 4087/8639 = 47%, 398 KB/s], Decompressed: 4077Downloaded: 4189 file(s) [attempted 4189/8639 = 48%, 90 KB/s], Decompressed: 4179Downloaded: 4298 file(s) [attempted 4298/8639 = 49%, 453 KB/s], Decompressed: 4294Downloaded: 4403 file(s) [attempted 4403/8639 = 50%, 725 KB/s], Decompressed: 4398Downloaded: 4513 file(s) [attempted 4513/8639 = 52%, 918 KB/s], Decompressed: 4508Downloaded: 4619 file(s) [attempted 4619/8639 = 53%, 1241 KB/s], Decompressed: 4615Downloaded: 4725 file(s) [attempted 4725/8639 = 54%, 269 KB/s], Decompressed: 4723Downloaded: 4839 file(s) [attempted 4839/8639 = 56%, 3175 KB/s], Decompressed: 4834Downloaded: 4944 file(s) [attempted 4944/8639 = 57%, 234 KB/s], Decompressed: 4940Downloaded: 5052 file(s) [attempted 5052/8639 = 58%, 1146 KB/s], Decompressed: 5038Downloaded: 5166 file(s) [attempted 5166/8639 = 59%, 289 KB/s], Decompressed: 5159Downloaded: 5268 file(s) [attempted 5268/8639 = 60%, 822 KB/s], Decompressed: 5261Downloaded: 5380 file(s) [attempted 5380/8639 = 62%, 113 KB/s], Decompressed: 5377Downloaded: 5488 file(s) [attempted 5488/8639 = 63%, 2146 KB/s], Decompressed: 5483Downloaded: 5597 file(s) [attempted 5597/8639 = 64%, 3007 KB/s], Decompressed: 5593Downloaded: 5714 file(s) [attempted 5714/8639 = 66%, 443 KB/s], Decompressed: 5709Downloaded: 5814 file(s) [attempted 5814/8639 = 67%, 441 KB/s], Decompressed: 5812Downloaded: 5923 file(s) [attempted 5923/8639 = 68%, 381 KB/s], Decompressed: 5919Downloaded: 6033 file(s) [attempted 6033/8639 = 69%, 323 KB/s], Decompressed: 6028Downloaded: 6143 file(s) [attempted 6143/8639 = 71%, 347 KB/s], Decompressed: 6138Downloaded: 6244 file(s) [attempted 6244/8639 = 72%, 854 KB/s], Decompressed: 6241Downloaded: 6349 file(s) [attempted 6349/8639 = 73%, 1044 KB/s], Decompressed: 6346Downloaded: 6458 file(s) [attempted 6458/8639 = 74%, 1308 KB/s], Decompressed: 6453Downloaded: 6564 file(s) [attempted 6564/8639 = 75%, 834 KB/s], Decompressed: 6562Downloaded: 6669 file(s) [attempted 6669/8639 = 77%, 314 KB/s], Decompressed: 6666Downloaded: 6778 file(s) [attempted 6778/8639 = 78%, 1211 KB/s], Decompressed: 6773Downloaded: 6884 file(s) [attempted 6884/8639 = 79%, 564 KB/s], Decompressed: 6880Downloaded: 6997 file(s) [attempted 6997/8639 = 80%, 184 KB/s], Decompressed: 6994Downloaded: 7106 file(s) [attempted 7106/8639 = 82%, 536 KB/s], Decompressed: 7102Downloaded: 7218 file(s) [attempted 7218/8639 = 83%, 3742 KB/s], Decompressed: 7216Downloaded: 7322 file(s) [attempted 7322/8639 = 84%, 2039 KB/s], Decompressed: 7319Downloaded: 7426 file(s) [attempted 7426/8639 = 85%, 2018 KB/s], Decompressed: 7421Downloaded: 7531 file(s) [attempted 7531/8639 = 87%, 708 KB/s], Decompressed: 7530Downloaded: 7642 file(s) [attempted 7642/8639 = 88%, 2084 KB/s], Decompressed: 7636Downloaded: 7757 file(s) [attempted 7757/8639 = 89%, 918 KB/s], Decompressed: 7752Downloaded: 7863 file(s) [attempted 7863/8639 = 91%, 1770 KB/s], Decompressed: 7860Downloaded: 7969 file(s) [attempted 7969/8639 = 92%, 532 KB/s], Decompressed: 7968Downloaded: 8081 file(s) [attempted 8081/8639 = 93%, 1646 KB/s], Decompressed: 8079Downloaded: 8191 file(s) [attempted 8191/8639 = 94%, 129 KB/s], Decompressed: 8189Downloaded: 8298 file(s) [attempted 8298/8639 = 96%, 61 KB/s], Decompressed: 8291Downloaded: 8408 file(s) [attempted 8408/8639 = 97%, 1036 KB/s], Decompressed: 8403Downloaded: 8515 file(s) [attempted 8515/8639 = 98%, 481 KB/s], Decompressed: 8508Downloaded: 8625 file(s) [attempted 8625/8639 = 99%, 206 KB/s], Decompressed: 8622Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 206 KB/s], Decompressed: 8629
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (357ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.5s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.8s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.4s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (8.9s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (8.1s)
✔ [8662/8673] Built Iut.Cor312.ThetaData.Places (7.3s)
✔ [8663/8675] Built TateCurvesTheta.Analysis.Strassmann (4.0s)
✔ [8664/8675] Built TateCurvesTheta.QParameter.BaseChange (3.4s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.8s)
✔ [8666/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (2.9s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (6.1s)
✔ [8668/8680] Built TateCurvesTheta.TateCurve.Discriminant (5.7s)
✔ [8669/8680] Built TateCurvesTheta.QParameter.NormalizedOrder (4.6s)
✔ [8670/8680] Built TateCurvesTheta.TateCurve.Parametrization (4.3s)
✔ [8671/8680] Built TateCurvesTheta.TateCurve.SplitReduction (4.4s)
✔ [8672/8680] Built TateCurvesTheta.TateCurve.JInvariant (3.8s)
✔ [8673/8684] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (2.9s)
✔ [8675/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (3.9s)
✔ [8676/8696] Built TateCurvesTheta.Theta.Basic (4.3s)
✔ [8677/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (6.0s)
✔ [8678/8696] Built TateCurvesTheta.QParameter.JParametrization (9.9s)
✔ [8679/8696] Built TateCurvesTheta.Theta.Periodicity (4.6s)
✔ [8680/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (10s)
✔ [8681/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (9.4s)
✔ [8682/8705] Built TateCurvesTheta.QParameter.Characterization (3.1s)
✔ [8683/8708] Built TateCurvesTheta.TateCurve.CoordinateInversion (4.9s)
✔ [8684/8708] Built TateCurvesTheta.Theta.Product (6.0s)
✔ [8685/8708] Built TateCurvesTheta.Theta.QBinomial (7.6s)
✔ [8686/8708] Built TateCurvesTheta.TateCurve.EisensteinSeries (13s)
✔ [8687/8712] Built TateCurvesTheta.Theta.Divisor (4.6s)
✔ [8688/8713] Built TateCurvesTheta.Theta.Uniqueness (4.1s)
✔ [8689/8714] Built TateCurvesTheta.Theta.FactorSeries (4.6s)
✔ [8690/8714] Built TateCurvesTheta.TateCurve.Quotient (8.0s)
✔ [8691/8714] Built TateCurvesTheta.TateCurve.IntegralModel (5.0s)
✔ [8692/8716] Built TateCurvesTheta.Theta.LaurentSphere (4.9s)
✔ [8693/8716] Built TateCurvesTheta.TateCurve.SphereBounds (7.2s)
✔ [8694/8717] Built TateCurvesTheta.TateCurve.TatePointMem (4.4s)
✔ [8695/8718] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.4s)
✔ [8696/8719] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.3s)
✔ [8697/8720] Built TateCurvesTheta.Theta.FactorReciprocal (3.6s)
✔ [8698/8721] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.5s)
✔ [8699/8721] Built TateCurvesTheta.TateCurve.PointMap (7.5s)
✔ [8700/8729] Built TateCurvesTheta.Theta.LaurentUnique (4.1s)
✔ [8701/8729] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.5s)
✔ [8702/8729] Built TateCurvesTheta.Theta.SeriesZero (2.9s)
✔ [8703/8729] Built TateCurvesTheta.Theta.RatioAnnulus (3.7s)
✔ [8704/8729] Built TateCurvesTheta.Theta.TripleProduct (3.2s)
✔ [8705/8729] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.7s)
✔ [8706/8731] Built TateCurvesTheta.Theta.StrictDominant (6.7s)
✔ [8707/8733] Built TateCurvesTheta.Theta.Normalization (3.3s)
✔ [8708/8735] Built TateCurvesTheta.Uniformization (8.1s)
✔ [8709/8735] Built Iut.Cor312.Procession (9.1s)
✔ [8710/8764] Built Iut.Cor312.RationalPlace (8.8s)
✔ [8711/8764] Built TateCurvesTheta.Theta.Durfee (6.5s)
✔ [8712/8764] Built IUTThreeClosures.ABCStatement (2.8s)
✔ [8713/8764] Built Iut.Cor312.PacketPresentation (6.9s)
⚠ [8714/8782] Built IUTThreeClosures.HonestFinitePositiveLogVolume (6.0s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8716/8782] Built IUTThreeClosures.FullPolyCore (6.5s)
✔ [8717/8782] Built TateCurvesTheta.Theta.Inversion (3.6s)
⚠ [8718/8782] Built IUTThreeClosures.Cor312CoefficientAlgebra (6.5s)
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
✔ [8719/8782] Built TateCurvesTheta.Theta.WeightSpace (16s)
✔ [8720/8782] Built Iut.Cor312.Container (14s)
✔ [8721/8782] Built Iut.Cor312.HolomorphicHull (8.7s)
⚠ [8722/8782] Built IUTThreeClosures.HonestPilotWitness (10s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8723/8782] Built IUTThreeClosures.ExplicitSemistableCurve (8.9s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8724/8782] Built Heights.WeilHeight (10s)
⚠ [8725/8782] Built IUTThreeClosures.QPilotNormalizationAudit (8.2s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8726/8782] Built IUTThreeClosures.SolvableRestrictionImage (9.2s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8727/8782] Built TateCurvesTheta.Theta.PuncturedProduct (50s)
⚠ [8728/8782] Built IUTThreeClosures.RootQPilotDivisor (6.9s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8729/8782] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.9s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8730/8782] Built IUTThreeClosures.RamificationCorrectedQPilot (6.6s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8782] Built IUTThreeClosures.AdmissiblePrimeSelection (6.3s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8733/8782] Built IUTThreeClosures.ProductWeightMarginalization (7.9s)
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
⚠ [8734/8782] Built IUTThreeClosures.FiniteExceptionalSet (5.0s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8735/8782] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.4s)
⚠ [8736/8782] Built IUTThreeClosures.GeneratedUnionCompactness (5.8s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8737/8782] Built Iut.Cor312.LogVolume (6.2s)
✔ [8739/8797] Built Iut.Cor312.ContainerHull (5.7s)
⚠ [8740/8797] Built IUTThreeClosures.QPilotNormalizationFork (6.2s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8741/8797] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.4s)
⚠ [8742/8797] Built IUTThreeClosures.ZModSL2Perfect (6.1s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8743/8797] Built IUTThreeClosures.PrimePowerQPilotRegion (6.6s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8744/8797] Built IUTThreeClosures.TateParameterUnitBallRegion (2.9s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8745/8797] Built IUTThreeClosures.FiniteExponentHull (5.6s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8746/8797] Built TateCurvesTheta.TateCurve.DefectVanishing (101s)
⚠ [8747/8797] Built IUTThreeClosures.StandardZeroLabel (6.1s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8748/8797] Built IUTThreeClosures.BarycentricPacketReading (6.3s)
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
⚠ [8749/8797] Built IUTThreeClosures.DiagonalPacketNoGo (5.7s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8750/8797] Built Genl.GeneralPosition.HeightTheory (1.0s)
⚠ [8751/8797] Built IUTThreeClosures.PublicNormalizationObstruction (6.2s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8752/8797] Built Iut4Sec1.Global.ArithmeticDivisor (6.2s)
⚠ [8753/8797] Built IUTThreeClosures.IUTIVAbsorption (8.0s)
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
✔ [8754/8797] Built TateCurvesTheta.TateCurve.TatePointOnCurve (6.8s)
⚠ [8755/8797] Built IUTThreeClosures.DistinguishedLabelQPilot (6.9s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8756/8797] Built IUTThreeClosures.ZeroLabelBarycentric (6.4s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
⚠ [8757/8797] Built IUTThreeClosures.StatementIIOutsideFinite (6.0s)
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
✔ [8758/8797] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (8.5s)
✔ [8759/8797] Built TateCurvesTheta.TateCurve.AdditionLaw (9.7s)
✔ [8760/8797] Built TateCurvesTheta.TateCurve.LargePointParametrization (13s)
✔ [8761/8797] Built TateCurvesTheta.TateCurve.AbelStep (6.3s)
✔ [8762/8797] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8763/8797] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (21s)
✔ [8764/8797] Built TateCurvesTheta.TateCurve.SurjectivitySphere (27s)
✔ [8765/8797] Built TateCurvesTheta.TateCurve.TateUniformization (4.0s)
✔ [8766/8797] Built TateCurvesTheta (3.4s)
✔ [8767/8797] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.5s)
✔ [8768/8797] Built Iut.Cor312.ThetaData.Orbicurve (4.4s)
✔ [8769/8797] Built Iut.Cor312.ThetaData.LocalConditions (7.4s)
✔ [8770/8797] Built Iut.Cor312.ThetaData.Basic (4.3s)
✔ [8771/8797] Built Iut.Cor312.LeftHandSide (3.9s)
✔ [8772/8797] Built Iut.Cor312.RightHandSide (4.1s)
✔ [8773/8797] Built Iut.Cor312.Statement (3.0s)
⚠ [8774/8797] Built IUTThreeClosures.NativeQPilotCalibration (5.2s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8775/8797] Built IUTThreeClosures.CorrectedQPilotDivisor (5.7s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8776/8797] Built IUTThreeClosures.ActualPilotWitness (4.1s)
✔ [8777/8797] Built IUTThreeClosures.GeneratedSource (4.3s)
✖ [8778/8797] Building IUTThreeClosures.PublicLogVolumeInconsistency (3.9s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/PublicLogVolumeInconsistency.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PublicLogVolumeInconsistency.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PublicLogVolumeInconsistency.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PublicLogVolumeInconsistency.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PublicLogVolumeInconsistency.setup.json --json
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:82:8: typeclass instance problem is stuck
  Finite ?m.12

Note: Lean will not try to resolve this typeclass instance problem because the type argument to `Finite` is a metavariable. This argument must be fully determined before Lean will try to resolve the typeclass.

Hint: Adding type annotations and supplying implicit arguments to functions can give Lean more information for typeclass resolution. For example, if you have a variable `x` that you intend to be a `Nat`, but Lean reports it as having an unresolved type like `?m`, replacing `x` with `(x : Nat)` can get typeclass resolution un-stuck.
error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:95:4: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  c ≥ 1
  b ≤ 0
  -2 ≤ 2*b - c ≤ -1
  a ≥ 5
where
 a := ↑Dθ.prime.ℓ
 b := ↑(Dθ.ℓ - 1) / 2
 c := ↑Dθ.ℓ
error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:134:7: Unknown identifier `PointwiseIUTIIIFamily`

Note: It is not possible to treat `PointwiseIUTIIIFamily` as an implicitly bound variable here because it has multiple characters while the `relaxedAutoImplicit` option is set to `false`.
error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:135:40: unsolved goals
AG : AnabelianGeometry
TG : TemperedGeometry AG
Input : Type z
inst✝ : Nonempty Input
F : sorry
x : Input
⊢ False
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:141:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
✔ [8779/8797] Built IUTThreeClosures.QuantifierCorrectClosure (4.0s)
✔ [8780/8797] Built IUTThreeClosures.ABCClosure (3.7s)
✔ [8781/8797] Built IUTThreeClosures.ThreeClosureTheorems (3.7s)
✔ [8782/8797] Built IUTThreeClosures.InhabitationBoundary (3.8s)
✔ [8783/8797] Built IUTThreeClosures.CircularityAudit (3.9s)
✔ [8784/8797] Built IUTThreeClosures.NonCircularDownstream (4.9s)
✔ [8785/8797] Built IUTThreeClosures.FourOpenConstructions (3.0s)
⚠ [8787/8797] Built IUTThreeClosures.ABCPointLegendreCurve (4.3s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✖ [8788/8797] Building IUTThreeClosures.LegendreArithmetic (4.2s)
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
⚠ [8791/8797] Built IUTThreeClosures.BridgeInhabitationAudit (4.8s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8792/8797] Built IUTThreeClosures.BridgeInhabitationExact (3.7s)
⚠ [8793/8797] Built IUTThreeClosures.CanonicalQPilotCorridor (3.8s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8794/8797] Built IUTThreeClosures.CanonicalCorridorAudit (3.9s)
⚠ [8795/8797] Built IUTThreeClosures.SourceDerivedIUTIVBridge (4.8s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Some required targets logged failures:
- IUTThreeClosures.PublicLogVolumeInconsistency
- IUTThreeClosures.LegendreArithmetic
error: build failed
```
