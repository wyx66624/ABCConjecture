# Lean CI result

- Tested commit: `31c70e2d14d0c5a4ccd7d4d6c758932e94251f5b`
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
info: genl: cloning https://github.com/LANA-Project/genl.git
info: genl: checking out revision '6e9a6543b46a2a02fd7fe7ec8ab203d878f32859'
info: iut: cloning https://github.com/lana-agents/iut.git
info: iut: checking out revision 'ddaddc274281adb5674d647e24fa478745ac6d40'
info: toolchain not updated; already up-to-date
info: mathlib: cloning https://github.com/leanprover-community/mathlib4
info: mathlib: checking out revision '81a5d257c8e410db227a6665ed08f64fea08e997'
info: tate-curves-theta: cloning https://github.com/lana-agents/tate-curves-theta
info: tate-curves-theta: checking out revision '90d7fac0e4ef2d6bf2a619326c30adb862d1b3de'
info: plausible: cloning https://github.com/leanprover-community/plausible
info: plausible: checking out revision 'e12c1910fe855cbfc38803cd4e55543906d5fa62'
info: LeanSearchClient: cloning https://github.com/leanprover-community/LeanSearchClient
info: LeanSearchClient: checking out revision 'c5d5b8fe6e5158def25cd28eb94e4141ad97c843'
info: importGraph: cloning https://github.com/leanprover-community/import-graph
info: importGraph: checking out revision '7e9612bf0b9ee66db3cb5b9988a35afc706f5a12'
info: proofwidgets: cloning https://github.com/leanprover-community/ProofWidgets4
info: proofwidgets: checking out revision '6e311e2a844da9b2cc3971187df2fe0066947b93'
info: aesop: cloning https://github.com/leanprover-community/aesop
info: aesop: checking out revision 'a7dbf0c63b694e47f425f3dcddbc0e178bb432d3'
info: Qq: cloning https://github.com/leanprover-community/quote4
info: Qq: checking out revision '38d591e778f100aec9762bb582f9c7f55f50e9dc'
info: batteries: cloning https://github.com/leanprover-community/batteries
info: batteries: checking out revision '023ce7d62a0531e22a5331e20b587817a80d49ff'
info: formal-schemes: cloning https://github.com/lana-agents/formal-schemes
info: formal-schemes: checking out revision '51aa935079537bf4dc580751a6e70727fb23ca93'
info: Cli: cloning https://github.com/leanprover/lean4-cli
info: Cli: checking out revision '88679d088c9720c27ebdf2ba4dafe17341747f94'
info: mathlib: running post-update hooks
✔ [2/6] Built Cache.Cli (383ms)
✔ [3/6] Built Cache.Lean (420ms)
✔ [8/27] Built Cache.Cli:c.o (218ms)
✔ [10/27] Built Cache.Lean:c.o (276ms)
✔ [11/27] Built Cache.Infra (492ms)
✔ [12/27] Built Cache.Infra:c.o (226ms)
✔ [13/27] Built Cache.IO (1.6s)
✔ [14/27] Built Cache.Hashing (858ms)
✔ [15/27] Built Cache.Hashing:c.o (636ms)
✔ [16/27] Built Cache.IO:c.o (1.7s)
✔ [17/27] Built Cache.Requests (2.2s)
✔ [18/27] Built Cache.Marker (589ms)
✔ [19/27] Built Cache.Marker:c.o (147ms)
✔ [20/27] Built Cache.Query (784ms)
✔ [21/27] Built Cache.Query:c.o (468ms)
✔ [22/27] Built Cache.Warning (886ms)
✔ [23/27] Built Cache.Warning:c.o (285ms)
✔ [24/27] Built Cache.Requests:c.o (3.2s)
✔ [25/27] Built Cache.Main (1.8s)
✔ [26/27] Built Cache.Main:c.o (947ms)
✔ [27/27] Built cache:exe (727ms)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 15 KB/s], Decompressed: 0Downloaded: 82 file(s) [attempted 82/8639 = 0%, 1233 KB/s], Decompressed: 9Downloaded: 192 file(s) [attempted 192/8639 = 2%, 180 KB/s], Decompressed: 43Downloaded: 290 file(s) [attempted 290/8639 = 3%, 1701 KB/s], Decompressed: 43Downloaded: 423 file(s) [attempted 423/8639 = 4%, 398 KB/s], Decompressed: 43Downloaded: 552 file(s) [attempted 552/8639 = 6%, 3710 KB/s], Decompressed: 141Downloaded: 680 file(s) [attempted 680/8639 = 7%, 3036 KB/s], Decompressed: 141Downloaded: 813 file(s) [attempted 813/8639 = 9%, 346 KB/s], Decompressed: 141Downloaded: 946 file(s) [attempted 946/8639 = 10%, 3153 KB/s], Decompressed: 141Downloaded: 1086 file(s) [attempted 1086/8639 = 12%, 2486 KB/s], Decompressed: 141Downloaded: 1226 file(s) [attempted 1226/8639 = 14%, 2322 KB/s], Decompressed: 141Downloaded: 1371 file(s) [attempted 1371/8639 = 15%, 883 KB/s], Decompressed: 141Downloaded: 1513 file(s) [attempted 1513/8639 = 17%, 1165 KB/s], Decompressed: 141Downloaded: 1632 file(s) [attempted 1632/8639 = 18%, 151 KB/s], Decompressed: 141Downloaded: 1749 file(s) [attempted 1749/8639 = 20%, 4329 KB/s], Decompressed: 141Downloaded: 1884 file(s) [attempted 1884/8639 = 21%, 909 KB/s], Decompressed: 141Downloaded: 2024 file(s) [attempted 2024/8639 = 23%, 3210 KB/s], Decompressed: 463Downloaded: 2162 file(s) [attempted 2162/8639 = 25%, 1142 KB/s], Decompressed: 463Downloaded: 2311 file(s) [attempted 2311/8639 = 26%, 478 KB/s], Decompressed: 463Downloaded: 2458 file(s) [attempted 2458/8639 = 28%, 1447 KB/s], Decompressed: 463Downloaded: 2591 file(s) [attempted 2591/8639 = 29%, 349 KB/s], Decompressed: 463Downloaded: 2714 file(s) [attempted 2714/8639 = 31%, 2640 KB/s], Decompressed: 463Downloaded: 2859 file(s) [attempted 2859/8639 = 33%, 2833 KB/s], Decompressed: 463Downloaded: 2999 file(s) [attempted 2999/8639 = 34%, 1638 KB/s], Decompressed: 463Downloaded: 3122 file(s) [attempted 3122/8639 = 36%, 477 KB/s], Decompressed: 463Downloaded: 3276 file(s) [attempted 3276/8639 = 37%, 721 KB/s], Decompressed: 463Downloaded: 3409 file(s) [attempted 3409/8639 = 39%, 307 KB/s], Decompressed: 463Downloaded: 3540 file(s) [attempted 3540/8639 = 40%, 3412 KB/s], Decompressed: 463Downloaded: 3668 file(s) [attempted 3668/8639 = 42%, 5186 KB/s], Decompressed: 463Downloaded: 3789 file(s) [attempted 3789/8639 = 43%, 611 KB/s], Decompressed: 463Downloaded: 3927 file(s) [attempted 3927/8639 = 45%, 1173 KB/s], Decompressed: 463Downloaded: 4069 file(s) [attempted 4069/8639 = 47%, 1341 KB/s], Decompressed: 463Downloaded: 4181 file(s) [attempted 4181/8639 = 48%, 745 KB/s], Decompressed: 463Downloaded: 4298 file(s) [attempted 4298/8639 = 49%, 258 KB/s], Decompressed: 463Downloaded: 4435 file(s) [attempted 4435/8639 = 51%, 1350 KB/s], Decompressed: 463Downloaded: 4571 file(s) [attempted 4571/8639 = 52%, 558 KB/s], Decompressed: 463Downloaded: 4688 file(s) [attempted 4688/8639 = 54%, 184 KB/s], Decompressed: 463Downloaded: 4805 file(s) [attempted 4805/8639 = 55%, 760 KB/s], Decompressed: 463Downloaded: 4958 file(s) [attempted 4958/8639 = 57%, 202 KB/s], Decompressed: 463Downloaded: 5068 file(s) [attempted 5068/8639 = 58%, 947 KB/s], Decompressed: 463Downloaded: 5207 file(s) [attempted 5207/8639 = 60%, 2465 KB/s], Decompressed: 463Downloaded: 5354 file(s) [attempted 5354/8639 = 61%, 1907 KB/s], Decompressed: 463Downloaded: 5497 file(s) [attempted 5497/8639 = 63%, 1836 KB/s], Decompressed: 463Downloaded: 5641 file(s) [attempted 5641/8639 = 65%, 5599 KB/s], Decompressed: 463Downloaded: 5784 file(s) [attempted 5784/8639 = 66%, 147 KB/s], Decompressed: 463Downloaded: 5932 file(s) [attempted 5932/8639 = 68%, 544 KB/s], Decompressed: 463Downloaded: 6065 file(s) [attempted 6065/8639 = 70%, 7732 KB/s], Decompressed: 463Downloaded: 6214 file(s) [attempted 6214/8639 = 71%, 489 KB/s], Decompressed: 463Downloaded: 6348 file(s) [attempted 6348/8639 = 73%, 1501 KB/s], Decompressed: 463Downloaded: 6479 file(s) [attempted 6479/8639 = 74%, 785 KB/s], Decompressed: 463Downloaded: 6625 file(s) [attempted 6625/8639 = 76%, 887 KB/s], Decompressed: 463Downloaded: 6714 file(s) [attempted 6714/8639 = 77%, 6179 KB/s], Decompressed: 463Downloaded: 6842 file(s) [attempted 6842/8639 = 79%, 2991 KB/s], Decompressed: 463Downloaded: 6989 file(s) [attempted 6989/8639 = 80%, 571 KB/s], Decompressed: 463Downloaded: 7132 file(s) [attempted 7132/8639 = 82%, 685 KB/s], Decompressed: 463Downloaded: 7283 file(s) [attempted 7283/8639 = 84%, 537 KB/s], Decompressed: 463Downloaded: 7432 file(s) [attempted 7432/8639 = 86%, 980 KB/s], Decompressed: 463Downloaded: 7526 file(s) [attempted 7526/8639 = 87%, 361 KB/s], Decompressed: 463Downloaded: 7675 file(s) [attempted 7675/8639 = 88%, 1369 KB/s], Decompressed: 463Downloaded: 7828 file(s) [attempted 7828/8639 = 90%, 421 KB/s], Decompressed: 463Downloaded: 7927 file(s) [attempted 7927/8639 = 91%, 1493 KB/s], Decompressed: 463Downloaded: 8053 file(s) [attempted 8053/8639 = 93%, 517 KB/s], Decompressed: 463Downloaded: 8183 file(s) [attempted 8183/8639 = 94%, 196 KB/s], Decompressed: 463Downloaded: 8336 file(s) [attempted 8336/8639 = 96%, 382 KB/s], Decompressed: 463Downloaded: 8480 file(s) [attempted 8480/8639 = 98%, 2744 KB/s], Decompressed: 463Downloaded: 8629 file(s) [attempted 8629/8639 = 99%, 2391 KB/s], Decompressed: 1921Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 2391 KB/s], Decompressed: 1921
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (423ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (2.8s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (4.1s)
✔ [8659/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (7.0s)
✔ [8660/8667] Built TateCurvesTheta.QParameter.Basic (3.9s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (8.4s)
✔ [8662/8675] Built Iut.Cor312.ThetaData.Places (7.4s)
✔ [8663/8675] Built TateCurvesTheta.QParameter.BaseChange (2.8s)
✔ [8664/8675] Built TateCurvesTheta.Analysis.Strassmann (4.9s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (4.2s)
✔ [8666/8678] Built TateCurvesTheta.QParameter.PrimeToOrder (3.2s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.9s)
✔ [8668/8680] Built TateCurvesTheta.TateCurve.Discriminant (5.5s)
✔ [8669/8680] Built TateCurvesTheta.QParameter.NormalizedOrder (4.9s)
✔ [8670/8680] Built TateCurvesTheta.TateCurve.JInvariant (3.2s)
✔ [8671/8680] Built TateCurvesTheta.TateCurve.Parametrization (4.3s)
✔ [8672/8680] Built TateCurvesTheta.TateCurve.SplitReduction (4.5s)
✔ [8673/8684] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.9s)
✔ [8675/8693] Built TateCurvesTheta.Theta.Basic (4.1s)
✔ [8676/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (4.7s)
✔ [8677/8696] Built TateCurvesTheta.QParameter.JParametrization (9.2s)
✔ [8678/8696] Built TateCurvesTheta.Theta.Periodicity (4.1s)
✔ [8679/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (5.8s)
✔ [8680/8699] Built TateCurvesTheta.QParameter.Characterization (3.8s)
✔ [8681/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (9.6s)
✔ [8682/8705] Built TateCurvesTheta.Theta.Product (5.1s)
✔ [8683/8705] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (7.8s)
✔ [8684/8705] Built TateCurvesTheta.Theta.Divisor (5.7s)
✔ [8685/8705] Built TateCurvesTheta.Theta.QBinomial (7.6s)
✔ [8686/8708] Built TateCurvesTheta.Theta.Uniqueness (6.6s)
✔ [8687/8708] Built TateCurvesTheta.TateCurve.EisensteinSeries (12s)
✔ [8688/8708] Built TateCurvesTheta.TateCurve.CoordinateInversion (4.4s)
✔ [8689/8708] Built TateCurvesTheta.Theta.LaurentSphere (4.2s)
✔ [8690/8711] Built TateCurvesTheta.Theta.FactorSeries (6.7s)
✔ [8691/8712] Built TateCurvesTheta.TateCurve.TatePointMem (3.8s)
✔ [8692/8713] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.4s)
✔ [8693/8714] Built TateCurvesTheta.Theta.ThetaProdLaurent (4.5s)
✔ [8694/8715] Built TateCurvesTheta.TateCurve.Quotient (6.9s)
✔ [8695/8716] Built TateCurvesTheta.TateCurve.IntegralModel (6.2s)
✔ [8696/8717] Built TateCurvesTheta.Theta.LaurentUnitSphere (4.0s)
✔ [8697/8719] Built TateCurvesTheta.TateCurve.SphereBounds (6.2s)
✔ [8698/8720] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.8s)
✔ [8699/8721] Built TateCurvesTheta.Theta.FactorReciprocal (3.8s)
✔ [8700/8721] Built TateCurvesTheta.Theta.LaurentUnique (3.8s)
✔ [8701/8721] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (4.2s)
✔ [8702/8722] Built TateCurvesTheta.TateCurve.PointMap (7.7s)
✔ [8703/8729] Built TateCurvesTheta.Theta.Normalization (3.9s)
✔ [8704/8729] Built TateCurvesTheta.Theta.SeriesZero (5.1s)
✔ [8705/8729] Built TateCurvesTheta.Theta.RatioAnnulus (4.9s)
✔ [8706/8729] Built TateCurvesTheta.Theta.Durfee (5.5s)
✔ [8707/8729] Built TateCurvesTheta.Theta.TripleProduct (5.8s)
✔ [8708/8729] Built TateCurvesTheta.Theta.StrictDominant (9.9s)
✔ [8709/8729] Built TateCurvesTheta.Theta.Inversion (4.3s)
✔ [8710/8731] Built TateCurvesTheta.Uniformization (9.6s)
✔ [8711/8733] Built TateCurvesTheta.Theta.WeightSpace (15s)
✔ [8712/8735] Built Iut.Cor312.Procession (10s)
✔ [8713/8766] Built Iut.Cor312.RationalPlace (8.9s)
✔ [8714/8766] Built Iut.Cor312.PacketPresentation (9.4s)
✔ [8715/8766] Built IUTThreeClosures.ABCStatement (3.4s)
⚠ [8716/8766] Built IUTThreeClosures.HonestFinitePositiveLogVolume (9.8s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8717/8785] Built IUTThreeClosures.FullPolyCore (8.1s)
⚠ [8719/8785] Built IUTThreeClosures.Cor312CoefficientAlgebra (9.2s)
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
✔ [8720/8785] Built Iut.Cor312.Container (7.3s)
✔ [8721/8785] Built Iut.Cor312.HolomorphicHull (7.4s)
✔ [8722/8785] Built TateCurvesTheta.Theta.PuncturedProduct (49s)
⚠ [8723/8785] Built IUTThreeClosures.HonestPilotWitness (6.7s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8724/8785] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.8s)
⚠ [8725/8785] Built IUTThreeClosures.ExplicitSemistableCurve (6.4s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8726/8785] Built Heights.WeilHeight (8.6s)
⚠ [8727/8785] Built IUTThreeClosures.SolvableRestrictionImage (7.3s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8785] Built IUTThreeClosures.QPilotNormalizationAudit (6.5s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8785] Built IUTThreeClosures.RootQPilotDivisor (6.1s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8730/8785] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.3s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8785] Built IUTThreeClosures.RamificationCorrectedQPilot (6.5s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8785] Built IUTThreeClosures.ProductWeightMarginalization (7.6s)
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
⚠ [8734/8785] Built IUTThreeClosures.AdmissiblePrimeSelection (6.1s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8735/8785] Built IUTThreeClosures.FiniteExceptionalSet (5.7s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8736/8785] Built IUTThreeClosures.GeneratedUnionCompactness (5.6s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8737/8785] Built Iut.Cor312.LogVolume (6.1s)
✔ [8738/8785] Built Iut.Cor312.ContainerHull (5.9s)
✔ [8740/8800] Built TateCurvesTheta.TateCurve.DefectVanishing (101s)
⚠ [8741/8800] Built IUTThreeClosures.HonestGeneratedSource (6.4s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8742/8800] Built IUTThreeClosures.ZModSL2Perfect (6.1s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8743/8800] Built Genl.Mathlib.Order.BoundedDiscrepancy (3.1s)
⚠ [8744/8800] Built IUTThreeClosures.QPilotNormalizationFork (6.6s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8745/8800] Built IUTThreeClosures.PrimePowerQPilotRegion (6.9s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8746/8800] Built TateCurvesTheta.TateCurve.TatePointOnCurve (7.2s)
⚠ [8747/8800] Built IUTThreeClosures.TateParameterUnitBallRegion (3.2s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8748/8800] Built IUTThreeClosures.FiniteExponentHull (6.1s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8800] Built IUTThreeClosures.StandardZeroLabel (5.5s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8800] Built IUTThreeClosures.BarycentricPacketReading (5.8s)
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
⚠ [8751/8800] Built IUTThreeClosures.DiagonalPacketNoGo (5.5s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8752/8800] Built Genl.GeneralPosition.HeightTheory (1.8s)
⚠ [8753/8800] Built IUTThreeClosures.PublicNormalizationObstruction (6.2s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8754/8800] Built Iut4Sec1.Global.ArithmeticDivisor (6.2s)
⚠ [8755/8800] Built IUTThreeClosures.IUTIVAbsorption (8.8s)
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
⚠ [8756/8800] Built IUTThreeClosures.DistinguishedLabelQPilot (5.9s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8757/8800] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (9.6s)
⚠ [8758/8800] Built IUTThreeClosures.ZeroLabelBarycentric (8.8s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8759/8800] Built TateCurvesTheta.TateCurve.AdditionLaw (11s)
✔ [8760/8800] Built TateCurvesTheta.TateCurve.LargePointParametrization (14s)
⚠ [8761/8800] Built IUTThreeClosures.StatementIIOutsideFinite (6.2s)
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
✔ [8762/8800] Built TateCurvesTheta.TateCurve.AbelStep (7.2s)
✔ [8763/8800] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8764/8800] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (23s)
✔ [8765/8800] Built TateCurvesTheta.TateCurve.SurjectivitySphere (25s)
✔ [8766/8800] Built TateCurvesTheta.TateCurve.TateUniformization (3.0s)
✔ [8767/8800] Built TateCurvesTheta (3.3s)
✔ [8768/8800] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.4s)
✔ [8769/8800] Built Iut.Cor312.ThetaData.Orbicurve (4.3s)
✔ [8770/8800] Built Iut.Cor312.ThetaData.LocalConditions (7.3s)
✔ [8771/8800] Built Iut.Cor312.ThetaData.Basic (4.2s)
✔ [8772/8800] Built Iut.Cor312.LeftHandSide (3.8s)
✔ [8773/8800] Built Iut.Cor312.RightHandSide (3.9s)
✔ [8774/8800] Built Iut.Cor312.Statement (3.8s)
⚠ [8775/8800] Built IUTThreeClosures.NativeQPilotCalibration (5.5s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8776/8800] Built IUTThreeClosures.CorrectedQPilotDivisor (5.6s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8777/8800] Built IUTThreeClosures.ActualPilotWitness (4.0s)
✔ [8778/8800] Built IUTThreeClosures.GeneratedSource (4.1s)
✔ [8779/8800] Built IUTThreeClosures.QuantifierCorrectClosure (3.6s)
✔ [8780/8800] Built IUTThreeClosures.ABCClosure (3.8s)
⚠ [8781/8800] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.1s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8782/8800] Built IUTThreeClosures.ThreeClosureTheorems (3.6s)
✔ [8783/8800] Built IUTThreeClosures.InhabitationBoundary (3.7s)
✔ [8784/8800] Built IUTThreeClosures.CircularityAudit (3.7s)
✔ [8785/8800] Built IUTThreeClosures.NonCircularDownstream (4.8s)
✔ [8786/8800] Built IUTThreeClosures.FourOpenConstructions (3.9s)
⚠ [8787/8800] Built IUTThreeClosures.ABCPointLegendreCurve (4.3s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8788/8800] Built IUTThreeClosures.PublicProgramUninhabited (5.4s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8789/8800] Built IUTThreeClosures.LegendreArithmetic (4.0s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8790/8800] Built IUTThreeClosures.BridgeInhabitationAudit (6.4s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8791/8800] Built IUTThreeClosures.BridgeInhabitationExact (4.2s)
⚠ [8792/8800] Built IUTThreeClosures.TripodWeilHeight (5.3s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8793/8800] Built IUTThreeClosures.ABCFreyCurve (5.0s)
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
⚠ [8794/8800] Built IUTThreeClosures.FreyDiscriminantConductor (4.5s)
warning: IUTThreeClosures/FreyDiscriminantConductor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8795/8800] Built IUTThreeClosures.CanonicalQPilotCorridor (5.6s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8796/8800] Built IUTThreeClosures.LegendreHeightCorridor (5.8s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8797/8800] Built IUTThreeClosures.CanonicalCorridorAudit (3.8s)
⚠ [8798/8800] Built IUTThreeClosures.SourceDerivedIUTIVBridge (4.7s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8799/8800] Built IUTThreeClosures (3.3s)
warning: IUTThreeClosures.lean:62:46: '' starts on column 46, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Build completed successfully (8800 jobs).
```
