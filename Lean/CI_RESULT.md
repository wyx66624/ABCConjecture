# Lean CI result

- Tested commit: `d471fcc4a291949b070733700f29eb2db6267bbb`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
538:✖ [8799/8801] Building IUTThreeClosures.FreyJHeightCorridor (4.9s)
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
✔ [2/6] Built Cache.Cli (353ms)
✔ [3/6] Built Cache.Lean (442ms)
✔ [8/27] Built Cache.Cli:c.o (187ms)
✔ [9/27] Built Cache.Lean:c.o (206ms)
✔ [11/27] Built Cache.Infra (482ms)
✔ [12/27] Built Cache.Infra:c.o (201ms)
✔ [13/27] Built Cache.IO (1.5s)
✔ [14/27] Built Cache.Hashing (830ms)
✔ [15/27] Built Cache.Hashing:c.o (609ms)
✔ [16/27] Built Cache.IO:c.o (1.8s)
✔ [17/27] Built Cache.Requests (2.0s)
✔ [18/27] Built Cache.Marker (693ms)
✔ [19/27] Built Cache.Marker:c.o (132ms)
✔ [20/27] Built Cache.Query (829ms)
✔ [21/27] Built Cache.Query:c.o (297ms)
✔ [22/27] Built Cache.Warning (852ms)
✔ [23/27] Built Cache.Warning:c.o (349ms)
✔ [24/27] Built Cache.Requests:c.o (3.0s)
✔ [25/27] Built Cache.Main (1.6s)
✔ [26/27] Built Cache.Main:c.o (867ms)
✔ [27/27] Built cache:exe (719ms)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 16 KB/s], Decompressed: 0Downloaded: 134 file(s) [attempted 134/8639 = 1%, 2561 KB/s], Decompressed: 9Downloaded: 304 file(s) [attempted 304/8639 = 3%, 760 KB/s], Decompressed: 45Downloaded: 475 file(s) [attempted 475/8639 = 5%, 2539 KB/s], Decompressed: 45Downloaded: 583 file(s) [attempted 583/8639 = 6%, 2521 KB/s], Decompressed: 45Downloaded: 706 file(s) [attempted 706/8639 = 8%, 5219 KB/s], Decompressed: 45Downloaded: 851 file(s) [attempted 851/8639 = 9%, 1469 KB/s], Decompressed: 45Downloaded: 1009 file(s) [attempted 1009/8639 = 11%, 2995 KB/s], Decompressed: 201Downloaded: 1175 file(s) [attempted 1175/8639 = 13%, 6764 KB/s], Decompressed: 201Downloaded: 1332 file(s) [attempted 1332/8639 = 15%, 2375 KB/s], Decompressed: 201Downloaded: 1490 file(s) [attempted 1490/8639 = 17%, 2408 KB/s], Decompressed: 201Downloaded: 1612 file(s) [attempted 1612/8639 = 18%, 1046 KB/s], Decompressed: 201Downloaded: 1749 file(s) [attempted 1749/8639 = 20%, 810 KB/s], Decompressed: 201Downloaded: 1898 file(s) [attempted 1898/8639 = 21%, 5268 KB/s], Decompressed: 201Downloaded: 2042 file(s) [attempted 2042/8639 = 23%, 1289 KB/s], Decompressed: 201Downloaded: 2161 file(s) [attempted 2161/8639 = 25%, 5789 KB/s], Decompressed: 201Downloaded: 2311 file(s) [attempted 2311/8639 = 26%, 1600 KB/s], Decompressed: 201Downloaded: 2452 file(s) [attempted 2452/8639 = 28%, 1300 KB/s], Decompressed: 201Downloaded: 2579 file(s) [attempted 2579/8639 = 29%, 1056 KB/s], Decompressed: 201Downloaded: 2723 file(s) [attempted 2723/8639 = 31%, 2367 KB/s], Decompressed: 201Downloaded: 2853 file(s) [attempted 2853/8639 = 33%, 1226 KB/s], Decompressed: 201Downloaded: 2975 file(s) [attempted 2975/8639 = 34%, 134 KB/s], Decompressed: 201Downloaded: 3097 file(s) [attempted 3097/8639 = 35%, 1520 KB/s], Decompressed: 201Downloaded: 3229 file(s) [attempted 3229/8639 = 37%, 773 KB/s], Decompressed: 201Downloaded: 3383 file(s) [attempted 3383/8639 = 39%, 708 KB/s], Decompressed: 201Downloaded: 3495 file(s) [attempted 3495/8639 = 40%, 4116 KB/s], Decompressed: 201Downloaded: 3640 file(s) [attempted 3640/8639 = 42%, 2937 KB/s], Decompressed: 201Downloaded: 3747 file(s) [attempted 3747/8639 = 43%, 3392 KB/s], Decompressed: 201Downloaded: 3903 file(s) [attempted 3903/8639 = 45%, 1543 KB/s], Decompressed: 201Downloaded: 4055 file(s) [attempted 4055/8639 = 46%, 1134 KB/s], Decompressed: 201Downloaded: 4162 file(s) [attempted 4162/8639 = 48%, 1652 KB/s], Decompressed: 201Downloaded: 4272 file(s) [attempted 4272/8639 = 49%, 6183 KB/s], Decompressed: 201Downloaded: 4418 file(s) [attempted 4418/8639 = 51%, 964 KB/s], Decompressed: 201Downloaded: 4575 file(s) [attempted 4575/8639 = 52%, 1409 KB/s], Decompressed: 201Downloaded: 4701 file(s) [attempted 4701/8639 = 54%, 3013 KB/s], Decompressed: 201Downloaded: 4885 file(s) [attempted 4885/8639 = 56%, 4442 KB/s], Decompressed: 958Downloaded: 5004 file(s) [attempted 5004/8639 = 57%, 314 KB/s], Decompressed: 958Downloaded: 5146 file(s) [attempted 5146/8639 = 59%, 2359 KB/s], Decompressed: 958Downloaded: 5293 file(s) [attempted 5293/8639 = 61%, 1544 KB/s], Decompressed: 958Downloaded: 5445 file(s) [attempted 5445/8639 = 63%, 605 KB/s], Decompressed: 958Downloaded: 5559 file(s) [attempted 5559/8639 = 64%, 523 KB/s], Decompressed: 958Downloaded: 5688 file(s) [attempted 5688/8639 = 65%, 266 KB/s], Decompressed: 958Downloaded: 5793 file(s) [attempted 5793/8639 = 67%, 93 KB/s], Decompressed: 958Downloaded: 5909 file(s) [attempted 5909/8639 = 68%, 1422 KB/s], Decompressed: 958Downloaded: 6068 file(s) [attempted 6068/8639 = 70%, 192 KB/s], Decompressed: 958Downloaded: 6217 file(s) [attempted 6217/8639 = 71%, 7153 KB/s], Decompressed: 958Downloaded: 6319 file(s) [attempted 6319/8639 = 73%, 622 KB/s], Decompressed: 958Downloaded: 6469 file(s) [attempted 6469/8639 = 74%, 167 KB/s], Decompressed: 958Downloaded: 6581 file(s) [attempted 6581/8639 = 76%, 1998 KB/s], Decompressed: 958Downloaded: 6735 file(s) [attempted 6735/8639 = 77%, 1001 KB/s], Decompressed: 958Downloaded: 6886 file(s) [attempted 6886/8639 = 79%, 1417 KB/s], Decompressed: 958Downloaded: 7044 file(s) [attempted 7044/8639 = 81%, 712 KB/s], Decompressed: 958Downloaded: 7157 file(s) [attempted 7157/8639 = 82%, 1646 KB/s], Decompressed: 958Downloaded: 7259 file(s) [attempted 7259/8639 = 84%, 3664 KB/s], Decompressed: 958Downloaded: 7404 file(s) [attempted 7404/8639 = 85%, 131 KB/s], Decompressed: 958Downloaded: 7409 file(s) [attempted 7409/8639 = 85%, 5648 KB/s], Decompressed: 958Downloaded: 7560 file(s) [attempted 7560/8639 = 87%, 4641 KB/s], Decompressed: 958Downloaded: 7707 file(s) [attempted 7707/8639 = 89%, 1063 KB/s], Decompressed: 958Downloaded: 7812 file(s) [attempted 7812/8639 = 90%, 195 KB/s], Decompressed: 958Downloaded: 7961 file(s) [attempted 7961/8639 = 92%, 122 KB/s], Decompressed: 958Downloaded: 8113 file(s) [attempted 8113/8639 = 93%, 1332 KB/s], Decompressed: 958Downloaded: 8218 file(s) [attempted 8218/8639 = 95%, 2954 KB/s], Decompressed: 958Downloaded: 8369 file(s) [attempted 8369/8639 = 96%, 416 KB/s], Decompressed: 958Downloaded: 8523 file(s) [attempted 8523/8639 = 98%, 652 KB/s], Decompressed: 958Downloaded: 8638 file(s) [attempted 8638/8639 = 99%, 634 KB/s], Decompressed: 958Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 634 KB/s], Decompressed: 958
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (436ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.2s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.4s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.4s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (8.2s)
✔ [8661/8670] Built TateCurvesTheta.AnalyticQuotient (8.1s)
✔ [8662/8675] Built Iut.Cor312.ThetaData.Places (6.9s)
✔ [8663/8675] Built TateCurvesTheta.QParameter.BaseChange (3.1s)
✔ [8664/8675] Built TateCurvesTheta.Analysis.Strassmann (4.8s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.6s)
✔ [8666/8678] Built TateCurvesTheta.QParameter.PrimeToOrder (2.7s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (4.9s)
✔ [8668/8684] Built TateCurvesTheta.QParameter.NormalizedOrder (4.0s)
✔ [8669/8685] Built TateCurvesTheta.TateCurve.Discriminant (5.6s)
✔ [8670/8689] Built TateCurvesTheta.TateCurve.Parametrization (4.1s)
✔ [8671/8689] Built TateCurvesTheta.Theta.Basic (3.5s)
✔ [8672/8689] Built TateCurvesTheta.TateCurve.SplitReduction (4.6s)
✔ [8673/8689] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.JInvariant (3.2s)
✔ [8675/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.3s)
✔ [8676/8693] Built TateCurvesTheta.Theta.Periodicity (2.8s)
✔ [8677/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (3.5s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (5.9s)
✔ [8679/8696] Built TateCurvesTheta.Theta.Product (5.7s)
✔ [8680/8696] Built TateCurvesTheta.QParameter.JParametrization (9.7s)
✔ [8681/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (8.8s)
✔ [8682/8696] Built TateCurvesTheta.Theta.Divisor (5.6s)
✔ [8683/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (9.8s)
✔ [8684/8699] Built TateCurvesTheta.Theta.Uniqueness (7.1s)
✔ [8685/8699] Built TateCurvesTheta.QParameter.Characterization (3.8s)
✔ [8686/8699] Built TateCurvesTheta.TateCurve.EisensteinSeries (12s)
✔ [8687/8704] Built TateCurvesTheta.Theta.FactorSeries (6.1s)
✔ [8688/8705] Built TateCurvesTheta.Theta.LaurentSphere (4.3s)
✔ [8689/8705] Built TateCurvesTheta.TateCurve.TatePointMem (3.5s)
✔ [8690/8708] Built TateCurvesTheta.Theta.QBinomial (4.5s)
✔ [8691/8711] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.3s)
✔ [8692/8712] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.6s)
✔ [8693/8713] Built TateCurvesTheta.TateCurve.CoordinateInversion (3.8s)
✔ [8694/8713] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.6s)
✔ [8695/8715] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.7s)
✔ [8696/8715] Built TateCurvesTheta.TateCurve.IntegralModel (5.2s)
✔ [8697/8715] Built TateCurvesTheta.TateCurve.Quotient (7.0s)
✔ [8698/8717] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (5.1s)
✔ [8699/8717] Built TateCurvesTheta.TateCurve.SphereBounds (7.2s)
✔ [8700/8719] Built TateCurvesTheta.Theta.Normalization (5.5s)
✔ [8701/8719] Built TateCurvesTheta.Theta.FactorReciprocal (5.9s)
✔ [8702/8721] Built TateCurvesTheta.Theta.Durfee (5.8s)
✔ [8703/8721] Built TateCurvesTheta.TateCurve.PointMap (10s)
✔ [8704/8721] Built TateCurvesTheta.Theta.RatioAnnulus (3.4s)
✔ [8705/8721] Built TateCurvesTheta.Theta.LaurentUnique (3.8s)
✔ [8706/8721] Built TateCurvesTheta.Theta.Inversion (4.0s)
✔ [8707/8729] Built TateCurvesTheta.Theta.SeriesZero (5.5s)
✔ [8708/8729] Built TateCurvesTheta.Theta.WeightSpace (15s)
✔ [8709/8729] Built TateCurvesTheta.Theta.StrictDominant (11s)
✔ [8710/8731] Built TateCurvesTheta.Theta.TripleProduct (5.5s)
✔ [8711/8733] Built Iut.Cor312.Procession (8.6s)
✔ [8712/8733] Built TateCurvesTheta.Uniformization (11s)
✔ [8713/8765] Built Iut.Cor312.RationalPlace (8.1s)
✔ [8714/8765] Built Iut.Cor312.PacketPresentation (7.5s)
✔ [8715/8765] Built IUTThreeClosures.ABCStatement (2.5s)
⚠ [8716/8765] Built IUTThreeClosures.HonestFinitePositiveLogVolume (7.3s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8717/8786] Built TateCurvesTheta.Theta.PuncturedProduct (45s)
✔ [8719/8786] Built IUTThreeClosures.FullPolyCore (6.6s)
⚠ [8720/8786] Built IUTThreeClosures.Cor312CoefficientAlgebra (6.0s)
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
✔ [8721/8786] Built Iut.Cor312.Container (6.3s)
✔ [8722/8786] Built Iut.Cor312.HolomorphicHull (5.9s)
⚠ [8723/8786] Built IUTThreeClosures.HonestPilotWitness (6.1s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8724/8786] Built Heights.WeilHeight (8.9s)
⚠ [8725/8786] Built IUTThreeClosures.ExplicitSemistableCurve (6.0s)
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
⚠ [8727/8786] Built IUTThreeClosures.RootQPilotDivisor (6.3s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8728/8786] Built IUTThreeClosures.QPilotNormalizationAudit (6.7s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8786] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.7s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8730/8786] Built TateCurvesTheta.TateCurve.DefectVanishing (88s)
⚠ [8731/8786] Built IUTThreeClosures.RamificationCorrectedQPilot (6.0s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8733/8786] Built IUTThreeClosures.ProductWeightMarginalization (7.8s)
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
⚠ [8734/8786] Built IUTThreeClosures.AdmissiblePrimeSelection (6.2s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8735/8786] Built IUTThreeClosures.FiniteExceptionalSet (6.5s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8736/8786] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.0s)
⚠ [8737/8786] Built IUTThreeClosures.GeneratedUnionCompactness (5.8s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8738/8786] Built Iut.Cor312.LogVolume (6.4s)
✔ [8739/8786] Built Iut.Cor312.ContainerHull (5.9s)
⚠ [8741/8801] Built IUTThreeClosures.HonestGeneratedSource (6.2s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8742/8801] Built IUTThreeClosures.ZModSL2Perfect (5.0s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8743/8801] Built Genl.Mathlib.Order.BoundedDiscrepancy (3.1s)
⚠ [8744/8801] Built IUTThreeClosures.QPilotNormalizationFork (7.2s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8745/8801] Built TateCurvesTheta.TateCurve.TatePointOnCurve (6.0s)
⚠ [8746/8801] Built IUTThreeClosures.TateParameterUnitBallRegion (2.0s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8747/8801] Built IUTThreeClosures.PrimePowerQPilotRegion (7.2s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8748/8801] Built IUTThreeClosures.FiniteExponentHull (5.9s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8801] Built IUTThreeClosures.StandardZeroLabel (6.0s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8801] Built IUTThreeClosures.DiagonalPacketNoGo (5.6s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8751/8801] Built IUTThreeClosures.BarycentricPacketReading (6.0s)
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
⚠ [8753/8801] Built IUTThreeClosures.PublicNormalizationObstruction (6.4s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8754/8801] Built Iut4Sec1.Global.ArithmeticDivisor (6.2s)
⚠ [8755/8801] Built IUTThreeClosures.IUTIVAbsorption (8.8s)
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
✔ [8756/8801] Built TateCurvesTheta.TateCurve.AdditionLaw (10s)
✔ [8757/8801] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (8.9s)
⚠ [8758/8801] Built IUTThreeClosures.DistinguishedLabelQPilot (8.9s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8759/8801] Built TateCurvesTheta.TateCurve.LargePointParametrization (14s)
⚠ [8760/8801] Built IUTThreeClosures.ZeroLabelBarycentric (7.7s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
⚠ [8761/8801] Built IUTThreeClosures.StatementIIOutsideFinite (6.2s)
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
✔ [8762/8801] Built TateCurvesTheta.TateCurve.AbelStep (7.2s)
✔ [8763/8801] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8764/8801] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (20s)
✔ [8765/8801] Built TateCurvesTheta.TateCurve.SurjectivitySphere (23s)
✔ [8766/8801] Built TateCurvesTheta.TateCurve.TateUniformization (4.2s)
✔ [8767/8801] Built TateCurvesTheta (3.6s)
✔ [8768/8801] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.6s)
✔ [8769/8801] Built Iut.Cor312.ThetaData.Orbicurve (4.5s)
✔ [8770/8801] Built Iut.Cor312.ThetaData.LocalConditions (7.6s)
✔ [8771/8801] Built Iut.Cor312.ThetaData.Basic (4.6s)
✔ [8772/8801] Built Iut.Cor312.LeftHandSide (4.2s)
✔ [8773/8801] Built Iut.Cor312.RightHandSide (4.4s)
✔ [8774/8801] Built Iut.Cor312.Statement (4.1s)
⚠ [8775/8801] Built IUTThreeClosures.NativeQPilotCalibration (5.7s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8776/8801] Built IUTThreeClosures.CorrectedQPilotDivisor (5.8s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8777/8801] Built IUTThreeClosures.ActualPilotWitness (4.2s)
✔ [8778/8801] Built IUTThreeClosures.GeneratedSource (4.6s)
✔ [8779/8801] Built IUTThreeClosures.QuantifierCorrectClosure (3.0s)
✔ [8780/8801] Built IUTThreeClosures.ABCClosure (4.2s)
⚠ [8781/8801] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.5s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8782/8801] Built IUTThreeClosures.ThreeClosureTheorems (3.9s)
✔ [8783/8801] Built IUTThreeClosures.InhabitationBoundary (4.1s)
✔ [8784/8801] Built IUTThreeClosures.CircularityAudit (4.2s)
✔ [8785/8801] Built IUTThreeClosures.NonCircularDownstream (5.4s)
✔ [8786/8801] Built IUTThreeClosures.FourOpenConstructions (4.4s)
⚠ [8787/8801] Built IUTThreeClosures.ABCPointLegendreCurve (4.9s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8788/8801] Built IUTThreeClosures.BridgeInhabitationAudit (5.1s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8789/8801] Built IUTThreeClosures.PublicProgramUninhabited (6.2s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8790/8801] Built IUTThreeClosures.LegendreArithmetic (6.5s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8791/8801] Built IUTThreeClosures.BridgeInhabitationExact (5.8s)
⚠ [8792/8801] Built IUTThreeClosures.TripodWeilHeight (4.0s)
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
⚠ [8794/8801] Built IUTThreeClosures.CanonicalQPilotCorridor (4.8s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8795/8801] Built IUTThreeClosures.LegendreHeightCorridor (4.0s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8796/8801] Built IUTThreeClosures.CanonicalCorridorAudit (5.9s)
⚠ [8797/8801] Built IUTThreeClosures.FreyJReducedData (4.9s)
warning: IUTThreeClosures/FreyJReducedData.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8798/8801] Built IUTThreeClosures.SourceDerivedIUTIVBridge (6.9s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✖ [8799/8801] Building IUTThreeClosures.FreyJHeightCorridor (4.9s)
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
