# Lean CI result

- Tested commit: `82c89e04b5f1f8da307852e1d751f1c1ae37f2d4`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
434:✖ [8780/8800] Building IUTThreeClosures.PublicLogVolumeInconsistency (3.9s)
441:error: IUTThreeClosures/PublicLogVolumeInconsistency.lean:122:4: omega could not prove the goal:
448:error: Lean exited with code 1
530:✖ [8796/8800] Building IUTThreeClosures.LegendreJHeight (4.1s)
537:error: IUTThreeClosures/LegendreJHeight.lean:38:2: failed to prove strict positivity, but it would be possible to prove nonnegativity if desired
538:error: Lean exited with code 1
544:Some required targets logged failures:
547:error: build failed
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
✔ [2/6] Built Cache.Cli (372ms)
✔ [3/6] Built Cache.Lean (422ms)
✔ [8/27] Built Cache.Cli:c.o (186ms)
✔ [10/27] Built Cache.Lean:c.o (229ms)
✔ [11/27] Built Cache.Infra (483ms)
✔ [12/27] Built Cache.Infra:c.o (201ms)
✔ [13/27] Built Cache.IO (1.5s)
✔ [14/27] Built Cache.Hashing (825ms)
✔ [15/27] Built Cache.Hashing:c.o (468ms)
✔ [16/27] Built Cache.IO:c.o (1.7s)
✔ [17/27] Built Cache.Requests (1.0s)
✔ [18/27] Built Cache.Marker (598ms)
✔ [19/27] Built Cache.Marker:c.o (125ms)
✔ [20/27] Built Cache.Query (774ms)
✔ [21/27] Built Cache.Query:c.o (295ms)
✔ [22/27] Built Cache.Warning (785ms)
✔ [23/27] Built Cache.Warning:c.o (351ms)
✔ [24/27] Built Cache.Requests:c.o (2.9s)
✔ [25/27] Built Cache.Main (1.5s)
✔ [26/27] Built Cache.Main:c.o (856ms)
✔ [27/27] Built cache:exe (717ms)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 16 KB/s], Decompressed: 0Downloaded: 89 file(s) [attempted 89/8639 = 1%, 1845 KB/s], Decompressed: 7Downloaded: 215 file(s) [attempted 215/8639 = 2%, 2128 KB/s], Decompressed: 33Downloaded: 300 file(s) [attempted 300/8639 = 3%, 1399 KB/s], Decompressed: 33Downloaded: 398 file(s) [attempted 398/8639 = 4%, 821 KB/s], Decompressed: 33Downloaded: 529 file(s) [attempted 529/8639 = 6%, 1166 KB/s], Decompressed: 124Downloaded: 657 file(s) [attempted 657/8639 = 7%, 1042 KB/s], Decompressed: 124Downloaded: 719 file(s) [attempted 719/8639 = 8%, 1919 KB/s], Decompressed: 124Downloaded: 816 file(s) [attempted 816/8639 = 9%, 2517 KB/s], Decompressed: 124Downloaded: 923 file(s) [attempted 923/8639 = 10%, 3754 KB/s], Decompressed: 124Downloaded: 1054 file(s) [attempted 1054/8639 = 12%, 109 KB/s], Decompressed: 124Downloaded: 1191 file(s) [attempted 1191/8639 = 13%, 164 KB/s], Decompressed: 124Downloaded: 1334 file(s) [attempted 1334/8639 = 15%, 172 KB/s], Decompressed: 124Downloaded: 1455 file(s) [attempted 1455/8639 = 16%, 1682 KB/s], Decompressed: 124Downloaded: 1565 file(s) [attempted 1565/8639 = 18%, 2235 KB/s], Decompressed: 124Downloaded: 1686 file(s) [attempted 1686/8639 = 19%, 426 KB/s], Decompressed: 124Downloaded: 1812 file(s) [attempted 1812/8639 = 20%, 482 KB/s], Decompressed: 124Downloaded: 1942 file(s) [attempted 1942/8639 = 22%, 3640 KB/s], Decompressed: 124Downloaded: 2081 file(s) [attempted 2081/8639 = 24%, 1030 KB/s], Decompressed: 124Downloaded: 2201 file(s) [attempted 2201/8639 = 25%, 866 KB/s], Decompressed: 124Downloaded: 2339 file(s) [attempted 2339/8639 = 27%, 1127 KB/s], Decompressed: 479Downloaded: 2474 file(s) [attempted 2474/8639 = 28%, 2432 KB/s], Decompressed: 479Downloaded: 2595 file(s) [attempted 2595/8639 = 30%, 384 KB/s], Decompressed: 479Downloaded: 2712 file(s) [attempted 2712/8639 = 31%, 681 KB/s], Decompressed: 479Downloaded: 2862 file(s) [attempted 2862/8639 = 33%, 2559 KB/s], Decompressed: 479Downloaded: 2978 file(s) [attempted 2978/8639 = 34%, 116 KB/s], Decompressed: 479Downloaded: 3109 file(s) [attempted 3109/8639 = 35%, 521 KB/s], Decompressed: 479Downloaded: 3227 file(s) [attempted 3227/8639 = 37%, 671 KB/s], Decompressed: 479Downloaded: 3346 file(s) [attempted 3346/8639 = 38%, 1733 KB/s], Decompressed: 479Downloaded: 3479 file(s) [attempted 3479/8639 = 40%, 1849 KB/s], Decompressed: 479Downloaded: 3610 file(s) [attempted 3610/8639 = 41%, 2934 KB/s], Decompressed: 479Downloaded: 3755 file(s) [attempted 3755/8639 = 43%, 826 KB/s], Decompressed: 479Downloaded: 3864 file(s) [attempted 3864/8639 = 44%, 1649 KB/s], Decompressed: 479Downloaded: 3948 file(s) [attempted 3948/8639 = 45%, 4561 KB/s], Decompressed: 479Downloaded: 4089 file(s) [attempted 4089/8639 = 47%, 461 KB/s], Decompressed: 479Downloaded: 4193 file(s) [attempted 4193/8639 = 48%, 130 KB/s], Decompressed: 479Downloaded: 4310 file(s) [attempted 4310/8639 = 49%, 3887 KB/s], Decompressed: 479Downloaded: 4445 file(s) [attempted 4445/8639 = 51%, 1748 KB/s], Decompressed: 479Downloaded: 4599 file(s) [attempted 4599/8639 = 53%, 147 KB/s], Decompressed: 479Downloaded: 4720 file(s) [attempted 4720/8639 = 54%, 1348 KB/s], Decompressed: 479Downloaded: 4829 file(s) [attempted 4829/8639 = 55%, 510 KB/s], Decompressed: 479Downloaded: 4832 file(s) [attempted 4832/8639 = 55%, 1487 KB/s], Decompressed: 479Downloaded: 4981 file(s) [attempted 4981/8639 = 57%, 402 KB/s], Decompressed: 479Downloaded: 5135 file(s) [attempted 5135/8639 = 59%, 2800 KB/s], Decompressed: 479Downloaded: 5280 file(s) [attempted 5280/8639 = 61%, 4032 KB/s], Decompressed: 479Downloaded: 5431 file(s) [attempted 5431/8639 = 62%, 680 KB/s], Decompressed: 479Downloaded: 5578 file(s) [attempted 5578/8639 = 64%, 742 KB/s], Decompressed: 479Downloaded: 5735 file(s) [attempted 5735/8639 = 66%, 1220 KB/s], Decompressed: 479Downloaded: 5875 file(s) [attempted 5875/8639 = 68%, 3831 KB/s], Decompressed: 479Downloaded: 6026 file(s) [attempted 6026/8639 = 69%, 2882 KB/s], Decompressed: 479Downloaded: 6182 file(s) [attempted 6182/8639 = 71%, 160 KB/s], Decompressed: 479Downloaded: 6332 file(s) [attempted 6332/8639 = 73%, 1338 KB/s], Decompressed: 479Downloaded: 6472 file(s) [attempted 6472/8639 = 74%, 1806 KB/s], Decompressed: 479Downloaded: 6619 file(s) [attempted 6619/8639 = 76%, 1291 KB/s], Decompressed: 479Downloaded: 6772 file(s) [attempted 6772/8639 = 78%, 2070 KB/s], Decompressed: 479Downloaded: 6903 file(s) [attempted 6903/8639 = 79%, 3172 KB/s], Decompressed: 479Downloaded: 7050 file(s) [attempted 7050/8639 = 81%, 798 KB/s], Decompressed: 479Downloaded: 7178 file(s) [attempted 7178/8639 = 83%, 5054 KB/s], Decompressed: 479Downloaded: 7251 file(s) [attempted 7251/8639 = 83%, 529 KB/s], Decompressed: 479Downloaded: 7377 file(s) [attempted 7377/8639 = 85%, 2346 KB/s], Decompressed: 479Downloaded: 7484 file(s) [attempted 7484/8639 = 86%, 348 KB/s], Decompressed: 479Downloaded: 7544 file(s) [attempted 7544/8639 = 87%, 774 KB/s], Decompressed: 479Downloaded: 7694 file(s) [attempted 7694/8639 = 89%, 521 KB/s], Decompressed: 479Downloaded: 7789 file(s) [attempted 7789/8639 = 90%, 604 KB/s], Decompressed: 479Downloaded: 7929 file(s) [attempted 7929/8639 = 91%, 1400 KB/s], Decompressed: 479Downloaded: 8037 file(s) [attempted 8037/8639 = 93%, 318 KB/s], Decompressed: 479Downloaded: 8163 file(s) [attempted 8163/8639 = 94%, 1589 KB/s], Decompressed: 479Downloaded: 8255 file(s) [attempted 8255/8639 = 95%, 786 KB/s], Decompressed: 479Downloaded: 8358 file(s) [attempted 8358/8639 = 96%, 147 KB/s], Decompressed: 479Downloaded: 8510 file(s) [attempted 8510/8639 = 98%, 395 KB/s], Decompressed: 479Downloaded: 8580 file(s) [attempted 8580/8639 = 99%, 2133 KB/s], Decompressed: 479Downloaded: 8638 file(s) [attempted 8638/8639 = 99%, 270 KB/s], Decompressed: 479Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 270 KB/s], Decompressed: 479
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (453ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.0s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.1s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.0s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (7.6s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (8.1s)
✔ [8662/8675] Built Iut.Cor312.ThetaData.Places (6.9s)
✔ [8663/8675] Built TateCurvesTheta.QParameter.BaseChange (3.4s)
✔ [8664/8675] Built TateCurvesTheta.Analysis.Strassmann (4.5s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.8s)
✔ [8666/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (2.6s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (4.0s)
✔ [8668/8684] Built TateCurvesTheta.QParameter.NormalizedOrder (4.2s)
✔ [8669/8689] Built TateCurvesTheta.TateCurve.Discriminant (5.0s)
✔ [8670/8689] Built TateCurvesTheta.TateCurve.Parametrization (4.2s)
✔ [8671/8689] Built TateCurvesTheta.Theta.Basic (3.4s)
✔ [8672/8689] Built TateCurvesTheta.TateCurve.SplitReduction (4.6s)
✔ [8673/8689] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.JInvariant (3.3s)
✔ [8675/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.3s)
✔ [8676/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (3.6s)
✔ [8677/8696] Built TateCurvesTheta.Theta.Periodicity (2.0s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (5.3s)
✔ [8679/8696] Built TateCurvesTheta.Theta.Product (5.8s)
✔ [8680/8696] Built TateCurvesTheta.QParameter.JParametrization (9.5s)
✔ [8681/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (8.2s)
✔ [8682/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (9.5s)
✔ [8683/8696] Built TateCurvesTheta.Theta.Divisor (5.6s)
✔ [8684/8696] Built TateCurvesTheta.Theta.Uniqueness (6.1s)
✔ [8685/8699] Built TateCurvesTheta.QParameter.Characterization (4.3s)
✔ [8686/8699] Built TateCurvesTheta.TateCurve.EisensteinSeries (12s)
✔ [8687/8704] Built TateCurvesTheta.Theta.FactorSeries (5.7s)
✔ [8688/8704] Built TateCurvesTheta.Theta.LaurentSphere (4.4s)
✔ [8689/8705] Built TateCurvesTheta.TateCurve.TatePointMem (3.2s)
✔ [8690/8708] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.9s)
✔ [8691/8708] Built TateCurvesTheta.Theta.QBinomial (4.4s)
✔ [8692/8708] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.1s)
✔ [8693/8712] Built TateCurvesTheta.TateCurve.CoordinateInversion (3.8s)
✔ [8694/8713] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.1s)
✔ [8695/8714] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.7s)
✔ [8696/8715] Built TateCurvesTheta.TateCurve.IntegralModel (5.6s)
✔ [8697/8715] Built TateCurvesTheta.TateCurve.Quotient (7.9s)
✔ [8698/8716] Built TateCurvesTheta.TateCurve.SphereBounds (6.4s)
✔ [8699/8716] Built TateCurvesTheta.Theta.Normalization (3.0s)
✔ [8700/8718] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.9s)
✔ [8701/8719] Built TateCurvesTheta.Theta.FactorReciprocal (4.4s)
✔ [8702/8720] Built TateCurvesTheta.Theta.Durfee (7.7s)
✔ [8703/8720] Built TateCurvesTheta.TateCurve.PointMap (10s)
✔ [8704/8720] Built TateCurvesTheta.Theta.LaurentUnique (5.8s)
✔ [8705/8720] Built TateCurvesTheta.Theta.RatioAnnulus (3.5s)
✔ [8706/8721] Built TateCurvesTheta.Theta.Inversion (3.9s)
✔ [8707/8722] Built TateCurvesTheta.Theta.SeriesZero (5.0s)
✔ [8708/8729] Built TateCurvesTheta.Theta.WeightSpace (14s)
✔ [8709/8729] Built TateCurvesTheta.Theta.TripleProduct (5.7s)
✔ [8710/8731] Built TateCurvesTheta.Theta.StrictDominant (11s)
✔ [8711/8733] Built TateCurvesTheta.Uniformization (9.6s)
✔ [8712/8735] Built Iut.Cor312.Procession (10s)
✔ [8713/8765] Built Iut.Cor312.RationalPlace (6.6s)
✔ [8714/8765] Built Iut.Cor312.PacketPresentation (7.7s)
✔ [8715/8765] Built IUTThreeClosures.ABCStatement (2.6s)
⚠ [8716/8765] Built IUTThreeClosures.HonestFinitePositiveLogVolume (6.5s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8717/8765] Built TateCurvesTheta.Theta.PuncturedProduct (44s)
✔ [8719/8765] Built IUTThreeClosures.FullPolyCore (6.7s)
⚠ [8720/8765] Built IUTThreeClosures.Cor312CoefficientAlgebra (6.5s)
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
✔ [8721/8785] Built Iut.Cor312.Container (5.9s)
✔ [8722/8785] Built Iut.Cor312.HolomorphicHull (6.2s)
⚠ [8723/8785] Built IUTThreeClosures.HonestPilotWitness (5.8s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8724/8785] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.7s)
✔ [8725/8785] Built Iut.Cor312.LogVolume (6.5s)
✔ [8726/8785] Built Heights.WeilHeight (8.0s)
⚠ [8727/8785] Built IUTThreeClosures.ExplicitSemistableCurve (6.8s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8785] Built IUTThreeClosures.SolvableRestrictionImage (6.2s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8785] Built IUTThreeClosures.QPilotNormalizationAudit (6.6s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8730/8785] Built IUTThreeClosures.RootQPilotDivisor (6.1s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8731/8785] Built TateCurvesTheta.TateCurve.DefectVanishing (85s)
⚠ [8732/8785] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.5s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8733/8785] Built IUTThreeClosures.RamificationCorrectedQPilot (6.5s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8734/8785] Built IUTThreeClosures.ProductWeightMarginalization (7.3s)
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
⚠ [8736/8785] Built IUTThreeClosures.GeneratedUnionCompactness (6.0s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8737/8785] Built IUTThreeClosures.AdmissiblePrimeSelection (6.2s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8738/8785] Built IUTThreeClosures.FiniteExceptionalSet (5.8s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8739/8785] Built Iut.Cor312.ContainerHull (5.7s)
⚠ [8740/8785] Built IUTThreeClosures.HonestGeneratedSource (6.1s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8742/8800] Built IUTThreeClosures.PrimePowerQPilotRegion (6.2s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8743/8800] Built IUTThreeClosures.ZModSL2Perfect (5.8s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8744/8800] Built IUTThreeClosures.QPilotNormalizationFork (6.5s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8745/8800] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.9s)
✔ [8746/8800] Built TateCurvesTheta.TateCurve.TatePointOnCurve (6.7s)
⚠ [8747/8800] Built IUTThreeClosures.DistinguishedLabelQPilot (6.4s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8748/8800] Built IUTThreeClosures.TateParameterUnitBallRegion (3.1s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8800] Built IUTThreeClosures.FiniteExponentHull (6.3s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8800] Built IUTThreeClosures.StandardZeroLabel (5.9s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8751/8800] Built IUTThreeClosures.BarycentricPacketReading (5.9s)
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
⚠ [8752/8800] Built IUTThreeClosures.DiagonalPacketNoGo (5.8s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8753/8800] Built Genl.GeneralPosition.HeightTheory (1.7s)
✔ [8754/8800] Built Iut4Sec1.Global.ArithmeticDivisor (5.0s)
⚠ [8755/8800] Built IUTThreeClosures.PublicNormalizationObstruction (6.5s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8756/8800] Built IUTThreeClosures.IUTIVAbsorption (8.7s)
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
✔ [8757/8800] Built TateCurvesTheta.TateCurve.AdditionLaw (9.3s)
⚠ [8758/8800] Built IUTThreeClosures.ZeroLabelBarycentric (8.1s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8759/8800] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (8.8s)
✔ [8760/8800] Built TateCurvesTheta.TateCurve.LargePointParametrization (13s)
⚠ [8761/8800] Built IUTThreeClosures.StatementIIOutsideFinite (7.9s)
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
✔ [8762/8800] Built TateCurvesTheta.TateCurve.AbelStep (6.7s)
✔ [8763/8800] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8764/8800] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (22s)
✔ [8765/8800] Built TateCurvesTheta.TateCurve.SurjectivitySphere (22s)
✔ [8766/8800] Built TateCurvesTheta.TateCurve.TateUniformization (4.2s)
✔ [8767/8800] Built TateCurvesTheta (3.5s)
✔ [8768/8800] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.6s)
✔ [8769/8800] Built Iut.Cor312.ThetaData.Orbicurve (4.4s)
✔ [8770/8800] Built Iut.Cor312.ThetaData.LocalConditions (7.4s)
✔ [8771/8800] Built Iut.Cor312.ThetaData.Basic (4.4s)
✔ [8772/8800] Built Iut.Cor312.LeftHandSide (4.0s)
✔ [8773/8800] Built Iut.Cor312.RightHandSide (4.2s)
✔ [8774/8800] Built Iut.Cor312.Statement (4.1s)
⚠ [8775/8800] Built IUTThreeClosures.NativeQPilotCalibration (5.5s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8776/8800] Built IUTThreeClosures.CorrectedQPilotDivisor (5.7s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8777/8800] Built IUTThreeClosures.ActualPilotWitness (4.1s)
✔ [8778/8800] Built IUTThreeClosures.GeneratedSource (4.3s)
✔ [8779/8800] Built IUTThreeClosures.QuantifierCorrectClosure (3.8s)
✖ [8780/8800] Building IUTThreeClosures.PublicLogVolumeInconsistency (3.9s)
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
✔ [8781/8800] Built IUTThreeClosures.ABCClosure (4.0s)
✔ [8782/8800] Built IUTThreeClosures.ThreeClosureTheorems (3.8s)
✔ [8783/8800] Built IUTThreeClosures.InhabitationBoundary (3.9s)
✔ [8784/8800] Built IUTThreeClosures.CircularityAudit (3.9s)
✔ [8785/8800] Built IUTThreeClosures.NonCircularDownstream (4.9s)
✔ [8786/8800] Built IUTThreeClosures.FourOpenConstructions (4.1s)
⚠ [8788/8800] Built IUTThreeClosures.ABCPointLegendreCurve (4.4s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8789/8800] Built IUTThreeClosures.BridgeInhabitationAudit (4.7s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8790/8800] Built IUTThreeClosures.LegendreArithmetic (4.7s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8791/8800] Built IUTThreeClosures.ABCFreyCurve (4.8s)
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
✔ [8792/8800] Built IUTThreeClosures.BridgeInhabitationExact (5.2s)
⚠ [8793/8800] Built IUTThreeClosures.TripodWeilHeight (5.5s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8794/8800] Built IUTThreeClosures.CanonicalQPilotCorridor (4.1s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8795/8800] Built IUTThreeClosures.LegendreHeightCorridor (4.5s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8796/8800] Building IUTThreeClosures.LegendreJHeight (4.1s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/LegendreJHeight.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/LegendreJHeight.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/LegendreJHeight.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/LegendreJHeight.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/LegendreJHeight.setup.json --json
warning: IUTThreeClosures/LegendreJHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/LegendreJHeight.lean:38:2: failed to prove strict positivity, but it would be possible to prove nonnegativity if desired
error: Lean exited with code 1
✔ [8797/8800] Built IUTThreeClosures.CanonicalCorridorAudit (5.4s)
⚠ [8798/8800] Built IUTThreeClosures.SourceDerivedIUTIVBridge (6.2s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Some required targets logged failures:
- IUTThreeClosures.PublicLogVolumeInconsistency
- IUTThreeClosures.LegendreJHeight
error: build failed
```
