# Lean CI result

- Tested commit: `4cb549599084fe5260db1a6883a32ee577262cae`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
434:✖ [8780/8799] Building IUTThreeClosures.PublicLogVolumeInconsistency (3.5s)
441:error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:122:4: omega could not prove the goal:
448:error: Lean exited with code 1
535:Some required targets logged failures:
537:error: build failed
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
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 73 KB/s], Decompressed: 0Downloaded: 75 file(s) [attempted 75/8639 = 0%, 749 KB/s], Decompressed: 72Downloaded: 152 file(s) [attempted 152/8639 = 1%, 718 KB/s], Decompressed: 150Downloaded: 237 file(s) [attempted 237/8639 = 2%, 1917 KB/s], Decompressed: 234Downloaded: 332 file(s) [attempted 332/8639 = 3%, 865 KB/s], Decompressed: 327Downloaded: 430 file(s) [attempted 430/8639 = 4%, 1129 KB/s], Decompressed: 428Downloaded: 527 file(s) [attempted 527/8639 = 6%, 175 KB/s], Decompressed: 523Downloaded: 626 file(s) [attempted 626/8639 = 7%, 500 KB/s], Decompressed: 621Downloaded: 727 file(s) [attempted 727/8639 = 8%, 714 KB/s], Decompressed: 724Downloaded: 829 file(s) [attempted 829/8639 = 9%, 1625 KB/s], Decompressed: 828Downloaded: 929 file(s) [attempted 929/8639 = 10%, 777 KB/s], Decompressed: 925Downloaded: 1028 file(s) [attempted 1028/8639 = 11%, 1324 KB/s], Decompressed: 1025Downloaded: 1132 file(s) [attempted 1132/8639 = 13%, 1707 KB/s], Decompressed: 1130Downloaded: 1237 file(s) [attempted 1237/8639 = 14%, 327 KB/s], Decompressed: 1235Downloaded: 1342 file(s) [attempted 1342/8639 = 15%, 255 KB/s], Decompressed: 1340Downloaded: 1447 file(s) [attempted 1447/8639 = 16%, 265 KB/s], Decompressed: 1445Downloaded: 1552 file(s) [attempted 1552/8639 = 17%, 189 KB/s], Decompressed: 1550Downloaded: 1655 file(s) [attempted 1655/8639 = 19%, 1843 KB/s], Decompressed: 1652Downloaded: 1759 file(s) [attempted 1759/8639 = 20%, 576 KB/s], Decompressed: 1755Downloaded: 1863 file(s) [attempted 1863/8639 = 21%, 345 KB/s], Decompressed: 1860Downloaded: 1963 file(s) [attempted 1963/8639 = 22%, 222 KB/s], Decompressed: 1958Downloaded: 2061 file(s) [attempted 2061/8639 = 23%, 2042 KB/s], Decompressed: 2058Downloaded: 2163 file(s) [attempted 2163/8639 = 25%, 1582 KB/s], Decompressed: 2158Downloaded: 2268 file(s) [attempted 2268/8639 = 26%, 853 KB/s], Decompressed: 2265Downloaded: 2371 file(s) [attempted 2371/8639 = 27%, 111 KB/s], Decompressed: 2368Downloaded: 2469 file(s) [attempted 2469/8639 = 28%, 3241 KB/s], Decompressed: 2466Downloaded: 2571 file(s) [attempted 2571/8639 = 29%, 1298 KB/s], Decompressed: 2566Downloaded: 2680 file(s) [attempted 2680/8639 = 31%, 63 KB/s], Decompressed: 2676Downloaded: 2783 file(s) [attempted 2783/8639 = 32%, 1615 KB/s], Decompressed: 2781Downloaded: 2885 file(s) [attempted 2885/8639 = 33%, 2403 KB/s], Decompressed: 2883Downloaded: 2990 file(s) [attempted 2990/8639 = 34%, 205 KB/s], Decompressed: 2988Downloaded: 3092 file(s) [attempted 3092/8639 = 35%, 955 KB/s], Decompressed: 3086Downloaded: 3195 file(s) [attempted 3195/8639 = 36%, 133 KB/s], Decompressed: 3193Downloaded: 3300 file(s) [attempted 3300/8639 = 38%, 2136 KB/s], Decompressed: 3293Downloaded: 3408 file(s) [attempted 3408/8639 = 39%, 207 KB/s], Decompressed: 3403Downloaded: 3510 file(s) [attempted 3510/8639 = 40%, 789 KB/s], Decompressed: 3508Downloaded: 3615 file(s) [attempted 3615/8639 = 41%, 333 KB/s], Decompressed: 3613Downloaded: 3718 file(s) [attempted 3718/8639 = 43%, 767 KB/s], Decompressed: 3715Downloaded: 3820 file(s) [attempted 3820/8639 = 44%, 570 KB/s], Decompressed: 3818Downloaded: 3927 file(s) [attempted 3927/8639 = 45%, 427 KB/s], Decompressed: 3925Downloaded: 4032 file(s) [attempted 4032/8639 = 46%, 896 KB/s], Decompressed: 4030Downloaded: 4135 file(s) [attempted 4135/8639 = 47%, 146 KB/s], Decompressed: 4130Downloaded: 4237 file(s) [attempted 4237/8639 = 49%, 376 KB/s], Decompressed: 4233Downloaded: 4342 file(s) [attempted 4342/8639 = 50%, 161 KB/s], Decompressed: 4338Downloaded: 4447 file(s) [attempted 4447/8639 = 51%, 1069 KB/s], Decompressed: 4445Downloaded: 4552 file(s) [attempted 4552/8639 = 52%, 470 KB/s], Decompressed: 4550Downloaded: 4662 file(s) [attempted 4662/8639 = 53%, 275 KB/s], Decompressed: 4659Downloaded: 4763 file(s) [attempted 4763/8639 = 55%, 2926 KB/s], Decompressed: 4757Downloaded: 4865 file(s) [attempted 4865/8639 = 56%, 4265 KB/s], Decompressed: 4862Downloaded: 4969 file(s) [attempted 4969/8639 = 57%, 3345 KB/s], Decompressed: 4968Downloaded: 5074 file(s) [attempted 5074/8639 = 58%, 1157 KB/s], Decompressed: 5070Downloaded: 5179 file(s) [attempted 5179/8639 = 59%, 122 KB/s], Decompressed: 5177Downloaded: 5277 file(s) [attempted 5277/8639 = 61%, 3202 KB/s], Decompressed: 5275Downloaded: 5384 file(s) [attempted 5384/8639 = 62%, 1040 KB/s], Decompressed: 5380Downloaded: 5489 file(s) [attempted 5489/8639 = 63%, 524 KB/s], Decompressed: 5487Downloaded: 5599 file(s) [attempted 5599/8639 = 64%, 346 KB/s], Decompressed: 5592Downloaded: 5702 file(s) [attempted 5702/8639 = 66%, 2075 KB/s], Decompressed: 5699Downloaded: 5804 file(s) [attempted 5804/8639 = 67%, 1040 KB/s], Decompressed: 5802Downloaded: 5904 file(s) [attempted 5904/8639 = 68%, 259 KB/s], Decompressed: 5900Downloaded: 6010 file(s) [attempted 6010/8639 = 69%, 408 KB/s], Decompressed: 6004Downloaded: 6122 file(s) [attempted 6122/8639 = 70%, 1960 KB/s], Decompressed: 6116Downloaded: 6224 file(s) [attempted 6224/8639 = 72%, 3486 KB/s], Decompressed: 6221Downloaded: 6326 file(s) [attempted 6326/8639 = 73%, 451 KB/s], Decompressed: 6324Downloaded: 6426 file(s) [attempted 6426/8639 = 74%, 1084 KB/s], Decompressed: 6419Downloaded: 6531 file(s) [attempted 6531/8639 = 75%, 916 KB/s], Decompressed: 6524Downloaded: 6636 file(s) [attempted 6636/8639 = 76%, 433 KB/s], Decompressed: 6634Downloaded: 6736 file(s) [attempted 6736/8639 = 77%, 1334 KB/s], Decompressed: 6734Downloaded: 6841 file(s) [attempted 6841/8639 = 79%, 368 KB/s], Decompressed: 6837Downloaded: 6951 file(s) [attempted 6951/8639 = 80%, 640 KB/s], Decompressed: 6946Downloaded: 7054 file(s) [attempted 7054/8639 = 81%, 1726 KB/s], Decompressed: 7049Downloaded: 7154 file(s) [attempted 7154/8639 = 82%, 1097 KB/s], Decompressed: 7151Downloaded: 7259 file(s) [attempted 7259/8639 = 84%, 150 KB/s], Decompressed: 7254Downloaded: 7363 file(s) [attempted 7363/8639 = 85%, 470 KB/s], Decompressed: 7357Downloaded: 7466 file(s) [attempted 7466/8639 = 86%, 354 KB/s], Decompressed: 7459Downloaded: 7570 file(s) [attempted 7570/8639 = 87%, 948 KB/s], Decompressed: 7566Downloaded: 7678 file(s) [attempted 7678/8639 = 88%, 529 KB/s], Decompressed: 7676Downloaded: 7784 file(s) [attempted 7784/8639 = 90%, 520 KB/s], Decompressed: 7778Downloaded: 7890 file(s) [attempted 7890/8639 = 91%, 516 KB/s], Decompressed: 7888Downloaded: 7998 file(s) [attempted 7998/8639 = 92%, 76 KB/s], Decompressed: 7994Downloaded: 8100 file(s) [attempted 8100/8639 = 93%, 926 KB/s], Decompressed: 8093Downloaded: 8199 file(s) [attempted 8199/8639 = 94%, 540 KB/s], Decompressed: 8193Downloaded: 8305 file(s) [attempted 8305/8639 = 96%, 1308 KB/s], Decompressed: 8303Downloaded: 8413 file(s) [attempted 8413/8639 = 97%, 715 KB/s], Decompressed: 8410Downloaded: 8515 file(s) [attempted 8515/8639 = 98%, 2800 KB/s], Decompressed: 8513Downloaded: 8619 file(s) [attempted 8619/8639 = 99%, 394 KB/s], Decompressed: 8615Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 394 KB/s], Decompressed: 8636
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (377ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (2.8s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.4s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (2.8s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (7.8s)
✔ [8661/8671] Built Iut.Cor312.ThetaData.Places (6.0s)
✔ [8662/8673] Built TateCurvesTheta.AnalyticQuotient (7.8s)
✔ [8663/8675] Built TateCurvesTheta.QParameter.BaseChange (2.9s)
✔ [8664/8675] Built TateCurvesTheta.Analysis.Strassmann (4.9s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.2s)
✔ [8666/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (2.6s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.4s)
✔ [8668/8680] Built TateCurvesTheta.TateCurve.Discriminant (4.9s)
✔ [8669/8680] Built TateCurvesTheta.QParameter.NormalizedOrder (4.3s)
✔ [8670/8680] Built TateCurvesTheta.TateCurve.Parametrization (3.0s)
✔ [8671/8680] Built TateCurvesTheta.TateCurve.JInvariant (3.1s)
✔ [8672/8680] Built Iut.Cor312.ThetaData.GlobalField (12s)
✔ [8673/8684] Built TateCurvesTheta.TateCurve.SplitReduction (4.2s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (2.7s)
✔ [8675/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (3.5s)
✔ [8676/8696] Built TateCurvesTheta.Theta.Basic (3.9s)
✔ [8677/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (4.9s)
✔ [8678/8696] Built TateCurvesTheta.QParameter.JParametrization (8.9s)
✔ [8679/8696] Built TateCurvesTheta.Theta.Periodicity (4.8s)
✔ [8680/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (9.1s)
✔ [8681/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (9.4s)
✔ [8682/8705] Built TateCurvesTheta.QParameter.Characterization (3.1s)
✔ [8683/8708] Built TateCurvesTheta.Theta.Product (4.0s)
✔ [8684/8708] Built TateCurvesTheta.TateCurve.CoordinateInversion (4.0s)
✔ [8685/8708] Built TateCurvesTheta.Theta.QBinomial (7.2s)
✔ [8686/8708] Built TateCurvesTheta.Theta.Divisor (5.2s)
✔ [8687/8708] Built TateCurvesTheta.TateCurve.EisensteinSeries (13s)
✔ [8688/8713] Built TateCurvesTheta.Theta.Uniqueness (3.0s)
✔ [8689/8714] Built TateCurvesTheta.Theta.FactorSeries (4.8s)
✔ [8690/8714] Built TateCurvesTheta.TateCurve.IntegralModel (5.4s)
✔ [8691/8714] Built TateCurvesTheta.TateCurve.Quotient (7.1s)
✔ [8692/8716] Built TateCurvesTheta.Theta.LaurentSphere (4.5s)
✔ [8693/8716] Built TateCurvesTheta.TateCurve.SphereBounds (6.8s)
✔ [8694/8717] Built TateCurvesTheta.TateCurve.TatePointMem (3.2s)
✔ [8695/8719] Built TateCurvesTheta.Theta.LaurentSphereReduce (2.9s)
✔ [8696/8719] Built TateCurvesTheta.Theta.ThetaProdLaurent (4.5s)
✔ [8697/8721] Built TateCurvesTheta.Theta.FactorReciprocal (3.2s)
✔ [8698/8721] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.1s)
✔ [8699/8721] Built TateCurvesTheta.Theta.LaurentUnique (3.4s)
✔ [8700/8729] Built TateCurvesTheta.TateCurve.PointMap (7.4s)
✔ [8701/8729] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (3.8s)
✔ [8702/8729] Built TateCurvesTheta.Theta.SeriesZero (2.5s)
✔ [8703/8729] Built TateCurvesTheta.Theta.RatioAnnulus (3.2s)
✔ [8704/8729] Built TateCurvesTheta.Theta.TripleProduct (3.1s)
✔ [8705/8729] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.3s)
✔ [8706/8731] Built TateCurvesTheta.Theta.StrictDominant (6.3s)
✔ [8707/8733] Built TateCurvesTheta.Theta.Normalization (3.0s)
✔ [8708/8735] Built TateCurvesTheta.Uniformization (6.9s)
✔ [8709/8735] Built Iut.Cor312.RationalPlace (7.2s)
✔ [8710/8765] Built Iut.Cor312.Procession (8.5s)
✔ [8711/8765] Built TateCurvesTheta.Theta.Durfee (6.9s)
✔ [8712/8765] Built IUTThreeClosures.ABCStatement (2.1s)
✔ [8713/8765] Built Iut.Cor312.PacketPresentation (6.6s)
⚠ [8714/8784] Built IUTThreeClosures.HonestFinitePositiveLogVolume (6.4s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8716/8784] Built IUTThreeClosures.FullPolyCore (5.5s)
✔ [8717/8784] Built TateCurvesTheta.Theta.Inversion (3.4s)
⚠ [8718/8784] Built IUTThreeClosures.Cor312CoefficientAlgebra (5.4s)
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
✔ [8719/8784] Built Iut.Cor312.Container (11s)
✔ [8720/8784] Built TateCurvesTheta.Theta.WeightSpace (16s)
✔ [8721/8784] Built Iut.Cor312.HolomorphicHull (9.1s)
⚠ [8722/8784] Built IUTThreeClosures.HonestPilotWitness (8.7s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8723/8784] Built IUTThreeClosures.ExplicitSemistableCurve (8.5s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8724/8784] Built Heights.WeilHeight (11s)
⚠ [8725/8784] Built IUTThreeClosures.SolvableRestrictionImage (7.8s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8726/8784] Built IUTThreeClosures.QPilotNormalizationAudit (7.6s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8727/8784] Built TateCurvesTheta.Theta.PuncturedProduct (44s)
⚠ [8728/8784] Built IUTThreeClosures.RootQPilotDivisor (6.4s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8729/8784] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.1s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8730/8784] Built IUTThreeClosures.RamificationCorrectedQPilot (6.2s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8784] Built IUTThreeClosures.AdmissiblePrimeSelection (5.7s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8733/8784] Built IUTThreeClosures.ProductWeightMarginalization (6.7s)
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
⚠ [8734/8784] Built IUTThreeClosures.FiniteExceptionalSet (5.3s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8735/8784] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.3s)
⚠ [8736/8784] Built IUTThreeClosures.GeneratedUnionCompactness (4.9s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8737/8784] Built Iut.Cor312.LogVolume (5.5s)
⚠ [8738/8784] Built IUTThreeClosures.HonestGeneratedSource (5.3s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8740/8799] Built Iut.Cor312.ContainerHull (5.4s)
⚠ [8741/8799] Built IUTThreeClosures.ZModSL2Perfect (5.6s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8742/8799] Built IUTThreeClosures.QPilotNormalizationFork (5.6s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8743/8799] Built IUTThreeClosures.PrimePowerQPilotRegion (5.7s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8744/8799] Built TateCurvesTheta.TateCurve.DefectVanishing (89s)
✔ [8745/8799] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.6s)
⚠ [8746/8799] Built IUTThreeClosures.TateParameterUnitBallRegion (2.6s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8747/8799] Built IUTThreeClosures.FiniteExponentHull (5.2s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8748/8799] Built IUTThreeClosures.StandardZeroLabel (5.2s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8799] Built IUTThreeClosures.BarycentricPacketReading (5.6s)
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
⚠ [8750/8799] Built IUTThreeClosures.DiagonalPacketNoGo (5.2s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8751/8799] Built IUTThreeClosures.PublicNormalizationObstruction (5.8s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8752/8799] Built Iut4Sec1.Global.ArithmeticDivisor (5.6s)
⚠ [8753/8799] Built IUTThreeClosures.DistinguishedLabelQPilot (5.3s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8754/8799] Built IUTThreeClosures.IUTIVAbsorption (8.1s)
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
✔ [8755/8799] Built Genl.GeneralPosition.HeightTheory (1.5s)
✔ [8756/8799] Built TateCurvesTheta.TateCurve.TatePointOnCurve (5.3s)
⚠ [8757/8799] Built IUTThreeClosures.ZeroLabelBarycentric (5.6s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
⚠ [8758/8799] Built IUTThreeClosures.StatementIIOutsideFinite (5.4s)
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
✔ [8759/8799] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (7.2s)
✔ [8760/8799] Built TateCurvesTheta.TateCurve.AdditionLaw (9.7s)
✔ [8761/8799] Built TateCurvesTheta.TateCurve.LargePointParametrization (11s)
✔ [8762/8799] Built TateCurvesTheta.TateCurve.AbelStep (6.1s)
✔ [8763/8799] Built TateCurvesTheta.TateCurve.GroupLaw (9.9s)
✔ [8764/8799] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (22s)
✔ [8765/8799] Built TateCurvesTheta.TateCurve.SurjectivitySphere (22s)
✔ [8766/8799] Built TateCurvesTheta.TateCurve.TateUniformization (3.8s)
✔ [8767/8799] Built TateCurvesTheta (3.1s)
✔ [8768/8799] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.3s)
✔ [8769/8799] Built Iut.Cor312.ThetaData.Orbicurve (4.1s)
✔ [8770/8799] Built Iut.Cor312.ThetaData.LocalConditions (7.2s)
✔ [8771/8799] Built Iut.Cor312.ThetaData.Basic (4.0s)
✔ [8772/8799] Built Iut.Cor312.LeftHandSide (3.5s)
✔ [8773/8799] Built Iut.Cor312.RightHandSide (3.7s)
✔ [8774/8799] Built Iut.Cor312.Statement (3.5s)
⚠ [8775/8799] Built IUTThreeClosures.NativeQPilotCalibration (5.3s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8776/8799] Built IUTThreeClosures.CorrectedQPilotDivisor (5.3s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8777/8799] Built IUTThreeClosures.ActualPilotWitness (3.9s)
✔ [8778/8799] Built IUTThreeClosures.GeneratedSource (3.0s)
✔ [8779/8799] Built IUTThreeClosures.QuantifierCorrectClosure (3.5s)
✖ [8780/8799] Building IUTThreeClosures.PublicLogVolumeInconsistency (3.5s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/PublicLogVolumeInconsistency.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PublicLogVolumeInconsistency.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PublicLogVolumeInconsistency.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PublicLogVolumeInconsistency.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PublicLogVolumeInconsistency.setup.json --json
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:122:4: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  1 ≤ b ≤ 2
  a ≥ 5
where
 a := ↑Dθ.prime.ℓ
 b := ↑Dθ.ℓ
error: Lean exited with code 1
✔ [8781/8799] Built IUTThreeClosures.ABCClosure (3.6s)
✔ [8782/8799] Built IUTThreeClosures.ThreeClosureTheorems (3.4s)
✔ [8783/8799] Built IUTThreeClosures.InhabitationBoundary (3.6s)
✔ [8784/8799] Built IUTThreeClosures.CircularityAudit (3.7s)
✔ [8785/8799] Built IUTThreeClosures.NonCircularDownstream (4.6s)
✔ [8786/8799] Built IUTThreeClosures.FourOpenConstructions (3.8s)
⚠ [8788/8799] Built IUTThreeClosures.ABCPointLegendreCurve (4.2s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8789/8799] Built IUTThreeClosures.BridgeInhabitationAudit (4.4s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8790/8799] Built IUTThreeClosures.LegendreArithmetic (4.3s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8791/8799] Built IUTThreeClosures.TripodWeilHeight (3.8s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8792/8799] Built IUTThreeClosures.BridgeInhabitationExact (4.0s)
⚠ [8793/8799] Built IUTThreeClosures.ABCFreyCurve (5.7s)
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
⚠ [8794/8799] Built IUTThreeClosures.LegendreHeightCorridor (4.1s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8795/8799] Built IUTThreeClosures.CanonicalQPilotCorridor (4.0s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8796/8799] Built IUTThreeClosures.CanonicalCorridorAudit (3.8s)
⚠ [8797/8799] Built IUTThreeClosures.SourceDerivedIUTIVBridge (4.6s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Some required targets logged failures:
- IUTThreeClosures.PublicLogVolumeInconsistency
error: build failed
```
