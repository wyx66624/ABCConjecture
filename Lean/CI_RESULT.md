# Lean CI result

- Tested commit: `7338104fb825307c15df209f274b8fe900fcc3e4`
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
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 15 KB/s], Decompressed: 0Downloaded: 103 file(s) [attempted 103/8639 = 1%, 92 KB/s], Decompressed: 100Downloaded: 225 file(s) [attempted 225/8639 = 2%, 386 KB/s], Decompressed: 222Downloaded: 362 file(s) [attempted 362/8639 = 4%, 2382 KB/s], Decompressed: 358Downloaded: 493 file(s) [attempted 493/8639 = 5%, 1009 KB/s], Decompressed: 491Downloaded: 626 file(s) [attempted 626/8639 = 7%, 699 KB/s], Decompressed: 619Downloaded: 776 file(s) [attempted 776/8639 = 8%, 3484 KB/s], Decompressed: 768Downloaded: 920 file(s) [attempted 920/8639 = 10%, 716 KB/s], Decompressed: 918Downloaded: 1068 file(s) [attempted 1068/8639 = 12%, 3696 KB/s], Decompressed: 1062Downloaded: 1219 file(s) [attempted 1219/8639 = 14%, 3467 KB/s], Decompressed: 1214Downloaded: 1357 file(s) [attempted 1357/8639 = 15%, 2072 KB/s], Decompressed: 1347Downloaded: 1498 file(s) [attempted 1498/8639 = 17%, 471 KB/s], Decompressed: 1494Downloaded: 1641 file(s) [attempted 1641/8639 = 18%, 816 KB/s], Decompressed: 1633Downloaded: 1786 file(s) [attempted 1786/8639 = 20%, 1757 KB/s], Decompressed: 1780Downloaded: 1914 file(s) [attempted 1914/8639 = 22%, 83 KB/s], Decompressed: 1911Downloaded: 2053 file(s) [attempted 2053/8639 = 23%, 711 KB/s], Decompressed: 2048Downloaded: 2199 file(s) [attempted 2199/8639 = 25%, 781 KB/s], Decompressed: 2195Downloaded: 2348 file(s) [attempted 2348/8639 = 27%, 511 KB/s], Decompressed: 2344Downloaded: 2481 file(s) [attempted 2481/8639 = 28%, 688 KB/s], Decompressed: 2473Downloaded: 2626 file(s) [attempted 2626/8639 = 30%, 215 KB/s], Decompressed: 2617Downloaded: 2773 file(s) [attempted 2773/8639 = 32%, 944 KB/s], Decompressed: 2766Downloaded: 2913 file(s) [attempted 2913/8639 = 33%, 844 KB/s], Decompressed: 2908Downloaded: 3055 file(s) [attempted 3055/8639 = 35%, 4676 KB/s], Decompressed: 3048Downloaded: 3191 file(s) [attempted 3191/8639 = 36%, 1420 KB/s], Decompressed: 3184Downloaded: 3337 file(s) [attempted 3337/8639 = 38%, 327 KB/s], Decompressed: 3333Downloaded: 3482 file(s) [attempted 3482/8639 = 40%, 427 KB/s], Decompressed: 3475Downloaded: 3627 file(s) [attempted 3627/8639 = 41%, 3183 KB/s], Decompressed: 3624Downloaded: 3777 file(s) [attempted 3777/8639 = 43%, 723 KB/s], Decompressed: 3771Downloaded: 3922 file(s) [attempted 3922/8639 = 45%, 423 KB/s], Decompressed: 3915Downloaded: 4069 file(s) [attempted 4069/8639 = 47%, 695 KB/s], Decompressed: 4058Downloaded: 4202 file(s) [attempted 4202/8639 = 48%, 1600 KB/s], Decompressed: 4190Downloaded: 4345 file(s) [attempted 4345/8639 = 50%, 2416 KB/s], Decompressed: 4340Downloaded: 4494 file(s) [attempted 4494/8639 = 52%, 1167 KB/s], Decompressed: 4477Downloaded: 4639 file(s) [attempted 4639/8639 = 53%, 186 KB/s], Decompressed: 4629Downloaded: 4781 file(s) [attempted 4781/8639 = 55%, 673 KB/s], Decompressed: 4771Downloaded: 4927 file(s) [attempted 4927/8639 = 57%, 633 KB/s], Decompressed: 4925Downloaded: 5067 file(s) [attempted 5067/8639 = 58%, 1278 KB/s], Decompressed: 5062Downloaded: 5212 file(s) [attempted 5212/8639 = 60%, 2938 KB/s], Decompressed: 5204Downloaded: 5363 file(s) [attempted 5363/8639 = 62%, 340 KB/s], Decompressed: 5356Downloaded: 5512 file(s) [attempted 5512/8639 = 63%, 887 KB/s], Decompressed: 5507Downloaded: 5654 file(s) [attempted 5654/8639 = 65%, 3585 KB/s], Decompressed: 5652Downloaded: 5799 file(s) [attempted 5799/8639 = 67%, 205 KB/s], Decompressed: 5794Downloaded: 5946 file(s) [attempted 5946/8639 = 68%, 424 KB/s], Decompressed: 5943Downloaded: 6078 file(s) [attempted 6078/8639 = 70%, 2715 KB/s], Decompressed: 6074Downloaded: 6228 file(s) [attempted 6228/8639 = 72%, 2952 KB/s], Decompressed: 6223Downloaded: 6370 file(s) [attempted 6370/8639 = 73%, 1033 KB/s], Decompressed: 6363Downloaded: 6499 file(s) [attempted 6499/8639 = 75%, 898 KB/s], Decompressed: 6496Downloaded: 6646 file(s) [attempted 6646/8639 = 76%, 388 KB/s], Decompressed: 6640Downloaded: 6796 file(s) [attempted 6796/8639 = 78%, 495 KB/s], Decompressed: 6794Downloaded: 6940 file(s) [attempted 6940/8639 = 80%, 2380 KB/s], Decompressed: 6936Downloaded: 7086 file(s) [attempted 7086/8639 = 82%, 167 KB/s], Decompressed: 7076Downloaded: 7232 file(s) [attempted 7232/8639 = 83%, 161 KB/s], Decompressed: 7223Downloaded: 7375 file(s) [attempted 7375/8639 = 85%, 1313 KB/s], Decompressed: 7372Downloaded: 7522 file(s) [attempted 7522/8639 = 87%, 548 KB/s], Decompressed: 7512Downloaded: 7662 file(s) [attempted 7662/8639 = 88%, 1856 KB/s], Decompressed: 7657Downloaded: 7806 file(s) [attempted 7806/8639 = 90%, 757 KB/s], Decompressed: 7803Downloaded: 7943 file(s) [attempted 7943/8639 = 91%, 985 KB/s], Decompressed: 7939Downloaded: 8089 file(s) [attempted 8089/8639 = 93%, 1271 KB/s], Decompressed: 8085Downloaded: 8232 file(s) [attempted 8232/8639 = 95%, 703 KB/s], Decompressed: 8230Downloaded: 8379 file(s) [attempted 8379/8639 = 96%, 308 KB/s], Decompressed: 8377Downloaded: 8520 file(s) [attempted 8520/8639 = 98%, 330 KB/s], Decompressed: 8514Downloaded: 8638 file(s) [attempted 8638/8639 = 99%, 925 KB/s], Decompressed: 8633Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 925 KB/s], Decompressed: 8633
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
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.2s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.4s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.6s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (7.8s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (7.6s)
✔ [8662/8673] Built Iut.Cor312.ThetaData.Places (7.4s)
✔ [8663/8675] Built TateCurvesTheta.QParameter.BaseChange (3.3s)
✔ [8664/8675] Built TateCurvesTheta.Analysis.Strassmann (4.6s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.6s)
✔ [8666/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (2.8s)
✔ [8667/8679] Built TateCurvesTheta.TateCurve.Discriminant (5.1s)
✔ [8668/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.9s)
✔ [8669/8679] Built TateCurvesTheta.QParameter.NormalizedOrder (4.1s)
✔ [8670/8680] Built TateCurvesTheta.TateCurve.JInvariant (3.1s)
✔ [8671/8684] Built TateCurvesTheta.TateCurve.SplitReduction (4.7s)
✔ [8672/8685] Built TateCurvesTheta.TateCurve.Parametrization (4.6s)
✔ [8673/8689] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8674/8691] Built TateCurvesTheta.Theta.Basic (3.7s)
✔ [8675/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (4.4s)
✔ [8676/8693] Built TateCurvesTheta.TateCurve.CoordinateExpansion (5.2s)
✔ [8677/8693] Built TateCurvesTheta.QParameter.JParametrization (8.6s)
✔ [8678/8696] Built TateCurvesTheta.Theta.Periodicity (3.8s)
✔ [8679/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (4.6s)
✔ [8680/8696] Built TateCurvesTheta.QParameter.Characterization (3.1s)
✔ [8681/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (7.8s)
✔ [8682/8704] Built TateCurvesTheta.Theta.Product (5.5s)
✔ [8683/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (8.9s)
✔ [8684/8704] Built TateCurvesTheta.Theta.QBinomial (6.6s)
✔ [8685/8705] Built TateCurvesTheta.Theta.Divisor (7.1s)
✔ [8686/8708] Built TateCurvesTheta.Theta.Uniqueness (6.2s)
✔ [8687/8708] Built TateCurvesTheta.TateCurve.EisensteinSeries (12s)
✔ [8688/8708] Built TateCurvesTheta.TateCurve.CoordinateInversion (3.6s)
✔ [8689/8708] Built TateCurvesTheta.Theta.FactorSeries (4.9s)
✔ [8690/8708] Built TateCurvesTheta.Theta.LaurentSphere (3.9s)
✔ [8691/8712] Built TateCurvesTheta.TateCurve.TatePointMem (3.8s)
✔ [8692/8713] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.7s)
✔ [8693/8714] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.3s)
✔ [8694/8715] Built TateCurvesTheta.TateCurve.IntegralModel (4.9s)
✔ [8695/8717] Built TateCurvesTheta.TateCurve.Quotient (6.4s)
✔ [8696/8717] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.9s)
✔ [8697/8719] Built TateCurvesTheta.TateCurve.SphereBounds (6.1s)
✔ [8698/8721] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.0s)
✔ [8699/8721] Built TateCurvesTheta.Theta.FactorReciprocal (4.0s)
✔ [8700/8721] Built TateCurvesTheta.Theta.LaurentUnique (3.4s)
✔ [8701/8721] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.8s)
✔ [8702/8729] Built TateCurvesTheta.TateCurve.PointMap (8.2s)
✔ [8703/8729] Built TateCurvesTheta.Theta.Normalization (3.7s)
✔ [8704/8729] Built TateCurvesTheta.Theta.SeriesZero (3.8s)
✔ [8705/8729] Built TateCurvesTheta.Theta.RatioAnnulus (3.9s)
✔ [8706/8729] Built TateCurvesTheta.Theta.TripleProduct (4.6s)
✔ [8707/8731] Built TateCurvesTheta.Theta.StrictDominant (9.1s)
✔ [8708/8733] Built TateCurvesTheta.Theta.Durfee (5.5s)
✔ [8709/8733] Built TateCurvesTheta.Uniformization (10s)
✔ [8710/8735] Built TateCurvesTheta.Theta.Inversion (3.5s)
✔ [8711/8735] Built Iut.Cor312.Procession (6.6s)
✔ [8712/8735] Built Iut.Cor312.RationalPlace (5.0s)
✔ [8713/8765] Built Iut.Cor312.PacketPresentation (11s)
✔ [8714/8765] Built TateCurvesTheta.Theta.WeightSpace (16s)
✔ [8715/8765] Built Iut.Cor312.Container (9.7s)
✔ [8716/8765] Built Iut.Cor312.HolomorphicHull (10s)
✔ [8717/8765] Built IUTThreeClosures.ABCStatement (3.2s)
⚠ [8718/8765] Built IUTThreeClosures.HonestFinitePositiveLogVolume (9.3s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8719/8784] Built IUTThreeClosures.FullPolyCore (7.8s)
⚠ [8721/8784] Built IUTThreeClosures.Cor312CoefficientAlgebra (7.3s)
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
✔ [8722/8784] Built TateCurvesTheta.Theta.PuncturedProduct (44s)
✔ [8723/8784] Built Iut.Cor312.LogVolume (7.0s)
✔ [8724/8784] Built Iut.Cor312.ContainerHull (6.3s)
⚠ [8725/8784] Built IUTThreeClosures.HonestPilotWitness (6.1s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8726/8784] Built IUTThreeClosures.WeakCompatibilityCountermodel (6.4s)
✔ [8727/8784] Built Heights.WeilHeight (8.3s)
⚠ [8728/8784] Built IUTThreeClosures.ExplicitSemistableCurve (6.4s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8784] Built IUTThreeClosures.SolvableRestrictionImage (7.4s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8730/8784] Built IUTThreeClosures.QPilotNormalizationAudit (6.7s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8731/8784] Built IUTThreeClosures.RootQPilotDivisor (6.4s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8784] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.3s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8733/8784] Built IUTThreeClosures.RamificationCorrectedQPilot (6.9s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8734/8784] Built TateCurvesTheta.TateCurve.DefectVanishing (87s)
⚠ [8735/8784] Built IUTThreeClosures.ProductWeightMarginalization (7.5s)
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
⚠ [8737/8784] Built IUTThreeClosures.GeneratedUnionCompactness (6.1s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8738/8784] Built IUTThreeClosures.AdmissiblePrimeSelection (6.0s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8739/8784] Built IUTThreeClosures.FiniteExceptionalSet (6.0s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8740/8784] Built IUTThreeClosures.PrimePowerQPilotRegion (6.4s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8742/8799] Built IUTThreeClosures.HonestGeneratedSource (6.2s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8743/8799] Built IUTThreeClosures.ZModSL2Perfect (5.9s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8744/8799] Built IUTThreeClosures.QPilotNormalizationFork (6.5s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8745/8799] Built Genl.Mathlib.Order.BoundedDiscrepancy (3.6s)
✔ [8746/8799] Built TateCurvesTheta.TateCurve.TatePointOnCurve (6.6s)
⚠ [8747/8799] Built IUTThreeClosures.TateParameterUnitBallRegion (3.1s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8748/8799] Built IUTThreeClosures.DistinguishedLabelQPilot (6.8s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8749/8799] Built IUTThreeClosures.FiniteExponentHull (5.0s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8799] Built IUTThreeClosures.StandardZeroLabel (5.7s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8751/8799] Built IUTThreeClosures.BarycentricPacketReading (6.2s)
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
⚠ [8752/8799] Built IUTThreeClosures.DiagonalPacketNoGo (6.1s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8753/8799] Built Genl.GeneralPosition.HeightTheory (1.8s)
⚠ [8754/8799] Built IUTThreeClosures.PublicNormalizationObstruction (6.6s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8755/8799] Built Iut4Sec1.Global.ArithmeticDivisor (6.1s)
⚠ [8756/8799] Built IUTThreeClosures.IUTIVAbsorption (8.8s)
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
✔ [8757/8799] Built TateCurvesTheta.TateCurve.AdditionLaw (10s)
✔ [8758/8799] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (9.1s)
⚠ [8759/8799] Built IUTThreeClosures.ZeroLabelBarycentric (9.9s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8760/8799] Built TateCurvesTheta.TateCurve.LargePointParametrization (13s)
⚠ [8761/8799] Built IUTThreeClosures.StatementIIOutsideFinite (7.5s)
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
✔ [8762/8799] Built TateCurvesTheta.TateCurve.AbelStep (6.9s)
✔ [8763/8799] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8764/8799] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (21s)
✔ [8765/8799] Built TateCurvesTheta.TateCurve.SurjectivitySphere (25s)
✔ [8766/8799] Built TateCurvesTheta.TateCurve.TateUniformization (4.3s)
✔ [8767/8799] Built TateCurvesTheta (3.7s)
✔ [8768/8799] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.8s)
✔ [8769/8799] Built Iut.Cor312.ThetaData.Orbicurve (4.7s)
✔ [8770/8799] Built Iut.Cor312.ThetaData.LocalConditions (7.6s)
✔ [8771/8799] Built Iut.Cor312.ThetaData.Basic (4.6s)
✔ [8772/8799] Built Iut.Cor312.LeftHandSide (4.1s)
✔ [8773/8799] Built Iut.Cor312.RightHandSide (4.4s)
⚠ [8774/8799] Built IUTThreeClosures.NativeQPilotCalibration (4.5s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8775/8799] Built IUTThreeClosures.CorrectedQPilotDivisor (5.4s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8776/8799] Built Iut.Cor312.Statement (5.3s)
✔ [8777/8799] Built IUTThreeClosures.ActualPilotWitness (4.1s)
✔ [8778/8799] Built IUTThreeClosures.GeneratedSource (4.6s)
✔ [8779/8799] Built IUTThreeClosures.QuantifierCorrectClosure (4.1s)
✔ [8780/8799] Built IUTThreeClosures.ABCClosure (4.3s)
⚠ [8781/8799] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.6s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8782/8799] Built IUTThreeClosures.ThreeClosureTheorems (4.0s)
✔ [8783/8799] Built IUTThreeClosures.InhabitationBoundary (4.2s)
✔ [8784/8799] Built IUTThreeClosures.CircularityAudit (4.3s)
✔ [8785/8799] Built IUTThreeClosures.NonCircularDownstream (5.2s)
✔ [8786/8799] Built IUTThreeClosures.FourOpenConstructions (4.4s)
⚠ [8787/8799] Built IUTThreeClosures.ABCPointLegendreCurve (4.9s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8788/8799] Built IUTThreeClosures.PublicProgramUninhabited (4.7s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8789/8799] Built IUTThreeClosures.BridgeInhabitationAudit (6.2s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8790/8799] Built IUTThreeClosures.LegendreArithmetic (5.9s)
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
✔ [8792/8799] Built IUTThreeClosures.BridgeInhabitationExact (5.6s)
⚠ [8793/8799] Built IUTThreeClosures.TripodWeilHeight (5.8s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8794/8799] Built IUTThreeClosures.CanonicalQPilotCorridor (4.4s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8795/8799] Built IUTThreeClosures.LegendreHeightCorridor (4.6s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8796/8799] Built IUTThreeClosures.CanonicalCorridorAudit (4.3s)
⚠ [8797/8799] Built IUTThreeClosures.SourceDerivedIUTIVBridge (5.2s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8798/8799] Built IUTThreeClosures (3.9s)
warning: IUTThreeClosures.lean:61:46: '' starts on column 46, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Build completed successfully (8799 jobs).
```
