# Lean CI result

- Tested commit: `25c2a275d837fbfd5e56142aa23a1b7ecf72d1e3`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
474:✖ [8790/8797] Building IUTThreeClosures.ABCFreyCurve (4.9s)
481:error: IUTThreeClosures/ABCFreyCurve.lean:41:2: No goals to be solved
482:error: IUTThreeClosures/ABCFreyCurve.lean:75:55: unsolved goals
485:error: IUTThreeClosures/ABCFreyCurve.lean:80:60: unsolved goals
488:error: IUTThreeClosures/ABCFreyCurve.lean:102:2: 'change' tactic failed, pattern
495:error: Lean exited with code 1
515:Some required targets logged failures:
517:error: build failed
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
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 14 KB/s], Decompressed: 0Downloaded: 78 file(s) [attempted 78/8639 = 0%, 102 KB/s], Decompressed: 76Downloaded: 178 file(s) [attempted 178/8639 = 2%, 492 KB/s], Decompressed: 173Downloaded: 271 file(s) [attempted 271/8639 = 3%, 1614 KB/s], Decompressed: 267Downloaded: 381 file(s) [attempted 381/8639 = 4%, 216 KB/s], Decompressed: 377Downloaded: 486 file(s) [attempted 486/8639 = 5%, 1340 KB/s], Decompressed: 484Downloaded: 601 file(s) [attempted 601/8639 = 6%, 1047 KB/s], Decompressed: 596Downloaded: 719 file(s) [attempted 719/8639 = 8%, 503 KB/s], Decompressed: 715Downloaded: 827 file(s) [attempted 827/8639 = 9%, 342 KB/s], Decompressed: 825Downloaded: 946 file(s) [attempted 946/8639 = 10%, 1488 KB/s], Decompressed: 939Downloaded: 1072 file(s) [attempted 1072/8639 = 12%, 813 KB/s], Decompressed: 1070Downloaded: 1191 file(s) [attempted 1191/8639 = 13%, 1566 KB/s], Decompressed: 1188Downloaded: 1311 file(s) [attempted 1311/8639 = 15%, 2736 KB/s], Decompressed: 1306Downloaded: 1435 file(s) [attempted 1435/8639 = 16%, 358 KB/s], Decompressed: 1429Downloaded: 1548 file(s) [attempted 1548/8639 = 17%, 221 KB/s], Decompressed: 1546Downloaded: 1674 file(s) [attempted 1674/8639 = 19%, 1028 KB/s], Decompressed: 1669Downloaded: 1789 file(s) [attempted 1789/8639 = 20%, 1426 KB/s], Decompressed: 1786Downloaded: 1912 file(s) [attempted 1912/8639 = 22%, 1682 KB/s], Decompressed: 1910Downloaded: 2026 file(s) [attempted 2026/8639 = 23%, 1806 KB/s], Decompressed: 2022Downloaded: 2137 file(s) [attempted 2137/8639 = 24%, 1040 KB/s], Decompressed: 2134Downloaded: 2262 file(s) [attempted 2262/8639 = 26%, 128 KB/s], Decompressed: 2257Downloaded: 2382 file(s) [attempted 2382/8639 = 27%, 908 KB/s], Decompressed: 2376Downloaded: 2497 file(s) [attempted 2497/8639 = 28%, 834 KB/s], Decompressed: 2493Downloaded: 2618 file(s) [attempted 2618/8639 = 30%, 330 KB/s], Decompressed: 2609Downloaded: 2741 file(s) [attempted 2741/8639 = 31%, 1233 KB/s], Decompressed: 2735Downloaded: 2859 file(s) [attempted 2859/8639 = 33%, 217 KB/s], Decompressed: 2857Downloaded: 2985 file(s) [attempted 2985/8639 = 34%, 2243 KB/s], Decompressed: 2980Downloaded: 3102 file(s) [attempted 3102/8639 = 35%, 490 KB/s], Decompressed: 3097Downloaded: 3223 file(s) [attempted 3223/8639 = 37%, 1001 KB/s], Decompressed: 3218Downloaded: 3339 file(s) [attempted 3339/8639 = 38%, 962 KB/s], Decompressed: 3337Downloaded: 3463 file(s) [attempted 3463/8639 = 40%, 636 KB/s], Decompressed: 3458Downloaded: 3580 file(s) [attempted 3580/8639 = 41%, 1372 KB/s], Decompressed: 3575Downloaded: 3703 file(s) [attempted 3703/8639 = 42%, 1822 KB/s], Decompressed: 3696Downloaded: 3822 file(s) [attempted 3822/8639 = 44%, 630 KB/s], Decompressed: 3820Downloaded: 3949 file(s) [attempted 3949/8639 = 45%, 423 KB/s], Decompressed: 3946Downloaded: 4060 file(s) [attempted 4060/8639 = 46%, 237 KB/s], Decompressed: 4058Downloaded: 4172 file(s) [attempted 4172/8639 = 48%, 138 KB/s], Decompressed: 4167Downloaded: 4280 file(s) [attempted 4280/8639 = 49%, 1292 KB/s], Decompressed: 4272Downloaded: 4403 file(s) [attempted 4403/8639 = 50%, 2672 KB/s], Decompressed: 4398Downloaded: 4520 file(s) [attempted 4520/8639 = 52%, 273 KB/s], Decompressed: 4515Downloaded: 4637 file(s) [attempted 4637/8639 = 53%, 440 KB/s], Decompressed: 4634Downloaded: 4763 file(s) [attempted 4763/8639 = 55%, 1756 KB/s], Decompressed: 4760Downloaded: 4875 file(s) [attempted 4875/8639 = 56%, 219 KB/s], Decompressed: 4869Downloaded: 4986 file(s) [attempted 4986/8639 = 57%, 3324 KB/s], Decompressed: 4981Downloaded: 5106 file(s) [attempted 5106/8639 = 59%, 1426 KB/s], Decompressed: 5096Downloaded: 5216 file(s) [attempted 5216/8639 = 60%, 2331 KB/s], Decompressed: 5212Downloaded: 5337 file(s) [attempted 5337/8639 = 61%, 5375 KB/s], Decompressed: 5331Downloaded: 5457 file(s) [attempted 5457/8639 = 63%, 1305 KB/s], Decompressed: 5453Downloaded: 5581 file(s) [attempted 5581/8639 = 64%, 3013 KB/s], Decompressed: 5576Downloaded: 5704 file(s) [attempted 5704/8639 = 66%, 1575 KB/s], Decompressed: 5697Downloaded: 5816 file(s) [attempted 5816/8639 = 67%, 468 KB/s], Decompressed: 5814Downloaded: 5945 file(s) [attempted 5945/8639 = 68%, 551 KB/s], Decompressed: 5939Downloaded: 6066 file(s) [attempted 6066/8639 = 70%, 112 KB/s], Decompressed: 6061Downloaded: 6183 file(s) [attempted 6183/8639 = 71%, 1107 KB/s], Decompressed: 6182Downloaded: 6304 file(s) [attempted 6304/8639 = 72%, 2099 KB/s], Decompressed: 6299Downloaded: 6422 file(s) [attempted 6422/8639 = 74%, 1091 KB/s], Decompressed: 6402Downloaded: 6526 file(s) [attempted 6526/8639 = 75%, 2213 KB/s], Decompressed: 6521Downloaded: 6647 file(s) [attempted 6647/8639 = 76%, 1010 KB/s], Decompressed: 6644Downloaded: 6761 file(s) [attempted 6761/8639 = 78%, 1905 KB/s], Decompressed: 6758Downloaded: 6880 file(s) [attempted 6880/8639 = 79%, 1279 KB/s], Decompressed: 6878Downloaded: 7000 file(s) [attempted 7000/8639 = 81%, 198 KB/s], Decompressed: 6990Downloaded: 7120 file(s) [attempted 7120/8639 = 82%, 387 KB/s], Decompressed: 7118Downloaded: 7239 file(s) [attempted 7239/8639 = 83%, 832 KB/s], Decompressed: 7237Downloaded: 7363 file(s) [attempted 7363/8639 = 85%, 1793 KB/s], Decompressed: 7359Downloaded: 7480 file(s) [attempted 7480/8639 = 86%, 1125 KB/s], Decompressed: 7477Downloaded: 7594 file(s) [attempted 7594/8639 = 87%, 375 KB/s], Decompressed: 7582Downloaded: 7707 file(s) [attempted 7707/8639 = 89%, 2417 KB/s], Decompressed: 7703Downloaded: 7834 file(s) [attempted 7834/8639 = 90%, 864 KB/s], Decompressed: 7829Downloaded: 7946 file(s) [attempted 7946/8639 = 91%, 377 KB/s], Decompressed: 7941Downloaded: 8066 file(s) [attempted 8066/8639 = 93%, 375 KB/s], Decompressed: 8062Downloaded: 8189 file(s) [attempted 8189/8639 = 94%, 509 KB/s], Decompressed: 8174Downloaded: 8299 file(s) [attempted 8299/8639 = 96%, 69 KB/s], Decompressed: 8286Downloaded: 8419 file(s) [attempted 8419/8639 = 97%, 537 KB/s], Decompressed: 8417Downloaded: 8523 file(s) [attempted 8523/8639 = 98%, 3493 KB/s], Decompressed: 8520Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 861 KB/s], Decompressed: 8634Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 861 KB/s], Decompressed: 8634
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (407ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (2.9s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.5s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (4.3s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (8.5s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (8.3s)
✔ [8662/8673] Built Iut.Cor312.ThetaData.Places (6.5s)
✔ [8663/8675] Built TateCurvesTheta.QParameter.BaseChange (3.3s)
✔ [8664/8675] Built TateCurvesTheta.Analysis.Strassmann (5.0s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.8s)
✔ [8666/8678] Built TateCurvesTheta.QParameter.PrimeToOrder (2.6s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.7s)
✔ [8668/8680] Built TateCurvesTheta.TateCurve.Discriminant (5.6s)
✔ [8669/8680] Built TateCurvesTheta.QParameter.NormalizedOrder (4.8s)
✔ [8670/8680] Built TateCurvesTheta.TateCurve.JInvariant (3.4s)
✔ [8671/8684] Built TateCurvesTheta.TateCurve.Parametrization (4.4s)
✔ [8672/8684] Built TateCurvesTheta.TateCurve.SplitReduction (4.6s)
✔ [8673/8684] Built Iut.Cor312.ThetaData.GlobalField (14s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.2s)
✔ [8675/8693] Built TateCurvesTheta.Theta.Basic (4.5s)
✔ [8676/8693] Built TateCurvesTheta.TateCurve.CoordinateExpansion (5.1s)
✔ [8677/8696] Built TateCurvesTheta.QParameter.JParametrization (9.1s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (5.7s)
✔ [8679/8696] Built TateCurvesTheta.Theta.Periodicity (4.4s)
✔ [8680/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (7.5s)
✔ [8681/8704] Built TateCurvesTheta.QParameter.Characterization (4.2s)
✔ [8682/8704] Built TateCurvesTheta.Theta.Product (6.6s)
✔ [8683/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (11s)
✔ [8684/8705] Built TateCurvesTheta.Theta.QBinomial (8.6s)
✔ [8685/8705] Built TateCurvesTheta.TateCurve.EisensteinSeries (13s)
✔ [8686/8708] Built TateCurvesTheta.Theta.Divisor (4.3s)
✔ [8687/8711] Built TateCurvesTheta.Theta.Uniqueness (5.0s)
✔ [8688/8711] Built TateCurvesTheta.Theta.FactorSeries (4.8s)
✔ [8689/8711] Built TateCurvesTheta.TateCurve.CoordinateInversion (4.1s)
✔ [8690/8712] Built TateCurvesTheta.Theta.LaurentSphere (3.8s)
✔ [8691/8713] Built TateCurvesTheta.TateCurve.TatePointMem (3.1s)
✔ [8692/8713] Built TateCurvesTheta.TateCurve.Quotient (7.0s)
✔ [8693/8715] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.1s)
✔ [8694/8715] Built TateCurvesTheta.Theta.LaurentSphereReduce (4.3s)
✔ [8695/8716] Built TateCurvesTheta.TateCurve.IntegralModel (5.4s)
✔ [8696/8717] Built TateCurvesTheta.TateCurve.SphereBounds (6.9s)
✔ [8697/8719] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.8s)
✔ [8698/8720] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.9s)
✔ [8699/8721] Built TateCurvesTheta.TateCurve.PointMap (8.8s)
✔ [8700/8721] Built TateCurvesTheta.Theta.FactorReciprocal (4.1s)
✔ [8701/8721] Built TateCurvesTheta.Theta.LaurentUnique (3.6s)
✔ [8702/8729] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.8s)
✔ [8703/8729] Built TateCurvesTheta.Theta.Normalization (3.5s)
✔ [8704/8729] Built TateCurvesTheta.Theta.SeriesZero (3.3s)
✔ [8705/8729] Built TateCurvesTheta.Theta.RatioAnnulus (4.1s)
✔ [8706/8729] Built TateCurvesTheta.Theta.TripleProduct (5.0s)
✔ [8707/8731] Built TateCurvesTheta.Theta.StrictDominant (10s)
✔ [8708/8733] Built TateCurvesTheta.Theta.Durfee (6.1s)
✔ [8709/8733] Built TateCurvesTheta.Uniformization (10s)
✔ [8710/8735] Built TateCurvesTheta.Theta.Inversion (3.5s)
✔ [8711/8735] Built Iut.Cor312.Procession (6.9s)
✔ [8712/8735] Built Iut.Cor312.RationalPlace (6.0s)
✔ [8713/8764] Built Iut.Cor312.PacketPresentation (10s)
✔ [8714/8764] Built TateCurvesTheta.Theta.WeightSpace (16s)
✔ [8715/8764] Built Iut.Cor312.Container (10s)
✔ [8716/8764] Built Iut.Cor312.HolomorphicHull (11s)
⚠ [8717/8764] Built IUTThreeClosures.HonestFinitePositiveLogVolume (9.3s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8718/8764] Built IUTThreeClosures.ABCStatement (3.7s)
✔ [8719/8782] Built IUTThreeClosures.FullPolyCore (7.4s)
⚠ [8721/8782] Built IUTThreeClosures.Cor312CoefficientAlgebra (8.6s)
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
✔ [8722/8782] Built Iut.Cor312.LogVolume (8.1s)
✔ [8723/8782] Built Iut.Cor312.ContainerHull (7.0s)
✔ [8724/8782] Built TateCurvesTheta.Theta.PuncturedProduct (48s)
⚠ [8725/8782] Built IUTThreeClosures.HonestPilotWitness (6.2s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8726/8782] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.9s)
✔ [8727/8782] Built Heights.WeilHeight (8.4s)
⚠ [8728/8782] Built IUTThreeClosures.ExplicitSemistableCurve (7.0s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8782] Built IUTThreeClosures.SolvableRestrictionImage (7.4s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8730/8782] Built IUTThreeClosures.QPilotNormalizationAudit (6.7s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8731/8782] Built IUTThreeClosures.RootQPilotDivisor (6.6s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8782] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.1s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8733/8782] Built IUTThreeClosures.RamificationCorrectedQPilot (7.0s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8734/8782] Built IUTThreeClosures.GeneratedUnionCompactness (5.6s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8735/8782] Built IUTThreeClosures.ProductWeightMarginalization (7.4s)
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
⚠ [8737/8782] Built IUTThreeClosures.AdmissiblePrimeSelection (6.2s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8738/8782] Built IUTThreeClosures.FiniteExceptionalSet (5.0s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8739/8793] Built IUTThreeClosures.PrimePowerQPilotRegion (6.3s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8741/8797] Built TateCurvesTheta.TateCurve.DefectVanishing (100s)
⚠ [8742/8797] Built IUTThreeClosures.ZModSL2Perfect (6.2s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8743/8797] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.5s)
⚠ [8744/8797] Built IUTThreeClosures.QPilotNormalizationFork (6.7s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8745/8797] Built IUTThreeClosures.TateParameterUnitBallRegion (2.8s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8746/8797] Built IUTThreeClosures.DistinguishedLabelQPilot (6.1s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8747/8797] Built IUTThreeClosures.FiniteExponentHull (5.7s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8748/8797] Built IUTThreeClosures.StandardZeroLabel (5.8s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8797] Built IUTThreeClosures.DiagonalPacketNoGo (5.7s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8797] Built IUTThreeClosures.BarycentricPacketReading (6.1s)
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
⚠ [8751/8797] Built IUTThreeClosures.PublicNormalizationObstruction (7.6s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8752/8797] Built TateCurvesTheta.TateCurve.TatePointOnCurve (7.1s)
✔ [8753/8797] Built Iut4Sec1.Global.ArithmeticDivisor (7.1s)
⚠ [8754/8797] Built IUTThreeClosures.IUTIVAbsorption (10s)
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
✔ [8755/8797] Built Genl.GeneralPosition.HeightTheory (1.0s)
⚠ [8756/8797] Built IUTThreeClosures.ZeroLabelBarycentric (8.5s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8757/8797] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (9.6s)
✔ [8758/8797] Built TateCurvesTheta.TateCurve.AdditionLaw (11s)
⚠ [8759/8797] Built IUTThreeClosures.StatementIIOutsideFinite (8.0s)
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
✔ [8760/8797] Built TateCurvesTheta.TateCurve.LargePointParametrization (16s)
✔ [8761/8797] Built TateCurvesTheta.TateCurve.AbelStep (7.1s)
✔ [8762/8797] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8763/8797] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (23s)
✔ [8764/8797] Built TateCurvesTheta.TateCurve.SurjectivitySphere (24s)
✔ [8765/8797] Built TateCurvesTheta.TateCurve.TateUniformization (4.1s)
✔ [8766/8797] Built TateCurvesTheta (3.4s)
✔ [8767/8797] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.6s)
✔ [8768/8797] Built Iut.Cor312.ThetaData.Orbicurve (4.4s)
✔ [8769/8797] Built Iut.Cor312.ThetaData.LocalConditions (7.5s)
✔ [8770/8797] Built Iut.Cor312.ThetaData.Basic (4.3s)
✔ [8771/8797] Built Iut.Cor312.LeftHandSide (3.9s)
✔ [8772/8797] Built Iut.Cor312.RightHandSide (4.1s)
⚠ [8773/8797] Built IUTThreeClosures.CorrectedQPilotDivisor (4.4s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8774/8797] Built Iut.Cor312.Statement (5.1s)
⚠ [8775/8797] Built IUTThreeClosures.NativeQPilotCalibration (5.4s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8776/8797] Built IUTThreeClosures.ActualPilotWitness (3.8s)
✔ [8777/8797] Built IUTThreeClosures.GeneratedSource (4.3s)
✔ [8778/8797] Built IUTThreeClosures.QuantifierCorrectClosure (3.0s)
⚠ [8779/8797] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.2s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:72:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8780/8797] Built IUTThreeClosures.ABCClosure (3.7s)
✔ [8781/8797] Built IUTThreeClosures.ThreeClosureTheorems (3.7s)
✔ [8782/8797] Built IUTThreeClosures.InhabitationBoundary (3.9s)
✔ [8783/8797] Built IUTThreeClosures.CircularityAudit (3.0s)
✔ [8784/8797] Built IUTThreeClosures.NonCircularDownstream (4.9s)
✔ [8785/8797] Built IUTThreeClosures.FourOpenConstructions (4.0s)
⚠ [8786/8797] Built IUTThreeClosures.ABCPointLegendreCurve (4.6s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8787/8797] Built IUTThreeClosures.LegendreArithmetic (4.9s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8788/8797] Built IUTThreeClosures.PublicProgramUninhabited (5.7s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8789/8797] Built IUTThreeClosures.BridgeInhabitationAudit (6.6s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✖ [8790/8797] Building IUTThreeClosures.ABCFreyCurve (4.9s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/ABCFreyCurve.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ABCFreyCurve.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ABCFreyCurve.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ABCFreyCurve.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ABCFreyCurve.setup.json --json
warning: IUTThreeClosures/ABCFreyCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/ABCFreyCurve.lean:41:2: No goals to be solved
error: IUTThreeClosures/ABCFreyCurve.lean:75:55: unsolved goals
P : ABCPoint
⊢ ((abcFreyCurveZ P)⁄ℚ).c₄ = 16 * ↑P.legendreCore
error: IUTThreeClosures/ABCFreyCurve.lean:80:60: unsolved goals
P : ABCPoint
⊢ ((abcFreyCurveZ P)⁄ℚ).Δ = 16 * ↑P.a ^ 2 * ↑P.b ^ 2 * ↑P.c ^ 2
error: IUTThreeClosures/ABCFreyCurve.lean:102:2: 'change' tactic failed, pattern
  (↑(abcFreyCurve P).Δ')⁻¹ * (abcFreyCurve P).c₄ ^ 3 = ?m.83
is not definitionally equal to target
  ↑(abcFreyCurve P).Δ'⁻¹ * (abcFreyCurve P).c₄ ^ 3 = 256 * ↑P.legendreCore ^ 3 / (↑P.a ^ 2 * ↑P.b ^ 2 * ↑P.c ^ 2)
warning: IUTThreeClosures/ABCFreyCurve.lean:116:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
⚠ [8791/8797] Built IUTThreeClosures.TripodWeilHeight (4.9s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8792/8797] Built IUTThreeClosures.BridgeInhabitationExact (4.0s)
⚠ [8793/8797] Built IUTThreeClosures.CanonicalQPilotCorridor (3.8s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8794/8797] Built IUTThreeClosures.CanonicalCorridorAudit (3.9s)
⚠ [8795/8797] Built IUTThreeClosures.SourceDerivedIUTIVBridge (4.8s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Some required targets logged failures:
- IUTThreeClosures.ABCFreyCurve
error: build failed
```
