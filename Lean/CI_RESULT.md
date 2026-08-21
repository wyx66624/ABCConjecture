# Lean CI result

- Tested commit: `c9c078a3183ef3b385d446ff2d7f6dd8912478ac`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
538:✖ [8799/8801] Building IUTThreeClosures.FreyJHeightCorridor (4.3s)
545:error: IUTThreeClosures/FreyJHeightCorridor.lean:118:4: linarith failed to find a contradiction
557:error: IUTThreeClosures/FreyJHeightCorridor.lean:145:4: linarith failed to find a contradiction
569:error: Lean exited with code 1
570:Some required targets logged failures:
572:error: build failed
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
✔ [2/6] Built Cache.Cli (367ms)
✔ [3/6] Built Cache.Lean (437ms)
✔ [8/27] Built Cache.Cli:c.o (240ms)
✔ [10/27] Built Cache.Lean:c.o (276ms)
✔ [11/27] Built Cache.Infra (480ms)
✔ [12/27] Built Cache.Infra:c.o (229ms)
✔ [13/27] Built Cache.IO (1.5s)
✔ [14/27] Built Cache.Hashing (795ms)
✔ [15/27] Built Cache.Hashing:c.o (622ms)
✔ [16/27] Built Cache.IO:c.o (1.7s)
✔ [17/27] Built Cache.Requests (2.1s)
✔ [18/27] Built Cache.Marker (589ms)
✔ [19/27] Built Cache.Marker:c.o (214ms)
✔ [20/27] Built Cache.Query (734ms)
✔ [21/27] Built Cache.Query:c.o (466ms)
✔ [22/27] Built Cache.Warning (878ms)
✔ [23/27] Built Cache.Warning:c.o (300ms)
✔ [24/27] Built Cache.Requests:c.o (3.1s)
✔ [25/27] Built Cache.Main (1.8s)
✔ [26/27] Built Cache.Main:c.o (928ms)
✔ [27/27] Built cache:exe (703ms)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 16 KB/s], Decompressed: 0Downloaded: 124 file(s) [attempted 124/8639 = 1%, 1671 KB/s], Decompressed: 9Downloaded: 285 file(s) [attempted 285/8639 = 3%, 3921 KB/s], Decompressed: 37Downloaded: 433 file(s) [attempted 433/8639 = 5%, 2274 KB/s], Decompressed: 37Downloaded: 603 file(s) [attempted 603/8639 = 6%, 2034 KB/s], Decompressed: 37Downloaded: 769 file(s) [attempted 769/8639 = 8%, 913 KB/s], Decompressed: 37Downloaded: 887 file(s) [attempted 887/8639 = 10%, 540 KB/s], Decompressed: 155Downloaded: 1018 file(s) [attempted 1018/8639 = 11%, 1064 KB/s], Decompressed: 155Downloaded: 1170 file(s) [attempted 1170/8639 = 13%, 1653 KB/s], Decompressed: 155Downloaded: 1295 file(s) [attempted 1295/8639 = 14%, 1454 KB/s], Decompressed: 155Downloaded: 1484 file(s) [attempted 1484/8639 = 17%, 1152 KB/s], Decompressed: 155Downloaded: 1647 file(s) [attempted 1647/8639 = 19%, 4666 KB/s], Decompressed: 155Downloaded: 1803 file(s) [attempted 1803/8639 = 20%, 967 KB/s], Decompressed: 155Downloaded: 1953 file(s) [attempted 1953/8639 = 22%, 2428 KB/s], Decompressed: 155Downloaded: 2102 file(s) [attempted 2102/8639 = 24%, 357 KB/s], Decompressed: 155Downloaded: 2251 file(s) [attempted 2251/8639 = 26%, 1236 KB/s], Decompressed: 155Downloaded: 2402 file(s) [attempted 2402/8639 = 27%, 1867 KB/s], Decompressed: 155Downloaded: 2554 file(s) [attempted 2554/8639 = 29%, 869 KB/s], Decompressed: 155Downloaded: 2661 file(s) [attempted 2661/8639 = 30%, 2449 KB/s], Decompressed: 155Downloaded: 2817 file(s) [attempted 2817/8639 = 32%, 12634 KB/s], Decompressed: 155Downloaded: 2976 file(s) [attempted 2976/8639 = 34%, 3357 KB/s], Decompressed: 155Downloaded: 3127 file(s) [attempted 3127/8639 = 36%, 1551 KB/s], Decompressed: 155Downloaded: 3286 file(s) [attempted 3286/8639 = 38%, 776 KB/s], Decompressed: 155Downloaded: 3454 file(s) [attempted 3454/8639 = 39%, 834 KB/s], Decompressed: 155Downloaded: 3589 file(s) [attempted 3589/8639 = 41%, 240 KB/s], Decompressed: 155Downloaded: 3722 file(s) [attempted 3722/8639 = 43%, 2593 KB/s], Decompressed: 778Downloaded: 3862 file(s) [attempted 3862/8639 = 44%, 2146 KB/s], Decompressed: 778Downloaded: 4013 file(s) [attempted 4013/8639 = 46%, 844 KB/s], Decompressed: 778Downloaded: 4120 file(s) [attempted 4120/8639 = 47%, 836 KB/s], Decompressed: 778Downloaded: 4280 file(s) [attempted 4280/8639 = 49%, 2005 KB/s], Decompressed: 778Downloaded: 4428 file(s) [attempted 4428/8639 = 51%, 3324 KB/s], Decompressed: 778Downloaded: 4565 file(s) [attempted 4565/8639 = 52%, 2594 KB/s], Decompressed: 778Downloaded: 4696 file(s) [attempted 4696/8639 = 54%, 2780 KB/s], Decompressed: 778Downloaded: 4854 file(s) [attempted 4854/8639 = 56%, 498 KB/s], Decompressed: 778Downloaded: 4999 file(s) [attempted 4999/8639 = 57%, 4987 KB/s], Decompressed: 778Downloaded: 5136 file(s) [attempted 5136/8639 = 59%, 1374 KB/s], Decompressed: 778Downloaded: 5265 file(s) [attempted 5265/8639 = 60%, 1383 KB/s], Decompressed: 778Downloaded: 5374 file(s) [attempted 5374/8639 = 62%, 617 KB/s], Decompressed: 778Downloaded: 5521 file(s) [attempted 5521/8639 = 63%, 1747 KB/s], Decompressed: 778Downloaded: 5619 file(s) [attempted 5619/8639 = 65%, 1361 KB/s], Decompressed: 778Downloaded: 5726 file(s) [attempted 5726/8639 = 66%, 1856 KB/s], Decompressed: 778Downloaded: 5873 file(s) [attempted 5873/8639 = 67%, 293 KB/s], Decompressed: 778Downloaded: 5963 file(s) [attempted 5963/8639 = 69%, 345 KB/s], Decompressed: 778Downloaded: 6076 file(s) [attempted 6076/8639 = 70%, 3407 KB/s], Decompressed: 778Downloaded: 6127 file(s) [attempted 6127/8639 = 70%, 1386 KB/s], Decompressed: 778Downloaded: 6276 file(s) [attempted 6276/8639 = 72%, 8216 KB/s], Decompressed: 778Downloaded: 6376 file(s) [attempted 6376/8639 = 73%, 7764 KB/s], Decompressed: 778Downloaded: 6480 file(s) [attempted 6480/8639 = 75%, 2299 KB/s], Decompressed: 778Downloaded: 6612 file(s) [attempted 6612/8639 = 76%, 2182 KB/s], Decompressed: 778Downloaded: 6726 file(s) [attempted 6726/8639 = 77%, 3127 KB/s], Decompressed: 778Downloaded: 6871 file(s) [attempted 6871/8639 = 79%, 756 KB/s], Decompressed: 778Downloaded: 7020 file(s) [attempted 7020/8639 = 81%, 3023 KB/s], Decompressed: 778Downloaded: 7167 file(s) [attempted 7167/8639 = 82%, 1916 KB/s], Decompressed: 778Downloaded: 7216 file(s) [attempted 7216/8639 = 83%, 2464 KB/s], Decompressed: 778Downloaded: 7325 file(s) [attempted 7325/8639 = 84%, 264 KB/s], Decompressed: 778Downloaded: 7470 file(s) [attempted 7470/8639 = 86%, 800 KB/s], Decompressed: 778Downloaded: 7626 file(s) [attempted 7626/8639 = 88%, 3929 KB/s], Decompressed: 778Downloaded: 7777 file(s) [attempted 7777/8639 = 90%, 203 KB/s], Decompressed: 778Downloaded: 7931 file(s) [attempted 7931/8639 = 91%, 2919 KB/s], Decompressed: 778Downloaded: 8083 file(s) [attempted 8083/8639 = 93%, 2740 KB/s], Decompressed: 778Downloaded: 8203 file(s) [attempted 8203/8639 = 94%, 2204 KB/s], Decompressed: 778Downloaded: 8366 file(s) [attempted 8366/8639 = 96%, 2330 KB/s], Decompressed: 778Downloaded: 8491 file(s) [attempted 8491/8639 = 98%, 285 KB/s], Decompressed: 778Downloaded: 8637 file(s) [attempted 8637/8639 = 99%, 1117 KB/s], Decompressed: 778Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 1117 KB/s], Decompressed: 778
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (418ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (2.9s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.5s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.8s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (9.1s)
✔ [8661/8667] Built TateCurvesTheta.Analysis.Strassmann (5.5s)
✔ [8662/8673] Built Iut.Cor312.ThetaData.Places (6.9s)
✔ [8663/8673] Built TateCurvesTheta.AnalyticQuotient (8.6s)
✔ [8664/8675] Built TateCurvesTheta.QParameter.BaseChange (2.8s)
✔ [8665/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (3.4s)
✔ [8666/8675] Built TateCurvesTheta.TateCurve.Weierstrass (4.1s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.6s)
✔ [8668/8679] Built TateCurvesTheta.QParameter.NormalizedOrder (3.4s)
✔ [8669/8689] Built TateCurvesTheta.TateCurve.Parametrization (4.5s)
✔ [8670/8689] Built TateCurvesTheta.TateCurve.Discriminant (4.9s)
✔ [8671/8691] Built TateCurvesTheta.Theta.Basic (4.2s)
✔ [8672/8691] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (2.9s)
✔ [8673/8691] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.CoordinateExpansion (3.7s)
✔ [8675/8692] Built TateCurvesTheta.TateCurve.JInvariant (3.6s)
✔ [8676/8692] Built TateCurvesTheta.Theta.Periodicity (3.3s)
✔ [8677/8696] Built TateCurvesTheta.TateCurve.SplitReduction (5.1s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (4.5s)
✔ [8679/8696] Built TateCurvesTheta.Theta.Product (6.8s)
✔ [8680/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (10s)
✔ [8681/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (9.9s)
✔ [8682/8696] Built TateCurvesTheta.QParameter.JParametrization (9.6s)
✔ [8683/8696] Built TateCurvesTheta.Theta.Uniqueness (5.6s)
✔ [8684/8696] Built TateCurvesTheta.Theta.Divisor (6.3s)
✔ [8685/8696] Built TateCurvesTheta.Theta.FactorSeries (6.2s)
✔ [8686/8696] Built TateCurvesTheta.QParameter.Characterization (3.3s)
✔ [8687/8704] Built TateCurvesTheta.TateCurve.TatePointMem (4.4s)
✔ [8688/8705] Built TateCurvesTheta.TateCurve.EisensteinSeries (13s)
✔ [8689/8705] Built TateCurvesTheta.Theta.LaurentSphere (5.2s)
✔ [8690/8708] Built TateCurvesTheta.Theta.ThetaProdLaurent (6.1s)
✔ [8691/8708] Built TateCurvesTheta.TateCurve.CoordinateInversion (3.0s)
✔ [8692/8708] Built TateCurvesTheta.Theta.LaurentSphereReduce (4.1s)
✔ [8693/8712] Built TateCurvesTheta.Theta.QBinomial (5.2s)
✔ [8694/8713] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.1s)
✔ [8695/8715] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.1s)
✔ [8696/8715] Built TateCurvesTheta.TateCurve.IntegralModel (5.8s)
✔ [8697/8715] Built TateCurvesTheta.TateCurve.Quotient (6.9s)
✔ [8698/8717] Built TateCurvesTheta.Theta.Normalization (4.4s)
✔ [8699/8717] Built TateCurvesTheta.TateCurve.SphereBounds (6.8s)
✔ [8700/8717] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (4.9s)
✔ [8701/8719] Built TateCurvesTheta.Theta.FactorReciprocal (4.0s)
✔ [8702/8720] Built TateCurvesTheta.Theta.Durfee (7.6s)
✔ [8703/8720] Built TateCurvesTheta.TateCurve.PointMap (11s)
✔ [8704/8720] Built TateCurvesTheta.Theta.LaurentUnique (4.7s)
✔ [8705/8720] Built TateCurvesTheta.Theta.RatioAnnulus (4.5s)
✔ [8706/8721] Built TateCurvesTheta.Theta.Inversion (3.8s)
✔ [8707/8721] Built TateCurvesTheta.Theta.SeriesZero (4.2s)
✔ [8708/8729] Built TateCurvesTheta.Theta.WeightSpace (18s)
✔ [8709/8729] Built TateCurvesTheta.Theta.StrictDominant (14s)
✔ [8710/8731] Built TateCurvesTheta.Theta.TripleProduct (4.7s)
✔ [8711/8733] Built Iut.Cor312.Procession (8.7s)
✔ [8712/8735] Built TateCurvesTheta.Uniformization (13s)
✔ [8713/8765] Built Iut.Cor312.RationalPlace (9.3s)
✔ [8714/8765] Built Iut.Cor312.PacketPresentation (9.3s)
✔ [8715/8765] Built IUTThreeClosures.ABCStatement (3.2s)
✔ [8716/8765] Built TateCurvesTheta.Theta.PuncturedProduct (47s)
⚠ [8717/8786] Built IUTThreeClosures.HonestFinitePositiveLogVolume (7.8s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8719/8786] Built IUTThreeClosures.FullPolyCore (5.0s)
✔ [8720/8786] Built Iut.Cor312.Container (5.6s)
⚠ [8721/8786] Built IUTThreeClosures.Cor312CoefficientAlgebra (6.3s)
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
✔ [8722/8786] Built Iut.Cor312.HolomorphicHull (6.4s)
⚠ [8723/8786] Built IUTThreeClosures.HonestPilotWitness (6.0s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8724/8786] Built Heights.WeilHeight (8.4s)
⚠ [8725/8786] Built IUTThreeClosures.ExplicitSemistableCurve (6.7s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8726/8786] Built IUTThreeClosures.SolvableRestrictionImage (6.9s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8727/8786] Built IUTThreeClosures.QPilotNormalizationAudit (6.4s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8786] Built IUTThreeClosures.RootQPilotDivisor (6.6s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8729/8786] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.1s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8730/8786] Built IUTThreeClosures.RamificationCorrectedQPilot (6.7s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8786] Built IUTThreeClosures.ProductWeightMarginalization (7.3s)
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
⚠ [8733/8786] Built IUTThreeClosures.AdmissiblePrimeSelection (6.3s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8734/8786] Built IUTThreeClosures.FiniteExceptionalSet (6.1s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8735/8786] Built IUTThreeClosures.GeneratedUnionCompactness (5.8s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8736/8786] Built IUTThreeClosures.WeakCompatibilityCountermodel (6.2s)
✔ [8737/8786] Built TateCurvesTheta.TateCurve.DefectVanishing (100s)
✔ [8738/8786] Built Iut.Cor312.LogVolume (6.4s)
✔ [8740/8801] Built Iut.Cor312.ContainerHull (5.7s)
⚠ [8741/8801] Built IUTThreeClosures.HonestGeneratedSource (6.0s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8742/8801] Built IUTThreeClosures.ZModSL2Perfect (6.3s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8743/8801] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.8s)
⚠ [8744/8801] Built IUTThreeClosures.QPilotNormalizationFork (6.7s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8745/8801] Built TateCurvesTheta.TateCurve.TatePointOnCurve (7.2s)
⚠ [8746/8801] Built IUTThreeClosures.PrimePowerQPilotRegion (6.9s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8747/8801] Built IUTThreeClosures.TateParameterUnitBallRegion (3.5s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8748/8801] Built IUTThreeClosures.FiniteExponentHull (6.4s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8801] Built IUTThreeClosures.StandardZeroLabel (5.8s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8801] Built IUTThreeClosures.DiagonalPacketNoGo (5.6s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8751/8801] Built IUTThreeClosures.BarycentricPacketReading (5.7s)
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
✔ [8752/8801] Built Genl.GeneralPosition.HeightTheory (1.9s)
✔ [8753/8801] Built Iut4Sec1.Global.ArithmeticDivisor (5.0s)
⚠ [8754/8801] Built IUTThreeClosures.PublicNormalizationObstruction (6.4s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8755/8801] Built IUTThreeClosures.IUTIVAbsorption (9.0s)
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
✔ [8756/8801] Built TateCurvesTheta.TateCurve.AdditionLaw (9.6s)
⚠ [8757/8801] Built IUTThreeClosures.DistinguishedLabelQPilot (9.6s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8758/8801] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (9.8s)
⚠ [8759/8801] Built IUTThreeClosures.ZeroLabelBarycentric (7.8s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8760/8801] Built TateCurvesTheta.TateCurve.LargePointParametrization (15s)
⚠ [8761/8801] Built IUTThreeClosures.StatementIIOutsideFinite (6.4s)
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
✔ [8762/8801] Built TateCurvesTheta.TateCurve.AbelStep (7.7s)
✔ [8763/8801] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8764/8801] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (22s)
✔ [8765/8801] Built TateCurvesTheta.TateCurve.SurjectivitySphere (26s)
✔ [8766/8801] Built TateCurvesTheta.TateCurve.TateUniformization (3.9s)
✔ [8767/8801] Built TateCurvesTheta (3.3s)
✔ [8768/8801] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.4s)
✔ [8769/8801] Built Iut.Cor312.ThetaData.Orbicurve (4.2s)
✔ [8770/8801] Built Iut.Cor312.ThetaData.LocalConditions (7.3s)
✔ [8771/8801] Built Iut.Cor312.ThetaData.Basic (4.2s)
✔ [8772/8801] Built Iut.Cor312.LeftHandSide (3.8s)
✔ [8773/8801] Built Iut.Cor312.RightHandSide (3.9s)
⚠ [8774/8801] Built IUTThreeClosures.NativeQPilotCalibration (4.2s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8775/8801] Built Iut.Cor312.Statement (4.9s)
⚠ [8776/8801] Built IUTThreeClosures.CorrectedQPilotDivisor (5.2s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8777/8801] Built IUTThreeClosures.ActualPilotWitness (3.7s)
✔ [8778/8801] Built IUTThreeClosures.GeneratedSource (4.2s)
✔ [8779/8801] Built IUTThreeClosures.QuantifierCorrectClosure (3.6s)
✔ [8780/8801] Built IUTThreeClosures.ABCClosure (3.9s)
⚠ [8781/8801] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.2s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8782/8801] Built IUTThreeClosures.ThreeClosureTheorems (3.6s)
✔ [8783/8801] Built IUTThreeClosures.InhabitationBoundary (3.7s)
✔ [8784/8801] Built IUTThreeClosures.CircularityAudit (3.8s)
✔ [8785/8801] Built IUTThreeClosures.NonCircularDownstream (4.8s)
✔ [8786/8801] Built IUTThreeClosures.FourOpenConstructions (3.9s)
⚠ [8787/8801] Built IUTThreeClosures.ABCPointLegendreCurve (4.4s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8788/8801] Built IUTThreeClosures.PublicProgramUninhabited (5.5s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8789/8801] Built IUTThreeClosures.LegendreArithmetic (4.0s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8790/8801] Built IUTThreeClosures.BridgeInhabitationAudit (6.2s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8791/8801] Built IUTThreeClosures.BridgeInhabitationExact (3.8s)
⚠ [8792/8801] Built IUTThreeClosures.TripodWeilHeight (5.8s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8793/8801] Built IUTThreeClosures.ABCFreyCurve (6.1s)
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
⚠ [8794/8801] Built IUTThreeClosures.CanonicalQPilotCorridor (4.4s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8795/8801] Built IUTThreeClosures.LegendreHeightCorridor (4.7s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8796/8801] Built IUTThreeClosures.CanonicalCorridorAudit (4.5s)
⚠ [8797/8801] Built IUTThreeClosures.SourceDerivedIUTIVBridge (5.9s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8798/8801] Built IUTThreeClosures.FreyJReducedData (4.8s)
warning: IUTThreeClosures/FreyJReducedData.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8799/8801] Building IUTThreeClosures.FreyJHeightCorridor (4.3s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/FreyJHeightCorridor.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FreyJHeightCorridor.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FreyJHeightCorridor.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FreyJHeightCorridor.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FreyJHeightCorridor.setup.json --json
warning: IUTThreeClosures/FreyJHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/FreyJHeightCorridor.lean:118:4: linarith failed to find a contradiction
P : ABCPoint
M : ℕ := max P.freyJReducedNum P.freyJReducedDen
hM : 0 < M
hnat : P.c ^ 6 ≤ 8 * M
hcR : 0 < ↑P.c
hMR : 0 < ↑M
hreal : ↑P.c ^ 6 ≤ 8 * ↑M
hlog : ↑6 * Real.log ↑P.c ≤ Real.log 8 + Real.log ↑M
a✝ : Real.log ↑M / 6 + Real.log 8 / 6 < Real.log ↑P.c
⊢ False
failed
error: IUTThreeClosures/FreyJHeightCorridor.lean:145:4: linarith failed to find a contradiction
P : ABCPoint
M : ℕ := max P.freyJReducedNum P.freyJReducedDen
hM : 0 < M
hnat : M ≤ 256 * P.c ^ 6
hMR : 0 < ↑M
hcR : 0 < ↑P.c
hreal : ↑M ≤ 256 * ↑P.c ^ 6
hlog : Real.log ↑M ≤ Real.log 256 + ↑6 * Real.log ↑P.c
a✝ : Real.log ↑P.c + Real.log 256 / 6 < Real.log ↑M / 6
⊢ False
failed
error: Lean exited with code 1
Some required targets logged failures:
- IUTThreeClosures.FreyJHeightCorridor
error: build failed
```
