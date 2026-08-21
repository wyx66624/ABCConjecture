# Lean CI result

- Tested commit: `1a511077ab3744dcf25a25f44bd6c3b6c6892e5d`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
538:✖ [8799/8801] Building IUTThreeClosures.FreyJHeightCorridor (4.1s)
551:error: IUTThreeClosures/FreyJHeightCorridor.lean:77:2: mod_cast has type
555:error: IUTThreeClosures/FreyJHeightCorridor.lean:111:2: linarith failed to find a contradiction
567:error: IUTThreeClosures/FreyJHeightCorridor.lean:135:2: linarith failed to find a contradiction
579:error: Lean exited with code 1
580:Some required targets logged failures:
582:error: build failed
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
✔ [2/6] Built Cache.Cli (373ms)
✔ [3/6] Built Cache.Lean (406ms)
✔ [8/27] Built Cache.Cli:c.o (234ms)
✔ [9/27] Built Cache.Lean:c.o (280ms)
✔ [11/27] Built Cache.Infra (479ms)
✔ [12/27] Built Cache.Infra:c.o (233ms)
✔ [13/27] Built Cache.IO (1.5s)
✔ [14/27] Built Cache.Hashing (820ms)
✔ [15/27] Built Cache.Hashing:c.o (451ms)
✔ [16/27] Built Cache.IO:c.o (1.9s)
✔ [17/27] Built Cache.Requests (2.2s)
✔ [18/27] Built Cache.Marker (575ms)
✔ [19/27] Built Cache.Marker:c.o (140ms)
✔ [20/27] Built Cache.Query (773ms)
✔ [21/27] Built Cache.Query:c.o (462ms)
✔ [22/27] Built Cache.Warning (736ms)
✔ [23/27] Built Cache.Warning:c.o (288ms)
✔ [24/27] Built Cache.Requests:c.o (3.3s)
✔ [25/27] Built Cache.Main (1.8s)
✔ [26/27] Built Cache.Main:c.o (936ms)
✔ [27/27] Built cache:exe (703ms)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 16 KB/s], Decompressed: 0Downloaded: 131 file(s) [attempted 131/8639 = 1%, 2257 KB/s], Decompressed: 12Downloaded: 239 file(s) [attempted 239/8639 = 2%, 583 KB/s], Decompressed: 49Downloaded: 415 file(s) [attempted 415/8639 = 4%, 635 KB/s], Decompressed: 49Downloaded: 550 file(s) [attempted 550/8639 = 6%, 1374 KB/s], Decompressed: 49Downloaded: 695 file(s) [attempted 695/8639 = 8%, 1314 KB/s], Decompressed: 49Downloaded: 815 file(s) [attempted 815/8639 = 9%, 434 KB/s], Decompressed: 49Downloaded: 968 file(s) [attempted 968/8639 = 11%, 2790 KB/s], Decompressed: 49Downloaded: 1121 file(s) [attempted 1121/8639 = 12%, 1330 KB/s], Decompressed: 232Downloaded: 1272 file(s) [attempted 1272/8639 = 14%, 645 KB/s], Decompressed: 232Downloaded: 1435 file(s) [attempted 1435/8639 = 16%, 6514 KB/s], Decompressed: 232Downloaded: 1540 file(s) [attempted 1540/8639 = 17%, 3971 KB/s], Decompressed: 232Downloaded: 1692 file(s) [attempted 1692/8639 = 19%, 6501 KB/s], Decompressed: 232Downloaded: 1850 file(s) [attempted 1850/8639 = 21%, 1444 KB/s], Decompressed: 232Downloaded: 1997 file(s) [attempted 1997/8639 = 23%, 12389 KB/s], Decompressed: 232Downloaded: 2148 file(s) [attempted 2148/8639 = 24%, 92 KB/s], Decompressed: 232Downloaded: 2282 file(s) [attempted 2282/8639 = 26%, 1730 KB/s], Decompressed: 232Downloaded: 2419 file(s) [attempted 2419/8639 = 28%, 805 KB/s], Decompressed: 232Downloaded: 2568 file(s) [attempted 2568/8639 = 29%, 4263 KB/s], Decompressed: 232Downloaded: 2717 file(s) [attempted 2717/8639 = 31%, 74 KB/s], Decompressed: 232Downloaded: 2887 file(s) [attempted 2887/8639 = 33%, 7961 KB/s], Decompressed: 232Downloaded: 3036 file(s) [attempted 3036/8639 = 35%, 4375 KB/s], Decompressed: 232Downloaded: 3176 file(s) [attempted 3176/8639 = 36%, 2258 KB/s], Decompressed: 232Downloaded: 3316 file(s) [attempted 3316/8639 = 38%, 2204 KB/s], Decompressed: 232Downloaded: 3446 file(s) [attempted 3446/8639 = 39%, 3166 KB/s], Decompressed: 232Downloaded: 3622 file(s) [attempted 3622/8639 = 41%, 1437 KB/s], Decompressed: 232Downloaded: 3759 file(s) [attempted 3759/8639 = 43%, 423 KB/s], Decompressed: 232Downloaded: 3915 file(s) [attempted 3915/8639 = 45%, 1838 KB/s], Decompressed: 232Downloaded: 4061 file(s) [attempted 4061/8639 = 47%, 1930 KB/s], Decompressed: 232Downloaded: 4165 file(s) [attempted 4165/8639 = 48%, 85 KB/s], Decompressed: 232Downloaded: 4321 file(s) [attempted 4321/8639 = 50%, 1600 KB/s], Decompressed: 232Downloaded: 4464 file(s) [attempted 4464/8639 = 51%, 751 KB/s], Decompressed: 232Downloaded: 4572 file(s) [attempted 4572/8639 = 52%, 1040 KB/s], Decompressed: 232Downloaded: 4729 file(s) [attempted 4729/8639 = 54%, 1348 KB/s], Decompressed: 232Downloaded: 4882 file(s) [attempted 4882/8639 = 56%, 466 KB/s], Decompressed: 232Downloaded: 5034 file(s) [attempted 5034/8639 = 58%, 3267 KB/s], Decompressed: 232Downloaded: 5199 file(s) [attempted 5199/8639 = 60%, 534 KB/s], Decompressed: 1121Downloaded: 5349 file(s) [attempted 5349/8639 = 61%, 226 KB/s], Decompressed: 1121Downloaded: 5532 file(s) [attempted 5532/8639 = 64%, 1377 KB/s], Decompressed: 1121Downloaded: 5670 file(s) [attempted 5670/8639 = 65%, 2139 KB/s], Decompressed: 1121Downloaded: 5822 file(s) [attempted 5822/8639 = 67%, 993 KB/s], Decompressed: 1121Downloaded: 5980 file(s) [attempted 5980/8639 = 69%, 2913 KB/s], Decompressed: 1121Downloaded: 6129 file(s) [attempted 6129/8639 = 70%, 1497 KB/s], Decompressed: 1121Downloaded: 6283 file(s) [attempted 6283/8639 = 72%, 8129 KB/s], Decompressed: 1121Downloaded: 6437 file(s) [attempted 6437/8639 = 74%, 540 KB/s], Decompressed: 1121Downloaded: 6589 file(s) [attempted 6589/8639 = 76%, 5313 KB/s], Decompressed: 1121Downloaded: 6745 file(s) [attempted 6745/8639 = 78%, 3236 KB/s], Decompressed: 1121Downloaded: 6903 file(s) [attempted 6903/8639 = 79%, 3324 KB/s], Decompressed: 1121Downloaded: 7055 file(s) [attempted 7055/8639 = 81%, 4854 KB/s], Decompressed: 1121Downloaded: 7171 file(s) [attempted 7171/8639 = 83%, 6658 KB/s], Decompressed: 1121Downloaded: 7325 file(s) [attempted 7325/8639 = 84%, 284 KB/s], Decompressed: 1121Downloaded: 7474 file(s) [attempted 7474/8639 = 86%, 10505 KB/s], Decompressed: 1121Downloaded: 7600 file(s) [attempted 7600/8639 = 87%, 6868 KB/s], Decompressed: 1121Downloaded: 7718 file(s) [attempted 7718/8639 = 89%, 325 KB/s], Decompressed: 1121Downloaded: 7868 file(s) [attempted 7868/8639 = 91%, 1036 KB/s], Decompressed: 1121Downloaded: 8010 file(s) [attempted 8010/8639 = 92%, 782 KB/s], Decompressed: 1121Downloaded: 8150 file(s) [attempted 8150/8639 = 94%, 448 KB/s], Decompressed: 1121Downloaded: 8325 file(s) [attempted 8325/8639 = 96%, 702 KB/s], Decompressed: 1121Downloaded: 8379 file(s) [attempted 8379/8639 = 96%, 185 KB/s], Decompressed: 1121Downloaded: 8530 file(s) [attempted 8530/8639 = 98%, 1152 KB/s], Decompressed: 1121Downloaded: 8637 file(s) [attempted 8637/8639 = 99%, 1544 KB/s], Decompressed: 1121Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 1544 KB/s], Decompressed: 1121
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (464ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.3s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.6s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.3s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (8.5s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (8.0s)
✔ [8662/8675] Built Iut.Cor312.ThetaData.Places (7.3s)
✔ [8663/8675] Built TateCurvesTheta.Analysis.Strassmann (4.6s)
✔ [8664/8675] Built TateCurvesTheta.QParameter.BaseChange (3.4s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (4.0s)
✔ [8666/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (2.5s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (6.0s)
✔ [8668/8684] Built TateCurvesTheta.QParameter.NormalizedOrder (4.3s)
✔ [8669/8689] Built TateCurvesTheta.TateCurve.Discriminant (5.6s)
✔ [8670/8689] Built TateCurvesTheta.Theta.Basic (3.9s)
✔ [8671/8691] Built TateCurvesTheta.TateCurve.Parametrization (4.3s)
✔ [8672/8691] Built TateCurvesTheta.TateCurve.SplitReduction (4.5s)
✔ [8673/8691] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8674/8693] Built TateCurvesTheta.TateCurve.JInvariant (3.3s)
✔ [8675/8693] Built TateCurvesTheta.Theta.Periodicity (3.2s)
✔ [8676/8696] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (2.9s)
✔ [8677/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (3.8s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (4.2s)
✔ [8679/8696] Built TateCurvesTheta.Theta.Product (5.3s)
✔ [8680/8696] Built TateCurvesTheta.QParameter.JParametrization (11s)
✔ [8681/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (9.0s)
✔ [8682/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (9.2s)
✔ [8683/8699] Built TateCurvesTheta.Theta.Uniqueness (5.2s)
✔ [8684/8699] Built TateCurvesTheta.Theta.Divisor (5.8s)
✔ [8685/8702] Built TateCurvesTheta.Theta.FactorSeries (7.3s)
✔ [8686/8704] Built TateCurvesTheta.QParameter.Characterization (3.8s)
✔ [8687/8704] Built TateCurvesTheta.TateCurve.EisensteinSeries (16s)
✔ [8688/8705] Built TateCurvesTheta.Theta.LaurentSphere (5.1s)
✔ [8689/8705] Built TateCurvesTheta.TateCurve.TatePointMem (3.4s)
✔ [8690/8708] Built TateCurvesTheta.Theta.ThetaProdLaurent (4.9s)
✔ [8691/8708] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.9s)
✔ [8692/8708] Built TateCurvesTheta.Theta.QBinomial (5.0s)
✔ [8693/8712] Built TateCurvesTheta.TateCurve.CoordinateInversion (4.0s)
✔ [8694/8713] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.3s)
✔ [8695/8714] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.4s)
✔ [8696/8715] Built TateCurvesTheta.TateCurve.Quotient (7.5s)
✔ [8697/8715] Built TateCurvesTheta.TateCurve.IntegralModel (5.9s)
✔ [8698/8716] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (4.6s)
✔ [8699/8717] Built TateCurvesTheta.TateCurve.SphereBounds (6.6s)
✔ [8700/8718] Built TateCurvesTheta.Theta.Normalization (4.3s)
✔ [8701/8719] Built TateCurvesTheta.Theta.FactorReciprocal (4.6s)
✔ [8702/8720] Built TateCurvesTheta.TateCurve.PointMap (10s)
✔ [8703/8721] Built TateCurvesTheta.Theta.Durfee (7.4s)
✔ [8704/8722] Built TateCurvesTheta.Theta.LaurentUnique (6.1s)
✔ [8705/8722] Built TateCurvesTheta.Theta.SeriesZero (3.5s)
✔ [8706/8722] Built TateCurvesTheta.Theta.RatioAnnulus (4.0s)
✔ [8707/8729] Built TateCurvesTheta.Theta.Inversion (3.7s)
✔ [8708/8729] Built TateCurvesTheta.Theta.StrictDominant (13s)
✔ [8709/8729] Built TateCurvesTheta.Theta.WeightSpace (18s)
✔ [8710/8731] Built TateCurvesTheta.Theta.TripleProduct (5.4s)
✔ [8711/8733] Built TateCurvesTheta.Uniformization (10s)
✔ [8712/8735] Built Iut.Cor312.Procession (8.8s)
✔ [8713/8765] Built Iut.Cor312.RationalPlace (8.2s)
✔ [8714/8765] Built Iut.Cor312.PacketPresentation (8.4s)
✔ [8715/8765] Built IUTThreeClosures.ABCStatement (3.1s)
⚠ [8716/8765] Built IUTThreeClosures.HonestFinitePositiveLogVolume (7.0s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8717/8786] Built IUTThreeClosures.FullPolyCore (7.2s)
✔ [8719/8786] Built TateCurvesTheta.Theta.PuncturedProduct (47s)
⚠ [8720/8786] Built IUTThreeClosures.Cor312CoefficientAlgebra (6.2s)
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
✔ [8721/8786] Built Iut.Cor312.Container (6.1s)
✔ [8722/8786] Built Iut.Cor312.HolomorphicHull (6.1s)
⚠ [8723/8786] Built IUTThreeClosures.HonestPilotWitness (5.0s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8724/8786] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.7s)
✔ [8725/8786] Built Heights.WeilHeight (8.7s)
⚠ [8726/8786] Built IUTThreeClosures.ExplicitSemistableCurve (6.3s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8727/8786] Built IUTThreeClosures.SolvableRestrictionImage (7.0s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8786] Built IUTThreeClosures.QPilotNormalizationAudit (6.3s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8786] Built IUTThreeClosures.RootQPilotDivisor (6.3s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8730/8786] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (5.9s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8786] Built IUTThreeClosures.RamificationCorrectedQPilot (6.5s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8786] Built IUTThreeClosures.ProductWeightMarginalization (7.9s)
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
⚠ [8734/8786] Built IUTThreeClosures.AdmissiblePrimeSelection (5.9s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8735/8786] Built IUTThreeClosures.FiniteExceptionalSet (5.7s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8736/8786] Built IUTThreeClosures.GeneratedUnionCompactness (5.9s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8737/8786] Built Iut.Cor312.LogVolume (6.2s)
✔ [8738/8786] Built TateCurvesTheta.TateCurve.DefectVanishing (100s)
✔ [8739/8797] Built Iut.Cor312.ContainerHull (5.0s)
⚠ [8741/8801] Built IUTThreeClosures.HonestGeneratedSource (5.0s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8742/8801] Built IUTThreeClosures.ZModSL2Perfect (5.7s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8743/8801] Built IUTThreeClosures.QPilotNormalizationFork (5.8s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8744/8801] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.8s)
⚠ [8745/8801] Built IUTThreeClosures.PrimePowerQPilotRegion (7.1s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8746/8801] Built IUTThreeClosures.TateParameterUnitBallRegion (3.8s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8747/8801] Built TateCurvesTheta.TateCurve.TatePointOnCurve (7.3s)
⚠ [8748/8801] Built IUTThreeClosures.FiniteExponentHull (5.8s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8801] Built IUTThreeClosures.StandardZeroLabel (5.8s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8801] Built IUTThreeClosures.BarycentricPacketReading (5.9s)
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
⚠ [8751/8801] Built IUTThreeClosures.DiagonalPacketNoGo (5.5s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8752/8801] Built Genl.GeneralPosition.HeightTheory (1.8s)
✔ [8753/8801] Built Iut4Sec1.Global.ArithmeticDivisor (5.9s)
⚠ [8754/8801] Built IUTThreeClosures.PublicNormalizationObstruction (6.4s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8755/8801] Built IUTThreeClosures.IUTIVAbsorption (8.7s)
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
⚠ [8756/8801] Built IUTThreeClosures.DistinguishedLabelQPilot (6.1s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8757/8801] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (9.2s)
✔ [8758/8801] Built TateCurvesTheta.TateCurve.AdditionLaw (11s)
⚠ [8759/8801] Built IUTThreeClosures.ZeroLabelBarycentric (9.3s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8760/8801] Built TateCurvesTheta.TateCurve.LargePointParametrization (15s)
⚠ [8761/8801] Built IUTThreeClosures.StatementIIOutsideFinite (6.3s)
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
✔ [8764/8801] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (22s)
✔ [8765/8801] Built TateCurvesTheta.TateCurve.SurjectivitySphere (26s)
✔ [8766/8801] Built TateCurvesTheta.TateCurve.TateUniformization (3.9s)
✔ [8767/8801] Built TateCurvesTheta (3.2s)
✔ [8768/8801] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.4s)
✔ [8769/8801] Built Iut.Cor312.ThetaData.Orbicurve (4.2s)
✔ [8770/8801] Built Iut.Cor312.ThetaData.LocalConditions (7.3s)
✔ [8771/8801] Built Iut.Cor312.ThetaData.Basic (4.2s)
✔ [8772/8801] Built Iut.Cor312.LeftHandSide (3.8s)
✔ [8773/8801] Built Iut.Cor312.RightHandSide (3.9s)
⚠ [8774/8801] Built IUTThreeClosures.CorrectedQPilotDivisor (4.7s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8775/8801] Built Iut.Cor312.Statement (4.7s)
⚠ [8776/8801] Built IUTThreeClosures.NativeQPilotCalibration (5.2s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8777/8801] Built IUTThreeClosures.ActualPilotWitness (3.7s)
✔ [8778/8801] Built IUTThreeClosures.GeneratedSource (4.1s)
✔ [8779/8801] Built IUTThreeClosures.QuantifierCorrectClosure (3.6s)
✔ [8780/8801] Built IUTThreeClosures.ABCClosure (3.8s)
⚠ [8781/8801] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.1s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8782/8801] Built IUTThreeClosures.ThreeClosureTheorems (3.6s)
✔ [8783/8801] Built IUTThreeClosures.InhabitationBoundary (3.7s)
✔ [8784/8801] Built IUTThreeClosures.CircularityAudit (3.8s)
✔ [8785/8801] Built IUTThreeClosures.NonCircularDownstream (4.8s)
✔ [8786/8801] Built IUTThreeClosures.FourOpenConstructions (3.9s)
⚠ [8787/8801] Built IUTThreeClosures.ABCPointLegendreCurve (4.3s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8788/8801] Built IUTThreeClosures.PublicProgramUninhabited (4.8s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8789/8801] Built IUTThreeClosures.BridgeInhabitationAudit (4.9s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8790/8801] Built IUTThreeClosures.LegendreArithmetic (5.0s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8791/8801] Built IUTThreeClosures.BridgeInhabitationExact (4.1s)
⚠ [8792/8801] Built IUTThreeClosures.TripodWeilHeight (5.6s)
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
⚠ [8795/8801] Built IUTThreeClosures.LegendreHeightCorridor (5.1s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8796/8801] Built IUTThreeClosures.CanonicalCorridorAudit (4.2s)
⚠ [8797/8801] Built IUTThreeClosures.SourceDerivedIUTIVBridge (5.9s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8798/8801] Built IUTThreeClosures.FreyJReducedData (3.9s)
warning: IUTThreeClosures/FreyJReducedData.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8799/8801] Building IUTThreeClosures.FreyJHeightCorridor (4.1s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/FreyJHeightCorridor.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FreyJHeightCorridor.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FreyJHeightCorridor.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FreyJHeightCorridor.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FreyJHeightCorridor.setup.json --json
warning: IUTThreeClosures/FreyJHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/FreyJHeightCorridor.lean:48:26: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/FreyJHeightCorridor.lean:48:26: 'ring' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
error: IUTThreeClosures/FreyJHeightCorridor.lean:77:2: mod_cast has type
  (↑(NNRat.divNat P.freyJReducedNum P.freyJReducedDen)).den = P.freyJReducedDen
but is expected to have type
  (↑P.freyJReducedNum / ↑P.freyJReducedDen).den = P.freyJReducedDen
error: IUTThreeClosures/FreyJHeightCorridor.lean:111:2: linarith failed to find a contradiction
P : ABCPoint
M : ℕ := max P.freyJReducedNum P.freyJReducedDen
hM : 0 < M
hnat : P.c ^ 6 ≤ 8 * M
hcR : 0 < ↑P.c
hMR : 0 < ↑M
hreal : ↑P.c ^ 6 ≤ 8 * ↑M
hlog : 6 * Real.log ↑P.c ≤ Real.log 8 + Real.log ↑M
a✝ : Real.log (max ↑P.freyJReducedNum ↑P.freyJReducedDen) / 6 + Real.log 8 / 6 < Real.log ↑P.c
⊢ False
failed
error: IUTThreeClosures/FreyJHeightCorridor.lean:135:2: linarith failed to find a contradiction
P : ABCPoint
M : ℕ := max P.freyJReducedNum P.freyJReducedDen
hM : 0 < M
hnat : M ≤ 256 * P.c ^ 6
hMR : 0 < ↑M
hcR : 0 < ↑P.c
hreal : ↑M ≤ 256 * ↑P.c ^ 6
hlog : Real.log ↑M ≤ Real.log 256 + 6 * Real.log ↑P.c
a✝ : Real.log ↑P.c + Real.log 256 / 6 < Real.log (max ↑P.freyJReducedNum ↑P.freyJReducedDen) / 6
⊢ False
failed
error: Lean exited with code 1
Some required targets logged failures:
- IUTThreeClosures.FreyJHeightCorridor
error: build failed
```
